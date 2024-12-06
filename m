Return-Path: <linux-fsdevel+bounces-36661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE1E9E76DA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 18:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DF5E285BC3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 17:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D331F3D51;
	Fri,  6 Dec 2024 17:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKgt2+7P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4EB206296;
	Fri,  6 Dec 2024 17:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733505461; cv=none; b=Bsfd/oDwBi+hjogxueHP/LB5JsND4uQfmKJGcObL3xG4Z4KCf9wpceEaXgNYNnlv686gQrkc/nTyUhLXQV3nc8pQfkQD1Hmg1qKTA/85CfbOHHkmAXA0kmk6T0ZLRxxSBdiKyfFIBP0B9IBjEUNNi22gGvEHAEN+luNuQTBKtc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733505461; c=relaxed/simple;
	bh=AuFd9Gw9Dc3IjuRANbTBGi5vZ1aTaRD1b70Nt5M3/Gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KcI9Hu3bZ6GC12qVHzDr9yRT9zgm8BPNHatLhhckQcxgrCJY2A2GPTIF5vtOXi9vLcEU2aVxx2oKKDnsOVRTIubfjImrmmrwcNp1X7PqaVY7zKCQhZ/9BY6zt426Sd/9ktHZDlLNpVvp+pMIxXPo2N5aYnGZazJJwDu/AaqoNi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKgt2+7P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F30C4CEDC;
	Fri,  6 Dec 2024 17:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733505461;
	bh=AuFd9Gw9Dc3IjuRANbTBGi5vZ1aTaRD1b70Nt5M3/Gk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HKgt2+7PsmXp/c3SLX5DRDO4UKmcDueQlB6L8vcYDbkTVx6oxX6sdsOVjWa74rYUc
	 BhJQgqOH9plH5nYy/Hf3ZTUYhIjBtd2RRBIkfcuD/Sl5sefeL049ABTLUDiW/TeLG8
	 4ntM6J8akUAuppFLoFuLF+WlUgGXFhRU48p7jkskoPe4E4e7+NDZvzrgVVNgpwjSZL
	 0xXGRimCLcOT1cgnbyrj8jri90dMOmkry36F564cOGqUNmERGzswBng49Ut0xl0Tg8
	 mpgBsgKMYd4/U80vYNYbYFezO7D6yK+wrEBWrUVowxwA82RmE/r1bvGG6+aaATpQjo
	 +hVc9EFOIkXOQ==
Date: Fri, 6 Dec 2024 09:17:40 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
	clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org,
	kirill@shutemov.name, bfoster@redhat.com
Subject: Re: [PATCH 11/12] mm/filemap: make buffered writes work with
 RWF_UNCACHED
Message-ID: <20241206171740.GD7820@frogsfrogsfrogs>
References: <20241203153232.92224-2-axboe@kernel.dk>
 <20241203153232.92224-13-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203153232.92224-13-axboe@kernel.dk>

