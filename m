Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA88493162
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jan 2022 00:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350196AbiARXZy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 18:25:54 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:51961 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234491AbiARXZx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 18:25:53 -0500
Received: from dread.disaster.area (pa49-179-45-11.pa.nsw.optusnet.com.au [49.179.45.11])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 21DA262C2BA;
        Wed, 19 Jan 2022 10:25:48 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1n9xrH-001StL-Oc; Wed, 19 Jan 2022 10:25:47 +1100
Date:   Wed, 19 Jan 2022 10:25:47 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Brian Foster <bfoster@redhat.com>, Ian Kent <raven@themaw.net>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] vfs: check dentry is still valid in get_link()
Message-ID: <20220118232547.GD59729@dread.disaster.area>
References: <164180589176.86426.501271559065590169.stgit@mickey.themaw.net>
 <YeJr7/E+9stwEb3t@zeniv-ca.linux.org.uk>
 <275358741c4ee64b5e4e008d514876ed4ec1071c.camel@themaw.net>
 <YeV+zseKGNqnSuKR@bfoster>
 <YeWZRL88KPtLWlkI@zeniv-ca.linux.org.uk>
 <20220118030041.GB59729@dread.disaster.area>
 <YeYxOadA0HgYfBjt@zeniv-ca.linux.org.uk>
 <20220118041253.GC59729@dread.disaster.area>
 <YeZW9s7x2uCBfNJD@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeZW9s7x2uCBfNJD@zeniv-ca.linux.org.uk>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=61e74c7f
        a=Eslsx4mF8WGvnV49LKizaA==:117 a=Eslsx4mF8WGvnV49LKizaA==:17
        a=kj9zAlcOel0A:10 a=DghFqjY3_ZEA:10 a=7-415B0cAAAA:8
        a=sC8CWpTUz8-MwOmwIq8A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 18, 2022 at 05:58:14AM +0000, Al Viro wrote:
> On Tue, Jan 18, 2022 at 03:12:53PM +1100, Dave Chinner wrote:
> 
> > No, that just creates a black hole where the VFS inode has been
> > destroyed but the XFS inode cache doesn't know it's been trashed.
> > Hence setting XFS_IRECLAIMABLE needs to remain in the during
> > ->destroy_inode, otherwise the ->lookup side of the cache will think
> > that are currently still in use by the VFS and hand them straight
> > back out without going through the inode recycling code.
> > 
> > i.e. XFS_IRECLAIMABLE is the flag that tells xfs_iget() that the VFS
> > part of the inode has been torn down, and that it must go back
> > through VFS re-initialisation before it can be re-instantiated as a
> > VFS inode.
> 
> OK...
> 
> > It would also mean that the inode will need to go through two RCU
> > grace periods before it gets reclaimed, because XFS uses RCU
> > protected inode cache lookups internally (e.g. for clustering dirty
> > inode writeback) and so freeing the inode from the internal
> > XFS inode cache requires RCU freeing...
> 
> Wait a minute.  Where is that RCU delay of yours, relative to
> xfs_vn_unlink() and xfs_vn_rename() (for target)?

Both of those drop the inode on an on-disk unlinked list. When the
last reference goes away, ->destroy_inode then runs inactivation.

Inactivation then runs transactions to free all the space attached
to the inode and then removes the inode from the unlinked list and
frees it. It then goes into the XFS_IRECLAIMABLE state and is dirty
in memory. It can't be reclaimed until the inode is written to disk
or the whole inode cluster is freed and the inode marked XFS_ISTALE
(so won't get written back).

At that point, a background inode reclaim thread (runs every 5s)
does a RCU protected lockless radix tree walk to find
XFS_IRECLAIMABLE inodes (via radix tree tags). If they are clean, it
moves them to XFS_IRECLAIM state, deletes them from the radix tree
and frees them via a call_rcu() callback.

If memory reclaim comes along sooner than this, the
->free_cached_objects() superblock shrinker callback runs that RCU
protected lockless radix tree walk to find XFS_IRECLAIMABLE inodes.

> And where does
> it happen in case of e.g. open() + unlink() + close()?

Same thing - close() drops the last reference, the unlinked inode
goes through inactivation, then moves into the XFS_IRECLAIMABLE
state.

The problem is not -quite- open-unlink-close. The problem case is
the reallocation of an on-disk inode in the case of
unlink-close-open(O_CREATE) operations because of the on-disk inode
allocator policy of aggressive reuse of recently freed inodes.  In
that case the xfs_iget() lookup will reinstantiate the inode via
xfs_iget_recycle() and the inode will change identity between VFS
instantiations.

This is where a RCU grace period is absolutely required, and we
don't currently have one. The bug was introduced with RCU freeing of
inodes (what, 15 years ago now?) and it's only recently that we've
realised this bug exists via code inspection. We really have no
evidence that it's actually been tripped over in the wild....

Unfortunately, the simple fix of adding syncronize_rcu() to
xfs_iget_recycle() causes significant performance regressions
because we hit this path quite frequently when workloads use lots of
temporary files - the on-disk inode allocator policy tends towards
aggressive re-use of inodes for small sets of temporary files.

The problem XFS is trying to address is that the VFS inode lifecycle
does not cater for filesystems that need to both dirty and then
clean unlinked inodes between iput_final() and ->destroy_inode. It's
too late to be able to put the inode back on the LRU once we've
decided to drop the inode if we need to dirty it again. ANd because
evict() is part of the non-blocking memory reclaim, we aren't
supposed to block for arbitrarily long periods of time or create
unbound memory demand processing inode eviction (both of which XFS
can do in inactivation).

IOWs, XFS can't free the inode until it's journal releases the
internal reference on the dirty inode. ext4 doesn't track inodes in
it's journal - it only tracks inode buffers that contain the changes
made to the inode, so once the transaction is committed in
ext4_evict_inode() the inode can be immediately freed via either
->destroy_inode or ->free_inode. That option does not exist for XFS
because we have to wait for the journal to finish with the inode
before it can be freed. Hence all the background reclaim stuff.

We've recently solved several of the problems we need to solve to
reduce the mismatch; avoiding blocking on inode writeback in reclaim
and background inactivation are two of the major pieces of work we
needed done before we could even consider more closely aligning XFS
to the VFS inode cache life cycle model.

The next step is to move the background inode inactivation triggers
up into ->drop_inode so we can catch inodes that need to be dirtied
by the filesysetm before they have been marked for eviction by the
VFS. This will allow us to keep the inode on the VFS LRU (probably
marked with I_WILL_FREE so everyone else keeps away from it) whilst
we are waiting for the background inactivation work to be done, the
journal flushed and the metadata written back. Once clean, we can
directly evict the inode from the VFS ourselves.

This would mean we only get clean, reclaimable inodes hitting the
evict() path, and so at that point we can just remove the inode
directly from the XFS inode cache from either ->destroy_inode or
->free_inode and RCU free it. The recycling of in-memory inodes in
xfs_iget_cache_hit can go away entirely because no inodes will
linger in the XFS inode cache without being visible at the VFS
layer as they do now...

That's going to take a fair bit of work to realise, and I'm not sure
yet exactly what mods are going to be needed to either the VFS inode
infrastructure or the XFS inode cache. 

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
