Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEEC8230370
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 09:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgG1HDL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 03:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgG1HDK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 03:03:10 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64612C061794
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2020 00:03:10 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x184so23795384ybx.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2020 00:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=RwukbzwHj4drlw4xoaPVWXFzwM9UUnQT4yQlXd5TyvU=;
        b=Kz+VTRuigeNusceUsnw0VS/2KW2FTZwCT6S6RU5w4w20iKl7NaWmBCsxOa/ftpyQLE
         rf2dKKIzO/D4dCUlIwV/ihTeQNdkX2plx6zKsulYEChbt3fu9+hxh/TyVUDq6xYJHdOW
         8Yi7Os2Yrjpp/rtUBYH7i2Bzc8LGycro8rREfcTi/IxEY7Epmw0EW8hW1owvvmaQIRsr
         fA/5HiL3O+UzXBGI2oY/B7AIRseaqm7xsvhP5GfHGGgts4O0wmSUqFM7qvsjpWBO8Udv
         2js18sOyIbT3PSLdAONCPLBAE2PYoh13OKgOPZVDZd20iImBdaA5N5n1XsW6R5yW7Pt5
         ln3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=RwukbzwHj4drlw4xoaPVWXFzwM9UUnQT4yQlXd5TyvU=;
        b=nhwIYLU1C0iAu21HtqLgNt6oszIGa5uFduckLMqQU4RyR3kxpcj+LX1reXs+CL+mu1
         srCY+sd5R3r3YiHz3H7QocTzyzv8/5+uFK9fOsLWNFbHRyIua7xuuPNFn4WSVgFnHcFe
         6+xLNo6Tjplarwfp6CQuCvDamTaVILb6QxzCarkqitXAkoRlkliit4kOhZd3wfSFkQ8E
         x9IrrBQYPUSGSXu1wL9a5D/tVPneuMXUPNKJCDa46Mp8avtSkicMyHR/rSjZgaaS2pwE
         Z7GS9o68s6hjUA0GN+yF2KGruAcZOogvzpUXpbxh3YDQVCTqKl8NXwetR+nZ5kaPeVx3
         S8Ig==
X-Gm-Message-State: AOAM530mRTpJYBEQNNPiKXkkuix3cEJIb2mL/F5nFWBwd2RaROT+LBJT
        q8jWIZxPMtwR6YKz2isSxFNFkjQ=
X-Google-Smtp-Source: ABdhPJz9DyOaldqjA6zJV1nkg8qnAdLXCd0QKrNVF8DKwOiHhsZUy7+0ON2WwFz6cmrpoyj93B46OZE=
X-Received: by 2002:a25:8087:: with SMTP id n7mr41138721ybk.439.1595919787637;
 Tue, 28 Jul 2020 00:03:07 -0700 (PDT)
Date:   Tue, 28 Jul 2020 00:01:31 -0700
Message-Id: <20200728070131.1629670-1-xii@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH] sched: Make select_idle_sibling search domain configurable
From:   Xi Wang <xii@google.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Xi Wang <xii@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The scope of select_idle_sibling idle cpu search is LLC. This
becomes a problem for the AMD CCX architecture, as the sd_llc is only
4 cores. On a many core machine, the range of search is too small to
reach a satisfactory level of statistical multiplexing / efficient
utilization of short idle time slices.

With this patch idle sibling search is detached from LLC and it
becomes run time configurable. To reduce search and migration
overheads, a presearch domain is added. The presearch domain will be
searched first before the "main search" domain, e.g.:

sysctl_sched_wake_idle_domain == 2 ("MC" domain)
sysctl_sched_wake_idle_presearch_domain == 1 ("DIE" domain)

Presearch will go through 4 cores of a CCX. If no idle cpu is found
during presearch, full search will go through the remaining cores of
a cpu socket.

Heuristics including sd->avg_scan_cost and sds->have_idle_cores
are only active for the main search.

On a 128 core (2 socket * 64 core, 256 hw threads) AMD machine ran
hackbench as

hackbench -g 20 -f 20 --loops 10000

A snapshot of run time was

Baseline: 11.8
With the patch: 7.6    (configured as in the example above)

