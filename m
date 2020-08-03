Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E415923A546
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 14:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbgHCMfD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 08:35:03 -0400
Received: from foss.arm.com ([217.140.110.172]:56644 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728767AbgHCMfC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:35:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F93931B;
        Mon,  3 Aug 2020 05:35:00 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.34.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 662293F71F;
        Mon,  3 Aug 2020 05:34:54 -0700 (PDT)
Date:   Mon, 3 Aug 2020 13:34:47 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, oleg@redhat.com,
        keescook@chromium.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        adobriyan@gmail.com, rostedt@goodmis.org, mingo@redhat.com,
        steve.capper@arm.com, vincenzo.frascino@arm.com,
        anshuman.khandual@arm.com, ardb@kernel.org, james.morse@arm.com,
        broonie@kernel.org, maz@kernel.org, kristina.martsenko@arm.com,
        samitolvanen@google.com, ebiederm@xmission.com,
        akpm@linux-foundation.org, gladkov.alexey@gmail.com,
        daniel.m.jordan@oracle.com, walken@google.com,
        bernd.edlinger@hotmail.de, laoar.shao@gmail.com, avagin@gmail.com,
        john.johansen@canonical.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        a.sahrawat@samsung.com, Vaneet narang <v.narang@samsung.com>
Subject: Re: [PATCH 1/1] arm64: add support for PAGE_SIZE aligned kernel stack
Message-ID: <20200803123447.GA89825@C02TD0UTHF1T.local>
References: <CGME20200802165825epcas5p3a2127be681530fdd785db0f8961eaf96@epcas5p3.samsung.com>
 <1596386115-47228-1-git-send-email-maninder1.s@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596386115-47228-1-git-send-email-maninder1.s@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 02, 2020 at 10:05:15PM +0530, Maninder Singh wrote:
> currently THREAD_SIZE is always in power of 2, which will waste
> memory in cases there is need to increase of stack size.

If you are seeing issues with the current stack size, can you please
explain that in more detail? Where are you seeing problems? Which
configuration options do you have selected?

I'm not keen on making kernel stack sizes configurable as it's not
currently possible for the person building the kernel to figure out a
safe size (and if this were possible, it's be better to handle this
automatically).

If the stack size is too small in some configurations I think we need to
ensure that it is appropriately sized regardless of whether the person
building the kernel believes they can identify a reasonable size.

> Thus adding support for PAGE_SIZE(not power of 2) stacks for arm64.
> User can decide any value 12KB, 16KB, 20 KB etc. based on value
> of THREAD_SHIFT. User can set any value which is PAGE_SIZE aligned for
> PAGE_ALIGNED_STACK_SIZE config.
> 
> Value of THREAD_SIZE is defined as 12KB for now, since with irq stacks
> it is enough and it will save 4KB per thread.

How are you certain of this?

> IRQ stack size is not changed and alignement of IRQ stack and kernel stack
> is maintained same to catch stack overflow faults as earlier.
> 
> THREAD_SIZE masking in common files is changed to THREAD_SIZE_ALIGNED.

This is definitely going to be confused with THREAD_ALIGN, so if we do
go ahead with this, the naming will need work.

Thanks,
Mark.

> 
> Co-developed-by: Vaneet narang <v.narang@samsung.com>
> Signed-off-by: Vaneet narang <v.narang@samsung.com>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> ---
>  arch/arm64/Kconfig              |  9 +++++++++
>  arch/arm64/include/asm/memory.h | 29 +++++++++++++++++++++++++----
>  arch/arm64/kernel/entry.S       |  4 ++--
>  arch/arm64/kernel/ptrace.c      |  4 ++--
>  drivers/misc/lkdtm/stackleak.c  |  2 +-
>  fs/proc/base.c                  |  4 ++--
>  include/linux/thread_info.h     |  4 ++++
>  kernel/trace/trace_stack.c      |  4 ++--
>  8 files changed, 47 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index c970171..301e068 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -977,6 +977,15 @@ config NODES_SHIFT
>  	  Specify the maximum number of NUMA Nodes available on the target
>  	  system.  Increases memory reserved to accommodate various tables.
>  
> +config	PAGE_ALIGNED_STACK_SIZE
> +	int "set per thread stack size (THREAD_SIZE)"
> +	default 12288
> +	depends on VMAP_STACK && ARM64_4K_PAGES && !KASAN
> +	help
> +	  Per Thread stack size, value must be PAGE_SIZE aligned.
> +	  make sure value should be less than (1 << THREAD_SHIFT),
> +	  otherwise increase THREAD_SHIFT also.
> +
>  config USE_PERCPU_NUMA_NODE_ID
>  	def_bool y
>  	depends on NUMA
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index 5767836..597071e 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -93,6 +93,7 @@
>   */
>  #if defined(CONFIG_VMAP_STACK) && (MIN_THREAD_SHIFT < PAGE_SHIFT)
>  #define THREAD_SHIFT		PAGE_SHIFT
> +#define THREAD_SIZE		(UL(1) << THREAD_SHIFT)
>  #else
>  #define THREAD_SHIFT		MIN_THREAD_SHIFT
>  #endif
> @@ -101,7 +102,15 @@
>  #define THREAD_SIZE_ORDER	(THREAD_SHIFT - PAGE_SHIFT)
>  #endif
>  
> -#define THREAD_SIZE		(UL(1) << THREAD_SHIFT)
> +#define THREAD_SIZE_ALIGNED	(UL(1) << THREAD_SHIFT)
> +
> +#ifndef THREAD_SIZE
> +#if defined(CONFIG_VMAP_STACK) && (CONFIG_PAGE_ALIGNED_STACK_SIZE)
> +#define THREAD_SIZE		CONFIG_PAGE_ALIGNED_STACK_SIZE
> +#else
> +#define THREAD_SIZE		THREAD_SIZE_ALIGNED
> +#endif
> +#endif
>  
>  /*
>   * By aligning VMAP'd stacks to 2 * THREAD_SIZE, we can detect overflow by
> @@ -109,12 +118,24 @@
>   * assembly.
>   */
>  #ifdef CONFIG_VMAP_STACK
> -#define THREAD_ALIGN		(2 * THREAD_SIZE)
> +#define THREAD_ALIGN		(2 * THREAD_SIZE_ALIGNED)
>  #else
> -#define THREAD_ALIGN		THREAD_SIZE
> +#define THREAD_ALIGN		THREAD_SIZE_ALIGNED
> +#endif
> +
> +#ifdef CONFIG_PAGE_ALIGNED_STACK_SIZE
> +
> +#if (THREAD_SIZE_ALIGNED < THREAD_SIZE)
> +#error "PAGE_ALIGNED_STACK_SIZE is more than THREAD_SIZE_ALIGNED, increase THREAD_SHIFT"
> +#endif
> +
> +#if (THREAD_SIZE % PAGE_SIZE)
> +#error "PAGE_ALIGNED_STACK_SIZE must be PAGE_SIZE align"
> +#endif
> +
>  #endif
>  
> -#define IRQ_STACK_SIZE		THREAD_SIZE
> +#define IRQ_STACK_SIZE		THREAD_SIZE_ALIGNED
>  
>  #define OVERFLOW_STACK_SIZE	SZ_4K
>  
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 13458c2..5190573 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -444,12 +444,12 @@ alternative_insn eret, nop, ARM64_UNMAP_KERNEL_AT_EL0
>  
>  	/*
>  	 * Compare sp with the base of the task stack.
> -	 * If the top ~(THREAD_SIZE - 1) bits match, we are on a task stack,
> +	 * If the top ~(THREAD_SIZE_ALIGNED - 1) bits match, we are on a task stack,
>  	 * and should switch to the irq stack.
>  	 */
>  	ldr	x25, [tsk, TSK_STACK]
>  	eor	x25, x25, x19
> -	and	x25, x25, #~(THREAD_SIZE - 1)
> +	and	x25, x25, #~(THREAD_SIZE_ALIGNED - 1)
>  	cbnz	x25, 9998f
>  
>  	ldr_this_cpu x25, irq_stack_ptr, x26
> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index b82eb50..800bb84 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -120,8 +120,8 @@ int regs_query_register_offset(const char *name)
>   */
>  static bool regs_within_kernel_stack(struct pt_regs *regs, unsigned long addr)
>  {
> -	return ((addr & ~(THREAD_SIZE - 1))  ==
> -		(kernel_stack_pointer(regs) & ~(THREAD_SIZE - 1))) ||
> +	return ((addr & ~(THREAD_SIZE_ALIGNED - 1))  ==
> +		(kernel_stack_pointer(regs) & ~(THREAD_SIZE_ALIGNED - 1))) ||
>  		on_irq_stack(addr, NULL);
>  }
>  
> diff --git a/drivers/misc/lkdtm/stackleak.c b/drivers/misc/lkdtm/stackleak.c
> index d1a5c07..f4ab60a 100644
> --- a/drivers/misc/lkdtm/stackleak.c
> +++ b/drivers/misc/lkdtm/stackleak.c
> @@ -24,7 +24,7 @@ void lkdtm_STACKLEAK_ERASING(void)
>  	 */
>  	sp = PTR_ALIGN(&i, sizeof(unsigned long));
>  
> -	left = ((unsigned long)sp & (THREAD_SIZE - 1)) / sizeof(unsigned long);
> +	left = ((unsigned long)sp & (THREAD_SIZE_ALIGNED - 1)) / sizeof(unsigned long);
>  	sp--;
>  
>  	/*
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index f3b6e12..f89e2c5 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -3135,9 +3135,9 @@ static int proc_stack_depth(struct seq_file *m, struct pid_namespace *ns,
>  				struct pid *pid, struct task_struct *task)
>  {
>  	unsigned long prev_depth = THREAD_SIZE -
> -				(task->prev_lowest_stack & (THREAD_SIZE - 1));
> +				(task->prev_lowest_stack & (THREAD_SIZE_ALIGNED - 1));
>  	unsigned long depth = THREAD_SIZE -
> -				(task->lowest_stack & (THREAD_SIZE - 1));
> +				(task->lowest_stack & (THREAD_SIZE_ALIGNED - 1));
>  
>  	seq_printf(m, "previous stack depth: %lu\nstack depth: %lu\n",
>  							prev_depth, depth);
> diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
> index e93e249..35a73b5 100644
> --- a/include/linux/thread_info.h
> +++ b/include/linux/thread_info.h
> @@ -43,6 +43,10 @@ enum {
>  #define THREAD_ALIGN	THREAD_SIZE
>  #endif
>  
> +#ifndef THREAD_SIZE_ALIGNED
> +#define THREAD_SIZE_ALIGNED	THREAD_SIZE
> +#endif
> +
>  #define THREADINFO_GFP		(GFP_KERNEL_ACCOUNT | __GFP_ZERO)
>  
>  /*
> diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
> index 5810fb8..ef3d442 100644
> --- a/kernel/trace/trace_stack.c
> +++ b/kernel/trace/trace_stack.c
> @@ -159,7 +159,7 @@ static void check_stack(unsigned long ip, unsigned long *stack)
>  	int frame_size = READ_ONCE(tracer_frame);
>  	int i, x;
>  
> -	this_size = ((unsigned long)stack) & (THREAD_SIZE-1);
> +	this_size = ((unsigned long)stack) & (THREAD_SIZE_ALIGNED - 1);
>  	this_size = THREAD_SIZE - this_size;
>  	/* Remove the frame of the tracer */
>  	this_size -= frame_size;
> @@ -211,7 +211,7 @@ static void check_stack(unsigned long ip, unsigned long *stack)
>  	x = 0;
>  	start = stack;
>  	top = (unsigned long *)
> -		(((unsigned long)start & ~(THREAD_SIZE-1)) + THREAD_SIZE);
> +		(((unsigned long)start & ~(THREAD_SIZE_ALIGNED - 1)) + THREAD_SIZE);
>  
>  	/*
>  	 * Loop through all the entries. One of the entries may
> -- 
> 1.9.1
> 
