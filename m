Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCF14B6B71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 12:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237417AbiBOLrL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 06:47:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237401AbiBOLrH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 06:47:07 -0500
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0056D6E4CE
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Feb 2022 03:46:55 -0800 (PST)
X-QQ-mid: bizesmtp42t1644925601t9w365aj
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 15 Feb 2022 19:46:39 +0800 (CST)
X-QQ-SSF: 0140000000200030C000B00A0000000
X-QQ-FEAT: g1CXZ3gRPwx4TwVKCclVJNNProhyXrIuqzTpwjvPUFGSA5iaB+P6KI1vlR2D1
        eXD07P/b4XtvxqlsHqgDjLWSZBCoW7yZ6ORi7Sh4tp2V6md2UoCmQVxXkGcARgxeRt96wRT
        hKF8QXbezm/5c6auJUHTpAY9K4BfOenY92Qa4zXnG/ldy/r9MeMZyj/k6uLInHLWpsENJoo
        kawGlcrvqbfwIWMJRaA9QLv6oQugsOA50osJckh4IBxxfLh1BLxOwwGdiDpRu1qYS2a1z7j
        k0K/EEMPAMuT4T7c/E9hYxO92Bs1fbcWKrUJEzStYs04YIMg+ZmMsJAsnk95wkvlPKKcp0R
        LfkAOwPyQ39IXRMFK33jT+LEiCYzfckzHM8OBottF97C4JvLk8=
X-QQ-GoodBg: 2
From:   Zhen Ni <nizhen@uniontech.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, mcgrof@kernel.org,
        keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Zhen Ni <nizhen@uniontech.com>
Subject: [PATCH v3 6/8] sched: Move uclamp_util sysctls to core.c
Date:   Tue, 15 Feb 2022 19:46:02 +0800
Message-Id: <20220215114604.25772-7-nizhen@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220215114604.25772-1-nizhen@uniontech.com>
References: <20220215114604.25772-1-nizhen@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

move uclamp_util sysctls to core.c and use the new
register_sysctl_init() to register the sysctl interface.

Signed-off-by: Zhen Ni <nizhen@uniontech.com>
---
 include/linux/sched/sysctl.h |  8 ------
 kernel/sched/core.c          | 48 +++++++++++++++++++++++++++---------
 kernel/sysctl.c              | 23 -----------------
 3 files changed, 37 insertions(+), 42 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 5515b54bfb57..9fe879602c4f 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -21,18 +21,10 @@ enum sched_tunable_scaling {
 	SCHED_TUNABLESCALING_END,
 };
 
-#ifdef CONFIG_UCLAMP_TASK
-extern unsigned int sysctl_sched_uclamp_util_min;
-extern unsigned int sysctl_sched_uclamp_util_max;
-extern unsigned int sysctl_sched_uclamp_util_min_rt_default;
-#endif
-
 #ifdef CONFIG_CFS_BANDWIDTH
 extern unsigned int sysctl_sched_cfs_bandwidth_slice;
 #endif
 