Signed-off-by: Xi Wang <xii@google.com>
---
 block/blk-mq.c                 |   2 +-
 block/blk-softirq.c            |   2 +-
 include/linux/cpuset.h         |  10 +-
 include/linux/sched/topology.h |  11 +-
 kernel/cgroup/cpuset.c         |  32 ++++--
 kernel/sched/core.c            |  10 +-
 kernel/sched/fair.c            | 191 +++++++++++++++++++++------------
 kernel/sched/sched.h           |   9 +-
 kernel/sched/topology.c        |  87 ++++++++++-----
 kernel/sysctl.c                |  25 +++++
 10 files changed, 256 insertions(+), 123 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4e0d173beaa3..20aee9f047e2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -626,7 +626,7 @@ void blk_mq_force_complete_rq(struct request *rq)
 
 	cpu = get_cpu();
 	if (!test_bit(QUEUE_FLAG_SAME_FORCE, &q->queue_flags))
-		shared = cpus_share_cache(cpu, ctx->cpu);
+		shared = cpus_share_sis(cpu, ctx->cpu);
 
 	if (cpu != ctx->cpu && !shared && cpu_online(ctx->cpu)) {
 		rq->csd.func = __blk_mq_complete_request_remote;
diff --git a/block/blk-softirq.c b/block/blk-softirq.c
index 6e7ec87d49fa..dd38ac0e1f2e 100644
--- a/block/blk-softirq.c
+++ b/block/blk-softirq.c
@@ -108,7 +108,7 @@ void __blk_complete_request(struct request *req)
 	 */
 	if (test_bit(QUEUE_FLAG_SAME_COMP, &q->queue_flags) && ccpu != -1) {
 		if (!test_bit(QUEUE_FLAG_SAME_FORCE, &q->queue_flags))
-			shared = cpus_share_cache(cpu, ccpu);
+			shared = cpus_share_sis(cpu, ccpu);
 	} else
 		ccpu = cpu;
 
diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 04c20de66afc..8b243aa8462e 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -117,6 +117,7 @@ static inline int cpuset_do_slab_mem_spread(void)
 extern bool current_cpuset_is_being_rebound(void);
 
 extern void rebuild_sched_domains(void);
+extern void rebuild_sched_domains_force(void);
 
 extern void cpuset_print_current_mems_allowed(void);
 
@@ -173,7 +174,7 @@ static inline void cpuset_force_rebuild(void) { }
 
 static inline void cpuset_update_active_cpus(void)
 {
-	partition_sched_domains(1, NULL, NULL);
+	partition_sched_domains(1, NULL, NULL, 0);
 }
 
 static inline void cpuset_wait_for_hotplug(void) { }
@@ -259,7 +260,12 @@ static inline bool current_cpuset_is_being_rebound(void)
 
 static inline void rebuild_sched_domains(void)
 {
-	partition_sched_domains(1, NULL, NULL);
+	partition_sched_domains(1, NULL, NULL, 0);
+}
+
+static inline void rebuild_sched_domains_force(void)
+{
+	partition_sched_domains(1, NULL, NULL, 1);
 }
 
 static inline void cpuset_print_current_mems_allowed(void)
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index fb11091129b3..aff9739cf516 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -151,16 +151,17 @@ static inline struct cpumask *sched_domain_span(struct sched_domain *sd)
 
 extern void partition_sched_domains_locked(int ndoms_new,
 					   cpumask_var_t doms_new[],
-					   struct sched_domain_attr *dattr_new);
+					   struct sched_domain_attr *dattr_new,
+					   int force_update);
 
 extern void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
-				    struct sched_domain_attr *dattr_new);
+				    struct sched_domain_attr *dattr_new, int force_update);
 
 /* Allocate an array of sched domains, for partition_sched_domains(). */
 cpumask_var_t *alloc_sched_domains(unsigned int ndoms);
 void free_sched_domains(cpumask_var_t doms[], unsigned int ndoms);
 
-bool cpus_share_cache(int this_cpu, int that_cpu);
+bool cpus_share_sis(int this_cpu, int that_cpu);
 
 typedef const struct cpumask *(*sched_domain_mask_f)(int cpu);
 typedef int (*sched_domain_flags_f)(void);
@@ -199,7 +200,7 @@ struct sched_domain_attr;
 
 static inline void
 partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
-			       struct sched_domain_attr *dattr_new)
+			       struct sched_domain_attr *dattr_new, int force_update)
 {
 }
 
@@ -209,7 +210,7 @@ partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 {
 }
 
-static inline bool cpus_share_cache(int this_cpu, int that_cpu)
+static inline bool cpus_share_sis(int this_cpu, int that_cpu)
 {
 	return true;
 }
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 642415b8c3c9..5087b90c4c47 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -962,10 +962,10 @@ static void rebuild_root_domains(void)
 
 static void
 partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
-				    struct sched_domain_attr *dattr_new)
+				    struct sched_domain_attr *dattr_new, int force_update)
 {
 	mutex_lock(&sched_domains_mutex);
-	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
+	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new, force_update);
 	rebuild_root_domains();
 	mutex_unlock(&sched_domains_mutex);
 }
