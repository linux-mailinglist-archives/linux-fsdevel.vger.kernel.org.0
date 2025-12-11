Return-Path: <linux-fsdevel+bounces-71090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4A4CB540E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 09:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D5757302620D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 08:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E97D2FD7D2;
	Thu, 11 Dec 2025 08:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJ0iyKYn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69BB2F616F;
	Thu, 11 Dec 2025 08:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765442876; cv=none; b=WMwIFLr1cZ47DL9ncA9o+QThZR4Md64GQS1qGjnPC3E4qeLxXE0NH557JTNOe8O4oVFnMHH2sYpwB8a6B1RrB0g8FbLqG1rJflXTncW2+S/TT84mJTSydxJaLXmhMdu6JmfSsXJEqEUrYHgHz7QLb2rO2axYaOq1MNSKmRLXVCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765442876; c=relaxed/simple;
	bh=j9P0IoM2VBePZSGPEbquteAAJ7kda9NDqMa0x5DcGEA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=r8g0c1rN2oJ6zLO4JwIeKsIkGzAo1I4rN2dbOF0zODkwNbxol0s3M2/IyJVIVobqJ3LbrbdrlfhZp3dy45xSangwg6+4yO4sxJQp52ktXHAZsLbpRbK4CmgAs1+kuSd+4idm4UfPrPgbzyPsbPYO+XRSfEHfJVlJY3QdYOU7if0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJ0iyKYn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193FAC116B1;
	Thu, 11 Dec 2025 08:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765442876;
	bh=j9P0IoM2VBePZSGPEbquteAAJ7kda9NDqMa0x5DcGEA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=bJ0iyKYn09dnRksKbPpgQmWootITzm8qVZhTdWApSd9uvdsPxcVhV7mIhnSB0VyVw
	 CdEpBfzhw5XdXRzCX9L82VIBXUczNVsYnFc+ucOJzF19XzZO4VMQX1ADrokC2/oDkG
	 9ggl9wYfnF3lz9Wq/njMYTLjJ/x3PDVZXo/1+OL3UU1Y15RmT4rH6q2uX5k5y1gEq4
	 bXiHzR1v1YiwnkitVB0pZDC4IYcpMPOr3pD98vZCRK2y4L5RtPmrkNnkeRFxC6vyBl
	 w1uq9/KBI2S5tSZuzi3PpZkt3/5F8hLa3tInVhJ2Nr+1Cz/Q0Z9YXPlNYbezWTsly6
	 4Jlt9kQkWrogQ==
Date: Thu, 11 Dec 2025 01:47:42 -0700 (MST)
From: Paul Walmsley <pjw@kernel.org>
To: Deepak Gupta <debug@rivosinc.com>
cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
    Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
    x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
    Vlastimil Babka <vbabka@suse.cz>, 
    Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
    Paul Walmsley <paul.walmsley@sifive.com>, 
    Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
    Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
    Christian Brauner <brauner@kernel.org>, 
    Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, 
    Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
    Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
    Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>, 
    Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
    Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
    =?ISO-8859-15?Q?Bj=F6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
    Andreas Hindborg <a.hindborg@kernel.org>, 
    Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
    Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org, 
    linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
    linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
    linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
    linux-kselftest@vger.kernel.org, alistair.francis@wdc.com, 
    richard.henderson@linaro.org, jim.shu@sifive.com, andybnac@gmail.com, 
    kito.cheng@sifive.com, charlie@rivosinc.com, atishp@rivosinc.com, 
    evan@rivosinc.com, cleger@rivosinc.com, alexghiti@rivosinc.com, 
    samitolvanen@google.com, broonie@kernel.org, rick.p.edgecombe@intel.com, 
    rust-for-linux@vger.kernel.org, Zong Li <zong.li@sifive.com>, 
    Andreas Korb <andreas.korb@aisec.fraunhofer.de>, 
    Valentin Haudiquet <valentin.haudiquet@canonical.com>
Subject: Re: [PATCH v25 06/28] riscv/mm : ensure PROT_WRITE leads to VM_READ
 | VM_WRITE
In-Reply-To: <20251205-v5_user_cfi_series-v25-6-1a07c0127361@rivosinc.com>
Message-ID: <b2acb9ca-1320-ab42-3937-2ea17153fac2@kernel.org>
References: <20251205-v5_user_cfi_series-v25-0-1a07c0127361@rivosinc.com> <20251205-v5_user_cfi_series-v25-6-1a07c0127361@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 5 Dec 2025, Deepak Gupta via B4 Relay wrote:

> From: Deepak Gupta <debug@rivosinc.com>
> 
> `arch_calc_vm_prot_bits` is implemented on risc-v to return VM_READ |
> VM_WRITE if PROT_WRITE is specified. Similarly `riscv_sys_mmap` is
> updated to convert all incoming PROT_WRITE to (PROT_WRITE | PROT_READ).
> This is to make sure that any existing apps using PROT_WRITE still work.
> 
> Earlier `protection_map[VM_WRITE]` used to pick read-write PTE encodings.
> Now `protection_map[VM_WRITE]` will always pick PAGE_SHADOWSTACK PTE
> encodings for shadow stack. Above changes ensure that existing apps
> continue to work because underneath kernel will be picking
> `protection_map[VM_WRITE|VM_READ]` PTE encodings.
> 
> Reviewed-by: Zong Li <zong.li@sifive.com>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

