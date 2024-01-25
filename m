Return-Path: <linux-fsdevel+bounces-8969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8B783C8C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 17:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FBF21C22187
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 16:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6CD1419B3;
	Thu, 25 Jan 2024 16:45:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2538135A6E;
	Thu, 25 Jan 2024 16:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201119; cv=none; b=sXd9ZKkXqyHDF6U9R3USuj3gE64hoog+q0BjUEl0b5ECTpqFO/JtuCclu6UQUiM919GZrS3g3Itp7eyKftWx3qJa3N19UoJUT6uEHtPB4Ljomao0GrZK7A7o8lOB/MetSYqdRRgIapptWrrP+gF5LFocjP8P+TrcKFUTAUSOElc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201119; c=relaxed/simple;
	bh=yrV/PL50Fxqf8cU3j9yTwERB+yL3VyhYhYMOfE4BEmk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fniKpNhb4LA7mHM/zUMBjeHdmHB95e2s1kTxPMJfnfyawgwHZP1E9xX5dt/P0fEhi/f+yT/H2dxktxTLaZdydeXp5OJ5EyOix/OS5U0uI7k0shnR3xN+13KwwzjAjBFNRd9Ks+dKPJL4rFl2qHiPW8vyTHoyL33cBSCgImwxbmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD7CA169E;
	Thu, 25 Jan 2024 08:46:01 -0800 (PST)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5BA33F5A1;
	Thu, 25 Jan 2024 08:45:11 -0800 (PST)
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
Subject: [PATCH RFC v3 26/35] arm64: mte: Use fault-on-access to reserve missing tag storage
Date: Thu, 25 Jan 2024 16:42:47 +0000
Message-Id: <20240125164256.4147-27-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125164256.4147-1-alexandru.elisei@arm.com>
References: <20240125164256.4147-1-alexandru.elisei@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are three situations in which a page that is to be mapped as
tagged doesn't have the corresponding tag storage reserved:

* reserve_tag_storage() failed.

* The allocation didn't specifiy __GFP_TAGGED (this can happen during
  migration, for example).

* The page was mapped in a non-MTE enabled VMA, then an mprotect(PROT_MTE)
  enabled MTE.

If a page that is about to be mapped as tagged doesn't have tag storage
reserved, map it with the PAGE_FAULT_ON_ACCESS protection to trigger a
fault next time they are accessed, and then reserve tag storage when the
fault is handled. If tag storage cannot be reserved, then the page is
migrated out of the VMA.

Tag storage pages (which cannot be tagged) mapped in an MTE enabled MTE
will be handled in a subsequent patch.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---

Changes since rfc v2:

* New patch, loosely based on the arm64 code from the rfc v2 patch  #19 ("mm:
mprotect: Introduce PAGE_FAULT_ON_ACCESS for mprotect(PROT_MTE)")
* All the common code has been moved back to the arch independent function
handle_{huge_pmd,pte}_protnone() (David Hildenbrand).
* Page is migrated if tag storage cannot be reserved after exhausting all
attempts (Hyesoo Yu).
* Moved folio_isolate_lru() declaration and struct migration_target_control to
headers in include/linux (Peter Collingbourne).

 arch/arm64/Kconfig                       |  1 +
 arch/arm64/include/asm/mte.h             |  4 +-
 arch/arm64/include/asm/mte_tag_storage.h |  3 +
 arch/arm64/include/asm/pgtable-prot.h    |  2 +
 arch/arm64/include/asm/pgtable.h         | 44 ++++++++---
 arch/arm64/kernel/mte.c                  | 11 ++-
 arch/arm64/mm/fault.c                    | 98 ++++++++++++++++++++++++
 include/linux/memcontrol.h               |  2 +
 include/linux/migrate.h                  |  8 +-
 include/linux/migrate_mode.h             |  1 +
 mm/internal.h                            |  6 --
 11 files changed, 156 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6f65e9005dc9..088e30fc6d12 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2085,6 +2085,7 @@ config ARM64_MTE
 if ARM64_MTE
 config ARM64_MTE_TAG_STORAGE
 	bool
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
index 423b19e0cc46..6d0f6ffcfdd6 100644
--- a/arch/arm64/include/asm/mte_tag_storage.h
+++ b/arch/arm64/include/asm/mte_tag_storage.h
@@ -32,6 +32,9 @@ int reserve_tag_storage(struct page *page, int order, gfp_t gfp);
 void free_tag_storage(struct page *page, int order);
 
 bool page_tag_storage_reserved(struct page *page);
