Return-Path: <linux-fsdevel+bounces-26768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB8E95B9A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 17:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0C062866D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 15:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888711CCB32;
	Thu, 22 Aug 2024 15:12:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8559A1CC892;
	Thu, 22 Aug 2024 15:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724339564; cv=none; b=e53ORYsMMGX2reRxefYGjptykeOHqaWFp0lsG+vOFWATOXd2RtuE2G7MJkSahylHtc9awy9FeAnDll4wpkWofinibH1xMFhUbdCxqrqRXOgnLJb3152pLyip3vqBvn2mMmsflcUvoZnbq5WwXZT45gBIicUC1sDSQaM8y17GAdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724339564; c=relaxed/simple;
	bh=pE0v1MARAlbj0b3UaPAKkAWJfloY9FgDEdPZHJ+N9rk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=So/7JqrrAJ8JUBgN/vzSjeuc6JHu+qpP9Ci892GnT63QEG/y7LU83VgtCHPiGJ6xtVTWsKzGXDRRO6DhkusDrYnbLrTCcspDnu/9vImyw7gqh3hOcg2iVtI4FnnYdYLAnYcRT/im1eZKmP5b8fcrgNmiK22aPe6x0RUhtNdxl90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41D7F15DB;
	Thu, 22 Aug 2024 08:13:08 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04AF63F58B;
	Thu, 22 Aug 2024 08:12:37 -0700 (PDT)
From: Joey Gouly <joey.gouly@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: nd@arm.com,
	akpm@linux-foundation.org,
	aneesh.kumar@kernel.org,
	aneesh.kumar@linux.ibm.com,
	anshuman.khandual@arm.com,
	bp@alien8.de,
	broonie@kernel.org,
	catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	joey.gouly@arm.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	maz@kernel.org,
	mingo@redhat.com,
	mpe@ellerman.id.au,
	naveen.n.rao@linux.ibm.com,
	npiggin@gmail.com,
	oliver.upton@linux.dev,
	shuah@kernel.org,
	skhan@linuxfoundation.org,
	szabolcs.nagy@arm.com,
	tglx@linutronix.de,
	will@kernel.org,
	x86@kernel.org,
	kvmarm@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v5 18/30] arm64: implement PKEYS support
Date: Thu, 22 Aug 2024 16:11:01 +0100
Message-Id: <20240822151113.1479789-19-joey.gouly@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240822151113.1479789-1-joey.gouly@arm.com>
References: <20240822151113.1479789-1-joey.gouly@arm.com>
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
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/mmu.h         |   1 +
 arch/arm64/include/asm/mmu_context.h |  46 +++++++++++-
 arch/arm64/include/asm/pgtable.h     |  22 +++++-
 arch/arm64/include/asm/pkeys.h       | 108 +++++++++++++++++++++++++++
 arch/arm64/include/asm/por.h         |  33 ++++++++
 arch/arm64/include/uapi/asm/mman.h   |   9 +++
 arch/arm64/mm/mmu.c                  |  45 +++++++++++
 7 files changed, 262 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/include/asm/pkeys.h
 create mode 100644 arch/arm64/include/asm/por.h

diff --git arch/arm64/include/asm/mmu.h arch/arm64/include/asm/mmu.h
index 65977c7783c5..983afeb4eba5 100644
--- arch/arm64/include/asm/mmu.h
+++ arch/arm64/include/asm/mmu.h
@@ -25,6 +25,7 @@ typedef struct {
 	refcount_t	pinned;
 	void		*vdso;
 	unsigned long	flags;
+	u8		pkey_allocation_map;
 } mm_context_t;
 
 /*
diff --git arch/arm64/include/asm/mmu_context.h arch/arm64/include/asm/mmu_context.h
index bd19f4c758b7..7c09d47e09cb 100644
--- arch/arm64/include/asm/mmu_context.h
+++ arch/arm64/include/asm/mmu_context.h
@@ -15,12 +15,12 @@
 #include <linux/sched/hotplug.h>
 #include <linux/mm_types.h>
 #include <linux/pgtable.h>
+#include <linux/pkeys.h>
 
 #include <asm/cacheflush.h>
 #include <asm/cpufeature.h>
 #include <asm/daifflags.h>
 #include <asm/proc-fns.h>
-#include <asm-generic/mm_hooks.h>
 #include <asm/cputype.h>
 #include <asm/sysreg.h>
 #include <asm/tlbflush.h>
@@ -175,9 +175,36 @@ init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
 	atomic64_set(&mm->context.id, 0);
 	refcount_set(&mm->context.pinned, 0);
+
+	/* pkey 0 is the default, so always reserve it. */
+	mm->context.pkey_allocation_map = BIT(0);
+
+	return 0;
+}
+
+static inline void arch_dup_pkeys(struct mm_struct *oldmm,
+				  struct mm_struct *mm)
+{
+	/* Duplicate the oldmm pkey state in mm: */
+	mm->context.pkey_allocation_map = oldmm->context.pkey_allocation_map;
+}
+
+static inline int arch_dup_mmap(struct mm_struct *oldmm, struct mm_struct *mm)
+{
+	arch_dup_pkeys(oldmm, mm);
+
 	return 0;
 }
 
