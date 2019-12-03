Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A13AB10F792
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 07:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfLCGAR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 01:00:17 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:56705 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726521AbfLCGAQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 01:00:16 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0TjnHvaK_1575352809;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TjnHvaK_1575352809)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 03 Dec 2019 14:00:10 +0800
Subject: [PATCH v3 1/2] sched/numa: introduce per-cgroup NUMA locality info
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
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <743eecad-9556-a241-546b-c8a66339840e@linux.alibaba.com>
 <207ef46c-672c-27c8-2012-735bd692a6de@linux.alibaba.com>
 <040def80-9c38-4bcc-e4a8-8a0d10f131ed@linux.alibaba.com>
Message-ID: <2398e8a4-a3ad-3660-3aba-298730d209b2@linux.alibaba.com>
Date:   Tue, 3 Dec 2019 14:00:08 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <040def80-9c38-4bcc-e4a8-8a0d10f131ed@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently there are no good approach to monitoring the per-cgroup NUMA
efficiency, this could be a trouble especially when groups are sharing
CPUs, we don't know which one introduced remote-memory accessing.

Although the per-task NUMA accessing info from PMU is good for further
debuging, but not light enough for daily monitoring, especial on a box
with thousands of tasks.

Fortunately, when NUMA Balancing enabled, it will periodly trigger page
fault and try to increase the NUMA locality, by tracing the results we
will be able to estimate the NUMA efficiency.

On each page fault of NUMA Balancing, when task's executing CPU is from
the same node of pages, we call this a local page accessing, otherwise
a remote page accessing.

By updating task's accessing counter into it's cgroup on ticks, we get
the per-cgroup numa locality info.

For example the new entry 'cpu.numa_stat' show:
  page_access local=1231412 remote=53453

Here we know the workloads in hierarchy have totally been traced 1284865
times of page accessing, and 1231412 of them are local page access, which
imply a good NUMA efficiency.

By monitoring the increments, we will be able to locate the per-cgroup
workload which NUMA Balancing can't helpwith (usually caused by wrong
CPU and memory node bindings), then we got chance to fix that in time.

