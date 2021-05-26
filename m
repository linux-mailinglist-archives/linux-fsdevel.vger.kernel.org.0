Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78734390D4E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 02:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbhEZAcr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 20:32:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:48096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232290AbhEZAcr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 20:32:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C4DD61417;
        Wed, 26 May 2021 00:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621989076;
        bh=rS46CPL5f/bRkO3BMaBiDsChhnXIQ5enJBn3cWJSARI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EYB84DlrjLbIs+294Q2BHQTtfWQRKXf12JBKt3fQ7TQe/ngCPuxG8bq1AXIC8GFBW
         164RokZrn8F2UaWo3cfJy6ODnx1A6xjqs9aP61EGhdJB4lrQ0H+LHDp4picjDqVNF6
         eHNc38JvQ7+pVmbA+L/KbPR+v1N2VY+bE7DO1bqNR7dyUHjJPhVTK7RfGVv01SINOE
         RQSoHwH5p+J8F+Dm4+60c30NdmypCBr4x2s4EZ7hAafoGIfRsxbfJ6b/VC2yErIvUZ
         DS/D4Z02jdflaIRX/u2c/AW69aMYHhBebjs9tCnry30cMoRZY1G6P5kI6Mc5tK8upN
         B+JpymCMsUtMA==
Date:   Tue, 25 May 2021 17:31:16 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, dan.j.williams@intel.com,
        willy@infradead.org, viro@zeniv.linux.org.uk, david@fromorbit.com,
        hch@lst.de, rgoldwyn@suse.de, jack@suse.cz
Subject: Re: [PATCH v6 7/7] fs/xfs: Add dax dedupe support
Message-ID: <20210526003116.GU202121@locust>
References: <20210519060045.1051226-1-ruansy.fnst@fujitsu.com>
 <20210519060045.1051226-8-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519060045.1051226-8-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 19, 2021 at 02:00:45PM +0800, Shiyang Ruan wrote:
