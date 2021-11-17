Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6A5454F14
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Nov 2021 22:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240780AbhKQVLK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Nov 2021 16:11:10 -0500
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:53362 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240773AbhKQVJ3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Nov 2021 16:09:29 -0500
Received: from dread.disaster.area (pa49-195-103-97.pa.nsw.optusnet.com.au [49.195.103.97])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id 1A353A8815;
        Thu, 18 Nov 2021 08:06:26 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mnS8N-00A376-KU; Thu, 18 Nov 2021 08:06:23 +1100
Date:   Thu, 18 Nov 2021 08:06:23 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Ian Kent <raven@themaw.net>
Cc:     Brian Foster <bfoster@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        xfs <linux-xfs@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] xfs: make sure link path does not go away at access
Message-ID: <20211117210623.GT449541@dread.disaster.area>
References: <20211112003249.GL449541@dread.disaster.area>
 <CAJfpegvHDM_Mtc8+ASAcmNLd6RiRM+KutjBOoycun_Oq2=+p=w@mail.gmail.com>
 <20211114231834.GM449541@dread.disaster.area>
 <CAJfpegu4BwJD1JKngsrzUs7h82cYDGpxv0R1om=WGhOOb6pZ2Q@mail.gmail.com>
 <20211115222417.GO449541@dread.disaster.area>
 <f8425d1270fe011897e7e14eaa6ba8a77c1ed077.camel@themaw.net>
 <20211116030120.GQ449541@dread.disaster.area>
 <YZPVSTDIWroHNvFS@bfoster>
 <20211117002251.GR449541@dread.disaster.area>
 <4253c446d98f9800b43d5966636bddabb3c6b1a0.camel@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4253c446d98f9800b43d5966636bddabb3c6b1a0.camel@themaw.net>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=epq8cqlX c=1 sm=1 tr=0 ts=61956ed4
        a=fP9RlOTWD4uZJjPSFnn6Ew==:117 a=fP9RlOTWD4uZJjPSFnn6Ew==:17
        a=HsDoLlocmGUuF16g:21 a=8nJEP1OIZ-IA:10 a=vIxV3rELxO4A:10 a=7-415B0cAAAA:8
        a=5Hh4-gWYXWfbCYL41wkA:9 a=wPNLvfGTeEIA:10 a=hl_xKfOxWho2XEkUDbUg:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 17, 2021 at 10:19:46AM +0800, Ian Kent wrote:
