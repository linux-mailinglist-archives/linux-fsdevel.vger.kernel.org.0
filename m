Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BD05B1C1E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 14:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbiIHMC4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 08:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiIHMCz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:02:55 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75801A6C48;
        Thu,  8 Sep 2022 05:02:53 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MNd4R5xGkzHngx;
        Thu,  8 Sep 2022 20:00:55 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 8 Sep 2022 20:02:51 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 8 Sep 2022 20:02:51 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
CC:     Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH Resend] sched: Move numa_balancing sysctls to its own file
Date:   Thu, 8 Sep 2022 20:07:14 +0800
Message-ID: <20220908120714.108481-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220908072531.87916-1-wangkefeng.wang@huawei.com>
References: <20220908072531.87916-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The sysctl_numa_balancing_promote_rate_limit and sysctl_numa_balancing
are part of sched, move them to its own file.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
Resend:  drop ctl_table in sysctl.h too.

 include/linux/sched/sysctl.h |  6 ------
 kernel/sched/core.c          | 13 ++++++++++++-
 kernel/sched/fair.c          | 18 +++++++++++++++---
 kernel/sysctl.c              | 19 -------------------
 4 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 303ee7dd0c7e..5a64582b086b 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -4,8 +4,6 @@
 
 #include <linux/types.h>
 
-struct ctl_table;
-
 #ifdef CONFIG_DETECT_HUNG_TASK
 /* used for hung_task and block/ */
 extern unsigned long sysctl_hung_task_timeout_secs;
@@ -27,12 +25,8 @@ enum sched_tunable_scaling {
 
 #ifdef CONFIG_NUMA_BALANCING
 extern int sysctl_numa_balancing_mode;
-extern unsigned int sysctl_numa_balancing_promote_rate_limit;
 #else
 #define sysctl_numa_balancing_mode	0
 #endif
 
-int sysctl_numa_balancing(struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos);
-
 #endif /* _LINUX_SCHED_SYSCTL_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b60422300af6..677225b71538 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4407,7 +4407,7 @@ static void reset_memory_tiering(void)
 	}
 }
 
-int sysctl_numa_balancing(struct ctl_table *table, int write,
+static int sysctl_numa_balancing(struct ctl_table *table, int write,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table t;
@@ -4534,6 +4534,17 @@ static struct ctl_table sched_core_sysctls[] = {
 		.proc_handler   = sysctl_sched_uclamp_handler,
 	},
 #endif /* CONFIG_UCLAMP_TASK */
+#ifdef CONFIG_NUMA_BALANCING
+	{
+		.procname	= "numa_balancing",
+		.data		= NULL, /* filled in by handler */
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= sysctl_numa_balancing,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_FOUR,
+	},
+#endif /* CONFIG_NUMA_BALANCING */
 	{}
 };
 static int __init sched_core_sysctl_init(void)
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cf3300b1a1d2..ff37620bdfbe 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -178,6 +178,11 @@ int __weak arch_asym_cpu_priority(int cpu)
 static unsigned int sysctl_sched_cfs_bandwidth_slice		= 5000UL;
 #endif
 
+#ifdef CONFIG_NUMA_BALANCING
+/* Restrict the NUMA promotion throughput (MB/s) for each target node. */
+static unsigned int sysctl_numa_balancing_promote_rate_limit = 65536;
+#endif
+
 #ifdef CONFIG_SYSCTL
 static struct ctl_table sched_fair_sysctls[] = {
 	{
@@ -197,6 +202,16 @@ static struct ctl_table sched_fair_sysctls[] = {
 		.extra1         = SYSCTL_ONE,
 	},
 #endif
+#ifdef CONFIG_NUMA_BALANCING
+	{
+		.procname	= "numa_balancing_promote_rate_limit_MBps",
+		.data		= &sysctl_numa_balancing_promote_rate_limit,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+	},
+#endif /* CONFIG_NUMA_BALANCING */
 	{}
 };
 
@@ -1094,9 +1109,6 @@ unsigned int sysctl_numa_balancing_scan_delay = 1000;
 /* The page with hint page fault latency < threshold in ms is considered hot */
 unsigned int sysctl_numa_balancing_hot_threshold = MSEC_PER_SEC;
 
-/* Restrict the NUMA promotion throughput (MB/s) for each target node. */
-unsigned int sysctl_numa_balancing_promote_rate_limit = 65536;
-
 struct numa_group {
 	refcount_t refcount;
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index f10a610aa834..2ea3bf603b89 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1631,25 +1631,6 @@ int proc_do_static_key(struct ctl_table *table, int write,
 }
 
 static struct ctl_table kern_table[] = {
-#ifdef CONFIG_NUMA_BALANCING
-	{
-		.procname	= "numa_balancing",
-		.data		= NULL, /* filled in by handler */
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= sysctl_numa_balancing,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_FOUR,
-	},
-	{
-		.procname	= "numa_balancing_promote_rate_limit_MBps",
-		.data		= &sysctl_numa_balancing_promote_rate_limit,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-	},
-#endif /* CONFIG_NUMA_BALANCING */
 	{
 		.procname	= "panic",
 		.data		= &panic_timeout,
-- 
2.35.3

