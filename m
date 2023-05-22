Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF6270CBFF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 23:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235543AbjEVVJG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 17:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235405AbjEVVI6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 17:08:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAFEB7;
        Mon, 22 May 2023 14:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=+3mMvkCk/meKXuQTldWwg9QWOYtx2piimZEsgamr2Wk=; b=IAHN7BifPzCm/GqDN1Ugq2ibAI
        SoJ8vkphb95h4PVRmGqogZQNTL9nmLLbwsl+n2rf2eAucZrOvyxz/+qLKg+lt5B3v9oPtq/5ufIL6
        Y/EW7pj8R9B1YjRdAkc7YdEhHVtCR8lRLq+zD4ldMhvn5/GeJQs6WGRR8dwRT4HUTERbyWHsFJ9qq
        2LoeEa7O/r5/EluSSntHrds01xea37sGDTQR1QwwiXRZMCI3zJ/Wp5yYhuzxPWZPTvlqG+/JtxhBM
        B2YyCUEurw8CS0rtIOhhORdBPbAMorgfOik3aD4lbnblXr2R+GxR0FpV8SduW5i8E9rhwP/iup4rp
        34hT42qg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1ClL-0083Je-24;
        Mon, 22 May 2023 21:08:15 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     keescook@chromium.org, yzaikin@google.com, ebiederm@xmission.com,
        arnd@arndb.de, bp@alien8.de, James.Bottomley@HansenPartnership.com,
        deller@gmx.de, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        luto@kernel.org, peterz@infradead.org, brgerst@gmail.com,
        christophe.jaillet@wanadoo.fr, kirill.shutemov@linux.intel.com,
        jroedel@suse.de
Cc:     j.granados@samsung.com, akpm@linux-foundation.org,
        willy@infradead.org, linux-parisc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 2/2] signal: move show_unhandled_signals sysctl to its own file
Date:   Mon, 22 May 2023 14:08:14 -0700
Message-Id: <20230522210814.1919325-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230522210814.1919325-1-mcgrof@kernel.org>
References: <20230522210814.1919325-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The show_unhandled_signals sysctl is the only sysctl for debug
left on kernel/sysctl.c. We've been moving the syctls out from
kernel/sysctl.c so to help avoid merge conflicts as the shared
array gets out of hand.

This change incurs simplifies sysctl registration by localizing
it where it should go for a penalty in size of increasing the
kernel by 23 bytes, we accept this given recent cleanups have
actually already saved us 1465 bytes in the prior commits.

./scripts/bloat-o-meter vmlinux.3-remove-dev-table vmlinux.4-remove-debug-table
add/remove: 3/1 grow/shrink: 0/1 up/down: 177/-154 (23)
Function                                     old     new   delta
signal_debug_table                             -     128    +128
init_signal_sysctls                            -      33     +33
__pfx_init_signal_sysctls                      -      16     +16
sysctl_init_bases                             85      59     -26
debug_table                                  128       -    -128
Total: Before=21256967, After=21256990, chg +0.00%

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 arch/parisc/kernel/traps.c |  1 +
 arch/x86/kernel/signal.c   |  1 +
 arch/x86/kernel/traps.c    |  1 +
 arch/x86/kernel/umip.c     |  1 +
 arch/x86/mm/fault.c        |  1 +
 kernel/signal.c            | 23 +++++++++++++++++++++++
 kernel/sysctl.c            | 14 --------------
 7 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/arch/parisc/kernel/traps.c b/arch/parisc/kernel/traps.c
index f9696fbf646c..e15f7e201962 100644
--- a/arch/parisc/kernel/traps.c
+++ b/arch/parisc/kernel/traps.c
@@ -23,6 +23,7 @@
 #include <linux/module.h>
 #include <linux/smp.h>
 #include <linux/spinlock.h>
+#include <linux/signal.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/console.h>
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 004cb30b7419..91905377d708 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -12,6 +12,7 @@
 
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
+#include <linux/signal.h>
 #include <linux/mm.h>
 #include <linux/smp.h>
 #include <linux/kernel.h>
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 58b1f208eff5..180d770f8817 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -31,6 +31,7 @@
 #include <linux/kexec.h>
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
+#include <linux/signal.h>
 #include <linux/timer.h>
 #include <linux/init.h>
 #include <linux/bug.h>
diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
index 5a4b21389b1d..cef5240dcd92 100644
--- a/arch/x86/kernel/umip.c
+++ b/arch/x86/kernel/umip.c
@@ -12,6 +12,7 @@
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
 #include <linux/ratelimit.h>
+#include <linux/signal.h>
 
 #undef pr_fmt
 #define pr_fmt(fmt) "umip: " fmt
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index e4399983c50c..e5f13250e68c 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -6,6 +6,7 @@
  */
 #include <linux/sched.h>		/* test_thread_flag(), ...	*/
 #include <linux/sched/task_stack.h>	/* task_stack_*(), ...		*/
+#include <linux/sched/signal.h>		/* show_unhandled_signals */
 #include <linux/kdebug.h>		/* oops_begin/end, ...		*/
 #include <linux/extable.h>		/* search_exception_tables	*/
 #include <linux/memblock.h>		/* max_low_pfn			*/
diff --git a/kernel/signal.c b/kernel/signal.c
index 8f6330f0e9ca..5ba4150c01a7 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -45,6 +45,7 @@
 #include <linux/posix-timers.h>
 #include <linux/cgroup.h>
 #include <linux/audit.h>
+#include <linux/sysctl.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/signal.h>
@@ -4771,6 +4772,28 @@ static inline void siginfo_buildtime_checks(void)
 #endif
 }
 
+#if defined(CONFIG_SYSCTL)
+static struct ctl_table signal_debug_table[] = {
+#ifdef CONFIG_SYSCTL_EXCEPTION_TRACE
+	{
+		.procname	= "exception-trace",
+		.data		= &show_unhandled_signals,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec
+	},
+#endif
+	{ }
+};
+
+static int __init init_signal_sysctls(void)
+{
+	register_sysctl_init("debug", signal_debug_table);
+	return 0;
+}
+early_initcall(init_signal_sysctls);
+#endif /* CONFIG_SYSCTL */
+
 void __init signals_init(void)
 {
 	siginfo_buildtime_checks();
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index a7fdb828afb6..43240955dcad 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2331,24 +2331,10 @@ static struct ctl_table vm_table[] = {
 	{ }
 };
 
-static struct ctl_table debug_table[] = {
-#ifdef CONFIG_SYSCTL_EXCEPTION_TRACE
-	{
-		.procname	= "exception-trace",
-		.data		= &show_unhandled_signals,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec
-	},
-#endif
-	{ }
-};
-
 int __init sysctl_init_bases(void)
 {
 	register_sysctl_init("kernel", kern_table);
 	register_sysctl_init("vm", vm_table);
-	register_sysctl_init("debug", debug_table);
 
 	return 0;
 }
-- 
2.39.2

