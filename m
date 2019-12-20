Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA1961280E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2019 17:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfLTQsq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Dec 2019 11:48:46 -0500
Received: from foss.arm.com ([217.140.110.172]:53332 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727181AbfLTQsp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Dec 2019 11:48:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A06B71FB;
        Fri, 20 Dec 2019 08:48:44 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 877B83F6CF;
        Fri, 20 Dec 2019 08:48:42 -0800 (PST)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        valentin.schneider@arm.com, qperret@google.com,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH] sched/rt: Add a new sysctl to control uclamp_util_min
Date:   Fri, 20 Dec 2019 16:48:38 +0000
Message-Id: <20191220164838.31619-1-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RT tasks by default try to run at the highest capacity/performance
level. When uclamp is selected this default behavior is retained by
enforcing the uclamp_util_min of the RT tasks to be
uclamp_none(UCLAMP_MAX), which is SCHED_CAPACITY_SCALE; the maximum
value.

See commit 1a00d999971c ("sched/uclamp: Set default clamps for RT tasks").

On battery powered devices, this default behavior could consume more
power, and it is desired to be able to tune it down. While uclamp allows
tuning this by changing the uclamp_util_min of the individual tasks, but
this is cumbersome and error prone.

To control the default behavior globally by system admins and device
integrators, introduce the new sysctl_sched_rt_uclamp_util_min to
change the default uclamp_util_min value of the RT tasks.

Whenever the new default changes, it'd be applied on the next wakeup of
the RT task, assuming that it still uses the system default value and
not a user applied one.

If the uclamp_util_min of an RT task is 0, then the RT utilization of
the rq is used to drive the frequency selection in schedutil for RT
tasks.

Tested on Juno-r2 in combination of the RT capacity awareness patches.
By default an RT task will go to the highest capacity CPU and run at the
maximum frequency. With this patch the RT task can run anywhere and
doesn't cause the frequency to be maximum all the time.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---
 include/linux/sched/sysctl.h |  1 +
 kernel/sched/core.c          | 54 ++++++++++++++++++++++++++++++++----
 kernel/sched/rt.c            |  6 ++++
 kernel/sched/sched.h         |  4 +++
 kernel/sysctl.c              |  7 +++++
 5 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index d4f6215ee03f..ec73d8db2092 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -59,6 +59,7 @@ extern int sysctl_sched_rt_runtime;
 #ifdef CONFIG_UCLAMP_TASK
 extern unsigned int sysctl_sched_uclamp_util_min;
 extern unsigned int sysctl_sched_uclamp_util_max;
+extern unsigned int sysctl_sched_rt_uclamp_util_min;
 #endif
 
 #ifdef CONFIG_CFS_BANDWIDTH
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 90e4b00ace89..a8ab0bb7a967 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -792,6 +792,23 @@ unsigned int sysctl_sched_uclamp_util_min = SCHED_CAPACITY_SCALE;
 /* Max allowed maximum utilization */
 unsigned int sysctl_sched_uclamp_util_max = SCHED_CAPACITY_SCALE;
 
+/*
+ * By default RT tasks run at the maximum performance point/capacity of the
+ * system. Uclamp enforces this by always setting UCLAMP_MIN of RT tasks to
+ * SCHED_CAPACITY_SCALE.
+ *
+ * This knob allows admins to change the default behavior when uclamp is being
+ * used. In battery powered devices particularly running at the maximum
+ * capacity will increase energy consumption and shorten the battery life.
+ *
+ * This knob only affects the default value RT uses when a new RT task is
+ * forked or has just changed policy to RT and no uclamp user settings were
+ * applied (ie: the task didn't modify the default value to a new value.
+ *
+ * This knob will not override the system default values defined above.
+ */
+unsigned int sysctl_sched_rt_uclamp_util_min = SCHED_CAPACITY_SCALE;
+
 /* All clamps are required to be less or equal than these values */
 static struct uclamp_se uclamp_default[UCLAMP_CNT];
 
@@ -919,6 +936,14 @@ uclamp_eff_get(struct task_struct *p, enum uclamp_id clamp_id)
 	return uc_req;
 }
 
