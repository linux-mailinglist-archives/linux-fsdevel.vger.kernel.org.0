Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5CE541D563
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Sep 2021 10:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348337AbhI3I34 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Sep 2021 04:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348109AbhI3I34 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Sep 2021 04:29:56 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826ADC06161C;
        Thu, 30 Sep 2021 01:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+L12sTTirMmOEVfxeyEGi5LQTEZvYrWzWkQwzAhxwkg=; b=OujGqol3VJa/GixiJqWuCxtHmI
        RPdfebF2NWO2yZnEaDh7ToE4VwUCUNrlk556tz6DMsnw2u+LEC6IyBkqi36oj/quB40JIDmsS23Hf
        cqgQRwR+eQu6yYZFowjF9CgOG80LJFMzcCzgNVoOkaIBE1OiWTMYTqQ0cFU2F8eMQ1HbMVvoGO37z
        oK5U7yx9YHODvwWjjuY7nw7paR1N9EbUgzlN5mvtAqSEK62hiLjZ5ca+UzxPrgnZz3lkMEaNuzSnu
        vXHTkdZfpbbWBky55tV4BQ2yyu2kxEjunJZJ7pg/Uyg7ST8jGK6xUNoB/dwcXTVzqxYPyQ1jIhiSY
        VHc8rWuw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mVrPL-006ukp-Hc; Thu, 30 Sep 2021 08:27:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 74707300268;
        Thu, 30 Sep 2021 10:27:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5693B266411AD; Thu, 30 Sep 2021 10:27:07 +0200 (CEST)
Date:   Thu, 30 Sep 2021 10:27:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        kernel test robot <oliver.sang@intel.com>,
        Vito Caputo <vcaputo@pengaru.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Anand K Mistry <amistry@google.com>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        Alexey Gladkov <legion@kernel.org>,
        Michael =?iso-8859-1?Q?Wei=DF?= 
        <michael.weiss@aisec.fraunhofer.de>,
        Michal Hocko <mhocko@suse.com>, Helge Deller <deller@gmx.de>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        "Tobin C. Harding" <me@tobin.cc>,
        Tycho Andersen <tycho@tycho.pizza>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jens Axboe <axboe@kernel.dk>,
        Stefan Metzmacher <metze@samba.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ohhoon Kwon <ohoono.kwon@samsung.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-hardening@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v2 2/6] sched: Add wrapper for get_wchan() to keep task
 blocked
Message-ID: <YVV027mFdUe9prGW@hirez.programming.kicks-ass.net>
References: <20210929220218.691419-1-keescook@chromium.org>
 <20210929220218.691419-3-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929220218.691419-3-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 29, 2021 at 03:02:14PM -0700, Kees Cook wrote:
> Having a stable wchan means the process must be blocked and for it to
> stay that way while performing stack unwinding.

How's this instead?

---
Subject: sched: Wrap get_wchan() to keep task blocked
From: Kees Cook <keescook@chromium.org>
Date: Wed, 29 Sep 2021 15:02:14 -0700

From: Kees Cook <keescook@chromium.org>

