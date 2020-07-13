Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597DF21D58D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 14:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbgGMMMx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 08:12:53 -0400
Received: from foss.arm.com ([217.140.110.172]:58790 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbgGMMMw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 08:12:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5428630E;
        Mon, 13 Jul 2020 05:12:51 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFC2C3F887;
        Mon, 13 Jul 2020 05:12:48 -0700 (PDT)
Date:   Mon, 13 Jul 2020 13:12:46 +0100
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
Message-ID: <20200713121246.xjif3g4zpja25o5r@e107158-lin.cambridge.arm.com>
References: <20200706142839.26629-1-qais.yousef@arm.com>
 <20200706142839.26629-2-qais.yousef@arm.com>
 <20200713112125.GG10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200713112125.GG10769@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/13/20 13:21, Peter Zijlstra wrote:
> > +	 * 2. fork()->sched_post_fork()
> > +	 *    __setscheduler_uclamp()
> > +	 *
> > +	 *	Both of these functions could read the old value but then get
> > +	 *	preempted, during which a user might write new value to
> > +	 *	sysctl_sched_uclamp_util_min_rt_default.
> > +	 *
> > +	 *	// read sysctl_sched_uclamp_util_min_rt_default;
> > +	 *	// PREEMPT-OUT
> > +	 *	.
> > +	 *	.                  <-- sync happens here
> > +	 *	.
> > +	 *	// PREEMPT-IN
> > +	 *	// write p->uclamp_req[UCLAMP_MIN]
> > +	 *
> > +	 *	That section is protected with rcu_read_lock(), so
> > +	 *	synchronize_rcu() will guarantee it has finished before we
> > +	 *	perform the update. Hence ensure that this sync happens after
> > +	 *	any concurrent sync which should guarantee correctness.
> > +	 */
> > +	synchronize_rcu();
> > +
> > +	rcu_read_lock();
> > +	for_each_process_thread(g, p)
> > +		__uclamp_sync_util_min_rt_default(p);
> > +	rcu_read_unlock();
> > +}
> 
> It's monday, and I cannot get my brain working.. I cannot decipher the
> comments you have with the smp_[rw]mb(), what actual ordering do they
> enforce?

It was a  bit of a paranoia to ensure that readers on other cpus see the new
value after this point.

> 
> Also, your synchronize_rcu() relies on write_lock() beeing
> non-preemptible, which isn't true on PREEMPT_RT.
> 
> The below seems simpler...

Hmm maybe I am missing something obvious, but beside the race with fork; I was
worried about another race and that's what the synchronize_rcu() is trying to
handle.

It's the classic preemption in the middle of RMW operation race.

		copy_process()			sysctl_uclamp

		  sched_post_fork()
		    __uclamp_sync_rt()
		      // read sysctl
		      // PREEMPT
						  for_each_process_thread()
		      // RESUME
		      // write syctl to p

So to summarize we have 3 scenarios:


	1. sysctl_uclamp happens *before* sched_post_fork()

for_each_process_thread() could miss the forked task, but that's okay because
sched_post_fork() will apply the correct value.


	2. sysctl_uclamp happens *during* sched_post_fork()

There's the risk of the classic preemption in the middle of RMW where another
CPU could have changed the shared variable after the current CPU has already
read it, but before writing it back.

I protect this with rcu_read_lock() which as far as I know synchronize_rcu()
will ensure if we do the update during this section; we'll wait for it to
finish. New forkees entering the rcu_read_lock() section will be okay because
they should see the new value.

spinlocks() and mutexes seemed inferior to this approach.

Any other potential future user that needs to do __uclamp_sync_rt() could
suffer from this race.


	3. sysctl_uclamp happens *after* sched_post_fork()

Here if for_each_process_thread() still can't see the forked task; then we have
a problem. For this case I wasn't sure if we needed the
smp_mp__after_spinlock() dance. It seemed a stretch to me not to see the forked
task after this point.

Would a simple smp_mp() in for_each_process_thread() be sufficient instead?

Though maybe better to provide a generic macro to do this dance for the benefit
of potential other future users and just call it here and not think too much.

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 0ee5e696c5d8..a124e3a1cb6d 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -586,7 +586,7 @@ extern void flush_itimer_signals(void);
        list_entry_rcu((p)->tasks.next, struct task_struct, tasks)

 #define for_each_process(p) \
-       for (p = &init_task ; (p = next_task(p)) != &init_task ; )
+       for (smp_mp(); p = &init_task ; (p = next_task(p)) != &init_task ; )

 extern bool current_is_single_threaded(void);

Thanks

--
Qais Yousef

