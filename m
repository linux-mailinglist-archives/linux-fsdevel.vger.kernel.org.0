Return-Path: <linux-fsdevel+bounces-75770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NEgOFY5eml+4gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 17:29:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A08C7A5B26
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 17:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EB3A43009888
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 16:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E430430FC17;
	Wed, 28 Jan 2026 16:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWHOwHmo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8433093A8;
	Wed, 28 Jan 2026 16:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769617744; cv=none; b=dLdwiV6e7co9kqR9lwT5jIOCYEbufuzGdRTU8fFLOyjGzaNMIv9sIOWwRU5nihbtk3Gi7kvUxXrkrO0UifNh/pgquQ/a6cpuf7r3bcCThquI+C07yc6zzI1Ts8X3aTuDYIFTMSjAf+M3mdQdiguZCbm2qUyArbk0oxkvNlAEXb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769617744; c=relaxed/simple;
	bh=mJmID4Z4UvSSgtu6Zttvq+McUuSYYgnS5C9d7U4ByQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/oa8blDabiWLJS5OCV1in4kdQKvQ+fngOYpFDSXrXI4yf7Hl5ye2zAfoeY9DVE81l7E9DAm+Km2Dbz9tmN5fJov3Goadsh5UrARthSFNsfhI6JqrK0aFrdhLFS92GlRcKGNADtSalnS61lQuuK47yDFTbqBKjWxUM03SpXSBtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWHOwHmo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13401C4CEF1;
	Wed, 28 Jan 2026 16:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769617744;
	bh=mJmID4Z4UvSSgtu6Zttvq+McUuSYYgnS5C9d7U4ByQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AWHOwHmoYLlTEV+ouPxcvV6xkNWkLVdXZu5KLA/WYFkL8Ec32TfkUEO5xxbL/AIhS
	 eNJ+rWIsExv9m+4cNnyauMFt043A38jukT+TUuci3g9toiBX0JX/X1hojSZRKFiovr
	 sARUmCTrPCzmsEFjw2AGyItt7ielvQ/Ze4ir1NVs9GFdSXpZDlJG0qhrWn+q0g5D3/
	 u1zjbHS9qo84tih+m5ahMRHY30qFBwAbsUccuNR6ABsAEN1uCbOVjFgeDYsDkkUxVN
	 tRCIvMv2QRSMb4vRGyzGs802rSWObobvz8oiE6ZmPu1GCBuXsGrft+gYco7PiNaoHT
	 oml8AdJccUifw==
Date: Wed, 28 Jan 2026 08:29:03 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 01/15] block: factor out a bio_integrity_action helper
Message-ID: <20260128162903.GX5945@frogsfrogsfrogs>
References: <20260128161517.666412-1-hch@lst.de>
 <20260128161517.666412-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128161517.666412-2-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75770-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:email,samsung.com:email]
X-Rspamd-Queue-Id: A08C7A5B26
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 05:14:56PM +0100, Christoph Hellwig wrote:
> Split the logic to see if a bio needs integrity metadata from
> bio_integrity_prep into a reusable helper than can be called from
> file system code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
> Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Tested-by: Anuj Gupta <anuj20.g@samsung.com>

