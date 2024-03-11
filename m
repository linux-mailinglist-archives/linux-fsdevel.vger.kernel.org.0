Return-Path: <linux-fsdevel+bounces-14139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E2A878425
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 16:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67234282E3E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 15:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0120D40C1F;
	Mon, 11 Mar 2024 15:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNh/kVgH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A294436E;
	Mon, 11 Mar 2024 15:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710172110; cv=none; b=ijXn0KIsTAxMJNS1UlYdTKD0Y/1GZoghhl0VPta58MxwG+7SvzwLsyzdmkzkS+9SpayWBTu6oI6TRFOIe4Zr2oZs+OiVd1sv5jQx0KXBLxOTjAUGut/fBqHSMPoM4gnNxWolVt77YrxK+CmaKggNDHQs8dQ7SQGkrjnmJmu92CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710172110; c=relaxed/simple;
	bh=RUD9l8K0ik+qMLD3iJPUNnrvnQ/fBcf65l1dnsvJdxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XzpA99U0CMMPuYQB4WV66BlEfrODBM3GGiEOxTLvqEQRriuOffGrWAwWPt++O47m0KayCaO1obhXpR1aThrCTy86k9wuvoxajhfNvDdokd5/VoukGPoNdVuTP/jFYSU9A3uMGpbwv+4ekj1t8MY97L2X4RgXh3EKs6rwHar6wpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNh/kVgH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD5BAC433C7;
	Mon, 11 Mar 2024 15:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710172109;
	bh=RUD9l8K0ik+qMLD3iJPUNnrvnQ/fBcf65l1dnsvJdxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tNh/kVgHoGI2BUMioMJwQKAz9a5IxZARg3igTcSTnIZHFAyH8kN//COrjU0tW+NUx
	 6yMwSbFxCBbX1+t9KNh0+akuqS4Q4e+tNvOwrf8OQdVkpeV/J2MhgqfreMQ3YWvIDI
	 5iMZQoIiIfOj8kxn501ol9FtrcWQh0n0p2kZwe3ibY43fko6d3Hz+gcQlI8SIwL7NA
	 z+kaPQCg/RoLImbDMgmqHW0VveS1kJgQM4NMfXQ+IgJr2Tjs3cxrZz4ZzdPKIKsPt2
	 ipto79hw9MqAJAz+dfTmzkTWMHkVgllhSUb+/Y7Uan6E0zuKcalRie3SFTfPT8Z02G
	 /CaAz4/Fp2nVg==
Date: Mon, 11 Mar 2024 08:48:29 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, hch@infradead.org, brauner@kernel.org,
	david@fromorbit.com, tytso@mit.edu, jack@suse.cz,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 3/4] iomap: don't increase i_size if it's not a write
 operation
Message-ID: <20240311154829.GU1927156@frogsfrogsfrogs>
References: <20240311122255.2637311-1-yi.zhang@huaweicloud.com>
 <20240311122255.2637311-4-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311122255.2637311-4-yi.zhang@huaweicloud.com>

On Mon, Mar 11, 2024 at 08:22:54PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Increase i_size in iomap_zero_range() and iomap_unshare_iter() is not
> needed, the caller should handle it. Especially, when truncate partial
> block, we could not increase i_size beyond the new EOF here. It doesn't
> affect xfs and gfs2 now because they set the new file size after zero
> out, it doesn't matter that a transient increase in i_size, but it will
> affect ext4 because it set file size before truncate.

>                                                       At the same time,
> iomap_write_failed() is also not needed for above two cases too, so
> factor them out and move them to iomap_write_iter() and
> iomap_zero_iter().

This change should be a separate patch with its own justification.
Which is, AFAICT, something along the lines of:

"Unsharing and zeroing can only happen within EOF, so there is never a
need to perform posteof pagecache truncation if write begin fails."

> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Doesn't this patch fix a bug in ext4?

