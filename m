Return-Path: <linux-fsdevel+bounces-40675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB000A26678
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 23:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77BA318857DD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 22:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B367E210F58;
	Mon,  3 Feb 2025 22:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lL6OEyBl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC091F92A;
	Mon,  3 Feb 2025 22:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738621232; cv=none; b=COZe6QUaY7IwOQwwqwRerqOWw+fmOhumU7WUkHuEAKsbgZnBioEmTNhd4X0YZkoUKZNRn6FwbJInR7nnM6RRQRyFdXaz1Tei3IYN7HyZuVzekVqLav5NlJDEJLFoGtIy7Y87sV94gH61uOUa9wquYnHmRTkpozvH/BIV1ahepjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738621232; c=relaxed/simple;
	bh=HjtBYQodTOz3gezl/0WAePfk1RhSSlgDX8xMVStQOwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OF5FVJOLxdqCE4YIZ88oDX3YzAKYCE1wABIg1FvigCEN6AnhRpe8/2fs36BsDH9G1RNyOCr8rpfRC2HuemQT4UaFQUnzToWKgeP1oriacFSsEWgn6Cu7CrEnKIW6khup3SQnE/7WBOdxMfbKrV0cxfFGmduPLLjw1ww4WSQdb2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lL6OEyBl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7E9C4CED2;
	Mon,  3 Feb 2025 22:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738621231;
	bh=HjtBYQodTOz3gezl/0WAePfk1RhSSlgDX8xMVStQOwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lL6OEyBlLjA5c5UCjZjNuisUsVwTe2hTAtkMizkoBjOtc0UprdSYnPB9umZuFFu1n
	 /TKHMJQCxn+JxbAQHmPJihHVbL0wvDDrcMFbvrg4yRITLDQ0RZCuyXMtcqsZPVndJ5
	 JIry62Zz8VcTI0pCxt0TdS+7iK/H1B5FN00q4UavbfqiueBnEaV4W64TwD+2b8a+ht
	 jfw4PYvXdcTq/c74ECIxWCJrd7pg3wXYy0qfyfkEtHQS3kETx8XDo71bE1b/lMXOZk
	 liGPIpPoRUusmzqPTtj+gDkMETDwQCH3k3dQoOpPfQhzVMMquoLHag7XWBkU+uds/8
	 7BLu84/l77heg==
Date: Mon, 3 Feb 2025 14:20:31 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	Qu Wenruo <wqu@suse.com>, Goldwyn Rodrigues <rgoldwyn@suse.com>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 7/7] xfs: implement block-metadata based data checksums
Message-ID: <20250203222031.GB134507@frogsfrogsfrogs>
References: <20250203094322.1809766-1-hch@lst.de>
 <20250203094322.1809766-8-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203094322.1809766-8-hch@lst.de>

On Mon, Feb 03, 2025 at 10:43:11AM +0100, Christoph Hellwig wrote:
> This is a quick hack to demonstrate how data checksumming can be
> implemented when it can be stored in the out of line metadata for each
> logical block.  It builds on top of the previous PI infrastructure
> and instead of generating/verifying protection information it simply
> generates and verifies a crc32c checksum and stores it in the non-PI

PI can do crc32c now?  I thought it could only do that old crc16 from
like 15 years ago and crc64?  If we try to throw crc32c at a device,
won't it then reject the "incorrect" checksums?  Or is there some other
magic in here where it works and I'm just too out of date to know?

<shrug>

The crc32c generation and validation looks decent though we're
definitely going to want an inode flag so that we're not stuck with
stable page writes.

--D

> metadata.  It misses a feature bit in the superblock, checking that
> enough size is available in the metadata and many other things.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/xfs_data_csum.c | 79 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 76 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/xfs/xfs_data_csum.c b/fs/xfs/xfs_data_csum.c
> index d9d3620654b1..862388803398 100644
> --- a/fs/xfs/xfs_data_csum.c
> +++ b/fs/xfs/xfs_data_csum.c
> @@ -14,6 +14,73 @@
>  #include <linux/blk-integrity.h>
>  #include <linux/bio-integrity.h>
>  
> +static inline void *xfs_csum_buf(struct bio *bio)
> +{
> +	return bvec_virt(bio_integrity(bio)->bip_vec);
> +}
> +
> +static inline __le32
> +xfs_data_csum(
> +	void			*data,
> +	unsigned int		len)
> +{
> +	return xfs_end_cksum(crc32c(XFS_CRC_SEED, data, len));
> +}
> +
> +static void
> +__xfs_data_csum_generate(
> +	struct bio		*bio)
> +{
> +	unsigned int		ssize = bdev_logical_block_size(bio->bi_bdev);
> +	__le32			*csum_buf = xfs_csum_buf(bio);
> +	struct bvec_iter_all	iter;
> +	struct bio_vec		*bv;
> +	int			c = 0;
> +
> +	bio_for_each_segment_all(bv, bio, iter) {
> +		void		*p;
> +		unsigned int	off;
> +
> +		p = bvec_kmap_local(bv);
> +		for (off = 0; off < bv->bv_len; off += ssize)
> +			csum_buf[c++] = xfs_data_csum(p + off, ssize);
> +		kunmap_local(p);
> +	}
> +}
> +
> +static int
> +__xfs_data_csum_verify(
> +	struct bio		*bio,
> +	struct xfs_inode	*ip,
> +	xfs_off_t		file_offset)
> +{
> +	unsigned int		ssize = bdev_logical_block_size(bio->bi_bdev);
> +	__le32			*csum_buf = xfs_csum_buf(bio);
> +	int			c = 0;
> +	struct bvec_iter_all	iter;
> +	struct bio_vec		*bv;
> +
> +	bio_for_each_segment_all(bv, bio, iter) {
> +		void		*p;
> +		unsigned int	off;
> +
> +		p = bvec_kmap_local(bv);
> +		for (off = 0; off < bv->bv_len; off += ssize) {
> +			if (xfs_data_csum(p + off, ssize) != csum_buf[c++]) {
> +				kunmap_local(p);
> +				xfs_warn(ip->i_mount,
> +"checksum mismatch at inode 0x%llx offset %lld",
> +					ip->i_ino, file_offset);
> +				return -EFSBADCRC;
> +			}
> +			file_offset += ssize;
> +		}
> +		kunmap_local(p);
> +	}
> +
> +	return 0;
> +}
> +
>  void *
>  xfs_data_csum_alloc(
>  	struct bio		*bio)
> @@ -53,11 +120,14 @@ xfs_data_csum_generate(
>  {
>  	struct blk_integrity	*bi = blk_get_integrity(bio->bi_bdev->bd_disk);
>  
> -	if (!bi || !bi->csum_type)
> +	if (!bi)
>  		return;
>  
>  	xfs_data_csum_alloc(bio);
> -	blk_integrity_generate(bio);
> +	if (!bi->csum_type)
> +		__xfs_data_csum_generate(bio);
> +	else
> +		blk_integrity_generate(bio);
>  }
>  
>  int
> @@ -67,7 +137,10 @@ xfs_data_csum_verify(
>  	struct bio		*bio = &ioend->io_bio;
>  	struct blk_integrity	*bi = blk_get_integrity(bio->bi_bdev->bd_disk);
>  
> -	if (!bi || !bi->csum_type)
> +	if (!bi)
>  		return 0;
> +	if (!bi->csum_type)
> +		return __xfs_data_csum_verify(&ioend->io_bio,
> +				XFS_I(ioend->io_inode), ioend->io_offset);
>  	return blk_integrity_verify_all(bio, ioend->io_sector);
>  }
> -- 
> 2.45.2
> 
> 

