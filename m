Return-Path: <linux-fsdevel+bounces-45964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFE1A7FD68
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 13:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E62D423EFF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 10:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF7F26B2B1;
	Tue,  8 Apr 2025 10:52:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A219268FDB;
	Tue,  8 Apr 2025 10:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744109523; cv=none; b=kyBqmR1FBZ3UtVw1pPq05B49lInAyer6LKG3mDHDK2NMvex6d6RhoF0pCRtGJZdgcvh1iJbthlGj0s+okNNZavRBW8utIZvq02gIVywkSxlUDeevsLBIIv9fVDmljrFJfpD/0nJ8rCUIumUs57jXbbbwGSJL/RTawClgExrMHcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744109523; c=relaxed/simple;
	bh=qdyfGchOgczDeIWDi2AZQbVlzbLP0tVBpIdNaPkXiQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FsFWfwd8+Iwsh1+2el/kbrO/+37iu5hTxZVvSotw8WeHUt9nsX6txYZ9XQ10awOVZsAk4JroXGDNpBlxoesMWDRmn4hplHdHwCPy8w+LVGNJv4iV8X1SitiPn7tYC1Ej1tjAGEYlHLiDZso4u37GhMXN1RYDP2psvnXcfLLDBvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3856F2047C;
	Tue,  8 Apr 2025 10:51:46 +0000 (UTC)
Message-ID: <3f9c48a6-1256-4e52-a26a-7f80f3b7c05a@ghiti.fr>
Date: Tue, 8 Apr 2025 12:51:45 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 11/28] riscv/shstk: If needed allocate a new shadow
 stack on clone
Content-Language: en-US
To: Deepak Gupta <debug@rivosinc.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Christian Brauner <brauner@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>,
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com,
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com,
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com,
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org,
 rick.p.edgecombe@intel.com, Zong Li <zong.li@sifive.com>
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
 <20250314-v5_user_cfi_series-v12-11-e51202b53138@rivosinc.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250314-v5_user_cfi_series-v12-11-e51202b53138@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddvkeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpedthfelfeejgeehveegleejleelgfevhfekieffkeeujeetfedvvefhledvgeegieenucfkphepvddttddumeekiedumeeffeekvdemvghfledtmeehsgegieemkeeludekmegtledujeemjeekjedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddttddumeekiedumeeffeekvdemvghfledtmeehsgegieemkeeludekmegtledujeemjeekjedvpdhhvghloheplgfkrfggieemvddttddumeekiedumeeffeekvdemvghfledtmeehsgegieemkeeludekmegtledujeemjeekjedvngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopeegledprhgtphhtthhopeguvggsuhhgsehrihhvohhsihhntgdrtghomhdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtthhopegsp
 hesrghlihgvnhekrdguvgdprhgtphhtthhopegurghvvgdrhhgrnhhsvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepgiekieeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhhprgesiiihthhorhdrtghomhdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhg
X-GND-Sasl: alex@ghiti.fr


On 14/03/2025 22:39, Deepak Gupta wrote:
> Userspace specifies CLONE_VM to share address space and spawn new thread.
> `clone` allow userspace to specify a new stack for new thread. However
> there is no way to specify new shadow stack base address without changing
> API. This patch allocates a new shadow stack whenever CLONE_VM is given.
>
> In case of CLONE_VFORK, parent is suspended until child finishes and thus
> can child use parent shadow stack. In case of !CLONE_VM, COW kicks in
> because entire address space is copied from parent to child.
>
> `clone3` is extensible and can provide mechanisms using which shadow stack
> as an input parameter can be provided. This is not settled yet and being
> extensively discussed on mailing list. Once that's settled, this commit
> will adapt to that.


What's the status of this discussion? Can you provide a Link to it?


