Return-Path: <linux-fsdevel+bounces-14141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D90287849D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 17:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F3511C2124E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 16:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B2247F7F;
	Mon, 11 Mar 2024 16:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDrEiu+m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8497A4436C;
	Mon, 11 Mar 2024 16:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173260; cv=none; b=sK8/tedH1iBL9bKmzLq+JGGL973hXFsX8uV7O0EvbCtDWeDFRwl6Bkm/QV0EO46G7KhZw/vcixp6XY+SAVwAdXuybyjdnQUfjz9bA4mkZ9TdE5RtIKua4M3F1wZTjcVl/T2hnyG7Ccwyz7BtMq/e528Ddi5DNzxaUluFhWIDn4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173260; c=relaxed/simple;
	bh=Z3VLtbgSadjSI/x6kUu32ZF43oQcfZ5oMFjrp5In00U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDhvJKTJaClowQ+wvVWSAoog83RY6mfgeXkpDaXzw0+MS+XrTbpowy1SH0MVqa9Mv4kfxLkUl47v8ZojyDR0SekOH61x2tofO/dysejxABVQC/TvDd/2IJWS4dqiHmOicBMH2qNMeLqOQNQNCdVanFxBkdnp8xuJd6Y2o9cIMcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDrEiu+m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01203C433F1;
	Mon, 11 Mar 2024 16:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710173260;
	bh=Z3VLtbgSadjSI/x6kUu32ZF43oQcfZ5oMFjrp5In00U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YDrEiu+mrr/IeG+VuLb+GqeyONl++YsowQWctcdNqdrvnXZ6zxWSW+58mkrmFPXnA
	 i8inmXsx+nlB9za6NxgaQRzMwVKQwyJRN381/3QiYzl5917n8yeW6AGUJGdM5O0LBm
	 IHdssvWlau3Ses9J/gHshDr7r98Id5aGzswxUbFeLi5GgFWzUEz6jIuceNoPSLrnRA
	 B4JD653vipyxVlrUYKByJbzu6lsdlLcCVTnH9i0SheyqbWxj4pAjtd3QkAswWhZWDk
	 C7/vFPJwPrrIt/mPv5I+/vp9+QFw567EbZ8qnv3R7WbhlhmxfTH/NT0RjiCPmqo80P
	 9f7nDvTOgO3vQ==
Date: Mon, 11 Mar 2024 09:07:39 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, hch@infradead.org, brauner@kernel.org,
	david@fromorbit.com, tytso@mit.edu, jack@suse.cz,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 4/4] iomap: cleanup iomap_write_iter()
Message-ID: <20240311160739.GV1927156@frogsfrogsfrogs>
References: <20240311122255.2637311-1-yi.zhang@huaweicloud.com>
 <20240311122255.2637311-5-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311122255.2637311-5-yi.zhang@huaweicloud.com>

On Mon, Mar 11, 2024 at 08:22:55PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> The status variable in iomap_write_iter() is confusing and
> iomap_write_end() always return 0 or copied bytes, so replace it with a
> new written variable to represent the written bytes in each cycle, and
> also do some cleanup, no logic changes.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  fs/iomap/buffered-io.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 19f91324c690..767af6e67ed4 100644
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
> @@ -915,28 +916,26 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  		 * no stale data is exposed.
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

I wish you'd made the variable renaming and the function reorganization
separate patches.  The renaming looks correct to me, but moving these
calls adds a logic bomb.

If at some point iomap_write_end actually starts returning partial write
completions (e.g. you wrote 250 bytes, but for some reason the pagecache
only acknowledges 100 bytes were written) then this code no longer
reverts the iter or truncates posteof pagecache correctly...

>  
>  		cond_resched();
> -		if (unlikely(status == 0)) {
> +		if (unlikely(written == 0)) {
>  			/*
>  			 * A short copy made iomap_write_end() reject the
>  			 * thing entirely.  Might be memory poisoning
>  			 * halfway through, might be a race with munmap,
>  			 * might be severe memory pressure.
>  			 */
> +			iomap_write_failed(iter->inode, pos, bytes);
> +			iov_iter_revert(i, copied);

...because now we only do that if the pagecache refuses to acknowledge
any bytes written at all.  I think it actually works correctly with
today's kernel since __iomap_write_end only returns copied or 0, but the
size_t return type implies that a short acknowledgement is theoretically
possible.

IOWs, doesn't this adds a logic bomb?

--D

> +
>  			if (chunk > PAGE_SIZE)
>  				chunk /= 2;
>  			if (copied) {
> @@ -944,17 +943,17 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
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

