Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4DE447C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 19:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbfFMRBh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 13:01:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:58974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729569AbfFLXeZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jun 2019 19:34:25 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA7ED20B7C;
        Wed, 12 Jun 2019 23:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560382464;
        bh=RfulGs94WgCZ7jdQnoQye9yf6n83P2Bg2N+gSa96+HM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n0pS4W7UF2IlkrbdQdfTEseJRJrV1850WLBEahplmQnSH7lnqEDu0DDX4ukQ7uGPp
         mLCsLCXTqe97BaHf21tZycFyScLO90zoX/fbOO+75AzRv47Znxg199rdZaUmNy95Nj
         +ytHTkCgv7bGKx90xsMFTmxJ1dED2EkELwd90cQY=
Date:   Wed, 12 Jun 2019 16:34:22 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Parshuram Raju Thombare <pthombar@cadence.com>,
        Ladvine D Almeida <ladvine.dalmeida@synopsys.com>,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>
Subject: Re: [RFC PATCH v2 3/8] block: blk-crypto for Inline Encryption
Message-ID: <20190612233421.GA99597@gmail.com>
References: <20190605232837.31545-1-satyat@google.com>
 <20190605232837.31545-4-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190605232837.31545-4-satyat@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 05, 2019 at 04:28:32PM -0700, Satya Tangirala wrote:
> We introduce blk-crypto, which manages programming keyslots for struct
> bios. With blk-crypto, filesystems only need to call bio_crypt_set_ctx with
> the encryption key, algorithm and data_unit_num; they don't have to worry
> about getting a keyslot for each encryption context, as blk-crypto handles
> that. Blk-crypto also makes it possible for layered devices like device
> mapper to make use of inline encryption hardware.
> 
> Blk-crypto delegates crypto operations to inline encryption hardware when
> available, and also contains a software fallback to the kernel crypto API.
> For more details, refer to Documentation/block/blk-crypto.txt.
> 
> Known issues:
> 1) We're allocating crypto_skcipher in blk_crypto_keyslot_program, which
>    uses GFP_KERNEL to allocate memory, but this function is on the write
>    path for IO - we need to add support for specifying a different flags
>    to the crypto API.
> 
> Signed-off-by: Satya Tangirala <satyat@google.com>
> ---
>  Documentation/block/blk-crypto.txt | 185 ++++++++++
>  block/Kconfig                      |   8 +
>  block/Makefile                     |   2 +
>  block/bio.c                        |   5 +
>  block/blk-core.c                   |  11 +-
>  block/blk-crypto.c                 | 558 +++++++++++++++++++++++++++++
>  include/linux/blk-crypto.h         |  40 +++
>  7 files changed, 808 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/block/blk-crypto.txt
>  create mode 100644 block/blk-crypto.c
>  create mode 100644 include/linux/blk-crypto.h
> 
> diff --git a/Documentation/block/blk-crypto.txt b/Documentation/block/blk-crypto.txt
> new file mode 100644
> index 000000000000..96a7983a117d
> --- /dev/null
> +++ b/Documentation/block/blk-crypto.txt
> @@ -0,0 +1,185 @@
> +BLK-CRYPTO and KEYSLOT MANAGER
> +===========================

How about renaming this documentation file to inline-encryption.txt and making
sure it covers the inline encryption feature as a whole?  "blk-crypto" is just
part of it.

> diff --git a/block/Makefile b/block/Makefile
> index eee1b4ceecf9..5d38ea437937 100644
> --- a/block/Makefile
> +++ b/block/Makefile
> @@ -35,3 +35,5 @@ obj-$(CONFIG_BLK_DEBUG_FS)	+= blk-mq-debugfs.o
>  obj-$(CONFIG_BLK_DEBUG_FS_ZONED)+= blk-mq-debugfs-zoned.o
>  obj-$(CONFIG_BLK_SED_OPAL)	+= sed-opal.o
>  obj-$(CONFIG_BLK_PM)		+= blk-pm.o
> +obj-$(CONFIG_BLK_INLINE_ENCRYPTION)	+= blk-crypt-ctx.o blk-crypto.o \
> +					     keyslot-manager.o

Two of these .c files were added by earlier patches, but they're not compiled
until now.  The usual practice is to make the code actually compiled after each
patch, e.g. by introducing the kconfig option first.  Otherwise there can be
build errors that don't show up until suddenly all the code is enabled at once.

