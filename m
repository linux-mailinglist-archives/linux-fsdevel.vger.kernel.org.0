Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6C30168CBE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2020 06:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgBVFjI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Feb 2020 00:39:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:37930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgBVFjH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Feb 2020 00:39:07 -0500
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F502208C3;
        Sat, 22 Feb 2020 05:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582349946;
        bh=tstnNHhaIvRVX4ExQFdDOhN9ZstDOzAqulx7HPJbK8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nQfM6CCgx+pVqyEwP92qBWdLJjAuuh7iZeR3ncbtvvgsiun0gVfKr9vYHUxYAxjFP
         abj9rUQsDl68oqGY5yOTPK4sCVbNj+yNYvjFQxlcOdCuS2hCQWRqLguVjvPBGtdKF8
         jOKekVc3QEjPSLZ+EsQDPvTSXf7tADwaIwl6OAh4=
Date:   Fri, 21 Feb 2020 21:39:05 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v7 7/9] fscrypt: add inline encryption support
Message-ID: <20200222053905.GC848@sol.localdomain>
References: <20200221115050.238976-1-satyat@google.com>
 <20200221115050.238976-8-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221115050.238976-8-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 21, 2020 at 03:50:48AM -0800, Satya Tangirala wrote:
> diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
> index 65cb09fa6ead..7c157130c16a 100644
> --- a/fs/crypto/keysetup.c
> +++ b/fs/crypto/keysetup.c
> @@ -19,6 +19,8 @@ struct fscrypt_mode fscrypt_modes[] = {
>  		.cipher_str = "xts(aes)",
>  		.keysize = 64,
>  		.ivsize = 16,
> +		.blk_crypto_mode = BLK_ENCRYPTION_MODE_AES_256_XTS,
> +		.blk_crypto_dun_bytes_required = 8,
>  	},
>  	[FSCRYPT_MODE_AES_256_CTS] = {
>  		.friendly_name = "AES-256-CTS-CBC",
> @@ -31,6 +33,8 @@ struct fscrypt_mode fscrypt_modes[] = {
>  		.cipher_str = "essiv(cbc(aes),sha256)",
>  		.keysize = 16,
>  		.ivsize = 16,
> +		.blk_crypto_mode = BLK_ENCRYPTION_MODE_AES_128_CBC_ESSIV,
> +		.blk_crypto_dun_bytes_required = 8,
>  	},
>  	[FSCRYPT_MODE_AES_128_CTS] = {
>  		.friendly_name = "AES-128-CTS-CBC",
> @@ -43,6 +47,8 @@ struct fscrypt_mode fscrypt_modes[] = {
>  		.cipher_str = "adiantum(xchacha12,aes)",
>  		.keysize = 32,
>  		.ivsize = 32,
> +		.blk_crypto_mode = BLK_ENCRYPTION_MODE_ADIANTUM,
> +		.blk_crypto_dun_bytes_required = 24,
>  	},
>  };

The DUN bytes required is actually determined by the IV generation method too.
Currently fscrypt has the following combinations:

	AES-256-XTS: 8 bytes
	AES-128-CBC-ESSIV: 8 bytes
	Adiantum without DIRECT_KEY: 8 bytes
	Adiantum with DIRECT_KEY: 24 bytes

I.e., DIRECT_KEY is only allowed with Adiantum, but not required for it.

So it's technically incorrect to always pass dun_bytes_required=24 for Adiantum.

And it's conceivable that in the future we could add an fscrypt setting that
uses AES-256-XTS with 16 IV bytes.  Such a setting wouldn't be usable with UFS
inline encryption, yet the existing AES-256-XTS settings still would.

So, how about instead of putting .blk_crypto_dun_bytes_required in the
crypto_mode table, using logic like:

	dun_bytes_required = 8;
	if (flags & FSCRYPT_POLICY_FLAG_DIRECT_KEY)
		dun_bytes_required += 16;

> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 3cd4fe6b845e..2331ff0464b2 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1370,6 +1370,7 @@ extern int send_sigurg(struct fown_struct *fown);
>  #define SB_NODIRATIME	2048	/* Do not update directory access times */
>  #define SB_SILENT	32768
>  #define SB_POSIXACL	(1<<16)	/* VFS does not apply the umask */
> +#define SB_INLINE_CRYPT	(1<<17)	/* inodes in SB use blk-crypto */
>  #define SB_KERNMOUNT	(1<<22) /* this is a kern_mount call */
>  #define SB_I_VERSION	(1<<23) /* Update inode I_version field */
>  #define SB_LAZYTIME	(1<<25) /* Update the on-disk [acm]times lazily */

This flag probably should be called "SB_INLINECRYPT" to match the mount option,
which is "inlinecrypt" not "inline_crypt".

Also, the addition of this flag, along with the update to show_sb_opts() in
fs/proc_namespace.c which I think is needed, maybe should go in a separate patch
whose subject is prefixed with "fs: " to make it clearer to reviewers that this
part is a VFS-level change.

- Eric
