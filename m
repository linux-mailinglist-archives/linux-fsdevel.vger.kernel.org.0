Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42F01B3206
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 23:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgDUVna (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 17:43:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:3426 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbgDUVna (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 17:43:30 -0400
IronPort-SDR: 7P8WNAcWUyj0aQ3Xi9OK9W1KZ9ggHx/r4D4g3kNIXe7tb1Jh77NDsEDZsyKWLMXtViP+DAeqfF
 Vpfe0R5UHuDw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 14:43:29 -0700
IronPort-SDR: l9v2emWz69/KRu2nwYAzuWNK6yG8VzlTGptMSXs336pBbWT0m/0+nvmKP3w1ZyAH2wx8R3haKM
 7VHY+96vMIrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,411,1580803200"; 
   d="scan'208";a="279792039"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga004.fm.intel.com with ESMTP; 21 Apr 2020 14:43:29 -0700
Date:   Tue, 21 Apr 2020 14:43:29 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V9 10/11] fs/xfs: Update
 xfs_ioctl_setattr_dax_invalidate()
Message-ID: <20200421214328.GD3372712@iweiny-DESK2.sc.intel.com>
References: <20200421191754.3372370-1-ira.weiny@intel.com>
 <20200421191754.3372370-11-ira.weiny@intel.com>
 <20200421203140.GD6742@magnolia>
 <20200421213049.GC27860@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421213049.GC27860@dread.disaster.area>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 22, 2020 at 07:30:49AM +1000, Dave Chinner wrote:
> On Tue, Apr 21, 2020 at 01:31:40PM -0700, Darrick J. Wong wrote:
> > On Tue, Apr 21, 2020 at 12:17:52PM -0700, ira.weiny@intel.com wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > Because of the separation of FS_XFLAG_DAX from S_DAX and the delayed
> > > setting of S_DAX, data invalidation no longer needs to happen when
> > > FS_XFLAG_DAX is changed.
> > > 
> > > Change xfs_ioctl_setattr_dax_invalidate() to be
> > > xfs_ioctl_dax_check_set_cache() and alter the code to reflect the new
> > > functionality.
> > > 
> > > Furthermore, we no longer need the locking so we remove the join_flags
> > > logic.
> > > 
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > ---
> > > Changes from V8:
> > > 	Change name of function to xfs_ioctl_dax_check_set_cache()
> > > 	Update commit message
> > > 	Fix bit manipulations
> > > 
> > > Changes from V7:
> > > 	Use new flag_inode_dontcache()
> > > 	Skip don't cache if mount over ride is active.
> > > 
> > > Changes from v6:
> > > 	Fix completely broken implementation and update commit message.
> > > 	Use the new VFS layer I_DONTCACHE to facilitate inode eviction
> > > 	and S_DAX changing on drop_caches
> > > 
> > > Changes from v5:
> > > 	New patch
> > > ---
> > >  fs/xfs/xfs_ioctl.c | 108 +++++++++------------------------------------
> > >  1 file changed, 20 insertions(+), 88 deletions(-)
> > > 
> > > diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> > > index 104495ac187c..b87b571a6748 100644
> > > --- a/fs/xfs/xfs_ioctl.c
> > > +++ b/fs/xfs/xfs_ioctl.c
> > > @@ -1245,64 +1245,26 @@ xfs_ioctl_setattr_xflags(
> > >  	return 0;
> > >  }
> > >  
> > > -/*
> > > - * If we are changing DAX flags, we have to ensure the file is clean and any
> > > - * cached objects in the address space are invalidated and removed. This
> > > - * requires us to lock out other IO and page faults similar to a truncate
> > > - * operation. The locks need to be held until the transaction has been committed
> > > - * so that the cache invalidation is atomic with respect to the DAX flag
> > > - * manipulation.
> > > - */
> > > -static int
> > > -xfs_ioctl_setattr_dax_invalidate(
> > > +static void
> > > +xfs_ioctl_dax_check_set_cache(
> > 
> > That's a ... strange name.  Set cache on what?
> > 
> > Oh, this is the function that sets I_DONTCACHE if an FS_XFLAG_DAX change
> > could have an immediate effect on S_DAX (assuming no other users).  What
> > do you think of the following?
> > 
> > 	/*
> > 	 * If a change to FS_XFLAG_DAX will result in an change to S_DAX
> > 	 * the next time the incore inode is initialized, set the VFS
> > 	 * I_DONTCACHE flag to try to hurry that along.
> > 	 */
> > 	static void
> > 	xfs_ioctl_try_change_vfs_dax(...)
> 
> That doesn't seem any better. This is a preparation function now, in
> that it can't fail and doesn't change the outcome of the operation
> being performed. So, IMO, calling it something like
> xfs_ioctl_setattr_prepare_dax() would be a better name for it.

But it does potentially (after a check) set I_DONTCACHE.

What about?

xfs_ioctl_dax_check_set_dontcache()?

Ira

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