> diff --git a/block/blk-crypto.c b/block/blk-crypto.c
> new file mode 100644
> index 000000000000..5adb5251ae7e
> --- /dev/null
> +++ b/block/blk-crypto.c
> @@ -0,0 +1,558 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2019 Google LLC
> + */
> +#include <linux/blk-crypto.h>
> +#include <linux/keyslot-manager.h>
> +#include <linux/mempool.h>
> +#include <linux/blk-cgroup.h>
> +#include <crypto/skcipher.h>
> +#include <crypto/algapi.h>
> +
> +struct blk_crypt_mode {
> +	const char *friendly_name;
> +	const char *cipher_str;
> +	size_t keysize;
> +	size_t ivsize;
> +	bool needs_essiv;
> +};

'friendly_name', 'ivsize', and 'needs_essiv' are unused.  So they should be
removed until they're actually needed.

> +
> +static const struct blk_crypt_mode blk_crypt_modes[] = {
> +	[BLK_ENCRYPTION_MODE_AES_256_XTS] = {
> +		.friendly_name = "AES-256-XTS",
> +		.cipher_str = "xts(aes)",
> +		.keysize = 64,
> +		.ivsize = 16,
> +	},
> +	/* TODO: the rest of the algs that fscrypt supports */
> +};

It's arguably a layering violation to mention fscrypt specifically here.  There
will eventually be other users of this too.

> +/* TODO: Do we want to make this user configurable somehow? */
> +#define BLK_CRYPTO_NUM_KEYSLOTS 100

This should be a kernel command line parameter.

> +
> +static unsigned int num_prealloc_bounce_pg = 32;

This should be a kernel command line parameter too.

> +
> +bool bio_crypt_swhandled(struct bio *bio)
> +{
> +	return bio_crypt_has_keyslot(bio) &&
> +	       bio->bi_crypt_context->processing_ksm == blk_crypto_ksm;
> +}

processing_ksm is NULL when there isn't a keyslot, so calling
bio_crypt_has_keyslot() isn't necessary here.

> +
> +/* TODO: handle modes that need essiv */
> +static int blk_crypto_keyslot_program(void *priv, const u8 *key,
> +				      enum blk_crypt_mode_num crypt_mode,
> +				      unsigned int data_unit_size,
> +				      unsigned int slot)
> +{
> +	struct blk_crypto_keyslot *slotp = &blk_crypto_keyslots[slot];
> +	struct crypto_skcipher *tfm = slotp->tfm;
> +	const struct blk_crypt_mode *mode = &blk_crypt_modes[crypt_mode];
> +	size_t keysize = mode->keysize;
> +	int err;
> +
> +	if (crypt_mode != slotp->crypt_mode || !tfm) {
> +		crypto_free_skcipher(slotp->tfm);
> +		slotp->tfm = NULL;
> +		memset(slotp->key, 0, BLK_CRYPTO_MAX_KEY_SIZE);
> +		tfm = crypto_alloc_skcipher(
> +			mode->cipher_str, 0, 0);
> +		if (IS_ERR(tfm))
> +			return PTR_ERR(tfm);
> +
> +		crypto_skcipher_set_flags(tfm,
> +					  CRYPTO_TFM_REQ_FORBID_WEAK_KEYS);
> +		slotp->crypt_mode = crypt_mode;
> +		slotp->tfm = tfm;
> +	}
> +
> +
> +	err = crypto_skcipher_setkey(tfm, key, keysize);
> +
> +	if (err) {
> +		crypto_free_skcipher(tfm);
> +		slotp->tfm = NULL;
> +		return err;
> +	}
> +
> +	memcpy(slotp->key, key, keysize);
> +
> +	return 0;
> +}
> +
> +static int blk_crypto_keyslot_evict(void *priv, const u8 *key,
> +				    enum blk_crypt_mode_num crypt_mode,
> +				    unsigned int data_unit_size,
> +				    unsigned int slot)
> +{
> +	crypto_free_skcipher(blk_crypto_keyslots[slot].tfm);
> +	blk_crypto_keyslots[slot].tfm = NULL;
> +	memset(blk_crypto_keyslots[slot].key, 0, BLK_CRYPTO_MAX_KEY_SIZE);
> +
> +	return 0;
> +}

If the call to crypto_skcipher_setkey() fails, then the ->tfm is set to NULL as
if the keyslot were free, but the raw key isn't wiped.  The state should be kept
consistent: the raw key of a free keyslot should always be zeroed.

