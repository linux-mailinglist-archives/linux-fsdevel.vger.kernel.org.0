Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8243C642F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 21:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236564AbhGLTx5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 15:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235201AbhGLTx5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 15:53:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD4AC0613DD;
        Mon, 12 Jul 2021 12:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=506n9yP4xj+gwii3hjrAW1bY1gWM1aKd4DRn7wTI3fQ=; b=bpqbDNpQe8lSDBjliF1qCNGOCp
        SabsgaorpwVqZ6gYd5Eex6VTxfGdlLXndO8fLv1Yda4R9M1euEP/gQlbKDCquedyb//QvitlC/YDf
        EwG55cy/3wZAo3ryy3vGW0freDuxZ3gankZh3s5MJz7cyMvICY5HdbEPNNkRRPeAXzf2kAqjnQao1
        dYhSOWXVJvzugbOZRcAtinabqOHSQw3UaQSuun9L3TFBWvdEjPnmbVYGRC1zfmOW75f/m0nlMtNf4
        ekMaZwNt0pXPfS739+feXyPDFjvzRO+kv4Hc3VhzKVJh5rbEVkmzoItHgsUsvVfJebmL+YEBxajKo
        YzThOyZg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m31w5-000OED-T3; Mon, 12 Jul 2021 19:50:03 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v13 08/18] mm/memcg: Convert mem_cgroup_charge() to take a folio
Date:   Mon, 12 Jul 2021 20:45:41 +0100
Message-Id: <20210712194551.91920-9-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712194551.91920-1-willy@infradead.org>
References: <20210712194551.91920-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert all callers of mem_cgroup_charge() to call page_folio() on the
page they're currently passing in.  Many of them will be converted to
use folios themselves soon.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/memcontrol.h |  6 +++---
 kernel/events/uprobes.c    |  3 ++-
 mm/filemap.c               |  2 +-
 mm/huge_memory.c           |  2 +-
 mm/khugepaged.c            |  4 ++--
 mm/ksm.c                   |  3 ++-
 mm/memcontrol.c            | 26 +++++++++++++-------------
 mm/memory.c                |  9 +++++----
 mm/migrate.c               |  2 +-
 mm/shmem.c                 |  2 +-
 mm/userfaultfd.c           |  2 +-
 11 files changed, 32 insertions(+), 29 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index f40c4e0b0431..0c3b386660a8 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -704,7 +704,7 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
 		page_counter_read(&memcg->memory);
 }
 
-int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask);
+int mem_cgroup_charge(struct folio *, struct mm_struct *, gfp_t);
 int mem_cgroup_swapin_charge_page(struct page *page, struct mm_struct *mm,
 				  gfp_t gfp, swp_entry_t entry);
 void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry);
@@ -1190,8 +1190,8 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
 	return false;
 }
 
-static inline int mem_cgroup_charge(struct page *page, struct mm_struct *mm,
-				    gfp_t gfp_mask)
+static inline int mem_cgroup_charge(struct folio *folio,
+		struct mm_struct *mm, gfp_t gfp)
 {
 	return 0;
 }
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index af24dc3febbe..6357c3580d07 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -167,7 +167,8 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 				addr + PAGE_SIZE);
 
 	if (new_page) {
-		err = mem_cgroup_charge(new_page, vma->vm_mm, GFP_KERNEL);
+		err = mem_cgroup_charge(page_folio(new_page), vma->vm_mm,
+					GFP_KERNEL);
 		if (err)
 			return err;
 	}