> Introduce xfs_mmaplock_two_inodes_and_break_dax_layout() for dax files
> who are going to be deduped.  After that, call compare range function
> only when files are both DAX or not.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  fs/xfs/xfs_file.c    |  2 +-
>  fs/xfs/xfs_inode.c   | 57 ++++++++++++++++++++++++++++++++++++++++++++
>  fs/xfs/xfs_inode.h   |  1 +
>  fs/xfs/xfs_reflink.c |  4 ++--
>  4 files changed, 61 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 38d8eca05aee..bd5002d38df4 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -823,7 +823,7 @@ xfs_wait_dax_page(
>  	xfs_ilock(ip, XFS_MMAPLOCK_EXCL);
>  }
>  
> -static int
> +int
>  xfs_break_dax_layouts(
>  	struct inode		*inode,
>  	bool			*retry)
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index 0369eb22c1bb..d5e2791969ba 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -3711,6 +3711,59 @@ xfs_iolock_two_inodes_and_break_layout(
>  	return 0;
>  }
>  
> +static int
> +xfs_mmaplock_two_inodes_and_break_dax_layout(
> +	struct xfs_inode	*ip1,
> +	struct xfs_inode	*ip2)
> +{
> +	int			error, attempts = 0;
> +	bool			retry;
> +	struct page		*page;
> +	struct xfs_log_item	*lp;
> +
> +	if (ip1->i_ino > ip2->i_ino)
> +		swap(ip1, ip2);

If Jan Kara [added to cc] succeeds in hoisting the MMAPLOCK to struct
address space then this is going to have to change to:

	if (VFS_I(ip1)->i_mapping > VFS_I(ip2)->i_mapping)
		swap(ip1, ip2);

For now this is ok.

> +
> +again:
> +	retry = false;
> +	/* Lock the first inode */
> +	xfs_ilock(ip1, XFS_MMAPLOCK_EXCL);
> +	error = xfs_break_dax_layouts(VFS_I(ip1), &retry);
> +	if (error || retry) {
> +		xfs_iunlock(ip1, XFS_MMAPLOCK_EXCL);
> +		goto again;
> +	}
> +
> +	if (ip1 == ip2)
> +		return 0;
> +
> +	/* Nested lock the second inode */
> +	lp = &ip1->i_itemp->ili_item;
> +	if (lp && test_bit(XFS_LI_IN_AIL, &lp->li_flags)) {
> +		if (!xfs_ilock_nowait(ip2,
> +		    xfs_lock_inumorder(XFS_MMAPLOCK_EXCL, 1))) {
> +			xfs_iunlock(ip1, XFS_MMAPLOCK_EXCL);
> +			if ((++attempts % 5) == 0)
> +				delay(1); /* Don't just spin the CPU */
> +			goto again;
> +		}
> +	} else
> +		xfs_ilock(ip2, xfs_lock_inumorder(XFS_MMAPLOCK_EXCL, 1));

I wonder if this chunk is really necessary considering that the AIL
never touches the MMAPLOCK/i_mapping invalidation lock?  I guess it
doesn't really hurt anything since that's what the code does now.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> +	/*
> +	 * We cannot use xfs_break_dax_layouts() directly here because it may
> +	 * need to unlock & lock the XFS_MMAPLOCK_EXCL which is not suitable
> +	 * for this nested lock case.
> +	 */
> +	page = dax_layout_busy_page(VFS_I(ip2)->i_mapping);
> +	if (page && page_ref_count(page) != 1) {
> +		xfs_iunlock(ip2, XFS_MMAPLOCK_EXCL);
> +		xfs_iunlock(ip1, XFS_MMAPLOCK_EXCL);
> +		goto again;
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * Lock two inodes so that userspace cannot initiate I/O via file syscalls or
>   * mmap activity.
> @@ -3725,6 +3778,10 @@ xfs_ilock2_io_mmap(
>  	ret = xfs_iolock_two_inodes_and_break_layout(VFS_I(ip1), VFS_I(ip2));
>  	if (ret)
>  		return ret;
> +
> +	if (IS_DAX(VFS_I(ip1)) && IS_DAX(VFS_I(ip2)))
> +		return xfs_mmaplock_two_inodes_and_break_dax_layout(ip1, ip2);
> +
>  	if (ip1 == ip2)
>  		xfs_ilock(ip1, XFS_MMAPLOCK_EXCL);
>  	else
> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> index ca826cfba91c..2d0b344fb100 100644
> --- a/fs/xfs/xfs_inode.h
> +++ b/fs/xfs/xfs_inode.h
> @@ -457,6 +457,7 @@ enum xfs_prealloc_flags {
>  
>  int	xfs_update_prealloc_flags(struct xfs_inode *ip,
>  				  enum xfs_prealloc_flags flags);
> +int	xfs_break_dax_layouts(struct inode *inode, bool *retry);
>  int	xfs_break_layouts(struct inode *inode, uint *iolock,
>  		enum layout_break_reason reason);
>  
> diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
> index 9a780948dbd0..ff308304c5cd 100644
> --- a/fs/xfs/xfs_reflink.c
> +++ b/fs/xfs/xfs_reflink.c
> @@ -1324,8 +1324,8 @@ xfs_reflink_remap_prep(
>  	if (XFS_IS_REALTIME_INODE(src) || XFS_IS_REALTIME_INODE(dest))
>  		goto out_unlock;
>  
> -	/* Don't share DAX file data for now. */
> -	if (IS_DAX(inode_in) || IS_DAX(inode_out))
> +	/* Don't share DAX file data with non-DAX file. */
> +	if (IS_DAX(inode_in) != IS_DAX(inode_out))
>  		goto out_unlock;
>  
>  	if (!IS_DAX(inode_in))
> -- 
> 2.31.1
> 
> 
> 
