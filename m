Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7195DCFF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2019 05:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbfGCD2P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jul 2019 23:28:15 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:49023 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727349AbfGCD2O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jul 2019 23:28:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0TVvMc2s_1562124490;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TVvMc2s_1562124490)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 03 Jul 2019 11:28:10 +0800
Subject: [PATCH 1/4] numa: introduce per-cgroup numa balancing locality,
 statistic
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
To:     Peter Zijlstra <peterz@infradead.org>, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mcgrof@kernel.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org
References: <209d247e-c1b2-3235-2722-dd7c1f896483@linux.alibaba.com>
 <60b59306-5e36-e587-9145-e90657daec41@linux.alibaba.com>
Message-ID: <3ac9b43a-cc80-01be-0079-df008a71ce4b@linux.alibaba.com>
Date:   Wed, 3 Jul 2019 11:28:10 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <60b59306-5e36-e587-9145-e90657daec41@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch introduced numa locality statistic, which try to imply
the numa balancing efficiency per memory cgroup.

By doing 'cat /sys/fs/cgroup/memory/CGROUP_PATH/memory.numa_stat', we
see new output line heading with 'locality', the format is:

  locality 0%~29% 30%~39% 40%~49% 50%~59% 60%~69% 70%~79% 80%~89%
90%~100%

interval means that on a task's last numa balancing, the percentage
of accessing local pages, which we called numa balancing locality.

And the number means inside the cgroup, how many micro seconds tasks
with that locality are running, for example:

  locality 15393 21259 13023 44461 21247 17012 28496 145402

the first number means that this cgroup have some tasks with 0~29%
locality executed 15393 ms.

