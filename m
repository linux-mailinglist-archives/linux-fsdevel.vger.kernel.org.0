Return-Path: <linux-fsdevel+bounces-56877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A26B1CC39
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 20:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 929A9565D84
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 18:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5166529E0F2;
	Wed,  6 Aug 2025 18:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5DgpZMb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E2DC8EB;
	Wed,  6 Aug 2025 18:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754506653; cv=none; b=R2a7mOmuPTEh4EiFDzREYUyPU5zEJejYW/gEgzdwi4PFTPWJFtFH7htW0uVRrhB6W4bL8aZCe45d9CZFYwUtgvvbFWnLbB3mn0upQPLYbWdImhmu6wjo0jM2mZqRGoTP4FEeNP/YMlJANhWfKjlsuzh54RW44nzV48dVTYn16GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754506653; c=relaxed/simple;
	bh=S1tpOXHvVmGvkkUcDTVIht6ckWqyaRnBwEeo7jDPZu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mcYKk9Hefu9GBKvmaFc9r1/KYd5EWdzNi7y4GpWmVWhBCgSh4DvMtqGgVYaNjS7nL/y0RyNZC+RQ0hoYyeq5u3ihitrOevM6GSs/oHVIONtWXsZFnaOHa6P2yU9otb9MWepejLU4f/5TkMzzcR0qYbhF0b95NTcpE6PZrq6ud7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5DgpZMb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC07C4CEE7;
	Wed,  6 Aug 2025 18:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754506653;
	bh=S1tpOXHvVmGvkkUcDTVIht6ckWqyaRnBwEeo7jDPZu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u5DgpZMbBrMlEHCD0U2XV9oAFeSNwqE2saBD4NroNIwSwfQOb6fR/e+Hj+9dkXYza
	 GSdnwVTypo0RrO1uPIi9p5Gqgw4zsLp9qhaHYpo0fGtuA457QbxgTpNfPio863LrTQ
	 eE/2/ZbnCVJ75QckPgb1x3qVBiirfktGC62Y/rdLagTJEQ1cwOQrfn77EHN7tACR6k
	 bOOrjC0euY0CI30rXkLWpEgVVxW8u1x8ZX5SED+CC6sycNRZn8b0Rl7vZF3GvgW088
	 63MpRrSxhEIoxOV5Y40cqoToFFG/aWeNYTEWMcnI74UVv+t4xrHm5jhdGDglSVCJ2Q
	 mlvn4La0hLeiw==
Date: Wed, 6 Aug 2025 11:57:32 -0700
From: Kees Cook <kees@kernel.org>
To: Svetlana Parfenova <svetlana.parfenova@syntacore.com>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, akpm@linux-foundation.org,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com
Subject: Re: [RFC RESEND] binfmt_elf: preserve original ELF e_flags in core
 dumps
Message-ID: <202508061152.6B26BDC6FB@keescook>
References: <20250806161814.607668-1-svetlana.parfenova@syntacore.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806161814.607668-1-svetlana.parfenova@syntacore.com>

On Wed, Aug 06, 2025 at 10:18:14PM +0600, Svetlana Parfenova wrote:
> Preserve the original ELF e_flags from the executable in the core dump
> header instead of relying on compile-time defaults (ELF_CORE_EFLAGS or
> value from the regset view). This ensures that ABI-specific flags in
> the dump file match the actual binary being executed.
> 
> Save the e_flags field during ELF binary loading (in load_elf_binary())
> into the mm_struct, and later retrieve it during core dump generation
> (in fill_note_info()). Use this saved value to populate the e_flags in
> the core dump ELF header.
> 
> Add a new Kconfig option, CONFIG_CORE_DUMP_USE_PROCESS_EFLAGS, to guard
> this behavior. Although motivated by a RISC-V use case, the mechanism is
> generic and can be applied to all architectures.

In the general case, is e_flags mismatched? i.e. why hide this behind a
Kconfig? Put another way, if I enabled this Kconfig and dumped core from
some regular x86_64 process, will e_flags be different?

