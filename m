Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9465F45282A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 04:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237021AbhKPDEn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Nov 2021 22:04:43 -0500
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:53273 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349011AbhKPDE1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Nov 2021 22:04:27 -0500
Received: from dread.disaster.area (pa49-195-103-97.pa.nsw.optusnet.com.au [49.195.103.97])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id 02BB0A4879;
        Tue, 16 Nov 2021 14:01:22 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mmoim-009M9s-MF; Tue, 16 Nov 2021 14:01:20 +1100
Date:   Tue, 16 Nov 2021 14:01:20 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Ian Kent <raven@themaw.net>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        xfs <linux-xfs@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Brian Foster <bfoster@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] xfs: make sure link path does not go away at access
Message-ID: <20211116030120.GQ449541@dread.disaster.area>
References: <163660195990.22525.6041281669106537689.stgit@mickey.themaw.net>
 <163660197073.22525.11235124150551283676.stgit@mickey.themaw.net>
 <20211112003249.GL449541@dread.disaster.area>
 <CAJfpegvHDM_Mtc8+ASAcmNLd6RiRM+KutjBOoycun_Oq2=+p=w@mail.gmail.com>
 <20211114231834.GM449541@dread.disaster.area>
 <CAJfpegu4BwJD1JKngsrzUs7h82cYDGpxv0R1om=WGhOOb6pZ2Q@mail.gmail.com>
 <20211115222417.GO449541@dread.disaster.area>
 <f8425d1270fe011897e7e14eaa6ba8a77c1ed077.camel@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f8425d1270fe011897e7e14eaa6ba8a77c1ed077.camel@themaw.net>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=61931f08
        a=fP9RlOTWD4uZJjPSFnn6Ew==:117 a=fP9RlOTWD4uZJjPSFnn6Ew==:17
        a=HsDoLlocmGUuF16g:21 a=8nJEP1OIZ-IA:10 a=vIxV3rELxO4A:10 a=7-415B0cAAAA:8
        a=aOrxH43kqUc55-AE6OAA:9 a=wPNLvfGTeEIA:10 a=hl_xKfOxWho2XEkUDbUg:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 16, 2021 at 09:03:31AM +0800, Ian Kent wrote:
> On Tue, 2021-11-16 at 09:24 +1100, Dave Chinner wrote:
> > On Mon, Nov 15, 2021 at 10:21:03AM +0100, Miklos Szeredi wrote:
> > > On Mon, 15 Nov 2021 at 00:18, Dave Chinner <david@fromorbit.com>
> > > wrote:
> > > > I just can't see how this race condition is XFS specific and why
> > > > fixing it requires XFS to sepcifically handle it while we ignore
> > > > similar theoretical issues in other filesystems...
> > > 
> > > It is XFS specific, because all other filesystems RCU free the in-
> > > core
> > > inode after eviction.
> > > 
> > > XFS is the only one that reuses the in-core inode object and that
> > > is
> > > very much different from anything the other filesystems do and what
> > > the VFS expects.
> > 
> > Sure, but I was refering to the xfs_ifree issue that the patch
> > addressed, not the re-use issue that the *first patch addressed*.
> > 
> > > I don't see how clearing the quick link buffer in
> > > ext4_evict_inode()
> > > could do anything bad.  The contents are irrelevant, the lookup
> > > will
> > > be restarted anyway, the important thing is that the buffer is not
> > > freed and that it's null terminated, and both hold for the ext4,
> > > AFAICS.
> > 
> > You miss the point (which, admittedly, probably wasn't clear).
> > 
> > I suggested just zeroing the buffer in xfs_ifree instead of zeroing
> > it, which you seemed to suggest wouldn't work and we should move the
> > XFS functionality to .free_inode. That's what I was refering to as
> > "not being XFS specific" - if it is safe for ext4 to zero the link
> > buffer in .evict while lockless lookups can still be accessing the
> > link buffer, it is safe for XFS to do the same thing in .destroy
> > context.
> 
> I'll need to think about that for a while.
> 
> Zeroing the buffer while it's being used seems like a problem to
> me and was what this patch was trying to avoid.

*nod*

That was my reading of the situation when I saw what ext4 was doing.
But Miklos says that this is fine, and I don't know the code well
enough to say he's wrong. So if it's ok for ext4, it's OK for XFS.
If it's not OK for XFS, then it isn't OK for ext4 either, and we
have more bugs to fix than just in XFS.

> I thought all that would be needed for this to happen is for a
> dentry drop to occur while the link walk was happening after
> ->get_link() had returned the pointer.
> 
> What have I got wrong in that thinking?

Nothing that I can see, but see my previous statement above.

I *think* that just zeroing the buffer means the race condition
means the link resolves as either wholly intact, partially zeroed
with trailing zeros in the length, wholly zeroed or zero length.
Nothing will crash, the link string is always null terminated even
if the length is wrong, and so nothing bad should happen as a result
of zeroing the symlink buffer when it gets evicted from the VFS
inode cache after unlink.

> > If it isn't safe for ext4 to do that, then we have a general
> > pathwalk problem, not an XFS issue. But, as you say, it is safe
> > to do this zeroing, so the fix to xfs_ifree() is to zero the
> > link buffer instead of freeing it, just like ext4 does.
> > 
> > As a side issue, we really don't want to move what XFS does in
> > .destroy_inode to .free_inode because that then means we need to
> > add synchronise_rcu() calls everywhere in XFS that might need to
> > wait on inodes being inactivated and/or reclaimed. And because
> > inode reclaim uses lockless rcu lookups, there's substantial
> > danger of adding rcu callback related deadlocks to XFS here.
> > That's just not a direction we should be moving in.
> 
> Another reason I decided to use the ECHILD return instead is that
> I thought synchronise_rcu() might add an unexpected delay.

It depends where you put the synchronise_rcu() call. :)