+
+vm_fault_t handle_folio_missing_tag_storage(struct folio *folio, struct vm_fault *vmf,
+					    bool *map_pte);
 #else
 static inline bool tag_storage_enabled(void)
 {
diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index 483dbfa39c4c..1820e29244f8 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -19,6 +19,7 @@
 #define PTE_SPECIAL		(_AT(pteval_t, 1) << 56)
 #define PTE_DEVMAP		(_AT(pteval_t, 1) << 57)
 #define PTE_PROT_NONE		(_AT(pteval_t, 1) << 58) /* only when !PTE_VALID */
+#define PTE_TAG_STORAGE_NONE	(_AT(pteval_t, 1) << 60) /* only when PTE_PROT_NONE */
 
 /*
  * This bit indicates that the entry is present i.e. pmd_page()
@@ -96,6 +97,7 @@ extern bool arm64_use_ng_mappings;
 	 })
 
 #define PAGE_NONE		__pgprot(((_PAGE_DEFAULT) & ~PTE_VALID) | PTE_PROT_NONE | PTE_RDONLY | PTE_NG | PTE_PXN | PTE_UXN)
+#define PAGE_FAULT_ON_ACCESS	__pgprot(((_PAGE_DEFAULT) & ~PTE_VALID) | PTE_PROT_NONE | PTE_TAG_STORAGE_NONE | PTE_RDONLY | PTE_NG | PTE_PXN | PTE_UXN)
 /* shared+writable pages are clean by default, hence PTE_RDONLY|PTE_WRITE */
 #define PAGE_SHARED		__pgprot(_PAGE_SHARED)
 #define PAGE_SHARED_EXEC	__pgprot(_PAGE_SHARED_EXEC)
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index f30466199a9b..0174e292f890 100644
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
@@ -444,7 +444,7 @@ static inline pgprot_t pte_pgprot(pte_t pte)
 	return __pgprot(pte_val(pfn_pte(pfn, __pgprot(0))) ^ pte_val(pte));
 }
 
-#ifdef CONFIG_NUMA_BALANCING
+#if defined(CONFIG_NUMA_BALANCING) || defined(CONFIG_ARCH_HAS_FAULT_ON_ACCESS)
 /*
  * See the comment in include/linux/pgtable.h
  */
@@ -459,6 +459,28 @@ static inline int pmd_protnone(pmd_t pmd)
 }
 #endif
 
+#ifdef CONFIG_ARCH_HAS_FAULT_ON_ACCESS
+static inline bool arch_fault_on_access_pte(pte_t pte)
+{
+	return pte_protnone(pte) && (pte_val(pte) & PTE_TAG_STORAGE_NONE);
+}
+
+static inline bool arch_fault_on_access_pmd(pmd_t pmd)
+{
+	return arch_fault_on_access_pte(pmd_pte(pmd));
+}
+
+static inline vm_fault_t arch_handle_folio_fault_on_access(struct folio *folio,
+							   struct vm_fault *vmf,
+							   bool *map_pte)
+{
+	if (tag_storage_enabled())
+		return handle_folio_missing_tag_storage(folio, vmf, map_pte);
+
+	return VM_FAULT_SIGBUS;
+}
+#endif /* CONFIG_ARCH_HAS_FAULT_ON_ACCESS */
+
 #define pmd_present_invalid(pmd)     (!!(pmd_val(pmd) & PMD_PRESENT_INVALID))
 
 static inline int pmd_present(pmd_t pmd)
@@ -533,7 +555,7 @@ static inline void __set_pte_at(struct mm_struct *mm,
 				unsigned long __always_unused addr,
 				pte_t *ptep, pte_t pte, unsigned int nr)
 {
-	__sync_cache_and_tags(pte, nr);
+	__sync_cache_and_tags(&pte, nr);
 	__check_safe_pte_update(mm, ptep, pte);
 	set_pte(ptep, pte);
 }
@@ -828,8 +850,8 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
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
index a41ef3213e1e..faf09da3400a 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -35,13 +35,18 @@ DEFINE_STATIC_KEY_FALSE(mte_async_or_asymm_mode);
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
+		if (tag_storage_enabled() && !page_tag_storage_reserved(page)) {
+			*pteval = pte_modify(*pteval, PAGE_FAULT_ON_ACCESS);
+			continue;
+		}
+
+		/* if PG_mte_tagged is set, tags have already been initialised */
 		if (try_page_mte_tagging(page)) {
 			mte_clear_page_tags(page_address(page));
 			set_page_mte_tagged(page);
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 1ffaeccecda2..1db3adb6499f 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -12,6 +12,8 @@
 #include <linux/extable.h>
 #include <linux/kfence.h>
 #include <linux/signal.h>
+#include <linux/memcontrol.h>
+#include <linux/migrate.h>
 #include <linux/mm.h>
 #include <linux/hardirq.h>
 #include <linux/init.h>
@@ -19,6 +21,7 @@
 #include <linux/kprobes.h>
 #include <linux/uaccess.h>
 #include <linux/page-flags.h>
+#include <linux/page-isolation.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/debug.h>
 #include <linux/highmem.h>
@@ -962,3 +965,98 @@ void tag_clear_highpage(struct page *page)
 	mte_zero_clear_page_tags(page_address(page));
 	set_page_mte_tagged(page);
 }
