Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68F720E327
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 00:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390343AbgF2VMT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 17:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730162AbgF2S5p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:57:45 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EF7C03078E
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2020 08:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=obbAcrutpbbkhl9xrV2JTPolduttl0+d3NI52M2ElfA=; b=Nf7V4idzWnLImooEIbRSBZlCFd
        rukD3lnOLabseR4vKy+KX4b4u5sLf5HXRqlvunmn7jQ339NcXzNKb8DVn+a1lvZhMMSNQFDGjp1Q/
        t6nVT08ITvjz5sW95Z79QGxtXY99NJNoiijeS6sx3HBRJ7hSdOHywsjxngFPd4UC0+iG5C9UmFlDy
        SFGsOxJzKJljBNqiPHkZG5d6XpGc07Hb3EG70uqjf7Hud48ub6b1Wt5HSYJELAFSC3gRBJAVig6Mn
        YO5NA+kTZ123dbOH9IZoD+kAZigxZrr2oY74/lI6zmyQUqDIEunCpnY75AXEI0+FxeGTLyViZTS4q
        Iojf+uCQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpvZp-0004CT-1o; Mon, 29 Jun 2020 15:20:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 5/7] mm: Replace hpage_nr_pages with thp_nr_pages
Date:   Mon, 29 Jun 2020 16:19:57 +0100
Message-Id: <20200629151959.15779-6-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200629151959.15779-1-willy@infradead.org>
References: <20200629151959.15779-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The thp prefix is more frequently used than hpage and we should
be consistent between the various functions.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/huge_mm.h   | 13 +++++++++----
 include/linux/mm_inline.h |  6 +++---
 include/linux/pagemap.h   |  6 +++---
 mm/compaction.c           |  2 +-
 mm/filemap.c              |  2 +-
 mm/gup.c                  |  2 +-
 mm/hugetlb.c              |  2 +-
 mm/internal.h             |  2 +-
 mm/memcontrol.c           | 10 +++++-----
 mm/memory_hotplug.c       |  7 +++----
 mm/mempolicy.c            |  2 +-
 mm/migrate.c              | 16 ++++++++--------
 mm/mlock.c                |  9 ++++-----
 mm/page_io.c              |  2 +-
 mm/page_vma_mapped.c      |  2 +-
 mm/rmap.c                 |  8 ++++----
 mm/swap.c                 | 16 ++++++++--------
 mm/swap_state.c           |  6 +++---
 mm/swapfile.c             |  2 +-
 mm/vmscan.c               |  6 +++---
 mm/workingset.c           |  6 +++---
 21 files changed, 65 insertions(+), 62 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 0ec3b5a73d38..dcdfd21763a3 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -278,9 +278,14 @@ static inline unsigned int thp_order(struct page *page)
 	return 0;
 }
 
-static inline int hpage_nr_pages(struct page *page)
+/**
+ * thp_nr_pages - The number of regular pages in this huge page.
+ * @page: The head page of a huge page.
+ */
+static inline int thp_nr_pages(struct page *page)
 {
-	if (unlikely(PageTransHuge(page)))
+	VM_BUG_ON_PGFLAGS(PageTail(page), page);
+	if (PageHead(page))
 		return HPAGE_PMD_NR;
 	return 1;
 }
@@ -343,9 +348,9 @@ static inline unsigned int thp_order(struct page *page)
 	return 0;
 }
 
-static inline int hpage_nr_pages(struct page *page)
+static inline int thp_nr_pages(struct page *page)
 {
-	VM_BUG_ON_PAGE(PageTail(page), page);
+	VM_BUG_ON_PGFLAGS(PageTail(page), page);
 	return 1;
 }
 
diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 219bef41d87c..8fc71e9d7bb0 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -48,14 +48,14 @@ static __always_inline void update_lru_size(struct lruvec *lruvec,
 static __always_inline void add_page_to_lru_list(struct page *page,
 				struct lruvec *lruvec, enum lru_list lru)
 {
-	update_lru_size(lruvec, lru, page_zonenum(page), hpage_nr_pages(page));
+	update_lru_size(lruvec, lru, page_zonenum(page), thp_nr_pages(page));
 	list_add(&page->lru, &lruvec->lists[lru]);
 }
 
 static __always_inline void add_page_to_lru_list_tail(struct page *page,
 				struct lruvec *lruvec, enum lru_list lru)
 {
-	update_lru_size(lruvec, lru, page_zonenum(page), hpage_nr_pages(page));
+	update_lru_size(lruvec, lru, page_zonenum(page), thp_nr_pages(page));
 	list_add_tail(&page->lru, &lruvec->lists[lru]);
 }
 
@@ -63,7 +63,7 @@ static __always_inline void del_page_from_lru_list(struct page *page,
 				struct lruvec *lruvec, enum lru_list lru)
 {
 	list_del(&page->lru);
-	update_lru_size(lruvec, lru, page_zonenum(page), -hpage_nr_pages(page));
+	update_lru_size(lruvec, lru, page_zonenum(page), -thp_nr_pages(page));
 }
 
 /**
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index cf2468da68e9..484a36185bb5 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -381,7 +381,7 @@ static inline struct page *find_subpage(struct page *head, pgoff_t index)
 	if (PageHuge(head))
 		return head;
 
-	return head + (index & (hpage_nr_pages(head) - 1));
+	return head + (index & (thp_nr_pages(head) - 1));
 }
 
 struct page *find_get_entry(struct address_space *mapping, pgoff_t offset);
@@ -730,7 +730,7 @@ static inline struct page *readahead_page(struct readahead_control *rac)
 
 	page = xa_load(&rac->mapping->i_pages, rac->_index);
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
-	rac->_batch_count = hpage_nr_pages(page);
+	rac->_batch_count = thp_nr_pages(page);
 
 	return page;
 }
@@ -753,7 +753,7 @@ static inline unsigned int __readahead_batch(struct readahead_control *rac,
 		VM_BUG_ON_PAGE(!PageLocked(page), page);
 		VM_BUG_ON_PAGE(PageTail(page), page);
 		array[i++] = page;
-		rac->_batch_count += hpage_nr_pages(page);
+		rac->_batch_count += thp_nr_pages(page);
 
 		/*
 		 * The page cache isn't using multi-index entries yet,
diff --git a/mm/compaction.c b/mm/compaction.c
index 86375605faa9..014eaea4c56a 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -991,7 +991,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		del_page_from_lru_list(page, lruvec, page_lru(page));
 		mod_node_page_state(page_pgdat(page),
 				NR_ISOLATED_ANON + page_is_file_lru(page),
-				hpage_nr_pages(page));
+				thp_nr_pages(page));
 
 isolate_success:
 		list_add(&page->lru, &cc->migratepages);
diff --git a/mm/filemap.c b/mm/filemap.c
index f0ae9a6308cb..80ce3658b147 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -197,7 +197,7 @@ static void unaccount_page_cache_page(struct address_space *mapping,
 	if (PageHuge(page))
 		return;
 
-	nr = hpage_nr_pages(page);
+	nr = thp_nr_pages(page);
 
 	__mod_lruvec_page_state(page, NR_FILE_PAGES, -nr);
 	if (PageSwapBacked(page)) {
diff --git a/mm/gup.c b/mm/gup.c
index 6f47697f8fb0..5daadae475ea 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1703,7 +1703,7 @@ static long check_and_migrate_cma_pages(struct task_struct *tsk,
 					mod_node_page_state(page_pgdat(head),
 							    NR_ISOLATED_ANON +
 							    page_is_file_lru(head),
-							    hpage_nr_pages(head));
+							    thp_nr_pages(head));
 				}
 			}
 		}
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 57ece74e3aae..6bb07bc655f7 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1593,7 +1593,7 @@ static struct address_space *_get_hugetlb_page_mapping(struct page *hpage)
 
 	/* Use first found vma */
 	pgoff_start = page_to_pgoff(hpage);
-	pgoff_end = pgoff_start + hpage_nr_pages(hpage) - 1;
+	pgoff_end = pgoff_start + thp_nr_pages(hpage) - 1;
 	anon_vma_interval_tree_foreach(avc, &anon_vma->rb_root,
 					pgoff_start, pgoff_end) {
 		struct vm_area_struct *vma = avc->vma;
diff --git a/mm/internal.h b/mm/internal.h
index de9f1d0ba5fc..ac3c79408045 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -368,7 +368,7 @@ extern void clear_page_mlock(struct page *page);
 static inline void mlock_migrate_page(struct page *newpage, struct page *page)
 {
 	if (TestClearPageMlocked(page)) {
-		int nr_pages = hpage_nr_pages(page);
+		int nr_pages = thp_nr_pages(page);
 
 		/* Holding pmd lock, no change in irq context: __mod is safe */
 		__mod_zone_page_state(page_zone(page), NR_MLOCK, -nr_pages);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 19622328e4b5..5136bcae93f4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5365,7 +5365,7 @@ static int mem_cgroup_move_account(struct page *page,
 {
 	struct lruvec *from_vec, *to_vec;
 	struct pglist_data *pgdat;
-	unsigned int nr_pages = compound ? hpage_nr_pages(page) : 1;
+	unsigned int nr_pages = compound ? thp_nr_pages(page) : 1;
 	int ret;
 
 	VM_BUG_ON(from == to);
@@ -6461,7 +6461,7 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
  */
 int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask)
 {
-	unsigned int nr_pages = hpage_nr_pages(page);
+	unsigned int nr_pages = thp_nr_pages(page);
 	struct mem_cgroup *memcg = NULL;
 	int ret = 0;
 
@@ -6692,7 +6692,7 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
 		return;
 
 	/* Force-charge the new page. The old one will be freed soon */
-	nr_pages = hpage_nr_pages(newpage);
+	nr_pages = thp_nr_pages(newpage);
 
 	page_counter_charge(&memcg->memory, nr_pages);
 	if (do_memsw_account())
@@ -6905,7 +6905,7 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 	 * ancestor for the swap instead and transfer the memory+swap charge.
 	 */
 	swap_memcg = mem_cgroup_id_get_online(memcg);
-	nr_entries = hpage_nr_pages(page);
+	nr_entries = thp_nr_pages(page);
 	/* Get references for the tail pages, too */
 	if (nr_entries > 1)
 		mem_cgroup_id_get_many(swap_memcg, nr_entries - 1);
@@ -6950,7 +6950,7 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
  */
 int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
 {
-	unsigned int nr_pages = hpage_nr_pages(page);
+	unsigned int nr_pages = thp_nr_pages(page);
 	struct page_counter *counter;
 	struct mem_cgroup *memcg;
 	unsigned short oldid;
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index da374cd3d45b..4a7ab9de1529 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1280,7 +1280,7 @@ static int
 do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 {
 	unsigned long pfn;
-	struct page *page;
+	struct page *page, *head;
 	int ret = 0;
 	LIST_HEAD(source);
 
@@ -1288,15 +1288,14 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 		if (!pfn_valid(pfn))
 			continue;
 		page = pfn_to_page(pfn);
+		head = compound_head(page);
 
 		if (PageHuge(page)) {
-			struct page *head = compound_head(page);
 			pfn = page_to_pfn(head) + compound_nr(head) - 1;
 			isolate_huge_page(head, &source);
 			continue;
 		} else if (PageTransHuge(page))
-			pfn = page_to_pfn(compound_head(page))
-				+ hpage_nr_pages(page) - 1;
+			pfn = page_to_pfn(head) + thp_nr_pages(page) - 1;
 
 		/*
 		 * HWPoison pages have elevated reference counts so the migration would
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 381320671677..d2b11c291e78 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1049,7 +1049,7 @@ static int migrate_page_add(struct page *page, struct list_head *pagelist,
 			list_add_tail(&head->lru, pagelist);
 			mod_node_page_state(page_pgdat(head),
 				NR_ISOLATED_ANON + page_is_file_lru(head),
-				hpage_nr_pages(head));
+				thp_nr_pages(head));
 		} else if (flags & MPOL_MF_STRICT) {
 			/*
 			 * Non-movable page may reach here.  And, there may be
diff --git a/mm/migrate.c b/mm/migrate.c
index f37729673558..9d0c6a853c1c 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -193,7 +193,7 @@ void putback_movable_pages(struct list_head *l)
 			put_page(page);
 		} else {
 			mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON +
-					page_is_file_lru(page), -hpage_nr_pages(page));
+					page_is_file_lru(page), -thp_nr_pages(page));
 			putback_lru_page(page);
 		}
 	}
@@ -386,7 +386,7 @@ static int expected_page_refs(struct address_space *mapping, struct page *page)
 	 */
 	expected_count += is_device_private_page(page);
 	if (mapping)
-		expected_count += hpage_nr_pages(page) + page_has_private(page);
+		expected_count += thp_nr_pages(page) + page_has_private(page);
 
 	return expected_count;
 }
@@ -441,7 +441,7 @@ int migrate_page_move_mapping(struct address_space *mapping,
 	 */
 	newpage->index = page->index;
 	newpage->mapping = page->mapping;
-	page_ref_add(newpage, hpage_nr_pages(page)); /* add cache reference */
+	page_ref_add(newpage, thp_nr_pages(page)); /* add cache reference */
 	if (PageSwapBacked(page)) {
 		__SetPageSwapBacked(newpage);
 		if (PageSwapCache(page)) {
@@ -474,7 +474,7 @@ int migrate_page_move_mapping(struct address_space *mapping,
 	 * to one less reference.
 	 * We know this isn't the last reference.
 	 */
-	page_ref_unfreeze(page, expected_count - hpage_nr_pages(page));
+	page_ref_unfreeze(page, expected_count - thp_nr_pages(page));
 
 	xas_unlock(&xas);
 	/* Leave irq disabled to prevent preemption while updating stats */
@@ -591,7 +591,7 @@ static void copy_huge_page(struct page *dst, struct page *src)
 	} else {
 		/* thp page */
 		BUG_ON(!PageTransHuge(src));
-		nr_pages = hpage_nr_pages(src);
+		nr_pages = thp_nr_pages(src);
 	}
 
 	for (i = 0; i < nr_pages; i++) {
@@ -1224,7 +1224,7 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
 		 */
 		if (likely(!__PageMovable(page)))
 			mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON +
-					page_is_file_lru(page), -hpage_nr_pages(page));
+					page_is_file_lru(page), -thp_nr_pages(page));
 	}
 
 	/*
@@ -1598,7 +1598,7 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
 		list_add_tail(&head->lru, pagelist);
 		mod_node_page_state(page_pgdat(head),
 			NR_ISOLATED_ANON + page_is_file_lru(head),
-			hpage_nr_pages(head));
+			thp_nr_pages(head));
 	}
 out_putpage:
 	/*
@@ -1962,7 +1962,7 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
 
 	page_lru = page_is_file_lru(page);
 	mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON + page_lru,
-				hpage_nr_pages(page));
+				thp_nr_pages(page));
 
 	/*
 	 * Isolating the page has taken another reference, so the
diff --git a/mm/mlock.c b/mm/mlock.c
index f8736136fad7..93ca2bf30b4f 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -61,8 +61,7 @@ void clear_page_mlock(struct page *page)
 	if (!TestClearPageMlocked(page))
 		return;
 
-	mod_zone_page_state(page_zone(page), NR_MLOCK,
-			    -hpage_nr_pages(page));
+	mod_zone_page_state(page_zone(page), NR_MLOCK, -thp_nr_pages(page));
 	count_vm_event(UNEVICTABLE_PGCLEARED);
 	/*
 	 * The previous TestClearPageMlocked() corresponds to the smp_mb()
@@ -95,7 +94,7 @@ void mlock_vma_page(struct page *page)
 
 	if (!TestSetPageMlocked(page)) {
 		mod_zone_page_state(page_zone(page), NR_MLOCK,
-				    hpage_nr_pages(page));
+				    thp_nr_pages(page));
 		count_vm_event(UNEVICTABLE_PGMLOCKED);
 		if (!isolate_lru_page(page))
 			putback_lru_page(page);
@@ -192,7 +191,7 @@ unsigned int munlock_vma_page(struct page *page)
 	/*
 	 * Serialize with any parallel __split_huge_page_refcount() which
 	 * might otherwise copy PageMlocked to part of the tail pages before
-	 * we clear it in the head page. It also stabilizes hpage_nr_pages().
+	 * we clear it in the head page. It also stabilizes thp_nr_pages().
 	 */
 	spin_lock_irq(&pgdat->lru_lock);
 
@@ -202,7 +201,7 @@ unsigned int munlock_vma_page(struct page *page)
 		goto unlock_out;
 	}
 
-	nr_pages = hpage_nr_pages(page);
+	nr_pages = thp_nr_pages(page);
 	__mod_zone_page_state(page_zone(page), NR_MLOCK, -nr_pages);
 
 	if (__munlock_isolate_lru_page(page, true)) {
diff --git a/mm/page_io.c b/mm/page_io.c
index 888000d1a8cc..77170b7e6f04 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -274,7 +274,7 @@ static inline void count_swpout_vm_event(struct page *page)
 	if (unlikely(PageTransHuge(page)))
 		count_vm_event(THP_SWPOUT);
 #endif
-	count_vm_events(PSWPOUT, hpage_nr_pages(page));
+	count_vm_events(PSWPOUT, thp_nr_pages(page));
 }
 
 int __swap_writepage(struct page *page, struct writeback_control *wbc,
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index e65629c056e8..5e77b269c330 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -61,7 +61,7 @@ static inline bool pfn_is_match(struct page *page, unsigned long pfn)
 		return page_pfn == pfn;
 
 	/* THP can be referenced by any subpage */
-	return pfn >= page_pfn && pfn - page_pfn < hpage_nr_pages(page);
+	return pfn >= page_pfn && pfn - page_pfn < thp_nr_pages(page);
 }
 
 /**
diff --git a/mm/rmap.c b/mm/rmap.c
index 5fe2dedce1fc..c56fab5826c1 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1130,7 +1130,7 @@ void do_page_add_anon_rmap(struct page *page,
 	}
 
 	if (first) {
-		int nr = compound ? hpage_nr_pages(page) : 1;
+		int nr = compound ? thp_nr_pages(page) : 1;
 		/*
 		 * We use the irq-unsafe __{inc|mod}_zone_page_stat because
 		 * these counters are not modified in interrupt context, and
@@ -1169,7 +1169,7 @@ void do_page_add_anon_rmap(struct page *page,
 void page_add_new_anon_rmap(struct page *page,
 	struct vm_area_struct *vma, unsigned long address, bool compound)
 {
-	int nr = compound ? hpage_nr_pages(page) : 1;
+	int nr = compound ? thp_nr_pages(page) : 1;
 
 	VM_BUG_ON_VMA(address < vma->vm_start || address >= vma->vm_end, vma);
 	__SetPageSwapBacked(page);
@@ -1860,7 +1860,7 @@ static void rmap_walk_anon(struct page *page, struct rmap_walk_control *rwc,
 		return;
 
 	pgoff_start = page_to_pgoff(page);
-	pgoff_end = pgoff_start + hpage_nr_pages(page) - 1;
+	pgoff_end = pgoff_start + thp_nr_pages(page) - 1;
 	anon_vma_interval_tree_foreach(avc, &anon_vma->rb_root,
 			pgoff_start, pgoff_end) {
 		struct vm_area_struct *vma = avc->vma;
@@ -1913,7 +1913,7 @@ static void rmap_walk_file(struct page *page, struct rmap_walk_control *rwc,
 		return;
 
 	pgoff_start = page_to_pgoff(page);
-	pgoff_end = pgoff_start + hpage_nr_pages(page) - 1;
+	pgoff_end = pgoff_start + thp_nr_pages(page) - 1;
 	if (!locked)
 		i_mmap_lock_read(mapping);
 	vma_interval_tree_foreach(vma, &mapping->i_mmap,
diff --git a/mm/swap.c b/mm/swap.c
index a82efc33411f..5fb3c36bbdad 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -241,7 +241,7 @@ static void pagevec_move_tail_fn(struct page *page, struct lruvec *lruvec,
 		del_page_from_lru_list(page, lruvec, page_lru(page));
 		ClearPageActive(page);
 		add_page_to_lru_list_tail(page, lruvec, page_lru(page));
-		(*pgmoved) += hpage_nr_pages(page);
+		(*pgmoved) += thp_nr_pages(page);
 	}
 }
 
@@ -312,7 +312,7 @@ void lru_note_cost(struct lruvec *lruvec, bool file, unsigned int nr_pages)
 void lru_note_cost_page(struct page *page)
 {
 	lru_note_cost(mem_cgroup_page_lruvec(page, page_pgdat(page)),
-		      page_is_file_lru(page), hpage_nr_pages(page));
+		      page_is_file_lru(page), thp_nr_pages(page));
 }
 
 static void __activate_page(struct page *page, struct lruvec *lruvec,
@@ -320,7 +320,7 @@ static void __activate_page(struct page *page, struct lruvec *lruvec,
 {
 	if (PageLRU(page) && !PageActive(page) && !PageUnevictable(page)) {
 		int lru = page_lru_base_type(page);
-		int nr_pages = hpage_nr_pages(page);
+		int nr_pages = thp_nr_pages(page);
 
 		del_page_from_lru_list(page, lruvec, lru);
 		SetPageActive(page);
@@ -499,7 +499,7 @@ void lru_cache_add_active_or_unevictable(struct page *page,
 		 * lock is held(spinlock), which implies preemption disabled.
 		 */
 		__mod_zone_page_state(page_zone(page), NR_MLOCK,
-				    hpage_nr_pages(page));
+				    thp_nr_pages(page));
 		count_vm_event(UNEVICTABLE_PGMLOCKED);
 	}
 	lru_cache_add(page);
@@ -531,7 +531,7 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec,
 {
 	int lru;
 	bool active;
-	int nr_pages = hpage_nr_pages(page);
+	int nr_pages = thp_nr_pages(page);
 
 	if (!PageLRU(page))
 		return;
@@ -579,7 +579,7 @@ static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec,
 {
 	if (PageLRU(page) && PageActive(page) && !PageUnevictable(page)) {
 		int lru = page_lru_base_type(page);
-		int nr_pages = hpage_nr_pages(page);
+		int nr_pages = thp_nr_pages(page);
 
 		del_page_from_lru_list(page, lruvec, lru + LRU_ACTIVE);
 		ClearPageActive(page);
@@ -598,7 +598,7 @@ static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec,
 	if (PageLRU(page) && PageAnon(page) && PageSwapBacked(page) &&
 	    !PageSwapCache(page) && !PageUnevictable(page)) {
 		bool active = PageActive(page);
-		int nr_pages = hpage_nr_pages(page);
+		int nr_pages = thp_nr_pages(page);
 
 		del_page_from_lru_list(page, lruvec,
 				       LRU_INACTIVE_ANON + active);
@@ -971,7 +971,7 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
 {
 	enum lru_list lru;
 	int was_unevictable = TestClearPageUnevictable(page);
-	int nr_pages = hpage_nr_pages(page);
+	int nr_pages = thp_nr_pages(page);
 
 	VM_BUG_ON_PAGE(PageLRU(page), page);
 
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 05889e8e3c97..1983be226b1c 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -115,7 +115,7 @@ int add_to_swap_cache(struct page *page, swp_entry_t entry, gfp_t gfp)
 	struct address_space *address_space = swap_address_space(entry);
 	pgoff_t idx = swp_offset(entry);
 	XA_STATE_ORDER(xas, &address_space->i_pages, idx, compound_order(page));
-	unsigned long i, nr = hpage_nr_pages(page);
+	unsigned long i, nr = thp_nr_pages(page);
 
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	VM_BUG_ON_PAGE(PageSwapCache(page), page);
@@ -157,7 +157,7 @@ int add_to_swap_cache(struct page *page, swp_entry_t entry, gfp_t gfp)
 void __delete_from_swap_cache(struct page *page, swp_entry_t entry)
 {
 	struct address_space *address_space = swap_address_space(entry);
-	int i, nr = hpage_nr_pages(page);
+	int i, nr = thp_nr_pages(page);
 	pgoff_t idx = swp_offset(entry);
 	XA_STATE(xas, &address_space->i_pages, idx);
 
@@ -250,7 +250,7 @@ void delete_from_swap_cache(struct page *page)
 	xa_unlock_irq(&address_space->i_pages);
 
 	put_swap_page(page, entry);
-	page_ref_sub(page, hpage_nr_pages(page));
+	page_ref_sub(page, thp_nr_pages(page));
 }
 
 /* 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 987276c557d1..142095774e55 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1368,7 +1368,7 @@ void put_swap_page(struct page *page, swp_entry_t entry)
 	unsigned char *map;
 	unsigned int i, free_entries = 0;
 	unsigned char val;
-	int size = swap_entry_size(hpage_nr_pages(page));
+	int size = swap_entry_size(thp_nr_pages(page));
 
 	si = _swap_info_get(entry);
 	if (!si)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 749d239c62b2..6325003e2f16 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1360,7 +1360,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 			case PAGE_ACTIVATE:
 				goto activate_locked;
 			case PAGE_SUCCESS:
-				stat->nr_pageout += hpage_nr_pages(page);
+				stat->nr_pageout += thp_nr_pages(page);
 
 				if (PageWriteback(page))
 					goto keep;
@@ -1868,7 +1868,7 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 		SetPageLRU(page);
 		lru = page_lru(page);
 
-		nr_pages = hpage_nr_pages(page);
+		nr_pages = thp_nr_pages(page);
 		update_lru_size(lruvec, lru, page_zonenum(page), nr_pages);
 		list_move(&page->lru, &lruvec->lists[lru]);
 
@@ -2070,7 +2070,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
 			 * so we ignore them here.
 			 */
 			if ((vm_flags & VM_EXEC) && page_is_file_lru(page)) {
-				nr_rotated += hpage_nr_pages(page);
+				nr_rotated += thp_nr_pages(page);
 				list_add(&page->lru, &l_active);
 				continue;
 			}
diff --git a/mm/workingset.c b/mm/workingset.c
index 50b7937bab32..fdeabea54e77 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -262,7 +262,7 @@ void *workingset_eviction(struct page *page, struct mem_cgroup *target_memcg)
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 
 	lruvec = mem_cgroup_lruvec(target_memcg, pgdat);
-	workingset_age_nonresident(lruvec, hpage_nr_pages(page));
+	workingset_age_nonresident(lruvec, thp_nr_pages(page));
 	/* XXX: target_memcg can be NULL, go through lruvec */
 	memcgid = mem_cgroup_id(lruvec_memcg(lruvec));
 	eviction = atomic_long_read(&lruvec->nonresident_age);
@@ -365,7 +365,7 @@ void workingset_refault(struct page *page, void *shadow)
 		goto out;
 
 	SetPageActive(page);
-	workingset_age_nonresident(lruvec, hpage_nr_pages(page));
+	workingset_age_nonresident(lruvec, thp_nr_pages(page));
 	inc_lruvec_state(lruvec, WORKINGSET_ACTIVATE);
 
 	/* Page was active prior to eviction */
@@ -402,7 +402,7 @@ void workingset_activation(struct page *page)
 	if (!mem_cgroup_disabled() && !memcg)
 		goto out;
 	lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
-	workingset_age_nonresident(lruvec, hpage_nr_pages(page));
+	workingset_age_nonresident(lruvec, thp_nr_pages(page));
 out:
 	rcu_read_unlock();
 }
-- 
2.27.0

