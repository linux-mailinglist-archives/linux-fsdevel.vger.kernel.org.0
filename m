Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 344FD46CC83
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 05:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240302AbhLHE3F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 23:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240125AbhLHE0s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:26:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9FBC0698C6
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 20:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=qtbKUPPS3ZVhgIUCfwJ/vbY8r8bBiiA/jYBJR/fWLdI=; b=g0Wig305W2ZPr5DePosI9mOHDW
        lgkahCfiDnxpcl9Zfqg9YaWIt/LxXOUbIlqrhAPf2lGa6eJ7IrXlWr6V7qaYzZEM1gLLx05OZjhPG
        uAPIpCVdQmc46nPHoLE8yao33CwTpdRX+HahcAr1UIYnB4/glU7ue3iFNsyzh9HXgekTSZFU+/zHD
        JNXpVoqqRzi4HVImRAzmVbcXl3ofKNaqYhl+ij1SWhUvdn/uRYYmbQfRp7QN8K5MYxeaEABVWZICX
        1SNRMRvOXdNv1ACIebBUODEhaz9Ye4BOvFuYGCP4jsLFIjuamkd+GlPWy2x6fCPX1Sdsah16pnocf
        q22lWlJg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muoU4-0084Z3-L7; Wed, 08 Dec 2021 04:23:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 25/48] filemap: Add read_cache_folio and read_mapping_folio
Date:   Wed,  8 Dec 2021 04:22:33 +0000
Message-Id: <20211208042256.1923824-26-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208042256.1923824-1-willy@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reimplement read_cache_page() as a wrapper around read_cache_folio().
Saves over 400 bytes of text from do_read_cache_folio() which more
thn makes up for the extra 100 bytes of text added to the various
wrapper functions.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 12 +++++-
 mm/filemap.c            | 95 +++++++++++++++++++++--------------------
 2 files changed, 59 insertions(+), 48 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 30302be6977f..7bef50ea5435 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -629,8 +629,10 @@ static inline struct page *grab_cache_page(struct address_space *mapping,
 	return find_or_create_page(mapping, index, mapping_gfp_mask(mapping));
 }
 
