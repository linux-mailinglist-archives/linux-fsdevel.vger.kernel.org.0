Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCCA1684CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 18:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgBURWG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 12:22:06 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51492 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgBURWG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 12:22:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aXt2MpJoOJ+SOLt+qHfSOYc8ycsQwnlJ+Ow9FqJrtSY=; b=UOYIsZ++D0e/9NUj2o1hGkWLjJ
        7+Hordj+sKrr5SKSkMAYh3lydolg9mbcBs6r4zeBS1Awx+rbZlhcSeeEzddiUiG8zOnxGHH3kDLSr
        Ruk5YTfcl6PpfrR8iXEguIz0uUfKY10rTnfEGx1xK1IOa+SCijt+qKhFDvVE3Ex+xWH7Hk5qsL3mg
        nwmwUOvfUVDC7ArZd4Ls+W8aiDS1YhaoyqVGVQyEzKbAFwbHDJQ2HlEuYt2/EWRb8t1jU1FU3p7nq
        Diignb4Ca9/RI0a+xDKN7CVkJQBd44k83ETOjPb/brdy4UXNBFPZr5u902pT3gAWJDgrmlZYFz0p6
        lw/kxzcQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j5C05-00063T-83; Fri, 21 Feb 2020 17:22:05 +0000
Date:   Fri, 21 Feb 2020 09:22:05 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v7 2/9] block: Inline encryption support for blk-mq
Message-ID: <20200221172205.GB438@infradead.org>
References: <20200221115050.238976-1-satyat@google.com>
 <20200221115050.238976-3-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221115050.238976-3-satyat@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> index bf62c25cde8f..bce563031e7c 100644
