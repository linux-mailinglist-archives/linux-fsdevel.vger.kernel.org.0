Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 473EA41D568
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Sep 2021 10:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348312AbhI3Iby (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Sep 2021 04:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236162AbhI3Iby (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Sep 2021 04:31:54 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C5FC06161C;
        Thu, 30 Sep 2021 01:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=e4x0QLBhxqxpYlsmnC9/Rhwg35CPPY/9OtJK2QmAvpg=; b=ECSjIDDintEsPUe7JUuZXjPMv2
        Er7l3JB23WZu4UwacGDBwyDNyor/3lesBhR9Wz7G+pS4SiCfzelP7rfVVjm5+J0yPIEZRkVWi8Yuh
        tJ9P0rb9380Wc/8SW6BqjsUIHnjZD4mg0smjs2njNzO64gxPjh/N3EBHPDW+4JFrOc5rIAjwL0cuE
        CgFf1Is8lvZ5vYsRbFPKuVghaaMl0CfWgHYUqHyBkup/t9jdPyF8AcUjTmE5t22thyZahN203plGh
        EyMs0rDHG9jkdJ4xwXLJyypy7HBRwkHcR/9lrmFwFw87O6jJbrPJqgTcaEn9NIXxbKP1IIAugGytf
        SePvdtbA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mVrRd-006uoH-H1; Thu, 30 Sep 2021 08:29:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 27783300252;
        Thu, 30 Sep 2021 10:29:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 146C8266411AD; Thu, 30 Sep 2021 10:29:33 +0200 (CEST)
Date:   Thu, 30 Sep 2021 10:29:33 +0200
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
Message-ID: <YVV1bR9TTUVjXI7G@hirez.programming.kicks-ass.net>
References: <20210929220218.691419-1-keescook@chromium.org>
 <20210929220218.691419-3-keescook@chromium.org>
 <YVV027mFdUe9prGW@hirez.programming.kicks-ass.net>
 <YVV1NZ68kLRYBo10@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVV1NZ68kLRYBo10@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 30, 2021 at 10:28:37AM +0200, Peter Zijlstra wrote:
> On Thu, Sep 30, 2021 at 10:27:07AM +0200, Peter Zijlstra wrote:
> > On Wed, Sep 29, 2021 at 03:02:14PM -0700, Kees Cook wrote:
> > > Having a stable wchan means the process must be blocked and for it to
> > > stay that way while performing stack unwinding.
> > 
> > How's this instead?
> > 
> On top of which we can do..

But that then leads to..

---
Subject: arch: Fix STACKTRACE_SUPPORT
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu Sep 30 10:21:15 CEST 2021

A few archs got save_stack_trace_tsk() vs in_sched_functions() wrong.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/csky/kernel/stacktrace.c  |    7 ++++++-
 arch/mips/kernel/stacktrace.c  |   27 ++++++++++++++++-----------
 arch/nds32/kernel/stacktrace.c |   20 +++++++++++---------
 3 files changed, 33 insertions(+), 21 deletions(-)

--- a/arch/csky/kernel/stacktrace.c
+++ b/arch/csky/kernel/stacktrace.c
@@ -132,12 +132,17 @@ static bool save_trace(unsigned long pc,
 	return __save_trace(pc, arg, false);
 }
 
+static bool save_trace_nosched(unsigned long pc, void *arg)
+{
+	return __save_trace(pc, arg, true);
+}
+
 /*
  * Save stack-backtrace addresses into a stack_trace buffer.
  */
 void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 {
-	walk_stackframe(tsk, NULL, save_trace, trace);
+	walk_stackframe(tsk, NULL, save_trace_nosched, trace);
 }
 EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
 
--- a/arch/mips/kernel/stacktrace.c
+++ b/arch/mips/kernel/stacktrace.c
@@ -66,16 +66,7 @@ static void save_context_stack(struct st
 #endif
 }
 
-/*
- * Save stack-backtrace addresses into a stack_trace buffer.
- */
-void save_stack_trace(struct stack_trace *trace)
-{
-	save_stack_trace_tsk(current, trace);
-}
-EXPORT_SYMBOL_GPL(save_stack_trace);
-
-void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
+void __save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace, bool savesched)
 {
 	struct pt_regs dummyregs;
 	struct pt_regs *regs = &dummyregs;
@@ -88,6 +79,20 @@ void save_stack_trace_tsk(struct task_st
 		regs->cp0_epc = tsk->thread.reg31;
 	} else
 		prepare_frametrace(regs);
-	save_context_stack(trace, tsk, regs, tsk == current);
+	save_context_stack(trace, tsk, regs, savesched);
+}
+
+/*
+ * Save stack-backtrace addresses into a stack_trace buffer.
+ */
+void save_stack_trace(struct stack_trace *trace)
+{
+	__save_stack_trace_tsk(current, trace, true);
+}
+EXPORT_SYMBOL_GPL(save_stack_trace);
+
+void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
+{
+	__save_stack_trace_tsk(tsk, trace, false);
 }
 EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
--- a/arch/nds32/kernel/stacktrace.c
+++ b/arch/nds32/kernel/stacktrace.c
@@ -6,13 +6,7 @@
 #include <linux/stacktrace.h>
 #include <linux/ftrace.h>
 
-void save_stack_trace(struct stack_trace *trace)
-{
-	save_stack_trace_tsk(current, trace);
-}
-EXPORT_SYMBOL_GPL(save_stack_trace);
-
-void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
+static void __save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace, bool savesched)
 {
 	unsigned long *fpn;
 	int skip = trace->skip;
@@ -21,10 +15,8 @@ void save_stack_trace_tsk(struct task_st
 
 	if (tsk == current) {
 		__asm__ __volatile__("\tori\t%0, $fp, #0\n":"=r"(fpn));
-		savesched = 1;
 	} else {
 		fpn = (unsigned long *)thread_saved_fp(tsk);
-		savesched = 0;
 	}
 
 	while (!kstack_end(fpn) && !((unsigned long)fpn & 0x3)
@@ -50,4 +42,14 @@ void save_stack_trace_tsk(struct task_st
 		fpn = (unsigned long *)fpp;
 	}
 }
+void save_stack_trace(struct stack_trace *trace)
+{
+	__save_stack_trace_tsk(current, trace, true);
+}
+EXPORT_SYMBOL_GPL(save_stack_trace);
+
+void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
+{
+	__save_stack_trace_tsk(tsk, trace, false);
+}
 EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
