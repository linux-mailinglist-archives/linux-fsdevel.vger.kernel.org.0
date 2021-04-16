Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72685362385
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 17:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245430AbhDPPHM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 11:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245035AbhDPPHK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 11:07:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B52C061574;
        Fri, 16 Apr 2021 08:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LNTP+tqteLOVl0P7a6EIZF+pGV+xBsbp2GZ7Ozcocnc=; b=J3eHdAjwAaSUHYsN4VTMi2FqzW
        ggj/fIYMMmyDQktxISUzuk+NLV67n7nAOs61q2jHENIupe5BeNrW0TFqJ3Aq0UlF1pyKhiT+PEYc2
        +0MMSidZqlGslWJYujs/SeiskbnirV06wWeTL96raqd3wDMLwOLkmSIbNw/KEJH6GE59/b6tMpMLh
        bdQ8bkNw+vvY6Vt3nXisKnR/BlilX1K9g3B2qlgr/zvhOfav4YH9nkXujTud1gIc3bax7PWklW3bo
        cloMyxUXtVl9zlzOzH20M7jbJggcqNMgEVTFbsJzj/hBxdsoClzuwmlem44lkOiz2iaoZPef8/Pgn
        5O6iDr3w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lXQ13-00A5yW-7J; Fri, 16 Apr 2021 15:04:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 487A2300222;
        Fri, 16 Apr 2021 17:04:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 095622C1AB5E3; Fri, 16 Apr 2021 17:04:15 +0200 (CEST)
Date:   Fri, 16 Apr 2021 17:04:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        David Rientjes <rientjes@google.com>,
        Oleg Rombakh <olegrom@google.com>, linux-doc@vger.kernel.org,
        Paul Turner <pjt@google.com>
Subject: Re: [PATCH v2] sched: Warn on long periods of pending need_resched
Message-ID: <YHmnbngrDGJkduFD@hirez.programming.kicks-ass.net>
References: <20210323035706.572953-1-joshdon@google.com>
 <20210324112739.GO15768@suse.de>
 <CABk29Nv7qwWcn4nUe_cxH-pJnppUVjHan+f-iHc8hEyPJ37jxA@mail.gmail.com>
 <CABk29NsQ21F3A6EPmCf+pJG7ojDFog9zD-ri8LO8OVW6sXeusQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29NsQ21F3A6EPmCf+pJG7ojDFog9zD-ri8LO8OVW6sXeusQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 30, 2021 at 03:44:12PM -0700, Josh Don wrote:
> Peter,
> 
> Since you've already pulled the need_resched warning patch into your
> tree, I'm including just the diff based on that patch (in response to
> Mel's comments) below. This should be squashed into the original
> patch.
> 

Sorry, I seem to have missed this. The patch is completely whitespace
mangled through.

I've attached my latest copy of the patch and held it back for now,
please resubmit.

---
Subject: sched: Warn on long periods of pending need_resched
From: Paul Turner <pjt@google.com>
Date: Mon, 22 Mar 2021 20:57:06 -0700

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210323035706.572953-1-joshdon@google.com
---

 include/linux/sched/sysctl.h |    3 +
 kernel/sched/core.c          |   75 ++++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/debug.c         |   13 +++++++
 kernel/sched/features.h      |    2 +
 kernel/sched/sched.h         |   10 +++++
 5 files changed, 102 insertions(+), 1 deletion(-)

--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -48,6 +48,9 @@ extern unsigned int sysctl_numa_balancin
 #ifdef CONFIG_SCHED_DEBUG
 extern __read_mostly unsigned int sysctl_sched_migration_cost;
 extern __read_mostly unsigned int sysctl_sched_nr_migrate;
