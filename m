Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77AA6EC88B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2019 19:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfKASd0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Nov 2019 14:33:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726671AbfKASd0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Nov 2019 14:33:26 -0400
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 520EB21734;
        Fri,  1 Nov 2019 18:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572633205;
        bh=O2xOXMU8ZuGa8qvDhmT8yNNHuqfhzhj+CDrM/y+R8mw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hzidrk+UjF6KOAXbE6VsYklvSG6v4p6oZqYY3BHWUMifu38B/OUELpDbD+afGyp6+
         9vqZyc1hVRscVcUMFAu1Hp1/YTh9T8Bcp4XzfLAVsAi5f3V/3eF/EJzoXBfImYp//E
         c8EBJE/0RMsGQPUUvMoTpfJRFaLjO5W/YJe+ukw4=
Date:   Fri, 1 Nov 2019 11:33:24 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, Satya Tangirala <satyat@google.com>,
        Paul Crowley <paulcrowley@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v2 3/3] f2fs: add support for IV_INO_LBLK_64 encryption
 policies
Message-ID: <20191101183324.GA14664@jaegeuk-macbookpro.roam.corp.google.com>
References: <20191024215438.138489-1-ebiggers@kernel.org>
 <20191024215438.138489-4-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024215438.138489-4-ebiggers@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/24, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> f2fs inode numbers are stable across filesystem resizing, and f2fs inode
> and file logical block numbers are always 32-bit.  So f2fs can always
> support IV_INO_LBLK_64 encryption policies.  Wire up the needed
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
> 2.24.0.rc0.303.g954a862665-goog
