Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B23018B1E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 12:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgCSLBk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 07:01:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44958 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbgCSLBj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 07:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+vl1LPoxkxHOU07W4GJvGU25FEPxKQgvle0+E353mqE=; b=uB9WB4ppC1GoT/zWSO4kHWQgqn
        YEUMLeqg4KslKZWQmzvuxToWpdzkInoQ6yirSVGLEzZWN+M49KYCqhQL1Kp0IO7qy8wXnrOv3x2aO
        W5D2/C6QV2R2hwbcqQSbe4YYjO+POTtpgdUFtQJSuA2tp3egSU0flbEt9754bcOhT2aqNszvXB0od
        0+QAE9ZkFUa8gPY94HJMWAQlEQGtIfutJ+QDTm+6CjBOF8Je23JCGh8n3eOneufR5e0CN4hxZ18r8
        LBvvqDmI6PGwo4zu5Al12gwJ1sq+GzNaODmkYU5KRKsLc3UYVVWEN6IHokPY+Xlg3+X+ajSHl6+su
        i3opea0g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEsvi-00047Y-O6; Thu, 19 Mar 2020 11:01:38 +0000
Date:   Thu, 19 Mar 2020 04:01:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v8 02/11] block: Inline encryption support for blk-mq
Message-ID: <20200319110138.GA20097@infradead.org>
References: <20200312080253.3667-1-satyat@google.com>
 <20200312080253.3667-3-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312080253.3667-3-satyat@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 12, 2020 at 01:02:44AM -0700, Satya Tangirala wrote:
> +	if (bio_has_crypt_ctx(bio))
> +		bio_crypt_clone(b, bio, gfp_mask);

FYI, what I had tried to suggest when moving the the bio_has_crypt_ctx
checks out was not to open code them, but to have inline functions.

E.g. your current bio_crypt_clone becomes __bio_crypt_clone,

and then a wrapper is added ala:

static inline void bio_crypt_clone(struct bio *dst, struct bio *src,
		gfp_t gfp_mask)
{
	if (bio_has_crypt_ctx(bio))
		__bio_crypt_clone(dst, src, gfp_mask);
}

Which also means in all the headers you can now declare everything
unconditional as long as bio_has_crypt_ctx is stubbed out for the case
where blk crypto is disabled.

>  	if (bio_integrity(bio)) {
>  		int ret;
>  
>  		ret = bio_integrity_clone(b, bio, gfp_mask);
> -
>  		if (ret < 0) {
>  			bio_put(b);
>  			return NULL;

Spurious whitespace change.

>  free_and_out:
> @@ -1813,5 +1830,7 @@ int __init blk_dev_init(void)
>  	blk_debugfs_root = debugfs_create_dir("block", NULL);
>  #endif
>  
> +	bio_crypt_ctx_init();
> +

Is there any good reason to explicitly call bio_crypt_ctx_init vs just
making it a local subsys_initcall?

> +bool bio_crypt_dun_is_contiguous(const struct bio_crypt_ctx *bc,
> +				 unsigned int bytes,
> +				 u64 next_dun[BLK_CRYPTO_DUN_ARRAY_SIZE])
> +{
> +	int i = 0;
> +	unsigned int inc = bytes >> bc->bc_key->data_unit_size_bits;
> +
> +	while (i < BLK_CRYPTO_DUN_ARRAY_SIZE) {
> +		if (bc->bc_dun[i] + inc != next_dun[i])
> +			return false;
> +		inc = ((bc->bc_dun[i] + inc)  < inc);

Besides the bracing and double whitespace issue this code looks weird
to me.

So inc starts out as the number of bytes shifted to the dun size.

We then check if it matches the next dun for every entry in the
array.

But then inc is turned into a bollean for the next iteration.  At that
point I'm a little lost, can you add comments or make the code more
explicit?

> +	blk_crypto_rq_set_defaults(rq);
> +
> +	err = blk_ksm_get_slot_for_key(rq->q->ksm,
> +				       bio->bi_crypt_context->bc_key,
> +				       &rq->crypt_keyslot);
> +	if (err != BLK_STS_OK)
> +		pr_warn_once("Failed to acquire keyslot for %s (err=%d).\n",
> +			     bio->bi_disk->disk_name, err);
> +	return err;

Is this error really that important?  If someone prints an error here
I'd expect the low-level driver to do that, as that is the only place
knowing what kind of error we could have here.

> +int blk_crypto_bio_prep(struct bio **bio_ptr)
> +{
> +	struct bio *bio = *bio_ptr;
> +
> +	/*
> +	 * If bio has no data, just pretend it didn't have an encryption
> +	 * context.
> +	 */
> +	if (!bio_has_data(bio)) {
> +		bio_crypt_free_ctx(bio);
> +		return 0;
> +	}

Shouldn't a submitted bio without data but with a crypt context be a
hard error?

> +	bio_crypt_check_alignment(bio);
> +	if (bio->bi_status != BLK_STS_OK)
> +		goto fail;

Weird calling convention.  Why doesn't bio_crypt_check_alignment
return a bool, and then this becomes the much more obvious:

	if (!bio_crypt_check_alignment(bio)) {
		bio->bi_status = BLK_STS_IOERR;
		goto fail;
	}

> +	/*
> +	 * Success if device supports the encryption context, and blk-integrity
> +	 * isn't supported by device/is turned off.
> +	 */
> +	if (!blk_ksm_crypto_key_supported(bio->bi_disk->queue->ksm,
> +					  bio->bi_crypt_context->bc_key)) {
> +		bio->bi_status = BLK_STS_NOTSUPP;
> +		goto fail;
> +	}
> +
> +	return 0;
> +fail:
> +	bio_endio(*bio_ptr);
> +	return -EIO;

Weird calling convention again.  If the actual error is in the bio,
this should just be a bool.

> +void blk_crypto_rq_prep_clone(struct request *dst, struct request *src)
> +{
> +	dst->crypt_ctx = src->crypt_ctx;
> +}

This seems reasonable to inline in the header..

> +	blk_status_t err;
>  
>  	blk_queue_bounce(q, &bio);
>  	__blk_queue_split(q, &bio, &nr_segs);
> @@ -2002,6 +2007,16 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
>  
>  	cookie = request_to_qc_t(data.hctx, rq);
>  
> +	if (bio_has_crypt_ctx(bio)) {
> +		err = blk_crypto_init_request(rq, bio);
> +		if (err != BLK_STS_OK) {

The err declaration can go into this scope.  I'd also rather call it
ret as err is usually used for errno codes.

Also blk_crypto_init_request doesn't really need the bio, but just the
key.  So I'd rather pass the key to avoid confusion what this function
might do with the bio.

> +			bio->bi_status = err;
> +			bio_endio(bio);
> +			blk_mq_end_request(rq, err);
> +			return BLK_QC_T_NONE;

Shoudn't the blk_mq_end_request just be a blk_mq_free_request here?

> +#ifdef CONFIG_BLOCK
> +
> +#include <linux/blk_types.h>
> +#include <linux/blkdev.h>
> +
> +struct request;
> +struct request_queue;
> +
> +#ifdef CONFIG_BLK_INLINE_ENCRYPTION

Does the #ifdef CONFIG_BLOCK buy us anything?
