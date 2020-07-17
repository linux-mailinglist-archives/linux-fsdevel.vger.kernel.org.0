Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6D6F22356F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 09:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgGQHVX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 03:21:23 -0400
Received: from mga04.intel.com ([192.55.52.120]:4232 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728107AbgGQHVT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 03:21:19 -0400
IronPort-SDR: dzTBoc8jWTtNIccqMAXx7LIYUQWkJfrVLf+QqDHXyUjYMS4xDgy+oR+gEC6hWL3qtI4MdeEq2x
 XHNR1SLOmm3A==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="147057757"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="147057757"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 00:21:10 -0700
IronPort-SDR: NpuLFicxYo6CMu6J08/KxXwA/c9FftKiMbWjFW+agAcMqKsLM+Wl39F5cNH0ROoUg+xVVBXjhw
 ko/0FI16DIyw==
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="326769004"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 00:21:10 -0700
From:   ira.weiny@intel.com
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH RFC V2 17/17] x86/entry: Preserve PKRS MSR across exceptions
Date:   Fri, 17 Jul 2020 00:20:56 -0700
Message-Id: <20200717072056.73134-18-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20200717072056.73134-1-ira.weiny@intel.com>
References: <20200717072056.73134-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The PKRS MSR is not managed by XSAVE.  It is already preserved through a
context switch but this support leaves exception handling code open to
memory accesses which the interrupted process has allowed.

Close this hole by preserve the current task's PKRS MSR, reset the PKRS
MSR value on exception entry, and then restore the state on exception
exit.

Notice that, in addition to the MSR value itself, the saved task state
must also include the device memory protection reference count which is
maintained to keep kmap re-entrant.  The following shows how this works:

...
	// ref == 0
	dev_access_enable()  // ref += 1 ==> disable protection
		irq()
			// enable protection
			// ref = 0
			_handler()
				dev_access_enable()   // ref += 1 ==> disable protection
				dev_access_disable()  // ref -= 1 ==> enable protection
			// WARN_ON(ref != 0)
			// disable protection
	do_pmem_thing()  // all good here
	dev_access_disable() // ref -= 1 ==> 0 ==> enable protection
...

Nested exceptions should also operate the same way with each exception
storing the previous reference count all the way down.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
RFC NOTES:

First I'm not sure if adding this state to idtentry_state and having
that state copied is the right way to go.  It seems like we should start
passing this by reference instead of value.  But for now this works as
an RFC.  Comments?

Second, I'm not 100% happy with having to save the reference count in
the exception handler.  It seems like a very ugly layering violation but
I don't see a way around it at the moment.

Third, this patch has gone through a couple of revisions as I've had
crashes which just don't make sense to me.  One particular issue I've
had is taking a MCE during memcpy_mcsafe causing my WARN_ON() to fire.
The code path was a pmem copy and the ref count should have been
elevated due to dev_access_enable() but why was
idtentry_enter()->idt_save_pkrs() not called I don't know.

Finally, it looks like the entry/exit code is being refactored into
common code.  So likely this is best handled somewhat there.  Because
this can be predicated on CONFIG_ARCH_HAS_SUPERVISOR_PKEYS and handled
in a generic fashion.  But that is a ways off I think.

This patch depends on:
	https://lore.kernel.org/lkml/159411021855.4006.13113751062324360868.tip-bot2@tip-bot2/
	Which has yet to land upstream.  I just pulled it into my test
	branch which is based on 5.8-rc5 to get the exception state
	tracking.  Hopefully it is self contained enough I'm not causing
	other issues with my tests.
---
 arch/x86/entry/common.c               | 78 ++++++++++++++++++++++++++-
 arch/x86/include/asm/idtentry.h       |  2 +
 arch/x86/include/asm/pkeys_internal.h |  3 +-
 arch/x86/kernel/process.c             |  1 -
 arch/x86/mm/pkeys.c                   |  2 +-
 5 files changed, 82 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 0521546022cb..012bf7ecca0d 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -41,6 +41,7 @@
 #include <asm/io_bitmap.h>
 #include <asm/syscall.h>
 #include <asm/irq_stack.h>
+#include <asm/pkeys_internal.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
@@ -558,6 +559,72 @@ SYSCALL_DEFINE0(ni_syscall)
 	return -ENOSYS;
 }
 
