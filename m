Return-Path: <linux-fsdevel+bounces-63303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DE6BB46B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 17:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61D973B6CF6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 15:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FE823A9A8;
	Thu,  2 Oct 2025 15:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hit0hmB/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE88238172;
	Thu,  2 Oct 2025 15:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759420711; cv=none; b=jxn5WIyIoNQuDvR3tKf0JId36YdjHHfZTRXrgf5zuqe1YTM1EiGknKX8UCbxaItA14x6DNWkuRbkwlUp9aNSxV0c3Fq71ltI7YcZqnemgSX3HNvOIMQHIrDL2TT86bSQ0SnqZM87YOX+WnjrI/NteYdCFGQTPnqoU4sb6sscUAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759420711; c=relaxed/simple;
	bh=cilV1O0vUAtuGZGe3YxvO4p8XIFUBSm2PiXuqmpPfBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4cD4mW3SUoFySylwp8gjFbwphDxrlmF57dso+/YUUCXIsBBxlSdtZtIO67nkWw+Fx/oao5soXEXzPUZ0s14z+4lj4WGSFf7jZTlYDRqJS68RuMurwufaj/SZ3T1ps7cuvTm0AiLfphNPa1G8wrZmWlDnzFPyn5dTUgAdtRmu+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hit0hmB/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67594C4CEF4;
	Thu,  2 Oct 2025 15:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759420710;
	bh=cilV1O0vUAtuGZGe3YxvO4p8XIFUBSm2PiXuqmpPfBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hit0hmB/DVeLXD6O/DpSQ8xEhEiP2a3qgSR3d0ryg1junES7D4Ug16orX9gcWc1FL
	 7KJXcq6+R8iaSXx75VrN6/Fj0NrBsmnICuipBoAzUrZOyFaQlWo/mSf0ocxa4Vtkcs
	 78Ve8D/fqKlMM17MRWq/WsjPy83yiUuqOIND8GJayscI6IW4TCQOnHgvT8f9vRpNvu
	 8GQTYZeYvAD3pjerLq4odG28Z6yW36sPZ3tK8D2vnEn0mZpLRsDaK+tomeoWnp5bWN
	 Krn2OP+FMIlynZyqtc+vJbUFDGuPaM1aX4gux0hSnfTYFYAPXXpLqbbGsHYao6Deh2
	 K9MUduWlNdYDQ==
Date: Thu, 2 Oct 2025 08:58:30 -0700
From: Kees Cook <kees@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: patches@lists.linux.dev, stable@vger.kernel.org,
	Svetlana Parfenova <svetlana.parfenova@syntacore.com>,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
	gregkh@linuxfoundation.org, harshvardhan.j.jha@oracle.com,
	chenqiwu@xiaomi.com, linux-riscv@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.17-6.12] binfmt_elf: preserve original ELF
 e_flags for core dumps
Message-ID: <202510020856.736F028D@keescook>
References: <20251002153025.2209281-1-sashal@kernel.org>
 <20251002153025.2209281-31-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251002153025.2209281-31-sashal@kernel.org>

I'm not excited about this getting backported without an explicit
user/champion for it -- it adds Kconfig dependencies and potentially
changes existing runtime behaviors.

-Kees

