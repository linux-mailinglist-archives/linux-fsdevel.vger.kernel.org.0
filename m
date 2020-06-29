Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F5920E5AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 00:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390057AbgF2Vkg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 17:40:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:60642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728225AbgF2SkW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:40:22 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16B2A255BA;
        Mon, 29 Jun 2020 18:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593454972;
        bh=Y7LpjQLfAxhqBzjm0yYAEkclb4h+QWTLcv+9I/39AOQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f2WxZRsr3ztXYnZzBr4mn4P+cVb5g5ZFjuVs6Q7CP9OHMSAstoPLftkfQGr7XYarS
         gRb9BsrxNCmYy773wNWZK69W9ONwYM5OkVOGzd56ZWIrqYKwAflXXkTPrzKgK3PTCd
         Z5aGgScPalZ5l1nSTCvh0rTphGGTlBxpvGf0MhSc=
Date:   Mon, 29 Jun 2020 11:22:50 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2 2/4] fscrypt: add inline encryption support
Message-ID: <20200629182250.GD20492@sol.localdomain>
References: <20200629120405.701023-1-satyat@google.com>
 <20200629120405.701023-3-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629120405.701023-3-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 29, 2020 at 12:04:03PM +0000, Satya Tangirala via Linux-f2fs-devel wrote:
> diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
> index 4fa18fff9c4e..1ea9369a7688 100644
> --- a/fs/crypto/bio.c
> +++ b/fs/crypto/bio.c
> @@ -41,6 +41,52 @@ void fscrypt_decrypt_bio(struct bio *bio)
>  }
>  EXPORT_SYMBOL(fscrypt_decrypt_bio);
>  
> +static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
> +					      pgoff_t lblk, sector_t pblk,
> +					      unsigned int len)
> +{
> +	const unsigned int blockbits = inode->i_blkbits;
> +	const unsigned int blocks_per_page = 1 << (PAGE_SHIFT - blockbits);
> +	struct bio *bio;
> +	int ret, err = 0;
> +	int num_pages = 0;
> +
> +	/* This always succeeds since __GFP_DIRECT_RECLAIM is set. */
> +	bio = bio_alloc(GFP_NOFS, BIO_MAX_PAGES);
> +
> +	while (len) {
> +		unsigned int blocks_this_page = min(len, blocks_per_page);
> +		unsigned int bytes_this_page = blocks_this_page << blockbits;
> +
> +		if (num_pages == 0) {
> +			fscrypt_set_bio_crypt_ctx(bio, inode, lblk, GFP_NOFS);
> +			bio_set_dev(bio, inode->i_sb->s_bdev);
> +			bio->bi_iter.bi_sector =
> +					pblk << (blockbits - SECTOR_SHIFT);
> +			bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
> +		}
> +		ret = bio_add_page(bio, ZERO_PAGE(0), bytes_this_page, 0);
> +		if (WARN_ON(ret != bytes_this_page)) {
> +			err = -EIO;
> +			goto out;
> +		}
> +		num_pages++;
> +		len -= blocks_this_page;
> +		lblk += blocks_this_page;
> +		pblk += blocks_this_page;
> +		if (num_pages == BIO_MAX_PAGES || !len) {
> +			err = submit_bio_wait(bio);
> +			if (err)
> +				goto out;
> +			bio_reset(bio);
> +			num_pages = 0;
> +		}
> +	}
> +out:
> +	bio_put(bio);
> +	return err;
> +}

I just realized we missed something.

With the new IV_INO_LBLK_32 IV generation strategy, logically contiguous blocks
don't necessarily have contiguous IVs.

So we need to check fscrypt_mergeable_bio() here.

Also it *should* be checked once per block, not once per page.  However, that
means that ext4_mpage_readpages() and f2fs_mpage_readpages() are wrong too,
since they only check fscrypt_mergeable_bio() once per page.

Given that difficulty, and the fact that IV_INO_LBLK_32 only has limited use
cases on specific hardware, I suggest that for now we simply restrict inline
encryption with IV_INO_LBLK_32 to the blocksize == PAGE_SIZE case.

(Checking fscrypt_mergeable_bio() once per page is still needed.)

I.e., on top of this patch:

diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index 1ea9369a7688..b048a0e38516 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -74,7 +74,8 @@ static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
 		len -= blocks_this_page;
 		lblk += blocks_this_page;
 		pblk += blocks_this_page;
-		if (num_pages == BIO_MAX_PAGES || !len) {
+		if (num_pages == BIO_MAX_PAGES || !len ||
+		    !fscrypt_mergeable_bio(bio, inode, lblk)) {
 			err = submit_bio_wait(bio);
 			if (err)
 				goto out;
diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
index ec514bc8ee86..097c5a565a21 100644
--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -84,6 +84,19 @@ int fscrypt_select_encryption_impl(struct fscrypt_info *ci)
 	if (!(sb->s_flags & SB_INLINECRYPT))
 		return 0;
 
+	/*
+	 * When a page contains multiple logically contiguous filesystem blocks,
+	 * some filesystem code only calls fscrypt_mergeable_bio() for the first
+	 * block in the page.  This is fine for most of fscrypt's IV generation
+	 * strategies, where contiguous blocks imply contiguous IVs.  But it
+	 * doesn't work with IV_INO_LBLK_32.  For now, simply exclude
+	 * IV_INO_LBLK_32 with blocksize != PAGE_SIZE from inline encryption.
+	 */
+	if ((fscrypt_policy_flags(&ci->ci_policy) &
+	     FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32) &&
+	    sb->s_blocksize != PAGE_SIZE)
+		return 0;
+
