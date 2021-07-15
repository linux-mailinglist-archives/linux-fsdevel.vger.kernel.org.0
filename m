Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA0D3C9821
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 07:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239300AbhGOFQ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 01:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbhGOFQ3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 01:16:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE65C06175F;
        Wed, 14 Jul 2021 22:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=vcxKKKBsxiUw5aygBjrmG9tISrBw5VzufzZExjokD1s=; b=jWy7e8/ISWsQ1oDmgOKfqP8um6
        QodRFKeVBs67meId8q+ukEeFe6rB6agsFA6frIw3LEL05TQuxEPj88dbWgfXCwRs+BtSVOsDVf9qt
        Wk8EznFuh7YIPENActZGNA7yiBdshRs9vqm15Fnp0J2ssJgF4U9at88Q1QfLVqOcehgoi1Y7Vy7/q
        mc8Rr4dp/zIq6358KXkMO2jby6pZLQynlNwgNFbJ1kYeMwumdCPs8iMkN6rF9/xC9O4aW9cewUJ/E
        T+JFBlhfGKhBBFyGcHohgyimchJ3p99NNSvoCivE568xe5Aa8zKm6Uqouus4YgURFkeeVwIuuXkNG
        lLh5cqXQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3tfq-0030KF-96; Thu, 15 Jul 2021 05:12:44 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 118/138] mm/filemap: Add read_cache_folio and read_mapping_folio
Date:   Thu, 15 Jul 2021 04:36:44 +0100
Message-Id: <20210715033704.692967-119-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
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
index 245554ce6b12..842d130fd6d3 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -539,8 +539,10 @@ static inline struct page *grab_cache_page(struct address_space *mapping,
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
@@ -552,6 +554,12 @@ static inline struct page *read_mapping_page(struct address_space *mapping,
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
index b0fe3234a20b..dd54a52f8e84 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3298,35 +3298,20 @@ EXPORT_SYMBOL(filemap_page_mkwrite);
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
@@ -3335,21 +3320,24 @@ static struct page *do_read_cache_page(struct address_space *mapping,
 
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
@@ -3383,23 +3371,23 @@ static struct page *do_read_cache_page(struct address_space *mapping,
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
 
@@ -3409,16 +3397,16 @@ static struct page *do_read_cache_page(struct address_space *mapping,
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
@@ -3431,10 +3419,25 @@ static struct page *do_read_cache_page(struct address_space *mapping,
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
2.30.2

