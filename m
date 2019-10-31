Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB90DEB6B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2019 19:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbfJaSQO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Oct 2019 14:16:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35388 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfJaSQO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Oct 2019 14:16:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=17ny2tyYchuJcZntPepC2H7DRLPjDMpL4NN+oqkqSow=; b=EBzOdjKJXHWIkOTWFGwr92r+5
        0oG5g6sFqfUFUORDYSobteMoX8yA7NquOFErl5Jbz48+hIfWxcIUd2t2rdIZi79XuvjBBJ5u0JR5Y
        1F55Lv6918LQWZoZNR0zcsCTYbcDkUJVBfxYGHHyap6eigddijJxdEyEJvoQqxC+3jdOkv7IN+Tiz
        /QJ+TO5k0wyIxrT7zBPR8NnxUbpBYPSLan8jovTam+iF8BawhDJe8Pil4dHgM7+JZL19l8rxuJCL0
        gGiMvL4q+csvDWn1upZy/WdDiVB7gvPUgBphrTTpgS6GJigFEPhaoVk6oTAWNhk2EDUBX8lqdpV/u
        Rdo2k2J2A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iQEzV-00005I-Jz; Thu, 31 Oct 2019 18:16:13 +0000
Date:   Thu, 31 Oct 2019 11:16:13 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v5 2/9] block: Add encryption context to struct bio
Message-ID: <20191031181613.GC23601@infradead.org>
References: <20191028072032.6911-1-satyat@google.com>
 <20191028072032.6911-3-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028072032.6911-3-satyat@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +static int num_prealloc_crypt_ctxs = 128;

Where does that magic number come from?

> +struct bio_crypt_ctx *bio_crypt_alloc_ctx(gfp_t gfp_mask)
> +{
> +	return mempool_alloc(bio_crypt_ctx_pool, gfp_mask);
> +}
> +EXPORT_SYMBOL(bio_crypt_alloc_ctx);

This isn't used by an modular code.

> +void bio_crypt_free_ctx(struct bio *bio)
> +{
> +	mempool_free(bio->bi_crypt_context, bio_crypt_ctx_pool);
> +	bio->bi_crypt_context = NULL;
> +}
> +EXPORT_SYMBOL(bio_crypt_free_ctx);

This one is called from modular code, but I think the usage in DM
is bogus, as the caller of the function eventually does a bio_put,
which ends up in bio_free and takes care of the freeing as well.

> +bool bio_crypt_should_process(struct bio *bio, struct request_queue *q)
> +{
> +	if (!bio_has_crypt_ctx(bio))
> +		return false;
> +
> +	WARN_ON(!bio_crypt_has_keyslot(bio));
> +	return q->ksm == bio->bi_crypt_context->processing_ksm;
> +}

Passing a struct request here and also adding the ->bio != NULL check
here would simplify the only caller in ufs a bit.

> +/*
> + * Checks that two bio crypt contexts are compatible - i.e. that
> + * they are mergeable except for data_unit_num continuity.
> + */
> +bool bio_crypt_ctx_compatible(struct bio *b_1, struct bio *b_2)
> +{
> +	struct bio_crypt_ctx *bc1 = b_1->bi_crypt_context;
> +	struct bio_crypt_ctx *bc2 = b_2->bi_crypt_context;
> +
> +	if (bio_has_crypt_ctx(b_1) != bio_has_crypt_ctx(b_2))
> +		return false;
> +
> +	if (!bio_has_crypt_ctx(b_1))
> +		return true;
> +
> +	return bc1->keyslot == bc2->keyslot &&
> +	       bc1->data_unit_size_bits == bc2->data_unit_size_bits;
> +}

I think we'd normally call this bio_crypt_ctx_mergeable.

> +	if (bio_crypt_clone(b, bio, gfp_mask) < 0) {
> +		bio_put(b);
> +		return NULL;
> +	}
>  
> -		if (ret < 0) {
> -			bio_put(b);
> -			return NULL;
> -		}
> +	if (bio_integrity(bio) &&
> +	    bio_integrity_clone(b, bio, gfp_mask) < 0) {
> +		bio_put(b);
> +		return NULL;

Pleae use a goto to merge the common error handling path

> +		if (!bio_crypt_ctx_back_mergeable(req->bio,
> +						  blk_rq_sectors(req),
> +						  next->bio)) {
> +			return ELEVATOR_NO_MERGE;
> +		}

No neef for the braces.  And pretty weird alignment, normal Linux style
would be:

		if (!bio_crypt_ctx_back_mergeable(req->bio,
				blk_rq_sectors(req), next->bio))
			return ELEVATOR_NO_MERGE;

> +		if (!bio_crypt_ctx_back_mergeable(rq->bio,
> +						  blk_rq_sectors(rq), bio)) {
> +			return ELEVATOR_NO_MERGE;
> +		}
>  		return ELEVATOR_BACK_MERGE;
> -	else if (blk_rq_pos(rq) - bio_sectors(bio) == bio->bi_iter.bi_sector)
> +	} else if (blk_rq_pos(rq) - bio_sectors(bio) ==
> +		   bio->bi_iter.bi_sector) {
> +		if (!bio_crypt_ctx_back_mergeable(bio,
> +						  bio_sectors(bio), rq->bio)) {
> +			return ELEVATOR_NO_MERGE;
> +		}

Same for these two.

> +++ b/block/bounce.c
> @@ -267,14 +267,15 @@ static struct bio *bounce_clone_bio(struct bio *bio_src, gfp_t gfp_mask,
>  		break;
>  	}
>  
> -	if (bio_integrity(bio_src)) {
> -		int ret;
> +	if (bio_crypt_clone(bio, bio_src, gfp_mask) < 0) {
> +		bio_put(bio);
> +		return NULL;
> +	}
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

Use a common error path with a goto, please.

> +static inline int bio_crypt_set_ctx(struct bio *bio,
> +				    const u8 *raw_key,
> +				    enum blk_crypto_mode_num crypto_mode,
> +				    u64 dun,
> +				    unsigned int dun_bits,
> +				    gfp_t gfp_mask)

Pleae just open code this in the only caller.

> +{
> +	struct bio_crypt_ctx *crypt_ctx;
> +
> +	crypt_ctx = bio_crypt_alloc_ctx(gfp_mask);
> +	if (!crypt_ctx)
> +		return -ENOMEM;

Also bio_crypt_alloc_ctx with a waiting mask will never return an
error.  Changing this function and its call chain to void returns will
clean up a lot of code in this series.

> +static inline void bio_set_data_unit_num(struct bio *bio, u64 dun)
> +{
> +	bio->bi_crypt_context->data_unit_num = dun;
> +}

This function is never used and can be removed.

> +static inline void bio_crypt_set_keyslot(struct bio *bio,
> +					 unsigned int keyslot,
> +					 struct keyslot_manager *ksm)
> +{
> +	bio->bi_crypt_context->keyslot = keyslot;
> +	bio->bi_crypt_context->processing_ksm = ksm;
> +}

Just adding these two lines to the only caller will be a lot cleaner.

> +static inline const u8 *bio_crypt_raw_key(struct bio *bio)
> +{
> +	return bio->bi_crypt_context->raw_key;
> +}

Can be inlined into the only caller.

> +
> +static inline enum blk_crypto_mode_num bio_crypto_mode(struct bio *bio)
> +{
> +	return bio->bi_crypt_context->crypto_mode;
> +}

Same here.

> +static inline u64 bio_crypt_sw_data_unit_num(struct bio *bio)
> +{
> +	return bio->bi_crypt_context->sw_data_unit_num;
> +}

Same here.
