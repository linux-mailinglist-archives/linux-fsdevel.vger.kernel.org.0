Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE42E1D8E3F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 05:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgESDbW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 23:31:22 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4860 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726492AbgESDbV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 23:31:21 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C0DA36D128BDB99DA3B5;
        Tue, 19 May 2020 11:31:19 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Tue, 19 May 2020 11:31:13 +0800
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
Subject: [PATCH v4 2/4] sysctl: Move some boundary constants form sysctl.c to sysctl_vals
Date:   Tue, 19 May 2020 11:31:09 +0800
Message-ID: <1589859071-25898-3-git-send-email-nixiaoming@huawei.com>
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

Some boundary (.extra1 .extra2) constants (E.g: neg_one two) in
sysctl.c are used in multiple features. Move these variables to
sysctl_vals to avoid adding duplicate variables when cleaning up
sysctls table.

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 fs/proc/proc_sysctl.c  |  2 +-
 include/linux/sysctl.h | 11 ++++++++---
 kernel/sysctl.c        | 39 +++++++++++++++++----------------------
 3 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 5b405f3..3d65e7d 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -24,7 +24,7 @@
 static const struct inode_operations proc_sys_dir_operations;
 
 /* shared constants to be used in various sysctls */
-const int sysctl_vals[] = { 0, 1, INT_MAX };
+const int sysctl_vals[] = { -1, 0, 1, 2, 4, 100, 1000, INT_MAX };
 EXPORT_SYMBOL(sysctl_vals);
 
 /* Support for permanently empty directories */
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 857ba93..97586ee 100644
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
index 8afd713..38469bf 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -111,14 +111,9 @@
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
@@ -1885,7 +1880,7 @@ int proc_do_static_key(struct ctl_table *table, int write,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &neg_one,
+		.extra1		= SYSCTL_NEG_ONE,
 		.extra2		= SYSCTL_ONE,
 	},
 #endif
@@ -2227,7 +2222,7 @@ int proc_do_static_key(struct ctl_table *table, int write,
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax_sysadmin,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= &two,
+		.extra2		= SYSCTL_TWO,
 	},
 #endif
 	{
@@ -2487,7 +2482,7 @@ int proc_do_static_key(struct ctl_table *table, int write,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &neg_one,
+		.extra1		= SYSCTL_NEG_ONE,
 	},
 #endif
 #ifdef CONFIG_RT_MUTEXES
@@ -2549,7 +2544,7 @@ int proc_do_static_key(struct ctl_table *table, int write,
 		.mode		= 0644,
 		.proc_handler	= perf_cpu_time_max_percent_handler,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= &one_hundred,
+		.extra2		= SYSCTL_ONE_HUNDRED,
 	},
 	{
 		.procname	= "perf_event_max_stack",
@@ -2567,7 +2562,7 @@ int proc_do_static_key(struct ctl_table *table, int write,
 		.mode		= 0644,
 		.proc_handler	= perf_event_max_stack_handler,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= &one_thousand,
+		.extra2		= SYSCTL_ONE_THOUSAND,
 	},
 #endif
 	{
@@ -2642,7 +2637,7 @@ int proc_do_static_key(struct ctl_table *table, int write,
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= &two,
+		.extra2		= SYSCTL_TWO,
 	},
 	{
 		.procname	= "panic_on_oom",
@@ -2651,7 +2646,7 @@ int proc_do_static_key(struct ctl_table *table, int write,
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= &two,
+		.extra2		= SYSCTL_TWO,
 	},
 	{
 		.procname	= "oom_kill_allocating_task",
@@ -2696,7 +2691,7 @@ int proc_do_static_key(struct ctl_table *table, int write,
 		.mode		= 0644,
 		.proc_handler	= dirty_background_ratio_handler,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= &one_hundred,
+		.extra2		= SYSCTL_ONE_HUNDRED,
 	},
 	{
 		.procname	= "dirty_background_bytes",
@@ -2713,7 +2708,7 @@ int proc_do_static_key(struct ctl_table *table, int write,
 		.mode		= 0644,
 		.proc_handler	= dirty_ratio_handler,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= &one_hundred,
+		.extra2		= SYSCTL_ONE_HUNDRED,
 	},
 	{
 		.procname	= "dirty_bytes",
@@ -2753,7 +2748,7 @@ int proc_do_static_key(struct ctl_table *table, int write,
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= &one_hundred,
+		.extra2		= SYSCTL_ONE_HUNDRED,
 	},
 #ifdef CONFIG_HUGETLB_PAGE
 	{
@@ -2810,7 +2805,7 @@ int proc_do_static_key(struct ctl_table *table, int write,
 		.mode		= 0200,
 		.proc_handler	= drop_caches_sysctl_handler,
 		.extra1		= SYSCTL_ONE,
-		.extra2		= &four,
+		.extra2		= SYSCTL_FOUR,
 	},
 #ifdef CONFIG_COMPACTION
 	{
@@ -2863,7 +2858,7 @@ int proc_do_static_key(struct ctl_table *table, int write,
 		.mode		= 0644,
 		.proc_handler	= watermark_scale_factor_sysctl_handler,
 		.extra1		= SYSCTL_ONE,
-		.extra2		= &one_thousand,
+		.extra2		= SYSCTL_ONE_THOUSAND,
 	},
 	{
 		.procname	= "percpu_pagelist_fraction",
@@ -2942,7 +2937,7 @@ int proc_do_static_key(struct ctl_table *table, int write,
 		.mode		= 0644,
 		.proc_handler	= sysctl_min_unmapped_ratio_sysctl_handler,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= &one_hundred,
+		.extra2		= SYSCTL_ONE_HUNDRED,
 	},
 	{
 		.procname	= "min_slab_ratio",
@@ -2951,7 +2946,7 @@ int proc_do_static_key(struct ctl_table *table, int write,
 		.mode		= 0644,
 		.proc_handler	= sysctl_min_slab_ratio_sysctl_handler,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= &one_hundred,
+		.extra2		= SYSCTL_ONE_HUNDRED,
 	},
 #endif
 #ifdef CONFIG_SMP
@@ -3234,7 +3229,7 @@ int proc_do_static_key(struct ctl_table *table, int write,
 		.mode		= 0600,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= &two,
+		.extra2		= SYSCTL_TWO,
 	},
 	{
 		.procname	= "protected_regular",
@@ -3243,7 +3238,7 @@ int proc_do_static_key(struct ctl_table *table, int write,
 		.mode		= 0600,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= &two,
+		.extra2		= SYSCTL_TWO,
 	},
 	{
 		.procname	= "suid_dumpable",
@@ -3252,7 +3247,7 @@ int proc_do_static_key(struct ctl_table *table, int write,
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

