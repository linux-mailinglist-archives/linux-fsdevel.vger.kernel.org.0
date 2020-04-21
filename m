Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2C91B1A9B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 02:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgDUAT3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 20:19:29 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:35569 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725550AbgDUAT3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 20:19:29 -0400
Received: from dread.disaster.area (pa49-180-0-232.pa.nsw.optusnet.com.au [49.180.0.232])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 2C5783A43C6;
        Tue, 21 Apr 2020 10:19:24 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jQgdH-00074C-Bj; Tue, 21 Apr 2020 10:19:23 +1000
Date:   Tue, 21 Apr 2020 10:19:23 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V8 10/11] fs/xfs: Change
 xfs_ioctl_setattr_dax_invalidate()
Message-ID: <20200421001923.GS9800@dread.disaster.area>
References: <20200415064523.2244712-1-ira.weiny@intel.com>
 <20200415064523.2244712-11-ira.weiny@intel.com>
 <20200420023131.GC9800@dread.disaster.area>
 <20200420183617.GB2838440@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420183617.GB2838440@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=XYjVcjsg+1UI/cdbgX7I7g==:117 a=XYjVcjsg+1UI/cdbgX7I7g==:17
        a=kj9zAlcOel0A:10 a=cl8xLZFz6L8A:10 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8
        a=7-415B0cAAAA:8 a=v_MXh98pven9RYxNG_0A:9 a=CjuIK1q_8ugA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 20, 2020 at 11:36:17AM -0700, Ira Weiny wrote:
> On Mon, Apr 20, 2020 at 12:31:31PM +1000, Dave Chinner wrote:
> > On Tue, Apr 14, 2020 at 11:45:22PM -0700, ira.weiny@intel.com wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > -out_unlock:
> > > -	xfs_iunlock(ip, XFS_MMAPLOCK_EXCL | XFS_IOLOCK_EXCL);
> > > -	return error;
> > > +	if (mp->m_flags & XFS_MOUNT_DAX_ALWAYS ||
> > > +	    mp->m_flags & XFS_MOUNT_DAX_NEVER)
> > > +		return;
> > 
> > 	if (mp->m_flags & (XFS_MOUNT_DAX_ALWAYS | XFS_MOUNT_DAX_NEVER))
> > 		return;
> > > +	if (((fa->fsx_xflags & FS_XFLAG_DAX) &&
> > > +	    !(ip->i_d.di_flags2 & XFS_DIFLAG2_DAX)) ||
> > > +	    (!(fa->fsx_xflags & FS_XFLAG_DAX) &&
> > > +	     (ip->i_d.di_flags2 & XFS_DIFLAG2_DAX)))
> > > +		flag_inode_dontcache(inode);
> > 
> > This doesn't set the XFS inode's "don't cache" flag, despite it
> > having one that serves exactly the same purpose.  IOWs, if the XFS_IDONTCACHE
> > flag is now redundant, please replace it's current usage with this new flag
> > and get rid of the XFS inode flag. i.e.  the only place we set XFS_IDONTCACHE
> > can be replaced with a call to this mark_inode_dontcache() call...
> 
> I agree, and I would have removed XFS_IDONTCACHE, except I was not convinced
> that XFS_IDONTCACHE was redundant.
> 
> Currently XFS_IDONTCACHE can be cleared if the inode is found in the cache and
> I was unable to convince myself that it would be ok to remove it.  I mentioned
> this to Darrick in V7.
> 
> https://lore.kernel.org/lkml/20200413194432.GD1649878@iweiny-DESK2.sc.intel.com/
> 
> What am I missing with this code?
> 
> xfs_iget_cache_hit():
> ...
>         if (!(flags & XFS_IGET_INCORE))
> 		xfs_iflags_clear(ip, XFS_ISTALE | XFS_IDONTCACHE);
> ...
> 
> Why is XFS_IDONTCACHE not 'sticky'?
> And why does xfs_iget_cache_hit() clear it

Because it was designed to do exactly what bulkstat required, and
nothing else.  xfs_iget() is an internal filesystem interface, not a
VFS level interface. Hence we can make up whatever semantics we
want. And if we get a cache hit, we have multiple references to the
inode so we probably should cache it regardless of whether the
original lookup said "I'm a one-shot wonder, so don't cache me".

IOWs, it's a classic "don't cache unless a second reference comes
along during the current life cycle" algorithm.

This isn't actually a frequently travelled path - bulkstat is a
pretty rare thing to be doing - so the behaviour is "be nice to the
cache because we can do it easily", not a hard requirement.

> rather than fail when XFS_IDONTCACHE is set?

Because then it would be impossible to access an inode that has
IDONTCACHE set on it. e.g. bulkstat an inode, now you can't open()
it because it has XFS_IDONTCACHE set and VFS pathwalk lookups fail
trying to resolve the inode number to a struct inode....

Same goes for I_DONTCACHE - this does not prevent new lookups from
taking references to the inode while it is still referenced. i.e.
the reference count can still go up after the flag is set. The flag
only takes effect when the reference count goes to zero.

Hence the only difference between XFS_IDONTCACHE and I_DONTCACHE is
the behaviour when cache hits on existing XFS_IDONTCACHE inodes
occur. It's not going to make a significant difference to cache
residency if we leave the I_DONTCACHE flag in place, because the
vast majority of inodes with that flag (from bulkstat) are still
one-shot wonders and hence the reclaim decision is still the
overwhelmingly correct decision to be making...

And, realistically, we have a second layer of inode caching in XFS
(the cluster buffers) and so it's likely if we evict and reclaim an
inode just before it gets re-used, then we'll hit the buffer cache
anyway. i.e. we still avoid the IO to read the inode back into
memory, we just burn a little more CPU re-instantiating it from the
buffer....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
