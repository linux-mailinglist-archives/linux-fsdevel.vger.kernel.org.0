Return-Path: <linux-fsdevel+bounces-47508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C2AA9EDA9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 12:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FA5317AE10
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 10:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E2B25F98A;
	Mon, 28 Apr 2025 10:14:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8C0254879;
	Mon, 28 Apr 2025 10:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745835252; cv=none; b=La43n52UHJmp0uXpS2M88XiK7YS7h/DzwIR8cmXJOzKfZZGihCDy6tPCduofwP+D0l9QWcmSr5RpM5eKPBuI5574nDd6VbVoOreIRMS4n1itaZCaMqCRX3zL3s7+4uAH5mkLwOMWpKgsATarjzSVGx8Bn2zUGoRc5NcGjYlbyIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745835252; c=relaxed/simple;
	bh=HkTNp77Xv/WN2djASSapKS/GGL9ub1ZggUCpE1DQWh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vug9UmuKQXC9hfYfh4sSCqRV/lDdVoDjpYBBwPRtXZzpPrHM3XMH5TgwX7uxJ6pIunOviTZh7MHaHvUnOcheeuMsd8bCLpfaP1h+YfIHAW7Xp59PtCqXTpZxLaLhHRrqSfLnFJYO1cdpxQpn8wtGrJlaCo9FGlohLDZ/5RH3hEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E9DC1595;
	Mon, 28 Apr 2025 03:14:03 -0700 (PDT)
Received: from [10.57.90.155] (unknown [10.57.90.155])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33D603F66E;
	Mon, 28 Apr 2025 03:14:08 -0700 (PDT)
