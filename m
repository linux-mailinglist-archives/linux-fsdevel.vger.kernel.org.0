Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD30175415
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 07:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgCBGs3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 01:48:29 -0500
Received: from foss.arm.com ([217.140.110.172]:56834 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgCBGs3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 01:48:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFB4A106F;
        Sun,  1 Mar 2020 22:48:27 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.1.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 042053F6CF;
        Sun,  1 Mar 2020 22:52:16 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Hugh Dickins <hughd@google.com>, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC 3/3] mm/vma: Introduce some more VMA flag wrappers
Date:   Mon,  2 Mar 2020 12:17:46 +0530
Message-Id: <1583131666-15531-4-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583131666-15531-1-git-send-email-anshuman.khandual@arm.com>
References: <1583131666-15531-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds the following new VMA flag wrappers which will replace current
open encodings across various places. This should not have any functional
implications.

vma_is_dontdump()
vma_is_noreserve()
vma_is_special()
vma_is_locked()
vma_is_mergeable()
vma_is_softdirty()
vma_is_thp()
vma_is_nothp()

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/sparc/include/asm/mman.h |  2 +-
 fs/binfmt_elf.c               |  2 +-
 fs/proc/task_mmu.c            | 14 ++++++-------
 include/linux/huge_mm.h       |  4 ++--
 include/linux/mm.h            | 39 +++++++++++++++++++++++++++++++++++
 kernel/events/core.c          |  2 +-
 kernel/events/uprobes.c       |  2 +-
 mm/gup.c                      |  2 +-
 mm/huge_memory.c              |  6 +++---
 mm/hugetlb.c                  |  4 ++--
 mm/ksm.c                      |  8 +++----
 mm/madvise.c                  |  4 ++--
 mm/memory.c                   |  4 ++--
 mm/migrate.c                  |  4 ++--
 mm/mlock.c                    |  4 ++--
 mm/mmap.c                     | 16 +++++++-------
 mm/mprotect.c                 |  2 +-
 mm/mremap.c                   |  4 ++--
 mm/msync.c                    |  3 +--
 mm/rmap.c                     |  6 +++---
 mm/shmem.c                    |  8 +++----
 21 files changed, 89 insertions(+), 51 deletions(-)

diff --git a/arch/sparc/include/asm/mman.h b/arch/sparc/include/asm/mman.h
index f94532f25db1..661c56add451 100644
--- a/arch/sparc/include/asm/mman.h
+++ b/arch/sparc/include/asm/mman.h
@@ -80,7 +80,7 @@ static inline int sparc_validate_prot(unsigned long prot, unsigned long addr)
 				 * tags on them. Disallow ADI on mergeable
 				 * pages.
 				 */
