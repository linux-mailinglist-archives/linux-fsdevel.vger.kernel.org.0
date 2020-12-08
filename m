Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4F62D339B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 21:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbgLHUW2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 15:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728983AbgLHUW0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:22:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0411C0613D6;
        Tue,  8 Dec 2020 12:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ClESjqaT/WyKY8JgQJAVIdt0CjT/HSTWaZz8AcFWYAo=; b=o9K3XD65ndELUjgwtRI6X78kCn
        pgPJ2JzAu/M2M4XfJZEicfFjbBbMsExdSvcyXP9VUDROiDLkNk3hEQoxjajuDI4G6gzT3X9NcwPiv
        gEFmsu4+irsx2SWC0pJaLT8Mt8QsunlAwOgplqvsvm7/Fyw/2gh+SyRoeEAyolC5XjWAyhe/hQG7o
        MaByImw+nH8vb/UeAFKlVhUZXtBG2ft0tVkvWZoaUg+RVLG7NbeDBurtzxuW43qjqMHlK/PVXSss2
        G3e1v6BvHnwxeOOFk4/2i3l7flmSVDizy6gwjPrKhPGsl6lebH2j4Y0FTA+z44QIkz6XOC8k9y5pi
        +hSwXGKw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmiwu-00051C-0T; Tue, 08 Dec 2020 19:47:00 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 10/11] mm/filemap: Add folio_add_to_page_cache
Date:   Tue,  8 Dec 2020 19:46:52 +0000
Message-Id: <20201208194653.19180-11-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201208194653.19180-1-willy@infradead.org>
References: <20201208194653.19180-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pages being added to the page cache should already be folios, so
turn add_to_page_cache_lru() into a wrapper.  Saves hundreds of
bytes of text.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 13 +++++++--
 mm/filemap.c            | 62 ++++++++++++++++++++---------------------
 2 files changed, 41 insertions(+), 34 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 060faeb8d701..3bc56b3aa384 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -778,9 +778,9 @@ static inline int fault_in_pages_readable(const char __user *uaddr, int size)
 }
 
 int add_to_page_cache_locked(struct page *page, struct address_space *mapping,
-				pgoff_t index, gfp_t gfp_mask);
-int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
-				pgoff_t index, gfp_t gfp_mask);
+				pgoff_t index, gfp_t gfp);
+int folio_add_to_page_cache(struct folio *folio, struct address_space *mapping,
+				pgoff_t index, gfp_t gfp);
 extern void delete_from_page_cache(struct page *page);
 extern void __delete_from_page_cache(struct page *page, void *shadow);
 int replace_page_cache_page(struct page *old, struct page *new, gfp_t gfp_mask);
@@ -805,6 +805,13 @@ static inline int add_to_page_cache(struct page *page,
 	return error;
 }
 
+static inline int add_to_page_cache_lru(struct page *page,
+		struct address_space *mapping, pgoff_t index, gfp_t gfp)
+{
+	return folio_add_to_page_cache((struct folio *)page, mapping,
+			index, gfp);
+}
+
 /**
  * struct readahead_control - Describes a readahead request.
  *
diff --git a/mm/filemap.c b/mm/filemap.c
index 56ff6aa24265..297144524f58 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -828,25 +828,25 @@ int replace_page_cache_page(struct page *old, struct page *new, gfp_t gfp_mask)
 }
 EXPORT_SYMBOL_GPL(replace_page_cache_page);
 
-static noinline int __add_to_page_cache_locked(struct page *page,
+static noinline int __add_to_page_cache_locked(struct folio *folio,
 					struct address_space *mapping,
-					pgoff_t offset, gfp_t gfp,
+					pgoff_t index, gfp_t gfp,
 					void **shadowp)
 {
-	XA_STATE(xas, &mapping->i_pages, offset);
-	int huge = PageHuge(page);
+	XA_STATE(xas, &mapping->i_pages, index);
+	int huge = PageHuge(&folio->page);
 	int error;
 
-	VM_BUG_ON_PAGE(!PageLocked(page), page);
-	VM_BUG_ON_PAGE(PageSwapBacked(page), page);
+	VM_BUG_ON_PAGE(!FolioLocked(folio), &folio->page);
+	VM_BUG_ON_PAGE(FolioSwapBacked(folio), &folio->page);
 	mapping_set_update(&xas, mapping);
 
-	get_page(page);
-	page->mapping = mapping;
-	page->index = offset;
+	get_folio(folio);
+	folio->page.mapping = mapping;
+	folio->page.index = index;
 
-	if (!huge && !page_is_secretmem(page)) {
-		error = mem_cgroup_charge(page, current->mm, gfp);
+	if (!huge && !page_is_secretmem(&folio->page)) {
+		error = mem_cgroup_charge(&folio->page, current->mm, gfp);
 		if (error)
 			goto error;
 	}
@@ -857,7 +857,7 @@ static noinline int __add_to_page_cache_locked(struct page *page,
 		unsigned int order = xa_get_order(xas.xa, xas.xa_index);
 		void *entry, *old = NULL;
 
-		if (order > thp_order(page))
+		if (order > folio_order(folio))
 			xas_split_alloc(&xas, xa_load(xas.xa, xas.xa_index),
 					order, gfp);
 		xas_lock_irq(&xas);
@@ -874,13 +874,13 @@ static noinline int __add_to_page_cache_locked(struct page *page,
 				*shadowp = old;
 			/* entry may have been split before we acquired lock */
 			order = xa_get_order(xas.xa, xas.xa_index);
