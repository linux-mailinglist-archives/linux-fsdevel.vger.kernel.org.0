Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1031D5FD3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 May 2020 10:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgEPIzo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 May 2020 04:55:44 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4851 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725997AbgEPIz3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 May 2020 04:55:29 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9DFCE47CD4781515226C;
        Sat, 16 May 2020 16:55:25 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Sat, 16 May 2020 16:55:18 +0800
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     <mcgrof@kernel.org>, <keescook@chromium.org>, <yzaikin@google.com>,
        <adobriyan@gmail.com>, <peterz@infradead.org>, <mingo@kernel.org>,
        <patrick.bellasi@arm.com>, <gregkh@linuxfoundation.org>,
        <tglx@linutronix.de>, <Jisheng.Zhang@synaptics.com>,
        <bigeasy@linutronix.de>, <pmladek@suse.com>,
        <ebiederm@xmission.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <nixiaoming@huawei.com>, <wangle6@huawei.com>
Subject: [PATCH v2 2/4] sysctl: Move some boundary constants form sysctl.c to sysctl_vals
Date:   Sat, 16 May 2020 16:55:13 +0800
Message-ID: <1589619315-65827-3-git-send-email-nixiaoming@huawei.com>
X-Mailer: git-send-email 1.8.5.6
In-Reply-To: <1589619315-65827-1-git-send-email-nixiaoming@huawei.com>
References: <1589619315-65827-1-git-send-email-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some boundary (.extra1 .extra2) constants (E.g: neg_one two) in
sysctl.c are used in multiple features. Move these variables to
sysctl_vals to avoid adding duplicate variables when cleaning up
sysctls table.

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
---
 fs/proc/proc_sysctl.c  |  2 +-
 include/linux/sysctl.h | 11 ++++++++---
 kernel/sysctl.c        | 37 ++++++++++++++++---------------------
 3 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index b6f5d45..3f77e64 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -23,7 +23,7 @@
 static const struct inode_operations proc_sys_dir_operations;
 
 /* shared constants to be used in various sysctls */
-const int sysctl_vals[] = { 0, 1, INT_MAX };
+const int sysctl_vals[] = { -1, 0, 1, 2, 4, 100, 1000, INT_MAX };
 EXPORT_SYMBOL(sysctl_vals);
 
 /* Support for permanently empty directories */
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 43f8ef9..bf97c30 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -38,9 +38,14 @@
 struct ctl_dir;
 
 /* Keep the same order as in fs/proc/proc_sysctl.c */
-#define SYSCTL_ZERO	((void *)&sysctl_vals[0])
-#define SYSCTL_ONE	((void *)&sysctl_vals[1])
-#define SYSCTL_INT_MAX	((void *)&sysctl_vals[2])
+#define SYSCTL_NEG_ONE	((void *)&sysctl_vals[0])
+#define SYSCTL_ZERO	((void *)&sysctl_vals[1])
+#define SYSCTL_ONE	((void *)&sysctl_vals[2])
+#define SYSCTL_TWO	((void *)&sysctl_vals[3])
+#define SYSCTL_FOUR	((void *)&sysctl_vals[4])
+#define SYSCTL_ONE_HUNDRED	((void *)&sysctl_vals[5])
+#define SYSCTL_ONE_THOUSAND	((void *)&sysctl_vals[6])
+#define SYSCTL_INT_MAX	((void *)&sysctl_vals[7])
 
 extern const int sysctl_vals[];
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 20c31f5..5f08cc2 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -124,14 +124,9 @@
 static int sixty = 60;
 #endif
 
-static int __maybe_unused neg_one = -1;
-static int __maybe_unused two = 2;
-static int __maybe_unused four = 4;
 static unsigned long zero_ul;
 static unsigned long one_ul = 1;
 static unsigned long long_max = LONG_MAX;
-static int one_hundred = 100;
-static int one_thousand = 1000;
 #ifdef CONFIG_PRINTK
 static int ten_thousand = 10000;
 #endif
@@ -547,7 +542,7 @@ static int sysrq_sysctl_handler(struct ctl_table *table, int write,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &neg_one,
+		.extra1		= SYSCTL_NEG_ONE,
 		.extra2		= SYSCTL_ONE,
 	},
 #endif
