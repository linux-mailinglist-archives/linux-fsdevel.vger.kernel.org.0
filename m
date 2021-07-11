Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39FCC3C3E76
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jul 2021 19:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbhGKRqP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 13:46:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:41490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229801AbhGKRqP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 13:46:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 277F56109F;
        Sun, 11 Jul 2021 17:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626025408;
        bh=C06W5kKx3p/cn8jh2aBd2TLN6zkS1xZFeVz1dW6gnAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U83WlnEjseeX0pQVx+IUcFvM3shItUFK99/goRJoJ35Y8olqDeWnw6UscKNDkknfP
         F+RHnxN8Ox+X4JUqBPes3TGMzhsc5lG/Nee3UXsqguGyW2fvM0YvkPIlRj7FKB5BoG
         gifML/aeU3peJqg0FBWPX6dyX1POZkTAkUgQoO4BDlsOEEwxR7OV+tBobAQDSgzXIx
         od9xOdCBaYiLSddbLXr5Yj4/ZkW7fqzvNLCeWQj/1VAeDoapiwAF00y6A4UrrqLhff
         qzou0FFcuAlxbTURZbBQRLjbrbD3hJNnIRvSLZojQUkaplVnUbIGqQaWSuQaw/o3lv
         j+JhHz6MDMMEA==
Date:   Sun, 11 Jul 2021 12:43:26 -0500
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, lhenriques@suse.de, xiubli@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        dhowells@redhat.com
Subject: Re: [RFC PATCH v7 03/24] fscrypt: export fscrypt_fname_encrypt and
 fscrypt_fname_encrypted_size
Message-ID: <YOstvqc7vAIb/TMI@quark.localdomain>
References: <20210625135834.12934-1-jlayton@kernel.org>
 <20210625135834.12934-4-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625135834.12934-4-jlayton@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 25, 2021 at 09:58:13AM -0400, Jeff Layton wrote:
> +bool fscrypt_fname_encrypted_size(const struct inode *inode, u32 orig_len,
> +				  u32 max_len, u32 *encrypted_len_ret)
> +{
> +	return __fscrypt_fname_encrypted_size(&inode->i_crypt_info->ci_policy,
> +					      orig_len, max_len,
> +					      encrypted_len_ret);
> +}
> +EXPORT_SYMBOL(fscrypt_fname_encrypted_size);

This function could use a kerneldoc comment now that it will be exported.

> diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
> index e300f6145ddc..b5c31baaa8bf 100644
> --- a/include/linux/fscrypt.h
> +++ b/include/linux/fscrypt.h
> @@ -212,6 +212,10 @@ int fscrypt_drop_inode(struct inode *inode);
>  /* fname.c */
>  int fscrypt_base64_encode(const u8 *src, int len, char *dst);
>  int fscrypt_base64_decode(const char *src, int len, u8 *dst);
> +bool fscrypt_fname_encrypted_size(const struct inode *inode, u32 orig_len,
> +				  u32 max_len, u32 *encrypted_len_ret);
> +int fscrypt_fname_encrypt(const struct inode *inode, const struct qstr *iname,
> +			  u8 *out, unsigned int olen);
>  int fscrypt_setup_filename(struct inode *inode, const struct qstr *iname,
>  			   int lookup, struct fscrypt_name *fname);

Generally I try to keep declarations in .h files in the same order as the
corresponding definitions in .c files.

- Eric
