Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8B86A0E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2019 05:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731114AbfGPDlT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jul 2019 23:41:19 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:43740 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730275AbfGPDlT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jul 2019 23:41:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0TX1aoqx_1563248467;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TX1aoqx_1563248467)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 16 Jul 2019 11:41:07 +0800
Subject: [PATCH v2 3/4] numa: introduce numa group per task group
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
Message-ID: <e91a257d-3936-68b5-4845-21bd93db6733@linux.alibaba.com>
Date:   Tue, 16 Jul 2019 11:41:07 +0800
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

By tracing numa page faults, we recognize tasks sharing the same page,
and try pack them together into a single numa group.

However when two task share lot's of cache pages while not much
anonymous pages, since numa balancing do not tracing cache page, they
have no chance to join into the same group.

While tracing cache page cost too much, we could use some hints from
userland and cpu cgroup could be a good one.

This patch introduced new entry 'numa_group' for cpu cgroup, by echo
non-zero into the entry, we can now force all the tasks of this cgroup
to join the same numa group serving for task group.

In this way tasks are more likely to settle down on the same node, to
share closer cpu cache and gain benefit from NUMA on both file/anonymous
pages.

Besides, when multiple cgroup enabled numa group, they will be able to
exchange task location by utilizing numa migration, in this way they
could achieve single node settle down without breaking load balance.

Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
---
Since v1:
  * just rebase, no logical changes

 kernel/sched/core.c  |  33 ++++++++++
 kernel/sched/fair.c  | 175 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h |  11 ++++
 3 files changed, 218 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f8aa73aa879b..9f100c48d6e4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6802,6 +6802,8 @@ void sched_offline_group(struct task_group *tg)
 {
 	unsigned long flags;

+	update_tg_numa_group(tg, false);
+
 	/* End participation in shares distribution: */
 	unregister_fair_sched_group(tg);

@@ -7321,6 +7323,32 @@ static int cpu_numa_stat_show(struct seq_file *sf, void *v)

 	return 0;
 }
+
+static DEFINE_MUTEX(numa_mutex);
+
+static int cpu_numa_group_show(struct seq_file *sf, void *v)
+{
+	struct task_group *tg = css_tg(seq_css(sf));
+
+	mutex_lock(&numa_mutex);
+	show_tg_numa_group(tg, sf);
+	mutex_unlock(&numa_mutex);
+
+	return 0;
+}
+
+static int cpu_numa_group_write_s64(struct cgroup_subsys_state *css,
+				struct cftype *cft, s64 numa_group)
+{
+	int ret;
+	struct task_group *tg = css_tg(css);
+
+	mutex_lock(&numa_mutex);
+	ret = update_tg_numa_group(tg, numa_group);
+	mutex_unlock(&numa_mutex);
+
+	return ret;
+}
 #endif

 static struct cftype cpu_legacy_files[] = {
@@ -7364,6 +7392,11 @@ static struct cftype cpu_legacy_files[] = {
 		.name = "numa_stat",
 		.seq_show = cpu_numa_stat_show,
 	},
+	{
+		.name = "numa_group",
+		.write_s64 = cpu_numa_group_write_s64,
+		.seq_show = cpu_numa_group_show,
+	},
 #endif
 	{ }	/* Terminate */
 };
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2c362266af76..c28ba040a563 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1073,6 +1073,7 @@ struct numa_group {
 	int nr_tasks;
 	pid_t gid;
 	int active_nodes;
+	bool evacuate;

 	struct rcu_head rcu;
 	unsigned long total_faults;
@@ -2246,6 +2247,176 @@ static inline void put_numa_group(struct numa_group *grp)
 		kfree_rcu(grp, rcu);
 }

