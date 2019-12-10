Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46570117FE5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 06:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfLJFno (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 00:43:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19520 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726085AbfLJFnn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 00:43:43 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBA5gATS125270
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2019 00:43:41 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wrt9xs44q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2019 00:43:41 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Tue, 10 Dec 2019 05:43:39 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 10 Dec 2019 05:43:34 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBA5hXDa46727516
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Dec 2019 05:43:33 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B29A1A4066;
        Tue, 10 Dec 2019 05:43:33 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E9402A4054;
        Tue, 10 Dec 2019 05:43:30 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue, 10 Dec 2019 05:43:30 +0000 (GMT)
Date:   Tue, 10 Dec 2019 11:13:30 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2] sched/core: Preempt current task in favour of bound
 kthread
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20191115045634.GN4614@dread.disaster.area>
 <20191115070843.GA24246@ming.t460p>
 <20191115234005.GO4614@dread.disaster.area>
 <20191118092121.GV4131@hirez.programming.kicks-ass.net>
 <20191118204054.GV4614@dread.disaster.area>
 <20191120191636.GI4097@hirez.programming.kicks-ass.net>
 <20191120220313.GC18056@pauld.bos.csb>
 <20191121132937.GW4114@hirez.programming.kicks-ass.net>
 <20191209165122.GA27229@linux.vnet.ibm.com>
 <20191209231743.GA19256@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20191209231743.GA19256@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 19121005-0008-0000-0000-0000033F5724
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121005-0009-0000-0000-00004A5E868F
Message-Id: <20191210054330.GF27253@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-10_01:2019-12-10,2019-12-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 suspectscore=2 mlxscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912100052
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A running task can wake-up a per CPU bound kthread on the same CPU.
If the current running task doesn't yield the CPU before the next load
balance operation, the scheduler would detect load imbalance and try to
balance the load. However this load balance would fail as the waiting
task is CPU bound, while the running task cannot be moved by the regular
load balancer. Finally the active load balancer would kick in and move
the task to a different CPU/Core. Moving the task to a different
CPU/core can lead to loss in cache affinity leading to poor performance.

This is more prone to happen if the current running task is CPU
intensive and the sched_wake_up_granularity is set to larger value.
When the sched_wake_up_granularity was relatively small, it was observed
that the bound thread would complete before the load balancer would have
chosen to move the cache hot task to a different CPU.

To deal with this situation, the current running task would yield to a
per CPU bound kthread, provided kthread is not CPU intensive.

/pboffline/hwcct_prg_old/lib/fsperf -t overwrite --noclean -f 5g -b 4k /pboffline

(With sched_wake_up_granularity set to 15ms)

Performance counter stats for 'system wide' (5 runs):
event					     v5.4                               v5.4 + patch(v2)
probe:active_load_balance_cpu_stop       1,919  ( +-  2.89% )                   5  ( +- 12.56% )
sched:sched_waking                     441,535  ( +-  0.17% )             901,174  ( +-  0.25% )
sched:sched_wakeup                     441,533  ( +-  0.17% )             901,172  ( +-  0.25% )
sched:sched_wakeup_new                   2,436  ( +-  8.08% )                 525  ( +-  2.57% )
sched:sched_switch                     797,007  ( +-  0.26% )           1,458,463  ( +-  0.24% )
sched:sched_migrate_task                20,998  ( +-  1.04% )               2,279  ( +-  3.47% )
sched:sched_process_free                 2,436  ( +-  7.90% )                 527  ( +-  2.30% )
sched:sched_process_exit                 2,451  ( +-  7.85% )                 542  ( +-  2.24% )
sched:sched_wait_task                        7  ( +- 21.20% )                   1  ( +- 77.46% )
sched:sched_process_wait                 3,951  ( +-  9.14% )                 816  ( +-  3.52% )
sched:sched_process_fork                 2,435  ( +-  8.09% )                 524  ( +-  2.58% )
sched:sched_process_exec                 1,023  ( +- 12.21% )                 198  ( +-  3.23% )
sched:sched_wake_idle_without_ipi      187,794  ( +-  1.14% )             348,565  ( +-  0.34% )

Elasped time in seconds          289.43 +- 1.42 ( +-  0.49% )    72.6013 +- 0.0417 ( +-  0.06% )
Throughput results

v5.4
Trigger time:................... 0.842679 s   (Throughput:     6075.86 MB/s)
Asynchronous submit time:.......   1.0184 s   (Throughput:     5027.49 MB/s)
Synchronous submit time:........        0 s   (Throughput:           0 MB/s)
I/O time:.......................   263.17 s   (Throughput:      19.455 MB/s)
Ratio trigger time to I/O time:.0.00320202

v5.4 + patch(v2)
Trigger time:................... 0.853973 s   (Throughput:      5995.5 MB/s)
Asynchronous submit time:....... 0.768092 s   (Throughput:     6665.86 MB/s)
Synchronous submit time:........        0 s   (Throughput:           0 MB/s)
I/O time:.......................  44.0267 s   (Throughput:     116.292 MB/s)
Ratio trigger time to I/O time:.0.0193966

