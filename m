Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED2D169872
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2019 17:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbfGOPkt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jul 2019 11:40:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730610AbfGOPkt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jul 2019 11:40:49 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C1422081C;
        Mon, 15 Jul 2019 15:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563205246;
        bh=LXQNO+Sb/LFc1IQjlNJ0b4WmkxUgAc5+IGl1WQsDucM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1fGnpAVOgEIax0EVhwcOqxZLXgkPH8vMROCGZ81VluA9Zp8EfcBC38YsVgYoj6tIS
         LuUZLQYuwPu5xF+tsmmh9PaFxx8nDHKSJYpLLJaiNqyFTomOWjYDn7jyHBxhripLgp
         gErsnWhhy144c6dwVfcCQR/FNuMDGIQz84YPyulo=
Date:   Mon, 15 Jul 2019 08:40:44 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Parshuram Raju Thombare <pthombar@cadence.com>,
        Ladvine D Almeida <ladvine.dalmeida@synopsys.com>,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3/8] block: blk-crypto for Inline Encryption
Message-ID: <20190715154044.GA728@sol.localdomain>
Mail-Followup-To: Satya Tangirala <satyat@google.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Parshuram Raju Thombare <pthombar@cadence.com>,
        Ladvine D Almeida <ladvine.dalmeida@synopsys.com>,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20190710225609.192252-1-satyat@google.com>
 <20190710225609.192252-4-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710225609.192252-4-satyat@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Satya, here's yet another round of comments.  I'd really like for
people who are experts in the block layer to review this too, though.
The integration into the block layer needs more review.

On Wed, Jul 10, 2019 at 03:56:04PM -0700, Satya Tangirala wrote:
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

It's not necessarily a "software fallback", since the kernel crypto API
supports hardware crypto accelerators, just not *inline* hardware crypto
accelerators.  To avoid this inevitable confusion, can you please call
it the "crypto API fallback"?  This applies to the whole patch series,
including both the code and documentation.

> 
> Known issues:
> 1) We're allocating crypto_skcipher in blk_crypto_keyslot_program, which
> uses GFP_KERNEL to allocate memory, but this function is on the write
> path for IO - we need to add support for specifying a different flags
> to the crypto API.

You could use memalloc_noio_save() and memalloc_noio_restore(), rather
than gfp_flags.

> diff --git a/block/blk-crypto.c b/block/blk-crypto.c
> new file mode 100644
> index 000000000000..f41fb7819ae9
> --- /dev/null
> +++ b/block/blk-crypto.c
> @@ -0,0 +1,585 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2019 Google LLC
> + */

Perhaps include a reference to the documentation file?

Also, how about adding:

	#define pr_fmt(fmt) "blk-crypto: " fmt

... so that all log messages in this file automatically get an
appropriate prefix.

> +#include <linux/blk-crypto.h>
> +#include <linux/keyslot-manager.h>
> +#include <linux/mempool.h>
> +#include <linux/blk-cgroup.h>
> +#include <crypto/skcipher.h>
> +#include <crypto/algapi.h>
> +#include <linux/module.h>

This code is using the crypto API, but as-is
CONFIG_BLK_INLINE_ENCRYPTION can be enabled without also enabling the
crypto API, which will cause a build error.  The Kconfig option needs:

        select CRYPTO
        select CRYPTO_BLKCIPHER

> +
> +struct blk_crypt_mode {
> +	const char *cipher_str;
> +	size_t keysize;
> +};

In general, I think more comments in this file would be really helpful.

For example, can you document the fields of blk_crypt_mode?  E.g.

struct blk_crypt_mode {
        const char *cipher_str; /* crypto API name (for fallback case) */
        size_t keysize;         /* key size in bytes */
};

