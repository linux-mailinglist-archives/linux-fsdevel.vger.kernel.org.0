Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69C1263048
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 17:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgIIPOl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 11:14:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:53988 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729971AbgIIL5w (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 07:57:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7A5B9AD1E;
        Wed,  9 Sep 2020 11:53:59 +0000 (UTC)
Date:   Wed, 9 Sep 2020 13:53:57 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/8] memcg: Enable fine-grained per process memory
 control
Message-ID: <20200909115357.GI7348@dhcp22.suse.cz>
References: <20200817140831.30260-1-longman@redhat.com>
 <20200818091453.GL2674@hirez.programming.kicks-ass.net>
 <20200818092617.GN28270@dhcp22.suse.cz>
 <20200818095910.GM2674@hirez.programming.kicks-ass.net>
 <20200818100516.GO28270@dhcp22.suse.cz>
 <20200818101844.GO2674@hirez.programming.kicks-ass.net>
 <20200818134900.GA829964@cmpxchg.org>
 <20200821193716.GU3982@worktop.programming.kicks-ass.net>
 <20200824165850.GA932571@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824165850.GA932571@cmpxchg.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[Sorry, this slipped through cracks]

On Mon 24-08-20 12:58:50, Johannes Weiner wrote:
> On Fri, Aug 21, 2020 at 09:37:16PM +0200, Peter Zijlstra wrote:
[...]
> > Arguably seeing the rate drop to near 0 is a very good point to consider
> > running cgroup-OOM.
> 
> Agreed. In the past, that's actually what we did: In cgroup1, you
> could disable the kernel OOM killer, and when reclaim failed at the
> limit, the allocating task would be put on a waitqueue until woken up
> by a freeing event. Conceptually this is clean & straight-forward.
> 
> However,
> 
> 1. Putting allocation contexts with unknown locks to indefinite sleep
>    caused deadlocks, for obvious reasons. Userspace OOM killing tends
>    to take a lot of task-specific locks when scanning through /proc
>    files for kill candidates, and can easily get stuck.
> 
>    Using bounded over indefinite waits is simply acknowledging that
>    the deadlock potential when connecting arbitrary task stacks in the
>    system through free->alloc ordering is equally difficult to plan
>    out as alloc->free ordering.
> 
>    The non-cgroup OOM killer actually has the same deadlock potential,
>    where the allocating/killing task can hold resources that the OOM
>    victim requires to exit. The OOM reaper hides it, the static
>    emergency reserves hide it - but to truly solve this problem, you
>    would have to have full knowledge of memory & lock ordering
>    dependencies of those tasks. And then can still end up with
>    scenarios where the only answer is panic().

Yes. Even killing all eligible tasks is not guaranteed to help the
situation because a) resources might be not bound to a process life time
(e.g. tmpfs) or ineligible task might be holding resources that block
others to do the proper cleanup. OOM reaper is here to make sure we
reclaim some of the address space of the victim and we go over all
eligible tasks rather than getting stuck at the first victim for ever.
 
> 2. I don't recall ever seeing situations in cgroup1 where the precise
>    matching of allocation rate to freeing rate has allowed cgroups to
>    run sustainably after reclaim has failed. The practical benefit of
>    a complicated feedback loop over something crude & robust once
>    we're in an OOM situation is not apparent to me.

Yes, this is usually go OOM and kill something. Running on a very edge
of the (memcg) oom doesn't tend to be sustainable and I am not sure it
makes sense to optimize for.

>    [ That's different from the IO-throttling *while still doing
>      reclaim* that Dave brought up. *That* justifies the same effort
>      we put into dirty throttling. I'm only talking about the
>      situation where reclaim has already failed and we need to
>      facilitate userspace OOM handling. ]
> 
> So that was the motivation for the bounded sleeps. They do not
> guarantee containment, but they provide a reasonable amount of time
> for the userspace OOM handler to intervene, without deadlocking.

Yes, memory.high is mostly a best effort containment. We do have the
hard limit to put a stop on runaways or if you are watching for PSI then
the high limit throttling would give you enough idea to take an action
from the userspace.

> That all being said, the semantics of the new 'high' limit in cgroup2
> have allowed us to move reclaim/limit enforcement out of the
> allocation context and into the userspace return path.
> 
> See the call to mem_cgroup_handle_over_high() from
> tracehook_notify_resume(), and the comments in try_charge() around
> set_notify_resume().
> 
> This already solves the free->alloc ordering problem by allowing the
> allocation to exceed the limit temporarily until at least all locks
> are dropped, we know we can sleep etc., before performing enforcement.
> 
> That means we may not need the timed sleeps anymore for that purpose,
> and could bring back directed waits for freeing-events again.
> 
> What do you think? Any hazards around indefinite sleeps in that resume
> path? It's called before __rseq_handle_notify_resume and the
> arch-specific resume callback (which appears to be a no-op currently).
> 
> Chris, Michal, what are your thoughts? It would certainly be simpler
> conceptually on the memcg side.

I would need a more specific description. But as I've already said. It
doesn't seem that we are in a need to fix any practical problem here.
High limit implementation has changed quite a lot recently. I would
rather see it settled for a while and see how it behaves in wider
variety of workloads before changing the implementation again.

-- 
Michal Hocko
SUSE Labs
