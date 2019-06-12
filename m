Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19CD842E5E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2019 20:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfFLSKt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jun 2019 14:10:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbfFLSKs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jun 2019 14:10:48 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1B01208CA;
        Wed, 12 Jun 2019 18:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560363048;
        bh=MrI+H3cwc9qGHA+GY1OIq8hqi5QtGAWDAbDuqX98X4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WzJv3zTmdUV31igC8M7p41j4UzeI4OjJvuL7UnCTwfx1JJPA0A0fDHqDKAIMewr8W
         REuZHykGGJAoNYeOEIP3P7JeN/XqHUQtV/yiKqxm2VXvhFa6bfxdVw9FU9HBOjKpef
         TYnIDmNzSuxKrWG5HtypaiMFV55GAxnxovXwq6e4=
Date:   Wed, 12 Jun 2019 11:10:46 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Parshuram Raju Thombare <pthombar@cadence.com>,
        Ladvine D Almeida <ladvine.dalmeida@synopsys.com>,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>
Subject: Re: [RFC PATCH v2 2/8] block: Add encryption context to struct bio
Message-ID: <20190612181044.GA18795@gmail.com>
References: <20190605232837.31545-1-satyat@google.com>
 <20190605232837.31545-3-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605232837.31545-3-satyat@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Satya,

On Wed, Jun 05, 2019 at 04:28:31PM -0700, Satya Tangirala wrote:
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
> 
> Signed-off-by: Satya Tangirala <satyat@google.com>
> ---
>  block/bio.c               |  12 ++-
>  block/blk-crypt-ctx.c     |  90 +++++++++++++++++++
>  block/blk-merge.c         |  34 ++++++-
>  block/bounce.c            |   9 +-
>  drivers/md/dm.c           |  15 ++--
>  include/linux/bio.h       | 180 ++++++++++++++++++++++++++++++++++++++
>  include/linux/blk_types.h |  28 ++++++
>  7 files changed, 355 insertions(+), 13 deletions(-)
>  create mode 100644 block/blk-crypt-ctx.c
> 
> diff --git a/block/bio.c b/block/bio.c
> index 683cbb40f051..87aa87288b39 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -16,6 +16,7 @@
>  #include <linux/workqueue.h>
>  #include <linux/cgroup.h>
>  #include <linux/blk-cgroup.h>
> +#include <linux/keyslot-manager.h>

No need to include keyslot-manager.h here.

> @@ -1019,6 +1026,7 @@ void bio_advance(struct bio *bio, unsigned bytes)
>  		bio_integrity_advance(bio, bytes);
>  
>  	bio_advance_iter(bio, &bio->bi_iter, bytes);
> +	bio_crypt_advance(bio, bytes);
>  }
>  EXPORT_SYMBOL(bio_advance);

It would be more logical to do bio_crypt_advance() before bio_advance_iter(), so
that the special features (encryption and integrity) are grouped together.

>  
> diff --git a/block/blk-crypt-ctx.c b/block/blk-crypt-ctx.c
> new file mode 100644
> index 000000000000..174c058ab0c6
> --- /dev/null
> +++ b/block/blk-crypt-ctx.c

It would be more logical for this file to be named "bio-crypt-ctx.c", as that
would match 'struct bio_crypt_ctx' and help distinguish it from "blk-crypto".

> @@ -0,0 +1,90 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2019 Google LLC
> + */
> +
> +#include <linux/bio.h>
> +#include <linux/blkdev.h>
> +#include <linux/slab.h>
> +#include <linux/keyslot-manager.h>
> +
> +struct bio_crypt_ctx *bio_crypt_alloc_ctx(gfp_t gfp_mask)
> +{
> +	return kzalloc(sizeof(struct bio_crypt_ctx), gfp_mask);
> +}

This needs EXPORT_SYMBOL(), since it's called by bio_crypt_set_ctx() which is an
inline function that will be called by places that submit bios.