Message-ID: <ad6b492c-cf5e-42ec-b772-52e74238483b@arm.com>
Date: Mon, 28 Apr 2025 11:14:06 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] binfmt_elf: Move brk for static PIE even if ASLR disabled
Content-Language: en-GB
To: Kees Cook <kees@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, Ali Saidi <alisaidi@amazon.com>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250425224502.work.520-kees@kernel.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250425224502.work.520-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/04/2025 23:45, Kees Cook wrote:
> In commit bbdc6076d2e5 ("binfmt_elf: move brk out of mmap when doing
> direct loader exec"), the brk was moved out of the mmap region when
> loading static PIE binaries (ET_DYN without INTERP). The common case
> for these binaries was testing new ELF loaders, so the brk needed to
> be away from mmap to avoid colliding with stack, future mmaps (of the
> loader-loaded binary), etc. But this was only done when ASLR was enabled,
> in an attempt to minimize changes to memory layouts.

If it's ok to move the brk to low memory for the !INTERP case, why is it not ok
to just load the whole program in low memory? Perhaps if the thing that is being
loaded does turn out to be the interpretter then it will move the brk to just
after to the program it loads so there is no conflict (I'm just guessing).

> 
> After adding support to respect alignment requirements for static PIE
> binaries in commit 3545deff0ec7 ("binfmt_elf: Honor PT_LOAD alignment
> for static PIE"), it became possible to have a large gap after the
> final PT_LOAD segment and the top of the mmap region. This means that
> future mmap allocations might go after the last PT_LOAD segment (where
> brk might be if ASLR was disabled) instead of before them (where they
> traditionally ended up).
> 
> On arm64, running with ASLR disabled, Ubuntu 22.04's "ldconfig" binary,
> a static PIE, has alignment requirements that leaves a gap large enough
> after the last PT_LOAD segment to fit the vdso and vvar, but still leave
> enough space for the brk (which immediately follows the last PT_LOAD
> segment) to be allocated by the binary.
> 
> fffff7f20000-fffff7fde000 r-xp 00000000 fe:02 8110426 /home/ubuntu/glibc-2.35/build/elf/ldconfig
> fffff7fee000-fffff7ff5000 rw-p 000be000 fe:02 8110426 /home/ubuntu/glibc-2.35/build/elf/ldconfig

nit: I captured this with a locally built version that has debug symbols, hence
the weird "/home/ubuntu/glibc-2.35/build/elf/ldconfig" path. Perhaps it is
clearer to change this to "/sbin/ldconfig.real", which is the system installed
location?

> fffff7ff5000-fffff7ffa000 rw-p 00000000 00:00 0
> ***[brk will go here at fffff7ffa000]***
> fffff7ffc000-fffff7ffe000 r--p 00000000 00:00 0       [vvar]
> fffff7ffe000-fffff8000000 r-xp 00000000 00:00 0       [vdso]
> fffffffdf000-1000000000000 rw-p 00000000 00:00 0      [stack]
> 
> After commit 0b3bc3354eb9 ("arm64: vdso: Switch to generic storage
> implementation"), the arm64 vvar grew slightly, and suddenly the brk
> collided with the allocation.
> 
> fffff7f20000-fffff7fde000 r-xp 00000000 fe:02 8110426 /home/ubuntu/glibc-2.35/build/elf/ldconfig
> fffff7fee000-fffff7ff5000 rw-p 000be000 fe:02 8110426 /home/ubuntu/glibc-2.35/build/elf/ldconfig
> fffff7ff5000-fffff7ffa000 rw-p 00000000 00:00 0
> ***[oops, no room any more, vvar is at fffff7ffa000!]***
> fffff7ffa000-fffff7ffe000 r--p 00000000 00:00 0       [vvar]
> fffff7ffe000-fffff8000000 r-xp 00000000 00:00 0       [vdso]
> fffffffdf000-1000000000000 rw-p 00000000 00:00 0      [stack]
> 
> The solution is to unconditionally move the brk out of the mmap region
> for static PIE binaries. Whether ASLR is enabled or not does not change if
> there may be future mmap allocation collisions with a growing brk region.
> 
> Update memory layout comments (with kernel-doc headings), consolidate
> the setting of mm->brk to later (it isn't needed early), move static PIE
> brk out of mmap unconditionally, and make sure brk(2) knows to base brk
> position off of mm->start_brk not mm->end_data no matter what the cause of
> moving it is (via current->brk_randomized). (Though why isn't this always
> just start_brk? More research is needed, but leave that alone for now.)
> 
> Reported-by: Ryan Roberts <ryan.roberts@arm.com>
> Closes: https://lore.kernel.org/lkml/f93db308-4a0e-4806-9faf-98f890f5a5e6@arm.com/
> Fixes: bbdc6076d2e5 ("binfmt_elf: move brk out of mmap when doing direct loader exec")
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: <linux-fsdevel@vger.kernel.org>
> Cc: <linux-mm@kvack.org>
> ---
>  fs/binfmt_elf.c | 67 +++++++++++++++++++++++++++++++------------------
>  1 file changed, 43 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 584fa89bc877..26c87d076adb 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -830,6 +830,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  	struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata = NULL;
>  	struct elf_phdr *elf_property_phdata = NULL;
>  	unsigned long elf_brk;
> +	bool brk_moved = false;
>  	int retval, i;
>  	unsigned long elf_entry;
>  	unsigned long e_entry;
> @@ -1097,15 +1098,19 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  			/* Calculate any requested alignment. */
>  			alignment = maximum_alignment(elf_phdata, elf_ex->e_phnum);
>  
> -			/*
> -			 * There are effectively two types of ET_DYN
> -			 * binaries: programs (i.e. PIE: ET_DYN with PT_INTERP)
> -			 * and loaders (ET_DYN without PT_INTERP, since they
> -			 * _are_ the ELF interpreter). The loaders must
> -			 * be loaded away from programs since the program
> -			 * may otherwise collide with the loader (especially
> -			 * for ET_EXEC which does not have a randomized
> -			 * position). For example to handle invocations of
> +			/**
> +			 * DOC: PIE handling
> +			 *
> +			 * There are effectively two types of ET_DYN ELF
> +			 * binaries: programs (i.e. PIE: ET_DYN with
> +			 * PT_INTERP) and loaders (i.e. static PIE: ET_DYN
> +			 * without PT_INTERP, usually the ELF interpreter
> +			 * itself). Loaders must be loaded away from programs
> +			 * since the program may otherwise collide with the
> +			 * loader (especially for ET_EXEC which does not have
> +			 * a randomized position).
> +			 *
> +			 * For example, to handle invocations of
>  			 * "./ld.so someprog" to test out a new version of
>  			 * the loader, the subsequent program that the
>  			 * loader loads must avoid the loader itself, so
> @@ -1118,6 +1123,9 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  			 * ELF_ET_DYN_BASE and loaders are loaded into the
>  			 * independently randomized mmap region (0 load_bias
>  			 * without MAP_FIXED nor MAP_FIXED_NOREPLACE).
> +			 *
> +			 * See below for "brk" handling details, which is
> +			 * also affected by program vs loader and ASLR.
>  			 */
>  			if (interpreter) {
>  				/* On ET_DYN with PT_INTERP, we do the ASLR. */
> @@ -1234,8 +1242,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  	start_data += load_bias;
>  	end_data += load_bias;
>  
> -	current->mm->start_brk = current->mm->brk = ELF_PAGEALIGN(elf_brk);
> -
>  	if (interpreter) {
>  		elf_entry = load_elf_interp(interp_elf_ex,
>  					    interpreter,
> @@ -1291,27 +1297,40 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  	mm->end_data = end_data;
>  	mm->start_stack = bprm->p;
>  
> -	if ((current->flags & PF_RANDOMIZE) && (snapshot_randomize_va_space > 1)) {
> +	/**
> +	 * DOC: "brk" handling
> +	 *
> +	 * For architectures with ELF randomization, when executing a
> +	 * loader directly (i.e. static PIE: ET_DYN without PT_INTERP),
> +	 * move the brk area out of the mmap region and into the unused
> +	 * ELF_ET_DYN_BASE region. Since "brk" grows up it may collide
> +	 * early with the stack growing down or other regions being put
> +	 * into the mmap region by the kernel (e.g. vdso).
> +	 */
> +	if (IS_ENABLED(CONFIG_ARCH_HAS_ELF_RANDOMIZE) &&

Does this imply that this issue will persist for !CONFIG_ARCH_HAS_ELF_RANDOMIZE
arches?

> +	    elf_ex->e_type == ET_DYN && !interpreter) {
> +		elf_brk = ELF_ET_DYN_BASE;
> +		/* This counts as moving the brk, so let brk(2) know. */
> +		brk_moved = true;

So you are now randomizing the brk regardless of the value of
snapshot_randomize_va_space. I suggested this as a potential solution but was
concerned about back-compat issues. See this code snippet from memory.c:

----8<----
/*
 * Randomize the address space (stacks, mmaps, brk, etc.).
 *
 * ( When CONFIG_COMPAT_BRK=y we exclude brk from randomization,
 *   as ancient (libc5 based) binaries can segfault. )
 */
int randomize_va_space __read_mostly =
#ifdef CONFIG_COMPAT_BRK
					1;
#else
					2;
#endif
----8<----

This implies to me that this change is in danger of breaking libc5-based binaries?

Thanks,
Ryan

> +	}
> +	mm->start_brk = mm->brk = ELF_PAGEALIGN(elf_brk);
> +
> +	if ((current->flags & PF_RANDOMIZE) && snapshot_randomize_va_space > 1) {
>  		/*
> -		 * For architectures with ELF randomization, when executing
> -		 * a loader directly (i.e. no interpreter listed in ELF
> -		 * headers), move the brk area out of the mmap region
> -		 * (since it grows up, and may collide early with the stack
> -		 * growing down), and into the unused ELF_ET_DYN_BASE region.
> +		 * If we didn't move the brk to ELF_ET_DYN_BASE (above),
> +		 * leave a gap between .bss and brk.
>  		 */
> -		if (IS_ENABLED(CONFIG_ARCH_HAS_ELF_RANDOMIZE) &&
> -		    elf_ex->e_type == ET_DYN && !interpreter) {
> -			mm->brk = mm->start_brk = ELF_ET_DYN_BASE;
> -		} else {
> -			/* Otherwise leave a gap between .bss and brk. */
> +		if (!brk_moved)
>  			mm->brk = mm->start_brk = mm->brk + PAGE_SIZE;
> -		}
>  
>  		mm->brk = mm->start_brk = arch_randomize_brk(mm);
> +		brk_moved = true;
> +	}
> +
>  #ifdef compat_brk_randomized
> +	if (brk_moved)
>  		current->brk_randomized = 1;
>  #endif
> -	}
>  
>  	if (current->personality & MMAP_PAGE_ZERO) {
>  		/* Why this, you ask???  Well SVr4 maps page 0 as read-only,