On Thu, Oct 02, 2025 at 11:30:18AM -0400, Sasha Levin wrote:
> From: Svetlana Parfenova <svetlana.parfenova@syntacore.com>
> 
> [ Upstream commit 8c94db0ae97c72c253a615f990bd466b456e94f6 ]
> 
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
> (in fill_note_info()). Kconfig option CONFIG_ARCH_HAS_ELF_CORE_EFLAGS
> is introduced for architectures that require this behaviour.
> 
> Signed-off-by: Svetlana Parfenova <svetlana.parfenova@syntacore.com>
> Link: https://lore.kernel.org/r/20250901135350.619485-1-svetlana.parfenova@syntacore.com
> Signed-off-by: Kees Cook <kees@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
> 
> LLM Generated explanations, may be completely bogus:
> 
> Based on my comprehensive analysis, here is my determination:
> 
> ---
> 
> ## **Backport Status: YES**
> 
> ### **Extensive Analysis:**
> 
> #### **Problem Being Fixed:**
> This commit addresses a debugging issue on RISC-V architecture where GDB
> cannot properly interpret core dumps. The root cause is that RISC-V uses
> the ELF e_flags field to encode critical ABI information (ISA
> extensions, FPU support), and without preserving these flags in core
> dumps, GDB displays warnings like:
> 
> ```
> warning: Unexpected size of section '.reg2/213' in core file.
> ```
> 
> This prevents developers from accessing FPU or other architecture-
> specific registers during post-mortem debugging, even when the data was
> correctly dumped.
> 
> #### **Code Changes Analysis:**
> 
> **1. fs/binfmt_elf.c (core changes):**
>    - Lines 106-119: Adds two inline helper functions
>      `elf_coredump_set_mm_eflags()` and `elf_coredump_get_mm_eflags()`
>      that are no-ops when CONFIG_ARCH_HAS_ELF_CORE_EFLAGS is disabled
>    - Line 1308: Saves e_flags during ELF binary loading:
>      `elf_coredump_set_mm_eflags(mm, elf_ex->e_flags)`
>    - Lines 1824-1866: Refactors fill_note_info() to extract machine type
>      and flags into local variables, then overrides flags with saved
>      value if architecture opted in
> 
> **2. include/linux/mm_types.h:**
>    - Adds `unsigned long saved_e_flags` field to mm_struct,
>      conditionally compiled
>    - Field placement is logical (after saved_auxv, another ELF-related
>      field)
>    - Memory overhead: one unsigned long (8 bytes on 64-bit) per
>      mm_struct, only on RISC-V
> 
> **3. fs/Kconfig.binfmt:**
>    - Adds CONFIG_ARCH_HAS_ELF_CORE_EFLAGS option
>    - Depends on BINFMT_ELF && ELF_CORE
>    - Allows architectures to opt-in to e_flags preservation
> 
> **4. arch/riscv/Kconfig:**
>    - Enables CONFIG_ARCH_HAS_ELF_CORE_EFLAGS for RISC-V
> 
> #### **Why This Qualifies for Backporting:**
> 
> **✓ Important Bug Fix:**
> - Fixes real user-facing problem: debugging RISC-V applications with FPU
>   is broken
> - Affects developers working on RISC-V platforms
> - No workaround available (the information is lost in core dumps)
> 
> **✓ Small and Contained:**
> - Net change: 55 insertions, 6 deletions across 4 files
> - All logic is simple save/restore pattern
> - No complex state management or synchronization
> 
> **✓ Minimal Regression Risk:**
> - Opt-in via Kconfig - other architectures completely unaffected
> - When disabled: zero runtime overhead (functions compile to empty
>   inline stubs)
> - When enabled: trivial assignment operations with no failure paths
> - Changes are in well-established code paths (load_elf_binary,
>   fill_note_info)
> 
> **✓ No Dependencies:**
> - Applies cleanly to 6.17 tree
> - No prerequisite commits required
> - The backport also includes a728ce8ffbd27 (struct_size() refactoring)
>   which is a compatible cleanup
> 
> **✓ Stable After Mainline:**
> - Committed Sep 3, 2025 (27 days in mainline as of Sep 30)
> - No fixes, reverts, or reported issues
> - git log shows no follow-up corrections needed
> 
> **✓ Maintainer Approved:**
> - Signed-off-by: Kees Cook (execve/binfmt maintainer)
> - Proper review process through lore.kernel.org
> 
> **✓ Follows Stable Kernel Rules:**
> - Rule 1: Must be obviously correct and tested ✓
> - Rule 2: Significant bugfix ✓
> - Rule 3: Not larger than 100 lines ✓
> - Rule 4: Patches cannot add features ✓ (fixes existing feature)
> - Rule 5: No theoretical race condition fixes ✓ (fixes actual GDB issue)
> 
> #### **Technical Correctness:**
> 
> **ELF_CORE_EFLAGS Historical Context:**
> - The macro has existed since 2005 (Linus's original git import)
> - Only Hexagon and PowerPC defined non-zero values
> - RISC-V's e_flags usage is architecturally critical for ABI
>   compatibility
> - The old approach (using static ELF_CORE_EFLAGS=0) lost runtime
>   information
> 
> **Design Quality:**
> - Clean separation: CONFIG option → mm_struct field → helper functions
> - Backward compatible: architectures that don't need it pay zero cost
> - Forward compatible: other architectures (ARM, MIPS) could adopt this
>   if needed
> - Proper abstraction through inline helpers prevents #ifdef
>   proliferation
> 
> #### **Potential Concerns Addressed:**
> 
> **Q: Is mm_struct size increase acceptable?**
> A: Yes. One unsigned long (8 bytes) per process on RISC-V only,
> negligible compared to typical mm_struct size (~1KB+)
> 
> **Q: Why not use regset_view->e_flags?**
> A: The regset_view structure doesn't have an e_flags field. The old code
> fell back to the compile-time ELF_CORE_EFLAGS constant, losing the per-
> process runtime ABI information from the actual ELF binary.
> 
> **Q: Thread safety concerns?**
> A: None. The e_flags are written once during load_elf_binary() before
> any threads can be created, and read during core dump when all threads
> are stopped.
> 
> **Q: Is this too recent for backporting?**
> A: While 27 days is relatively fresh, the change is so minimal and
> isolated that the risk is negligible. The opt-in nature means
> regressions can only affect RISC-V users who explicitly enable
> coredumps.
> 
> ### **Conclusion:**
> 
> This commit should be backported because it fixes an important debugging
> issue on RISC-V with minimal risk. The change is small, self-contained,
> opt-in, and has been stable in mainline. It meets all stable kernel
> backporting criteria and will significantly improve the debugging
> experience for RISC-V developers without impacting other architectures.
> 
>  arch/riscv/Kconfig       |  1 +
>  fs/Kconfig.binfmt        |  9 +++++++++
>  fs/binfmt_elf.c          | 40 ++++++++++++++++++++++++++++++++++------
>  include/linux/mm_types.h |  5 +++++
>  4 files changed, 49 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 51dcd8eaa2435..74db054aa1b8b 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -28,6 +28,7 @@ config RISCV
>  	select ARCH_HAS_DEBUG_VIRTUAL if MMU
>  	select ARCH_HAS_DEBUG_VM_PGTABLE
>  	select ARCH_HAS_DEBUG_WX
> +	select ARCH_HAS_ELF_CORE_EFLAGS
>  	select ARCH_HAS_FAST_MULTIPLIER
>  	select ARCH_HAS_FORTIFY_SOURCE
>  	select ARCH_HAS_GCOV_PROFILE_ALL
> diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
> index bd2f530e57408..1949e25c7741b 100644
> --- a/fs/Kconfig.binfmt
> +++ b/fs/Kconfig.binfmt
> @@ -184,4 +184,13 @@ config EXEC_KUNIT_TEST
>  	  This builds the exec KUnit tests, which tests boundary conditions
>  	  of various aspects of the exec internals.
>  
> +config ARCH_HAS_ELF_CORE_EFLAGS
> +	bool
> +	depends on BINFMT_ELF && ELF_CORE
> +	default n
> +	help
> +	  Select this option if the architecture makes use of the e_flags
> +	  field in the ELF header to store ABI or other architecture-specific
> +	  information that should be preserved in core dumps.
> +
>  endmenu
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 264fba0d44bdf..c126e3d0e7018 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -103,6 +103,21 @@ static struct linux_binfmt elf_format = {
>  
>  #define BAD_ADDR(x) (unlikely((unsigned long)(x) >= TASK_SIZE))
>  
> +static inline void elf_coredump_set_mm_eflags(struct mm_struct *mm, u32 flags)
> +{
> +#ifdef CONFIG_ARCH_HAS_ELF_CORE_EFLAGS
> +	mm->saved_e_flags = flags;
> +#endif
> +}
> +
> +static inline u32 elf_coredump_get_mm_eflags(struct mm_struct *mm, u32 flags)
> +{
> +#ifdef CONFIG_ARCH_HAS_ELF_CORE_EFLAGS
> +	flags = mm->saved_e_flags;
> +#endif
> +	return flags;
> +}
> +
>  /*
>   * We need to explicitly zero any trailing portion of the page that follows
>   * p_filesz when it ends before the page ends (e.g. bss), otherwise this
> @@ -1290,6 +1305,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  	mm->end_data = end_data;
>  	mm->start_stack = bprm->p;
>  
> +	elf_coredump_set_mm_eflags(mm, elf_ex->e_flags);
> +
>  	/**
>  	 * DOC: "brk" handling
>  	 *
> @@ -1804,6 +1821,8 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
>  	struct elf_thread_core_info *t;
>  	struct elf_prpsinfo *psinfo;
>  	struct core_thread *ct;
> +	u16 machine;
> +	u32 flags;
>  
>  	psinfo = kmalloc(sizeof(*psinfo), GFP_KERNEL);
>  	if (!psinfo)
> @@ -1831,17 +1850,26 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
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
> +	 * if arch needs that.
> +	 */
> +	flags = elf_coredump_get_mm_eflags(dump_task->mm, flags);
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
> index a643fae8a3494..7f625c35128be 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1107,6 +1107,11 @@ struct mm_struct {
>  
>  		unsigned long saved_auxv[AT_VECTOR_SIZE]; /* for /proc/PID/auxv */
>  
> +#ifdef CONFIG_ARCH_HAS_ELF_CORE_EFLAGS
> +		/* the ABI-related flags from the ELF header. Used for core dump */
> +		unsigned long saved_e_flags;
> +#endif
> +
>  		struct percpu_counter rss_stat[NR_MM_COUNTERS];
>  
>  		struct linux_binfmt *binfmt;
> -- 
> 2.51.0
> 

-- 
Kees Cook

