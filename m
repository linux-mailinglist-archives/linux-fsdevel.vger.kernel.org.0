Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C729C16F2D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2020 23:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgBYW7s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Feb 2020 17:59:48 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:45885 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728806AbgBYW7r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Feb 2020 17:59:47 -0500
Received: from dread.disaster.area (pa49-195-202-68.pa.nsw.optusnet.com.au [49.195.202.68])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id A7E1D3A2C51;
        Wed, 26 Feb 2020 09:59:42 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1j6jAz-0004a5-3t; Wed, 26 Feb 2020 09:59:41 +1100
Date:   Wed, 26 Feb 2020 09:59:41 +1100
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
Subject: Re: [PATCH V4 09/13] fs/xfs: Add write aops lock to xfs layer
Message-ID: <20200225225941.GO10776@dread.disaster.area>
References: <20200221004134.30599-1-ira.weiny@intel.com>
 <20200221004134.30599-10-ira.weiny@intel.com>
 <20200224003455.GY10776@dread.disaster.area>
 <20200224195735.GA11565@iweiny-DESK2.sc.intel.com>
 <20200224223245.GZ10776@dread.disaster.area>
 <20200225211228.GB15810@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225211228.GB15810@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=mqTaRPt+QsUAtUurwE173Q==:117 a=mqTaRPt+QsUAtUurwE173Q==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
        a=QyXUC8HyAAAA:8 a=7-415B0cAAAA:8 a=WlU5GPDpDACU7zcM-uYA:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 25, 2020 at 01:12:28PM -0800, Ira Weiny wrote:
> On Tue, Feb 25, 2020 at 09:32:45AM +1100, Dave Chinner wrote:
> > On Mon, Feb 24, 2020 at 11:57:36AM -0800, Ira Weiny wrote:
> > > On Mon, Feb 24, 2020 at 11:34:55AM +1100, Dave Chinner wrote:
> > > > On Thu, Feb 20, 2020 at 04:41:30PM -0800, ira.weiny@intel.com wrote:
> > > > > From: Ira Weiny <ira.weiny@intel.com>
> > > > > 
> > > 
> > > [snip]
> > > 
> > > > > 
> > > > > diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> > > > > index 35df324875db..5b014c428f0f 100644
> > > > > --- a/fs/xfs/xfs_inode.c
> > > > > +++ b/fs/xfs/xfs_inode.c
> > > > > @@ -142,12 +142,12 @@ xfs_ilock_attr_map_shared(
> > > > >   *
> > > > >   * Basic locking order:
> > > > >   *
> > > > > - * i_rwsem -> i_mmap_lock -> page_lock -> i_ilock
> > > > > + * s_dax_sem -> i_rwsem -> i_mmap_lock -> page_lock -> i_ilock
> > > > >   *
> > > > >   * mmap_sem locking order:
> > > > >   *
> > > > >   * i_rwsem -> page lock -> mmap_sem
> > > > > - * mmap_sem -> i_mmap_lock -> page_lock
> > > > > + * s_dax_sem -> mmap_sem -> i_mmap_lock -> page_lock
> > > > >   *
> > > > >   * The difference in mmap_sem locking order mean that we cannot hold the
> > > > >   * i_mmap_lock over syscall based read(2)/write(2) based IO. These IO paths can
> > > > > @@ -182,6 +182,9 @@ xfs_ilock(
> > > > >  	       (XFS_ILOCK_SHARED | XFS_ILOCK_EXCL));
> > > > >  	ASSERT((lock_flags & ~(XFS_LOCK_MASK | XFS_LOCK_SUBCLASS_MASK)) == 0);
> > > > >  
> > > > > +	if (lock_flags & XFS_DAX_EXCL)
> > > > > +		inode_aops_down_write(VFS_I(ip));
> > > > 
> > > > I largely don't see the point of adding this to xfs_ilock/iunlock.
> > > > 
> > > > It's only got one caller, so I don't see much point in adding it to
> > > > an interface that has over a hundred other call sites that don't
> > > > need or use this lock. just open code it where it is needed in the
> > > > ioctl code.
> > > 
> > > I know it seems overkill but if we don't do this we need to code a flag to be
> > > returned from xfs_ioctl_setattr_dax_invalidate().  This flag is then used in
> > > xfs_ioctl_setattr_get_trans() to create the transaction log item which can then
> > > be properly used to unlock the lock in xfs_inode_item_release()
> > > 
> > > I don't know of a cleaner way to communicate to xfs_inode_item_release() to
> > > unlock i_aops_sem after the transaction is complete.
> > 
> > We manually unlock inodes after transactions in many cases -
> > anywhere we do a rolling transaction, the inode locks do not get
> > released by the transaction. Hence for a one-off case like this it
> > doesn't really make sense to push all this infrastructure into the
> > transaction subsystem. Especially as we can manually lock before and
> > unlock after the transaction context without any real complexity.
> 
> So does xfs_trans_commit() operate synchronously?

What do you mean by "synchronously", and what are you expecting to
occur (a)synchronously with respect to filesystem objects and/or
on-disk state?

Keep in mid that the xfs transaction subsystem is a complex
asynchronous IO engine full of feedback loops and resource
management, so asking if something is "synchronous" without any
other context is a difficult question to answer :)

> I want to understand this better because I have fought with a lot of ABBA
> issues with these locks.  So...  can I hold the lock until after
> xfs_trans_commit() and safely unlock it there... because the XFS_MMAPLOCK_EXCL,
> XFS_IOLOCK_EXCL, and XFS_ILOCK_EXCL will be released at that point?  Thus
> preserving the following lock order.

See how operations like xfs_create, xfs_unlink, etc work. The don't
specify flags to xfs_ijoin(), and so the transaction commits don't
automatically unlock the inode. This is necessary so that rolling
transactions are executed atomically w.r.t. inode access - no-one
can lock and access the inode while a multi-commit rolling
transaction on the inode is on-going.

In this case it's just a single commit and we don't need to keep
it locked after the change is made, so we can unlock the inode
on commit. So for the XFS internal locks the code is fine and
doesn't need to change. We just need to wrap the VFS aops lock (if
we keep it) around the outside of all the XFS locking until the
transaction commits and unlocks the XFS locks...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
