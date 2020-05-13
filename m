Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63CE21D1CF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 20:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390088AbgEMSFa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 14:05:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390038AbgEMSFa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 14:05:30 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C06BB20659;
        Wed, 13 May 2020 18:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589393130;
        bh=s05yTJaJ2U7VPeAsl86vdaH+LHnd7rgYFl+s/FhtxDQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l53rt7Jg1VZ1vN8qaLqR66Jj869Gfdem81Rm7UNH+doDXsfeAfBcHsW6f0jhbVxyR
         rLlwJ0ZJ1tWTRl0PeQzVcYkXg2mktappox+Aya1s8YtjZQufMhI3JeGpkVbA/m8Y/N
         ScL5AC2Tzm0ntsf6eYnFfhgvw7yA2Nohsr1DH0jo=
Date:   Wed, 13 May 2020 11:05:27 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v12 05/12] block: blk-crypto-fallback for Inline
 Encryption
Message-ID: <20200513180527.GE1243@sol.localdomain>
References: <20200430115959.238073-1-satyat@google.com>
 <20200430115959.238073-6-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430115959.238073-6-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 30, 2020 at 11:59:52AM +0000, Satya Tangirala wrote:
> Blk-crypto delegates crypto operations to inline encryption hardware when
> available. The separately configurable blk-crypto-fallback contains a
> software fallback to the kernel crypto API - when enabled, blk-crypto
> will use this fallback for en/decryption when inline encryption hardware is
> not available. This lets upper layers not have to worry about whether or
> not the underlying device has support for inline encryption before
> deciding to specify an encryption context for a bio. It also allows for
> testing without actual inline encryption hardware - in particular, it
> makes it possible to test the inline encryption code in ext4 and f2fs
> simply by running xfstests with the inlinecrypt mount option, which in
> turn allows for things like the regular upstream regression testing of
> ext4 to cover the inline encryption code paths. For more details, refer
> to Documentation/block/inline-encryption.rst.
> 
> Signed-off-by: Satya Tangirala <satyat@google.com>

Generally looks good, you can add:

    Reviewed-by: Eric Biggers <ebiggers@google.com>

A few comments below for when you resend.  Also, can you split the paragraph
above into multiple?  E.g.

	Blk-crypto delegates...

	This lets upper layers...

	For more details, refer to...

> +static int blk_crypto_keyslot_program(struct blk_keyslot_manager *ksm,
> +				      const struct blk_crypto_key *key,
> +				      unsigned int slot)
> +{
> +	struct blk_crypto_keyslot *slotp = &blk_crypto_keyslots[slot];
> +	const enum blk_crypto_mode_num crypto_mode =
> +						key->crypto_cfg.crypto_mode;
> +	int err;
> +
> +	if (crypto_mode != slotp->crypto_mode &&
> +	    slotp->crypto_mode != BLK_ENCRYPTION_MODE_INVALID)
> +		blk_crypto_evict_keyslot(slot);
> +
> +	slotp->crypto_mode = crypto_mode;
> +	err = crypto_skcipher_setkey(slotp->tfms[crypto_mode], key->raw,
> +				     key->size);
> +	if (err) {
> +		blk_crypto_evict_keyslot(slot);
> +		return -EIO;
> +	}
> +	return 0;
> +}

Shouldn't this just return 'err'?  Is there a good reason for EIO?

> +static bool blk_crypto_alloc_cipher_req(struct bio *src_bio,
> +					struct blk_ksm_keyslot *slot,
> +					struct skcipher_request **ciph_req_ret,
> +					struct crypto_wait *wait)
> +{
> +	struct skcipher_request *ciph_req;
> +	const struct blk_crypto_keyslot *slotp;
> +	int keyslot_idx = blk_ksm_get_slot_idx(slot);
> +
> +	slotp = &blk_crypto_keyslots[keyslot_idx];
> +	ciph_req = skcipher_request_alloc(slotp->tfms[slotp->crypto_mode],
> +					  GFP_NOIO);
> +	if (!ciph_req) {
> +		src_bio->bi_status = BLK_STS_RESOURCE;
> +		return false;
> +	}
> +
> +	skcipher_request_set_callback(ciph_req,
> +				      CRYPTO_TFM_REQ_MAY_BACKLOG |
> +				      CRYPTO_TFM_REQ_MAY_SLEEP,
> +				      crypto_req_done, wait);
> +	*ciph_req_ret = ciph_req;
> +
> +	return true;
> +}

I think it would be better to remove the 'src_bio' argument from here and make
the two callers set BLK_STS_RESOURCE instead.  See e.g.
bio_crypt_check_alignment() which uses a similar convention.

> +/**
> + * blk_crypto_fallback_decrypt_endio - clean up bio w.r.t fallback decryption
> + *
> + * @bio: the bio to clean up.
> + *
> + * Restore bi_private and bi_end_io, and queue the bio for decryption into a
> + * workqueue, since this function will be called from an atomic context.
> + */

"clean up bio w.r.t fallback decryption" is misleading, since the main point of
this function is to queue the bio for decryption.  How about:

/**
 * blk_crypto_fallback_decrypt_endio - queue bio for fallback decryption
 *
 * @bio: the bio to queue
 *
 * Restore bi_private and bi_end_io, and queue the bio for decryption into a
 * workqueue, since this function will be called from an atomic context.
 */

> +bool blk_crypto_fallback_bio_prep(struct bio **bio_ptr)
> +{
> +	struct bio *bio = *bio_ptr;
> +	struct bio_crypt_ctx *bc = bio->bi_crypt_context;
> +	struct bio_fallback_crypt_ctx *f_ctx;
> +
> +	if (!tfms_inited[bc->bc_key->crypto_cfg.crypto_mode]) {
> +		bio->bi_status = BLK_STS_IOERR;
> +		return false;
> +	}

This can only happen if the user forgot to call blk_crypto_start_using_key().
And if someone does that, it might be hard for them to understand why they're
getting IOERR.  A WARN_ON_ONCE() and a comment would help:

	if (WARN_ON_ONCE(!tfms_inited[bc->bc_key->crypto_cfg.crypto_mode])) {
		/* User didn't call blk_crypto_start_using_key() first */
		bio->bi_status = BLK_STS_IOERR;
		return false;
	}

This would be similar to how __blk_crypto_bio_prep() does
WARN_ON_ONCE(!bio_has_data(bio)) to catch another type of usage error.

> +/*
> + * Prepare blk-crypto-fallback for the specified crypto mode.
> + * Returns -ENOPKG if the needed crypto API support is missing.
> + */
> +int blk_crypto_fallback_start_using_mode(enum blk_crypto_mode_num mode_num)
> +{
> +	const char *cipher_str = blk_crypto_modes[mode_num].cipher_str;
> +	struct blk_crypto_keyslot *slotp;
> +	unsigned int i;
> +	int err = 0;
> +
> +	/*
> +	 * Fast path
> +	 * Ensure that updates to blk_crypto_keyslots[i].tfms[mode_num]
> +	 * for each i are visible before we try to access them.
> +	 */
> +	if (likely(smp_load_acquire(&tfms_inited[mode_num])))
> +		return 0;
> +
> +	mutex_lock(&tfms_init_lock);
> +	err = blk_crypto_fallback_init();
> +	if (err)
> +		goto out;
> +
> +	if (tfms_inited[mode_num])
> +		goto out;

It would make more sense to check tfms_inited[mode_num] immediately after
acquiring the mutex, given that it's checked before.

- Eric
