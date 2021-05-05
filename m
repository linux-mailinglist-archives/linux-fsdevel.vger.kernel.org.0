Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5397437479A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 20:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbhEESAi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 14:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbhEESA1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 14:00:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A5BC00F61F;
        Wed,  5 May 2021 10:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=2jSpm6FvzYEABILGIXHpg0xLyNMDYxqhO9kFxx3u9jc=; b=d+CAvFmLlbls4c44XNxKrjLgGI
        bS8uBPRCTp+89jkEhKHAxAuPM34nkHtdbvWr25E7+D0JMzK310yHlfPDcMCYKdnbF4muey7qMGyY8
        KGR99M+zUqfmOcur7ALNOHOCjm0SxjumoG8QT9XIUgU0hEDfK3ByeAegolNYvFxHohb76MBPMQEn1
        qJ+W9a+ZJnJwZhDBymknNIJ/ahTYxV4VldJTvb/1n9v2AfNFLCzTuaJGX99cu8FPlzEC5hyNfM/58
        0nTgUJzkqWzRlD4ATs0nA4MIu3kdMuLuxNxosNIZjf2IFlTN4D4WiFCdqfV6H7CHzjV9GuvCZq/br
        KO9Mkd+Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leKsU-000cZ5-1m; Wed, 05 May 2021 17:01:08 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 78/96] mm/filemap: Add folio_add_to_page_cache
Date:   Wed,  5 May 2021 16:06:10 +0100
Message-Id: <20210505150628.111735-79-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
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
 include/linux/mm.h      |  7 -----
 include/linux/pagemap.h | 22 ++++++++++++---
 mm/filemap.c            | 59 ++++++++++++++++++++---------------------
 3 files changed, 48 insertions(+), 40 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3f91c9971b32..a6144d325064 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -223,13 +223,6 @@ int overcommit_kbytes_handler(struct ctl_table *, int, void *, size_t *,
 		loff_t *);
 int overcommit_policy_handler(struct ctl_table *, int, void *, size_t *,
 		loff_t *);
-/*
- * Any attempt to mark this function as static leads to build failure
- * when CONFIG_DEBUG_INFO_BTF is enabled because __add_to_page_cache_locked()
- * is referred to by BPF code. This must be visible for error injection.
- */
-int __add_to_page_cache_locked(struct page *page, struct address_space *mapping,
-		pgoff_t index, gfp_t gfp, void **shadowp);
 
 #if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
 #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 64370f615aba..8eab3d8400d2 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -951,9 +951,9 @@ static inline int fault_in_pages_readable(const char __user *uaddr, int size)
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
 void replace_page_cache_page(struct page *old, struct page *new);
@@ -978,6 +978,22 @@ static inline int add_to_page_cache(struct page *page,
 	return error;
 }
 
