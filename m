Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26BFB1273C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2019 04:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfLTDOT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Dec 2019 22:14:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:60728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726964AbfLTDOT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Dec 2019 22:14:19 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B7B7227BF;
        Fri, 20 Dec 2019 03:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576811657;
        bh=i/JjcA8h5CbmRck200pOTP3ojPM0o0poosCZdFpjszU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qRgozHrn8mu56X1O63Kee/qXyPqbZC1352FVJxUdGSgeniKQ4IJamGwvqq25qWoZs
         RJp5xWw97BEnQNM4org2+Xkh9LcLrUiP94yVyZ1grzl957aq4rYuoCV9X/NXqZnS5H
         lvtQYoswfexTMuRDZ1YR9d32LLErT24YBckvSfss=
Date:   Thu, 19 Dec 2019 19:14:16 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v6 3/9] block: blk-crypto for Inline Encryption
Message-ID: <20191220031416.GA718@sol.localdomain>
References: <20191218145136.172774-1-satyat@google.com>
 <20191218145136.172774-4-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218145136.172774-4-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 18, 2019 at 06:51:30AM -0800, Satya Tangirala wrote:
> diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
[...]
> +
> +/* The following few vars are only used during the crypto API fallback */
> +static struct kmem_cache *bio_fallback_crypt_ctx_cache;
> +static mempool_t *bio_fallback_crypt_ctx_pool;

The above comment is redundant now that this file only contains the crypto API
fallback.

