Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAEE299560
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 19:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1789836AbgJZSbs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 14:31:48 -0400
Received: from casper.infradead.org ([90.155.50.34]:47268 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1789828AbgJZSbo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 14:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=88leN58bQJyJtRlk/FnBT7Qu037R3x2fc0nGcwRpo6U=; b=GgOi+H15tHTh5qCiyjlAorDDWe
        GpMH9s5yYAsS0kODbE2gpaDyQBKHp+sBYl9dJU10+PQyFCnEZvbjyi5omhC1DLAu0Jt990AJYVoDA
        QMg3l53XRn/mpsLdp4Dl7OO69MWsZLi8SkzvycKe4iJjRvGbyO7atb3d80BTvH83GSHCniGnjOULb
        pTy4YgioE4rED6yn95p9raOZzEICHHl9fg8uOi9wD7yUGpN5MjHLcT18HKmOeUiIxtG2fN0bwVtFC
        p35gnPHWL89sDXnoTsKNLhWQ/MiSBYQGxlZEwiw3GCvOt3TW6kd+XOshkXiaZa9hgQSi/flHuyL0s
        Jhjv9RwA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kX7HS-0002jc-JQ; Mon, 26 Oct 2020 18:31:42 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 4/9] mm: Replace prep_transhuge_page with thp_prep
Date:   Mon, 26 Oct 2020 18:31:31 +0000
Message-Id: <20201026183136.10404-5-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201026183136.10404-1-willy@infradead.org>
References: <20201026183136.10404-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since this is a THP function, move it into the thp_* function namespace.

By permitting NULL or order-0 pages as an argument, and returning the
argument, callers can write:

	return thp_prep(alloc_pages(...));

instead of assigning the result to a temporary variable and conditionally
passing that to prep_transhuge_page().  It'd be even nicer to have a
thp_alloc() function, but there are a lot of different ways that THPs
get allocated, and replicating the alloc_pages() family of APIs is a
bit too much verbosity.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 include/linux/huge_mm.h |  7 +++++--
 mm/huge_memory.c        | 12 ++++++++----
 mm/khugepaged.c         | 12 +++---------
 mm/mempolicy.c          | 15 ++++-----------
 mm/migrate.c            | 15 ++++-----------
 mm/shmem.c              |  9 ++++-----
 6 files changed, 28 insertions(+), 42 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 0365aa97f8e7..c2ecb6036ad8 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -183,7 +183,7 @@ extern unsigned long thp_get_unmapped_area(struct file *filp,
 		unsigned long addr, unsigned long len, unsigned long pgoff,
 		unsigned long flags);
 
-extern void prep_transhuge_page(struct page *page);
+extern struct page *thp_prep(struct page *page);
 extern void free_transhuge_page(struct page *page);
 bool is_transparent_hugepage(struct page *page);
 
@@ -375,7 +375,10 @@ static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
 	return false;
 }
 
-static inline void prep_transhuge_page(struct page *page) {}
+static inline struct page *thp_prep(struct page *page)
+{
+	return page;
+}
 
 static inline bool is_transparent_hugepage(struct page *page)
 {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9474dbc150ed..4448b9cb4327 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -487,15 +487,20 @@ static inline struct deferred_split *get_deferred_split_queue(struct page *page)
 }
 #endif
 
-void prep_transhuge_page(struct page *page)
+struct page *thp_prep(struct page *page)
 {
+	if (!page || compound_order(page) == 0)
+		return page;
 	/*
-	 * we use page->mapping and page->indexlru in second tail page
+	 * we use page->mapping and page->index in second tail page
 	 * as list_head: assuming THP order >= 2
 	 */
+	BUG_ON(compound_order(page) == 1);
 
 	INIT_LIST_HEAD(page_deferred_list(page));
 	set_compound_page_dtor(page, TRANSHUGE_PAGE_DTOR);
+
+	return page;
 }
 
 bool is_transparent_hugepage(struct page *page)
@@ -745,12 +750,11 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 		return ret;
 	}
 	gfp = alloc_hugepage_direct_gfpmask(vma);
-	page = alloc_hugepage_vma(gfp, vma, haddr, HPAGE_PMD_ORDER);
+	page = thp_prep(alloc_hugepage_vma(gfp, vma, haddr, HPAGE_PMD_ORDER));
 	if (unlikely(!page)) {
 		count_vm_event(THP_FAULT_FALLBACK);
 		return VM_FAULT_FALLBACK;
 	}
