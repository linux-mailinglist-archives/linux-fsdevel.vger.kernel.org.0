Return-Path: <linux-fsdevel+bounces-20648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CFA8D65FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 17:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BACA71C27E17
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 15:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A220155C8B;
	Fri, 31 May 2024 15:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pHuEE5ts"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE546CDA3;
	Fri, 31 May 2024 15:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717170261; cv=none; b=E6KPpyrohzmrDlqYhwBX3X3kxHvZqSLwWQ0FsrpPpt8yrtSSb79FZcm5r0vaPnuASrEPjvEVG/alYPrYZ4RS2B41u3K+oa5B0NySlhUCp+CIuTQESxe0dZz4vzHMvdcuRnuJsoY7EQEnQZ9z0Agrf76RR+4ch8yylxpWT2TqeYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717170261; c=relaxed/simple;
	bh=0g/brmY75GKu9UfvuKo6Byyw0S+dlVufHw2SasUdd0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7oFnAY6eTy8hV86DHvmx8C1nExhrIQMu/ilvO6NYc/3ZkcYr5j3c0nGcaOVyATrMJdCBZqsPuj42MCH9tIQzlUnFA6FSwffnBe4hoduPJnAgGJZTW96uLOjUm2ckpPK9h/Vc0diXBHcJx3NRLJ2fYPY6/MBY1oi1fq9UlGDbPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pHuEE5ts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE62CC116B1;
	Fri, 31 May 2024 15:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717170261;
	bh=0g/brmY75GKu9UfvuKo6Byyw0S+dlVufHw2SasUdd0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pHuEE5ts+cIgQmZH1nESlqOyjM4GEAGaeWlajSE1/eVcCQarpLFCKNfB/dEd7/dy+
	 ry2ZROPpHTq3yY8FhoN0QTEj2HeIgH60RQwKjs6er4+PZSfbAYkXsL//HmzRKvGJSE
	 x6pdPtPuJgN7IiDctazEkrGQo/yxybb6h/2YulZXBgSk73Oh1xnvmKC3Z8CD/hW6n8
	 3fQvZLER8JD9E/HZc6wuYS3SzDok34OV1MLLDWMZVKFsiA/pq/c4CpF9iwwApVFCYf
	 QbLcKTV5eTCxZV/yfuNbY6xnHKzQIiM1mSGf2KlErHyvvzsqEPzoqHFpt4OQecKFmt
	 4FNVwBNCR0wNw==
Date: Fri, 31 May 2024 08:44:20 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, hch@infradead.org, brauner@kernel.org,
	david@fromorbit.com, chandanbabu@kernel.org, jack@suse.cz,
	willy@infradead.org, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: Re: [RFC PATCH v4 5/8] xfs: refactor the truncating order
Message-ID: <20240531154420.GO52987@frogsfrogsfrogs>
References: <20240529095206.2568162-1-yi.zhang@huaweicloud.com>
 <20240529095206.2568162-6-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529095206.2568162-6-yi.zhang@huaweicloud.com>

