Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D73A67524B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jan 2023 11:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjATKXm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Jan 2023 05:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjATKXl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Jan 2023 05:23:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744158B76A;
        Fri, 20 Jan 2023 02:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CeGv0JtmRE31bDGztcRu8iAtRTnI2gcf4GZAbDeGXW4=; b=EfQaYrQTpC9FZgAc9US9UUa6qO
        ZhdSTQznBD6VDiTXzgG8ZlpaU2hIhwKHJHmG269zfqliyfIcm+01zSYLyqMSWkOyC2Qo2f4hB4xSv
        dXtmag26HNKiu7xwd7191QKfvFdedR4z+tFk2bXlNrem7pMXdKnDFQAdwRvgOovyPUJo9VzxH46gg
        e5GtdKEZ0PuSQayAddqCHFHxJMkJwatPs7l3ZybOctMTRleAHEo/phby55tWZ23hNHbeVcL5JPR62
        32JA7mFYMgzxeVgNhqTAWtwbptjejO8DhY1S0F8Mog9qxmxJOX3UYzKS6xhWDMi/jutqdEHzxxF4Y
        juf72uXg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pIoYP-001rMS-Oy; Fri, 20 Jan 2023 10:23:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BEC95300033;
        Fri, 20 Jan 2023 11:23:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9AE5E2011D472; Fri, 20 Jan 2023 11:23:24 +0100 (CET)
Date:   Fri, 20 Jan 2023 11:23:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Gregory Price <gourry.memverge@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        krisman@collabora.com, tglx@linutronix.de, luto@kernel.org,
        oleg@redhat.com, ebiederm@xmission.com, akpm@linux-foundation.org,
        adobriyan@gmail.com, corbet@lwn.net, shuah@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH 1/3] ptrace,syscall_user_dispatch: Implement Syscall User
 Dispatch Suspension
Message-ID: <Y8prnDT0YUhEzI8+@hirez.programming.kicks-ass.net>
References: <20230118201055.147228-1-gregory.price@memverge.com>
 <20230118201055.147228-2-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118201055.147228-2-gregory.price@memverge.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 18, 2023 at 03:10:53PM -0500, Gregory Price wrote:
> Adds PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH to ptrace options, and
> modify Syscall User Dispatch to suspend interception when enabled.
> 
> This is modeled after the SUSPEND_SECCOMP feature, which suspends
> SECCOMP interposition.  Without doing this, software like CRIU will
> inject system calls into a process and be intercepted by Syscall
> User Dispatch, either causing a crash (due to blocked signals) or
> the delivery of those signals to a ptracer (not the intended behavior).
> 
> Since Syscall User Dispatch is not a privileged feature, a check
> for permissions is not required, however attempting to set this
> option when CONFIG_CHECKPOINT_RESTORE it not supported should be
> disallowed, as its intended use is checkpoint/resume.
> 
> Signed-off-by: Gregory Price <gregory.price@memverge.com>

One small nit -- see below, otherwise:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  include/linux/ptrace.h               | 2 ++
>  include/uapi/linux/ptrace.h          | 6 +++++-
>  kernel/entry/syscall_user_dispatch.c | 5 +++++
>  kernel/ptrace.c                      | 5 +++++
>  4 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
> index eaaef3ffec22..461ae5c99d57 100644
> --- a/include/linux/ptrace.h
> +++ b/include/linux/ptrace.h
> @@ -45,6 +45,8 @@ extern int ptrace_access_vm(struct task_struct *tsk, unsigned long addr,
>  
>  #define PT_EXITKILL		(PTRACE_O_EXITKILL << PT_OPT_FLAG_SHIFT)
>  #define PT_SUSPEND_SECCOMP	(PTRACE_O_SUSPEND_SECCOMP << PT_OPT_FLAG_SHIFT)
> +#define PT_SUSPEND_SYSCALL_USER_DISPATCH \
> +	(PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH << PT_OPT_FLAG_SHIFT)
>  
>  extern long arch_ptrace(struct task_struct *child, long request,
>  			unsigned long addr, unsigned long data);
> diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
> index 195ae64a8c87..ba9e3f19a22c 100644
> --- a/include/uapi/linux/ptrace.h
> +++ b/include/uapi/linux/ptrace.h
> @@ -146,9 +146,13 @@ struct ptrace_rseq_configuration {
>  /* eventless options */
>  #define PTRACE_O_EXITKILL		(1 << 20)
>  #define PTRACE_O_SUSPEND_SECCOMP	(1 << 21)
> +#define PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH	(1 << 22)
>  
>  #define PTRACE_O_MASK		(\
> -	0x000000ff | PTRACE_O_EXITKILL | PTRACE_O_SUSPEND_SECCOMP)
> +	0x000000ff | \
> +	PTRACE_O_EXITKILL | \
> +	PTRACE_O_SUSPEND_SECCOMP | \
> +	PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH)
>  
>  #include <asm/ptrace.h>
>  
> diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
> index 0b6379adff6b..7607f4598dd8 100644
> --- a/kernel/entry/syscall_user_dispatch.c
> +++ b/kernel/entry/syscall_user_dispatch.c
> @@ -8,6 +8,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/signal.h>
>  #include <linux/elf.h>
> +#include <linux/ptrace.h>
>  
>  #include <linux/sched/signal.h>
>  #include <linux/sched/task_stack.h>
> @@ -36,6 +37,10 @@ bool syscall_user_dispatch(struct pt_regs *regs)
>  	struct syscall_user_dispatch *sd = &current->syscall_dispatch;
>  	char state;
>  
> +	if (IS_ENABLED(CONFIG_CHECKPOINT_RESTORE) &&
> +		unlikely(current->ptrace & PT_SUSPEND_SYSCALL_USER_DISPATCH))

Align with the '(' pleaase.

> +		return false;
> +
>  	if (likely(instruction_pointer(regs) - sd->offset < sd->len))
>  		return false;
>  
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index 54482193e1ed..a6ad815bd4be 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -370,6 +370,11 @@ static int check_ptrace_options(unsigned long data)
>  	if (data & ~(unsigned long)PTRACE_O_MASK)
>  		return -EINVAL;
>  
> +	if (unlikely(data & PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH)) {
> +		if (!IS_ENABLED(CONFIG_CHECKPOINT_RESTART))
> +			return -EINVAL;
> +	}
> +
>  	if (unlikely(data & PTRACE_O_SUSPEND_SECCOMP)) {
>  		if (!IS_ENABLED(CONFIG_CHECKPOINT_RESTORE) ||
>  		    !IS_ENABLED(CONFIG_SECCOMP))
> -- 
> 2.39.0
> 
