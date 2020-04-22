Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A43D21B3B78
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 11:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgDVJfD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 05:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725912AbgDVJfC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 05:35:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2263C03C1A8;
        Wed, 22 Apr 2020 02:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xcFiTZSrglcMD8nwtpbYfjiJzGQ3uCCaDpM9G1wNLKM=; b=TXFsXmPaYrp/VOshmRq5oS5gpB
        mH8EcHlmIZWR7Ds6MAyC3WNS9aJnVXMn5IBRQHmpHDNAaqgSJtN3Y5dM+5jCkkUPU9VIPuHBa0J5w
        hVKMsEVfCMpOpt19u+puh31aNERk7mTEFexQ19XaWimZfLH1XSuJzkCOFd8jnMoINlW6iJf4GKT1E
        RtHfgCVYHHVVqS8qCgihDk98Z9DjyOAtOR0VdaskIIHBcg2iEBSQciGxpj3KTviLZLUNBiSzLB8Bz
        rcSYZiir5vXAA7VR8XsKJrTJqgSaZLCmWDx5eJUt+HUGpWpvnk6yp4wwRd0E7ZzdRp1l60YO9hHcs
        lXmKpV8A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRBmY-0006Xx-9a; Wed, 22 Apr 2020 09:35:02 +0000
Date:   Wed, 22 Apr 2020 02:35:02 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v10 03/12] block: Inline encryption support for blk-mq
Message-ID: <20200422093502.GB12290@infradead.org>
References: <20200408035654.247908-1-satyat@google.com>
 <20200408035654.247908-4-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408035654.247908-4-satyat@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +/**
> + * __blk_crypto_bio_prep - Prepare bio for inline encryption
> + *
> + * @bio_ptr: pointer to original bio pointer
> + *
> + * Succeeds if the bio doesn't have inline encryption enabled or if the bio
> + * crypt context provided for the bio is supported by the underlying device's
> + * inline encryption hardware. Ends the bio with error otherwise.
> + *
> + * Caller must ensure bio has bio_crypt_ctx.
> + *
> + * Return: true on success; false on error (and bio->bi_status will be set
> + *	   appropriately, and bio_endio() will have been called so bio
> + *	   submission should abort).
> + */
> +bool __blk_crypto_bio_prep(struct bio **bio_ptr)
> +{
> +	struct bio *bio = *bio_ptr;

Why is the bio passed by references?  As far as I can see it is never
changed.

> +
> +	/* Error if bio has no data. */
> +	if (WARN_ON_ONCE(!bio_has_data(bio)))
> +		goto fail;
> +
> +	if (!bio_crypt_check_alignment(bio))
> +		goto fail;
> +
> +	/*
> +	 * Success if device supports the encryption context, and blk-integrity
> +	 * isn't supported by device/is turned off.
> +	 */
> +	if (!blk_ksm_crypto_cfg_supported(bio->bi_disk->queue->ksm,
> +				&bio->bi_crypt_context->bc_key->crypto_cfg)) {

The indentation here looks odd.

> +		bio->bi_status = BLK_STS_NOTSUPP;
> +		goto fail;
> +	}
> +
> +	return true;
> +fail:
> +	bio_endio(*bio_ptr);

This seems to fail to set a status for the bio_has_data case,
and setting the status for bio_crypt_check_alignment should be moved
to here, where we also end the IO.

> + * __blk_crypto_rq_bio_prep - Prepare a request when its first bio is inserted
> + *
> + * @rq: The request to prepare
> + * @bio: The first bio being inserted into the request
> + *
> + * Frees the bio crypt context in the request's old rq->crypt_ctx, if any, and
> + * moves the bio crypt context of the bio into the request's rq->crypt_ctx.
> + */
> +void __blk_crypto_rq_bio_prep(struct request *rq, struct bio *bio)
> +{
> +	mempool_free(rq->crypt_ctx, bio_crypt_ctx_pool);
> +	rq->crypt_ctx = bio->bi_crypt_context;
> +	bio->bi_crypt_context = NULL;
> +}

This seems to be called in case of the both the initial request
creation and merging a bio into the request (although only the
front merge and not the back merge, which seems weird).

But even then the behvior seems odd as bio->bi_crypt_context becomes
NULL as soon as the bio is attached to a request, which seems like
a somewhat dangerous condition.  Maybe it works, but is it really worth
saving a little memory?  Why not just propagate the context of the first
bio to the request, and free them when the bio is completed?

Why do we always take the context from the bio instead of keeping
the one in the request?  After all we merge the bio into the request.

> +void __blk_crypto_rq_prep_clone(struct request *dst, struct request *src)
> +{
> +	dst->crypt_ctx = src->crypt_ctx;

Probably worth just open coding in the only caller..

> +
> +/**
> + * __blk_crypto_insert_cloned_request - Prepare a cloned request to be inserted
> + *					into a request queue.
> + * @rq: the request being queued
> + *
> + * Return: BLK_STS_OK on success, nonzero on error.
> + */
> +blk_status_t __blk_crypto_insert_cloned_request(struct request *rq)
> +{
> +	return blk_crypto_init_request(rq);

Same.

>  	__blk_queue_split(q, &bio, &nr_segs);
> @@ -2011,6 +2015,15 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
>  
>  	blk_mq_bio_to_request(rq, bio, nr_segs);
>  
> +	ret = blk_crypto_init_request(rq);
> +	if (ret != BLK_STS_OK) {
> +		bio->bi_status = ret;
> +		bio_endio(bio);
> +		blk_mq_free_request(rq);
> +		return BLK_QC_T_NONE;
> +	}

Didn't Eric have a comment last round that we shoul dtry this before
attaching the bio to simplify error handling?

> +#define BLK_CRYPTO_DUN_ARRAY_SIZE	(BLK_CRYPTO_MAX_IV_SIZE/sizeof(u64))

Please use whitespace before and after operators.
