Return-Path: <linux-fsdevel+bounces-3705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 767617F793E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 17:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B86C281FE4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 16:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80DC364D4;
	Fri, 24 Nov 2023 16:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 664042D54;
	Fri, 24 Nov 2023 08:35:57 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 625F71BF3;
	Fri, 24 Nov 2023 08:36:43 -0800 (PST)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 981EC3F73F;
	Fri, 24 Nov 2023 08:35:54 -0800 (PST)
From: Joey Gouly <joey.gouly@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: akpm@linux-foundation.org,
	aneesh.kumar@linux.ibm.com,
	broonie@kernel.org,
	catalin.marinas@arm.com,
	dave.hansen@linux.intel.com,
	joey.gouly@arm.com,
	maz@kernel.org,
	oliver.upton@linux.dev,
	shuah@kernel.org,
	will@kernel.org,
	kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v3 14/25] arm64: implement PKEYS support
Date: Fri, 24 Nov 2023 16:34:59 +0000
Message-Id: <20231124163510.1835740-15-joey.gouly@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231124163510.1835740-1-joey.gouly@arm.com>
References: <20231124163510.1835740-1-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the PKEYS interface, using the Permission Overlay Extension.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/mmu.h         |  2 +
 arch/arm64/include/asm/mmu_context.h | 32 ++++++++++++-
 arch/arm64/include/asm/pgtable.h     | 23 +++++++++-
 arch/arm64/include/asm/pkeys.h       | 68 +++++++++++++++++++++++++---
 arch/arm64/include/asm/por.h         | 33 ++++++++++++++
 arch/arm64/mm/mmu.c                  | 35 +++++++++++++-
 6 files changed, 184 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm64/include/asm/por.h

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 2fcf51231d6e..55338b14b453 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -25,6 +25,8 @@ typedef struct {
 	refcount_t	pinned;
 	void		*vdso;
 	unsigned long	flags;
+
+	u8		pkey_allocation_map;
 } mm_context_t;
 
 /*
diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 16b48fe9353f..3fc739fb831c 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -15,6 +15,7 @@
 #include <linux/sched/hotplug.h>
 #include <linux/mm_types.h>
 #include <linux/pgtable.h>
+#include <linux/pkeys.h>
 
 #include <asm/cacheflush.h>
 #include <asm/cpufeature.h>
@@ -211,11 +212,24 @@ init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
 	atomic64_set(&mm->context.id, 0);
 	refcount_set(&mm->context.pinned, 0);
+
+	// pkey 0 is the default, so always reserve it.
+	mm->context.pkey_allocation_map = 0x1;
+
 	return 0;
 }
 
+static inline void arch_dup_pkeys(struct mm_struct *oldmm,
+				  struct mm_struct *mm)
+{
+	/* Duplicate the oldmm pkey state in mm: */
+	mm->context.pkey_allocation_map = oldmm->context.pkey_allocation_map;
+}
+
 static inline int arch_dup_mmap(struct mm_struct *oldmm, struct mm_struct *mm)
 {
+	arch_dup_pkeys(oldmm, mm);
+
 	return 0;
 }
 
@@ -317,10 +331,26 @@ static inline unsigned long mm_untag_mask(struct mm_struct *mm)
 	return -1UL >> 8;
 }
 
+/*
+ * We only want to enforce protection keys on the current process
+ * because we effectively have no access to POR_EL0 for other
+ * processes or any way to tell *which * POR_EL0 in a threaded
+ * process we could use.
+ *
+ * So do not enforce things if the VMA is not from the current
+ * mm, or if we are in a kernel thread.
+ */
 static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
 		bool write, bool execute, bool foreign)
 {
-	return true;
+	if (!arch_pkeys_enabled())
+		return true;
+
+	/* allow access if the VMA is not one from this process */
+	if (foreign || vma_is_foreign(vma))
+		return true;
+
+	return por_el0_allows_pkey(vma_pkey(vma), write, execute);
 }
 
 #include <asm-generic/mmu_context.h>
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index e45105336ca0..789c88b138f5 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -30,6 +30,7 @@
 
 #include <asm/cmpxchg.h>
 #include <asm/fixmap.h>