By monitoring the increment, we can check if the workload of a
particular
cgroup is doing well with numa, when most of the tasks are running with
locality 0~29%, then something is wrong with your numa policy.

Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
---
 include/linux/memcontrol.h | 36 +++++++++++++++++++++++++++++++
 include/linux/sched.h      |  8 ++++++-
 kernel/sched/debug.c       |  7 ++++++
 kernel/sched/fair.c        |  9 ++++++++
 mm/memcontrol.c            | 53 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 112 insertions(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 2cbce1fe7780..0a30d14c9f43 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -174,6 +174,25 @@ enum memcg_kmem_state {
 	KMEM_ONLINE,
 };

+#ifdef CONFIG_NUMA_BALANCING
+
+enum memcg_numa_locality_interval {
+	PERCENT_0_29,
+	PERCENT_30_39,
+	PERCENT_40_49,
+	PERCENT_50_59,
+	PERCENT_60_69,
+	PERCENT_70_79,
+	PERCENT_80_89,
+	PERCENT_90_100,
+	NR_NL_INTERVAL,
+};
+
+struct memcg_stat_numa {
+	u64 locality[NR_NL_INTERVAL];
+};
+
+#endif
 #if defined(CONFIG_SMP)
 struct memcg_padding {
 	char x[0];
@@ -313,6 +332,10 @@ struct mem_cgroup {
 	struct list_head event_list;
 	spinlock_t event_list_lock;

+#ifdef CONFIG_NUMA_BALANCING
+	struct memcg_stat_numa __percpu *stat_numa;
+#endif
+
 	struct mem_cgroup_per_node *nodeinfo[0];
 	/* WARNING: nodeinfo must be the last member here */
 };
@@ -795,6 +818,14 @@ static inline void memcg_memory_event_mm(struct mm_struct *mm,
 void mem_cgroup_split_huge_fixup(struct page *head);
 #endif

+#ifdef CONFIG_NUMA_BALANCING
+extern void memcg_stat_numa_update(struct task_struct *p);
+#else
+static inline void memcg_stat_numa_update(struct task_struct *p)
+{
+}
+#endif
+
 #else /* CONFIG_MEMCG */

 #define MEM_CGROUP_ID_SHIFT	0
@@ -1131,6 +1162,11 @@ static inline
 void count_memcg_event_mm(struct mm_struct *mm, enum vm_event_item idx)
 {
 }
+
+static inline void memcg_stat_numa_update(struct task_struct *p)
+{
+}
+
 #endif /* CONFIG_MEMCG */

 /* idx can be of type enum memcg_stat_item or node_stat_item */
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
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index f7e4579e746c..473e6b7a1b8d 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -849,6 +849,13 @@ static void sched_show_numa(struct task_struct *p, struct seq_file *m)
 	SEQ_printf(m, "current_node=%d, numa_group_id=%d\n",
 			task_node(p), task_numa_group_id(p));
 	show_numa_stats(p, m);
+	SEQ_printf(m, "faults_locality local=%lu remote=%lu failed=%lu ",
+			p->numa_faults_locality[1],
+			p->numa_faults_locality[0],
+			p->numa_faults_locality[2]);
+	SEQ_printf(m, "lhit=%lu rhit=%lu\n",
+			p->numa_faults_locality[4],
+			p->numa_faults_locality[3]);
 	mpol_put(pol);
 #endif
 }
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 036be95a87e9..b32304817eeb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -23,6 +23,7 @@
 #include "sched.h"

 #include <trace/events/sched.h>
+#include <linux/memcontrol.h>

 /*
  * Targeted preemption latency for CPU-bound tasks:
@@ -2449,6 +2450,12 @@ void task_numa_fault(int last_cpupid, int mem_node, int pages, int flags)
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
@@ -2625,6 +2632,8 @@ static void task_tick_numa(struct rq *rq, struct task_struct *curr)
 	if (!curr->mm || (curr->flags & PF_EXITING) || work->next != work)
 		return;

+	memcg_stat_numa_update(curr);
+
 	/*
 	 * Using runtime rather than walltime has the dual advantage that
 	 * we (mostly) drive the selection from busy threads and that the
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b3f67a6b6527..2edf3f5ac4b9 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -58,6 +58,7 @@
 #include <linux/file.h>
 #include <linux/tracehook.h>
 #include <linux/seq_buf.h>
+#include <linux/cpuset.h>
 #include "internal.h"
 #include <net/sock.h>
 #include <net/ip.h>
@@ -3562,10 +3563,53 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
 		seq_putc(m, '\n');
 	}

+#ifdef CONFIG_NUMA_BALANCING
+	seq_puts(m, "locality");
+	for (nr = 0; nr < NR_NL_INTERVAL; nr++) {
+		int cpu;
+		u64 sum = 0;
+
+		for_each_possible_cpu(cpu)
+			sum += per_cpu(memcg->stat_numa->locality[nr], cpu);
+
+		seq_printf(m, " %u", jiffies_to_msecs(sum));
+	}
+	seq_putc(m, '\n');
+#endif
+
 	return 0;
 }
 #endif /* CONFIG_NUMA */

+#ifdef CONFIG_NUMA_BALANCING
+
+void memcg_stat_numa_update(struct task_struct *p)
+{
+	struct mem_cgroup *memcg;
+	unsigned long remote = p->numa_faults_locality[3];
+	unsigned long local = p->numa_faults_locality[4];
+	unsigned long idx = -1;
+
+	if (mem_cgroup_disabled())
+		return;
+
+	if (remote || local) {
+		idx = ((local * 10) / (remote + local)) - 2;
+		/* 0~29% in one slot for cache align */
+		if (idx < PERCENT_0_29)
+			idx = PERCENT_0_29;
+		else if (idx >= NR_NL_INTERVAL)
+			idx = NR_NL_INTERVAL - 1;
+	}
+
+	rcu_read_lock();
+	memcg = mem_cgroup_from_task(p);
+	if (idx != -1)
+		this_cpu_inc(memcg->stat_numa->locality[idx]);
+	rcu_read_unlock();
+}
+#endif
+
 static const unsigned int memcg1_stats[] = {
 	MEMCG_CACHE,
 	MEMCG_RSS,
@@ -4641,6 +4685,9 @@ static void __mem_cgroup_free(struct mem_cgroup *memcg)

 	for_each_node(node)
 		free_mem_cgroup_per_node_info(memcg, node);
+#ifdef CONFIG_NUMA_BALANCING
+	free_percpu(memcg->stat_numa);
+#endif
 	free_percpu(memcg->vmstats_percpu);
 	free_percpu(memcg->vmstats_local);
 	kfree(memcg);
@@ -4679,6 +4726,12 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	if (!memcg->vmstats_percpu)
 		goto fail;

+#ifdef CONFIG_NUMA_BALANCING
+	memcg->stat_numa = alloc_percpu(struct memcg_stat_numa);
+	if (!memcg->stat_numa)
+		goto fail;
+#endif
+
 	for_each_node(node)
 		if (alloc_mem_cgroup_per_node_info(memcg, node))
 			goto fail;
-- 
2.14.4.44.g2045bb6