@@ -878,7 +873,7 @@ static int sysrq_sysctl_handler(struct ctl_table *table, int write,
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax_sysadmin,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= &two,
+		.extra2		= SYSCTL_TWO,
 	},
 #endif
 	{
@@ -1189,7 +1184,7 @@ static int sysrq_sysctl_handler(struct ctl_table *table, int write,
 		.mode		= 0644,
 		.proc_handler	= perf_cpu_time_max_percent_handler,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= &one_hundred,
+		.extra2		= SYSCTL_ONE_HUNDRED,
 	},
 	{
 		.procname	= "perf_event_max_stack",
@@ -1207,7 +1202,7 @@ static int sysrq_sysctl_handler(struct ctl_table *table, int write,
 		.mode		= 0644,
 		.proc_handler	= perf_event_max_stack_handler,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= &one_thousand,
+		.extra2		= SYSCTL_ONE_THOUSAND,
 	},
 #endif
 	{
@@ -1282,7 +1277,7 @@ static int sysrq_sysctl_handler(struct ctl_table *table, int write,
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= &two,
+		.extra2		= SYSCTL_TWO,
 	},
 	{
 		.procname	= "panic_on_oom",
@@ -1291,7 +1286,7 @@ static int sysrq_sysctl_handler(struct ctl_table *table, int write,
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= &two,
+		.extra2		= SYSCTL_TWO,
 	},
 	{
 		.procname	= "oom_kill_allocating_task",
@@ -1336,7 +1331,7 @@ static int sysrq_sysctl_handler(struct ctl_table *table, int write,
 		.mode		= 0644,
 		.proc_handler	= dirty_background_ratio_handler,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= &one_hundred,
+		.extra2		= SYSCTL_ONE_HUNDRED,
 	},
 	{
 		.procname	= "dirty_background_bytes",
@@ -1353,7 +1348,7 @@ static int sysrq_sysctl_handler(struct ctl_table *table, int write,
 		.mode		= 0644,
 		.proc_handler	= dirty_ratio_handler,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= &one_hundred,
+		.extra2		= SYSCTL_ONE_HUNDRED,
 	},
 	{
 		.procname	= "dirty_bytes",
@@ -1393,7 +1388,7 @@ static int sysrq_sysctl_handler(struct ctl_table *table, int write,
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= &one_hundred,
+		.extra2		= SYSCTL_ONE_HUNDRED,
 	},
 #ifdef CONFIG_HUGETLB_PAGE
 	{
@@ -1450,7 +1445,7 @@ static int sysrq_sysctl_handler(struct ctl_table *table, int write,
 		.mode		= 0200,
 		.proc_handler	= drop_caches_sysctl_handler,
 		.extra1		= SYSCTL_ONE,
-		.extra2		= &four,
+		.extra2		= SYSCTL_FOUR,
 	},
 #ifdef CONFIG_COMPACTION
 	{
@@ -1503,7 +1498,7 @@ static int sysrq_sysctl_handler(struct ctl_table *table, int write,
 		.mode		= 0644,
 		.proc_handler	= watermark_scale_factor_sysctl_handler,
 		.extra1		= SYSCTL_ONE,
-		.extra2		= &one_thousand,
+		.extra2		= SYSCTL_ONE_THOUSAND,
 	},
 	{
 		.procname	= "percpu_pagelist_fraction",
@@ -1582,7 +1577,7 @@ static int sysrq_sysctl_handler(struct ctl_table *table, int write,
 		.mode		= 0644,
 		.proc_handler	= sysctl_min_unmapped_ratio_sysctl_handler,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= &one_hundred,
+		.extra2		= SYSCTL_ONE_HUNDRED,
 	},
 	{
 		.procname	= "min_slab_ratio",
@@ -1591,7 +1586,7 @@ static int sysrq_sysctl_handler(struct ctl_table *table, int write,
 		.mode		= 0644,
 		.proc_handler	= sysctl_min_slab_ratio_sysctl_handler,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= &one_hundred,
+		.extra2		= SYSCTL_ONE_HUNDRED,
 	},
 #endif
 #ifdef CONFIG_SMP
@@ -1874,7 +1869,7 @@ static int sysrq_sysctl_handler(struct ctl_table *table, int write,
 		.mode		= 0600,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= &two,
+		.extra2		= SYSCTL_TWO,
 	},
 	{
 		.procname	= "protected_regular",
@@ -1883,7 +1878,7 @@ static int sysrq_sysctl_handler(struct ctl_table *table, int write,
 		.mode		= 0600,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= &two,
+		.extra2		= SYSCTL_TWO,
 	},
 	{
 		.procname	= "suid_dumpable",
@@ -1892,7 +1887,7 @@ static int sysrq_sysctl_handler(struct ctl_table *table, int write,
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax_coredump,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= &two,
+		.extra2		= SYSCTL_TWO,
 	},
 #if defined(CONFIG_BINFMT_MISC) || defined(CONFIG_BINFMT_MISC_MODULE)
 	{
-- 
1.8.5.6