(With sched_wake_up_granularity set to 4ms)

Performance counter stats for 'system wide' (5 runs):
event					      v5.4 				v5.4 + patch(v2)
probe:active_load_balance_cpu_stop               6  ( +-  6.03% )                   5  ( +- 23.20% )
sched:sched_waking                         899,880  ( +-  0.38% )             899,737  ( +-  0.41% )
sched:sched_wakeup                         899,878  ( +-  0.38% )             899,736  ( +-  0.41% )
sched:sched_wakeup_new                         622  ( +- 11.95% )                 499  ( +-  1.08% )
sched:sched_switch                       1,458,214  ( +-  0.40% )           1,451,374  ( +-  0.32% )
sched:sched_migrate_task                     3,120  ( +- 10.00% )               2,500  ( +- 10.86% )
sched:sched_process_free                       608  ( +- 12.18% )                 484  ( +-  1.19% )
sched:sched_process_exit                       623  ( +- 11.91% )                 499  ( +-  1.15% )
sched:sched_wait_task                            1  ( +- 31.18% )                   1  ( +- 31.18% )
sched:sched_process_wait                       998  ( +- 13.22% )                 765  ( +-  0.16% )
sched:sched_process_fork                       622  ( +- 11.95% )                 498  ( +-  1.08% )
sched:sched_process_exec                       242  ( +- 13.81% )                 183  ( +-  0.48% )
sched:sched_wake_idle_without_ipi          349,165  ( +-  0.35% )             347,773  ( +-  0.43% )

Elasped time in seconds           72.8560 +- 0.0768 ( +-  0.11% )     72.4327 +- 0.0797 ( +-  0.11% )

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
Changelog:
v1 : http://lore.kernel.org/lkml/20191209165122.GA27229@linux.vnet.ibm.com
v1->v2: Pass the the right params to try_to_wake_up as correctly pointed out
by Dave Chinner


 kernel/sched/core.c  |  7 ++++++-
 kernel/sched/fair.c  | 23 ++++++++++++++++++++++-
 kernel/sched/sched.h |  3 ++-
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 44123b4d14e8..82126cbf62cd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2664,7 +2664,12 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
  */
 int wake_up_process(struct task_struct *p)
 {
-	return try_to_wake_up(p, TASK_NORMAL, 0);
+	int wake_flags = 0;
+
+	if (is_per_cpu_kthread(p))
+		wake_flags = WF_KTHREAD;
+
+	return try_to_wake_up(p, TASK_NORMAL, wake_flags);
 }
 EXPORT_SYMBOL(wake_up_process);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 69a81a5709ff..36486f71e59f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6660,6 +6660,27 @@ static void set_skip_buddy(struct sched_entity *se)
 		cfs_rq_of(se)->skip = se;
 }
 
+static int kthread_wakeup_preempt(struct rq *rq, struct task_struct *p, int wake_flags)
+{
+	struct task_struct *curr = rq->curr;
+	struct cfs_rq *cfs_rq = task_cfs_rq(curr);
+
+	if (!(wake_flags & WF_KTHREAD))
+		return 0;
+
+	if (p->nr_cpus_allowed != 1 || curr->nr_cpus_allowed == 1)
+		return 0;
+
+	if (cfs_rq->nr_running > 2)
+		return 0;
+
+	/*
+	 * Don't preempt, if the waking kthread is more CPU intensive than
+	 * the current thread.
+	 */
+	return p->nvcsw * curr->nivcsw >= p->nivcsw * curr->nvcsw;
+}
+
 /*
  * Preempt the current task with a newly woken task if needed:
  */
@@ -6716,7 +6737,7 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 	find_matching_se(&se, &pse);
 	update_curr(cfs_rq_of(se));
 	BUG_ON(!pse);
-	if (wakeup_preempt_entity(se, pse) == 1) {
+	if (wakeup_preempt_entity(se, pse) == 1 || kthread_wakeup_preempt(rq, p, wake_flags)) {
 		/*
 		 * Bias pick_next to pick the sched entity that is
 		 * triggering this preemption.
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c8870c5bd7df..23d4284ad1e3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1643,7 +1643,8 @@ static inline int task_on_rq_migrating(struct task_struct *p)
  */
 #define WF_SYNC			0x01		/* Waker goes to sleep after wakeup */
 #define WF_FORK			0x02		/* Child wakeup after fork */
-#define WF_MIGRATED		0x4		/* Internal use, task got migrated */
+#define WF_MIGRATED		0x04		/* Internal use, task got migrated */
+#define WF_KTHREAD		0x08		/* Per CPU Kthread*/
 
 /*
  * To aid in avoiding the subversion of "niceness" due to uneven distribution
-- 
2.18.1

