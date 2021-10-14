Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B393042DFE6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 19:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbhJNRI2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 13:08:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232331AbhJNRI2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 13:08:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2175761152;
        Thu, 14 Oct 2021 17:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634231183;
        bh=gHRFogiS7ENQ7g40ZXO7645Y7MTCDeTBdUTC9wUMGTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m3sQXvBJ4t8iKB6QoTZGaZtSHLZQRO33s6kuXRUHqgE+plVGXl3/hRmp0inrfOSEQ
         WG4JHMRngdQVNjCs5casGqGtT1PBIN+VMFs9uIURw61QVhtt64/0hCiBlXVNFciC0Y
         uhUbsUPoQrVG2e0HkopGtEabRcJY1aZKlJcFkeoFTtuwQRV4ZSKvmNajVa3pkUrJpa
         lXt8sU8JKJlv+fXYcNgrrp8gW1Dr+YfedI3C9eDcdMuZ+mJrjbdtB0dmADovxPzhWg
         wm2MCXvPIaRswW/LMoitUorAH6PJnClFC09yNnuRp2tqIX42t8T0NEX37KmhOAC/wH
         ZwNnyOdxxTTdg==
Date:   Thu, 14 Oct 2021 10:06:22 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     dan.j.williams@intel.com, hch@lst.de, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        rgoldwyn@suse.de, viro@zeniv.linux.org.uk, willy@infradead.org
Subject: Re: [PATCH v10 7/8] xfs: support CoW in fsdax mode
Message-ID: <20211014170622.GB24333@magnolia>
References: <20210928062311.4012070-1-ruansy.fnst@fujitsu.com>
 <20210928062311.4012070-8-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928062311.4012070-8-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 28, 2021 at 02:23:10PM +0800, Shiyang Ruan wrote:
> In fsdax mode, WRITE and ZERO on a shared extent need CoW performed.
> After that, new allocated extents needs to be remapped to the file.
> So, add a CoW identification in ->iomap_begin(), and implement
> ->iomap_end() to do the remapping work.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>

I think this patch looks good, so:
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

A big thank you to Shiyang for persisting in getting this series
finished! :)

Judging from the conversation Christoph and I had the last time this
patchset was submitted, I gather the last big remaining issue is the use
of page->mapping for hw poison.  So I'll go take a look at "fsdax:
introduce FS query interface to support reflink" now.

--D

