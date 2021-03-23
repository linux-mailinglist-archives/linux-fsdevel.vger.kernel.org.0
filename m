Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06432345687
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 04:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhCWD5g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 23:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhCWD5a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 23:57:30 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14233C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Mar 2021 20:57:30 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id o14so755398qvn.18
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Mar 2021 20:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=7LwaQTamB0TdcaLHECmYAIONSZjqeBm8xO6I3hJTgjc=;
        b=jCOSOYdBtVKK9EDPmBx7oGZcmSK0UZSRiDekzLhwtDTccFlLihPntyaN+wS9xwijp6
         clO40aMjTSlxknAjX5WxYYF37uhAZ6NK4aQtTKYj46RbnFfjI/6k9qM088waqmnwrSaL
         t0dFHjk7ZmT2ZgNWNENQUiDnxEoMRy22hUjd3Qqob8ceFbvf0KGf1vYodID8ak7SdWZq
         /oYitO9baPmZcRUvVyXyVtbdH7ltLZDzBawjX2+QpV+DI/ztpUNm4JNCDy5xlYL7bMx+
         MECaLBrnyaQXAEixuLZmErz2qHzDm/SiX9GS9rklVcHzYQrmN7PDytGDPcTEjlVYjvmP
         2l2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=7LwaQTamB0TdcaLHECmYAIONSZjqeBm8xO6I3hJTgjc=;
        b=DfwlvrwiTdwRj0yTWabhIEki4GdsRFt4lj7aZmg2BraTH22JCRNiD9G+yHKynZ6Zzk
         o01VeY0fJHqXVmuoCgoKHq0KgwlyyPN2xpeRHbOowxGcLvS+MGuxwKEp5+WfAAnKDQUc
         HpmCgln2d2pfkPvKpSjx6QmBTsTaA1IkeLEaTSEQODwz6ZKb8hg7abMVoc3rmHONo+3J
         a+Vyhp7zJqwhPtTEIa8c74JBwL5/GS3yByO3O4Za5I+tLE/BhcPwUD4ruxzqc9QbACme
         WEjgqF6ccm6Ec24cLm4ax72RunjMWfnQqOe1G5hU433s4LXQU77MQmNK0oiimPEMQL9U
         q1wA==
X-Gm-Message-State: AOAM530YrDzkyT9rcB6/s9Ne2EqediY5onleMF03uMnEDOzMhcyvxff5
        XSRBPs77llxeggCV+Wwmi2KAb2E1ktnt
X-Google-Smtp-Source: ABdhPJyOadzMevOe0ZmoKY4krpE5yZpUH/97w/m3YqVOPclw7XUEDBkMkqGNOOqnd1/CI4BO17vujCfHSwl5
X-Received: from joshdon.svl.corp.google.com ([2620:15c:2cd:202:f8e3:ee1:458e:d199])
 (user=joshdon job=sendgmr) by 2002:ad4:4b0a:: with SMTP id
 r10mr2847891qvw.31.1616471849233; Mon, 22 Mar 2021 20:57:29 -0700 (PDT)
Date:   Mon, 22 Mar 2021 20:57:06 -0700
Message-Id: <20210323035706.572953-1-joshdon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v2] sched: Warn on long periods of pending need_resched
From:   Josh Don <joshdon@google.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        David Rientjes <rientjes@google.com>,
        Oleg Rombakh <olegrom@google.com>, linux-doc@vger.kernel.org,
        Paul Turner <pjt@google.com>, Josh Don <joshdon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Paul Turner <pjt@google.com>

CPU scheduler marks need_resched flag to signal a schedule() on a
particular CPU. But, schedule() may not happen immediately in cases
where the current task is executing in the kernel mode (no
preemption state) for extended periods of time.

This patch adds a warn_on if need_resched is pending for more than the
time specified in sysctl resched_latency_warn_ms. If it goes off, it is
likely that there is a missing cond_resched() somewhere. Monitoring is
done via the tick and the accuracy is hence limited to jiffy scale. This
also means that we won't trigger the warning if the tick is disabled.

This feature is default disabled. It can be toggled on using sysctl
resched_latency_warn_enabled.

Signed-off-by: Paul Turner <pjt@google.com>
Signed-off-by: Josh Don <joshdon@google.com>
---
Delta from v1:
- separate sysctl for enabling/disabling and triggering warn_once
  behavior
- add documentation
- static branch for the enable
 Documentation/admin-guide/sysctl/kernel.rst | 23 ++++++
 include/linux/sched/sysctl.h                |  4 ++
 kernel/sched/core.c                         | 78 ++++++++++++++++++++-
 kernel/sched/debug.c                        | 10 +++
 kernel/sched/sched.h                        | 10 +++
 kernel/sysctl.c                             | 24 +++++++
 6 files changed, 148 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 1d56a6b73a4e..2d4a21d3b79f 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1077,6 +1077,29 @@ ROM/Flash boot loader. Maybe to tell it what to do after
 rebooting. ???
 
 
