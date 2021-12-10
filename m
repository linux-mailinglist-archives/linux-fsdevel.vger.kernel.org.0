Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40EDC470A60
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Dec 2021 20:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245542AbhLJTg0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Dec 2021 14:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234441AbhLJTgZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:36:25 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A2BC061746;
        Fri, 10 Dec 2021 11:32:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4956FCE2D06;
        Fri, 10 Dec 2021 19:32:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47EA4C00446;
        Fri, 10 Dec 2021 19:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639164766;
        bh=UdeUDbJrW+pvd7iJQh9qGMEk4aY4ucJONMujeSt5H7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dKj+kNGhHzuybagcVjehDQDROQDo6jWTJb/tIwD6O566bEq01kGZreG8OxnF0lxLI
         O8NBQCLSStWF1lLf1bh/LvbgLvlGaj+OUjgsWhJjXTDLq3ATSmc2cHIynJSCEp19Fy
         C8l0iKLgy8l3NWrQogZoRS9lHQKweUCi8SQww1Un9GPhnghFtK0rUHK55qmcG15wt7
         miIyt4oKkrzMl1EZNJYR+tYH8FxEesHoO316MljYO3DgOFVPlknq89Bf0jNcEVdUgy
         E6WboNah+BxvZTb/rODFE0kebt9GVN5tYrcBkYXfb99SLSQq3hVoa/VU9YLL1AUOMc
         xY3TkNkGhxRPw==
Date:   Fri, 10 Dec 2021 11:32:44 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/36] fscrypt: export fscrypt_fname_encrypt and
 fscrypt_fname_encrypted_size
Message-ID: <YbOrXLbg8/tpzhsV@sol.localdomain>
References: <20211209153647.58953-1-jlayton@kernel.org>
 <20211209153647.58953-4-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209153647.58953-4-jlayton@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 09, 2021 at 10:36:14AM -0500, Jeff Layton wrote:
> For ceph, we want to use our own scheme for handling filenames that are
> are longer than NAME_MAX after encryption and base64 encoding. This

base64 => Base64.  (base64 and base64url are types of Base64.)

> diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
> index 8fa23d525b5c..3be04b5aa570 100644
> --- a/fs/crypto/fname.c
> +++ b/fs/crypto/fname.c
> @@ -130,6 +130,7 @@ int fscrypt_fname_encrypt(const struct inode *inode, const struct qstr *iname,
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL(fscrypt_fname_encrypt);

The documentation for the @inode parameter could use a mention that the inode's
key must have already been set up.  External callers could get that wrong.

Also, I'd prefer EXPORT_SYMBOL_GPL for anything that isn't generic functionality
like Base64 encoding/decoding.

> +/**
> + * fscrypt_fname_encrypted_size() - calculate length of encrypted filename
> + * @inode: 		parent inode of dentry name being encrypted

Likewise, this should mention that the inode's key must have already been set
up.

> + * Filenames must be padded out to at least the end of an fscrypt block before
> + * encrypting them.

That's not really correct.  The padding amount depends on the padding flags, as
well as whether the filename gets truncated at max_len or not.  Also there's not
really any such thing as an "fscrypt block".  (FS_CRYPTO_BLOCK_SIZE, which is 16
bytes, is misnamed.  It really should be two separate things like
FSCRYPT_MIN_FNAME_CTEXT_SIZE and FSCRYPT_CONTENTS_CTEXT_ALIGNMENT.)

How about just writing something like:

    Filenames that are shorter than the maximum length may have their lengths
    increased slightly by encryption, due to padding that is applied.

> + *
> + * Return: false if the orig_len is shorter than max_len. Otherwise, true and
> + * 	   fill out encrypted_len_ret with the length (up to max_len).

false if orig_len is *greater* than max_len.

> diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
> index 5b0a9e6478b5..51e42767dbd6 100644
> --- a/fs/crypto/fscrypt_private.h
> +++ b/fs/crypto/fscrypt_private.h
> @@ -297,14 +297,11 @@ void fscrypt_generate_iv(union fscrypt_iv *iv, u64 lblk_num,
>  			 const struct fscrypt_info *ci);
>  
>  /* fname.c */
> -int fscrypt_fname_encrypt(const struct inode *inode, const struct qstr *iname,
> -			  u8 *out, unsigned int olen);
> -bool fscrypt_fname_encrypted_size(const union fscrypt_policy *policy,
> -				  u32 orig_len, u32 max_len,
> -				  u32 *encrypted_len_ret);
> +bool __fscrypt_fname_encrypted_size(const union fscrypt_policy *policy,
> +				    u32 orig_len, u32 max_len,
> +                                    u32 *encrypted_len_ret);

This is indented with spaces, not tabs.

- Eric
