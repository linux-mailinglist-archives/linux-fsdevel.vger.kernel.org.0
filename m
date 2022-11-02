Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A2F615B36
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 04:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiKBDyC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Nov 2022 23:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKBDyA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Nov 2022 23:54:00 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F6A2BDF;
        Tue,  1 Nov 2022 20:53:58 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N2CYR5wnKzRnsP;
        Wed,  2 Nov 2022 11:48:59 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 2 Nov 2022 11:53:57 +0800
Received: from huawei.com (7.220.126.23) by dggpemm500014.china.huawei.com
 (7.185.36.153) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 11:53:56 +0800
From:   Song Zhang <zhangsong34@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <mcgrof@kernel.org>, <keescook@chromium.org>, <yzaikin@google.com>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        Song Zhang <zhangsong34@huawei.com>
Subject: [PATCH] sched/fair: Introduce priority load balance for CFS
Date:   Wed, 2 Nov 2022 11:53:01 +0800
Message-ID: <20221102035301.512892-1-zhangsong34@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [7.220.126.23]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a new sysctl interface:
/proc/sys/kernel/sched_prio_load_balance_enabled

0: default behavior
1: enable priority load balance for CFS

For co-location with idle and non-idle tasks, when CFS do load balance,
it is reasonable to prefer migrating non-idle tasks and migrating idle
tasks lastly. This will reduce the interference by SCHED_IDLE tasks
as much as possible.

Testcase:
- Spawn large number of idle(SCHED_IDLE) tasks occupy CPUs
- Let non-idle tasks compete with idle tasks for CPU time.

Using schbench to test non-idle tasks latency:
$ ./schbench -m 1 -t 10 -r 30 -R 200

Test result:
1.Default behavior
Latency percentiles (usec) runtime 30 (s) (4562 total samples)
        50.0th: 62528 (2281 samples)
        75.0th: 623616 (1141 samples)
        90.0th: 764928 (687 samples)
        95.0th: 824320 (225 samples)
        *99.0th: 920576 (183 samples)
        99.5th: 953344 (23 samples)
        99.9th: 1008640 (18 samples)
        min=9, max=1074466

2.Enable priority load balance
Latency percentiles (usec) runtime 30 (s) (4391 total samples)
        50.0th: 22624 (2204 samples)
        75.0th: 48832 (1092 samples)
        90.0th: 85376 (657 samples)
        95.0th: 113280 (220 samples)
        *99.0th: 182528 (175 samples)
        99.5th: 206592 (22 samples)
        99.9th: 290304 (17 samples)
        min=6, max=351815

From percentile details, we see the benefit of priority load balance
that 95% of non-idle tasks latencies stays no more than 113ms, while
non-idle tasks latencies has got almost 50% over 600ms if priority
load balance not enabled.

Signed-off-by: Song Zhang <zhangsong34@huawei.com>
---
 include/linux/sched/sysctl.h |  4 +++
 init/Kconfig                 | 10 ++++++
 kernel/sched/core.c          |  3 ++
 kernel/sched/fair.c          | 61 +++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h         |  3 ++
 kernel/sysctl.c              | 11 +++++++
 6 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 303ee7dd0c7e..9b3673269ecc 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -32,6 +32,10 @@ extern unsigned int sysctl_numa_balancing_promote_rate_limit;
 #define sysctl_numa_balancing_mode	0
 #endif
 
+#ifdef CONFIG_SCHED_PRIO_LB
+extern unsigned int sysctl_sched_prio_load_balance_enabled;
+#endif
+
 int sysctl_numa_balancing(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
 
diff --git a/init/Kconfig b/init/Kconfig
index 694f7c160c9c..b0dfe6701218 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1026,6 +1026,16 @@ config CFS_BANDWIDTH
 	  restriction.
 	  See Documentation/scheduler/sched-bwc.rst for more information.
 
+config SCHED_PRIO_LB
+	bool "Priority load balance for CFS"
+	depends on SMP
+	default n
+	help
+	  This feature enable CFS priority load balance to reduce
+	  non-idle tasks latency interferenced by SCHED_IDLE tasks.
+	  It prefer migrating non-idle tasks firstly and
+	  migrating SCHED_IDLE tasks lastly.
+
 config RT_GROUP_SCHED
 	bool "Group scheduling for SCHED_RR/FIFO"
 	depends on CGROUP_SCHED
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5800b0623ff3..9be35431fdd5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9731,6 +9731,9 @@ void __init sched_init(void)
 		rq->max_idle_balance_cost = sysctl_sched_migration_cost;
 
 		INIT_LIST_HEAD(&rq->cfs_tasks);
+#ifdef CONFIG_SCHED_PRIO_LB
+		INIT_LIST_HEAD(&rq->cfs_idle_tasks);
+#endif
 
 		rq_attach_root(rq, &def_root_domain);
 #ifdef CONFIG_NO_HZ_COMMON
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e4a0b8bd941c..bdeb04324f0c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -139,6 +139,10 @@ static int __init setup_sched_thermal_decay_shift(char *str)
 }
 __setup("sched_thermal_decay_shift=", setup_sched_thermal_decay_shift);
 
+#ifdef CONFIG_SCHED_PRIO_LB
+unsigned int sysctl_sched_prio_load_balance_enabled;
+#endif
+
 #ifdef CONFIG_SMP
 /*
  * For asym packing, by default the lower numbered CPU has higher priority.
@@ -3199,6 +3203,21 @@ static inline void update_scan_period(struct task_struct *p, int new_cpu)
 
 #endif /* CONFIG_NUMA_BALANCING */
 