-	prep_transhuge_page(page);
 	return __do_huge_pmd_anonymous_page(vmf, page, gfp);
 }
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 4e3dff13eb70..3b09c7e4ae3a 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -867,14 +867,13 @@ khugepaged_alloc_page(struct page **hpage, gfp_t gfp, int node)
 {
 	VM_BUG_ON_PAGE(*hpage, *hpage);
 
-	*hpage = __alloc_pages_node(node, gfp, HPAGE_PMD_ORDER);
+	*hpage = thp_prep(__alloc_pages_node(node, gfp, HPAGE_PMD_ORDER));
 	if (unlikely(!*hpage)) {
 		count_vm_event(THP_COLLAPSE_ALLOC_FAILED);
 		*hpage = ERR_PTR(-ENOMEM);
 		return NULL;
 	}
 
-	prep_transhuge_page(*hpage);
 	count_vm_event(THP_COLLAPSE_ALLOC);
 	return *hpage;
 }
@@ -886,13 +885,8 @@ static int khugepaged_find_target_node(void)
 
 static inline struct page *alloc_khugepaged_hugepage(void)
 {
-	struct page *page;
-
-	page = alloc_pages(alloc_hugepage_khugepaged_gfpmask(),
-			   HPAGE_PMD_ORDER);
-	if (page)
-		prep_transhuge_page(page);
-	return page;
+	return thp_prep(alloc_pages(alloc_hugepage_khugepaged_gfpmask(),
+			   HPAGE_PMD_ORDER));
 }
 
 static struct page *khugepaged_alloc_hugepage(bool *wait)
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 3fde772ef5ef..e97cee53c0b1 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1226,19 +1226,12 @@ static struct page *new_page(struct page *page, unsigned long start)
 		vma = vma->vm_next;
 	}
 
-	if (PageHuge(page)) {
+	if (PageHuge(page))
 		return alloc_huge_page_vma(page_hstate(compound_head(page)),
 				vma, address);
-	} else if (PageTransHuge(page)) {
-		struct page *thp;
-
-		thp = alloc_hugepage_vma(GFP_TRANSHUGE, vma, address,
-					 HPAGE_PMD_ORDER);
-		if (!thp)
-			return NULL;
-		prep_transhuge_page(thp);
-		return thp;
-	}
+	if (PageTransHuge(page))
+		return thp_prep(alloc_hugepage_vma(GFP_TRANSHUGE, vma,
+				address, thp_order(page)));
 	/*
 	 * if !vma, alloc_page_vma() will use task or system default policy
 	 */
diff --git a/mm/migrate.c b/mm/migrate.c
index 5ca5842df5db..262c91038c41 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1538,7 +1538,6 @@ struct page *alloc_migration_target(struct page *page, unsigned long private)
 	struct migration_target_control *mtc;
 	gfp_t gfp_mask;
 	unsigned int order = 0;
-	struct page *new_page = NULL;
 	int nid;
 	int zidx;
 
@@ -1568,12 +1567,8 @@ struct page *alloc_migration_target(struct page *page, unsigned long private)
 	if (is_highmem_idx(zidx) || zidx == ZONE_MOVABLE)
 		gfp_mask |= __GFP_HIGHMEM;
 
-	new_page = __alloc_pages_nodemask(gfp_mask, order, nid, mtc->nmask);
-
-	if (new_page && PageTransHuge(new_page))
-		prep_transhuge_page(new_page);
-
-	return new_page;
+	return thp_prep(__alloc_pages_nodemask(gfp_mask, order, nid,
+			mtc->nmask));
 }
 
 #ifdef CONFIG_NUMA
@@ -2134,12 +2129,10 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
 	int page_lru = page_is_file_lru(page);
 	unsigned long start = address & HPAGE_PMD_MASK;
 
-	new_page = alloc_pages_node(node,
-		(GFP_TRANSHUGE_LIGHT | __GFP_THISNODE),
-		HPAGE_PMD_ORDER);
+	new_page = thp_prep(alloc_pages_node(node,
+			GFP_TRANSHUGE_LIGHT | __GFP_THISNODE, HPAGE_PMD_ORDER));
 	if (!new_page)
 		goto out_fail;
-	prep_transhuge_page(new_page);
 
 	isolated = numamigrate_isolate_page(pgdat, page);
 	if (!isolated) {
diff --git a/mm/shmem.c b/mm/shmem.c
index 0cce132457f1..c10f8ecf85ce 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1486,12 +1486,11 @@ static struct page *shmem_alloc_hugepage(gfp_t gfp,
 		return NULL;
 
 	shmem_pseudo_vma_init(&pvma, info, hindex);
-	page = alloc_pages_vma(gfp | __GFP_COMP | __GFP_NORETRY | __GFP_NOWARN,
-			HPAGE_PMD_ORDER, &pvma, 0, numa_node_id(), true);
+	gfp |= __GFP_COMP | __GFP_NORETRY | __GFP_NOWARN;
+	page = thp_prep(alloc_pages_vma(gfp, HPAGE_PMD_ORDER, &pvma, 0,
+			numa_node_id(), true));
 	shmem_pseudo_vma_destroy(&pvma);
-	if (page)
-		prep_transhuge_page(page);
-	else
+	if (!page)
 		count_vm_event(THP_FILE_FALLBACK);
 	return page;
 }
-- 
2.28.0

