Return-Path: <linux-fsdevel+bounces-57948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0566DB26ED8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 20:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E40FE173339
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 18:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDB2223DD0;
	Thu, 14 Aug 2025 18:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lc7rXhCH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27CE78F2B;
	Thu, 14 Aug 2025 18:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755196034; cv=none; b=r50LrM/AOjW2FXqVpjvem0SXaaH6DaCaBvNORohH0kqm+vIMQa2UK3CFupCyyXvIEH9TzYqxu8ueCtOCDSrxOcVwymHHJZZ4NWJa60AnTooTdt6icifYursICnmzNXbvFqKM1q1QgmP/3RfH8jJ9BcvG9SQuOyYq/gYLsavKygg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755196034; c=relaxed/simple;
	bh=vZ1bu875zZ0XVDWMeBVLT9Q9HrS/b42vDFcu/7DHKQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYaQX4cte5R4seu54dwL22312ZtYlZkPKmic2nd1XoFVS0MX2hHJude3HR1DaQ7orBALBDKGrkwnyocI5bCj2dqSLtgMVV96h+ClCKv/TQAVixUNzd7t/99PyZ3oEnnTQLg8HEmH+Km1qhoF0UkL9F4D6q9n2clZT7oE0p9DezA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lc7rXhCH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420D1C4CEED;
	Thu, 14 Aug 2025 18:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755196034;
	bh=vZ1bu875zZ0XVDWMeBVLT9Q9HrS/b42vDFcu/7DHKQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lc7rXhCHElrD0/MmjJ3JW9c2OPLbFnrqtMg/tGud04eOhGXhnPYTCxIQi1U+iWTe4
	 XLGCCWNMhHExMSO86xrDL6TFYQ3ebKgIQgZ7/sWCLf84SyrVSbdaXbCWqLA5x36J3O
	 oJ8ykaKMy7rzRtaDkT46k6aT80TB87/tknbzbKY/oWD1KQr5v/Mp62F5lB/38yjOAY
	 xhJ2k5OboWvMvApNZCwHcMIlLRKx1lwmrwdD6q90Sf5dTo8B1k/Dl8xndG7yX9VHtp
	 fjgpOfHTX+obM/xQnE4WrvIKQiyeTQ+olwoTEXYxoViBkd2UYj4KKIXjfrneo51P2G
	 wzyqh50pTNUFA==
Date: Thu, 14 Aug 2025 11:27:13 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, mcgrof@kernel.org,
	gost.dev@samsung.com, linux-xfs@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH] iomap: use largest_zero_folio() in iomap_dio_zero()
Message-ID: <20250814182713.GS7965@frogsfrogsfrogs>
References: <20250814142137.45469-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814142137.45469-1-kernel@pankajraghav.com>

On Thu, Aug 14, 2025 at 04:21:37PM +0200, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> iomap_dio_zero() uses a custom allocated memory of zeroes for padding
> zeroes. This was a temporary solution until there was a way to request a
> zero folio that was greater than the PAGE_SIZE.
> 
> Use largest_zero_folio() function instead of using the custom allocated
> memory of zeroes. There is no guarantee from largest_zero_folio()
> function that it will always return a PMD sized folio. Adapt the code so
> that it can also work if largest_zero_folio() returns a ZERO_PAGE.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

Seems fine to me, though I wonder if this oughn't go along with the
rest of the largest_zero_folio changes?

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/direct-io.c | 38 +++++++++++++++-----------------------
>  1 file changed, 15 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index b84f6af2eb4c..a7a281ea3e50 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -24,13 +24,6 @@
>  #define IOMAP_DIO_WRITE		(1U << 30)
>  #define IOMAP_DIO_DIRTY		(1U << 31)
>  
> -/*
> - * Used for sub block zeroing in iomap_dio_zero()
> - */
> -#define IOMAP_ZERO_PAGE_SIZE (SZ_64K)
> -#define IOMAP_ZERO_PAGE_ORDER (get_order(IOMAP_ZERO_PAGE_SIZE))
> -static struct page *zero_page;
> -
>  struct iomap_dio {
>  	struct kiocb		*iocb;
>  	const struct iomap_dio_ops *dops;
> @@ -285,24 +278,35 @@ static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
>  {
>  	struct inode *inode = file_inode(dio->iocb->ki_filp);
>  	struct bio *bio;
> +	struct folio *zero_folio = largest_zero_folio();
> +	int nr_vecs = max(1, i_blocksize(inode) / folio_size(zero_folio));
>  
>  	if (!len)
>  		return 0;
> +
>  	/*
> -	 * Max block size supported is 64k
> +	 * This limit shall never be reached as most filesystems have a
> +	 * maximum blocksize of 64k.
>  	 */
> -	if (WARN_ON_ONCE(len > IOMAP_ZERO_PAGE_SIZE))
> +	if (WARN_ON_ONCE(nr_vecs > BIO_MAX_VECS))
>  		return -EINVAL;
>  
> -	bio = iomap_dio_alloc_bio(iter, dio, 1, REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
> +	bio = iomap_dio_alloc_bio(iter, dio, nr_vecs,
> +				  REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
>  	fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
>  				  GFP_KERNEL);
>  	bio->bi_iter.bi_sector = iomap_sector(&iter->iomap, pos);
>  	bio->bi_private = dio;
>  	bio->bi_end_io = iomap_dio_bio_end_io;
>  
> -	__bio_add_page(bio, zero_page, len, 0);
> +	while (len > 0) {
> +		unsigned int io_len = min(len, folio_size(zero_folio));
> +
> +		bio_add_folio_nofail(bio, zero_folio, io_len, 0);
> +		len -= io_len;
> +	}
>  	iomap_dio_submit_bio(iter, dio, bio, pos);
> +
>  	return 0;
>  }
>  
> @@ -822,15 +826,3 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  	return iomap_dio_complete(dio);
>  }
>  EXPORT_SYMBOL_GPL(iomap_dio_rw);
> -
> -static int __init iomap_dio_init(void)
> -{
> -	zero_page = alloc_pages(GFP_KERNEL | __GFP_ZERO,
> -				IOMAP_ZERO_PAGE_ORDER);
> -
> -	if (!zero_page)
> -		return -ENOMEM;
> -
> -	return 0;
> -}
> -fs_initcall(iomap_dio_init);
> 
> base-commit: 931e46dcbc7e6035a90e9c4a27a84b660e083f0a
> -- 
> 2.50.1
> 
> 

