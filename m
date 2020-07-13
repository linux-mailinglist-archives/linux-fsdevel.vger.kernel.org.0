Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D5721DF5E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 20:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbgGMSJb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 14:09:31 -0400
Received: from foss.arm.com ([217.140.110.172]:51838 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729689AbgGMSJb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 14:09:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2749E1FB;
        Mon, 13 Jul 2020 11:09:30 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B03813F7D8;
        Mon, 13 Jul 2020 11:09:27 -0700 (PDT)
Date:   Mon, 13 Jul 2020 19:09:25 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Doug Anderson <dianders@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Quentin Perret <qperret@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] sched/uclamp: Add a new sysctl to control RT
 default boost value
Message-ID: <20200713180925.mot4tmz3ifnrurx5@e107158-lin.cambridge.arm.com>
References: <20200706142839.26629-1-qais.yousef@arm.com>
 <20200706142839.26629-2-qais.yousef@arm.com>
 <20200713112125.GG10769@hirez.programming.kicks-ass.net>
 <20200713121246.xjif3g4zpja25o5r@e107158-lin.cambridge.arm.com>
 <20200713133558.GK10769@hirez.programming.kicks-ass.net>
 <20200713142754.tri5jljnrzjst2oe@e107158-lin.cambridge.arm.com>
 <20200713165449.GM10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200713165449.GM10769@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/13/20 18:54, Peter Zijlstra wrote:
> On Mon, Jul 13, 2020 at 03:27:55PM +0100, Qais Yousef wrote:
> > On 07/13/20 15:35, Peter Zijlstra wrote:
> > > > I protect this with rcu_read_lock() which as far as I know synchronize_rcu()
> > > > will ensure if we do the update during this section; we'll wait for it to
> > > > finish. New forkees entering the rcu_read_lock() section will be okay because
> > > > they should see the new value.
> > > > 
> > > > spinlocks() and mutexes seemed inferior to this approach.
> > > 
> > > Well, didn't we just write in another patch that p->uclamp_* was
> > > protected by both rq->lock and p->pi_lock?
> > 
> > __setscheduler_uclamp() path is holding these locks, not sure by design or it
> > just happened this path holds the lock. I can't see the lock in the
> > uclamp_fork() path. But it's hard sometimes to unfold the layers of callers,
> > especially not all call sites are annotated for which lock is assumed to be
> > held.
> > 
> > Is it safe to hold the locks in uclamp_fork() while the task is still being
> > created? My new code doesn't hold it of course.
> > 
> > We can enforce this rule if you like. Though rcu critical section seems lighter
> > weight to me.
> > 
> > If all of this does indeed start looking messy we can put the update in
> > a delayed worker and schedule that instead of doing synchronous setup.
> 
> sched_fork() doesn't need the locks, because at that point the task
> isn't visible yet. HOWEVER, sched_post_fork() is after pid-hash (per
> design) and thus the task is visible, so we can race against
> sched_setattr(), so we'd better hold those locks anyway.

Okay. I thought task_rq_lock() is expensive because it'll compete with other
users in fast path.

