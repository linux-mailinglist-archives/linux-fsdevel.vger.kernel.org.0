Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E012FA775
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 18:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407144AbhARRVf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 12:21:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406863AbhARRDX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 12:03:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F25C061793;
        Mon, 18 Jan 2021 09:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=6YK8dxrIi6WHXmqxTYcAlqgkXxY6OI1r+h3iSsQcrI0=; b=C3raeL3Kn0g4dP57UwlPf+W+w1
        ASPS/ph0PPLk1lgQZSN/QUf9GAS7hOISsupaAtKqlnnUSnkdFPekYxYrvlvbhJdi0LAyJS2C96Ho0
        CQR7vQqZvS9L7t5gO37j7uy/Giixv3ZY2PYPlcU/PPNd4QyHuRfa7DPlZvaGfO0w+l9l/6GcP7pwe
        53OlfOQFz81F3x9OEhRNtacl6pHmBhipXMC7iOuC9xFTW/vWXjtUtX3GvVhhYte3EXUwfzAxp5SZj
        LvOKX7ERIP0GzFHjICjw052chJUNhQZOOHWh6CmHzdRwdxa3HGc5lVzxaqHXU7LksNxIHFDn+pSmT
        NyUJteVQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l1Xum-00D7Iv-FV; Mon, 18 Jan 2021 17:02:05 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/27] mm/util: Add folio_mapping and folio_file_mapping
Date:   Mon, 18 Jan 2021 17:01:31 +0000
Message-Id: <20210118170148.3126186-11-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118170148.3126186-1-willy@infradead.org>
References: <20210118170148.3126186-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These are the folio equivalent of page_mapping() and page_file_mapping().
Adjust page_file_mapping() and page_mapping_file() to use folios
internally.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h | 23 +++++++++++++++--------
 mm/swapfile.c      |  6 +++---
 mm/util.c          | 20 ++++++++++----------
 3 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 380328930d6c..46cee44c0c68 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1586,17 +1586,25 @@ void page_address_init(void);
 
 extern void *page_rmapping(struct page *page);
 extern struct anon_vma *page_anon_vma(struct page *page);
-extern struct address_space *page_mapping(struct page *page);
+struct address_space *folio_mapping(struct folio *);
+struct address_space *__folio_file_mapping(struct folio *);
 
-extern struct address_space *__page_file_mapping(struct page *);
+static inline struct address_space *page_mapping(struct page *page)
+{
+	return folio_mapping(page_folio(page));
+}
 
-static inline
-struct address_space *page_file_mapping(struct page *page)
+static inline struct address_space *folio_file_mapping(struct folio *folio)
 {
-	if (unlikely(PageSwapCache(page)))
-		return __page_file_mapping(page);
+	if (unlikely(FolioSwapCache(folio)))
+		return __folio_file_mapping(folio);
 
-	return page->mapping;
+	return folio->page.mapping;
+}
+
+static inline struct address_space *page_file_mapping(struct page *page)
+{
+	return folio_file_mapping(page_folio(page));
 }
 
 extern pgoff_t __page_file_index(struct page *page);
@@ -1613,7 +1621,6 @@ static inline pgoff_t page_index(struct page *page)
 }
 
 bool page_mapped(struct page *page);
-struct address_space *page_mapping(struct page *page);
 struct address_space *page_mapping_file(struct page *page);
 
 /*
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 9fffc5af29d1..ddb734fccfc3 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3551,11 +3551,11 @@ struct swap_info_struct *page_swap_info(struct page *page)
 /*
  * out-of-line __page_file_ methods to avoid include hell.
  */
-struct address_space *__page_file_mapping(struct page *page)
+struct address_space *__folio_file_mapping(struct folio *folio)
 {
-	return page_swap_info(page)->swap_file->f_mapping;
+	return page_swap_info(&folio->page)->swap_file->f_mapping;
 }
-EXPORT_SYMBOL_GPL(__page_file_mapping);
+EXPORT_SYMBOL_GPL(__folio_file_mapping);
 
 pgoff_t __page_file_index(struct page *page)
 {
diff --git a/mm/util.c b/mm/util.c
index c37e24d5fa43..c052c39b9f1c 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -686,39 +686,39 @@ struct anon_vma *page_anon_vma(struct page *page)
 	return __page_rmapping(page);
 }
 
-struct address_space *page_mapping(struct page *page)
+struct address_space *folio_mapping(struct folio *folio)
 {
 	struct address_space *mapping;
 
-	page = compound_head(page);
-
 	/* This happens if someone calls flush_dcache_page on slab page */
-	if (unlikely(PageSlab(page)))
+	if (unlikely(FolioSlab(folio)))
 		return NULL;
 
-	if (unlikely(PageSwapCache(page))) {
+	if (unlikely(FolioSwapCache(folio))) {
 		swp_entry_t entry;
 
-		entry.val = page_private(page);
+		entry.val = folio_private(folio);
 		return swap_address_space(entry);
 	}
 
-	mapping = page->mapping;
+	mapping = folio->page.mapping;
 	if ((unsigned long)mapping & PAGE_MAPPING_ANON)
 		return NULL;
 
 	return (void *)((unsigned long)mapping & ~PAGE_MAPPING_FLAGS);
 }
-EXPORT_SYMBOL(page_mapping);
+EXPORT_SYMBOL(folio_mapping);
 
 /*
  * For file cache pages, return the address_space, otherwise return NULL
  */
 struct address_space *page_mapping_file(struct page *page)
 {
-	if (unlikely(PageSwapCache(page)))
+	struct folio *folio = page_folio(page);
+
+	if (unlikely(FolioSwapCache(folio)))
 		return NULL;
-	return page_mapping(page);
+	return folio_mapping(folio);
 }
 
 /* Slow path of page_mapcount() for compound pages */
-- 
2.29.2