+resched_latency_warn_enabled
+============================
+
+Enables/disables a warning that will trigger if need_resched is set for
+longer than sysctl ``resched_latency_warn_ms``. This warning likely
+indicates a kernel bug, such as a failure to call cond_resched().
+
+Requires ``CONFIG_SCHED_DEBUG``.
+
+
+resched_latency_warn_ms
+=======================
+
+See ``resched_latency_warn_enabled``.
+
+
+resched_latency_warn_once
+=========================
+
+If set, ``resched_latency_warn_enabled`` will only trigger one warning
+per boot.
+
+
 sched_energy_aware
 ==================
 
diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 3c31ba88aca5..43a1f5ab819a 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -48,6 +48,10 @@ extern unsigned int sysctl_numa_balancing_scan_size;
 extern __read_mostly unsigned int sysctl_sched_migration_cost;
 extern __read_mostly unsigned int sysctl_sched_nr_migrate;
 
+extern struct static_key_false resched_latency_warn_enabled;
+extern int sysctl_resched_latency_warn_ms;
+extern int sysctl_resched_latency_warn_once;
+
 int sched_proc_update_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *length, loff_t *ppos);
 #endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 98191218d891..d69ae342b450 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -58,7 +58,21 @@ const_debug unsigned int sysctl_sched_features =
 #include "features.h"
 	0;
 #undef SCHED_FEAT
-#endif
+
+/*
+ * Print a warning if need_resched is set for the given duration (if
+ * resched_latency_warn_enabled is set).
+ *
+ * If sysctl_resched_latency_warn_once is set, only one warning will be shown
+ * per boot.
+ *
+ * Resched latency will be ignored for the first resched_boot_quiet_sec, to
+ * reduce false alarms.
+ */
+int sysctl_resched_latency_warn_ms = 100;
+int sysctl_resched_latency_warn_once = 1;
+const long resched_boot_quiet_sec = 600;
+#endif /* CONFIG_SCHED_DEBUG */
 
 /*
  * Number of tasks to iterate in a single balance run.
@@ -4520,6 +4534,58 @@ unsigned long long task_sched_runtime(struct task_struct *p)
 	return ns;
 }
 
+#ifdef CONFIG_SCHED_DEBUG
+static u64 resched_latency_check(struct rq *rq)
+{
+	int latency_warn_ms = READ_ONCE(sysctl_resched_latency_warn_ms);
+	u64 need_resched_latency, now = rq_clock(rq);
+	static bool warned_once;
+
+	if (sysctl_resched_latency_warn_once && warned_once)
+		return 0;
+
+	if (!need_resched() || WARN_ON_ONCE(latency_warn_ms < 2))
+		return 0;
+
+	/* Disable this warning for the first few mins after boot */
+	if (now < resched_boot_quiet_sec * NSEC_PER_SEC)
+		return 0;
+
+	if (!rq->last_seen_need_resched_ns) {
+		rq->last_seen_need_resched_ns = now;
+		rq->ticks_without_resched = 0;
+		return 0;
+	}
+
+	rq->ticks_without_resched++;
+	need_resched_latency = now - rq->last_seen_need_resched_ns;
+	if (need_resched_latency <= latency_warn_ms * NSEC_PER_MSEC)
+		return 0;
+
+	warned_once = true;
+
+	return need_resched_latency;
+}
+
+static int __init setup_resched_latency_warn_ms(char *str)
+{
+	long val;
+
+	if ((kstrtol(str, 0, &val))) {
+		pr_warn("Unable to set resched_latency_warn_ms\n");
+		return 1;
+	}
+
+	sysctl_resched_latency_warn_ms = val;
+	return 1;
+}
+__setup("resched_latency_warn_ms=", setup_resched_latency_warn_ms);
+#else
+static inline u64 resched_latency_check(struct rq *rq) { return 0; }
+#endif /* CONFIG_SCHED_DEBUG */
+
+DEFINE_STATIC_KEY_FALSE(resched_latency_warn_enabled);
+
 /*
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
@@ -4531,6 +4597,7 @@ void scheduler_tick(void)
 	struct task_struct *curr = rq->curr;
 	struct rq_flags rf;
 	unsigned long thermal_pressure;
+	u64 resched_latency = 0;
 
 	arch_scale_freq_tick();
 	sched_clock_tick();
@@ -4541,11 +4608,17 @@ void scheduler_tick(void)
 	thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
 	update_thermal_load_avg(rq_clock_thermal(rq), rq, thermal_pressure);
 	curr->sched_class->task_tick(rq, curr, 0);
+	if (static_branch_unlikely(&resched_latency_warn_enabled))
+		resched_latency = resched_latency_check(rq);
 	calc_global_load_tick(rq);
 	psi_task_tick(rq);
 
 	rq_unlock(rq, &rf);
 
+	if (static_branch_unlikely(&resched_latency_warn_enabled) &&
+	    resched_latency)
+		resched_latency_warn(cpu, resched_latency);
+
 	perf_event_task_tick();
 
 #ifdef CONFIG_SMP
@@ -5040,6 +5113,9 @@ static void __sched notrace __schedule(bool preempt)
 	next = pick_next_task(rq, prev, &rf);
 	clear_tsk_need_resched(prev);
 	clear_preempt_need_resched();
+#ifdef CONFIG_SCHED_DEBUG
+	rq->last_seen_need_resched_ns = 0;
+#endif
 
 	if (likely(prev != next)) {
 		rq->nr_switches++;
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 486f403a778b..39fe8c7851f7 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1033,3 +1033,13 @@ void proc_sched_set_task(struct task_struct *p)
 	memset(&p->se.statistics, 0, sizeof(p->se.statistics));
 #endif
 }
+
+void resched_latency_warn(int cpu, u64 latency)
+{
+	static DEFINE_RATELIMIT_STATE(latency_check_ratelimit, 60 * 60 * HZ, 1);
+
+	WARN(__ratelimit(&latency_check_ratelimit),
+	     "sched: CPU %d need_resched set for > %llu ns (%d ticks) "
+	     "without schedule\n",
+	     cpu, latency, cpu_rq(cpu)->ticks_without_resched);
+}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 10a1522b1e30..ae2a99098388 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -57,6 +57,7 @@
 #include <linux/prefetch.h>
 #include <linux/profile.h>
 #include <linux/psi.h>
+#include <linux/ratelimit.h>
 #include <linux/rcupdate_wait.h>
 #include <linux/security.h>
 #include <linux/stop_machine.h>
@@ -963,6 +964,11 @@ struct rq {
 
 	atomic_t		nr_iowait;
 
+#ifdef CONFIG_SCHED_DEBUG
+	u64 last_seen_need_resched_ns;
+	int ticks_without_resched;
+#endif
+
 #ifdef CONFIG_MEMBARRIER
 	int membarrier_state;
 #endif
@@ -2366,6 +2372,8 @@ extern void print_dl_stats(struct seq_file *m, int cpu);
 extern void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq);
 extern void print_rt_rq(struct seq_file *m, int cpu, struct rt_rq *rt_rq);
 extern void print_dl_rq(struct seq_file *m, int cpu, struct dl_rq *dl_rq);
+
+extern void resched_latency_warn(int cpu, u64 latency);
 #ifdef CONFIG_NUMA_BALANCING
 extern void
 show_numa_stats(struct task_struct *p, struct seq_file *m);
@@ -2373,6 +2381,8 @@ extern void
 print_numa_stats(struct seq_file *m, int node, unsigned long tsf,
 	unsigned long tpf, unsigned long gsf, unsigned long gpf);
 #endif /* CONFIG_NUMA_BALANCING */
