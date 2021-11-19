Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54019457742
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Nov 2021 20:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbhKSTrc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 14:47:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25425 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236107AbhKSTrb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 14:47:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637351068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=46YYqrkRHLAschjfxpnYjUnB3WM/67rchyHoD+P7T4k=;
        b=OoN0qEKpCltocfKNAOsrlQ3B4DvnoqWifgGkpZg4wH2ZayaYXiPOw+ySCiaSaYXTk/lkMi
        Pd8QqtyolF3IN8vG/3rOi+p/eP0iUtd9zhl+B9Apqn/cuYNFDzHptdDrnNdAc1fBE+xGZi
        l62dkgWTpJYJwhctDJ8eWBWSsVsX5jc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-Ptgf8jGOPRyFDLC_-mBA2Q-1; Fri, 19 Nov 2021 14:44:25 -0500
X-MC-Unique: Ptgf8jGOPRyFDLC_-mBA2Q-1
Received: by mail-qk1-f199.google.com with SMTP id bk21-20020a05620a1a1500b004631b196a46so8744353qkb.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Nov 2021 11:44:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=46YYqrkRHLAschjfxpnYjUnB3WM/67rchyHoD+P7T4k=;
        b=vBBEKnjUb6Yj7ZQGbLcHrEa+iKOiylg2hpzWfMbfTNdgBydKy61cs33EDA4s54F8nc
         MBTYOahWi2N/Xt5Y9YJAKioRgwAH2l83keJfhEd2OO6B5Kl296xEp4pRCOkkhseSeC2D
         bvOvC+fzwSG1yO2xuEFZ/fXTnprWSrZIaOi5R3XeXV4tJPrcQitYrO5QYN0YmRvQBhti
         6MAUe8WTMmucqApvcwwxZcDFoBaGwJu4QMwhEdi7+NmvkVArux9bUJ60UJo1cPorabzN
         DnANejUhm0VSoFH+XtaH9CLvVzCg5YAeTKpuH6nwTSkreCVuplOskEc+LMxsCq82nR9n
         vz2Q==
X-Gm-Message-State: AOAM532vrcJ41HQDyI511eoMgZGWtmGBD1wj3QnJNRg/jOKx+32GU4Bs
        ZdJ0sFqJt7h4avoQNc+aQo/nKLm9P+vRPs5r0kCU+i7e4pRHT8kDyr/51uGm9xoila8a070/yiH
        WAHKZrX6QRLX8m26Xoflzt2MS6Q==
X-Received: by 2002:a05:620a:cd0:: with SMTP id b16mr29177119qkj.401.1637351065065;
        Fri, 19 Nov 2021 11:44:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJysHFtfV18hC6YuuWrifxKZACnDo9Rpegn7SNHmMA0Gt36hkY0oZv4M71OJoUkrmEmH/IJHKg==
X-Received: by 2002:a05:620a:cd0:: with SMTP id b16mr29177093qkj.401.1637351064705;
        Fri, 19 Nov 2021 11:44:24 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id az16sm318729qkb.124.2021.11.19.11.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 11:44:24 -0800 (PST)
Date:   Fri, 19 Nov 2021 14:44:21 -0500
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
Message-ID: <YZf+lRsb0lBWdYgN@bfoster>
References: <CAJfpegvHDM_Mtc8+ASAcmNLd6RiRM+KutjBOoycun_Oq2=+p=w@mail.gmail.com>
 <20211114231834.GM449541@dread.disaster.area>
 <CAJfpegu4BwJD1JKngsrzUs7h82cYDGpxv0R1om=WGhOOb6pZ2Q@mail.gmail.com>
 <20211115222417.GO449541@dread.disaster.area>
 <f8425d1270fe011897e7e14eaa6ba8a77c1ed077.camel@themaw.net>
 <20211116030120.GQ449541@dread.disaster.area>
 <YZPVSTDIWroHNvFS@bfoster>
 <20211117002251.GR449541@dread.disaster.area>
 <YZVQUSCWWgOs+cRB@bfoster>
 <20211117214852.GU449541@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117214852.GU449541@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 18, 2021 at 08:48:52AM +1100, Dave Chinner wrote:
> On Wed, Nov 17, 2021 at 01:56:17PM -0500, Brian Foster wrote:
> > On Wed, Nov 17, 2021 at 11:22:51AM +1100, Dave Chinner wrote:
> > > On Tue, Nov 16, 2021 at 10:59:05AM -0500, Brian Foster wrote:
> > > > On Tue, Nov 16, 2021 at 02:01:20PM +1100, Dave Chinner wrote:
> > > > > On Tue, Nov 16, 2021 at 09:03:31AM +0800, Ian Kent wrote:
> > > > > > On Tue, 2021-11-16 at 09:24 +1100, Dave Chinner wrote:
> > > > > > > If it isn't safe for ext4 to do that, then we have a general
> > > > > > > pathwalk problem, not an XFS issue. But, as you say, it is safe
> > > > > > > to do this zeroing, so the fix to xfs_ifree() is to zero the
> > > > > > > link buffer instead of freeing it, just like ext4 does.
> > > > > > > 
> > > > > > > As a side issue, we really don't want to move what XFS does in
> > > > > > > .destroy_inode to .free_inode because that then means we need to
> > > > > > > add synchronise_rcu() calls everywhere in XFS that might need to
> > > > > > > wait on inodes being inactivated and/or reclaimed. And because
> > > > > > > inode reclaim uses lockless rcu lookups, there's substantial
> > > > > > > danger of adding rcu callback related deadlocks to XFS here.
> > > > > > > That's just not a direction we should be moving in.
> > > > > > 
> > > > > > Another reason I decided to use the ECHILD return instead is that
> > > > > > I thought synchronise_rcu() might add an unexpected delay.
> > > > > 
> > > > > It depends where you put the synchronise_rcu() call. :)
> > > > > 
> > > > > > Since synchronise_rcu() will only wait for processes that
> > > > > > currently have the rcu read lock do you think that could actually
> > > > > > be a problem in this code path?
> > > > > 
> > > > > No, I don't think it will.  The inode recycle case in XFS inode
> > > > > lookup can trigger in two cases:
> > > > > 
> > > > > 1. VFS cache eviction followed by immediate lookup
> > > > > 2. Inode has been unlinked and evicted, then free and reallocated by
> > > > > the filesytsem.
> > > > > 
> > > > > In case #1, that's a cold cache lookup and hence delays are
> > > > > acceptible (e.g. a slightly longer delay might result in having to
> > > > > fetch the inode from disk again). Calling synchronise_rcu() in this
> > > > > case is not going to be any different from having to fetch the inode
> > > > > from disk...
> > > > > 
> > > > > In case #2, there's a *lot* of CPU work being done to modify
> > > > > metadata (inode btree updates, etc), and so the operations can block
> > > > > on journal space, metadata IO, etc. Delays are acceptible, and could
> > > > > be in the order of hundreds of milliseconds if the transaction
> > > > > subsystem is bottlenecked. waiting for an RCU grace period when we
> > > > > reallocate an indoe immediately after freeing it isn't a big deal.
> > > > > 
> > > > > IOWs, if synchronize_rcu() turns out to be a problem, we can
> > > > > optimise that separately - we need to correct the inode reuse
> > > > > behaviour w.r.t. VFS RCU expectations, then we can optimise the
> > > > > result if there are perf problems stemming from correct behaviour.
> > > > > 
> > > > 
> > > > FWIW, with a fairly crude test on a high cpu count system, it's not that
> > > > difficult to reproduce an observable degradation in inode allocation
> > > > rate with a synchronous grace period in the inode reuse path, caused
> > > > purely by a lookup heavy workload on a completely separate filesystem.
> > > >
> > > > The following is a 5m snapshot of the iget stats from a filesystem doing
> > > > allocs/frees with an external/heavy lookup workload (which not included
> > > > in the stats), with and without a sync grace period wait in the reuse
> > > > path:
> > > > 
> > > > baseline:	ig 1337026 1331541 4 5485 0 5541 1337026
> > > > sync_rcu_test:	ig 2955 2588 0 367 0 383 2955
> > > 
> > > The alloc/free part of the workload is a single threaded
> > > create/unlink in a tight loop, yes?
> > > 
> > > This smells like a side effect of agressive reallocation of
> > > just-freed XFS_IRECLAIMABLE inodes from the finobt that haven't had
> > > their unlink state written back to disk yet. i.e. this is a corner
> > > case in #2 above where a small set of inodes is being repeated
> > > allocated and freed by userspace and hence being agressively reused
> > > and never needing to wait for IO. i.e. a tempfile workload
> > > optimisation...
> > > 
> > 
> > Yes, that was the point of the test.. to stress inode reuse against
> > known rcu activity.
> > 
> > > > I think this is kind of the nature of RCU and why I'm not sure it's a
> > > > great idea to rely on update side synchronization in a codepath that
> > > > might want to scale/perform in certain workloads.
> > > 
> > > The problem here is not update side synchronisation. Root cause is
> > > aggressive reallocation of recently freed VFS inodes via physical
> > > inode allocation algorithms. Unfortunately, the RCU grace period
> > > requirements of the VFS inode life cycle dictate that we can't
> > > aggressively re-allocate and reuse freed inodes like this. i.e.
> > > reallocation of a just-freed inode also has to wait for an RCU grace
> > > period to pass before the in memory inode can be re-instantiated as
> > > a newly allocated inode.
> > > 
> > 
> > I'm just showing that insertion of an synchronous rcu grace period wait
> > in the iget codepath is not without side effect, because that was the
> > proposal.
> > 
> > > (Hmmmm - I wonder if of the other filesystems might have similar
> > > problems with physical inode reallocation inside a RCU grace period?
> > > i.e. without inode instance re-use, the VFS could potentially see
> > > multiple in-memory instances of the same physical inode at the same
> > > time.)
> > > 
> > > > I'm not totally sure
> > > > if this will be a problem for real users running real workloads or not,
> > > > or if this can be easily mitigated, whether it's all rcu or a cascading
> > > > effect, etc. This is just a quick test so that all probably requires
> > > > more test and analysis to discern.
> > > 
> > > This looks like a similar problem to what busy extents address - we
> > > can't reuse a newly freed extent until the transaction containing
> > > the EFI/EFD hit stable storage (and the discard operation on the
> > > range is complete). Hence while a newly freed extent is
> > > marked free in the allocbt, they can't be reused until they are
> > > released from the busy extent tree.
> > > 
> > > I can think of several ways to address this, but let me think on it
> > > a bit more.  I suspect there's a trick we can use to avoid needing
> > > synchronise_rcu() completely by using the spare radix tree tag and
> > > rcu grace period state checks with get_state_synchronize_rcu() and
> > > poll_state_synchronize_rcu() to clear the radix tree tags via a
> > > periodic radix tree tag walk (i.e. allocation side polling for "can
> > > we use this inode" rather than waiting for the grace period to
> > > expire once an inode has been selected and allocated.)
> > > 
> > 
> > Yeah, and same. It's just a matter of how to break things down. I can
> > sort of see where you're going with the above, though I'm not totally
> > convinced that rcu gp polling is an advantage over explicit use of
> > existing infrastructure/apis.
> 
> RCU gp polling is existing infrastructure/apis. It's used in several
> places to explicitly elide unnecessary calls to
> synchronise_rcu()....
> 
> > It seems more important that we avoid
> > overly crude things like sync waits in the alloc path vs. optimize away
> > potentially multiple async grace periods in the free path. Of course,
> > it's worth thinking about options regardless.
> > 
> > That said, is deferred inactivation still a thing? If so, then we've
> 
> Already merged.
> 
> > already decided to defer/batch inactivations from the point the vfs
> > calls our ->destroy_inode() based on our own hueristic (which is likely
> > longer than a grace period already in most cases, making this even less
> > of an issue).
> 
> No, Performance problems with large/long queues dictated a solution
> in the other direction, into lockless, minimal depth, low delay
> per-cpu deferred batching. IOWs, batch scheduling has significatly
> faster scheduling requirements than RCU grace periods provide.
> 
> > That includes deferral of the physical free and inobt
> > updates, which means inode reuse can't occur until the inactivation
> > workqueue task runs.
> 
> Which can happen the moment the inode is queued for inactivation
> on CONFIG_PREEMPT configs, long before a RCU grace period has
> expired.
> 
> > Only a single grace period is required to cover
> > (from the rcuwalk perspective) the entire set of inodes queued for
> > inactivation. That leaves at least a few fairly straightforward options:
> > 
> > 1. Use queue_rcu_work() to schedule the inactivation task. We'd probably
> > have to isolate the list to process first from the queueing context
> > rather than from workqueue context to ensure we don't process recently
> > added inodes that haven't sat for a grace period.
> 
> No, that takes too long. Long queues simply mean deferred
> inactivation is working on cold CPU caches and that means we take a
> 30-50% performance hit on inode eviction overhead for inodes that
> need inactivation (e.g. unlinked inodes) just by having to load all
> the inode state into CPU caches again.
> 
> Numbers I recorded at the time indicate that inactivation that
> doesn't block on IO or the log typically takes between 200-500us
> of CPU time, so the deferred batch sizes are sized to run about
> 10-15ms worth of deferred processing at a time. Filling a batch
> takes memory reclaim about 200uS to fill when running
> dispose_list() to evict inodes.
> 
> The problem with using RCU grace periods is that they delay the
> start of the work for at least 10ms, sometimes hundreds of ms.
> Using queue_rcu_work() means we will need to go back to unbound
> depth queues to avoid blocking waiting for grace period expiry to
> maintain perfomrance. THis means having tens of thousands of inodes
> queued for inactivation before the workqueue starts running. These
> are the sorts of numbers that caused all the problems Darrick was
> having with performance, and that was all cold cache loading
> overhead which is unavoidable with such large queue depths....
> 

