Return-Path: <linux-fsdevel+bounces-59110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72151B34872
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 19:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 280C73A9AF6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 17:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C483019AC;
	Mon, 25 Aug 2025 17:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4UkVnPS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064023009DB;
	Mon, 25 Aug 2025 17:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756142228; cv=none; b=gpbVVpw0B9F9kRwF4QLCL/PvLNpa9ZTEkrTfIpUoM5jOKu8Wzgo6lZxyouXeHy+4y+yJqDPD9cdoMvjwmAiVdhmj8/pVVKy6/+bwN/dwlMXQ9ZLt26bRxol2wjLnCE10ObrCNSuyhhBXbYyMIR4a0pAz+ooZpJiqBTE+EsOcBQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756142228; c=relaxed/simple;
	bh=fanRgUaxIj09krYa7fxG1OndohAbT5Q13tqT+sXc9hY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCezz4b6KaWLmTOkPqlpf5GLlkKFLZsZ3o5h9Y6NA7AaGS3k42VWbCtY1NGinaqJNWXkSEUBMKrAvjdIMjFJadV06nQK3WOWv9ADfbUTwU6wfhOMjvw8cypOiAnGbVLJl36FKT/iN2gkmur/bcyhJFeUMPX9AHiKHVxROG5zt6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4UkVnPS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73417C4CEED;
	Mon, 25 Aug 2025 17:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756142227;
	bh=fanRgUaxIj09krYa7fxG1OndohAbT5Q13tqT+sXc9hY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f4UkVnPSVEy/q7m+lriWEU0OD6KJ183jkCaMpnxprhCPsumeklpe/KAiUrRlV189T
	 R2zLcPPXieceyDBHOKhOQj2p8Q+9XFUvH5E9NAfqL4jIPPHA8edNeR6UXP0JTP5GnI
	 EO92FF3+tJDd9Wef2UOYZ8xEmgplHwL/VNC/JEWmIBHC8tKCq03lbc4BZFXQlD2smz
	 VBXcH3TUsC000gZHAq8aAtG89ZQIIb6+kE2LMrZHbsy4IBT8HNRStju185P0h6PZa6
	 t/uEq1AS0DIVbznf1/KhrFGO+GFh1CkOSdqynrzXsxFtzaIjyHd7BDIrU2Ol43ZNlb
	 q3Y4pbpqugNIQ==
Date: Mon, 25 Aug 2025 10:17:07 -0700
From: Kees Cook <kees@kernel.org>
To: Svetlana Parfenova <svetlana.parfenova@syntacore.com>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, akpm@linux-foundation.org,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com
Subject: Re: [RFC RESEND v2] binfmt_elf: preserve original ELF e_flags for
 core dumps
Message-ID: <202508251009.CB5EB2E304@keescook>
References: <20250806161814.607668-1-svetlana.parfenova@syntacore.com>
 <20250811095328.256869-1-svetlana.parfenova@syntacore.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811095328.256869-1-svetlana.parfenova@syntacore.com>

On Mon, Aug 11, 2025 at 03:53:28PM +0600, Svetlana Parfenova wrote:
> Some architectures, such as RISC-V, use the ELF e_flags field to encode
> ABI-specific information (e.g., ISA extensions, fpu support). Debuggers
> like GDB rely on these flags in core dumps to correctly interpret
> optional register sets. If the flags are missing or incorrect, GDB may
> warn and ignore valid data, for example:
> 
>     warning: Unexpected size of section '.reg2/213' in core file.
> 
> This can prevent access to fpu or other architecture-specific registers
> even when they were dumped.
> 
> Save the e_flags field during ELF binary loading (in load_elf_binary())
> into the mm_struct, and later retrieve it during core dump generation
> (in fill_note_info()). A new macro ELF_CORE_USE_PROCESS_EFLAGS allows
> architectures to enable this behavior - currently just RISC-V.
> 
> Signed-off-by: Svetlana Parfenova <svetlana.parfenova@syntacore.com>
> ---
> Changes in v2:
>  - Remove usage of Kconfig option.
>  - Add an architecture-optional macro to set process e_flags. Enabled
>    by defining ELF_CORE_USE_PROCESS_EFLAGS. Defaults to no-op if not
>    used.
> 
>  arch/riscv/include/asm/elf.h |  1 +
>  fs/binfmt_elf.c              | 34 ++++++++++++++++++++++++++++------
>  include/linux/mm_types.h     |  3 +++
>  3 files changed, 32 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
> index c7aea7886d22..5d9f0ac851ee 100644
> --- a/arch/riscv/include/asm/elf.h
> +++ b/arch/riscv/include/asm/elf.h
> @@ -20,6 +20,7 @@
>   * These are used to set parameters in the core dumps.
>   */
>  #define ELF_ARCH	EM_RISCV
> +#define ELF_CORE_USE_PROCESS_EFLAGS

