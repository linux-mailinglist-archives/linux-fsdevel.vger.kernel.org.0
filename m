Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A50D26A0DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2019 05:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730964AbfGPDjp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jul 2019 23:39:45 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:19655 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729574AbfGPDjp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jul 2019 23:39:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0TX1Yc3G_1563248369;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TX1Yc3G_1563248369)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 16 Jul 2019 11:39:30 +0800
Subject: [PATCH v2 1/4] numa: introduce per-cgroup numa balancing locality
 statistic
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
To:     Peter Zijlstra <peterz@infradead.org>, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mcgrof@kernel.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Hillf Danton <hdanton@sina.com>
References: <209d247e-c1b2-3235-2722-dd7c1f896483@linux.alibaba.com>
 <60b59306-5e36-e587-9145-e90657daec41@linux.alibaba.com>
 <65c1987f-bcce-2165-8c30-cf8cf3454591@linux.alibaba.com>
Message-ID: <120ffcaa-0281-5d30-c0c1-9464d93e935f@linux.alibaba.com>
Date:   Tue, 16 Jul 2019 11:39:29 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <65c1987f-bcce-2165-8c30-cf8cf3454591@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch introduced numa locality statistic, which try to imply
the numa balancing efficiency per memory cgroup.

On numa balancing, we trace the local page accessing ratio of tasks,
which we call the locality.

By doing 'cat /sys/fs/cgroup/cpu/CGROUP_PATH/cpu.numa_stat', we
see output line heading with 'locality', like:

  locality 15393 21259 13023 44461 21247 17012 28496 145402

locality divided into 8 regions, each number standing for the micro
seconds we hit a task running with the locality within that region,
for example here we have tasks with locality around 0~12% running for
15393 ms, and tasks with locality around 88~100% running for 145402 ms.

