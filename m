Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27A0B9F637
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2019 00:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbfH0WeV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Aug 2019 18:34:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfH0WeV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Aug 2019 18:34:21 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B50CF20856;
        Tue, 27 Aug 2019 22:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566945259;
        bh=z3xopfZ51WkV8awSgGyWZJzCisrDG8pyxGkIqqDVBSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IHnbWObz7IdfNCr+53RBoZHkmbFKif0Ubb3U5DkhOtvlRer9YxXdAsIT9YoL7Kidv
         Q22s8MGqTqqZZeT2DNSgZhSuqMttd550jyK2IOBeMRSVdo96htJcCV2bX9pl4maVMR
         Z2Gg+MPSg2Ep+r0t8NHplneXUJkCyIiA254+HXT8=
Date:   Tue, 27 Aug 2019 15:34:17 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v4 3/8] block: blk-crypto for Inline Encryption
Message-ID: <20190827223415.GC27166@gmail.com>
Mail-Followup-To: Satya Tangirala <satyat@google.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
References: <20190821075714.65140-1-satyat@google.com>
 <20190821075714.65140-4-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821075714.65140-4-satyat@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 21, 2019 at 12:57:09AM -0700, Satya Tangirala wrote:
> diff --git a/block/blk-crypto.c b/block/blk-crypto.c
> new file mode 100644
> index 000000000000..c8f06264a0f5
> --- /dev/null
> +++ b/block/blk-crypto.c
> @@ -0,0 +1,737 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2019 Google LLC
> + */
> +
> +/*
> + * Refer to Documentation/block/inline-encryption.txt for detailed explanation.
> + */
> +
> +#ifdef pr_fmt
> +#undef pr_fmt
> +#endif

This is the beginning of the file, so the

#ifdef pr_fmt
#undef pr_fmt
#endif

is unnecessary.

> +static struct blk_crypto_keyslot {
> +	struct crypto_skcipher *tfm;
> +	enum blk_crypto_mode_num crypto_mode;
> +	u8 key[BLK_CRYPTO_MAX_KEY_SIZE];
> +	struct crypto_skcipher *tfms[ARRAY_SIZE(blk_crypto_modes)];
> +} *blk_crypto_keyslots;

It would be helpful if there was a comment somewhere explaining what's going on
with the crypto tfms now, like:

/*
 * Allocating a crypto tfm during I/O can deadlock, so we have to preallocate
 * all a mode's tfms when that mode starts being used.  Since each mode may need
 * all the keyslots at some point, each mode needs its own tfm for each keyslot;
 * thus, a keyslot may contain tfms for multiple modes.  However, to match the
 * behavior of real inline encryption hardware (which only supports a single
 * encryption context per keyslot), we only allow one tfm per keyslot to be used
 * at a time.  Unused tfms have their keys cleared.
 */

Otherwise it's not at all obvious what's going on.

> +
> +static struct mutex tfms_lock[ARRAY_SIZE(blk_crypto_modes)];
> +static bool tfms_inited[ARRAY_SIZE(blk_crypto_modes)];
> +
> +struct work_mem {
> +	struct work_struct crypto_work;
> +	struct bio *bio;
> +};
> +
> +/* The following few vars are only used during the crypto API fallback */
> +static struct keyslot_manager *blk_crypto_ksm;
> +static struct workqueue_struct *blk_crypto_wq;
> +static mempool_t *blk_crypto_page_pool;
> +static struct kmem_cache *blk_crypto_work_mem_cache;
> +
> +bool bio_crypt_swhandled(struct bio *bio)
> +{
> +	return bio_has_crypt_ctx(bio) &&
> +	       bio->bi_crypt_context->processing_ksm == blk_crypto_ksm;
> +}
> +
> +static const u8 zeroes[BLK_CRYPTO_MAX_KEY_SIZE];
> +static void evict_keyslot(unsigned int slot)
> +{
> +	struct blk_crypto_keyslot *slotp = &blk_crypto_keyslots[slot];
> +	enum blk_crypto_mode_num crypto_mode = slotp->crypto_mode;
> +
> +	/* Clear the key in the skcipher */
> +	crypto_skcipher_setkey(slotp->tfms[crypto_mode], zeroes,
> +			       blk_crypto_modes[crypto_mode].keysize);
> +	memzero_explicit(slotp->key, BLK_CRYPTO_MAX_KEY_SIZE);
> +}

Unfortunately setting the all-zeroes key won't work, because the all-zeroes key
fails the "weak key" check for XTS, as its two halves are the same.

Presumably this wasn't noticed during testing because the return value of
crypto_skcipher_setkey() is ignored.  So I suggest adding a WARN_ON():

	err = crypto_skcipher_setkey(slotp->tfms[crypto_mode], blank_key,
				     blk_crypto_modes[crypto_mode].keysize);
	WARN_ON(err);

Then for the actual fix, maybe set a random key instead of an all-zeroes one?

