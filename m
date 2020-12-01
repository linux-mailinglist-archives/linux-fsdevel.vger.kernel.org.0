Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D344A2CADCE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 21:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388019AbgLAUxf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 15:53:35 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:36177 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726083AbgLAUxe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 15:53:34 -0500
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id DFA093C5034;
        Wed,  2 Dec 2020 07:52:44 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kkCdf-00H4pJ-I1; Wed, 02 Dec 2020 07:52:43 +1100
Date:   Wed, 2 Dec 2020 07:52:43 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Eric Sandeen <sandeen@redhat.com>, torvalds@linux-foundation.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org,
        linux-kernel@vger.kernel.org, xfs <linux-xfs@vger.kernel.org>,
        linux-ext4@vger.kernel.org, Xiaoli Feng <xifeng@redhat.com>
Subject: Re: [PATCH 2/2] statx: move STATX_ATTR_DAX attribute handling to
 filesystems
Message-ID: <20201201205243.GK2842436@dread.disaster.area>
References: <e388f379-cd11-a5d2-db82-aa1aa518a582@redhat.com>
 <05a0f4fd-7f62-8fbc-378d-886ccd5b3f11@redhat.com>
 <20201201173905.GI143045@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201173905.GI143045@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Ubgvt5aN c=1 sm=1 tr=0 cx=a_idp_d
        a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
        a=kj9zAlcOel0A:10 a=zTNgK-yGK50A:10 a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8
        a=0VGuV5NUSCmGL-iizfcA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 01, 2020 at 09:39:05AM -0800, Darrick J. Wong wrote:
> On Tue, Dec 01, 2020 at 10:59:36AM -0600, Eric Sandeen wrote:
> > It's a bit odd to set STATX_ATTR_DAX into the statx attributes in the VFS;
> > while the VFS can detect the current DAX state, it is the filesystem which
> > actually sets S_DAX on the inode, and the filesystem is the place that
> > knows whether DAX is something that the "filesystem actually supports" [1]
> > so that the statx attributes_mask can be properly set.
> > 
> > So, move STATX_ATTR_DAX attribute setting to the individual dax-capable
> > filesystems, and update the attributes_mask there as well.
> > 
> > [1] 3209f68b3ca4 statx: Include a mask for stx_attributes in struct statx
> > 
> > Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> > ---
> >  fs/ext2/inode.c   | 6 +++++-
> >  fs/ext4/inode.c   | 5 ++++-
> >  fs/stat.c         | 3 ---
> >  fs/xfs/xfs_iops.c | 5 ++++-
> >  4 files changed, 13 insertions(+), 6 deletions(-)
> > 
> > diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> > index 11c5c6fe75bb..3550783a6ea0 100644
> > --- a/fs/ext2/inode.c
> > +++ b/fs/ext2/inode.c
> > @@ -1653,11 +1653,15 @@ int ext2_getattr(const struct path *path, struct kstat *stat,
> >  		stat->attributes |= STATX_ATTR_IMMUTABLE;
> >  	if (flags & EXT2_NODUMP_FL)
> >  		stat->attributes |= STATX_ATTR_NODUMP;
> > +	if (IS_DAX(inode))
> > +		stat->attributes |= STATX_ATTR_DAX;
> > +
> >  	stat->attributes_mask |= (STATX_ATTR_APPEND |
> >  			STATX_ATTR_COMPRESSED |
> >  			STATX_ATTR_ENCRYPTED |
> >  			STATX_ATTR_IMMUTABLE |
> > -			STATX_ATTR_NODUMP);
> > +			STATX_ATTR_NODUMP |
> > +			STATX_ATTR_DAX);
> >  
> >  	generic_fillattr(inode, stat);
> >  	return 0;
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index 0d8385aea898..848a0f2b154e 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -5550,13 +5550,16 @@ int ext4_getattr(const struct path *path, struct kstat *stat,
> >  		stat->attributes |= STATX_ATTR_NODUMP;
> >  	if (flags & EXT4_VERITY_FL)
> >  		stat->attributes |= STATX_ATTR_VERITY;
> > +	if (IS_DAX(inode))
> > +		stat->attributes |= STATX_ATTR_DAX;
> >  
> >  	stat->attributes_mask |= (STATX_ATTR_APPEND |
> >  				  STATX_ATTR_COMPRESSED |
> >  				  STATX_ATTR_ENCRYPTED |
> >  				  STATX_ATTR_IMMUTABLE |
> >  				  STATX_ATTR_NODUMP |
> > -				  STATX_ATTR_VERITY);
> > +				  STATX_ATTR_VERITY |
> > +				  STATX_ATTR_DAX);
> >  
> >  	generic_fillattr(inode, stat);
> >  	return 0;
> > diff --git a/fs/stat.c b/fs/stat.c
> > index dacecdda2e79..5bd90949c69b 100644
> > --- a/fs/stat.c
> > +++ b/fs/stat.c
> > @@ -80,9 +80,6 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
> >  	if (IS_AUTOMOUNT(inode))
> >  		stat->attributes |= STATX_ATTR_AUTOMOUNT;
> >  
> > -	if (IS_DAX(inode))
> > -		stat->attributes |= STATX_ATTR_DAX;
> > -
> >  	if (inode->i_op->getattr)
> >  		return inode->i_op->getattr(path, stat, request_mask,
> >  					    query_flags);
> > diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> > index 1414ab79eacf..56deda7042fd 100644
> > --- a/fs/xfs/xfs_iops.c
> > +++ b/fs/xfs/xfs_iops.c
> > @@ -575,10 +575,13 @@ xfs_vn_getattr(
> >  		stat->attributes |= STATX_ATTR_APPEND;
> >  	if (ip->i_d.di_flags & XFS_DIFLAG_NODUMP)
> >  		stat->attributes |= STATX_ATTR_NODUMP;
> > +	if (IS_DAX(inode))
> > +		stat->attributes |= STATX_ATTR_DAX;
> >  
> >  	stat->attributes_mask |= (STATX_ATTR_IMMUTABLE |
> >  				  STATX_ATTR_APPEND |
> > -				  STATX_ATTR_NODUMP);
> > +				  STATX_ATTR_NODUMP |
> > +				  STATX_ATTR_DAX);
> 
> TBH I preferred your previous iteration on this, which only set the DAX
> bit in the attributes_mask if the underlying storage was pmem and the
> blocksize was correct, etc. since it made it easier to distinguish
> between a filesystem where you /could/ have DAX (but it wasn't currently
> enabled) and a filesystem where it just isn't possible.

I think that's the only thing that makes sense from a userspace
perspective. THe man page explicitly says that:

  stx_attributes_mask
	A mask indicating which bits in stx_attributes are supported
	by the VFS and the filesystem.

So if DAX can never be turned on for that filesystem instance then,
by definition, it does not support DAX and the bit should never be
set.

e.g. We don't talk about kernels that support reflink - what matters
to userspace is whether the filesystem instance supports reflink.
Think of the useless mess that xfs_info would be if it reported
kernel capabilities instead of filesystem instance capabilities.
i.e. we don't report that a filesystem supports reflink just because
the kernel supports it - it reports whether the filesystem instance
being queried supports reflink. And that also implies the kernel
supports it, because the kernel has to support it to mount the
filesystem...

So, yeah, I think it really does need to be conditional on the
filesystem instance being queried to be actually useful to users....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
