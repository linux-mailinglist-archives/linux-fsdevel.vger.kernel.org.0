Return-Path: <linux-fsdevel+bounces-14838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D776888068A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 22:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 080B31C22049
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 21:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D55D3FB80;
	Tue, 19 Mar 2024 21:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXhxMwXK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CBF3C485;
	Tue, 19 Mar 2024 21:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710882486; cv=none; b=qMiF1XCBU0mUW4634RwdYRZnyzfJECftJsPFwU4Q4+nr58ILi9Tc/XMMfyA+xcs2mPXHHzTSYCUNtPs/gdjpcw0muYry0BL9r6od5+AuL4aZDE/fE/FTwEF1ItdsRzpY4ShKUqYlrJphmoe4QKMknyeZSu4++BgRga6aQrp7Z0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710882486; c=relaxed/simple;
	bh=4YY28ffhMpVq+c07gRVzOqaSW91JO13rslhjeezFpTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QF5PGJwANC6KDVi9x3HBBKuEEvvCekUEEKZzE0TSX+nO3CRw5XIazHXwZiI1wZS+gvvkklLRavW4elnCKEA3YKhf++zGjskNAUrxzkV9e+gcqz5SdV1itidoXRlTjifslm8uKWVU0NckiVjqfJ16fKRKhsWsPZflb6sYcyaVZyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXhxMwXK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14DA0C433C7;
	Tue, 19 Mar 2024 21:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710882486;
	bh=4YY28ffhMpVq+c07gRVzOqaSW91JO13rslhjeezFpTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CXhxMwXK4qIol6IWNrQ+SNhNVdrQMyft4sjfljLQwLpojdDeG1eT+3zQQWbrjgooe
	 H33gInUX5oM3pEPXpe6BzhACEikWjv42le8cLXiVU9neNAq2fnSyEbCc1mmQlPSZdo
	 i/DpMZYD2dU3BF2QM4tmaUwrSwsQENnQvBEQbhlb+pX3GE+WqHIaaSqhnpnu1drQ2j
	 YE9toO6e4g6FXGH1XdEqVBRF9rw0rBdF941EpuV68Jgzb1yH/v8duz6K/ik8Fk0HT9
	 bB7DxMBDOcEZLmpW2KTQ3185baA/Ge5IjxkKXWHS36/JGpgZ/EJp66o8XXfqCChivr
	 CERfliH/1ixug==
Date: Tue, 19 Mar 2024 14:08:05 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, hch@infradead.org, brauner@kernel.org,
	david@fromorbit.com, tytso@mit.edu, jack@suse.cz,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v3 8/9] iomap: make iomap_write_end() return a boolean
Message-ID: <20240319210805.GM1927156@frogsfrogsfrogs>
References: <20240319011102.2929635-1-yi.zhang@huaweicloud.com>
 <20240319011102.2929635-9-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319011102.2929635-9-yi.zhang@huaweicloud.com>