-				if (vma->vm_flags & VM_MERGEABLE)
+				if (vma_is_mergeable(vma))
 					return 0;
 			}
 		}
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 1eb63867e266..5d41047a4a77 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1305,7 +1305,7 @@ static unsigned long vma_dump_size(struct vm_area_struct *vma,
 	if (always_dump_vma(vma))
 		goto whole;
 
-	if (vma->vm_flags & VM_DONTDUMP)
+	if (vma_is_dontdump(vma))
 		return 0;
 
 	/* support for DAX */
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 3ba9ae83bff5..e425a8cc6c15 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -523,7 +523,7 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 {
 	struct mem_size_stats *mss = walk->private;
 	struct vm_area_struct *vma = walk->vma;
-	bool locked = !!(vma->vm_flags & VM_LOCKED);
+	bool locked = vma_is_locked(vma);
 	struct page *page = NULL;
 
 	if (pte_present(*pte)) {
@@ -575,7 +575,7 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 {
 	struct mem_size_stats *mss = walk->private;
 	struct vm_area_struct *vma = walk->vma;
-	bool locked = !!(vma->vm_flags & VM_LOCKED);
+	bool locked = vma_is_locked(vma);
 	struct page *page;
 
 	/* FOLL_DUMP will return -EFAULT on huge zero page */
@@ -1187,7 +1187,7 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 		tlb_gather_mmu(&tlb, mm, 0, -1);
 		if (type == CLEAR_REFS_SOFT_DIRTY) {
 			for (vma = mm->mmap; vma; vma = vma->vm_next) {
-				if (!(vma->vm_flags & VM_SOFTDIRTY))
+				if (!vma_is_softdirty(vma))
 					continue;
 				up_read(&mm->mmap_sem);
 				if (down_write_killable(&mm->mmap_sem)) {
@@ -1309,7 +1309,7 @@ static int pagemap_pte_hole(unsigned long start, unsigned long end,
 			break;
 
 		/* Addresses in the VMA. */
-		if (vma->vm_flags & VM_SOFTDIRTY)
+		if (vma_is_softdirty(vma))
 			pme = make_pme(0, PM_SOFT_DIRTY);
 		for (; addr < min(end, vma->vm_end); addr += PAGE_SIZE) {
 			err = add_to_pagemap(addr, &pme, pm);
@@ -1354,7 +1354,7 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 		flags |= PM_FILE;
 	if (page && page_mapcount(page) == 1)
 		flags |= PM_MMAP_EXCLUSIVE;
-	if (vma->vm_flags & VM_SOFTDIRTY)
+	if (vma_is_softdirty(vma))
 		flags |= PM_SOFT_DIRTY;
 
 	return make_pme(frame, flags);
@@ -1376,7 +1376,7 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 		pmd_t pmd = *pmdp;
 		struct page *page = NULL;
 
-		if (vma->vm_flags & VM_SOFTDIRTY)
+		if (vma_is_softdirty(vma))
 			flags |= PM_SOFT_DIRTY;
 
 		if (pmd_present(pmd)) {
@@ -1464,7 +1464,7 @@ static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
 	int err = 0;
 	pte_t pte;
 
-	if (vma->vm_flags & VM_SOFTDIRTY)
+	if (vma_is_softdirty(vma))
 		flags |= PM_SOFT_DIRTY;
 
 	pte = huge_ptep_get(ptep);
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 5aca3d1bdb32..e04bd9eef47e 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -97,7 +97,7 @@ extern unsigned long transparent_hugepage_flags;
  */
 static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
 {
-	if (vma->vm_flags & VM_NOHUGEPAGE)
+	if (vma_is_nothp(vma))
 		return false;
 
 	if (is_vma_temporary_stack(vma))
@@ -119,7 +119,7 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
 
 	if (transparent_hugepage_flags &
 				(1 << TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG))
-		return !!(vma->vm_flags & VM_HUGEPAGE);
+		return vma_is_thp(vma);
 
 	return false;
 }
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 525026df1e58..4927e939a51d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -563,6 +563,45 @@ static inline bool vma_is_accessible(struct vm_area_struct *vma)
 	return vma->vm_flags & VM_ACCESS_FLAGS;
 }
 
+static inline bool vma_is_dontdump(struct vm_area_struct *vma)
+{
+	return vma->vm_flags & VM_DONTDUMP;
+}
+
+static inline bool vma_is_noreserve(struct vm_area_struct *vma)
+{
+	return vma->vm_flags & VM_NORESERVE;
+}
+
+static inline bool vma_is_special(struct vm_area_struct *vma)
+{
+	return vma->vm_flags & VM_SPECIAL;
+}
+
+static inline bool vma_is_locked(struct vm_area_struct *vma)
+{
+	return vma->vm_flags & VM_LOCKED;
+}
+
+static inline bool vma_is_thp(struct vm_area_struct *vma)
+{
+	return vma->vm_flags & VM_HUGEPAGE;
+}
+
+static inline bool vma_is_nothp(struct vm_area_struct *vma)
+{
+	return vma->vm_flags & VM_NOHUGEPAGE;
+}
+
+static inline bool vma_is_mergeable(struct vm_area_struct *vma)
+{
+	return vma->vm_flags & VM_MERGEABLE;
+}
+
+static inline bool vma_is_softdirty(struct vm_area_struct *vma)
+{
+	return vma->vm_flags & VM_SOFTDIRTY;
+}
 #ifdef CONFIG_SHMEM
 /*
  * The vma_is_shmem is not inline because it is used only by slow
diff --git a/kernel/events/core.c b/kernel/events/core.c
index ef5be3ed0580..8f7a4b15026a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7692,7 +7692,7 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
 		flags |= MAP_DENYWRITE;
 	if (vma->vm_flags & VM_MAYEXEC)
 		flags |= MAP_EXECUTABLE;
-	if (vma->vm_flags & VM_LOCKED)
+	if (vma_is_locked(vma))
 		flags |= MAP_LOCKED;
 	if (is_vm_hugetlb_page(vma))
 		flags |= MAP_HUGETLB;
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index ece7e13f6e4a..5527098c1912 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -211,7 +211,7 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 		try_to_free_swap(old_page);
 	page_vma_mapped_walk_done(&pvmw);
 
-	if (vma->vm_flags & VM_LOCKED)
+	if (vma_is_locked(vma))
 		munlock_vma_page(old_page);
 	put_page(old_page);
 
diff --git a/mm/gup.c b/mm/gup.c
index 58c8cbfeded6..ca23d23a90f2 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -289,7 +289,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 		 */
 		mark_page_accessed(page);
 	}
-	if ((flags & FOLL_MLOCK) && (vma->vm_flags & VM_LOCKED)) {
+	if ((flags & FOLL_MLOCK) && vma_is_locked(vma)) {
 		/* Do not mlock pte-mapped THP */
 		if (PageTransCompound(page))
 			goto out;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b08b199f9a11..d59ecb872ff2 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -674,7 +674,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
  */
 static inline gfp_t alloc_hugepage_direct_gfpmask(struct vm_area_struct *vma)
 {
-	const bool vma_madvised = !!(vma->vm_flags & VM_HUGEPAGE);
+	const bool vma_madvised = vma_is_thp(vma);
 
 	/* Always do synchronous compaction */
 	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, &transparent_hugepage_flags))
@@ -1499,7 +1499,7 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 	VM_BUG_ON_PAGE(!PageHead(page) && !is_zone_device_page(page), page);
 	if (flags & FOLL_TOUCH)
 		touch_pmd(vma, addr, pmd, flags);
-	if ((flags & FOLL_MLOCK) && (vma->vm_flags & VM_LOCKED)) {
+	if ((flags & FOLL_MLOCK) && vma_is_locked(vma)) {
 		/*
 		 * We don't mlock() pte-mapped THPs. This way we can avoid
 		 * leaking mlocked pages into non-VM_LOCKED VMAs.
@@ -3082,7 +3082,7 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 	else
 		page_add_file_rmap(new, true);
 	set_pmd_at(mm, mmun_start, pvmw->pmd, pmde);
-	if ((vma->vm_flags & VM_LOCKED) && !PageDoubleMap(new))
+	if (vma_is_locked(vma) && !PageDoubleMap(new))
 		mlock_vma_page(new);
 	update_mmu_cache_pmd(vma, address, pvmw->pmd);
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index dd8737a94bec..efe40f533224 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -757,7 +757,7 @@ void reset_vma_resv_huge_pages(struct vm_area_struct *vma)
 /* Returns true if the VMA has associated reserve pages */
 static bool vma_has_reserves(struct vm_area_struct *vma, long chg)
 {
-	if (vma->vm_flags & VM_NORESERVE) {
+	if (vma_is_noreserve(vma)) {
 		/*
 		 * This address is already reserved by other process(chg == 0),
 		 * so, we should decrement reserved count. Without decrementing,
@@ -4558,7 +4558,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 	 * attempt will be made for VM_NORESERVE to allocate a page
 	 * without using reserves
 	 */
-	if (vm_flags & VM_NORESERVE)
+	if (vma_is_noreserve(vma))
 		return 0;
 
 	/*
diff --git a/mm/ksm.c b/mm/ksm.c
index d17c7d57d0d8..8bf11a543c27 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -525,7 +525,7 @@ static struct vm_area_struct *find_mergeable_vma(struct mm_struct *mm,
 	vma = find_vma(mm, addr);
 	if (!vma || vma->vm_start > addr)
 		return NULL;
-	if (!(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
+	if (!vma_is_mergeable(vma) || !vma->anon_vma)
 		return NULL;
 	return vma;
 }
@@ -980,7 +980,7 @@ static int unmerge_and_remove_all_rmap_items(void)
 		for (vma = mm->mmap; vma; vma = vma->vm_next) {
 			if (ksm_test_exit(mm))
 				break;
-			if (!(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
+			if (!vma_is_mergeable(vma) || !vma->anon_vma)
 				continue;
 			err = unmerge_ksm_pages(vma,
 						vma->vm_start, vma->vm_end);
@@ -1251,7 +1251,7 @@ static int try_to_merge_one_page(struct vm_area_struct *vma,
 			err = replace_page(vma, page, kpage, orig_pte);
 	}
 
-	if ((vma->vm_flags & VM_LOCKED) && kpage && !err) {
+	if (vma_is_locked(vma) && kpage && !err) {
 		munlock_vma_page(page);
 		if (!PageMlocked(kpage)) {
 			unlock_page(page);
@@ -2284,7 +2284,7 @@ static struct rmap_item *scan_get_next_rmap_item(struct page **page)
 		vma = find_vma(mm, ksm_scan.address);
 
 	for (; vma; vma = vma->vm_next) {
-		if (!(vma->vm_flags & VM_MERGEABLE))
+		if (!vma_is_mergeable(vma))
 			continue;
 		if (ksm_scan.address < vma->vm_start)
 			ksm_scan.address = vma->vm_start;
diff --git a/mm/madvise.c b/mm/madvise.c
index 43b47d3fae02..ffd6a4ff4c99 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -106,7 +106,7 @@ static long madvise_behavior(struct vm_area_struct *vma,
 		new_flags |= VM_DONTDUMP;
 		break;
 	case MADV_DODUMP:
-		if (!is_vm_hugetlb_page(vma) && new_flags & VM_SPECIAL) {
+		if (!is_vm_hugetlb_page(vma) && vma_is_special(vma)) {
 			error = -EINVAL;
 			goto out;
 		}
@@ -821,7 +821,7 @@ static long madvise_remove(struct vm_area_struct *vma,
 
 	*prev = NULL;	/* tell sys_madvise we drop mmap_sem */
 
-	if (vma->vm_flags & VM_LOCKED)
+	if (vma_is_locked(vma))
 		return -EINVAL;
 
 	f = vma->vm_file;
diff --git a/mm/memory.c b/mm/memory.c
index 2f07747612b7..c45386dae91b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2604,7 +2604,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		 * Don't let another task, with possibly unlocked vma,
 		 * keep the mlocked page.
 		 */
-		if (page_copied && (vma->vm_flags & VM_LOCKED)) {
+		if (page_copied && vma_is_locked(vma)) {
 			lock_page(old_page);	/* LRU manipulation */
 			if (PageMlocked(old_page))
 				munlock_vma_page(old_page);
@@ -3083,7 +3083,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 
 	swap_free(entry);
 	if (mem_cgroup_swap_full(page) ||
-	    (vma->vm_flags & VM_LOCKED) || PageMlocked(page))
+	    vma_is_locked(vma) || PageMlocked(page))
 		try_to_free_swap(page);
 	unlock_page(page);
 	if (page != swapcache && swapcache) {
diff --git a/mm/migrate.c b/mm/migrate.c
index b1092876e537..45ac5b750e77 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -270,7 +270,7 @@ static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
 			else
 				page_add_file_rmap(new, false);
 		}
-		if (vma->vm_flags & VM_LOCKED && !PageTransCompound(new))
+		if (vma_is_locked(vma) && !PageTransCompound(new))
 			mlock_vma_page(new);
 
 		if (PageTransHuge(page) && PageMlocked(page))
@@ -2664,7 +2664,7 @@ int migrate_vma_setup(struct migrate_vma *args)
 	args->start &= PAGE_MASK;
 	args->end &= PAGE_MASK;
 	if (!args->vma || is_vm_hugetlb_page(args->vma) ||
-	    (args->vma->vm_flags & VM_SPECIAL) || vma_is_dax(args->vma))
+	    (vma_is_special(args->vma) || vma_is_dax(args->vma))
 		return -EINVAL;
 	if (nr_pages <= 0)
 		return -EINVAL;
diff --git a/mm/mlock.c b/mm/mlock.c
index a72c1eeded77..3d4f66f2dee9 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -526,7 +526,7 @@ static int mlock_fixup(struct vm_area_struct *vma, struct vm_area_struct **prev,
 	int lock = !!(newflags & VM_LOCKED);
 	vm_flags_t old_flags = vma->vm_flags;
 
-	if (newflags == vma->vm_flags || (vma->vm_flags & VM_SPECIAL) ||
+	if (newflags == vma->vm_flags || vma_is_special(vma) ||
 	    is_vm_hugetlb_page(vma) || vma == get_gate_vma(current->mm) ||
 	    vma_is_dax(vma))
 		/* don't set VM_LOCKED or VM_LOCKONFAULT and don't count */
@@ -654,7 +654,7 @@ static unsigned long count_mm_mlocked_page_nr(struct mm_struct *mm,
 			continue;
 		if (start + len <=  vma->vm_start)
 			break;
-		if (vma->vm_flags & VM_LOCKED) {
+		if (vma_is_locked(vma)) {
 			if (start > vma->vm_start)
 				count -= (start - vma->vm_start);
 			if (start + len < vma->vm_end) {
diff --git a/mm/mmap.c b/mm/mmap.c
index f9a01763857b..c93cad8aa9ac 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2279,7 +2279,7 @@ static int acct_stack_growth(struct vm_area_struct *vma,
 		return -ENOMEM;
 
 	/* mlock limit tests */
-	if (vma->vm_flags & VM_LOCKED) {
+	if (vma_is_locked(vma)) {
 		unsigned long locked;
 		unsigned long limit;
 		locked = mm->locked_vm + grow;
@@ -2374,7 +2374,7 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 				 * against concurrent vma expansions.
 				 */
 				spin_lock(&mm->page_table_lock);
-				if (vma->vm_flags & VM_LOCKED)
+				if (vma_is_locked(vma))
 					mm->locked_vm += grow;
 				vm_stat_account(mm, vma->vm_flags, grow);
 				anon_vma_interval_tree_pre_update_vma(vma);
@@ -2454,7 +2454,7 @@ int expand_downwards(struct vm_area_struct *vma,
 				 * against concurrent vma expansions.
 				 */
 				spin_lock(&mm->page_table_lock);
-				if (vma->vm_flags & VM_LOCKED)
+				if (vma_is_locked(vma))
 					mm->locked_vm += grow;
 				vm_stat_account(mm, vma->vm_flags, grow);
 				anon_vma_interval_tree_pre_update_vma(vma);
@@ -2508,7 +2508,7 @@ find_extend_vma(struct mm_struct *mm, unsigned long addr)
 	/* don't alter vm_end if the coredump is running */
 	if (!prev || !mmget_still_valid(mm) || expand_stack(prev, addr))
 		return NULL;
-	if (prev->vm_flags & VM_LOCKED)
+	if (vma_is_locked(prev))
 		populate_vma_page_range(prev, addr, prev->vm_end, NULL);
 	return prev;
 }
@@ -2538,7 +2538,7 @@ find_extend_vma(struct mm_struct *mm, unsigned long addr)
 	start = vma->vm_start;
 	if (expand_stack(vma, addr))
 		return NULL;
-	if (vma->vm_flags & VM_LOCKED)
+	if (vma_is_locked(vma))
 		populate_vma_page_range(vma, addr, start, NULL);
 	return vma;
 }
@@ -2790,7 +2790,7 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	if (mm->locked_vm) {
 		struct vm_area_struct *tmp = vma;
 		while (tmp && tmp->vm_start < end) {
-			if (tmp->vm_flags & VM_LOCKED) {
+			if (vma_is_locked(tmp)) {
 				mm->locked_vm -= vma_pages(tmp);
 				munlock_vma_pages_all(tmp);
 			}
@@ -2925,7 +2925,7 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 
 	flags &= MAP_NONBLOCK;
 	flags |= MAP_SHARED | MAP_FIXED | MAP_POPULATE;
-	if (vma->vm_flags & VM_LOCKED) {
+	if (vma_is_locked(vma)) {
 		struct vm_area_struct *tmp;
 		flags |= MAP_LOCKED;
 
@@ -3105,7 +3105,7 @@ void exit_mmap(struct mm_struct *mm)
 	if (mm->locked_vm) {
 		vma = mm->mmap;
 		while (vma) {
-			if (vma->vm_flags & VM_LOCKED)
+			if (vma_is_locked(vma))
 				munlock_vma_pages_all(vma);
 			vma = vma->vm_next;
 		}
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 4921a4211c6b..d7d4629979fc 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -117,7 +117,7 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 			/* Avoid taking write faults for known dirty pages */
 			if (dirty_accountable && pte_dirty(ptent) &&
 					(pte_soft_dirty(ptent) ||
-					 !(vma->vm_flags & VM_SOFTDIRTY))) {
+					 !vma_is_softdirty(vma))) {
 				ptent = pte_mkwrite(ptent);
 			}
 			ptep_modify_prot_commit(vma, addr, pte, oldpte, ptent);
diff --git a/mm/mremap.c b/mm/mremap.c
index af363063ea23..25d5ecbb783f 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -472,7 +472,7 @@ static struct vm_area_struct *vma_to_resize(unsigned long addr,
 	if (vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP))
 		return ERR_PTR(-EFAULT);
 
-	if (vma->vm_flags & VM_LOCKED) {
+	if (vma_is_locked(vma)) {
 		unsigned long locked, lock_limit;
 		locked = mm->locked_vm << PAGE_SHIFT;
 		lock_limit = rlimit(RLIMIT_MEMLOCK);
@@ -681,7 +681,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 			}
 
 			vm_stat_account(mm, vma->vm_flags, pages);
-			if (vma->vm_flags & VM_LOCKED) {
+			if (vma_is_locked(vma)) {
 				mm->locked_vm += pages;
 				locked = true;
 				new_addr = addr;
diff --git a/mm/msync.c b/mm/msync.c
index c3bd3e75f687..e02327f8ccca 100644
--- a/mm/msync.c
+++ b/mm/msync.c
@@ -75,8 +75,7 @@ SYSCALL_DEFINE3(msync, unsigned long, start, size_t, len, int, flags)
 			unmapped_error = -ENOMEM;
 		}
 		/* Here vma->vm_start <= start < vma->vm_end. */
-		if ((flags & MS_INVALIDATE) &&
-				(vma->vm_flags & VM_LOCKED)) {
+		if ((flags & MS_INVALIDATE) && vma_is_locked(vma)) {
 			error = -EBUSY;
 			goto out_unlock;
 		}
diff --git a/mm/rmap.c b/mm/rmap.c
index b3e381919835..b7941238aea9 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -785,7 +785,7 @@ static bool page_referenced_one(struct page *page, struct vm_area_struct *vma,
 	while (page_vma_mapped_walk(&pvmw)) {
 		address = pvmw.address;
 
-		if (vma->vm_flags & VM_LOCKED) {
+		if (vma_is_locked(vma)) {
 			page_vma_mapped_walk_done(&pvmw);
 			pra->vm_flags |= VM_LOCKED;
 			return false; /* To break the loop */
@@ -1379,7 +1379,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 	enum ttu_flags flags = (enum ttu_flags)arg;
 
 	/* munlock has nothing to gain from examining un-locked vmas */
-	if ((flags & TTU_MUNLOCK) && !(vma->vm_flags & VM_LOCKED))
+	if ((flags & TTU_MUNLOCK) && !vma_is_locked(vma))
 		return true;
 
 	if (IS_ENABLED(CONFIG_MIGRATION) && (flags & TTU_MIGRATION) &&
@@ -1429,7 +1429,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 		 * skipped over this mm) then we should reactivate it.
 		 */
 		if (!(flags & TTU_IGNORE_MLOCK)) {
-			if (vma->vm_flags & VM_LOCKED) {
+			if (vma_is_locked(vma)) {
 				/* PTE-mapped THP are never mlocked */
 				if (!PageTransCompound(page)) {
 					/*
diff --git a/mm/shmem.c b/mm/shmem.c
index aad3ba74b0e9..23fb58bb1e94 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2058,10 +2058,10 @@ static vm_fault_t shmem_fault(struct vm_fault *vmf)
 
 	sgp = SGP_CACHE;
 
-	if ((vma->vm_flags & VM_NOHUGEPAGE) ||
+	if (vma_is_nothp(vma) ||
 	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
 		sgp = SGP_NOHUGE;
-	else if (vma->vm_flags & VM_HUGEPAGE)
+	else if (vma_is_thp(vma))
 		sgp = SGP_HUGE;
 
 	err = shmem_getpage_gfp(inode, vmf->pgoff, &vmf->page, sgp,
@@ -3986,7 +3986,7 @@ bool shmem_huge_enabled(struct vm_area_struct *vma)
 	loff_t i_size;
 	pgoff_t off;
 
-	if ((vma->vm_flags & VM_NOHUGEPAGE) ||
+	if (vma_is_nothp(vma) ||
 	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
 		return false;
 	if (shmem_huge == SHMEM_HUGE_FORCE)
@@ -4007,7 +4007,7 @@ bool shmem_huge_enabled(struct vm_area_struct *vma)
 			/* fall through */
 		case SHMEM_HUGE_ADVISE:
 			/* TODO: implement fadvise() hints */
-			return (vma->vm_flags & VM_HUGEPAGE);
+			return (vma_is_thp(vma));
 		default:
 			VM_BUG_ON(1);
 			return false;
-- 
2.20.1

