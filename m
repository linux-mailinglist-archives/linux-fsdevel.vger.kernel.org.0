Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8008A4B6B6B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 12:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237415AbiBOLrL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 06:47:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237404AbiBOLrI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 06:47:08 -0500
Received: from smtpproxy21.qq.com (smtpbg701.qq.com [203.205.195.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234C86E781
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Feb 2022 03:46:55 -0800 (PST)
X-QQ-mid: bizesmtp42t1644925593t3pm1mk3
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 15 Feb 2022 19:46:31 +0800 (CST)
X-QQ-SSF: 0140000000200030C000B00A0000000
X-QQ-FEAT: Mzskoac49OiF/11Gwdp4gDc1j4Zinhfjps/TN1K1t8Fh2vW3CC1AFPgnhSKIe
        YlzAfyNnuygVLwxcYT80ZevGbs2fRk4gxgLhv4iftzh1PfaTAj/X/GY+LGvseJyOrS+FiBo
        SaMoL+QpPzEkRV77s4q15DShW1kUR/ZPFmOSsdh5EErhkp5XsKKJqYSI2wlu7q4WAng8eRJ
        EXqMHI25xStBDamX1BnL35HVjNCc+1FZEnnzsaAWZDAONqfelKFASPPBc8ENh0qY5lqiZ6X
        K+6mwwntGVZFe62T0Co3wVa2d/OcFJ4E1I+4XHCyZsxKfASXp1d1pptX0JjlBpMMXRD87+1
        /NXyRNVfoMpc0htLuI1vNIuJQ6ZW8JDAI+Ltt2BeGAaLIwLPnJKVZzw2A50aA==
X-QQ-GoodBg: 2
From:   Zhen Ni <nizhen@uniontech.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, mcgrof@kernel.org,
        keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Zhen Ni <nizhen@uniontech.com>
Subject: [PATCH v3 4/8] sched: Move deadline_period sysctls to deadline.c
Date:   Tue, 15 Feb 2022 19:46:00 +0800
Message-Id: <20220215114604.25772-5-nizhen@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220215114604.25772-1-nizhen@uniontech.com>
References: <20220215114604.25772-1-nizhen@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign5
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
 kernel/sched/deadline.c      | 42 +++++++++++++++++++++++++++++-------
 kernel/sysctl.c              | 14 ------------
 3 files changed, 34 insertions(+), 25 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 99fbf61464ab..81187a8c625d 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -21,9 +21,6 @@ enum sched_tunable_scaling {
 	SCHED_TUNABLESCALING_END,
 };
 
-extern unsigned int sysctl_sched_dl_period_max;
-extern unsigned int sysctl_sched_dl_period_min;
-
 #ifdef CONFIG_UCLAMP_TASK
 extern unsigned int sysctl_sched_uclamp_util_min;
 extern unsigned int sysctl_sched_uclamp_util_max;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index d2c072b0ef01..9ed9ace11151 100644
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
+static int __init sched_dl_sysctl_init(void)
+{
+	register_sysctl_init("kernel", sched_dl_sysctls);
+	return 0;
+}
+late_initcall(sched_dl_sysctl_init);
+#endif
+
 static inline struct task_struct *dl_task_of(struct sched_dl_entity *dl_se)
 {
 	return container_of(dl_se, struct task_struct, dl);
@@ -2854,14 +2888,6 @@ void __getparam_dl(struct task_struct *p, struct sched_attr *attr)
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
index 73cccd935d65..f4434d22246b 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1674,20 +1674,6 @@ static struct ctl_table kern_table[] = {
 		.extra2		= SYSCTL_ONE,
 	},
 #endif /* CONFIG_NUMA_BALANCING */
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