> +
> +static const struct blk_crypt_mode blk_crypt_modes[] = {
> +	[BLK_ENCRYPTION_MODE_AES_256_XTS] = {
> +		.cipher_str = "xts(aes)",
> +		.keysize = 64,
> +	},
> +};
> +
> +#define BLK_CRYPTO_MAX_KEY_SIZE 64
> +/* TODO: Do we want to make this user configurable somehow? */
> +static int blk_crypto_num_keyslots = 100;

This TODO is stale, since this patch already makes num_keyslots a kernel
command line parameter.

> +
> +static struct blk_crypto_keyslot {
> +	struct crypto_skcipher *tfm;
> +	enum blk_crypt_mode_num crypt_mode;
> +	u8 key[BLK_CRYPTO_MAX_KEY_SIZE];
> +} *blk_crypto_keyslots;
> +
> +struct work_mem {
> +	struct work_struct crypto_work;
> +	struct bio *bio;
> +};
> +
> +static struct keyslot_manager *blk_crypto_ksm;
> +static struct workqueue_struct *blk_crypto_wq;
> +static mempool_t *blk_crypto_page_pool;
> +static struct kmem_cache *blk_crypto_work_mem_cache;

It would be helpful to add a comment somewhere that makes it clear that
all this stuff is for the crypto API fallback, which is not used if the
disk natively supports inline encryption.

I'm concerned that people will read this code and draw the wrong
conclusion about where the encryption is actually being done in their
particular case.

> +
> +/* TODO: handle modes that need essiv */

There's a pending patchset that makes ESSIV accessible via
crypto_skcipher.  So ESSIV won't need special handling.  I suggest just
deleting this TODO comment for now.

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

Nit: reversing this to '!tfm || crypt_mode != slotp->crypt_mode' would
be more logical because as the code is written, unused slots have tfm ==
NULL but an undefined crypt_mode.  It doesn't make sense to check the
undefined thing first, then the defined thing.

> +		evict_keyslot(slot);
> +		tfm = crypto_alloc_skcipher(
> +			mode->cipher_str, 0, 0);

Nit: the parameters to crypto_alloc_skcipher() fit in one line.

> +		if (IS_ERR(tfm))
> +			return PTR_ERR(tfm);
> +
> +		crypto_skcipher_set_flags(tfm,
> +					  CRYPTO_TFM_REQ_FORBID_WEAK_KEYS);

Nit: the parameters to crypto_skcipher_set_flags() fit in one line.

