Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF50194905
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Mar 2020 21:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgCZU2a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Mar 2020 16:28:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728847AbgCZU22 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Mar 2020 16:28:28 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6A4B20775;
        Thu, 26 Mar 2020 20:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585254507;
        bh=POApO7xjc2R9qUby99KjfBYobM0PigxIu6iKSXh0YTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yuuDV27xql+w9QP6gC4+BD06IS1YX5PzuojXqTrytI3EHuPsDyEakoaUOUk2IszZq
         npS0PJjgCrleVPprMkQ6LTZfJVPqpL/INQwScBLJeIaL8XlfQcmubkt8aArHtn/lwz
         wUbq664xyeCUft0Idt/gUcOADdvieH2ZeBJEVmEM=
Date:   Thu, 26 Mar 2020 13:28:25 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v9 04/11] block: blk-crypto-fallback for Inline Encryption
Message-ID: <20200326202825.GB186343@gmail.com>
References: <20200326030702.223233-1-satyat@google.com>
 <20200326030702.223233-5-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326030702.223233-5-satyat@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 25, 2020 at 08:06:55PM -0700, Satya Tangirala wrote:
> Blk-crypto delegates crypto operations to inline encryption hardware when
> available. The separately configurable blk-crypto-fallback contains a
> software fallback to the kernel crypto API - when enabled, blk-crypto
> will use this fallback for en/decryption when inline encryption hardware is
> not available. This lets upper layers not have to worry about whether or
> not the underlying device has support for inline encryption before
> deciding to specify an encryption context for a bio, and also allows for
> testing without actual inline encryption hardware. For more details, refer
> to Documentation/block/inline-encryption.rst.
> 
> Signed-off-by: Satya Tangirala <satyat@google.com>

It might be helpful to also mention some real-world examples of how this helps
testing, e.g. it makes it possible to test the inline encryption code in ext4
and f2fs simply by running xfstests with the inlinecrypt mount option.
Therefore it makes it possible for the regular upstream regression testing of
ext4 to cover the inline encryption code paths.

> diff --git a/Documentation/block/inline-encryption.rst b/Documentation/block/inline-encryption.rst
> new file mode 100644
> index 0000000000000..3fa475799ecd1
> --- /dev/null
> +++ b/Documentation/block/inline-encryption.rst
> @@ -0,0 +1,195 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=================
> +Inline Encryption
> +=================

You may want to consider further improving this documentation file and then
putting it as patch 1 of the series as its own patch to introduce the rest of
the series, rather than "hiding" it in this particular patch.  The documentation
is for blk-crypto as a whole; it's not specific to blk-crypto-fallback.

> +struct bio_fallback_crypt_ctx {
> +	struct bio_crypt_ctx crypt_ctx;
> +	/*
> +	 * Copy of the bvec_iter when this bio was submitted.
> +	 * We only want to en/decrypt the part of the bio as described by the
> +	 * bvec_iter upon submission because bio might be split before being
> +	 * resubmitted
> +	 */
> +	struct bvec_iter crypt_iter;
> +	u64 fallback_dun[BLK_CRYPTO_DUN_ARRAY_SIZE];
> +	union {
> +		struct {
> +			struct work_struct work;
> +			struct bio *bio;
> +		};
> +		struct {
> +			void *bi_private_orig;
> +			bio_end_io_t *bi_end_io_orig;
> +		};
> +	};
> +};

Isn't 'fallback_dun' unnecessary now that blk-crypto-fallback uses bi_private?
'fallback_dun' should always be equal to 'crypt_ctx.bc_dun', right?

> +/**
> + * blk_crypto_fallback_bio_prep - Prepare a bio to use fallback en/decryption
> + *
> + * @bio_ptr: pointer to the bio to prepare
> + *
> + * If bio is doing a WRITE operation, we split the bio into two parts, resubmit
> + * the second part. Allocates a bounce bio for the first part, encrypts it, and
> + * update bio_ptr to point to the bounce bio.

This comment is misleading.  The code actually only splits the bio if it's very
large; it doesn't always split it.

> diff --git a/block/blk-crypto.c b/block/blk-crypto.c
> index a52ec4eb153be..41d5e421624e5 100644
> --- a/block/blk-crypto.c
> +++ b/block/blk-crypto.c
> @@ -3,6 +3,10 @@
>   * Copyright 2019 Google LLC
>   */
>  
> +/*
> + * Refer to Documentation/block/inline-encryption.rst for detailed explanation.
> + */
> +
>  #define pr_fmt(fmt) "blk-crypto: " fmt
>  
>  #include <linux/bio.h>
> @@ -206,7 +210,8 @@ static bool bio_crypt_check_alignment(struct bio *bio)
>   * __blk_crypto_init_request - Initializes the request's crypto fields based on
>   *			       the blk_crypto_key for a bio to be added to the
>   *			       request, and prepares it for hardware inline
> - *			       encryption.
> + *			       encryption (as opposed to using the crypto API
> + *			       fallback).
>   *
>   * @rq: The request to init
>   * @key: The blk_crypto_key of bios that will (eventually) be added to @rq.
> @@ -219,6 +224,10 @@ static bool bio_crypt_check_alignment(struct bio *bio)
>  blk_status_t __blk_crypto_init_request(struct request *rq,
>  				       const struct blk_crypto_key *key)
>  {
> +	/*
> +	 * We have a bio crypt context here - that means we didn't fallback
> +	 * to crypto API, so try to program a keyslot now.
> +	 */
>  	return blk_ksm_get_slot_for_key(rq->q->ksm, key, &rq->crypt_keyslot);
>  }

Since the fallback is now transparent to everything below it, we probably
shouldn't leave as many comments like this around that mention the fallback.
Comments are more useful if the code is doing something unexpected, as opposed
to something expected.

>  void __blk_crypto_rq_prep_clone(struct request *dst, struct request *src)
>  {
> +	/* Don't clone crypto info if src uses fallback en/decryption */
> +	if (!src->crypt_keyslot)
> +		return;
> +
>  	dst->crypt_ctx = src->crypt_ctx;
>  }

Isn't this part unnecessary?  If the fallback was used, there is no crypt
context anymore.

- Eric