The easiest way to handle this would be to add a helper function:

static void evict_keyslot(unsigned int slot)
{
	struct blk_crypto_keyslot *slotp = &blk_crypto_keyslots[slot];

	crypto_free_skcipher(slotp->tfm);
	slotp->tfm = NULL;
	memzero_explicit(slotp->key, BLK_CRYPTO_MAX_KEY_SIZE);
}

Then call this from the two places in blk_crypto_keyslot_program(), and from
blk_crypto_keyslot_evict().

(It doesn't really need to be memzero_explicit() instead of memset() here, but
it's good to make the intent of "this is wiping a crypto key" clear.)

> +
> +static int blk_crypto_keyslot_find(void *priv,
> +				   const u8 *key,
> +				   enum blk_crypt_mode_num crypt_mode,
> +				   unsigned int data_unit_size_bytes)
> +{
> +	int slot;
> +	const size_t keysize = blk_crypt_modes[crypt_mode].keysize;
> +
> +	/* TODO: hashmap? */
> +	for (slot = 0; slot < BLK_CRYPTO_NUM_KEYSLOTS; slot++) {
> +		if (blk_crypto_keyslots[slot].crypt_mode == crypt_mode &&
> +		    !crypto_memneq(blk_crypto_keyslots[slot].key, key,
> +				   keysize)) {
> +			return slot;
> +		}

Nit: can drop the braces here and fit the crypto_memneq() parameters on one
line.

> +static bool blk_crypt_mode_supported(void *priv,
> +				     enum blk_crypt_mode_num crypt_mode,
> +				     unsigned int data_unit_size)
> +{
> +	// Of course, blk-crypto supports all blk_crypt_modes.
> +	return true;
> +}

This actually isn't obvious, since there could be modes that are only supported
by particular hardware drivers.  It would be more helpful if the comment was:

	/* All blk_crypt_modes are required to have a software fallback. */

> +static void blk_crypto_put_keyslot(struct bio *bio)
> +{
> +	struct bio_crypt_ctx *crypt_ctx = bio->bi_crypt_context;
> +
> +	keyslot_manager_put_slot(crypt_ctx->processing_ksm, crypt_ctx->keyslot);
> +	bio_crypt_unset_keyslot(bio);
> +}
> +
> +static int blk_crypto_get_keyslot(struct bio *bio,
> +				      struct keyslot_manager *ksm)
> +{
> +	int slot;
> +	enum blk_crypt_mode_num crypt_mode = bio_crypt_mode(bio);
> +
> +	if (!ksm)
> +		return -ENOMEM;
> +
> +	slot = keyslot_manager_get_slot_for_key(ksm,
> +						bio_crypt_raw_key(bio),
> +						crypt_mode, PAGE_SIZE);

Needs to be '1 << crypt_ctx->data_unit_size_bits', not PAGE_SIZE.

> +	if (slot < 0)
> +		return slot;
> +
> +	bio_crypt_set_keyslot(bio, slot, ksm);
> +	return 0;
> +}

Since blk_crypto_{get,put}_keyslot() support any keyslot manager, naming them
blk_crypto is a bit confusing, since it suggests they might only be relevant to
the software fallback (blk_crypto_keyslots).  Maybe they should be renamed to
bio_crypt_{acquire,release}_keyslot() and moved to bio-crypt-ctx.c?

> +static int blk_crypto_encrypt_bio(struct bio **bio_ptr)
> +{
> +	struct bio *src_bio = *bio_ptr;
> +	int slot;
> +	struct skcipher_request *ciph_req = NULL;
> +	DECLARE_CRYPTO_WAIT(wait);
> +	struct bio_vec bv;
> +	struct bvec_iter iter;
> +	int err = 0;
> +	u64 curr_dun;
> +	union {
> +		__le64 dun;
> +		u8 bytes[16];
> +	} iv;
> +	struct scatterlist src, dst;
> +	struct bio *enc_bio;
> +	struct bio_vec *enc_bvec;
> +	int i, j;
> +	unsigned int num_sectors;
> +
> +	if (!blk_crypto_keyslots)
> +		return -ENOMEM;

Why the NULL check for blk_crypto_keyslots?  The kernel already panics if
blk_crypto_init() fails.

> +
> +	/* Split the bio if it's too big for single page bvec */
> +	i = 0;
> +	num_sectors = 0;
> +	bio_for_each_segment(bv, src_bio, iter) {
> +		num_sectors += bv.bv_len >> 9;
> +		if (++i == BIO_MAX_PAGES)
> +			break;
> +	}
> +	if (num_sectors < bio_sectors(src_bio)) {
> +		struct bio *split_bio;
> +
> +		split_bio = bio_split(src_bio, num_sectors, GFP_NOIO, NULL);
> +		if (!split_bio) {
> +			src_bio->bi_status = BLK_STS_RESOURCE;
> +			return -ENOMEM;
> +		}
> +		bio_chain(split_bio, src_bio);
> +		generic_make_request(src_bio);
> +		*bio_ptr = split_bio;
> +	}
> +
> +	src_bio = *bio_ptr;

This line can be moved into the previous 'if' block.

> +
> +	enc_bio = blk_crypto_clone_bio(src_bio);
> +	if (!enc_bio) {
> +		src_bio->bi_status = BLK_STS_RESOURCE;
> +		return -ENOMEM;
> +	}
> +
> +	err = blk_crypto_get_keyslot(src_bio, blk_crypto_ksm);
> +	if (err) {
> +		src_bio->bi_status = BLK_STS_IOERR;
> +		bio_put(enc_bio);
> +		return err;
> +	}
> +	slot = bio_crypt_get_slot(src_bio);
> +
> +	ciph_req = skcipher_request_alloc(blk_crypto_keyslots[slot].tfm,
> +					  GFP_NOIO);
> +	if (!ciph_req) {
> +		src_bio->bi_status = BLK_STS_RESOURCE;
> +		err = -ENOMEM;
> +		bio_put(enc_bio);
> +		goto out_release_keyslot;
> +	}
> +
> +	skcipher_request_set_callback(ciph_req,
> +				      CRYPTO_TFM_REQ_MAY_BACKLOG |
> +				      CRYPTO_TFM_REQ_MAY_SLEEP,
> +				      crypto_req_done, &wait);

This function and blk_crypto_decrypt_bio() are getting long.  To help a tiny
bit, maybe add a helper function blk_crypto_alloc_skcipher_request(bio) and call
it from both places?

> +
> +	curr_dun = bio_crypt_sw_data_unit_num(src_bio);
> +	sg_init_table(&src, 1);
> +	sg_init_table(&dst, 1);
> +	for (i = 0, enc_bvec = enc_bio->bi_io_vec; i < enc_bio->bi_vcnt;
> +	     enc_bvec++, i++) {
> +		struct page *page = enc_bvec->bv_page;
> +		struct page *ciphertext_page =
> +			mempool_alloc(blk_crypto_page_pool, GFP_NOFS);

GFP_NOIO, not GFP_NOFS.

> +
> +		enc_bvec->bv_page = ciphertext_page;
> +
> +		if (!ciphertext_page)
> +			goto no_mem_for_ciph_page;
> +
> +		memset(&iv, 0, sizeof(iv));
> +		iv.dun = cpu_to_le64(curr_dun);
> +
> +		sg_set_page(&src, page, enc_bvec->bv_len, enc_bvec->bv_offset);
> +		sg_set_page(&dst, ciphertext_page, enc_bvec->bv_len,
> +			    enc_bvec->bv_offset);
> +
> +		skcipher_request_set_crypt(ciph_req, &src, &dst,
> +					   enc_bvec->bv_len, iv.bytes);
> +		err = crypto_wait_req(crypto_skcipher_encrypt(ciph_req), &wait);
> +		if (err)
> +			goto no_mem_for_ciph_page;
> +
> +		curr_dun++;
> +		continue;
> +no_mem_for_ciph_page:
> +		err = -ENOMEM;
> +		for (j = i - 1; j >= 0; j--) {
> +			mempool_free(enc_bio->bi_io_vec->bv_page,
> +				     blk_crypto_page_pool);
> +		}

The error path needs to free bi_io_vec[j], not bi_io_vec.

> +/*
> + * TODO: assumption right now is:
> + * each segment in bio has length == the data_unit_size
> + */

This needs to be fixed, or else blk-crypto needs to reject using unsupported
data unit sizes.  But it seems it can be supported pretty easily by just looping
through each data unit in each bio segment.  To get some ideas you could look at
my patches queued in fscrypt.git that handle encrypting/decrypting filesystem
blocks smaller than PAGE_SIZE, e.g.
https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git/commit/?id=53bc1d854c64c20d967dab15b111baca02a6d99e

> +static void blk_crypto_decrypt_bio(struct work_struct *w)
> +{
> +	struct work_mem *work_mem =
> +		container_of(w, struct work_mem, crypto_work);
> +	struct bio *bio = work_mem->bio;
> +	int slot = bio_crypt_get_slot(bio);
> +	struct skcipher_request *ciph_req;
> +	DECLARE_CRYPTO_WAIT(wait);
> +	struct bio_vec bv;
> +	struct bvec_iter iter;
> +	u64 curr_dun;
> +	union {
> +		__le64 dun;
> +		u8 bytes[16];
> +	} iv;
> +	struct scatterlist sg;
> +
> +	curr_dun = bio_crypt_sw_data_unit_num(bio);
> +
> +	kmem_cache_free(blk_crypto_work_mem_cache, work_mem);
> +	ciph_req = skcipher_request_alloc(blk_crypto_keyslots[slot].tfm,
> +					  GFP_NOFS);
> +	if (!ciph_req) {
> +		bio->bi_status = BLK_STS_RESOURCE;
> +		goto out;
> +	}
> +
> +	skcipher_request_set_callback(ciph_req,
> +				      CRYPTO_TFM_REQ_MAY_BACKLOG |
> +				      CRYPTO_TFM_REQ_MAY_SLEEP,
> +				      crypto_req_done, &wait);
> +
> +	sg_init_table(&sg, 1);
> +	__bio_for_each_segment(bv, bio, iter,
> +			       bio->bi_crypt_context->crypt_iter) {
> +		struct page *page = bv.bv_page;
> +		int err;
> +
> +		memset(&iv, 0, sizeof(iv));
> +		iv.dun = cpu_to_le64(curr_dun);
> +
> +		sg_set_page(&sg, page, bv.bv_len, bv.bv_offset);
> +		skcipher_request_set_crypt(ciph_req, &sg, &sg,
> +					   bv.bv_len, iv.bytes);
> +		err = crypto_wait_req(crypto_skcipher_decrypt(ciph_req), &wait);
> +		if (err) {
> +			bio->bi_status = BLK_STS_IOERR;
> +			goto out;
> +		}
> +		curr_dun++;
> +	}
> +
> +out:
> +	skcipher_request_free(ciph_req);
> +	blk_crypto_put_keyslot(bio);
> +	bio_endio(bio);
> +}
> +
> +static void blk_crypto_queue_decrypt_bio(struct bio *bio)
> +{
> +	struct work_mem *work_mem =
> +		kmem_cache_zalloc(blk_crypto_work_mem_cache, GFP_ATOMIC);
> +
> +	if (!work_mem) {
> +		bio->bi_status = BLK_STS_RESOURCE;
> +		return bio_endio(bio);
> +	}

The keyslot needs to be released if allocating the work_mem fails.

However, I'm wondering: for software fallback decryption, why is the keyslot
allocated before the bio is submitted, rather than in the workqueue work after
the bio completes?  The actual decryption is already sleepable, so why not just
allocate the keyslot then too?  It would also make it more similar to the
software fallback encryption, which doesn't hold the keyslot during I/O.

> +
> +	INIT_WORK(&work_mem->crypto_work, blk_crypto_decrypt_bio);
> +	work_mem->bio = bio;
> +	queue_work(blk_crypto_wq, &work_mem->crypto_work);
> +}
> +
> +/*
> + * Ensures that:
> + * 1) The bio’s encryption context is programmed into a keyslot in the
> + * keyslot manager (KSM) of the request queue that the bio is being submitted
> + * to (or the software fallback KSM if the request queue doesn’t have a KSM),
> + * and that the processing_ksm in the bi_crypt_context of this bio is set to
> + * this KSM.
> + *
> + * 2) That the bio has a reference to this keyslot in this KSM.
> + */

Make this into a proper kerneldoc comment that has a one-line function overview
and documents the return value?  For example:

/**
 * blk_crypto_submit_bio - handle submitting bio for inline encryption
 *
 * @bio_ptr: pointer to original bio pointer
 *
 * If the bio doesn't have inline encryption enabled or the submitter already
 * specified a keyslot for the target device, do nothing.  Else, a raw key must
 * have been provided, so acquire a device keyslot for it if supported.  Else,
 * use the software crypto fallback.
 * 
 * [Something about the software crypto fallback and how it may update
 * *bio_ptr.]
 *
 * Return: 0 if bio submission should continue; nonzero if bio_endio() was
 *        already called so bio submission should abort.
  */

> +int blk_crypto_submit_bio(struct bio **bio_ptr)
> +{
> +	struct bio *bio = *bio_ptr;
> +	struct request_queue *q;
> +	int err;
> +	enum blk_crypt_mode_num crypt_mode;

The 'crypt_mode' variable is never used.

> +	struct bio_crypt_ctx *crypt_ctx;
> +
> +	if (!bio_has_data(bio))
> +		return 0;
> +
> +	if (!bio_is_encrypted(bio) || bio_crypt_swhandled(bio))
> +		return 0;

Why is bio_crypt_swhandled() checked here?

Also consider reordering these checks to:

	if (!bio_is_encrypted(bio) || !bio_has_data(bio))
		return 0;

	/* comment */
	if (bio_crypt_swhandled(bio))
		return 0;

!bio_is_encrypted() is the most common case, so for efficiency should be checked
first.  !bio_is_encrypted() and !bio_has_data() are also easy to understand and
kind of go together, while bio_crypt_swhandled() seems different; it's harder to
understand and might need a comment.

> +
> +	crypt_ctx = bio->bi_crypt_context;
> +	q = bio->bi_disk->queue;
> +	crypt_mode = bio_crypt_mode(bio);
> +
> +	if (bio_crypt_has_keyslot(bio)) {
> +		/* Key already programmed into device? */
> +		if (q->ksm == crypt_ctx->processing_ksm)
> +			return 0;
> +
> +		/* Nope, release the existing keyslot. */
> +		blk_crypto_put_keyslot(bio);
> +	}
> +
> +	/* Get device keyslot if supported */
> +	if (q->ksm) {
> +		err = blk_crypto_get_keyslot(bio, q->ksm);
> +		if (!err)
> +			return 0;

Perhaps there should be a warning message here, since it may be unexpected for
the software fallback encryption to be used, and it may perform poorly.  E.g.

	pr_warn_once("blk-crypto: failed to acquire keyslot for %s (err=%d).  Falling back to software crypto.\n",
		      bio->bi_disk->disk_name, err);

> +	}
> +
> +	/* Fallback to software crypto */
> +	if (bio_data_dir(bio) == WRITE) {
> +		/* Encrypt the data now */
> +		err = blk_crypto_encrypt_bio(bio_ptr);
> +		if (err)
> +			goto out_encrypt_err;
> +	} else {
> +		err = blk_crypto_get_keyslot(bio, blk_crypto_ksm);
> +		if (err)
> +			goto out_err;
> +	}
> +	return 0;
> +out_err:
> +	bio->bi_status = BLK_STS_IOERR;
> +out_encrypt_err:
> +	bio_endio(bio);
> +	return err;
> +}
> +
> +/*
> + * If the bio is not en/decrypted in software, this function releases the
> + * reference to the keyslot that blk_crypto_submit_bio got.
> + * If blk_crypto_submit_bio decided to fallback to software crypto for this
> + * bio, then if the bio is doing a write, we free the allocated bounce pages,
> + * and if the bio is doing a read, we queue the bio for decryption into a
> + * workqueue and return -EAGAIN. After the bio has been decrypted, we release
> + * the keyslot before we call bio_endio(bio).
> + */
> +bool blk_crypto_endio(struct bio *bio)
> +{
> +	if (!bio_crypt_has_keyslot(bio))
> +		return true;
> +
> +	if (!bio_crypt_swhandled(bio)) {
> +		blk_crypto_put_keyslot(bio);
> +		return true;
> +	}
> +
> +	/* bio_data_dir(bio) == READ. So decrypt bio */
> +	blk_crypto_queue_decrypt_bio(bio);
> +	return false;
> +}
> +
> +int __init blk_crypto_init(void)
> +{
> +	blk_crypto_ksm = keyslot_manager_create(BLK_CRYPTO_NUM_KEYSLOTS,
> +						&blk_crypto_ksm_ll_ops,
> +						NULL);
> +	if (!blk_crypto_ksm)
> +		goto out_ksm;
> +
> +	blk_crypto_wq = alloc_workqueue("blk_crypto_wq",
> +					WQ_UNBOUND | WQ_HIGHPRI,
> +					num_online_cpus());
> +	if (!blk_crypto_wq)
> +		goto out_wq;

WQ_MEM_RECLAIM might be needed here.

- Eric