-int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos);
 int sysctl_numa_balancing(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 276033cceaf2..c4dab5535575 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1243,10 +1243,10 @@ static void set_load_weight(struct task_struct *p)
 static DEFINE_MUTEX(uclamp_mutex);
 
 /* Max allowed minimum utilization */
-unsigned int sysctl_sched_uclamp_util_min = SCHED_CAPACITY_SCALE;
+static unsigned int sysctl_sched_uclamp_util_min = SCHED_CAPACITY_SCALE;
 
 /* Max allowed maximum utilization */
-unsigned int sysctl_sched_uclamp_util_max = SCHED_CAPACITY_SCALE;
+static unsigned int sysctl_sched_uclamp_util_max = SCHED_CAPACITY_SCALE;
 
 /*
  * By default RT tasks run at the maximum performance point/capacity of the
@@ -1263,7 +1263,7 @@ unsigned int sysctl_sched_uclamp_util_max = SCHED_CAPACITY_SCALE;
  * This knob will not override the system default sched_util_clamp_min defined
  * above.
  */
-unsigned int sysctl_sched_uclamp_util_min_rt_default = SCHED_CAPACITY_SCALE;
+static unsigned int sysctl_sched_uclamp_util_min_rt_default = SCHED_CAPACITY_SCALE;
 
 /* All clamps are required to be less or equal than these values */
 static struct uclamp_se uclamp_default[UCLAMP_CNT];
@@ -1716,7 +1716,7 @@ static void uclamp_update_root_tg(void)
 static void uclamp_update_root_tg(void) { }
 #endif
 
-int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
+static int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	bool update_root_tg = false;
@@ -4360,8 +4360,12 @@ static int sysctl_schedstats(struct ctl_table *table, int write, void *buffer,
 		set_schedstats(state);
 	return err;
 }
+#endif /* CONFIG_PROC_SYSCTL */
+#endif /* CONFIG_SCHEDSTATS */
 
-static struct ctl_table sched_schedstats_sysctls[] = {
+#ifdef CONFIG_SYSCTL
+static struct ctl_table sched_core_sysctls[] = {
+#ifdef CONFIG_SCHEDSTATS
 	{
 		.procname       = "sched_schedstats",
 		.data           = NULL,
@@ -4371,17 +4375,39 @@ static struct ctl_table sched_schedstats_sysctls[] = {
 		.extra1         = SYSCTL_ZERO,
 		.extra2         = SYSCTL_ONE,
 	},
+#endif /* CONFIG_SCHEDSTATS */
+#ifdef CONFIG_UCLAMP_TASK
+	{
+		.procname       = "sched_util_clamp_min",
+		.data           = &sysctl_sched_uclamp_util_min,
+		.maxlen         = sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler   = sysctl_sched_uclamp_handler,
+	},
+	{
+		.procname       = "sched_util_clamp_max",
+		.data           = &sysctl_sched_uclamp_util_max,
+		.maxlen         = sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler   = sysctl_sched_uclamp_handler,
+	},
+	{
+		.procname       = "sched_util_clamp_min_rt_default",
+		.data           = &sysctl_sched_uclamp_util_min_rt_default,
+		.maxlen         = sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler   = sysctl_sched_uclamp_handler,
+	},
+#endif /* CONFIG_UCLAMP_TASK */
 	{}
 };
-
-static int __init sched_schedstats_sysctl_init(void)
+static int __init sched_core_sysctl_init(void)
 {
-	register_sysctl_init("kernel", sched_schedstats_sysctls);
+	register_sysctl_init("kernel", sched_core_sysctls);
 	return 0;
 }
-late_initcall(sched_schedstats_sysctl_init);
-#endif /* CONFIG_PROC_SYSCTL */
-#endif /* CONFIG_SCHEDSTATS */
+late_initcall(sched_core_sysctl_init);
+#endif /* CONFIG_SYSCTL */
 
 /*
  * fork()/clone()-time setup:
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index cfcbd17005af..d811e471f7d3 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1674,29 +1674,6 @@ static struct ctl_table kern_table[] = {
 		.extra2		= SYSCTL_ONE,
 	},
 #endif /* CONFIG_NUMA_BALANCING */
-#ifdef CONFIG_UCLAMP_TASK
-	{
-		.procname	= "sched_util_clamp_min",
-		.data		= &sysctl_sched_uclamp_util_min,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= sysctl_sched_uclamp_handler,
-	},
-	{
-		.procname	= "sched_util_clamp_max",
-		.data		= &sysctl_sched_uclamp_util_max,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= sysctl_sched_uclamp_handler,
-	},
-	{
-		.procname	= "sched_util_clamp_min_rt_default",
-		.data		= &sysctl_sched_uclamp_util_min_rt_default,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= sysctl_sched_uclamp_handler,
-	},
-#endif
 #ifdef CONFIG_CFS_BANDWIDTH
 	{
 		.procname	= "sched_cfs_bandwidth_slice_us",
-- 
2.20.1



