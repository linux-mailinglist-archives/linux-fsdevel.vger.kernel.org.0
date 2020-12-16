Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3EB2DC645
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 19:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730477AbgLPSZJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 13:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730437AbgLPSY7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 13:24:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA2BC0611CC;
        Wed, 16 Dec 2020 10:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=pHHHztOvvZ9gowFilY+U0EY94H0Bu4WrAql9WMv8D/c=; b=CD9kFsIgInuockykbNNXQ9Oi4L
        L/5jyX0eKnaj0garLdZFD29beSWFdjTNRKd2XT2hWhUso9kF6BqUSDS5uKwGayENUM8EFP0OYoANd
        uD+g8z+ATdUB8qyY+BNPzzEwky6vkwNQiKmEdzRX+Mhp3kZaeuum52mfC1CVvOW8A4YJlV3zORqs3
        hPd9YyK9WjmmBC5qQ6Ah9ajdL9XVTo5CF22YqcY9yVPgMFqpQAPAcm7qO1FwS2/qTuraisKT4lcu4
        h/2CqwkPC8Uq8dCXEbvjtkmsLFc8Dw26neyEDpfUrFp0cpw90Ro/A24t7K0gpWQU1mEe3/mU+R0a6
        DRv9w38A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kpbSe-00077K-T7; Wed, 16 Dec 2020 18:23:41 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/25] mm: Add filemap_get_folio and find_get_folio
Date:   Wed, 16 Dec 2020 18:23:23 +0000
Message-Id: <20201216182335.27227-14-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201216182335.27227-1-willy@infradead.org>
References: <20201216182335.27227-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Turn pagecache_get_page() into a wrapper around filemap_get_folio().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h |  21 +++++-
 mm/filemap.c            | 141 +++++++++++++++++++++-------------------
 2 files changed, 94 insertions(+), 68 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 317f17e98412..2c2974970467 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -317,8 +317,10 @@ pgoff_t page_cache_prev_miss(struct address_space *mapping,
 #define FGP_HEAD		0x00000080
 #define FGP_ENTRY		0x00000100
 
-struct page *pagecache_get_page(struct address_space *mapping, pgoff_t offset,
-		int fgp_flags, gfp_t cache_gfp_mask);
+struct folio *filemap_get_folio(struct address_space *mapping, pgoff_t index,
+		int fgp_flags, gfp_t gfp);
+struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
+		int fgp_flags, gfp_t gfp);
 
 /**
  * find_get_page - find and get a page reference
@@ -336,6 +338,12 @@ static inline struct page *find_get_page(struct address_space *mapping,
 	return pagecache_get_page(mapping, offset, 0, 0);
 }
 
+static inline struct folio *find_get_folio(struct address_space *mapping,
+					pgoff_t index)
+{
+	return filemap_get_folio(mapping, index, 0, 0);
+}
+
 static inline struct page *find_get_page_flags(struct address_space *mapping,
 					pgoff_t offset, int fgp_flags)
 {
@@ -451,6 +459,15 @@ static inline struct page *folio_page(struct folio *folio, pgoff_t index)
 	return &folio->page + index;
 }
 
+/* Does this folio contain this index? */
+static inline bool folio_contains(struct folio *folio, pgoff_t index)
+{
+	/* HugeTLBfs indexes the page cache in units of hpage_size */
+	if (PageHuge(&folio->page))
+		return folio->page.index == index;
+	return index - folio_index(folio) < folio_nr_pages(folio);
+}
+
 /*
  * Given the page we found in the page cache, return the page corresponding
  * to this index in the file
diff --git a/mm/filemap.c b/mm/filemap.c
index b9f25a2d8312..7ed9e3dcefc8 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1717,94 +1717,58 @@ static struct folio *mapping_get_entry(struct address_space *mapping,
 	return folio;
 }
 
-/**
- * pagecache_get_page - Find and get a reference to a page.
- * @mapping: The address_space to search.
- * @index: The page index.
- * @fgp_flags: %FGP flags modify how the page is returned.
- * @gfp_mask: Memory allocation flags to use if %FGP_CREAT is specified.
- *
- * Looks up the page cache entry at @mapping & @index.
- *
- * @fgp_flags can be zero or more of these flags:
- *
- * * %FGP_ACCESSED - The page will be marked accessed.
- * * %FGP_LOCK - The page is returned locked.
- * * %FGP_HEAD - If the page is present and a THP, return the head page
- *   rather than the exact page specified by the index.
- * * %FGP_ENTRY - If there is a shadow / swap / DAX entry, return it
- *   instead of allocating a new page to replace it.
- * * %FGP_CREAT - If no page is present then a new page is allocated using
- *   @gfp_mask and added to the page cache and the VM's LRU list.
- *   The page is returned locked and with an increased refcount.
- * * %FGP_FOR_MMAP - The caller wants to do its own locking dance if the
- *   page is already in cache.  If the page was allocated, unlock it before
- *   returning so the caller can do the same dance.
- * * %FGP_WRITE - The page will be written
- * * %FGP_NOFS - __GFP_FS will get cleared in gfp mask
- * * %FGP_NOWAIT - Don't get blocked by page lock
- *
- * If %FGP_LOCK or %FGP_CREAT are specified then the function may sleep even
- * if the %GFP flags specified for %FGP_CREAT are atomic.
- *
- * If there is a page cache page, it is returned with an increased refcount.
- *
- * Return: The found page or %NULL otherwise.
- */
-struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
-		int fgp_flags, gfp_t gfp_mask)
+struct folio *filemap_get_folio(struct address_space *mapping, pgoff_t index,
+		int fgp_flags, gfp_t gfp)
 {
-	struct page *page;
+	struct folio *folio;
 
 repeat:
-	page = &mapping_get_entry(mapping, index)->page;
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
+			if (!trylock_folio(folio)) {
+				put_folio(folio);
 				return NULL;
 			}
 		} else {
-			lock_page(page);
+			lock_folio(folio);
 		}
 
 		/* Has the page been truncated? */