This Signed-off-by: doesn't look right.  It doesn't look like Arnd 
developed this patch, and it doesn't appear that he replied with a 
Signed-off-by: to the list regarding a patch that you wrote.  Did I miss 
it?  Did you mean Co-developed-by: or some other tag?

> Tested-by: Andreas Korb <andreas.korb@aisec.fraunhofer.de>
> Tested-by: Valentin Haudiquet <valentin.haudiquet@canonical.com>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  arch/riscv/include/asm/mman.h    | 26 ++++++++++++++++++++++++++
>  arch/riscv/include/asm/pgtable.h |  1 +
>  arch/riscv/kernel/sys_riscv.c    | 10 ++++++++++
>  arch/riscv/mm/init.c             |  2 +-
>  4 files changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/mman.h b/arch/riscv/include/asm/mman.h
> new file mode 100644
> index 000000000000..0ad1d19832eb
> --- /dev/null
> +++ b/arch/riscv/include/asm/mman.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_MMAN_H__
> +#define __ASM_MMAN_H__
> +
> +#include <linux/compiler.h>
> +#include <linux/types.h>
> +#include <linux/mm.h>
> +#include <uapi/asm/mman.h>
> +
> +static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
> +						   unsigned long pkey __always_unused)
> +{
> +	unsigned long ret = 0;
> +
> +	/*
> +	 * If PROT_WRITE was specified, force it to VM_READ | VM_WRITE.
> +	 * Only VM_WRITE means shadow stack.
> +	 */
> +	if (prot & PROT_WRITE)
> +		ret = (VM_READ | VM_WRITE);
> +	return ret;
> +}
> +
> +#define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
> +
> +#endif /* ! __ASM_MMAN_H__ */
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 29e994a9afb6..4c4057a2550e 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -182,6 +182,7 @@ extern struct pt_alloc_ops pt_ops __meminitdata;
>  #define PAGE_READ_EXEC		__pgprot(_PAGE_BASE | _PAGE_READ | _PAGE_EXEC)
>  #define PAGE_WRITE_EXEC		__pgprot(_PAGE_BASE | _PAGE_READ |	\
>  					 _PAGE_EXEC | _PAGE_WRITE)
> +#define PAGE_SHADOWSTACK       __pgprot(_PAGE_BASE | _PAGE_WRITE)
>  
>  #define PAGE_COPY		PAGE_READ
>  #define PAGE_COPY_EXEC		PAGE_READ_EXEC
> diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
> index 795b2e815ac9..22fc9b3268be 100644
> --- a/arch/riscv/kernel/sys_riscv.c
> +++ b/arch/riscv/kernel/sys_riscv.c
> @@ -7,6 +7,7 @@
>  
>  #include <linux/syscalls.h>
>  #include <asm/cacheflush.h>
> +#include <asm-generic/mman-common.h>
>  
>  static long riscv_sys_mmap(unsigned long addr, unsigned long len,
>  			   unsigned long prot, unsigned long flags,
> @@ -16,6 +17,15 @@ static long riscv_sys_mmap(unsigned long addr, unsigned long len,
>  	if (unlikely(offset & (~PAGE_MASK >> page_shift_offset)))
>  		return -EINVAL;
>  
> +	/*
> +	 * If PROT_WRITE is specified then extend that to PROT_READ
> +	 * protection_map[VM_WRITE] is now going to select shadow stack encodings.
> +	 * So specifying PROT_WRITE actually should select protection_map [VM_WRITE | VM_READ]
> +	 * If user wants to create shadow stack then they should use `map_shadow_stack` syscall.
> +	 */
> +	if (unlikely((prot & PROT_WRITE) && !(prot & PROT_READ)))
> +		prot |= PROT_READ;
> +
>  	return ksys_mmap_pgoff(addr, len, prot, flags, fd,
>  			       offset >> (PAGE_SHIFT - page_shift_offset));
>  }
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index d85efe74a4b6..62ab2c7de7c8 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -376,7 +376,7 @@ pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
>  static const pgprot_t protection_map[16] = {
>  	[VM_NONE]					= PAGE_NONE,
>  	[VM_READ]					= PAGE_READ,
> -	[VM_WRITE]					= PAGE_COPY,
> +	[VM_WRITE]					= PAGE_SHADOWSTACK,
>  	[VM_WRITE | VM_READ]				= PAGE_COPY,
>  	[VM_EXEC]					= PAGE_EXEC,
>  	[VM_EXEC | VM_READ]				= PAGE_READ_EXEC,
> 
> -- 
> 2.43.0
> 
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 

