Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA7E9400DB5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Sep 2021 02:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbhIEAWO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Sep 2021 20:22:14 -0400
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:47691 "EHLO
        mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234283AbhIEAWO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Sep 2021 20:22:14 -0400
Received: from dread.disaster.area (pa49-195-182-146.pa.nsw.optusnet.com.au [49.195.182.146])
        by mail107.syd.optusnet.com.au (Postfix) with ESMTPS id 13A931143E1A;
        Sun,  5 Sep 2021 10:21:07 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mMfuD-008mCI-AK; Sun, 05 Sep 2021 10:21:05 +1000
Date:   Sun, 5 Sep 2021 10:21:05 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [GIT PULL] xfs: new code for 5.15
Message-ID: <20210905002105.GC1826899@dread.disaster.area>
References: <20210831211847.GC9959@magnolia>
 <CAHk-=whyVPgkAfARB7gMjLEyu0kSxmb6qpqfuE_r6QstAzgHcA@mail.gmail.com>
 <20210902174311.GG9942@magnolia>
 <20210902223545.GA1826899@dread.disaster.area>
 <87a6kub2dp.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6kub2dp.ffs@tglx>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0
        a=QpfB3wCSrn/dqEBSktpwZQ==:117 a=QpfB3wCSrn/dqEBSktpwZQ==:17
        a=kj9zAlcOel0A:10 a=7QKq2e-ADPsA:10 a=3AiNZ_45AAAA:8 a=VwQbUJbxAAAA:8
        a=7-415B0cAAAA:8 a=qHsc3swS6rIxck_nN0wA:9 a=CjuIK1q_8ugA:10
        a=BNLXQWJ-vaQA:10 a=GWTQ6tnsnZoA:10 a=tBs8r7Es1lhbrCgE1GuL:22
        a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 03, 2021 at 08:26:58AM +0200, Thomas Gleixner wrote:
> Dave,
> 
> On Fri, Sep 03 2021 at 08:35, Dave Chinner wrote:
> > On Thu, Sep 02, 2021 at 10:43:11AM -0700, Darrick J. Wong wrote:
> > The part I dislike most about it is that we have to modify a header
> > file that triggers full kernel rebuilds. Managing patch stacks and
> > branches where one of them modifies such a header file means quick,
> > XFS subsystem only kernel rebuilds are a rare thing...
> 
> If you don't care about ordering, you can avoid touching the global
> header completely. The dynamic state ranges in PREPARE and ONLINE
> provide exactly what you want. It's documented.

Ordering? When and why would I care about ordering?
il_last_pushed_lsn
> 
> > That said, I'm all for a better interface to the CPU hotplug
> > notifications. THe current interface is ... esoteric and to
> 
> What's so esoteric about:
> 
>        state = cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "xfs:prepare", func1, func2);
>        state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "xfs:online", func3, func4);

I don't want -online- notifications.  I only want _offline_
notifications and according to the documentation,
CPUHP_AP_ONLINE_DYN get called on both online and offline state
changes.

