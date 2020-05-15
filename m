Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5C361D44AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 06:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgEOEeE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 00:34:04 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4844 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725616AbgEOEeC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 00:34:02 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 14FA57D24D9A92364ED5;
        Fri, 15 May 2020 12:33:53 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Fri, 15 May 2020 12:33:47 +0800
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     <mcgrof@kernel.org>, <keescook@chromium.org>, <yzaikin@google.com>,
        <adobriyan@gmail.com>, <mingo@kernel.org>, <peterz@infradead.org>,
        <akpm@linux-foundation.org>, <yamada.masahiro@socionext.com>,
        <bauerman@linux.ibm.com>, <gregkh@linuxfoundation.org>,
        <skhan@linuxfoundation.org>, <dvyukov@google.com>,
        <svens@stackframe.org>, <joel@joelfernandes.org>,
        <tglx@linutronix.de>, <Jisheng.Zhang@synaptics.com>,
        <pmladek@suse.com>, <bigeasy@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <nixiaoming@huawei.com>, <wangle6@huawei.com>
Subject: [PATCH 1/4] hung_task: Move hung_task sysctl interface to hung_task_sysctl.c
Date:   Fri, 15 May 2020 12:33:41 +0800
Message-ID: <1589517224-123928-2-git-send-email-nixiaoming@huawei.com>
X-Mailer: git-send-email 1.8.5.6
In-Reply-To: <1589517224-123928-1-git-send-email-nixiaoming@huawei.com>
References: <1589517224-123928-1-git-send-email-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move hung_task sysctl interface to hung_task_sysctl.c.
Use register_sysctl() to register the sysctl interface to avoid
merge conflicts when different features modify sysctl.c at the same time.

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
---
 include/linux/sched/sysctl.h |  8 +----
 kernel/Makefile              |  4 ++-
 kernel/hung_task.c           |  6 ++--
 kernel/hung_task.h           | 21 ++++++++++++
 kernel/hung_task_sysctl.c    | 80 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/sysctl.c              | 50 ---------------------------
 6 files changed, 108 insertions(+), 61 deletions(-)
 create mode 100644 kernel/hung_task.h
 create mode 100644 kernel/hung_task_sysctl.c

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index d4f6215..c075e09 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -7,14 +7,8 @@
 struct ctl_table;
 
 #ifdef CONFIG_DETECT_HUNG_TASK
-extern int	     sysctl_hung_task_check_count;
-extern unsigned int  sysctl_hung_task_panic;
+/* used for hung_task and block/ */
 extern unsigned long sysctl_hung_task_timeout_secs;
-extern unsigned long sysctl_hung_task_check_interval_secs;
-extern int sysctl_hung_task_warnings;
-extern int proc_dohung_task_timeout_secs(struct ctl_table *table, int write,
-					 void __user *buffer,
-					 size_t *lenp, loff_t *ppos);
 #else
 /* Avoid need for ifdefs elsewhere in the code */
 enum { sysctl_hung_task_timeout_secs = 0 };
diff --git a/kernel/Makefile b/kernel/Makefile
index 4cb4130..c16934bf 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -84,7 +84,9 @@ obj-$(CONFIG_KCOV) += kcov.o
 obj-$(CONFIG_KPROBES) += kprobes.o
 obj-$(CONFIG_FAIL_FUNCTION) += fail_function.o
 obj-$(CONFIG_KGDB) += debug/
-obj-$(CONFIG_DETECT_HUNG_TASK) += hung_task.o
+obj-$(CONFIG_DETECT_HUNG_TASK) += hung_tasks.o
+hung_tasks-y := hung_task.o
+hung_tasks-$(CONFIG_SYSCTL) += hung_task_sysctl.o
 obj-$(CONFIG_LOCKUP_DETECTOR) += watchdog.o
 obj-$(CONFIG_HARDLOCKUP_DETECTOR_PERF) += watchdog_hld.o
 obj-$(CONFIG_SECCOMP) += seccomp.o
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 14a625c..bfe6e25 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -15,15 +15,13 @@
 #include <linux/kthread.h>
 #include <linux/lockdep.h>
 #include <linux/export.h>
-#include <linux/sysctl.h>
 #include <linux/suspend.h>
 #include <linux/utsname.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/debug.h>
-#include <linux/sched/sysctl.h>
 
 #include <trace/events/sched.h>
-
+#include "hung_task.h"
 /*
  * The number of tasks checked:
  */