-		if (unlikely(page->mapping != mapping)) {
-			unlock_page(page);
-			put_page(page);
+		if (unlikely(folio->page.mapping != mapping)) {
+			unlock_folio(folio);
+			put_folio(folio);
 			goto repeat;
 		}
-		VM_BUG_ON_PAGE(!thp_contains(page, index), page);
+		VM_BUG_ON_PAGE(!folio_contains(folio, index), &folio->page);
 	}
 
 	if (fgp_flags & FGP_ACCESSED)
-		mark_page_accessed(page);
+		mark_folio_accessed(folio);
 	else if (fgp_flags & FGP_WRITE) {
 		/* Clear idle flag for buffer write */
-		if (page_is_idle(page))
-			clear_page_idle(page);
+		if (page_is_idle(&folio->page))
+			clear_page_idle(&folio->page);
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
 
-		page = &__page_cache_alloc(gfp_mask, 0)->page;
-		if (!page)
+		folio = __page_cache_alloc(gfp, 0);
+		if (!folio)
 			return NULL;
 
 		if (WARN_ON_ONCE(!(fgp_flags & (FGP_LOCK | FGP_FOR_MMAP))))
@@ -1812,12 +1776,12 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 
 		/* Init accessed so avoid atomic mark_page_accessed later */
 		if (fgp_flags & FGP_ACCESSED)
-			__SetPageReferenced(page);
+			__SetFolioReferenced(folio);
 
-		err = add_to_page_cache_lru(page, mapping, index, gfp_mask);
+		err = add_to_page_cache_lru(&folio->page, mapping, index, gfp);
 		if (unlikely(err)) {
-			put_page(page);
-			page = NULL;
+			put_folio(folio);
+			folio = NULL;
 			if (err == -EEXIST)
 				goto repeat;
 		}
@@ -1826,11 +1790,56 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 		 * add_to_page_cache_lru locks the page, and for mmap we expect
 		 * an unlocked page.
 		 */
-		if (page && (fgp_flags & FGP_FOR_MMAP))
-			unlock_page(page);
+		if (folio && (fgp_flags & FGP_FOR_MMAP))
+			unlock_folio(folio);
 	}
 
-	return page;
+	return folio;
+}
+EXPORT_SYMBOL(filemap_get_folio);
+
+/**
+ * pagecache_get_page - Find and get a reference to a page.
+ * @mapping: The address_space to search.
+ * @index: The page index.
+ * @fgp_flags: %FGP flags modify how the page is returned.
+ * @gfp: Memory allocation flags to use if %FGP_CREAT is specified.
+ *
+ * Looks up the page cache entry at @mapping & @index.
+ *
+ * @fgp_flags can be zero or more of these flags:
+ *
+ * * %FGP_ACCESSED - The page will be marked accessed.
+ * * %FGP_LOCK - The page is returned locked.
+ * * %FGP_HEAD - If the page is present and a THP, return the head page
+ *   rather than the exact page specified by the index.
+ * * %FGP_ENTRY - If there is a shadow / swap / DAX entry, return it
+ *   instead of allocating a new page to replace it.
+ * * %FGP_CREAT - If no page is present then a new page is allocated using
+ *   @gfp_mask and added to the page cache and the VM's LRU list.
+ *   The page is returned locked and with an increased refcount.
+ * * %FGP_FOR_MMAP - The caller wants to do its own locking dance if the
+ *   page is already in cache.  If the page was allocated, unlock it before
+ *   returning so the caller can do the same dance.
+ * * %FGP_WRITE - The page will be written
+ * * %FGP_NOFS - __GFP_FS will get cleared in gfp mask
+ * * %FGP_NOWAIT - Don't get blocked by page lock
+ *
+ * If %FGP_LOCK or %FGP_CREAT are specified then the function may sleep even
+ * if the %GFP flags specified for %FGP_CREAT are atomic.
+ *
+ * If there is a page cache page, it is returned with an increased refcount.
+ *
+ * Return: The found page or %NULL otherwise.
+ */
+struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
+		int fgp_flags, gfp_t gfp)
+{
+	struct folio *folio = filemap_get_folio(mapping, index, fgp_flags, gfp);
+
+	if ((fgp_flags & FGP_HEAD) || !folio || xa_is_value(folio))
+		return &folio->page;
+	return folio_page(folio, index);
 }
 EXPORT_SYMBOL(pagecache_get_page);
 
-- 
2.29.2

