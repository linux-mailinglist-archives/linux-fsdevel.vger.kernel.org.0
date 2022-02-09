Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F874AED87
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 10:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239265AbiBIJCo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 04:02:44 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbiBIJCe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 04:02:34 -0500
X-Greylist: delayed 26803 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 01:02:30 PST
Received: from smtpproxy21.qq.com (smtpbg703.qq.com [203.205.195.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A75E015650
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 01:02:30 -0800 (PST)
X-QQ-mid: bizesmtp37t1644397059tj91lubl
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 09 Feb 2022 16:57:33 +0800 (CST)
X-QQ-SSF: 0140000000200010C000C00B0000000
X-QQ-FEAT: MQdFpt6IGfGW25XRNRRXN+cnV3y8ABsHivnrSTLjmo8FU5lA7hwdk6Z7f+aVd
        Zb1RQ7xkDYZhW6LBeLCdA6v4ZmVbOyJ2D50mjDccU0rDSSCOHow1ixJQrrx0qSxKqH6gQGL
        ffHglCpzZMN1+kqSvNl3Cb7Wpwq3U1/qDQ52NCdeHx975rXeZrOGgSIzC9zp7SVw39wltpe
        ASqSaURTMbg7/QokZQm6QfoC3S0XJ0umxSACAgv8ZMuhqMWrdFTBfTHHuc5hSarv+W4zK1o
        lKcgFNiuh5tSw/En2CO8K1tnA5GiH7JhGEI/VkRy2JjrVzojh8gLxVx+kNOstLyTkn9b/dl
        zVmDnI3rGXaBZzY1YHOqBd5aTleAdbfJSg6+2JW
X-QQ-GoodBg: 2
From:   Zhen Ni <nizhen@uniontech.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        mcgrof@kernel.org, keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Zhen Ni <nizhen@uniontech.com>
Subject: [PATCH] sched: move uclamp_util sysctls to core.c
Date:   Wed,  9 Feb 2022 16:57:30 +0800
Message-Id: <20220209085730.22470-1-nizhen@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
 include/linux/sched/sysctl.h |  8 -------
 kernel/sched/core.c          | 43 ++++++++++++++++++++++++++++++++----
 kernel/sysctl.c              | 23 -------------------
 3 files changed, 39 insertions(+), 35 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index c19dd5a2c05c..1f07d14cf9fc 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -35,12 +35,6 @@ extern int sysctl_sched_rt_runtime;
 extern unsigned int sysctl_sched_dl_period_max;
 extern unsigned int sysctl_sched_dl_period_min;
 
-#ifdef CONFIG_UCLAMP_TASK
-extern unsigned int sysctl_sched_uclamp_util_min;
-extern unsigned int sysctl_sched_uclamp_util_max;
-extern unsigned int sysctl_sched_uclamp_util_min_rt_default;
-#endif
-
 #ifdef CONFIG_CFS_BANDWIDTH
 extern unsigned int sysctl_sched_cfs_bandwidth_slice;
 #endif
@@ -56,8 +50,6 @@ int sched_rr_handler(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
 int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
-int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos);
 int sysctl_numa_balancing(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
 int sysctl_schedstats(struct ctl_table *table, int write, void *buffer,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 848eaa0efe0e..1962111416e4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1254,10 +1254,10 @@ static void set_load_weight(struct task_struct *p, bool update_load)
 static DEFINE_MUTEX(uclamp_mutex);
 
 /* Max allowed minimum utilization */
-unsigned int sysctl_sched_uclamp_util_min = SCHED_CAPACITY_SCALE;
+static unsigned int sysctl_sched_uclamp_util_min = SCHED_CAPACITY_SCALE;
 
 /* Max allowed maximum utilization */
-unsigned int sysctl_sched_uclamp_util_max = SCHED_CAPACITY_SCALE;
+static unsigned int sysctl_sched_uclamp_util_max = SCHED_CAPACITY_SCALE;
 
 /*
  * By default RT tasks run at the maximum performance point/capacity of the
@@ -1274,7 +1274,7 @@ unsigned int sysctl_sched_uclamp_util_max = SCHED_CAPACITY_SCALE;
  * This knob will not override the system default sched_util_clamp_min defined
  * above.
  */
-unsigned int sysctl_sched_uclamp_util_min_rt_default = SCHED_CAPACITY_SCALE;
+static unsigned int sysctl_sched_uclamp_util_min_rt_default = SCHED_CAPACITY_SCALE;
 
 /* All clamps are required to be less or equal than these values */
 static struct uclamp_se uclamp_default[UCLAMP_CNT];
@@ -1727,7 +1727,7 @@ static void uclamp_update_root_tg(void)
 static void uclamp_update_root_tg(void) { }
 #endif
 
-int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
+static int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	bool update_root_tg = false;
@@ -1792,6 +1792,40 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 	return result;
 }
 
+#ifdef CONFIG_SYSCTL
+static struct ctl_table sched_uclamp_util_sysctls[] = {
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
+	{}
+};
+
+static void __init sched_uclamp_sysctl_init(void)
+{
+	register_sysctl_init("kernel", sched_uclamp_util_sysctls);
+}
+#else
+#define sched_uclamp_sysctl_init() do { } while (0)
+#endif
+
 static int uclamp_validate(struct task_struct *p,
 			   const struct sched_attr *attr)
 {
@@ -1955,6 +1989,7 @@ static void __init init_uclamp(void)
 		root_task_group.uclamp[clamp_id] = uc_max;
 #endif
 	}
+	sched_uclamp_sysctl_init();
 }
 
 #else /* CONFIG_UCLAMP_TASK */
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 5ae443b2882e..78996c0c8852 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1727,29 +1727,6 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= sched_rr_handler,
 	},
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
 #ifdef CONFIG_SCHED_AUTOGROUP
 	{
 		.procname	= "sched_autogroup_enabled",
-- 
2.20.1