+#ifdef CONFIG_SCHED_PRIO_LB
+static void
+adjust_rq_cfs_tasks(
+	void (*list_op)(struct list_head *, struct list_head *),
+	struct rq *rq,
+	struct sched_entity *se)
+{
+	if (sysctl_sched_prio_load_balance_enabled &&
+		task_has_idle_policy(task_of(se)))
+		(*list_op)(&se->group_node, &rq->cfs_idle_tasks);
+	else
+		(*list_op)(&se->group_node, &rq->cfs_tasks);
+}
+#endif
+
 static void
 account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
@@ -3208,7 +3227,11 @@ account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		struct rq *rq = rq_of(cfs_rq);
 
 		account_numa_enqueue(rq, task_of(se));
+#ifdef CONFIG_SCHED_PRIO_LB
+		adjust_rq_cfs_tasks(list_add, rq, se);
+#else
 		list_add(&se->group_node, &rq->cfs_tasks);
+#endif
 	}
 #endif
 	cfs_rq->nr_running++;
@@ -7631,7 +7654,11 @@ done: __maybe_unused;
 	 * the list, so our cfs_tasks list becomes MRU
 	 * one.
 	 */
+#ifdef CONFIG_SCHED_PRIO_LB
+	adjust_rq_cfs_tasks(list_move, rq, &p->se);
+#else
 	list_move(&p->se.group_node, &rq->cfs_tasks);
+#endif
 #endif
 
 	if (hrtick_enabled_fair(rq))
@@ -8156,11 +8183,18 @@ static void detach_task(struct task_struct *p, struct lb_env *env)
 static struct task_struct *detach_one_task(struct lb_env *env)
 {
 	struct task_struct *p;
+	struct list_head *tasks = &env->src_rq->cfs_tasks;
+#ifdef CONFIG_SCHED_PRIO_LB
+	bool has_detach_idle_tasks = false;
+#endif
 
 	lockdep_assert_rq_held(env->src_rq);
 
+#ifdef CONFIG_SCHED_PRIO_LB
+again:
+#endif
 	list_for_each_entry_reverse(p,
-			&env->src_rq->cfs_tasks, se.group_node) {
+			tasks, se.group_node) {
 		if (!can_migrate_task(p, env))
 			continue;
 
@@ -8175,6 +8209,13 @@ static struct task_struct *detach_one_task(struct lb_env *env)
 		schedstat_inc(env->sd->lb_gained[env->idle]);
 		return p;
 	}
+#ifdef CONFIG_SCHED_PRIO_LB
+	if (sysctl_sched_prio_load_balance_enabled && !has_detach_idle_tasks) {
+		has_detach_idle_tasks = true;
+		tasks = &env->src_rq->cfs_idle_tasks;
+		goto again;
+	}
+#endif
 	return NULL;
 }
 
@@ -8190,6 +8231,9 @@ static int detach_tasks(struct lb_env *env)
 	unsigned long util, load;
 	struct task_struct *p;
 	int detached = 0;
+#ifdef CONFIG_SCHED_PRIO_LB
+	bool has_detach_idle_tasks = false;
+#endif
 
 	lockdep_assert_rq_held(env->src_rq);
 
@@ -8205,6 +8249,9 @@ static int detach_tasks(struct lb_env *env)
 	if (env->imbalance <= 0)
 		return 0;
 
+#ifdef CONFIG_SCHED_PRIO_LB
+again:
+#endif
 	while (!list_empty(tasks)) {
 		/*
 		 * We don't want to steal all, otherwise we may be treated likewise,
@@ -8310,6 +8357,14 @@ static int detach_tasks(struct lb_env *env)
 		list_move(&p->se.group_node, tasks);
 	}
 
+#ifdef CONFIG_SCHED_PRIO_LB
+	if (sysctl_sched_prio_load_balance_enabled &&
+		!has_detach_idle_tasks && env->imbalance > 0) {
+		has_detach_idle_tasks = true;
+		tasks = &env->src_rq->cfs_idle_tasks;
+		goto again;
+	}
+#endif
 	/*
 	 * Right now, this is one of only two places we collect this stat
 	 * so we can safely collect detach_one_task() stats here rather
@@ -11814,7 +11869,11 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
 		 * Move the next running task to the front of the list, so our
 		 * cfs_tasks list becomes MRU one.
 		 */
+#ifdef CONFIG_SCHED_PRIO_LB
+		adjust_rq_cfs_tasks(list_move, rq, se);
+#else
 		list_move(&se->group_node, &rq->cfs_tasks);
+#endif
 	}
 #endif
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1644242ecd11..1b831c05ba30 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1053,6 +1053,9 @@ struct rq {
 	int			online;
 
 	struct list_head cfs_tasks;
+#ifdef CONFIG_SCHED_PRIO_LB
+	struct list_head cfs_idle_tasks;
+#endif
 
 	struct sched_avg	avg_rt;
 	struct sched_avg	avg_dl;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 188c305aeb8b..5fc0f9ffb675 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2090,6 +2090,17 @@ static struct ctl_table kern_table[] = {
 		.extra1		= SYSCTL_ONE,
 		.extra2		= SYSCTL_INT_MAX,
 	},
+#endif
+#ifdef CONFIG_SCHED_PRIO_LB
+	{
+		.procname	= "sched_prio_load_balance_enabled",
+		.data		= &sysctl_sched_prio_load_balance_enabled,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
 #endif
 	{ }
 };
-- 
2.27.0

