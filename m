Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB6311CA4C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 11:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbfLLKKr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 05:10:47 -0500
Received: from merlin.infradead.org ([205.233.59.134]:38538 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfLLKKr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 05:10:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cyHBd48uymSk+HX6YSv2rvFf3J2j8QaEFcl33tEALdE=; b=N4qCEueCWcdZtRUbvlyVh9ZNP
        lrj8J1pNZhcMlaYy8vmD5JD90MgRyGhnk51G8izKkUm7AmcEVZj3LUolC+DV4l025qznUvwEBVwur
        6hIqssj+0/BOUZTDyGmvVcRuuoIUu72pIuWnBxzxoX28U+c9a+nM5CvG8D17d6FRGvplmcamOHeJQ
        uJWV6s2ASY8FXShBTPXJG0eKsItLD/A0zEeGlIPctzvBlO8AV/KOdQRbExpJeShpKJtSAKzx3iB4x
        cT7uutJJHizOeLeHgEHVB8IDNvdYBuI9phlIUtUJ5gJgtUgBCis1UCUO0uOxInlbjeyrAsgxdQ8ng
        aq0yiDyfA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifLQY-0007AL-Vk; Thu, 12 Dec 2019 10:10:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B579C305FEE;
        Thu, 12 Dec 2019 11:09:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 005FB2012196F; Thu, 12 Dec 2019 11:10:31 +0100 (CET)
Date:   Thu, 12 Dec 2019 11:10:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Phil Auld <pauld@redhat.com>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v4] sched/core: Preempt current task in favour of bound
 kthread
Message-ID: <20191212101031.GV2827@hirez.programming.kicks-ass.net>
References: <20191118204054.GV4614@dread.disaster.area>
 <20191120191636.GI4097@hirez.programming.kicks-ass.net>
 <20191120220313.GC18056@pauld.bos.csb>
 <20191121132937.GW4114@hirez.programming.kicks-ass.net>
 <20191209165122.GA27229@linux.vnet.ibm.com>
 <20191209231743.GA19256@dread.disaster.area>
 <20191210054330.GF27253@linux.vnet.ibm.com>
 <20191210172307.GD9139@linux.vnet.ibm.com>
 <20191211173829.GB21797@linux.vnet.ibm.com>
 <20191211224617.GE19256@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211224617.GE19256@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 12, 2019 at 09:46:17AM +1100, Dave Chinner wrote:
> On Wed, Dec 11, 2019 at 11:08:29PM +0530, Srikar Dronamraju wrote:
> > A running task can wake-up a per CPU bound kthread on the same CPU.
> > If the current running task doesn't yield the CPU before the next load
> > balance operation, the scheduler would detect load imbalance and try to
> > balance the load. However this load balance would fail as the waiting
> > task is CPU bound, while the running task cannot be moved by the regular
> > load balancer. Finally the active load balancer would kick in and move
> > the task to a different CPU/Core. Moving the task to a different
> > CPU/core can lead to loss in cache affinity leading to poor performance.
> > 
> > This is more prone to happen if the current running task is CPU
> > intensive and the sched_wake_up_granularity is set to larger value.
> > When the sched_wake_up_granularity was relatively small, it was observed
> > that the bound thread would complete before the load balancer would have
> > chosen to move the cache hot task to a different CPU.
> > 
> > To deal with this situation, the current running task would yield to a
> > per CPU bound kthread, provided kthread is not CPU intensive.
> 
> So a question for you here: when does the workqueue worker pre-empt
> the currently running task? Is it immediately? Or when a time-slice
> of the currently running task runs out?
> 
> We don't want queued work immediately pre-empting the task that
> queued the work - the queued work is *deferred* work that should be
> run _soon_ but we want the currently running task to finish what it
> is doing first if possible. 

Good point, something to maybe try (Srikar?) is making tick preemption
more agressive for such tasks.

The below extends the previous patch to retain the set_next_buddy() on
wakeup, but does not make the actual preemption more agressive.