+static inline void arch_exit_mmap(struct mm_struct *mm)
+{
+}
+
+static inline void arch_unmap(struct mm_struct *mm,
+			unsigned long start, unsigned long end)
+{
+}
+
 #ifdef CONFIG_ARM64_SW_TTBR0_PAN
 static inline void update_saved_ttbr0(struct task_struct *tsk,
 				      struct mm_struct *mm)
@@ -267,6 +294,23 @@ static inline unsigned long mm_untag_mask(struct mm_struct *mm)
 	return -1UL >> 8;
 }
 
+/*
+ * Only enforce protection keys on the current process, because there is no
+ * user context to access POR_EL0 for another address space.
+ */
+static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
+		bool write, bool execute, bool foreign)
+{
+	if (!system_supports_poe())
+		return true;
+
+	/* allow access if the VMA is not one from this process */
+	if (foreign || vma_is_foreign(vma))
+		return true;
+
+	return por_el0_allows_pkey(vma_pkey(vma), write, execute);
+}
+
 #include <asm-generic/mmu_context.h>
 
 #endif /* !__ASSEMBLY__ */
diff --git arch/arm64/include/asm/pgtable.h arch/arm64/include/asm/pgtable.h
index 61a674942a6b..96c2b0b07c4c 100644
--- arch/arm64/include/asm/pgtable.h
+++ arch/arm64/include/asm/pgtable.h
@@ -34,6 +34,7 @@
 
 #include <asm/cmpxchg.h>
 #include <asm/fixmap.h>
+#include <asm/por.h>
 #include <linux/mmdebug.h>
 #include <linux/mm_types.h>
 #include <linux/sched.h>
@@ -149,6 +150,24 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
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
@@ -159,7 +178,8 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
 #define pte_access_permitted_no_overlay(pte, write) \
 	(((pte_val(pte) & (PTE_VALID | PTE_USER)) == (PTE_VALID | PTE_USER)) && (!(write) || pte_write(pte)))
 #define pte_access_permitted(pte, write) \
-	pte_access_permitted_no_overlay(pte, write)
+	(pte_access_permitted_no_overlay(pte, write) && \
+	por_el0_allows_pkey(FIELD_GET(PTE_PO_IDX_MASK, pte_val(pte)), write, false))
 #define pmd_access_permitted(pmd, write) \
 	(pte_access_permitted(pmd_pte(pmd), (write)))
 #define pud_access_permitted(pud, write) \
