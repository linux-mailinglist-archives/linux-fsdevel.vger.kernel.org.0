Return-Path: <linux-fsdevel+bounces-75522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AHmNJbCd2nckgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 20:37:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 527F08CA7B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 20:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2ACDD300EBCF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 19:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873B2285CB9;
	Mon, 26 Jan 2026 19:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iu+SXhoT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A82258EDB;
	Mon, 26 Jan 2026 19:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769456210; cv=none; b=P13FZDzkOKbnvT1je21V9d3beT1PLo3YsdGrdJghhnJaM2o1Y4yqBhSyGDwk7lJs7vSH1vdoU7LQv0yhhIAEkDEQucH4eYIj1fFaakUMgoWpXXKqXARXmV67xjGWEXVREKv2Z16yFhlr4EVlUVa86Evfed2hQAPsNQ8QnmQ/AUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769456210; c=relaxed/simple;
	bh=WQDHzbHWisuyP9HUrv0hhczQyl1XzKm5J3s1W8GvNw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbW8eqbG2pRJjXUbqSl9It9AzK130eSBDTi5j6L7oEXpVv/dvP5yzk7Znhu4QTLZtGWXqplW3PtVGOBQS2SStrh6DAG7STaEJDsyrLAPuUFGA/PLPm3J/idCbr2aiRzZbAab2chSYjWnm40KL7CYYcfEQscMvOivKblXxKUQpKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iu+SXhoT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E88C116C6;
	Mon, 26 Jan 2026 19:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769456209;
	bh=WQDHzbHWisuyP9HUrv0hhczQyl1XzKm5J3s1W8GvNw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iu+SXhoTaNkr/e5V3RWQB+X70Sztgq9Qy+fCPHKu7nxIx3sP5QfQvnfxNPAHjzB50
	 vrAxgnGQqHdN34+wLcvFwsliXz/7UouDiegID86GeglOFeDnpVz9oM8Z3QZ8Y5l17w
	 5gaogrFWp1TRHZ9UfrVYCMwktn8JjPV2dHwoduWE9654SnQFurMmiiSbPXTRDuNXJD
	 T32W86LDtwSy3uB2dnevPQ+6ngfHRuW/vWlyVMabYfDxX2qR4FhsU9XtMWiWWHtV9g
	 dTEc+aXXeFZosDhHRMHAzQ6GlmmurRSdkvcOpz31MlXYKV/zyVnHGdbHNipPrh63cR
	 6Ooi2hJ0MHkYA==
Date: Mon, 26 Jan 2026 11:36:48 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/15] block: add a BIO_MAX_SIZE constant and use it
Message-ID: <20260126193648.GV5910@frogsfrogsfrogs>
References: <20260126055406.1421026-1-hch@lst.de>
 <20260126055406.1421026-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126055406.1421026-2-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75522-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lst.de:email]
