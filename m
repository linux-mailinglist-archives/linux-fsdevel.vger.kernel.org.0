Return-Path: <linux-fsdevel+bounces-14836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6E288067E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 22:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59F50283BED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 21:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB3C57880;
	Tue, 19 Mar 2024 21:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JILVZYVC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21BA4F887;
	Tue, 19 Mar 2024 21:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710882253; cv=none; b=esAwAKSb0kYdHaXBULRtkHyoMUUv8Z9KS/IpYCovFv9zSJ4lRQBDm2X9DWukD8q7dghjZSyFy8Oii6jHYEM8QpWmsrZdvv/v3hTRR23IjSDpm39d1oKZKW8UkEUkX+aXmGzgIFgrg3iM2v6COj5mM31qVb7qmdnmPnveiZl0ih8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710882253; c=relaxed/simple;
	bh=JuJs5mTOcQXm8/vrla5Htlxql1DF6ftkq5/q432yuQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXye5/WuCzI7pvxqAWu8NTJzeYPQpVkFJdhE0AEFhVoY8rnWTjGG55vugUmfhvjXqhehvdehkO4rnmYEQLylGkgiVjQYwC1TV+XfN2qU9CfJ2wKGANVyKziuWNPfYjdEAfSpKJbvXsK3TmeLphXrsBUaH9V3U0a0Pz3DpP4SYt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JILVZYVC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E7FC43390;
	Tue, 19 Mar 2024 21:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710882252;
	bh=JuJs5mTOcQXm8/vrla5Htlxql1DF6ftkq5/q432yuQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JILVZYVCkUIvKv3+UHkZjJxHfwaoU2NtuIvA3MUYvTFKblPYqmETvLftP+COMlIS1
	 LsAgiGL1vtK4mTgDu6mbV8psB/F1jDoFE6/VB/oVT1a+S5cmQ3AIpJmgxhXPE5Xk5B
	 CoFfSKS59HBAhR7Js9fjRASwph3gbFZHCdM0FnMYZb7SD6n/MQ7aAiq8N7FzcT+X9x
	 hwZbuQja2x2satDjR52D/UAmNaEF9J+bScYNtMRsbyaYRtkH5MyTl1G1yXPuht03Ar
	 fJ6mlhGVHG2GVSeWOLT3DwIkRSh7H1Q85emQr16uW9Jt8ww/ejg8wFmZd4Fqe9ZabH
	 Ldh/Sq0s/4eIA==
Date: Tue, 19 Mar 2024 14:04:12 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, hch@infradead.org, brauner@kernel.org,
	david@fromorbit.com, tytso@mit.edu, jack@suse.cz,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v3 6/9] iomap: don't increase i_size if it's not a write
 operation
Message-ID: <20240319210412.GK1927156@frogsfrogsfrogs>
References: <20240319011102.2929635-1-yi.zhang@huaweicloud.com>
 <20240319011102.2929635-7-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319011102.2929635-7-yi.zhang@huaweicloud.com>

On Tue, Mar 19, 2024 at 09:10:59AM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Increase i_size in iomap_zero_range() and iomap_unshare_iter() is not
> needed, the caller should handle it. Especially, when truncate partial
> block, we should not increase i_size beyond the new EOF here. It doesn't
> affect xfs and gfs2 now because they set the new file size after zero
> out, it doesn't matter that a transient increase in i_size, but it will
> affect ext4 because it set file size before truncate. So move the i_size
> updating logic to iomap_write_iter().
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks for applying the comment update,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 50 +++++++++++++++++++++---------------------
>  1 file changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 7e32a204650b..e9112dc78d15 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -837,32 +837,13 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
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
> -
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
>  
> -	if (old_size < pos)
> -		pagecache_isize_extended(iter->inode, old_size, pos);
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
> @@ -877,6 +858,7 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  
>  	do {
>  		struct folio *folio;
> +		loff_t old_size;
>  		size_t offset;		/* Offset into folio */
>  		size_t bytes;		/* Bytes to write to folio */
>  		size_t copied;		/* Bytes copied from user */
> @@ -926,6 +908,22 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  		copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);
>  		status = iomap_write_end(iter, pos, bytes, copied, folio);
>  
> +		/*
> +		 * Update the in-memory inode size after copying the data into
> +		 * the page cache.  It's up to the file system to write the
> +		 * updated size to disk, preferably after I/O completion so that
> +		 * no stale data is exposed.  Only once that's done can we
> +		 * unlock and release the folio.
> +		 */
> +		old_size = iter->inode->i_size;
> +		if (pos + status > old_size) {
> +			i_size_write(iter->inode, pos + status);
> +			iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
> +		}
> +		__iomap_put_folio(iter, pos, status, folio);
> +
> +		if (old_size < pos)
> +			pagecache_isize_extended(iter->inode, old_size, pos);
>  		if (status < bytes)
>  			iomap_write_failed(iter->inode, pos + status,
>  					   bytes - status);
> @@ -1298,6 +1296,7 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
>  			bytes = folio_size(folio) - offset;
>  
>  		bytes = iomap_write_end(iter, pos, bytes, bytes, folio);
> +		__iomap_put_folio(iter, pos, bytes, folio);
>  		if (WARN_ON_ONCE(bytes == 0))
>  			return -EIO;
>  
> @@ -1362,6 +1361,7 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
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