+#ifdef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
+/*
+ * PKRS is a per-logical-processor MSR which overlays additional protection for
+ * pages which have been mapped with a protection key.
+ *
+ * The register is not maintained with XSAVE so we have to maintain the MSR
+ * value in software during context switch and exception handling.
+ *
+ * Context switches save the MSR in the task struct thus taking that value to
+ * other processors if necessary.
+ *
+ * To protect against exceptions having access to this memory we save the
+ * current running value and set the default PKRS value for the duration of the
+ * exception.  Thus preventing exception handlers from having the access of the
+ * interrupted task.
+ *
+ * Furthermore, Zone Device Access Protection maintains access in a re-entrant
+ * manner through a reference count which also needs to be maintained should
+ * exception handlers use those interfaces for memory access.  Here we start
+ * off the exception handler ref count to 0 and ensure it is 0 when the
+ * exception is done.  Then restore it for the interrupted task.
+ */
+
+static void noinstr idt_save_pkrs(idtentry_state_t state)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_PKS))
+		return;
+
+#ifdef CONFIG_ZONE_DEVICE_ACCESS_PROTECTION
+	/*
+	 * Save the ref count of the current running process and set it to 0
+	 * for any irq users to properly track re-entrance
+	 */
+	state.pkrs_ref = current->dev_page_access_ref;
+	current->dev_page_access_ref = 0;
+#endif
+
+	state.pkrs = this_cpu_read(pkrs_cache);
+	if (state.pkrs != INIT_PKRS_VALUE)
+		write_pkrs(INIT_PKRS_VALUE);
+}
+
+static void noinstr idt_restore_pkrs(idtentry_state_t state)
+{
+	u32 pkrs;
+
+	if (!cpu_feature_enabled(X86_FEATURE_PKS))
+		return;
+
+	pkrs = this_cpu_read(pkrs_cache);
+	if (state.pkrs != pkrs)
+		write_pkrs(state.pkrs);
+
+#ifdef CONFIG_ZONE_DEVICE_ACCESS_PROTECTION
+	WARN_ON_ONCE(current->dev_page_access_ref != 0);
+	/* Restore the interrupted process reference */
+	current->dev_page_access_ref = state.pkrs_ref;
+#endif
+}
+#else
+/* Define as macros to prevent conflict of inline and noinstr */
+#define idt_save_pkrs(state)
+#define idt_restore_pkrs(state)
+#endif
+
+
 /**
  * idtentry_enter - Handle state tracking on ordinary idtentries
  * @regs:	Pointer to pt_regs of interrupted context
@@ -604,6 +671,8 @@ idtentry_state_t noinstr idtentry_enter(struct pt_regs *regs)
 		return ret;
 	}
 
+	idt_save_pkrs(ret);
+
 	/*
 	 * If this entry hit the idle task invoke rcu_irq_enter() whether
 	 * RCU is watching or not.
@@ -694,7 +763,12 @@ void noinstr idtentry_exit(struct pt_regs *regs, idtentry_state_t state)
 	/* Check whether this returns to user mode */
 	if (user_mode(regs)) {
 		prepare_exit_to_usermode(regs);
-	} else if (regs->flags & X86_EFLAGS_IF) {
+		return;
+	}
+
+	idt_restore_pkrs(state);
+
+	if (regs->flags & X86_EFLAGS_IF) {
 		/*
 		 * If RCU was not watching on entry this needs to be done
 		 * carefully and needs the same ordering of lockdep/tracing
@@ -819,6 +893,8 @@ __visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
 
 	inhcall = get_and_clear_inhcall();
 	if (inhcall && !WARN_ON_ONCE(state.exit_rcu)) {
+		/* Normally called by idtentry_exit, we must restore pkrs here */
+		idt_restore_pkrs(state);
 		instrumentation_begin();
 		idtentry_exit_cond_resched(regs, true);
 		instrumentation_end();
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 7227225cf45d..92d5e43cda7f 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -14,6 +14,8 @@ void idtentry_enter_user(struct pt_regs *regs);
 void idtentry_exit_user(struct pt_regs *regs);
 
 typedef struct idtentry_state {
+	unsigned int pkrs_ref;
+	u32 pkrs;
 	bool exit_rcu;
 } idtentry_state_t;
 
diff --git a/arch/x86/include/asm/pkeys_internal.h b/arch/x86/include/asm/pkeys_internal.h
index e34f380c66d1..60e7b55dd141 100644
--- a/arch/x86/include/asm/pkeys_internal.h
+++ b/arch/x86/include/asm/pkeys_internal.h
@@ -27,7 +27,8 @@
 #define        PKS_NUM_KEYS            16
 
 #ifdef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
-void write_pkrs(u32 pkrs_val);
+DECLARE_PER_CPU(u32, pkrs_cache);
+void noinstr write_pkrs(u32 pkrs_val);
 #else
 static inline void write_pkrs(u32 pkrs_val) { }
 #endif
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index d69250a7c1bf..85f0cbd5faa5 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -194,7 +194,6 @@ int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
  * headers.
  */
 #ifdef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
-DECLARE_PER_CPU(u32, pkrs_cache);
 static inline void pks_init_task(struct task_struct *tsk)
 {
 	/* New tasks get the most restrictive PKRS value */
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index e565fadd74d7..cf9915fed6c9 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -247,7 +247,7 @@ DEFINE_PER_CPU(u32, pkrs_cache);
  * disabled as it does not guarantee the atomicity of updating the pkrs_cache
  * and MSR on its own.
  */
-void write_pkrs(u32 pkrs_val)
+void noinstr write_pkrs(u32 pkrs_val)
 {
 	this_cpu_write(pkrs_cache, pkrs_val);
 	wrmsrl(MSR_IA32_PKRS, pkrs_val);
-- 
2.28.0.rc0.12.gb6a658bd00c9

