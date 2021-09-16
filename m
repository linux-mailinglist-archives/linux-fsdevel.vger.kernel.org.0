Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5135840D246
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 06:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhIPETc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 00:19:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:57658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229463AbhIPETb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 00:19:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E19A36113E;
        Thu, 16 Sep 2021 04:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631765892;
        bh=07MliWGJfGAK+LhqNrCmA5FdUeLaldL2r83Wm9CtfwE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YNy7NcFBStdeULkAFLP1P/e8exSZKD/ocG0UoVxepppronIhq3DuOcEgY9DbIUpUx
         Ts2B4qsGqOZQhEMvr6kuBvwouJoPBd+IRhbRnBDTX1AjM6riW5JXJ+NY33FHu0gIXM
         nmKYOky1JW4mWHdpPchdsUvl8QmapizQ2FC12gQuBYvW7acddNmqmmpQAWLOMZv/gB
         ze8EhCyoCvudfheaRV91fy4ERv3QgoJAqNvLrDvL3B6aqnroPjQmF1icxewkc/fb+I
         zjsTo0QCjyPN+ngTpfAjH3w0myrvPJU4gL0bmaOkJjn8ZtE4XJBS1PYvTozRzYlyuR
         TcyJEfRDi+ACw==
Date:   Wed, 15 Sep 2021 21:18:11 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     hch@lst.de, linux-xfs@vger.kernel.org, dan.j.williams@intel.com,
        david@fromorbit.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        rgoldwyn@suse.de, viro@zeniv.linux.org.uk, willy@infradead.org
Subject: Re: [PATCH v9 8/8] xfs: Add dax dedupe support
Message-ID: <20210916041811.GB34874@magnolia>
References: <20210915104501.4146910-1-ruansy.fnst@fujitsu.com>
 <20210915104501.4146910-9-ruansy.fnst@fujitsu.com>
 <20210916003008.GE34830@magnolia>
 <38eeee6f-aa11-4c13-b7c0-2e48927b85dc@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38eeee6f-aa11-4c13-b7c0-2e48927b85dc@fujitsu.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 16, 2021 at 12:01:18PM +0800, Shiyang Ruan wrote:
> 
> 
> On 2021/9/16 8:30, Darrick J. Wong wrote:
> > On Wed, Sep 15, 2021 at 06:45:01PM +0800, Shiyang Ruan wrote:
> > > Introduce xfs_mmaplock_two_inodes_and_break_dax_layout() for dax files
> > > who are going to be deduped.  After that, call compare range function
> > > only when files are both DAX or not.
> > > 
> > > Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> > > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > >   fs/xfs/xfs_file.c    |  2 +-
> > >   fs/xfs/xfs_inode.c   | 80 +++++++++++++++++++++++++++++++++++++++++---
> > >   fs/xfs/xfs_inode.h   |  1 +
> > >   fs/xfs/xfs_reflink.c |  4 +--
> > >   4 files changed, 80 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> > > index 2ef1930374d2..c3061723613c 100644
> > > --- a/fs/xfs/xfs_file.c
> > > +++ b/fs/xfs/xfs_file.c
> > > @@ -846,7 +846,7 @@ xfs_wait_dax_page(
> > >   	xfs_ilock(ip, XFS_MMAPLOCK_EXCL);
> > >   }
> > > -static int
> > > +int
> > >   xfs_break_dax_layouts(
> > >   	struct inode		*inode,
> > >   	bool			*retry)
> > > diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> > > index a4f6f034fb81..bdc084cdbf46 100644
> > > --- a/fs/xfs/xfs_inode.c
> > > +++ b/fs/xfs/xfs_inode.c
> > > @@ -3790,6 +3790,61 @@ xfs_iolock_two_inodes_and_break_layout(
> > >   	return 0;
> > >   }
> > > +static int
> > > +xfs_mmaplock_two_inodes_and_break_dax_layout(
> > > +	struct xfs_inode	*ip1,
> > > +	struct xfs_inode	*ip2)
> > > +{
> > > +	int			error, attempts = 0;
> > > +	bool			retry;
> > > +	struct page		*page;
> > > +	struct xfs_log_item	*lp;
> > > +
> > > +	if (ip1->i_ino > ip2->i_ino)
> > > +		swap(ip1, ip2);
> > > +
> > > +again:
> > > +	retry = false;
> > > +	/* Lock the first inode */
> > > +	xfs_ilock(ip1, XFS_MMAPLOCK_EXCL);
> > > +	error = xfs_break_dax_layouts(VFS_I(ip1), &retry);
> > > +	if (error || retry) {
> > > +		xfs_iunlock(ip1, XFS_MMAPLOCK_EXCL);
> > > +		if (error == 0 && retry)
> > > +			goto again;
> > > +		return error;
> > > +	}
> > > +
> > > +	if (ip1 == ip2)
> > > +		return 0;
> > > +
> > > +	/* Nested lock the second inode */
> > > +	lp = &ip1->i_itemp->ili_item;
> > > +	if (lp && test_bit(XFS_LI_IN_AIL, &lp->li_flags)) {
> > > +		if (!xfs_ilock_nowait(ip2,
> > > +		    xfs_lock_inumorder(XFS_MMAPLOCK_EXCL, 1))) {
> > > +			xfs_iunlock(ip1, XFS_MMAPLOCK_EXCL);
> > > +			if ((++attempts % 5) == 0)
> > > +				delay(1); /* Don't just spin the CPU */
> > > +			goto again;
> > > +		}
> > 
> > I suspect we don't need this part for grabbing the MMAPLOCK^W pagecache
> > invalidatelock.  The AIL only grabs the ILOCK, never the IOLOCK or the
> > MMAPLOCK.
> 
> Maybe I have misunderstood this part.
> 
> What I want is to lock the two inode nestedly.  This code is copied from
> xfs_lock_two_inodes(), which checks this AIL during locking two inode with
> each of the three kinds of locks.

<nod> It's totally reasonable to copy-paste the function you want and
change it as needed...

> But I also found the recent merged function: filemap_invalidate_lock_two()
> just locks two inode directly without checking AIL.  So, I am not if the AIL
> check is needed in this case.

...especially when even the maintainer is only 99% sure that the AIL
checking chunk here can be removed.  Anyone else have an opinion?

--D

> > 
> > > +	} else
> > > +		xfs_ilock(ip2, xfs_lock_inumorder(XFS_MMAPLOCK_EXCL, 1));
> > > +	/*
> > > +	 * We cannot use xfs_break_dax_layouts() directly here because it may
> > > +	 * need to unlock & lock the XFS_MMAPLOCK_EXCL which is not suitable
> > > +	 * for this nested lock case.
> > > +	 */
> > > +	page = dax_layout_busy_page(VFS_I(ip2)->i_mapping);
> > > +	if (page && page_ref_count(page) != 1) {
> > 
> > Do you think the patch "ext4/xfs: add page refcount helper" would be a
> > good cleanup to head this series?
> > 
> > https://lore.kernel.org/linux-xfs/20210913161604.31981-1-alex.sierra@amd.com/T/#m59cf7cd5c0d521ad487fa3a15d31c3865db88bdf
> 
> Got it.
> 
> 
> --
> Thanks,
> Ruan
> 
> > 
> > The rest of the logic looks ok.
> > 
> > --D
> > 
> > > +		xfs_iunlock(ip2, XFS_MMAPLOCK_EXCL);
> > > +		xfs_iunlock(ip1, XFS_MMAPLOCK_EXCL);
> > > +		goto again;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >   /*
> > >    * Lock two inodes so that userspace cannot initiate I/O via file syscalls or
> > >    * mmap activity.
> > > @@ -3804,8 +3859,19 @@ xfs_ilock2_io_mmap(
> > >   	ret = xfs_iolock_two_inodes_and_break_layout(VFS_I(ip1), VFS_I(ip2));
> > >   	if (ret)
> > >   		return ret;
> > > -	filemap_invalidate_lock_two(VFS_I(ip1)->i_mapping,
> > > -				    VFS_I(ip2)->i_mapping);
> > > +
> > > +	if (IS_DAX(VFS_I(ip1)) && IS_DAX(VFS_I(ip2))) {
> > > +		ret = xfs_mmaplock_two_inodes_and_break_dax_layout(ip1, ip2);
> > > +		if (ret) {
> > > +			inode_unlock(VFS_I(ip2));
> > > +			if (ip1 != ip2)
> > > +				inode_unlock(VFS_I(ip1));
> > > +			return ret;
> > > +		}
> > > +	} else
> > > +		filemap_invalidate_lock_two(VFS_I(ip1)->i_mapping,
> > > +					    VFS_I(ip2)->i_mapping);
> > > +
> > >   	return 0;
> > >   }
> > > @@ -3815,8 +3881,14 @@ xfs_iunlock2_io_mmap(
> > >   	struct xfs_inode	*ip1,
> > >   	struct xfs_inode	*ip2)
> > >   {
> > > -	filemap_invalidate_unlock_two(VFS_I(ip1)->i_mapping,
> > > -				      VFS_I(ip2)->i_mapping);
> > > +	if (IS_DAX(VFS_I(ip1)) && IS_DAX(VFS_I(ip2))) {
> > > +		xfs_iunlock(ip2, XFS_MMAPLOCK_EXCL);
> > > +		if (ip1 != ip2)
> > > +			xfs_iunlock(ip1, XFS_MMAPLOCK_EXCL);
> > > +	} else
> > > +		filemap_invalidate_unlock_two(VFS_I(ip1)->i_mapping,
> > > +					      VFS_I(ip2)->i_mapping);
> > > +
> > >   	inode_unlock(VFS_I(ip2));
> > >   	if (ip1 != ip2)
> > >   		inode_unlock(VFS_I(ip1));
> > > diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> > > index b21b177832d1..f7e26fe31a26 100644
> > > --- a/fs/xfs/xfs_inode.h
> > > +++ b/fs/xfs/xfs_inode.h
> > > @@ -472,6 +472,7 @@ enum xfs_prealloc_flags {
> > >   int	xfs_update_prealloc_flags(struct xfs_inode *ip,
> > >   				  enum xfs_prealloc_flags flags);
> > > +int	xfs_break_dax_layouts(struct inode *inode, bool *retry);
> > >   int	xfs_break_layouts(struct inode *inode, uint *iolock,
> > >   		enum layout_break_reason reason);
> > > diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
> > > index 9d876e268734..3b99c9dfcf0d 100644
> > > --- a/fs/xfs/xfs_reflink.c
> > > +++ b/fs/xfs/xfs_reflink.c
> > > @@ -1327,8 +1327,8 @@ xfs_reflink_remap_prep(
> > >   	if (XFS_IS_REALTIME_INODE(src) || XFS_IS_REALTIME_INODE(dest))
> > >   		goto out_unlock;
> > > -	/* Don't share DAX file data for now. */
> > > -	if (IS_DAX(inode_in) || IS_DAX(inode_out))
> > > +	/* Don't share DAX file data with non-DAX file. */
> > > +	if (IS_DAX(inode_in) != IS_DAX(inode_out))
> > >   		goto out_unlock;
> > >   	if (!IS_DAX(inode_in))
> > > -- 
> > > 2.33.0
> > > 
> > > 
> > > 
> 
> 
