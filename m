Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E989B33E8AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 06:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhCQFAZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 01:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhCQFAY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 01:00:24 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B21C06174A
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Mar 2021 22:00:24 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v92so1174983ybi.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Mar 2021 22:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=uR46A4nqOYwwJGkb7CjOd8YvMztGe4D67fEr9Lx0aK4=;
        b=m15dh5m3XXgVhf5iWQarg86MSr3VNumGRieYIz4PfcfM8sNthpKwxA5HcN0Art4i5v
         /bHjfTAZ/ReKbPrZl1wGPgFDj18CL3ET2UtjPuA+eqHEl3uMIJV448Nv6p2y+mxv5Ft1
         d4Uxgm4KyT9ZWu89QAO69ESjmDMGlwNrgbhV0rwL+C6TClF9a8BRC5jWeCIpbPtLl64u
         jJvaJGaXy9/+68C8LLAmwq+P4q3OLbHgIKf8uyJAExOatoEP399TehNCpr3hBgP/X8v8
         N2+eYsMdUMeE9fOGiJKANZxdtWdLk4Y65UvhrQDqvPsmpoDoVGObMKxbszmNfNdRhp28
         yguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=uR46A4nqOYwwJGkb7CjOd8YvMztGe4D67fEr9Lx0aK4=;
        b=qNnW2DMw7D8hhHVkbgnDQUw+xxn+/0y6cuXkadZQh/Bbr+BF5t0UvVHiJy47WZ0c5u
         m/LYtuPTUmwrrgRGOUoF/3PbQaFoE6+439CWFR9MGJjUkEgaJzG1QFfs14Q1KsktNUxM
         7YyaYZpTzRMVVSCIT2C31zgym1F0vheCpYH6PF27ARYrGHZl0SaKYjWPJojKsxOS3gY5
         muDTaYZXU1qu50mRG1FbHuw8Btm2R9HJJ2VnVV0+TAF6FIHyGxarPHhQjONHTxqo/A/4
         wfLdf0Xe2vdVuZFFm2EIdnxYrmhBC83cL+qESmzFCVJg0OPwyHMGg1PU8Q6bp1G4d2Qj
         viRw==
X-Gm-Message-State: AOAM5309p3OMRrCAnRhZjemqdCh1i3Tzvy1cfmUL5tw0FadsRlVa4MXA
        8z8feCVNLMTcXW4ys8T+liX4MMZPxcFU
X-Google-Smtp-Source: ABdhPJyGFfX7YbliA3oIHPHF+6wCyNHCB+/qSrZ0IwLrluGITLldY+ClN8AbHwDGi4297g0SL7yWMTU3fhN7
X-Received: from joshdon.svl.corp.google.com ([2620:15c:2cd:202:d554:135a:678a:ce01])
 (user=joshdon job=sendgmr) by 2002:a25:dad4:: with SMTP id
 n203mr2720954ybf.233.1615957223214; Tue, 16 Mar 2021 22:00:23 -0700 (PDT)
Date:   Tue, 16 Mar 2021 21:59:49 -0700
Message-Id: <20210317045949.1584952-1-joshdon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH] sched: Warn on long periods of pending need_resched
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
        Oleg Rombakh <olegrom@google.com>,
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
time specified in sysctl resched_latency_warn_ms. Monitoring is done via
the tick and the accuracy is hence limited to jiffy scale. This also
means that we won't trigger the warning if the tick is disabled.

If resched_latency_warn_ms is set to the default value, only one warning
will be produced per boot.

This warning only exists under CONFIG_SCHED_DEBUG. If it goes off, it is
likely that there is a missing cond_resched() somewhere.

Signed-off-by: Paul Turner <pjt@google.com>
Signed-off-by: Josh Don <joshdon@google.com>
---
We've caught various bugs using this patch. In fact, a followup patch to
this one will be a patch introducing a missing cond_resched(). However,
this may be too noisy to have as default enabled (especially given that
it requires some tuning); I'm open to having this default disabled
instead.
 kernel/sched/core.c  | 91 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |  6 +++
 kernel/sysctl.c      |  8 ++++
 3 files changed, 105 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 98191218d891..ac037fc87d5e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -58,7 +58,25 @@ const_debug unsigned int sysctl_sched_features =
 #include "features.h"
 	0;
 #undef SCHED_FEAT