> 
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1013,8 +1013,6 @@ static void __uclamp_sync_util_min_rt_de
>  	unsigned int default_util_min;
>  	struct uclamp_se *uc_se;
>  
> -	WARN_ON_ONCE(!rcu_read_lock_held());
> -
>  	if (!rt_task(p))
>  		return;
>  
> @@ -1024,8 +1022,6 @@ static void __uclamp_sync_util_min_rt_de
>  	if (uc_se->user_defined)
>  		return;
>  
> -	/* Sync with smp_wmb() in uclamp_sync_util_min_rt_default() */
> -	smp_rmb();
>  	default_util_min = sysctl_sched_uclamp_util_min_rt_default;
>  	uclamp_se_set(uc_se, default_util_min, false);
>  }
> @@ -1035,47 +1031,21 @@ static void uclamp_sync_util_min_rt_defa
>  	struct task_struct *g, *p;
>  
>  	/*
> -	 * Make sure the updated sysctl_sched_uclamp_util_min_rt_default which
> -	 * was just written is synchronized against any future read on another
> -	 * cpu.
> -	 */
> -	smp_wmb();
> -
> -	/*
> -	 * Wait for all updaters to observe the new change.
> -	 *
> -	 * There are 2 races to deal with here:
> -	 *
> -	 * 1. fork()->copy_process()
> -	 *
> -	 *	If a task was concurrently forking, for_each_process_thread()
> -	 *	will not see it, hence it could have copied the old value and
> -	 *	we missed the opportunity to update it.
> -	 *
> -	 *	This should be handled by sched_post_fork() where it'll ensure
> -	 *	it performs the sync after the fork.
> -	 *
> -	 * 2. fork()->sched_post_fork()
> -	 *    __setscheduler_uclamp()
> -	 *
> -	 *	Both of these functions could read the old value but then get
> -	 *	preempted, during which a user might write new value to
> -	 *	sysctl_sched_uclamp_util_min_rt_default.
> -	 *
> -	 *	// read sysctl_sched_uclamp_util_min_rt_default;
> -	 *	// PREEMPT-OUT
> -	 *	.
> -	 *	.                  <-- sync happens here
> -	 *	.
> -	 *	// PREEMPT-IN
> -	 *	// write p->uclamp_req[UCLAMP_MIN]
> -	 *
> -	 *	That section is protected with rcu_read_lock(), so
> -	 *	synchronize_rcu() will guarantee it has finished before we
> -	 *	perform the update. Hence ensure that this sync happens after
> -	 *	any concurrent sync which should guarantee correctness.
> -	 */
> -	synchronize_rcu();
> +	 * copy_process()			sysctl_uclamp
> +	 *					  uclamp_min_rt = X;
> +	 *   write_lock(&tasklist_lock)		  read_lock(&tasklist_lock)
> +	 *   // link thread			  smp_mb__after_spinlock()
> +	 *   write_unlock(&tasklist_lock)	  read_unlock(&tasklist_lock);
> +	 *   sched_post_fork()			  for_each_process_thread()
> +	 *     __uclamp_sync_rt()		    __uclamp_sync_rt()
> +	 *
> +	 * Ensures that either sched_post_fork() will observe the new
> +	 * uclamp_min_rt or for_each_process_thread() will observe the new
> +	 * task.
> +	 */
> +	read_lock(&tasklist_lock);
> +	smp_mb__after_spinlock();
> +	read_unlock(&tasklist_lock);
>  
>  	rcu_read_lock();
>  	for_each_process_thread(g, p)
> @@ -1408,6 +1378,9 @@ int sysctl_sched_uclamp_handler(struct c
>  		uclamp_update_root_tg();
>  	}
>  
> +	if (old_min_rt != sysctl_sched_uclamp_util_min_rt_default)
> +		uclamp_sync_util_min_rt_default();
> +
>  	/*
>  	 * We update all RUNNABLE tasks only when task groups are in use.
>  	 * Otherwise, keep it simple and do just a lazy update at each next
> @@ -1466,9 +1439,7 @@ static void __setscheduler_uclamp(struct
>  		 * at runtime.
>  		 */
>  		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN)) {
> -			rcu_read_lock();
>  			__uclamp_sync_util_min_rt_default(p);
> -			rcu_read_unlock();
>  		} else {
>  			uclamp_se_set(uc_se, uclamp_none(clamp_id), false);
>  		}
> @@ -1521,6 +1492,11 @@ static void __init init_uclamp_rq(struct
>  	rq->uclamp_flags = 0;
>  }
>  
> +static void uclamp_post_fork(struct task_struct *p)
> +{
> +	__uclamp_sync_util_min_rt_default(p);
> +}
> +
>  static void __init init_uclamp(void)
>  {
>  	struct uclamp_se uc_max = {};
