Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE65A28920E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 21:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403799AbgJITn1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 15:43:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:2891 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403780AbgJITnW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 15:43:22 -0400
IronPort-SDR: h0uS+odjFhrLMbeHBMREWtH27f8f0AK+9++50O07wCMAt7OG3hwBG+6xlumEP2lmNkr8CS8nCb
 JhIUM6SiNBMQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9769"; a="182975359"
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; 
   d="scan'208";a="182975359"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 12:43:22 -0700
IronPort-SDR: MkfnCLSSRwOBTQEfWdMVmXruOqSNup+ZdyDI/59QanK2/5c7cgi3y+Kyqitw3PbH47IJQ1/95p
 LM+Wp9uIp/MA==
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; 
   d="scan'208";a="354957039"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 12:43:21 -0700
From:   ira.weiny@intel.com
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH RFC V3 6/9] x86/entry: Pass irqentry_state_t by reference
Date:   Fri,  9 Oct 2020 12:42:55 -0700
Message-Id: <20201009194258.3207172-7-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20201009194258.3207172-1-ira.weiny@intel.com>
References: <20201009194258.3207172-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

In preparation for adding PKS information to struct irqentry_state_t
change all call sites and usages to pass the struct by reference
instead of by value.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 arch/x86/entry/common.c         | 16 +++++++---------
 arch/x86/include/asm/idtentry.h | 29 +++++++++++++++++------------
 arch/x86/kernel/kvm.c           |  4 ++--
 arch/x86/kernel/nmi.c           |  7 ++++---
 arch/x86/kernel/traps.c         | 21 +++++++++++++--------
 arch/x86/mm/fault.c             |  4 ++--
 include/linux/entry-common.h    |  7 ++++---
 kernel/entry/common.c           | 20 ++++++++------------
 8 files changed, 57 insertions(+), 51 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 870efeec8bda..305da13770b6 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -209,9 +209,9 @@ SYSCALL_DEFINE0(ni_syscall)
 	return -ENOSYS;
 }
 
-noinstr bool idtentry_enter_nmi(struct pt_regs *regs)
+noinstr void idtentry_enter_nmi(struct pt_regs *regs, irqentry_state_t *irq_state)
 {
-	bool irq_state = lockdep_hardirqs_enabled();
+	irq_state->exit_rcu = lockdep_hardirqs_enabled();
 
 	__nmi_enter();
 	lockdep_hardirqs_off(CALLER_ADDR0);
@@ -222,15 +222,13 @@ noinstr bool idtentry_enter_nmi(struct pt_regs *regs)
 	trace_hardirqs_off_finish();
 	ftrace_nmi_enter();
 	instrumentation_end();
-
-	return irq_state;
 }
 
-noinstr void idtentry_exit_nmi(struct pt_regs *regs, bool restore)
+noinstr void idtentry_exit_nmi(struct pt_regs *regs, irqentry_state_t *irq_state)
 {
 	instrumentation_begin();
 	ftrace_nmi_exit();
-	if (restore) {
+	if (irq_state->exit_rcu) {
 		trace_hardirqs_on_prepare();
 		lockdep_hardirqs_on_prepare(CALLER_ADDR0);
 	}
@@ -238,7 +236,7 @@ noinstr void idtentry_exit_nmi(struct pt_regs *regs, bool restore)
 
 	rcu_nmi_exit();
 	lockdep_hardirq_exit();
-	if (restore)
+	if (irq_state->exit_rcu)
 		lockdep_hardirqs_on(CALLER_ADDR0);
 	__nmi_exit();
 }
@@ -295,7 +293,7 @@ __visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
 	bool inhcall;
 	irqentry_state_t state;
 
-	state = irqentry_enter(regs);
+	irqentry_enter(regs, &state);
 	old_regs = set_irq_regs(regs);
 
 	instrumentation_begin();
@@ -311,7 +309,7 @@ __visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
 		instrumentation_end();
 		restore_inhcall(inhcall);
 	} else {
-		irqentry_exit(regs, state);
+		irqentry_exit(regs, &state);
 	}
 }
 #endif /* CONFIG_XEN_PV */
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index a0638640f1ed..622889ba21d0 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -11,8 +11,8 @@
 
 #include <asm/irq_stack.h>
 
