Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A454517C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Nov 2021 23:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351026AbhKOWqU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Nov 2021 17:46:20 -0500
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:55880 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349461AbhKOW10 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Nov 2021 17:27:26 -0500
Received: from dread.disaster.area (pa49-195-103-97.pa.nsw.optusnet.com.au [49.195.103.97])
        by mail110.syd.optusnet.com.au (Postfix) with ESMTPS id 2386D10A222;
        Tue, 16 Nov 2021 09:24:18 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mmkOf-009HGm-MV; Tue, 16 Nov 2021 09:24:17 +1100
Date:   Tue, 16 Nov 2021 09:24:17 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Ian Kent <raven@themaw.net>, xfs <linux-xfs@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Brian Foster <bfoster@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] xfs: make sure link path does not go away at access
Message-ID: <20211115222417.GO449541@dread.disaster.area>
References: <163660195990.22525.6041281669106537689.stgit@mickey.themaw.net>
 <163660197073.22525.11235124150551283676.stgit@mickey.themaw.net>
 <20211112003249.GL449541@dread.disaster.area>
 <CAJfpegvHDM_Mtc8+ASAcmNLd6RiRM+KutjBOoycun_Oq2=+p=w@mail.gmail.com>
 <20211114231834.GM449541@dread.disaster.area>
 <CAJfpegu4BwJD1JKngsrzUs7h82cYDGpxv0R1om=WGhOOb6pZ2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegu4BwJD1JKngsrzUs7h82cYDGpxv0R1om=WGhOOb6pZ2Q@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=6192de15
        a=fP9RlOTWD4uZJjPSFnn6Ew==:117 a=fP9RlOTWD4uZJjPSFnn6Ew==:17
        a=HsDoLlocmGUuF16g:21 a=kj9zAlcOel0A:10 a=vIxV3rELxO4A:10 a=7-415B0cAAAA:8
        a=hBwIGOmajLrGL4O3OTcA:9 a=CjuIK1q_8ugA:10 a=hl_xKfOxWho2XEkUDbUg:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 15, 2021 at 10:21:03AM +0100, Miklos Szeredi wrote:
> On Mon, 15 Nov 2021 at 00:18, Dave Chinner <david@fromorbit.com> wrote:
> > I just can't see how this race condition is XFS specific and why
> > fixing it requires XFS to sepcifically handle it while we ignore
> > similar theoretical issues in other filesystems...
> 
> It is XFS specific, because all other filesystems RCU free the in-core
> inode after eviction.
> 
> XFS is the only one that reuses the in-core inode object and that is
> very much different from anything the other filesystems do and what
> the VFS expects.

Sure, but I was refering to the xfs_ifree issue that the patch
addressed, not the re-use issue that the *first patch addressed*.

> I don't see how clearing the quick link buffer in ext4_evict_inode()
> could do anything bad.  The contents are irrelevant, the lookup will
> be restarted anyway, the important thing is that the buffer is not
> freed and that it's null terminated, and both hold for the ext4,
> AFAICS.

You miss the point (which, admittedly, probably wasn't clear).

I suggested just zeroing the buffer in xfs_ifree instead of zeroing
it, which you seemed to suggest wouldn't work and we should move the
XFS functionality to .free_inode. That's what I was refering to as
"not being XFS specific" - if it is safe for ext4 to zero the link
buffer in .evict while lockless lookups can still be accessing the
link buffer, it is safe for XFS to do the same thing in .destroy
context.

If it isn't safe for ext4 to do that, then we have a general
pathwalk problem, not an XFS issue. But, as you say, it is safe to
do this zeroing, so the fix to xfs_ifree() is to zero the link
buffer instead of freeing it, just like ext4 does.

As a side issue, we really don't want to move what XFS does in
.destroy_inode to .free_inode because that then means we need to add
synchronise_rcu() calls everywhere in XFS that might need to wait on
inodes being inactivated and/or reclaimed. And because inode reclaim
uses lockless rcu lookups, there's substantial danger of adding rcu
callback related deadlocks to XFS here. That's just not a direction
we should be moving in.

I'll also point out that this would require XFS inodes to pass
through *two* rcu grace periods before the memory they hold could be
freed because, as I mentioned, xfs inode reclaim uses rcu protected
inode lookups and so relies on inodes to be freed by rcu callback...

> I tend to agree with Brian and Ian at this point: return -ECHILD from
> xfs_vn_get_link_inline() until xfs's inode resue vs. rcu walk
> implications are fully dealt with.  No way to fix this from VFS alone.

I disagree from a fundamental process POV - this is just sweeping
the issue under the table and leaving it for someone else to solve
because the root cause of the inode re-use issue has not been
identified. But to the person who architected the lockless XFS inode
cache 15 years ago, it's pretty obvious, so let's just solve it now.

With the xfs_ifree() problem solved by zeroing rather than freeing,
then the only other problem is inode reuse *within an rcu grace
period*. Immediate inode reuse tends to be rare, (we can actually
trace occurrences to validate this assertion), and implementation
wise reuse is isolated to a single function: xfs_iget_recycle().

xfs_iget_recycle() drops the rcu_read_lock() inode lookup context
that found the inode marks it as being reclaimed (preventing other
lookups from finding it), then re-initialises the inode. This is
what makes .get_link change in the middle of pathwalk - we're
reinitialising the inode without waiting for the RCU grace period to
expire.

The obvious thing to do here is that after we drop the RCU read
context, we simply call synchronize_rcu() before we start
re-initialising the inode to wait for the current grace period to
expire. This ensures that any pathwalk that may have found that
inode has seen the sequence number change and droppped out of
lockless mode and is no longer trying to access that inode.  Then we
can safely reinitialise the inode as it has passed through a RCU
grace period just like it would have if it was freed and
reallocated.

This completely removes the entire class of "reused inodes race with
VFS level RCU walks" bugs from the XFS inode cache implementation,
hence XFS inodes behave the same as all other filesystems w.r.t RCU
grace period expiry needing to occur before a VFS inode is reused.

So, it looks like three patches to fix this entirely:

1. the pathwalk link sequence check fix
2. zeroing the inline link buffer in xfs_ifree()
3. adding synchronize_rcu() (or some variant) to xfs_iget_recycle()

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