> +static int blk_crypto_keyslot_program(struct keyslot_manager *ksm,
> +				      const struct blk_crypto_key *key,
> +				      unsigned int slot)
> +{
> +	struct blk_crypto_keyslot *slotp = &blk_crypto_keyslots[slot];
> +	const enum blk_crypto_mode_num crypto_mode = key->crypto_mode;
> +	int err;
> +
> +	if (crypto_mode != slotp->crypto_mode &&
> +	    slotp->crypto_mode != BLK_ENCRYPTION_MODE_INVALID) {
> +		blk_crypto_evict_keyslot(slot);
> +	}

Unnecessary braces.

> +
> +	if (!slotp->tfms[crypto_mode])
> +		return -ENOMEM;

This check seems pointless since blk_crypto_fallback_submit_bio() already
checked whether the tfms have been initialized for the crypto_mode or not.

> +/*
> + * The crypto API fallback's encryption routine.
> + * Allocate a bounce bio for encryption, encrypt the input bio using crypto API,
> + * and replace *bio_ptr with the bounce bio. May split input bio if it's too
> + * large.
> + */
> +static int blk_crypto_encrypt_bio(struct bio **bio_ptr)
> +{
> +	struct bio *src_bio;
> +	struct skcipher_request *ciph_req = NULL;
> +	DECLARE_CRYPTO_WAIT(wait);
> +	u64 curr_dun[BLK_CRYPTO_DUN_ARRAY_SIZE];
> +	union blk_crypto_iv iv;
> +	struct scatterlist src, dst;
> +	struct bio *enc_bio;
> +	unsigned int i, j;
> +	int data_unit_size;
> +	struct bio_crypt_ctx *bc;
> +	int err = 0;

When there are a lot of variables I feel it helps readability to declare them in
the order in which they are used.

> +		/* Encrypt each data unit in this page */
> +		for (j = 0; j < enc_bvec->bv_len; j += data_unit_size) {
> +			blk_crypto_dun_to_iv(curr_dun, &iv);
> +			err = crypto_wait_req(crypto_skcipher_encrypt(ciph_req),
> +					      &wait);
> +			if (err) {
> +				i++;
> +				src_bio->bi_status = BLK_STS_RESOURCE;
> +				goto out_free_bounce_pages;
> +			}
> +			bio_crypt_dun_increment(curr_dun, 1);
> +			src.offset += data_unit_size;
> +			dst.offset += data_unit_size;
> +		}
[...]
> +		/* Decrypt each data unit in the segment */
> +		for (i = 0; i < bv.bv_len; i += data_unit_size) {
> +			blk_crypto_dun_to_iv(curr_dun, &iv);
> +			if (crypto_wait_req(crypto_skcipher_decrypt(ciph_req),
> +					    &wait)) {
> +				bio->bi_status = BLK_STS_IOERR;
> +				goto out;
> +			}
> +			bio_crypt_dun_increment(curr_dun, 1);
> +			sg.offset += data_unit_size;
> +		}
> +	}

Encryption failure is using BLK_STS_RESOURCE whereas decryption failure is using
BLK_STS_IOERR.  They should use the same error code.

> +/*
> + * Queue bio for decryption.
> + * Returns true iff bio was queued for decryption.
> + */
> +bool blk_crypto_queue_decrypt_bio(struct bio *bio)
> +{
> +	struct blk_crypto_decrypt_work *decrypt_work;
> +
> +	/* If there was an IO error, don't queue for decrypt. */
> +	if (bio->bi_status)
> +		goto out;
> +
> +	decrypt_work = kmem_cache_zalloc(blk_crypto_decrypt_work_cache,
> +					 GFP_ATOMIC);
> +	if (!decrypt_work) {
> +		bio->bi_status = BLK_STS_RESOURCE;
> +		goto out;
> +	}
> +
> +	INIT_WORK(&decrypt_work->work, blk_crypto_decrypt_bio);
> +	decrypt_work->bio = bio;
> +	queue_work(blk_crypto_wq, &decrypt_work->work);
> +
> +	return true;
> +out:
> +	blk_crypto_free_fallback_crypt_ctx(bio);
> +	return false;
> +}

Needing to allocate a struct blk_crypto_decrypt_work for every bio adds some
complexity and introduces another point of failure.  How about embedding the
work_struct and back-pointer to the bio in the struct bio_fallback_crypt_ctx
instead?  Since bio_fallback_crypt_ctx and bio_crypt_ctx are now separate, this
approach would no longer add any overhead to hardware inline encryption.

> +
> +/**
> + * blk_crypto_start_using_mode() - Start using a crypto algorithm on a device
> + * @mode_num: the blk_crypto_mode we want to allocate ciphers for.
> + * @data_unit_size: the data unit size that will be used
> + * @q: the request queue for the device
> + *
> + * Upper layers must call this function to ensure that a the crypto API fallback
> + * has transforms for this algorithm, if they become necessary.
> + *
> + * Return: 0 on success and -err on error.
> + */
> +int blk_crypto_start_using_mode(enum blk_crypto_mode_num mode_num,
> +				unsigned int data_unit_size,
> +				struct request_queue *q)
> +{

I think it would make more sense to put the request_queue parameter first.

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
> +	/*
> +	 * If the keyslot manager of the request queue supports this
> +	 * crypto mode, then we don't need to allocate this mode.
> +	 */
> +	if (keyslot_manager_crypto_mode_supported(q->ksm, mode_num,
> +						  data_unit_size))
> +		return 0;
> +
> +	mutex_lock(&tfms_init_lock);
> +	if (likely(tfms_inited[mode_num]))
> +		goto out;

Drop the second likely() since that case isn't really likely.

> +int blk_crypto_fallback_submit_bio(struct bio **bio_ptr)
> +{
> +	struct bio *bio = *bio_ptr;
> +	struct bio_crypt_ctx *bc = bio->bi_crypt_context;
> +	struct bio_fallback_crypt_ctx *f_ctx;
> +
> +	if (WARN_ON_ONCE(!tfms_inited[bc->bc_key->crypto_mode])) {
> +		bio->bi_status = BLK_STS_IOERR;
> +		return -EIO;
> +	}

The reason I had suggested the WARN here is because it went with a change to
make blk-crypto no longer try to fall back to the crypto API on keyslot
programming error.  But that change wasn't included in v6.  So this WARN can
currently be hit, so it's not appropriate for it to be a WARN.

> +int __init blk_crypto_fallback_init(void)
> +{
> +	int i;
> +	unsigned int crypto_mode_supported[BLK_ENCRYPTION_MODE_MAX];
> +
> +	prandom_bytes(blank_key, BLK_CRYPTO_MAX_KEY_SIZE);
> +
> +	/* All blk-crypto modes have a crypto API fallback. */
> +	for (i = 0; i < BLK_ENCRYPTION_MODE_MAX; i++)
> +		crypto_mode_supported[i] = 0xFFFFFFFF;
> +	crypto_mode_supported[BLK_ENCRYPTION_MODE_INVALID] = 0;
> +
> +	blk_crypto_ksm = keyslot_manager_create(blk_crypto_num_keyslots,
> +						&blk_crypto_ksm_ll_ops,
> +						crypto_mode_supported, NULL);
> +	if (!blk_crypto_ksm)
> +		return -ENOMEM;
> +
> +	blk_crypto_wq = alloc_workqueue("blk_crypto_wq",
> +					WQ_UNBOUND | WQ_HIGHPRI |
> +					WQ_MEM_RECLAIM, num_online_cpus());
> +	if (!blk_crypto_wq)
> +		return -ENOMEM;
> +
> +	blk_crypto_keyslots = kcalloc(blk_crypto_num_keyslots,
> +				      sizeof(blk_crypto_keyslots[0]),
> +				      GFP_KERNEL);
> +	if (!blk_crypto_keyslots)
> +		return -ENOMEM;
> +
> +	blk_crypto_bounce_page_pool =
> +		mempool_create_page_pool(num_prealloc_bounce_pg, 0);
> +	if (!blk_crypto_bounce_page_pool)
> +		return -ENOMEM;
> +
> +	blk_crypto_decrypt_work_cache = KMEM_CACHE(blk_crypto_decrypt_work,
> +						   SLAB_RECLAIM_ACCOUNT);
> +	if (!blk_crypto_decrypt_work_cache)
> +		return -ENOMEM;
> +
> +	bio_fallback_crypt_ctx_cache = KMEM_CACHE(bio_fallback_crypt_ctx, 0);
> +	if (!bio_fallback_crypt_ctx_cache)
> +		return -ENOMEM;
> +
> +	bio_fallback_crypt_ctx_pool =
> +		mempool_create_slab_pool(num_prealloc_fallback_crypt_ctxs,
> +					 bio_fallback_crypt_ctx_cache);
> +	if (!bio_fallback_crypt_ctx_pool)
> +		return -ENOMEM;
> +
> +	return 0;
> +}

All this memory gets pre-allocated at boot time when
CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK=y even if nothing uses it.

How about delaying all this initialization to blk_crypto_start_using_mode(),
similar to the crypto tfm allocations, so that people who don't need the
fallback don't pay the price of these memory allocations?

> +/**
> + * blk_crypto_submit_bio - handle submitting bio for inline encryption
> + *
> + * @bio_ptr: pointer to original bio pointer
> + *
> + * If the bio doesn't have inline encryption enabled or the submitter already
> + * specified a keyslot for the target device, do nothing.  Else, a raw key must
> + * have been provided, so acquire a device keyslot for it if supported.  Else,
> + * use the crypto API fallback.
> + *
> + * When the crypto API fallback is used for encryption, blk-crypto may choose to
> + * split the bio into 2 - the first one that will continue to be processed and
> + * the second one that will be resubmitted via generic_make_request.
> + * A bounce bio will be allocated to encrypt the contents of the aforementioned
> + * "first one", and *bio_ptr will be updated to this bounce bio.
> + *
> + * Return: 0 if bio submission should continue; nonzero if bio_endio() was
> + *	   already called so bio submission should abort.
> + */
> +int blk_crypto_submit_bio(struct bio **bio_ptr)
> +{
> +	struct bio *bio = *bio_ptr;
> +	struct request_queue *q;
> +	struct bio_crypt_ctx *bc = bio->bi_crypt_context;
> +	int err;
> +
> +	if (!bc || !bio_has_data(bio))
> +		return 0;
> +
> +	/*
> +	 * When a read bio is marked for fallback decryption, its bi_iter is
> +	 * saved so that when we decrypt the bio later, we know what part of it
> +	 * was marked for fallback decryption (when the bio is passed down after
> +	 * blk_crypto_submit bio, it may be split or advanced so we cannot rely
> +	 * on the bi_iter while decrypting in blk_crypto_endio)
> +	 */
> +	if (bio_crypt_fallback_crypted(bc))
> +		return 0;
> +
> +	err = bio_crypt_check_alignment(bio);
> +	if (err) {
> +		bio->bi_status = BLK_STS_IOERR;
> +		goto out;
> +	}
> +
> +	q = bio->bi_disk->queue;
> +
> +	if (bc->bc_ksm) {
> +		/* Key already programmed into device? */
> +		if (q->ksm == bc->bc_ksm)
> +			return 0;
> +
> +		/* Nope, release the existing keyslot. */
> +		bio_crypt_ctx_release_keyslot(bc);
> +	}
> +
> +	/* Get device keyslot if supported */
> +	if (keyslot_manager_crypto_mode_supported(q->ksm,
> +						  bc->bc_key->crypto_mode,
> +						  bc->bc_key->data_unit_size)) {
> +		err = bio_crypt_ctx_acquire_keyslot(bc, q->ksm);
> +		if (!err)
> +			return 0;
> +
> +		pr_warn_once("Failed to acquire keyslot for %s (err=%d).  Falling back to crypto API.\n",
> +			     bio->bi_disk->disk_name, err);
> +	}

I'm still not sure we should bother trying to fall back to the crypto API when
hardware keyslot programming fails, given that the crypto tfm's are unlikely to
have been allocated anyway.

> +/**
> + * blk_crypto_init_key() - Prepare a key for use with blk-crypto
> + * @blk_key: Pointer to the blk_crypto_key to initialize.
> + * @raw_key: Pointer to the raw key.  Must be the correct length for the chosen
> + *	     @crypto_mode; see blk_crypto_modes[].
> + * @crypto_mode: identifier for the encryption algorithm to use
> + * @data_unit_size: the data unit size to use for en/decryption
> + *
> + * Return: The blk_crypto_key that was prepared, or an ERR_PTR() on error.  When
> + *	   done using the key, it must be freed with blk_crypto_free_key().
> + */
> +int blk_crypto_init_key(struct blk_crypto_key *blk_key, const u8 *raw_key,
> +			enum blk_crypto_mode_num crypto_mode,
> +			unsigned int data_unit_size)

The "Return:" comment is outdated as this function got changed from allocation
semantics to init semantics, so that struct blk_crypto_key could be embedded in
another struct.  It should be changed to something that emphasizes that the
caller is responsible for zeroizing the keys, e.g.:

  Return: 0 on success, -errno on failure.  The caller is responsible for
          zeroizing both blk_key and raw_key when done with them.

> +/**
> + * blk_crypto_evict_key() - Evict a key from any inline encryption hardware
> + *			    it may have been programmed into
> + * @q: The request queue who's keyslot manager this key might have been
> + *     programmed into
> + * @key: The key to evict
> + *
> + * Upper layers (filesystems) should call this function to ensure that a key
> + * is evicted from hardware that it might have been programmed into. This
> + * will call keyslot_manager_evict_key on the queue's keyslot manager, if one
> + * exists, and supports the crypto algorithm with the specified data unit size.
> + * Otherwise, it will evict the key from the blk-crypto-fallback's ksm.
> + *
> + * Return: 0 on success, -err on error.
> + */
> +int blk_crypto_evict_key(struct request_queue *q,
> +			 const struct blk_crypto_key *key)
> +{
> +	if (q->ksm &&
> +	    keyslot_manager_crypto_mode_supported(q->ksm, key->crypto_mode,
> +						  key->data_unit_size))
> +		return keyslot_manager_evict_key(q->ksm, key);
> +
> +	return blk_crypto_fallback_evict_key(key);
> +}

As I mentioned on the keyslot manager patch, this should return 0 if the key
does not currently have a keyslot, as callers will consider that to be success.

- Eric
