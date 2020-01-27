Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C666714A668
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 15:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgA0OnQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 09:43:16 -0500
Received: from outbound-smtp34.blacknight.com ([46.22.139.253]:55119 "EHLO
        outbound-smtp34.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726443AbgA0OnQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 09:43:16 -0500
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Jan 2020 09:43:14 EST
Received: from mail.blacknight.com (unknown [81.17.255.152])
        by outbound-smtp34.blacknight.com (Postfix) with ESMTPS id A3676B9E
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jan 2020 14:36:10 +0000 (GMT)
Received: (qmail 26736 invoked from network); 27 Jan 2020 14:36:10 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 27 Jan 2020 14:36:10 -0000
Date:   Mon, 27 Jan 2020 14:36:08 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sched, fair: Allow a per-cpu kthread waking a task to stack
 on the same CPU
Message-ID: <20200127143608.GX3466@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit 8ab39f11d974 ("xfs: prevent CIL push holdoff in log
recovery") changed from using bound workqueues to using unbound
workqueues. Functionally this makes sense but it was observed at the time
that the dbench performance dropped quite a lot and CPU migrations were
excessively high even when there are plenty of idle CPUs.

The pattern of the task migration is straight-forward. With XFS, an IO
issuer may delegate work to a kworker which wakes on the same CPU. On
completion of the work, it wakes the task, finds that the previous CPU
is busy (because the kworker is still running on it) and migrates the
task to the next idle CPU. The task ends up migrating around all CPUs
sharing a LLC at high frequency. This has negative implications both in
commication costs and power management.  mpstat confirmed that at low
thread counts that all CPUs sharing an LLC has low level of activity.

The impact of this problem is related to the number of CPUs sharing an LLC.

This patch special cases the pattern and allows a kworker waker and a
task wakee to stack on the same CPU if there is a strong chance they are
directly related. The expectation is that the kworker is likely going
back to sleep shortly. This is not guaranteed as the IO could be queued
asynchronously but there is a very strong relationship between the task and
kworker in this case that would justify stacking on the same CPU instead
of migrating. There should be few concerns about kworker starvation given
that the special casing is only when the kworker is the waker.

DBench on XFS
MMTests config: io-dbench4-async modified to run on a fresh XFS filesystem

UMA machine with 8 cores sharing LLC
                          5.5.0-rc7              5.5.0-rc7
                  tipsched-20200124           kworkerstack
Amean     1        22.63 (   0.00%)       20.54 *   9.23%*
Amean     2        25.56 (   0.00%)       23.40 *   8.44%*
Amean     4        28.63 (   0.00%)       27.85 *   2.70%*
Amean     8        37.66 (   0.00%)       37.68 (  -0.05%)
Amean     64      469.47 (   0.00%)      468.26 (   0.26%)
Stddev    1         1.00 (   0.00%)        0.72 (  28.12%)
Stddev    2         1.62 (   0.00%)        1.97 ( -21.54%)
Stddev    4         2.53 (   0.00%)        3.58 ( -41.19%)
Stddev    8         5.30 (   0.00%)        5.20 (   1.92%)
Stddev    64       86.36 (   0.00%)       94.53 (  -9.46%)

NUMA machine, 48 CPUs total, 24 CPUs share cache
                           5.5.0-rc7              5.5.0-rc7
                   tipsched-20200124      kworkerstack-v1r2
Amean     1         58.69 (   0.00%)       30.21 *  48.53%*
Amean     2         60.90 (   0.00%)       35.29 *  42.05%*
Amean     4         66.77 (   0.00%)       46.55 *  30.28%*
Amean     8         81.41 (   0.00%)       68.46 *  15.91%*
Amean     16       113.29 (   0.00%)      107.79 *   4.85%*
Amean     32       199.10 (   0.00%)      198.22 *   0.44%*
Amean     64       478.99 (   0.00%)      477.06 *   0.40%*
Amean     128     1345.26 (   0.00%)     1372.64 *  -2.04%*
Stddev    1          2.64 (   0.00%)        4.17 ( -58.08%)
Stddev    2          4.35 (   0.00%)        5.38 ( -23.73%)
Stddev    4          6.77 (   0.00%)        6.56 (   3.00%)
Stddev    8         11.61 (   0.00%)       10.91 (   6.04%)
Stddev    16        18.63 (   0.00%)       19.19 (  -3.01%)
Stddev    32        38.71 (   0.00%)       38.30 (   1.06%)
Stddev    64       100.28 (   0.00%)       91.24 (   9.02%)
Stddev    128      186.87 (   0.00%)      160.34 (  14.20%)

Dbench has been modified to report the time to complete a single "load
file". This is a more meaningful metric for dbench that a throughput
metric as the benchmark makes many different system calls that are not
throughput-related

Patch shows a 9.23% and 48.53% reduction in the time to process a load
file with the difference partially explained by the number of CPUs sharing
a LLC. In a separate run, task migrations were almost eliminated by the
patch for low client counts. In case people have issue with the metric
used for the benchmark, this is a comparison of the throughputs as
reported by dbench on the NUMA machine.

dbench4 Throughput (misleading but traditional)
                           5.5.0-rc7              5.5.0-rc7
                   tipsched-20200124      kworkerstack-v1r2
Hmean     1        321.41 (   0.00%)      617.82 *  92.22%*
Hmean     2        622.87 (   0.00%)     1066.80 *  71.27%*
Hmean     4       1134.56 (   0.00%)     1623.74 *  43.12%*
Hmean     8       1869.96 (   0.00%)     2212.67 *  18.33%*
Hmean     16      2673.11 (   0.00%)     2806.13 *   4.98%*
Hmean     32      3032.74 (   0.00%)     3039.54 (   0.22%)
Hmean     64      2514.25 (   0.00%)     2498.96 *  -0.61%*
Hmean     128     1778.49 (   0.00%)     1746.05 *  -1.82%*

Note that this is somewhat specific to XFS and ext4 shows no performance
difference as it does not rely on kworkers in the same way. No major
problem was observed running other workloads on different machines although
not all tests have completed yet.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/core.c  | 11 -----------
 kernel/sched/fair.c  | 13 +++++++++++++
 kernel/sched/sched.h | 13 +++++++++++++
 3 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fc1dfc007604..1f615a223791 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1442,17 +1442,6 @@ void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags)
 
 #ifdef CONFIG_SMP
 
-static inline bool is_per_cpu_kthread(struct task_struct *p)
-{
-	if (!(p->flags & PF_KTHREAD))
-		return false;
-
-	if (p->nr_cpus_allowed != 1)
-		return false;
-
-	return true;
-}
-
 /*
  * Per-CPU kthreads are allowed to run on !active && online CPUs, see
  * __set_cpus_allowed_ptr() and select_fallback_rq().
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fe4e0d775375..76df439aff76 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5912,6 +5912,19 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	    (available_idle_cpu(prev) || sched_idle_cpu(prev)))
 		return prev;
 
+	/*
+	 * Allow a per-cpu kthread to stack with the wakee if the
+	 * kworker thread and the tasks previous CPU are the same.
+	 * The assumption is that the wakee queued work for the
+	 * per-cpu kthread that is now complete and the wakeup is
+	 * essentially a sync wakeup.
+	 */
+	if (is_per_cpu_kthread(current) &&
+	    prev == smp_processor_id() &&
+	    this_rq()->nr_running <= 1) {
+		return prev;
+	}
+
 	/* Check a recently used CPU as a potential idle candidate: */
 	recent_used_cpu = p->recent_used_cpu;
 	if (recent_used_cpu != prev &&
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1a88dc8ad11b..5876e6ba5903 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2479,3 +2479,16 @@ static inline void membarrier_switch_mm(struct rq *rq,
 {
 }
 #endif
+
+#ifdef CONFIG_SMP
+static inline bool is_per_cpu_kthread(struct task_struct *p)
+{
+	if (!(p->flags & PF_KTHREAD))
+		return false;
+
+	if (p->nr_cpus_allowed != 1)
+		return false;
+
+	return true;
+}
+#endif