Hm, Ok. I recall the large queue depth issues on the earlier versions
but had not caught up with the subsequent changes that limit (percpu)
batch size, etc. The cond sync rcu approach is easy enough to hack in
(i.e., sample gp on destroy, cond_sync_rcu() on inactivate) that I ran a
few experiments on opposing ends of the spectrum wrt to concurrency.

The short of it is that I do see about a 30% hit in the single threaded
sustained removal case with current batch sizes. If the workload scales
out to many (64) cpus, the impact dissipates, I suspect because we've
already distributed the workload across percpu wq tasks and thus drive
the rcu subsystem with context switches and other quiescent states that
progress grace periods. The single threaded perf hit mitigates at about
4x the current throttling threshold.

> > 2. Drop a synchronize_rcu() in the workqueue task before it starts
> > processing items.
> 
> Same problem. The per-cpu queue currently has a hard throttle at 256
> inodes and that means nothing will be able to queue inodes for
> inactivation on that CPU until the current RCU grace period expires.
> 

Yeah..

> > 3. Incorporate something like the above with an rcu grace period cookie
> > to selectively process inodes (or batches thereof).
> 
> The use of lockless linked lists in the per-cpu queues makes that
> difficult. Lockless dequeue requires removing the entire list from
> the shared list head atomically, and it's a single linked list so we
> can't selectively remove inodes from the list without a full
> traversal. And selective removal from the list can't be done
> locklessly.
> 

