Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA5A9131E08
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 04:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgAGDfG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jan 2020 22:35:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:38076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbgAGDfF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jan 2020 22:35:05 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44BD02064C;
        Tue,  7 Jan 2020 03:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578368104;
        bh=e118KvI5qb2fDQ7LkiIqY/PWfnMIY8wleRWU1qItE80=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v/YT298JtKLhlmgaYYQkrPwvxIqWw/qoIJvqTiVulWgtsARHsnEPgfQgMHIgGs8vG
         xiI/sxLjHuJ4kkBdKzR/jjZfeaZK87Mg1FafCVo3xj3+NPRid9ey2FibIroRnR82ST
         LcyZrrRZJl01rFA78G+AUzrA9ejJJuUV2Qs9wHFM=
Date:   Mon, 6 Jan 2020 19:35:02 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Subject: Re: [PATCH v2 2/3] fscrypt: Don't allow v1 policies with casefolding
Message-ID: <20200107033502.GC705@sol.localdomain>
References: <20200107023323.38394-1-drosen@google.com>
 <20200107023323.38394-3-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107023323.38394-3-drosen@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 06, 2020 at 06:33:22PM -0800, Daniel Rosenberg wrote:
> Casefolding currently requires a derived key for computing the siphash.
> This is available for v2 policies, but not v1, so we disallow it for v1.
> 
> Signed-off-by: Daniel Rosenberg <drosen@google.com>
> ---
>  fs/crypto/keysetup.c    |  7 ++++---
>  fs/crypto/policy.c      | 39 +++++++++++++++++++++++++++++++++++++++
>  fs/inode.c              |  7 +++++++
>  include/linux/fscrypt.h | 11 +++++++++++
>  4 files changed, 61 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
> index c1bd897c9310..7445ab76e0b3 100644
> --- a/fs/crypto/keysetup.c
> +++ b/fs/crypto/keysetup.c
> @@ -224,10 +224,11 @@ static int fscrypt_setup_v2_file_key(struct fscrypt_info *ci,
>  					  FS_KEY_DERIVATION_NONCE_SIZE,
>  					  (u8 *)&ci->ci_hash_key,
>  					  sizeof(ci->ci_hash_key));
> -		if (!err)
> -			ci->ci_hash_key_initialized = true;
> +		if (err)
> +			return err;
> +		ci->ci_hash_key_initialized = true;
>  	}
> -	return err;
> +	return 0;
>  }

This part should be folded into patch 1.

>  
>  /*
> diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
> index f1cff83c151a..9e937cfa732c 100644
> --- a/fs/crypto/policy.c
> +++ b/fs/crypto/policy.c
> @@ -124,6 +124,12 @@ static bool fscrypt_supported_v1_policy(const struct fscrypt_policy_v1 *policy,
>  					policy->filenames_encryption_mode))
>  		return false;
>  
> +	if (IS_CASEFOLDED(inode)) {
> +		fscrypt_warn(inode,
> +			     "v1 policy does not support casefolded directories");
> +		return false;
> +	}
> +
>  	return true;
>  }
>  
> @@ -579,3 +585,36 @@ int fscrypt_inherit_context(struct inode *parent, struct inode *child,
>  	return preload ? fscrypt_get_encryption_info(child): 0;
>  }
>  EXPORT_SYMBOL(fscrypt_inherit_context);
> +
> +static int fscrypt_set_casefolding_allowed(struct inode *inode)
> +{
> +	union fscrypt_policy policy;
> +	int err = fscrypt_get_policy(inode, &policy);
> +
> +	if (err)
> +		return err;
> +
> +	if (policy.version != FSCRYPT_POLICY_V2)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +int fscrypt_ioc_setflags_prepare(struct inode *inode,
> +				 unsigned int oldflags,
> +				 unsigned int flags)
> +{
> +	int err;
> +
> +	/*
> +	 * When a directory is encrypted, the CASEFOLD flag can only be turned
> +	 * on if the fscrypt policy supports it.
> +	 */
> +	if (IS_ENCRYPTED(inode) && (flags & ~oldflags & FS_CASEFOLD_FL)) {
> +		err = fscrypt_set_casefolding_allowed(inode);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}

There's not really any point to the fscrypt_set_casefolding_allowed() function.
It can just be folded into fscrypt_ioc_setflags_prepare():

int fscrypt_ioc_setflags_prepare(struct inode *inode,
				 unsigned int oldflags,
				 unsigned int flags)
{
	union fscrypt_policy policy;
	int err;

	/*
	 * When a directory is encrypted, the CASEFOLD flag can only be turned
	 * on if the fscrypt policy supports it.
	 */
	if (IS_ENCRYPTED(inode) && (flags & ~oldflags & FS_CASEFOLD_FL)) {
		err = fscrypt_get_policy(inode, &policy);
		if (err)
			return err;
		if (policy.version != FSCRYPT_POLICY_V2)
			return -EINVAL;
	}

	return 0;
}

> @@ -2242,6 +2243,8 @@ EXPORT_SYMBOL(current_time);
>  int vfs_ioc_setflags_prepare(struct inode *inode, unsigned int oldflags,
>  			     unsigned int flags)
>  {
> +	int err;
> +
>  	/*
>  	 * The IMMUTABLE and APPEND_ONLY flags can only be changed by
>  	 * the relevant capability.
> @@ -2252,6 +2255,10 @@ int vfs_ioc_setflags_prepare(struct inode *inode, unsigned int oldflags,
>  	    !capable(CAP_LINUX_IMMUTABLE))
>  		return -EPERM;
>  
> +	err = fscrypt_ioc_setflags_prepare(inode, oldflags, flags);
> +	if (err)
> +		return err;
> +
>  	return 0;
>  }

Can just do 'return fscrypt_ioc_setflags_prepare(inode, oldflags, flags);'

- Eric