+
+extern int sysctl_resched_latency_warn_ms;
+extern int sysctl_resched_latency_warn_once;
 #endif
 
 /*
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -58,7 +58,21 @@ const_debug unsigned int sysctl_sched_fe
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
+static const long resched_boot_quiet_sec = 600;
+#endif /* CONFIG_SCHED_DEBUG */
 
 /*
  * Number of tasks to iterate in a single balance run.
@@ -4527,6 +4541,56 @@ unsigned long long task_sched_runtime(st
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
 /*
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
@@ -4538,6 +4602,7 @@ void scheduler_tick(void)
 	struct task_struct *curr = rq->curr;
 	struct rq_flags rf;
 	unsigned long thermal_pressure;
+	u64 resched_latency;
 
 	arch_scale_freq_tick();
 	sched_clock_tick();
@@ -4548,10 +4613,15 @@ void scheduler_tick(void)
 	thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
 	update_thermal_load_avg(rq_clock_thermal(rq), rq, thermal_pressure);
 	curr->sched_class->task_tick(rq, curr, 0);
+	if (sched_feat(LATENCY_WARN))
+		resched_latency = resched_latency_check(rq);
 	calc_global_load_tick(rq);
 
 	rq_unlock(rq, &rf);
 
+	if (sched_feat(LATENCY_WARN) && resched_latency)
+		resched_latency_warn(cpu, resched_latency);
+
 	perf_event_task_tick();
 
 #ifdef CONFIG_SMP
@@ -5046,6 +5116,9 @@ static void __sched notrace __schedule(b
 	next = pick_next_task(rq, prev, &rf);
 	clear_tsk_need_resched(prev);
 	clear_preempt_need_resched();
+#ifdef CONFIG_SCHED_DEBUG
+	rq->last_seen_need_resched_ns = 0;
+#endif
 
 	if (likely(prev != next)) {
 		rq->nr_switches++;
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -297,6 +297,9 @@ static __init int sched_init_debug(void)
 	debugfs_create_u32("min_granularity_ns", 0644, debugfs_sched, &sysctl_sched_min_granularity);
 	debugfs_create_u32("wakeup_granularity_ns", 0644, debugfs_sched, &sysctl_sched_wakeup_granularity);
 
+	debugfs_create_u32("latency_warn_ms", 0644, debugfs_sched, &sysctl_resched_latency_warn_ms);
+	debugfs_create_u32("latency_warn_once", 0644, debugfs_sched, &sysctl_resched_latency_warn_once);
+
 #ifdef CONFIG_SMP
 	debugfs_create_file("tunable_scaling", 0644, debugfs_sched, NULL, &sched_scaling_fops);
 	debugfs_create_u32("migration_cost_ns", 0644, debugfs_sched, &sysctl_sched_migration_cost);
@@ -1027,3 +1030,13 @@ void proc_sched_set_task(struct task_str
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
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -91,5 +91,7 @@ SCHED_FEAT(WA_BIAS, true)
 SCHED_FEAT(UTIL_EST, true)
 SCHED_FEAT(UTIL_EST_FASTUP, true)
 
+SCHED_FEAT(LATENCY_WARN, false)
+
 SCHED_FEAT(ALT_PERIOD, true)
 SCHED_FEAT(BASE_SLICE, true)
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -58,6 +58,7 @@
 #include <linux/prefetch.h>
 #include <linux/profile.h>
 #include <linux/psi.h>
+#include <linux/ratelimit.h>
 #include <linux/rcupdate_wait.h>
 #include <linux/security.h>
 #include <linux/stop_machine.h>
@@ -971,6 +972,11 @@ struct rq {
 
 	atomic_t		nr_iowait;
 
+#ifdef CONFIG_SCHED_DEBUG
+	u64 last_seen_need_resched_ns;
+	int ticks_without_resched;
+#endif
+
 #ifdef CONFIG_MEMBARRIER
 	int membarrier_state;
 #endif
@@ -2362,6 +2368,8 @@ extern void print_dl_stats(struct seq_fi
 extern void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq);
 extern void print_rt_rq(struct seq_file *m, int cpu, struct rt_rq *rt_rq);
 extern void print_dl_rq(struct seq_file *m, int cpu, struct dl_rq *dl_rq);
+
+extern void resched_latency_warn(int cpu, u64 latency);
 #ifdef CONFIG_NUMA_BALANCING
 extern void
 show_numa_stats(struct task_struct *p, struct seq_file *m);
@@ -2369,6 +2377,8 @@ extern void
 print_numa_stats(struct seq_file *m, int node, unsigned long tsf,
 	unsigned long tpf, unsigned long gsf, unsigned long gpf);
 #endif /* CONFIG_NUMA_BALANCING */
+#else
+static inline void resched_latency_warn(int cpu, u64 latency) {}
 #endif /* CONFIG_SCHED_DEBUG */
 
 extern void init_cfs_rq(struct cfs_rq *cfs_rq);

