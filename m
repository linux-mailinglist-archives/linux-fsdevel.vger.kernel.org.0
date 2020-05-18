Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63ACF1D6F82
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 May 2020 06:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbgEREAO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 00:00:14 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58160 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726053AbgEREAM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 00:00:12 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 90BB74870029CCCDB0E1;
        Mon, 18 May 2020 12:00:09 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Mon, 18 May 2020 12:00:00 +0800
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     <mcgrof@kernel.org>, <keescook@chromium.org>, <yzaikin@google.com>,
        <adobriyan@gmail.com>, <patrick.bellasi@arm.com>,
        <mingo@kernel.org>, <peterz@infradead.org>, <tglx@linutronix.de>,
        <gregkh@linuxfoundation.org>, <Jisheng.Zhang@synaptics.com>,
        <bigeasy@linutronix.de>, <pmladek@suse.com>,
        <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <nixiaoming@huawei.com>, <wangle6@huawei.com>,
        <alex.huangjianhui@huawei.com>
Subject: [PATCH v3 3/4] hung_task: Move hung_task sysctl interface to hung_task.c
Date:   Mon, 18 May 2020 11:59:56 +0800
Message-ID: <1589774397-42485-4-git-send-email-nixiaoming@huawei.com>
X-Mailer: git-send-email 1.8.5.6
In-Reply-To: <1589774397-42485-1-git-send-email-nixiaoming@huawei.com>
References: <1589774397-42485-1-git-send-email-nixiaoming@huawei.com>
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
 include/linux/sched/sysctl.h |  8 +-----
 kernel/hung_task.c           | 63 +++++++++++++++++++++++++++++++++++++++++++-
 kernel/sysctl.c              | 50 -----------------------------------
 3 files changed, 63 insertions(+), 58 deletions(-)

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
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 14a625c..d010c96 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -215,10 +215,11 @@ static long hung_timeout_jiffies(unsigned long last_checked,
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
@@ -235,6 +236,65 @@ int proc_dohung_task_timeout_secs(struct ctl_table *table, int write,
 	return ret;
 }
 
+/*
+ * This is needed for proc_doulongvec_minmax of sysctl_hung_task_timeout_secs
+ * and hung_task_check_interval_secs
+ */
+static const unsigned long hung_task_timeout_max = (LONG_MAX / HZ);
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
+#endif
+
+
 static atomic_t reset_hung_task = ATOMIC_INIT(0);
 
 void reset_hung_task_detector(void)
@@ -304,6 +364,7 @@ static int __init hung_task_init(void)
 	pm_notifier(hungtask_pm_notify, 0);
 
 	watchdog_task = kthread_run(watchdog, NULL, "khungtaskd");
+	hung_task_sysctl_init();
 
 	return 0;
 }
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 76c3237..90e3ea8 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -144,13 +144,6 @@
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
@@ -1080,49 +1073,6 @@ static int sysrq_sysctl_handler(struct ctl_table *table, int write,
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

