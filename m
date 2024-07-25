Return-Path: <linux-fsdevel+bounces-24263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E51D93C706
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 18:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B21B51C21387
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 16:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964E419D893;
	Thu, 25 Jul 2024 16:12:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D3819D884
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 16:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721923957; cv=none; b=IZZZ8G2ROxYFb3Snbve9/OK6hP/xKNZ4KzW50kXCuCoAXrIo/fdquq334Q1vIbz1y9RCyt0ZbfPukGWkNcPfyYNCJwW8yfJCTbiycYnAdBoVWm9N/Pq2lhCglfzpKXVrtgcJ5yt1T15pw12DQKBzX0ZMeHUSLiZ/6OiQfgr1ZvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721923957; c=relaxed/simple;
	bh=TYBhyEVfHD0hdhnSFlid/6BnUwGa6bA3P+mrIwLeUB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mh38TxEeDZFvz8oAJSjiNzUDHSOnAhWZBaqGQ6kNXts+977//RnACvwk//eCW248VPBYClhSLl5JZP3piOWrU4kIFnMsHAW4lh63ixqx9sM6sWpkCgDnIgVpLlJIoOZoILFBCF0hIbt38k6bFMySrem//ngGLCnrV+KQ74v8tuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 596EC1007;
	Thu, 25 Jul 2024 09:12:59 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 257DE3F5A1;
	Thu, 25 Jul 2024 09:12:30 -0700 (PDT)
Date: Thu, 25 Jul 2024 17:12:27 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Joey Gouly <joey.gouly@arm.com>
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
Message-ID: <ZqJ5a5Iy85/XLGkr@e133380.arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-18-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503130147.1154804-18-joey.gouly@arm.com>

On Fri, May 03, 2024 at 02:01:35PM +0100, Joey Gouly wrote:
> Implement the PKEYS interface, using the Permission Overlay Extension.
> 
> Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/include/asm/mmu.h         |   1 +
>  arch/arm64/include/asm/mmu_context.h |  51 ++++++++++++-
>  arch/arm64/include/asm/pgtable.h     |  22 +++++-
>  arch/arm64/include/asm/pkeys.h       | 110 +++++++++++++++++++++++++++
>  arch/arm64/include/asm/por.h         |  33 ++++++++
>  arch/arm64/mm/mmu.c                  |  40 ++++++++++
>  6 files changed, 255 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm64/include/asm/pkeys.h
>  create mode 100644 arch/arm64/include/asm/por.h

[...]

> diff --git a/arch/arm64/include/asm/pkeys.h b/arch/arm64/include/asm/pkeys.h
> new file mode 100644
> index 000000000000..a284508a4d02
> --- /dev/null
> +++ b/arch/arm64/include/asm/pkeys.h
> @@ -0,0 +1,110 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2023 Arm Ltd.
> + *
> + * Based on arch/x86/include/asm/pkeys.h
> + */
> +
> +#ifndef _ASM_ARM64_PKEYS_H
> +#define _ASM_ARM64_PKEYS_H
> +
> +#define ARCH_VM_PKEY_FLAGS (VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2)
> +
> +#define arch_max_pkey() 7

Did you mean 8 ?  I'm guessing this may be the "off by one error" you
alluded to in your own reply to the cover letter, but just in case...

(x86 and powerpc seem to have booby-trapped the name of this macro for
the unwary...)

See also mm_pkey_{is_allocated,alloc}().

> +
> +int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
> +		unsigned long init_val);
> +
> +static inline bool arch_pkeys_enabled(void)
> +{
> +	return false;
> +}
> +
> +static inline int vma_pkey(struct vm_area_struct *vma)
> +{
> +	return (vma->vm_flags & ARCH_VM_PKEY_FLAGS) >> VM_PKEY_SHIFT;
> +}
> +
> +static inline int arch_override_mprotect_pkey(struct vm_area_struct *vma,
> +		int prot, int pkey)
> +{
> +	if (pkey != -1)
> +		return pkey;
> +
> +	return vma_pkey(vma);
> +}
> +
> +static inline int execute_only_pkey(struct mm_struct *mm)
> +{
> +	// Execute-only mappings are handled by EPAN/FEAT_PAN3.
> +	WARN_ON_ONCE(!cpus_have_final_cap(ARM64_HAS_EPAN));
> +
> +	return -1;
> +}
> +
> +#define mm_pkey_allocation_map(mm)	(mm->context.pkey_allocation_map)

Pedantic nit: (mm)

although other arches have the same nit already, and it's probably low
risk given the scope and usage of these macros.

(Also, the outer parentheses are also redundant (if harmless).)

