Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7A44B1EF1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Feb 2022 08:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347371AbiBKHCI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Feb 2022 02:02:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbiBKHCF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Feb 2022 02:02:05 -0500
Received: from smtpproxy21.qq.com (smtpbg701.qq.com [203.205.195.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF992634
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Feb 2022 23:02:04 -0800 (PST)
X-QQ-mid: bizesmtp52t1644562897t6ei7ucv
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 11 Feb 2022 15:01:33 +0800 (CST)
X-QQ-SSF: 0140000000200020C000B00A0000000
X-QQ-FEAT: Or3swkal8d2ySEZ5gfcMSGkkSLzZHQP2dpRbj9/tXSDL1jL9N+lIbbCM25LUG
        fgvEdHXw/PaghwO+Z28OYA8XEAo9eZUJWvcYlFtBUr+wJ9oQmoq/o+g7TSzHSRwllAe8b+4
        0F7wM8qWqsdHkajURx6w1D2992GdNDmRgYjVxNI2NrxevBb7bQAvp9ONrUo8jdvGQJcVZVI
        fcsucHSm8Jd60Wk1SH6B8EQVSE7bIxIyBdbjpqfYHDMrMKwy/Kphl5D0rTmga02rm4kceto
        LiiVNIFt0bRXvHXwSreaZYSxwxaptLlppM0YPFXVq7VT8EB1uDanFib9+8nV3AiaX5/uVCy
        VJJJPY7TvGZDnJMmFQ=
X-QQ-GoodBg: 2
From:   Zhen Ni <nizhen@uniontech.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, mcgrof@kernel.org,
        keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Zhen Ni <nizhen@uniontech.com>
Subject: [PATCH] sched: move deadline_period sysctls to deadline.c
Date:   Fri, 11 Feb 2022 15:00:14 +0800
Message-Id: <20220211070014.30764-1-nizhen@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

move deadline_period sysctls to deadline.c and use the new
register_sysctl_init() to register the sysctl interface.

Signed-off-by: Zhen Ni <nizhen@uniontech.com>
---
 include/linux/sched/sysctl.h |  3 ---
 kernel/sched/deadline.c      | 43 +++++++++++++++++++++++++++++-------
 kernel/sysctl.c              | 14 ------------
 3 files changed, 35 insertions(+), 25 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index c19dd5a2c05c..facdf2dbc83a 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -32,9 +32,6 @@ enum sched_tunable_scaling {
 extern unsigned int sysctl_sched_rt_period;
 extern int sysctl_sched_rt_runtime;
 
-extern unsigned int sysctl_sched_dl_period_max;
-extern unsigned int sysctl_sched_dl_period_min;
-
 #ifdef CONFIG_UCLAMP_TASK
 extern unsigned int sysctl_sched_uclamp_util_min;
 extern unsigned int sysctl_sched_uclamp_util_max;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index d2c072b0ef01..8f094ed8e8db 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -20,6 +20,40 @@
 
 struct dl_bandwidth def_dl_bandwidth;
 
+/*
+ * Default limits for DL period; on the top end we guard against small util
+ * tasks still getting ridiculously long effective runtimes, on the bottom end we
+ * guard against timer DoS.
+ */
+static unsigned int sysctl_sched_dl_period_max = 1 << 22; /* ~4 seconds */
+static unsigned int sysctl_sched_dl_period_min = 100;     /* 100 us */
+#ifdef CONFIG_SYSCTL
+static struct ctl_table sched_dl_sysctls[] = {
+	{
+		.procname       = "sched_deadline_period_max_us",
+		.data           = &sysctl_sched_dl_period_max,
+		.maxlen         = sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec,
+	},
+	{
+		.procname       = "sched_deadline_period_min_us",
+		.data           = &sysctl_sched_dl_period_min,
+		.maxlen         = sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec,
+	},
+	{}
+};
+
+static void __init sched_dl_sysctl_init(void)
+{
+	register_sysctl_init("kernel", sched_dl_sysctls);
+}
+#else
+#define sched_dl_sysctl_init() do { } while (0)
+#endif
+
 static inline struct task_struct *dl_task_of(struct sched_dl_entity *dl_se)
 {
 	return container_of(dl_se, struct task_struct, dl);
@@ -2487,6 +2521,7 @@ void __init init_sched_dl_class(void)
 	for_each_possible_cpu(i)
 		zalloc_cpumask_var_node(&per_cpu(local_cpu_mask_dl, i),
 					GFP_KERNEL, cpu_to_node(i));
+	sched_dl_sysctl_init();
 }
 
 void dl_add_task_root_domain(struct task_struct *p)
@@ -2854,14 +2889,6 @@ void __getparam_dl(struct task_struct *p, struct sched_attr *attr)
 	attr->sched_flags |= dl_se->flags;
 }
 
-/*
- * Default limits for DL period; on the top end we guard against small util
- * tasks still getting ridiculously long effective runtimes, on the bottom end we
- * guard against timer DoS.
- */
-unsigned int sysctl_sched_dl_period_max = 1 << 22; /* ~4 seconds */
-unsigned int sysctl_sched_dl_period_min = 100;     /* 100 us */
-
 /*
  * This function validates the new parameters of a -deadline task.
  * We ask for the deadline not being zero, and greater or equal
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 5ae443b2882e..d880a78598a1 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1706,20 +1706,6 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= sched_rt_handler,
 	},
-	{
-		.procname	= "sched_deadline_period_max_us",
-		.data		= &sysctl_sched_dl_period_max,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "sched_deadline_period_min_us",
-		.data		= &sysctl_sched_dl_period_min,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
 	{
 		.procname	= "sched_rr_timeslice_ms",
 		.data		= &sysctl_sched_rr_timeslice,
-- 
2.20.1



