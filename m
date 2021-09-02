Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91103FF73B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Sep 2021 00:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347689AbhIBWgu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Sep 2021 18:36:50 -0400
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:39865 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231642AbhIBWgt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Sep 2021 18:36:49 -0400
Received: from dread.disaster.area (pa49-195-182-146.pa.nsw.optusnet.com.au [49.195.182.146])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id 5118D85680;
        Fri,  3 Sep 2021 08:35:47 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mLvJB-007ziM-U1; Fri, 03 Sep 2021 08:35:45 +1000
Date:   Fri, 3 Sep 2021 08:35:45 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [GIT PULL] xfs: new code for 5.15
Message-ID: <20210902223545.GA1826899@dread.disaster.area>
References: <20210831211847.GC9959@magnolia>
 <CAHk-=whyVPgkAfARB7gMjLEyu0kSxmb6qpqfuE_r6QstAzgHcA@mail.gmail.com>
 <20210902174311.GG9942@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902174311.GG9942@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0
        a=QpfB3wCSrn/dqEBSktpwZQ==:117 a=QpfB3wCSrn/dqEBSktpwZQ==:17
        a=kj9zAlcOel0A:10 a=7QKq2e-ADPsA:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=Dg21x2e93uhxExW4IOkA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 02, 2021 at 10:43:11AM -0700, Darrick J. Wong wrote:
> On Thu, Sep 02, 2021 at 08:47:42AM -0700, Linus Torvalds wrote:
> > On Tue, Aug 31, 2021 at 2:18 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > >
> > > As for new features: we now batch inode inactivations in percpu
> > > background threads, which sharply decreases frontend thread wait time
> > > when performing file deletions and should improve overall directory tree
> > > deletion times.
> > 
> > So no complaints on this one, but I do have a reaction: we have a lot
> > of these random CPU hotplug events, and XFS now added another one.
> > 
> > I don't see that as a problem, but just the _randomness_ of these
> > callbacks makes me go "hmm". And that "enum cpuhp_state" thing isn't
> > exactly a thing of beauty, and just makes me think there's something
> > nasty going on.
> > 
> > For the new xfs usage, I really get the feeling that it's not that XFS
> > actually cares about the CPU states, but that this is literally tied
> > to just having percpu state allocated and active, and that maybe it
> > would be sensible to have something more specific to that kind of use.
> 
> Correct -- we don't really care about cpu state at all; all xfs needs is
> to push batched work items on a per-cpu list to another cpu when a cpu
> goes offline.  I didn't see anything that looked like it handled that
> kind of thing, so ... cpuhp_state it was. :/

Yeah, it appeared to me that cpuhp_state is the replacement for the
simple, old register_cpu_notifier() hotplug interface that we've
used in the past in XFS (e.g. for per-cpu superblock counters back
in 2006). So, like many other subsystems, I just hooked into it with
a subsystem notifier so we don't have to modify global headers in
future for new internal CPU dead notifiers because, as Darrick
mentions, I have more percpu based modifications coming up for
XFS...


> > We have other things that are very similar in nature - like the page
> > allocator percpu caches etc, which for very similar reasons want cpu
> > dead/online notification.
> > 
> > I'm only throwing this out as a reaction to this - I'm not sure
> > another interface would be good or worthwhile, but that "enum
> > cpuhp_state" is ugly enough that I thought I'd rope in Thomas for CPU
> > hotplug, and the percpu memory allocation people for comments.

Calling it ugly is being kind. :/

The part I dislike most about it is that we have to modify a header
file that triggers full kernel rebuilds. Managing patch stacks and
branches where one of them modifies such a header file means quick,
XFS subsystem only kernel rebuilds are a rare thing...

> > IOW, just _maybe_ we would want to have some kind of callback model
> > for "percpu_alloc()" and it being explicitly about allocations
> > becoming available or going away, rather than about CPU state.
> > 
> > Comments?
> 
> Seems like a good fit for us, though I'll let Dave Chinner chime in
> since he's the one with more per-cpu list patches coming up.

I think this might just be semantics - I understand the intent of
Linus's suggestion is to provide a hotplug callback with a per-cpu
allocation region. The thing that we rely on here is, however, that
per-cpu allocation regions are static for the life of the allocation
and always cover all possible CPUs. Hence the callbacks we want here
are really about CPU state changes and I'm not convinced it's the
best idea to conflate CPU state change callbacks with memory
allocation...

That said, I'm all for a better interface to the CPU hotplug
notifications. THe current interface is ... esoteric and to
understand how to use it effectively requires becoming a CPU hotplug
expert. There's something to be said for the simplicity of the old
register_cpu_notifier() interface we used to have...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
