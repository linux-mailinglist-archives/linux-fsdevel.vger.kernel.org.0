Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC3F4B6B69
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 12:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237384AbiBOLq5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 06:46:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237377AbiBOLqy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 06:46:54 -0500
X-Greylist: delayed 18848 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Feb 2022 03:46:43 PST
Received: from smtpbg152.qq.com (smtpbg152.qq.com [13.245.186.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E5167367
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Feb 2022 03:46:43 -0800 (PST)
X-QQ-mid: bizesmtp42t1644925589trar06iw
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 15 Feb 2022 19:46:28 +0800 (CST)
X-QQ-SSF: 0140000000200030C000B00A0000000
X-QQ-FEAT: jfdGVjI73+TThiERy94CGjhCoqY8w2xurx3DF0RF/qLoJij9UOJd3rHF423LK
        Amhb/WuMgFPjm3XjVcmyCXPWtQ33PYJNH53npZYDM0RG8FzFx1dack6V1vLDAnMar4U2Q6f
        UUygnjIVXsjUvUF5BXBXqIANNY21XScIMWFAP6eUsJfl3U3kiipJDEkSOOkHK/Kd5UiVdwh
        cItd2B9AU+CvQaSItATzFAnjCTs2vf4ZkVM9dgjszHRE7bv6GmVooCrj/+MbFwTnzZMFXIM
        GAw04Ysew2BoMkxvAjducQhYiaS7Mnb/SsvvUNMN4jfw0bYayOzUXlrYci6ll08PEvgC5Ra
        ihKDU2/G2GCmWa6qs2A6HO9I5V53OEuOWRZMujk4vtIhAjl/54ciwTWnRK2Cg==
X-QQ-GoodBg: 2
From:   Zhen Ni <nizhen@uniontech.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, mcgrof@kernel.org,
        keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Zhen Ni <nizhen@uniontech.com>
Subject: [PATCH v3 3/8] sched: Move rt_period/runtime sysctls to rt.c
Date:   Tue, 15 Feb 2022 19:45:59 +0800
Message-Id: <20220215114604.25772-4-nizhen@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220215114604.25772-1-nizhen@uniontech.com>
References: <20220215114604.25772-1-nizhen@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign5
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

move rt_period/runtime sysctls to rt.c and use the new
register_sysctl_init() to register the sysctl interface.

Signed-off-by: Zhen Ni <nizhen@uniontech.com>
---
 include/linux/sched/sysctl.h | 11 ---------
 kernel/rcu/rcu.h             |  2 ++
 kernel/sched/core.c          | 13 -----------
 kernel/sched/rt.c            | 43 +++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h         |  4 ++++
 kernel/sysctl.c              | 14 ------------
 6 files changed, 48 insertions(+), 39 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index ffe42509a595..99fbf61464ab 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -21,15 +21,6 @@ enum sched_tunable_scaling {
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
 int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos);
 int sysctl_numa_balancing(struct ctl_table *table, int write, void *buffer,
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 24b5f2c2de87..7812c740b3bf 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -23,6 +23,8 @@
 #define RCU_SEQ_CTR_SHIFT	2
 #define RCU_SEQ_STATE_MASK	((1 << RCU_SEQ_CTR_SHIFT) - 1)
 
+extern int sysctl_sched_rt_runtime;
+
 /*
  * Return the counter portion of a sequence number previously returned
  * by rcu_seq_snap() or rcu_seq_current().
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3c1239c61b45..276033cceaf2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -81,12 +81,6 @@ const_debug unsigned int sysctl_sched_nr_migrate = 8;
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
@@ -380,13 +374,6 @@ sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags) { }
 
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
index 7b4f4fbbb404..1106828c4236 100644
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
+static int __init sched_rt_sysctl_init(void)
+{
+	register_sysctl_init("kernel", sched_rt_sysctls);
+	return 0;
+}
+late_initcall(sched_rt_sysctl_init);
+#endif
+
 static enum hrtimer_restart sched_rt_period_timer(struct hrtimer *timer)
 {
 	struct rt_bandwidth *rt_b =
@@ -2928,7 +2969,7 @@ static void sched_rt_do_global(void)
 	raw_spin_unlock_irqrestore(&def_rt_bandwidth.rt_runtime_lock, flags);
 }
 
-int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
+static int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos)
 {
 	int old_period, old_runtime;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 27465635c774..385e74095434 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -102,6 +102,10 @@ extern void calc_global_load_tick(struct rq *this_rq);
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
index 88ff6b27f8ab..73cccd935d65 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1674,20 +1674,6 @@ static struct ctl_table kern_table[] = {
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



