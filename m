Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C56D1C11A6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 13:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgEALtg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 07:49:36 -0400
Received: from foss.arm.com ([217.140.110.172]:39018 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728575AbgEALtf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 07:49:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F91B30E;
        Fri,  1 May 2020 04:49:34 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97BD63F305;
        Fri,  1 May 2020 04:49:31 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Qais Yousef <qais.yousef@arm.com>,
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
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 1/2] sched/uclamp: Add a new sysctl to control RT default boost value
Date:   Fri,  1 May 2020 12:49:26 +0100
Message-Id: <20200501114927.15248-1-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
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
integrators, introduce the new sysctl_sched_uclamp_util_min_rt_default
to change the default boost value of the RT tasks.

I anticipate this to be mostly in the form of modifying the init script
of a particular device.

Whenever the new default changes, it'd be applied lazily on the next
opportunity the scheduler needs to calculate the effective uclamp.min
value for the task, assuming that it still uses the system default value
and not a user applied one.

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
CC: Randy Dunlap <rdunlap@infradead.org>
CC: linux-doc@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: linux-fsdevel@vger.kernel.org
---

Changes in v4:
	* Make uclamp_sync_util_min_rt_default() inline and more selective
	  about when to do the sync (Pavan, Dietmar).

v3 discussion:

https://lore.kernel.org/lkml/20200428164134.5588-1-qais.yousef@arm.com/


 include/linux/sched/sysctl.h |  1 +
 kernel/sched/core.c          | 77 +++++++++++++++++++++++++++++++++---
 kernel/sysctl.c              |  7 ++++
 3 files changed, 80 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index d4f6215ee03f..e62cef019094 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -59,6 +59,7 @@ extern int sysctl_sched_rt_runtime;
 #ifdef CONFIG_UCLAMP_TASK
 extern unsigned int sysctl_sched_uclamp_util_min;
 extern unsigned int sysctl_sched_uclamp_util_max;
+extern unsigned int sysctl_sched_uclamp_util_min_rt_default;
 #endif
 
 #ifdef CONFIG_CFS_BANDWIDTH
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9a2fbf98fd6f..15d2978e1869 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -790,6 +790,26 @@ unsigned int sysctl_sched_uclamp_util_min = SCHED_CAPACITY_SCALE;
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
+ *
+ * Any modification is applied lazily on the next attempt to calculate the
+ * effective value of the task.
+ */
+unsigned int sysctl_sched_uclamp_util_min_rt_default = SCHED_CAPACITY_SCALE;
+
 /* All clamps are required to be less or equal than these values */
 static struct uclamp_se uclamp_default[UCLAMP_CNT];
 
@@ -872,6 +892,28 @@ unsigned int uclamp_rq_max_value(struct rq *rq, enum uclamp_id clamp_id,
 	return uclamp_idle_value(rq, clamp_id, clamp_value);
 }
 
+static inline void uclamp_sync_util_min_rt_default(struct task_struct *p,
+						   enum uclamp_id clamp_id)
+{
+	struct uclamp_se *uc_se;
+
+	/* Only sync for UCLAMP_MIN and RT tasks */
+	if (clamp_id != UCLAMP_MIN || likely(!rt_task(p)))
+		return;
+
+	uc_se = &p->uclamp_req[UCLAMP_MIN];
+
+	/*
+	 * Only sync if user didn't override the default request and the sysctl
+	 * knob has changed.
+	 */
+	if (unlikely(uc_se->user_defined) ||
+	    likely(uc_se->value == sysctl_sched_uclamp_util_min_rt_default))
+		return;
+
+	uclamp_se_set(uc_se, sysctl_sched_uclamp_util_min_rt_default, false);
+}
+
 static inline struct uclamp_se
 uclamp_tg_restrict(struct task_struct *p, enum uclamp_id clamp_id)
 {
@@ -907,8 +949,15 @@ uclamp_tg_restrict(struct task_struct *p, enum uclamp_id clamp_id)
 static inline struct uclamp_se
 uclamp_eff_get(struct task_struct *p, enum uclamp_id clamp_id)
 {
-	struct uclamp_se uc_req = uclamp_tg_restrict(p, clamp_id);
-	struct uclamp_se uc_max = uclamp_default[clamp_id];
+	struct uclamp_se uc_req, uc_max;
+
+	/*
+	 * Sync up any change to sysctl_sched_uclamp_util_min_rt_default value.
+	 */
+	uclamp_sync_util_min_rt_default(p, clamp_id);
+
+	uc_req = uclamp_tg_restrict(p, clamp_id);
+	uc_max = uclamp_default[clamp_id];
 
 	/* System default restrictions always apply */
 	if (unlikely(uc_req.value > uc_max.value))
@@ -1114,12 +1163,13 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 				loff_t *ppos)
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
@@ -1133,6 +1183,18 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 		goto undo;
 	}
 
+	/*
+	 * The new value will be applied to RT tasks the next time the
+	 * scheduler needs to calculate the effective uclamp.min for that task,
+	 * assuming the task is using the system default and not a user
+	 * specified value. In the latter we shall leave the value as the user
+	 * requested.
+	 */
+	if (sysctl_sched_uclamp_util_min_rt_default > SCHED_CAPACITY_SCALE) {
+		result = -EINVAL;
+		goto undo;
+	}
+
 	if (old_min != sysctl_sched_uclamp_util_min) {
 		uclamp_se_set(&uclamp_default[UCLAMP_MIN],
 			      sysctl_sched_uclamp_util_min, false);
@@ -1158,6 +1220,7 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 undo:
 	sysctl_sched_uclamp_util_min = old_min;
 	sysctl_sched_uclamp_util_max = old_max;
+	sysctl_sched_uclamp_util_min_rt_default = old_min_rt;
 done:
 	mutex_unlock(&uclamp_mutex);
 
@@ -1200,9 +1263,13 @@ static void __setscheduler_uclamp(struct task_struct *p,
 		if (uc_se->user_defined)
 			continue;
 
-		/* By default, RT tasks always get 100% boost */
+		/*
+		 * By default, RT tasks always get 100% boost, which the admins
+		 * are allowed to change via
+		 * sysctl_sched_uclamp_util_min_rt_default knob.
+		 */
 		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
-			clamp_value = uclamp_none(UCLAMP_MAX);
+			clamp_value = sysctl_sched_uclamp_util_min_rt_default;
 
 		uclamp_se_set(uc_se, clamp_value, false);
 	}
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 8a176d8727a3..64117363c502 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -453,6 +453,13 @@ static struct ctl_table kern_table[] = {
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