+static inline int add_to_page_cache_lru(struct page *page,
+		struct address_space *mapping, pgoff_t index, gfp_t gfp)
+{
+	return folio_add_to_page_cache((struct folio *)page, mapping,
+			index, gfp);
+}
+
+/*
+ * Making this function static leads to build failure when
+ * CONFIG_DEBUG_INFO_BTF is enabled because __add_to_page_cache_locked()
+ * is referred to by BPF code.  This must be visible for error injection.
+ */
+int __add_to_page_cache_locked(struct folio *folio,
+		struct address_space *mapping,
+		pgoff_t index, gfp_t gfp, void **shadowp);
+
 /**
  * struct readahead_control - Describes a readahead request.
  *
diff --git a/mm/filemap.c b/mm/filemap.c
index a9c16f05b863..062610ae95d8 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -853,26 +853,25 @@ void replace_page_cache_page(struct page *old, struct page *new)
 }
 EXPORT_SYMBOL_GPL(replace_page_cache_page);
 
-noinline int __add_to_page_cache_locked(struct page *page,
-					struct address_space *mapping,
-					pgoff_t offset, gfp_t gfp,
-					void **shadowp)
+noinline int __add_to_page_cache_locked(struct folio *folio,
+		struct address_space *mapping, pgoff_t index, gfp_t gfp,
+		void **shadowp)
 {
-	XA_STATE(xas, &mapping->i_pages, offset);
-	int huge = PageHuge(page);
+	XA_STATE(xas, &mapping->i_pages, index);
+	int huge = folio_hugetlb(folio);
 	int error;
 	bool charged = false;
 
-	VM_BUG_ON_PAGE(!PageLocked(page), page);
-	VM_BUG_ON_PAGE(PageSwapBacked(page), page);
+	VM_BUG_ON_FOLIO(!folio_locked(folio), folio);
+	VM_BUG_ON_FOLIO(folio_swapbacked(folio), folio);
 	mapping_set_update(&xas, mapping);
 
-	get_page(page);
-	page->mapping = mapping;
-	page->index = offset;
+	folio_get(folio);
+	folio->mapping = mapping;
+	folio->index = index;
 
 	if (!huge) {
-		error = mem_cgroup_charge(page, current->mm, gfp);
+		error = folio_charge_cgroup(folio, current->mm, gfp);
 		if (error)
 			goto error;
 		charged = true;
@@ -884,7 +883,7 @@ noinline int __add_to_page_cache_locked(struct page *page,
 		unsigned int order = xa_get_order(xas.xa, xas.xa_index);
 		void *entry, *old = NULL;
 
-		if (order > thp_order(page))
+		if (order > folio_order(folio))
 			xas_split_alloc(&xas, xa_load(xas.xa, xas.xa_index),
 					order, gfp);
 		xas_lock_irq(&xas);
@@ -901,13 +900,13 @@ noinline int __add_to_page_cache_locked(struct page *page,
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
 
@@ -915,7 +914,7 @@ noinline int __add_to_page_cache_locked(struct page *page,
 
 		/* hugetlb pages do not participate in page cache accounting */
 		if (!huge)
-			__inc_lruvec_page_state(page, NR_FILE_PAGES);
+			__lruvec_stat_add_folio(folio, NR_FILE_PAGES);
 unlock:
 		xas_unlock_irq(&xas);
 	} while (xas_nomem(&xas, gfp));
@@ -923,16 +922,16 @@ noinline int __add_to_page_cache_locked(struct page *page,
 	if (xas_error(&xas)) {
 		error = xas_error(&xas);
 		if (charged)
-			mem_cgroup_uncharge(page);
+			folio_uncharge_cgroup(folio);
 		goto error;
 	}
 
-	trace_mm_filemap_add_to_page_cache(page);
+	trace_mm_filemap_add_to_page_cache(&folio->page);
 	return 0;
 error:
-	page->mapping = NULL;
+	folio->mapping = NULL;
 	/* Leave page->index set: truncation relies upon it */
-	put_page(page);
+	folio_put(folio);
 	return error;
 }
 ALLOW_ERROR_INJECTION(__add_to_page_cache_locked, ERRNO);
@@ -952,22 +951,22 @@ ALLOW_ERROR_INJECTION(__add_to_page_cache_locked, ERRNO);
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
+	__folio_set_locked_flag(folio);
+	ret = __add_to_page_cache_locked(folio, mapping, index,
 					 gfp_mask, &shadow);
 	if (unlikely(ret))
-		__ClearPageLocked(page);
+		__folio_clear_locked_flag(folio);
 	else {
 		/*
 		 * The page might have been evicted from cache only
@@ -977,14 +976,14 @@ int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
 		 * data from the working set, only to cache data that will
 		 * get overwritten with something else, is a waste of memory.
 		 */
-		WARN_ON_ONCE(PageActive(page));
+		WARN_ON_ONCE(folio_active(folio));
 		if (!(gfp_mask & __GFP_WRITE) && shadow)
-			workingset_refault(page_folio(page), shadow);
-		lru_cache_add(page);
+			workingset_refault(folio, shadow);
+		folio_add_lru(folio);
 	}
 	return ret;
 }
-EXPORT_SYMBOL_GPL(add_to_page_cache_lru);
+EXPORT_SYMBOL_GPL(folio_add_to_page_cache);
 
 #ifdef CONFIG_NUMA
 struct folio *filemap_alloc_folio(gfp_t gfp, unsigned int order)
-- 
2.30.2