On Tue, Dec 03, 2024 at 08:31:47AM -0700, Jens Axboe wrote:
> If RWF_UNCACHED is set for a write, mark new folios being written with
> uncached. This is done by passing in the fact that it's an uncached write
> through the folio pointer. We can only get there when IOCB_UNCACHED was
> allowed, which can only happen if the file system opts in. Opting in means
> they need to check for the LSB in the folio pointer to know if it's an
> uncached write or not. If it is, then FGP_UNCACHED should be used if
> creating new folios is necessary.
> 
> Uncached writes will drop any folios they create upon writeback
> completion, but leave folios that may exist in that range alone. Since
> ->write_begin() doesn't currently take any flags, and to avoid needing
> to change the callback kernel wide, use the foliop being passed in to
> ->write_begin() to signal if this is an uncached write or not. File
> systems can then use that to mark newly created folios as uncached.
> 
> This provides similar benefits to using RWF_UNCACHED with reads. Testing
> buffered writes on 32 files:
> 
> writing bs 65536, uncached 0
>   1s: 196035MB/sec
>   2s: 132308MB/sec
>   3s: 132438MB/sec
>   4s: 116528MB/sec
>   5s: 103898MB/sec
>   6s: 108893MB/sec
>   7s: 99678MB/sec
>   8s: 106545MB/sec
>   9s: 106826MB/sec
>  10s: 101544MB/sec
>  11s: 111044MB/sec
>  12s: 124257MB/sec
>  13s: 116031MB/sec
>  14s: 114540MB/sec
>  15s: 115011MB/sec
>  16s: 115260MB/sec
>  17s: 116068MB/sec
>  18s: 116096MB/sec
> 
> where it's quite obvious where the page cache filled, and performance
> dropped from to about half of where it started, settling in at around
> 115GB/sec. Meanwhile, 32 kswapds were running full steam trying to
> reclaim pages.
> 
> Running the same test with uncached buffered writes:
> 
> writing bs 65536, uncached 1
>   1s: 198974MB/sec
>   2s: 189618MB/sec
>   3s: 193601MB/sec
>   4s: 188582MB/sec
>   5s: 193487MB/sec
>   6s: 188341MB/sec
>   7s: 194325MB/sec
>   8s: 188114MB/sec
>   9s: 192740MB/sec
>  10s: 189206MB/sec
>  11s: 193442MB/sec
>  12s: 189659MB/sec
>  13s: 191732MB/sec
>  14s: 190701MB/sec
>  15s: 191789MB/sec
>  16s: 191259MB/sec
>  17s: 190613MB/sec
>  18s: 191951MB/sec
> 
> and the behavior is fully predictable, performing the same throughout
> even after the page cache would otherwise have fully filled with dirty
> data. It's also about 65% faster, and using half the CPU of the system
> compared to the normal buffered write.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  include/linux/fs.h      |  5 +++++
>  include/linux/pagemap.h |  9 +++++++++
>  mm/filemap.c            | 12 +++++++++++-
>  3 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 40383f5cc6a2..32255473f79d 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2912,6 +2912,11 @@ static inline ssize_t generic_write_sync(struct kiocb *iocb, ssize_t count)
>  				(iocb->ki_flags & IOCB_SYNC) ? 0 : 1);
>  		if (ret)
>  			return ret;
> +	} else if (iocb->ki_flags & IOCB_UNCACHED) {
> +		struct address_space *mapping = iocb->ki_filp->f_mapping;
> +
> +		filemap_fdatawrite_range_kick(mapping, iocb->ki_pos,
> +					      iocb->ki_pos + count);
>  	}
>  
>  	return count;
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index f2d49dccb7c1..e49587c40157 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -14,6 +14,7 @@
>  #include <linux/gfp.h>
>  #include <linux/bitops.h>
>  #include <linux/hardirq.h> /* for in_interrupt() */
> +#include <linux/writeback.h>
>  #include <linux/hugetlb_inline.h>
>  
>  struct folio_batch;
> @@ -70,6 +71,14 @@ static inline int filemap_write_and_wait(struct address_space *mapping)
>  	return filemap_write_and_wait_range(mapping, 0, LLONG_MAX);
>  }
>  
> +/*
> + * Value passed in to ->write_begin() if IOCB_UNCACHED is set for the write,
> + * and the ->write_begin() handler on a file system supporting FOP_UNCACHED
> + * must check for this and pass FGP_UNCACHED for folio creation.
> + */
> +#define foliop_uncached			((struct folio *) 0xfee1c001)
> +#define foliop_is_uncached(foliop)	(*(foliop) == foliop_uncached)

Honestly, I'm not a fan of foliop_uncached or foliop_is_uncached.

The first one because it's a magic value and can you guarantee that
0xfee1c001 will never be a pointer to an actual struct folio, even on
32-bit?

Second, they're both named "foliop" even though the first one doesn't
return a (struct folio **) but the second one takes that as an arg.

I think these two macros are only used for ext4 (or really, !iomap)
support, right?  And that's only to avoid messing with ->write_begin?
What if you dropped ext4 support instead? :D

--D

>  /**
>   * filemap_set_wb_err - set a writeback error on an address_space
>   * @mapping: mapping in which to set writeback error
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 826df99e294f..00f3c6c58629 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -4095,7 +4095,7 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
>  	ssize_t written = 0;
>  
>  	do {
> -		struct folio *folio;
> +		struct folio *folio = NULL;
>  		size_t offset;		/* Offset into folio */
>  		size_t bytes;		/* Bytes to write to folio */
>  		size_t copied;		/* Bytes copied from user */
> @@ -4123,6 +4123,16 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
>  			break;
>  		}
>  
> +		/*
> +		 * If IOCB_UNCACHED is set here, we now the file system
> +		 * supports it. And hence it'll know to check folip for being
> +		 * set to this magic value. If so, it's an uncached write.
> +		 * Whenever ->write_begin() changes prototypes again, this
> +		 * can go away and just pass iocb or iocb flags.
> +		 */
> +		if (iocb->ki_flags & IOCB_UNCACHED)
> +			folio = foliop_uncached;
> +
>  		status = a_ops->write_begin(file, mapping, pos, bytes,
>  						&folio, &fsdata);
>  		if (unlikely(status < 0))
> -- 
> 2.45.2
> 
> 

