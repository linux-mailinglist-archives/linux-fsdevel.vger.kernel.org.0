Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11355FA77D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 04:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbfKMDos (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 22:44:48 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:53010 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727352AbfKMDos (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 22:44:48 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0ThxMCqT_1573616680;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0ThxMCqT_1573616680)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 13 Nov 2019 11:44:41 +0800
Subject: [PATCH 1/3] sched/numa: advanced per-cgroup numa statistic
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
References: <743eecad-9556-a241-546b-c8a66339840e@linux.alibaba.com>
Message-ID: <4cb583ce-bf9a-0453-1b35-b920253845a0@linux.alibaba.com>
Date:   Wed, 13 Nov 2019 11:44:40 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <743eecad-9556-a241-546b-c8a66339840e@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently there are no good approach to monitoring the per-cgroup
numa efficiency, this could be a trouble especially when groups
are sharing CPUs, it's impossible to tell which one caused the
remote-memory access by reading hardware counter since multiple
workloads could sharing the same CPU, which make it painful when
one want to find out the root cause and fix the issue.

In order to address this, we introduced new per-cgroup statistic
for numa:
  * the numa locality to imply the numa balancing efficiency
  * the numa execution time on each node

The task locality is the local page accessing ratio traced on numa
balancing PF, and the group locality is the topology of task execution
time, sectioned by the locality into 7 regions.

For example the new entry 'cpu.numa_stat' show:
  locality 39541 60962 36842 72519 118605 721778 946553
  exectime 1220127 1458684

Here we know the workloads in hierarchy executed 1220127ms on node_0
and 1458684ms on node_1 in total, tasks with locality around 0~13%
executed for 39541 ms, and tasks with locality around 86~100% executed
for 946553 ms, which imply most of the memory access are local access.

By monitoring the new statistic, we will be able to know the numa
efficiency of each per-cgroup workloads on machine, whatever they
sharing the CPUs or not, we will be able to find out which one
introduced the remote access mostly.

Besides, per-node memory topology from 'memory.numa_stat' become
more useful when we have the per-node execution time, workloads
always executing on node_0 while it's memory is all on node_1 is
usually a bad case.

Cc: Mel Gorman <mgorman@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Michal Koutný <mkoutny@suse.com>
Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
---
 include/linux/sched.h        | 18 ++++++++-
 include/linux/sched/sysctl.h |  6 +++
 init/Kconfig                 |  9 +++++
 kernel/sched/core.c          | 91 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/fair.c          | 33 ++++++++++++++++
 kernel/sched/sched.h         | 17 +++++++++
 kernel/sysctl.c              | 11 ++++++
 7 files changed, 184 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 263cf089d1b3..e3daadc5a799 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1113,9 +1113,25 @@ struct task_struct {
 	 * numa_faults_locality tracks if faults recorded during the last
 	 * scan window were remote/local or failed to migrate. The task scan
 	 * period is adapted based on the locality of the faults with different
-	 * weights depending on whether they were shared or private faults
+	 * weights depending on whether they were shared or private faults.
+	 *
+	 * Counter id stand for:
+	 * 0 -- remote faults
+	 * 1 -- local faults
+	 * 2 -- page migration failure
+	 *
+	 * Extra counters when CONFIG_CGROUP_NUMA_STAT enabled:
+	 * 3 -- remote page accessing
+	 * 4 -- local page accessing
+	 *
+	 * The 'remote/local faults' records the cpu-page relationship before
+	 * page migration, while the 'remote/local page accessing' is after.
 	 */
+#ifndef CONFIG_CGROUP_NUMA_STAT
 	unsigned long			numa_faults_locality[3];
+#else
+	unsigned long			numa_faults_locality[5];
+#endif

 	unsigned long			numa_pages_migrated;
 #endif /* CONFIG_NUMA_BALANCING */
diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 89f55e914673..2d6a515df544 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -102,4 +102,10 @@ extern int sched_energy_aware_handler(struct ctl_table *table, int write,
 				 loff_t *ppos);
 #endif

+#ifdef CONFIG_CGROUP_NUMA_STAT
+extern int sysctl_cg_numa_stat(struct ctl_table *table, int write,
+				 void __user *buffer, size_t *lenp,
+				 loff_t *ppos);
+#endif
+
 #endif /* _LINUX_SCHED_SYSCTL_H */
diff --git a/init/Kconfig b/init/Kconfig
index b4daad2bac23..b0f9bfbd1c3f 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -817,6 +817,15 @@ config NUMA_BALANCING_DEFAULT_ENABLED
 	  If set, automatic NUMA balancing will be enabled if running on a NUMA
 	  machine.

+config CGROUP_NUMA_STAT
+	bool "Advanced per-cgroup NUMA statistics"
+	default n
+	depends on CGROUP_SCHED && NUMA_BALANCING
+	help
+	  This option adds support for per-cgroup NUMA locality/execution
+	  statistics, for monitoring NUMA efficiency of per-cgroup workloads
+	  on NUMA platforms with NUMA Balancing enabled.
+
 menuconfig CGROUPS
 	bool "Control Group support"
 	select KERNFS
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index eb42b71faab9..4f05576f371a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7638,6 +7638,84 @@ static u64 cpu_rt_period_read_uint(struct cgroup_subsys_state *css,
 }
 #endif /* CONFIG_RT_GROUP_SCHED */

+#ifdef CONFIG_CGROUP_NUMA_STAT
+DEFINE_STATIC_KEY_FALSE(sched_cg_numa_stat);
+
+#ifdef CONFIG_PROC_SYSCTL
+int sysctl_cg_numa_stat(struct ctl_table *table, int write,
+			 void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct ctl_table t;
+	int err;
+	int state = static_branch_likely(&sched_cg_numa_stat);
+
+	if (write && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	t = *table;
+	t.data = &state;
+	err = proc_dointvec_minmax(&t, write, buffer, lenp, ppos);
+	if (err < 0 || !write)
+		return err;
+
+	if (state)
+		static_branch_enable(&sched_cg_numa_stat);
+	else
+		static_branch_disable(&sched_cg_numa_stat);
+
+	return err;
+}
+#endif
+
+static inline struct cfs_rq *tg_cfs_rq(struct task_group *tg, int cpu)
+{
+	return tg == &root_task_group ? &cpu_rq(cpu)->cfs : tg->cfs_rq[cpu];
+}
+
+static int cpu_numa_stat_show(struct seq_file *sf, void *v)
+{
+	int nr;
+	struct task_group *tg = css_tg(seq_css(sf));
+
+	if (!static_branch_likely(&sched_cg_numa_stat))
+		return 0;
+
+	seq_puts(sf, "locality");
+	for (nr = 0; nr < NR_NL_INTERVAL; nr++) {
+		int cpu;
+		u64 sum = 0;
+
+		for_each_possible_cpu(cpu)
+			sum += tg_cfs_rq(tg, cpu)->nstat.locality[nr];
+
+		seq_printf(sf, " %u", jiffies_to_msecs(sum));
+	}
+	seq_putc(sf, '\n');
+
+	seq_puts(sf, "exectime");
+	for_each_online_node(nr) {
+		int cpu;
+		u64 sum = 0;
+
+		for_each_cpu(cpu, cpumask_of_node(nr))
+			sum += tg_cfs_rq(tg, cpu)->nstat.jiffies;
+
+		seq_printf(sf, " %u", jiffies_to_msecs(sum));
+	}
+	seq_putc(sf, '\n');
+
+	return 0;
+}
+
+static __init int cg_numa_stat_setup(char *opt)
+{
+	static_branch_enable(&sched_cg_numa_stat);
+
+	return 0;
+}
+__setup("cg_numa_stat", cg_numa_stat_setup);
+#endif
+
 static struct cftype cpu_legacy_files[] = {
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	{
@@ -7687,6 +7765,12 @@ static struct cftype cpu_legacy_files[] = {
 		.seq_show = cpu_uclamp_max_show,
 		.write = cpu_uclamp_max_write,
 	},
+#endif
+#ifdef CONFIG_CGROUP_NUMA_STAT
+	{
+		.name = "numa_stat",
+		.seq_show = cpu_numa_stat_show,
+	},
 #endif
 	{ }	/* Terminate */
 };
@@ -7868,6 +7952,13 @@ static struct cftype cpu_files[] = {
 		.seq_show = cpu_uclamp_max_show,
 		.write = cpu_uclamp_max_write,
 	},
+#endif
+#ifdef CONFIG_CGROUP_NUMA_STAT
+	{
+		.name = "numa_stat",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = cpu_numa_stat_show,
+	},
 #endif
 	{ }	/* terminate */
 };
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a81c36472822..706519104c9f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2466,6 +2466,18 @@ void task_numa_fault(int last_cpupid, int mem_node, int pages, int flags)
 	p->numa_faults[task_faults_idx(NUMA_MEMBUF, mem_node, priv)] += pages;
 	p->numa_faults[task_faults_idx(NUMA_CPUBUF, cpu_node, priv)] += pages;
 	p->numa_faults_locality[local] += pages;
+
+#ifdef CONFIG_CGROUP_NUMA_STAT
+	if (!static_branch_unlikely(&sched_cg_numa_stat))
+		return;
+
+	/*
+	 * We want to record the real local/remote page access statistic
+	 * here, so use 'mem_node' which is the real residential node of
+	 * page after migrate_misplaced_page().
+	 */
+	p->numa_faults_locality[3 + !!(mem_node == numa_node_id())] += pages;
+#endif
 }

 static void reset_ptenuma_scan(struct task_struct *p)
@@ -4274,6 +4286,23 @@ static void put_prev_entity(struct cfs_rq *cfs_rq, struct sched_entity *prev)
 	cfs_rq->curr = NULL;
 }

+#ifdef CONFIG_CGROUP_NUMA_STAT
+static void update_numa_statistics(struct cfs_rq *cfs_rq)
+{
+	int idx;
+	unsigned long remote = current->numa_faults_locality[3];
+	unsigned long local = current->numa_faults_locality[4];
+
+	cfs_rq->nstat.jiffies++;
+
+	if (!remote && !local)
+		return;
+
+	idx = (NR_NL_INTERVAL - 1) * local / (remote + local);
+	cfs_rq->nstat.locality[idx]++;
+}
+#endif
+
 static void
 entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
 {
@@ -4287,6 +4316,10 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
 	 */
 	update_load_avg(cfs_rq, curr, UPDATE_TG);
 	update_cfs_group(curr);
+#ifdef CONFIG_CGROUP_NUMA_STAT
+	if (static_branch_unlikely(&sched_cg_numa_stat))
+		update_numa_statistics(cfs_rq);
+#endif

 #ifdef CONFIG_SCHED_HRTICK
 	/*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0db2c1b3361e..0476e6f95013 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -486,6 +486,16 @@ struct cfs_bandwidth { };

 #endif	/* CONFIG_CGROUP_SCHED */

+#ifdef CONFIG_CGROUP_NUMA_STAT
+/* NUMA Locality Interval, 7 buckets for cache align */
+#define NR_NL_INTERVAL	7
+
+struct numa_statistics {
+	u64 jiffies;
+	u64 locality[NR_NL_INTERVAL];
+};
+#endif
+
 /* CFS-related fields in a runqueue */
 struct cfs_rq {
 	struct load_weight	load;
@@ -575,6 +585,9 @@ struct cfs_rq {
 	struct list_head	throttled_list;
 #endif /* CONFIG_CFS_BANDWIDTH */
 #endif /* CONFIG_FAIR_GROUP_SCHED */
+#ifdef CONFIG_CGROUP_NUMA_STAT
+	struct numa_statistics	nstat ____cacheline_aligned;
+#endif
 };

 static inline int rt_bandwidth_enabled(void)
@@ -1601,6 +1614,10 @@ static const_debug __maybe_unused unsigned int sysctl_sched_features =
 extern struct static_key_false sched_numa_balancing;
 extern struct static_key_false sched_schedstats;

+#ifdef CONFIG_CGROUP_NUMA_STAT
+extern struct static_key_false sched_cg_numa_stat;
+#endif
+
 static inline u64 global_rt_period(void)
 {
 	return (u64)sysctl_sched_rt_period * NSEC_PER_USEC;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 31ece1120aa4..63a62c4df918 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -428,6 +428,17 @@ static struct ctl_table kern_table[] = {
 		.extra2		= SYSCTL_ONE,
 	},
 #endif /* CONFIG_NUMA_BALANCING */
+#ifdef CONFIG_CGROUP_NUMA_STAT
+	{
+		.procname	= "cg_numa_stat",
+		.data		= NULL, /* filled in by handler */
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= sysctl_cg_numa_stat,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+#endif /* CONFIG_CGROUP_NUMA_STAT */
 #endif /* CONFIG_SCHED_DEBUG */
 	{
 		.procname	= "sched_rt_period_us",
-- 
2.14.4.44.g2045bb6

