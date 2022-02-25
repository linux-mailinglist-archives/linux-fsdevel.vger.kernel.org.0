Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F8C4C3E75
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 07:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237877AbiBYGhj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Feb 2022 01:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237873AbiBYGhh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Feb 2022 01:37:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5131CB7149;
        Thu, 24 Feb 2022 22:37:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5EDFB82B1F;
        Fri, 25 Feb 2022 06:37:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE40FC340E7;
        Fri, 25 Feb 2022 06:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1645771022;
        bh=4MmorLgF84ZySrVFNvm9JGkl40hv/866KGjpYHRoaMk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IZG561ZvYZp17yt4j7BwPoeb2TjCCIhYV6yKxnNGceyAZKiGp1Bf4LA9SVj1teF16
         3qtw+HaD4VAokkiWXFMoM7qdvOy+VEk8jqFEnAToYdgiKH4vrAh9l+fWRvlvJZd07p
         4b7m1EYjQFU2TDWiafDyEEy8sJSAsKz8ka5LLKxM=
Date:   Thu, 24 Feb 2022 22:37:01 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     mhocko@suse.cz, sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: Re: mmotm 2022-02-23-21-20 uploaded
Message-Id: <20220224223701.4dd5245b08feb3e85a1be718@linux-foundation.org>
In-Reply-To: <Yhg60P06ksKTjddP@sirena.org.uk>
References: <20220224052137.BFB10C340E9@smtp.kernel.org>
        <20220223212416.c957b713f5f8823f9b8e0a8d@linux-foundation.org>
        <Yhg60P06ksKTjddP@sirena.org.uk>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 25 Feb 2022 02:11:28 +0000 Mark Brown <broonie@kernel.org> wrote:

> On Wed, Feb 23, 2022 at 09:24:16PM -0800, Andrew Morton wrote:
> > On Wed, 23 Feb 2022 21:21:36 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:
> > 
> > > The mm-of-the-moment snapshot 2022-02-23-21-20 has been uploaded to
> > > 
> > >    https://www.ozlabs.org/~akpm/mmotm/
> > > 
> > 
> > Below is how I resolved the fallout from jamming today's linux-next
> > back on top of the MM queue.
> 
> Thanks, this was enormously helpful

Cool.

> (there's a bunch of embarrassing
> merge fixups in the tree today, but they're all driver error with me fat
> fingering the scripts).

Things got worse with the appearance of Maple tree.  Mainly in
kernel/fork.c.

Conflict with Andrey's big "kasan, vmalloc, arm64: add vmalloc tagging
support for SW/HW_TAGS" series.  I moved this series to be staged
behind linux-next and fixed things up.

My alloc_thread_stack_node) needs checking please (below).

And today's fix-all-the-rejects patch is below that.

I'll upload all this in 2 secs...




static int alloc_thread_stack_node(struct task_struct *tsk, int node)
{
	struct vm_struct *vm;
	void *stack;
	int i;

	for (i = 0; i < NR_CACHED_STACKS; i++) {
		struct vm_struct *s;

		s = this_cpu_xchg(cached_stacks[i], NULL);

		if (!s)
			continue;

		/* Reset stack metadata. */
		kasan_unpoison_range(s->addr, THREAD_SIZE);

		stack = kasan_reset_tag(s->addr);

		/* Clear stale pointers from reused stack. */
		memset(stack, 0, THREAD_SIZE);

		if (memcg_charge_kernel_stack(s)) {
			vfree(s->addr);
			return -ENOMEM;
		}

		tsk->stack_vm_area = s;
		tsk->stack = stack;
		return 0;
	}

	/*
	 * Allocated stacks are cached and later reused by new threads,
	 * so memcg accounting is performed manually on assigning/releasing
	 * stacks to tasks. Drop __GFP_ACCOUNT.
	 */
	stack = __vmalloc_node_range(THREAD_SIZE, THREAD_ALIGN,
				     VMALLOC_START, VMALLOC_END,
				     THREADINFO_GFP & ~__GFP_ACCOUNT,
				     PAGE_KERNEL,
				     0, node, __builtin_return_address(0));
	if (!stack)
		return -ENOMEM;

	vm = find_vm_area(stack);
	if (memcg_charge_kernel_stack(vm)) {
		vfree(stack);
		return -ENOMEM;
	}
	/*
	 * We can't call find_vm_area() in interrupt context, and
	 * free_thread_stack() can be called in interrupt context,
	 * so cache the vm_struct.
	 */
	tsk->stack_vm_area = vm;
	if (stack)
		stack = kasan_reset_tag(stack);
	tsk->stack = stack;
	return 0;
}



 Documentation/admin-guide/sysctl/kernel.rst |   50 ------------------
 kernel/fork.c                               |    1 
 lib/Kconfig.debug                           |    1 
 mm/huge_memory.c                            |    4 -
 mm/memcontrol.c                             |    2 
 mm/memory-failure.c                         |    4 -
 mm/memory.c                                 |    2 
 mm/memremap.c                               |   11 ---
 mm/mmap.c                                   |   26 ++++++---
 mm/rmap.c                                   |   30 +++++-----
 mm/vmscan.c                                 |    8 +-
 tools/include/linux/gfp.h                   |    3 -
 tools/testing/radix-tree/linux/gfp.h        |   32 -----------
 13 files changed, 45 insertions(+), 129 deletions(-)