> On Wed, 2021-11-17 at 11:22 +1100, Dave Chinner wrote:
> > On Tue, Nov 16, 2021 at 10:59:05AM -0500, Brian Foster wrote:
> > > On Tue, Nov 16, 2021 at 02:01:20PM +1100, Dave Chinner wrote:
> > > > On Tue, Nov 16, 2021 at 09:03:31AM +0800, Ian Kent wrote:
> > > > > On Tue, 2021-11-16 at 09:24 +1100, Dave Chinner wrote:
> > > > > > If it isn't safe for ext4 to do that, then we have a general
> > > > > > pathwalk problem, not an XFS issue. But, as you say, it is
> > > > > > safe
> > > > > > to do this zeroing, so the fix to xfs_ifree() is to zero the
> > > > > > link buffer instead of freeing it, just like ext4 does.
> > > > > > 
> > > > > > As a side issue, we really don't want to move what XFS does
> > > > > > in
> > > > > > .destroy_inode to .free_inode because that then means we need
> > > > > > to
> > > > > > add synchronise_rcu() calls everywhere in XFS that might need
> > > > > > to
> > > > > > wait on inodes being inactivated and/or reclaimed. And
> > > > > > because
> > > > > > inode reclaim uses lockless rcu lookups, there's substantial
> > > > > > danger of adding rcu callback related deadlocks to XFS here.
> > > > > > That's just not a direction we should be moving in.
> > > > > 
> > > > > Another reason I decided to use the ECHILD return instead is
> > > > > that
> > > > > I thought synchronise_rcu() might add an unexpected delay.
> > > > 
> > > > It depends where you put the synchronise_rcu() call. :)
> > > > 
> > > > > Since synchronise_rcu() will only wait for processes that
> > > > > currently have the rcu read lock do you think that could
> > > > > actually
> > > > > be a problem in this code path?
> > > > 
> > > > No, I don't think it will.  The inode recycle case in XFS inode
> > > > lookup can trigger in two cases:
> > > > 
> > > > 1. VFS cache eviction followed by immediate lookup
> > > > 2. Inode has been unlinked and evicted, then free and reallocated
> > > > by
> > > > the filesytsem.
> > > > 
> > > > In case #1, that's a cold cache lookup and hence delays are
> > > > acceptible (e.g. a slightly longer delay might result in having
> > > > to
> > > > fetch the inode from disk again). Calling synchronise_rcu() in
> > > > this
> > > > case is not going to be any different from having to fetch the
> > > > inode
> > > > from disk...
> > > > 
> > > > In case #2, there's a *lot* of CPU work being done to modify
> > > > metadata (inode btree updates, etc), and so the operations can
> > > > block
> > > > on journal space, metadata IO, etc. Delays are acceptible, and
> > > > could
> > > > be in the order of hundreds of milliseconds if the transaction
> > > > subsystem is bottlenecked. waiting for an RCU grace period when
> > > > we
> > > > reallocate an indoe immediately after freeing it isn't a big
> > > > deal.
> > > > 
> > > > IOWs, if synchronize_rcu() turns out to be a problem, we can
> > > > optimise that separately - we need to correct the inode reuse
> > > > behaviour w.r.t. VFS RCU expectations, then we can optimise the
> > > > result if there are perf problems stemming from correct
> > > > behaviour.
> > > > 
> > > 
> > > FWIW, with a fairly crude test on a high cpu count system, it's not
> > > that
> > > difficult to reproduce an observable degradation in inode
> > > allocation
> > > rate with a synchronous grace period in the inode reuse path,
> > > caused
> > > purely by a lookup heavy workload on a completely separate
> > > filesystem.
> > > 
> > > The following is a 5m snapshot of the iget stats from a filesystem
> > > doing
> > > allocs/frees with an external/heavy lookup workload (which not
> > > included
> > > in the stats), with and without a sync grace period wait in the
> > > reuse
> > > path:
> > > 
> > > baseline:       ig 1337026 1331541 4 5485 0 5541 1337026
> > > sync_rcu_test:  ig 2955 2588 0 367 0 383 2955
> > 
> > The alloc/free part of the workload is a single threaded
> > create/unlink in a tight loop, yes?
> > 
> > This smells like a side effect of agressive reallocation of
> > just-freed XFS_IRECLAIMABLE inodes from the finobt that haven't had
> > their unlink state written back to disk yet. i.e. this is a corner
> > case in #2 above where a small set of inodes is being repeated
> > allocated and freed by userspace and hence being agressively reused
> > and never needing to wait for IO. i.e. a tempfile workload
> > optimisation...
> > 
> > > I think this is kind of the nature of RCU and why I'm not sure it's
> > > a
> > > great idea to rely on update side synchronization in a codepath
> > > that
> > > might want to scale/perform in certain workloads.
> > 
> > The problem here is not update side synchronisation. Root cause is
> > aggressive reallocation of recently freed VFS inodes via physical
> > inode allocation algorithms. Unfortunately, the RCU grace period
> > requirements of the VFS inode life cycle dictate that we can't
> > aggressively re-allocate and reuse freed inodes like this. i.e.
> > reallocation of a just-freed inode also has to wait for an RCU grace
> > period to pass before the in memory inode can be re-instantiated as
> > a newly allocated inode.
> > 
> > (Hmmmm - I wonder if of the other filesystems might have similar
> > problems with physical inode reallocation inside a RCU grace period?
> > i.e. without inode instance re-use, the VFS could potentially see
> > multiple in-memory instances of the same physical inode at the same
> > time.)
> > 
> > > I'm not totally sure
> > > if this will be a problem for real users running real workloads or
> > > not,
> > > or if this can be easily mitigated, whether it's all rcu or a
> > > cascading
> > > effect, etc. This is just a quick test so that all probably
> > > requires
> > > more test and analysis to discern.
> > 
> > This looks like a similar problem to what busy extents address - we
> > can't reuse a newly freed extent until the transaction containing
> > the EFI/EFD hit stable storage (and the discard operation on the
> > range is complete). Hence while a newly freed extent is
> > marked free in the allocbt, they can't be reused until they are
> > released from the busy extent tree.
> > 
> > I can think of several ways to address this, but let me think on it
> > a bit more.  I suspect there's a trick we can use to avoid needing
> > synchronise_rcu() completely by using the spare radix tree tag and
> > rcu grace period state checks with get_state_synchronize_rcu() and
> > poll_state_synchronize_rcu() to clear the radix tree tags via a
> > periodic radix tree tag walk (i.e. allocation side polling for "can
> > we use this inode" rather than waiting for the grace period to
> > expire once an inode has been selected and allocated.)
> 
> The synchronise_rcu() seems like it's too broad a brush.

It has always been a big hammer. But correctness comes first, speed
second.

> It sounds like there are relatively simple ways to avoid the link
> path race which I won't go into again but there's still a chance
> inode re-use can cause confusion if done at the wrong time.
> 
> So it sounds like per-object (inode) granularity is needed for the
> wait and that means answering the question "how do we know when it's
> ok to re-use the inode" when we come to alloc the inode and want to
> re-use one.

When we free the inode, we simply mark it with a radix tree tag and
record the rcu grace sequence in the inode via
get_state_synchronize_rcu().  Then when allocation selects an inode
for allocation, we do a radix tree tag lookup on that inode number,
and if it is set we move to the next free inode in the finobt. Every
so often we sweep the radix tree clearing the tags for inodes with
expired grace periods, allowing them to be reallocated again. The
radix tree lookups during allocation would be fairly cheap
(lockless, read-only, just checking for a tag, not dereferencing the
slot) - I added two lookups on this tree per unlinked inode to turn
the list into a double linked list in memory and didn't see any
significant increase in overhead. If allocation succeeds then we are
going to insert/lookup the inode in that slot in the near future, so
we are going to take the hit of bringing that radix tree node into
CPU caches anyway...

> There'd be a need to know when not to wait at all too ... mmm.

Yup, that's what get_state_synchronize_rcu and
poll_state_synchronize_rcu give us.

Cheers,

Dave
-- 
Dave Chinner
david@fromorbit.com
