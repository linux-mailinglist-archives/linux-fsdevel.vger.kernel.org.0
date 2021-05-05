Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A5E3746E6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 19:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbhEERcT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 13:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240242AbhEERbn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 13:31:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A21C049548;
        Wed,  5 May 2021 09:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=SxxEmoLS4ZPsogD6Mo5ZPuY7EyQChdV3gLRp4slNQ3Y=; b=HY3h5yi1P3M6cCzycMXiFrG86d
        yc7k7FYjwBq4gJxId3PMXGu0LOT+MpPCdC8z6ny6CTAgJ1CtESA9mpemA5OFbWY944uWTZlo57LLj
        CY8YBOOtaXaKicUE+gXtIE9E4p1GICV5ikYDvP6+zyMKfMQbVP3BT9k6t223I/m6dgCPD9NTYxQea
        ZwVuLvPfamh0/WL51a4A5KgILDiaW5AsmqhXCgikkKd3DBw2rETWamrxNDjT/oVeVut+H3j2zFmgc
        DPk37jA71YUJsqG42ufxIYtKSHmkehGVAkkqf0SqIpfd/jHzzm1hljlb2Sqae6oj8QiyLPOsrneAz
        7VvCRLMg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leKlQ-000cBg-Ch; Wed, 05 May 2021 16:54:29 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 76/96] mm/page_alloc: Add __alloc_folio, __alloc_folio_node and alloc_folio
Date:   Wed,  5 May 2021 16:06:08 +0100
Message-Id: <20210505150628.111735-77-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These wrappers are mostly for type safety, but they also ensure that the
page allocator allocates a compound page and initialises the deferred
list if the page is large enough to have one.  While the new allocation
functions cost 65 bytes of text, they save dozens of bytes of text in
each of their callers, due to not having to call prep_transhuge_page().
Overall, shrinks the kernel by 238 bytes.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/gfp.h | 16 +++++++++++++
 mm/khugepaged.c     | 32 ++++++++++----------------
 mm/mempolicy.c      | 10 ++++++++
 mm/migrate.c        | 56 +++++++++++++++++++++------------------------
 mm/page_alloc.c     | 12 ++++++++++
 5 files changed, 76 insertions(+), 50 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index a503d928e684..76086c798cb1 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -511,6 +511,8 @@ static inline void arch_alloc_page(struct page *page, int order) { }
 
 struct page *__alloc_pages(gfp_t gfp, unsigned int order, int preferred_nid,
 		nodemask_t *nodemask);
+struct folio *__alloc_folio(gfp_t gfp, unsigned int order, int preferred_nid,
+		nodemask_t *nodemask);
 
 unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 				nodemask_t *nodemask, int nr_pages,
@@ -543,6 +545,15 @@ __alloc_pages_node(int nid, gfp_t gfp_mask, unsigned int order)
 	return __alloc_pages(gfp_mask, order, nid, NULL);
 }
 