--- a/Documentation/admin-guide/sysctl/kernel.rst~linux-next-rejects
+++ a/Documentation/admin-guide/sysctl/kernel.rst
@@ -616,55 +616,7 @@ being accessed should be migrated to a l
 The unmapping of pages and trapping faults incur additional overhead that
 ideally is offset by improved memory locality but there is no universal
 guarantee. If the target workload is already bound to NUMA nodes then this
-feature should be disabled. Otherwise, if the system overhead from the
-feature is too high then the rate the kernel samples for NUMA hinting
-faults may be controlled by the `numa_balancing_scan_period_min_ms,
-numa_balancing_scan_delay_ms, numa_balancing_scan_period_max_ms,
-numa_balancing_scan_size_mb`_, and numa_balancing_settle_count sysctls.
-
-Or NUMA_BALANCING_MEMORY_TIERING to optimize page placement among
-different types of memory (represented as different NUMA nodes) to
-place the hot pages in the fast memory.  This is implemented based on
-unmapping and page fault too.
-
-numa_balancing_scan_period_min_ms, numa_balancing_scan_delay_ms, numa_balancing_scan_period_max_ms, numa_balancing_scan_size_mb
-===============================================================================================================================
-
-
-Automatic NUMA balancing scans tasks address space and unmaps pages to
-detect if pages are properly placed or if the data should be migrated to a
-memory node local to where the task is running.  Every "scan delay" the task
-scans the next "scan size" number of pages in its address space. When the
-end of the address space is reached the scanner restarts from the beginning.
-
-In combination, the "scan delay" and "scan size" determine the scan rate.
-When "scan delay" decreases, the scan rate increases.  The scan delay and
-hence the scan rate of every task is adaptive and depends on historical
-behaviour. If pages are properly placed then the scan delay increases,
-otherwise the scan delay decreases.  The "scan size" is not adaptive but
-the higher the "scan size", the higher the scan rate.
-
-Higher scan rates incur higher system overhead as page faults must be
-trapped and potentially data must be migrated. However, the higher the scan
-rate, the more quickly a tasks memory is migrated to a local node if the
-workload pattern changes and minimises performance impact due to remote
-memory accesses. These sysctls control the thresholds for scan delays and
-the number of pages scanned.
-
-``numa_balancing_scan_period_min_ms`` is the minimum time in milliseconds to
-scan a tasks virtual memory. It effectively controls the maximum scanning
-rate for each task.
-
-``numa_balancing_scan_delay_ms`` is the starting "scan delay" used for a task
-when it initially forks.
-
-``numa_balancing_scan_period_max_ms`` is the maximum time in milliseconds to
-scan a tasks virtual memory. It effectively controls the minimum scanning
-rate for each task.
-
-``numa_balancing_scan_size_mb`` is how many megabytes worth of pages are
-scanned for a given scan.
-
+feature should be disabled.
 
 oops_all_cpu_backtrace
 ======================
--- a/lib/Kconfig.debug~linux-next-rejects
+++ a/lib/Kconfig.debug
@@ -275,6 +275,7 @@ config DEBUG_INFO_DWARF5
 	bool "Generate DWARF Version 5 debuginfo"
 	select DEBUG_INFO
 	depends on !CC_IS_CLANG || (CC_IS_CLANG && (AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)))
