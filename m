Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE2937B37B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 03:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhELBbS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 21:31:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229736AbhELBbR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 21:31:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 97A8C61927;
        Wed, 12 May 2021 01:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620783009;
        bh=Vg/kR1hjFwUfoVRRdbozqj39FwPrLpjJeupkthrO8dg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lX+jqid+kjhN2QdPnhITLk0QCYptvNdWPIUcxl6ZvEm/1sSuT86Io+0dBEHLXet39
         oFlbVHlB80OIgUgofgyOWFXLj9jnSHusLOxK5U39lXpMCIdDoFxnOl7Gw1SJNPIJyc
         AkTBlE3RwfhuniiBbnbRxmG6F6n1OegYg0Uc4cf3NmxcK5vhnRMvUlHdV+V2DiTc7U
         D2HK/zpriKrBtRbDJ5ljVUeRqxxRD9ewEmZ5T2GUZXyLl3pe9eVPbyYOFL2BM1rTpS
         j2uVKgfLi6JfwIhFaRHeqNUbenCnp1qG5CrhP38UqBvn5geNiHykbJmGcfXyBqUErl
         /c6LzaD3ifpBQ==
Date:   Tue, 11 May 2021 18:30:06 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, dan.j.williams@intel.com,
        willy@infradead.org, viro@zeniv.linux.org.uk, david@fromorbit.com,
        hch@lst.de, rgoldwyn@suse.de
Subject: Re: [PATCH v5 6/7] fs/xfs: Handle CoW for fsdax write() path
Message-ID: <20210512013006.GV8582@magnolia>
References: <20210511030933.3080921-1-ruansy.fnst@fujitsu.com>
 <20210511030933.3080921-7-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511030933.3080921-7-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 11, 2021 at 11:09:32AM +0800, Shiyang Ruan wrote:
> In fsdax mode, WRITE and ZERO on a shared extent need CoW performed. After
> CoW, new allocated extents needs to be remapped to the file.  So, add an
> iomap_end for dax write ops to do the remapping work.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  fs/xfs/xfs_bmap_util.c |  3 +--
>  fs/xfs/xfs_file.c      |  9 +++----
>  fs/xfs/xfs_iomap.c     | 61 +++++++++++++++++++++++++++++++++++++++++-
>  fs/xfs/xfs_iomap.h     |  4 +++
>  fs/xfs/xfs_iops.c      |  7 +++--
>  fs/xfs/xfs_reflink.c   |  3 +--
>  6 files changed, 72 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
> index a5e9d7d34023..2a36dc93ff27 100644
> --- a/fs/xfs/xfs_bmap_util.c
> +++ b/fs/xfs/xfs_bmap_util.c
> @@ -965,8 +965,7 @@ xfs_free_file_space(
>  		return 0;
>  	if (offset + len > XFS_ISIZE(ip))
>  		len = XFS_ISIZE(ip) - offset;
> -	error = iomap_zero_range(VFS_I(ip), offset, len, NULL,
> -			&xfs_buffered_write_iomap_ops);
> +	error = xfs_iomap_zero_range(ip, offset, len, NULL);
>  	if (error)
>  		return error;
>  
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 396ef36dcd0a..38d8eca05aee 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -684,11 +684,8 @@ xfs_file_dax_write(
>  	pos = iocb->ki_pos;
>  
>  	trace_xfs_file_dax_write(iocb, from);
> -	ret = dax_iomap_rw(iocb, from, &xfs_direct_write_iomap_ops);
> -	if (ret > 0 && iocb->ki_pos > i_size_read(inode)) {
> -		i_size_write(inode, iocb->ki_pos);
> -		error = xfs_setfilesize(ip, pos, ret);
> -	}
> +	ret = dax_iomap_rw(iocb, from, &xfs_dax_write_iomap_ops);
> +
>  out:
>  	if (iolock)
>  		xfs_iunlock(ip, iolock);
> @@ -1309,7 +1306,7 @@ __xfs_filemap_fault(
>  
>  		ret = dax_iomap_fault(vmf, pe_size, &pfn, NULL,
>  				(write_fault && !vmf->cow_page) ?
> -				 &xfs_direct_write_iomap_ops :
> +				 &xfs_dax_write_iomap_ops :
>  				 &xfs_read_iomap_ops);
>  		if (ret & VM_FAULT_NEEDDSYNC)
>  			ret = dax_finish_sync_fault(vmf, pe_size, pfn);
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index d154f42e2dc6..8b593a51480d 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -761,7 +761,8 @@ xfs_direct_write_iomap_begin(
>  
>  		/* may drop and re-acquire the ilock */
>  		error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
> -				&lockmode, flags & IOMAP_DIRECT);
> +				&lockmode,
> +				(flags & IOMAP_DIRECT) || IS_DAX(inode));
>  		if (error)
>  			goto out_unlock;
>  		if (shared)
> @@ -854,6 +855,41 @@ const struct iomap_ops xfs_direct_write_iomap_ops = {
>  	.iomap_begin		= xfs_direct_write_iomap_begin,
>  };
>  
> +static int
> +xfs_dax_write_iomap_end(
> +	struct inode		*inode,
> +	loff_t			pos,
> +	loff_t			length,
> +	ssize_t			written,
> +	unsigned int		flags,
> +	struct iomap		*iomap)
> +{
> +	int			error = 0;
> +	struct xfs_inode	*ip = XFS_I(inode);
> +	bool			cow = xfs_is_cow_inode(ip);
> +
> +	if (!written)
> +		return 0;
> +
> +	if (pos + written > i_size_read(inode) && !(flags & IOMAP_FAULT)) {
> +		i_size_write(inode, pos + written);
> +		error = xfs_setfilesize(ip, pos, written);
> +		if (error && cow) {
> +			xfs_reflink_cancel_cow_range(ip, pos, written, true);
> +			return error;
> +		}
> +	}
> +	if (cow)
> +		error = xfs_reflink_end_cow(ip, pos, written);
> +
> +	return error;
> +}
> +
> +const struct iomap_ops xfs_dax_write_iomap_ops = {
> +	.iomap_begin		= xfs_direct_write_iomap_begin,
> +	.iomap_end		= xfs_dax_write_iomap_end,
> +};
> +
>  static int
>  xfs_buffered_write_iomap_begin(
>  	struct inode		*inode,
> @@ -1311,3 +1347,26 @@ xfs_xattr_iomap_begin(
>  const struct iomap_ops xfs_xattr_iomap_ops = {
>  	.iomap_begin		= xfs_xattr_iomap_begin,
>  };
> +
> +int
> +xfs_iomap_zero_range(
> +	struct xfs_inode	*ip,
> +	loff_t			offset,
> +	loff_t			len,
> +	bool			*did_zero)
> +{
> +	return iomap_zero_range(VFS_I(ip), offset, len, did_zero,
> +			IS_DAX(VFS_I(ip)) ? &xfs_dax_write_iomap_ops
> +					  : &xfs_buffered_write_iomap_ops);
> +}
> +
> +int
> +xfs_iomap_truncate_page(
> +	struct xfs_inode	*ip,
> +	loff_t			pos,
> +	bool			*did_zero)
> +{
> +	return iomap_truncate_page(VFS_I(ip), pos, did_zero,
> +			IS_DAX(VFS_I(ip)) ? &xfs_dax_write_iomap_ops
> +					  : &xfs_buffered_write_iomap_ops);
> +}

I wonder, can these become static inline helpers in xfs_iomap.h?
It would be kinda nice not to add another stack frame just to virtualize
the iomap ops.

--D

> diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
> index 7d3703556d0e..e4e515cd63b5 100644
> --- a/fs/xfs/xfs_iomap.h
> +++ b/fs/xfs/xfs_iomap.h
> @@ -14,6 +14,9 @@ struct xfs_bmbt_irec;
>  int xfs_iomap_write_direct(struct xfs_inode *ip, xfs_fileoff_t offset_fsb,
>  		xfs_fileoff_t count_fsb, struct xfs_bmbt_irec *imap);
>  int xfs_iomap_write_unwritten(struct xfs_inode *, xfs_off_t, xfs_off_t, bool);
> +int xfs_iomap_zero_range(struct xfs_inode *ip, loff_t offset, loff_t len,
> +		bool *did_zero);
> +int xfs_iomap_truncate_page(struct xfs_inode *ip, loff_t pos, bool *did_zero);
>  xfs_fileoff_t xfs_iomap_eof_align_last_fsb(struct xfs_inode *ip,
>  		xfs_fileoff_t end_fsb);
>  
> @@ -42,6 +45,7 @@ xfs_aligned_fsb_count(
>  
>  extern const struct iomap_ops xfs_buffered_write_iomap_ops;
>  extern const struct iomap_ops xfs_direct_write_iomap_ops;
> +extern const struct iomap_ops xfs_dax_write_iomap_ops;
>  extern const struct iomap_ops xfs_read_iomap_ops;
>  extern const struct iomap_ops xfs_seek_iomap_ops;
>  extern const struct iomap_ops xfs_xattr_iomap_ops;
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index dfe24b7f26e5..6d936c3e1a6e 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -911,8 +911,8 @@ xfs_setattr_size(
>  	 */
>  	if (newsize > oldsize) {
>  		trace_xfs_zero_eof(ip, oldsize, newsize - oldsize);
> -		error = iomap_zero_range(inode, oldsize, newsize - oldsize,
> -				&did_zeroing, &xfs_buffered_write_iomap_ops);
> +		error = xfs_iomap_zero_range(ip, oldsize, newsize - oldsize,
> +				&did_zeroing);
>  	} else {
>  		/*
>  		 * iomap won't detect a dirty page over an unwritten block (or a
> @@ -924,8 +924,7 @@ xfs_setattr_size(
>  						     newsize);
>  		if (error)
>  			return error;
> -		error = iomap_truncate_page(inode, newsize, &did_zeroing,
> -				&xfs_buffered_write_iomap_ops);
> +		error = xfs_iomap_truncate_page(ip, newsize, &did_zeroing);
>  	}
>  
>  	if (error)
> diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
> index d25434f93235..9a780948dbd0 100644
> --- a/fs/xfs/xfs_reflink.c
> +++ b/fs/xfs/xfs_reflink.c
> @@ -1266,8 +1266,7 @@ xfs_reflink_zero_posteof(
>  		return 0;
>  
>  	trace_xfs_zero_eof(ip, isize, pos - isize);
> -	return iomap_zero_range(VFS_I(ip), isize, pos - isize, NULL,
> -			&xfs_buffered_write_iomap_ops);
> +	return xfs_iomap_zero_range(ip, isize, pos - isize, NULL);
>  }
>  
>  /*
> -- 
> 2.31.1
> 
> 
> 
