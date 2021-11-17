Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106D2454D83
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Nov 2021 19:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbhKQS7Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Nov 2021 13:59:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55026 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240281AbhKQS7X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Nov 2021 13:59:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637175382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vxkdfj9JEAJ/LK1YWoTa70cHi7v/Kw2W+r/qMs1q6ps=;
        b=WigOILrdVEbpDRqOqydmB8LZhUrhx4M0XC5EmHgfWCjhzT+oB6lbCk/RThaNie3JiOuveZ
        dBUpPMsYW9RasbE4r8bRvbi04sBXmCdx36GsY33jMS8vkIz8GWytmFSnJiEWasablBI1HP
        wnDuEfIAMFUZOXIFHY6D6ZiyGawMDKY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-308-OoNXx-sqPEOrsskkfPdMgg-1; Wed, 17 Nov 2021 13:56:21 -0500
X-MC-Unique: OoNXx-sqPEOrsskkfPdMgg-1
Received: by mail-qk1-f197.google.com with SMTP id v14-20020a05620a0f0e00b0043355ed67d1so2688975qkl.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Nov 2021 10:56:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vxkdfj9JEAJ/LK1YWoTa70cHi7v/Kw2W+r/qMs1q6ps=;
        b=dn0fROqZiVCLisR+WlUJgxJLfulPhMS4OL8a36ZdJCU9Ndazw+tHtXXqMY4A0jSSxt
         WdrahMeqL7b76d8gooW9FDocHBybzkP793PrA3Q9g7CrzIGNExOjfI5WnfWflmzXsDYt
         Kt3HnLvgp+GRepGLyCDEMFxsxQpAAA4NEaqND/+0pPqutJkY24g9Q3+hOs69zS375CIW
         8wvhzBUGLKEVdh8nJJe3z2W+BaoxA4qn9cSziWIc0rZwVdOz5SUCU17VnWgnAPtnjxo/
         hvVRoWMy47XiLcWyBec9bVAulh/8se0RRxtwARtJCOnKwEHyCVKwjAspu1mqJAwomPGn
         Y46Q==
X-Gm-Message-State: AOAM532IPpz3SPE5+9Ldkfbw54HNFuEmWc39j+eSgiknJfCPnNSphM2C
        AIqUKcbTpXAHAIUL97Ofov/Nzvo6rnzCJkg3uC0qwAUSRxWL5CgLO39zHdcUx/XpLKgQONz253M
        4ka58pquMmrFEIDmc0IBBTLHN5A==
X-Received: by 2002:ac8:590a:: with SMTP id 10mr19262634qty.186.1637175380484;
        Wed, 17 Nov 2021 10:56:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxgmIgb+WOecaMJGBYjEmk1D98xPws7O0jLA83WP0lJ5dXbARz40eq0F3oz8jvsYAcBKi1PUg==
X-Received: by 2002:ac8:590a:: with SMTP id 10mr19262593qty.186.1637175380136;
        Wed, 17 Nov 2021 10:56:20 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id u10sm381268qkp.104.2021.11.17.10.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 10:56:19 -0800 (PST)
Date:   Wed, 17 Nov 2021 13:56:17 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Ian Kent <raven@themaw.net>, Miklos Szeredi <miklos@szeredi.hu>,
        xfs <linux-xfs@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] xfs: make sure link path does not go away at access
Message-ID: <YZVQUSCWWgOs+cRB@bfoster>
References: <163660197073.22525.11235124150551283676.stgit@mickey.themaw.net>
 <20211112003249.GL449541@dread.disaster.area>
 <CAJfpegvHDM_Mtc8+ASAcmNLd6RiRM+KutjBOoycun_Oq2=+p=w@mail.gmail.com>
 <20211114231834.GM449541@dread.disaster.area>
 <CAJfpegu4BwJD1JKngsrzUs7h82cYDGpxv0R1om=WGhOOb6pZ2Q@mail.gmail.com>
 <20211115222417.GO449541@dread.disaster.area>
 <f8425d1270fe011897e7e14eaa6ba8a77c1ed077.camel@themaw.net>
 <20211116030120.GQ449541@dread.disaster.area>
 <YZPVSTDIWroHNvFS@bfoster>
 <20211117002251.GR449541@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117002251.GR449541@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 17, 2021 at 11:22:51AM +1100, Dave Chinner wrote:
> On Tue, Nov 16, 2021 at 10:59:05AM -0500, Brian Foster wrote:
> > On Tue, Nov 16, 2021 at 02:01:20PM +1100, Dave Chinner wrote:
> > > On Tue, Nov 16, 2021 at 09:03:31AM +0800, Ian Kent wrote:
> > > > On Tue, 2021-11-16 at 09:24 +1100, Dave Chinner wrote:
> > > > > If it isn't safe for ext4 to do that, then we have a general
> > > > > pathwalk problem, not an XFS issue. But, as you say, it is safe
> > > > > to do this zeroing, so the fix to xfs_ifree() is to zero the
> > > > > link buffer instead of freeing it, just like ext4 does.
> > > > > 
> > > > > As a side issue, we really don't want to move what XFS does in
> > > > > .destroy_inode to .free_inode because that then means we need to
> > > > > add synchronise_rcu() calls everywhere in XFS that might need to
> > > > > wait on inodes being inactivated and/or reclaimed. And because
> > > > > inode reclaim uses lockless rcu lookups, there's substantial
> > > > > danger of adding rcu callback related deadlocks to XFS here.
> > > > > That's just not a direction we should be moving in.
> > > > 
> > > > Another reason I decided to use the ECHILD return instead is that
> > > > I thought synchronise_rcu() might add an unexpected delay.
> > > 
> > > It depends where you put the synchronise_rcu() call. :)
> > > 
> > > > Since synchronise_rcu() will only wait for processes that
> > > > currently have the rcu read lock do you think that could actually
> > > > be a problem in this code path?
> > > 
> > > No, I don't think it will.  The inode recycle case in XFS inode
> > > lookup can trigger in two cases:
> > > 
> > > 1. VFS cache eviction followed by immediate lookup
> > > 2. Inode has been unlinked and evicted, then free and reallocated by
> > > the filesytsem.
> > > 
> > > In case #1, that's a cold cache lookup and hence delays are
> > > acceptible (e.g. a slightly longer delay might result in having to
> > > fetch the inode from disk again). Calling synchronise_rcu() in this
> > > case is not going to be any different from having to fetch the inode
> > > from disk...
> > > 
> > > In case #2, there's a *lot* of CPU work being done to modify
> > > metadata (inode btree updates, etc), and so the operations can block
> > > on journal space, metadata IO, etc. Delays are acceptible, and could
> > > be in the order of hundreds of milliseconds if the transaction
> > > subsystem is bottlenecked. waiting for an RCU grace period when we
> > > reallocate an indoe immediately after freeing it isn't a big deal.
> > > 
> > > IOWs, if synchronize_rcu() turns out to be a problem, we can
> > > optimise that separately - we need to correct the inode reuse
> > > behaviour w.r.t. VFS RCU expectations, then we can optimise the
> > > result if there are perf problems stemming from correct behaviour.
> > > 
> > 
> > FWIW, with a fairly crude test on a high cpu count system, it's not that
> > difficult to reproduce an observable degradation in inode allocation
> > rate with a synchronous grace period in the inode reuse path, caused
> > purely by a lookup heavy workload on a completely separate filesystem.
> >
> > The following is a 5m snapshot of the iget stats from a filesystem doing
> > allocs/frees with an external/heavy lookup workload (which not included
> > in the stats), with and without a sync grace period wait in the reuse
> > path:
> > 
> > baseline:	ig 1337026 1331541 4 5485 0 5541 1337026
> > sync_rcu_test:	ig 2955 2588 0 367 0 383 2955
> 
> The alloc/free part of the workload is a single threaded
> create/unlink in a tight loop, yes?
> 
> This smells like a side effect of agressive reallocation of
> just-freed XFS_IRECLAIMABLE inodes from the finobt that haven't had
> their unlink state written back to disk yet. i.e. this is a corner
> case in #2 above where a small set of inodes is being repeated
> allocated and freed by userspace and hence being agressively reused
> and never needing to wait for IO. i.e. a tempfile workload
> optimisation...
> 

Yes, that was the point of the test.. to stress inode reuse against
known rcu activity.

> > I think this is kind of the nature of RCU and why I'm not sure it's a
> > great idea to rely on update side synchronization in a codepath that
> > might want to scale/perform in certain workloads.
> 
> The problem here is not update side synchronisation. Root cause is
> aggressive reallocation of recently freed VFS inodes via physical
> inode allocation algorithms. Unfortunately, the RCU grace period
> requirements of the VFS inode life cycle dictate that we can't
> aggressively re-allocate and reuse freed inodes like this. i.e.
> reallocation of a just-freed inode also has to wait for an RCU grace
> period to pass before the in memory inode can be re-instantiated as
> a newly allocated inode.
> 

I'm just showing that insertion of an synchronous rcu grace period wait
in the iget codepath is not without side effect, because that was the
proposal.