> Since synchronise_rcu() will only wait for processes that
> currently have the rcu read lock do you think that could actually
> be a problem in this code path?

No, I don't think it will.  The inode recycle case in XFS inode
lookup can trigger in two cases:

1. VFS cache eviction followed by immediate lookup
2. Inode has been unlinked and evicted, then free and reallocated by
the filesytsem.

In case #1, that's a cold cache lookup and hence delays are
acceptible (e.g. a slightly longer delay might result in having to
fetch the inode from disk again). Calling synchronise_rcu() in this
case is not going to be any different from having to fetch the inode
from disk...

In case #2, there's a *lot* of CPU work being done to modify
metadata (inode btree updates, etc), and so the operations can block
on journal space, metadata IO, etc. Delays are acceptible, and could
be in the order of hundreds of milliseconds if the transaction
subsystem is bottlenecked. waiting for an RCU grace period when we
reallocate an indoe immediately after freeing it isn't a big deal.

IOWs, if synchronize_rcu() turns out to be a problem, we can
optimise that separately - we need to correct the inode reuse
behaviour w.r.t. VFS RCU expectations, then we can optimise the
result if there are perf problems stemming from correct behaviour.

> > I'll also point out that this would require XFS inodes to pass
> > through *two* rcu grace periods before the memory they hold could be
> > freed because, as I mentioned, xfs inode reclaim uses rcu protected
> > inode lookups and so relies on inodes to be freed by rcu callback...
> > 
> > > I tend to agree with Brian and Ian at this point: return -ECHILD
> > > from
> > > xfs_vn_get_link_inline() until xfs's inode resue vs. rcu walk
> > > implications are fully dealt with.  No way to fix this from VFS
> > > alone.
> > 
> > I disagree from a fundamental process POV - this is just sweeping
> > the issue under the table and leaving it for someone else to solve
> > because the root cause of the inode re-use issue has not been
> > identified. But to the person who architected the lockless XFS inode
> > cache 15 years ago, it's pretty obvious, so let's just solve it now.
> 
> Sorry, I don't understand what you mean by the root cause not
> being identified?

The whole approach of "we don't know how to fix the inode reuse case
so disable it" implies that nobody has understood where in the reuse
case the problem lies. i.e. "inode reuse" by itself is not the root
cause of the problem.

The root cause is "allowing an inode to be reused without waiting
for an RCU grace period to expire". This might seem pedantic, but
"without waiting for an rcu grace period to expire" is the important
part of the problem (i.e. the bug), not the "allowing an inode to be
reused" bit.

Once the RCU part of the problem is pointed out, the solution
becomes obvious. As nobody had seen the obvious (wait for an RCU
grace period when recycling an inode) it stands to reason that
nobody really understood what the root cause of the inode reuse
problem.

> > With the xfs_ifree() problem solved by zeroing rather than freeing,
> > then the only other problem is inode reuse *within an rcu grace
> > period*. Immediate inode reuse tends to be rare, (we can actually
> > trace occurrences to validate this assertion), and implementation
> > wise reuse is isolated to a single function: xfs_iget_recycle().
> > 
> > xfs_iget_recycle() drops the rcu_read_lock() inode lookup context
> > that found the inode marks it as being reclaimed (preventing other
> > lookups from finding it), then re-initialises the inode. This is
> > what makes .get_link change in the middle of pathwalk - we're
> > reinitialising the inode without waiting for the RCU grace period to
> > expire.
> 
> Ok, good to know that, there's a lot of icache code to look
> through, ;)

My point precisely. :)

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
