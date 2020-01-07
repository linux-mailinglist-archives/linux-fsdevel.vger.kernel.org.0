Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2A1131E36
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 05:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbgAGECa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jan 2020 23:02:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:44090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727441AbgAGECa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jan 2020 23:02:30 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3854E2075A;
        Tue,  7 Jan 2020 04:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578369749;
        bh=SGiwJZ1cj1RSxCwq18Rs//spHGsKusiqB2dlalvIa2Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X/7oUzcEYRNo7uvBJNRjQdavOJiB2GJZ0dp5hb5RPicSqGlYymTrHcnj9c8zqkQZT
         +y2h6F/4GXqimgSRmO0vQDpwm/pDyE/hnor1SydCiUAawgSRG0rvRczrm6HxgQbQ7E
         x6FGzOvpVSQaxFhW7UuJ6S0Jzrcu+bdcDpKjcLaU=
Date:   Mon, 6 Jan 2020 20:02:27 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Subject: Re: [PATCH v2 1/3] fscrypt: Add siphash and hash key for policy v2
Message-ID: <20200107040227.GE705@sol.localdomain>
References: <20200107023323.38394-1-drosen@google.com>
 <20200107023323.38394-2-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107023323.38394-2-drosen@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 06, 2020 at 06:33:21PM -0800, Daniel Rosenberg wrote:
> With encryption and casefolding, we cannot simply take the hash of the
> ciphertext because of case insensitivity, and we can't take the hash of
> the unencrypted name since that would leak information about the
> encrypted name. Instead we can use siphash to compute a keyed hash of
> the file names.
> 
> When a v2 policy is used on a directory, we derive a key for use with
> siphash.
> 
> Signed-off-by: Daniel Rosenberg <drosen@google.com>
> ---
>  fs/crypto/fname.c           | 22 ++++++++++++++++++++++
>  fs/crypto/fscrypt_private.h |  9 +++++++++
>  fs/crypto/keysetup.c        | 32 +++++++++++++++++++++++---------
>  include/linux/fscrypt.h     |  9 +++++++++
>  4 files changed, 63 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
> index 3fd27e14ebdd..371e8f01d1c8 100644
> --- a/fs/crypto/fname.c
> +++ b/fs/crypto/fname.c
> @@ -402,6 +402,28 @@ int fscrypt_setup_filename(struct inode *dir, const struct qstr *iname,
>  }
>  EXPORT_SYMBOL(fscrypt_setup_filename);
>  
> +/**
> + * fscrypt_fname_siphash() - Calculate the siphash for a file name
> + * @dir: the parent directory
> + * @name: the name of the file to get the siphash of
> + *
> + * Given a user-provided filename @name, this function calculates the siphash of
> + * that name using the directory's hash key.
> + *
> + * This assumes the directory uses a v2 policy, and the key is available.
> + *
> + * Return: the siphash of @name using the hash key of @dir
> + */
> +u64 fscrypt_fname_siphash(const struct inode *dir, const struct qstr *name)
> +{
> +	struct fscrypt_info *ci = dir->i_crypt_info;
> +
> +	WARN_ON(!ci->ci_hash_key_initialized);
> +
> +	return siphash(name->name, name->len, &ci->ci_hash_key);
> +}
> +EXPORT_SYMBOL(fscrypt_fname_siphash);
> +
>  /*
>   * Validate dentries in encrypted directories to make sure we aren't potentially
>   * caching stale dentries after a key has been added.
> diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
> index b22e8decebed..8b37a5eebb57 100644
> --- a/fs/crypto/fscrypt_private.h
> +++ b/fs/crypto/fscrypt_private.h
> @@ -12,6 +12,7 @@
>  #define _FSCRYPT_PRIVATE_H
>  
>  #include <linux/fscrypt.h>
> +#include <linux/siphash.h>
>  #include <crypto/hash.h>
>  
>  #define CONST_STRLEN(str)	(sizeof(str) - 1)
> @@ -188,6 +189,13 @@ struct fscrypt_info {
>  	 */
>  	struct fscrypt_direct_key *ci_direct_key;
>  
> +	/*
> +	 * With v2 policies, this can be used with siphash
> +	 * When the key has been set, ci_hash_key_initialized is set to true
> +	 */
> +	siphash_key_t ci_hash_key;
> +	bool ci_hash_key_initialized;
> +
>  	/* The encryption policy used by this inode */
>  	union fscrypt_policy ci_policy;
>  
> @@ -262,6 +270,7 @@ extern int fscrypt_init_hkdf(struct fscrypt_hkdf *hkdf, const u8 *master_key,
>  #define HKDF_CONTEXT_PER_FILE_KEY	2
>  #define HKDF_CONTEXT_DIRECT_KEY		3
>  #define HKDF_CONTEXT_IV_INO_LBLK_64_KEY	4
> +#define HKDF_CONTEXT_FNAME_HASH_KEY     5
>  
>  extern int fscrypt_hkdf_expand(const struct fscrypt_hkdf *hkdf, u8 context,
>  			       const u8 *info, unsigned int infolen,
> diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
> index 96074054bdbc..c1bd897c9310 100644
> --- a/fs/crypto/keysetup.c
> +++ b/fs/crypto/keysetup.c
> @@ -189,7 +189,7 @@ static int fscrypt_setup_v2_file_key(struct fscrypt_info *ci,
>  		 * This ensures that the master key is consistently used only
>  		 * for HKDF, avoiding key reuse issues.
>  		 */
> -		return setup_per_mode_key(ci, mk, mk->mk_direct_tfms,
> +		err = setup_per_mode_key(ci, mk, mk->mk_direct_tfms,
>  					  HKDF_CONTEXT_DIRECT_KEY, false);
>  	} else if (ci->ci_policy.v2.flags &
>  		   FSCRYPT_POLICY_FLAG_IV_INO_LBLK_64) {
> @@ -199,20 +199,34 @@ static int fscrypt_setup_v2_file_key(struct fscrypt_info *ci,
>  		 * the IVs.  This format is optimized for use with inline
>  		 * encryption hardware compliant with the UFS or eMMC standards.
>  		 */
> -		return setup_per_mode_key(ci, mk, mk->mk_iv_ino_lblk_64_tfms,
> +		err = setup_per_mode_key(ci, mk, mk->mk_iv_ino_lblk_64_tfms,
>  					  HKDF_CONTEXT_IV_INO_LBLK_64_KEY,
>  					  true);
> +	} else {
> +		err = fscrypt_hkdf_expand(&mk->mk_secret.hkdf,
> +					  HKDF_CONTEXT_PER_FILE_KEY,
> +					  ci->ci_nonce,
> +					  FS_KEY_DERIVATION_NONCE_SIZE,
> +					  derived_key, ci->ci_mode->keysize);
> +		if (err)
> +			return err;
> +
> +		err = fscrypt_set_derived_key(ci, derived_key);
> +		memzero_explicit(derived_key, ci->ci_mode->keysize);
>  	}
> -
> -	err = fscrypt_hkdf_expand(&mk->mk_secret.hkdf,
> -				  HKDF_CONTEXT_PER_FILE_KEY,
> -				  ci->ci_nonce, FS_KEY_DERIVATION_NONCE_SIZE,
> -				  derived_key, ci->ci_mode->keysize);
>  	if (err)
>  		return err;
>  
> -	err = fscrypt_set_derived_key(ci, derived_key);
> -	memzero_explicit(derived_key, ci->ci_mode->keysize);
> +	if (S_ISDIR(ci->ci_inode->i_mode)) {
> +		err = fscrypt_hkdf_expand(&mk->mk_secret.hkdf,
> +					  HKDF_CONTEXT_FNAME_HASH_KEY,
> +					  ci->ci_nonce,
> +					  FS_KEY_DERIVATION_NONCE_SIZE,
> +					  (u8 *)&ci->ci_hash_key,
> +					  sizeof(ci->ci_hash_key));
> +		if (!err)
> +			ci->ci_hash_key_initialized = true;
> +	}
>  	return err;
>  }
>  

This is deriving a SipHash key for every directory, even ones which won't use it
at all.  Since deriving a SipHash key is just as expensive as deriving an
encryption key, this doubles the time needed to setup every directory's key(s)
-- or even much more than doubles it, in the case of per-mode encryption keys.

It's really important that we keep fscrypt overhead as low as possible.
How feasible would it be to only derive the SipHash key when needed?
I.e., check IS_CASEFOLDED() here, and derive the SipHash key if needed in
fscrypt_ioc_setflags_prepare()?  Is the problem that safely getting access to
the master key again is hard?

- Eric
