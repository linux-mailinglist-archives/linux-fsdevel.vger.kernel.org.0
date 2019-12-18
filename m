Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA99125453
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 22:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfLRVKc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 16:10:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:46360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfLRVKc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:10:32 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C73012072B;
        Wed, 18 Dec 2019 21:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576703431;
        bh=DjJlPhkNOeyYOEaPhZnxRDhM1ngiEl80Fz0h84MDDfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vbBLR4VDzDvap0a4QVSlvS4Woz6WBmC18j2ZKLHzxz/d2aG1a741m6A5xmuOPjqcw
         4UcO3jopByVEzGq9h9BJHpyDrFaDeIDbdzL7awyQ6m7HV/fFfP69rWFEniM9CRWcGl
         xsMych95oZBnsqpI+UMX8S22BqN2jqjL89F8zO3E=
Date:   Wed, 18 Dec 2019 13:10:29 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v6 2/9] block: Add encryption context to struct bio
Message-ID: <20191218211028.GB47399@gmail.com>
References: <20191218145136.172774-1-satyat@google.com>
 <20191218145136.172774-3-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218145136.172774-3-satyat@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 18, 2019 at 06:51:29AM -0800, Satya Tangirala wrote:
> We must have some way of letting a storage device driver know what
> encryption context it should use for en/decrypting a request. However,
> it's the filesystem/fscrypt that knows about and manages encryption
> contexts. As such, when the filesystem layer submits a bio to the block
> layer, and this bio eventually reaches a device driver with support for
> inline encryption, the device driver will need to have been told the
> encryption context for that bio.
> 
> We want to communicate the encryption context from the filesystem layer
> to the storage device along with the bio, when the bio is submitted to the
> block layer. To do this, we add a struct bio_crypt_ctx to struct bio, which
> can represent an encryption context (note that we can't use the bi_private
> field in struct bio to do this because that field does not function to pass
> information across layers in the storage stack). We also introduce various
> functions to manipulate the bio_crypt_ctx and make the bio/request merging
> logic aware of the bio_crypt_ctx.

You might want to reword this to clarify that this could potentially be used by
any user of the block layer (e.g., device-mapper targets), not just filesystems
and not just fscrypt.  fscrypt is just the initial use case.

