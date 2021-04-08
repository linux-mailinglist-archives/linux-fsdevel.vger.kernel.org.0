Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E05358FE7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 00:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbhDHWkR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 18:40:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:48520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232915AbhDHWkR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 18:40:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8384B61159;
        Thu,  8 Apr 2021 22:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617921605;
        bh=K2jD0akbYdLKdPVjxAi9o8SNykZ+szmTFeSEaBQvdAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WrCiUDzFMVQIkHOkYS3MG06pbKBK/bbzYf/4K8GIVKhJT75yUCKPt96COtV2NsKLF
         SJi23FEsbZp9zBWmaA9MtxaVxUszXe+0JejeHHYrgboPLEiKi3noeW0g4x2+2jW5Zq
         gfqw9b+/5/2k/jGe2AHoPa/iS6fU6C0V/LByEVpLrHGEPNU6m6ijKKU2KLzXDXetRh
         t/LqBwK8aJ5mUGOF8vcuHrw1rfO5rIbIC6zh4pAQcYgNrulUQ86wFCBRFJlIfbjgKj
         9xTRcK5vL/OpkXoKKImAntaD+xFRaYcRmr/yR9rgIaacZmEQENbXWMpvztIYKkpCiA
         LxzqwV8hjxIpg==
Date:   Thu, 8 Apr 2021 15:40:04 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, dan.j.williams@intel.com,
        willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk,
        linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        rgoldwyn@suse.de
Subject: Re: [PATCH v4 6/7] fs/xfs: Handle CoW for fsdax write() path
Message-ID: <20210408224004.GC3957620@magnolia>
References: <20210408120432.1063608-1-ruansy.fnst@fujitsu.com>
 <20210408120432.1063608-7-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408120432.1063608-7-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 08, 2021 at 08:04:31PM +0800, Shiyang Ruan wrote:
> In fsdax mode, WRITE and ZERO on a shared extent need CoW performed. After
> CoW, new allocated extents needs to be remapped to the file.  So, add an
> iomap_end for dax write ops to do the remapping work.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  fs/xfs/xfs_bmap_util.c |  3 +--
>  fs/xfs/xfs_file.c      |  9 +++----
>  fs/xfs/xfs_iomap.c     | 58 +++++++++++++++++++++++++++++++++++++++++-
>  fs/xfs/xfs_iomap.h     |  4 +++
>  fs/xfs/xfs_iops.c      |  7 +++--
>  fs/xfs/xfs_reflink.c   |  3 +--
>  6 files changed, 69 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
> index e7d68318e6a5..9fcea33dd2c9 100644
> --- a/fs/xfs/xfs_bmap_util.c
> +++ b/fs/xfs/xfs_bmap_util.c
> @@ -954,8 +954,7 @@ xfs_free_file_space(
>  		return 0;
>  	if (offset + len > XFS_ISIZE(ip))
>  		len = XFS_ISIZE(ip) - offset;
> -	error = iomap_zero_range(VFS_I(ip), offset, len, NULL,
> -			&xfs_buffered_write_iomap_ops);
> +	error = xfs_iomap_zero_range(VFS_I(ip), offset, len, NULL);
>  	if (error)
>  		return error;
>  
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index a007ca0711d9..5795d5d6f869 100644
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
> index e17ab7f42928..f818f989687b 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -760,7 +760,8 @@ xfs_direct_write_iomap_begin(
>  
>  		/* may drop and re-acquire the ilock */
>  		error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
> -				&lockmode, flags & IOMAP_DIRECT);
> +				&lockmode,
> +				flags & IOMAP_DIRECT || IS_DAX(inode));

Parentheses, please:
				(flags & IOMAP_DIRECT) || IS_DAX(inode));

