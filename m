Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16F33FE29
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 18:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbfD3QvS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 12:51:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfD3QvS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 12:51:18 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52DF92147A;
        Tue, 30 Apr 2019 16:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556643077;
        bh=3A7w+7LZPtm+9FWKjAgeHNtIX9e4JIDaC+A4dd4ARQ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ac5F7t0j6x24hq3IoaAVr5vKg3sOed28k6SV2U+v0kOOicvbQ9Bo+Z8sR/VlBjaY4
         Wt7nXL7vV9xnSg1i4wF3IeXYBaH/rsVuS3+KuNG778bEP5XGmZt+kTV/rN1VaGl+Gr
         MGfC0vxfwf3QR6eLBLVcoQPWxrmliOTjA5P2PDsM=
Date:   Tue, 30 Apr 2019 09:51:15 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chandan Rajendra <chandan@linux.ibm.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org, yuchao0@huawei.com,
        hch@infradead.org
Subject: Re: [PATCH V2 12/13] fscrypt_zeroout_range: Encrypt all zeroed out
 blocks of a page
Message-ID: <20190430165114.GA48973@gmail.com>
References: <20190428043121.30925-1-chandan@linux.ibm.com>
 <20190428043121.30925-13-chandan@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190428043121.30925-13-chandan@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 28, 2019 at 10:01:20AM +0530, Chandan Rajendra wrote:
> For subpage-sized blocks, this commit adds code to encrypt all zeroed
> out blocks mapped by a page.
> 
> Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
> ---
>  fs/crypto/bio.c | 40 ++++++++++++++++++----------------------
>  1 file changed, 18 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
> index 856f4694902d..46dd2ec50c7d 100644
> --- a/fs/crypto/bio.c
> +++ b/fs/crypto/bio.c
> @@ -108,29 +108,23 @@ EXPORT_SYMBOL(fscrypt_pullback_bio_page);
>  int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
>  				sector_t pblk, unsigned int len)
>  {
> -	struct fscrypt_ctx *ctx;
>  	struct page *ciphertext_page = NULL;
>  	struct bio *bio;
> +	u64 total_bytes, page_bytes;

page_bytes should be 'unsigned int', since it's <= PAGE_SIZE.

>  	int ret, err = 0;
>  
> -	BUG_ON(inode->i_sb->s_blocksize != PAGE_SIZE);
> -
> -	ctx = fscrypt_get_ctx(inode, GFP_NOFS);
> -	if (IS_ERR(ctx))
> -		return PTR_ERR(ctx);
> +	total_bytes = len << inode->i_blkbits;

Should cast len to 'u64' here, in case it's greater than UINT_MAX / blocksize.

>  
> -	ciphertext_page = fscrypt_alloc_bounce_page(ctx, GFP_NOWAIT);
> -	if (IS_ERR(ciphertext_page)) {
> -		err = PTR_ERR(ciphertext_page);
> -		goto errout;
> -	}
> +	while (total_bytes) {
> +		page_bytes = min_t(u64, total_bytes, PAGE_SIZE);
>  
> -	while (len--) {
> -		err = fscrypt_do_page_crypto(inode, FS_ENCRYPT, lblk,
> -					     ZERO_PAGE(0), ciphertext_page,
> -					     PAGE_SIZE, 0, GFP_NOFS);
> -		if (err)
> +		ciphertext_page = fscrypt_encrypt_page(inode, ZERO_PAGE(0),
> +						page_bytes, 0, lblk, GFP_NOFS);
> +		if (IS_ERR(ciphertext_page)) {
> +			err = PTR_ERR(ciphertext_page);
> +			ciphertext_page = NULL;
>  			goto errout;
> +		}

'ciphertext_page' is leaked after each loop iteration.  Did you mean to free it,
or did you mean to reuse it for subsequent iterations?

>  
>  		bio = bio_alloc(GFP_NOWAIT, 1);
>  		if (!bio) {
> @@ -141,9 +135,8 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
>  		bio->bi_iter.bi_sector =
>  			pblk << (inode->i_sb->s_blocksize_bits - 9);

This line uses ->s_blocksize_bits, but your new code uses ->i_blkbits.  AFAIK
they'll always be the same, but please pick one or the other to use.

>  		bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
> -		ret = bio_add_page(bio, ciphertext_page,
> -					inode->i_sb->s_blocksize, 0);
> -		if (ret != inode->i_sb->s_blocksize) {
> +		ret = bio_add_page(bio, ciphertext_page, page_bytes, 0);
> +		if (ret != page_bytes) {
>  			/* should never happen! */
>  			WARN_ON(1);
>  			bio_put(bio);
> @@ -156,12 +149,15 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
>  		bio_put(bio);
>  		if (err)
>  			goto errout;
> -		lblk++;
> -		pblk++;
> +
> +		lblk += page_bytes >> inode->i_blkbits;
> +		pblk += page_bytes >> inode->i_blkbits;
> +		total_bytes -= page_bytes;
>  	}
>  	err = 0;
>  errout:
> -	fscrypt_release_ctx(ctx);
> +	if (!IS_ERR_OR_NULL(ciphertext_page))
> +		fscrypt_restore_control_page(ciphertext_page);
>  	return err;
>  }
>  EXPORT_SYMBOL(fscrypt_zeroout_range);
> -- 
> 2.19.1
> 
