Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB41F14D4BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2020 01:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgA3Ani (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 19:43:38 -0500
Received: from outbound-smtp09.blacknight.com ([46.22.139.14]:60481 "EHLO
        outbound-smtp09.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726528AbgA3Ani (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 19:43:38 -0500
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp09.blacknight.com (Postfix) with ESMTPS id 241361C3FDC
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2020 00:43:36 +0000 (GMT)
Received: (qmail 22593 invoked from network); 30 Jan 2020 00:43:35 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 30 Jan 2020 00:43:35 -0000
Date:   Thu, 30 Jan 2020 00:43:34 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>, Phil Auld <pauld@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched, fair: Allow a per-cpu kthread waking a task to
 stack on the same CPU
Message-ID: <20200130004334.GF3466@techsingularity.net>
References: <20200127143608.GX3466@techsingularity.net>
 <20200127223256.GA18610@dread.disaster.area>
 <20200128011936.GY3466@techsingularity.net>
 <20200128091012.GZ3466@techsingularity.net>
 <20200129173852.GP14914@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200129173852.GP14914@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 29, 2020 at 06:38:52PM +0100, Peter Zijlstra wrote:
> On Tue, Jan 28, 2020 at 09:10:12AM +0000, Mel Gorman wrote:
> > Peter, Ingo and Vincent -- I know the timing is bad due to the merge
> > window but do you have any thoughts on allowing select_idle_sibling to
> > stack a wakee task on the same CPU as a waker in this specific case?
> 
> I sort of see, but *groan*...
> 

This is the reaction I kinda expected. Sync wakeups and select_idle_sibling
probably caused someone PTSD at some point before my time in kernel/sched/.

> so if the kworker unlocks a contended mutex/rwsem/completion...
> 
> I suppose the fact that it limits it to tasks that were running on the
> same CPU limits the impact if we do get it wrong.
> 

And it's limited to no other task currently running on the
CPU. Now, potentially multiple sleepers are on that CPU waiting for
a mutex/rwsem/completion but it's very unlikely and mostly likely due
to the machine being saturated in which case searching for an idle CPU
will probably fail. It would also be bound by a small window after the
first wakeup before the task becomes runnable before the nr_running check
mitigages the problem. Besides, if the sleeping task is waiting on the
lock, it *is* related to the kworker which is probably finished.

In other words, even this patches worst-case behaviour does not seem
that bad.

> Elsewhere you write:
> 
> > I would prefer the wakeup code did not have to signal that it's a
> > synchronous wakeup. Sync wakeups so exist but callers got it wrong many
> > times where stacking was allowed and then the waker did not go to sleep.
> > While the chain of events are related, they are not related in a very
> > obvious way. I think it's much safer to keep this as a scheduler
> > heuristic instead of depending on callers to have sufficient knowledge
> > of the scheduler implementation.
> 
> That is true; the existing WF_SYNC has caused many issues for maybe
> being too strong.
> 

Exactly. It ended up being almost ignored. It basically just means that
the waker CPU may be used as the target for wake_affine because the
users were not obeying the contract.

> But what if we create a new hint that combines both these ideas? Say
> WF_COMPLETE and subject that to these same criteria. This way we can
> eliminate wakeups from locks and such (they won't have this set).
> 

I think that'll end up with three consequences. First, it falls foul
of Rusty's Rules of API Design[1] because even if people read the
implementation and the documentation, they might still get it wrong like
what happened with WF_SYNC.  Second, some other subsystem will think it's
special and use the flag because it happens to work for one benchmark or
worse, they happened to copy/paste the code for some reason. Finally,
the workqueue implementation may change in some way that renders the
use of the flag incorrect. With this patch, if workqueues change design,
it's more likely the patch becomes a no-op.

> Or am I just making things complicated again?

I think so but I also wrote the patch so I'm biased. I think the callers
would be forced into an API change if it's a common pattern where multiple
unbound tasks can sleep on the same CPU waiting on a single kworker and
I struggle to think of such an example.

The length of time it took this issue to be detected and patched is
indicative that not everyone is familiar with kernel/sched/fair.c and its
consequences.  If they were, chances are they would have implemented some
mental hack like binding a task to a single CPU until the IO completes.

[1] http://sweng.the-davies.net/Home/rustys-api-design-manifesto

-- 
Mel Gorman
SUSE Labs
