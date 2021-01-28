Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE91F3069FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 02:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbhA1BMb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 20:12:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:35442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231439AbhA1BGu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 20:06:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C69C64DD1;
        Thu, 28 Jan 2021 01:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611795857;
        bh=9u+pX6tITQPni/ZTAGHNlkfJc+eKK2wzAvA+xh2TVPU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pCUSbfI7WRD+4txA2pHo3Xrw3oZG+pmpeTwBWaNcegbi36zxBW/ML2+IuDHKMbzHn
         AVTlavn5uNudzkPHCEf7hOhLjZyJxaX0VqC+vmh0Ax9J0E99UlNwAjDmZT8rxkmXhe
         W9tkHXGPTWxNhLRsIOiZ63gbCL00Xe4L0F4ttBQWkxnoSOup3VE3LxSDWVoxdaf48/
         fISbEA7jX+sAUC3svQE6GrupalDXRGVf9ICYNTaONC8eARwMjBA04hUG0OmSmVNpkL
         mLuVd2lKIw2s/GnYIUz1aajlGgJohdw5ia9o9MmXIjfeSLBbSbO5d/RUmc6QsOUv8/
         bhT8EDe+EENaw==
Date:   Wed, 27 Jan 2021 17:04:15 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-api@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Victor Hsieh <victorhsieh@google.com>
Subject: Re: [PATCH 2/6] fs-verity: don't pass whole descriptor to
 fsverity_verify_signature()
Message-ID: <YBINj74g4Qhgwr9L@google.com>
References: <20210115181819.34732-1-ebiggers@kernel.org>
 <20210115181819.34732-3-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115181819.34732-3-ebiggers@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 01/15, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Now that fsverity_get_descriptor() validates the sig_size field,
> fsverity_verify_signature() doesn't need to do it.
> 
> Just change the prototype of fsverity_verify_signature() to take the
> signature directly rather than take a fsverity_descriptor.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Jaegeuk Kim <jaegeuk@kernel.org>

> ---
>  fs/verity/fsverity_private.h |  6 ++----
>  fs/verity/open.c             |  3 ++-
>  fs/verity/signature.c        | 20 ++++++--------------
>  3 files changed, 10 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
> index 6c9caccc06021..a7920434bae50 100644
> --- a/fs/verity/fsverity_private.h
> +++ b/fs/verity/fsverity_private.h
> @@ -140,15 +140,13 @@ void __init fsverity_exit_info_cache(void);
>  
>  #ifdef CONFIG_FS_VERITY_BUILTIN_SIGNATURES
>  int fsverity_verify_signature(const struct fsverity_info *vi,
> -			      const struct fsverity_descriptor *desc,
> -			      size_t desc_size);
> +			      const u8 *signature, size_t sig_size);
>  
>  int __init fsverity_init_signature(void);
>  #else /* !CONFIG_FS_VERITY_BUILTIN_SIGNATURES */
>  static inline int
>  fsverity_verify_signature(const struct fsverity_info *vi,
> -			  const struct fsverity_descriptor *desc,
> -			  size_t desc_size)
> +			  const u8 *signature, size_t sig_size)
>  {
>  	return 0;
>  }
> diff --git a/fs/verity/open.c b/fs/verity/open.c
> index a987bb785e9b0..60ff8af7219fe 100644
> --- a/fs/verity/open.c
> +++ b/fs/verity/open.c
> @@ -181,7 +181,8 @@ struct fsverity_info *fsverity_create_info(const struct inode *inode,
>  		 vi->tree_params.hash_alg->name,
>  		 vi->tree_params.digest_size, vi->file_digest);
>  
> -	err = fsverity_verify_signature(vi, desc, desc_size);
> +	err = fsverity_verify_signature(vi, desc->signature,
> +					le32_to_cpu(desc->sig_size));
>  out:
>  	if (err) {
>  		fsverity_free_info(vi);
> diff --git a/fs/verity/signature.c b/fs/verity/signature.c
> index 012468eda2a78..143a530a80088 100644
> --- a/fs/verity/signature.c
> +++ b/fs/verity/signature.c
> @@ -29,21 +29,19 @@ static struct key *fsverity_keyring;
>  /**
>   * fsverity_verify_signature() - check a verity file's signature
>   * @vi: the file's fsverity_info
> - * @desc: the file's fsverity_descriptor
> - * @desc_size: size of @desc
> + * @signature: the file's built-in signature
> + * @sig_size: size of signature in bytes, or 0 if no signature
>   *
> - * If the file's fs-verity descriptor includes a signature of the file digest,
> - * verify it against the certificates in the fs-verity keyring.
> + * If the file includes a signature of its fs-verity file digest, verify it
> + * against the certificates in the fs-verity keyring.
>   *
>   * Return: 0 on success (signature valid or not required); -errno on failure
>   */
>  int fsverity_verify_signature(const struct fsverity_info *vi,
> -			      const struct fsverity_descriptor *desc,
> -			      size_t desc_size)
> +			      const u8 *signature, size_t sig_size)
>  {
>  	const struct inode *inode = vi->inode;
>  	const struct fsverity_hash_alg *hash_alg = vi->tree_params.hash_alg;
> -	const u32 sig_size = le32_to_cpu(desc->sig_size);
>  	struct fsverity_formatted_digest *d;
>  	int err;
>  
> @@ -56,11 +54,6 @@ int fsverity_verify_signature(const struct fsverity_info *vi,
>  		return 0;
>  	}
>  
> -	if (sig_size > desc_size - sizeof(*desc)) {
> -		fsverity_err(inode, "Signature overflows verity descriptor");
> -		return -EBADMSG;
> -	}
> -
>  	d = kzalloc(sizeof(*d) + hash_alg->digest_size, GFP_KERNEL);
>  	if (!d)
>  		return -ENOMEM;
> @@ -70,8 +63,7 @@ int fsverity_verify_signature(const struct fsverity_info *vi,
>  	memcpy(d->digest, vi->file_digest, hash_alg->digest_size);
>  
>  	err = verify_pkcs7_signature(d, sizeof(*d) + hash_alg->digest_size,
> -				     desc->signature, sig_size,
> -				     fsverity_keyring,
> +				     signature, sig_size, fsverity_keyring,
>  				     VERIFYING_UNSPECIFIED_SIGNATURE,
>  				     NULL, NULL);
>  	kfree(d);
> -- 
> 2.30.0
