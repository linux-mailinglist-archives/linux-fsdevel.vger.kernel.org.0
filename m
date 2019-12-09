Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA77211722C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 17:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfLIQvg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 11:51:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47302 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726562AbfLIQvf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 11:51:35 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB9GlIf1125694
        for <linux-fsdevel@vger.kernel.org>; Mon, 9 Dec 2019 11:51:33 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wskq6shg8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Dec 2019 11:51:33 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Mon, 9 Dec 2019 16:51:30 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 9 Dec 2019 16:51:26 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB9GpPhK53674036
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Dec 2019 16:51:25 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFC64AE053;
        Mon,  9 Dec 2019 16:51:25 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 194CDAE056;
        Mon,  9 Dec 2019 16:51:23 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon,  9 Dec 2019 16:51:22 +0000 (GMT)
Date:   Mon, 9 Dec 2019 22:21:22 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Phil Auld <pauld@redhat.com>, Dave Chinner <david@fromorbit.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: single aio thread is migrated crazily by scheduler
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20191114235415.GL4614@dread.disaster.area>
 <20191115010824.GC4847@ming.t460p>
 <20191115045634.GN4614@dread.disaster.area>
 <20191115070843.GA24246@ming.t460p>
 <20191115234005.GO4614@dread.disaster.area>
 <20191118092121.GV4131@hirez.programming.kicks-ass.net>
 <20191118204054.GV4614@dread.disaster.area>
 <20191120191636.GI4097@hirez.programming.kicks-ass.net>
 <20191120220313.GC18056@pauld.bos.csb>
 <20191121132937.GW4114@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20191121132937.GW4114@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 19120916-0028-0000-0000-000003C6F00A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120916-0029-0000-0000-0000248A1C82
Message-Id: <20191209165122.GA27229@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-09_04:2019-12-09,2019-12-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 suspectscore=2 priorityscore=1501 spamscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912090142
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Peter Zijlstra <peterz@infradead.org> [2019-11-21 14:29:37]:

> On Wed, Nov 20, 2019 at 05:03:13PM -0500, Phil Auld wrote:
> > On Wed, Nov 20, 2019 at 08:16:36PM +0100 Peter Zijlstra wrote:
> > > On Tue, Nov 19, 2019 at 07:40:54AM +1100, Dave Chinner wrote:
> 
> > > > Yes, that's precisely the problem - work is queued, by default, on a
> > > > specific CPU and it will wait for a kworker that is pinned to that
> > > 
> > > I'm thinking the problem is that it doesn't wait. If it went and waited
> > > for it, active balance wouldn't be needed, that only works on active
> > > tasks.
> > 
> > Since this is AIO I wonder if it should queue_work on a nearby cpu by 
> > default instead of unbound.  
> 
> The thing seems to be that 'unbound' is in fact 'bound'. Maybe we should
> fix that. If the load-balancer were allowed to move the kworker around
> when it didn't get time to run, that would probably be a better
> solution.
> 
 
Can the scheduler detect this situation and probably preempt the current
task?

----->8-------------------------------------------8<------------------

From 578407a0d01fa458ccb412f3390b04d3e1030d33 Mon Sep 17 00:00:00 2001
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Date: Sat, 7 Dec 2019 08:50:54 +0530
Subject: [RFC PATCH] sched/core: Preempt current task in favour of bound kthread

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
event					v5.4 				v5.4 + patch
probe:active_load_balance_cpu_stop     1,740  ( +-  4.06% )                4  ( +- 15.41% )
sched:sched_waking                   431,952  ( +-  0.63% )          905,001  ( +-  0.25% )
sched:sched_wakeup                   431,950  ( +-  0.63% )          905,000  ( +-  0.25% )
sched:sched_wakeup_new                   427  ( +- 14.50% )              544  ( +-  3.11% )
sched:sched_switch                   773,491  ( +-  0.72% )        1,467,539  ( +-  0.30% )
sched:sched_migrate_task              19,744  ( +-  0.69% )            2,488  ( +-  5.24% )
sched:sched_process_free                 417  ( +- 15.26% )              545  ( +-  3.47% )
sched:sched_process_exit                 433  ( +- 14.71% )              560  ( +-  3.37% )
sched:sched_wait_task                      3  ( +- 23.57% )                1  ( +- 61.24% )
sched:sched_process_wait                 132  ( +- 80.37% )              848  ( +-  3.63% )
sched:sched_process_fork                 427  ( +- 14.50% )              543  ( +-  3.08% )
sched:sched_process_exec                  36  ( +- 92.46% )              211  ( +-  7.50% )
sched:sched_wake_idle_without_ipi    178,349  ( +-  0.87% )          351,912  ( +-  0.31% )

