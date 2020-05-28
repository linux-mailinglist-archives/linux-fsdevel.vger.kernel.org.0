Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8FEA1E6E35
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 23:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436781AbgE1V4Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 17:56:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436745AbgE1V4X (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 17:56:23 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C1E0206F1;
        Thu, 28 May 2020 21:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590702982;
        bh=YrvA6l1wo4LASJiVpABx+mDsD3QcKwzk5VGr+qu3r4c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rEJMBMPXsLqP516mYlBkqFn4ZibP50uBkCESunKDePTB/L5cCrgLy2v/2tR1SN+aa
         g3GjRaUu76j+HeqJkWL7d6rAhzwYeGle3Q+vgQj6s/0yhQ+hWVDunlbLRfOr835Mt5
         mac8NUQU0tbuTlMA7ONnECD74zrStT9vhTojjbxQ=
Date:   Thu, 28 May 2020 14:54:30 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v13 10/12] fscrypt: add inline encryption support
Message-ID: <20200528215430.GA143195@gmail.com>
References: <20200514003727.69001-1-satyat@google.com>
 <20200514003727.69001-11-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514003727.69001-11-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A few minor things to clean up when you resend this after v5.8-rc1:

(You'll have to resolve the conflicts with
 https://lore.kernel.org/r/20200515204141.251098-1-ebiggers@kernel.org
 too, but it shouldn't be too hard.  Note that I made setup_per_mode_enc_key()
 use a mutex, like this patch does.)

On Thu, May 14, 2020 at 12:37:25AM +0000, Satya Tangirala wrote:
> Add support for inline encryption to fs/crypto/.  With "inline
> encryption", the block layer handles the decryption/encryption as part
> of the bio, instead of the filesystem doing the crypto itself via
> Linux's crypto API.  This model is needed in order to take advantage of
> the inline encryption hardware present on most modern mobile SoCs.
> 
> To use inline encryption, the filesystem needs to be mounted with
> '-o inlinecrypt'.  The contents of any encrypted files will then be
> encrypted using blk-crypto, instead of using the traditional
> filesystem-layer crypto. Fscrypt still provides the key and IV to use,
> and the actual ciphertext on-disk is still the same; therefore it's
> testable using the existing fscrypt ciphertext verification tests.
> 
> Note that since blk-crypto has a fallack to Linux's crypto API, and

"fallack" => "fallback"

>  struct fscrypt_info {
>  
> -	/* The actual crypto transform used for encryption and decryption */
> -	struct crypto_skcipher *ci_ctfm;
> +	/* The key in a form prepared for actual encryption/decryption */
> +	struct fscrypt_prepared_key	ci_key;
>  

It would be clearer to call this field 'ci_enc_key' instead of 'ci_key'.
Since there are several types of fscrypt keys, including the recently added
ci_dirhash_key, I've been trying to clarify what type of key is meant when it's
ambiguous.  E.g. see https://git.kernel.org/torvalds/c/f592efe735a29c76

>  	/* True if the key should be freed when this fscrypt_info is freed */

If taking the above suggestion, this would need "the key" => "ci_enc_key"

>  	/*
>  	 * If non-NULL, then encryption is done using the master key directly
> -	 * and ci_ctfm will equal ci_direct_key->dk_ctfm.
> +	 * and ci_key will equal ci_direct_key->dk_key.
>  	 */

If taking the above suggestion, this would need "ci_key" => "ci_enc_key"

> +/* inline_crypt.c */
> +#ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
> +extern void fscrypt_select_encryption_impl(struct fscrypt_info *ci);

I'm now trying to consistently not use 'extern' on function declarations.  So,
can you remove it from the new declarations here and include/linux/fscrypt.h?

> +/**
> + * fscrypt_set_bio_crypt_ctx - prepare a file contents bio for inline encryption

I'm also now trying to consistently include the parentheses in the function
names in kerneldoc comments.  So:

 * fscrypt_set_bio_crypt_ctx() - prepare a file data bio for inline crypto

 * fscrypt_set_bio_crypt_ctx_bh() - prepare a file data bio for inline crypto

(similarly for the other new kerneldoc comments)

Make sure to also run

	scripts/kernel-doc -v -none fs/crypto/*.{c,h} include/linux/fscrypt.h

to check for new kerneldoc warnings.  In fscrypt.git#master I've gotten rid of
all the existing ones.

Thanks!

- Eric