> diff --git a/block/bio-crypt-ctx.c b/block/bio-crypt-ctx.c
> new file mode 100644
> index 000000000000..dadf0da3c21b
> --- /dev/null
> +++ b/block/bio-crypt-ctx.c
> @@ -0,0 +1,131 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2019 Google LLC
> + */
> +
> +#include <linux/bio.h>
> +#include <linux/blkdev.h>
> +#include <linux/keyslot-manager.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +
> +
> +static int num_prealloc_crypt_ctxs = 128;
> +
> +module_param(num_prealloc_crypt_ctxs, int, 0444);
> +MODULE_PARM_DESC(num_prealloc_crypt_ctxs,
> +		"Number of bio crypto contexts to preallocate");
> +
> +static struct kmem_cache *bio_crypt_ctx_cache;
> +static mempool_t *bio_crypt_ctx_pool;
> +
> +int __init bio_crypt_ctx_init(void)
> +{
> +	bio_crypt_ctx_cache = KMEM_CACHE(bio_crypt_ctx, 0);
> +	if (!bio_crypt_ctx_cache)
> +		return -ENOMEM;
> +
> +	bio_crypt_ctx_pool = mempool_create_slab_pool(num_prealloc_crypt_ctxs,
> +						      bio_crypt_ctx_cache);
> +	if (!bio_crypt_ctx_pool)
> +		return -ENOMEM;
> +
> +	/* This is assumed in various places. */
> +	BUILD_BUG_ON(BLK_ENCRYPTION_MODE_INVALID != 0);
> +
> +	return 0;
> +}
> +
> +struct bio_crypt_ctx *bio_crypt_alloc_ctx(gfp_t gfp_mask)
> +{
> +	return mempool_alloc(bio_crypt_ctx_pool, gfp_mask);
> +}
> +
> +void bio_crypt_free_ctx(struct bio *bio)
> +{
> +	mempool_free(bio->bi_crypt_context, bio_crypt_ctx_pool);
> +	bio->bi_crypt_context = NULL;
> +}
> +
> +void bio_crypt_clone(struct bio *dst, struct bio *src, gfp_t gfp_mask)
> +{
> +	const struct bio_crypt_ctx *src_bc = src->bi_crypt_context;
> +
> +	/*
> +	 * If a bio is swhandled, then it will be decrypted when bio_endio
> +	 * is called. As we only want the data to be decrypted once, copies
> +	 * of the bio must not have have a crypt context.
> +	 */

This comment belongs in the patch that adds the crypto API fallback, not in this
patch.

> +/*
> + * Checks that two bio crypt contexts are compatible - i.e. that
> + * they are mergeable except for data_unit_num continuity.
> + */
> +bool bio_crypt_ctx_compatible(struct bio *b_1, struct bio *b_2)
> +{
> +	struct bio_crypt_ctx *bc1 = b_1->bi_crypt_context;
> +	struct bio_crypt_ctx *bc2 = b_2->bi_crypt_context;
> +
> +	if (bc1 != bc2)
> +		return false;
> +
> +	return !bc1 || bc1->bc_key == bc2->bc_key;
> +}

As we've been discussing, this got broken because it now always returns false
when the bio_crypt_ctx's are different.  My suggestion is:

	if (!bc1)
		return !bc2;
	return bc2 && bc1->bc_key == bc2->bc_key;

> @@ -615,15 +617,12 @@ struct bio *bio_clone_fast(struct bio *bio, gfp_t gfp_mask, struct bio_set *bs)
>  
>  	__bio_clone_fast(b, bio);
>  
> -	if (bio_integrity(bio)) {
> -		int ret;
> -
> -		ret = bio_integrity_clone(b, bio, gfp_mask);
> +	bio_crypt_clone(b, bio, gfp_mask);
>  
> -		if (ret < 0) {
> -			bio_put(b);
> -			return NULL;
> -		}
> +	if (bio_integrity(bio) &&
> +	    bio_integrity_clone(b, bio, gfp_mask) < 0) {
> +		bio_put(b);
> +		return NULL;
>  	}

Now that bio_crypt_clone() can't fail, this patch probably shouldn't bother to
clean up the blk-integrity error handling.

> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index d783bdc4559b..5e53aad97da9 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -596,6 +596,8 @@ int ll_back_merge_fn(struct request *req, struct bio *bio, unsigned int nr_segs)
>  		req_set_nomerge(req->q, req);
>  		return 0;
>  	}
> +	if (!bio_crypt_ctx_mergeable(req->bio, blk_rq_bytes(req), bio))
> +		return 0;
>  
>  	return ll_new_hw_segment(req, bio, nr_segs);
>  }
> @@ -612,6 +614,8 @@ int ll_front_merge_fn(struct request *req, struct bio *bio, unsigned int nr_segs
>  		req_set_nomerge(req->q, req);
>  		return 0;
>  	}
> +	if (!bio_crypt_ctx_mergeable(bio, bio->bi_iter.bi_size, req->bio))
> +		return 0;
>  
>  	return ll_new_hw_segment(req, bio, nr_segs);
>  }
> @@ -656,6 +660,9 @@ static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
>  	if (blk_integrity_merge_rq(q, req, next) == false)
>  		return 0;
>  
> +	if (!bio_crypt_ctx_mergeable(req->bio, blk_rq_bytes(req), next->bio))
> +		return 0;
> +
>  	/* Merge is OK... */
>  	req->nr_phys_segments = total_phys_segments;
>  	return 1;
> @@ -895,6 +902,10 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
>  	if (rq->ioprio != bio_prio(bio))
>  		return false;
>  
> +	/* Only merge if the crypt contexts are compatible */
> +	if (!bio_crypt_ctx_compatible(bio, rq->bio))
> +		return false;
> +
>  	return true;
>  }

Thanks, this looks much better now.  This fixes the bug in v5 where the DUN
continuity check in blk_try_merge() was insufficient, as blk_try_merge() isn't
always called, but ll_front_merge_fn() and ll_back_merge_fn() are.

As an optional cleanup, could you also move the blk-crypto checks in
ll_back_merge_fn(), ll_front_merge_fn(), and blk_rq_merge_ok() to be immediately
below the corresponding blk-integrity checks?  blk-integrity and blk-crypto are
both optional block layer features which have constraints for front and back
merges, so they require merge checks in all the same places (except in one case
where blk-integrity requires an extra check).  That's partly how I found the bug
(which for the record, Satya found independently too) -- I was comparing the
blk-crypto checks to blk-integrity.

So having the blk-crypto and blk-integrity checks be immediately next to each
other would be helpful from a readability standpoint.

Could you also flip the argument order in the call to bio_crypt_ctx_compatible()
so that it matches the order for the other checks in blk_rq_merge_ok()?

None of this "actually matters", but IMO it's really important that we make
these merge checks as straightforward and auditable as possible, as bugs in them
cause data corruption, as we've seen.