> --- a/block/bio-integrity.c
> +++ b/block/bio-integrity.c
> @@ -42,6 +42,11 @@ struct bio_integrity_payload *bio_integrity_alloc(struct bio *bio,
>  	struct bio_set *bs = bio->bi_pool;
>  	unsigned inline_vecs;
>  
> +	if (bio_has_crypt_ctx(bio)) {
> +		pr_warn("blk-integrity can't be used together with blk-crypto en/decryption.");
> +		return ERR_PTR(-EOPNOTSUPP);
> +	}

What is the rationale for this limitation?  Restricting unrelated
features from being used together is a pretty bad design pattern and
should be avoided where possible.  If it can't it needs to be documented
very clearly.

> +#ifdef CONFIG_BLK_INLINE_ENCRYPTION
> +	rq->rq_crypt_ctx.keyslot = -EINVAL;
> +#endif

All the other core block calls to the crypto code are in helpers that
are stubbed out.  It might make sense to follow that style here.

>  
>  free_and_out:
> @@ -1813,5 +1826,8 @@ int __init blk_dev_init(void)
>  	blk_debugfs_root = debugfs_create_dir("block", NULL);
>  #endif
>  
> +	if (bio_crypt_ctx_init() < 0)
> +		panic("Failed to allocate mem for bio crypt ctxs\n");

Maybe move that panic into bio_crypt_ctx_init itself?

> +static int num_prealloc_crypt_ctxs = 128;
> +
> +module_param(num_prealloc_crypt_ctxs, int, 0444);
> +MODULE_PARM_DESC(num_prealloc_crypt_ctxs,
> +		"Number of bio crypto contexts to preallocate");

Please write a comment why this is a tunable, how the default is choosen
and why someone might want to chane it.

> +struct bio_crypt_ctx *bio_crypt_alloc_ctx(gfp_t gfp_mask)
> +{
> +	return mempool_alloc(bio_crypt_ctx_pool, gfp_mask);
> +}

I'd rather move bio_crypt_set_ctx out of line, at which point we don't
really need this helper.

> +/* Return: 0 on success, negative on error */
> +int rq_crypt_ctx_acquire_keyslot(struct bio_crypt_ctx *bc,
> +				  struct keyslot_manager *ksm,
> +				  struct rq_crypt_ctx *rc)
> +{
> +	rc->keyslot = blk_ksm_get_slot_for_key(ksm, bc->bc_key);
> +	return rc->keyslot >= 0 ? 0 : rc->keyslot;
> +}
> +
> +void rq_crypt_ctx_release_keyslot(struct keyslot_manager *ksm,
> +				  struct rq_crypt_ctx *rc)
> +{
> +	if (rc->keyslot >= 0)
> +		blk_ksm_put_slot(ksm, rc->keyslot);
> +	rc->keyslot = -EINVAL;
> +}

Is there really much of a need for these helpers?  I think the
callers would generally be simpler without them.  Especially the
fallback code can avoid having to declare rq_crypt_ctx variables
on stack without the helpers.

> +int blk_crypto_init_request(struct request *rq, struct request_queue *q,
> +			    struct bio *bio)

We can always derive the request_queue from rq->q, so there is no need
to pass it explicitly (even if a lot of legacy block code does, but
it is slowly getting cleaned up).

> +{
> +	struct rq_crypt_ctx *rc = &rq->rq_crypt_ctx;
> +	struct bio_crypt_ctx *bc;
> +	int err;
> +
> +	rc->bc = NULL;
> +	rc->keyslot = -EINVAL;
> +
> +	if (!bio)
> +		return 0;
> +
> +	bc = bio->bi_crypt_context;
> +	if (!bc)
> +		return 0;

Shouldn't the checks if the bio actually requires crypto handling be
done by the caller based on a new handler ala:

static inline bool bio_is_encrypted(struct bio *bio)
{
	return bio && bio->bi_crypt_context;
}

and maybe some inline helpers to reduce the clutter?

That way a kernel with blk crypto support, but using non-crypto I/O
saves all the function calls to blk-crypto.

> +	err = bio_crypt_check_alignment(bio);
> +	if (err)
> +		goto fail;

This seems pretty late to check the alignment, it would be more
useful in bio_add_page.  Then again Jens didn't like alignment checks
in the block layer at all even for the normal non-crypto alignment,
so I don't see why we'd have them here but not for the general case
(I'd actually like to ee them for the general case, btw).

> +int blk_crypto_evict_key(struct request_queue *q,
> +			 const struct blk_crypto_key *key)
> +{
> +	if (q->ksm && blk_ksm_crypto_mode_supported(q->ksm, key))
> +		return blk_ksm_evict_key(q->ksm, key);
> +
> +	return 0;
> +}

Is there any point in this wrapper that just has a single caller?
Als why doesn't blk_ksm_evict_key have the blk_ksm_crypto_mode_supported
sanity check itself?

> @@ -1998,6 +2007,13 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
>  
>  	cookie = request_to_qc_t(data.hctx, rq);
>  
> +	if (blk_crypto_init_request(rq, q, bio)) {
> +		bio->bi_status = BLK_STS_RESOURCE;
> +		bio_endio(bio);
> +		blk_mq_end_request(rq, BLK_STS_RESOURCE);
> +		return BLK_QC_T_NONE;
> +	}

This looks fundamentally wrong given that layers above blk-mq
can't handle BLK_STS_RESOURCE.  It will just show up as an error
in the calller insteaf of being requeued.

That being said I think the only error return from
blk_crypto_init_request is and actual hardware error.  So failing this
might be ok, but it should be BLK_STS_IOERR, or even better an error
directly propagated from the driver. 

> +int bio_crypt_ctx_init(void);
> +
> +struct bio_crypt_ctx *bio_crypt_alloc_ctx(gfp_t gfp_mask);
> +
> +void bio_crypt_free_ctx(struct bio *bio);

These can go into block layer internal headers.

> +static inline bool bio_crypt_dun_is_contiguous(const struct bio_crypt_ctx *bc,
> +					       unsigned int bytes,
> +					u64 next_dun[BLK_CRYPTO_DUN_ARRAY_SIZE])
> +{
> +	int i = 0;
> +	unsigned int inc = bytes >> bc->bc_key->data_unit_size_bits;
> +
> +	while (i < BLK_CRYPTO_DUN_ARRAY_SIZE) {
> +		if (bc->bc_dun[i] + inc != next_dun[i])
> +			return false;
> +		inc = ((bc->bc_dun[i] + inc)  < inc);
> +		i++;
> +	}
> +
> +	return true;
> +}
> +
> +static inline void bio_crypt_dun_increment(u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE],
> +					   unsigned int inc)
> +{
> +	int i = 0;
> +
> +	while (inc && i < BLK_CRYPTO_DUN_ARRAY_SIZE) {
> +		dun[i] += inc;
> +		inc = (dun[i] < inc);
> +		i++;
> +	}
> +}

Should these really be inline?

> +bool bio_crypt_rq_ctx_compatible(struct request *rq, struct bio *bio);
> +
> +bool bio_crypt_ctx_front_mergeable(struct request *req, struct bio *bio);
> +
> +bool bio_crypt_ctx_back_mergeable(struct request *req, struct bio *bio);
> +
> +bool bio_crypt_ctx_merge_rq(struct request *req, struct request *next);
> +
> +void blk_crypto_bio_back_merge(struct request *req, struct bio *bio);
> +
> +void blk_crypto_bio_front_merge(struct request *req, struct bio *bio);
> +
> +void blk_crypto_free_request(struct request *rq);
> +
> +int blk_crypto_init_request(struct request *rq, struct request_queue *q,
> +			    struct bio *bio);
> +
> +int blk_crypto_bio_prep(struct bio **bio_ptr);
> +
> +void blk_crypto_rq_bio_prep(struct request *rq, struct bio *bio);
> +
> +void blk_crypto_rq_prep_clone(struct request *dst, struct request *src);
> +
> +int blk_crypto_insert_cloned_request(struct request_queue *q,
> +				     struct request *rq);
> +
> +int blk_crypto_init_key(struct blk_crypto_key *blk_key, const u8 *raw_key,
> +			enum blk_crypto_mode_num crypto_mode,
> +			unsigned int blk_crypto_dun_bytes,
> +			unsigned int data_unit_size);
> +
> +int blk_crypto_evict_key(struct request_queue *q,
> +			 const struct blk_crypto_key *key);

Most of this should be block layer private.

> +struct rq_crypt_ctx {
> +	struct bio_crypt_ctx *bc;
> +	int keyslot;
> +};
> +
>  /*
>   * Try to put the fields that are referenced together in the same cacheline.
>   *
> @@ -224,6 +230,10 @@ struct request {
>  	unsigned short nr_integrity_segments;
>  #endif
>  
> +#ifdef CONFIG_BLK_INLINE_ENCRYPTION
> +	struct rq_crypt_ctx rq_crypt_ctx;
> +#endif

I'd be tempted to just add

	struct bio_crypt_ctx *crypt_ctx;
	int crypt_keyslot;

directly to struct request.
