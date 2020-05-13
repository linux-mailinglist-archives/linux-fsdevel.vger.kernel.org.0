Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88A8E1D1C3A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 19:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389925AbgEMR12 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 13:27:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:54956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732731AbgEMR11 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 13:27:27 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EA452053B;
        Wed, 13 May 2020 17:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589390847;
        bh=0cEJvOzqzlvc+ckapq/Ksd7zF4cLk0jrLsa+BhyTNKY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G1kma4bEuOTNMJPk6yVPXMrF6c+ycpfGtt+l4NA60vp8JgwOg6P0jHIwbxtbMq2ye
         W913pvitFAMsz71ChlNbORZFi8aZwjsphudV+GDYaAUZpzY4B3EIsO9bosnFhpHFOp
         KLdY1gZOo17YKHVEZvuTrAmP5OX5qv4DNT1pVYh0=
Date:   Wed, 13 May 2020 10:27:25 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v12 03/12] block: Inline encryption support for blk-mq
Message-ID: <20200513172725.GC1243@sol.localdomain>
References: <20200430115959.238073-1-satyat@google.com>
 <20200430115959.238073-4-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430115959.238073-4-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 30, 2020 at 11:59:50AM +0000, Satya Tangirala wrote:
> We must have some way of letting a storage device driver know what
> encryption context it should use for en/decrypting a request. However,
> it's the upper layers (like the filesystem/fscrypt) that know about and
> manages encryption contexts. As such, when the upper layer submits a bio
> to the block layer, and this bio eventually reaches a device driver with
> support for inline encryption, the device driver will need to have been
> told the encryption context for that bio.
> 
> We want to communicate the encryption context from the upper layer to the
> storage device along with the bio, when the bio is submitted to the block
> layer. To do this, we add a struct bio_crypt_ctx to struct bio, which can
> represent an encryption context (note that we can't use the bi_private
> field in struct bio to do this because that field does not function to pass
> information across layers in the storage stack). We also introduce various
> functions to manipulate the bio_crypt_ctx and make the bio/request merging
> logic aware of the bio_crypt_ctx.
> 
> We also make changes to blk-mq to make it handle bios with encryption
> contexts. blk-mq can merge many bios into the same request. These bios need
> to have contiguous data unit numbers (the necessary changes to blk-merge
> are also made to ensure this) - as such, it suffices to keep the data unit
> number of just the first bio, since that's all a storage driver needs to
> infer the data unit number to use for each data block in each bio in a
> request. blk-mq keeps track of the encryption context to be used for all
> the bios in a request with the request's rq_crypt_ctx. When the first bio
> is added to an empty request, blk-mq will program the encryption context
> of that bio into the request_queue's keyslot manager, and store the
> returned keyslot in the request's rq_crypt_ctx. All the functions to
> operate on encryption contexts are in blk-crypto.c.
> 
> Upper layers only need to call bio_crypt_set_ctx with the encryption key,
> algorithm and data_unit_num; they don't have to worry about getting a
> keyslot for each encryption context, as blk-mq/blk-crypto handles that.
> Blk-crypto also makes it possible for request-based layered devices like
> dm-rq to make use of inline encryption hardware by cloning the
> rq_crypt_ctx and programming a keyslot in the new request_queue when
> necessary.
> 
> Note that any user of the block layer can submit bios with an
> encryption context, such as filesystems, device-mapper targets, etc.
> 
> Signed-off-by: Satya Tangirala <satyat@google.com>

Looks good, you can add:

    Reviewed-by: Eric Biggers <ebiggers@google.com>

A few comments for if you resend:

> @@ -647,6 +651,8 @@ bool bio_attempt_front_merge(struct request *req, struct bio *bio,
>  	req->__sector = bio->bi_iter.bi_sector;
>  	req->__data_len += bio->bi_iter.bi_size;
>  
> +	bio_crypt_attempt_front_merge(req, bio);
> +
>  	blk_account_io_start(req, false);
>  	return true;
>  }

I think this should be called "bio_crypt_do_front_merge()", since at this point
we've already decided to do the front merge, not just "attempt" it.
"bio_crypt_attempt_front_merge()" sounds like it should have a return value, so
it confused me at first glance.

> +/**
> + * blk_crypto_init_key() - Prepare a key for use with blk-crypto
> + * @blk_key: Pointer to the blk_crypto_key to initialize.
> + * @raw_key: Pointer to the raw key. Must be the correct length for the chosen
> + *	     @crypto_mode; see blk_crypto_modes[].
> + * @crypto_mode: identifier for the encryption algorithm to use
> + * @dun_bytes: number of bytes that will be used to specify the DUN when this
> + *	       key is used
> + * @data_unit_size: the data unit size to use for en/decryption
> + *
> + * Return: 0 on success, -errno on failure.  The caller is responsible for
> + *	   zeroizing both blk_key and raw_key when done with them.
> + */
> +int blk_crypto_init_key(struct blk_crypto_key *blk_key, const u8 *raw_key,
> +			enum blk_crypto_mode_num crypto_mode,
> +			unsigned int dun_bytes,
> +			unsigned int data_unit_size)
> +{
> +	const struct blk_crypto_mode *mode;
> +
> +	memset(blk_key, 0, sizeof(*blk_key));
> +
> +	if (crypto_mode >= ARRAY_SIZE(blk_crypto_modes))
> +		return -EINVAL;
> +
> +	mode = &blk_crypto_modes[crypto_mode];
> +	if (mode->keysize == 0)
> +		return -EINVAL;
> +
> +	if (!is_power_of_2(data_unit_size))
> +		return -EINVAL;

Since we're validating the crypto_mode and data_unit_size, we should validate
the dun_bytes too:

	if (dun_bytes <= 0 || dun_bytes > BLK_CRYPTO_MAX_IV_SIZE)
		return -EINVAL;

(One might argue that dun_bytes == 0 should be allowed in case we add support
for AES-ECB to blk-crypto, to align with the UFS specification which allows it.
But ECB isn't suitable for disk encryption and should never have been included
in the specification, so IMO we should reject dun_bytes==0 with prejudice :-) )

> @@ -2016,6 +2021,15 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
>  
>  	blk_mq_bio_to_request(rq, bio, nr_segs);
>  
> +	ret = blk_crypto_init_request(rq);
> +	if (ret != BLK_STS_OK) {
> +		bio->bi_status = ret;
> +		bio_endio(bio);
> +		blk_mq_free_request(rq);
> +		return BLK_QC_T_NONE;
> +	}
> +
> +

There's an extra blank line here.

- Eric