+static inline
+struct folio *__alloc_folio_node(gfp_t gfp, unsigned int order, int nid)
+{
+	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
+	VM_WARN_ON((gfp & __GFP_THISNODE) && !node_online(nid));
+
+	return __alloc_folio(gfp, order, nid, NULL);
+}
+
 /*
  * Allocate pages, preferring the node given as nid. When nid == NUMA_NO_NODE,
  * prefer the current CPU's closest node. Otherwise node must be valid and
@@ -559,6 +570,7 @@ static inline struct page *alloc_pages_node(int nid, gfp_t gfp_mask,
 
 #ifdef CONFIG_NUMA
 struct page *alloc_pages(gfp_t gfp, unsigned int order);
+struct folio *alloc_folio(gfp_t gfp, unsigned order);
 extern struct page *alloc_pages_vma(gfp_t gfp_mask, int order,
 			struct vm_area_struct *vma, unsigned long addr,
 			int node, bool hugepage);
@@ -569,6 +581,10 @@ static inline struct page *alloc_pages(gfp_t gfp_mask, unsigned int order)
 {
 	return alloc_pages_node(numa_node_id(), gfp_mask, order);
 }
+static inline struct folio *alloc_folio(gfp_t gfp, unsigned int order)
+{
+	return __alloc_folio_node(gfp, order, numa_node_id());
+}
 #define alloc_pages_vma(gfp_mask, order, vma, addr, node, false)\
 	alloc_pages(gfp_mask, order)
 #define alloc_hugepage_vma(gfp_mask, vma, addr, order) \
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 6c0185fdd815..9dde71607f7c 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -877,18 +877,20 @@ static bool khugepaged_prealloc_page(struct page **hpage, bool *wait)
 static struct page *
 khugepaged_alloc_page(struct page **hpage, gfp_t gfp, int node)
 {
+	struct folio *folio;
+
 	VM_BUG_ON_PAGE(*hpage, *hpage);
 
-	*hpage = __alloc_pages_node(node, gfp, HPAGE_PMD_ORDER);
-	if (unlikely(!*hpage)) {
+	folio = __alloc_folio_node(gfp, HPAGE_PMD_ORDER, node);
+	if (unlikely(!folio)) {
 		count_vm_event(THP_COLLAPSE_ALLOC_FAILED);
 		*hpage = ERR_PTR(-ENOMEM);
 		return NULL;
 	}
 
-	prep_transhuge_page(*hpage);
 	count_vm_event(THP_COLLAPSE_ALLOC);
-	return *hpage;
+	*hpage = &folio->page;
+	return &folio->page;
 }
 #else
 static int khugepaged_find_target_node(void)
@@ -896,24 +898,14 @@ static int khugepaged_find_target_node(void)
 	return 0;
 }
 
-static inline struct page *alloc_khugepaged_hugepage(void)
-{
-	struct page *page;
-
-	page = alloc_pages(alloc_hugepage_khugepaged_gfpmask(),
-			   HPAGE_PMD_ORDER);
-	if (page)
-		prep_transhuge_page(page);
-	return page;
-}
-
 static struct page *khugepaged_alloc_hugepage(bool *wait)
 {
-	struct page *hpage;
+	struct folio *folio;
 
 	do {
-		hpage = alloc_khugepaged_hugepage();
-		if (!hpage) {
+		folio = alloc_folio(alloc_hugepage_khugepaged_gfpmask(),
+					HPAGE_PMD_ORDER);
+		if (!folio) {
 			count_vm_event(THP_COLLAPSE_ALLOC_FAILED);
 			if (!*wait)
 				return NULL;
@@ -922,9 +914,9 @@ static struct page *khugepaged_alloc_hugepage(bool *wait)
 			khugepaged_alloc_sleep();
 		} else
 			count_vm_event(THP_COLLAPSE_ALLOC);
-	} while (unlikely(!hpage) && likely(khugepaged_enabled()));
+	} while (unlikely(!folio) && likely(khugepaged_enabled()));
 
-	return hpage;
+	return &folio->page;
 }
 
 static bool khugepaged_prealloc_page(struct page **hpage, bool *wait)
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index d79fa299b70c..382fec380f28 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2277,6 +2277,16 @@ struct page *alloc_pages(gfp_t gfp, unsigned order)
 }
 EXPORT_SYMBOL(alloc_pages);
 
+struct folio *alloc_folio(gfp_t gfp, unsigned order)
+{
+	struct page *page = alloc_pages(gfp | __GFP_COMP, order);
+
+	if (page && order > 1)
+		prep_transhuge_page(page);
+	return (struct folio *)page;
+}
+EXPORT_SYMBOL(alloc_folio);
+
 int vma_dup_policy(struct vm_area_struct *src, struct vm_area_struct *dst)
 {
 	struct mempolicy *pol = mpol_dup(vma_policy(src));
diff --git a/mm/migrate.c b/mm/migrate.c
index b234c3f3acb7..0b9cadbad900 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1562,7 +1562,7 @@ struct page *alloc_migration_target(struct page *page, unsigned long private)
 	struct migration_target_control *mtc;
 	gfp_t gfp_mask;
 	unsigned int order = 0;
-	struct page *new_page = NULL;
+	struct folio *new_folio = NULL;
 	int nid;
 	int zidx;
 
@@ -1592,12 +1592,9 @@ struct page *alloc_migration_target(struct page *page, unsigned long private)
 	if (is_highmem_idx(zidx) || zidx == ZONE_MOVABLE)
 		gfp_mask |= __GFP_HIGHMEM;
 
-	new_page = __alloc_pages(gfp_mask, order, nid, mtc->nmask);
+	new_folio = __alloc_folio(gfp_mask, order, nid, mtc->nmask);
 
-	if (new_page && PageTransHuge(new_page))
-		prep_transhuge_page(new_page);
-
-	return new_page;
+	return &new_folio->page;
 }
 
 #ifdef CONFIG_NUMA
@@ -2155,35 +2152,34 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
 	spinlock_t *ptl;
 	pg_data_t *pgdat = NODE_DATA(node);
 	int isolated = 0;
-	struct page *new_page = NULL;
+	struct folio *new_folio = NULL;
 	int page_lru = page_is_file_lru(page);
 	unsigned long start = address & HPAGE_PMD_MASK;
 
-	new_page = alloc_pages_node(node,
-		(GFP_TRANSHUGE_LIGHT | __GFP_THISNODE),
-		HPAGE_PMD_ORDER);
-	if (!new_page)
+	new_folio = __alloc_folio_node(node,
+			(GFP_TRANSHUGE_LIGHT | __GFP_THISNODE),
+			HPAGE_PMD_ORDER);
+	if (!new_folio)
 		goto out_fail;
-	prep_transhuge_page(new_page);
 
 	isolated = numamigrate_isolate_page(pgdat, page);
 	if (!isolated) {
-		put_page(new_page);
+		folio_put(new_folio);
 		goto out_fail;
 	}
 
 	/* Prepare a page as a migration target */