@@ -298,6 +296,8 @@ static int watchdog(void *dummy)
 
 static int __init hung_task_init(void)
 {
+	hung_task_sysctl_init();
+
 	atomic_notifier_chain_register(&panic_notifier_list, &panic_block);
 
 	/* Disable hung task detector on suspend */
diff --git a/kernel/hung_task.h b/kernel/hung_task.h
new file mode 100644
index 00000000..2fa6a19
--- /dev/null
+++ b/kernel/hung_task.h
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * hung_task sysctl data and function
+ */
+#ifndef KERNEL_HUNG_TASK_H_
+#define KERNEL_HUNG_TASK_H_
+#include <linux/sched/sysctl.h>
+extern int      sysctl_hung_task_check_count;
+extern unsigned int  sysctl_hung_task_panic;
+extern unsigned long sysctl_hung_task_check_interval_secs;
+extern int sysctl_hung_task_warnings;
+extern int proc_dohung_task_timeout_secs(struct ctl_table *table, int write,
+					 void __user *buffer,
+					 size_t *lenp, loff_t *ppos);
+#ifdef CONFIG_SYSCTL
+extern void __init hung_task_sysctl_init(void);
+#else
+#define hung_task_sysctl_init() do { } while (0)
+#endif
+
+#endif
diff --git a/kernel/hung_task_sysctl.c b/kernel/hung_task_sysctl.c
new file mode 100644
index 00000000..5b10d4e
--- /dev/null
+++ b/kernel/hung_task_sysctl.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * register sysctl for hung_task
+ *
+ */
+
+#include <linux/sysctl.h>
+#include <linux/sched/sysctl.h>
+#include <linux/kmemleak.h>
+#include "hung_task.h"
+
+/*
+ * This is needed for proc_doulongvec_minmax of sysctl_hung_task_timeout_secs
+ * and hung_task_check_interval_secs
+ */
+static unsigned long hung_task_timeout_max = (LONG_MAX / HZ);
+static int neg_one = -1;
+static struct ctl_table hung_task_sysctls[] = {
+	{
+		.procname	= "hung_task_panic",
+		.data		= &sysctl_hung_task_panic,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+	{
+		.procname	= "hung_task_check_count",
+		.data		= &sysctl_hung_task_check_count,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+	},
+	{
+		.procname	= "hung_task_timeout_secs",
+		.data		= &sysctl_hung_task_timeout_secs,
+		.maxlen		= sizeof(unsigned long),
+		.mode		= 0644,
+		.proc_handler	= proc_dohung_task_timeout_secs,
+		.extra2		= &hung_task_timeout_max,
+	},
+	{
+		.procname	= "hung_task_check_interval_secs",
+		.data		= &sysctl_hung_task_check_interval_secs,
+		.maxlen		= sizeof(unsigned long),
+		.mode		= 0644,
+		.proc_handler	= proc_dohung_task_timeout_secs,
+		.extra2		= &hung_task_timeout_max,
+	},
+	{
+		.procname	= "hung_task_warnings",
+		.data		= &sysctl_hung_task_warnings,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &neg_one,
+	},
+	{}
+};
+
+/*
+ * The hung task sysctl has a default value.
+ * Even if register_sysctl() fails, it does not affect the main function of
+ * the hung task. At the same time, during the system initialization phase,
+ * malloc small memory will almost never fail.
+ * So the return value is ignored here
+ */
+void __init hung_task_sysctl_init(void)
+{
+	struct ctl_table_header *srt = register_sysctl("kernel", hung_task_sysctls);
+
+	if (unlikely(!srt)) {
+		pr_err("%s fail\n", __func__);
+		return;
+	}
+	kmemleak_not_leak(srt);
+}
+
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index b9ff323..20adae0 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -149,13 +149,6 @@
 static int ngroups_max = NGROUPS_MAX;
 static const int cap_last_cap = CAP_LAST_CAP;
 
-/*
- * This is needed for proc_doulongvec_minmax of sysctl_hung_task_timeout_secs
- * and hung_task_check_interval_secs
- */
-#ifdef CONFIG_DETECT_HUNG_TASK
-static unsigned long hung_task_timeout_max = (LONG_MAX/HZ);
-#endif
 
 #ifdef CONFIG_INOTIFY_USER
 #include <linux/inotify.h>
@@ -1087,49 +1080,6 @@ static int sysrq_sysctl_handler(struct ctl_table *table, int write,
 		.proc_handler	= proc_dointvec,
 	},
 #endif
-#ifdef CONFIG_DETECT_HUNG_TASK
-	{
-		.procname	= "hung_task_panic",
-		.data		= &sysctl_hung_task_panic,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-	{
-		.procname	= "hung_task_check_count",
-		.data		= &sysctl_hung_task_check_count,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-	},
-	{
-		.procname	= "hung_task_timeout_secs",
-		.data		= &sysctl_hung_task_timeout_secs,
-		.maxlen		= sizeof(unsigned long),
-		.mode		= 0644,
-		.proc_handler	= proc_dohung_task_timeout_secs,
-		.extra2		= &hung_task_timeout_max,
-	},
-	{
-		.procname	= "hung_task_check_interval_secs",
-		.data		= &sysctl_hung_task_check_interval_secs,
-		.maxlen		= sizeof(unsigned long),
-		.mode		= 0644,
-		.proc_handler	= proc_dohung_task_timeout_secs,
-		.extra2		= &hung_task_timeout_max,
-	},
-	{
-		.procname	= "hung_task_warnings",
-		.data		= &sysctl_hung_task_warnings,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &neg_one,
-	},
-#endif
 #ifdef CONFIG_RT_MUTEXES
 	{
 		.procname	= "max_lock_depth",
-- 
1.8.5.6

