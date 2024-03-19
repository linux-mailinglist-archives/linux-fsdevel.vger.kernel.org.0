Return-Path: <linux-fsdevel+bounces-14837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0E1880681
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 22:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F29E11F23107
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 21:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A361A3D3B9;
	Tue, 19 Mar 2024 21:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHWo2JRh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058142B9D3;
	Tue, 19 Mar 2024 21:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710882302; cv=none; b=Ut/tJdlySVcVNNFn7Fe4Gk9AqZaRJ/c+JrLKuLbHNqVzeZfCxN5AouleGP1P8hW4JW+j1S6dZgP9ATY1rIHumYlFy/QlYwHaVY//GOj41dGxQQDXza/13kqieYbwDcEFVTcAJzT5lVj2tJYaAqAfSNR/nrusDBavXm9un+X/990=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710882302; c=relaxed/simple;
	bh=YmZGbVxoRW7YnePQKU5vsbz57//dRcnqGNgy8+/fRcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKz7ASf/AT38+QnDlM2UP9Ka9GwHVI2XFEnr3vHrGJvDfIJd5h67iuoGpE9hj5DNuArQPsiIbtwfiBcptWPozFtLyaPLaVrn+7pRX3u/wI2yY8BxVRfoURg3midOa3OXAco7PPixJi6+uQfzxJiX61AMM2eAJLMbKfBIUZXVl28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHWo2JRh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86706C433C7;
	Tue, 19 Mar 2024 21:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710882301;
	bh=YmZGbVxoRW7YnePQKU5vsbz57//dRcnqGNgy8+/fRcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CHWo2JRhDHujPTlYvoxmw07C9p9v9Sku5GC9j0j7zQUaY3aCgoT0nXs4/Nmp7K39K
	 xbCyhfGtXJt2BNPh47hhuH864j0+qM1p9pKce0n11xdgI1MX1iH79R/xBuIfa8xiLn
	 PBRD+ANLDorKzNh0Hslx84biVT/ewCxZt2pTFqTTjGvAOg+kaAXg9Hf4DEDRAwi2VH
	 1xOY1eAQBgFCEune673i8/Ji3e4lpor+0HylmPI8S5eqKeKsdqtw6K7Ms7JFKnHMgX
	 NA8eSYuSd4GgHRH3R1PDNw/q+YCqAdp+OGDQRB1NnKu6JSp4GI9UO/h72R8cq4rJhu
	 H9xft/X16q0qA==
Date: Tue, 19 Mar 2024 14:05:01 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, hch@infradead.org, brauner@kernel.org,
	david@fromorbit.com, tytso@mit.edu, jack@suse.cz,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v3 7/9] iomap: use a new variable to handle the written
 bytes in iomap_write_iter()
Message-ID: <20240319210501.GL1927156@frogsfrogsfrogs>
References: <20240319011102.2929635-1-yi.zhang@huaweicloud.com>
 <20240319011102.2929635-8-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319011102.2929635-8-yi.zhang@huaweicloud.com>

On Tue, Mar 19, 2024 at 09:11:00AM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> In iomap_write_iter(), the status variable used to receive the return
> value from iomap_write_end() is confusing, replace it with a new written
> variable to represent the written bytes in each cycle, no logic changes.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Looks good,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index e9112dc78d15..291648c61a32 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -851,7 +851,7 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  	loff_t length = iomap_length(iter);
>  	size_t chunk = PAGE_SIZE << MAX_PAGECACHE_ORDER;
>  	loff_t pos = iter->pos;
> -	ssize_t written = 0;
> +	ssize_t total_written = 0;
>  	long status = 0;
>  	struct address_space *mapping = iter->inode->i_mapping;
>  	unsigned int bdp_flags = (iter->flags & IOMAP_NOWAIT) ? BDP_ASYNC : 0;
> @@ -862,6 +862,7 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  		size_t offset;		/* Offset into folio */
>  		size_t bytes;		/* Bytes to write to folio */
>  		size_t copied;		/* Bytes copied from user */
> +		size_t written;		/* Bytes have been written */
>  
>  		bytes = iov_iter_count(i);
>  retry:
> @@ -906,7 +907,7 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  			flush_dcache_folio(folio);
>  
>  		copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);
> -		status = iomap_write_end(iter, pos, bytes, copied, folio);
> +		written = iomap_write_end(iter, pos, bytes, copied, folio);
>  
>  		/*
>  		 * Update the in-memory inode size after copying the data into
> @@ -916,22 +917,22 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  		 * unlock and release the folio.
>  		 */
>  		old_size = iter->inode->i_size;
> -		if (pos + status > old_size) {
> -			i_size_write(iter->inode, pos + status);
> +		if (pos + written > old_size) {
> +			i_size_write(iter->inode, pos + written);
>  			iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
>  		}
> -		__iomap_put_folio(iter, pos, status, folio);
> +		__iomap_put_folio(iter, pos, written, folio);
>  
>  		if (old_size < pos)
>  			pagecache_isize_extended(iter->inode, old_size, pos);
> -		if (status < bytes)
> -			iomap_write_failed(iter->inode, pos + status,
> -					   bytes - status);
> -		if (unlikely(copied != status))
> -			iov_iter_revert(i, copied - status);
> +		if (written < bytes)
> +			iomap_write_failed(iter->inode, pos + written,
> +					   bytes - written);
> +		if (unlikely(copied != written))
> +			iov_iter_revert(i, copied - written);
>  
>  		cond_resched();
> -		if (unlikely(status == 0)) {
> +		if (unlikely(written == 0)) {
>  			/*
>  			 * A short copy made iomap_write_end() reject the
>  			 * thing entirely.  Might be memory poisoning
> @@ -945,17 +946,17 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  				goto retry;
>  			}
>  		} else {
> -			pos += status;
> -			written += status;
> -			length -= status;
> +			pos += written;
> +			total_written += written;
> +			length -= written;
>  		}
>  	} while (iov_iter_count(i) && length);
>  
>  	if (status == -EAGAIN) {
> -		iov_iter_revert(i, written);
> +		iov_iter_revert(i, total_written);
>  		return -EAGAIN;
>  	}
> -	return written ? written : status;
> +	return total_written ? total_written : status;
>  }
>  
>  ssize_t
> -- 
> 2.39.2
> 
> 

