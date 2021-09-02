Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F64A3FF2C1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Sep 2021 19:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347113AbhIBRpN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Sep 2021 13:45:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:38562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347204AbhIBRoK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Sep 2021 13:44:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B8686600AA;
        Thu,  2 Sep 2021 17:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630604591;
        bh=D0GaGVR2vKk3xktWmeeIHVHJSQvMWkhDtm3v+etPCSw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vo6/w5JuJRN9qBNRkl24dK0skloQpLcT0B1paVmTgkQFkU7H6LqPsOfT1pDRZMQGa
         CM3OuEBcCzZBkIYlXTmrXzeHDFAiHvu4ZyI0Vx9QYREBrWvJoXdx1/82TJ5J0M3S9d
         ll33WYUOA7OsLLp+y72k1SqgGtgftnY8CTGZAZyz2hGjyT7fFr/l96laZKUsm1FqWJ
         OXNIkpQqGxqpugL0sTZS9aBaP+gmRz1/8baZR5TE+T0qcWkd9VKxGM+6KH/nzvlbmW
         IpD2SL0elqP+XNBjbCS6TnWo8l4a6ckGnBCYrQ6cAi4NwTzPXT3FcgZ6h5x4Js6Uz5
         OhDcVyH48nl4w==
Date:   Thu, 2 Sep 2021 10:43:11 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [GIT PULL] xfs: new code for 5.15
Message-ID: <20210902174311.GG9942@magnolia>
References: <20210831211847.GC9959@magnolia>
 <CAHk-=whyVPgkAfARB7gMjLEyu0kSxmb6qpqfuE_r6QstAzgHcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whyVPgkAfARB7gMjLEyu0kSxmb6qpqfuE_r6QstAzgHcA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 02, 2021 at 08:47:42AM -0700, Linus Torvalds wrote:
> On Tue, Aug 31, 2021 at 2:18 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > As for new features: we now batch inode inactivations in percpu
> > background threads, which sharply decreases frontend thread wait time
> > when performing file deletions and should improve overall directory tree
> > deletion times.
> 
> So no complaints on this one, but I do have a reaction: we have a lot
> of these random CPU hotplug events, and XFS now added another one.
> 
> I don't see that as a problem, but just the _randomness_ of these
> callbacks makes me go "hmm". And that "enum cpuhp_state" thing isn't
> exactly a thing of beauty, and just makes me think there's something
> nasty going on.
> 
> For the new xfs usage, I really get the feeling that it's not that XFS
> actually cares about the CPU states, but that this is literally tied
> to just having percpu state allocated and active, and that maybe it
> would be sensible to have something more specific to that kind of use.

Correct -- we don't really care about cpu state at all; all xfs needs is
to push batched work items on a per-cpu list to another cpu when a cpu
goes offline.  I didn't see anything that looked like it handled that
kind of thing, so ... cpuhp_state it was. :/

> We have other things that are very similar in nature - like the page
> allocator percpu caches etc, which for very similar reasons want cpu
> dead/online notification.
> 
> I'm only throwing this out as a reaction to this - I'm not sure
> another interface would be good or worthwhile, but that "enum
> cpuhp_state" is ugly enough that I thought I'd rope in Thomas for CPU
> hotplug, and the percpu memory allocation people for comments.
> 
> IOW, just _maybe_ we would want to have some kind of callback model
> for "percpu_alloc()" and it being explicitly about allocations
> becoming available or going away, rather than about CPU state.
> 
> Comments?

Seems like a good fit for us, though I'll let Dave Chinner chime in
since he's the one with more per-cpu list patches coming up.

> > Lastly, with this release, two new features have graduated to supported
> > status: inode btree counters (for faster mounts), and support for dates
> > beyond Y2038.
> 
> Oh, I had thought Y2038 was already a non-issue for xfs. Silly me.

It's been a new feature in upstream for a year now.  We're merely taking
down the scary warnings that using this new code might result in a
subspace vortex opening in the skies or that all trains bound for
Moynihan end up on track 19 or wherever. ;)

--D

>               Linus