>  		if (error)
>  			goto out_unlock;
>  		if (shared)
> @@ -853,6 +854,38 @@ const struct iomap_ops xfs_direct_write_iomap_ops = {
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
> +	xfs_inode_t		*ip = XFS_I(inode);

Please don't use typedefs:

	struct xfs_inode	*ip = XFS_I(inode);

> +	bool			cow = xfs_is_cow_inode(ip);
> +
> +	if (pos + written > i_size_read(inode)) {

What if we wrote zero bytes?  Usually that means error, right?

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
> @@ -1314,3 +1347,26 @@ xfs_xattr_iomap_begin(
>  const struct iomap_ops xfs_xattr_iomap_ops = {
>  	.iomap_begin		= xfs_xattr_iomap_begin,
>  };
> +
> +int
> +xfs_iomap_zero_range(
> +	struct inode		*inode,

Might as well pass the xfs_inode pointers directly into these two functions.

--D

> +	loff_t			offset,
> +	loff_t			len,
> +	bool			*did_zero)
> +{
> +	return iomap_zero_range(inode, offset, len, did_zero,
> +			IS_DAX(inode) ? &xfs_dax_write_iomap_ops :
> +					&xfs_buffered_write_iomap_ops);
> +}
> +
> +int
> +xfs_iomap_truncate_page(
> +	struct inode		*inode,
> +	loff_t			pos,
> +	bool			*did_zero)
> +{
> +	return iomap_truncate_page(inode, pos, did_zero,
> +			IS_DAX(inode) ? &xfs_dax_write_iomap_ops :
> +					&xfs_buffered_write_iomap_ops);
> +}
> diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
> index 7d3703556d0e..8adb2bf78a5a 100644
> --- a/fs/xfs/xfs_iomap.h
> +++ b/fs/xfs/xfs_iomap.h
> @@ -14,6 +14,9 @@ struct xfs_bmbt_irec;
>  int xfs_iomap_write_direct(struct xfs_inode *ip, xfs_fileoff_t offset_fsb,
>  		xfs_fileoff_t count_fsb, struct xfs_bmbt_irec *imap);
>  int xfs_iomap_write_unwritten(struct xfs_inode *, xfs_off_t, xfs_off_t, bool);
> +int xfs_iomap_zero_range(struct inode *inode, loff_t offset, loff_t len,
> +		bool *did_zero);
> +int xfs_iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero);
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
> index 66ebccb5a6ff..db8eeaa8a773 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -879,8 +879,8 @@ xfs_setattr_size(
>  	 */
>  	if (newsize > oldsize) {
>  		trace_xfs_zero_eof(ip, oldsize, newsize - oldsize);
> -		error = iomap_zero_range(inode, oldsize, newsize - oldsize,
> -				&did_zeroing, &xfs_buffered_write_iomap_ops);
> +		error = xfs_iomap_zero_range(inode, oldsize, newsize - oldsize,
> +				&did_zeroing);
>  	} else {
>  		/*
>  		 * iomap won't detect a dirty page over an unwritten block (or a
> @@ -892,8 +892,7 @@ xfs_setattr_size(
>  						     newsize);
>  		if (error)
>  			return error;
> -		error = iomap_truncate_page(inode, newsize, &did_zeroing,
> -				&xfs_buffered_write_iomap_ops);
> +		error = xfs_iomap_truncate_page(inode, newsize, &did_zeroing);
>  	}
>  
>  	if (error)
> diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
> index 9ef9f98725a2..a4cd6e8a7aa0 100644
> --- a/fs/xfs/xfs_reflink.c
> +++ b/fs/xfs/xfs_reflink.c
> @@ -1266,8 +1266,7 @@ xfs_reflink_zero_posteof(
>  		return 0;
>  
>  	trace_xfs_zero_eof(ip, isize, pos - isize);
> -	return iomap_zero_range(VFS_I(ip), isize, pos - isize, NULL,
> -			&xfs_buffered_write_iomap_ops);
> +	return xfs_iomap_zero_range(VFS_I(ip), isize, pos - isize, NULL);
>  }
>  
>  /*
> -- 
> 2.31.0
> 
> 
> 