-			if (order > thp_order(page)) {
+			if (order > folio_order(folio)) {
 				xas_split(&xas, old, order);
 				xas_reset(&xas);
 			}
 		}
 
-		xas_store(&xas, page);
+		xas_store(&xas, folio);
 		if (xas_error(&xas))
 			goto unlock;
 
@@ -890,7 +890,7 @@ static noinline int __add_to_page_cache_locked(struct page *page,
 
 		/* hugetlb pages do not participate in page cache accounting */
 		if (!huge)
-			__inc_lruvec_page_state(page, NR_FILE_PAGES);
+			__inc_lruvec_page_state(&folio->page, NR_FILE_PAGES);
 unlock:
 		xas_unlock_irq(&xas);
 	} while (xas_nomem(&xas, gfp));
@@ -900,12 +900,12 @@ static noinline int __add_to_page_cache_locked(struct page *page,
 		goto error;
 	}
 
-	trace_mm_filemap_add_to_page_cache(page);
+	trace_mm_filemap_add_to_page_cache(&folio->page);
 	return 0;
 error:
-	page->mapping = NULL;
+	folio->page.mapping = NULL;
 	/* Leave page->index set: truncation relies upon it */
-	put_page(page);
+	put_folio(folio);
 	return error;
 }
 ALLOW_ERROR_INJECTION(__add_to_page_cache_locked, ERRNO);
@@ -925,22 +925,22 @@ ALLOW_ERROR_INJECTION(__add_to_page_cache_locked, ERRNO);
 int add_to_page_cache_locked(struct page *page, struct address_space *mapping,
 		pgoff_t offset, gfp_t gfp_mask)
 {
-	return __add_to_page_cache_locked(page, mapping, offset,
+	return __add_to_page_cache_locked(page_folio(page), mapping, offset,
 					  gfp_mask, NULL);
 }
 EXPORT_SYMBOL(add_to_page_cache_locked);
 
-int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
-				pgoff_t offset, gfp_t gfp_mask)
+int folio_add_to_page_cache(struct folio *folio, struct address_space *mapping,
+				pgoff_t index, gfp_t gfp_mask)
 {
 	void *shadow = NULL;
 	int ret;
 
-	__SetPageLocked(page);
-	ret = __add_to_page_cache_locked(page, mapping, offset,
+	__SetFolioLocked(folio);
+	ret = __add_to_page_cache_locked(folio, mapping, index,
 					 gfp_mask, &shadow);
 	if (unlikely(ret))
-		__ClearPageLocked(page);
+		__ClearFolioLocked(folio);
 	else {
 		/*
 		 * The page might have been evicted from cache only
@@ -950,14 +950,14 @@ int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
 		 * data from the working set, only to cache data that will
 		 * get overwritten with something else, is a waste of memory.
 		 */
-		WARN_ON_ONCE(PageActive(page));
+		WARN_ON_ONCE(FolioActive(folio));
 		if (!(gfp_mask & __GFP_WRITE) && shadow)
-			workingset_refault(page, shadow);
-		lru_cache_add(page);
+			workingset_refault(&folio->page, shadow);
+		lru_cache_add(&folio->page);
 	}
 	return ret;
 }
-EXPORT_SYMBOL_GPL(add_to_page_cache_lru);
+EXPORT_SYMBOL_GPL(folio_add_to_page_cache);
 
 #ifdef CONFIG_NUMA
 struct page *__page_cache_alloc(gfp_t gfp)
@@ -1817,7 +1817,7 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 		if (fgp_flags & FGP_ACCESSED)
 			__SetFolioReferenced(folio);
 
-		err = add_to_page_cache_lru(page, mapping, index, gfp_mask);
+		err = folio_add_to_page_cache(folio, mapping, index, gfp_mask);
 		if (unlikely(err)) {
 			put_folio(folio);
 			page = NULL;
@@ -1826,8 +1826,8 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 		}
 
 		/*
-		 * add_to_page_cache_lru locks the page, and for mmap we expect
-		 * an unlocked page.
+		 * folio_add_to_page_cache locks the page, and for mmap we
+		 * expect an unlocked page.
 		 */
 		if (page && (fgp_flags & FGP_FOR_MMAP))
 			unlock_folio(folio);
-- 
2.29.2