Let's move this to the per-arch Kconfig instead, that way we can use it
in other places. Maybe call in CONFIG_ARCH_HAS_ELF_CORE_EFLAGS?

>  
>  #ifndef ELF_CLASS
>  #ifdef CONFIG_64BIT
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index caeddccaa1fe..e52b1e077218 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -66,6 +66,14 @@
>  #define elf_check_fdpic(ex) false
>  #endif
>  
> +#ifdef ELF_CORE_USE_PROCESS_EFLAGS
> +#define elf_coredump_get_process_eflags(dump_task, e_flags) \
> +	(*(e_flags) = (dump_task)->mm->saved_e_flags)
> +#else
> +#define elf_coredump_get_process_eflags(dump_task, e_flags) \
> +	do { (void)(dump_task); (void)(e_flags); } while (0)
> +#endif

Let's make specific set/get helpers here, instead.

static inline
u32 coredump_get_mm_eflags(struct mm_struct *mm, u32 flags)
{
#ifdef CONFIG_ARCH_HAS_ELF_CORE_EFLAGS
	flags = mm->saved_e_flags;
#else
	return flags;
}

static inline
void coredump_set_mm_eflags(struct mm_struct *mm, u32 flags)
{
#ifdef CONFIG_ARCH_HAS_ELF_CORE_EFLAGS
	mm->saved_e_flags = flags;
#endif
}


> +
>  static int load_elf_binary(struct linux_binprm *bprm);
>  
>  /*
> @@ -1290,6 +1298,9 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  	mm->end_data = end_data;
>  	mm->start_stack = bprm->p;
>  
> +	/* stash e_flags for use in core dumps */
> +	mm->saved_e_flags = elf_ex->e_flags;

Then this is:

	coredump_set_mm_eflags(mm, elf_ex->e_flags);

> +
>  	/**
>  	 * DOC: "brk" handling
>  	 *
> @@ -1804,6 +1815,8 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
>  	struct elf_thread_core_info *t;
>  	struct elf_prpsinfo *psinfo;
>  	struct core_thread *ct;
> +	u16 machine;
> +	u32 flags;
>  
>  	psinfo = kmalloc(sizeof(*psinfo), GFP_KERNEL);
>  	if (!psinfo)
> @@ -1831,17 +1844,26 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
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
> +	/*
> +	 * Override ELF e_flags with value taken from process,
> +	 * if arch wants to.
> +	 */
> +	elf_coredump_get_process_eflags(dump_task, &flags);

And this is:

	flags = coredump_get_mm_eflags(dump_task->mm, flags);

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
> index d6b91e8a66d6..e46f554f8d91 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1098,6 +1098,9 @@ struct mm_struct {
>  
>  		unsigned long saved_auxv[AT_VECTOR_SIZE]; /* for /proc/PID/auxv */
>  

And then add:

#ifdef CONFIG_ARCH_HAS_ELF_CORE_EFLAGS

> +		/* the ABI-related flags from the ELF header. Used for core dump */
> +		unsigned long saved_e_flags;

#endif

around this part

> +
>  		struct percpu_counter rss_stat[NR_MM_COUNTERS];
>  
>  		struct linux_binfmt *binfmt;
> -- 
> 2.50.1
> 

-- 
Kees Cook

