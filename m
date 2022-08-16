Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C77559659A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 00:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237557AbiHPWnF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 18:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiHPWnF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 18:43:05 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA42591080;
        Tue, 16 Aug 2022 15:43:02 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-52-176.pa.nsw.optusnet.com.au [49.181.52.176])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id E33B010E8833;
        Wed, 17 Aug 2022 08:42:59 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oO5Gz-00Dy1R-GM; Wed, 17 Aug 2022 08:42:57 +1000
Date:   Wed, 17 Aug 2022 08:42:57 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] xfs: fix i_version handling in xfs
Message-ID: <20220816224257.GV3600936@dread.disaster.area>
References: <20220816131736.42615-1-jlayton@kernel.org>
 <Yvu7DHDWl4g1KsI5@magnolia>
 <e77fd4d19815fd661dbdb04ab27e687ff7e727eb.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e77fd4d19815fd661dbdb04ab27e687ff7e727eb.camel@kernel.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=62fc1d74
        a=O3n/kZ8kT9QBBO3sWHYIyw==:117 a=O3n/kZ8kT9QBBO3sWHYIyw==:17
        a=kj9zAlcOel0A:10 a=biHskzXt2R4A:10 a=yPCof4ZbAAAA:8 a=7-415B0cAAAA:8
        a=VwQbUJbxAAAA:8 a=Rtz12tFEleHYSgjB_mQA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22 a=AjGcO6oz07-iQ99wixmX:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 16, 2022 at 11:58:06AM -0400, Jeff Layton wrote:
> On Tue, 2022-08-16 at 08:43 -0700, Darrick J. Wong wrote:
> > On Tue, Aug 16, 2022 at 09:17:36AM -0400, Jeff Layton wrote:
> > > The i_version in xfs_trans_log_inode is bumped for any inode update,
> > > including atime-only updates due to reads. We don't want to record those
> > > in the i_version, as they don't represent "real" changes. Remove that
> > > callsite.
> > > 
> > > In xfs_vn_update_time, if S_VERSION is flagged, then attempt to bump the
> > > i_version and turn on XFS_ILOG_CORE if it happens. In
> > > xfs_trans_ichgtime, update the i_version if the mtime or ctime are being
> > > updated.
> > 
> > What about operations that don't touch the mtime but change the file
> > metadata anyway?  There are a few of those, like the blockgc garbage
> > collector, deduperange, and the defrag tool.
> > 
> 
> Do those change the c/mtime at all?
> 
> It's possible we're missing some places that should change the i_version
> as well. We may need some more call sites.
> 
> > Zooming out a bit -- what does i_version signal, concretely?  I thought
> > it was used by nfs (and maybe ceph?) to signal to clients that the file
> > on the server has moved on, and the client needs to invalidate its
> > caches.  I thought afs had a similar generation counter, though it's
> > only used to cache file data, not metadata?  Does an i_version change
> > cause all of them to invalidate caches, or is there more behavior I
> > don't know about?
> > 
> 
> For NFS, it indicates a change to the change attribute indicates that
> there has been a change to the data or metadata for the file. atime
> changes due to reads are specifically exempted from this, but we do bump
> the i_version if someone (e.g.) changes the atime via utimes(). 

We have relatime behaviour to optimise away unnecessary atime
updates on reads.  Trying to explicitly exclude i_version from atime
updates in one filesystem just because NFS doesn't need that
information seems ....  misguided.  The -on disk- i_version
field behaviour is defined by the filesystem implementation, not the
NFS requirements.

> The NFS client will generally invalidate its caches for the inode when
> it notices a change attribute change.
>
> FWIW, AFS may not meet this standard since it doesn't generally
> increment the counter on metadata changes. It may turn out that we don't
> want to expose this to the AFS client due to that (or maybe come up with
> some way to indicate this difference).

In XFS, we've defined the on-disk i_version field to mean
"increments with any persistent inode data or metadata change",
regardless of what the high level applications that use i_version
might actually require.

That some network filesystem might only need a subset of the
metadata to be covered by i_version is largely irrelevant - if we
don't cover every persistent inode metadata change with i_version,
then applications that *need* stuff like atime change notification
can't be supported.

> > Does that mean that we should bump i_version for any file data or
> > attribute that could be queried or observed by userspace?  In which case
> > I suppose this change is still correct, even if it relaxes i_version
> > updates from "any change to the inode whatsoever" to "any change that
> > would bump mtime".  Unless FIEMAP is part of "attributes observed by
> > userspace".
> > 
> > (The other downside I can see is that now we have to remember to bump
> > timestamps for every new file operation we add, unlike the current code
> > which is centrally located in xfs_trans_log_inode.)
> > 
> 
> The main reason for the change attribute in NFS was that NFSv3 is
> plagued with cache-coherency problems due to coarse-grained timestamp
> granularity. It was conceived as a way to indicate that the inode had
> changed without relying on timestamps.

