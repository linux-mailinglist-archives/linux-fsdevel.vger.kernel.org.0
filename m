Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78F2D112051
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 00:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfLCXhY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 18:37:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:45894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbfLCXhY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 18:37:24 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1858020656;
        Tue,  3 Dec 2019 23:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575416242;
        bh=oBlyMq4h1w80kqTkWb/Gz5L8T8126mtBIKddWWF/JAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kWxdiItltSxMlKyb5CztyvIAdnfVgCNZeEr/34VKn0Vn0tjr44VDRCZ50Z7Pjm9bi
         KaHf7BniYOUi6vXEBpW7zteiKtl74+T7CwxvHQmKXSlR3onpaT8hhtOM6kKmaA3U6E
         MyDCopRdPyHVmbqLaRn9TGUEZI3xo3iEp5C3p9Ns=
Date:   Tue, 3 Dec 2019 15:37:20 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Subject: Re: [PATCH 2/8] fscrypt: Don't allow v1 policies with casefolding
Message-ID: <20191203233720.GC727@sol.localdomain>
References: <20191203051049.44573-1-drosen@google.com>
 <20191203051049.44573-3-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203051049.44573-3-drosen@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 02, 2019 at 09:10:43PM -0800, Daniel Rosenberg wrote:
> Casefolding requires a derived key for computing the siphash.
> This is available for v2 policies, but not v1, so we disallow it for v1.
> 
> Signed-off-by: Daniel Rosenberg <drosen@google.com>
> ---
>  fs/crypto/policy.c      | 26 +++++++++++++++++++++++---
>  fs/inode.c              |  8 ++++++++
>  include/linux/fscrypt.h |  7 +++++++
>  3 files changed, 38 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
> index 96f528071bed..94d96d3212d6 100644
> --- a/fs/crypto/policy.c
> +++ b/fs/crypto/policy.c
> @@ -67,9 +67,9 @@ static bool supported_iv_ino_lblk_64_policy(
>   * fscrypt_supported_policy - check whether an encryption policy is supported
>   *
>   * Given an encryption policy, check whether all its encryption modes and other
> - * settings are supported by this kernel.  (But we don't currently don't check
> - * for crypto API support here, so attempting to use an algorithm not configured
> - * into the crypto API will still fail later.)
> + * settings are supported by this kernel on the given inode.  (But we don't
> + * currently don't check for crypto API support here, so attempting to use an
> + * algorithm not configured into the crypto API will still fail later.)
>   *
>   * Return: %true if supported, else %false
>   */
> @@ -97,6 +97,12 @@ bool fscrypt_supported_policy(const union fscrypt_policy *policy_u,
>  			return false;
>  		}
>  
> +		if (IS_CASEFOLDED(inode)) {
> +			fscrypt_warn(inode,
> +				     "v1 policy does not support casefolded directories");
> +			return false;
> +		}
> +
>  		return true;
>  	}
>  	case FSCRYPT_POLICY_V2: {
> @@ -530,3 +536,17 @@ int fscrypt_inherit_context(struct inode *parent, struct inode *child,
>  	return preload ? fscrypt_get_encryption_info(child): 0;
>  }
>  EXPORT_SYMBOL(fscrypt_inherit_context);
> +
> +int fscrypt_set_casefolding_allowed(struct inode *inode)
> +{
> +	union fscrypt_policy policy;
> +	int ret = fscrypt_get_policy(inode, &policy);
> +
> +	if (ret < 0)
> +		return ret;

In fs/crypto/ we're trying to use 'err' rather than 'ret' when a variable can
only be 0 or a negative errno value.  I.e.:

        union fscrypt_policy policy;
        int err;

        err = fscrypt_get_policy(inode, &policy);
        if (err)
                return err;

> +
> +	if (policy.version == FSCRYPT_POLICY_V2)
> +		return 0;
> +	else
> +		return -EINVAL;
> +}

In kernel code normally an early return is used in cases like this.  I.e.:

	if (policy.version != FSCRYPT_POLICY_V2)
		return -EINVAL;

	return 0;

> @@ -2245,6 +2246,13 @@ int vfs_ioc_setflags_prepare(struct inode *inode, unsigned int oldflags,
>  	    !capable(CAP_LINUX_IMMUTABLE))
>  		return -EPERM;
>  
> +	/*
> +	 * When a directory is encrypted, the CASEFOLD flag can only be turned
> +	 * on if the fscrypt policy supports it.
> +	 */
> +	if (IS_ENCRYPTED(inode) && (flags & ~oldflags & FS_CASEFOLD_FL))
> +		return fscrypt_set_casefolding_allowed(inode);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL(vfs_ioc_setflags_prepare);

This needs to only return early on error.  Otherwise when people add checks for
more flags later, those checks will not be executed when the CASEFOLD flag is
enabled on an encrypted directory.

I.e.:

        if (IS_ENCRYPTED(inode) && (flags & ~oldflags & FS_CASEFOLD_FL)) {
                err = fscrypt_set_casefolding_allowed(inode);
                if (err)
                        return err;
        }

I'm also wondering if this is the right level of abstraction.
Maybe the API should be:

	err = fscrypt_ioc_setflags_prepare(inode, oldflags, flags);
	if (err)
		return err;

Then the VFS code will be "obvious", and the comment:

        /*
         * When a directory is encrypted, the CASEFOLD flag can only be turned
         * on if the fscrypt policy supports it.
         */

can be moved to the definition of fscrypt_ioc_setflags_prepare() in fs/crypto/.

- Eric