Having a stable wchan means the process must be blocked and for it to
stay that way while performing stack unwinding.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
[peterz: __get_wchan]
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/alpha/include/asm/processor.h      |    2 +-
 arch/alpha/kernel/process.c             |    5 ++---
 arch/arc/include/asm/processor.h        |    2 +-
 arch/arc/kernel/stacktrace.c            |    4 ++--
 arch/arm/include/asm/processor.h        |    2 +-
 arch/arm/kernel/process.c               |    4 +---
 arch/arm64/include/asm/processor.h      |    2 +-
 arch/arm64/kernel/process.c             |    4 +---
 arch/csky/include/asm/processor.h       |    2 +-
 arch/csky/kernel/stacktrace.c           |    5 ++---
 arch/h8300/include/asm/processor.h      |    2 +-
 arch/h8300/kernel/process.c             |    5 +----
 arch/hexagon/include/asm/processor.h    |    2 +-
 arch/hexagon/kernel/process.c           |    4 +---
 arch/ia64/include/asm/processor.h       |    2 +-
 arch/ia64/kernel/process.c              |    5 +----
 arch/m68k/include/asm/processor.h       |    2 +-
 arch/m68k/kernel/process.c              |    4 +---
 arch/microblaze/include/asm/processor.h |    2 +-
 arch/microblaze/kernel/process.c        |    2 +-
 arch/mips/include/asm/processor.h       |    2 +-
 arch/mips/kernel/process.c              |    8 +++-----
 arch/nds32/include/asm/processor.h      |    2 +-
 arch/nds32/kernel/process.c             |    7 +------
 arch/nios2/include/asm/processor.h      |    2 +-
 arch/nios2/kernel/process.c             |    5 +----
 arch/openrisc/include/asm/processor.h   |    2 +-
 arch/openrisc/kernel/process.c          |    2 +-
 arch/parisc/include/asm/processor.h     |    2 +-
 arch/parisc/kernel/process.c            |    5 +----
 arch/powerpc/include/asm/processor.h    |    2 +-
 arch/powerpc/kernel/process.c           |    9 +++------
 arch/riscv/include/asm/processor.h      |    2 +-
 arch/riscv/kernel/stacktrace.c          |   12 +++++-------
 arch/s390/include/asm/processor.h       |    2 +-
 arch/s390/kernel/process.c              |    4 ++--
 arch/sh/include/asm/processor_32.h      |    2 +-
 arch/sh/kernel/process_32.c             |    5 +----
 arch/sparc/include/asm/processor_32.h   |    2 +-
 arch/sparc/include/asm/processor_64.h   |    2 +-
 arch/sparc/kernel/process_32.c          |    5 +----
 arch/sparc/kernel/process_64.c          |    5 +----
 arch/um/include/asm/processor-generic.h |    2 +-
 arch/um/kernel/process.c                |    5 +----
 arch/x86/include/asm/processor.h        |    2 +-
 arch/x86/kernel/process.c               |    5 +----
 arch/xtensa/include/asm/processor.h     |    2 +-
 arch/xtensa/kernel/process.c            |    5 +----
 include/linux/sched.h                   |    1 +
 kernel/sched/core.c                     |   19 +++++++++++++++++++
 50 files changed, 80 insertions(+), 112 deletions(-)

--- a/arch/alpha/include/asm/processor.h
+++ b/arch/alpha/include/asm/processor.h
@@ -42,7 +42,7 @@ extern void start_thread(struct pt_regs
 struct task_struct;
 extern void release_thread(struct task_struct *);
 
-unsigned long get_wchan(struct task_struct *p);
+unsigned long __get_wchan(struct task_struct *p);
 
 #define KSTK_EIP(tsk) (task_pt_regs(tsk)->pc)
 
--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -376,12 +376,11 @@ thread_saved_pc(struct task_struct *t)
 }
 
 unsigned long