> This change is needed to resolve a debugging issue encountered when
> analyzing core dumps with GDB for RISC-V systems. GDB inspects the
> e_flags field to determine whether optional register sets such as the
> floating-point unit are supported. Without correct flags, GDB may warn
> and ignore valid register data:
> 
>     warning: Unexpected size of section '.reg2/213' in core file.
> 
> As a result, floating-point registers are not accessible in the debugger,
> even though they were dumped. Preserving the original e_flags enables
> GDB and other tools to properly interpret the dump contents.
> 
> Signed-off-by: Svetlana Parfenova <svetlana.parfenova@syntacore.com>
> ---
>  fs/Kconfig.binfmt        |  9 +++++++++
>  fs/binfmt_elf.c          | 26 ++++++++++++++++++++------
>  include/linux/mm_types.h |  5 +++++
>  3 files changed, 34 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
> index bd2f530e5740..45bed2041542 100644
> --- a/fs/Kconfig.binfmt
> +++ b/fs/Kconfig.binfmt
> @@ -184,4 +184,13 @@ config EXEC_KUNIT_TEST
>  	  This builds the exec KUnit tests, which tests boundary conditions
>  	  of various aspects of the exec internals.
>  
> +config CORE_DUMP_USE_PROCESS_EFLAGS
> +	bool "Preserve ELF e_flags from executable in core dumps"
> +	depends on BINFMT_ELF && ELF_CORE && RISCV
> +	default n
> +	help
> +	  Save the ELF e_flags from the process executable at load time
> +	  and use it in the core dump header. This ensures the dump reflects
> +	  the original binary ABI.
> +
>  endmenu
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index caeddccaa1fe..e5e06e11f9fc 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -1290,6 +1290,11 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  	mm->end_data = end_data;
>  	mm->start_stack = bprm->p;
>  
> +#ifdef CONFIG_CORE_DUMP_USE_PROCESS_EFLAGS
> +	/* stash e_flags for use in core dumps */
> +	mm->saved_e_flags = elf_ex->e_flags;
> +#endif

Is this structure actually lost during ELF load? I thought we preserved
some more of the ELF headers during load...

> +
>  	/**
>  	 * DOC: "brk" handling
>  	 *
> @@ -1804,6 +1809,8 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
>  	struct elf_thread_core_info *t;
>  	struct elf_prpsinfo *psinfo;
>  	struct core_thread *ct;
> +	u16 machine;
> +	u32 flags;
>  
>  	psinfo = kmalloc(sizeof(*psinfo), GFP_KERNEL);
>  	if (!psinfo)
> @@ -1831,17 +1838,24 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
>  		return 0;
>  	}
>  
> -	/*
> -	 * Initialize the ELF file header.
> -	 */
> -	fill_elf_header(elf, phdrs,
> -			view->e_machine, view->e_flags);
> +	machine = view->e_machine;
> +	flags = view->e_flags;
>  #else
>  	view = NULL;
>  	info->thread_notes = 2;
> -	fill_elf_header(elf, phdrs, ELF_ARCH, ELF_CORE_EFLAGS);
> +	machine = ELF_ARCH;
> +	flags = ELF_CORE_EFLAGS;
>  #endif
>  
> +#ifdef CONFIG_CORE_DUMP_USE_PROCESS_EFLAGS
> +	flags = dump_task->mm->saved_e_flags;
> +#endif

This appears to clobber the value from view->e_flags. Is that right? It
feels like this change should only be needed in the default
ELF_CORE_EFLAGS case. How is view->e_flags normally set?

> +
> +	/*
> +	 * Initialize the ELF file header.
> +	 */
> +	fill_elf_header(elf, phdrs, machine, flags);
> +
>  	/*
>  	 * Allocate a structure for each thread.
>  	 */
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index d6b91e8a66d6..39921b32e4f5 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1098,6 +1098,11 @@ struct mm_struct {
>  
>  		unsigned long saved_auxv[AT_VECTOR_SIZE]; /* for /proc/PID/auxv */
>  
> +#ifdef CONFIG_CORE_DUMP_USE_PROCESS_EFLAGS
> +		/* the ABI-related flags from the ELF header. Used for core dump */
> +		unsigned long saved_e_flags;
> +#endif
> +
>  		struct percpu_counter rss_stat[NR_MM_COUNTERS];
>  
>  		struct linux_binfmt *binfmt;
> -- 
> 2.50.1
> 

-Kees

-- 
Kees Cook