> (Hmmmm - I wonder if of the other filesystems might have similar
> problems with physical inode reallocation inside a RCU grace period?
> i.e. without inode instance re-use, the VFS could potentially see
> multiple in-memory instances of the same physical inode at the same
> time.)
> 
> > I'm not totally sure
> > if this will be a problem for real users running real workloads or not,
> > or if this can be easily mitigated, whether it's all rcu or a cascading
> > effect, etc. This is just a quick test so that all probably requires
> > more test and analysis to discern.
> 
> This looks like a similar problem to what busy extents address - we
> can't reuse a newly freed extent until the transaction containing
> the EFI/EFD hit stable storage (and the discard operation on the
> range is complete). Hence while a newly freed extent is
> marked free in the allocbt, they can't be reused until they are
> released from the busy extent tree.
> 
> I can think of several ways to address this, but let me think on it
> a bit more.  I suspect there's a trick we can use to avoid needing
> synchronise_rcu() completely by using the spare radix tree tag and
> rcu grace period state checks with get_state_synchronize_rcu() and
> poll_state_synchronize_rcu() to clear the radix tree tags via a
> periodic radix tree tag walk (i.e. allocation side polling for "can
> we use this inode" rather than waiting for the grace period to
> expire once an inode has been selected and allocated.)
> 

Yeah, and same. It's just a matter of how to break things down. I can
sort of see where you're going with the above, though I'm not totally
convinced that rcu gp polling is an advantage over explicit use of
existing infrastructure/apis. It seems more important that we avoid
overly crude things like sync waits in the alloc path vs. optimize away
potentially multiple async grace periods in the free path. Of course,
it's worth thinking about options regardless.

That said, is deferred inactivation still a thing? If so, then we've
already decided to defer/batch inactivations from the point the vfs
calls our ->destroy_inode() based on our own hueristic (which is likely
longer than a grace period already in most cases, making this even less
of an issue). That includes deferral of the physical free and inobt
updates, which means inode reuse can't occur until the inactivation
workqueue task runs. Only a single grace period is required to cover
(from the rcuwalk perspective) the entire set of inodes queued for
inactivation. That leaves at least a few fairly straightforward options:

1. Use queue_rcu_work() to schedule the inactivation task. We'd probably
have to isolate the list to process first from the queueing context
rather than from workqueue context to ensure we don't process recently
added inodes that haven't sat for a grace period.

2. Drop a synchronize_rcu() in the workqueue task before it starts
processing items.

3. Incorporate something like the above with an rcu grace period cookie
to selectively process inodes (or batches thereof).

Options 1 and 2 both seem rather simple and unlikely to noticeably
impact behavior/performance. Option 3 seems a bit overkill to me, but is
certainly an option if the previous assertion around performance doesn't
hold true (particularly if we keep the tracking simple, such as
recording/enforcing the most recent gp of the set). Thoughts?

Brian

> > > > 
> > > > Sorry, I don't understand what you mean by the root cause not
> > > > being identified?
> > > 
> > > The whole approach of "we don't know how to fix the inode reuse case
> > > so disable it" implies that nobody has understood where in the reuse
> > > case the problem lies. i.e. "inode reuse" by itself is not the root
> > > cause of the problem.
> > > 
> > 
> > I don't think anybody suggested to disable inode reuse.
> 
> Nobody did, so that's not what I was refering to. I was refering to
> the patches for and comments advocating disabling .get_link for RCU
> pathwalk because of the apparently unsolved problems stemming from
> inode reuse...
> 
> > > The root cause is "allowing an inode to be reused without waiting
> > > for an RCU grace period to expire". This might seem pedantic, but
> > > "without waiting for an rcu grace period to expire" is the important
> > > part of the problem (i.e. the bug), not the "allowing an inode to be
> > > reused" bit.
> > > 
> > > Once the RCU part of the problem is pointed out, the solution
> > > becomes obvious. As nobody had seen the obvious (wait for an RCU
> > > grace period when recycling an inode) it stands to reason that
> > > nobody really understood what the root cause of the inode reuse
> > > problem.
> > > 
> > 
> > The synchronize_rcu() approach was one of the first options discussed in
> > the bug report once a reproducer was available.
> 
> What bug report would that be? :/
> 
> It's not one that I've read, and I don't recall seeing a pointer to
> it anywhere in the path posting. IOWs, whatever discussion happened
> in a private distro bug report can't be assumed as "general
> knowledge" in an upstream discussion...
> 
> > AIUI, this is not currently a reproducible problem even before patch 1,
> > which reduces the race window even further. Given that and the nak on
> > the current patch (the justification for which I don't really
> > understand), I'm starting to agree with Ian's earlier statement that
> > perhaps it is best to separate this one so we can (hopefully) move patch
> > 1 along on its own merit..
> 
> *nod*
> 
> The problem seems pretty rare, the pathwalk patch makes it
> even rarer, so I think they can be separated just fine.
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