elapsed time in seconds       288.09 +- 2.30  ( +-  0.80% )   72.631 +- 0.109 ( +-  0.15% )

Throughput results

v5.4
Trigger time:................... 0.842679 s   (Throughput:     6075.86 MB/s)
Asynchronous submit time:.......   1.0184 s   (Throughput:     5027.49 MB/s)
Synchronous submit time:........        0 s   (Throughput:           0 MB/s)
I/O time:.......................   263.17 s   (Throughput:      19.455 MB/s)
Ratio trigger time to I/O time:.0.00320202

v5.4 + patch
Trigger time:................... 0.858728 s   (Throughput:      5962.3 MB/s)
Asynchronous submit time:....... 0.758399 s   (Throughput:     6751.06 MB/s)
Synchronous submit time:........        0 s   (Throughput:           0 MB/s)
I/O time:.......................   43.411 s   (Throughput:     117.942 MB/s)
Ratio trigger time to I/O time:.0.0197813

(With sched_wake_up_granularity set to 4ms)

Performance counter stats for 'system wide' (5 runs):
event					      v5.4 				v5.4 + patch
probe:active_load_balance_cpu_stop               4  ( +- 29.92% )                  6  ( +- 21.88% )
sched:sched_waking                         896,177  ( +-  0.25% )            900,352  ( +-  0.36% )
sched:sched_wakeup                         896,174  ( +-  0.25% )            900,352  ( +-  0.36% )
sched:sched_wakeup_new                         255  ( +- 40.79% )                568  ( +-  4.22% )
sched:sched_switch                       1,453,937  ( +-  0.27% )          1,459,653  ( +-  0.46% )
sched:sched_migrate_task                     2,318  ( +-  6.55% )              2,898  ( +- 13.14% )
sched:sched_process_free                       239  ( +- 43.14% )                553  ( +-  4.46% )
sched:sched_process_exit                       255  ( +- 40.54% )                568  ( +-  4.33% )
sched:sched_wait_task                            3  ( +- 38.13% )                  2  ( +- 32.39% )
sched:sched_process_wait                       257  ( +- 68.90% )                887  ( +-  4.59% )
sched:sched_process_fork                       255  ( +- 40.87% )                567  ( +-  4.21% )
sched:sched_process_exec                       116  ( +- 71.52% )                214  ( +-  4.51% )
sched:sched_stat_runtime            82,757,021,750  ( +-  2.38% )     82,092,839,452  ( +-  0.31% )
sched:sched_wake_idle_without_ipi          347,790  ( +-  0.69% )            350,369  ( +-  0.27% )

elapsed time in seconds           72.6114 +- 0.0516 ( +-  0.07% )   72.6425 +- 0.0658 ( +-  0.09% )

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 kernel/sched/core.c  |  7 ++++++-
 kernel/sched/fair.c  | 23 ++++++++++++++++++++++-
 kernel/sched/sched.h |  3 ++-
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 44123b4d14e8..efd740aafa17 100644
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
+	return try_to_wake_up(p, TASK_NORMAL, WF_KTHREAD);
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

