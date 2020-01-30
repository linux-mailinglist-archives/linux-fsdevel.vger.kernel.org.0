Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1E514D4D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2020 01:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbgA3AuJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 19:50:09 -0500
Received: from outbound-smtp30.blacknight.com ([81.17.249.61]:35322 "EHLO
        outbound-smtp30.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727446AbgA3AuI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 19:50:08 -0500
Received: from mail.blacknight.com (unknown [81.17.254.11])
        by outbound-smtp30.blacknight.com (Postfix) with ESMTPS id 0428370020
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2020 00:50:05 +0000 (GMT)
Received: (qmail 8490 invoked from network); 30 Jan 2020 00:50:04 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 30 Jan 2020 00:50:04 -0000
Date:   Thu, 30 Jan 2020 00:50:02 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Phil Auld <pauld@redhat.com>, Ming Lei <ming.lei@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched, fair: Allow a per-cpu kthread waking a task to
 stack on the same CPU
Message-ID: <20200130005002.GG3466@techsingularity.net>
References: <20200127143608.GX3466@techsingularity.net>
 <20200127223256.GA18610@dread.disaster.area>
 <20200128011936.GY3466@techsingularity.net>
 <20200128091012.GZ3466@techsingularity.net>
 <20200129173852.GP14914@hirez.programming.kicks-ass.net>
 <20200129220021.GN18610@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200129220021.GN18610@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 30, 2020 at 09:00:21AM +1100, Dave Chinner wrote:
> On Wed, Jan 29, 2020 at 06:38:52PM +0100, Peter Zijlstra wrote:
> > On Tue, Jan 28, 2020 at 09:10:12AM +0000, Mel Gorman wrote:
> > > Peter, Ingo and Vincent -- I know the timing is bad due to the merge
> > > window but do you have any thoughts on allowing select_idle_sibling to
> > > stack a wakee task on the same CPU as a waker in this specific case?
> > 
> > I sort of see, but *groan*...
> > 
> > so if the kworker unlocks a contended mutex/rwsem/completion...
> > 
> > I suppose the fact that it limits it to tasks that were running on the
> > same CPU limits the impact if we do get it wrong.
> > 
> > Elsewhere you write:
> > 
> > > I would prefer the wakeup code did not have to signal that it's a
> > > synchronous wakeup. Sync wakeups so exist but callers got it wrong many
> > > times where stacking was allowed and then the waker did not go to sleep.
> > > While the chain of events are related, they are not related in a very
> > > obvious way. I think it's much safer to keep this as a scheduler
> > > heuristic instead of depending on callers to have sufficient knowledge
> > > of the scheduler implementation.
> > 
> > That is true; the existing WF_SYNC has caused many issues for maybe
> > being too strong.
> > 
> > But what if we create a new hint that combines both these ideas? Say
> > WF_COMPLETE and subject that to these same criteria. This way we can
> > eliminate wakeups from locks and such (they won't have this set).
> > 
> > Or am I just making things complicated again?
> 
> I suspect this is making it complicated again, because it requires
> the people who maintain the code that is using workqueues to
> understand when they might need to use a special wakeup interface in
> the work function. And that includes code that currently calls
> wake_up_all() because there can be hundreds of independent tasks
> waiting on the IO completion (e.g all the wait queues in the XFS
> journal code can (and do) have multiple threads waiting on them).
> 
> IOWs, requiring a special flag just to optimise this specific case
> (i.e. single dependent waiter on same CPU as the kworker) when the
> adverse behaviour is both hardware and workload dependent means it
> just won't get used correctly or reliably.
> 

I agree. Pick any of Rusty's rules from "-2 Read the implementation
and you'll get it wrong" all the way down to "-10 It's impossible to
get right.".

> Hence I'd much prefer the kernel detects and dynamically handles
> this situation at runtime, because this pattern of workqueue usage
> is already quite common and will only become more widespread as we
> progress towards async processing of syscalls.
> 

To be fair, as Peter says, the kernel patch may not detect this
properly. There are corner cases where it will get it wrong. My thinking is
that *at the moment* when the heuristic is wrong, it's almost certainly
because the machine was so over-saturated such that multiple related
tasks are stacking anyway.

Depending on how async syscalls proceeds, this might get turn out to the
the wrong heuristic and an API change will be required. At least if that
happens, we'll have a few use cases to help guide what the API change
should look like so we do not end up in WF_SYNC hell again.

-- 
Mel Gorman
SUSE Labs
