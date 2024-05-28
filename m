Return-Path: <linux-fsdevel+bounces-20338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8948D1961
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 13:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8AC6B21782
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 11:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E1616C69D;
	Tue, 28 May 2024 11:26:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC40182B3
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 May 2024 11:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716895593; cv=none; b=QM9IY/f5+HbVXRYGoauLpqlsdXjxP43cMUYQGNrqgA/eJ0EYw8s/Fo7FedmN5r4H2R9QLTBayickARn6VNhVblHeTN740yMitb1aZoThdZvLO4iMhhTsvLR4V7K7lu+bT4+sGvMEM98RgwLPNEE7AS5PX3aXjxYC2kmL4S8/xV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716895593; c=relaxed/simple;
	bh=WPJeLoTFVOJ8aZfnYP+GrmD0EfUdf+fJiVPnwye1o4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSiwwAeiO8/0aPCvqjTYmV/eDFZm+2q7MnjMb6mwZSty27xBHzZcRcNnOwLnTJGePcrWGA6kvbOIZ2pXRGTP/KSqAYsE+RW1lpjeBQ0y44OmTARVwP6chN1hT5s6B7+CIaezaVt2WLfRz09g2vX89bVVsAQxPepLPvMHZ5CzPwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A3FB339;
	Tue, 28 May 2024 04:26:53 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 719FD3F762;
	Tue, 28 May 2024 04:26:26 -0700 (PDT)
Date: Tue, 28 May 2024 12:26:19 +0100
From: Joey Gouly <joey.gouly@arm.com>
To: Amit Daniel Kachhap <amitdaniel.kachhap@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	aneesh.kumar@kernel.org, aneesh.kumar@linux.ibm.com, bp@alien8.de,
	broonie@kernel.org, catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu, dave.hansen@linux.intel.com,
	hpa@zytor.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mingo@redhat.com,
	mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com,
	oliver.upton@linux.dev, shuah@kernel.org, szabolcs.nagy@arm.com,
	tglx@linutronix.de, will@kernel.org, x86@kernel.org,
	kvmarm@lists.linux.dev
Subject: Re: [PATCH v4 17/29] arm64: implement PKEYS support
Message-ID: <20240528112619.GA1072039@e124191.cambridge.arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-18-joey.gouly@arm.com>
 <48b56552-98dd-4b14-8f0c-6cd3a38ded39@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48b56552-98dd-4b14-8f0c-6cd3a38ded39@arm.com>

Hi Amit,

Thanks for taking a look!