Don't you see the cognitive dissonance that contradictory "use
online for offline" API naming like this causes. It easily scores
negative points on the Rusty's API scale....
(http://sweng.the-davies.net/Home/rustys-api-design-manifesto)

Also, having to understand what the multiple callbacks
just for different operations is a bit of a WTF. What's the actual
difference between the "online" and "prepare down" callbacks?
For online notifications, the prepare down op is documented as the
online hotplug error handling function that undoes the online
callback.

But if we are registering an -offline notification-, their use isn't
actually documented. Is it the same, or is it inverted? I have to go
read the code...

That is then followed by this gem:

"The callback can be remove by invoking cpuhp_remove_state(). In
case of a dynamically allocated state (CPUHP_AP_ONLINE_DYN) use the
returned state. During the removal of a hotplug state the teardown
callback will be invoked."

What does "use the returned state" mean? What returned
state? Where did it come from? It's not defined anywhere. Then
there's "the teardown callback will be invoked" - that's the first
reference to a "teardown callback" in the documentation. I have to
assume it means the "prepare_down" callback, but....

... then I wonder: the prepare_down callback is per-cpu. Does this
mean that when we remove a hp notifier, the prepare_down callback is
called for every CPU? Or something else? It's not documented, I've
got to go read the code just to work out the basic, fundamental
behaviour of the API I'm trying to use....

> Only if you care about callback ordering vs. other subsystems, then adding
> the state in the global header is required. It's neither the end of the
> world, nor is it rocket science and requires expert knowledge to do so.
> 
> > understand how to use it effectively requires becoming a CPU hotplug
> > expert.
> 
>   https://www.kernel.org/doc/html/latest/core-api/cpu_hotplug.html
> 
> If there is something missing in that documentation which makes you
> think you need to become a CPU hotplug expert, please let me know. I'm
> happy to expand that document.

Deja vu. It's memory-ordering all over again.

The fundamental problem is documentation is written by experts in
the subject matter and, as such, is full of implicit, unspoken
knowledge the reader needs to know before the documentation makes
sense. It is written in a way that only experts in the subject
matter actually understand because only they have the underlying
knowledge to fill in the blanks. And, worst of all, said experts get
upset and obnoxiously defensive when someone dares to say that it's
not perfect.

You might not think that using CPUHP_AP_ONLINE_DYN for CPU offline
events is hard to understand because you know the intimate details
of the implementation (i.e. the offline events are the reverse order
state transitions of online events). But for someone who hasn't
touched the CPU hotplug infrastructure in several years, it's
totally baroque.

I still have little idea of what a "dynamically allocated state" is
in the CPU hotplug model vs an ordered one. It's not defined in the
documentation, nor is it explained how, why and when each should be
used. No examples are given as to when dynamic vs static order is
preferred or needed, and there's nothing in the documentation to
tell you how to just do offline notification.

Hence we end up with code like this:

void __init page_writeback_init(void)
{
        BUG_ON(wb_domain_init(&global_wb_domain, GFP_KERNEL));

        cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mm/writeback:online",
                          page_writeback_cpu_online, NULL);
        cpuhp_setup_state(CPUHP_MM_WRITEBACK_DEAD, "mm/writeback:dead", NULL,
                          page_writeback_cpu_online);
}

Which mixes a dynamic notifier for CPU online, followed by a
specifically ordered offline notifier. Yet both call the same
"online" function, one as a notifier, the other as a "teardown"
callback. But in both cases, neither is used as a "teardown" for a
failed hotplug case.

The WTF level here is sky high. Taken at face value it makes no
sense at all because it uses the same function for online and
offline events. According to the documentation, neither notifier
handles hotplug failure, and there's absolutely no clear reason for
why one event is dynamic and the other is static.

This is what makes it a terrible API: from my perspective, it seems
almost impossible to use correctly even though I've read the
documentation and spend a bunch of time reading the code and try
hard to do the right thing. That's a -9 or -10 on the Rusty API
scale...

> > There's something to be said for the simplicity of the old
> > register_cpu_notifier() interface we used to have...
> 
> There is a lot to be said about it. The simplicity of it made people do
> the most hillarious things to deal with:
> 
>   - Ordering issues including build order dependencies
>   - Asymetry between bringup and teardown
>   - The inability to test state transitions
>   - ....
>
> Back then when we converted the notifier mess 35 of ~140 hotplug
> notifiers (i.e. ~25%) contained bugs of all sorts. Quite some of them
> were caused by the well understood simplicity of the hotplug notifier
> mechanics. I'm surely not missing any of that.

You're conflating implementation problems with "API is unusable".
The API was very easy to understand and use, and those
implementation difficulties (like ordering and symmetry) could have
eaily been fixed just by having a notifier block per defined
transition, rather than multiplexing all state transitions all into
a single notifier...

Indeed, that's the core difference between that old API and the
current API - the current API requires registering a notifier per
state transition, but that registers the notifier for both CPU up
and down transitions.

The problem with the new API is that the requirement for symmetry in
some subsystems has bled into the API, and so now all the subsystems
that *don't need/want symmetry* have to juggle some undocumented
esoteric combination of state definitions and callbacks to get the
behaviour they require. And that, AFAICT, means that those callbacks
can't handle failures in hotplug processing properly.

So rather than having a nice, simple "one callback per event" API,
we've got this convoluted thing that behaves according to a
combination of state definition and callback defintions. Then the
API is duplicated into "_nocall()" variants (not documented!)
because many subsystems do not want hotplug callbacks run on
setup/teardown of hotplug events.

The old hotplug notification *implementation* had problems, but the
*API* was not the cause of those bugs. In contrast, the current API
appears to make it impossible to implement notifiers for certain use
cases correctly, and that's directly where my statement that "you
need to be a cpuhp expert to use this" comes from....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
