Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0F821596A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jul 2020 16:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbgGFO3D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jul 2020 10:29:03 -0400
Received: from foss.arm.com ([217.140.110.172]:45134 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729158AbgGFO3C (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jul 2020 10:29:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B06DC0A;
        Mon,  6 Jul 2020 07:29:01 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0117C3F71E;
        Mon,  6 Jul 2020 07:28:58 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Quentin Perret <qperret@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 1/2] sched/uclamp: Add a new sysctl to control RT default boost value
Date:   Mon,  6 Jul 2020 15:28:38 +0100
Message-Id: <20200706142839.26629-2-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200706142839.26629-1-qais.yousef@arm.com>
References: <20200706142839.26629-1-qais.yousef@arm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RT tasks by default run at the highest capacity/performance level. When
uclamp is selected this default behavior is retained by enforcing the
requested uclamp.min (p->uclamp_req[UCLAMP_MIN]) of the RT tasks to be
uclamp_none(UCLAMP_MAX), which is SCHED_CAPACITY_SCALE; the maximum
value.

This is also referred to as 'the default boost value of RT tasks'.

See commit 1a00d999971c ("sched/uclamp: Set default clamps for RT tasks").

On battery powered devices, it is desired to control this default
(currently hardcoded) behavior at runtime to reduce energy consumed by
RT tasks.

For example, a mobile device manufacturer where big.LITTLE architecture
is dominant, the performance of the little cores varies across SoCs, and
on high end ones the big cores could be too power hungry.

Given the diversity of SoCs, the new knob allows manufactures to tune
the best performance/power for RT tasks for the particular hardware they
run on.

They could opt to further tune the value when the user selects
a different power saving mode or when the device is actively charging.

The runtime aspect of it further helps in creating a single kernel image
that can be run on multiple devices that require different tuning.

Keep in mind that a lot of RT tasks in the system are created by the
kernel. On Android for instance I can see over 50 RT tasks, only
a handful of which created by the Android framework.

To control the default behavior globally by system admins and device
integrator, introduce the new sysctl_sched_uclamp_util_min_rt_default
to change the default boost value of the RT tasks.

I anticipate this to be mostly in the form of modifying the init script
of a particular device.

To avoid polluting the fast path with unnecessary code, the approach
taken is to synchronously do the update by traversing all the existing
tasks in the system. This could race with a concurrent fork(), which is
dealt with by introducing sched_post_fork() function which will ensure
the racy fork will get the right update applied.

Tested on Juno-r2 in combination with the RT capacity awareness [1].
By default an RT task will go to the highest capacity CPU and run at the
maximum frequency, which is particularly energy inefficient on high end
mobile devices because the biggest core[s] are 'huge' and power hungry.

With this patch the RT task can be controlled to run anywhere by
default, and doesn't cause the frequency to be maximum all the time.
Yet any task that really needs to be boosted can easily escape this
default behavior by modifying its requested uclamp.min value
(p->uclamp_req[UCLAMP_MIN]) via sched_setattr() syscall.

[1] 804d402fb6f6: ("sched/rt: Make RT capacity-aware")

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
CC: Jonathan Corbet <corbet@lwn.net>
CC: Juri Lelli <juri.lelli@redhat.com>
CC: Vincent Guittot <vincent.guittot@linaro.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: Ben Segall <bsegall@google.com>
CC: Mel Gorman <mgorman@suse.de>
CC: Luis Chamberlain <mcgrof@kernel.org>
CC: Kees Cook <keescook@chromium.org>
CC: Iurii Zaikin <yzaikin@google.com>
CC: Quentin Perret <qperret@google.com>
CC: Valentin Schneider <valentin.schneider@arm.com>
CC: Patrick Bellasi <patrick.bellasi@matbug.net>
CC: Pavan Kondeti <pkondeti@codeaurora.org>
CC: linux-doc@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: linux-fsdevel@vger.kernel.org
---

Peter

I didn't do the

	read_lock(&taslist_lock);
	smp_mb__after_spinlock();
	read_unlock(&tasklist_lock);

dance you suggested on IRC as it didn't seem necessary. But maybe I missed
something.

 include/linux/sched/sysctl.h |   1 +
 include/linux/sched/task.h   |   1 +
 kernel/fork.c                |   1 +
 kernel/sched/core.c          | 132 +++++++++++++++++++++++++++++++++--
 kernel/sysctl.c              |   7 ++
 5 files changed, 135 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 660ac49f2b53..efabeace2bbf 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -64,6 +64,7 @@ extern int sysctl_sched_rt_runtime;
 #ifdef CONFIG_UCLAMP_TASK
 extern unsigned int sysctl_sched_uclamp_util_min;
 extern unsigned int sysctl_sched_uclamp_util_max;
+extern unsigned int sysctl_sched_uclamp_util_min_rt_default;
 #endif
 
 #ifdef CONFIG_CFS_BANDWIDTH
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 38359071236a..e7ddab095baf 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -55,6 +55,7 @@ extern asmlinkage void schedule_tail(struct task_struct *prev);
 extern void init_idle(struct task_struct *idle, int cpu);
 
 extern int sched_fork(unsigned long clone_flags, struct task_struct *p);
+extern void sched_post_fork(struct task_struct *p);
 extern void sched_dead(struct task_struct *p);
 
 void __noreturn do_task_dead(void);
diff --git a/kernel/fork.c b/kernel/fork.c
index 142b23645d82..cb555c0b3f19 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2304,6 +2304,7 @@ static __latent_entropy struct task_struct *copy_process(
 	write_unlock_irq(&tasklist_lock);
 
 	proc_fork_connector(p);
+	sched_post_fork(p);
 	cgroup_post_fork(p, args);
 	perf_event_fork(p);
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8f360326861e..aa0a0118ad97 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -791,6 +791,23 @@ unsigned int sysctl_sched_uclamp_util_min = SCHED_CAPACITY_SCALE;
 /* Max allowed maximum utilization */
 unsigned int sysctl_sched_uclamp_util_max = SCHED_CAPACITY_SCALE;
 
+/*
+ * By default RT tasks run at the maximum performance point/capacity of the
+ * system. Uclamp enforces this by always setting UCLAMP_MIN of RT tasks to
+ * SCHED_CAPACITY_SCALE.
+ *
+ * This knob allows admins to change the default behavior when uclamp is being
+ * used. In battery powered devices, particularly, running at the maximum
+ * capacity and frequency will increase energy consumption and shorten the
+ * battery life.
+ *
+ * This knob only affects RT tasks that their uclamp_se->user_defined == false.
+ *
+ * This knob will not override the system default sched_util_clamp_min defined
+ * above.
+ */
+unsigned int sysctl_sched_uclamp_util_min_rt_default = SCHED_CAPACITY_SCALE;
+
 /* All clamps are required to be less or equal than these values */
 static struct uclamp_se uclamp_default[UCLAMP_CNT];
 
@@ -873,6 +890,81 @@ unsigned int uclamp_rq_max_value(struct rq *rq, enum uclamp_id clamp_id,
 	return uclamp_idle_value(rq, clamp_id, clamp_value);
 }
 
+static void __uclamp_sync_util_min_rt_default(struct task_struct *p)
+{
+	unsigned int default_util_min;
+	struct uclamp_se *uc_se;
+
+	WARN_ON_ONCE(!rcu_read_lock_held());
+
+	if (!rt_task(p))
+		return;
+
+	uc_se = &p->uclamp_req[UCLAMP_MIN];
+
+	/* Only sync if user didn't override the default */
+	if (uc_se->user_defined)
+		return;
+
+	/* Sync with smp_wmb() in uclamp_sync_util_min_rt_default() */
+	smp_rmb();
+	default_util_min = sysctl_sched_uclamp_util_min_rt_default;
+	uclamp_se_set(uc_se, default_util_min, false);
+}
+
+static void uclamp_sync_util_min_rt_default(void)
+{
+	struct task_struct *g, *p;
+
+	/*
+	 * Make sure the updated sysctl_sched_uclamp_util_min_rt_default which
+	 * was just written is synchronized against any future read on another
+	 * cpu.
+	 */
+	smp_wmb();
+
+	/*
+	 * Wait for all updaters to observe the new change.
+	 *
+	 * There are 2 races to deal with here:
+	 *
+	 * 1. fork()->copy_process()
+	 *
+	 *	If a task was concurrently forking, for_each_process_thread()
+	 *	will not see it, hence it could have copied the old value and
+	 *	we missed the opportunity to update it.
+	 *
+	 *	This should be handled by sched_post_fork() where it'll ensure
+	 *	it performs the sync after the fork.
+	 *
+	 * 2. fork()->sched_post_fork()
+	 *    __setscheduler_uclamp()
+	 *
+	 *	Both of these functions could read the old value but then get
+	 *	preempted, during which a user might write new value to
+	 *	sysctl_sched_uclamp_util_min_rt_default.
+	 *
+	 *	// read sysctl_sched_uclamp_util_min_rt_default;
+	 *	// PREEMPT-OUT
+	 *	.
+	 *	.                  <-- sync happens here
+	 *	.
+	 *	// PREEMPT-IN
+	 *	// write p->uclamp_req[UCLAMP_MIN]
+	 *
+	 *	That section is protected with rcu_read_lock(), so
+	 *	synchronize_rcu() will guarantee it has finished before we
+	 *	perform the update. Hence ensure that this sync happens after
+	 *	any concurrent sync which should guarantee correctness.
+	 */
+	synchronize_rcu();
+
+	rcu_read_lock();
+	for_each_process_thread(g, p)
+		__uclamp_sync_util_min_rt_default(p);
+	rcu_read_unlock();
+}
+
 static inline struct uclamp_se
 uclamp_tg_restrict(struct task_struct *p, enum uclamp_id clamp_id)
 {
@@ -1114,12 +1206,13 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	bool update_root_tg = false;
-	int old_min, old_max;
+	int old_min, old_max, old_min_rt;
 	int result;
 
 	mutex_lock(&uclamp_mutex);
 	old_min = sysctl_sched_uclamp_util_min;
 	old_max = sysctl_sched_uclamp_util_max;
+	old_min_rt = sysctl_sched_uclamp_util_min_rt_default;
 
 	result = proc_dointvec(table, write, buffer, lenp, ppos);
 	if (result)
@@ -1128,7 +1221,9 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 		goto done;
 
 	if (sysctl_sched_uclamp_util_min > sysctl_sched_uclamp_util_max ||
-	    sysctl_sched_uclamp_util_max > SCHED_CAPACITY_SCALE) {
+	    sysctl_sched_uclamp_util_max > SCHED_CAPACITY_SCALE		||
+	    sysctl_sched_uclamp_util_min_rt_default > SCHED_CAPACITY_SCALE) {
+
 		result = -EINVAL;
 		goto undo;
 	}
@@ -1147,6 +1242,9 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 	if (update_root_tg)
 		uclamp_update_root_tg();
 
+	if (old_min_rt != sysctl_sched_uclamp_util_min_rt_default)
+		uclamp_sync_util_min_rt_default();
+
 	/*
 	 * We update all RUNNABLE tasks only when task groups are in use.
 	 * Otherwise, keep it simple and do just a lazy update at each next
@@ -1158,6 +1256,7 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 undo:
 	sysctl_sched_uclamp_util_min = old_min;
 	sysctl_sched_uclamp_util_max = old_max;
+	sysctl_sched_uclamp_util_min_rt_default = old_min_rt;
 done:
 	mutex_unlock(&uclamp_mutex);
 
@@ -1194,17 +1293,23 @@ static void __setscheduler_uclamp(struct task_struct *p,
 	 */
 	for_each_clamp_id(clamp_id) {
 		struct uclamp_se *uc_se = &p->uclamp_req[clamp_id];
-		unsigned int clamp_value = uclamp_none(clamp_id);
 
 		/* Keep using defined clamps across class changes */
 		if (uc_se->user_defined)
 			continue;
 
-		/* By default, RT tasks always get 100% boost */
-		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
-			clamp_value = uclamp_none(UCLAMP_MAX);
+		/*
+		 * RT by default have a 100% boost value that could be modified
+		 * at runtime.
+		 */
+		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN)) {
+			rcu_read_lock();
+			__uclamp_sync_util_min_rt_default(p);
+			rcu_read_unlock();
+		} else {
+			uclamp_se_set(uc_se, uclamp_none(clamp_id), false);
+		}
 
-		uclamp_se_set(uc_se, clamp_value, false);
 	}
 
 	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
@@ -1237,6 +1342,13 @@ static void uclamp_fork(struct task_struct *p)
 	}
 }
 