On Tue, Mar 19, 2024 at 09:11:01AM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> For now, we can make sure iomap_write_end() always return 0 or copied
> bytes, so instead of return written bytes, convert to return a boolean
> to indicate the copied bytes have been written to the pagecache.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c | 50 +++++++++++++++++++++++++++---------------
>  1 file changed, 32 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 291648c61a32..004673ea8bc1 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -790,7 +790,7 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
>  	return status;
>  }
>  
> -static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
> +static bool __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
>  		size_t copied, struct folio *folio)
>  {
>  	flush_dcache_folio(folio);
> @@ -807,14 +807,14 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
>  	 * redo the whole thing.
>  	 */
>  	if (unlikely(copied < len && !folio_test_uptodate(folio)))
> -		return 0;
> +		return false;
>  	iomap_set_range_uptodate(folio, offset_in_folio(folio, pos), len);
>  	iomap_set_range_dirty(folio, offset_in_folio(folio, pos), copied);
>  	filemap_dirty_folio(inode->i_mapping, folio);
> -	return copied;
> +	return true;
>  }
>  
> -static size_t iomap_write_end_inline(const struct iomap_iter *iter,
> +static void iomap_write_end_inline(const struct iomap_iter *iter,
>  		struct folio *folio, loff_t pos, size_t copied)
>  {
>  	const struct iomap *iomap = &iter->iomap;
> @@ -829,21 +829,32 @@ static size_t iomap_write_end_inline(const struct iomap_iter *iter,
>  	kunmap_local(addr);
>  
>  	mark_inode_dirty(iter->inode);
> -	return copied;
>  }
>  
> -/* Returns the number of bytes copied.  May be 0.  Cannot be an errno. */
> -static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
> +/*
> + * Returns true if all copied bytes have been written to the pagecache,
> + * otherwise return false.
> + */
> +static bool iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
>  		size_t copied, struct folio *folio)
>  {
>  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> +	bool ret = true;
>  
> -	if (srcmap->type == IOMAP_INLINE)
> -		return iomap_write_end_inline(iter, folio, pos, copied);
> -	if (srcmap->flags & IOMAP_F_BUFFER_HEAD)
> -		return block_write_end(NULL, iter->inode->i_mapping, pos, len,
> -				       copied, &folio->page, NULL);
> -	return __iomap_write_end(iter->inode, pos, len, copied, folio);
> +	if (srcmap->type == IOMAP_INLINE) {
> +		iomap_write_end_inline(iter, folio, pos, copied);
> +	} else if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
> +		size_t bh_written;
> +
> +		bh_written = block_write_end(NULL, iter->inode->i_mapping, pos,
> +					len, copied, &folio->page, NULL);
> +		WARN_ON_ONCE(bh_written != copied && bh_written != 0);
> +		ret = bh_written == copied;
> +	} else {
> +		ret = __iomap_write_end(iter->inode, pos, len, copied, folio);
> +	}
> +
> +	return ret;

This could be cleaned up even further:

	if (srcmap->type == IOMAP_INLINE) {
		iomap_write_end_inline(iter, folio, pos, copied);
		return true;
	}

	if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
		size_t bh_written;

		bh_written = block_write_end(NULL, iter->inode->i_mapping, pos,
					len, copied, &folio->page, NULL);
		WARN_ON_ONCE(bh_written != copied && bh_written != 0);
		return bh_written == copied;
	}

	return __iomap_write_end(iter->inode, pos, len, copied, folio);

>  }
>  
>  static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
> @@ -907,7 +918,8 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  			flush_dcache_folio(folio);
>  
>  		copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);
> -		written = iomap_write_end(iter, pos, bytes, copied, folio);
> +		written = iomap_write_end(iter, pos, bytes, copied, folio) ?
> +			  copied : 0;
>  
>  		/*
>  		 * Update the in-memory inode size after copying the data into
> @@ -1285,6 +1297,7 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
>  		int status;
>  		size_t offset;
>  		size_t bytes = min_t(u64, SIZE_MAX, length);
> +		bool ret;
>  
>  		status = iomap_write_begin(iter, pos, bytes, &folio);
>  		if (unlikely(status))
> @@ -1296,9 +1309,9 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
>  		if (bytes > folio_size(folio) - offset)
>  			bytes = folio_size(folio) - offset;
>  
> -		bytes = iomap_write_end(iter, pos, bytes, bytes, folio);
> +		ret = iomap_write_end(iter, pos, bytes, bytes, folio);
>  		__iomap_put_folio(iter, pos, bytes, folio);
> -		if (WARN_ON_ONCE(bytes == 0))
> +		if (WARN_ON_ONCE(!ret))

If you named this variable "write_end_ok" then the diagnostic output
from the WARN_ONs would say that.  That said, it also encodes the line
number so it's not a big deal to leave this as it is.

With at least the first cleanup applied,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

>  			return -EIO;
>  
>  		cond_resched();
> @@ -1347,6 +1360,7 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  		int status;
>  		size_t offset;
>  		size_t bytes = min_t(u64, SIZE_MAX, length);
> +		bool ret;
>  
>  		status = iomap_write_begin(iter, pos, bytes, &folio);
>  		if (status)
> @@ -1361,9 +1375,9 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  		folio_zero_range(folio, offset, bytes);
>  		folio_mark_accessed(folio);
>  
> -		bytes = iomap_write_end(iter, pos, bytes, bytes, folio);
> +		ret = iomap_write_end(iter, pos, bytes, bytes, folio);
>  		__iomap_put_folio(iter, pos, bytes, folio);
> -		if (WARN_ON_ONCE(bytes == 0))
> +		if (WARN_ON_ONCE(!ret))
>  			return -EIO;
>  
>  		pos += bytes;
> -- 
> 2.39.2
> 
> 

