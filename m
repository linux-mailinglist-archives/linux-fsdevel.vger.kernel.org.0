Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269AC2D10CF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 13:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbgLGMqf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 07:46:35 -0500
Received: from mga11.intel.com ([192.55.52.93]:13302 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbgLGMqe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 07:46:34 -0500
IronPort-SDR: cnOsql8PLSohbGzBapKpFP6nayEoxa6CkOJHFuqQETKJEu7nEEIu4Zn98+m3oSV7M0APoSC45s
 l7sNfi6Y4lSw==
X-IronPort-AV: E=McAfee;i="6000,8403,9827"; a="170182999"
X-IronPort-AV: E=Sophos;i="5.78,399,1599548400"; 
   d="scan'208";a="170182999"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 04:44:48 -0800
IronPort-SDR: KIcPa1m/tdFSrCCg+HZ9wcNpGF/RBbY/5Xg1Ca101JRRKwiOb/+WF10Wk62CakzdO2ew9KNkf3
 A/QkDatczTeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,399,1599548400"; 
   d="scan'208";a="436691903"
Received: from cvg-ubt08.iil.intel.com (HELO cvg-ubt08.me-corp.lan) ([10.185.176.12])
  by fmsmga001.fm.intel.com with ESMTP; 07 Dec 2020 04:44:41 -0800
From:   Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kars Mulder <kerneldev@karsmulder.nl>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Joe Perches <joe@perches.com>,
        Rafael Aquini <aquini@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michel Lespinasse <walken@google.com>,
        Jann Horn <jannh@google.com>, chenqiwu <chenqiwu@xiaomi.com>,
        Minchan Kim <minchan@kernel.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v2] do_exit(): panic() recursion detected
Date:   Mon,  7 Dec 2020 14:44:33 +0200
Message-Id: <20201207124433.4017265-1-vladimir.kondratiev@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Recursive do_exit() is symptom of compromised kernel integrity.
For safety critical systems, it may be better to
panic() in this case to minimize risk.

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>
Change-Id: I42f45900a08c4282c511b05e9e6061360d07db60
---
 Documentation/admin-guide/kernel-parameters.txt | 6 ++++++
 include/linux/kernel.h                          | 1 +
 kernel/exit.c                                   | 7 +++++++
 kernel/sysctl.c                                 | 9 +++++++++
 4 files changed, 23 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 44fde25bb221..6e12a6804557 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3508,6 +3508,12 @@
 			bit 4: print ftrace buffer
 			bit 5: print all printk messages in buffer
 
+	panic_on_exit_recursion
+			panic() when do_exit() recursion detected, rather then
+			try to stay running whenever possible.
+			Useful on safety critical systems; re-entry in do_exit
+			is a symptom of compromised kernel integrity.
+
 	panic_on_taint=	Bitmask for conditionally calling panic() in add_taint()
 			Format: <hex>[,nousertaint]
 			Hexadecimal bitmask representing the set of TAINT flags
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 2f05e9128201..5afb20534cb2 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -539,6 +539,7 @@ extern int sysctl_panic_on_rcu_stall;
 extern int sysctl_panic_on_stackoverflow;
 
 extern bool crash_kexec_post_notifiers;
+extern int panic_on_exit_recursion;
 
 /*
  * panic_cpu is used for synchronizing panic() and crash_kexec() execution. It
diff --git a/kernel/exit.c b/kernel/exit.c
index 1f236ed375f8..162799a8b539 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -68,6 +68,9 @@
 #include <asm/unistd.h>
 #include <asm/mmu_context.h>
 
+int panic_on_exit_recursion __read_mostly;
+core_param(panic_on_exit_recursion, panic_on_exit_recursion, int, 0644);
+
 static void __unhash_process(struct task_struct *p, bool group_dead)
 {
 	nr_threads--;
@@ -757,6 +760,10 @@ void __noreturn do_exit(long code)
 	 */
 	if (unlikely(tsk->flags & PF_EXITING)) {
 		pr_alert("Fixing recursive fault but reboot is needed!\n");
+		if (panic_on_exit_recursion)
+			panic("Recursive do_exit() detected in %s[%d]\n",
+			      current->comm, task_pid_nr(current));
+
 		futex_exit_recursive(tsk);
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule();
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index afad085960b8..bb397fba2c42 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2600,6 +2600,15 @@ static struct ctl_table kern_table[] = {
 		.extra2		= &one_thousand,
 	},
 #endif
+	{
+		.procname	= "panic_on_exit_recursion",
+		.data		= &panic_on_exit_recursion,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
 	{
 		.procname	= "panic_on_warn",
 		.data		= &panic_on_warn,
-- 
2.27.0