-get_wchan(struct task_struct *p)
+__get_wchan(struct task_struct *p)
 {
 	unsigned long schedule_frame;
 	unsigned long pc;
-	if (!p || p == current || task_is_running(p))
-		return 0;
+
 	/*
 	 * This one depends on the frame size of schedule().  Do a
 	 * "disass schedule" in gdb to find the frame size.  Also, the
--- a/arch/arc/include/asm/processor.h
+++ b/arch/arc/include/asm/processor.h
@@ -70,7 +70,7 @@ struct task_struct;
 extern void start_thread(struct pt_regs * regs, unsigned long pc,
 			 unsigned long usp);
 
-extern unsigned int get_wchan(struct task_struct *p);
+extern unsigned int __get_wchan(struct task_struct *p);
 
 #endif /* !__ASSEMBLY__ */
 
--- a/arch/arc/kernel/stacktrace.c
+++ b/arch/arc/kernel/stacktrace.c
@@ -15,7 +15,7 @@
  *      = specifics of data structs where trace is saved(CONFIG_STACKTRACE etc)
  *
  *  vineetg: March 2009
- *  -Implemented correct versions of thread_saved_pc() and get_wchan()
+ *  -Implemented correct versions of thread_saved_pc() and __get_wchan()
  *
  *  rajeshwarr: 2008
  *  -Initial implementation
@@ -248,7 +248,7 @@ void show_stack(struct task_struct *tsk,
  * Of course just returning schedule( ) would be pointless so unwind until
  * the function is not in schedular code
  */
-unsigned int get_wchan(struct task_struct *tsk)
+unsigned int __get_wchan(struct task_struct *tsk)
 {
 	return arc_unwind_core(tsk, NULL, __get_first_nonsched, NULL);
 }
--- a/arch/arm/include/asm/processor.h
+++ b/arch/arm/include/asm/processor.h
@@ -84,7 +84,7 @@ struct task_struct;
 /* Free all resources held by a thread. */
 extern void release_thread(struct task_struct *);
 
-unsigned long get_wchan(struct task_struct *p);
+unsigned long __get_wchan(struct task_struct *p);
 
 #define task_pt_regs(p) \
 	((struct pt_regs *)(THREAD_START_SP + task_stack_page(p)) - 1)
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -276,13 +276,11 @@ int copy_thread(unsigned long clone_flag
 	return 0;
 }
 
-unsigned long get_wchan(struct task_struct *p)
+unsigned long __get_wchan(struct task_struct *p)
 {
 	struct stackframe frame;
 	unsigned long stack_page;
 	int count = 0;
-	if (!p || p == current || task_is_running(p))
-		return 0;
 
 	frame.fp = thread_saved_fp(p);
 	frame.sp = thread_saved_sp(p);
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -257,7 +257,7 @@ struct task_struct;
 /* Free all resources held by a thread. */
 extern void release_thread(struct task_struct *);
 
-unsigned long get_wchan(struct task_struct *p);
+unsigned long __get_wchan(struct task_struct *p);
 
 void update_sctlr_el1(u64 sctlr);
 
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -528,13 +528,11 @@ __notrace_funcgraph struct task_struct *
 	return last;
 }
 
-unsigned long get_wchan(struct task_struct *p)
+unsigned long __get_wchan(struct task_struct *p)
 {
 	struct stackframe frame;
 	unsigned long stack_page, ret = 0;
 	int count = 0;
-	if (!p || p == current || task_is_running(p))
-		return 0;
 
 	stack_page = (unsigned long)try_get_task_stack(p);
 	if (!stack_page)
--- a/arch/csky/include/asm/processor.h
+++ b/arch/csky/include/asm/processor.h
@@ -81,7 +81,7 @@ static inline void release_thread(struct
 
 extern int kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
 
-unsigned long get_wchan(struct task_struct *p);
+unsigned long __get_wchan(struct task_struct *p);
 
 #define KSTK_EIP(tsk)		(task_pt_regs(tsk)->pc)
 #define KSTK_ESP(tsk)		(task_pt_regs(tsk)->usp)
--- a/arch/csky/kernel/stacktrace.c
+++ b/arch/csky/kernel/stacktrace.c
@@ -111,12 +111,11 @@ static bool save_wchan(unsigned long pc,
 	return false;
 }
 
-unsigned long get_wchan(struct task_struct *task)
+unsigned long __get_wchan(struct task_struct *task)
 {
 	unsigned long pc = 0;
 
-	if (likely(task && task != current && !task_is_running(task)))
-		walk_stackframe(task, NULL, save_wchan, &pc);
+	walk_stackframe(task, NULL, save_wchan, &pc);
 	return pc;
 }
 
--- a/arch/h8300/include/asm/processor.h
+++ b/arch/h8300/include/asm/processor.h
@@ -105,7 +105,7 @@ static inline void release_thread(struct
 {
 }
 
-unsigned long get_wchan(struct task_struct *p);
+unsigned long __get_wchan(struct task_struct *p);
 
 #define	KSTK_EIP(tsk)	\
 	({			 \
--- a/arch/h8300/kernel/process.c
+++ b/arch/h8300/kernel/process.c
@@ -128,15 +128,12 @@ int copy_thread(unsigned long clone_flag
 	return 0;
 }
 
-unsigned long get_wchan(struct task_struct *p)
+unsigned long __get_wchan(struct task_struct *p)
 {
 	unsigned long fp, pc;
 	unsigned long stack_page;
 	int count = 0;
 
-	if (!p || p == current || task_is_running(p))
-		return 0;
-
 	stack_page = (unsigned long)p;
 	fp = ((struct pt_regs *)p->thread.ksp)->er6;
 	do {
--- a/arch/hexagon/include/asm/processor.h
+++ b/arch/hexagon/include/asm/processor.h
@@ -64,7 +64,7 @@ struct thread_struct {
 extern void release_thread(struct task_struct *dead_task);
 
 /* Get wait channel for task P.  */
-extern unsigned long get_wchan(struct task_struct *p);
+extern unsigned long __get_wchan(struct task_struct *p);
 
 /*  The following stuff is pretty HEXAGON specific.  */
 
--- a/arch/hexagon/kernel/process.c
+++ b/arch/hexagon/kernel/process.c
@@ -130,13 +130,11 @@ void flush_thread(void)
  * is an identification of the point at which the scheduler
  * was invoked by a blocked thread.
  */
-unsigned long get_wchan(struct task_struct *p)
+unsigned long __get_wchan(struct task_struct *p)
 {
 	unsigned long fp, pc;
 	unsigned long stack_page;
 	int count = 0;
-	if (!p || p == current || task_is_running(p))
-		return 0;
 
 	stack_page = (unsigned long)task_stack_page(p);
 	fp = ((struct hexagon_switch_stack *)p->thread.switch_sp)->fp;
--- a/arch/ia64/include/asm/processor.h
+++ b/arch/ia64/include/asm/processor.h
@@ -330,7 +330,7 @@ struct task_struct;
 #define release_thread(dead_task)
 
 /* Get wait channel for task P.  */
-extern unsigned long get_wchan (struct task_struct *p);
+extern unsigned long __get_wchan (struct task_struct *p);
 
 /* Return instruction pointer of blocked task TSK.  */
 #define KSTK_EIP(tsk)					\
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -523,15 +523,12 @@ exit_thread (struct task_struct *tsk)
 }
 
 unsigned long
-get_wchan (struct task_struct *p)
+__get_wchan (struct task_struct *p)
 {
 	struct unw_frame_info info;
 	unsigned long ip;
 	int count = 0;
 
-	if (!p || p == current || task_is_running(p))
-		return 0;
-
 	/*
 	 * Note: p may not be a blocked task (it could be current or
 	 * another process running on some other CPU.  Rather than
--- a/arch/m68k/include/asm/processor.h
+++ b/arch/m68k/include/asm/processor.h
@@ -125,7 +125,7 @@ static inline void release_thread(struct
 {
 }
 
-unsigned long get_wchan(struct task_struct *p);
+unsigned long __get_wchan(struct task_struct *p);
 
 #define	KSTK_EIP(tsk)	\
     ({			\
--- a/arch/m68k/kernel/process.c
+++ b/arch/m68k/kernel/process.c
@@ -263,13 +263,11 @@ int dump_fpu (struct pt_regs *regs, stru
 }
 EXPORT_SYMBOL(dump_fpu);
 
-unsigned long get_wchan(struct task_struct *p)
+unsigned long __get_wchan(struct task_struct *p)
 {
 	unsigned long fp, pc;
 	unsigned long stack_page;
 	int count = 0;
-	if (!p || p == current || task_is_running(p))
-		return 0;
 
 	stack_page = (unsigned long)task_stack_page(p);
 	fp = ((struct switch_stack *)p->thread.ksp)->a6;
--- a/arch/microblaze/include/asm/processor.h
+++ b/arch/microblaze/include/asm/processor.h
@@ -68,7 +68,7 @@ static inline void release_thread(struct
 {
 }
 
-unsigned long get_wchan(struct task_struct *p);
+unsigned long __get_wchan(struct task_struct *p);
 
 /* The size allocated for kernel stacks. This _must_ be a power of two! */
 # define KERNEL_STACK_SIZE	0x2000
--- a/arch/microblaze/kernel/process.c
+++ b/arch/microblaze/kernel/process.c
@@ -112,7 +112,7 @@ int copy_thread(unsigned long clone_flag
 	return 0;
 }
 
-unsigned long get_wchan(struct task_struct *p)
+unsigned long __get_wchan(struct task_struct *p)
 {
 /* TBD (used by procfs) */
 	return 0;
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -369,7 +369,7 @@ static inline void flush_thread(void)
 {
 }
 
-unsigned long get_wchan(struct task_struct *p);
+unsigned long __get_wchan(struct task_struct *p);
 
 #define __KSTK_TOS(tsk) ((unsigned long)task_stack_page(tsk) + \
 			 THREAD_SIZE - 32 - sizeof(struct pt_regs))
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -511,7 +511,7 @@ static int __init frame_info_init(void)
 
 	/*
 	 * Without schedule() frame info, result given by
-	 * thread_saved_pc() and get_wchan() are not reliable.
+	 * thread_saved_pc() and __get_wchan() are not reliable.
 	 */
 	if (schedule_mfi.pc_offset < 0)
 		printk("Can't analyze schedule() prologue at %p\n", schedule);
@@ -652,9 +652,9 @@ unsigned long unwind_stack(struct task_s
 #endif
 
 /*
- * get_wchan - a maintenance nightmare^W^Wpain in the ass ...
+ * __get_wchan - a maintenance nightmare^W^Wpain in the ass ...
  */
-unsigned long get_wchan(struct task_struct *task)
+unsigned long __get_wchan(struct task_struct *task)
 {
 	unsigned long pc = 0;
 #ifdef CONFIG_KALLSYMS
@@ -662,8 +662,6 @@ unsigned long get_wchan(struct task_stru
 	unsigned long ra = 0;
 #endif
 
-	if (!task || task == current || task_is_running(task))
-		goto out;
 	if (!task_stack_page(task))
 		goto out;
 
--- a/arch/nds32/include/asm/processor.h
+++ b/arch/nds32/include/asm/processor.h
@@ -83,7 +83,7 @@ extern struct task_struct *last_task_use
 /* Prepare to copy thread state - unlazy all lazy status */
 #define prepare_to_copy(tsk)	do { } while (0)
 
-unsigned long get_wchan(struct task_struct *p);
+unsigned long __get_wchan(struct task_struct *p);
 
 #define cpu_relax()			barrier()
 
--- a/arch/nds32/kernel/process.c
+++ b/arch/nds32/kernel/process.c
@@ -233,15 +233,12 @@ int dump_fpu(struct pt_regs *regs, elf_f
 
 EXPORT_SYMBOL(dump_fpu);
 
-unsigned long get_wchan(struct task_struct *p)
+unsigned long __get_wchan(struct task_struct *p)
 {
 	unsigned long fp, lr;
 	unsigned long stack_start, stack_end;
 	int count = 0;
 
-	if (!p || p == current || task_is_running(p))
-		return 0;
-
 	if (IS_ENABLED(CONFIG_FRAME_POINTER)) {
 		stack_start = (unsigned long)end_of_stack(p);
 		stack_end = (unsigned long)task_stack_page(p) + THREAD_SIZE;
@@ -258,5 +255,3 @@ unsigned long get_wchan(struct task_stru
 	}
 	return 0;
 }
-
-EXPORT_SYMBOL(get_wchan);
--- a/arch/nios2/include/asm/processor.h
+++ b/arch/nios2/include/asm/processor.h
@@ -69,7 +69,7 @@ static inline void release_thread(struct
 {
 }
 
-extern unsigned long get_wchan(struct task_struct *p);
+extern unsigned long __get_wchan(struct task_struct *p);
 
 #define task_pt_regs(p) \
 	((struct pt_regs *)(THREAD_SIZE + task_stack_page(p)) - 1)
--- a/arch/nios2/kernel/process.c
+++ b/arch/nios2/kernel/process.c
@@ -217,15 +217,12 @@ void dump(struct pt_regs *fp)
 	pr_emerg("\n\n");
 }
 
-unsigned long get_wchan(struct task_struct *p)
+unsigned long __get_wchan(struct task_struct *p)
 {
 	unsigned long fp, pc;
 	unsigned long stack_page;
 	int count = 0;
 
-	if (!p || p == current || task_is_running(p))
-		return 0;
-
 	stack_page = (unsigned long)p;
 	fp = ((struct switch_stack *)p->thread.ksp)->fp;	/* ;dgt2 */
 	do {
--- a/arch/openrisc/include/asm/processor.h
+++ b/arch/openrisc/include/asm/processor.h
@@ -73,7 +73,7 @@ struct thread_struct {
 
 void start_thread(struct pt_regs *regs, unsigned long nip, unsigned long sp);
 void release_thread(struct task_struct *);
-unsigned long get_wchan(struct task_struct *p);
+unsigned long __get_wchan(struct task_struct *p);
 
 #define cpu_relax()     barrier()
 
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -263,7 +263,7 @@ void dump_elf_thread(elf_greg_t *dest, s
 	dest[35] = 0;
 }
 
-unsigned long get_wchan(struct task_struct *p)
+unsigned long __get_wchan(struct task_struct *p)
 {
 	/* TODO */
 
--- a/arch/parisc/include/asm/processor.h
+++ b/arch/parisc/include/asm/processor.h
@@ -273,7 +273,7 @@ struct mm_struct;
 /* Free all resources held by a thread. */
 extern void release_thread(struct task_struct *);
 
-extern unsigned long get_wchan(struct task_struct *p);
+extern unsigned long __get_wchan(struct task_struct *p);
 
 #define KSTK_EIP(tsk)	((tsk)->thread.regs.iaoq[0])
 #define KSTK_ESP(tsk)	((tsk)->thread.regs.gr[30])
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -240,15 +240,12 @@ copy_thread(unsigned long clone_flags, u
 }
 
 unsigned long
-get_wchan(struct task_struct *p)
+__get_wchan(struct task_struct *p)
 {
 	struct unwind_frame_info info;
 	unsigned long ip;
 	int count = 0;
 
-	if (!p || p == current || task_is_running(p))
-		return 0;
-
 	/*
 	 * These bracket the sleeping functions..
 	 */
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -300,7 +300,7 @@ struct thread_struct {
 
 #define task_pt_regs(tsk)	((tsk)->thread.regs)
 
-unsigned long get_wchan(struct task_struct *p);
+unsigned long __get_wchan(struct task_struct *p);
 
 #define KSTK_EIP(tsk)  ((tsk)->thread.regs? (tsk)->thread.regs->nip: 0)
 #define KSTK_ESP(tsk)  ((tsk)->thread.regs? (tsk)->thread.regs->gpr[1]: 0)
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -2111,14 +2111,11 @@ int validate_sp(unsigned long sp, struct
 
 EXPORT_SYMBOL(validate_sp);
 
-static unsigned long __get_wchan(struct task_struct *p)
+static unsigned long ___get_wchan(struct task_struct *p)
 {
 	unsigned long ip, sp;
 	int count = 0;
 
-	if (!p || p == current || task_is_running(p))
-		return 0;
-
 	sp = p->thread.ksp;
 	if (!validate_sp(sp, p, STACK_FRAME_OVERHEAD))
 		return 0;
@@ -2137,14 +2134,14 @@ static unsigned long __get_wchan(struct
 	return 0;
 }
 
-unsigned long get_wchan(struct task_struct *p)
+unsigned long __get_wchan(struct task_struct *p)
 {
 	unsigned long ret;
 
 	if (!try_get_task_stack(p))
 		return 0;
 
-	ret = __get_wchan(p);
+	ret = ___get_wchan(p);
 
 	put_task_stack(p);
 
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -66,7 +66,7 @@ static inline void release_thread(struct
 {
 }
 
-extern unsigned long get_wchan(struct task_struct *p);
+extern unsigned long __get_wchan(struct task_struct *p);
 
 
 static inline void wait_for_interrupt(void)
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -128,16 +128,14 @@ static bool save_wchan(void *arg, unsign
 	return true;
 }
 
-unsigned long get_wchan(struct task_struct *task)
+unsigned long __get_wchan(struct task_struct *task)
 {
 	unsigned long pc = 0;
 
-	if (likely(task && task != current && !task_is_running(task))) {
-		if (!try_get_task_stack(task))
-			return 0;
-		walk_stackframe(task, NULL, save_wchan, &pc);
-		put_task_stack(task);
-	}
+	if (!try_get_task_stack(task))
+		return 0;
+	walk_stackframe(task, NULL, save_wchan, &pc);
+	put_task_stack(task);
 	return pc;
 }
 
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -192,7 +192,7 @@ static inline void release_thread(struct
 void guarded_storage_release(struct task_struct *tsk);
 void gs_load_bc_cb(struct pt_regs *regs);
 
-unsigned long get_wchan(struct task_struct *p);
+unsigned long __get_wchan(struct task_struct *p);
 #define task_pt_regs(tsk) ((struct pt_regs *) \
         (task_stack_page(tsk) + THREAD_SIZE) - 1)
 #define KSTK_EIP(tsk)	(task_pt_regs(tsk)->psw.addr)
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -181,12 +181,12 @@ void execve_tail(void)
 	asm volatile("sfpc %0" : : "d" (0));
 }
 
-unsigned long get_wchan(struct task_struct *p)
+unsigned long __get_wchan(struct task_struct *p)
 {
 	struct unwind_state state;
 	unsigned long ip = 0;
 
-	if (!p || p == current || task_is_running(p) || !task_stack_page(p))
+	if (!task_stack_page(p))
 		return 0;
 
 	if (!try_get_task_stack(p))
--- a/arch/sh/include/asm/processor_32.h
+++ b/arch/sh/include/asm/processor_32.h
@@ -180,7 +180,7 @@ static inline void show_code(struct pt_r
 }
 #endif
 
-extern unsigned long get_wchan(struct task_struct *p);
+extern unsigned long __get_wchan(struct task_struct *p);
 
 #define KSTK_EIP(tsk)  (task_pt_regs(tsk)->pc)
 #define KSTK_ESP(tsk)  (task_pt_regs(tsk)->regs[15])
--- a/arch/sh/kernel/process_32.c
+++ b/arch/sh/kernel/process_32.c
@@ -182,13 +182,10 @@ __switch_to(struct task_struct *prev, st
 	return prev;
 }
 
-unsigned long get_wchan(struct task_struct *p)
+unsigned long __get_wchan(struct task_struct *p)
 {
 	unsigned long pc;
 
-	if (!p || p == current || task_is_running(p))
-		return 0;
-
 	/*
 	 * The same comment as on the Alpha applies here, too ...
 	 */
--- a/arch/sparc/include/asm/processor_32.h
+++ b/arch/sparc/include/asm/processor_32.h
@@ -89,7 +89,7 @@ static inline void start_thread(struct p
 /* Free all resources held by a thread. */
 #define release_thread(tsk)		do { } while(0)
 
-unsigned long get_wchan(struct task_struct *);
+unsigned long __get_wchan(struct task_struct *);
 
 #define task_pt_regs(tsk) ((tsk)->thread.kregs)
 #define KSTK_EIP(tsk)  ((tsk)->thread.kregs->pc)
--- a/arch/sparc/include/asm/processor_64.h
+++ b/arch/sparc/include/asm/processor_64.h
@@ -183,7 +183,7 @@ do { \
 /* Free all resources held by a thread. */
 #define release_thread(tsk)		do { } while (0)
 
-unsigned long get_wchan(struct task_struct *task);
+unsigned long __get_wchan(struct task_struct *task);
 
 #define task_pt_regs(tsk) (task_thread_info(tsk)->kregs)
 #define KSTK_EIP(tsk)  (task_pt_regs(tsk)->tpc)
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -365,7 +365,7 @@ int copy_thread(unsigned long clone_flag
 	return 0;
 }
 
-unsigned long get_wchan(struct task_struct *task)
+unsigned long __get_wchan(struct task_struct *task)
 {
 	unsigned long pc, fp, bias = 0;
 	unsigned long task_base = (unsigned long) task;
@@ -373,9 +373,6 @@ unsigned long get_wchan(struct task_stru
 	struct reg_window32 *rw;
 	int count = 0;
 
-	if (!task || task == current || task_is_running(task))
-		goto out;
-
 	fp = task_thread_info(task)->ksp + bias;
 	do {
 		/* Bogus frame pointer? */
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -663,7 +663,7 @@ int arch_dup_task_struct(struct task_str
 	return 0;
 }
 
-unsigned long get_wchan(struct task_struct *task)
+unsigned long __get_wchan(struct task_struct *task)
 {
 	unsigned long pc, fp, bias = 0;
 	struct thread_info *tp;
@@ -671,9 +671,6 @@ unsigned long get_wchan(struct task_stru
         unsigned long ret = 0;
 	int count = 0; 
 
-	if (!task || task == current || task_is_running(task))
-		goto out;
-
 	tp = task_thread_info(task);
 	bias = STACK_BIAS;
 	fp = task_thread_info(task)->ksp + bias;
--- a/arch/um/include/asm/processor-generic.h
+++ b/arch/um/include/asm/processor-generic.h
@@ -106,6 +106,6 @@ extern struct cpuinfo_um boot_cpu_data;
 #define cache_line_size()	(boot_cpu_data.cache_alignment)
 
 #define KSTK_REG(tsk, reg) get_thread_reg(reg, &tsk->thread.switch_buf)
-extern unsigned long get_wchan(struct task_struct *p);
+extern unsigned long __get_wchan(struct task_struct *p);
 
 #endif
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -364,14 +364,11 @@ unsigned long arch_align_stack(unsigned
 }
 #endif
 
-unsigned long get_wchan(struct task_struct *p)
+unsigned long __get_wchan(struct task_struct *p)
 {
 	unsigned long stack_page, sp, ip;
 	bool seen_sched = 0;
 
-	if ((p == NULL) || (p == current) || task_is_running(p))
-		return 0;
-
 	stack_page = (unsigned long) task_stack_page(p);
 	/* Bail if the process has no kernel stack for some reason */
 	if (stack_page == 0)
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -590,7 +590,7 @@ static inline void load_sp0(unsigned lon
 /* Free all resources held by a thread. */
 extern void release_thread(struct task_struct *);
 
-unsigned long get_wchan(struct task_struct *p);
+unsigned long __get_wchan(struct task_struct *p);
 
 /*
  * Generic CPUID function
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -943,13 +943,10 @@ unsigned long arch_randomize_brk(struct
  * because the task might wake up and we might look at a stack
  * changing under us.
  */
-unsigned long get_wchan(struct task_struct *p)
+unsigned long __get_wchan(struct task_struct *p)
 {
 	unsigned long entry = 0;
 
-	if (p == current || task_is_running(p))
-		return 0;
-
 	stack_trace_save_tsk(p, &entry, 1, 0);
 	return entry;
 }
--- a/arch/xtensa/include/asm/processor.h
+++ b/arch/xtensa/include/asm/processor.h
@@ -215,7 +215,7 @@ struct mm_struct;
 /* Free all resources held by a thread. */
 #define release_thread(thread) do { } while(0)
 
-extern unsigned long get_wchan(struct task_struct *p);
+extern unsigned long __get_wchan(struct task_struct *p);
 
 #define KSTK_EIP(tsk)		(task_pt_regs(tsk)->pc)
 #define KSTK_ESP(tsk)		(task_pt_regs(tsk)->areg[1])
--- a/arch/xtensa/kernel/process.c
+++ b/arch/xtensa/kernel/process.c
@@ -298,15 +298,12 @@ int copy_thread(unsigned long clone_flag
  * These bracket the sleeping functions..
  */
 
-unsigned long get_wchan(struct task_struct *p)
+unsigned long __get_wchan(struct task_struct *p)
 {
 	unsigned long sp, pc;
 	unsigned long stack_page = (unsigned long) task_stack_page(p);
 	int count = 0;
 
-	if (!p || p == current || task_is_running(p))
-		return 0;
-
 	sp = p->thread.sp;
 	pc = MAKE_PC_FROM_RA(p->thread.ra, p->thread.sp);
 
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2139,6 +2139,7 @@ static inline void set_task_cpu(struct t
 #endif /* CONFIG_SMP */
 
 extern bool sched_task_on_rq(struct task_struct *p);
+extern unsigned long get_wchan(struct task_struct *p);
 
 /*
  * In order to reduce various lock holder preemption latencies provide an
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1962,6 +1962,25 @@ bool sched_task_on_rq(struct task_struct
 	return task_on_rq_queued(p);
 }
 
+unsigned long get_wchan(struct task_struct *p)
+{
+	unsigned long ip = 0;
+	unsigned int state;
+
+	if (!p || p == current)
+		return 0;
+
+	/* Only get wchan if task is blocked and we can keep it that way. */
+	raw_spin_lock_irq(&p->pi_lock);
+	state = READ_ONCE(p->__state);
+	smp_rmb(); /* see try_to_wake_up() */
+	if (state != TASK_RUNNING && state != TASK_WAKING && !p->on_rq)
+		ip = __get_wchan(p);
+	raw_spin_unlock_irq(&p->pi_lock);
+
+	return ip;
+}
+
 static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 {
 	if (!(flags & ENQUEUE_NOCLOCK))