>
> Reviewed-by: Zong Li <zong.li@sifive.com>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>   arch/riscv/include/asm/mmu_context.h |   7 ++
>   arch/riscv/include/asm/usercfi.h     |  25 ++++++++
>   arch/riscv/kernel/process.c          |   9 +++
>   arch/riscv/kernel/usercfi.c          | 120 +++++++++++++++++++++++++++++++++++
>   4 files changed, 161 insertions(+)
>
> diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/asm/mmu_context.h
> index 8c4bc49a3a0f..dbf27a78df6c 100644
> --- a/arch/riscv/include/asm/mmu_context.h
> +++ b/arch/riscv/include/asm/mmu_context.h
> @@ -48,6 +48,13 @@ static inline unsigned long mm_untag_mask(struct mm_struct *mm)
>   }
>   #endif
>   
> +#define deactivate_mm deactivate_mm
> +static inline void deactivate_mm(struct task_struct *tsk,
> +				 struct mm_struct *mm)
> +{
> +	shstk_release(tsk);
> +}
> +
>   #include <asm-generic/mmu_context.h>
>   
>   #endif /* _ASM_RISCV_MMU_CONTEXT_H */
> diff --git a/arch/riscv/include/asm/usercfi.h b/arch/riscv/include/asm/usercfi.h
> index 5f2027c51917..82d28ac98d76 100644
> --- a/arch/riscv/include/asm/usercfi.h
> +++ b/arch/riscv/include/asm/usercfi.h
> @@ -8,6 +8,9 @@
>   #ifndef __ASSEMBLY__
>   #include <linux/types.h>
>   
> +struct task_struct;
> +struct kernel_clone_args;
> +
>   #ifdef CONFIG_RISCV_USER_CFI
>   struct cfi_status {
>   	unsigned long ubcfi_en : 1; /* Enable for backward cfi. */
> @@ -17,6 +20,28 @@ struct cfi_status {
>   	unsigned long shdw_stk_size; /* size of shadow stack */
>   };
>   
> +unsigned long shstk_alloc_thread_stack(struct task_struct *tsk,
> +				       const struct kernel_clone_args *args);
> +void shstk_release(struct task_struct *tsk);
> +void set_shstk_base(struct task_struct *task, unsigned long shstk_addr, unsigned long size);
> +unsigned long get_shstk_base(struct task_struct *task, unsigned long *size);
> +void set_active_shstk(struct task_struct *task, unsigned long shstk_addr);
> +bool is_shstk_enabled(struct task_struct *task);
> +
> +#else
> +
> +#define shstk_alloc_thread_stack(tsk, args) 0
> +
> +#define shstk_release(tsk)
> +
> +#define get_shstk_base(task, size) 0UL
> +
> +#define set_shstk_base(task, shstk_addr, size)
> +
> +#define set_active_shstk(task, shstk_addr)
> +
> +#define is_shstk_enabled(task) false
> +
>   #endif /* CONFIG_RISCV_USER_CFI */
>   
>   #endif /* __ASSEMBLY__ */
> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index 7c244de77180..99acb6342a37 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -29,6 +29,7 @@
>   #include <asm/vector.h>
>   #include <asm/cpufeature.h>
>   #include <asm/exec.h>
> +#include <asm/usercfi.h>
>   
>   #if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_STACKPROTECTOR_PER_TASK)
>   #include <linux/stackprotector.h>
> @@ -211,6 +212,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>   	unsigned long clone_flags = args->flags;
>   	unsigned long usp = args->stack;
>   	unsigned long tls = args->tls;
> +	unsigned long ssp = 0;
>   	struct pt_regs *childregs = task_pt_regs(p);
>   
>   	/* Ensure all threads in this mm have the same pointer masking mode. */
> @@ -229,11 +231,18 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>   		p->thread.s[0] = (unsigned long)args->fn;
>   		p->thread.s[1] = (unsigned long)args->fn_arg;
>   	} else {
> +		/* allocate new shadow stack if needed. In case of CLONE_VM we have to */
> +		ssp = shstk_alloc_thread_stack(p, args);
> +		if (IS_ERR_VALUE(ssp))
> +			return PTR_ERR((void *)ssp);
> +
>   		*childregs = *(current_pt_regs());
>   		/* Turn off status.VS */
>   		riscv_v_vstate_off(childregs);
>   		if (usp) /* User fork */
>   			childregs->sp = usp;
> +		/* if needed, set new ssp */
> +		ssp ? set_active_shstk(p, ssp) : 0;


The use of the ternary here is weird, can you change that to a if 
statement?


>   		if (clone_flags & CLONE_SETTLS)
>   			childregs->tp = tls;
>   		childregs->a0 = 0; /* Return value of fork() */
> diff --git a/arch/riscv/kernel/usercfi.c b/arch/riscv/kernel/usercfi.c
> index 24022809a7b5..73cf87dab186 100644
> --- a/arch/riscv/kernel/usercfi.c
> +++ b/arch/riscv/kernel/usercfi.c
> @@ -19,6 +19,41 @@
>   
>   #define SHSTK_ENTRY_SIZE sizeof(void *)
>   
> +bool is_shstk_enabled(struct task_struct *task)
> +{
> +	return task->thread_info.user_cfi_state.ubcfi_en ? true : false;
> +}
> +
> +void set_shstk_base(struct task_struct *task, unsigned long shstk_addr, unsigned long size)
> +{
> +	task->thread_info.user_cfi_state.shdw_stk_base = shstk_addr;
> +	task->thread_info.user_cfi_state.shdw_stk_size = size;
> +}
> +
> +unsigned long get_shstk_base(struct task_struct *task, unsigned long *size)
> +{
> +	if (size)
> +		*size = task->thread_info.user_cfi_state.shdw_stk_size;
> +	return task->thread_info.user_cfi_state.shdw_stk_base;
> +}
> +
> +void set_active_shstk(struct task_struct *task, unsigned long shstk_addr)
> +{
> +	task->thread_info.user_cfi_state.user_shdw_stk = shstk_addr;
> +}
> +
> +/*
> + * If size is 0, then to be compatible with regular stack we want it to be as big as
> + * regular stack. Else PAGE_ALIGN it and return back
> + */
> +static unsigned long calc_shstk_size(unsigned long size)
> +{
> +	if (size)
> +		return PAGE_ALIGN(size);
> +
> +	return PAGE_ALIGN(min_t(unsigned long long, rlimit(RLIMIT_STACK), SZ_4G));
> +}
> +
>   /*
>    * Writes on shadow stack can either be `sspush` or `ssamoswap`. `sspush` can happen
>    * implicitly on current shadow stack pointed to by CSR_SSP. `ssamoswap` takes pointer to
> @@ -142,3 +177,88 @@ SYSCALL_DEFINE3(map_shadow_stack, unsigned long, addr, unsigned long, size, unsi
>   
>   	return allocate_shadow_stack(addr, aligned_size, size, set_tok);
>   }
> +
> +/*
> + * This gets called during clone/clone3/fork. And is needed to allocate a shadow stack for
> + * cases where CLONE_VM is specified and thus a different stack is specified by user. We
> + * thus need a separate shadow stack too. How does separate shadow stack is specified by
> + * user is still being debated. Once that's settled, remove this part of the comment.
> + * This function simply returns 0 if shadow stack are not supported or if separate shadow
> + * stack allocation is not needed (like in case of !CLONE_VM)
> + */
> +unsigned long shstk_alloc_thread_stack(struct task_struct *tsk,
> +				       const struct kernel_clone_args *args)
> +{
> +	unsigned long addr, size;
> +
> +	/* If shadow stack is not supported, return 0 */
> +	if (!cpu_supports_shadow_stack())
> +		return 0;
> +
> +	/*
> +	 * If shadow stack is not enabled on the new thread, skip any
> +	 * switch to a new shadow stack.
> +	 */
> +	if (!is_shstk_enabled(tsk))
> +		return 0;
> +
> +	/*
> +	 * For CLONE_VFORK the child will share the parents shadow stack.
> +	 * Set base = 0 and size = 0, this is special means to track this state
> +	 * so the freeing logic run for child knows to leave it alone.
> +	 */
> +	if (args->flags & CLONE_VFORK) {
> +		set_shstk_base(tsk, 0, 0);
> +		return 0;
> +	}
> +
> +	/*
> +	 * For !CLONE_VM the child will use a copy of the parents shadow
> +	 * stack.
> +	 */
> +	if (!(args->flags & CLONE_VM))
> +		return 0;
> +
> +	/*
> +	 * reaching here means, CLONE_VM was specified and thus a separate shadow
> +	 * stack is needed for new cloned thread. Note: below allocation is happening
> +	 * using current mm.
> +	 */
> +	size = calc_shstk_size(args->stack_size);
> +	addr = allocate_shadow_stack(0, size, 0, false);
> +	if (IS_ERR_VALUE(addr))
> +		return addr;
> +
> +	set_shstk_base(tsk, addr, size);
> +
> +	return addr + size;
> +}
> +
> +void shstk_release(struct task_struct *tsk)
> +{
> +	unsigned long base = 0, size = 0;
> +	/* If shadow stack is not supported or not enabled, nothing to release */
> +	if (!cpu_supports_shadow_stack() || !is_shstk_enabled(tsk))
> +		return;
> +
> +	/*
> +	 * When fork() with CLONE_VM fails, the child (tsk) already has a
> +	 * shadow stack allocated, and exit_thread() calls this function to
> +	 * free it.  In this case the parent (current) and the child share
> +	 * the same mm struct. Move forward only when they're same.
> +	 */
> +	if (!tsk->mm || tsk->mm != current->mm)
> +		return;
> +
> +	/*
> +	 * We know shadow stack is enabled but if base is NULL, then
> +	 * this task is not managing its own shadow stack (CLONE_VFORK). So
> +	 * skip freeing it.
> +	 */
> +	base = get_shstk_base(tsk, &size);
> +	if (!base)
> +		return;
> +
> +	vm_munmap(base, size);
> +	set_shstk_base(tsk, 0, 0);
> +}
>

