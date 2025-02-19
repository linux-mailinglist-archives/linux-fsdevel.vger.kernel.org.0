Return-Path: <linux-fsdevel+bounces-42132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66805A3CC6A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 23:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0323918936F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 22:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5A325A2C3;
	Wed, 19 Feb 2025 22:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHxzDfVb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2549F1CAA65;
	Wed, 19 Feb 2025 22:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740004456; cv=none; b=KSkXlrJVFVixOLxaypDjIvvFIAvemhNDjymmzeiqZ/o2rsS4gXWd45ngbOHH1RaojfB9h/6wWyCHdYGGwHVB4NPELtII2/99NcxKLZjf9EnrBtsg3N/fHpyko/ys4vXpRMBikuan+9R1OHEyxinNPQWB6eV192KscY1LLR6PHRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740004456; c=relaxed/simple;
	bh=P9AKx0dQ7j+z8OHm5Bm84AjKvXgfBdLDYl1PkL54KrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bbuht/ev+DhIZ/prSZvlWQ2eXX9mdQWvrTfwCGfZkzEjvZ7a3l86M4cwfRKUOFp2iYu5DryqaL+AFbeVw9Xf6JVJKkzGV4oLAiIlqMUWFJ6EYADp4V5IYZeg6fefzgJSmI0ASQDQe7r7s0wUZKMP0X0Ii6TRbarTx1+70qspSk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHxzDfVb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F187EC4CED1;
	Wed, 19 Feb 2025 22:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740004456;
	bh=P9AKx0dQ7j+z8OHm5Bm84AjKvXgfBdLDYl1PkL54KrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KHxzDfVbbbX3MrTdB1/Q87S+8WAEsByzCNW8BtaKInD38nKcx7NVWMpVv+0pDehRY
	 p3IvGc9f+UNf9ahYejMKZAsTZ9va6ek0qDM18zkoaatiK8vaLYw2rFd/Sg4o4Pvt4o
	 6247Ca4arZgpzEN689svYI2XyeaFvSfU4LsK8BjJ2Z9uKR0T7SbtfMxdcJNT2/SwPs
	 pXA4RxjdZ7CjYbVTzGi590nN2eq2F3Dy9+1efYmHpTKXzDcvCJ66M7rAdvxRM/actE
	 GiM8J57DYwD833hn/GydbN/DBDxoiAmxrA7YDlPjnM9tgS8Rt1aZnQez8owWxBQSMm
	 K7VmnMYGUoVMw==
Date: Wed, 19 Feb 2025 14:34:15 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 05/12] dax: push advance down into dax_iomap_iter()
 for read and write
Message-ID: <20250219223415.GK21808@frogsfrogsfrogs>
References: <20250219175050.83986-1-bfoster@redhat.com>
 <20250219175050.83986-6-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219175050.83986-6-bfoster@redhat.com>

On Wed, Feb 19, 2025 at 12:50:43PM -0500, Brian Foster wrote:
> DAX read and write currently advances the iter after the
> dax_iomap_iter() returns the number of bytes processed rather than
> internally within the iter handler itself, as most other iomap
> operations do. Push the advance down into dax_iomap_iter() and
> update the function to return op status instead of bytes processed.
> 
> dax_iomap_iter() shortcuts reads from a hole or unwritten mapping by
> directly zeroing the iov_iter, so advance the iomap_iter similarly
> in that case.
> 
> The DAX processing loop can operate on a range slightly different
> than defined by the iomap_iter depending on circumstances. For
> example, a read may be truncated by inode size, a read or write
> range can be increased due to page alignment, etc. Therefore, this
> patch aims to retain as much of the existing logic as possible.
> 
> The loop control logic remains pos based, but is sampled from the
> iomap_iter on each iteration after the advance instead of being
> updated manually. Similarly, length is updated based on the output
> of the advance instead of being updated manually. The advance itself
> is based on the number of bytes transferred, which was previously
> used to update the local copies of pos and length.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>

Looks good,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/dax.c | 27 +++++++++++----------------
>  1 file changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 296f5aa18640..139e299e53e6 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1431,8 +1431,7 @@ int dax_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
>  }
>  EXPORT_SYMBOL_GPL(dax_truncate_page);
>  
> -static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
> -		struct iov_iter *iter)
> +static int dax_iomap_iter(struct iomap_iter *iomi, struct iov_iter *iter)
>  {
>  	const struct iomap *iomap = &iomi->iomap;
>  	const struct iomap *srcmap = iomap_iter_srcmap(iomi);
> @@ -1451,8 +1450,10 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
>  		if (pos >= end)
>  			return 0;
>  
> -		if (iomap->type == IOMAP_HOLE || iomap->type == IOMAP_UNWRITTEN)
> -			return iov_iter_zero(min(length, end - pos), iter);
> +		if (iomap->type == IOMAP_HOLE || iomap->type == IOMAP_UNWRITTEN) {
> +			done = iov_iter_zero(min(length, end - pos), iter);
> +			return iomap_iter_advance(iomi, &done);
> +		}
>  	}
>  
>  	/*
> @@ -1485,7 +1486,7 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
>  	}
>  
>  	id = dax_read_lock();
> -	while (pos < end) {
> +	while ((pos = iomi->pos) < end) {
>  		unsigned offset = pos & (PAGE_SIZE - 1);
>  		const size_t size = ALIGN(length + offset, PAGE_SIZE);
>  		pgoff_t pgoff = dax_iomap_pgoff(iomap, pos);
> @@ -1535,18 +1536,16 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
>  			xfer = dax_copy_to_iter(dax_dev, pgoff, kaddr,
>  					map_len, iter);
>  
> -		pos += xfer;
> -		length -= xfer;
> -		done += xfer;
> -
> -		if (xfer == 0)
> +		length = xfer;
> +		ret = iomap_iter_advance(iomi, &length);
> +		if (!ret && xfer == 0)
>  			ret = -EFAULT;
>  		if (xfer < map_len)
>  			break;
>  	}
>  	dax_read_unlock(id);
>  
> -	return done ? done : ret;
> +	return ret;
>  }
>  
>  /**
> @@ -1585,12 +1584,8 @@ dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	if (iocb->ki_flags & IOCB_NOWAIT)
>  		iomi.flags |= IOMAP_NOWAIT;
>  
> -	while ((ret = iomap_iter(&iomi, ops)) > 0) {
> +	while ((ret = iomap_iter(&iomi, ops)) > 0)
>  		iomi.processed = dax_iomap_iter(&iomi, iter);
> -		if (iomi.processed > 0)
> -			iomi.processed = iomap_iter_advance(&iomi,
> -							    &iomi.processed);
> -	}
>  
>  	done = iomi.pos - iocb->ki_pos;
>  	iocb->ki_pos = iomi.pos;
> -- 
> 2.48.1
> 
> 