diff --git arch/arm64/include/asm/pkeys.h arch/arm64/include/asm/pkeys.h
new file mode 100644
index 000000000000..32c352bb36b9
--- /dev/null
+++ arch/arm64/include/asm/pkeys.h
@@ -0,0 +1,108 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Arm Ltd.
+ *
+ * Based on arch/x86/include/asm/pkeys.h
+ */
+
+#ifndef _ASM_ARM64_PKEYS_H
+#define _ASM_ARM64_PKEYS_H
+
+#define ARCH_VM_PKEY_FLAGS (VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2)
+
+#define arch_max_pkey() 8
+
+int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
+		unsigned long init_val);
+
+static inline bool arch_pkeys_enabled(void)
+{
+	return false;
+}
+
+static inline int vma_pkey(struct vm_area_struct *vma)
+{
+	return (vma->vm_flags & ARCH_VM_PKEY_FLAGS) >> VM_PKEY_SHIFT;
+}
+
+static inline int arch_override_mprotect_pkey(struct vm_area_struct *vma,
+		int prot, int pkey)
+{
+	if (pkey != -1)
+		return pkey;
+
+	return vma_pkey(vma);
+}
+
+static inline int execute_only_pkey(struct mm_struct *mm)
+{
+	// Execute-only mappings are handled by EPAN/FEAT_PAN3.
+	WARN_ON_ONCE(!cpus_have_final_cap(ARM64_HAS_EPAN));
+
+	return -1;
+}
+
+#define mm_pkey_allocation_map(mm)	(mm)->context.pkey_allocation_map
+#define mm_set_pkey_allocated(mm, pkey) do {		\
+	mm_pkey_allocation_map(mm) |= (1U << pkey);	\
+} while (0)
+#define mm_set_pkey_free(mm, pkey) do {			\
+	mm_pkey_allocation_map(mm) &= ~(1U << pkey);	\
+} while (0)
+
+static inline bool mm_pkey_is_allocated(struct mm_struct *mm, int pkey)
+{
+	/*
+	 * "Allocated" pkeys are those that have been returned
+	 * from pkey_alloc() or pkey 0 which is allocated
+	 * implicitly when the mm is created.
+	 */
+	if (pkey < 0 || pkey >= arch_max_pkey())
+		return false;
+
+	return mm_pkey_allocation_map(mm) & (1U << pkey);
+}
+
+/*
+ * Returns a positive, 3-bit key on success, or -1 on failure.
+ */
+static inline int mm_pkey_alloc(struct mm_struct *mm)
+{
+	/*
+	 * Note: this is the one and only place we make sure
+	 * that the pkey is valid as far as the hardware is
+	 * concerned.  The rest of the kernel trusts that
+	 * only good, valid pkeys come out of here.
+	 */
+	u8 all_pkeys_mask = GENMASK(arch_max_pkey() - 1, 0);
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
+}
+
+static inline int mm_pkey_free(struct mm_struct *mm, int pkey)
+{
+	if (!mm_pkey_is_allocated(mm, pkey))
+		return -EINVAL;
+
+	mm_set_pkey_free(mm, pkey);
+
+	return 0;
+}
+
+#endif /* _ASM_ARM64_PKEYS_H */
diff --git arch/arm64/include/asm/por.h arch/arm64/include/asm/por.h
new file mode 100644
index 000000000000..e06e9f473675
--- /dev/null
+++ arch/arm64/include/asm/por.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Arm Ltd.
+ */
+
+#ifndef _ASM_ARM64_POR_H
+#define _ASM_ARM64_POR_H
+
+#define POR_BITS_PER_PKEY		4
+#define POR_ELx_IDX(por_elx, idx)	(((por_elx) >> ((idx) * POR_BITS_PER_PKEY)) & 0xf)
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
diff --git arch/arm64/include/uapi/asm/mman.h arch/arm64/include/uapi/asm/mman.h
index 1e6482a838e1..e7e0c8216243 100644
--- arch/arm64/include/uapi/asm/mman.h
+++ arch/arm64/include/uapi/asm/mman.h
@@ -7,4 +7,13 @@
 #define PROT_BTI	0x10		/* BTI guarded page */
 #define PROT_MTE	0x20		/* Normal Tagged mapping */
 
+/* Override any generic PKEY permission defines */
+#define PKEY_DISABLE_EXECUTE	0x4
+#define PKEY_DISABLE_READ	0x8
+#undef PKEY_ACCESS_MASK
+#define PKEY_ACCESS_MASK       (PKEY_DISABLE_ACCESS |\
+				PKEY_DISABLE_WRITE  |\
+				PKEY_DISABLE_READ   |\
+				PKEY_DISABLE_EXECUTE)
+
 #endif /* ! _UAPI__ASM_MMAN_H */
diff --git arch/arm64/mm/mmu.c arch/arm64/mm/mmu.c
index 353ea5dc32b8..e55b02fbddc8 100644
--- arch/arm64/mm/mmu.c
+++ arch/arm64/mm/mmu.c
@@ -25,6 +25,7 @@
 #include <linux/vmalloc.h>
 #include <linux/set_memory.h>
 #include <linux/kfence.h>
+#include <linux/pkeys.h>
 
 #include <asm/barrier.h>
 #include <asm/cputype.h>
@@ -1549,3 +1550,47 @@ void __cpu_replace_ttbr1(pgd_t *pgdp, bool cnp)
 
 	cpu_uninstall_idmap();
 }
+
+#ifdef CONFIG_ARCH_HAS_PKEYS
+int arch_set_user_pkey_access(struct task_struct *tsk, int pkey, unsigned long init_val)
+{
+	u64 new_por = POE_RXW;
+	u64 old_por;
+	u64 pkey_shift;
+
+	if (!system_supports_poe())
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
+	new_por = POE_RXW;
+	if (init_val & PKEY_DISABLE_WRITE)
+		new_por &= ~POE_W;
+	if (init_val & PKEY_DISABLE_ACCESS)
+		new_por &= ~POE_RW;
+	if (init_val & PKEY_DISABLE_READ)
+		new_por &= ~POE_R;
+	if (init_val & PKEY_DISABLE_EXECUTE)
+		new_por &= ~POE_X;
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
+}
+#endif
-- 
2.25.1