> +static int blk_crypto_keyslot_find(void *priv,
> +				   const u8 *key,
> +				   enum blk_crypt_mode_num crypt_mode,
> +				   unsigned int data_unit_size_bytes)
> +{
> +	int slot;
> +	const size_t keysize = blk_crypt_modes[crypt_mode].keysize;
> +
> +	/* TODO: hashmap? */
> +	for (slot = 0; slot < blk_crypto_num_keyslots; slot++) {
> +		if (blk_crypto_keyslots[slot].crypt_mode == crypt_mode &&
> +		    !crypto_memneq(blk_crypto_keyslots[slot].key, key, keysize))
> +			return slot;
> +	}

There should be no TODO comments in the code, so please do something
about this one.  Note that we musn't leak other keys via timing
information, so a naive hashmap is not an appropriate solution.  So
perhaps this comment should just be deleted, or updated to explain the
timing attack problem and how it's solved.

> +static bool blk_crypt_mode_supported(void *priv,
> +				     enum blk_crypt_mode_num crypt_mode,
> +				     unsigned int data_unit_size)
> +{
> +	/* All blk_crypt_modes are required to have a software fallback. */
> +	return true;
> +}
> +
> +static const struct keyslot_mgmt_ll_ops blk_crypto_ksm_ll_ops = {
> +	.keyslot_program	= blk_crypto_keyslot_program,
> +	.keyslot_evict		= blk_crypto_keyslot_evict,
> +	.keyslot_find		= blk_crypto_keyslot_find,
> +	.crypt_mode_supported	= blk_crypt_mode_supported,
> +};

There's a missing "o" in blk_crypt_mode_supported().

> +
> +static void blk_crypto_encrypt_endio(struct bio *enc_bio)
> +{
> +	struct bio *src_bio = enc_bio->bi_private;
> +	struct bio_vec *enc_bvec, *enc_bvec_end;
> +
> +	enc_bvec = enc_bio->bi_io_vec;
> +	enc_bvec_end = enc_bvec + enc_bio->bi_vcnt;
> +	for (; enc_bvec != enc_bvec_end; enc_bvec++)
> +		mempool_free(enc_bvec->bv_page, blk_crypto_page_pool);

Nit: this could just be a regular loop over 'i':

	for (i = 0; i < enc_bio->bi_vcnt; i++)
		mempool_free(enc_bio->bi_io_vec[i].bv_page,
			     blk_crypto_page_pool);

It's one line shorter and slightly easier to read.

> +static struct bio *blk_crypto_clone_bio(struct bio *bio_src)
> +{
> +	struct bvec_iter iter;
> +	struct bio_vec bv;
> +	struct bio *bio;
> +
> +	bio = bio_alloc_bioset(GFP_NOIO, bio_segments(bio_src), NULL);
> +	if (!bio)
> +		return NULL;
> +	bio->bi_disk		= bio_src->bi_disk;
> +	bio->bi_opf		= bio_src->bi_opf;
> +	bio->bi_ioprio		= bio_src->bi_ioprio;
> +	bio->bi_write_hint	= bio_src->bi_write_hint;
> +	bio->bi_iter.bi_sector	= bio_src->bi_iter.bi_sector;
> +	bio->bi_iter.bi_size	= bio_src->bi_iter.bi_size;
> +
> +	bio_for_each_segment(bv, bio_src, iter)
> +		bio->bi_io_vec[bio->bi_vcnt++] = bv;
> +
> +	if (bio_integrity(bio_src)) {
> +		int ret;
> +
> +		ret = bio_integrity_clone(bio, bio_src, GFP_NOIO);
> +		if (ret < 0) {
> +			bio_put(bio);
> +			return NULL;
> +		}
> +	}

Nit: the code under bio_integrity() can be written more concisely:

	if (bio_integrity(bio_src) &&
	    bio_integrity_clone(bio, bio_src, GFP_NOIO) < 0) {
		bio_put(bio);
		return NULL;
	}

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
> +	int data_unit_size;

As I mentioned on v2, this function is difficult to understand because
it's so long.  I gave a suggestion to make it slightly shorter, which
was not taken.  It would be helpful if you responded to suggestions that
you're not accepting, since otherwise it's unclear whether the
suggestion was rejected, or was missed or forgotten.

Anyway, a new suggestion: it also seems the bio splitting can be nicely
made its own function, which would help.  E.g.:

static int blk_crypto_split_bio_if_needed(struct bio **bio_ptr)
{
       struct bio *bio = *bio_ptr;
       unsigned int i = 0;
       unsigned int num_sectors = 0;
       struct bio_vec bv;
       struct bvec_iter iter;

       bio_for_each_segment(bv, bio, iter) {
               num_sectors += bv.bv_len >> SECTOR_SHIFT;
               if (++i == BIO_MAX_PAGES)
                       break;
       }
       if (num_sectors < bio_sectors(bio)) {
               struct bio *split_bio;

               split_bio = bio_split(bio, num_sectors, GFP_NOIO, NULL);
               if (!split_bio) {
                       bio->bi_status = BLK_STS_RESOURCE;
                       return -ENOMEM;
               }
               bio_chain(split_bio, bio);
               generic_make_request(bio);
               *bio_ptr = split_bio;
       }
       return 0;
}

> +
> +	/* Split the bio if it's too big for single page bvec */
> +	i = 0;
> +	num_sectors = 0;
> +	data_unit_size = 1 << src_bio->bi_crypt_context->data_unit_size_bits;
> +	bio_for_each_segment(bv, src_bio, iter) {
> +		num_sectors += bv.bv_len >> 9;
> +		if (bv.bv_len % data_unit_size != 0) {
> +			src_bio->bi_status = BLK_STS_IOERR;
> +			return -EIO;
> +		}
> +		if (++i == BIO_MAX_PAGES)
> +			break;
> +	}

1.) The alignment check should be done on both bv_len and bv_offset.

2.) To make the behavior consistent, I also think it should be done
    regardless of whether the crypto API fallback is being used.

3.) As coded, this alignment check is broken because it's only being
    done on the first BIO_MAX_PAGES pages of the bio.

