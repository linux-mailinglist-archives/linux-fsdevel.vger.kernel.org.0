Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA57159AA8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 21:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731856AbgBKUmY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 15:42:24 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:36152 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728512AbgBKUmY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 15:42:24 -0500
Received: from dread.disaster.area (pa49-179-138-28.pa.nsw.optusnet.com.au [49.179.138.28])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id C35BA7EAD5E;
        Wed, 12 Feb 2020 07:42:20 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1j1cMO-0002wz-8Z; Wed, 12 Feb 2020 07:42:20 +1100
Date:   Wed, 12 Feb 2020 07:42:20 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 06/12] fs/xfs: Check if the inode supports DAX under
 lock
Message-ID: <20200211204220.GN10776@dread.disaster.area>
References: <20200208193445.27421-1-ira.weiny@intel.com>
 <20200208193445.27421-7-ira.weiny@intel.com>
 <20200211061639.GH10776@dread.disaster.area>
 <20200211175509.GD12866@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211175509.GD12866@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=zAxSp4fFY/GQY8/esVNjqw==:117 a=zAxSp4fFY/GQY8/esVNjqw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
        a=QyXUC8HyAAAA:8 a=7-415B0cAAAA:8 a=dz0gKRpfQL60cEkPPx4A:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 11, 2020 at 09:55:09AM -0800, Ira Weiny wrote:
> On Tue, Feb 11, 2020 at 05:16:39PM +1100, Dave Chinner wrote:
> > On Sat, Feb 08, 2020 at 11:34:39AM -0800, ira.weiny@intel.com wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > One of the checks for an inode supporting DAX is if the inode is
> > > reflinked.  During a non-DAX to DAX state change we could race with
> > > the file being reflinked and end up with a reflinked file being in DAX
> > > state.
> > > 
> > > Prevent this race by checking for DAX support under the MMAP_LOCK.
> > 
> > The on disk inode flags are protected by the XFS_ILOCK, not the
> > MMAP_LOCK. i.e. the MMAPLOCK provides data access serialisation, not
> > metadata modification serialisation.
> 
> Ah...
> 
> > 
> > > 
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > ---
> > >  fs/xfs/xfs_ioctl.c | 11 +++++++----
> > >  1 file changed, 7 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> > > index da1eb2bdb386..4ff402fd6636 100644
> > > --- a/fs/xfs/xfs_ioctl.c
> > > +++ b/fs/xfs/xfs_ioctl.c
> > > @@ -1194,10 +1194,6 @@ xfs_ioctl_setattr_dax_invalidate(
> > >  
> > >  	*join_flags = 0;
> > >  
> > > -	if ((fa->fsx_xflags & FS_XFLAG_DAX) == FS_XFLAG_DAX &&
> > > -	    !xfs_inode_supports_dax(ip))
> > > -		return -EINVAL;
> > > -
> > >  	/* If the DAX state is not changing, we have nothing to do here. */
> > >  	if ((fa->fsx_xflags & FS_XFLAG_DAX) &&
> > >  	    (ip->i_d.di_flags2 & XFS_DIFLAG2_DAX))
> > > @@ -1211,6 +1207,13 @@ xfs_ioctl_setattr_dax_invalidate(
> > >  
> > >  	/* lock, flush and invalidate mapping in preparation for flag change */
> > >  	xfs_ilock(ip, XFS_MMAPLOCK_EXCL | XFS_IOLOCK_EXCL);
> > > +
> > > +	if ((fa->fsx_xflags & FS_XFLAG_DAX) == FS_XFLAG_DAX &&
> > > +	    !xfs_inode_supports_dax(ip)) {
> > > +		error = -EINVAL;
> > > +		goto out_unlock;
> > > +	}
> > 
> > Yes, you might be able to get away with reflink vs dax flag
> > serialisation on the inode flag modification, but it is not correct and
> > leaves a landmine for future inode flag modifications that are done
> > without holding either the MMAP or IOLOCK.
> > 
> > e.g. concurrent calls to xfs_ioctl_setattr() setting/clearing flags
> > other than the on disk DAX flag are all serialised by the ILOCK_EXCL
> > and will no be serialised against this DAX check. Hence if there are
> > other flags that we add in future that affect the result of
> > xfs_inode_supports_dax(), this code will not be correctly
> > serialised.
> > 
> > This raciness in checking the DAX flags is the reason that
> > xfs_ioctl_setattr_xflags() redoes all the reflink vs dax checks once
> > it's called under the XFS_ILOCK_EXCL during the actual change
> > transaction....
> 
> Ok I found this by trying to make sure that the xfs_inode_supports_dax() call
> was always returning valid data.  So I don't have a specific test which was
> failing.
> 
> Looking at the code again, it sounds like I was wrong about which locks protect
> what and with your explanation above it looks like there is nothing to be done
> here and I can drop the patch.
> 
> Would you agree?

*nod*

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