@@ -981,7 +981,7 @@ partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
  *
  * Call with cpuset_mutex held.  Takes get_online_cpus().
  */
-static void rebuild_sched_domains_locked(void)
+static void rebuild_sched_domains_locked(int force_update)
 {
 	struct sched_domain_attr *attr;
 	cpumask_var_t *doms;
@@ -1007,23 +1007,33 @@ static void rebuild_sched_domains_locked(void)
 	ndoms = generate_sched_domains(&doms, &attr);
 
 	/* Have scheduler rebuild the domains */
-	partition_and_rebuild_sched_domains(ndoms, doms, attr);
+	partition_and_rebuild_sched_domains(ndoms, doms, attr, force_update);
 }
 #else /* !CONFIG_SMP */
-static void rebuild_sched_domains_locked(void)
+static void rebuild_sched_domains_locked(int force_update)
 {
 }
 #endif /* CONFIG_SMP */
 
-void rebuild_sched_domains(void)
+void __rebuild_sched_domains(int force_update)
 {
 	get_online_cpus();
 	percpu_down_write(&cpuset_rwsem);
-	rebuild_sched_domains_locked();
+	rebuild_sched_domains_locked(force_update);
 	percpu_up_write(&cpuset_rwsem);
 	put_online_cpus();
 }
 
+void rebuild_sched_domains(void)
+{
+	__rebuild_sched_domains(0);
+}
+
+void rebuild_sched_domains_force(void)
+{
+	__rebuild_sched_domains(1);
+}
+
 /**
  * update_tasks_cpumask - Update the cpumasks of tasks in the cpuset.
  * @cs: the cpuset in which each task's cpus_allowed mask needs to be changed
@@ -1437,7 +1447,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 	rcu_read_unlock();
 
 	if (need_rebuild_sched_domains)
-		rebuild_sched_domains_locked();
+		rebuild_sched_domains_locked(0);
 }
 
 /**
@@ -1837,7 +1847,7 @@ static int update_relax_domain_level(struct cpuset *cs, s64 val)
 		cs->relax_domain_level = val;
 		if (!cpumask_empty(cs->cpus_allowed) &&
 		    is_sched_load_balance(cs))
-			rebuild_sched_domains_locked();
+			rebuild_sched_domains_locked(0);
 	}
 
 	return 0;
@@ -1903,7 +1913,7 @@ static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
 	spin_unlock_irq(&callback_lock);
 
 	if (!cpumask_empty(trialcs->cpus_allowed) && balance_flag_changed)
-		rebuild_sched_domains_locked();
+		rebuild_sched_domains_locked(0);
 
 	if (spread_flag_changed)
 		update_tasks_flags(cs);
@@ -1994,7 +2004,7 @@ static int update_prstate(struct cpuset *cs, int val)
 	if (parent->child_ecpus_count)
 		update_sibling_cpumasks(parent, cs, &tmp);
 
-	rebuild_sched_domains_locked();
+	rebuild_sched_domains_locked(0);
 out:
 	free_cpumasks(NULL, &tmp);
 	return err;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e15543cb8481..e28548fc63f0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2350,9 +2350,9 @@ void wake_up_if_idle(int cpu)
 	rcu_read_unlock();
 }
 
-bool cpus_share_cache(int this_cpu, int that_cpu)
+bool cpus_share_sis(int this_cpu, int that_cpu)
 {
-	return per_cpu(sd_llc_id, this_cpu) == per_cpu(sd_llc_id, that_cpu);
+	return per_cpu(sd_sis_id, this_cpu) == per_cpu(sd_sis_id, that_cpu);
 }
 
 static inline bool ttwu_queue_cond(int cpu, int wake_flags)
@@ -2361,7 +2361,7 @@ static inline bool ttwu_queue_cond(int cpu, int wake_flags)
 	 * If the CPU does not share cache, then queue the task on the
 	 * remote rqs wakelist to avoid accessing remote data.
 	 */
-	if (!cpus_share_cache(smp_processor_id(), cpu))
+	if (!cpus_share_sis(smp_processor_id(), cpu))
 		return true;
 
 	/*
@@ -6501,7 +6501,7 @@ static void cpuset_cpu_active(void)
 		 * operation in the resume sequence, just build a single sched
 		 * domain, ignoring cpusets.
 		 */
