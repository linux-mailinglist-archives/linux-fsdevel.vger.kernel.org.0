Return-Path: <linux-fsdevel+bounces-3159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2417F07E4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 17:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA542B20A1A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 16:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C351218033;
	Sun, 19 Nov 2023 16:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id B58BE171C;
	Sun, 19 Nov 2023 08:59:19 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6B291476;
	Sun, 19 Nov 2023 09:00:05 -0800 (PST)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98F883F6C4;
	Sun, 19 Nov 2023 08:59:14 -0800 (PST)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	oliver.upton@linux.dev,
	maz@kernel.org,
	james.morse@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	arnd@arndb.de,
	akpm@linux-foundation.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	mhiramat@kernel.org,
	rppt@kernel.org,
	hughd@google.com
Cc: pcc@google.com,
	steven.price@arm.com,
	anshuman.khandual@arm.com,
	vincenzo.frascino@arm.com,
	david@redhat.com,
	eugenis@google.com,
	kcc@google.com,
	hyesoo.yu@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH RFC v2 19/27] mm: mprotect: Introduce PAGE_FAULT_ON_ACCESS for mprotect(PROT_MTE)
Date: Sun, 19 Nov 2023 16:57:13 +0000
Message-Id: <20231119165721.9849-20-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231119165721.9849-1-alexandru.elisei@arm.com>
References: <20231119165721.9849-1-alexandru.elisei@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To enable tagging on a memory range, userspace can use mprotect() with the
PROT_MTE access flag. Pages already mapped in the VMA don't have the
associated tag storage block reserved, so mark the PTEs as
PAGE_FAULT_ON_ACCESS to trigger a fault next time they are accessed, and
reserve the tag storage on the fault path.

This has several benefits over reserving the tag storage as part of the
mprotect() call handling:

- Tag storage is reserved only for those pages in the VMA that are
  accessed, instead of for all the pages already mapped in the VMA.
- Reduces the latency of the mprotect() call.
- Eliminates races with page migration.

But all of this is at the expense of an extra page fault per page until the
pages being accessed all have their corresponding tag storage reserved.

For arm64, the PAGE_FAULT_ON_ACCESS protection is created by defining a new
page table entry software bit, PTE_TAG_STORAGE_NONE. Linux doesn't set any
of the PBHA bits in entries from the last level of the translation table
and it doesn't use the TCR_ELx.HWUxx bits; also, the first PBHA bit, bit
59, is already being used as a software bit for PMD_PRESENT_INVALID.

This is only implemented for PTE mappings; PMD mappings will follow.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/Kconfig                       |   1 +
 arch/arm64/include/asm/mte.h             |   4 +-
 arch/arm64/include/asm/mte_tag_storage.h |   2 +
 arch/arm64/include/asm/pgtable-prot.h    |   2 +
 arch/arm64/include/asm/pgtable.h         |  40 ++++++---
 arch/arm64/kernel/mte.c                  |  12 ++-
 arch/arm64/mm/fault.c                    | 101 +++++++++++++++++++++++
 include/linux/pgtable.h                  |  17 ++++
 mm/Kconfig                               |   3 +
 mm/memory.c                              |   3 +
 10 files changed, 170 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index efa5b7958169..3b9c435eaafb 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2066,6 +2066,7 @@ if ARM64_MTE
 config ARM64_MTE_TAG_STORAGE
 	bool "Dynamic MTE tag storage management"
 	depends on ARCH_KEEP_MEMBLOCK
+	select ARCH_HAS_FAULT_ON_ACCESS
 	select CONFIG_CMA
 	help
 	  Adds support for dynamic management of the memory used by the hardware
diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
index 6457b7899207..70dc2e409070 100644
--- a/arch/arm64/include/asm/mte.h
+++ b/arch/arm64/include/asm/mte.h
@@ -107,7 +107,7 @@ static inline bool try_page_mte_tagging(struct page *page)
 }
 
 void mte_zero_clear_page_tags(void *addr);
-void mte_sync_tags(pte_t pte, unsigned int nr_pages);
+void mte_sync_tags(pte_t *pteval, unsigned int nr_pages);
 void mte_copy_page_tags(void *kto, const void *kfrom);
 void mte_thread_init_user(void);
 void mte_thread_switch(struct task_struct *next);
@@ -139,7 +139,7 @@ static inline bool try_page_mte_tagging(struct page *page)
 static inline void mte_zero_clear_page_tags(void *addr)
 {
 }
-static inline void mte_sync_tags(pte_t pte, unsigned int nr_pages)
+static inline void mte_sync_tags(pte_t *pteval, unsigned int nr_pages)
 {
 }
 static inline void mte_copy_page_tags(void *kto, const void *kfrom)
