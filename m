Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715631BF0B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Apr 2020 09:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgD3HBz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Apr 2020 03:01:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:56766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726337AbgD3HBz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Apr 2020 03:01:55 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF6312082E;
        Thu, 30 Apr 2020 07:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588230114;
        bh=VkPQbnpx+zf8DgFLC0fcN2jRxOU34cNTULVNWSlQdWY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UA8yXGr++xLigJVs/jXtlrQ6VuNUKgmOw5ji3uAEJ74a0oUl0O0xO12WLD/whjS0a
         E9n2UfN1np5uZeZ9yT/XrQru7HEvlxB+XfHsHDp0fpw678cTIeHfBpUQ0NA6u8TLid
         OH92FcqNSpJw/6F20XpFADdwLz3zjI/BKDRJR4rI=
Date:   Thu, 30 Apr 2020 00:01:52 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v11 03/12] block: Inline encryption support for blk-mq
Message-ID: <20200430070152.GB16238@sol.localdomain>
References: <20200429072121.50094-1-satyat@google.com>
 <20200429072121.50094-4-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429072121.50094-4-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 29, 2020 at 07:21:12AM +0000, Satya Tangirala wrote:
> diff --git a/block/blk-crypto.c b/block/blk-crypto.c
[...]

> +void bio_crypt_dun_increment(u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE],
> +			     unsigned int inc)
> +{
> +	int i = 0;
> +
> +	while (inc && i < BLK_CRYPTO_DUN_ARRAY_SIZE) {
> +		dun[i] += inc;
> +		inc = (dun[i] < inc);
> +		i++;
> +	}
> +}

Like bio_crypt_dun_is_contiguous(), this could use a comment like:

/* Increments @dun by @inc, treating @dun as a multi-limb integer. */

> +
> +void __bio_crypt_advance(struct bio *bio, unsigned int bytes)
> +{
> +	struct bio_crypt_ctx *bc = bio->bi_crypt_context;
> +
> +	bio_crypt_dun_increment(bc->bc_dun,
> +				bytes >> bc->bc_key->data_unit_size_bits);
> +}
> +
> +/*
> + * Returns true if @bc_dun plus @bytes converted to data units is equal to

@bc->bc_dun, not @bc_dun.

> + * @next_dun, treating the DUNs as multi-limb integers.
> + */
> +bool bio_crypt_dun_is_contiguous(const struct bio_crypt_ctx *bc,
> +				 unsigned int bytes,
> +				 const u64 next_dun[BLK_CRYPTO_DUN_ARRAY_SIZE])
> +{
> +	int i = 0;
> +	unsigned int carry = bytes >> bc->bc_key->data_unit_size_bits;
> +
> +	while (i < BLK_CRYPTO_DUN_ARRAY_SIZE) {
> +		if (bc->bc_dun[i] + carry != next_dun[i])
> +			return false;
> +		/*
> +		 * If the addition in this limb overflowed, then we need to
> +		 * carry 1 into the next limb. Else the carry is 0.
> +		 */
> +		if ((bc->bc_dun[i] + carry) < carry)
> +			carry = 1;
> +		else
> +			carry = 0;
> +		i++;
> +	}

This would be simpler as a 'for' loop.

Maybe switch bio_crypt_dun_increment() to use 'for' as well:
 'for (i = 0; inc && i < BLK_CRYPTO_DUN_ARRAY_SIZE; i++)'

> +/*
> + * Checks that two bio crypt contexts are compatible, and also
> + * that their data_unit_nums are continuous (and can hence be merged)
> + * in the order b_1 followed by b_2.
> + */
> +bool bio_crypt_ctx_mergeable(struct bio_crypt_ctx *bc1, unsigned int bc1_bytes,
> +			     struct bio_crypt_ctx *bc2)

@bc1 and @bc2, not "b_1" and "b_2".

> +/*
> + * Check that all I/O segments are data unit aligned, and set bio->bi_status
> + * on error.
> + */
> +static bool bio_crypt_check_alignment(struct bio *bio)
> +{
> +	const unsigned int data_unit_size =
> +		bio->bi_crypt_context->bc_key->crypto_cfg.data_unit_size;
> +	struct bvec_iter iter;
> +	struct bio_vec bv;
> +
> +	bio_for_each_segment(bv, bio, iter) {
> +		if (!IS_ALIGNED(bv.bv_len | bv.bv_offset, data_unit_size))
> +			return false;
> +	}
> +
> +	return true;
> +}

The comment above this function is outdated.  IMO just simplify it to one line:

/* Check that all I/O segments are data unit aligned. */

> +bool __blk_crypto_bio_prep(struct bio **bio_ptr)
> +{
> +	struct bio *bio = *bio_ptr;
> +	const struct blk_crypto_key *bc_key = bio->bi_crypt_context->bc_key;
> +	blk_status_t blk_st = BLK_STS_IOERR;
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

This comment gets replaced later in the series by:

        /*
         * Success if device supports the encryption context, or we succeeded
         * in falling back to the crypto API.
         */

I think it should just start out like that?
(Also: ", or we succeeded" => "or if we succeeded".)

> +/**
> + * blk_crypto_start_using_key() - Start using a blk_crypto_key on a device
> + * @key: A key to use on the device
> + * @q: the request queue for the device
> + *
> + * Upper layers must call this function to ensure that the hardware supports
> + * the key's crypto settings.
> + *
> + * Return: 0 on success; -ENOPKG if the hardware doesn't support the key
> + */
> +int blk_crypto_start_using_key(const struct blk_crypto_key *key,
> +			       struct request_queue *q)
> +{
> +	if (blk_ksm_crypto_cfg_supported(q->ksm, &key->crypto_cfg))
> +		return 0;
> +	return -ENOPKG;
> +}
> +EXPORT_SYMBOL_GPL(blk_crypto_start_using_key);

Like blk_crypto_init_key(), bio_crypt_set_ctx(), and blk_crypto_evict_key(),
this is only used by fs/crypto/ which is non-modular, so this doesn't need
EXPORT_SYMBOL_GPL() yet.

> +/**
> + * blk_crypto_evict_key() - Evict a key from any inline encryption hardware
> + *			    it may have been programmed into
> + * @q: The request queue who's associated inline encryption hardware this key
> + *     might have been programmed into
> + * @key: The key to evict
> + *
> + * Upper layers (filesystems) should call this function to ensure that a key
> + * is evicted from hardware that it might have been programmed into. This
> + * will call blk_ksm_evict_key on the queue's keyslot manager, if one
> + * exists, and supports the crypto algorithm with the specified data unit size.

This bit about calling blk_ksm_evict_key() gets deleted later in the series.  It
should be deleted in this patch too.

Also, due to the keyslot manager changes in v11, we should replace "should call"
with "must call" and mention the "no I/O in flight" requirement, e.g.:

 * Upper layers (filesystems) must call this function to ensure that a key is
 * evicted from any hardware that it might have been programmed into.  The key
 * must not be in use by any in-flight IO when this function is called.

> + *
> + * Return: 0 on success or if key is not present in the q's ksm, -err on error.
> + */
> +int blk_crypto_evict_key(struct request_queue *q,
> +			 const struct blk_crypto_key *key)
> +{
> +	if (q->ksm && blk_ksm_crypto_cfg_supported(q->ksm, &key->crypto_cfg))
> +		return blk_ksm_evict_key(q->ksm, key);

Since blk_ksm_crypto_cfg_supported() handles a NULL ksm (returns false), the
NULL check here can be removed.

- Eric