diff --git a/mm/filemap.c b/mm/filemap.c
index 8e6c69db5559..44498bfe7b45 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -872,7 +872,7 @@ noinline int __add_to_page_cache_locked(struct page *page,
 	page->index = offset;
 
 	if (!huge) {
-		error = mem_cgroup_charge(page, NULL, gfp);
+		error = mem_cgroup_charge(page_folio(page), NULL, gfp);
 		if (error)
 			goto error;
 		charged = true;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index afff3ac87067..ecb1fb1f5f3e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -603,7 +603,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 
 	VM_BUG_ON_PAGE(!PageCompound(page), page);
 
-	if (mem_cgroup_charge(page, vma->vm_mm, gfp)) {
+	if (mem_cgroup_charge(page_folio(page), vma->vm_mm, gfp)) {
 		put_page(page);
 		count_vm_event(THP_FAULT_FALLBACK);
 		count_vm_event(THP_FAULT_FALLBACK_CHARGE);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b0412be08fa2..8f6d7fdea9f4 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1087,7 +1087,7 @@ static void collapse_huge_page(struct mm_struct *mm,
 		goto out_nolock;
 	}
 
-	if (unlikely(mem_cgroup_charge(new_page, mm, gfp))) {
+	if (unlikely(mem_cgroup_charge(page_folio(new_page), mm, gfp))) {
 		result = SCAN_CGROUP_CHARGE_FAIL;
 		goto out_nolock;
 	}
@@ -1658,7 +1658,7 @@ static void collapse_file(struct mm_struct *mm,
 		goto out;
 	}
 
-	if (unlikely(mem_cgroup_charge(new_page, mm, gfp))) {
+	if (unlikely(mem_cgroup_charge(page_folio(new_page), mm, gfp))) {
 		result = SCAN_CGROUP_CHARGE_FAIL;
 		goto out;
 	}
diff --git a/mm/ksm.c b/mm/ksm.c
index 3fa9bc8a67cf..23d36b59f997 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2580,7 +2580,8 @@ struct page *ksm_might_need_to_copy(struct page *page,
 		return page;		/* let do_swap_page report the error */
 
 	new_page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma, address);
-	if (new_page && mem_cgroup_charge(new_page, vma->vm_mm, GFP_KERNEL)) {
+	if (new_page &&
+	    mem_cgroup_charge(page_folio(new_page), vma->vm_mm, GFP_KERNEL)) {
 		put_page(new_page);
 		new_page = NULL;
 	}
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f64869c0e06e..ebad42c55f76 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6681,10 +6681,9 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
 			atomic_long_read(&parent->memory.children_low_usage)));
 }
 
-static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
+static int __mem_cgroup_charge(struct folio *folio, struct mem_cgroup *memcg,
 			       gfp_t gfp)
 {
-	struct folio *folio = page_folio(page);
 	unsigned int nr_pages = folio_nr_pages(folio);
 	int ret;
 
@@ -6697,27 +6696,27 @@ static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
 
 	local_irq_disable();
 	mem_cgroup_charge_statistics(memcg, nr_pages);
-	memcg_check_events(memcg, page_to_nid(page));
+	memcg_check_events(memcg, folio_nid(folio));
 	local_irq_enable();
 out:
 	return ret;
 }
 
 /**
- * mem_cgroup_charge - charge a newly allocated page to a cgroup
- * @page: page to charge
- * @mm: mm context of the victim
- * @gfp_mask: reclaim mode
+ * mem_cgroup_charge - Charge a newly allocated folio to a cgroup.
+ * @folio: Folio to charge.
+ * @mm: mm context of the allocating task.
+ * @gfp: reclaim mode
  *
- * Try to charge @page to the memcg that @mm belongs to, reclaiming
- * pages according to @gfp_mask if necessary. if @mm is NULL, try to
+ * Try to charge @folio to the memcg that @mm belongs to, reclaiming
+ * pages according to @gfp if necessary.  If @mm is NULL, try to
  * charge to the active memcg.
  *
- * Do not use this for pages allocated for swapin.
+ * Do not use this for folios allocated for swapin.
  *
  * Returns 0 on success. Otherwise, an error code is returned.
  */
-int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask)
+int mem_cgroup_charge(struct folio *folio, struct mm_struct *mm, gfp_t gfp)
 {
 	struct mem_cgroup *memcg;
 	int ret;
@@ -6726,7 +6725,7 @@ int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask)
 		return 0;
 
 	memcg = get_mem_cgroup_from_mm(mm);
-	ret = __mem_cgroup_charge(page, memcg, gfp_mask);
+	ret = __mem_cgroup_charge(folio, memcg, gfp);
 	css_put(&memcg->css);
 
 	return ret;
@@ -6747,6 +6746,7 @@ int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask)
 int mem_cgroup_swapin_charge_page(struct page *page, struct mm_struct *mm,
 				  gfp_t gfp, swp_entry_t entry)
 {
+	struct folio *folio = page_folio(page);
 	struct mem_cgroup *memcg;
 	unsigned short id;
 	int ret;
@@ -6761,7 +6761,7 @@ int mem_cgroup_swapin_charge_page(struct page *page, struct mm_struct *mm,
 		memcg = get_mem_cgroup_from_mm(mm);
 	rcu_read_unlock();
 
-	ret = __mem_cgroup_charge(page, memcg, gfp);
+	ret = __mem_cgroup_charge(folio, memcg, gfp);
 
 	css_put(&memcg->css);
 	return ret;
diff --git a/mm/memory.c b/mm/memory.c
index 2f111f9b3dbc..614418e26e2c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -990,7 +990,7 @@ page_copy_prealloc(struct mm_struct *src_mm, struct vm_area_struct *vma,
 	if (!new_page)
 		return NULL;
 
-	if (mem_cgroup_charge(new_page, src_mm, GFP_KERNEL)) {
+	if (mem_cgroup_charge(page_folio(new_page), src_mm, GFP_KERNEL)) {
 		put_page(new_page);
 		return NULL;
 	}
@@ -3019,7 +3019,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		}
 	}
 
-	if (mem_cgroup_charge(new_page, mm, GFP_KERNEL))
+	if (mem_cgroup_charge(page_folio(new_page), mm, GFP_KERNEL))
 		goto oom_free_new;
 	cgroup_throttle_swaprate(new_page, GFP_KERNEL);
 
@@ -3768,7 +3768,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	if (!page)
 		goto oom;
 
-	if (mem_cgroup_charge(page, vma->vm_mm, GFP_KERNEL))
+	if (mem_cgroup_charge(page_folio(page), vma->vm_mm, GFP_KERNEL))
 		goto oom_free_page;
 	cgroup_throttle_swaprate(page, GFP_KERNEL);
 
@@ -4183,7 +4183,8 @@ static vm_fault_t do_cow_fault(struct vm_fault *vmf)
 	if (!vmf->cow_page)
 		return VM_FAULT_OOM;
 
-	if (mem_cgroup_charge(vmf->cow_page, vma->vm_mm, GFP_KERNEL)) {
+	if (mem_cgroup_charge(page_folio(vmf->cow_page), vma->vm_mm,
+				GFP_KERNEL)) {
 		put_page(vmf->cow_page);
 		return VM_FAULT_OOM;
 	}
diff --git a/mm/migrate.c b/mm/migrate.c
index 23cbd9de030b..01c05d7f9d6a 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2811,7 +2811,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 
 	if (unlikely(anon_vma_prepare(vma)))
 		goto abort;
-	if (mem_cgroup_charge(page, vma->vm_mm, GFP_KERNEL))
+	if (mem_cgroup_charge(page_folio(page), vma->vm_mm, GFP_KERNEL))
 		goto abort;
 
 	/*
diff --git a/mm/shmem.c b/mm/shmem.c
index 70d9ce294bb4..3931fed5c8d8 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -685,7 +685,7 @@ static int shmem_add_to_page_cache(struct page *page,
 	page->index = index;
 
 	if (!PageSwapCache(page)) {
-		error = mem_cgroup_charge(page, charge_mm, gfp);
+		error = mem_cgroup_charge(page_folio(page), charge_mm, gfp);
 		if (error) {
 			if (PageTransHuge(page)) {
 				count_vm_event(THP_FILE_FALLBACK);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 0e2132834bc7..5d0f55f3c0ed 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -164,7 +164,7 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
 	__SetPageUptodate(page);
 
 	ret = -ENOMEM;
-	if (mem_cgroup_charge(page, dst_mm, GFP_KERNEL))
+	if (mem_cgroup_charge(page_folio(page), dst_mm, GFP_KERNEL))
 		goto out_release;
 
 	ret = mfill_atomic_install_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
-- 
2.30.2

