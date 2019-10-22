Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50D1BE0960
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2019 18:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731993AbfJVQnS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Oct 2019 12:43:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731320AbfJVQnS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:43:18 -0400
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B1F520679;
        Tue, 22 Oct 2019 16:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571762597;
        bh=Zj5wr74CxqX0/V/io5KPMu9t2gOvJAzJbqNGWFeTg7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l2aoOrGYyK6nfJbMVQHHmqrtySzqsH3ke+c8RolvKfiJSPa7PULq6dsJxo92f4318
         auMhhPorvk0IKXhDoHIsC1u+C+T3ROdAwoxER+76dtjVXvihmcSlAsb8u+z4Esy6ms
         N/r764ctPaMgZaUY6XvhBSqta5ccsS3Ry81QUyd8=
Date:   Tue, 22 Oct 2019 09:43:16 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, Satya Tangirala <satyat@google.com>,
        Paul Crowley <paulcrowley@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 3/3] f2fs: add support for INLINE_CRYPT_OPTIMIZED
 encryption policies
Message-ID: <20191022164316.GA88771@jaegeuk-macbookpro.roam.corp.google.com>
References: <20191021230355.23136-1-ebiggers@kernel.org>
 <20191021230355.23136-4-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021230355.23136-4-ebiggers@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/21, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> f2fs inode numbers are stable across filesystem resizing, and f2fs inode
> and file logical block numbers are always 32-bit.  So f2fs can always
> support INLINE_CRYPT_OPTIMIZED encryption policies.  Wire up the needed
> fscrypt_operations to declare support.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Acked-by: Jaegeuk Kim <jaegeuk@kernel.org>

> ---
>  fs/f2fs/super.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 1443cee158633..851ac95229263 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2308,13 +2308,27 @@ static bool f2fs_dummy_context(struct inode *inode)
>  	return DUMMY_ENCRYPTION_ENABLED(F2FS_I_SB(inode));
>  }
>  
> +static bool f2fs_has_stable_inodes(struct super_block *sb)
> +{
> +	return true;
> +}
> +
> +static void f2fs_get_ino_and_lblk_bits(struct super_block *sb,
> +				       int *ino_bits_ret, int *lblk_bits_ret)
> +{
> +	*ino_bits_ret = 8 * sizeof(nid_t);
> +	*lblk_bits_ret = 8 * sizeof(block_t);
> +}
> +
>  static const struct fscrypt_operations f2fs_cryptops = {
> -	.key_prefix	= "f2fs:",
> -	.get_context	= f2fs_get_context,
> -	.set_context	= f2fs_set_context,
> -	.dummy_context	= f2fs_dummy_context,
> -	.empty_dir	= f2fs_empty_dir,
> -	.max_namelen	= F2FS_NAME_LEN,
> +	.key_prefix		= "f2fs:",
> +	.get_context		= f2fs_get_context,
> +	.set_context		= f2fs_set_context,
> +	.dummy_context		= f2fs_dummy_context,
> +	.empty_dir		= f2fs_empty_dir,
> +	.max_namelen		= F2FS_NAME_LEN,
> +	.has_stable_inodes	= f2fs_has_stable_inodes,
> +	.get_ino_and_lblk_bits	= f2fs_get_ino_and_lblk_bits,
>  };
>  #endif
>  
> -- 
> 2.23.0.866.gb869b98d4c-goog
