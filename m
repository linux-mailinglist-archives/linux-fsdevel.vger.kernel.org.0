Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1490233ADC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 23:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730659AbgG3V2Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 17:28:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730627AbgG3V2Q (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 17:28:16 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D126420829;
        Thu, 30 Jul 2020 21:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596144496;
        bh=cyTiwVqbwajpjpYHHW0xWoy2TRDD13JcNWIqnoFlZFs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=khGmwQM9Sf3cEDShy6J3iyvng+LBRPA7dnnUedQRp9sxgNaQitUDwcn9qdpEv5kTh
         EMe/EktKK0VHpnsnd2BvQx1p4FI3z/OLwo3HcJmkGKrmRJzIe16z/6xLxdu61AvrJK
         qD5HLMOJdBxA2UbLslMmfdbriyToKRsypPOPXkqc=
Date:   Thu, 30 Jul 2020 14:28:14 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Satya Tangirala <satyat@google.com>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] fscrypt: don't load ->i_crypt_info before it's known to
 be valid
Message-ID: <20200730212814.GB1074@sol.localdomain>
References: <20200727174158.121456-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727174158.121456-1-ebiggers@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 27, 2020 at 10:41:58AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> In fscrypt_set_bio_crypt_ctx(), ->i_crypt_info isn't known to be
> non-NULL until we check fscrypt_inode_uses_inline_crypto().  So, load
> ->i_crypt_info after the check rather than before.  This makes no
> difference currently, but it prevents people from introducing bugs where
> the pointer is dereferenced when it may be NULL.
> 
> Suggested-by: Dave Chinner <david@fromorbit.com>
> Cc: Satya Tangirala <satyat@google.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/crypto/inline_crypt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
> index dfb06375099ae..b6b8574caa13c 100644
> --- a/fs/crypto/inline_crypt.c
> +++ b/fs/crypto/inline_crypt.c
> @@ -244,11 +244,12 @@ static void fscrypt_generate_dun(const struct fscrypt_info *ci, u64 lblk_num,
>  void fscrypt_set_bio_crypt_ctx(struct bio *bio, const struct inode *inode,
>  			       u64 first_lblk, gfp_t gfp_mask)
>  {
> -	const struct fscrypt_info *ci = inode->i_crypt_info;
> +	const struct fscrypt_info *ci;
>  	u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE];
>  
>  	if (!fscrypt_inode_uses_inline_crypto(inode))
>  		return;
> +	ci = inode->i_crypt_info;
>  
>  	fscrypt_generate_dun(ci, first_lblk, dun);
>  	bio_crypt_set_ctx(bio, &ci->ci_enc_key.blk_key->base, dun, gfp_mask);

Applied to fscrypt.git#master for 5.9.

- Eric