Yes, and the most important design consideration for a filesystem is
that it -must be persistent-. The constraints on i_version are much
stricter than timestamps, and they are directly related to how the
filesystem persists metadata changes, not how metadata is changed or
accessed in memory.

> In practice, we want to bump the i_version counter whenever the ctime or
> mtime would be changed.

What about O_NOCMTIME modifications? What about lazytime
filesystems? These explicilty avoid or delay persisten c/mtime
updates, and that means bumping i_version only based on c/mtime
updates cannot be relied on. i_version is supposed to track user
visible data and metadata changes, *not timestamp updates*.

> > > Cc: Darrick J. Wong <darrick.wong@oracle.com>
> > > Cc: Dave Chinner <david@fromorbit.com>
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/xfs/libxfs/xfs_trans_inode.c | 17 +++--------------
> > >  fs/xfs/xfs_iops.c               |  4 ++++
> > >  2 files changed, 7 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/fs/xfs/libxfs/xfs_trans_inode.c b/fs/xfs/libxfs/xfs_trans_inode.c
> > > index 8b5547073379..78bf7f491462 100644
> > > --- a/fs/xfs/libxfs/xfs_trans_inode.c
> > > +++ b/fs/xfs/libxfs/xfs_trans_inode.c
> > > @@ -71,6 +71,8 @@ xfs_trans_ichgtime(
> > >  		inode->i_ctime = tv;
> > >  	if (flags & XFS_ICHGTIME_CREATE)
> > >  		ip->i_crtime = tv;
> > > +	if (flags & (XFS_ICHGTIME_MOD|XFS_ICHGTIME_CHG))
> > > +		inode_inc_iversion(inode);
> > >  }

That looks wrong - this is not the only path through XFS that
modifies timestamps, and I have to ask why this needs to be an
explicit i_version bump given that nobody may have looked at
i_version since the last time it was updated?.

What about xfs_fs_dirty_inode() when we actually persist lazytime
in-memory timestamp updates? We didn't bump i_version when setting
I_DIRTY_TIME, and this patch now removes the mechanism that is used
to bump iversion if it is needed when we persist those lazytime
updates.....

> > >  /*
> > > @@ -116,20 +118,7 @@ xfs_trans_log_inode(
> > >  		spin_unlock(&inode->i_lock);
> > >  	}
> > >  
> > > -	/*
> > > -	 * First time we log the inode in a transaction, bump the inode change
> > > -	 * counter if it is configured for this to occur. While we have the
> > > -	 * inode locked exclusively for metadata modification, we can usually
> > > -	 * avoid setting XFS_ILOG_CORE if no one has queried the value since
> > > -	 * the last time it was incremented. If we have XFS_ILOG_CORE already
> > > -	 * set however, then go ahead and bump the i_version counter
> > > -	 * unconditionally.
> > > -	 */
> > > -	if (!test_and_set_bit(XFS_LI_DIRTY, &iip->ili_item.li_flags)) {
> > > -		if (IS_I_VERSION(inode) &&
> > > -		    inode_maybe_inc_iversion(inode, flags & XFS_ILOG_CORE))
> > > -			iversion_flags = XFS_ILOG_CORE;
> > > -	}
> > > +	set_bit(XFS_LI_DIRTY, &iip->ili_item.li_flags);

.... and this removes the sweep that captures in-memory timestamp
and i_version peeks between any persistent inode metadata
modifications that have been made, regardless of whether i_version
has already been bumped for them or not.

IOws, this seems to rely on every future inode modification in XFS
calling xfs_trans_ichgtime() to bump i_version to sweep previous VFS
in-memory timestamp updates that this inode modification captures
and persists to disk.

This seems fragile and error prone - it's relying on the
developers always getting timestamp and iversion updates correct,
rather the code always guaranteeing that it captures timestamp and
iversion updates without any extra effort.

Hence, I don't think that trying to modify how filesystems persist
and maintain i_version coherency because NFS "doesn't need i_version
to cover atime updates" is the wrong approach. On-disk i_version
coherency has to work for more than just one NFS implementation
(especially now i_version will be exported to userspace!). 
Persistent atime updates are already optimised away by relatime, and
so I think that any further atime filtering is largely a NFS
application layer problem and not something that should be solved by
changing the on-disk definition of back end filesystem structure
persistence.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