-bool idtentry_enter_nmi(struct pt_regs *regs);
-void idtentry_exit_nmi(struct pt_regs *regs, bool irq_state);
+void idtentry_enter_nmi(struct pt_regs *regs, irqentry_state_t *irq_state);
+void idtentry_exit_nmi(struct pt_regs *regs, irqentry_state_t *irq_state);
 
 /**
  * DECLARE_IDTENTRY - Declare functions for simple IDT entry points
@@ -52,12 +52,13 @@ static __always_inline void __##func(struct pt_regs *regs);		\
 									\
 __visible noinstr void func(struct pt_regs *regs)			\
 {									\
-	irqentry_state_t state = irqentry_enter(regs);			\
+	irqentry_state_t state;						\
 									\
+	irqentry_enter(regs, &state);					\
 	instrumentation_begin();					\
 	__##func (regs);						\
 	instrumentation_end();						\
-	irqentry_exit(regs, state);					\
+	irqentry_exit(regs, &state);					\
 }									\
 									\
 static __always_inline void __##func(struct pt_regs *regs)
@@ -99,12 +100,13 @@ static __always_inline void __##func(struct pt_regs *regs,		\
 __visible noinstr void func(struct pt_regs *regs,			\
 			    unsigned long error_code)			\
 {									\
-	irqentry_state_t state = irqentry_enter(regs);			\
+	irqentry_state_t state;						\
 									\
+	irqentry_enter(regs, &state);					\
 	instrumentation_begin();					\
 	__##func (regs, error_code);					\
 	instrumentation_end();						\
-	irqentry_exit(regs, state);					\
+	irqentry_exit(regs, &state);					\
 }									\
 									\
 static __always_inline void __##func(struct pt_regs *regs,		\
@@ -195,15 +197,16 @@ static __always_inline void __##func(struct pt_regs *regs, u8 vector);	\
 __visible noinstr void func(struct pt_regs *regs,			\
 			    unsigned long error_code)			\
 {									\
-	irqentry_state_t state = irqentry_enter(regs);			\
+	irqentry_state_t state;						\
 									\
+	irqentry_enter(regs, &state);					\
 	instrumentation_begin();					\
 	irq_enter_rcu();						\
 	kvm_set_cpu_l1tf_flush_l1d();					\
 	__##func (regs, (u8)error_code);				\
 	irq_exit_rcu();							\
 	instrumentation_end();						\
-	irqentry_exit(regs, state);					\
+	irqentry_exit(regs, &state);					\
 }									\
 									\
 static __always_inline void __##func(struct pt_regs *regs, u8 vector)
@@ -237,15 +240,16 @@ static void __##func(struct pt_regs *regs);				\
 									\
 __visible noinstr void func(struct pt_regs *regs)			\
 {									\
-	irqentry_state_t state = irqentry_enter(regs);			\
+	irqentry_state_t state;						\
 									\
+	irqentry_enter(regs, &state);					\
 	instrumentation_begin();					\
 	irq_enter_rcu();						\
 	kvm_set_cpu_l1tf_flush_l1d();					\
 	run_sysvec_on_irqstack_cond(__##func, regs);			\
 	irq_exit_rcu();							\
 	instrumentation_end();						\
-	irqentry_exit(regs, state);					\
+	irqentry_exit(regs, &state);					\
 }									\
 									\
 static noinline void __##func(struct pt_regs *regs)
@@ -266,15 +270,16 @@ static __always_inline void __##func(struct pt_regs *regs);		\
 									\
 __visible noinstr void func(struct pt_regs *regs)			\
 {									\
-	irqentry_state_t state = irqentry_enter(regs);			\
+	irqentry_state_t state;						\
 									\
+	irqentry_enter(regs, &state);					\
 	instrumentation_begin();					\
 	__irq_enter_raw();						\
 	kvm_set_cpu_l1tf_flush_l1d();					\
 	__##func (regs);						\
 	__irq_exit_raw();						\
 	instrumentation_end();						\
-	irqentry_exit(regs, state);					\
+	irqentry_exit(regs, &state);					\
 }									\
 									\
 static __always_inline void __##func(struct pt_regs *regs)
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 9663ba31347c..c6be0a54236f 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -241,7 +241,7 @@ noinstr bool __kvm_handle_async_pf(struct pt_regs *regs, u32 token)
 	if (!flags)
 		return false;
 
-	state = irqentry_enter(regs);
+	irqentry_enter(regs, &state);
 	instrumentation_begin();
 
 	/*
@@ -262,7 +262,7 @@ noinstr bool __kvm_handle_async_pf(struct pt_regs *regs, u32 token)
 	}
 
 	instrumentation_end();
-	irqentry_exit(regs, state);
+	irqentry_exit(regs, &state);
 	return true;
 }
 
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 4fc9954a9560..68c07cad0150 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -33,6 +33,7 @@
 #include <asm/reboot.h>
 #include <asm/cache.h>
 #include <asm/nospec-branch.h>
+#include <asm/idtentry.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/nmi.h>
@@ -475,7 +476,7 @@ static DEFINE_PER_CPU(unsigned long, nmi_dr7);
 
 DEFINE_IDTENTRY_RAW(exc_nmi)
 {
-	bool irq_state;
+	irqentry_state_t irq_state = { };
 
 	if (IS_ENABLED(CONFIG_SMP) && arch_cpu_is_offline(smp_processor_id()))
 		return;
@@ -490,14 +491,14 @@ DEFINE_IDTENTRY_RAW(exc_nmi)
 
 	this_cpu_write(nmi_dr7, local_db_save());
 
-	irq_state = idtentry_enter_nmi(regs);
+	idtentry_enter_nmi(regs, &irq_state);
 
 	inc_irq_stat(__nmi_count);
 
 	if (!ignore_nmis)
 		default_do_nmi(regs);
 
-	idtentry_exit_nmi(regs, irq_state);
+	idtentry_exit_nmi(regs, &irq_state);
 
 	local_db_restore(this_cpu_read(nmi_dr7));
 
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 81a2fb711091..daf7bc02fc99 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -254,11 +254,11 @@ DEFINE_IDTENTRY_RAW(exc_invalid_op)
 	if (!user_mode(regs) && handle_bug(regs))
 		return;
 
-	state = irqentry_enter(regs);
+	irqentry_enter(regs, &state);
 	instrumentation_begin();
 	handle_invalid_op(regs);
 	instrumentation_end();
-	irqentry_exit(regs, state);
+	irqentry_exit(regs, &state);
 }
 
 DEFINE_IDTENTRY(exc_coproc_segment_overrun)
@@ -342,6 +342,7 @@ __visible void __noreturn handle_stack_overflow(const char *message,
  */
 DEFINE_IDTENTRY_DF(exc_double_fault)
 {
+	irqentry_state_t irq_state;
 	static const char str[] = "double fault";
 	struct task_struct *tsk = current;
 
@@ -404,7 +405,7 @@ DEFINE_IDTENTRY_DF(exc_double_fault)
 	}
 #endif
 