Cc: Mel Gorman <mgorman@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Michal Koutný <mkoutny@suse.com>
Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
---
 include/linux/sched.h        | 15 +++++++++
 include/linux/sched/sysctl.h |  6 ++++
 init/Kconfig                 |  9 ++++++
 kernel/sched/core.c          | 75 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/fair.c          | 62 ++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h         | 12 +++++++
 kernel/sysctl.c              | 11 +++++++
 7 files changed, 190 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8f6607cd40ac..d15704ac0c6e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1125,6 +1125,21 @@ struct task_struct {
 	unsigned long			numa_pages_migrated;
 #endif /* CONFIG_NUMA_BALANCING */

+#ifdef CONFIG_CGROUP_NUMA_LOCALITY
+	/*
+	 * Counter index stand for:
+	 * 0 -- remote page accessing
+	 * 1 -- local page accessing
+	 * 2 -- remote page accessing updated
+	 * 3 -- local page accessing updated
+	 *
+	 * We record the counter in task_numa_fault(), this is based on the
+	 * fact that after page fault is handled, the task will access the
+	 * page on the CPU where it triggered PF.
+	 */
+	unsigned long			numa_page_access[4];
+#endif
+
 #ifdef CONFIG_RSEQ
 	struct rseq __user *rseq;
 	u32 rseq_sig;
diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 89f55e914673..c7048119b8b5 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -102,4 +102,10 @@ extern int sched_energy_aware_handler(struct ctl_table *table, int write,
 				 loff_t *ppos);
 #endif

+#ifdef CONFIG_CGROUP_NUMA_LOCALITY
+extern int sysctl_numa_locality(struct ctl_table *table, int write,
+				 void __user *buffer, size_t *lenp,
+				 loff_t *ppos);
+#endif
+
 #endif /* _LINUX_SCHED_SYSCTL_H */
diff --git a/init/Kconfig b/init/Kconfig
index 4d8d145c41d2..9c086f716a6d 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -817,6 +817,15 @@ config NUMA_BALANCING_DEFAULT_ENABLED
 	  If set, automatic NUMA balancing will be enabled if running on a NUMA
 	  machine.

+config CGROUP_NUMA_LOCALITY
+	bool "The per-cgroup NUMA Locality"
+	default n
+	depends on CGROUP_SCHED && NUMA_BALANCING
+	help
+	  This option enable the collection of per-cgroup NUMA locality info,
+	  to tell whether NUMA Balancing is working well for a particular
+	  workload.
+
 menuconfig CGROUPS
 	bool "Control Group support"
 	select KERNFS
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index aaa1740e6497..6a7850d94c55 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7657,6 +7657,68 @@ static u64 cpu_rt_period_read_uint(struct cgroup_subsys_state *css,
 }
 #endif /* CONFIG_RT_GROUP_SCHED */

+#ifdef CONFIG_CGROUP_NUMA_LOCALITY
+DEFINE_STATIC_KEY_FALSE(sched_numa_locality);
+
+#ifdef CONFIG_PROC_SYSCTL
+int sysctl_numa_locality(struct ctl_table *table, int write,
+			 void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct ctl_table t;
+	int err;
+	int state = static_branch_likely(&sched_numa_locality);
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
+		static_branch_enable(&sched_numa_locality);
+	else
+		static_branch_disable(&sched_numa_locality);
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
+	int cpu;
+	u64 local = 0, remote = 0;
+	struct task_group *tg = css_tg(seq_css(sf));
+
+	if (!static_branch_likely(&sched_numa_locality))
+		return 0;
+
+	for_each_possible_cpu(cpu) {
+		local += tg_cfs_rq(tg, cpu)->local_page_access;
+		remote += tg_cfs_rq(tg, cpu)->remote_page_access;
+	}
+
+	seq_printf(sf, "page_access local=%llu remote=%llu\n", local, remote);
+
+	return 0;
+}
+
+static __init int numa_locality_setup(char *opt)
+{
+	static_branch_enable(&sched_numa_locality);
+
+	return 0;
+}
+__setup("numa_locality", numa_locality_setup);
+#endif
+
 static struct cftype cpu_legacy_files[] = {
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	{
@@ -7706,6 +7768,12 @@ static struct cftype cpu_legacy_files[] = {
 		.seq_show = cpu_uclamp_max_show,
 		.write = cpu_uclamp_max_write,
 	},
+#endif
+#ifdef CONFIG_CGROUP_NUMA_LOCALITY
+	{
+		.name = "numa_stat",
+		.seq_show = cpu_numa_stat_show,
+	},
 #endif
 	{ }	/* Terminate */
 };
@@ -7887,6 +7955,13 @@ static struct cftype cpu_files[] = {
 		.seq_show = cpu_uclamp_max_show,
 		.write = cpu_uclamp_max_write,
 	},
+#endif
+#ifdef CONFIG_CGROUP_NUMA_LOCALITY
+	{
+		.name = "numa_stat",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = cpu_numa_stat_show,
+	},
 #endif
 	{ }	/* terminate */
 };
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 81eba554db8d..4f5689f5a088 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1050,6 +1050,62 @@ update_stats_curr_start(struct cfs_rq *cfs_rq, struct sched_entity *se)
  */

 #ifdef CONFIG_NUMA_BALANCING
+
+#ifdef CONFIG_CGROUP_NUMA_LOCALITY
+/*
+ * We want to record the real local/remote page access statistic
+ * here, so 'pnid' should be pages's real residential node after
+ * migrate_misplaced_page(), and 'cnid' should be the node of CPU
+ * where triggered the PF.
+ */
+static inline void
+update_task_locality(struct task_struct *p, int pnid, int cnid, int pages)
+{
+	if (!static_branch_unlikely(&sched_numa_locality))
+		return;
+
+	/*
+	 * pnid != cnid --> remote idx 0
+	 * pnid == cnid --> local idx 1
+	 */
+	p->numa_page_access[!!(pnid == cnid)] += pages;
+}
+
+static inline void update_group_locality(struct cfs_rq *cfs_rq)
+{
+	unsigned long ldiff, rdiff;
+
+	if (!static_branch_unlikely(&sched_numa_locality))
+		return;
+
+	rdiff = current->numa_page_access[0] - current->numa_page_access[2];
+	ldiff = current->numa_page_access[1] - current->numa_page_access[3];
+	if (!ldiff && !rdiff)
+		return;
+
+	cfs_rq->local_page_access += ldiff;
+	cfs_rq->remote_page_access += rdiff;
+
+	/*
+	 * Consider updated when reach root cfs_rq, no PF should happen
+	 * during the hierarchical updating.
+	 */
+	if (&cfs_rq->rq->cfs == cfs_rq) {
+		current->numa_page_access[2] = current->numa_page_access[0];
+		current->numa_page_access[3] = current->numa_page_access[1];
+	}
+}
+#else
+static inline void
+update_task_locality(struct task_struct *p, int pnid, int cnid, int pages)
+{
+}
+
+static inline void update_group_locality(struct cfs_rq *cfs_rq)
+{
+}
+#endif /* CONFIG_CGROUP_NUMA_LOCALITY */
+
 /*
  * Approximate time to scan a full NUMA task in ms. The task scan period is
  * calculated based on the tasks virtual memory size and
@@ -2465,6 +2521,8 @@ void task_numa_fault(int last_cpupid, int mem_node, int pages, int flags)
 	p->numa_faults[task_faults_idx(NUMA_MEMBUF, mem_node, priv)] += pages;
 	p->numa_faults[task_faults_idx(NUMA_CPUBUF, cpu_node, priv)] += pages;
 	p->numa_faults_locality[local] += pages;
+
+	update_task_locality(p, mem_node, numa_node_id(), pages);
 }

 static void reset_ptenuma_scan(struct task_struct *p)
@@ -2650,6 +2708,9 @@ void init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
 	p->last_sum_exec_runtime	= 0;

 	init_task_work(&p->numa_work, task_numa_work);
+#ifdef CONFIG_CGROUP_NUMA_LOCALITY
+	memset(p->numa_page_access, 0, sizeof(p->numa_page_access));
+#endif

 	/* New address space, reset the preferred nid */
 	if (!(clone_flags & CLONE_VM)) {
@@ -4298,6 +4359,7 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
 	 */
 	update_load_avg(cfs_rq, curr, UPDATE_TG);
 	update_cfs_group(curr);
+	update_group_locality(cfs_rq);

 #ifdef CONFIG_SCHED_HRTICK
 	/*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 05c282775f21..33f5653d9d4c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -575,6 +575,14 @@ struct cfs_rq {
 	struct list_head	throttled_list;
 #endif /* CONFIG_CFS_BANDWIDTH */
 #endif /* CONFIG_FAIR_GROUP_SCHED */
+#ifdef CONFIG_CGROUP_NUMA_LOCALITY
+	/*
+	 * The local/remote page access info collected from all
+	 * the tasks in hierarchy.
+	 */
+	u64			local_page_access;
+	u64			remote_page_access;
+#endif
 };

 static inline int rt_bandwidth_enabled(void)
@@ -1601,6 +1609,10 @@ static const_debug __maybe_unused unsigned int sysctl_sched_features =
 extern struct static_key_false sched_numa_balancing;
 extern struct static_key_false sched_schedstats;

+#ifdef CONFIG_CGROUP_NUMA_LOCALITY
+extern struct static_key_false sched_numa_locality;
+#endif
+
 static inline u64 global_rt_period(void)
 {
 	return (u64)sysctl_sched_rt_period * NSEC_PER_USEC;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 50373984a5e2..73cbb70940ac 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -428,6 +428,17 @@ static struct ctl_table kern_table[] = {
 		.extra2		= SYSCTL_ONE,
 	},
 #endif /* CONFIG_NUMA_BALANCING */
+#ifdef CONFIG_CGROUP_NUMA_LOCALITY
+	{
+		.procname	= "numa_locality",
+		.data		= NULL, /* filled in by handler */
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= sysctl_numa_locality,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+#endif /* CONFIG_CGROUP_NUMA_LOCALITY */
 #endif /* CONFIG_SCHED_DEBUG */
 	{
 		.procname	= "sched_rt_period_us",
-- 
2.14.4.44.g2045bb6