> +
> +static int blk_crypto_keyslot_program(void *priv, const u8 *key,
> +				      enum blk_crypto_mode_num crypto_mode,
> +				      unsigned int data_unit_size,
> +				      unsigned int slot)
> +{
> +	struct blk_crypto_keyslot *slotp = &blk_crypto_keyslots[slot];
> +	const struct blk_crypto_mode *mode = &blk_crypto_modes[crypto_mode];
> +	size_t keysize = mode->keysize;
> +	int err;
> +
> +	if (crypto_mode != slotp->crypto_mode) {
> +		evict_keyslot(slot);
> +		slotp->crypto_mode = crypto_mode;
> +	}

Currently the crypto_mode of every blk_crypto_keyslot starts out as AES_256_XTS
(0).  So if the user starts by choosing some other mode, this will immediately
call evict_keyslot() and crash dereferencing a NULL pointer.

To fix this, how about initializing all the modes to
BLK_ENCRYPTION_MODE_INVALID?

Then here the code would need to be:

	if (crypto_mode != slotp->crypto_mode &&
	    slotp->crypto_mode != BLK_ENCRYPTION_MODE_INVALID)
		evict_keyslot(slot);

And evict_keyslot() should invalidate the crypto_mode:

static void evict_keyslot(unsigned int slot)
{
	...

	slotp->crypto_mode = BLK_ENCRYPTION_MODE_INVALID;
}

> +
> +static int blk_crypto_keyslot_evict(void *priv, const u8 *key,
> +				    enum blk_crypto_mode_num crypto_mode,
> +				    unsigned int data_unit_size,
> +				    unsigned int slot)
> +{
> +	evict_keyslot(slot);
> +	return 0;
> +}

It might be useful to have a WARN_ON() here if the keyslot isn't in use
(i.e., if slotp->crypto_mode == BLK_ENCRYPTION_MODE_INVALID).

> +int blk_crypto_submit_bio(struct bio **bio_ptr)
> +{
> +	struct bio *bio = *bio_ptr;
> +	struct request_queue *q;
> +	int err;
> +	struct bio_crypt_ctx *crypt_ctx;
> +
> +	if (!bio_has_crypt_ctx(bio) || !bio_has_data(bio))
> +		return 0;
> +
> +	/*
> +	 * When a read bio is marked for sw decryption, its bi_iter is saved
> +	 * so that when we decrypt the bio later, we know what part of it was
> +	 * marked for sw decryption (when the bio is passed down after
> +	 * blk_crypto_submit bio, it may be split or advanced so we cannot rely
> +	 * on the bi_iter while decrypting in blk_crypto_endio)
> +	 */
> +	if (bio_crypt_swhandled(bio))
> +		return 0;
> +
> +	err = bio_crypt_check_alignment(bio);
> +	if (err)
> +		goto out;

Need to set ->bi_status if bio_crypt_check_alignment() fails.

> +bool blk_crypto_endio(struct bio *bio)
> +{
> +	if (!bio_has_crypt_ctx(bio))
> +		return true;
> +
> +	if (bio_crypt_swhandled(bio)) {
> +		/*
> +		 * The only bios that are swhandled when they reach here
> +		 * are those with bio_data_dir(bio) == READ, since WRITE
> +		 * bios that are encrypted by the crypto API fallback are
> +		 * handled by blk_crypto_encrypt_endio.
> +		 */
> +
> +		/* If there was an IO error, don't decrypt. */
> +		if (bio->bi_status)
> +			return true;
> +
> +		blk_crypto_queue_decrypt_bio(bio);
> +		return false;
> +	}
> +
> +	if (bio_has_crypt_ctx(bio) && bio_crypt_has_keyslot(bio))
> +		bio_crypt_ctx_release_keyslot(bio);

No need to check bio_has_crypt_ctx(bio) here, as it was already checked above.

> +int blk_crypto_mode_alloc_ciphers(enum blk_crypto_mode_num mode_num)
> +{
> +	struct blk_crypto_keyslot *slotp;
> +	int err = 0;
> +	int i;
> +
> +	/* Fast path */
> +	if (likely(READ_ONCE(tfms_inited[mode_num]))) {
> +		/*
> +		 * Ensure that updates to blk_crypto_keyslots[i].tfms[mode_num]
> +		 * for each i are visible before we try to access them.
> +		 */
> +		smp_rmb();
> +		return 0;
> +	}

I think we want smp_load_acquire() here.

	/* pairs with smp_store_release() below */
	if (smp_load_acquire(&tfms_inited[mode_num]))
		return 0;

> +
> +	mutex_lock(&tfms_lock[mode_num]);
> +	if (likely(tfms_inited[mode_num]))
> +		goto out;
> +
> +	for (i = 0; i < blk_crypto_num_keyslots; i++) {
> +		slotp = &blk_crypto_keyslots[i];
> +		slotp->tfms[mode_num] = crypto_alloc_skcipher(
> +					blk_crypto_modes[mode_num].cipher_str,
> +					0, 0);
> +		if (IS_ERR(slotp->tfms[mode_num])) {
> +			err = PTR_ERR(slotp->tfms[mode_num]);
> +			slotp->tfms[mode_num] = NULL;
> +			goto out_free_tfms;
> +		}
> +
> +		crypto_skcipher_set_flags(slotp->tfms[mode_num],
> +					  CRYPTO_TFM_REQ_FORBID_WEAK_KEYS);
> +	}
> +
> +	/*
> +	 * Ensure that updates to blk_crypto_keyslots[i].tfms[mode_num]
> +	 * for each i are visible before we set tfms_inited[mode_num].
> +	 */
> +	smp_wmb();
> +	WRITE_ONCE(tfms_inited[mode_num], true);
> +	goto out;

... and smp_store_release() here.

	/* pairs with smp_load_acquire() above */
	smp_store_release(&tfms_inited[mode_num], true);
	goto out;

- Eric