> +#define mm_set_pkey_allocated(mm, pkey) do {		\
> +	mm_pkey_allocation_map(mm) |= (1U << pkey);	\
> +} while (0)
> +#define mm_set_pkey_free(mm, pkey) do {			\
> +	mm_pkey_allocation_map(mm) &= ~(1U << pkey);	\
> +} while (0)
> +
> +static inline bool mm_pkey_is_allocated(struct mm_struct *mm, int pkey)
> +{
> +	/*
> +	 * "Allocated" pkeys are those that have been returned
> +	 * from pkey_alloc() or pkey 0 which is allocated
> +	 * implicitly when the mm is created.
> +	 */
> +	if (pkey < 0)
> +		return false;
> +	if (pkey >= arch_max_pkey())
> +		return false;

Did you mean > ?

> +
> +	return mm_pkey_allocation_map(mm) & (1U << pkey);
> +}
> +
> +/*
> + * Returns a positive, 3-bit key on success, or -1 on failure.
> + */
> +static inline int mm_pkey_alloc(struct mm_struct *mm)
> +{
> +	/*
> +	 * Note: this is the one and only place we make sure
> +	 * that the pkey is valid as far as the hardware is
> +	 * concerned.  The rest of the kernel trusts that
> +	 * only good, valid pkeys come out of here.
> +	 */
> +	u8 all_pkeys_mask = ((1U << arch_max_pkey()) - 1);

Nit: redundant outer ().

Also, GENMASK() and friends might be cleaner that spelling out this
idiom explicitly (but no big deal).

(1 << 7) - 1 is 0x7f, which doesn't feel right if pkeys 0..7 are all
supposed to be valid.  (See arch_max_pkey() above.)


(Also it looks mildly weird to have this before checking
arch_pkeys_enabled(), but since this is likely to be constant-folded by
the compiler, I guess it almost certainly makes no difference.  It's
harmless either way.)

> +	int ret;
> +
> +	if (!arch_pkeys_enabled())
> +		return -1;
> +
> +	/*
> +	 * Are we out of pkeys?  We must handle this specially
> +	 * because ffz() behavior is undefined if there are no
> +	 * zeros.
> +	 */
> +	if (mm_pkey_allocation_map(mm) == all_pkeys_mask)
> +		return -1;
> +
> +	ret = ffz(mm_pkey_allocation_map(mm));
> +
> +	mm_set_pkey_allocated(mm, ret);
> +
> +	return ret;
> +}
> +
> +static inline int mm_pkey_free(struct mm_struct *mm, int pkey)
> +{
> +	if (!mm_pkey_is_allocated(mm, pkey))
> +		return -EINVAL;

Does anything prevent a pkey_free(0)?

I couldn't find any check related to this so far.

If not, this may be a generic problem, better solved through a wrapper
in the generic mm code.

Userspace has to have at least one PKEY allocated, since the pte field
has to be set to something...  unless we turn PKEYs on or off per mm.
But the pkeys API doesn't seem to be designed that way (and it doesn't
look very useful).


> +
> +	mm_set_pkey_free(mm, pkey);
> +
> +	return 0;
> +}
> +
> +#endif /* _ASM_ARM64_PKEYS_H */
> diff --git a/arch/arm64/include/asm/por.h b/arch/arm64/include/asm/por.h
> new file mode 100644
> index 000000000000..d6604e0c5c54
> --- /dev/null
> +++ b/arch/arm64/include/asm/por.h
> @@ -0,0 +1,33 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2023 Arm Ltd.
> + */
> +
> +#ifndef _ASM_ARM64_POR_H
> +#define _ASM_ARM64_POR_H
> +
> +#define POR_BITS_PER_PKEY		4
> +#define POR_ELx_IDX(por_elx, idx)	(((por_elx) >> (idx * POR_BITS_PER_PKEY)) & 0xf)

Nit: (idx)

Since this is shared with other code in a header, it's probably best
to avoid surprises.

[...]

> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 495b732d5af3..e50ccc86d150 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -25,6 +25,7 @@
>  #include <linux/vmalloc.h>
>  #include <linux/set_memory.h>
>  #include <linux/kfence.h>
> +#include <linux/pkeys.h>
>  
>  #include <asm/barrier.h>
>  #include <asm/cputype.h>
> @@ -1535,3 +1536,42 @@ void __cpu_replace_ttbr1(pgd_t *pgdp, bool cnp)
>  
>  	cpu_uninstall_idmap();
>  }
> +
> +#ifdef CONFIG_ARCH_HAS_PKEYS
> +int arch_set_user_pkey_access(struct task_struct *tsk, int pkey, unsigned long init_val)
> +{
> +	u64 new_por = POE_RXW;
> +	u64 old_por;
> +	u64 pkey_shift;
> +
> +	if (!arch_pkeys_enabled())
> +		return -ENOSPC;
> +
> +	/*
> +	 * This code should only be called with valid 'pkey'
> +	 * values originating from in-kernel users.  Complain
> +	 * if a bad value is observed.
> +	 */
> +	if (WARN_ON_ONCE(pkey >= arch_max_pkey()))
> +		return -EINVAL;
> +
> +	/* Set the bits we need in POR:  */
> +	if (init_val & PKEY_DISABLE_ACCESS)
> +		new_por = POE_X;
> +	else if (init_val & PKEY_DISABLE_WRITE)
> +		new_por = POE_RX;
> +
> +	/* Shift the bits in to the correct place in POR for pkey: */
> +	pkey_shift = pkey * POR_BITS_PER_PKEY;
> +	new_por <<= pkey_shift;
> +
> +	/* Get old POR and mask off any old bits in place: */
> +	old_por = read_sysreg_s(SYS_POR_EL0);
> +	old_por &= ~(POE_MASK << pkey_shift);
> +
> +	/* Write old part along with new part: */
> +	write_sysreg_s(old_por | new_por, SYS_POR_EL0);
> +
> +	return 0;
> +}
> +#endif

<bikeshed>

Although this is part of the existing PKEYS support, it feels weird to
have to initialise the permissions with one interface and one set of
flags, then change the permissions using an arch-specific interface and
a different set of flags (i.e., directly writing POR_EL0) later on.

Is there any merit in defining a vDSO function for changing the flags in
userspace?  This would allow userspace to use PKEYS in a generic way
without a nasty per-arch volatile asm hack.  

(Maybe too late for stopping user libraries rolling their own, though.)


Since we ideally don't want to write the above flags-mungeing code
twice, there would be the option of implementing pkey_alloc() via a
vDSO wrapper on arm64 (though this might be more trouble than it is
worth).

Of course, this is all pointless if people thought that even the
overhead of a vDSO call was unacceptable for flipping the permissions
on and off.  Either way, this is a potential enhancement, orthogonal to
this series...

</bikeshed>

[...]

Cheers
---Dave