-extern struct page * read_cache_page(struct address_space *mapping,
-				pgoff_t index, filler_t *filler, void *data);
+struct folio *read_cache_folio(struct address_space *, pgoff_t index,
+		filler_t *filler, void *data);
+struct page *read_cache_page(struct address_space *, pgoff_t index,
+		filler_t *filler, void *data);
 extern struct page * read_cache_page_gfp(struct address_space *mapping,
 				pgoff_t index, gfp_t gfp_mask);
 extern int read_cache_pages(struct address_space *mapping,
@@ -642,6 +644,12 @@ static inline struct page *read_mapping_page(struct address_space *mapping,
 	return read_cache_page(mapping, index, NULL, data);
 }
 
+static inline struct folio *read_mapping_folio(struct address_space *mapping,
+				pgoff_t index, void *data)
+{
+	return read_cache_folio(mapping, index, NULL, data);
+}
+
 /*
  * Get index of the page within radix-tree (but not for hugetlb pages).
  * (TODO: remove once hugetlb pages will have ->index in PAGE_SIZE)
diff --git a/mm/filemap.c b/mm/filemap.c
index fc0f1d9904d2..f34dda0a7627 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3418,35 +3418,20 @@ EXPORT_SYMBOL(filemap_page_mkwrite);
 EXPORT_SYMBOL(generic_file_mmap);
 EXPORT_SYMBOL(generic_file_readonly_mmap);
 
-static struct page *wait_on_page_read(struct page *page)
+static struct folio *do_read_cache_folio(struct address_space *mapping,
+		pgoff_t index, filler_t filler, void *data, gfp_t gfp)
 {
-	if (!IS_ERR(page)) {
-		wait_on_page_locked(page);
-		if (!PageUptodate(page)) {
-			put_page(page);
-			page = ERR_PTR(-EIO);
-		}
-	}
-	return page;
-}
-
-static struct page *do_read_cache_page(struct address_space *mapping,
-				pgoff_t index,
-				int (*filler)(void *, struct page *),
-				void *data,
-				gfp_t gfp)
-{
-	struct page *page;
+	struct folio *folio;
 	int err;
 repeat:
-	page = find_get_page(mapping, index);
-	if (!page) {
-		page = __page_cache_alloc(gfp);
-		if (!page)
+	folio = filemap_get_folio(mapping, index);
+	if (!folio) {
+		folio = filemap_alloc_folio(gfp, 0);
+		if (!folio)
 			return ERR_PTR(-ENOMEM);
-		err = add_to_page_cache_lru(page, mapping, index, gfp);
+		err = filemap_add_folio(mapping, folio, index, gfp);
 		if (unlikely(err)) {
-			put_page(page);
+			folio_put(folio);
 			if (err == -EEXIST)
 				goto repeat;
 			/* Presumably ENOMEM for xarray node */
@@ -3455,21 +3440,24 @@ static struct page *do_read_cache_page(struct address_space *mapping,
 
 filler:
 		if (filler)
-			err = filler(data, page);
+			err = filler(data, &folio->page);
 		else
-			err = mapping->a_ops->readpage(data, page);
+			err = mapping->a_ops->readpage(data, &folio->page);
 
 		if (err < 0) {
-			put_page(page);
+			folio_put(folio);
 			return ERR_PTR(err);
 		}
 
-		page = wait_on_page_read(page);
-		if (IS_ERR(page))
-			return page;
+		folio_wait_locked(folio);
+		if (!folio_test_uptodate(folio)) {
+			folio_put(folio);
+			return ERR_PTR(-EIO);
+		}
+
 		goto out;
 	}
-	if (PageUptodate(page))
+	if (folio_test_uptodate(folio))
 		goto out;
 
 	/*
@@ -3503,23 +3491,23 @@ static struct page *do_read_cache_page(struct address_space *mapping,
 	 * avoid spurious serialisations and wakeups when multiple processes
 	 * wait on the same page for IO to complete.
 	 */
-	wait_on_page_locked(page);
-	if (PageUptodate(page))
+	folio_wait_locked(folio);
+	if (folio_test_uptodate(folio))
 		goto out;
 
 	/* Distinguish between all the cases under the safety of the lock */
-	lock_page(page);
+	folio_lock(folio);
 
 	/* Case c or d, restart the operation */
-	if (!page->mapping) {
-		unlock_page(page);
-		put_page(page);
+	if (!folio->mapping) {
+		folio_unlock(folio);
+		folio_put(folio);
 		goto repeat;
 	}
 
 	/* Someone else locked and filled the page in a very small window */
-	if (PageUptodate(page)) {
-		unlock_page(page);
+	if (folio_test_uptodate(folio)) {
+		folio_unlock(folio);
 		goto out;
 	}
 
@@ -3529,16 +3517,16 @@ static struct page *do_read_cache_page(struct address_space *mapping,
 	 * Clear page error before actual read, PG_error will be
 	 * set again if read page fails.
 	 */
-	ClearPageError(page);
+	folio_clear_error(folio);
 	goto filler;
 
 out:
-	mark_page_accessed(page);
-	return page;
+	folio_mark_accessed(folio);
+	return folio;
 }
 
 /**
- * read_cache_page - read into page cache, fill it if needed
+ * read_cache_folio - read into page cache, fill it if needed
  * @mapping:	the page's address_space
  * @index:	the page index
  * @filler:	function to perform the read
@@ -3553,10 +3541,25 @@ static struct page *do_read_cache_page(struct address_space *mapping,
  *
  * Return: up to date page on success, ERR_PTR() on failure.
  */
+struct folio *read_cache_folio(struct address_space *mapping, pgoff_t index,
+		filler_t filler, void *data)
+{
+	return do_read_cache_folio(mapping, index, filler, data,
+			mapping_gfp_mask(mapping));
+}
+EXPORT_SYMBOL(read_cache_folio);
+
+static struct page *do_read_cache_page(struct address_space *mapping,
+		pgoff_t index, filler_t *filler, void *data, gfp_t gfp)
+{
+	struct folio *folio = read_cache_folio(mapping, index, filler, data);
+	if (IS_ERR(folio))
+		return &folio->page;
+	return folio_file_page(folio, index);
+}
+
 struct page *read_cache_page(struct address_space *mapping,
-				pgoff_t index,
-				int (*filler)(void *, struct page *),
-				void *data)
+				pgoff_t index, filler_t *filler, void *data)
 {
 	return do_read_cache_page(mapping, index, filler, data,
 			mapping_gfp_mask(mapping));
-- 
2.33.0