-	idtentry_enter_nmi(regs);
+	idtentry_enter_nmi(regs, &irq_state);
 	instrumentation_begin();
 	notify_die(DIE_TRAP, str, regs, error_code, X86_TRAP_DF, SIGSEGV);
 
@@ -650,12 +651,15 @@ DEFINE_IDTENTRY_RAW(exc_int3)
 		instrumentation_end();
 		irqentry_exit_to_user_mode(regs);
 	} else {
-		bool irq_state = idtentry_enter_nmi(regs);
+		irqentry_state_t irq_state;
+
+		idtentry_enter_nmi(regs, &irq_state);
+
 		instrumentation_begin();
 		if (!do_int3(regs))
 			die("int3", regs, 0);
 		instrumentation_end();
-		idtentry_exit_nmi(regs, irq_state);
+		idtentry_exit_nmi(regs, &irq_state);
 	}
 }
 
@@ -861,7 +865,9 @@ static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 	 * includes the entry stack is excluded for everything.
 	 */
 	unsigned long dr7 = local_db_save();
-	bool irq_state = idtentry_enter_nmi(regs);
+	irqentry_state_t irq_state;
+
+	idtentry_enter_nmi(regs, &irq_state);
 	instrumentation_begin();
 
 	/*
@@ -880,8 +886,7 @@ static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 	handle_debug(regs, dr6, false);
 
 	instrumentation_end();
-	idtentry_exit_nmi(regs, irq_state);
-
+	idtentry_exit_nmi(regs, &irq_state);
 	local_db_restore(dr7);
 }
 
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 6e3e8a124903..e55bc4bff389 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1476,11 +1476,11 @@ DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)
 	 * code reenabled RCU to avoid subsequent wreckage which helps
 	 * debugability.
 	 */