+void show_tg_numa_group(struct task_group *tg, struct seq_file *sf)
+{
+	int nid;
+	struct numa_group *ng = tg->numa_group;
+
+	if (!ng) {
+		seq_puts(sf, "disabled\n");
+		return;
+	}
+
+	seq_printf(sf, "id %d nr_tasks %d active_nodes %d\n",
+		   ng->gid, ng->nr_tasks, ng->active_nodes);
+
+	for_each_online_node(nid) {
+		int f_idx = task_faults_idx(NUMA_MEM, nid, 0);
+		int pf_idx = task_faults_idx(NUMA_MEM, nid, 1);
+
+		seq_printf(sf, "node %d ", nid);
+
+		seq_printf(sf, "mem_private %lu mem_shared %lu ",
+			   ng->faults[f_idx], ng->faults[pf_idx]);
+
+		seq_printf(sf, "cpu_private %lu cpu_shared %lu\n",
+			   ng->faults_cpu[f_idx], ng->faults_cpu[pf_idx]);
+	}
+}
+
+int update_tg_numa_group(struct task_group *tg, bool numa_group)
+{
+	struct numa_group *ng = tg->numa_group;
+
+	/* if no change then do nothing */
+	if ((ng != NULL) == numa_group)
+		return 0;
+
+	if (ng) {
+		/* put and evacuate tg's numa group */
+		rcu_assign_pointer(tg->numa_group, NULL);
+		ng->evacuate = true;
+		put_numa_group(ng);
+	} else {
+		unsigned int size = sizeof(struct numa_group) +
+				    4*nr_node_ids*sizeof(unsigned long);
+
+		ng = kzalloc(size, GFP_KERNEL | __GFP_NOWARN);
+		if (!ng)
+			return -ENOMEM;
+
+		refcount_set(&ng->refcount, 1);
+		spin_lock_init(&ng->lock);
+		ng->faults_cpu = ng->faults + NR_NUMA_HINT_FAULT_TYPES *
+						nr_node_ids;
+		/* now make tasks see and join */
+		rcu_assign_pointer(tg->numa_group, ng);
+	}
+
+	return 0;
+}
+
+static bool tg_numa_group(struct task_struct *p)
+{
+	int i;
+	struct task_group *tg;
+	struct numa_group *grp, *my_grp;
+
+	rcu_read_lock();
+
+	tg = task_group(p);
+	if (!tg)
+		goto no_join;
+
+	grp = rcu_dereference(tg->numa_group);
+	my_grp = rcu_dereference(p->numa_group);
+
+	if (!grp)
+		goto no_join;
+
+	if (grp == my_grp) {
+		if (!grp->evacuate)
+			goto joined;
+
+		/*
+		 * Evacuate task from tg's numa group
+		 */
+		rcu_read_unlock();
+
+		spin_lock_irq(&grp->lock);
+
+		for (i = 0; i < NR_NUMA_HINT_FAULT_STATS * nr_node_ids; i++)
+			grp->faults[i] -= p->numa_faults[i];
+
+		grp->total_faults -= p->total_numa_faults;
+		grp->nr_tasks--;
+
+		spin_unlock_irq(&grp->lock);
+
+		rcu_assign_pointer(p->numa_group, NULL);
+
+		put_numa_group(grp);
+
+		return false;
+	}
+
+	if (!get_numa_group(grp))
+		goto no_join;
+
+	rcu_read_unlock();
+
+	/*
+	 * Just join tg's numa group
+	 */
+	if (!my_grp) {
+		spin_lock_irq(&grp->lock);
+
+		if (refcount_read(&grp->refcount) == 2) {
+			grp->gid = p->pid;
+			grp->active_nodes = 1;
+			grp->max_faults_cpu = 0;
+		}
+
+		for (i = 0; i < NR_NUMA_HINT_FAULT_STATS * nr_node_ids; i++)
+			grp->faults[i] += p->numa_faults[i];
+
+		grp->total_faults += p->total_numa_faults;
+		grp->nr_tasks++;
+
+		spin_unlock_irq(&grp->lock);
+		rcu_assign_pointer(p->numa_group, grp);
+
+		return true;
+	}
+
+	/*
+	 * Switch from the task's numa group to the tg's
+	 */
+	double_lock_irq(&my_grp->lock, &grp->lock);
+
+	if (refcount_read(&grp->refcount) == 2) {
+		grp->gid = p->pid;
+		grp->active_nodes = 1;
+		grp->max_faults_cpu = 0;
+	}
+
+	for (i = 0; i < NR_NUMA_HINT_FAULT_STATS * nr_node_ids; i++) {
+		my_grp->faults[i] -= p->numa_faults[i];
+		grp->faults[i] += p->numa_faults[i];
+	}
+
+	my_grp->total_faults -= p->total_numa_faults;
+	grp->total_faults += p->total_numa_faults;
+
+	my_grp->nr_tasks--;
+	grp->nr_tasks++;
+
+	spin_unlock(&my_grp->lock);
+	spin_unlock_irq(&grp->lock);
+
+	rcu_assign_pointer(p->numa_group, grp);
+
+	put_numa_group(my_grp);
+	return true;
+
+joined:
+	rcu_read_unlock();
+	return true;
+no_join:
+	rcu_read_unlock();
+	return false;
+}
+
 static void task_numa_group(struct task_struct *p, int cpupid, int flags,
 			int *priv)
 {
@@ -2416,7 +2587,9 @@ void task_numa_fault(int last_cpupid, int mem_node, int pages, int flags)
 		priv = 1;
 	} else {
 		priv = cpupid_match_pid(p, last_cpupid);
-		if (!priv && !(flags & TNF_NO_GROUP))
+		if (tg_numa_group(p))
+			priv = (flags & TNF_SHARED) ? 0 : priv;
+		else if (!priv && !(flags & TNF_NO_GROUP))
 			task_numa_group(p, last_cpupid, flags, &priv);
 	}

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 456f83f7f595..23e4a62cd37b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -408,6 +408,7 @@ struct task_group {

 #ifdef CONFIG_NUMA_BALANCING
 	struct numa_stat __percpu *numa_stat;
+	void *numa_group;
 #endif
 };

@@ -1316,11 +1317,21 @@ extern int migrate_task_to(struct task_struct *p, int cpu);
 extern int migrate_swap(struct task_struct *p, struct task_struct *t,
 			int cpu, int scpu);
 extern void init_numa_balancing(unsigned long clone_flags, struct task_struct *p);
+extern void show_tg_numa_group(struct task_group *tg, struct seq_file *sf);
+extern int update_tg_numa_group(struct task_group *tg, bool numa_group);
 #else
 static inline void
 init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
 {
 }
+static inline void
+show_tg_numa_group(struct task_group *tg, struct seq_file *sf)
+{
+}
+update_tg_numa_group(struct task_group *tg, bool numa_group)
+{
+	return 0;
+}
 #endif /* CONFIG_NUMA_BALANCING */

 #ifdef CONFIG_SMP
-- 
2.14.4.44.g2045bb6

