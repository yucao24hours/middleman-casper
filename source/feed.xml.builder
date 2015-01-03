xml.instruct!
xml.feed "xmlns" => "http://www.w3.org/2005/Atom" do
  site_url = settings.casper[:blog][:url]
  xml.title settings.casper[:blog][:name]
  xml.subtitle settings.casper[:blog][:description]
  xml.id URI.join(site_url, blog.options.prefix.to_s)
  xml.link "href" => URI.join(site_url, blog.options.prefix.to_s)
  xml.link "href" => URI.join(site_url, current_page.path), "rel" => "self"
  xml.updated blog.articles.first.date.to_time.iso8601
  xml.author { xml.name settings.casper[:author][:name] }

  blog.articles[0..5].each do |article|
    xml.entry do
      xml.title article.title
      xml.link "rel" => "alternate", "href" => URI.join(site_url, article.url)
      xml.id URI.join(site_url, article.url)
      xml.published article.date.to_time.iso8601
      xml.updated File.mtime(article.source_file).iso8601
      xml.author { xml.name settings.casper[:author][:name] }
      xml.summary summary(article), "type" => "html"
      # Use article.body if you haven't Nokogiri available
      # xml.content article.body, "type" => "html"
    end
  end
end