>  
> diff --git a/block/bounce.c b/block/bounce.c
> index f8ed677a1bf7..aa57ccc6ced3 100644
> --- a/block/bounce.c
> +++ b/block/bounce.c
> @@ -267,14 +267,12 @@ static struct bio *bounce_clone_bio(struct bio *bio_src, gfp_t gfp_mask,
>  		break;
>  	}
>  
> -	if (bio_integrity(bio_src)) {
> -		int ret;
> +	bio_crypt_clone(bio, bio_src, gfp_mask);
>  
> -		ret = bio_integrity_clone(bio, bio_src, gfp_mask);
> -		if (ret < 0) {
> -			bio_put(bio);
> -			return NULL;
> -		}
> +	if (bio_integrity(bio_src) &&
> +	    bio_integrity_clone(bio, bio_src, gfp_mask) < 0) {
> +		bio_put(bio);
> +		return NULL;
>  	}
>  
>  	bio_clone_blkg_association(bio, bio_src);

Like in bio_clone_fast(): now that bio_crypt_clone() can't fail, this patch
probably shouldn't bother cleaning up the blk-integrity error handling.

> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index e8f9661a10a1..783e0d5fd130 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1304,9 +1304,10 @@ static int clone_bio(struct dm_target_io *tio, struct bio *bio,
>  
>  	__bio_clone_fast(clone, bio);
>  
> +	bio_crypt_clone(clone, bio, GFP_NOIO);
> +
>  	if (bio_integrity(bio)) {
>  		int r;
> -

Unnecessary deleted line.

> diff --git a/include/linux/bio-crypt-ctx.h b/include/linux/bio-crypt-ctx.h
> index dd4ac9d95428..4535df0a6349 100644
> --- a/include/linux/bio-crypt-ctx.h
> +++ b/include/linux/bio-crypt-ctx.h
> @@ -8,7 +8,7 @@
>  enum blk_crypto_mode_num {
>  	BLK_ENCRYPTION_MODE_INVALID,
>  	BLK_ENCRYPTION_MODE_AES_256_XTS,
> -	BLK_ENCRYPTION_MODE_AES_128_CBC,
> +	BLK_ENCRYPTION_MODE_AES_128_CBC_ESSIV,

This should be folded into the patch which introduced blk_crypto_mode_num.

> +/**
> + * struct bio_crypt_ctx - an inline encryption context
> + * @bc_key: the key, algorithm, and data unit size to use
> + * @bc_keyslot: the keyslot that has been assigned for this key in @bc_ksm,
> + *		or -1 if no keyslot has been assigned yet.
> + * @bc_dun: the data unit number (starting IV) to use
> + * @bc_ksm: the keyslot manager into which the key has been programmed with
> + *	    @bc_keyslot, or NULL if this key hasn't yet been programmed.
> + *
> + * A bio_crypt_ctx specifies that the contents of the bio will be encrypted (for
> + * write requests) or decrypted (for read requests) inline by the storage device
> + * or controller, or by the crypto API fallback.
> + */
> +struct bio_crypt_ctx {
> +	const struct blk_crypto_key	*bc_key;
> +	int				bc_keyslot;
> +
> +	/* Data unit number */
> +	u64				bc_dun[BLK_CRYPTO_DUN_ARRAY_SIZE];
> +
> +	/*
> +	 * The keyslot manager where the key has been programmed
> +	 * with keyslot.
> +	 */
> +	struct keyslot_manager		*bc_ksm;
> +};

The two comments inside the struct definition are not needed now that there is a
kerneldoc comment above the struct which documents all the fields.

FWIW, I also think it would be slightly more logical to order the fields like:

struct bio_crypt_ctx {
	const struct blk_crypto_key	*bc_key;
	u64				bc_dun[BLK_CRYPTO_DUN_ARRAY_SIZE];
	struct keyslot_manager		*bc_ksm;
	int				bc_keyslot;
};

... because (key, dun) go together as they're what the user provides, while
(ksm, keyslot) go together as they're managed by the block layer.

> +static inline bool bio_crypt_dun_is_contiguous(const struct bio_crypt_ctx *bc,
> +					       unsigned int bytes,
> +					u64 next_dun[BLK_CRYPTO_DUN_ARRAY_SIZE])
> +{
> +	int i = 0;
> +	unsigned int inc = bytes >> bc->bc_key->data_unit_size_bits;
> +
> +	while (inc && i < BLK_CRYPTO_DUN_ARRAY_SIZE) {
> +		if (bc->bc_dun[i] + inc != next_dun[i])
> +			return false;
> +		inc = ((bc->bc_dun[i] + inc)  < inc);
> +		i++;
> +	}
> +
> +	return true;
> +}

This incorrectly returns true in some cases.  It needs to compare the whole DUN,
not stop as soon as 'inc' becomes 0.

I'm also always a bit nervious of code that checks for integer wraparound
without casting or assigning the result, due to the presence of integer
promotion in C...  That's partly why I had the 'u64 sum' variable in the version
I suggested.  But this specific case is fine because the type is u64.

- Eric
