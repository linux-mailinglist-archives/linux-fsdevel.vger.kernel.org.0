Return-Path: <linux-fsdevel+bounces-4833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B79D8804A2D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 07:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B25F8B20B23
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 06:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345C5DF67
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 06:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCDZ1SYm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8347211A;
	Tue,  5 Dec 2023 04:54:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48276C433C7;
	Tue,  5 Dec 2023 04:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701752044;
	bh=gfnlbyYTn/MoiggJHqdV/y+nYA+UAKkU/fA7bdBpam8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RCDZ1SYmsNVA8OTNgEzLwWqeHAlYhOPQXBF4wMm/0xd5T/TmB92iorV1/72FjuVPO
	 YxdCbYRDh5pX1R+pmGRc8/uBNBjfZknRL/NcQEhS9gm47Y4HeOSK7yADpfUnVNRB8i
	 kuB4cZ4qkcTCI6myzLmkJIFpNQci9+0Zbs+y6ZAnLkam6ZUW4FZJV5Wq6JFty5vJ5Z
	 CdvaTxDWjPPxcA5nhJ4wfe8YgJg7cIX6iHOITR2f0PcYzhgPso2S8XkVdvq2bN6qkf
	 TOUpbKAPGK7Dob1dhobl2T1iyiJ7fe8dUS5GajlZeq8M5KTxZ5BE+hmdZ17G3fDPjM
	 TeU8svdAjp6WA==
Date: Mon, 4 Dec 2023 20:54:02 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 05/46] blk-crypto: add a process bio callback
Message-ID: <20231205045402.GG1168@sol.localdomain>
References: <cover.1701468305.git.josef@toxicpanda.com>
 <eeeea8d462fe739cff8883feeccacd154a10b40b.1701468306.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eeeea8d462fe739cff8883feeccacd154a10b40b.1701468306.git.josef@toxicpanda.com>

On Fri, Dec 01, 2023 at 05:11:02PM -0500, Josef Bacik wrote:
> +	/* Process the encrypted bio before we submit it. */
> +	if (bc->bc_key->crypto_cfg.process_bio) {
> +		blk_st = bc->bc_key->crypto_cfg.process_bio(src_bio, enc_bio);
> +		if (blk_st != BLK_STS_OK) {
> +			src_bio->bi_status = blk_st;
> +			goto out_free_bounce_pages;
> +		}
> +	}
> +

How does this interact with the splitting that can happen at the beginning of
blk_crypto_fallback_encrypt_bio()?  Won't src_bio differ from the original bio
in that case?

> +	/*
> +	 * Process the bio first before trying to decrypt.
> +	 *
> +	 * NOTE: btrfs expects that this bio is the same that was submitted.  If
> +	 * at any point this changes we will need to update process_bio to take
> +	 * f_ctx->crypt_iter in order to make sure we can iterate the pages for
> +	 * checksumming.  We're currently saving this in our btrfs_bio, so this
> +	 * works, but if at any point in the future we start allocating a bounce
> +	 * bio or something we need to update this callback.
> +	 */
> +	if (bc->bc_key->crypto_cfg.process_bio) {
> +		blk_st = bc->bc_key->crypto_cfg.process_bio(bio, bio);
> +		if (blk_st != BLK_STS_OK) {
> +			bio->bi_status = blk_st;
> +			goto out_no_keyslot;
> +		}
> +	}

The NOTE above feels a bit out of place.  It doesn't make sense to use a bounce
bio for decryption, so the described concern doesn't seem too realistic.
Specific filesystems also shouldn't really be mentioned here.  Maybe the comment
should just say that the contract of blk_crypto_process_bio_t requires
orig_bio == enc_bio for reads?  Maybe it should be a comment on
blk_crypto_process_bio_t itself.

> +/**
> + * blk_crypto_cfg_supports_process_bio - check if this config supports
> + *					 process_bio
> + * @profile: the profile we're checking
> + *
> + * This is just a quick check to make sure @profile is the fallback profile, as
> + * no other offload implementations support process_bio.
> + */
> +bool blk_crypto_cfg_supports_process_bio(struct blk_crypto_profile *profile)
> +{
> +	return profile == blk_crypto_fallback_profile;
> +}

How about calling this blk_crypto_profile_is_fallback()?

> diff --git a/include/linux/blk-crypto.h b/include/linux/blk-crypto.h
> index 5e5822c18ee4..194c1d727013 100644
> --- a/include/linux/blk-crypto.h
> +++ b/include/linux/blk-crypto.h
> @@ -6,7 +6,7 @@
>  #ifndef __LINUX_BLK_CRYPTO_H
>  #define __LINUX_BLK_CRYPTO_H
>  
> -#include <linux/types.h>
> +#include <linux/blk_types.h>
>  
>  enum blk_crypto_mode_num {
>  	BLK_ENCRYPTION_MODE_INVALID,
> @@ -17,6 +17,9 @@ enum blk_crypto_mode_num {
>  	BLK_ENCRYPTION_MODE_MAX,
>  };
>  
> +typedef blk_status_t (blk_crypto_process_bio_t)(struct bio *orig_bio,
> +						struct bio *enc_bio);

Usually people include a '*' in function pointer typedefs.

> +
>  #define BLK_CRYPTO_MAX_KEY_SIZE		64
>  /**
>   * struct blk_crypto_config - an inline encryption key's crypto configuration

This kerneldoc comment is missing documentation for process_bio.

> @@ -31,6 +34,7 @@ struct blk_crypto_config {
>  	enum blk_crypto_mode_num crypto_mode;
>  	unsigned int data_unit_size;
>  	unsigned int dun_bytes;
> +	blk_crypto_process_bio_t *process_bio;
>  };

*process_bio => process_bio.

> diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
> index 756f23fc3e83..5f5efb472fc9 100644
> --- a/include/linux/fscrypt.h
> +++ b/include/linux/fscrypt.h
> @@ -16,6 +16,7 @@
>  #include <linux/fs.h>
>  #include <linux/mm.h>
>  #include <linux/slab.h>
> +#include <linux/blk-crypto.h>
>  #include <uapi/linux/fscrypt.h>
>  
>  /*
> @@ -199,6 +200,19 @@ struct fscrypt_operations {
>  	 */
>  	struct block_device **(*get_devices)(struct super_block *sb,
>  					     unsigned int *num_devs);
> +
> +	/*
> +	 * A callback if the file system requires the ability to process the
> +	 * encrypted bio.
> +	 *
> +	 * @orig_bio: the original bio submitted.
> +	 * @enc_bio: the encrypted bio.
> +	 *
> +	 * For writes the enc_bio will be different from the orig_bio, for reads
> +	 * they will be the same.  For reads we get the bio before it is
> +	 * decrypted, for writes we get the bio before it is submitted.
> +	 */
> +	blk_crypto_process_bio_t *process_bio;

Adding fscrypt support for process_bio should be a separate patch.

Also, the documentation for fscrypt_operations::process_bio should make it clear
that it only applies to inline encryption.

- Eric