-		partition_sched_domains(1, NULL, NULL);
+		partition_sched_domains(1, NULL, NULL, 0);
 		if (--num_cpus_frozen)
 			return;
 		/*
@@ -6522,7 +6522,7 @@ static int cpuset_cpu_inactive(unsigned int cpu)
 		cpuset_update_active_cpus();
 	} else {
 		num_cpus_frozen++;
-		partition_sched_domains(1, NULL, NULL);
+		partition_sched_domains(1, NULL, NULL, 0);
 	}
 	return 0;
 }
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 04fa8dbcfa4d..0ed71f2f3a81 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5736,8 +5736,8 @@ static void record_wakee(struct task_struct *p)
  * at a frequency roughly N times higher than one of its wakees.
  *
  * In order to determine whether we should let the load spread vs consolidating
- * to shared cache, we look for a minimum 'flip' frequency of llc_size in one
- * partner, and a factor of lls_size higher frequency in the other.
+ * sis domain, we look for a minimum 'flip' frequency of sis_size in one partner,
+ * and a factor of sis_size higher frequency in the other.
  *
  * With both conditions met, we can be relatively sure that the relationship is
  * non-monogamous, with partner count exceeding socket size.
@@ -5750,7 +5750,7 @@ static int wake_wide(struct task_struct *p)
 {
 	unsigned int master = current->wakee_flips;
 	unsigned int slave = p->wakee_flips;
-	int factor = __this_cpu_read(sd_llc_size);
+	int factor = __this_cpu_read(sd_sis_size);
 
 	if (master < slave)
 		swap(master, slave);
@@ -5786,7 +5786,7 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
 	 * a cpufreq perspective, it's better to have higher utilisation
 	 * on one CPU.
 	 */
-	if (available_idle_cpu(this_cpu) && cpus_share_cache(this_cpu, prev_cpu))
+	if (available_idle_cpu(this_cpu) && cpus_share_sis(this_cpu, prev_cpu))
 		return available_idle_cpu(prev_cpu) ? prev_cpu : this_cpu;
 
 	if (sync && cpu_rq(this_cpu)->nr_running == 1)
@@ -5978,7 +5978,7 @@ static inline void set_idle_cores(int cpu, int val)
 {
 	struct sched_domain_shared *sds;
 
-	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
+	sds = rcu_dereference(per_cpu(sd_sis_shared, cpu));
 	if (sds)
 		WRITE_ONCE(sds->has_idle_cores, val);
 }
