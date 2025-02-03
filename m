Return-Path: <linux-fsdevel+bounces-40679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8550FA2668A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 23:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18F9F16599F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 22:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9C5210187;
	Mon,  3 Feb 2025 22:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZqPGyk3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC1C1D5CD4;
	Mon,  3 Feb 2025 22:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738621444; cv=none; b=K2y9sd+1c5BtCsor1T9myWPFLAgHoUQoWhzmZsfHxCDRZZPhtokQc+zsLk2knVhRmQxVrV7CU4XiiVdiLtgd33yLLWIQCGBYH46KcRuBGxR47e4C8HqweklTThq7gsv7XPPMF3JXgiCLHACIlHqodoy1pD0vS4KwwEoJC7/mn0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738621444; c=relaxed/simple;
	bh=rCjWPNB05DV0xd5MlwqQGxqqfurR4768Ko5+/xGn9Pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mc1E6BmXa6A+lJdtRBiN/+l2NbSORMXu95rJNFE2AdlBOj+DaPznkLlNbifeEOsN4OtMasnRZFfb7w2Eku44O7X+i9SGOO8GleoXmpKVZC1TGQcQDy8LJqZTcwOokbHsE7DzpZ2b4wmU+c9+cHqqRUv7T2JZdaHMJHPpWX32fXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZqPGyk3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F69C4CED2;
	Mon,  3 Feb 2025 22:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738621444;
	bh=rCjWPNB05DV0xd5MlwqQGxqqfurR4768Ko5+/xGn9Pw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UZqPGyk3iqlUz0v3r1Lny0TwNufY5ERxMFMOpZg6lkV4SBIZlcpDhh7OupZmHyo6P
	 bYvz9Bxpy8Mtr4HdK05tTgkJF5OOfiLdFnAxKXgEeARP+xaoVQYiLiiYh2maAgEKGY
	 wo2F9thM72jkmJzSCVoELlfIKZB/BDEdyFx/hEUfsZeGDATnKKg2+a/8sdYPjH1Oq6
	 0+kZX6esz0DJRbHwrzHEbjo4e+72UholC0QaI4Z1558MjWMGfePwEw3IP3kCxEojN6
	 VjCoST3p8L5Tl60tNLAljRE0aINMr3ytE3k0XiusIMW59k88PRUD+oBCifL6Ki1573
	 MFBfI5jLmOPBg==
Date: Mon, 3 Feb 2025 14:24:03 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	Qu Wenruo <wqu@suse.com>, Goldwyn Rodrigues <rgoldwyn@suse.com>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 4/7] iomap: support ioends for reads
Message-ID: <20250203222403.GF134507@frogsfrogsfrogs>
References: <20250203094322.1809766-1-hch@lst.de>
 <20250203094322.1809766-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203094322.1809766-5-hch@lst.de>

On Mon, Feb 03, 2025 at 10:43:08AM +0100, Christoph Hellwig wrote:
> Support using the ioend structure to defer I/O completion for
> reads in addition to writes.  This requires a check for the operation
> to not merge reads and writes, and for buffere I/O a call into the

                                         buffered

> buffered read I/O completion handler from iomap_finish_ioend.  For
> direct I/O the existing call into the direct I/O completion handler
> handles reads just fine already.

Otherwise everything looks ok to me.

--D

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c | 23 ++++++++++++++++++-----
>  fs/iomap/internal.h    |  3 ++-
>  fs/iomap/ioend.c       |  6 +++++-
>  3 files changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index eaffa23eb8e4..06990e012884 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -306,14 +306,27 @@ static void iomap_finish_folio_read(struct folio *folio, size_t off,
>  		folio_end_read(folio, uptodate);
>  }
>  
> -static void iomap_read_end_io(struct bio *bio)
> +static u32 __iomap_read_end_io(struct bio *bio, int error)
>  {
> -	int error = blk_status_to_errno(bio->bi_status);
>  	struct folio_iter fi;
> +	u32 folio_count = 0;
>  
> -	bio_for_each_folio_all(fi, bio)
> +	bio_for_each_folio_all(fi, bio) {
>  		iomap_finish_folio_read(fi.folio, fi.offset, fi.length, error);
> +		folio_count++;
> +	}
>  	bio_put(bio);
> +	return folio_count;
> +}
> +
> +static void iomap_read_end_io(struct bio *bio)
> +{
> +	__iomap_read_end_io(bio, blk_status_to_errno(bio->bi_status));
> +}
> +
> +u32 iomap_finish_ioend_buffered_read(struct iomap_ioend *ioend)
> +{
> +	return __iomap_read_end_io(&ioend->io_bio, ioend->io_error);
>  }
>  
>  struct iomap_readpage_ctx {
> @@ -1568,7 +1581,7 @@ static void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
>   * state, release holds on bios, and finally free up memory.  Do not use the
>   * ioend after this.
>   */
> -u32 iomap_finish_ioend_buffered(struct iomap_ioend *ioend)
> +u32 iomap_finish_ioend_buffered_write(struct iomap_ioend *ioend)
>  {
>  	struct inode *inode = ioend->io_inode;
>  	struct bio *bio = &ioend->io_bio;
> @@ -1600,7 +1613,7 @@ static void iomap_writepage_end_bio(struct bio *bio)
>  	struct iomap_ioend *ioend = iomap_ioend_from_bio(bio);
>  
>  	ioend->io_error = blk_status_to_errno(bio->bi_status);
> -	iomap_finish_ioend_buffered(ioend);
> +	iomap_finish_ioend_buffered_write(ioend);
>  }
>  
>  /*
> diff --git a/fs/iomap/internal.h b/fs/iomap/internal.h
> index f6992a3bf66a..c824e74a3526 100644
> --- a/fs/iomap/internal.h
> +++ b/fs/iomap/internal.h
> @@ -4,7 +4,8 @@
>  
>  #define IOEND_BATCH_SIZE	4096
>  
> -u32 iomap_finish_ioend_buffered(struct iomap_ioend *ioend);
> +u32 iomap_finish_ioend_buffered_read(struct iomap_ioend *ioend);
> +u32 iomap_finish_ioend_buffered_write(struct iomap_ioend *ioend);
>  u32 iomap_finish_ioend_direct(struct iomap_ioend *ioend);
>  
>  #endif /* _IOMAP_INTERNAL_H */
> diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
> index 18894ebba6db..2dd29403dc10 100644
> --- a/fs/iomap/ioend.c
> +++ b/fs/iomap/ioend.c
> @@ -44,7 +44,9 @@ static u32 iomap_finish_ioend(struct iomap_ioend *ioend, int error)
>  		return 0;
>  	if (ioend->io_flags & IOMAP_IOEND_DIRECT)
>  		return iomap_finish_ioend_direct(ioend);
> -	return iomap_finish_ioend_buffered(ioend);
> +	if (bio_op(&ioend->io_bio) == REQ_OP_READ)
> +		return iomap_finish_ioend_buffered_read(ioend);
> +	return iomap_finish_ioend_buffered_write(ioend);
>  }
>  
>  /*
> @@ -83,6 +85,8 @@ EXPORT_SYMBOL_GPL(iomap_finish_ioends);
>  static bool iomap_ioend_can_merge(struct iomap_ioend *ioend,
>  		struct iomap_ioend *next)
>  {
> +	if (bio_op(&ioend->io_bio) != bio_op(&next->io_bio))
> +		return false;
>  	if (ioend->io_bio.bi_status != next->io_bio.bi_status)
>  		return false;
>  	if (next->io_flags & IOMAP_IOEND_BOUNDARY)
> -- 
> 2.45.2
> 
> 