I got the below which I am testing. I hit a splat in uclamp static key too
while testing this :( I'll test them in unison and lump the fix in this series
in the next version.

Thanks

--
Qais Yousef

---
 include/linux/sched.h | 10 ++++--
 kernel/sched/core.c   | 81 ++++++++++++++++---------------------------
 2 files changed, 37 insertions(+), 54 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 12b10ce51a08..81c4eed8d9a3 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -686,9 +686,15 @@ struct task_struct {
 	struct sched_dl_entity		dl;
 
 #ifdef CONFIG_UCLAMP_TASK
-	/* Clamp values requested for a scheduling entity */
+	/*
+	 * Clamp values requested for a scheduling entity.
+	 * Must be updated with task_rq_lock() held.
+	 */
 	struct uclamp_se		uclamp_req[UCLAMP_CNT];
-	/* Effective clamp values used for a scheduling entity */
+	/*
+	 * Effective clamp values used for a scheduling entity.
+	 * Must be updated with task_rq_lock() held.
+	 */
 	struct uclamp_se		uclamp[UCLAMP_CNT];
 #endif
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 45bd4d9d2bba..8a648da4e7f2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -914,74 +914,55 @@ unsigned int uclamp_rq_max_value(struct rq *rq, enum uclamp_id clamp_id,
 	return uclamp_idle_value(rq, clamp_id, clamp_value);
 }
 
-static void __uclamp_sync_util_min_rt_default(struct task_struct *p)
+static void __uclamp_sync_util_min_rt_default_locked(struct task_struct *p)
 {
 	unsigned int default_util_min;
 	struct uclamp_se *uc_se;
 
-	WARN_ON_ONCE(!rcu_read_lock_held());
-
-	if (!rt_task(p))
-		return;
-
 	uc_se = &p->uclamp_req[UCLAMP_MIN];
 
 	/* Only sync if user didn't override the default */
 	if (uc_se->user_defined)
 		return;
 
-	/* Sync with smp_wmb() in uclamp_sync_util_min_rt_default() */
-	smp_rmb();
 	default_util_min = sysctl_sched_uclamp_util_min_rt_default;
 	uclamp_se_set(uc_se, default_util_min, false);
 }
 
+static void __uclamp_sync_util_min_rt_default(struct task_struct *p)
+{
+	struct rq_flags rf;
+	struct rq *rq;
+
+	if (!rt_task(p))
+		return;
+
+	/* Protect updates to p->uclamp_* */
+	rq = task_rq_lock(p, &rf);
+	__uclamp_sync_util_min_rt_default_locked(p);
+	task_rq_unlock(rq, p, &rf);
+}
+
 static void uclamp_sync_util_min_rt_default(void)
 {
 	struct task_struct *g, *p;
 
 	/*
-	 * Make sure the updated sysctl_sched_uclamp_util_min_rt_default which
-	 * was just written is synchronized against any future read on another
-	 * cpu.
-	 */
-	smp_wmb();
-
-	/*
-	 * Wait for all updaters to observe the new change.
-	 *
-	 * There are 2 races to deal with here:
-	 *
-	 * 1. fork()->copy_process()
-	 *
-	 *	If a task was concurrently forking, for_each_process_thread()
-	 *	will not see it, hence it could have copied the old value and
-	 *	we missed the opportunity to update it.
-	 *
-	 *	This should be handled by sched_post_fork() where it'll ensure
-	 *	it performs the sync after the fork.
-	 *
-	 * 2. fork()->sched_post_fork()
-	 *    __setscheduler_uclamp()
-	 *
-	 *	Both of these functions could read the old value but then get
-	 *	preempted, during which a user might write new value to
-	 *	sysctl_sched_uclamp_util_min_rt_default.
+	 * copy_process()			sysctl_uclamp
+	 *					  uclamp_min_rt = X;
+	 *   write_lock(&tasklist_lock)		  read_lock(&tasklist_lock)
+	 *   // link thread			  smp_mb__after_spinlock()
+	 *   write_unlock(&tasklist_lock)	  read_unlock(&tasklist_lock);
+	 *   sched_post_fork()			  for_each_process_thread()
+	 *     __uclamp_sync_rt()		    __uclamp_sync_rt()
 	 *
-	 *	// read sysctl_sched_uclamp_util_min_rt_default;
-	 *	// PREEMPT-OUT
-	 *	.
-	 *	.                  <-- sync happens here
-	 *	.
-	 *	// PREEMPT-IN
-	 *	// write p->uclamp_req[UCLAMP_MIN]
-	 *
-	 *	That section is protected with rcu_read_lock(), so
-	 *	synchronize_rcu() will guarantee it has finished before we
-	 *	perform the update. Hence ensure that this sync happens after
-	 *	any concurrent sync which should guarantee correctness.
+	 * Ensures that either sched_post_fork() will observe the new
+	 * uclamp_min_rt or for_each_process_thread() will observe the new
+	 * task.
 	 */
-	synchronize_rcu();
+	read_lock(&tasklist_lock);
+	smp_mb__after_spinlock();
+	read_unlock(&tasklist_lock);
 
 	rcu_read_lock();
 	for_each_process_thread(g, p)
@@ -1377,9 +1358,7 @@ static void __setscheduler_uclamp(struct task_struct *p,
 		 * at runtime.
 		 */
 		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN)) {
-			rcu_read_lock();
-			__uclamp_sync_util_min_rt_default(p);
-			rcu_read_unlock();
+			__uclamp_sync_util_min_rt_default_locked(p);
 		} else {
 			uclamp_se_set(uc_se, uclamp_none(clamp_id), false);
 		}
@@ -1420,9 +1399,7 @@ static void uclamp_fork(struct task_struct *p)
 
 static void uclamp_post_fork(struct task_struct *p)
 {
-	rcu_read_lock();
 	__uclamp_sync_util_min_rt_default(p);
-	rcu_read_unlock();
 }
 
 static void __init init_uclamp_rq(struct rq *rq)
-- 
2.17.1