> ---
>  fs/iomap/buffered-io.c | 59 +++++++++++++++++++++---------------------
>  1 file changed, 30 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 093c4515b22a..19f91324c690 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -786,7 +786,6 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
>  
>  out_unlock:
>  	__iomap_put_folio(iter, pos, 0, folio);
> -	iomap_write_failed(iter->inode, pos, len);
>  
>  	return status;
>  }
> @@ -838,34 +837,13 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
>  		size_t copied, struct folio *folio)
>  {
>  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> -	loff_t old_size = iter->inode->i_size;
> -	size_t ret;
> -
> -	if (srcmap->type == IOMAP_INLINE) {
> -		ret = iomap_write_end_inline(iter, folio, pos, copied);
> -	} else if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
> -		ret = block_write_end(NULL, iter->inode->i_mapping, pos, len,
> -				copied, &folio->page, NULL);
> -	} else {
> -		ret = __iomap_write_end(iter->inode, pos, len, copied, folio);
> -	}
>  
> -	/*
> -	 * Update the in-memory inode size after copying the data into the page
> -	 * cache.  It's up to the file system to write the updated size to disk,
> -	 * preferably after I/O completion so that no stale data is exposed.
> -	 */
> -	if (pos + ret > old_size) {
> -		i_size_write(iter->inode, pos + ret);
> -		iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
> -	}
> -	__iomap_put_folio(iter, pos, ret, folio);
> -
> -	if (old_size < pos)
> -		pagecache_isize_extended(iter->inode, old_size, pos);
> -	if (ret < len)
> -		iomap_write_failed(iter->inode, pos + ret, len - ret);
> -	return ret;
> +	if (srcmap->type == IOMAP_INLINE)
> +		return iomap_write_end_inline(iter, folio, pos, copied);
> +	if (srcmap->flags & IOMAP_F_BUFFER_HEAD)
> +		return block_write_end(NULL, iter->inode->i_mapping, pos, len,
> +				       copied, &folio->page, NULL);
> +	return __iomap_write_end(iter->inode, pos, len, copied, folio);
>  }
>  
>  static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
> @@ -880,6 +858,7 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  
>  	do {
>  		struct folio *folio;
> +		loff_t old_size;
>  		size_t offset;		/* Offset into folio */
>  		size_t bytes;		/* Bytes to write to folio */
>  		size_t copied;		/* Bytes copied from user */
> @@ -912,8 +891,10 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  		}
>  
>  		status = iomap_write_begin(iter, pos, bytes, &folio);
> -		if (unlikely(status))
> +		if (unlikely(status)) {
> +			iomap_write_failed(iter->inode, pos, bytes);
>  			break;
> +		}
>  		if (iter->iomap.flags & IOMAP_F_STALE)
>  			break;
>  
> @@ -927,6 +908,24 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  		copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);
>  		status = iomap_write_end(iter, pos, bytes, copied, folio);
>  
> +		/*
> +		 * Update the in-memory inode size after copying the data into
> +		 * the page cache.  It's up to the file system to write the
> +		 * updated size to disk, preferably after I/O completion so that
> +		 * no stale data is exposed.
> +		 */
> +		old_size = iter->inode->i_size;
> +		if (pos + status > old_size) {
> +			i_size_write(iter->inode, pos + status);
> +			iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
> +		}
> +		__iomap_put_folio(iter, pos, status, folio);

Why is it necessary to hoist the __iomap_put_folio calls from
iomap_write_end into iomap_write_iter, iomap_unshare_iter, and
iomap_zero_iter?  None of those functions seem to use it, and it makes
more sense to me that iomap_write_end releases the folio that
iomap_write_begin returned.

--D

> +
> +		if (old_size < pos)
> +			pagecache_isize_extended(iter->inode, old_size, pos);
> +		if (status < bytes)
> +			iomap_write_failed(iter->inode, pos + status,
> +					   bytes - status);
>  		if (unlikely(copied != status))
>  			iov_iter_revert(i, copied - status);
>  
> @@ -1296,6 +1295,7 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
>  			bytes = folio_size(folio) - offset;
>  
>  		bytes = iomap_write_end(iter, pos, bytes, bytes, folio);
> +		__iomap_put_folio(iter, pos, bytes, folio);
>  		if (WARN_ON_ONCE(bytes == 0))
>  			return -EIO;
>  
> @@ -1360,6 +1360,7 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  		folio_mark_accessed(folio);
>  
>  		bytes = iomap_write_end(iter, pos, bytes, bytes, folio);
> +		__iomap_put_folio(iter, pos, bytes, folio);
>  		if (WARN_ON_ONCE(bytes == 0))
>  			return -EIO;
>  
> -- 
> 2.39.2
> 
> 

