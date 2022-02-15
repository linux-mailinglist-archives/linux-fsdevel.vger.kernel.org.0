Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0643A4B626E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 06:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbiBOFXa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 00:23:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233972AbiBOFXU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 00:23:20 -0500
Received: from smtpproxy21.qq.com (smtpbg701.qq.com [203.205.195.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92637F9564
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Feb 2022 21:23:11 -0800 (PST)
X-QQ-mid: bizesmtp5t1644902571ta1e0kja4
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 15 Feb 2022 13:22:49 +0800 (CST)
X-QQ-SSF: 0140000000200020C000000A0000000
X-QQ-FEAT: dpyQmELDBxFOkaeF2OHMMffhgLVBgman+tjRIPgz1RGBjLOUD5n1napWVa6EC
        BHb8uBYeK6YNgP8VDiG1EzmrK4Qhlf/VsbQU863WB3LGblInFaCpresSObm4yMarFmOeIjp
        uuJSuJyRCLPJ7wRK07ADMOt//KRW65mUqZlxhTzzOZjS4XsG2jGTjXXflTy93ZXizLUrJJy
        HwEFEPCqZz3ImK1WxkY6dQvbLW8BFO5+7oKHODhXsFuYZIwCAa29Os+loh4YcApm2jbYfCe
        8iM2B/LTvnKCpL9xI0j2+1SfjvhHWK0jvyc+ZhXahi3qdu8B9fqwccDPqQXlPod7Si2zvIV
        ETpY/ETcktIJUwYPRPqXlL/2bgDiMVsQJkvN26YJhTTEdxUUr4=
X-QQ-GoodBg: 1
From:   Zhen Ni <nizhen@uniontech.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, mcgrof@kernel.org,
        keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Zhen Ni <nizhen@uniontech.com>
Subject: [PATCH 6/8] sched: Move uclamp_util sysctls to core.c
Date:   Tue, 15 Feb 2022 13:22:12 +0800
Message-Id: <20220215052214.5286-7-nizhen@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220215052214.5286-1-nizhen@uniontech.com>
References: <20220215052214.5286-1-nizhen@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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