+	depends on PAHOLE_VERSION >= 121
 	help
 	  Generate DWARF v5 debug info. Requires binutils 2.35.2, gcc 5.0+ (gcc
 	  5.0+ accepts the -gdwarf-5 flag but only had partial support for some
--- a/mm/huge_memory.c~linux-next-rejects
+++ a/mm/huge_memory.c
@@ -3164,10 +3164,8 @@ void remove_migration_pmd(struct page_vm
 	if (PageAnon(new))
 		page_add_anon_rmap(new, vma, mmun_start, true);
 	else
-		page_add_file_rmap(new, true);
+		page_add_file_rmap(new, vma, true);
 	set_pmd_at(mm, mmun_start, pvmw->pmd, pmde);
-	if ((vma->vm_flags & VM_LOCKED) && !PageDoubleMap(new))
-		mlock_vma_page(new);
 
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache_pmd(vma, address, pvmw->pmd);
--- a/mm/memcontrol.c~linux-next-rejects
+++ a/mm/memcontrol.c
@@ -7210,7 +7210,7 @@ void mem_cgroup_swapout(struct folio *fo
 	memcg_stats_lock();
 	mem_cgroup_charge_statistics(memcg, -nr_entries);
 	memcg_stats_unlock();
-	memcg_check_events(memcg, page_to_nid(page));
+	memcg_check_events(memcg, folio_nid(folio));
 
 	css_put(&memcg->css);
 }
--- a/mm/memory.c~linux-next-rejects
+++ a/mm/memory.c
@@ -1414,7 +1414,7 @@ again:
 				continue;
 			rss[mm_counter(page)]--;
 			if (is_device_private_entry(entry))
-				page_remove_rmap(page, false);
+				page_remove_rmap(page, vma, false);
 			put_page(page);
 		} else if (!non_swap_entry(entry)) {
 			/* Genuine swap entry, hence a private anon page */
--- a/mm/memory-failure.c~linux-next-rejects
+++ a/mm/memory-failure.c
@@ -1416,12 +1416,12 @@ static bool hwpoison_user_mappings(struc
 		 */
 		mapping = hugetlb_page_mapping_lock_write(hpage);
 		if (mapping) {
-				try_to_unmap(folio, ttu|TTU_RMAP_LOCKED);
+			try_to_unmap(folio, ttu|TTU_RMAP_LOCKED);
 			i_mmap_unlock_write(mapping);
 		} else
 			pr_info("Memory failure: %#lx: could not lock mapping for mapped huge page\n", pfn);
 	} else {
-			try_to_unmap(folio, ttu);
+		try_to_unmap(folio, ttu);
 	}
 
 	unmap_success = !page_mapped(hpage);
--- a/mm/memremap.c~linux-next-rejects
+++ a/mm/memremap.c
@@ -101,13 +101,6 @@ static unsigned long pfn_end(struct dev_
 	return (range->start + range_len(range)) >> PAGE_SHIFT;
 }
 
-static unsigned long pfn_next(struct dev_pagemap *pgmap, unsigned long pfn)
-{
-	if (pfn % (1024 << pgmap->vmemmap_shift))
-		cond_resched();
-	return pfn + pgmap_vmemmap_nr(pgmap);
-}
-
 static unsigned long pfn_len(struct dev_pagemap *pgmap, unsigned long range_id)
 {
 	return (pfn_end(pgmap, range_id) -
@@ -134,10 +127,6 @@ bool pfn_zone_device_reserved(unsigned l
 	return ret;
 }
 
-#define for_each_device_pfn(pfn, map, i) \
-	for (pfn = pfn_first(map, i); pfn < pfn_end(map, i); \
-	     pfn = pfn_next(map, pfn))
-
 static void pageunmap_range(struct dev_pagemap *pgmap, int range_id)
 {
 	struct range *range = &pgmap->ranges[range_id];
--- a/mm/rmap.c~linux-next-rejects
+++ a/mm/rmap.c
@@ -1526,22 +1526,22 @@ static bool try_to_unmap_one(struct foli
 			pteval = ptep_clear_flush(vma, address, pvmw.pte);
 		}
 
-		/* Move the dirty bit to the page. Now the pte is gone. */
+		/* Set the dirty flag on the folio now the pte is gone. */
 		if (pte_dirty(pteval))
-			set_page_dirty(page);
+			folio_mark_dirty(folio);
 
 		/* Update high watermark before we lower rss */
 		update_hiwater_rss(mm);
 
 		if (PageHWPoison(subpage) && !(flags & TTU_IGNORE_HWPOISON)) {
 			pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
-			if (PageHuge(page)) {
-				hugetlb_count_sub(compound_nr(page), mm);
+			if (folio_test_hugetlb(folio)) {
+				hugetlb_count_sub(folio_nr_pages(folio), mm);
 				set_huge_swap_pte_at(mm, address,
 						     pvmw.pte, pteval,
 						     vma_mmu_pagesize(vma));
 			} else {
-				dec_mm_counter(mm, mm_counter(page));
+				dec_mm_counter(mm, mm_counter(&folio->page));
 				set_pte_at(mm, address, pvmw.pte, pteval);
 			}
 
@@ -1579,7 +1579,7 @@ static bool try_to_unmap_one(struct foli
 			}
 
 			/* MADV_FREE page check */
-			if (!PageSwapBacked(page)) {
+			if (!folio_test_swapbacked(folio)) {
 				int ref_count, map_count;
 
 				/*
@@ -1589,8 +1589,8 @@ static bool try_to_unmap_one(struct foli
 				 */
 				smp_mb();
 
-				ref_count = page_count(page);
-				map_count = page_mapcount(page);
+				ref_count = folio_ref_count(folio);
+				map_count = folio_mapcount(folio);
 
 				/*
 				 * Order reads for page refcount and dirty flag;
@@ -1603,7 +1603,7 @@ static bool try_to_unmap_one(struct foli
 				 * plus one or more rmap's (dropped by discard:).
 				 */
 				if ((ref_count == 1 + map_count) &&
-				    !PageDirty(page)) {
+				    !folio_test_dirty(folio)) {
 					/* Invalidate as we cleared the pte */
 					mmu_notifier_invalidate_range(mm,
 						address, address + PAGE_SIZE);
@@ -1867,7 +1867,7 @@ static bool try_to_migrate_one(struct fo
 				swp_pte = pte_swp_mkuffd_wp(swp_pte);
 			set_pte_at(mm, pvmw.address, pvmw.pte, swp_pte);
 			trace_set_migration_pte(pvmw.address, pte_val(swp_pte),
-						compound_order(page));
+						folio_order(folio));
 			/*
 			 * No need to invalidate here it will synchronize on
 			 * against the special swap migration pte.
@@ -1879,16 +1879,16 @@ static bool try_to_migrate_one(struct fo
 			 * changed when hugepage migrations to device private
 			 * memory are supported.
 			 */
-			subpage = page;
+			subpage = &folio->page;
 		} else if (PageHWPoison(subpage)) {
 			pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
-			if (PageHuge(page)) {
-				hugetlb_count_sub(compound_nr(page), mm);
+			if (folio_test_hugetlb(folio)) {
+				hugetlb_count_sub(folio_nr_pages(folio), mm);
 				set_huge_swap_pte_at(mm, address,
 						     pvmw.pte, pteval,
 						     vma_mmu_pagesize(vma));
 			} else {
-				dec_mm_counter(mm, mm_counter(page));
+				dec_mm_counter(mm, mm_counter(&folio->page));
 				set_pte_at(mm, address, pvmw.pte, pteval);
 			}
 
@@ -1937,7 +1937,7 @@ static bool try_to_migrate_one(struct fo
 				swp_pte = pte_swp_mkuffd_wp(swp_pte);
 			set_pte_at(mm, address, pvmw.pte, swp_pte);
 			trace_set_migration_pte(address, pte_val(swp_pte),
-						compound_order(page));
+						folio_order(folio));
 			/*
 			 * No need to invalidate here it will synchronize on
 			 * against the special swap migration pte.
--- a/mm/vmscan.c~linux-next-rejects
+++ a/mm/vmscan.c
@@ -1575,7 +1575,7 @@ retry:
 		 */
 		mapping = page_mapping(page);
 		if (writeback && PageReclaim(page))
-			stat->nr_congested++;
+			stat->nr_congested += nr_pages;
 
 		/*
 		 * If a page at the tail of the LRU is under writeback, there
@@ -1724,9 +1724,9 @@ retry:
 				/* Adding to swap updated mapping */
 				mapping = page_mapping(page);
 			}
-		} else if (unlikely(PageTransHuge(page))) {
-			/* Split file/lazyfree THP */
-			if (split_huge_page_to_list(page, page_list))
+		} else if (PageSwapBacked(page) && PageTransHuge(page)) {
+			/* Split shmem THP */
+			if (split_folio_to_list(folio, page_list))
 				goto keep_locked;
 		}
 
--- a/tools/include/linux/gfp.h~linux-next-rejects
+++ a/tools/include/linux/gfp.h
@@ -12,7 +12,6 @@
 #define __GFP_FS		0x80u
 #define __GFP_NOWARN		0x200u
 #define __GFP_ZERO		0x8000u
-#define __GFP_ATOMIC		0x80000u
 #define __GFP_ACCOUNT		0x100000u
 #define __GFP_DIRECT_RECLAIM	0x400000u
 #define __GFP_KSWAPD_RECLAIM	0x2000000u
@@ -20,7 +19,7 @@
 #define __GFP_RECLAIM	(__GFP_DIRECT_RECLAIM | __GFP_KSWAPD_RECLAIM)
 
 #define GFP_ZONEMASK	0x0fu
-#define GFP_ATOMIC	(__GFP_HIGH | __GFP_ATOMIC | __GFP_KSWAPD_RECLAIM)
+#define GFP_ATOMIC	(__GFP_HIGH | __GFP_KSWAPD_RECLAIM)
 #define GFP_KERNEL	(__GFP_RECLAIM | __GFP_IO | __GFP_FS)
 #define GFP_NOWAIT	(__GFP_KSWAPD_RECLAIM)
 
--- a/tools/testing/radix-tree/linux/gfp.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _GFP_H
-#define _GFP_H
-
-#include <linux/types.h>
-
-#define __GFP_BITS_SHIFT 26
-#define __GFP_BITS_MASK ((gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
-
-#define __GFP_HIGH		0x20u
-#define __GFP_IO		0x40u
-#define __GFP_FS		0x80u
-#define __GFP_NOWARN		0x200u
-#define __GFP_ZERO		0x8000u
-#define __GFP_ACCOUNT		0x100000u
-#define __GFP_DIRECT_RECLAIM	0x400000u
-#define __GFP_KSWAPD_RECLAIM	0x2000000u
-
-#define __GFP_RECLAIM	(__GFP_DIRECT_RECLAIM|__GFP_KSWAPD_RECLAIM)
-
-#define GFP_ZONEMASK	0x0fu
-#define GFP_ATOMIC	(__GFP_HIGH|__GFP_KSWAPD_RECLAIM)
-#define GFP_KERNEL	(__GFP_RECLAIM | __GFP_IO | __GFP_FS)
-#define GFP_NOWAIT	(__GFP_KSWAPD_RECLAIM)
-
-
-static inline bool gfpflags_allow_blocking(const gfp_t gfp_flags)
-{
-	return !!(gfp_flags & __GFP_DIRECT_RECLAIM);
-}
-
-#endif
--- a/kernel/fork.c~linux-next-rejects
+++ a/kernel/fork.c
@@ -471,7 +471,6 @@ struct vm_area_struct *vm_area_dup(struc
 		 */
 		*new = data_race(*orig);
 		INIT_LIST_HEAD(&new->anon_vma_chain);
-		new->vm_next = new->vm_prev = NULL;
 		dup_anon_vma_name(orig, new);
 	}
 	return new;
--- a/mm/mmap.c~linux-next-rejects
+++ a/mm/mmap.c
@@ -3104,19 +3104,29 @@ void exit_mmap(struct mm_struct *mm)
 	tlb_gather_mmu_fullmm(&tlb, mm);
 	/* update_hiwater_rss(mm) here? but nobody should be looking */
 	/* Use -1 here to ensure all VMAs in the mm are unmapped */
-	unmap_vmas(&tlb, vma, 0, -1);
-	free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
+	unmap_vmas(&tlb, &mm->mm_mt, vma, 0, ULONG_MAX);
+	free_pgtables(&tlb, &mm->mm_mt, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
 	tlb_finish_mmu(&tlb);
 
-	/* Walk the list again, actually closing and freeing it. */
-	while (vma) {
+	/*
+	 * Walk the list again, actually closing and freeing it, with preemption
+	 * enabled, without holding any MM locks besides the unreachable
+	 * mmap_write_lock.
+	 */
+	do {
 		if (vma->vm_flags & VM_ACCOUNT)
 			nr_accounted += vma_pages(vma);
-		vma = remove_vma(vma);
+		remove_vma(vma);
+		count++;
 		cond_resched();
-	}
-	mm->mmap = NULL;
-	mmap_write_unlock(mm);
+	} while ((vma = mas_find(&mas, ULONG_MAX)) != NULL);
+
+	BUG_ON(count != mm->map_count);
+
+	trace_exit_mmap(mm);
+	__mt_destroy(&mm->mm_mt);
+	rwsem_release(&mm->mmap_lock.dep_map, _THIS_IP_);
+
 	vm_unacct_memory(nr_accounted);
 }
 
_