> +
> +void bio_crypt_free_ctx(struct bio *bio)
> +{
> +	kzfree(bio->bi_crypt_context);
> +	bio->bi_crypt_context = NULL;
> +}
> +
> +int bio_clone_crypt_context(struct bio *dst, struct bio *src, gfp_t gfp_mask)
> +{

How about naming this function bio_crypt_clone(), for consistency with
bio_integrity_clone()?

> +	if (!bio_is_encrypted(src) || bio_crypt_swhandled(src))
> +		return 0;

Why isn't cloning needed when bio_crypt_swhandled(src)?

> +
> +	dst->bi_crypt_context = bio_crypt_alloc_ctx(gfp_mask);
> +	if (!dst->bi_crypt_context)
> +		return -ENOMEM;
> +
> +	*dst->bi_crypt_context = *src->bi_crypt_context;
> +
> +	if (!bio_crypt_has_keyslot(src))
> +		return 0;
> +
> +	keyslot_manager_get_slot(src->bi_crypt_context->processing_ksm,
> +				 src->bi_crypt_context->keyslot);
> +
> +	return 0;
> +}

Nit: a conditional get would be cleaner than an early return here.

	if (bio_crypt_has_keyslot(src))
		keyslot_manager_get_slot(src->bi_crypt_context->processing_ksm,
					 src->bi_crypt_context->keyslot);

Also, this function needs EXPORT_SYMBOL(), since it's called by drivers/md/dm.c,
which can be a loadable module.

> +/*
> + * Checks that two bio crypt contexts are compatible - i.e. that
> + * they are mergeable except for data_unit_num continuity.
> + */
> +bool bio_crypt_ctx_compatible(struct bio *b_1, struct bio *b_2)
> +{
> +	struct bio_crypt_ctx *bc1 = b_1->bi_crypt_context;
> +	struct bio_crypt_ctx *bc2 = b_2->bi_crypt_context;
> +
> +	if (bio_is_encrypted(b_1) != bio_is_encrypted(b_2))
> +		return false;
> +
> +	if (!bio_is_encrypted(b_1))
> +		return true;
> +
> +	return bc1->keyslot != bc2->keyslot &&
> +	       bc1->data_unit_size_bits == bc2->data_unit_size_bits;
> +}

It needs to be 'bc1->keyslot == bc2->keyslot'.

> +
> +/*
> + * Checks that two bio crypt contexts are compatible, and also
> + * that their data_unit_nums are continuous (and can hence be merged)
> + */
> +bool bio_crypt_ctx_back_mergeable(struct bio *b_1,
> +				  unsigned int b1_sectors,
> +				  struct bio *b_2)
> +{
> +	struct bio_crypt_ctx *bc1 = b_1->bi_crypt_context;
> +	struct bio_crypt_ctx *bc2 = b_2->bi_crypt_context;
> +
> +	if (!bio_crypt_ctx_compatible(b_1, b_2))
> +		return false;
> +
> +	return !bio_is_encrypted(b_1) ||
> +		(bc1->data_unit_num +
> +		(b1_sectors >> (bc1->data_unit_size_bits - 9)) ==
> +		bc2->data_unit_num);
> +}
> +

Unnecessary blank line at end of file.

> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 0f23b5682640..ba9552932571 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -561,6 +561,186 @@ static inline void bvec_kunmap_irq(char *buffer, unsigned long *flags)
>  }
>  #endif
>  
> +#ifdef CONFIG_BLK_INLINE_ENCRYPTION
> +extern int bio_clone_crypt_context(struct bio *dst, struct bio *src,
> +				   gfp_t gfp_mask);
> +
> +static inline bool bio_is_encrypted(struct bio *bio)
> +{
> +	return bio && bio->bi_crypt_context;
> +}

Is the 'bio != NULL' check actually needed?  Most bio helper functions don't
check for NULL, as it's not a meaningful case.

> +
> +static inline bool bio_crypt_has_keyslot(struct bio *bio)
> +{
> +	return bio_is_encrypted(bio) &&
> +	       bio->bi_crypt_context->keyslot >= 0;
> +}
> +

I think the bio_is_encrypted() check here should be dropped, since all callers
check it beforehand anyway.  It doesn't really make sense for someone to call
functions that are meant to access fields of the bio_crypt_ctx, before verifying
that there actually is a bio_crypt_ctx.  Other bio_crypt_* functions don't check
for NULL, so it seems inconsistent that this one does.