On Tue, May 28, 2024 at 12:25:58PM +0530, Amit Daniel Kachhap wrote:
> 
> 
> On 5/3/24 18:31, Joey Gouly wrote:
> > Implement the PKEYS interface, using the Permission Overlay Extension.
> > 
> > Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > ---
> >   arch/arm64/include/asm/mmu.h         |   1 +
> >   arch/arm64/include/asm/mmu_context.h |  51 ++++++++++++-
> >   arch/arm64/include/asm/pgtable.h     |  22 +++++-
> >   arch/arm64/include/asm/pkeys.h       | 110 +++++++++++++++++++++++++++
> >   arch/arm64/include/asm/por.h         |  33 ++++++++
> >   arch/arm64/mm/mmu.c                  |  40 ++++++++++
> >   6 files changed, 255 insertions(+), 2 deletions(-)
> >   create mode 100644 arch/arm64/include/asm/pkeys.h
> >   create mode 100644 arch/arm64/include/asm/por.h
> > 
> > diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> > index 65977c7783c5..983afeb4eba5 100644
> > --- a/arch/arm64/include/asm/mmu.h
> > +++ b/arch/arm64/include/asm/mmu.h
> > @@ -25,6 +25,7 @@ typedef struct {
> >   	refcount_t	pinned;
> >   	void		*vdso;
> >   	unsigned long	flags;
> > +	u8		pkey_allocation_map;
> >   } mm_context_t;
> >   /*
> > diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
> > index c768d16b81a4..cb499db7a97b 100644
> > --- a/arch/arm64/include/asm/mmu_context.h
> > +++ b/arch/arm64/include/asm/mmu_context.h
> > @@ -15,12 +15,12 @@
> >   #include <linux/sched/hotplug.h>
> >   #include <linux/mm_types.h>
> >   #include <linux/pgtable.h>
> > +#include <linux/pkeys.h>
> >   #include <asm/cacheflush.h>
> >   #include <asm/cpufeature.h>
> >   #include <asm/daifflags.h>
> >   #include <asm/proc-fns.h>
> > -#include <asm-generic/mm_hooks.h>
> >   #include <asm/cputype.h>
> >   #include <asm/sysreg.h>
> >   #include <asm/tlbflush.h>
> > @@ -175,9 +175,36 @@ init_new_context(struct task_struct *tsk, struct mm_struct *mm)
> >   {
> >   	atomic64_set(&mm->context.id, 0);
> >   	refcount_set(&mm->context.pinned, 0);
> > +
> > +	/* pkey 0 is the default, so always reserve it. */
> > +	mm->context.pkey_allocation_map = 0x1;
> > +
> > +	return 0;
> > +}
> > +
> > +static inline void arch_dup_pkeys(struct mm_struct *oldmm,
> > +				  struct mm_struct *mm)
> > +{
> > +	/* Duplicate the oldmm pkey state in mm: */
> > +	mm->context.pkey_allocation_map = oldmm->context.pkey_allocation_map;
> > +}
> > +
> > +static inline int arch_dup_mmap(struct mm_struct *oldmm, struct mm_struct *mm)
> > +{
> > +	arch_dup_pkeys(oldmm, mm);
> > +
> >   	return 0;
> >   }
> > +static inline void arch_exit_mmap(struct mm_struct *mm)
> > +{
> > +}
> > +
> > +static inline void arch_unmap(struct mm_struct *mm,
> > +			unsigned long start, unsigned long end)
> > +{
> > +}
> > +
> >   #ifdef CONFIG_ARM64_SW_TTBR0_PAN
> >   static inline void update_saved_ttbr0(struct task_struct *tsk,
> >   				      struct mm_struct *mm)
> > @@ -267,6 +294,28 @@ static inline unsigned long mm_untag_mask(struct mm_struct *mm)
> >   	return -1UL >> 8;
> >   }
> > +/*
> > + * We only want to enforce protection keys on the current process
> > + * because we effectively have no access to POR_EL0 for other
> > + * processes or any way to tell *which * POR_EL0 in a threaded
> > + * process we could use.
> > + *
> > + * So do not enforce things if the VMA is not from the current
> > + * mm, or if we are in a kernel thread.
> > + */
> > +static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
> > +		bool write, bool execute, bool foreign)
> > +{
> > +	if (!arch_pkeys_enabled())
> > +		return true;
> 
> The above check can be dropped as the caller of this function
> fault_from_pkey() does the same check.

arch_vma_access_permitted() is called by other places in the kernel, so I need to leave that check in.

Thanks,
Joey

> 
> Thanks,
> Amit
> 
> > +
> > +	/* allow access if the VMA is not one from this process */
> > +	if (foreign || vma_is_foreign(vma))
> > +		return true;
> > +
> > +	return por_el0_allows_pkey(vma_pkey(vma), write, execute);
> > +}
> > +
> >   #include <asm-generic/mmu_context.h>
> >   #endif /* !__ASSEMBLY__ */
> > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> > index 2449e4e27ea6..8ee68ff03016 100644
> > --- a/arch/arm64/include/asm/pgtable.h
> > +++ b/arch/arm64/include/asm/pgtable.h
> > @@ -34,6 +34,7 @@
> >   #include <asm/cmpxchg.h>
> >   #include <asm/fixmap.h>
> > +#include <asm/por.h>
> >   #include <linux/mmdebug.h>
> >   #include <linux/mm_types.h>
> >   #include <linux/sched.h>
> > @@ -153,6 +154,24 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
> >   #define pte_accessible(mm, pte)	\
> >   	(mm_tlb_flush_pending(mm) ? pte_present(pte) : pte_valid(pte))
> > +static inline bool por_el0_allows_pkey(u8 pkey, bool write, bool execute)
> > +{
> > +	u64 por;
> > +
> > +	if (!system_supports_poe())
> > +		return true;
> > +
> > +	por = read_sysreg_s(SYS_POR_EL0);
> > +
> > +	if (write)
> > +		return por_elx_allows_write(por, pkey);
> > +
> > +	if (execute)
> > +		return por_elx_allows_exec(por, pkey);
> > +
> > +	return por_elx_allows_read(por, pkey);
> > +}
> > +
> >   /*
> >    * p??_access_permitted() is true for valid user mappings (PTE_USER
> >    * bit set, subject to the write permission check). For execute-only
> > @@ -163,7 +182,8 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
> >   #define pte_access_permitted_no_overlay(pte, write) \
> >   	(((pte_val(pte) & (PTE_VALID | PTE_USER)) == (PTE_VALID | PTE_USER)) && (!(write) || pte_write(pte)))
> >   #define pte_access_permitted(pte, write) \
> > -	pte_access_permitted_no_overlay(pte, write)
> > +	(pte_access_permitted_no_overlay(pte, write) && \
> > +	por_el0_allows_pkey(FIELD_GET(PTE_PO_IDX_MASK, pte_val(pte)), write, false))
> >   #define pmd_access_permitted(pmd, write) \
> >   	(pte_access_permitted(pmd_pte(pmd), (write)))
> >   #define pud_access_permitted(pud, write) \
> > diff --git a/arch/arm64/include/asm/pkeys.h b/arch/arm64/include/asm/pkeys.h
> > new file mode 100644
> > index 000000000000..a284508a4d02
> > --- /dev/null
> > +++ b/arch/arm64/include/asm/pkeys.h
> > @@ -0,0 +1,110 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2023 Arm Ltd.
> > + *
> > + * Based on arch/x86/include/asm/pkeys.h
> > + */
> > +
> > +#ifndef _ASM_ARM64_PKEYS_H
> > +#define _ASM_ARM64_PKEYS_H
> > +
> > +#define ARCH_VM_PKEY_FLAGS (VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2)
> > +
> > +#define arch_max_pkey() 7
> > +
> > +int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
> > +		unsigned long init_val);
> > +
> > +static inline bool arch_pkeys_enabled(void)
> > +{
> > +	return false;
> > +}
> > +
> > +static inline int vma_pkey(struct vm_area_struct *vma)
> > +{
> > +	return (vma->vm_flags & ARCH_VM_PKEY_FLAGS) >> VM_PKEY_SHIFT;
> > +}
> > +
> > +static inline int arch_override_mprotect_pkey(struct vm_area_struct *vma,
> > +		int prot, int pkey)
> > +{
> > +	if (pkey != -1)
> > +		return pkey;
> > +
> > +	return vma_pkey(vma);
> > +}
> > +
> > +static inline int execute_only_pkey(struct mm_struct *mm)
> > +{
> > +	// Execute-only mappings are handled by EPAN/FEAT_PAN3.
> > +	WARN_ON_ONCE(!cpus_have_final_cap(ARM64_HAS_EPAN));
> > +
> > +	return -1;
> > +}
> > +
> > +#define mm_pkey_allocation_map(mm)	(mm->context.pkey_allocation_map)
> > +#define mm_set_pkey_allocated(mm, pkey) do {		\
> > +	mm_pkey_allocation_map(mm) |= (1U << pkey);	\
> > +} while (0)
> > +#define mm_set_pkey_free(mm, pkey) do {			\
> > +	mm_pkey_allocation_map(mm) &= ~(1U << pkey);	\
> > +} while (0)
> > +
> > +static inline bool mm_pkey_is_allocated(struct mm_struct *mm, int pkey)
> > +{
> > +	/*
> > +	 * "Allocated" pkeys are those that have been returned
> > +	 * from pkey_alloc() or pkey 0 which is allocated
> > +	 * implicitly when the mm is created.
> > +	 */
> > +	if (pkey < 0)
> > +		return false;
> > +	if (pkey >= arch_max_pkey())
> > +		return false;
> > +
> > +	return mm_pkey_allocation_map(mm) & (1U << pkey);
> > +}
> > +
> > +/*
> > + * Returns a positive, 3-bit key on success, or -1 on failure.
> > + */
> > +static inline int mm_pkey_alloc(struct mm_struct *mm)
> > +{
> > +	/*
> > +	 * Note: this is the one and only place we make sure
> > +	 * that the pkey is valid as far as the hardware is
> > +	 * concerned.  The rest of the kernel trusts that
> > +	 * only good, valid pkeys come out of here.
> > +	 */
> > +	u8 all_pkeys_mask = ((1U << arch_max_pkey()) - 1);
> > +	int ret;
> > +
> > +	if (!arch_pkeys_enabled())
> > +		return -1;
> > +
> > +	/*
> > +	 * Are we out of pkeys?  We must handle this specially
> > +	 * because ffz() behavior is undefined if there are no
> > +	 * zeros.
> > +	 */
> > +	if (mm_pkey_allocation_map(mm) == all_pkeys_mask)
> > +		return -1;
> > +
> > +	ret = ffz(mm_pkey_allocation_map(mm));
> > +
> > +	mm_set_pkey_allocated(mm, ret);
> > +
> > +	return ret;
> > +}
> > +
> > +static inline int mm_pkey_free(struct mm_struct *mm, int pkey)
> > +{
> > +	if (!mm_pkey_is_allocated(mm, pkey))
> > +		return -EINVAL;
> > +
> > +	mm_set_pkey_free(mm, pkey);
> > +
> > +	return 0;
> > +}
> > +
> > +#endif /* _ASM_ARM64_PKEYS_H */
> > diff --git a/arch/arm64/include/asm/por.h b/arch/arm64/include/asm/por.h
> > new file mode 100644
> > index 000000000000..d6604e0c5c54
> > --- /dev/null
> > +++ b/arch/arm64/include/asm/por.h
> > @@ -0,0 +1,33 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2023 Arm Ltd.
> > + */
> > +
> > +#ifndef _ASM_ARM64_POR_H
> > +#define _ASM_ARM64_POR_H
> > +
> > +#define POR_BITS_PER_PKEY		4
> > +#define POR_ELx_IDX(por_elx, idx)	(((por_elx) >> (idx * POR_BITS_PER_PKEY)) & 0xf)
> > +
> > +static inline bool por_elx_allows_read(u64 por, u8 pkey)
> > +{
> > +	u8 perm = POR_ELx_IDX(por, pkey);
> > +
> > +	return perm & POE_R;
> > +}
> > +
> > +static inline bool por_elx_allows_write(u64 por, u8 pkey)
> > +{
> > +	u8 perm = POR_ELx_IDX(por, pkey);
> > +
> > +	return perm & POE_W;
> > +}
> > +
> > +static inline bool por_elx_allows_exec(u64 por, u8 pkey)
> > +{
> > +	u8 perm = POR_ELx_IDX(por, pkey);
> > +
> > +	return perm & POE_X;
> > +}
> > +
> > +#endif /* _ASM_ARM64_POR_H */
> > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > index 495b732d5af3..e50ccc86d150 100644
> > --- a/arch/arm64/mm/mmu.c
> > +++ b/arch/arm64/mm/mmu.c
> > @@ -25,6 +25,7 @@
> >   #include <linux/vmalloc.h>
> >   #include <linux/set_memory.h>
> >   #include <linux/kfence.h>
> > +#include <linux/pkeys.h>
> >   #include <asm/barrier.h>
> >   #include <asm/cputype.h>
> > @@ -1535,3 +1536,42 @@ void __cpu_replace_ttbr1(pgd_t *pgdp, bool cnp)
> >   	cpu_uninstall_idmap();
> >   }
> > +
> > +#ifdef CONFIG_ARCH_HAS_PKEYS
> > +int arch_set_user_pkey_access(struct task_struct *tsk, int pkey, unsigned long init_val)
> > +{
> > +	u64 new_por = POE_RXW;
> > +	u64 old_por;
> > +	u64 pkey_shift;
> > +
> > +	if (!arch_pkeys_enabled())
> > +		return -ENOSPC;
> > +
> > +	/*
> > +	 * This code should only be called with valid 'pkey'
> > +	 * values originating from in-kernel users.  Complain
> > +	 * if a bad value is observed.
> > +	 */
> > +	if (WARN_ON_ONCE(pkey >= arch_max_pkey()))
> > +		return -EINVAL;
> > +
> > +	/* Set the bits we need in POR:  */
> > +	if (init_val & PKEY_DISABLE_ACCESS)
> > +		new_por = POE_X;
> > +	else if (init_val & PKEY_DISABLE_WRITE)
> > +		new_por = POE_RX;
> > +
> > +	/* Shift the bits in to the correct place in POR for pkey: */
> > +	pkey_shift = pkey * POR_BITS_PER_PKEY;
> > +	new_por <<= pkey_shift;
> > +
> > +	/* Get old POR and mask off any old bits in place: */
> > +	old_por = read_sysreg_s(SYS_POR_EL0);
> > +	old_por &= ~(POE_MASK << pkey_shift);
> > +
> > +	/* Write old part along with new part: */
> > +	write_sysreg_s(old_por | new_por, SYS_POR_EL0);
> > +
> > +	return 0;
> > +}
> > +#endif