+
+#ifdef CONFIG_ARM64_MTE_TAG_STORAGE
+
+#define MR_TAG_STORAGE	MR_ARCH_1
+
+/*
+ * Called with an elevated reference on the folio.
+ * Returns with the elevated reference dropped.
+ */
+static int replace_folio_with_tagged(struct folio *folio)
+{
+	struct migration_target_control mtc = {
+		.nid = NUMA_NO_NODE,
+		.gfp_mask = GFP_HIGHUSER_MOVABLE | __GFP_TAGGED,
+	};
+	LIST_HEAD(foliolist);
+	int ret, tries;
+
+	lru_cache_disable();
+
+	if (!folio_isolate_lru(folio)) {
+		lru_cache_enable();
+		folio_put(folio);
+		return -EAGAIN;
+	}
+
+	/* Isolate just grabbed another reference, drop ours. */
+	folio_put(folio);
+	list_add_tail(&folio->lru, &foliolist);
+
+	tries = 3;
+	while (tries--) {
+		ret = migrate_pages(&foliolist, alloc_migration_target, NULL, (unsigned long)&mtc,
+				    MIGRATE_SYNC, MR_TAG_STORAGE, NULL);
+		if (ret != -EBUSY)
+			break;
+	}
+
+	if (ret != 0)
+		putback_movable_pages(&foliolist);
+
+	lru_cache_enable();
+
+	return ret;
+}
+
+vm_fault_t handle_folio_missing_tag_storage(struct folio *folio, struct vm_fault *vmf,
+					    bool *map_pte)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	int ret = 0;
+
+	*map_pte = false;
+
+	/*
+	 * This should never happen, once a VMA has been marked as tagged, that
+	 * cannot be changed.
+	 */
+	if (WARN_ON_ONCE(!(vma->vm_flags & VM_MTE)))
+		goto out_map;
+
+	/*
+	 * The folio is probably being isolated for migration, replay the fault
+	 * to give time for the entry to be replaced by a migration pte.
+	 */
+	if (unlikely(is_migrate_isolate_page(folio_page(folio, 0))))
+		goto out_retry;
+
+	ret = reserve_tag_storage(folio_page(folio, 0), folio_order(folio), GFP_HIGHUSER_MOVABLE);
+	if (ret) {
+		/* replace_folio_with_tagged() is expensive, try to avoid it. */
+		if (fault_flag_allow_retry_first(vmf->flags))
+			goto out_retry;
+
+		replace_folio_with_tagged(folio);
+		return 0;
+	}
+
+out_map:
+	folio_put(folio);
+	*map_pte = true;
+	return 0;
+
+out_retry:
+	folio_put(folio);
+	if (fault_flag_allow_retry_first(vmf->flags)) {
+		/* Flag set by GUP. */
+		if (!(vmf->flags & FAULT_FLAG_RETRY_NOWAIT))
+			release_fault_lock(vmf);
+		return VM_FAULT_RETRY;
+	}
+	/* Replay the fault. */
+	return 0;
+}
+#endif
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 20ff87f8e001..9c0b559f54f5 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1633,6 +1633,8 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 }
 #endif /* CONFIG_MEMCG */
 
+bool folio_isolate_lru(struct folio *folio);
+
 static inline void __inc_lruvec_kmem_state(void *p, enum node_stat_item idx)
 {
 	__mod_lruvec_kmem_state(p, idx, 1);
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 2ce13e8a309b..f954e19bd9d1 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -10,8 +10,6 @@
 typedef struct folio *new_folio_t(struct folio *folio, unsigned long private);
 typedef void free_folio_t(struct folio *folio, unsigned long private);
 
-struct migration_target_control;
-
 /*
  * Return values from addresss_space_operations.migratepage():
  * - negative errno on page migration failure;
@@ -57,6 +55,12 @@ struct movable_operations {
 	void (*putback_page)(struct page *);
 };
 
+struct migration_target_control {
+       int nid;                /* preferred node id */
+       nodemask_t *nmask;
+       gfp_t gfp_mask;
+};
+
 /* Defined in mm/debug.c: */
 extern const char *migrate_reason_names[MR_TYPES];
 
diff --git a/include/linux/migrate_mode.h b/include/linux/migrate_mode.h
index f37cc03f9369..c6c5c7726d26 100644
--- a/include/linux/migrate_mode.h
+++ b/include/linux/migrate_mode.h
@@ -29,6 +29,7 @@ enum migrate_reason {
 	MR_CONTIG_RANGE,
 	MR_LONGTERM_PIN,
 	MR_DEMOTION,
+	MR_ARCH_1,
 	MR_TYPES
 };
 
diff --git a/mm/internal.h b/mm/internal.h
index f309a010d50f..cb76cf0928f5 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -952,12 +952,6 @@ static inline bool is_migrate_highatomic_page(struct page *page)
 
 void setup_zone_pageset(struct zone *zone);
 
-struct migration_target_control {
-	int nid;		/* preferred node id */
-	nodemask_t *nmask;
-	gfp_t gfp_mask;
-};
-
 /*
  * mm/filemap.c
  */
-- 
2.43.0