+void uclamp_rt_sync_default_util_min(struct task_struct *p)
+{
+	struct uclamp_se *uc_se = &p->uclamp_req[UCLAMP_MIN];
+
+	if (!uc_se->user_defined)
+		uclamp_se_set(uc_se, sysctl_sched_rt_uclamp_util_min, false);
+}
+
 unsigned int uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id)
 {
 	struct uclamp_se uc_eff;
@@ -1116,12 +1141,13 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 				loff_t *ppos)
 {
 	bool update_root_tg = false;
-	int old_min, old_max;
+	int old_min, old_max, old_rt_min;
 	int result;
 
 	mutex_lock(&uclamp_mutex);
 	old_min = sysctl_sched_uclamp_util_min;
 	old_max = sysctl_sched_uclamp_util_max;
+	old_rt_min = sysctl_sched_rt_uclamp_util_min;
 
 	result = proc_dointvec(table, write, buffer, lenp, ppos);
 	if (result)
@@ -1129,12 +1155,23 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 	if (!write)
 		goto done;
 
+	/*
+	 * The new value will be applied to all RT tasks the next time they
+	 * wakeup, assuming the task is using the system default and not a user
+	 * specified value. In the latter we shall leave the value as the user
+	 * requested.
+	 */
 	if (sysctl_sched_uclamp_util_min > sysctl_sched_uclamp_util_max ||
 	    sysctl_sched_uclamp_util_max > SCHED_CAPACITY_SCALE) {
 		result = -EINVAL;
 		goto undo;
 	}
 
+	if (sysctl_sched_rt_uclamp_util_min > SCHED_CAPACITY_SCALE) {
+		result = -EINVAL;
+		goto undo;
+	}
+
 	if (old_min != sysctl_sched_uclamp_util_min) {
 		uclamp_se_set(&uclamp_default[UCLAMP_MIN],
 			      sysctl_sched_uclamp_util_min, false);
@@ -1160,6 +1197,7 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 undo:
 	sysctl_sched_uclamp_util_min = old_min;
 	sysctl_sched_uclamp_util_max = old_max;
+	sysctl_sched_rt_uclamp_util_min = old_rt_min;
 done:
 	mutex_unlock(&uclamp_mutex);
 
@@ -1202,9 +1240,12 @@ static void __setscheduler_uclamp(struct task_struct *p,
 		if (uc_se->user_defined)
 			continue;
 
-		/* By default, RT tasks always get 100% boost */
+		/*
+		 * By default, RT tasks always get 100% boost, which the admins
+		 * are allowed change via sysctl_sched_rt_uclamp_util_min knob.
+		 */
 		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
-			clamp_value = uclamp_none(UCLAMP_MAX);
+			clamp_value = sysctl_sched_rt_uclamp_util_min;
 
 		uclamp_se_set(uc_se, clamp_value, false);
 	}
@@ -1236,9 +1277,12 @@ static void uclamp_fork(struct task_struct *p)
 	for_each_clamp_id(clamp_id) {
 		unsigned int clamp_value = uclamp_none(clamp_id);
 
-		/* By default, RT tasks always get 100% boost */
+		/*
+		 * By default, RT tasks always get 100% boost, which the admins
+		 * are allowed change via sysctl_sched_rt_uclamp_util_min knob.
+		 */
 		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
-			clamp_value = uclamp_none(UCLAMP_MAX);
+			clamp_value = sysctl_sched_rt_uclamp_util_min;
 
 		uclamp_se_set(&p->uclamp_req[clamp_id], clamp_value, false);
 	}
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index e591d40fd645..19572dfc175b 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2147,6 +2147,12 @@ static void pull_rt_task(struct rq *this_rq)
  */
 static void task_woken_rt(struct rq *rq, struct task_struct *p)
 {
+	/*
+	 * When sysctl_sched_rt_uclamp_util_min value is changed by the user,
+	 * we apply any new value on the next wakeup, which is here.
+	 */
+	uclamp_rt_sync_default_util_min(p);
+
 	if (!task_running(rq, p) &&
 	    !test_tsk_need_resched(rq->curr) &&
 	    p->nr_cpus_allowed > 1 &&
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 280a3c735935..337bf17b1a9d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2300,6 +2300,8 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
 #endif /* CONFIG_CPU_FREQ */
 
 #ifdef CONFIG_UCLAMP_TASK
+void uclamp_rt_sync_default_util_min(struct task_struct *p);
+
 unsigned int uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
 
 static __always_inline
@@ -2330,6 +2332,8 @@ static inline unsigned int uclamp_util(struct rq *rq, unsigned int util)
 	return uclamp_util_with(rq, util, NULL);
 }
 #else /* CONFIG_UCLAMP_TASK */
+void uclamp_rt_sync_default_util_min(struct task_struct *p) {}
+
 static inline unsigned int uclamp_util_with(struct rq *rq, unsigned int util,
 					    struct task_struct *p)
 {
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 70665934d53e..06183762daac 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -465,6 +465,13 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= sysctl_sched_uclamp_handler,
 	},
+	{
+		.procname	= "sched_rt_util_clamp_min",
+		.data		= &sysctl_sched_rt_uclamp_util_min,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= sysctl_sched_uclamp_handler,
+	},
 #endif
 #ifdef CONFIG_SCHED_AUTOGROUP
 	{
-- 
2.17.1

