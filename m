Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90DC71706E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 19:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgBZSCx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 13:02:53 -0500
Received: from mga02.intel.com ([134.134.136.20]:38096 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726787AbgBZSCx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 13:02:53 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 10:02:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,489,1574150400"; 
   d="scan'208";a="256409560"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga002.jf.intel.com with ESMTP; 26 Feb 2020 10:02:51 -0800
Date:   Wed, 26 Feb 2020 10:02:51 -0800
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
Subject: Re: [PATCH V4 09/13] fs/xfs: Add write aops lock to xfs layer
Message-ID: <20200226180250.GC22036@iweiny-DESK2.sc.intel.com>
References: <20200221004134.30599-1-ira.weiny@intel.com>
 <20200221004134.30599-10-ira.weiny@intel.com>
 <20200224003455.GY10776@dread.disaster.area>
 <20200224195735.GA11565@iweiny-DESK2.sc.intel.com>
 <20200224223245.GZ10776@dread.disaster.area>
 <20200225211228.GB15810@iweiny-DESK2.sc.intel.com>
 <20200225225941.GO10776@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225225941.GO10776@dread.disaster.area>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 26, 2020 at 09:59:41AM +1100, Dave Chinner wrote:
> On Tue, Feb 25, 2020 at 01:12:28PM -0800, Ira Weiny wrote:
> > On Tue, Feb 25, 2020 at 09:32:45AM +1100, Dave Chinner wrote:
> > > On Mon, Feb 24, 2020 at 11:57:36AM -0800, Ira Weiny wrote:
> > > > On Mon, Feb 24, 2020 at 11:34:55AM +1100, Dave Chinner wrote:
> > > > > On Thu, Feb 20, 2020 at 04:41:30PM -0800, ira.weiny@intel.com wrote:
> > > > > > From: Ira Weiny <ira.weiny@intel.com>
> > > > > > 
> > > > 
> > > > [snip]
> > > > 
> > > > > > 
> > > > > > diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> > > > > > index 35df324875db..5b014c428f0f 100644
> > > > > > --- a/fs/xfs/xfs_inode.c
> > > > > > +++ b/fs/xfs/xfs_inode.c
> > > > > > @@ -142,12 +142,12 @@ xfs_ilock_attr_map_shared(
> > > > > >   *
> > > > > >   * Basic locking order:
> > > > > >   *
> > > > > > - * i_rwsem -> i_mmap_lock -> page_lock -> i_ilock
> > > > > > + * s_dax_sem -> i_rwsem -> i_mmap_lock -> page_lock -> i_ilock
> > > > > >   *
> > > > > >   * mmap_sem locking order:
> > > > > >   *
> > > > > >   * i_rwsem -> page lock -> mmap_sem
> > > > > > - * mmap_sem -> i_mmap_lock -> page_lock
> > > > > > + * s_dax_sem -> mmap_sem -> i_mmap_lock -> page_lock
> > > > > >   *
> > > > > >   * The difference in mmap_sem locking order mean that we cannot hold the
> > > > > >   * i_mmap_lock over syscall based read(2)/write(2) based IO. These IO paths can
> > > > > > @@ -182,6 +182,9 @@ xfs_ilock(
> > > > > >  	       (XFS_ILOCK_SHARED | XFS_ILOCK_EXCL));
> > > > > >  	ASSERT((lock_flags & ~(XFS_LOCK_MASK | XFS_LOCK_SUBCLASS_MASK)) == 0);
> > > > > >  
> > > > > > +	if (lock_flags & XFS_DAX_EXCL)
> > > > > > +		inode_aops_down_write(VFS_I(ip));
> > > > > 
> > > > > I largely don't see the point of adding this to xfs_ilock/iunlock.
> > > > > 
> > > > > It's only got one caller, so I don't see much point in adding it to
> > > > > an interface that has over a hundred other call sites that don't
> > > > > need or use this lock. just open code it where it is needed in the
> > > > > ioctl code.
> > > > 
> > > > I know it seems overkill but if we don't do this we need to code a flag to be
> > > > returned from xfs_ioctl_setattr_dax_invalidate().  This flag is then used in
> > > > xfs_ioctl_setattr_get_trans() to create the transaction log item which can then
> > > > be properly used to unlock the lock in xfs_inode_item_release()
> > > > 
> > > > I don't know of a cleaner way to communicate to xfs_inode_item_release() to
> > > > unlock i_aops_sem after the transaction is complete.
> > > 
> > > We manually unlock inodes after transactions in many cases -
> > > anywhere we do a rolling transaction, the inode locks do not get
> > > released by the transaction. Hence for a one-off case like this it
> > > doesn't really make sense to push all this infrastructure into the
> > > transaction subsystem. Especially as we can manually lock before and
> > > unlock after the transaction context without any real complexity.
> > 
> > So does xfs_trans_commit() operate synchronously?
> 
> What do you mean by "synchronously", and what are you expecting to
> occur (a)synchronously with respect to filesystem objects and/or
> on-disk state?
> 
> Keep in mid that the xfs transaction subsystem is a complex
> asynchronous IO engine full of feedback loops and resource
> management,

This is precisely why I added the lock to the transaction state.  So that I
could guarantee that the lock will be released in the proper order when the
complicated transaction subsystem was done with it.  I did not see any reason
to allow operations to proceed before that time.  And so this seemed safe...

> so asking if something is "synchronous" without any
> other context is a difficult question to answer :)

Or apparently it is difficult to even ask...  ;-)  (...not trying to be
sarcastic.)  Seriously, I'm not an expert in this area so I did what I thought
was most safe.  Which for me was the number 1 goal.

> 
> > I want to understand this better because I have fought with a lot of ABBA
> > issues with these locks.  So...  can I hold the lock until after
> > xfs_trans_commit() and safely unlock it there... because the XFS_MMAPLOCK_EXCL,
> > XFS_IOLOCK_EXCL, and XFS_ILOCK_EXCL will be released at that point?  Thus
> > preserving the following lock order.
> 
> See how operations like xfs_create, xfs_unlink, etc work. The don't
> specify flags to xfs_ijoin(), and so the transaction commits don't
> automatically unlock the inode.

xfs_ijoin()?  Do you mean xfs_trans_ijoin()?

> This is necessary so that rolling
> transactions are executed atomically w.r.t. inode access - no-one
> can lock and access the inode while a multi-commit rolling
> transaction on the inode is on-going.
> 
> In this case it's just a single commit and we don't need to keep
> it locked after the change is made, so we can unlock the inode
> on commit. So for the XFS internal locks the code is fine and
> doesn't need to change. We just need to wrap the VFS aops lock (if
> we keep it) around the outside of all the XFS locking until the
> transaction commits and unlocks the XFS locks...

Ok, I went ahead and coded it up and it is testing now.  Everything looks good.
I have to say that at this point I have to agree that I can't see how a
deadlock could occur so...

Thanks for the review,
Ira

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
