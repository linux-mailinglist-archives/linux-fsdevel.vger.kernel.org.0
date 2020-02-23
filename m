Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3F55169837
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2020 16:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgBWPEz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Feb 2020 10:04:55 -0500
Received: from mga12.intel.com ([192.55.52.136]:40581 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgBWPEz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Feb 2020 10:04:55 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Feb 2020 07:04:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,476,1574150400"; 
   d="scan'208";a="435670098"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga005.fm.intel.com with ESMTP; 23 Feb 2020 07:04:54 -0800
Date:   Sun, 23 Feb 2020 07:04:54 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V4 09/13] fs/xfs: Add write aops lock to xfs layer
Message-ID: <20200223150454.GD29607@iweiny-DESK2.sc.intel.com>
References: <20200221004134.30599-1-ira.weiny@intel.com>
 <20200221004134.30599-10-ira.weiny@intel.com>
 <20200222003109.GE9506@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200222003109.GE9506@magnolia>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 21, 2020 at 04:31:09PM -0800, Darrick J. Wong wrote:
> On Thu, Feb 20, 2020 at 04:41:30PM -0800, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > XFS requires the use of the aops of an inode to quiesced prior to
> > changing it to/from the DAX aops vector.
> > 
> > Take the aops write lock while changing DAX state.
> > 
> > We define a new XFS_DAX_EXCL lock type to carry the lock through to
> > transaction completion.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > Changes from v3:
> > 	Change locking function names to reflect changes in previous
> > 	patches.
> > 
> > Changes from V2:
> > 	Change name of patch (WAS: fs/xfs: Add lock/unlock state to xfs)
> > 	Remove the xfs specific lock and move to the vfs layer.
> > 		We still use XFS_LOCK_DAX_EXCL to be able to pass this
> > 		flag through to the transaction code.  But we no longer
> > 		have a lock specific to xfs.  This removes a lot of code
> > 		from the XFS layer, preps us for using this in ext4, and
> > 		is actually more straight forward now that all the
> > 		locking requirements are better known.
> > 
> > 	Fix locking order comment
> > 	Rework for new 'state' names
> > 	(Other comments on the previous patch are not applicable with
> > 	new patch as much of the code was removed in favor of the vfs
> > 	level lock)
> > ---
> >  fs/xfs/xfs_inode.c | 22 ++++++++++++++++++++--
> >  fs/xfs/xfs_inode.h |  7 +++++--
> >  2 files changed, 25 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> > index 35df324875db..5b014c428f0f 100644
> > --- a/fs/xfs/xfs_inode.c
> > +++ b/fs/xfs/xfs_inode.c
> > @@ -142,12 +142,12 @@ xfs_ilock_attr_map_shared(
> >   *
> >   * Basic locking order:
> >   *
> > - * i_rwsem -> i_mmap_lock -> page_lock -> i_ilock
> > + * s_dax_sem -> i_rwsem -> i_mmap_lock -> page_lock -> i_ilock
> 
> "dax_sem"?  I thought this was now called i_aops_sem?

:-/ yep...

> 
> >   *
> >   * mmap_sem locking order:
> >   *
> >   * i_rwsem -> page lock -> mmap_sem
> > - * mmap_sem -> i_mmap_lock -> page_lock
> > + * s_dax_sem -> mmap_sem -> i_mmap_lock -> page_lock
> >   *
> >   * The difference in mmap_sem locking order mean that we cannot hold the
> >   * i_mmap_lock over syscall based read(2)/write(2) based IO. These IO paths can
> > @@ -182,6 +182,9 @@ xfs_ilock(
> >  	       (XFS_ILOCK_SHARED | XFS_ILOCK_EXCL));
> >  	ASSERT((lock_flags & ~(XFS_LOCK_MASK | XFS_LOCK_SUBCLASS_MASK)) == 0);
> >  
> > +	if (lock_flags & XFS_DAX_EXCL)
> 
> And similarly, I think this should be XFS_OPSLOCK_EXCL...

... and ... yes...

Thanks for the review, I'll clean it up.

Ira

> 
> --D
> 
> > +		inode_aops_down_write(VFS_I(ip));
> > +
> >  	if (lock_flags & XFS_IOLOCK_EXCL) {
> >  		down_write_nested(&VFS_I(ip)->i_rwsem,
> >  				  XFS_IOLOCK_DEP(lock_flags));
> > @@ -224,6 +227,8 @@ xfs_ilock_nowait(
> >  	 * You can't set both SHARED and EXCL for the same lock,
> >  	 * and only XFS_IOLOCK_SHARED, XFS_IOLOCK_EXCL, XFS_ILOCK_SHARED,
> >  	 * and XFS_ILOCK_EXCL are valid values to set in lock_flags.
> > +	 *
> > +	 * XFS_DAX_* is not allowed
> >  	 */
> >  	ASSERT((lock_flags & (XFS_IOLOCK_SHARED | XFS_IOLOCK_EXCL)) !=
> >  	       (XFS_IOLOCK_SHARED | XFS_IOLOCK_EXCL));
> > @@ -232,6 +237,7 @@ xfs_ilock_nowait(
> >  	ASSERT((lock_flags & (XFS_ILOCK_SHARED | XFS_ILOCK_EXCL)) !=
> >  	       (XFS_ILOCK_SHARED | XFS_ILOCK_EXCL));
> >  	ASSERT((lock_flags & ~(XFS_LOCK_MASK | XFS_LOCK_SUBCLASS_MASK)) == 0);
> > +	ASSERT((lock_flags & XFS_DAX_EXCL) == 0);
> >  
> >  	if (lock_flags & XFS_IOLOCK_EXCL) {
> >  		if (!down_write_trylock(&VFS_I(ip)->i_rwsem))
> > @@ -318,6 +324,9 @@ xfs_iunlock(
> >  	else if (lock_flags & XFS_ILOCK_SHARED)
> >  		mrunlock_shared(&ip->i_lock);
> >  
> > +	if (lock_flags & XFS_DAX_EXCL)
> > +		inode_aops_up_write(VFS_I(ip));
> > +
> >  	trace_xfs_iunlock(ip, lock_flags, _RET_IP_);
> >  }
> >  
> > @@ -333,6 +342,8 @@ xfs_ilock_demote(
> >  	ASSERT(lock_flags & (XFS_IOLOCK_EXCL|XFS_MMAPLOCK_EXCL|XFS_ILOCK_EXCL));
> >  	ASSERT((lock_flags &
> >  		~(XFS_IOLOCK_EXCL|XFS_MMAPLOCK_EXCL|XFS_ILOCK_EXCL)) == 0);
> > +	/* XFS_DAX_* is not allowed */
> > +	ASSERT((lock_flags & XFS_DAX_EXCL) == 0);
> >  
> >  	if (lock_flags & XFS_ILOCK_EXCL)
> >  		mrdemote(&ip->i_lock);
> > @@ -465,6 +476,9 @@ xfs_lock_inodes(
> >  	ASSERT(!(lock_mode & XFS_ILOCK_EXCL) ||
> >  		inodes <= XFS_ILOCK_MAX_SUBCLASS + 1);
> >  
> > +	/* XFS_DAX_* is not allowed */
> > +	ASSERT((lock_mode & XFS_DAX_EXCL) == 0);
> > +
> >  	if (lock_mode & XFS_IOLOCK_EXCL) {
> >  		ASSERT(!(lock_mode & (XFS_MMAPLOCK_EXCL | XFS_ILOCK_EXCL)));
> >  	} else if (lock_mode & XFS_MMAPLOCK_EXCL)
> > @@ -566,6 +580,10 @@ xfs_lock_two_inodes(
> >  	ASSERT(!(ip0_mode & (XFS_MMAPLOCK_SHARED|XFS_MMAPLOCK_EXCL)) ||
> >  	       !(ip1_mode & (XFS_ILOCK_SHARED|XFS_ILOCK_EXCL)));
> >  
> > +	/* XFS_DAX_* is not allowed */
> > +	ASSERT((ip0_mode & XFS_DAX_EXCL) == 0);
> > +	ASSERT((ip1_mode & XFS_DAX_EXCL) == 0);
> > +
> >  	ASSERT(ip0->i_ino != ip1->i_ino);
> >  
> >  	if (ip0->i_ino > ip1->i_ino) {
> > diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> > index 492e53992fa9..25fe20740bf7 100644
> > --- a/fs/xfs/xfs_inode.h
> > +++ b/fs/xfs/xfs_inode.h
> > @@ -278,10 +278,12 @@ static inline void xfs_ifunlock(struct xfs_inode *ip)
> >  #define	XFS_ILOCK_SHARED	(1<<3)
> >  #define	XFS_MMAPLOCK_EXCL	(1<<4)
> >  #define	XFS_MMAPLOCK_SHARED	(1<<5)
> > +#define	XFS_DAX_EXCL		(1<<6)
> >  
> >  #define XFS_LOCK_MASK		(XFS_IOLOCK_EXCL | XFS_IOLOCK_SHARED \
> >  				| XFS_ILOCK_EXCL | XFS_ILOCK_SHARED \
> > -				| XFS_MMAPLOCK_EXCL | XFS_MMAPLOCK_SHARED)
> > +				| XFS_MMAPLOCK_EXCL | XFS_MMAPLOCK_SHARED \
> > +				| XFS_DAX_EXCL)
> >  
> >  #define XFS_LOCK_FLAGS \
> >  	{ XFS_IOLOCK_EXCL,	"IOLOCK_EXCL" }, \
> > @@ -289,7 +291,8 @@ static inline void xfs_ifunlock(struct xfs_inode *ip)
> >  	{ XFS_ILOCK_EXCL,	"ILOCK_EXCL" }, \
> >  	{ XFS_ILOCK_SHARED,	"ILOCK_SHARED" }, \
> >  	{ XFS_MMAPLOCK_EXCL,	"MMAPLOCK_EXCL" }, \
> > -	{ XFS_MMAPLOCK_SHARED,	"MMAPLOCK_SHARED" }
> > +	{ XFS_MMAPLOCK_SHARED,	"MMAPLOCK_SHARED" }, \
> > +	{ XFS_DAX_EXCL,		"DAX_EXCL" }
> >  
> >  
> >  /*
> > -- 
> > 2.21.0
> > 
