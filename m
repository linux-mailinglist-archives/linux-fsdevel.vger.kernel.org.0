Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5206140D0C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 02:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbhIPAXs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 20:23:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:54736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233367AbhIPAXr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 20:23:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2394261157;
        Thu, 16 Sep 2021 00:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631751748;
        bh=4z4JcaZpiS167/VVfDR1gcapchasih3ZqhIqL2fbA58=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f/cWD2JUnx8RUnXEzXI8GS68PfaVcEr/cVAKI11LHtLxqNaZyLeQINaRGlrOVkI/x
         wiUMHaDnaTKGVRB1E/lpt/DoegPLcGi65ypd4FsN7IUL+3nWhRYBnLMSJVL0T9tJbc
         plA3XkTFwPZDDSg91kwf2lAWUNhdxogcpdlaEQrzV79A0ZLSeZvfCkxnwLKk3jNPL2
         EJEbrM0628giTlHXs4wlyeIkaMRrLpqW1uhdmSPiZWodoh5YG7SbZuYdNRrDHyc2kc
         WHMzAJFgAdBE8Gtx0z731BKOxHEi28nrkqFUq/C7FepJyYidk3wsBvWhnXWcyQ391G
         8gwd1veWttbBw==
Date:   Wed, 15 Sep 2021 17:22:27 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     hch@lst.de, linux-xfs@vger.kernel.org, dan.j.williams@intel.com,
        david@fromorbit.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        rgoldwyn@suse.de, viro@zeniv.linux.org.uk, willy@infradead.org
Subject: Re: [PATCH v9 7/8] xfs: support CoW in fsdax mode
Message-ID: <20210916002227.GD34830@magnolia>
References: <20210915104501.4146910-1-ruansy.fnst@fujitsu.com>
 <20210915104501.4146910-8-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915104501.4146910-8-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 15, 2021 at 06:45:00PM +0800, Shiyang Ruan wrote:
> In fsdax mode, WRITE and ZERO on a shared extent need CoW performed.
> After that, new allocated extents needs to be remapped to the file.
> So, add a CoW identification in ->iomap_begin(), and implement
> ->iomap_end() to do the remapping work.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  fs/xfs/xfs_bmap_util.c |  3 +--
>  fs/xfs/xfs_file.c      |  6 +++---
>  fs/xfs/xfs_iomap.c     | 38 +++++++++++++++++++++++++++++++++++++-
>  fs/xfs/xfs_iomap.h     | 30 ++++++++++++++++++++++++++++++
>  fs/xfs/xfs_iops.c      |  7 +++----
>  fs/xfs/xfs_reflink.c   |  3 +--
>  6 files changed, 75 insertions(+), 12 deletions(-)
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
> index 7aa943edfc02..2ef1930374d2 100644
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
> @@ -1329,8 +1329,8 @@ __xfs_filemap_fault(
>  		xfs_ilock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
>  		ret = dax_iomap_fault(vmf, pe_size, &pfn, NULL,
>  				(write_fault && !vmf->cow_page) ?
> -				 &xfs_direct_write_iomap_ops :
> -				 &xfs_read_iomap_ops);
> +					&xfs_dax_write_iomap_ops :
> +					&xfs_read_iomap_ops);

Hmm... I wonder if this should get hoisted to a "xfs_dax_iomap_fault"
wrapper like you did for xfs_iomap_zero_range?

>  		if (ret & VM_FAULT_NEEDDSYNC)
>  			ret = dax_finish_sync_fault(vmf, pe_size, pfn);
>  		xfs_iunlock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 093758440ad5..6fa3b377cb81 100644
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
> +	struct inode 		*inode,
> +	loff_t 			pos,
> +	loff_t 			length,
> +	ssize_t 		written,
> +	unsigned 		flags,
> +	struct iomap 		*iomap)

Whitespace nit:     ^ space before a tab.

> +{
> +	struct xfs_inode	*ip = XFS_I(inode);
> +	/*
> +	 * Usually we use @written to indicate whether the operation was
> +	 * successful.  But it is always positive or zero.  The CoW needs the
> +	 * actual error code from actor().  So, get it from
> +	 * iomap_iter->processed.

Hm.  All six arguments are derived from the struct iomap_iter, so maybe
it makes more sense to pass that in?  I'll poke around with this more
tomorrow.

> +	 */
> +	const struct iomap_iter *iter =
> +				container_of(iomap, typeof(*iter), iomap);
> +
> +	if (!xfs_is_cow_inode(ip))
> +		return 0;
> +
> +	if (iter->processed <= 0) {
> +		xfs_reflink_cancel_cow_range(ip, pos, length, true);
> +		return 0;
> +	}
> +
> +	return xfs_reflink_end_cow(ip, pos, iter->processed);
> +}
> +
> +const struct iomap_ops xfs_dax_write_iomap_ops = {
> +	.iomap_begin 	= xfs_direct_write_iomap_begin,

Space before tab    ^

> +	.iomap_end	= xfs_dax_write_iomap_end,
> +};
> +
>  static int
>  xfs_buffered_write_iomap_begin(

Also, we have an related request to drop the EXPERIMENTAL tag for
non-DAX reflink.  Whichever patch enables dax+reflink for xfs needs to
make it clear that reflink + any possibility of DAX emits an
EXPERIMENTAL warning.

--D

>  	struct inode		*inode,
> diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
> index 7d3703556d0e..92679a0c3578 100644
> --- a/fs/xfs/xfs_iomap.h
> +++ b/fs/xfs/xfs_iomap.h
> @@ -45,5 +45,35 @@ extern const struct iomap_ops xfs_direct_write_iomap_ops;
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
> +			IS_DAX(inode)?
> +				&xfs_dax_write_iomap_ops :
> +				&xfs_buffered_write_iomap_ops);
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