> ---
>  fs/xfs/xfs_bmap_util.c |  3 +--
>  fs/xfs/xfs_file.c      |  7 ++-----
>  fs/xfs/xfs_iomap.c     | 30 +++++++++++++++++++++++++++-
>  fs/xfs/xfs_iomap.h     | 44 ++++++++++++++++++++++++++++++++++++++++++
>  fs/xfs/xfs_iops.c      |  7 +++----
>  fs/xfs/xfs_reflink.c   |  3 +--
>  6 files changed, 80 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
> index 73a36b7be3bd..0681250e0a5d 100644
> --- a/fs/xfs/xfs_bmap_util.c
> +++ b/fs/xfs/xfs_bmap_util.c
> @@ -1009,8 +1009,7 @@ xfs_free_file_space(
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
> index 7aa943edfc02..afde4fbefb6f 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -704,7 +704,7 @@ xfs_file_dax_write(
>  	pos = iocb->ki_pos;
>  
>  	trace_xfs_file_dax_write(iocb, from);
> -	ret = dax_iomap_rw(iocb, from, &xfs_direct_write_iomap_ops);
> +	ret = dax_iomap_rw(iocb, from, &xfs_dax_write_iomap_ops);
>  	if (ret > 0 && iocb->ki_pos > i_size_read(inode)) {
>  		i_size_write(inode, iocb->ki_pos);
>  		error = xfs_setfilesize(ip, pos, ret);
> @@ -1327,10 +1327,7 @@ __xfs_filemap_fault(
>  		pfn_t pfn;
>  
>  		xfs_ilock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
> -		ret = dax_iomap_fault(vmf, pe_size, &pfn, NULL,
> -				(write_fault && !vmf->cow_page) ?
> -				 &xfs_direct_write_iomap_ops :
> -				 &xfs_read_iomap_ops);
> +		ret = xfs_dax_iomap_fault(vmf, pe_size, write_fault, &pfn);
>  		if (ret & VM_FAULT_NEEDDSYNC)
>  			ret = dax_finish_sync_fault(vmf, pe_size, pfn);
>  		xfs_iunlock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 093758440ad5..51cb5b713521 100644
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
> @@ -854,6 +855,33 @@ const struct iomap_ops xfs_direct_write_iomap_ops = {
>  	.iomap_begin		= xfs_direct_write_iomap_begin,
>  };
>  
> +static int
> +xfs_dax_write_iomap_end(
> +	struct inode		*inode,
> +	loff_t			pos,
> +	loff_t			length,
> +	ssize_t			written,
> +	unsigned		flags,
> +	struct iomap		*iomap)
> +{
> +	struct xfs_inode	*ip = XFS_I(inode);
> +
> +	if (!xfs_is_cow_inode(ip))
> +		return 0;
> +
> +	if (!written) {
> +		xfs_reflink_cancel_cow_range(ip, pos, length, true);
> +		return 0;
> +	}
> +
> +	return xfs_reflink_end_cow(ip, pos, written);
> +}
> +
> +const struct iomap_ops xfs_dax_write_iomap_ops = {
> +	.iomap_begin	= xfs_direct_write_iomap_begin,
> +	.iomap_end	= xfs_dax_write_iomap_end,
> +};
> +
>  static int
>  xfs_buffered_write_iomap_begin(
>  	struct inode		*inode,
> diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
> index 7d3703556d0e..81726bfbf890 100644
> --- a/fs/xfs/xfs_iomap.h
> +++ b/fs/xfs/xfs_iomap.h
> @@ -7,6 +7,7 @@
>  #define __XFS_IOMAP_H__
>  
>  #include <linux/iomap.h>
> +#include <linux/dax.h>
>  
>  struct xfs_inode;
>  struct xfs_bmbt_irec;
> @@ -45,5 +46,48 @@ extern const struct iomap_ops xfs_direct_write_iomap_ops;
>  extern const struct iomap_ops xfs_read_iomap_ops;
>  extern const struct iomap_ops xfs_seek_iomap_ops;
>  extern const struct iomap_ops xfs_xattr_iomap_ops;
> +extern const struct iomap_ops xfs_dax_write_iomap_ops;
> +
> +static inline int
> +xfs_iomap_zero_range(
> +	struct xfs_inode	*ip,
> +	loff_t			pos,
> +	loff_t			len,
> +	bool			*did_zero)
> +{
> +	struct inode		*inode = VFS_I(ip);
> +
> +	return iomap_zero_range(inode, pos, len, did_zero,
> +			IS_DAX(inode) ?
> +				&xfs_dax_write_iomap_ops :
> +				&xfs_buffered_write_iomap_ops);
> +}
> +
> +static inline int
> +xfs_iomap_truncate_page(
> +	struct xfs_inode	*ip,
> +	loff_t			pos,
> +	bool			*did_zero)
> +{
> +	struct inode		*inode = VFS_I(ip);
> +
> +	return iomap_truncate_page(inode, pos, did_zero,
> +			IS_DAX(inode) ?
> +				&xfs_dax_write_iomap_ops :
> +				&xfs_buffered_write_iomap_ops);
> +}
> +
> +static inline int
> +xfs_dax_iomap_fault(
> +	struct vm_fault		*vmf,
> +	enum page_entry_size	pe_size,
> +	bool			write_fault,
> +	pfn_t			*pfn)
> +{
> +	return dax_iomap_fault(vmf, pe_size, pfn, NULL,
> +			(write_fault && !vmf->cow_page) ?
> +				&xfs_dax_write_iomap_ops :
> +				&xfs_read_iomap_ops);
> +}
>  
>  #endif /* __XFS_IOMAP_H__*/
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index a607d6aca5c4..332e6208dffd 100644
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
> index 7ecea0311e88..9d876e268734 100644
> --- a/fs/xfs/xfs_reflink.c
> +++ b/fs/xfs/xfs_reflink.c
> @@ -1269,8 +1269,7 @@ xfs_reflink_zero_posteof(
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
> 2.33.0
> 
> 
> 