Then it 'fixes' the tick preemption to better align with the actual
scheduler pick (ie. consider the buddy hints).

---
 kernel/sched/core.c  |  3 +++
 kernel/sched/fair.c  | 26 +++++++++++++++++++-------
 kernel/sched/sched.h |  3 ++-
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 90e4b00ace89..75738b136ea7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2560,6 +2560,9 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	success = 1;
 	cpu = task_cpu(p);
 
+	if (is_per_cpu_kthread(p))
+		wake_flags |= WF_KTHREAD;
+
 	/*
 	 * Ensure we load p->on_rq _after_ p->state, otherwise it would
 	 * be possible to, falsely, observe p->on_rq == 0 and get stuck
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 08a233e97a01..78e681c8c19a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4126,6 +4126,9 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		update_min_vruntime(cfs_rq);
 }
 
+static struct sched_entity *
+__pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr);
+
 /*
  * Preempt the current task with a newly woken task if needed:
  */
@@ -4156,13 +4159,13 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 	if (delta_exec < sysctl_sched_min_granularity)
 		return;
 
-	se = __pick_first_entity(cfs_rq);
+	se = __pick_next_entity(cfs_rq, NULL);
 	delta = curr->vruntime - se->vruntime;
 
 	if (delta < 0)
 		return;
 
-	if (delta > ideal_runtime)
+	if (delta > ideal_runtime) // maybe frob this too ?
 		resched_curr(rq_of(cfs_rq));
 }
 
@@ -4210,7 +4213,7 @@ wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se);
  * 4) do not run the "skip" process, if something else is available
  */
 static struct sched_entity *
-pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
+__pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 {
 	struct sched_entity *left = __pick_first_entity(cfs_rq);
 	struct sched_entity *se;
@@ -4255,8 +4258,14 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 	if (cfs_rq->next && wakeup_preempt_entity(cfs_rq->next, left) < 1)
 		se = cfs_rq->next;
 
-	clear_buddies(cfs_rq, se);
+	return se;
+}
 
+static struct sched_entity *
+pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
+{
+	struct sched_entity *se = __pick_next_entity(cfs_rq, curr);
+	clear_buddies(cfs_rq, se);
 	return se;
 }
 
@@ -6565,7 +6574,7 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 	struct sched_entity *se = &curr->se, *pse = &p->se;
 	struct cfs_rq *cfs_rq = task_cfs_rq(curr);
 	int scale = cfs_rq->nr_running >= sched_nr_latency;
-	int next_buddy_marked = 0;
+	int wpe, next_buddy_marked = 0;
 
 	if (unlikely(se == pse))
 		return;
@@ -6612,14 +6621,17 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 	find_matching_se(&se, &pse);
 	update_curr(cfs_rq_of(se));
 	BUG_ON(!pse);
-	if (wakeup_preempt_entity(se, pse) == 1) {
+	wpe = wakeup_preempt_entity(se, pse);
+	if (wpe >= !(wake_flags & WF_KTHREAD)) {
 		/*
 		 * Bias pick_next to pick the sched entity that is
 		 * triggering this preemption.
 		 */
 		if (!next_buddy_marked)
 			set_next_buddy(pse);
-		goto preempt;
+
+		if (wpe == 1)
+			goto preempt;
 	}
 
 	return;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 280a3c735935..2ee86ef51001 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1643,7 +1643,8 @@ static inline int task_on_rq_migrating(struct task_struct *p)
  */
 #define WF_SYNC			0x01		/* Waker goes to sleep after wakeup */
 #define WF_FORK			0x02		/* Child wakeup after fork */
-#define WF_MIGRATED		0x4		/* Internal use, task got migrated */
+#define WF_MIGRATED		0x04		/* Internal use, task got migrated */
+#define WF_KTHREAD		0x08
 
 /*
  * To aid in avoiding the subversion of "niceness" due to uneven distribution