Looks good to me now, thanks for clarifying the kerneldoc
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  block/bio-integrity-auto.c    | 64 +++++------------------------------
>  block/bio-integrity.c         | 48 ++++++++++++++++++++++++++
>  block/blk-mq.c                |  6 ++--
>  drivers/nvdimm/btt.c          |  6 ++--
>  include/linux/bio-integrity.h |  5 ++-
>  include/linux/blk-integrity.h | 23 +++++++++++++
>  6 files changed, 89 insertions(+), 63 deletions(-)
> 
> diff --git a/block/bio-integrity-auto.c b/block/bio-integrity-auto.c
> index 44dcdf7520c5..e16f669dbf1e 100644
> --- a/block/bio-integrity-auto.c
> +++ b/block/bio-integrity-auto.c
> @@ -50,11 +50,6 @@ static bool bip_should_check(struct bio_integrity_payload *bip)
>  	return bip->bip_flags & BIP_CHECK_FLAGS;
>  }
>  
> -static bool bi_offload_capable(struct blk_integrity *bi)
> -{
> -	return bi->metadata_size == bi->pi_tuple_size;
> -}
> -
>  /**
>   * __bio_integrity_endio - Integrity I/O completion function
>   * @bio:	Protected bio
> @@ -84,69 +79,27 @@ bool __bio_integrity_endio(struct bio *bio)
>  /**
>   * bio_integrity_prep - Prepare bio for integrity I/O
>   * @bio:	bio to prepare
> + * @action:	preparation action needed (BI_ACT_*)
> + *
> + * Allocate the integrity payload.  For writes, generate the integrity metadata
> + * and for reads, setup the completion handler to verify the metadata.
>   *
> - * Checks if the bio already has an integrity payload attached.  If it does, the
> - * payload has been generated by another kernel subsystem, and we just pass it
> - * through.
> - * Otherwise allocates integrity payload and for writes the integrity metadata
> - * will be generated.  For reads, the completion handler will verify the
> - * metadata.
> + * This is used for bios that do not have user integrity payloads attached.
>   */
> -bool bio_integrity_prep(struct bio *bio)
> +void bio_integrity_prep(struct bio *bio, unsigned int action)
>  {
>  	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
>  	struct bio_integrity_data *bid;
> -	bool set_flags = true;
> -	gfp_t gfp = GFP_NOIO;
> -
> -	if (!bi)
> -		return true;
> -
> -	if (!bio_sectors(bio))
> -		return true;
> -
> -	/* Already protected? */
> -	if (bio_integrity(bio))
> -		return true;
> -
> -	switch (bio_op(bio)) {
> -	case REQ_OP_READ:
> -		if (bi->flags & BLK_INTEGRITY_NOVERIFY) {
> -			if (bi_offload_capable(bi))
> -				return true;
> -			set_flags = false;
> -		}
> -		break;
> -	case REQ_OP_WRITE:
> -		/*
> -		 * Zero the memory allocated to not leak uninitialized kernel
> -		 * memory to disk for non-integrity metadata where nothing else
> -		 * initializes the memory.
> -		 */
> -		if (bi->flags & BLK_INTEGRITY_NOGENERATE) {
> -			if (bi_offload_capable(bi))
> -				return true;
> -			set_flags = false;
> -			gfp |= __GFP_ZERO;
> -		} else if (bi->metadata_size > bi->pi_tuple_size)
> -			gfp |= __GFP_ZERO;
> -		break;
> -	default:
> -		return true;
> -	}
> -
> -	if (WARN_ON_ONCE(bio_has_crypt_ctx(bio)))
> -		return true;
>  
>  	bid = mempool_alloc(&bid_pool, GFP_NOIO);
>  	bio_integrity_init(bio, &bid->bip, &bid->bvec, 1);
>  	bid->bio = bio;
>  	bid->bip.bip_flags |= BIP_BLOCK_INTEGRITY;
> -	bio_integrity_alloc_buf(bio, gfp & __GFP_ZERO);
> +	bio_integrity_alloc_buf(bio, action & BI_ACT_ZERO);
>  
>  	bip_set_seed(&bid->bip, bio->bi_iter.bi_sector);
>  
> -	if (set_flags) {
> +	if (action & BI_ACT_CHECK) {
>  		if (bi->csum_type == BLK_INTEGRITY_CSUM_IP)
>  			bid->bip.bip_flags |= BIP_IP_CHECKSUM;
>  		if (bi->csum_type)
> @@ -160,7 +113,6 @@ bool bio_integrity_prep(struct bio *bio)
>  		blk_integrity_generate(bio);
>  	else
>  		bid->saved_bio_iter = bio->bi_iter;
> -	return true;
>  }
>  EXPORT_SYMBOL(bio_integrity_prep);
>  
> diff --git a/block/bio-integrity.c b/block/bio-integrity.c
> index 09eeaf6e74b8..6bdbb4ed2d1a 100644
> --- a/block/bio-integrity.c
> +++ b/block/bio-integrity.c
> @@ -7,6 +7,7 @@
>   */
>  
>  #include <linux/blk-integrity.h>
> +#include <linux/t10-pi.h>
>  #include "blk.h"
>  
>  struct bio_integrity_alloc {
> @@ -16,6 +17,53 @@ struct bio_integrity_alloc {
>  
>  static mempool_t integrity_buf_pool;
>  
> +static bool bi_offload_capable(struct blk_integrity *bi)
> +{
> +	return bi->metadata_size == bi->pi_tuple_size;
> +}
> +
> +unsigned int __bio_integrity_action(struct bio *bio)
> +{
> +	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
> +
> +	if (WARN_ON_ONCE(bio_has_crypt_ctx(bio)))
> +		return 0;
> +
> +	switch (bio_op(bio)) {
> +	case REQ_OP_READ:
> +		if (bi->flags & BLK_INTEGRITY_NOVERIFY) {
> +			if (bi_offload_capable(bi))
> +				return 0;
> +			return BI_ACT_BUFFER;
> +		}
> +		return BI_ACT_BUFFER | BI_ACT_CHECK;
> +	case REQ_OP_WRITE:
> +		/*
> +		 * Flush masquerading as write?
> +		 */
> +		if (!bio_sectors(bio))
> +			return 0;
> +
> +		/*
> +		 * Zero the memory allocated to not leak uninitialized kernel
> +		 * memory to disk for non-integrity metadata where nothing else
> +		 * initializes the memory.
> +		 */
> +		if (bi->flags & BLK_INTEGRITY_NOGENERATE) {
> +			if (bi_offload_capable(bi))
> +				return 0;
> +			return BI_ACT_BUFFER | BI_ACT_ZERO;
> +		}
> +
> +		if (bi->metadata_size > bi->pi_tuple_size)
> +			return BI_ACT_BUFFER | BI_ACT_CHECK | BI_ACT_ZERO;
> +		return BI_ACT_BUFFER | BI_ACT_CHECK;
> +	default:
> +		return 0;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(__bio_integrity_action);
> +
>  void bio_integrity_alloc_buf(struct bio *bio, bool zero_buffer)
>  {
>  	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index cf1daedbb39f..d40942bafd02 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3134,6 +3134,7 @@ void blk_mq_submit_bio(struct bio *bio)
>  	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
>  	struct blk_plug *plug = current->plug;
>  	const int is_sync = op_is_sync(bio->bi_opf);
> +	unsigned int integrity_action;
>  	struct blk_mq_hw_ctx *hctx;
>  	unsigned int nr_segs;
>  	struct request *rq;
> @@ -3186,8 +3187,9 @@ void blk_mq_submit_bio(struct bio *bio)
>  	if (!bio)
>  		goto queue_exit;
>  
> -	if (!bio_integrity_prep(bio))
> -		goto queue_exit;
> +	integrity_action = bio_integrity_action(bio);
> +	if (integrity_action)
> +		bio_integrity_prep(bio, integrity_action);
>  
>  	blk_mq_bio_issue_init(q, bio);
>  	if (blk_mq_attempt_bio_merge(q, bio, nr_segs))
> diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
> index a933db961ed7..9cc4b659de1a 100644
> --- a/drivers/nvdimm/btt.c
> +++ b/drivers/nvdimm/btt.c
> @@ -1437,14 +1437,16 @@ static void btt_submit_bio(struct bio *bio)
>  {
>  	struct bio_integrity_payload *bip = bio_integrity(bio);
>  	struct btt *btt = bio->bi_bdev->bd_disk->private_data;
> +	unsigned int integrity_action;
>  	struct bvec_iter iter;
>  	unsigned long start;
>  	struct bio_vec bvec;
>  	int err = 0;
>  	bool do_acct;
>  
> -	if (!bio_integrity_prep(bio))
> -		return;
> +	integrity_action = bio_integrity_action(bio);
> +	if (integrity_action)
> +		bio_integrity_prep(bio, integrity_action);
>  
>  	do_acct = blk_queue_io_stat(bio->bi_bdev->bd_disk->queue);
>  	if (do_acct)
> diff --git a/include/linux/bio-integrity.h b/include/linux/bio-integrity.h
> index 21e4652dcfd2..276cbbdd2c9d 100644
> --- a/include/linux/bio-integrity.h
> +++ b/include/linux/bio-integrity.h
> @@ -78,7 +78,7 @@ int bio_integrity_add_page(struct bio *bio, struct page *page, unsigned int len,
>  int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter);
>  int bio_integrity_map_iter(struct bio *bio, struct uio_meta *meta);
>  void bio_integrity_unmap_user(struct bio *bio);
> -bool bio_integrity_prep(struct bio *bio);
> +void bio_integrity_prep(struct bio *bio, unsigned int action);
>  void bio_integrity_advance(struct bio *bio, unsigned int bytes_done);
>  void bio_integrity_trim(struct bio *bio);
>  int bio_integrity_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp_mask);
> @@ -104,9 +104,8 @@ static inline void bio_integrity_unmap_user(struct bio *bio)
>  {
>  }
>  
> -static inline bool bio_integrity_prep(struct bio *bio)
> +static inline void bio_integrity_prep(struct bio *bio, unsigned int action)
>  {
> -	return true;
>  }
>  
>  static inline int bio_integrity_clone(struct bio *bio, struct bio *bio_src,
> diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
> index c15b1ac62765..fd3f3c8c0fcd 100644
> --- a/include/linux/blk-integrity.h
> +++ b/include/linux/blk-integrity.h
> @@ -180,4 +180,27 @@ static inline struct bio_vec rq_integrity_vec(struct request *rq)
>  }
>  #endif /* CONFIG_BLK_DEV_INTEGRITY */
>  
> +enum bio_integrity_action {
> +	BI_ACT_BUFFER		= (1u << 0),	/* allocate buffer */
> +	BI_ACT_CHECK		= (1u << 1),	/* generate / verify PI */
> +	BI_ACT_ZERO		= (1u << 2),	/* zero buffer */
> +};
> +
> +/**
> + * bio_integrity_action - return the integrity action needed for a bio
> + * @bio:	bio to operate on
> + *
> + * Returns the mask of integrity actions (BI_ACT_*) that need to be performed
> + * for @bio.
> + */
> +unsigned int __bio_integrity_action(struct bio *bio);
> +static inline unsigned int bio_integrity_action(struct bio *bio)
> +{
> +	if (!blk_get_integrity(bio->bi_bdev->bd_disk))
> +		return 0;
> +	if (bio_integrity(bio))
> +		return 0;
> +	return __bio_integrity_action(bio);
> +}
> +
>  #endif /* _LINUX_BLK_INTEGRITY_H */
> -- 
> 2.47.3
> 
> 

