Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9ACF45AF3E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 23:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237653AbhKWWk2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 17:40:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:43738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234838AbhKWWk0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 17:40:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 089CA60C49;
        Tue, 23 Nov 2021 22:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637707038;
        bh=YoReEiqelazD5gYdwwwjglLG5WIXTm48Y79nG7v+/64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=esbBG88W+Ksgf1/9SPXidiiMAoAl6tHAy8Z5dI2BFZGeSFRKhj9VIE5z48pJ2TVwS
         u8dZRhP0gjMAxe2/7wMJSvm0eKckqB/3y7Poz7NFhOXjts2NFH7aj9/6QYmmqdkANS
         7QjFOh4qXMRLjlyCIZKEZtzPYWBAb1qc/MLPUnfneD88KzlufjM5dGoxIWTXZS/vn9
         gkAy5TsCEZ5tA3ou44o8vF0i5wPkbWffhhDeRrO0l0k4t7RDGvpuEdGXgsc7oM/UBf
         HbkzZDG4XTUB/l9XZooJEM8l2d55HNgxCB/vEW3QKkYKqt2vYt/8Lr6ZfFIdbztRCK
         aPyVJKaOUsgqQ==
Date:   Tue, 23 Nov 2021 14:37:17 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, dm-devel@redhat.com,
        linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>
Subject: Re: [PATCH 15/29] xfs: add xfs_zero_range and xfs_truncate_page
 helpers
Message-ID: <20211123223717.GJ266024@magnolia>
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-16-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109083309.584081-16-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 09, 2021 at 09:32:55AM +0100, Christoph Hellwig wrote:
> From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> 
> Add helpers to prepare for using different DAX operations.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> [hch: split from a larger patch + slight cleanups]
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_bmap_util.c |  7 +++----
>  fs/xfs/xfs_file.c      |  3 +--
>  fs/xfs/xfs_iomap.c     | 25 +++++++++++++++++++++++++
>  fs/xfs/xfs_iomap.h     |  4 ++++
>  fs/xfs/xfs_iops.c      |  7 +++----
>  fs/xfs/xfs_reflink.c   |  3 +--
>  6 files changed, 37 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
> index 73a36b7be3bd1..797ea0c8b14e1 100644
> --- a/fs/xfs/xfs_bmap_util.c
> +++ b/fs/xfs/xfs_bmap_util.c
> @@ -1001,7 +1001,7 @@ xfs_free_file_space(
>  
>  	/*
>  	 * Now that we've unmap all full blocks we'll have to zero out any
> -	 * partial block at the beginning and/or end.  iomap_zero_range is smart
> +	 * partial block at the beginning and/or end.  xfs_zero_range is smart
>  	 * enough to skip any holes, including those we just created, but we
>  	 * must take care not to zero beyond EOF and enlarge i_size.
>  	 */
> @@ -1009,15 +1009,14 @@ xfs_free_file_space(
>  		return 0;
>  	if (offset + len > XFS_ISIZE(ip))
>  		len = XFS_ISIZE(ip) - offset;
> -	error = iomap_zero_range(VFS_I(ip), offset, len, NULL,
> -			&xfs_buffered_write_iomap_ops);
> +	error = xfs_zero_range(ip, offset, len, NULL);
>  	if (error)
>  		return error;
>  
>  	/*
>  	 * If we zeroed right up to EOF and EOF straddles a page boundary we
>  	 * must make sure that the post-EOF area is also zeroed because the
> -	 * page could be mmap'd and iomap_zero_range doesn't do that for us.
> +	 * page could be mmap'd and xfs_zero_range doesn't do that for us.
>  	 * Writeback of the eof page will do this, albeit clumsily.
>  	 */
>  	if (offset + len >= XFS_ISIZE(ip) && offset_in_page(offset + len) > 0) {
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 27594738b0d18..8d4c5ca261bd7 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -437,8 +437,7 @@ xfs_file_write_checks(
>  		}
>  
>  		trace_xfs_zero_eof(ip, isize, iocb->ki_pos - isize);
> -		error = iomap_zero_range(inode, isize, iocb->ki_pos - isize,
> -				NULL, &xfs_buffered_write_iomap_ops);
> +		error = xfs_zero_range(ip, isize, iocb->ki_pos - isize, NULL);
>  		if (error)
>  			return error;
>  	} else
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 093758440ad53..d6d71ae9f2ae4 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1311,3 +1311,28 @@ xfs_xattr_iomap_begin(
>  const struct iomap_ops xfs_xattr_iomap_ops = {
>  	.iomap_begin		= xfs_xattr_iomap_begin,
>  };
> +
> +int
> +xfs_zero_range(
> +	struct xfs_inode	*ip,
> +	loff_t			pos,
> +	loff_t			len,
> +	bool			*did_zero)
> +{
> +	struct inode		*inode = VFS_I(ip);
> +
> +	return iomap_zero_range(inode, pos, len, did_zero,
> +				&xfs_buffered_write_iomap_ops);
> +}
> +
> +int
> +xfs_truncate_page(
> +	struct xfs_inode	*ip,
> +	loff_t			pos,
> +	bool			*did_zero)
> +{
> +	struct inode		*inode = VFS_I(ip);
> +
> +	return iomap_truncate_page(inode, pos, did_zero,
> +				   &xfs_buffered_write_iomap_ops);
> +}
> diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
> index 7d3703556d0e0..f1a281ab9328c 100644
> --- a/fs/xfs/xfs_iomap.h
> +++ b/fs/xfs/xfs_iomap.h
> @@ -20,6 +20,10 @@ xfs_fileoff_t xfs_iomap_eof_align_last_fsb(struct xfs_inode *ip,
>  int xfs_bmbt_to_iomap(struct xfs_inode *, struct iomap *,
>  		struct xfs_bmbt_irec *, u16);
>  
> +int xfs_zero_range(struct xfs_inode *ip, loff_t pos, loff_t len,
> +		bool *did_zero);
> +int xfs_truncate_page(struct xfs_inode *ip, loff_t pos, bool *did_zero);
> +
>  static inline xfs_filblks_t
>  xfs_aligned_fsb_count(
>  	xfs_fileoff_t		offset_fsb,
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index a607d6aca5c4d..ab5ef52b2a9ff 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -911,8 +911,8 @@ xfs_setattr_size(
>  	 */
>  	if (newsize > oldsize) {
>  		trace_xfs_zero_eof(ip, oldsize, newsize - oldsize);
> -		error = iomap_zero_range(inode, oldsize, newsize - oldsize,
> -				&did_zeroing, &xfs_buffered_write_iomap_ops);
> +		error = xfs_zero_range(ip, oldsize, newsize - oldsize,
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
> +		error = xfs_truncate_page(ip, newsize, &did_zeroing);
>  	}
>  
>  	if (error)
> diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
> index cb0edb1d68ef1..facce5c076d83 100644
> --- a/fs/xfs/xfs_reflink.c
> +++ b/fs/xfs/xfs_reflink.c
> @@ -1269,8 +1269,7 @@ xfs_reflink_zero_posteof(
>  		return 0;
>  
>  	trace_xfs_zero_eof(ip, isize, pos - isize);
> -	return iomap_zero_range(VFS_I(ip), isize, pos - isize, NULL,
> -			&xfs_buffered_write_iomap_ops);
> +	return xfs_zero_range(ip, isize, pos - isize, NULL);
>  }
>  
>  /*
> -- 
> 2.30.2
> 