+#include <asm/por.h>
 #include <linux/mmdebug.h>
 #include <linux/mm_types.h>
 #include <linux/sched.h>
@@ -143,6 +144,24 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
 #define pte_accessible(mm, pte)	\
 	(mm_tlb_flush_pending(mm) ? pte_present(pte) : pte_valid(pte))
 
+static inline bool por_el0_allows_pkey(u8 pkey, bool write, bool execute)
+{
+	u64 por;
+
+	if (!system_supports_poe())
+		return true;
+
+	por = read_sysreg_s(SYS_POR_EL0);
+
+	if (write)
+		return por_elx_allows_write(por, pkey);
+
+	if (execute)
+		return por_elx_allows_exec(por, pkey);
+
+	return por_elx_allows_read(por, pkey);
+}
+
 /*
  * p??_access_permitted() is true for valid user mappings (PTE_USER
  * bit set, subject to the write permission check). For execute-only
@@ -151,7 +170,9 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
  * PTE_VALID bit set.
  */
 #define pte_access_permitted(pte, write) \
-	(((pte_val(pte) & (PTE_VALID | PTE_USER)) == (PTE_VALID | PTE_USER)) && (!(write) || pte_write(pte)))
+	(((pte_val(pte) & (PTE_VALID | PTE_USER)) == (PTE_VALID | PTE_USER)) && \
+	 (!(write) || pte_write(pte)) && \
+	 por_el0_allows_pkey(FIELD_GET(PTE_PO_IDX_MASK, pte_val(pte)), write, false))
 #define pmd_access_permitted(pmd, write) \
 	(pte_access_permitted(pmd_pte(pmd), (write)))
 #define pud_access_permitted(pud, write) \
diff --git a/arch/arm64/include/asm/pkeys.h b/arch/arm64/include/asm/pkeys.h
index 5761fb48fd53..a80c654da93d 100644
--- a/arch/arm64/include/asm/pkeys.h
+++ b/arch/arm64/include/asm/pkeys.h
@@ -10,7 +10,7 @@
 
 #define ARCH_VM_PKEY_FLAGS (VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2)
 
-#define arch_max_pkey() 0
+#define arch_max_pkey() 7
 
 int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 		unsigned long init_val);
@@ -22,33 +22,89 @@ static inline bool arch_pkeys_enabled(void)
 
 static inline int vma_pkey(struct vm_area_struct *vma)
 {
-	return -1;
+	return (vma->vm_flags & ARCH_VM_PKEY_FLAGS) >> VM_PKEY_SHIFT;
 }
 
 static inline int arch_override_mprotect_pkey(struct vm_area_struct *vma,
 		int prot, int pkey)
 {
-	return -1;
+	if (pkey != -1)
+		return pkey;
+
+	return vma_pkey(vma);
 }
 
 static inline int execute_only_pkey(struct mm_struct *mm)
 {
+	// Execute-only mappings are handled by EPAN/FEAT_PAN3.
+	WARN_ON_ONCE(!cpus_have_final_cap(ARM64_HAS_EPAN));
+
 	return -1;
 }
 
+#define mm_pkey_allocation_map(mm)	(mm->context.pkey_allocation_map)
+#define mm_set_pkey_allocated(mm, pkey) do {		\
+	mm_pkey_allocation_map(mm) |= (1U << pkey);	\
+} while (0)
+#define mm_set_pkey_free(mm, pkey) do {			\
+	mm_pkey_allocation_map(mm) &= ~(1U << pkey);	\
+} while (0)
+
 static inline bool mm_pkey_is_allocated(struct mm_struct *mm, int pkey)
 {
-	return false;
+	/*
+	 * "Allocated" pkeys are those that have been returned
+	 * from pkey_alloc() or pkey 0 which is allocated
+	 * implicitly when the mm is created.
+	 */
+	if (pkey < 0)
+		return false;
+	if (pkey >= arch_max_pkey())
+		return false;
+
+	return mm_pkey_allocation_map(mm) & (1U << pkey);
 }
 