-	state = irqentry_enter(regs);
+	irqentry_enter(regs, &state);
 
 	instrumentation_begin();
 	handle_page_fault(regs, error_code, address);
 	instrumentation_end();
 
-	irqentry_exit(regs, state);
+	irqentry_exit(regs, &state);
 }
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 159c7476b11b..de4f24c554ee 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -349,6 +349,7 @@ typedef struct irqentry_state {
 /**
  * irqentry_enter - Handle state tracking on ordinary interrupt entries
  * @regs:	Pointer to pt_regs of interrupted context
+ * @state:	Pointer to an object to store the irq state
  *
  * Invokes:
  *  - lockdep irqflag state tracking as low level ASM entry disabled
@@ -377,7 +378,7 @@ typedef struct irqentry_state {
  *
  * Returns: An opaque object that must be passed to idtentry_exit()
  */
-irqentry_state_t noinstr irqentry_enter(struct pt_regs *regs);
+void noinstr irqentry_enter(struct pt_regs *regs, irqentry_state_t *state);
 
 /**
  * irqentry_exit_cond_resched - Conditionally reschedule on return from interrupt
@@ -389,7 +390,7 @@ void irqentry_exit_cond_resched(void);
 /**
  * irqentry_exit - Handle return from exception that used irqentry_enter()
  * @regs:	Pointer to pt_regs (exception entry regs)
- * @state:	Return value from matching call to irqentry_enter()
+ * @state:	Reference to the value saved in irqentry_enter()
  *
  * Depending on the return target (kernel/user) this runs the necessary
  * preemption and work checks if possible and reguired and returns to
@@ -400,6 +401,6 @@ void irqentry_exit_cond_resched(void);
  *
  * Counterpart to irqentry_enter().
  */
-void noinstr irqentry_exit(struct pt_regs *regs, irqentry_state_t state);
+void noinstr irqentry_exit(struct pt_regs *regs, irqentry_state_t *state);
 
 #endif
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 6fdb6105e6d6..21601993ad1b 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -282,15 +282,13 @@ noinstr void irqentry_exit_to_user_mode(struct pt_regs *regs)
 	exit_to_user_mode();
 }
 
-noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
+noinstr void irqentry_enter(struct pt_regs *regs, irqentry_state_t *state)
 {
-	irqentry_state_t ret = {
-		.exit_rcu = false,
-	};
+	state->exit_rcu = false;
 
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
-		return ret;
+		return;
 	}
 
 	/*
@@ -328,8 +326,8 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 		trace_hardirqs_off_finish();
 		instrumentation_end();
 
-		ret.exit_rcu = true;
-		return ret;
+		state->exit_rcu = true;
+		return;
 	}
 
 	/*
@@ -343,8 +341,6 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 	/* Use the combo lockdep/tracing function */
 	trace_hardirqs_off();
 	instrumentation_end();
-
-	return ret;
 }
 
 void irqentry_exit_cond_resched(void)
@@ -359,7 +355,7 @@ void irqentry_exit_cond_resched(void)
 	}
 }
 
-noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
+noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t *state)
 {
 	lockdep_assert_irqs_disabled();
 
@@ -372,7 +368,7 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 		 * carefully and needs the same ordering of lockdep/tracing
 		 * and RCU as the return to user mode path.
 		 */
-		if (state.exit_rcu) {
+		if (state->exit_rcu) {
 			instrumentation_begin();
 			/* Tell the tracer that IRET will enable interrupts */
 			trace_hardirqs_on_prepare();
@@ -394,7 +390,7 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 		 * IRQ flags state is correct already. Just tell RCU if it
 		 * was not watching on entry.
 		 */
-		if (state.exit_rcu)
+		if (state->exit_rcu)
 			rcu_irq_exit();
 	}
 }
-- 
2.28.0.rc0.12.gb6a658bd00c9

