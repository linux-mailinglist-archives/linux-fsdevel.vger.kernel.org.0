Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4F013B418
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 22:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbgANVMq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 16:12:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:56974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727285AbgANVMq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 16:12:46 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2244124658;
        Tue, 14 Jan 2020 21:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579036365;
        bh=J3OsxJ0QF2e1qLWbeTaDEKd7v4FiOXvliReYz6wlurA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YSpaSCiNWpxz/Hp2I+ocHoWQz+de0pi1yKaVA0WbbtASy9uM/orM1gSNArzG1gjKk
         xZOGhpvoB7cWI1MxLIjy5b+npg8ynLKCAHAJVmhzVpuVGbrMBK5UchQD+tdNUNiIPB
         iaXoDigsthokLSovxzjetaBBqV1oyWdI7noUMCyA=
Date:   Tue, 14 Jan 2020 13:12:43 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v6 7/9] fscrypt: add inline encryption support
Message-ID: <20200114211243.GC41220@gmail.com>
References: <20191218145136.172774-1-satyat@google.com>
 <20191218145136.172774-8-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218145136.172774-8-satyat@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 18, 2019 at 06:51:34AM -0800, Satya Tangirala wrote:
> diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
> index 1f4b8a277060..d28d8e803554 100644
> --- a/fs/crypto/bio.c
> +++ b/fs/crypto/bio.c
> @@ -46,26 +46,35 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
>  {
>  	const unsigned int blockbits = inode->i_blkbits;
>  	const unsigned int blocksize = 1 << blockbits;
> +	const bool inlinecrypt = fscrypt_inode_uses_inline_crypto(inode);
>  	struct page *ciphertext_page;
>  	struct bio *bio;
>  	int ret, err = 0;
>  
> -	ciphertext_page = fscrypt_alloc_bounce_page(GFP_NOWAIT);
> -	if (!ciphertext_page)
> -		return -ENOMEM;
> +	if (inlinecrypt) {
> +		ciphertext_page = ZERO_PAGE(0);
> +	} else {
> +		ciphertext_page = fscrypt_alloc_bounce_page(GFP_NOWAIT);
> +		if (!ciphertext_page)
> +			return -ENOMEM;
> +	}
>  
>  	while (len--) {
> -		err = fscrypt_crypt_block(inode, FS_ENCRYPT, lblk,
> -					  ZERO_PAGE(0), ciphertext_page,
> -					  blocksize, 0, GFP_NOFS);
> -		if (err)
> -			goto errout;
> +		if (!inlinecrypt) {
> +			err = fscrypt_crypt_block(inode, FS_ENCRYPT, lblk,
> +						  ZERO_PAGE(0), ciphertext_page,
> +						  blocksize, 0, GFP_NOFS);
> +			if (err)
> +				goto errout;
> +		}
>  
>  		bio = bio_alloc(GFP_NOWAIT, 1);
>  		if (!bio) {
>  			err = -ENOMEM;
>  			goto errout;
>  		}
> +		fscrypt_set_bio_crypt_ctx(bio, inode, lblk, GFP_NOIO);
> +
>  		bio_set_dev(bio, inode->i_sb->s_bdev);
>  		bio->bi_iter.bi_sector = pblk << (blockbits - 9);
>  		bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
> @@ -87,7 +96,8 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
>  	}
>  	err = 0;
>  errout:
> -	fscrypt_free_bounce_page(ciphertext_page);
> +	if (!inlinecrypt)
> +		fscrypt_free_bounce_page(ciphertext_page);
>  	return err;
>  }
>  EXPORT_SYMBOL(fscrypt_zeroout_range);

FYI, I've just applied a patch
(https://lore.kernel.org/r/20191226160813.53182-1-ebiggers@kernel.org/)
to fscrypt.git#master that optimizes this function to write multiple pages at a
time.  So this part of this patch will need to be reworked.  I suggest just
handling the inline and fs-layer encryption cases separately.

I maintain a testing branch that has all the pending patches I'm interested in
applied, so I actually already hacked together the following to resolve the
conflict.  Please double check it carefully before using it in v7 though:

static int fscrypt_zeroout_range_inlinecrypt(const struct inode *inode,
					     pgoff_t lblk,
					     sector_t pblk, unsigned int len)
{
	const unsigned int blockbits = inode->i_blkbits;
	const unsigned int blocks_per_page_bits = PAGE_SHIFT - blockbits;
	const unsigned int blocks_per_page = 1 << blocks_per_page_bits;
	unsigned int i;
	struct bio *bio;
	int ret, err;

	/* This always succeeds since __GFP_DIRECT_RECLAIM is set. */
	bio = bio_alloc(GFP_NOFS, BIO_MAX_PAGES);

	do {
		bio_set_dev(bio, inode->i_sb->s_bdev);
		bio->bi_iter.bi_sector = pblk << (blockbits - 9);
		bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
		fscrypt_set_bio_crypt_ctx(bio, inode, lblk, GFP_NOFS);

		i = 0;
		do {
			unsigned int blocks_this_page =
				min(len, blocks_per_page);
			unsigned int bytes_this_page =
				blocks_this_page << blockbits;

			ret = bio_add_page(bio, ZERO_PAGE(0),
					   bytes_this_page, 0);
			if (WARN_ON(ret != bytes_this_page)) {
				err = -EIO;
				goto out;
			}
			lblk += blocks_this_page;
			pblk += blocks_this_page;
			len -= blocks_this_page;
		} while (++i != BIO_MAX_PAGES && len != 0);

		err = submit_bio_wait(bio);
		if (err)
			goto out;
		bio_reset(bio);
	} while (len != 0);
	err = 0;
out:
	bio_put(bio);
	return err;
}