By monitoring the increment, we can check if the workloads of a
particular cgroup is doing well with numa, when most of the tasks are
running in low locality region, then something is wrong with your numa
policy.

Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
---
Since v1:
  * move implementation from memory cgroup into cpu group
  * introduce new entry 'numa_stat' to present locality
  * locality now accounting in hierarchical way
  * locality now accounted into 8 regions equally

 include/linux/sched.h |  8 +++++++-
 kernel/sched/core.c   | 40 ++++++++++++++++++++++++++++++++++++++++
 kernel/sched/debug.c  |  7 +++++++
 kernel/sched/fair.c   | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h  | 29 +++++++++++++++++++++++++++++
 5 files changed, 132 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 907808f1acc5..eb26098de6ea 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1117,8 +1117,14 @@ struct task_struct {
 	 * scan window were remote/local or failed to migrate. The task scan
 	 * period is adapted based on the locality of the faults with different
 	 * weights depending on whether they were shared or private faults
+	 *
+	 * 0 -- remote faults
+	 * 1 -- local faults
+	 * 2 -- page migration failure
+	 * 3 -- remote page accessing
+	 * 4 -- local page accessing
 	 */
-	unsigned long			numa_faults_locality[3];
+	unsigned long			numa_faults_locality[5];

 	unsigned long			numa_pages_migrated;
 #endif /* CONFIG_NUMA_BALANCING */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fa43ce3962e7..71a8d3ed8495 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6367,6 +6367,10 @@ static struct kmem_cache *task_group_cache __read_mostly;
 DECLARE_PER_CPU(cpumask_var_t, load_balance_mask);
 DECLARE_PER_CPU(cpumask_var_t, select_idle_mask);

+#ifdef CONFIG_NUMA_BALANCING
+DECLARE_PER_CPU(struct numa_stat, root_numa_stat);
+#endif
+
 void __init sched_init(void)
 {
 	unsigned long alloc_size = 0, ptr;
@@ -6416,6 +6420,10 @@ void __init sched_init(void)
 	init_defrootdomain();
 #endif

+#ifdef CONFIG_NUMA_BALANCING
+	root_task_group.numa_stat = &root_numa_stat;
+#endif
+
 #ifdef CONFIG_RT_GROUP_SCHED
 	init_rt_bandwidth(&root_task_group.rt_bandwidth,
 			global_rt_period(), global_rt_runtime());
@@ -6727,6 +6735,7 @@ static DEFINE_SPINLOCK(task_group_lock);

 static void sched_free_group(struct task_group *tg)
 {
+	free_tg_numa_stat(tg);
 	free_fair_sched_group(tg);
 	free_rt_sched_group(tg);
 	autogroup_free(tg);
@@ -6742,6 +6751,9 @@ struct task_group *sched_create_group(struct task_group *parent)
 	if (!tg)
 		return ERR_PTR(-ENOMEM);

+	if (!alloc_tg_numa_stat(tg))
+		goto err;
+
 	if (!alloc_fair_sched_group(tg, parent))
 		goto err;

@@ -7277,6 +7289,28 @@ static u64 cpu_rt_period_read_uint(struct cgroup_subsys_state *css,
 }
 #endif /* CONFIG_RT_GROUP_SCHED */

+#ifdef CONFIG_NUMA_BALANCING
+static int cpu_numa_stat_show(struct seq_file *sf, void *v)
+{
+	int nr;
+	struct task_group *tg = css_tg(seq_css(sf));
+
+	seq_puts(sf, "locality");
+	for (nr = 0; nr < NR_NL_INTERVAL; nr++) {
+		int cpu;
+		u64 sum = 0;
+
+		for_each_possible_cpu(cpu)
+			sum += per_cpu(tg->numa_stat->locality[nr], cpu);
+
+		seq_printf(sf, " %u", jiffies_to_msecs(sum));
+	}
+	seq_putc(sf, '\n');
+
+	return 0;
+}
+#endif
+
 static struct cftype cpu_legacy_files[] = {
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	{
@@ -7312,6 +7346,12 @@ static struct cftype cpu_legacy_files[] = {
 		.read_u64 = cpu_rt_period_read_uint,
 		.write_u64 = cpu_rt_period_write_uint,
 	},
+#endif
+#ifdef CONFIG_NUMA_BALANCING
+	{
+		.name = "numa_stat",
+		.seq_show = cpu_numa_stat_show,
+	},
 #endif
 	{ }	/* Terminate */
 };
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index f7e4579e746c..a22b2a62aee2 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -848,6 +848,13 @@ static void sched_show_numa(struct task_struct *p, struct seq_file *m)
 	P(total_numa_faults);
 	SEQ_printf(m, "current_node=%d, numa_group_id=%d\n",
 			task_node(p), task_numa_group_id(p));
+	SEQ_printf(m, "faults_locality local=%lu remote=%lu failed=%lu ",
+			p->numa_faults_locality[1],
+			p->numa_faults_locality[0],
+			p->numa_faults_locality[2]);
+	SEQ_printf(m, "lhit=%lu rhit=%lu\n",
+			p->numa_faults_locality[4],
+			p->numa_faults_locality[3]);
 	show_numa_stats(p, m);
 	mpol_put(pol);
 #endif
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 036be95a87e9..cd716355d70e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2449,6 +2449,12 @@ void task_numa_fault(int last_cpupid, int mem_node, int pages, int flags)
 	p->numa_faults[task_faults_idx(NUMA_MEMBUF, mem_node, priv)] += pages;
 	p->numa_faults[task_faults_idx(NUMA_CPUBUF, cpu_node, priv)] += pages;
 	p->numa_faults_locality[local] += pages;
+	/*
+	 * We want to have the real local/remote page access statistic
+	 * here, so use 'mem_node' which is the real residential node of
+	 * page after migrate_misplaced_page().
+	 */
+	p->numa_faults_locality[3 + !!(mem_node == numa_node_id())] += pages;
 }

 static void reset_ptenuma_scan(struct task_struct *p)
@@ -2611,6 +2617,47 @@ void task_numa_work(struct callback_head *work)
 	}
 }

+DEFINE_PER_CPU(struct numa_stat, root_numa_stat);
+
+int alloc_tg_numa_stat(struct task_group *tg)
+{
+	tg->numa_stat = alloc_percpu(struct numa_stat);
+	if (!tg->numa_stat)
+		return 0;
+
+	return 1;
+}
+
+void free_tg_numa_stat(struct task_group *tg)
+{
+	free_percpu(tg->numa_stat);
+}
+
+static void update_tg_numa_stat(struct task_struct *p)
+{
+	struct task_group *tg;
+	unsigned long remote = p->numa_faults_locality[3];
+	unsigned long local = p->numa_faults_locality[4];
+	int idx = -1;
+
+	/* Tobe scaled? */
+	if (remote || local)
+		idx = NR_NL_INTERVAL * local / (remote + local + 1);
+
+	rcu_read_lock();
+
+	tg = task_group(p);
+	while (tg) {
+		/* skip account when there are no faults records */
+		if (idx != -1)
+			this_cpu_inc(tg->numa_stat->locality[idx]);
+
+		tg = tg->parent;
+	}
+
+	rcu_read_unlock();
+}
+
 /*
  * Drive the periodic memory faults..
  */
@@ -2625,6 +2672,8 @@ static void task_tick_numa(struct rq *rq, struct task_struct *curr)
 	if (!curr->mm || (curr->flags & PF_EXITING) || work->next != work)
 		return;

+	update_tg_numa_stat(curr);
+
 	/*
 	 * Using runtime rather than walltime has the dual advantage that
 	 * we (mostly) drive the selection from busy threads and that the
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 802b1f3405f2..685a9e670880 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -353,6 +353,17 @@ struct cfs_bandwidth {
 #endif
 };

+#ifdef CONFIG_NUMA_BALANCING
+
+/* NUMA Locality Interval, 8 bucket for cache align */
+#define NR_NL_INTERVAL	8
+
+struct numa_stat {
+	u64 locality[NR_NL_INTERVAL];
+};
+
+#endif
+
 /* Task group related information */
 struct task_group {
 	struct cgroup_subsys_state css;
@@ -393,8 +404,26 @@ struct task_group {
 #endif

 	struct cfs_bandwidth	cfs_bandwidth;
+
+#ifdef CONFIG_NUMA_BALANCING
+	struct numa_stat __percpu *numa_stat;
+#endif
 };

+#ifdef CONFIG_NUMA_BALANCING
+int alloc_tg_numa_stat(struct task_group *tg);
+void free_tg_numa_stat(struct task_group *tg);
+#else
+static int alloc_tg_numa_stat(struct task_group *tg)
+{
+	return 1;
+}
+
+static void free_tg_numa_stat(struct task_group *tg)
+{
+}
+#endif
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 #define ROOT_TASK_GROUP_LOAD	NICE_0_LOAD

-- 
2.14.4.44.g2045bb6

