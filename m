Return-Path: <linux-fsdevel+bounces-75171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8F8sKXe6cmmtowAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 01:01:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43ECE6EA68
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 01:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 115AD301BC03
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 00:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7E12773E9;
	Fri, 23 Jan 2026 00:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mv+IR6cl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406411DF27D;
	Fri, 23 Jan 2026 00:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769126475; cv=none; b=ICuCkStj2aN8FzhsWIovC2zbUIwIKQfm4MudT8Taeua9pAOa+WMwEjiuI3s4T2jIbxiak9sdeFv2ZXg3QaspN6ovFY4ZNjyWFTXBSAhbUxUwCkzNbQRwsrCk205TxWZ7CTNTeUKyl+6VAy/LqozeE4wmJFhiUxIMeWuD6akp5ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769126475; c=relaxed/simple;
	bh=EfuJ/9S2MVwEwAsSrSVrV7MJXkr1aGgO6ERpiat1cR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jajx3q+IC0a9vui+6f9JhwMqg+bLnHy7XLegZMhN0gMkZZpPne4+OipM5sg6BOUCWzey27ulYTzst03MYArj25rrs2SNUqrAmDQbvqL+5PXqcOO1kTqjX6nnrtdJBp1JgG3CZnvISvc9DzVqdmkBU+CgtgmGgNoUGBFW7ZJQvaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mv+IR6cl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9A7C116C6;
	Fri, 23 Jan 2026 00:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769126473;
	bh=EfuJ/9S2MVwEwAsSrSVrV7MJXkr1aGgO6ERpiat1cR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mv+IR6clX+oVf5rEU1EoEkq0u12BRlLZVJwA2AKMb7XScA/pQdXEL4Rgbd1g8a1nU
	 cTxE2iTXdJ1zLGVu5hIT7YTDPonLc+wHxr7Z/I7iLpRP1/BF8aM71OZ11IuIYGrQQV
	 xgbWBBLJw+B7bJDuPitG2lzZaVU3qtI2KfvzBqhbVwAM/Oy2htcIqUXXXqkVua+Knp
	 Lr3eHvbAqPs9QW/cntxoCio0JRKBostYJnLpRW7AF9jJ3ircbHe0jXnRRFWcrTuaN3
	 HhjshjHdbip3ArQNAN7iqOJDBiYq9Zm9RQ+FEuWhplxzcZwcWezTCEVHCekWAB2LkL
	 PqS5tG94QXpyQ==
Date: Thu, 22 Jan 2026 16:01:13 -0800
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
Message-ID: <20260123000113.GF5945@frogsfrogsfrogs>
References: <20260121064339.206019-1-hch@lst.de>
 <20260121064339.206019-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121064339.206019-2-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75171-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 43ECE6EA68
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 07:43:09AM +0100, Christoph Hellwig wrote:
> Split the logic to see if a bio needs integrity metadata from
> bio_integrity_prep into a reusable helper than can be called from
> file system code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/bio-integrity-auto.c    | 64 +++++------------------------------
>  block/bio-integrity.c         | 48 ++++++++++++++++++++++++++
>  block/blk-mq.c                |  6 ++--
>  drivers/nvdimm/btt.c          |  6 ++--
>  include/linux/bio-integrity.h |  5 ++-
>  include/linux/blk-integrity.h | 16 +++++++++
>  6 files changed, 82 insertions(+), 63 deletions(-)
> 
> diff --git a/block/bio-integrity-auto.c b/block/bio-integrity-auto.c
> index 44dcdf7520c5..3a4141a9de0c 100644
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
> + * @action:	preparation action needed

What is @action?  Is it a bitset of BI_ACT_* values?  If yes, then can
the comment please say that explicitly?

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

Yes, I suppose it is a bitset.

--D

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

Just out of curiosity, what happens if metadata_size > pi_tuple_size?

Can it be the case that metadata_size < pi_tuple_size?

> +unsigned int __bio_integrity_action(struct bio *bio)

Hrm, this function returns a bitset of BI_ACT_* flags, doesn't it?

Would be kinda nice if a comment could say that.

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

Er... does someone initialize it eventually?  Such as the filesystem?
Or maybe an io_uring caller?

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

"check" feels like a weird name for a write, where we're generating the
PI information.  It really means "block layer takes care of PI
generation and validation", right?  As opposed to whichever upper layer
is using the block device?

BI_ACT_YOUDOIT <snerk>

How about BI_ACT_BDEV /* block layer checks/validates PI */

Everything else in here looks reasonable.

--D

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
> index a29d8ac9d3e3..3e58f6d50a1a 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3133,6 +3133,7 @@ void blk_mq_submit_bio(struct bio *bio)
>  	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
>  	struct blk_plug *plug = current->plug;
>  	const int is_sync = op_is_sync(bio->bi_opf);
> +	unsigned int integrity_action;
>  	struct blk_mq_hw_ctx *hctx;
>  	unsigned int nr_segs;
>  	struct request *rq;
> @@ -3185,8 +3186,9 @@ void blk_mq_submit_bio(struct bio *bio)
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
> index c15b1ac62765..91d12610d252 100644
> --- a/include/linux/blk-integrity.h
> +++ b/include/linux/blk-integrity.h
> @@ -180,4 +180,20 @@ static inline struct bio_vec rq_integrity_vec(struct request *rq)
>  }
>  #endif /* CONFIG_BLK_DEV_INTEGRITY */
>  
> +enum bio_integrity_action {
> +	BI_ACT_BUFFER		= (1u << 0),	/* allocate buffer */
> +	BI_ACT_CHECK		= (1u << 1),	/* generate / verify PI */
> +	BI_ACT_ZERO		= (1u << 2),	/* zero buffer */
> +};
> +
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

