Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6BC7159768
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 18:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730727AbgBKRzK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 12:55:10 -0500
Received: from mga12.intel.com ([192.55.52.136]:27492 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729205AbgBKRzK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 12:55:10 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 09:55:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="266342730"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga002.fm.intel.com with ESMTP; 11 Feb 2020 09:55:09 -0800
Date:   Tue, 11 Feb 2020 09:55:09 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Chinner <david@fromorbit.com>
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
Message-ID: <20200211175509.GD12866@iweiny-DESK2.sc.intel.com>
References: <20200208193445.27421-1-ira.weiny@intel.com>
 <20200208193445.27421-7-ira.weiny@intel.com>
 <20200211061639.GH10776@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211061639.GH10776@dread.disaster.area>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 11, 2020 at 05:16:39PM +1100, Dave Chinner wrote:
> On Sat, Feb 08, 2020 at 11:34:39AM -0800, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > One of the checks for an inode supporting DAX is if the inode is
> > reflinked.  During a non-DAX to DAX state change we could race with
> > the file being reflinked and end up with a reflinked file being in DAX
> > state.
> > 
> > Prevent this race by checking for DAX support under the MMAP_LOCK.
> 
> The on disk inode flags are protected by the XFS_ILOCK, not the
> MMAP_LOCK. i.e. the MMAPLOCK provides data access serialisation, not
> metadata modification serialisation.

Ah...

> 
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> >  fs/xfs/xfs_ioctl.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> > index da1eb2bdb386..4ff402fd6636 100644
> > --- a/fs/xfs/xfs_ioctl.c
> > +++ b/fs/xfs/xfs_ioctl.c
> > @@ -1194,10 +1194,6 @@ xfs_ioctl_setattr_dax_invalidate(
> >  
> >  	*join_flags = 0;
> >  
> > -	if ((fa->fsx_xflags & FS_XFLAG_DAX) == FS_XFLAG_DAX &&
> > -	    !xfs_inode_supports_dax(ip))
> > -		return -EINVAL;
> > -
> >  	/* If the DAX state is not changing, we have nothing to do here. */
> >  	if ((fa->fsx_xflags & FS_XFLAG_DAX) &&
> >  	    (ip->i_d.di_flags2 & XFS_DIFLAG2_DAX))
> > @@ -1211,6 +1207,13 @@ xfs_ioctl_setattr_dax_invalidate(
> >  
> >  	/* lock, flush and invalidate mapping in preparation for flag change */
> >  	xfs_ilock(ip, XFS_MMAPLOCK_EXCL | XFS_IOLOCK_EXCL);
> > +
> > +	if ((fa->fsx_xflags & FS_XFLAG_DAX) == FS_XFLAG_DAX &&
> > +	    !xfs_inode_supports_dax(ip)) {
> > +		error = -EINVAL;
> > +		goto out_unlock;
> > +	}
> 
> Yes, you might be able to get away with reflink vs dax flag
> serialisation on the inode flag modification, but it is not correct and
> leaves a landmine for future inode flag modifications that are done
> without holding either the MMAP or IOLOCK.
> 
> e.g. concurrent calls to xfs_ioctl_setattr() setting/clearing flags
> other than the on disk DAX flag are all serialised by the ILOCK_EXCL
> and will no be serialised against this DAX check. Hence if there are
> other flags that we add in future that affect the result of
> xfs_inode_supports_dax(), this code will not be correctly
> serialised.
> 
> This raciness in checking the DAX flags is the reason that
> xfs_ioctl_setattr_xflags() redoes all the reflink vs dax checks once
> it's called under the XFS_ILOCK_EXCL during the actual change
> transaction....

Ok I found this by trying to make sure that the xfs_inode_supports_dax() call
was always returning valid data.  So I don't have a specific test which was
failing.

Looking at the code again, it sounds like I was wrong about which locks protect
what and with your explanation above it looks like there is nothing to be done
here and I can drop the patch.

Would you agree?

Thanks for the review!
Ira

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
