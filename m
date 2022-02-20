Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54AD4BCCD2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Feb 2022 07:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240724AbiBTGCD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Feb 2022 01:02:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239843AbiBTGCC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Feb 2022 01:02:02 -0500
Received: from smtpbg156.qq.com (smtpbg156.qq.com [15.184.82.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67A227F
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Feb 2022 22:01:39 -0800 (PST)
X-QQ-mid: bizesmtp82t1645336882t5dgk557
Received: from localhost.localdomain (unknown [180.102.102.45])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 20 Feb 2022 14:01:16 +0800 (CST)
X-QQ-SSF: 01400000002000B0F000B00A0000000
X-QQ-FEAT: zD6y7hNAcUDOz2spGL/eUKdvHQFW318WJmvVp1I5o3JA883k/G16UFiqIcHw4
        PBZ45w9nlRbhLwZwLDc91e8FdhgMGUn61raT5T9pXHP1bIUcBLW/oW3bXuXhP3ZhHBBbw4l
        sdn+5SZ7+S6rIzzBNhT4bOxGaUOTTxQn3REmqbN6PWYflwJz2iSsrIZZ5XNQlNYtQcdLZFO
        nhDonfnvqbgU1bSTmKhWJ6kaJtkFZmLR/YAC7aoB21xhpZbyStZK7UL4WM3y8VYc+u23GH8
        X578cnMVz9F37uklWZb+CU0sgSVjRtn/OnhTJwN3HFkVWOGFIUONEBk2H/5we+6FkMvqlHs
        f+FSmlATG7vdRv5ELgUXlO5onmn9p+WlGxBF21p
X-QQ-GoodBg: 2
From:   tangmeng <tangmeng@uniontech.com>
To:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, nizhen@uniontech.com,
        zhanglianjie@uniontech.com, nixiaoming@huawei.com,
        tangmeng <tangmeng@uniontech.com>
Subject: [PATCH 06/11] mm/vmstat: move vmstat sysctls to its own file
Date:   Sun, 20 Feb 2022 14:01:10 +0800
Message-Id: <20220220060110.13770-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

kernel/sysctl.c is a kitchen sink where everyone leaves their dirty
dishes, this makes it very difficult to maintain.

To help with this maintenance let's start by moving sysctls to places
where they actually belong.  The proc sysctl maintainers do not want to
know what sysctl knobs you wish to add for your own piece of code, we
just care about the core logic.

All filesystem syctls now get reviewed by fs folks. This commit
follows the commit of fs, move the vmstat sysctls to its own file,
mm/vmstat.c.

vmstat_refresh is defined when CONFIG_PROC_FS is defined, so macro
control is added to stat_refresh.

Signed-off-by: tangmeng <tangmeng@uniontech.com>
---
 include/linux/vmstat.h |  9 --------
 kernel/sysctl.c        | 25 ---------------------
 mm/vmstat.c            | 50 ++++++++++++++++++++++++++++++++++++++----
 3 files changed, 46 insertions(+), 38 deletions(-)

diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index bfe38869498d..b615d8d7c1d2 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -10,15 +10,10 @@
 #include <linux/static_key.h>
 #include <linux/mmdebug.h>
 
-extern int sysctl_stat_interval;
-
 #ifdef CONFIG_NUMA
 #define ENABLE_NUMA_STAT   1
 #define DISABLE_NUMA_STAT   0
-extern int sysctl_vm_numa_stat;
 DECLARE_STATIC_KEY_TRUE(vm_numa_stat_key);
-int sysctl_vm_numa_stat_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *length, loff_t *ppos);
 #endif
 
 struct reclaim_stat {
@@ -300,10 +295,6 @@ void quiet_vmstat(void);
 void cpu_vm_stats_fold(int cpu);
 void refresh_zone_stat_thresholds(void);
 
-struct ctl_table;
-int vmstat_refresh(struct ctl_table *, int write, void *buffer, size_t *lenp,
-		loff_t *ppos);
-
 void drain_zonestat(struct zone *zone, struct per_cpu_zonestat *);
 
 int calculate_pressure_threshold(struct zone *zone);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 62499e3207aa..31f2c6e21392 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2192,15 +2192,6 @@ static struct ctl_table vm_table[] = {
 		.mode           = 0644,
 		.proc_handler   = &hugetlb_mempolicy_sysctl_handler,
 	},
-	{
-		.procname		= "numa_stat",
-		.data			= &sysctl_vm_numa_stat,
-		.maxlen			= sizeof(int),
-		.mode			= 0644,
-		.proc_handler	= sysctl_vm_numa_stat_handler,
-		.extra1			= SYSCTL_ZERO,
-		.extra2			= SYSCTL_ONE,
-	},
 #endif
 	 {
 		.procname	= "hugetlb_shm_group",
@@ -2377,22 +2368,6 @@ static struct ctl_table vm_table[] = {
 		.extra2		= SYSCTL_ONE_HUNDRED,
 	},
 #endif
-#ifdef CONFIG_SMP
-	{
-		.procname	= "stat_interval",
-		.data		= &sysctl_stat_interval,
-		.maxlen		= sizeof(sysctl_stat_interval),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_jiffies,
-	},
-	{
-		.procname	= "stat_refresh",
-		.data		= NULL,
-		.maxlen		= 0,
-		.mode		= 0600,
-		.proc_handler	= vmstat_refresh,
-	},
-#endif
 #ifdef CONFIG_MMU
 	{
 		.procname	= "mmap_min_addr",
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 4057372745d0..e7eeba4db2eb 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -32,7 +32,7 @@
 #include "internal.h"
 
 #ifdef CONFIG_NUMA
-int sysctl_vm_numa_stat = ENABLE_NUMA_STAT;
+static int sysctl_vm_numa_stat = ENABLE_NUMA_STAT;
 
 /* zero numa counters within a zone */
 static void zero_zone_numa_counters(struct zone *zone)
@@ -74,7 +74,7 @@ static void invalid_numa_statistics(void)
 
 static DEFINE_MUTEX(vm_numa_stat_lock);
 
-int sysctl_vm_numa_stat_handler(struct ctl_table *table, int write,
+static int sysctl_vm_numa_stat_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *length, loff_t *ppos)
 {
 	int ret, oldval;
@@ -1853,7 +1853,7 @@ static const struct seq_operations vmstat_op = {
 
 #ifdef CONFIG_SMP
 static DEFINE_PER_CPU(struct delayed_work, vmstat_work);
-int sysctl_stat_interval __read_mostly = HZ;
+static int sysctl_stat_interval __read_mostly = HZ;
 
 #ifdef CONFIG_PROC_FS
 static void refresh_vm_stats(struct work_struct *work)
@@ -1861,7 +1861,7 @@ static void refresh_vm_stats(struct work_struct *work)
 	refresh_cpu_vm_stats(true);
 }
 
-int vmstat_refresh(struct ctl_table *table, int write,
+static int vmstat_refresh(struct ctl_table *table, int write,
 		   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	long val;
@@ -2238,3 +2238,45 @@ static int __init extfrag_debug_init(void)
 
 module_init(extfrag_debug_init);
 #endif
+
+#ifdef CONFIG_SYSCTL
+static struct ctl_table vm_stat_table[] = {
+#ifdef CONFIG_NUMA
+	{
+		.procname               = "numa_stat",
+		.data                   = &sysctl_vm_numa_stat,
+		.maxlen                 = sizeof(int),
+		.mode                   = 0644,
+		.proc_handler           = sysctl_vm_numa_stat_handler,
+		.extra1                 = SYSCTL_ZERO,
+		.extra2                 = SYSCTL_ONE,
+	},
+#endif /* CONFIG_NUMA */
+#ifdef CONFIG_SMP
+	{
+		.procname       = "stat_interval",
+		.data           = &sysctl_stat_interval,
+		.maxlen         = sizeof(sysctl_stat_interval),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec_jiffies,
+	},
+#ifdef CONFIG_PROC_FS
+	{
+		.procname       = "stat_refresh",
+		.data           = NULL,
+		.maxlen         = 0,
+		.mode           = 0600,
+		.proc_handler   = vmstat_refresh,
+	},
+#endif /* CONFIG_PROC_FS */
+#endif /* CONFIG_SMP */
+	{ }
+};
+
+static __init int vm_stat_sysctls_init(void)
+{
+	register_sysctl_init("vm", vm_stat_table);
+	return 0;
+}
+late_initcall(vm_stat_sysctls_init);
+#endif /* CONFIG_SYSCTL */
-- 
2.20.1



