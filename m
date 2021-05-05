Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63733747AE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 20:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235499AbhEESB6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 14:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235384AbhEESBq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 14:01:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0850C04BE54;
        Wed,  5 May 2021 10:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=g71cA5NAYjcDTOWfpDITnnU5YKEY6TQ2aucSVKC/UTc=; b=SAaTW4Rb4YTifeI44fsSvkAxOK
        FmXa6rMSInpKLOe4rYc5eC/Ck1oJPHEPF4i/R2F4e7A/FF77F83kjtE9ca+8sshjpqkbOVNhzE11I
        ZLdCp26Ljsxa5QPadeStnxq29p4qrH6SFU4/cbbLQ7Dg5xEohPFGASXVZvwKgRpu5ipX0WedE9svK
        bXgVIWKutbkXbde78LVySysaRsOcPFUhMCuHmJZyu3dpGcC22k6cc4QdZ8IcjTfR4t2sFEqjsdkNL
        ZKiXba2GMgpfr35pQx3BlKFnUBBj4eoGHkKx9v5iMj24IIqp3Lj91oo3hS5HZ0uJLKv0oC1wghqJE
        qo0dT3CA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leKxT-000cgm-AT; Wed, 05 May 2021 17:05:50 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 80/96] mm/filemap: Add filemap_get_folio and find_get_folio
Date:   Wed,  5 May 2021 16:06:12 +0100
Message-Id: <20210505150628.111735-81-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Turn pagecache_get_page() into a wrapper around filemap_get_folio().
Remove find_lock_head() as this use case is now covered by
filemap_get_folio().

Reduces overall kernel size by 209 bytes.  filemap_get_folio() is
316 bytes shorter than pagecache_get_page() was, but the new
pagecache_get_page() is 99 bytes.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 31 +++++---------
 mm/filemap.c            | 90 +++++++++++++++++++----------------------
 mm/folio-compat.c       | 11 +++++
 3 files changed, 63 insertions(+), 69 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 8eab3d8400d2..03125035077c 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -378,8 +378,10 @@ pgoff_t page_cache_prev_miss(struct address_space *mapping,
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
@@ -397,6 +399,12 @@ static inline struct page *find_get_page(struct address_space *mapping,
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
@@ -422,25 +430,6 @@ static inline struct page *find_lock_page(struct address_space *mapping,
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
index b3714dddb045..3d8715a6dd08 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1777,95 +1777,89 @@ static struct folio *mapping_get_entry(struct address_space *mapping,
 }
 
 /**
- * pagecache_get_page - Find and get a reference to a page.
+ * filemap_get_folio - Find and get a reference to a folio.
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
+struct folio *filemap_get_folio(struct address_space *mapping, pgoff_t index,
+		int fgp_flags, gfp_t gfp)
 {
 	struct folio *folio;
-	struct page *page;
 
 repeat:
 	folio = mapping_get_entry(mapping, index);
-	page = &folio->page;
-	if (xa_is_value(page)) {
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
+		if (folio_idle(folio))
+			folio_clear_idle_flag(folio);
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
@@ -1873,27 +1867,27 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 
 		/* Init accessed so avoid atomic mark_page_accessed later */
 		if (fgp_flags & FGP_ACCESSED)
-			__SetPageReferenced(page);
+			__folio_set_referenced_flag(folio);
 
-		err = add_to_page_cache_lru(page, mapping, index, gfp_mask);
+		err = folio_add_to_page_cache(folio, mapping, index, gfp);
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
+		 * folio_add_to_page_cache locks the page, and for mmap
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
+EXPORT_SYMBOL(filemap_get_folio);
 
 static inline struct page *find_get_entry(struct xa_state *xas, pgoff_t max,
 		xa_mark_t mark)
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 7de3839ad072..df0038c65da9 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -85,3 +85,14 @@ void lru_cache_add(struct page *page)
 	folio_add_lru(page_folio(page));
 }
 EXPORT_SYMBOL(lru_cache_add);
+
+struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
+		int fgp_flags, gfp_t gfp)
+{
+	struct folio *folio = filemap_get_folio(mapping, index, fgp_flags, gfp);
+
+	if ((fgp_flags & FGP_HEAD) || !folio || xa_is_value(folio))
+		return &folio->page;
+	return folio_file_page(folio, index);
+}
+EXPORT_SYMBOL(pagecache_get_page);
-- 
2.30.2