X-Rspamd-Queue-Id: 527F08CA7B
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 06:53:32AM +0100, Christoph Hellwig wrote:
> Currently the only constant for the maximum bio size is BIO_MAX_SECTORS,
> which is in units of 512-byte sectors, but a lot of user need a byte
> limit.
> 
> Add a BIO_MAX_SIZE constant, redefine BIO_MAX_SECTORS in terms of it, and
> switch all bio-related uses of UINT_MAX for the maximum size to use the
> symbolic names instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Yay, thanks!
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  block/bio.c               | 10 +++++-----
>  block/blk-lib.c           |  9 ++++-----
>  block/blk-merge.c         |  8 ++++----
>  include/linux/blk_types.h |  3 ++-
>  4 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 2359c0723b88..ac7703e149c6 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -924,7 +924,7 @@ static inline bool bio_full(struct bio *bio, unsigned len)
>  {
>  	if (bio->bi_vcnt >= bio->bi_max_vecs)
>  		return true;
> -	if (bio->bi_iter.bi_size > UINT_MAX - len)
> +	if (bio->bi_iter.bi_size > BIO_MAX_SIZE - len)
>  		return true;
>  	return false;
>  }
> @@ -1030,7 +1030,7 @@ int bio_add_page(struct bio *bio, struct page *page,
>  {
>  	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
>  		return 0;
> -	if (bio->bi_iter.bi_size > UINT_MAX - len)
> +	if (bio->bi_iter.bi_size > BIO_MAX_SIZE - len)
>  		return 0;
>  
>  	if (bio->bi_vcnt > 0) {
> @@ -1057,7 +1057,7 @@ void bio_add_folio_nofail(struct bio *bio, struct folio *folio, size_t len,
>  {
>  	unsigned long nr = off / PAGE_SIZE;
>  
> -	WARN_ON_ONCE(len > UINT_MAX);
> +	WARN_ON_ONCE(len > BIO_MAX_SIZE);
>  	__bio_add_page(bio, folio_page(folio, nr), len, off % PAGE_SIZE);
>  }
>  EXPORT_SYMBOL_GPL(bio_add_folio_nofail);
> @@ -1081,7 +1081,7 @@ bool bio_add_folio(struct bio *bio, struct folio *folio, size_t len,
>  {
>  	unsigned long nr = off / PAGE_SIZE;
>  
> -	if (len > UINT_MAX)
> +	if (len > BIO_MAX_SIZE)
>  		return false;
>  	return bio_add_page(bio, folio_page(folio, nr), len, off % PAGE_SIZE) > 0;
>  }
> @@ -1238,7 +1238,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  		extraction_flags |= ITER_ALLOW_P2PDMA;
>  
>  	size = iov_iter_extract_pages(iter, &pages,
> -				      UINT_MAX - bio->bi_iter.bi_size,
> +				      BIO_MAX_SIZE - bio->bi_iter.bi_size,
>  				      nr_pages, extraction_flags, &offset);
>  	if (unlikely(size <= 0))
>  		return size ? size : -EFAULT;
> diff --git a/block/blk-lib.c b/block/blk-lib.c
> index 9e2cc58f881f..0be3acdc3eb5 100644
> --- a/block/blk-lib.c
> +++ b/block/blk-lib.c
> @@ -32,7 +32,7 @@ static sector_t bio_discard_limit(struct block_device *bdev, sector_t sector)
>  	 * Align the bio size to the discard granularity to make splitting the bio
>  	 * at discard granularity boundaries easier in the driver if needed.
>  	 */
> -	return round_down(UINT_MAX, discard_granularity) >> SECTOR_SHIFT;
> +	return round_down(BIO_MAX_SIZE, discard_granularity) >> SECTOR_SHIFT;
>  }
>  
>  struct bio *blk_alloc_discard_bio(struct block_device *bdev,
> @@ -107,8 +107,7 @@ static sector_t bio_write_zeroes_limit(struct block_device *bdev)
>  {
>  	sector_t bs_mask = (bdev_logical_block_size(bdev) >> 9) - 1;
>  
> -	return min(bdev_write_zeroes_sectors(bdev),
> -		(UINT_MAX >> SECTOR_SHIFT) & ~bs_mask);
> +	return min(bdev_write_zeroes_sectors(bdev), BIO_MAX_SECTORS & ~bs_mask);
>  }
>  
>  /*
> @@ -337,8 +336,8 @@ int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector,
>  	int ret = 0;
>  
>  	/* make sure that "len << SECTOR_SHIFT" doesn't overflow */
> -	if (max_sectors > UINT_MAX >> SECTOR_SHIFT)
> -		max_sectors = UINT_MAX >> SECTOR_SHIFT;
> +	if (max_sectors > BIO_MAX_SECTORS)
> +		max_sectors = BIO_MAX_SECTORS;
>  	max_sectors &= ~bs_mask;
>  
>  	if (max_sectors == 0)
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index b82c6d304658..0eb0aef97197 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -95,13 +95,13 @@ static inline bool req_gap_front_merge(struct request *req, struct bio *bio)
>  }
>  
>  /*
> - * The max size one bio can handle is UINT_MAX becasue bvec_iter.bi_size
> - * is defined as 'unsigned int', meantime it has to be aligned to with the
> + * The maximum size that a bio can fit has to be aligned down to the
>   * logical block size, which is the minimum accepted unit by hardware.
>   */
>  static unsigned int bio_allowed_max_sectors(const struct queue_limits *lim)
>  {
> -	return round_down(UINT_MAX, lim->logical_block_size) >> SECTOR_SHIFT;
> +	return round_down(BIO_MAX_SIZE, lim->logical_block_size) >>
> +			SECTOR_SHIFT;
>  }
>  
>  /*
> @@ -502,7 +502,7 @@ unsigned int blk_recalc_rq_segments(struct request *rq)
>  
>  	rq_for_each_bvec(bv, rq, iter)
>  		bvec_split_segs(&rq->q->limits, &bv, &nr_phys_segs, &bytes,
> -				UINT_MAX, UINT_MAX);
> +				UINT_MAX, BIO_MAX_SIZE);
>  	return nr_phys_segs;
>  }
>  
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 19a888a2f104..d59553324a84 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -281,7 +281,8 @@ struct bio {
>  };
>  
>  #define BIO_RESET_BYTES		offsetof(struct bio, bi_max_vecs)
> -#define BIO_MAX_SECTORS		(UINT_MAX >> SECTOR_SHIFT)
> +#define BIO_MAX_SIZE		UINT_MAX /* max value of bi_iter.bi_size */
> +#define BIO_MAX_SECTORS		(BIO_MAX_SIZE >> SECTOR_SHIFT)
>  
>  static inline struct bio_vec *bio_inline_vecs(struct bio *bio)
>  {
> -- 
> 2.47.3
> 
> 

