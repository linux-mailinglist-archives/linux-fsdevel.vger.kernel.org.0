Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B934421D871
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 16:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730049AbgGMO2B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 10:28:01 -0400
Received: from foss.arm.com ([217.140.110.172]:38166 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729881AbgGMO2A (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 10:28:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2E2E30E;
        Mon, 13 Jul 2020 07:27:59 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CA813F7BB;
        Mon, 13 Jul 2020 07:27:57 -0700 (PDT)
Date:   Mon, 13 Jul 2020 15:27:55 +0100
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
Message-ID: <20200713142754.tri5jljnrzjst2oe@e107158-lin.cambridge.arm.com>
References: <20200706142839.26629-1-qais.yousef@arm.com>
 <20200706142839.26629-2-qais.yousef@arm.com>
 <20200713112125.GG10769@hirez.programming.kicks-ass.net>
 <20200713121246.xjif3g4zpja25o5r@e107158-lin.cambridge.arm.com>
 <20200713133558.GK10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200713133558.GK10769@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/13/20 15:35, Peter Zijlstra wrote:
> On Mon, Jul 13, 2020 at 01:12:46PM +0100, Qais Yousef wrote:
> > On 07/13/20 13:21, Peter Zijlstra wrote:
> 
> > > It's monday, and I cannot get my brain working.. I cannot decipher the
> > > comments you have with the smp_[rw]mb(), what actual ordering do they
> > > enforce?
> > 
> > It was a  bit of a paranoia to ensure that readers on other cpus see the new
> > value after this point.
> 
> IIUC that's not something any barrier can provide.
> 
> Barriers can only order between (at least) two memory operations:
> 
> 	X = 1;		y = Y;
> 	smp_wmb();	smp_rmb();
> 	Y = 1;		x = X;
> 
> guarantees that if y == 1, then x must also be 1. Because the left hand
> side orders the store of Y after the store of X, while the right hand
> side order the load of X after the load of Y. Therefore, if the first
> load observes the last store, the second load must observe the first
> store.
> 
> Without a second variable, barriers can't guarantee _anything_. Which is
> why any barrier comment should refer to at least two variables.

Hmmm okay. I thought this will order the write with the read. In my head if,
for example, the write was stuck in the write buffer of CPU0, then a read on
CPU1 would wait for this to be committed before carrying on and issue a read.

So I was reading this as don't issue new reads before current writes are done.

I need to go back and read memory-barriers.rst. It's been 10 years since I last
read it..

> 
> > > Also, your synchronize_rcu() relies on write_lock() beeing
> > > non-preemptible, which isn't true on PREEMPT_RT.
> > > 
> > > The below seems simpler...
> 
> > Hmm maybe I am missing something obvious, but beside the race with fork; I was
> > worried about another race and that's what the synchronize_rcu() is trying to
> > handle.
> > 
> > It's the classic preemption in the middle of RMW operation race.
> > 
> > 		copy_process()			sysctl_uclamp
> > 
> > 		  sched_post_fork()
> > 		    __uclamp_sync_rt()
> > 		      // read sysctl
> > 		      // PREEMPT
> > 						  for_each_process_thread()
> > 		      // RESUME
> > 		      // write syctl to p
> > 
> 
> > 	2. sysctl_uclamp happens *during* sched_post_fork()
> > 
> > There's the risk of the classic preemption in the middle of RMW where another
> > CPU could have changed the shared variable after the current CPU has already
> > read it, but before writing it back.
> 
> Aah.. I see.
> 
> > I protect this with rcu_read_lock() which as far as I know synchronize_rcu()
> > will ensure if we do the update during this section; we'll wait for it to
> > finish. New forkees entering the rcu_read_lock() section will be okay because
> > they should see the new value.
> > 
> > spinlocks() and mutexes seemed inferior to this approach.
> 
> Well, didn't we just write in another patch that p->uclamp_* was
> protected by both rq->lock and p->pi_lock?

__setscheduler_uclamp() path is holding these locks, not sure by design or it
just happened this path holds the lock. I can't see the lock in the
uclamp_fork() path. But it's hard sometimes to unfold the layers of callers,
especially not all call sites are annotated for which lock is assumed to be
held.

Is it safe to hold the locks in uclamp_fork() while the task is still being
created? My new code doesn't hold it of course.

We can enforce this rule if you like. Though rcu critical section seems lighter
weight to me.

If all of this does indeed start looking messy we can put the update in
a delayed worker and schedule that instead of doing synchronous setup.

Or go back to task_woken_rt() with a cached per-rq variable of
sysctl_util_min_rt that is more likely to be cache hot compared to the global
sysctl_util_min_rt variable.

Thanks

--
Qais Yousef