+/*
+ * Returns a positive, 3-bit key on success, or -1 on failure.
+ */
 static inline int mm_pkey_alloc(struct mm_struct *mm)
 {
-	return -1;
+	/*
+	 * Note: this is the one and only place we make sure
+	 * that the pkey is valid as far as the hardware is
+	 * concerned.  The rest of the kernel trusts that
+	 * only good, valid pkeys come out of here.
+	 */
+	u8 all_pkeys_mask = ((1U << arch_max_pkey()) - 1);
+	int ret;
+
+	if (!arch_pkeys_enabled())
+		return -1;
+
+	/*
+	 * Are we out of pkeys?  We must handle this specially
+	 * because ffz() behavior is undefined if there are no
+	 * zeros.
+	 */
+	if (mm_pkey_allocation_map(mm) == all_pkeys_mask)
+		return -1;
+
+	ret = ffz(mm_pkey_allocation_map(mm));
+
+	mm_set_pkey_allocated(mm, ret);
+
+	return ret;
 }
 
 static inline int mm_pkey_free(struct mm_struct *mm, int pkey)
 {
-	return -EINVAL;
+	if (!mm_pkey_is_allocated(mm, pkey))
+		return -EINVAL;
+
+	mm_set_pkey_free(mm, pkey);
+
+	return 0;
 }
 
 #endif /* _ASM_ARM64_PKEYS_H */
diff --git a/arch/arm64/include/asm/por.h b/arch/arm64/include/asm/por.h
new file mode 100644
index 000000000000..90484dae9920
--- /dev/null
+++ b/arch/arm64/include/asm/por.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Arm Ltd.
+*/
+
+#ifndef _ASM_ARM64_POR_H
+#define _ASM_ARM64_POR_H
+
+#define POR_BITS_PER_PKEY		4
+#define POR_ELx_IDX(por_elx, idx)	(((por_elx) >> (idx * POR_BITS_PER_PKEY)) & 0xf)
+
+static inline bool por_elx_allows_read(u64 por, u8 pkey)
+{
+	u8 perm = POR_ELx_IDX(por, pkey);
+
+	return perm & POE_R;
+}
+
+static inline bool por_elx_allows_write(u64 por, u8 pkey)
+{
+	u8 perm = POR_ELx_IDX(por, pkey);
+
+	return perm & POE_W;
+}
+
+static inline bool por_elx_allows_exec(u64 por, u8 pkey)
+{
+	u8 perm = POR_ELx_IDX(por, pkey);
+
+	return perm & POE_X;
+}
+
+#endif /* _ASM_ARM64_POR_H */
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index f7bf41eae904..c255345e6a6a 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -25,6 +25,7 @@
 #include <linux/vmalloc.h>
 #include <linux/set_memory.h>
 #include <linux/kfence.h>
+#include <linux/pkeys.h>
 
 #include <asm/barrier.h>
 #include <asm/cputype.h>
@@ -1490,6 +1491,38 @@ void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr, pte
 #ifdef CONFIG_ARCH_HAS_PKEYS
 int arch_set_user_pkey_access(struct task_struct *tsk, int pkey, unsigned long init_val)
 {
-	return -ENOSPC;
+	u64 new_por = POE_RXW;
+	u64 old_por;
+	u64 pkey_shift;
+
+	if (!arch_pkeys_enabled())
+		return -ENOSPC;
+
+	/*
+	 * This code should only be called with valid 'pkey'
+	 * values originating from in-kernel users.  Complain
+	 * if a bad value is observed.
+	 */
+	if (WARN_ON_ONCE(pkey >= arch_max_pkey()))
+		return -EINVAL;
+
+	/* Set the bits we need in POR:  */
+	if (init_val & PKEY_DISABLE_ACCESS)
+		new_por = POE_X;
+	else if (init_val & PKEY_DISABLE_WRITE)
+		new_por = POE_RX;
+
+	/* Shift the bits in to the correct place in POR for pkey: */
+	pkey_shift = pkey * POR_BITS_PER_PKEY;
+	new_por <<= pkey_shift;
+
+	/* Get old POR and mask off any old bits in place: */
+	old_por = read_sysreg_s(SYS_POR_EL0);
+	old_por &= ~(POE_MASK << pkey_shift);
+
+	/* Write old part along with new part: */
+	write_sysreg_s(old_por | new_por, SYS_POR_EL0);
+
+	return 0;
 }
 #endif
-- 
2.25.1