Sure, that's why I referred to "batches thereof."

> We could, potentially, use a separate lockless queue for unlinked
> inodes and defer that to after a grace period, but then rm -rf
> workloads will go much, much slower.
> 

I don't quite follow what you mean by a separate lockless queue..?  In
any event, another experiment I ran in light of the above results that
might be similar was to put the inode queueing component of
destroy_inode() behind an rcu callback. This reduces the single threaded
perf hit from the previous approach by about 50%. So not entirely
baseline performance, but it's back closer to baseline if I double the
throttle threshold (and actually faster at 4x). Perhaps my crude
prototype logic could be optimized further to not rely on percpu
threshold changes to match the baseline.

My overall takeaway from these couple hacky experiments is that the
unconditional synchronous rcu wait is indeed probably too heavy weight,
as you point out. The polling or callback (or perhaps your separate
queue) approach seems to be in the ballpark of viability, however,
particularly when we consider the behavior of scaled or mixed workloads
(since inactive queue processing seems to be size driven vs. latency
driven).

So I dunno.. if you consider the various severity and complexity
tradeoffs, this certainly seems worth more consideration to me. I can
think of other potentially interesting ways to experiment with
optimizing the above or perhaps tweak queueing to better facilitate
taking advantage of grace periods, but it's not worth going too far down
that road if you're wedded to the "busy inodes" approach.

Brian

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

