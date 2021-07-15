Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7BA3CAE08
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 22:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236532AbhGOUmK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 16:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236255AbhGOUmF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 16:42:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249FEC06175F
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jul 2021 13:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=rRzHEXc1ZEZ/CLzyENwbizlQTGvzKdjf6R/+nj4ll8w=; b=FQUnGuDkUXSc+Wg/DfULDurIWc
        qhmd2q8J+Fz4L4t7iq2PIXWDKLRHPTPf/WJVTi6+Clz0Djsg29f6ocM2zqos9RJWLrEhFP0SvHYHS
        Um3D0vm2T7WMpUqgTgXxbK0layKClh/6d0GJghGp6E+tzQHSjrfxvZtsosBCVJZ/dRcrxa8yPi2F2
        akyz1qmiNFVyvZEutdyxRfMyUWHAT9YBrmnhC9iC0U3DcOd26CEfzfOXs64L8KHhfJj4sdISnUhz8
        0qqpIViNrEZ2yVU11FE989t/ISuauHg5/07OUqfMAFbxwqkZaoFzWkqgerHuc5E18YsA/l+B+GFKh
        savgIPjQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m486y-003qWc-7o; Thu, 15 Jul 2021 20:37:58 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH v14 38/39] mm/filemap: Add filemap_get_folio
Date:   Thu, 15 Jul 2021 21:00:29 +0100
Message-Id: <20210715200030.899216-39-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715200030.899216-1-willy@infradead.org>
References: <20210715200030.899216-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

filemap_get_folio() is a replacement for find_get_page().
Turn pagecache_get_page() into a wrapper around __filemap_get_folio().
Remove find_lock_head() as this use case is now covered by
filemap_get_folio().

Reduces overall kernel size by 209 bytes.  __filemap_get_folio() is
316 bytes shorter than pagecache_get_page() was, but the new
pagecache_get_page() is 99 bytes.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 41 +++++++++---------
 mm/filemap.c            | 92 ++++++++++++++++++++---------------------
 mm/folio-compat.c       | 12 ++++++
 3 files changed, 76 insertions(+), 69 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 19b2e3bea14c..b24933eced18 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -302,8 +302,26 @@ pgoff_t page_cache_prev_miss(struct address_space *mapping,
 #define FGP_HEAD		0x00000080
 #define FGP_ENTRY		0x00000100
 
-struct page *pagecache_get_page(struct address_space *mapping, pgoff_t offset,
-		int fgp_flags, gfp_t cache_gfp_mask);
+struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
+		int fgp_flags, gfp_t gfp);
+struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
+		int fgp_flags, gfp_t gfp);
+
+/**
+ * filemap_get_folio - Find and get a folio.
+ * @mapping: The address_space to search.
+ * @index: The page index.
+ *
+ * Looks up the page cache entry at @mapping & @index.  If a folio is
+ * present, it is returned with an increased refcount.
+ *
+ * Otherwise, %NULL is returned.
+ */
+static inline struct folio *filemap_get_folio(struct address_space *mapping,
+					pgoff_t index)
+{
+	return __filemap_get_folio(mapping, index, 0, 0);
+}
 
 /**
  * find_get_page - find and get a page reference
@@ -346,25 +364,6 @@ static inline struct page *find_lock_page(struct address_space *mapping,
 	return pagecache_get_page(mapping, index, FGP_LOCK, 0);
 }
 
-/**
- * find_lock_head - Locate, pin and lock a pagecache page.
- * @mapping: The address_space to search.
- * @index: The page index.
- *
- * Looks up the page cache entry at @mapping & @index.  If there is a
- * page cache page, its head page is returned locked and with an increased
- * refcount.
- *
- * Context: May sleep.
- * Return: A struct page which is !PageTail, or %NULL if there is no page
- * in the cache for this index.
- */
-static inline struct page *find_lock_head(struct address_space *mapping,
-					pgoff_t index)
-{
-	return pagecache_get_page(mapping, index, FGP_LOCK | FGP_HEAD, 0);
-}
-
 /**
  * find_or_create_page - locate or add a pagecache page
  * @mapping: the page's address_space
diff --git a/mm/filemap.c b/mm/filemap.c
index 85a457c7b7a7..061e285aae21 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1794,93 +1794,89 @@ static void *mapping_get_entry(struct address_space *mapping, pgoff_t index)
 }
 
 /**
- * pagecache_get_page - Find and get a reference to a page.
+ * __filemap_get_folio - Find and get a reference to a folio.
  * @mapping: The address_space to search.
  * @index: The page index.
- * @fgp_flags: %FGP flags modify how the page is returned.
- * @gfp_mask: Memory allocation flags to use if %FGP_CREAT is specified.
+ * @fgp_flags: %FGP flags modify how the folio is returned.
+ * @gfp: Memory allocation flags to use if %FGP_CREAT is specified.
  *
  * Looks up the page cache entry at @mapping & @index.
  *
  * @fgp_flags can be zero or more of these flags:
  *
- * * %FGP_ACCESSED - The page will be marked accessed.
- * * %FGP_LOCK - The page is returned locked.
- * * %FGP_HEAD - If the page is present and a THP, return the head page
- *   rather than the exact page specified by the index.
+ * * %FGP_ACCESSED - The folio will be marked accessed.
+ * * %FGP_LOCK - The folio is returned locked.
  * * %FGP_ENTRY - If there is a shadow / swap / DAX entry, return it
- *   instead of allocating a new page to replace it.
+ *   instead of allocating a new folio to replace it.
  * * %FGP_CREAT - If no page is present then a new page is allocated using
- *   @gfp_mask and added to the page cache and the VM's LRU list.
+ *   @gfp and added to the page cache and the VM's LRU list.
  *   The page is returned locked and with an increased refcount.
  * * %FGP_FOR_MMAP - The caller wants to do its own locking dance if the
  *   page is already in cache.  If the page was allocated, unlock it before
  *   returning so the caller can do the same dance.
- * * %FGP_WRITE - The page will be written
- * * %FGP_NOFS - __GFP_FS will get cleared in gfp mask
- * * %FGP_NOWAIT - Don't get blocked by page lock
+ * * %FGP_WRITE - The page will be written to by the caller.
+ * * %FGP_NOFS - __GFP_FS will get cleared in gfp.
+ * * %FGP_NOWAIT - Don't get blocked by page lock.
  *
  * If %FGP_LOCK or %FGP_CREAT are specified then the function may sleep even
  * if the %GFP flags specified for %FGP_CREAT are atomic.
  *
  * If there is a page cache page, it is returned with an increased refcount.
  *
- * Return: The found page or %NULL otherwise.
+ * Return: The found folio or %NULL otherwise.
  */
-struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
-		int fgp_flags, gfp_t gfp_mask)
+struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
+		int fgp_flags, gfp_t gfp)
 {
-	struct page *page;
+	struct folio *folio;
 
 repeat:
-	page = mapping_get_entry(mapping, index);
-	if (xa_is_value(page)) {
+	folio = mapping_get_entry(mapping, index);
+	if (xa_is_value(folio)) {
 		if (fgp_flags & FGP_ENTRY)
-			return page;
-		page = NULL;
+			return folio;
+		folio = NULL;
 	}
-	if (!page)
+	if (!folio)
 		goto no_page;
 
 	if (fgp_flags & FGP_LOCK) {
 		if (fgp_flags & FGP_NOWAIT) {
-			if (!trylock_page(page)) {
-				put_page(page);
+			if (!folio_trylock(folio)) {
+				folio_put(folio);
 				return NULL;
 			}
 		} else {
-			lock_page(page);
+			folio_lock(folio);
 		}
 
 		/* Has the page been truncated? */
-		if (unlikely(page->mapping != mapping)) {
-			unlock_page(page);
-			put_page(page);
+		if (unlikely(folio->mapping != mapping)) {
+			folio_unlock(folio);
+			folio_put(folio);
 			goto repeat;
 		}
-		VM_BUG_ON_PAGE(!thp_contains(page, index), page);
+		VM_BUG_ON_FOLIO(!folio_contains(folio, index), folio);
 	}
 
 	if (fgp_flags & FGP_ACCESSED)
-		mark_page_accessed(page);
+		folio_mark_accessed(folio);
 	else if (fgp_flags & FGP_WRITE) {
 		/* Clear idle flag for buffer write */
-		if (page_is_idle(page))
-			clear_page_idle(page);
+		if (folio_test_idle(folio))
+			folio_clear_idle(folio);
 	}
-	if (!(fgp_flags & FGP_HEAD))
-		page = find_subpage(page, index);
 
 no_page:
-	if (!page && (fgp_flags & FGP_CREAT)) {
+	if (!folio && (fgp_flags & FGP_CREAT)) {
 		int err;
 		if ((fgp_flags & FGP_WRITE) && mapping_can_writeback(mapping))
-			gfp_mask |= __GFP_WRITE;
+			gfp |= __GFP_WRITE;
 		if (fgp_flags & FGP_NOFS)
-			gfp_mask &= ~__GFP_FS;
+			gfp &= ~__GFP_FS;
 
-		page = __page_cache_alloc(gfp_mask);
-		if (!page)
+		folio = filemap_alloc_folio(gfp, 0);
+		if (!folio)
 			return NULL;
 
 		if (WARN_ON_ONCE(!(fgp_flags & (FGP_LOCK | FGP_FOR_MMAP))))
@@ -1888,27 +1884,27 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 
 		/* Init accessed so avoid atomic mark_page_accessed later */
 		if (fgp_flags & FGP_ACCESSED)
-			__SetPageReferenced(page);
+			__folio_set_referenced(folio);
 
-		err = add_to_page_cache_lru(page, mapping, index, gfp_mask);
+		err = filemap_add_folio(mapping, folio, index, gfp);
 		if (unlikely(err)) {
-			put_page(page);
-			page = NULL;
+			folio_put(folio);
+			folio = NULL;
 			if (err == -EEXIST)
 				goto repeat;
 		}
 
 		/*
-		 * add_to_page_cache_lru locks the page, and for mmap we expect
-		 * an unlocked page.
+		 * filemap_add_folio locks the page, and for mmap
+		 * we expect an unlocked page.
 		 */
-		if (page && (fgp_flags & FGP_FOR_MMAP))
-			unlock_page(page);
+		if (folio && (fgp_flags & FGP_FOR_MMAP))
+			folio_unlock(folio);
 	}
 
-	return page;
+	return folio;
 }
-EXPORT_SYMBOL(pagecache_get_page);
+EXPORT_SYMBOL(__filemap_get_folio);
 
 static inline struct page *find_get_entry(struct xa_state *xas, pgoff_t max,
 		xa_mark_t mark)
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 6b19bc4ed6b0..e833e680e944 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -115,3 +115,15 @@ int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
 	return filemap_add_folio(mapping, page_folio(page), index, gfp);
 }
 EXPORT_SYMBOL(add_to_page_cache_lru);
+
+struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
+		int fgp_flags, gfp_t gfp)
+{
+	struct folio *folio;
+
+	folio = __filemap_get_folio(mapping, index, fgp_flags, gfp);
+	if ((fgp_flags & FGP_HEAD) || !folio || xa_is_value(folio))
+		return &folio->page;
+	return folio_file_page(folio, index);
+}
+EXPORT_SYMBOL(pagecache_get_page);
-- 
2.30.2

