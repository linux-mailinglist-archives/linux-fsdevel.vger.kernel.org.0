Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E614B01E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 02:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiBJBVF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 20:21:05 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbiBJBVC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:21:02 -0500
Received: from smtpproxy21.qq.com (smtpbg701.qq.com [203.205.195.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043F61EC76
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 17:21:02 -0800 (PST)
X-QQ-mid: bizesmtp40t1644456039t9nh99gn
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 10 Feb 2022 09:20:34 +0800 (CST)
X-QQ-SSF: 0140000000200010C000B00A0000000
X-QQ-FEAT: Mx1dxJbW4IUnI3y2SrIKQ5MSdeobh2lcs2b75Si5IgzgCw7r9y38BqfW4vBA9
        xk/kJQG3oS0EvLCXEVA/nZEskyBd5PkZlC2sGH4Qeu7pq02CiBtDFKPxqCPAyreZ983hXP5
        SuIbS70XcvIsmXnX+tCEVcOYj8HUoCeJ05TmUdNmrgKgqPxAjCVnskHdx1Bpg6xB4tVwo+j
        ef3S0f4JYv8YklAsA5X1srsGORy5DbieueM6g9APVE4OIxh5PRL2CAyy/n4Sfk5DGlhkATC
        dqGLQY4/u2XR/vG3A3+Xvmk3CG9qfkZYbNOEdiEv/5OYJWxhSBIkrNYFbSYf7SKiK+eDCs0
        HPJG4xZA67E82VLzHM=
X-QQ-GoodBg: 2
From:   Zhen Ni <nizhen@uniontech.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, mcgrof@kernel.org,
        keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Zhen Ni <nizhen@uniontech.com>
Subject: [PATCH] sched: move rt_period/runtime sysctls to rt.c
Date:   Thu, 10 Feb 2022 09:20:30 +0800
Message-Id: <20220210012030.8813-1-nizhen@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

move rt_period/runtime sysctls to rt.c and use the new
register_sysctl_init() to register the sysctl interface.

Signed-off-by: Zhen Ni <nizhen@uniontech.com>
---
 include/linux/sched/sysctl.h | 11 ---------
 kernel/sched/core.c          | 13 -----------
 kernel/sched/rt.c            | 44 +++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h         |  4 ++++
 kernel/sysctl.c              | 14 ------------
 5 files changed, 47 insertions(+), 39 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 1f07d14cf9fc..e18ce60d6c8c 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -23,15 +23,6 @@ enum sched_tunable_scaling {
 	SCHED_TUNABLESCALING_END,
 };
 
-/*
- *  control realtime throttling:
- *
- *  /proc/sys/kernel/sched_rt_period_us
- *  /proc/sys/kernel/sched_rt_runtime_us
- */
-extern unsigned int sysctl_sched_rt_period;
-extern int sysctl_sched_rt_runtime;
-
 extern unsigned int sysctl_sched_dl_period_max;
 extern unsigned int sysctl_sched_dl_period_min;
 
@@ -48,8 +39,6 @@ extern int sched_rr_timeslice;
 
 int sched_rr_handler(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
-int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos);
 int sysctl_numa_balancing(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
 int sysctl_schedstats(struct ctl_table *table, int write, void *buffer,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1962111416e4..9742ad1276b0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -80,12 +80,6 @@ const_debug unsigned int sysctl_sched_nr_migrate = 8;
 const_debug unsigned int sysctl_sched_nr_migrate = 32;
 #endif
 
-/*
- * period over which we measure -rt task CPU usage in us.
- * default: 1s
- */
-unsigned int sysctl_sched_rt_period = 1000000;
-
 __read_mostly int scheduler_running;
 
 #ifdef CONFIG_SCHED_CORE
@@ -379,13 +373,6 @@ sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags) { }
 
 #endif /* CONFIG_SCHED_CORE */
 
-/*
- * part of the period that we allow rt tasks to run in us.
- * default: 0.95s
- */
-int sysctl_sched_rt_runtime = 950000;
-
-
 /*
  * Serialization rules:
  *
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 7b4f4fbbb404..5f23778c80b4 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -16,6 +16,47 @@ static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun);
 
 struct rt_bandwidth def_rt_bandwidth;
 
+/*
+ * period over which we measure -rt task CPU usage in us.
+ * default: 1s
+ */
+unsigned int sysctl_sched_rt_period = 1000000;
+
+/*
+ * part of the period that we allow rt tasks to run in us.
+ * default: 0.95s
+ */
+int sysctl_sched_rt_runtime = 950000;
+
+static int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
+		size_t *lenp, loff_t *ppos);
+#ifdef CONFIG_SYSCTL
+static struct ctl_table sched_rt_sysctls[] = {
+	{
+		.procname       = "sched_rt_period_us",
+		.data           = &sysctl_sched_rt_period,
+		.maxlen         = sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler   = sched_rt_handler,
+	},
+	{
+		.procname       = "sched_rt_runtime_us",
+		.data           = &sysctl_sched_rt_runtime,
+		.maxlen         = sizeof(int),
+		.mode           = 0644,
+		.proc_handler   = sched_rt_handler,
+	},
+	{}
+};
+
+static void __init sched_rt_sysctl_init(void)
+{
+	register_sysctl_init("kernel", sched_rt_sysctls);
+}
+#else
+#define sched_rt_sysctl_init() do { } while (0)
+#endif
+
 static enum hrtimer_restart sched_rt_period_timer(struct hrtimer *timer)
 {
 	struct rt_bandwidth *rt_b =
@@ -2471,6 +2512,7 @@ void __init init_sched_rt_class(void)
 		zalloc_cpumask_var_node(&per_cpu(local_cpu_mask, i),
 					GFP_KERNEL, cpu_to_node(i));
 	}
+	sched_rt_sysctl_init();
 }
 #endif /* CONFIG_SMP */
 
@@ -2928,7 +2970,7 @@ static void sched_rt_do_global(void)
 	raw_spin_unlock_irqrestore(&def_rt_bandwidth.rt_runtime_lock, flags);
 }
 
-int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
+static int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos)
 {
 	int old_period, old_runtime;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index de53be905739..695e280b063f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -100,6 +100,10 @@ extern void calc_global_load_tick(struct rq *this_rq);
 extern long calc_load_fold_active(struct rq *this_rq, long adjust);
 
 extern void call_trace_sched_update_nr_running(struct rq *rq, int count);
+
+extern unsigned int sysctl_sched_rt_period;
+extern int sysctl_sched_rt_runtime;
+
 /*
  * Helpers for converting nanosecond timing to jiffy resolution
  */
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 78996c0c8852..88264300ce69 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1692,20 +1692,6 @@ static struct ctl_table kern_table[] = {
 		.extra2		= SYSCTL_ONE,
 	},
 #endif /* CONFIG_NUMA_BALANCING */
-	{
-		.procname	= "sched_rt_period_us",
-		.data		= &sysctl_sched_rt_period,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= sched_rt_handler,
-	},
-	{
-		.procname	= "sched_rt_runtime_us",
-		.data		= &sysctl_sched_rt_runtime,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= sched_rt_handler,
-	},
 	{
 		.procname	= "sched_deadline_period_max_us",
 		.data		= &sysctl_sched_dl_period_max,
-- 
2.20.1