4.) '%' or '/' by a non-constant generally should be avoided in kernel
    code, because they can be very slow, and they aren't supported on
    64-bit variables on some architectures.  data_unit_size is always a
    power of 2, so use IS_ALIGNED() instead.

Instead, I suggest adding the following and calling it from early in
blk_crypto_submit_bio():

/* All I/O segments must be data unit aligned */
static int bio_crypt_check_alignment(struct bio *bio)
{
        int data_unit_size = 1 << bio->bi_crypt_context->data_unit_size_bits;
        struct bvec_iter iter;
        struct bio_vec bv;

        bio_for_each_segment(bv, bio, iter) {
                if (!IS_ALIGNED(bv.bv_len | bv.bv_offset, data_unit_size))
                        return -EIO;
        }
        return 0;
}

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
> +		src_bio = *bio_ptr;
> +	}
> +
> +	enc_bio = blk_crypto_clone_bio(src_bio);
> +	if (!enc_bio) {
> +		src_bio->bi_status = BLK_STS_RESOURCE;
> +		return -ENOMEM;
> +	}
> +
> +	err = bio_crypt_ctx_acquire_keyslot(src_bio, blk_crypto_ksm);
> +	if (err) {
> +		src_bio->bi_status = BLK_STS_IOERR;
> +		bio_put(enc_bio);
> +		return err;
> +	}
> +	slot = bio_crypt_get_keyslot(src_bio);
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

To help people follow this code, a few brief comments describing the
high-level tasks being accomplished here would be helpful.  E.g.:

       /*
        * Use the crypto API fallback keyslot manager to get a crypto_skcipher
        * for the algorithm and key, then allocate an skcipher_request for it.
        */

Then below:

	/* Encrypt each page in the bio */

and

		/* Encrypt each data unit in the page */


