Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA2F1FFA81
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 19:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbgFRRsd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 13:48:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:58988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728356AbgFRRsd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 13:48:33 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D599207DD;
        Thu, 18 Jun 2020 17:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592502512;
        bh=ZOxGV61qCMZ+mvpZMM0gV3hYOdWhVFXHU/BEccRNoNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uedDzgpvpynhZLypdYUPWQUHm9movWphBFmtrCdHmsm3s7+j/ieEsOiR4XkReCYto
         OEZtiW6GiqXvnUx4YqqthusOkVd8jzdinjuEqzGCz/uSUwIHmQWGYWz2s9EzLAeuW1
         GLCim5nOZXmhLjy1G+awTfmk/P+XKYaNthFqQUUY=
Date:   Thu, 18 Jun 2020 10:48:31 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/4] fscrypt: add inline encryption support
Message-ID: <20200618174831.GB2957@sol.localdomain>
References: <20200617075732.213198-1-satyat@google.com>
 <20200617075732.213198-3-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617075732.213198-3-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A few nits:

On Wed, Jun 17, 2020 at 07:57:30AM +0000, Satya Tangirala wrote:
> To use inline encryption, the filesystem needs to be mounted with
> '-o inlinecrypt'.  The contents of any encrypted files will then be
> encrypted using blk-crypto, instead of using the traditional
> filesystem-layer crypto.

This isn't clear about what happens when blk-crypto isn't supported on a
file.  How about:

"To use inline encryption, the filesystem needs to be mounted with
'-o inlinecrypt'.  blk-crypto will then be used to encrypt the contents
of any encrypted files where it can be used instead of the traditional
filesystem-layer crypto."

> diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
> index eb7fcd2b7fb8..1572186b0db4 100644
> --- a/fs/crypto/fscrypt_private.h
> +++ b/fs/crypto/fscrypt_private.h
> @@ -14,6 +14,7 @@
>  #include <linux/fscrypt.h>
>  #include <linux/siphash.h>
>  #include <crypto/hash.h>
> +#include <linux/blk-crypto.h>
>  
>  #define CONST_STRLEN(str)	(sizeof(str) - 1)
>  
> @@ -166,6 +167,20 @@ struct fscrypt_symlink_data {
>  	char encrypted_path[1];
>  } __packed;
>  
> +/**
> + * struct fscrypt_prepared_key - a key prepared for actual encryption/decryption
> + * @tfm: crypto API transform object
> + * @blk_key: key for blk-crypto
> + *
> + * Normally only one of the fields will be non-NULL.
> + */
> +struct fscrypt_prepared_key {
> +	struct crypto_skcipher *tfm;
> +#ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
> +	struct fscrypt_blk_crypto_key *blk_key;
> +#endif
> +};
> +
>  /*
>   * fscrypt_info - the "encryption key" for an inode
>   *
> @@ -175,12 +190,23 @@ struct fscrypt_symlink_data {
>   */
>  struct fscrypt_info {
>  
> -	/* The actual crypto transform used for encryption and decryption */
> -	struct crypto_skcipher *ci_ctfm;
> +	/* The key in a form prepared for actual encryption/decryption */
> +	struct fscrypt_prepared_key	ci_enc_key;

Space instead of tab before ci_enc_key, to match the other fields of
this struct.

>  
> -	/* True if the key should be freed when this fscrypt_info is freed */
> +	/*
> +	 * True if the ci_enc_key should be freed when this fscrypt_info is
> +	 * freed
> +	 */
>  	bool ci_owns_key;

This comment would fit nicely on one line if "the" was deleted:

	/* True if ci_enc_key should be freed when this fscrypt_info is freed */

> +/* inline_crypt.c */
> +#ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
> +void fscrypt_select_encryption_impl(struct fscrypt_info *ci);
> +
> +static inline bool
> +fscrypt_using_inline_encryption(const struct fscrypt_info *ci)
> +{
> +	return ci->ci_inlinecrypt;
> +}
> +
> +int fscrypt_prepare_inline_crypt_key(struct fscrypt_prepared_key *prep_key,
> +				     const u8 *raw_key,
> +				     const struct fscrypt_info *ci);
> +
> +void fscrypt_destroy_inline_crypt_key(struct fscrypt_prepared_key *prep_key);
> +
> +/*
> + * Check whether the crypto transform or blk-crypto key has been allocated in
> + * @prep_key, depending on which encryption implementation the file will use.
> + */
> +static inline bool
> +fscrypt_is_key_prepared(struct fscrypt_prepared_key *prep_key,
> +			const struct fscrypt_info *ci)
> +{
> +	/*
> +	 * The READ_ONCE() here pairs with the smp_store_release() in
> +	 * fscrypt_prepare_key().  (This only matters for the per-mode keys,
> +	 * which are shared by multiple inodes.)
> +	 */
> +	if (fscrypt_using_inline_encryption(ci))
> +		return READ_ONCE(prep_key->blk_key) != NULL;
> +	return READ_ONCE(prep_key->tfm) != NULL;
> +}
> +
> +#else /* CONFIG_FS_ENCRYPTION_INLINE_CRYPT */
> +
> +static inline void fscrypt_select_encryption_impl(struct fscrypt_info *ci)
> +{
> +}
> +
> +static inline bool fscrypt_using_inline_encryption(
> +					const struct fscrypt_info *ci)
> +{
> +	return false;
> +}

fscrypt_using_inline_encryption() here is formatted differently from the
CONFIG_FS_ENCRYPTION_INLINE_CRYPT=y case.  I'd use for both:

static inline bool
fscrypt_using_inline_encryption(const struct fscrypt_info *ci)

> +int fscrypt_prepare_key(struct fscrypt_prepared_key *prep_key,
> +			const u8 *raw_key,
> +			const struct fscrypt_info *ci);

'raw_key' and 'ci' fit on one line.  (Note: the definition already does that.)

> +/* Enable inline encryption for this file if supported. */
> +void fscrypt_select_encryption_impl(struct fscrypt_info *ci)
> +{

This function should return an error code (0 or -ENOMEM) so that
failure of kmalloc_array() can be reported.

> +	/* The crypto mode must be valid */
> +	if (ci->ci_mode->blk_crypto_mode == BLK_ENCRYPTION_MODE_INVALID)
> +		return;

The comment "The crypto mode must be valid" is confusing, since the mode
*is* valid for fscrypt, just not for blk-crypto.  How about:

	/* The crypto mode must have a blk-crypto counterpart */

> +	/*
> +	 * blk-crypto must support the crypto configuration we'll use for the
> +	 * inode on all devices in the sb
> +	 */

I think the following would be a slightly clearer and more consistent
with other comments:

	/*
	 * On all the filesystem's devices, blk-crypto must support the crypto
	 * configuration that the file would use.
	 */

> +/**
> + * fscrypt_mergeable_bio() - test whether data can be added to a bio
> + * @bio: the bio being built up
> + * @inode: the inode for the next part of the I/O
> + * @next_lblk: the next file logical block number in the I/O
> + *
> + * When building a bio which may contain data which should undergo inline
> + * encryption (or decryption) via fscrypt, filesystems should call this function
> + * to ensure that the resulting bio contains only logically contiguous data.
> + * This will return false if the next part of the I/O cannot be merged with the
> + * bio because either the encryption key would be different or the encryption
> + * data unit numbers would be discontiguous.
> + *
> + * fscrypt_set_bio_crypt_ctx() must have already been called on the bio.
> + *
> + * Return: true iff the I/O is mergeable
> + */

The mention of "logically contiguous data" here is now technically wrong
due to the new IV_INO_LBLK_32 IV generation method.  For that, logically
contiguous blocks don't necessarily have contiguous DUNs.

I'd replace in this comment:
	"logically contiguous data" => "contiguous data unit numbers"

- Eric