+static void uclamp_post_fork(struct task_struct *p)
+{
+	rcu_read_lock();
+	__uclamp_sync_util_min_rt_default(p);
+	rcu_read_unlock();
+}
+
 static void __init init_uclamp(void)
 {
 	struct uclamp_se uc_max = {};
@@ -1278,6 +1390,7 @@ static inline int uclamp_validate(struct task_struct *p,
 static void __setscheduler_uclamp(struct task_struct *p,
 				  const struct sched_attr *attr) { }
 static inline void uclamp_fork(struct task_struct *p) { }
+static inline void uclamp_post_fork(struct task_struct *p) { }
 static inline void init_uclamp(void) { }
 #endif /* CONFIG_UCLAMP_TASK */
 
@@ -2963,6 +3076,11 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	return 0;
 }
 
+void sched_post_fork(struct task_struct *p)
+{
+	uclamp_post_fork(p);
+}
+
 unsigned long to_ratio(u64 period, u64 runtime)
 {
 	if (runtime == RUNTIME_INF)
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index db1ce7af2563..d36913c9f3b5 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1801,6 +1801,13 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= sysctl_sched_uclamp_handler,
 	},
+	{
+		.procname	= "sched_util_clamp_min_rt_default",
+		.data		= &sysctl_sched_uclamp_util_min_rt_default,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= sysctl_sched_uclamp_handler,
+	},
 #endif
 #ifdef CONFIG_SCHED_AUTOGROUP
 	{
-- 
2.17.1