-	__SetPageLocked(new_page);
+	__folio_set_locked_flag(new_folio);
 	if (PageSwapBacked(page))
-		__SetPageSwapBacked(new_page);
+		__folio_set_swapbacked_flag(new_folio);
 
 	/* anon mapping, we can simply copy page->mapping to the new page: */
-	new_page->mapping = page->mapping;
-	new_page->index = page->index;
+	new_folio->mapping = page->mapping;
+	new_folio->index = page->index;
 	/* flush the cache before copying using the kernel virtual address */
 	flush_cache_range(vma, start, start + HPAGE_PMD_SIZE);
-	migrate_page_copy(new_page, page);
-	WARN_ON(PageLRU(new_page));
+	migrate_page_copy(&new_folio->page, page);
+	WARN_ON(folio_lru(new_folio));
 
 	/* Recheck the target PMD */
 	ptl = pmd_lock(mm, pmd);
@@ -2191,13 +2187,13 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
 		spin_unlock(ptl);
 
 		/* Reverse changes made by migrate_page_copy() */
-		if (TestClearPageActive(new_page))
+		if (folio_test_clear_active_flag(new_folio))
 			SetPageActive(page);
-		if (TestClearPageUnevictable(new_page))
+		if (folio_test_clear_unevictable_flag(new_folio))
 			SetPageUnevictable(page);
 
-		unlock_page(new_page);
-		put_page(new_page);		/* Free it */
+		folio_unlock(new_folio);
+		folio_put(new_folio);		/* Free it */
 
 		/* Retake the callers reference and putback on LRU */
 		get_page(page);
@@ -2208,7 +2204,7 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
 		goto out_unlock;
 	}
 
-	entry = mk_huge_pmd(new_page, vma->vm_page_prot);
+	entry = mk_huge_pmd(&new_folio->page, vma->vm_page_prot);
 	entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
 
 	/*
@@ -2219,7 +2215,7 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
 	 * new page and page_add_new_anon_rmap guarantee the copy is
 	 * visible before the pagetable update.
 	 */
-	page_add_anon_rmap(new_page, vma, start, true);
+	page_add_anon_rmap(&new_folio->page, vma, start, true);
 	/*
 	 * At this point the pmd is numa/protnone (i.e. non present) and the TLB
 	 * has already been flushed globally.  So no TLB can be currently
@@ -2235,17 +2231,17 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
 	update_mmu_cache_pmd(vma, address, &entry);
 
 	page_ref_unfreeze(page, 2);
-	mlock_migrate_page(new_page, page);
+	mlock_migrate_page(&new_folio->page, page);
 	page_remove_rmap(page, true);
-	set_page_owner_migrate_reason(new_page, MR_NUMA_MISPLACED);
+	set_page_owner_migrate_reason(&new_folio->page, MR_NUMA_MISPLACED);
 
 	spin_unlock(ptl);
 
 	/* Take an "isolate" reference and put new page on the LRU. */
-	get_page(new_page);
-	putback_lru_page(new_page);
+	folio_get(new_folio);
+	putback_lru_page(&new_folio->page);
 
-	unlock_page(new_page);
+	folio_unlock(new_folio);
 	unlock_page(page);
 	put_page(page);			/* Drop the rmap reference */
 	put_page(page);			/* Drop the LRU isolation reference */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5a1e5b624594..6b5d3f993a41 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5225,6 +5225,18 @@ struct page *__alloc_pages(gfp_t gfp, unsigned int order, int preferred_nid,
 }
 EXPORT_SYMBOL(__alloc_pages);
 
+struct folio *__alloc_folio(gfp_t gfp, unsigned int order, int preferred_nid,
+		nodemask_t *nodemask)
+{
+	struct page *page = __alloc_pages(gfp | __GFP_COMP, order,
+			preferred_nid, nodemask);
+
+	if (page && order > 1)
+		prep_transhuge_page(page);
+	return (struct folio *)page;
+}
+EXPORT_SYMBOL(__alloc_folio);
+
 /*
  * Common helper functions. Never use with __GFP_HIGHMEM because the returned
  * address cannot represent highmem pages. Use alloc_pages and then kmap if
-- 
2.30.2

