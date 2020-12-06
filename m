Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE2F2D050E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Dec 2020 14:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgLFNLk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Dec 2020 08:11:40 -0500
Received: from mga11.intel.com ([192.55.52.93]:39732 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgLFNLj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Dec 2020 08:11:39 -0500
IronPort-SDR: QKDKgtsCPplZI3k++3k1BAcBNY4xVvGkOjvrUfCGIOTh6N4sLGnT2zHcJf2NpGd/f9uz1eLOWm
 9eXBlF4gi7QA==
X-IronPort-AV: E=McAfee;i="6000,8403,9826"; a="170075281"
X-IronPort-AV: E=Sophos;i="5.78,397,1599548400"; 
   d="scan'208";a="170075281"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2020 05:10:59 -0800
IronPort-SDR: slcHwJiz/mitijhJdZ/Xd8ynlgp6fPnJIxNegCNPB/axnemz6ixn4MKXT2GUNTpqrWqTMfZ1C6
 SXLTiZQyfFUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,397,1599548400"; 
   d="scan'208";a="316745070"
Received: from cvg-ubt08.iil.intel.com (HELO cvg-ubt08.me-corp.lan) ([10.185.176.12])
  by fmsmga008.fm.intel.com with ESMTP; 06 Dec 2020 05:10:52 -0800
From:   Vladimir Kondratiev <vladimir.kondratiev@intel.com>
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
Cc:     Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] do_exit(): panic() when double fault detected
Date:   Sun,  6 Dec 2020 15:10:36 +0200
Message-Id: <20201206131036.3780898-1-vladimir.kondratiev@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Double fault detected in do_exit() is symptom of integrity
compromised. For safety critical systems, it may be better to
panic() in this case to minimize risk.

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 5 +++++
 include/linux/kernel.h                          | 1 +
 kernel/exit.c                                   | 7 +++++++
 kernel/sysctl.c                                 | 9 +++++++++
 4 files changed, 22 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 44fde25bb221..6cb2a63c47f3 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3521,6 +3521,11 @@
 			extra details on the taint flags that users can pick
 			to compose the bitmask to assign to panic_on_taint.
 
+	panic_on_double_fault
+			panic() when double fault detected in do_exit().
+			Useful on safety critical systems; double fault is
+			a symptom of kernel integrity compromised.
+
 	panic_on_warn	panic() instead of WARN().  Useful to cause kdump
 			on a WARN().
 
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 2f05e9128201..0d8822259a36 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -539,6 +539,7 @@ extern int sysctl_panic_on_rcu_stall;
 extern int sysctl_panic_on_stackoverflow;
 
 extern bool crash_kexec_post_notifiers;
+extern int panic_on_double_fault;
 
 /*
  * panic_cpu is used for synchronizing panic() and crash_kexec() execution. It
diff --git a/kernel/exit.c b/kernel/exit.c
index 1f236ed375f8..e67ae43644f9 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -68,6 +68,9 @@
 #include <asm/unistd.h>
 #include <asm/mmu_context.h>
 
+int panic_on_double_fault __read_mostly;
+core_param(panic_on_double_fault, panic_on_double_fault, int, 0644);
+
 static void __unhash_process(struct task_struct *p, bool group_dead)
 {
 	nr_threads--;
@@ -757,6 +760,10 @@ void __noreturn do_exit(long code)
 	 */
 	if (unlikely(tsk->flags & PF_EXITING)) {
 		pr_alert("Fixing recursive fault but reboot is needed!\n");
+		if (panic_on_double_fault)
+			panic("Double fault detected in %s[%d]\n",
+			      current->comm, task_pid_nr(current));
+
 		futex_exit_recursive(tsk);
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule();
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index afad085960b8..869a2ca41e8e 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2600,6 +2600,15 @@ static struct ctl_table kern_table[] = {
 		.extra2		= &one_thousand,
 	},
 #endif
+	{
+		.procname	= "panic_on_double_fault",
+		.data		= &panic_on_double_fault,
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

---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