> +
> +	curr_dun = bio_crypt_data_unit_num(src_bio);
> +	sg_init_table(&src, 1);
> +	sg_init_table(&dst, 1);
> +	for (i = 0, enc_bvec = enc_bio->bi_io_vec; i < enc_bio->bi_vcnt;
> +	     enc_bvec++, i++) {
> +		struct page *page = enc_bvec->bv_page;

Nit: to make this slightly easier to read, you could just use a regular
loop over 'i' and assign enc_bvec in the loop:

	for (i = 0; i < enc_bio->bi_vcnt; i++) {
		struct bio_vec *enc_bvec = &enc_bio->bi_io_vec[i];


> +		struct page *ciphertext_page =
> +			mempool_alloc(blk_crypto_page_pool, GFP_NOIO);

Please rename 'page' => 'plaintext_page' to make it very clear which is
the plaintext and which is the ciphertext.

> +
> +		enc_bvec->bv_page = ciphertext_page;
> +
> +		if (!ciphertext_page)
> +			goto no_mem_for_ciph_page;
> +
> +		for (j = 0; j < enc_bvec->bv_len / data_unit_size; j++) {
> +			memset(&iv, 0, sizeof(iv));
> +			iv.dun = cpu_to_le64(curr_dun);
> +
> +			sg_set_page(&src, page, data_unit_size,
> +				    enc_bvec->bv_offset + j * data_unit_size);
> +			sg_set_page(&dst, ciphertext_page, data_unit_size,
> +				    enc_bvec->bv_offset + j * data_unit_size);
> +
> +			skcipher_request_set_crypt(ciph_req, &src, &dst,
> +						   data_unit_size, iv.bytes);
> +			err = crypto_wait_req(crypto_skcipher_encrypt(ciph_req),
> +					      &wait);
> +			if (err)
> +				goto no_mem_for_ciph_page;
> +			curr_dun++;
> +		}

This could be optimized slightly by only calling
skcipher_request_set_crypt() once per bio (since the scatterlists and IV
buffer are always the same), and by only doing the two sg_set_page()
calls once per page and instead updating the scatterlists after
encrypting each data unit:

	src.offset += data_unit_size;
	dst.offset += data_unit_size;

And the loop can be:

	for (j = 0; j < enc_bvec->bv_len; j += data_unit_size) {

... so that no divisions or multiplications are needed.

> +		continue;
> +no_mem_for_ciph_page:
> +		err = -ENOMEM;
> +		for (j = i - 1; j >= 0; j--) {
> +			mempool_free(enc_bio->bi_io_vec[j].bv_page,
> +				     blk_crypto_page_pool);
> +		}
> +		src_bio->bi_status = BLK_STS_RESOURCE;
> +		bio_put(enc_bio);
> +		goto out_release_cipher;
> +	}

If crypto_skcipher_encrypt() fails, a bounce page is leaked.  Also, the
failure is not necessarily caused by "no memory".

To fix the former, we can increment 'i' immediately after the page has
been allocated.  To fix the latter, we can set bi_status at the place
the error happened.

To make the error handling easier to read and less error prone, how
about it also moving it to the end of the function, including the
bio_put(enc_bio):

        enc_bio = NULL;
        err = 0;
        goto out_free_ciph_req;

out_free_bounce_pages:
        while (i > 0)
                mempool_free(enc_bio->bi_io_vec[--i].bv_page,
                             blk_crypto_page_pool);
out_free_ciph_req:
        skcipher_request_free(ciph_req);
out_release_keyslot:
        bio_crypt_ctx_release_keyslot(src_bio);
out_put_enc_bio:
        if (enc_bio)
                bio_put(enc_bio);
        return err;

> +
> +	enc_bio->bi_private = src_bio;
> +	enc_bio->bi_end_io = blk_crypto_encrypt_endio;
> +
> +	*bio_ptr = enc_bio;
> +out_release_cipher:
> +	skcipher_request_free(ciph_req);
> +out_release_keyslot:
> +	bio_crypt_ctx_release_keyslot(src_bio);
> +	return err;
> +}
> +
> +/*
> + * TODO: assumption right now is:
> + * each segment in bio has length divisible by the data_unit_size
> + */

Why is this a TODO?  What's wrong with just failing bio's that aren't
properly aligned?

> +static void blk_crypto_decrypt_bio(struct work_struct *w)
> +{
> +	struct work_mem *work_mem =
> +		container_of(w, struct work_mem, crypto_work);
> +	struct bio *bio = work_mem->bio;
> +	int slot;
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
> +	int err;
> +	int data_unit_size = 1 << bio->bi_crypt_context->data_unit_size_bits;
> +	int i;
> +
> +	kmem_cache_free(blk_crypto_work_mem_cache, work_mem);

Nit: freeing the work_mem is cleanup work that always must be done,
similar to calling bio_endio().  So I suggest moving this to the end of
this function, after bio_endio().  Otherwise it would be easy for a
future patch to accidentally introduce a use-after-free of work_mem.

> +
> +	err = bio_crypt_ctx_acquire_keyslot(bio, blk_crypto_ksm);
> +	if (err) {
> +		bio->bi_status = BLK_STS_RESOURCE;
> +		goto out_no_keyslot;
> +	}
> +
> +	slot = bio_crypt_get_keyslot(bio);
> +	ciph_req = skcipher_request_alloc(blk_crypto_keyslots[slot].tfm,
> +					  GFP_NOIO);
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
> +	curr_dun = bio_crypt_sw_data_unit_num(bio);
> +	sg_init_table(&sg, 1);
> +	__bio_for_each_segment(bv, bio, iter,
> +			       bio->bi_crypt_context->crypt_iter) {
> +		if (bv.bv_len % data_unit_size != 0) {
> +			bio->bi_status = BLK_STS_IOERR;
> +			err = -EIO;
> +			goto out;
> +		}
> +		for (i = 0; i < bv.bv_len / data_unit_size; i++) {
> +			struct page *page = bv.bv_page;
> +
> +			memset(&iv, 0, sizeof(iv));
> +			iv.dun = cpu_to_le64(curr_dun);
> +
> +			sg_set_page(&sg, page, data_unit_size,
> +				    bv.bv_offset + i * data_unit_size);
> +			skcipher_request_set_crypt(ciph_req, &sg, &sg,
> +						   data_unit_size, iv.bytes);
> +			err = crypto_wait_req(crypto_skcipher_decrypt(ciph_req),
> +					      &wait);
> +			if (err) {
> +				bio->bi_status = BLK_STS_IOERR;
> +				goto out;
> +			}
> +			curr_dun++;
> +		}
> +	}

Most of the comments I made for the encryption case apply here too.

> +
> +out:
> +	skcipher_request_free(ciph_req);
> +	bio_crypt_ctx_release_keyslot(bio);
> +out_no_keyslot:
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

It's not conventional to chain 'void' return values like this.

Try to be as boring as possible.  Just write:

		bio_endio(bio);
		return;

> +
> +	INIT_WORK(&work_mem->crypto_work, blk_crypto_decrypt_bio);
> +	work_mem->bio = bio;
> +	queue_work(blk_crypto_wq, &work_mem->crypto_work);
> +}
> +
> +/**
> + * blk_crypto_submit_bio - handle submitting bio for inline encryption
> + *
> + * @bio_ptr: pointer to original bio pointer
> + *
> + * If the bio doesn't have inline encryption enabled or the submitter already
> + * specified a keyslot for the target device, do nothing.  Else, a raw key must
> + * have been provided, so acquire a device keyslot for it if supported.  Else,
> + * use the software crypto fallback.
> + *
> + * When the software fallback is used for encryption, blk-crypto may choose to
> + * split the bio into 2 - one that will continue to be processed and the other
> + * that will be resubmitted via generic_make_request. *bio_ptr will be updated
> + * to the first bio (the one that will continue to be processed).

The second paragraph is misleading because it doesn't explain that
*bio_ptr is actually updated to point to the bounce bio.

> + *
> + * Return: 0 if bio submission should continue; nonzero if bio_endio() was
> + *        already called so bio submission should abort.
> + */
> +int blk_crypto_submit_bio(struct bio **bio_ptr)
> +{
> +	struct bio *bio = *bio_ptr;
> +	struct request_queue *q;
> +	int err;
> +	struct bio_crypt_ctx *crypt_ctx;
> +
> +	if (!bio_is_encrypted(bio) || !bio_has_data(bio))
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
> +	crypt_ctx = bio->bi_crypt_context;
> +	q = bio->bi_disk->queue;
> +
> +	if (bio_crypt_has_keyslot(bio)) {
> +		/* Key already programmed into device? */
> +		if (q->ksm == crypt_ctx->processing_ksm)
> +			return 0;
> +
> +		/* Nope, release the existing keyslot. */
> +		bio_crypt_ctx_release_keyslot(bio);
> +	}
> +
> +	/* Get device keyslot if supported */
> +	if (q->ksm) {
> +		err = bio_crypt_ctx_acquire_keyslot(bio, q->ksm);
> +		if (!err) {
> +			pr_warn_once("blk-crypto: failed to acquire keyslot for %s (err=%d).  Falling back to software crypto.\n",
> +				     bio->bi_disk->disk_name, err);
> +			return 0;
> +		}

This warning message should go in the err != 0 case, not err == 0.

> +	}
> +
> +	/* Fallback to software crypto */
> +	if (bio_data_dir(bio) == WRITE) {
> +		/* Encrypt the data now */
> +		err = blk_crypto_encrypt_bio(bio_ptr);
> +		if (err)
> +			goto out_encrypt_err;
> +	} else {
> +		/* Mark bio as swhandled */
> +		bio->bi_crypt_context->processing_ksm = blk_crypto_ksm;
> +		bio->bi_crypt_context->crypt_iter = bio->bi_iter;
> +		bio->bi_crypt_context->sw_data_unit_num =
> +				bio->bi_crypt_context->data_unit_num;
> +	}
> +	return 0;
> +out_encrypt_err:
> +	bio_endio(bio);
> +	return err;
> +}
> +
> +/**
> + * blk_crypto_endio - clean up bio w.r.t inline encryption during bio_endio
> + *
> + * @bio - the bio to clean up
> + *
> + * If blk_crypto_submit_bio decided to fallback to software crypto for this
> + * bio, we queue the bio for decryption into a workqueue and return false,
> + * and call bio_endio(bio) at a later time (after the bio has been decrypted).
> + *
> + * If the bio is not to be decrypted in software, this function releases the
> + * reference to the keyslot that blk_crypto_submit_bio got.
> + *
> + * Return: true if bio_endio should continue; false otherwise (bio_endio will
> + * be called again when bio has been decrypted).
> + */
> +bool blk_crypto_endio(struct bio *bio)
> +{
> +	if (bio_crypt_swhandled(bio)) {
> +		/*
> +		 * The only bios that are swhandled when they reach here
> +		 * are those with bio_data_dir(bio) == READ, since WRITE
> +		 * bios that are encrypted by software fallback are handled
> +		 * by blk_crypto_encrypt_endio.
> +		 */
> +		blk_crypto_queue_decrypt_bio(bio);
> +		return false;
> +	}

This should only do the decryption if there was no I/O error.

> +
> +	if (bio_is_encrypted(bio) && bio_crypt_has_keyslot(bio))
> +		bio_crypt_ctx_release_keyslot(bio);
> +
> +	return true;

Also it seems that blk_crypto_endio() should mirror
blk_crypto_submit_bio() and start with:

	if (!bio_is_encrypted(bio) || !bio_has_data(bio))
		return true;

Otherwise the bio_has_data() case might be handled inconsistently.  And
it's good to check bio_is_encrypted() first, so that the unencrypted
case is as fast and easy to understand as possible.

Also, blk_crypto_endio() always releases the keyslot, even if it was
provided by the submitter of the bio.  Shouldn't it only release the
keyslot if it was acquired by blk_crypto_submit_bio()?

> +}
> +
> +int __init blk_crypto_init(void)
> +{
> +	blk_crypto_ksm = keyslot_manager_create(blk_crypto_num_keyslots,
> +						&blk_crypto_ksm_ll_ops,
> +						NULL);
> +	if (!blk_crypto_ksm)
> +		goto out_ksm;
> +
> +	blk_crypto_wq = alloc_workqueue("blk_crypto_wq",
> +					WQ_UNBOUND | WQ_HIGHPRI |
> +					WQ_MEM_RECLAIM,
> +					num_online_cpus());
> +	if (!blk_crypto_wq)
> +		goto out_wq;
> +
> +	blk_crypto_keyslots = kcalloc(blk_crypto_num_keyslots,
> +				      sizeof(*blk_crypto_keyslots),
> +				      GFP_KERNEL);
> +	if (!blk_crypto_keyslots)
> +		goto out_blk_crypto_keyslots;
> +
> +	blk_crypto_page_pool =
> +		mempool_create_page_pool(num_prealloc_bounce_pg, 0);
> +	if (!blk_crypto_page_pool)
> +		goto out_bounce_pool;
> +
> +	blk_crypto_work_mem_cache = KMEM_CACHE(work_mem, SLAB_RECLAIM_ACCOUNT);
> +	if (!blk_crypto_work_mem_cache)
> +		goto out_work_mem_cache;
> +
> +	return 0;
> +
> +out_work_mem_cache:
> +	mempool_destroy(blk_crypto_page_pool);
> +	blk_crypto_page_pool = NULL;
> +out_bounce_pool:
> +	kzfree(blk_crypto_keyslots);
> +	blk_crypto_keyslots = NULL;
> +out_blk_crypto_keyslots:
> +	destroy_workqueue(blk_crypto_wq);
> +	blk_crypto_wq = NULL;
> +out_wq:
> +	keyslot_manager_destroy(blk_crypto_ksm);
> +	blk_crypto_ksm = NULL;
> +out_ksm:
> +	pr_warn("No memory for blk-crypto software fallback.");
> +	return -ENOMEM;
> +}

Nit: I find it easier to read error labels when they describe what is
done at them, rather than what was done just before the goto.
I.e. use out:, out_destroy_ksm:, out_destroy_workqueue:, etc.

> +
> +module_param(blk_crypto_num_keyslots, int, 0);
> +MODULE_PARM_DESC(blk_crypto_num_keyslots,
> +		 "Number of keyslots for software fallback in blk-crypto.");
> +module_param(num_prealloc_bounce_pg, uint, 0);
> +MODULE_PARM_DESC(num_prealloc_bounce_pg,
> +	"Number of preallocated bounce pages for blk-crypto to use during software fallback encryption");

I believe it's more common for the module_param() statements to go at
the top of the file, next to the actual variables.

Also, the module parameter names are inconsistent.  The first parameter
will be "blk_crypto.blk_crypto_num_keyslots" on command line and second
parameter will be "blk_crypto.num_prealloc_bounce_pg" on command line.

It should be "blk_crypto.num_keyslots" for the first.  No need to say
"blk_crypto" twice.

module_param_named() can be used to still prefix the C variable names
with "blk_crypto_".

> diff --git a/include/linux/blk-crypto.h b/include/linux/blk-crypto.h
> new file mode 100644
> index 000000000000..cbb5bea6dcdb
> --- /dev/null
> +++ b/include/linux/blk-crypto.h
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright 2019 Google LLC
> + */
> +
> +#ifndef __LINUX_BLK_CRYPTO_H
> +#define __LINUX_BLK_CRYPTO_H
> +
> +#include <linux/types.h>
> +
> +#ifdef CONFIG_BLK_INLINE_ENCRYPTION
> +
> +struct bio;

This forward declaration should go outside the ifdef, since 'struct bio'
is referred to in both cases.

> +
> +int blk_crypto_init(void);
> +
> +int blk_crypto_submit_bio(struct bio **bio_ptr);
> +
> +bool blk_crypto_endio(struct bio *bio);
> +
> +#else /* CONFIG_BLK_INLINE_ENCRYPTION */
> +
> +static inline int blk_crypto_init(void)
> +{
> +	return 0;
> +}
> +
> +static inline int blk_crypto_submit_bio(struct bio **bio)
> +{
> +	return 0;
> +}

To be consistent with the other declaration, the parameter name here
should be 'bio_ptr', not 'bio'.

> +
> +static inline bool blk_crypto_endio(struct bio *bio)
> +{
> +	return true;
> +}
> +
> +#endif /* CONFIG_BLK_INLINE_ENCRYPTION */
> +
> +#endif /* __LINUX_BLK_CRYPTO_H */
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

- Eric