diff --git a/arch/arm64/include/asm/mte_tag_storage.h b/arch/arm64/include/asm/mte_tag_storage.h
index 6e5d28e607bb..c70ced60a0cd 100644
--- a/arch/arm64/include/asm/mte_tag_storage.h
+++ b/arch/arm64/include/asm/mte_tag_storage.h
@@ -33,6 +33,8 @@ int reserve_tag_storage(struct page *page, int order, gfp_t gfp);
 void free_tag_storage(struct page *page, int order);
 
 bool page_tag_storage_reserved(struct page *page);
+
+vm_fault_t handle_page_missing_tag_storage(struct vm_fault *vmf);
 #else
 static inline bool tag_storage_enabled(void)
 {
diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index e9624f6326dd..85ebb3e352ad 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -19,6 +19,7 @@
 #define PTE_SPECIAL		(_AT(pteval_t, 1) << 56)
 #define PTE_DEVMAP		(_AT(pteval_t, 1) << 57)
 #define PTE_PROT_NONE		(_AT(pteval_t, 1) << 58) /* only when !PTE_VALID */
+#define PTE_TAG_STORAGE_NONE	(_AT(pteval_t, 1) << 60) /* only when PTE_PROT_NONE */
 
 /*
  * This bit indicates that the entry is present i.e. pmd_page()
@@ -94,6 +95,7 @@ extern bool arm64_use_ng_mappings;
 	 })
 
 #define PAGE_NONE		__pgprot(((_PAGE_DEFAULT) & ~PTE_VALID) | PTE_PROT_NONE | PTE_RDONLY | PTE_NG | PTE_PXN | PTE_UXN)
+#define PAGE_FAULT_ON_ACCESS	__pgprot(((_PAGE_DEFAULT) & ~PTE_VALID) | PTE_PROT_NONE | PTE_TAG_STORAGE_NONE | PTE_RDONLY | PTE_NG | PTE_PXN | PTE_UXN)
 /* shared+writable pages are clean by default, hence PTE_RDONLY|PTE_WRITE */
 #define PAGE_SHARED		__pgprot(_PAGE_SHARED)
 #define PAGE_SHARED_EXEC	__pgprot(_PAGE_SHARED_EXEC)
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 20e8de853f5d..8cc135f1c112 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -326,10 +326,10 @@ static inline void __check_safe_pte_update(struct mm_struct *mm, pte_t *ptep,
 		     __func__, pte_val(old_pte), pte_val(pte));
 }
 