+
+/*
+ * Print a warning if need_resched is set for at least this long. At the
+ * default value, only a single warning will be printed per boot.
+ *
+ * Values less than 2 disable the feature.
+ *
+ * A kernel compiled with CONFIG_KASAN tends to run more slowly on average.
+ * Increase the need_resched timeout to reduce false alarms.
+ */
+#ifdef CONFIG_KASAN
+#define RESCHED_DEFAULT_WARN_LATENCY_MS 101
+#define RESCHED_BOOT_QUIET_SEC 600
+#else
+#define RESCHED_DEFAULT_WARN_LATENCY_MS 51
+#define RESCHED_BOOT_QUIET_SEC 300
 #endif
+int sysctl_resched_latency_warn_ms = RESCHED_DEFAULT_WARN_LATENCY_MS;
+#endif /* CONFIG_SCHED_DEBUG */
 
 /*
  * Number of tasks to iterate in a single balance run.
@@ -4520,6 +4538,71 @@ unsigned long long task_sched_runtime(struct task_struct *p)
 	return ns;
 }
 
+#ifdef CONFIG_SCHED_DEBUG
+
+static inline u64 resched_latency_check(struct rq *rq)
+{
+	int latency_warn_ms = READ_ONCE(sysctl_resched_latency_warn_ms);
+	bool warn_only_once = (latency_warn_ms == RESCHED_DEFAULT_WARN_LATENCY_MS);
+	u64 need_resched_latency, now = rq_clock(rq);
+	static bool warned_once;
+
+	if (warn_only_once && warned_once)
+		return 0;
+
+	if (!need_resched() || latency_warn_ms < 2)
+		return 0;
+
+	/* Disable this warning for the first few mins after boot */
+	if (now < RESCHED_BOOT_QUIET_SEC * NSEC_PER_SEC)
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
+static inline void resched_latency_warn(int cpu, u64 latency)
+{
+	static DEFINE_RATELIMIT_STATE(latency_check_ratelimit, 60 * 60 * HZ, 1);
+
+	WARN(__ratelimit(&latency_check_ratelimit),
+	     "CPU %d: need_resched set for > %llu ns (%d ticks) "
+	     "without schedule\n",
+	     cpu, latency, cpu_rq(cpu)->ticks_without_resched);
+}
+
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
+static inline void resched_latency_warn(int cpu, u64 latency) {}
+#endif /* CONFIG_SCHED_DEBUG */
+
+
 /*
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
@@ -4531,6 +4614,7 @@ void scheduler_tick(void)
 	struct task_struct *curr = rq->curr;
 	struct rq_flags rf;
 	unsigned long thermal_pressure;
+	u64 resched_latency;
 
 	arch_scale_freq_tick();
 	sched_clock_tick();
@@ -4541,11 +4625,15 @@ void scheduler_tick(void)
 	thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
 	update_thermal_load_avg(rq_clock_thermal(rq), rq, thermal_pressure);
 	curr->sched_class->task_tick(rq, curr, 0);
+	resched_latency = resched_latency_check(rq);
 	calc_global_load_tick(rq);
 	psi_task_tick(rq);
 
 	rq_unlock(rq, &rf);
 
+	if (resched_latency)
+		resched_latency_warn(cpu, resched_latency);
+
 	perf_event_task_tick();
 
 #ifdef CONFIG_SMP
@@ -5040,6 +5128,9 @@ static void __sched notrace __schedule(bool preempt)
 	next = pick_next_task(rq, prev, &rf);
 	clear_tsk_need_resched(prev);
 	clear_preempt_need_resched();
+#ifdef CONFIG_SCHED_DEBUG
+	rq->last_seen_need_resched_ns = 0;
+#endif
 
 	if (likely(prev != next)) {
 		rq->nr_switches++;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 10a1522b1e30..912a8886bc7f 100644
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
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 62fbd09b5dc1..526094fc364e 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -193,6 +193,7 @@ static int max_wakeup_granularity_ns = NSEC_PER_SEC;	/* 1 second */
 static int min_sched_tunable_scaling = SCHED_TUNABLESCALING_NONE;
 static int max_sched_tunable_scaling = SCHED_TUNABLESCALING_END-1;
 #endif /* CONFIG_SMP */
+extern int sysctl_resched_latency_warn_ms;
 #endif /* CONFIG_SCHED_DEBUG */
 
 #ifdef CONFIG_COMPACTION
@@ -1763,6 +1764,13 @@ static struct ctl_table kern_table[] = {
 		.extra2		= SYSCTL_ONE,
 	},
 #endif /* CONFIG_NUMA_BALANCING */
+	{
+		.procname	= "resched_latency_warn_ms",
+		.data		= &sysctl_resched_latency_warn_ms,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
 #endif /* CONFIG_SCHED_DEBUG */
 	{
 		.procname	= "sched_rt_period_us",
-- 
2.31.0.rc2.261.g7f71774620-goog

