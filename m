Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12B1219D6BA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 14:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403761AbgDCMbb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 08:31:31 -0400
Received: from foss.arm.com ([217.140.110.172]:52586 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728099AbgDCMbb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 08:31:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4D2D7FA;
        Fri,  3 Apr 2020 05:31:29 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 546163F68F;
        Fri,  3 Apr 2020 05:31:27 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
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
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] sched/uclamp: Add a new sysctl to control RT default boost value
Date:   Fri,  3 Apr 2020 13:30:19 +0100
Message-Id: <20200403123020.13897-1-qais.yousef@arm.com>
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
integrators, introduce the new sysctl_sched_rt_default_uclamp_util_min
to change the default boost value of the RT tasks.

I anticipate this to be mostly in the form of modifying the init script
of a particular device.

Whenever the new default changes, it'd be applied lazily on the next
enqueue, assuming that it still uses the system default value and not a
user applied one.

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

Changes in v2:
	* Do the lazy update in uclamp_rq_inc() (Thanks Qeuntin)
	* Rename to: sysctl_sched_rt_default_uclamp_util_min (Quentin)
	* uclamp_rt_sync_default_util_min() now is a static function in core.c
	  with no prototype export in sched.h
	* Added docs in sysctl/kernel.rst (patch 2) (Quentin)

v1 can be found here:

	https://lore.kernel.org/lkml/20191220164838.31619-1-qais.yousef@arm.com/

Summary of v1 discussion:

Patrick has voiced a concern about the approach. AFAIU the suggestion proposed
by Patrick instead is to split sysctl_sched_uclamp_util_min into 2, one for RT
and another for CFS. And use the RT constraint to limit how much boost RT tasks
get globally.

If my understanding was correct, the proposed approach by Patrick doesn't work
for what we want to achieve here. Beside it breaks ABI.

The global per RT task doesn't work because if I want to disable boosting for
all RT tasks by default but still allow a handful of critical ones to be
boosted, the global constraint will render any request via sched_setattr()
syscall a NOP.

So IIUC, we'll still _always_ boost RT tasks to max, but introduce a new knob
to cap and restrict this boost. Which IMHO is a convoluted way to disable the
hardcoded max boost behavior.

This approach instead gives admins a direct control over the default boost
value for RT tasks, which is exactly what we want, without any level of
indirection. It converts a hardcoded value into a sysctl variable that
sysadmins can modify at runtime.


 include/linux/sched/sysctl.h |  1 +
 kernel/sched/core.c          | 66 +++++++++++++++++++++++++++++++++---
 kernel/sysctl.c              |  7 ++++
 3 files changed, 69 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index d4f6215ee03f..91204480fabc 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -59,6 +59,7 @@ extern int sysctl_sched_rt_runtime;
 #ifdef CONFIG_UCLAMP_TASK
 extern unsigned int sysctl_sched_uclamp_util_min;
 extern unsigned int sysctl_sched_uclamp_util_max;
+extern unsigned int sysctl_sched_rt_default_uclamp_util_min;
 #endif
 
 #ifdef CONFIG_CFS_BANDWIDTH
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1a9983da4408..a726b26a5056 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -797,6 +797,27 @@ unsigned int sysctl_sched_uclamp_util_min = SCHED_CAPACITY_SCALE;
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
+ * This knob only affects the default value RT has when a new RT task is
+ * forked or has just changed policy to RT, given the user hasn't modified the
+ * uclamp.min value of the task via sched_setattr().
+ *
+ * This knob will not override the system default sched_util_clamp_min defined
+ * above.
+ *
+ * Any modification is applied lazily on the next RT task wakeup.
+ */
+unsigned int sysctl_sched_rt_default_uclamp_util_min = SCHED_CAPACITY_SCALE;
+
 /* All clamps are required to be less or equal than these values */
 static struct uclamp_se uclamp_default[UCLAMP_CNT];
 
@@ -924,6 +945,14 @@ uclamp_eff_get(struct task_struct *p, enum uclamp_id clamp_id)
 	return uc_req;
 }
 