-static inline void __sync_cache_and_tags(pte_t pte, unsigned int nr_pages)
+static inline void __sync_cache_and_tags(pte_t *pteval, unsigned int nr_pages)
 {
-	if (pte_present(pte) && pte_user_exec(pte) && !pte_special(pte))
-		__sync_icache_dcache(pte);
+	if (pte_present(*pteval) && pte_user_exec(*pteval) && !pte_special(*pteval))
+		__sync_icache_dcache(*pteval);
 
 	/*
 	 * If the PTE would provide user space access to the tags associated
@@ -337,9 +337,9 @@ static inline void __sync_cache_and_tags(pte_t pte, unsigned int nr_pages)
 	 * pte_access_permitted() returns false for exec only mappings, they
 	 * don't expose tags (instruction fetches don't check tags).
 	 */
-	if (system_supports_mte() && pte_access_permitted(pte, false) &&
-	    !pte_special(pte) && pte_tagged(pte))
-		mte_sync_tags(pte, nr_pages);
+	if (system_supports_mte() && pte_access_permitted(*pteval, false) &&
+	    !pte_special(*pteval) && pte_tagged(*pteval))
+		mte_sync_tags(pteval, nr_pages);
 }
 
 static inline void set_ptes(struct mm_struct *mm,
@@ -347,7 +347,7 @@ static inline void set_ptes(struct mm_struct *mm,
 			    pte_t *ptep, pte_t pte, unsigned int nr)
 {
 	page_table_check_ptes_set(mm, ptep, pte, nr);
-	__sync_cache_and_tags(pte, nr);
+	__sync_cache_and_tags(&pte, nr);
 
 	for (;;) {
 		__check_safe_pte_update(mm, ptep, pte);
@@ -459,6 +459,26 @@ static inline int pmd_protnone(pmd_t pmd)
 }
 #endif
 
+#ifdef CONFIG_ARCH_HAS_FAULT_ON_ACCESS
+static inline bool fault_on_access_pte(pte_t pte)
+{
+	return (pte_val(pte) & (PTE_PROT_NONE | PTE_TAG_STORAGE_NONE | PTE_VALID)) ==
+		(PTE_PROT_NONE | PTE_TAG_STORAGE_NONE);
+}
+
+static inline bool fault_on_access_pmd(pmd_t pmd)
+{
+	return fault_on_access_pte(pmd_pte(pmd));
+}
+
+static inline vm_fault_t arch_do_page_fault_on_access(struct vm_fault *vmf)
+{
+	if (tag_storage_enabled())
+		return handle_page_missing_tag_storage(vmf);
+	return VM_FAULT_SIGBUS;
+}
+#endif /* CONFIG_ARCH_HAS_FAULT_ON_ACCESS */
+
 #define pmd_present_invalid(pmd)     (!!(pmd_val(pmd) & PMD_PRESENT_INVALID))
 
 static inline int pmd_present(pmd_t pmd)
@@ -533,7 +553,7 @@ static inline void __set_pte_at(struct mm_struct *mm,
 				unsigned long __always_unused addr,
 				pte_t *ptep, pte_t pte, unsigned int nr)
 {
-	__sync_cache_and_tags(pte, nr);
+	__sync_cache_and_tags(&pte, nr);
 	__check_safe_pte_update(mm, ptep, pte);
 	set_pte(ptep, pte);
 }
@@ -828,8 +848,8 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 	 * in MAIR_EL1. The mask below has to include PTE_ATTRINDX_MASK.
 	 */
 	const pteval_t mask = PTE_USER | PTE_PXN | PTE_UXN | PTE_RDONLY |
-			      PTE_PROT_NONE | PTE_VALID | PTE_WRITE | PTE_GP |
-			      PTE_ATTRINDX_MASK;
+			      PTE_PROT_NONE | PTE_TAG_STORAGE_NONE | PTE_VALID |
+			      PTE_WRITE | PTE_GP | PTE_ATTRINDX_MASK;
 	/* preserve the hardware dirty information */
 	if (pte_hw_dirty(pte))
 		pte = set_pte_bit(pte, __pgprot(PTE_DIRTY));
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index a41ef3213e1e..5962bab1d549 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -21,6 +21,7 @@
 #include <asm/barrier.h>
 #include <asm/cpufeature.h>
 #include <asm/mte.h>
+#include <asm/mte_tag_storage.h>
 #include <asm/ptrace.h>
 #include <asm/sysreg.h>
 
@@ -35,13 +36,18 @@ DEFINE_STATIC_KEY_FALSE(mte_async_or_asymm_mode);
 EXPORT_SYMBOL_GPL(mte_async_or_asymm_mode);
 #endif
 
-void mte_sync_tags(pte_t pte, unsigned int nr_pages)
+void mte_sync_tags(pte_t *pteval, unsigned int nr_pages)
 {
-	struct page *page = pte_page(pte);
+	struct page *page = pte_page(*pteval);
 	unsigned int i;
 
-	/* if PG_mte_tagged is set, tags have already been initialised */
 	for (i = 0; i < nr_pages; i++, page++) {
+		if (tag_storage_enabled() && unlikely(!page_tag_storage_reserved(page))) {
+			*pteval = pte_modify(*pteval, PAGE_FAULT_ON_ACCESS);
+			continue;
+		}
+
+		/* if PG_mte_tagged is set, tags have already been initialised */
 		if (try_page_mte_tagging(page)) {
 			mte_clear_page_tags(page_address(page));
 			set_page_mte_tagged(page);
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index acbc7530d2b2..f5fa583acf18 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -19,6 +19,7 @@
 #include <linux/kprobes.h>
 #include <linux/uaccess.h>
 #include <linux/page-flags.h>
+#include <linux/page-isolation.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/debug.h>
 #include <linux/highmem.h>
@@ -953,3 +954,103 @@ void tag_clear_highpage(struct page *page)
 	mte_zero_clear_page_tags(page_address(page));
 	set_page_mte_tagged(page);
 }
+
+#ifdef CONFIG_ARM64_MTE_TAG_STORAGE
+vm_fault_t handle_page_missing_tag_storage(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct page *page = NULL;
+	pte_t new_pte, old_pte;
+	bool writable = false;
+	vm_fault_t err;
+	int ret;
+
+	spin_lock(vmf->ptl);
+	if (unlikely(!pte_same(*vmf->pte, vmf->orig_pte))) {
+		pte_unmap_unlock(vmf->pte, vmf->ptl);
+		return 0;
+	}
+
+	/* Get the normal PTE  */
+	old_pte = ptep_get(vmf->pte);
+	new_pte = pte_modify(old_pte, vma->vm_page_prot);
+
+	/*
+	 * Detect now whether the PTE could be writable; this information
+	 * is only valid while holding the PT lock.
+	 */
+	writable = pte_write(new_pte);
+	if (!writable && vma_wants_manual_pte_write_upgrade(vma) &&
+	    can_change_pte_writable(vma, vmf->address, new_pte))
+		writable = true;
+
+	page = vm_normal_page(vma, vmf->address, new_pte);
+	if (!page || is_zone_device_page(page))
+		goto out_map;
+
+	/*
+	 * This should never happen, once a VMA has been marked as tagged, that
+	 * cannot be changed.
+	 */
+	if (!(vma->vm_flags & VM_MTE))
+		goto out_map;
+
+	/* Prevent the page from being unmapped from under us. */
+	get_page(page);
+	vma_set_access_pid_bit(vma);
+
+	/*
+	 * Pairs with pte_offset_map_nolock(), which takes the RCU read lock,
+	 * and spin_lock() above which takes the ptl lock. Both locks should be
+	 * balanced after this point.
+	 */
+	pte_unmap_unlock(vmf->pte, vmf->ptl);
+
+	/*
+	 * Probably the page is being isolated for migration, replay the fault
+	 * to give time for the entry to be replaced by a migration pte.
+	 */
+	if (unlikely(is_migrate_isolate_page(page)))
+		goto out_retry;
+
+	ret = reserve_tag_storage(page, 0, GFP_HIGHUSER_MOVABLE);
+	if (ret)
+		goto out_retry;
+
+	put_page(page);
+
+	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address, &vmf->ptl);
+	if (unlikely(!pte_same(*vmf->pte, vmf->orig_pte))) {
+		pte_unmap_unlock(vmf->pte, vmf->ptl);
+		return 0;
+	}
+
+out_map:
+	/*
+	 * Make it present again, depending on how arch implements
+	 * non-accessible ptes, some can allow access by kernel mode.
+	 */
+	old_pte = ptep_modify_prot_start(vma, vmf->address, vmf->pte);
+	new_pte = pte_modify(old_pte, vma->vm_page_prot);
+	new_pte = pte_mkyoung(new_pte);
+	if (writable)
+		new_pte = pte_mkwrite(new_pte, vma);
+	ptep_modify_prot_commit(vma, vmf->address, vmf->pte, old_pte, new_pte);
+	update_mmu_cache(vma, vmf->address, vmf->pte);
+	pte_unmap_unlock(vmf->pte, vmf->ptl);
+
+	return 0;
+
+out_retry:
+	put_page(page);
+	if (vmf->flags & FAULT_FLAG_VMA_LOCK)
+		vma_end_read(vma);
+	if (fault_flag_allow_retry_first(vmf->flags)) {
+		err = VM_FAULT_RETRY;
+	} else {
+		/* Replay the fault. */
+		err = 0;
+	}
+	return err;
+}
+#endif
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index ffdb9b6bed6c..e2c761dd6c41 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1458,6 +1458,23 @@ static inline int pmd_protnone(pmd_t pmd)
 }
 #endif /* CONFIG_NUMA_BALANCING */
 
+#ifndef CONFIG_ARCH_HAS_FAULT_ON_ACCESS
+static inline bool fault_on_access_pte(pte_t pte)
+{
+	return false;
+}
+
+static inline bool fault_on_access_pmd(pmd_t pmd)
+{
+	return false;
+}
+
+static inline vm_fault_t arch_do_page_fault_on_access(struct vm_fault *vmf)
+{
+	return VM_FAULT_SIGBUS;
+}
+#endif
+
 #endif /* CONFIG_MMU */
 
 #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
diff --git a/mm/Kconfig b/mm/Kconfig
index 89971a894b60..a90eefc3ee80 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1019,6 +1019,9 @@ config IDLE_PAGE_TRACKING
 config ARCH_HAS_CACHE_LINE_SIZE
 	bool
 
+config ARCH_HAS_FAULT_ON_ACCESS
+	bool
+
 config ARCH_HAS_CURRENT_STACK_POINTER
 	bool
 	help
diff --git a/mm/memory.c b/mm/memory.c
index e137f7673749..a04a971200b9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5044,6 +5044,9 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 	if (!pte_present(vmf->orig_pte))
 		return do_swap_page(vmf);
 
+	if (fault_on_access_pte(vmf->orig_pte) && vma_is_accessible(vmf->vma))
+		return arch_do_page_fault_on_access(vmf);
+
 	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma))
 		return do_numa_page(vmf);
 
-- 
2.42.1