@@ -5987,7 +5987,7 @@ static inline bool test_idle_cores(int cpu, bool def)
 {
 	struct sched_domain_shared *sds;
 
-	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
+	sds = rcu_dereference(per_cpu(sd_sis_shared, cpu));
 	if (sds)
 		return READ_ONCE(sds->has_idle_cores);
 
@@ -5996,7 +5996,7 @@ static inline bool test_idle_cores(int cpu, bool def)
 
 /*
  * Scans the local SMT mask to see if the entire core is idle, and records this
- * information in sd_llc_shared->has_idle_cores.
+ * information in sd_sis_shared->has_idle_cores.
  *
  * Since SMT siblings share all cache levels, inspecting this limited remote
  * state should be fairly cheap.
@@ -6024,13 +6024,12 @@ void __update_idle_core(struct rq *rq)
 }
 
 /*
- * Scan the entire LLC domain for idle cores; this dynamically switches off if
+ * Scan the entire sis domain for idle cores; this dynamically switches off if
  * there are no idle cores left in the system; tracked through
- * sd_llc->shared->has_idle_cores and enabled through update_idle_core() above.
+ * sd_sis->shared->has_idle_cores and enabled through update_idle_core() above.
  */
-static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int target)
+static int select_idle_core(struct task_struct *p, struct cpumask *cpus, int target)
 {
-	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
 	int core, cpu;
 
 	if (!static_branch_likely(&sched_smt_present))
@@ -6039,18 +6038,18 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
 	if (!test_idle_cores(target, false))
 		return -1;
 
-	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
-
 	for_each_cpu_wrap(core, cpus, target) {
 		bool idle = true;
 
+		if (core != cpumask_first(cpu_smt_mask(core)))
+			continue;
+
 		for_each_cpu(cpu, cpu_smt_mask(core)) {
 			if (!available_idle_cpu(cpu)) {
 				idle = false;
 				break;
 			}
 		}
-		cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
 
 		if (idle)
 			return core;
@@ -6099,45 +6098,45 @@ static inline int select_idle_smt(struct task_struct *p, int target)
 #endif /* CONFIG_SCHED_SMT */
 
 /*
- * Scan the LLC domain for idle CPUs; this is dynamically regulated by
+ * Scan the sis domain for idle CPUs; this is dynamically regulated by
  * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
  * average idle time for this rq (as found in rq->avg_idle).
  */
-static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int target)
+static int select_idle_cpu(struct task_struct *p, struct cpumask *cpus,
+	bool main_search, unsigned int span_weight, int target)
 {
-	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
 	struct sched_domain *this_sd;
 	u64 avg_cost, avg_idle;
 	u64 time;
 	int this = smp_processor_id();
 	int cpu, nr = INT_MAX;
 
-	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
-	if (!this_sd)
-		return -1;
+	if (main_search) {
+		this_sd = rcu_dereference(*this_cpu_ptr(&sd_sis));
+		if (!this_sd)
+			return -1;
 
-	/*
-	 * Due to large variance we need a large fuzz factor; hackbench in
-	 * particularly is sensitive here.
-	 */
-	avg_idle = this_rq()->avg_idle / 512;
-	avg_cost = this_sd->avg_scan_cost + 1;
+		/*
+		 * Due to large variance we need a large fuzz factor; hackbench in
+		 * particularly is sensitive here.
+		 */
+		avg_idle = this_rq()->avg_idle / 512;
+		avg_cost = this_sd->avg_scan_cost + 1;
 
-	if (sched_feat(SIS_AVG_CPU) && avg_idle < avg_cost)
-		return -1;
+		if (sched_feat(SIS_AVG_CPU) && avg_idle < avg_cost)
+			return -1;
 
-	if (sched_feat(SIS_PROP)) {
-		u64 span_avg = sd->span_weight * avg_idle;
-		if (span_avg > 4*avg_cost)
-			nr = div_u64(span_avg, avg_cost);
-		else
-			nr = 4;
+		if (sched_feat(SIS_PROP)) {
+			u64 span_avg = span_weight * avg_idle;
+			if (span_avg > 4*avg_cost)
+				nr = div_u64(span_avg, avg_cost);
+			else
+				nr = 4;
+		}
 	}
 
 	time = cpu_clock(this);
 
-	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
-
 	for_each_cpu_wrap(cpu, cpus, target) {
 		if (!--nr)
 			return -1;
@@ -6145,8 +6144,10 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 			break;
 	}
 
-	time = cpu_clock(this) - time;
-	update_avg(&this_sd->avg_scan_cost, time);
+	if (main_search) {
+		time = cpu_clock(this) - time;
+		update_avg(&this_sd->avg_scan_cost, time);
+	}
 
 	return cpu;
 }
@@ -6186,19 +6187,21 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 }
 
 /*
- * Try and locate an idle core/thread in the LLC cache domain.
+ * Try and locate an idle core/thread in the sis domain.
  */
 static int select_idle_sibling(struct task_struct *p, int prev, int target)
 {
-	struct sched_domain *sd;
-	int i, recent_used_cpu;
+	struct sched_domain *sd_asym;
+	struct sched_domain *sd[2];
+	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
+	int i, r, recent_used_cpu;
 
 	/*
 	 * For asymmetric CPU capacity systems, our domain of interest is
-	 * sd_asym_cpucapacity rather than sd_llc.
+	 * sd_asym_cpucapacity rather than sd_sis.
 	 */
 	if (static_branch_unlikely(&sched_asym_cpucapacity)) {
-		sd = rcu_dereference(per_cpu(sd_asym_cpucapacity, target));
+		sd_asym = rcu_dereference(per_cpu(sd_asym_cpucapacity, target));
 		/*
 		 * On an asymmetric CPU capacity system where an exclusive
 		 * cpuset defines a symmetric island (i.e. one unique
@@ -6207,10 +6210,10 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 		 * SD_ASYM_CPUCAPACITY. These should follow the usual symmetric
 		 * capacity path.
 		 */
-		if (!sd)
+		if (!sd_asym)
 			goto symmetric;
 
-		i = select_idle_capacity(p, sd, target);
+		i = select_idle_capacity(p, sd_asym, target);
 		return ((unsigned)i < nr_cpumask_bits) ? i : target;
 	}
 
@@ -6221,7 +6224,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	/*
 	 * If the previous CPU is cache affine and idle, don't be stupid:
 	 */
-	if (prev != target && cpus_share_cache(prev, target) &&
+	if (prev != target && cpus_share_sis(prev, target) &&
 	    (available_idle_cpu(prev) || sched_idle_cpu(prev)))
 		return prev;
 
@@ -6243,7 +6246,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	recent_used_cpu = p->recent_used_cpu;
 	if (recent_used_cpu != prev &&
 	    recent_used_cpu != target &&
-	    cpus_share_cache(recent_used_cpu, target) &&
+	    cpus_share_sis(recent_used_cpu, target) &&
 	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
 	    cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr)) {
 		/*
@@ -6254,21 +6257,35 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 		return recent_used_cpu;
 	}
 
-	sd = rcu_dereference(per_cpu(sd_llc, target));
-	if (!sd)
-		return target;
+	for (i = 0; ; i++) {
+		if (i == 0) {
+			sd[0] = rcu_dereference(per_cpu(sd_sis_pre, target));
+			if (!sd[0])
+				continue;
+			cpumask_and(cpus, sched_domain_span(sd[0]), p->cpus_ptr);
+		} else if (i == 1) {
+			sd[1] = rcu_dereference(per_cpu(sd_sis, target));
+			if (!sd[1])
+				continue;
+			cpumask_and(cpus, sched_domain_span(sd[1]), p->cpus_ptr);
+			if (sd[0])
+				cpumask_andnot(cpus, cpus, sched_domain_span(sd[0]));
+		} else {
+			break;
+		}
 
-	i = select_idle_core(p, sd, target);
-	if ((unsigned)i < nr_cpumask_bits)
-		return i;
+		r = select_idle_core(p, cpus, target);
+		if ((unsigned)r < nr_cpumask_bits)
+			return r;
 
-	i = select_idle_cpu(p, sd, target);
-	if ((unsigned)i < nr_cpumask_bits)
-		return i;
+		r = select_idle_cpu(p, cpus, (i == 1), sd[i]->span_weight, target);
+		if ((unsigned)r < nr_cpumask_bits)
+			return r;
 
-	i = select_idle_smt(p, target);
-	if ((unsigned)i < nr_cpumask_bits)
-		return i;
+		r = select_idle_smt(p, target);
+		if ((unsigned)r < nr_cpumask_bits)
+			return r;
+	}
 
 	return target;
 }
@@ -6718,6 +6735,46 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 	return new_cpu;
 }
 
+
+#ifdef CONFIG_SMP
+
+extern int sysctl_sched_wake_idle_domain;
+extern int sysctl_sched_wake_idle_presearch_domain;
+
+DEFINE_MUTEX(wake_idle_domain_mutex);
+
+int proc_sched_wake_idle_domain_handler(struct ctl_table *table,
+		int write, void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct ctl_table tmp = *table;
+	int *sysctl = tmp.data;
+	int val = *sysctl;
+	int min = -1, max = INT_MAX;
+	int rc;
+
+	tmp.extra1 = &min;
+	tmp.extra2 = &max;
+	tmp.data = &val;
+
+	rc = proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
+
+	if (rc || !write)
+		return rc;
+
+	mutex_lock(&wake_idle_domain_mutex);
+	*sysctl = val;
+	rebuild_sched_domains_force();
+	mutex_unlock(&wake_idle_domain_mutex);
+
+	pr_info("Idle cpu search (select_idle_sibling) domains changed to: "
+	  "sched_wake_idle_domain %d sched_wake_idle_presearch domain %d\n",
+	  sysctl_sched_wake_idle_domain, sysctl_sched_wake_idle_presearch_domain);
+
+	return 0;
+}
+
+#endif
+
 static void detach_entity_cfs_rq(struct sched_entity *se);
 
 /*
@@ -10136,21 +10193,21 @@ static void nohz_balancer_kick(struct rq *rq)
 		 * cache use, instead we want to embrace asymmetry and only
 		 * ensure tasks have enough CPU capacity.
 		 *
-		 * Skip the LLC logic because it's not relevant in that case.
+		 * Skip the sis logic because it's not relevant in that case.
 		 */
 		goto unlock;
 	}
 
-	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
+	sds = rcu_dereference(per_cpu(sd_sis_shared, cpu));
 	if (sds) {
 		/*
-		 * If there is an imbalance between LLC domains (IOW we could
-		 * increase the overall cache use), we need some less-loaded LLC
+		 * If there is an imbalance between sis domains (IOW we could
+		 * increase the overall cache use), we need some less-loaded sis
 		 * domain to pull some load. Likewise, we may need to spread
-		 * load within the current LLC domain (e.g. packed SMT cores but
+		 * load within the current sis domain (e.g. packed SMT cores but
 		 * other CPUs are idle). We can't really know from here how busy
 		 * the others are - so just get a nohz balance going if it looks
-		 * like this LLC domain has tasks we could move.
+		 * like this sis domain has tasks we could move.
 		 */
 		nr_busy = atomic_read(&sds->nr_busy_cpus);
 		if (nr_busy > 1) {
@@ -10170,7 +10227,7 @@ static void set_cpu_sd_state_busy(int cpu)
 	struct sched_domain *sd;
 
 	rcu_read_lock();
-	sd = rcu_dereference(per_cpu(sd_llc, cpu));
+	sd = rcu_dereference(per_cpu(sd_sis, cpu));
 
 	if (!sd || !sd->nohz_idle)
 		goto unlock;
@@ -10200,7 +10257,7 @@ static void set_cpu_sd_state_idle(int cpu)
 	struct sched_domain *sd;
 
 	rcu_read_lock();
-	sd = rcu_dereference(per_cpu(sd_llc, cpu));
+	sd = rcu_dereference(per_cpu(sd_sis, cpu));
 
 	if (!sd || sd->nohz_idle)
 		goto unlock;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 877fb08eb1b0..641a5bacdf77 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1415,10 +1415,11 @@ static inline struct sched_domain *lowest_flag_domain(int cpu, int flag)
 	return sd;
 }
 
-DECLARE_PER_CPU(struct sched_domain __rcu *, sd_llc);
-DECLARE_PER_CPU(int, sd_llc_size);
-DECLARE_PER_CPU(int, sd_llc_id);
-DECLARE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
+DECLARE_PER_CPU(struct sched_domain __rcu *, sd_sis);
+DECLARE_PER_CPU(int, sd_sis_size);
+DECLARE_PER_CPU(int, sd_sis_id);
+DECLARE_PER_CPU(struct sched_domain_shared __rcu *, sd_sis_shared);
+DECLARE_PER_CPU(struct sched_domain *, sd_sis_pre);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index ba81187bb7af..bdda783c5148 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -605,41 +605,75 @@ static void destroy_sched_domains(struct sched_domain *sd)
 }
 
 /*
- * Keep a special pointer to the highest sched_domain that has
- * SD_SHARE_PKG_RESOURCE set (Last Level Cache Domain) for this
- * allows us to avoid some pointer chasing select_idle_sibling().
- *
- * Also keep a unique ID per domain (we use the first CPU number in
- * the cpumask of the domain), this allows us to quickly tell if
- * two CPUs are in the same cache domain, see cpus_share_cache().
+ * sd_sis is the select_idle_sibling search domain. It is generalized sd_llc
+ * not limited by the SD_SHARE_PKG_RESOURCE flag. With the sysctls sd_sis is
+ * also run time configurable.
+ * To limit overheads from searching / migrating among cores that don't share
+ * llc, a presearch domain can be enabled such that most searches / migrations
+ * still happen inside a smaller domain when the machine is lightly loaded.
+ *
+ * Keep a special pointer for this allows us to avoid some pointer chasing in
+ * select_idle_sibling(). Also keep a unique ID per domain (we use the first CPU
+ * number in the cpumask of the domain), this allows us to quickly tell if
+ * two CPUs are in the same sis domain, see cpus_share_sis().
  */
-DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
-DEFINE_PER_CPU(int, sd_llc_size);
-DEFINE_PER_CPU(int, sd_llc_id);
-DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
+DEFINE_PER_CPU(struct sched_domain __rcu *, sd_sis);
+DEFINE_PER_CPU(int, sd_sis_size);
+DEFINE_PER_CPU(int, sd_sis_id);
+DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_sis_shared);
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
 DEFINE_STATIC_KEY_FALSE(sched_asym_cpucapacity);
 
+int sysctl_sched_wake_idle_domain = -1;
+int sysctl_sched_wake_idle_presearch_domain = -1;
+DEFINE_PER_CPU(struct sched_domain *, sd_sis_pre);
+
 static void update_top_cache_domain(int cpu)
 {
 	struct sched_domain_shared *sds = NULL;
-	struct sched_domain *sd;
+	struct sched_domain *sd, *sdp;
 	int id = cpu;
 	int size = 1;
+	int level;
+
+	if (sysctl_sched_wake_idle_domain < 0) {
+		sd = highest_flag_domain(cpu, SD_SHARE_PKG_RESOURCES);
+	} else {
+		level = 0;
+		for_each_domain(cpu, sd) {
+			if (level == sysctl_sched_wake_idle_domain)
+				break;
+			level++;
+		}
+	}
 
-	sd = highest_flag_domain(cpu, SD_SHARE_PKG_RESOURCES);
 	if (sd) {
 		id = cpumask_first(sched_domain_span(sd));
 		size = cpumask_weight(sched_domain_span(sd));
 		sds = sd->shared;
 	}
 
-	rcu_assign_pointer(per_cpu(sd_llc, cpu), sd);
-	per_cpu(sd_llc_size, cpu) = size;
-	per_cpu(sd_llc_id, cpu) = id;
-	rcu_assign_pointer(per_cpu(sd_llc_shared, cpu), sds);
+	rcu_assign_pointer(per_cpu(sd_sis, cpu), sd);
+	per_cpu(sd_sis_size, cpu) = size;
+	per_cpu(sd_sis_id, cpu) = id;
+	rcu_assign_pointer(per_cpu(sd_sis_shared, cpu), sds);
+
+	sdp = NULL;
+	if (sd && sysctl_sched_wake_idle_presearch_domain >= 0) {
+		level = 0;
+		for_each_domain(cpu, sdp) {
+			if (sdp == sd) {
+				sdp = NULL;
+				break;
+			}
+			if (level == sysctl_sched_wake_idle_presearch_domain)
+				break;
+			level++;
+		}
+	}
+	rcu_assign_pointer(per_cpu(sd_sis_pre, cpu), sdp);
 
 	sd = lowest_flag_domain(cpu, SD_NUMA);
 	rcu_assign_pointer(per_cpu(sd_numa, cpu), sd);
@@ -1400,14 +1434,12 @@ sd_init(struct sched_domain_topology_level *tl,
 	}
 
 	/*
-	 * For all levels sharing cache; connect a sched_domain_shared
-	 * instance.
+	 * Connect sched_domain_shared instances. As sd_sis can be changed at run
+	 * time, link all domains.
 	 */
-	if (sd->flags & SD_SHARE_PKG_RESOURCES) {
-		sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
-		atomic_inc(&sd->shared->ref);
-		atomic_set(&sd->shared->nr_busy_cpus, sd_weight);
-	}
+	sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
+	atomic_inc(&sd->shared->ref);
+	atomic_set(&sd->shared->nr_busy_cpus, sd_weight);
 
 	sd->private = sdd;
 
@@ -2204,7 +2236,7 @@ static int dattrs_equal(struct sched_domain_attr *cur, int idx_cur,
  * Call with hotplug lock and sched_domains_mutex held
  */
 void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
-				    struct sched_domain_attr *dattr_new)
+				    struct sched_domain_attr *dattr_new, int force_update)
 {
 	bool __maybe_unused has_eas = false;
 	int i, j, n;
@@ -2217,6 +2249,7 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
 
 	/* Let the architecture update CPU core mappings: */
 	new_topology = arch_update_cpu_topology();
+	new_topology |= force_update;
 
 	if (!doms_new) {
 		WARN_ON_ONCE(dattr_new);
@@ -2310,9 +2343,9 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
  * Call with hotplug lock held
  */
 void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
-			     struct sched_domain_attr *dattr_new)
+			     struct sched_domain_attr *dattr_new, int force_update)
 {
 	mutex_lock(&sched_domains_mutex);
-	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
+	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new, 0);
 	mutex_unlock(&sched_domains_mutex);
 }
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index db1ce7af2563..b474851e1a66 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -144,6 +144,10 @@ static const int cap_last_cap = CAP_LAST_CAP;
 #ifdef CONFIG_DETECT_HUNG_TASK
 static unsigned long hung_task_timeout_max = (LONG_MAX/HZ);
 #endif