> +
> +static inline int bio_crypt_get_slot(struct bio *bio)
> +{
> +	return bio->bi_crypt_context->keyslot;
> +}

For consistency this should be named *_get_keyslot(), not *_get_slot().

> +
> +static inline void bio_crypt_set_keyslot(struct bio *bio,
> +					 unsigned int keyslot,
> +					 struct keyslot_manager *ksm)
> +{
> +	bio->bi_crypt_context->keyslot = keyslot;
> +	bio->bi_crypt_context->processing_ksm = ksm;
> +
> +	bio->bi_crypt_context->crypt_iter = bio->bi_iter;
> +	bio->bi_crypt_context->sw_data_unit_num =
> +		bio->bi_crypt_context->data_unit_num;
> +}
> +
> +static inline void bio_crypt_unset_keyslot(struct bio *bio)
> +{
> +	bio->bi_crypt_context->processing_ksm = NULL;
> +	bio->bi_crypt_context->keyslot = -1;
> +}
> +
> +static inline u8 *bio_crypt_raw_key(struct bio *bio)
> +{
> +	return bio->bi_crypt_context->raw_key;
> +}
> +
> +static inline enum blk_crypt_mode_num bio_crypt_mode(struct bio *bio)
> +{
> +	return bio->bi_crypt_context->crypt_mode;
> +}

bio_crypt_unset_keyslot(), bio_crypt_raw_key(), and bio_crypt_mode() are only
used in blk-crypto.c.  Is there any reason for block users or drivers to need to
call them?  If not, these fields should really just be accessed directly in
blk-crypto.c.  It's not needed to provide these functions in bio.h where they
are available to everyone.

> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index aafa96839f95..c111b1ce8d24 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -148,6 +148,29 @@ enum blk_crypt_mode_num {
>  	 */
>  };
>  
> +struct bio_crypt_ctx {
> +	int keyslot;
> +	u8 *raw_key;
> +	enum blk_crypt_mode_num crypt_mode;
> +	u64 data_unit_num;
> +	unsigned int data_unit_size_bits;
> +
> +	/*
> +	 * The keyslot manager where the key has been programmed
> +	 * with keyslot.
> +	 */
> +	struct keyslot_manager *processing_ksm;
> +
> +	/*
> +	 * Copy of the bvec_iter when this bio was submitted.
> +	 * We only want to en/decrypt the part of the bio
> +	 * as described by the bvec_iter upon submission because
> +	 * bio might be split before being resubmitted
> +	 */
> +	struct bvec_iter crypt_iter;
> +	u64 sw_data_unit_num;
> +};
> +

How about making this struct definition conditional on
CONFIG_BLK_INLINE_ENCRYPTION?  When !CONFIG_BLK_INLINE_ENCRYPTION, no code is
compiled that dereferences any pointer to this struct.

For consistency with bio_integrity_payload and to avoid an extra #ifdef, I think
this should also be moved to bio.h.

blk_crypt_mode_num can be moved to bio.h too, but it will need to be
unconditional since it's used as a parameter to bio_crypt_set_ctx().

>  /*
>   * main unit of I/O for the block layer and lower layers (ie drivers and
>   * stacking drivers)
> @@ -186,6 +209,11 @@ struct bio {
>  	struct blkcg_gq		*bi_blkg;
>  	struct bio_issue	bi_issue;
>  #endif
> +
> +#ifdef CONFIG_BLK_INLINE_ENCRYPTION
> +	struct bio_crypt_ctx	*bi_crypt_context;
> +#endif
> +
>  	union {
>  #if defined(CONFIG_BLK_DEV_INTEGRITY)
>  		struct bio_integrity_payload *bi_integrity; /* data integrity */
> -- 
> 2.22.0.rc1.311.g5d7573a151-goog
> 

Is it actually meaningful to use the blk_integrity feature in combination with
inline encryption?  How might this be tested?  If the features actually conflict
anyway, bi_crypt_context and bi_integrity could share the same union.

- Eric