+#else
+static inline void resched_latency_warn(int cpu, u64 latency) {}
 #endif /* CONFIG_SCHED_DEBUG */
 
 extern void init_cfs_rq(struct cfs_rq *cfs_rq);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 62fbd09b5dc1..b784a1c98c5e 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -193,6 +193,7 @@ static int max_wakeup_granularity_ns = NSEC_PER_SEC;	/* 1 second */
 static int min_sched_tunable_scaling = SCHED_TUNABLESCALING_NONE;
 static int max_sched_tunable_scaling = SCHED_TUNABLESCALING_END-1;
 #endif /* CONFIG_SMP */
+static int min_resched_latency_warn_ms = 2;
 #endif /* CONFIG_SCHED_DEBUG */
 
 #ifdef CONFIG_COMPACTION
@@ -1763,6 +1764,29 @@ static struct ctl_table kern_table[] = {
 		.extra2		= SYSCTL_ONE,
 	},
 #endif /* CONFIG_NUMA_BALANCING */
+	{
+		.procname	= "resched_latency_warn_enabled",
+		.data		= &resched_latency_warn_enabled,
+		.mode		= 0644,
+		.proc_handler	= proc_do_static_key,
+	},
+	{
+		.procname	= "resched_latency_warn_ms",
+		.data		= &sysctl_resched_latency_warn_ms,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &min_resched_latency_warn_ms,
+	},
+	{
+		.procname	= "resched_latency_warn_once",
+		.data		= &sysctl_resched_latency_warn_once,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
 #endif /* CONFIG_SCHED_DEBUG */
 	{
 		.procname	= "sched_rt_period_us",
-- 
2.31.0.rc2.261.g7f71774620-goog