On Wed, May 29, 2024 at 05:52:03PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> When truncating down an inode, we call xfs_truncate_page() to zero out
> the tail partial block that beyond new EOF, which prevents exposing
> stale data. But xfs_truncate_page() always assumes the blocksize is
> i_blocksize(inode), it's not always true if we have a large allocation
> unit for a file and we should aligned to this unitsize, e.g. realtime
> inode should aligned to the rtextsize.
> 
> Current xfs_setattr_size() can't support zeroing out a large alignment
> size on trucate down since the process order is wrong. We first do zero
> out through xfs_truncate_page(), and then update inode size through
> truncate_setsize() immediately. If the zeroed range is larger than a
> folio, the write back path would not write back zeroed pagecache beyond
> the EOF folio, so it doesn't write zeroes to the entire tail extent and
> could expose stale data after an appending write into the next aligned
> extent.
> 
> We need to adjust the order to zero out tail aligned blocks, write back
> zeroed or cached data, update i_size and drop cache beyond aligned EOF
> block, preparing for the fix of realtime inode and supporting the
> upcoming forced alignment feature.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  fs/xfs/xfs_iomap.c |   2 +-
>  fs/xfs/xfs_iomap.h |   3 +-
>  fs/xfs/xfs_iops.c  | 107 ++++++++++++++++++++++++++++-----------------
>  3 files changed, 69 insertions(+), 43 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 8cdfcbb5baa7..0369b64cc3f4 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1468,10 +1468,10 @@ int
>  xfs_truncate_page(
>  	struct xfs_inode	*ip,
>  	loff_t			pos,
> +	unsigned int		blocksize,
>  	bool			*did_zero)
>  {
>  	struct inode		*inode = VFS_I(ip);
> -	unsigned int		blocksize = i_blocksize(inode);
>  
>  	if (IS_DAX(inode))
>  		return dax_truncate_page(inode, pos, blocksize, did_zero,
> diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
> index 4da13440bae9..feb1610cb645 100644
> --- a/fs/xfs/xfs_iomap.h
> +++ b/fs/xfs/xfs_iomap.h
> @@ -25,7 +25,8 @@ int xfs_bmbt_to_iomap(struct xfs_inode *ip, struct iomap *iomap,
>  
>  int xfs_zero_range(struct xfs_inode *ip, loff_t pos, loff_t len,
>  		bool *did_zero);
> -int xfs_truncate_page(struct xfs_inode *ip, loff_t pos, bool *did_zero);
> +int xfs_truncate_page(struct xfs_inode *ip, loff_t pos,
> +		unsigned int blocksize, bool *did_zero);
>  
>  static inline xfs_filblks_t
>  xfs_aligned_fsb_count(
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index d44508930b67..d24927075022 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -812,6 +812,7 @@ xfs_setattr_size(
>  	int			error;
>  	uint			lock_flags = 0;
>  	bool			did_zeroing = false;
> +	bool			write_back = false;
>  
>  	xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL | XFS_MMAPLOCK_EXCL);
>  	ASSERT(S_ISREG(inode->i_mode));
> @@ -853,30 +854,7 @@ xfs_setattr_size(
>  	 * the transaction because the inode cannot be unlocked once it is a
>  	 * part of the transaction.
>  	 *
> -	 * Start with zeroing any data beyond EOF that we may expose on file
> -	 * extension, or zeroing out the rest of the block on a downward
> -	 * truncate.
> -	 */
> -	if (newsize > oldsize) {
> -		trace_xfs_zero_eof(ip, oldsize, newsize - oldsize);
> -		error = xfs_zero_range(ip, oldsize, newsize - oldsize,
> -				&did_zeroing);
> -	} else if (newsize != oldsize) {
> -		error = xfs_truncate_page(ip, newsize, &did_zeroing);
> -	}
> -
> -	if (error)
> -		return error;
> -
> -	/*
> -	 * We've already locked out new page faults, so now we can safely remove
> -	 * pages from the page cache knowing they won't get refaulted until we
> -	 * drop the XFS_MMAP_EXCL lock after the extent manipulations are
> -	 * complete. The truncate_setsize() call also cleans partial EOF page
> -	 * PTEs on extending truncates and hence ensures sub-page block size
> -	 * filesystems are correctly handled, too.
> -	 *
> -	 * We have to do all the page cache truncate work outside the
> +	 * And we have to do all the page cache truncate work outside the

Style nit: don't start a paragraph with "and".

>  	 * transaction context as the "lock" order is page lock->log space
>  	 * reservation as defined by extent allocation in the writeback path.
>  	 * Hence a truncate can fail with ENOMEM from xfs_trans_alloc(), but
> @@ -884,27 +862,74 @@ xfs_setattr_size(
>  	 * user visible changes). There's not much we can do about this, except
>  	 * to hope that the caller sees ENOMEM and retries the truncate
>  	 * operation.
> -	 *
> -	 * And we update in-core i_size and truncate page cache beyond newsize
> -	 * before writeback the [i_disk_size, newsize] range, so we're
> -	 * guaranteed not to write stale data past the new EOF on truncate down.
>  	 */
> -	truncate_setsize(inode, newsize);
> +	write_back = newsize > ip->i_disk_size && oldsize != ip->i_disk_size;
> +	if (newsize < oldsize) {
> +		unsigned int blocksize = i_blocksize(inode);
>  
> -	/*
> -	 * We are going to log the inode size change in this transaction so
> -	 * any previous writes that are beyond the on disk EOF and the new
> -	 * EOF that have not been written out need to be written here.  If we
> -	 * do not write the data out, we expose ourselves to the null files
> -	 * problem. Note that this includes any block zeroing we did above;
> -	 * otherwise those blocks may not be zeroed after a crash.
> -	 */
> -	if (did_zeroing ||
> -	    (newsize > ip->i_disk_size && oldsize != ip->i_disk_size)) {
> -		error = filemap_write_and_wait_range(VFS_I(ip)->i_mapping,
> -						ip->i_disk_size, newsize - 1);
> +		/*
> +		 * Zeroing out the partial EOF block and the rest of the extra
> +		 * aligned blocks on a downward truncate.
> +		 */
> +		error = xfs_truncate_page(ip, newsize, blocksize, &did_zeroing);
>  		if (error)
>  			return error;
> +
> +		/*
> +		 * We are going to log the inode size change in this transaction
> +		 * so any previous writes that are beyond the on disk EOF and
> +		 * the new EOF that have not been written out need to be written
> +		 * here.  If we do not write the data out, we expose ourselves
> +		 * to the null files problem. Note that this includes any block
> +		 * zeroing we did above; otherwise those blocks may not be
> +		 * zeroed after a crash.
> +		 */
> +		if (did_zeroing || write_back) {
> +			error = filemap_write_and_wait_range(inode->i_mapping,
> +					min_t(loff_t, ip->i_disk_size, newsize),
> +					roundup_64(newsize, blocksize) - 1);
> +			if (error)
> +				return error;
> +		}
> +
> +		/*
> +		 * Updating i_size after writing back to make sure the zeroed

"Update the incore i_size after flushing dirty tail pages to disk, and
drop all the pagecache beyond the allocation unit containing EOF." ?

> +		 * blocks could been written out, and drop all the page cache
> +		 * range that beyond blocksize aligned new EOF block.
> +		 *
> +		 * We've already locked out new page faults, so now we can
> +		 * safely remove pages from the page cache knowing they won't
> +		 * get refaulted until we drop the XFS_MMAP_EXCL lock after the
> +		 * extent manipulations are complete.
> +		 */
> +		i_size_write(inode, newsize);
> +		truncate_pagecache(inode, roundup_64(newsize, blocksize));

I'm not sure why we need to preserve the pagecache beyond eof having
zeroed and then written the post-eof blocks out to disk, but I'm
guessing this is why you open-code truncate_setsize?

> +	} else {
> +		/*
> +		 * Start with zeroing any data beyond EOF that we may expose on
> +		 * file extension.
> +		 */
> +		if (newsize > oldsize) {
> +			trace_xfs_zero_eof(ip, oldsize, newsize - oldsize);
> +			error = xfs_zero_range(ip, oldsize, newsize - oldsize,
> +					       &did_zeroing);
> +			if (error)
> +				return error;
> +		}
> +
> +		/*
> +		 * The truncate_setsize() call also cleans partial EOF page
> +		 * PTEs on extending truncates and hence ensures sub-page block
> +		 * size filesystems are correctly handled, too.
> +		 */
> +		truncate_setsize(inode, newsize);
> +
> +		if (did_zeroing || write_back) {
> +			error = filemap_write_and_wait_range(inode->i_mapping,
> +					ip->i_disk_size, newsize - 1);
> +			if (error)
> +				return error;
> +		}
>  	}

At this point I wonder if these three truncate cases (down, up, and
unchanged) should just be broken out into three helpers without so much
twisty logic.

xfs_setattr_truncate_down():
	xfs_truncate_page(..., &did_zeroing);

	if (did_zeroing || extending_ondisk_eof)
		filemap_write_and_wait_range(...);

	truncate_setsize(...); /* or your opencoded version */

xfs_setattr_truncate_up():
	xfs_zero_range(..., &did_zeroing);

	truncate_setsize(...);

	if (did_zeroing || extending_ondisk_eof)
		filemap_write_and_wait_range(...);

xfs_setattr_truncate_unchanged():
	truncate_setsize(...);

	if (extending_ondisk_eof)
		filemap_write_and_wait_range(...);

So then the callsite becomes:

	if (newsize > oldsize)
		xfs_settattr_truncate_up();
	else if (newsize < oldsize)
		xfs_setattr_truncate_down();
	else
		xfs_setattr_truncate_unchanged();

But, I dunno.  Most of the code is really just extensive commenting.

--D

> +			if (error)
> +				return error;
> +		}
> +
> +		/*
> +		 * The truncate_setsize() call also cleans partial EOF page
> +		 * PTEs on extending truncates and hence ensures sub-page block
> +		 * size filesystems are correctly handled, too.
> +		 */
> +		truncate_setsize(inode, newsize);
> +
> +		if (did_zeroing || write_back) {
> +			error = filemap_write_and_wait_range(inode->i_mapping,
> +					ip->i_disk_size, newsize - 1);



>  
>  	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_itruncate, 0, 0, 0, &tp);
> -- 
> 2.39.2
> 
> 