+#ifdef CONFIG_SMP
+extern int sysctl_sched_wake_idle_domain;
+extern int sysctl_sched_wake_idle_presearch_domain;
+#endif
 
 #ifdef CONFIG_INOTIFY_USER
 #include <linux/inotify.h>
@@ -202,6 +206,11 @@ static int max_extfrag_threshold = 1000;
 
 #endif /* CONFIG_SYSCTL */
 
+#ifdef CONFIG_SMP
+int proc_sched_wake_idle_domain_handler(struct ctl_table *table,
+		int write, void __user *buffer, size_t *lenp, loff_t *ppos);
+#endif
+
 #if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_SYSCTL)
 static int bpf_stats_handler(struct ctl_table *table, int write,
 			     void __user *buffer, size_t *lenp,
@@ -1834,6 +1843,22 @@ static struct ctl_table kern_table[] = {
 		.extra2		= SYSCTL_ONE,
 	},
 #endif
+#ifdef CONFIG_SMP
+	{
+		.procname	= "sched_wake_idle_domain",
+		.data		= &sysctl_sched_wake_idle_domain,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_sched_wake_idle_domain_handler,
+	},
+	{
+		.procname	= "sched_wake_idle_presearch_domain",
+		.data		= &sysctl_sched_wake_idle_presearch_domain,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_sched_wake_idle_domain_handler,
+	},
+#endif
 #ifdef CONFIG_PROVE_LOCKING
 	{
 		.procname	= "prove_locking",
-- 
2.28.0.rc0.142.g3c755180ce-goog

