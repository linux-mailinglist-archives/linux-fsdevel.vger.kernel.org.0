Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B3E1D8E42
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 05:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbgESDb2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 23:31:28 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40628 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726492AbgESDb1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 23:31:27 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C0E9A7E0793F261936AC;
        Tue, 19 May 2020 11:31:24 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Tue, 19 May 2020 11:31:14 +0800
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     <mcgrof@kernel.org>, <keescook@chromium.org>, <yzaikin@google.com>,
        <adobriyan@gmail.com>, <mingo@kernel.org>, <nixiaoming@huawei.com>,
        <gpiccoli@canonical.com>, <rdna@fb.com>, <patrick.bellasi@arm.com>,
        <sfr@canb.auug.org.au>, <akpm@linux-foundation.org>,
        <mhocko@suse.com>, <penguin-kernel@i-love.sakura.ne.jp>,
        <vbabka@suse.cz>, <tglx@linutronix.de>, <peterz@infradead.org>,
        <Jisheng.Zhang@synaptics.com>, <khlebnikov@yandex-team.ru>,
        <bigeasy@linutronix.de>, <pmladek@suse.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC:     <wangle6@huawei.com>, <alex.huangjianhui@huawei.com>
Subject: [PATCH v4 3/4] hung_task: Move hung_task sysctl interface to hung_task.c
Date:   Tue, 19 May 2020 11:31:10 +0800
Message-ID: <1589859071-25898-4-git-send-email-nixiaoming@huawei.com>
X-Mailer: git-send-email 1.8.5.6
In-Reply-To: <1589859071-25898-1-git-send-email-nixiaoming@huawei.com>
References: <1589859071-25898-1-git-send-email-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move hung_task sysctl interface to hung_task.c.
Use register_sysctl() to register the sysctl interface to avoid
merge conflicts when different features modify sysctl.c at the same time.

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 include/linux/sched/sysctl.h | 14 +-------
 kernel/hung_task.c           | 77 +++++++++++++++++++++++++++++++++++++++++++-
 kernel/sysctl.c              | 62 -----------------------------------
 3 files changed, 77 insertions(+), 76 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 660ac49..fcd397a8 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -7,20 +7,8 @@
 struct ctl_table;
 
 #ifdef CONFIG_DETECT_HUNG_TASK
-
-#ifdef CONFIG_SMP
-extern unsigned int sysctl_hung_task_all_cpu_backtrace;
-#else
-#define sysctl_hung_task_all_cpu_backtrace 0
-#endif /* CONFIG_SMP */
-
-extern int	     sysctl_hung_task_check_count;
-extern unsigned int  sysctl_hung_task_panic;
+/* used for hung_task and block/ */
 extern unsigned long sysctl_hung_task_timeout_secs;
-extern unsigned long sysctl_hung_task_check_interval_secs;
-extern int sysctl_hung_task_warnings;
-int proc_dohung_task_timeout_secs(struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos);
 #else
 /* Avoid need for ifdefs elsewhere in the code */
 enum { sysctl_hung_task_timeout_secs = 0 };
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index a672db8..d67df599 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -63,6 +63,9 @@
  * Defaults to 0, can be changed via sysctl.
  */
 unsigned int __read_mostly sysctl_hung_task_all_cpu_backtrace;
+#else
+/* Avoid need for ifdefs elsewhere in the code */
+enum { sysctl_hung_task_timeout_secs = 0 };
 #endif /* CONFIG_SMP */
 
 /*
@@ -265,10 +268,11 @@ static long hung_timeout_jiffies(unsigned long last_checked,
 		MAX_SCHEDULE_TIMEOUT;
 }
 
+#ifdef CONFIG_SYSCTL
 /*
  * Process updating of timeout sysctl
  */
-int proc_dohung_task_timeout_secs(struct ctl_table *table, int write,
+static int proc_dohung_task_timeout_secs(struct ctl_table *table, int write,
 				  void __user *buffer,
 				  size_t *lenp, loff_t *ppos)
 {
@@ -285,6 +289,76 @@ int proc_dohung_task_timeout_secs(struct ctl_table *table, int write,
 	return ret;
 }
 
+/*
+ * This is needed for proc_doulongvec_minmax of sysctl_hung_task_timeout_secs
+ * and hung_task_check_interval_secs
+ */
+static const unsigned long hung_task_timeout_max = (LONG_MAX / HZ);
+static struct ctl_table hung_task_sysctls[] = {
+#ifdef CONFIG_SMP
+	{
+		.procname	= "hung_task_all_cpu_backtrace",
+		.data		= &sysctl_hung_task_all_cpu_backtrace,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+#endif /* CONFIG_SMP */
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
+		.extra2		= (void *)&hung_task_timeout_max,
+	},
+	{
+		.procname	= "hung_task_check_interval_secs",
+		.data		= &sysctl_hung_task_check_interval_secs,
+		.maxlen		= sizeof(unsigned long),
+		.mode		= 0644,
+		.proc_handler	= proc_dohung_task_timeout_secs,
+		.extra2		= (void *)&hung_task_timeout_max,
+	},
+	{
+		.procname	= "hung_task_warnings",
+		.data		= &sysctl_hung_task_warnings,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_NEG_ONE,
+	},
+	{}
+};
+
+static void __init hung_task_sysctl_init(void)
+{
+	register_sysctl_init("kernel", hung_task_sysctls, "hung_task_sysctls");
+}
+#else
+#define hung_task_sysctl_init() do { } while (0)
+#endif /* CONFIG_SYSCTL */
+
+
 static atomic_t reset_hung_task = ATOMIC_INIT(0);
 
 void reset_hung_task_detector(void)
@@ -354,6 +428,7 @@ static int __init hung_task_init(void)
 	pm_notifier(hungtask_pm_notify, 0);
 
 	watchdog_task = kthread_run(watchdog, NULL, "khungtaskd");
+	hung_task_sysctl_init();
 
 	return 0;
 }
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 38469bf..b7fd4e6 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -131,13 +131,6 @@
 static const int ngroups_max = NGROUPS_MAX;
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
@@ -229,7 +222,6 @@ static int bpf_stats_handler(struct ctl_table *table, int write,
 	return ret;
 }
 #endif
-
 /*
  * /proc/sys support
  */
@@ -2431,60 +2423,6 @@ int proc_do_static_key(struct ctl_table *table, int write,
 		.proc_handler	= proc_dointvec,
 	},
 #endif
-#ifdef CONFIG_DETECT_HUNG_TASK
-#ifdef CONFIG_SMP
-	{
-		.procname	= "hung_task_all_cpu_backtrace",
-		.data		= &sysctl_hung_task_all_cpu_backtrace,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-#endif /* CONFIG_SMP */
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
-		.extra1		= SYSCTL_NEG_ONE,
-	},
-#endif
 #ifdef CONFIG_RT_MUTEXES
 	{
 		.procname	= "max_lock_depth",
-- 
1.8.5.6