+static void uclamp_rt_sync_default_util_min(struct task_struct *p)
+{
+	struct uclamp_se *uc_se = &p->uclamp_req[UCLAMP_MIN];
+
+	if (!uc_se->user_defined)
+		uclamp_se_set(uc_se, sysctl_sched_rt_default_uclamp_util_min, false);
+}
+
 unsigned long uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id)
 {
 	struct uclamp_se uc_eff;
@@ -1030,6 +1059,12 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
 	if (unlikely(!p->sched_class->uclamp_enabled))
 		return;
 
+	/*
+	 * When sysctl_sched_rt_default_uclamp_util_min value is changed by the
+	 * user, we apply any new value on the next wakeup, which is here.
+	 */
+	uclamp_rt_sync_default_util_min(p);
+
 	for_each_clamp_id(clamp_id)
 		uclamp_rq_inc_id(rq, p, clamp_id);
 
@@ -1121,12 +1156,13 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 				loff_t *ppos)
 {
 	bool update_root_tg = false;
-	int old_min, old_max;
+	int old_min, old_max, old_rt_min;
 	int result;
 
 	mutex_lock(&uclamp_mutex);
 	old_min = sysctl_sched_uclamp_util_min;
 	old_max = sysctl_sched_uclamp_util_max;
+	old_rt_min = sysctl_sched_rt_default_uclamp_util_min;
 
 	result = proc_dointvec(table, write, buffer, lenp, ppos);
 	if (result)
@@ -1134,12 +1170,23 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
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
 
+	if (sysctl_sched_rt_default_uclamp_util_min > SCHED_CAPACITY_SCALE) {
+		result = -EINVAL;
+		goto undo;
+	}
+
 	if (old_min != sysctl_sched_uclamp_util_min) {
 		uclamp_se_set(&uclamp_default[UCLAMP_MIN],
 			      sysctl_sched_uclamp_util_min, false);
@@ -1165,6 +1212,7 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 undo:
 	sysctl_sched_uclamp_util_min = old_min;
 	sysctl_sched_uclamp_util_max = old_max;
+	sysctl_sched_rt_default_uclamp_util_min = old_rt_min;
 done:
 	mutex_unlock(&uclamp_mutex);
 
@@ -1207,9 +1255,13 @@ static void __setscheduler_uclamp(struct task_struct *p,
 		if (uc_se->user_defined)
 			continue;
 
-		/* By default, RT tasks always get 100% boost */
+		/*
+		 * By default, RT tasks always get 100% boost, which the admins
+		 * are allowed to change via
+		 * sysctl_sched_rt_default_uclamp_util_min knob.
+		 */
 		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
-			clamp_value = uclamp_none(UCLAMP_MAX);
+			clamp_value = sysctl_sched_rt_default_uclamp_util_min;
 
 		uclamp_se_set(uc_se, clamp_value, false);
 	}
@@ -1241,9 +1293,13 @@ static void uclamp_fork(struct task_struct *p)
 	for_each_clamp_id(clamp_id) {
 		unsigned int clamp_value = uclamp_none(clamp_id);
 
-		/* By default, RT tasks always get 100% boost */
+		/*
+		 * By default, RT tasks always get 100% boost, which the admins
+		 * are allowed to change via
+		 * sysctl_sched_rt_default_uclamp_util_min knob.
+		 */
 		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
-			clamp_value = uclamp_none(UCLAMP_MAX);
+			clamp_value = sysctl_sched_rt_default_uclamp_util_min;
 
 		uclamp_se_set(&p->uclamp_req[clamp_id], clamp_value, false);
 	}
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index ad5b88a53c5a..0272ae8c6147 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -465,6 +465,13 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= sysctl_sched_uclamp_handler,
 	},
+	{
+		.procname	= "sched_rt_default_util_clamp_min",
+		.data		= &sysctl_sched_rt_default_uclamp_util_min,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= sysctl_sched_uclamp_handler,
+	},
 #endif
 #ifdef CONFIG_SCHED_AUTOGROUP
 	{
-- 
2.17.1

