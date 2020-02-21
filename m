Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7C021686D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 19:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbgBUSkN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 13:40:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:40522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729288AbgBUSkM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 13:40:12 -0500
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04462208E4;
        Fri, 21 Feb 2020 18:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582310411;
        bh=3YrQ2Cspduv8p1rKuaa41bpCFtQWvnwvF2Buv3BWSGE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UAEVGHH0S7mhCC+QS//PHH1fwrlrqpoUQbMfcOGAzku9VHK4DRtsBKSt+PxFmIBCf
         KMS80bOXgolqa1nlyFbwYcANnTzGrE/4USZOCmCppD6ZYYrSHA/Dbdy00MoaOi6Fl6
         sLYGJ/B6gcxiMLvXAT3ZDqwNJeO/ox8wMsKJBFp8=
Date:   Fri, 21 Feb 2020 10:40:09 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v7 7/9] fscrypt: add inline encryption support
Message-ID: <20200221184009.GD925@sol.localdomain>
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
> diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
> index 4fa18fff9c4e..82d06cf4b94a 100644
> --- a/fs/crypto/bio.c
> +++ b/fs/crypto/bio.c
> @@ -24,6 +24,8 @@
>  #include <linux/module.h>
>  #include <linux/bio.h>
>  #include <linux/namei.h>
> +#include <linux/fscrypt.h>

No need to include <linux/fscrypt.h> explicitly here, since everything in
fs/crypto/ already gets it via "fscrypt_private.h".

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
> +			fscrypt_set_bio_crypt_ctx(bio, inode, lblk, GFP_NOIO);

This should use GFP_NOFS rather than the stricter GFP_NOIO.

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
> +			if (!err && bio->bi_status)
> +				err = -EIO;

submit_bio_wait() already checks bi_status and reflects it in the returned
error, so checking it again here is redundant.

> @@ -69,12 +119,17 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
>  	unsigned int nr_pages;
>  	unsigned int i;
>  	unsigned int offset;
> +	const bool inlinecrypt = fscrypt_inode_uses_inline_crypto(inode);
>  	struct bio *bio;
>  	int ret, err;
>  
>  	if (len == 0)
>  		return 0;
>  
> +	if (inlinecrypt)
> +		return fscrypt_zeroout_range_inline_crypt(inode, lblk, pblk,
> +							  len);
> +

No need for the 'inlinecrypt' bool variable.  Just do:

	if (fscrypt_inode_uses_inline_crypto(inode))

FYI, I had suggested a merge resolution to use here which didn't have the above
problems.  Looks like you missed it?
https://lkml.kernel.org/linux-block/20200114211243.GC41220@gmail.com/

- Eric
