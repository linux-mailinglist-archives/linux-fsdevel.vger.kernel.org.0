Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF2E2BD5DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2019 02:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391842AbfIYAwS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Sep 2019 20:52:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56876 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391536AbfIYAwS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Sep 2019 20:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0cjGwEA4PqaAXASo8dxcqkZcnZ5NT/5g/ODeUF4SeXg=; b=PzRlI0jUb52P6YMDT6xr4CtRV9
        Epx4aVhJjHCShqUftshMX21nvkY5k+8iRR3PEPOy7gsp4+C/Aj/jLNlUBx8E2OYwX4df1eaqFw6RR
        nHNJ3rRa1jEtQh31NVdrK6O/MhmVg6uAfFBgksHPUmDXZrcV/NI7bMiSwlp48c3Q0QKN8eEgBwVx8
        +4lRwTmFLJdKK7x5MGmpVj9A4my2Wc+Xv9BM0T2yG8nDgiiZJd+j0sr4Vw1UF6lRlholMWGz896fS
        yrnF5BCeMf/CR2AgLLSzG0b/G7LKi/XQE+lXnAbriFY8u9hVH++Qcv59FbzdN7D0HhjRvS3JXWqrC
        nPhQs1Cg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCvXV-00076v-Lz; Wed, 25 Sep 2019 00:52:17 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 11/15] mm: Remove hpage_nr_pages
Date:   Tue, 24 Sep 2019 17:52:10 -0700
Message-Id: <20190925005214.27240-12-willy@infradead.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190925005214.27240-1-willy@infradead.org>
References: <20190925005214.27240-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

This function assumed that compound pages were necessarily PMD sized.
While that may be true for some users, it's not going to be true for
all users forever, so it's better to remove it and avoid the confusion
by just using compound_nr() or page_size().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 drivers/nvdimm/btt.c      |  4 +---
 drivers/nvdimm/pmem.c     |  3 +--
 include/linux/huge_mm.h   |  8 --------
 include/linux/mm_inline.h |  6 +++---
 mm/filemap.c              |  2 +-
 mm/gup.c                  |  2 +-
 mm/internal.h             |  4 ++--
 mm/memcontrol.c           | 14 +++++++-------
 mm/memory_hotplug.c       |  4 ++--
 mm/mempolicy.c            |  2 +-
 mm/migrate.c              | 19 ++++++++++---------
 mm/mlock.c                |  9 ++++-----
 mm/page_io.c              |  4 ++--
 mm/page_vma_mapped.c      |  6 +++---
 mm/rmap.c                 |  8 ++++----
 mm/swap.c                 |  4 ++--
 mm/swap_state.c           |  4 ++--
 mm/swapfile.c             |  2 +-
 mm/vmscan.c               |  4 ++--
 19 files changed, 49 insertions(+), 60 deletions(-)

diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index a8d56887ec88..2aac2bf10a37 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1488,10 +1488,8 @@ static int btt_rw_page(struct block_device *bdev, sector_t sector,
 {
 	struct btt *btt = bdev->bd_disk->private_data;
 	int rc;
-	unsigned int len;
 
-	len = hpage_nr_pages(page) * PAGE_SIZE;
-	rc = btt_do_bvec(btt, NULL, page, len, 0, op, sector);
+	rc = btt_do_bvec(btt, NULL, page, page_size(page), 0, op, sector);
 	if (rc == 0)
 		page_endio(page, op_is_write(op), 0);
 
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index f9f76f6ba07b..778c73fd10d6 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -224,8 +224,7 @@ static int pmem_rw_page(struct block_device *bdev, sector_t sector,
 	struct pmem_device *pmem = bdev->bd_queue->queuedata;
 	blk_status_t rc;
 
-	rc = pmem_do_bvec(pmem, page, hpage_nr_pages(page) * PAGE_SIZE,
-			  0, op, sector);
+	rc = pmem_do_bvec(pmem, page, page_size(page), 0, op, sector);
 
 	/*
 	 * The ->rw_page interface is subtle and tricky.  The core
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 779e83800a77..6018d31549c3 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -226,12 +226,6 @@ static inline spinlock_t *pud_trans_huge_lock(pud_t *pud,
 	else
 		return NULL;
 }
-static inline int hpage_nr_pages(struct page *page)
-{
-	if (unlikely(PageTransHuge(page)))
-		return HPAGE_PMD_NR;
-	return 1;
-}
 
 struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
 		pmd_t *pmd, int flags, struct dev_pagemap **pgmap);
@@ -285,8 +279,6 @@ static inline struct list_head *page_deferred_list(struct page *page)
 #define HPAGE_PUD_MASK ({ BUILD_BUG(); 0; })
 #define HPAGE_PUD_SIZE ({ BUILD_BUG(); 0; })
 
-#define hpage_nr_pages(x) 1
-
 static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
 {
 	return false;
diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 6f2fef7b0784..3bd675ce6ba8 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -47,14 +47,14 @@ static __always_inline void update_lru_size(struct lruvec *lruvec,
 static __always_inline void add_page_to_lru_list(struct page *page,
 				struct lruvec *lruvec, enum lru_list lru)
 {
-	update_lru_size(lruvec, lru, page_zonenum(page), hpage_nr_pages(page));
+	update_lru_size(lruvec, lru, page_zonenum(page), compound_nr(page));
 	list_add(&page->lru, &lruvec->lists[lru]);
 }
 
 static __always_inline void add_page_to_lru_list_tail(struct page *page,
 				struct lruvec *lruvec, enum lru_list lru)
 {
-	update_lru_size(lruvec, lru, page_zonenum(page), hpage_nr_pages(page));
+	update_lru_size(lruvec, lru, page_zonenum(page), compound_nr(page));
 	list_add_tail(&page->lru, &lruvec->lists[lru]);
 }
 
@@ -62,7 +62,7 @@ static __always_inline void del_page_from_lru_list(struct page *page,
 				struct lruvec *lruvec, enum lru_list lru)
 {
 	list_del(&page->lru);
-	update_lru_size(lruvec, lru, page_zonenum(page), -hpage_nr_pages(page));
+	update_lru_size(lruvec, lru, page_zonenum(page), -compound_nr(page));
 }
 
 /**
diff --git a/mm/filemap.c b/mm/filemap.c
index 8eca91547e40..b07ef9469861 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -196,7 +196,7 @@ static void unaccount_page_cache_page(struct address_space *mapping,
 	if (PageHuge(page))
 		return;
 
-	nr = hpage_nr_pages(page);
+	nr = compound_nr(page);
 
 	__mod_node_page_state(page_pgdat(page), NR_FILE_PAGES, -nr);
 	if (PageSwapBacked(page)) {
diff --git a/mm/gup.c b/mm/gup.c
index 60c3915c8ee6..579dc9426b87 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1469,7 +1469,7 @@ static long check_and_migrate_cma_pages(struct task_struct *tsk,
 					mod_node_page_state(page_pgdat(head),
 							    NR_ISOLATED_ANON +
 							    page_is_file_cache(head),
-							    hpage_nr_pages(head));
+							    compound_nr(head));
 				}
 			}
 		}
diff --git a/mm/internal.h b/mm/internal.h
index e32390802fd3..abe3a15b456c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -327,7 +327,7 @@ extern void clear_page_mlock(struct page *page);
 static inline void mlock_migrate_page(struct page *newpage, struct page *page)
 {
 	if (TestClearPageMlocked(page)) {
-		int nr_pages = hpage_nr_pages(page);
+		int nr_pages = compound_nr(page);
 
 		/* Holding pmd lock, no change in irq context: __mod is safe */
 		__mod_zone_page_state(page_zone(page), NR_MLOCK, -nr_pages);
@@ -354,7 +354,7 @@ vma_address(struct page *page, struct vm_area_struct *vma)
 	unsigned long start, end;
 
 	start = __vma_address(page, vma);
-	end = start + PAGE_SIZE * (hpage_nr_pages(page) - 1);
+	end = start + page_size(page) - 1;
 
 	/* page should be within @vma mapping range */
 	VM_BUG_ON_VMA(end < vma->vm_start || start >= vma->vm_end, vma);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2156ef775d04..9d457684a731 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5406,7 +5406,7 @@ static int mem_cgroup_move_account(struct page *page,
 				   struct mem_cgroup *to)
 {
 	unsigned long flags;
-	unsigned int nr_pages = compound ? hpage_nr_pages(page) : 1;
+	unsigned int nr_pages = compound ? compound_nr(page) : 1;
 	int ret;
 	bool anon;
 
@@ -6447,7 +6447,7 @@ int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
 			  bool compound)
 {
 	struct mem_cgroup *memcg = NULL;
-	unsigned int nr_pages = compound ? hpage_nr_pages(page) : 1;
+	unsigned int nr_pages = compound ? compound_nr(page) : 1;
 	int ret = 0;
 
 	if (mem_cgroup_disabled())
@@ -6521,7 +6521,7 @@ int mem_cgroup_try_charge_delay(struct page *page, struct mm_struct *mm,
 void mem_cgroup_commit_charge(struct page *page, struct mem_cgroup *memcg,
 			      bool lrucare, bool compound)
 {
-	unsigned int nr_pages = compound ? hpage_nr_pages(page) : 1;
+	unsigned int nr_pages = compound ? compound_nr(page) : 1;
 
 	VM_BUG_ON_PAGE(!page->mapping, page);
 	VM_BUG_ON_PAGE(PageLRU(page) && !lrucare, page);
@@ -6565,7 +6565,7 @@ void mem_cgroup_commit_charge(struct page *page, struct mem_cgroup *memcg,
 void mem_cgroup_cancel_charge(struct page *page, struct mem_cgroup *memcg,
 		bool compound)
 {
-	unsigned int nr_pages = compound ? hpage_nr_pages(page) : 1;
+	unsigned int nr_pages = compound ? compound_nr(page) : 1;
 
 	if (mem_cgroup_disabled())
 		return;
@@ -6772,7 +6772,7 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
 
 	/* Force-charge the new page. The old one will be freed soon */
 	compound = PageTransHuge(newpage);
-	nr_pages = compound ? hpage_nr_pages(newpage) : 1;
+	nr_pages = compound ? compound_nr(newpage) : 1;
 
 	page_counter_charge(&memcg->memory, nr_pages);
 	if (do_memsw_account())
@@ -6995,7 +6995,7 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 	 * ancestor for the swap instead and transfer the memory+swap charge.
 	 */
 	swap_memcg = mem_cgroup_id_get_online(memcg);
-	nr_entries = hpage_nr_pages(page);
+	nr_entries = compound_nr(page);
 	/* Get references for the tail pages, too */
 	if (nr_entries > 1)
 		mem_cgroup_id_get_many(swap_memcg, nr_entries - 1);
@@ -7041,7 +7041,7 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
  */
 int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
 {
-	unsigned int nr_pages = hpage_nr_pages(page);
+	unsigned int nr_pages = compound_nr(page);
 	struct page_counter *counter;
 	struct mem_cgroup *memcg;
 	unsigned short oldid;
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index b1be791f772d..317478203d20 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1344,8 +1344,8 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 			isolate_huge_page(head, &source);
 			continue;
 		} else if (PageTransHuge(page))
-			pfn = page_to_pfn(compound_head(page))
-				+ hpage_nr_pages(page) - 1;
+			pfn = page_to_pfn(compound_head(page)) +
+				compound_nr(page) - 1;
 
 		/*
 		 * HWPoison pages have elevated reference counts so the migration would
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 464406e8da91..586ba2adbfd2 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -978,7 +978,7 @@ static int migrate_page_add(struct page *page, struct list_head *pagelist,
 			list_add_tail(&head->lru, pagelist);
 			mod_node_page_state(page_pgdat(head),
 				NR_ISOLATED_ANON + page_is_file_cache(head),
-				hpage_nr_pages(head));
+				compound_nr(head));
 		} else if (flags & MPOL_MF_STRICT) {
 			/*
 			 * Non-movable page may reach here.  And, there may be
diff --git a/mm/migrate.c b/mm/migrate.c
index 73d476d690b1..c3c9a3e70f07 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -191,8 +191,9 @@ void putback_movable_pages(struct list_head *l)
 			unlock_page(page);
 			put_page(page);
 		} else {
-			mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON +
-					page_is_file_cache(page), -hpage_nr_pages(page));
+			mod_node_page_state(page_pgdat(page),
+				NR_ISOLATED_ANON + page_is_file_cache(page),
+				-compound_nr(page));
 			putback_lru_page(page);
 		}
 	}
@@ -381,7 +382,7 @@ static int expected_page_refs(struct address_space *mapping, struct page *page)
 	 */
 	expected_count += is_device_private_page(page);
 	if (mapping)
-		expected_count += hpage_nr_pages(page) + page_has_private(page);
+		expected_count += compound_nr(page) + page_has_private(page);
 
 	return expected_count;
 }
@@ -436,7 +437,7 @@ int migrate_page_move_mapping(struct address_space *mapping,
 	 */
 	newpage->index = page->index;
 	newpage->mapping = page->mapping;
-	page_ref_add(newpage, hpage_nr_pages(page)); /* add cache reference */
+	page_ref_add(newpage, compound_nr(page)); /* add cache reference */
 	if (PageSwapBacked(page)) {
 		__SetPageSwapBacked(newpage);
 		if (PageSwapCache(page)) {
@@ -469,7 +470,7 @@ int migrate_page_move_mapping(struct address_space *mapping,
 	 * to one less reference.
 	 * We know this isn't the last reference.
 	 */
-	page_ref_unfreeze(page, expected_count - hpage_nr_pages(page));
+	page_ref_unfreeze(page, expected_count - compound_nr(page));
 
 	xas_unlock(&xas);
 	/* Leave irq disabled to prevent preemption while updating stats */
@@ -579,7 +580,7 @@ static void copy_huge_page(struct page *dst, struct page *src)
 	} else {
 		/* thp page */
 		BUG_ON(!PageTransHuge(src));
-		nr_pages = hpage_nr_pages(src);
+		nr_pages = compound_nr(src);
 	}
 
 	for (i = 0; i < nr_pages; i++) {
@@ -1215,7 +1216,7 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
 		 */
 		if (likely(!__PageMovable(page)))
 			mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON +
-					page_is_file_cache(page), -hpage_nr_pages(page));
+					page_is_file_cache(page), -compound_nr(page));
 	}
 
 	/*
@@ -1571,7 +1572,7 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
 		list_add_tail(&head->lru, pagelist);
 		mod_node_page_state(page_pgdat(head),
 			NR_ISOLATED_ANON + page_is_file_cache(head),
-			hpage_nr_pages(head));
+			compound_nr(head));
 	}
 out_putpage:
 	/*
@@ -1912,7 +1913,7 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
 
 	page_lru = page_is_file_cache(page);
 	mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON + page_lru,
-				hpage_nr_pages(page));
+				compound_nr(page));
 
 	/*
 	 * Isolating the page has taken another reference, so the
diff --git a/mm/mlock.c b/mm/mlock.c
index a90099da4fb4..5567d55bf5e1 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -61,8 +61,7 @@ void clear_page_mlock(struct page *page)
 	if (!TestClearPageMlocked(page))
 		return;
 
-	mod_zone_page_state(page_zone(page), NR_MLOCK,
-			    -hpage_nr_pages(page));
+	mod_zone_page_state(page_zone(page), NR_MLOCK, -compound_nr(page));
 	count_vm_event(UNEVICTABLE_PGCLEARED);
 	/*
 	 * The previous TestClearPageMlocked() corresponds to the smp_mb()
@@ -95,7 +94,7 @@ void mlock_vma_page(struct page *page)
 
 	if (!TestSetPageMlocked(page)) {
 		mod_zone_page_state(page_zone(page), NR_MLOCK,
-				    hpage_nr_pages(page));
+				    compound_nr(page));
 		count_vm_event(UNEVICTABLE_PGMLOCKED);
 		if (!isolate_lru_page(page))
 			putback_lru_page(page);
@@ -192,7 +191,7 @@ unsigned int munlock_vma_page(struct page *page)
 	/*
 	 * Serialize with any parallel __split_huge_page_refcount() which
 	 * might otherwise copy PageMlocked to part of the tail pages before
-	 * we clear it in the head page. It also stabilizes hpage_nr_pages().
+	 * we clear it in the head page. It also stabilizes compound_nr().
 	 */
 	spin_lock_irq(&pgdat->lru_lock);
 
@@ -202,7 +201,7 @@ unsigned int munlock_vma_page(struct page *page)
 		goto unlock_out;
 	}
 
-	nr_pages = hpage_nr_pages(page);
+	nr_pages = compound_nr(page);
 	__mod_zone_page_state(page_zone(page), NR_MLOCK, -nr_pages);
 
 	if (__munlock_isolate_lru_page(page, true)) {
diff --git a/mm/page_io.c b/mm/page_io.c
index 24ee600f9131..965fcc5701f8 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -40,7 +40,7 @@ static struct bio *get_swap_bio(gfp_t gfp_flags,
 		bio->bi_iter.bi_sector <<= PAGE_SHIFT - 9;
 		bio->bi_end_io = end_io;
 
-		bio_add_page(bio, page, PAGE_SIZE * hpage_nr_pages(page), 0);
+		bio_add_page(bio, page, page_size(page), 0);
 	}
 	return bio;
 }
@@ -271,7 +271,7 @@ static inline void count_swpout_vm_event(struct page *page)
 	if (unlikely(PageTransHuge(page)))
 		count_vm_event(THP_SWPOUT);
 #endif
-	count_vm_events(PSWPOUT, hpage_nr_pages(page));
+	count_vm_events(PSWPOUT, compound_nr(page));
 }
 
 int __swap_writepage(struct page *page, struct writeback_control *wbc,
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index eff4b4520c8d..dfca512c7b50 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -57,7 +57,7 @@ static inline bool pfn_in_hpage(struct page *hpage, unsigned long pfn)
 	unsigned long hpage_pfn = page_to_pfn(hpage);
 
 	/* THP can be referenced by any subpage */
-	return pfn >= hpage_pfn && pfn - hpage_pfn < hpage_nr_pages(hpage);
+	return (pfn - hpage_pfn) < compound_nr(hpage);
 }
 
 /**
@@ -223,7 +223,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			if (pvmw->address >= pvmw->vma->vm_end ||
 			    pvmw->address >=
 					__vma_address(pvmw->page, pvmw->vma) +
-					hpage_nr_pages(pvmw->page) * PAGE_SIZE)
+					page_size(pvmw->page))
 				return not_found(pvmw);
 			/* Did we cross page table boundary? */
 			if (pvmw->address % PMD_SIZE == 0) {
@@ -264,7 +264,7 @@ int page_mapped_in_vma(struct page *page, struct vm_area_struct *vma)
 	unsigned long start, end;
 
 	start = __vma_address(page, vma);
-	end = start + PAGE_SIZE * (hpage_nr_pages(page) - 1);
+	end = start + page_size(page) - 1;
 
 	if (unlikely(end < vma->vm_start || start >= vma->vm_end))
 		return 0;
diff --git a/mm/rmap.c b/mm/rmap.c
index d9a23bb773bf..2d857283fb41 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1112,7 +1112,7 @@ void do_page_add_anon_rmap(struct page *page,
 	}
 
 	if (first) {
-		int nr = compound ? hpage_nr_pages(page) : 1;
+		int nr = compound ? compound_nr(page) : 1;
 		/*
 		 * We use the irq-unsafe __{inc|mod}_zone_page_stat because
 		 * these counters are not modified in interrupt context, and
@@ -1150,7 +1150,7 @@ void do_page_add_anon_rmap(struct page *page,
 void page_add_new_anon_rmap(struct page *page,
 	struct vm_area_struct *vma, unsigned long address, bool compound)
 {
-	int nr = compound ? hpage_nr_pages(page) : 1;
+	int nr = compound ? compound_nr(page) : 1;
 
 	VM_BUG_ON_VMA(address < vma->vm_start || address >= vma->vm_end, vma);
 	__SetPageSwapBacked(page);
@@ -1826,7 +1826,7 @@ static void rmap_walk_anon(struct page *page, struct rmap_walk_control *rwc,
 		return;
 
 	pgoff_start = page_to_pgoff(page);
-	pgoff_end = pgoff_start + hpage_nr_pages(page) - 1;
+	pgoff_end = pgoff_start + compound_nr(page) - 1;
 	anon_vma_interval_tree_foreach(avc, &anon_vma->rb_root,
 			pgoff_start, pgoff_end) {
 		struct vm_area_struct *vma = avc->vma;
@@ -1879,7 +1879,7 @@ static void rmap_walk_file(struct page *page, struct rmap_walk_control *rwc,
 		return;
 
 	pgoff_start = page_to_pgoff(page);
-	pgoff_end = pgoff_start + hpage_nr_pages(page) - 1;
+	pgoff_end = pgoff_start + compound_nr(page) - 1;
 	if (!locked)
 		i_mmap_lock_read(mapping);
 	vma_interval_tree_foreach(vma, &mapping->i_mmap,
diff --git a/mm/swap.c b/mm/swap.c
index 784dc1620620..25d8c43035a4 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -465,7 +465,7 @@ void lru_cache_add_active_or_unevictable(struct page *page,
 		 * lock is held(spinlock), which implies preemption disabled.
 		 */
 		__mod_zone_page_state(page_zone(page), NR_MLOCK,
-				    hpage_nr_pages(page));
+				    compound_nr(page));
 		count_vm_event(UNEVICTABLE_PGMLOCKED);
 	}
 	lru_cache_add(page);
@@ -558,7 +558,7 @@ static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec,
 		ClearPageSwapBacked(page);
 		add_page_to_lru_list(page, lruvec, LRU_INACTIVE_FILE);
 
-		__count_vm_events(PGLAZYFREE, hpage_nr_pages(page));
+		__count_vm_events(PGLAZYFREE, compound_nr(page));
 		count_memcg_page_event(page, PGLAZYFREE);
 		update_page_reclaim_stat(lruvec, 1, 0);
 	}
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 8e7ce9a9bc5e..51d8884a693a 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -158,7 +158,7 @@ int add_to_swap_cache(struct page *page, swp_entry_t entry, gfp_t gfp)
 void __delete_from_swap_cache(struct page *page, swp_entry_t entry)
 {
 	struct address_space *address_space = swap_address_space(entry);
-	int i, nr = hpage_nr_pages(page);
+	int i, nr = compound_nr(page);
 	pgoff_t idx = swp_offset(entry);
 	XA_STATE(xas, &address_space->i_pages, idx);
 
@@ -251,7 +251,7 @@ void delete_from_swap_cache(struct page *page)
 	xa_unlock_irq(&address_space->i_pages);
 
 	put_swap_page(page, entry);
-	page_ref_sub(page, hpage_nr_pages(page));
+	page_ref_sub(page, compound_nr(page));
 }
 
 /* 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index dab43523afdd..2dc7fbde7d9b 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1331,7 +1331,7 @@ void put_swap_page(struct page *page, swp_entry_t entry)
 	unsigned char *map;
 	unsigned int i, free_entries = 0;
 	unsigned char val;
-	int size = swap_entry_size(hpage_nr_pages(page));
+	int size = swap_entry_size(compound_nr(page));
 
 	si = _swap_info_get(entry);
 	if (!si)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4911754c93b7..a7f9f379e523 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1901,7 +1901,7 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 		SetPageLRU(page);
 		lru = page_lru(page);
 
-		nr_pages = hpage_nr_pages(page);
+		nr_pages = compound_nr(page);
 		update_lru_size(lruvec, lru, page_zonenum(page), nr_pages);
 		list_move(&page->lru, &lruvec->lists[lru]);
 
@@ -2095,7 +2095,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
 
 		if (page_referenced(page, 0, sc->target_mem_cgroup,
 				    &vm_flags)) {
-			nr_rotated += hpage_nr_pages(page);
+			nr_rotated += compound_nr(page);
 			/*
 			 * Identify referenced, file-backed active pages and
 			 * give them one more trip around the active list. So
-- 
2.23.0

