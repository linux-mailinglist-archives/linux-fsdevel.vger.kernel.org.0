Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D4A229DD9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 19:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731378AbgGVRG5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 13:06:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:59934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726784AbgGVRG5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 13:06:57 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 716B32065F;
        Wed, 22 Jul 2020 17:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595437616;
        bh=J9bE9IOReg39TnqW7rQqgVX/bLpQnJgtze/XCWHrEi8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SLvlcAXPykYlMlmVanzKn3R31qhYknX1uon6FWXrRV0UQOMps3FOBazrA/ELlo+uv
         MNqN9Ht4B0YtczHGivnbHHdEPndGHM5XTTPdEXCeiRe3J1AosGDJNHFuh9g5rvKbHU
         0q60IWW69l0+aw4fVpq7A8zP3s6fMj8Ao8qr1f9s=
Date:   Wed, 22 Jul 2020 10:06:56 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v4 3/7] iomap: support direct I/O with fscrypt using
 blk-crypto
Message-ID: <20200722170656.GF3912099@google.com>
References: <20200720233739.824943-1-satyat@google.com>
 <20200720233739.824943-4-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720233739.824943-4-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/20, Satya Tangirala wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Wire up iomap direct I/O with the fscrypt additions for direct I/O.
> This allows ext4 to support direct I/O on encrypted files when inline
> encryption is enabled.
> 
> This change consists of two parts:
> 
> - Set a bio_crypt_ctx on bios for encrypted files, so that the file
>   contents get encrypted (or decrypted).
> 
> - Ensure that encryption data unit numbers (DUNs) are contiguous within
>   each bio.  Use the new function fscrypt_limit_io_pages() for this,
>   since the iomap code works directly with logical ranges and thus
>   doesn't have a chance to call fscrypt_mergeable_bio() on each page.
> 
> Note that fscrypt_limit_io_pages() is normally a no-op, as normally the
> DUNs simply increment along with the logical blocks.  But it's needed to
> handle an edge case in one of the fscrypt IV generation methods.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> Co-developed-by: Satya Tangirala <satyat@google.com>
> Signed-off-by: Satya Tangirala <satyat@google.com>

Reviewed-by: Jaegeuk Kim <jaegeuk@kernel.org>

> ---
>  fs/iomap/direct-io.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index ec7b78e6feca..12064daa3e3d 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -6,6 +6,7 @@
>  #include <linux/module.h>
>  #include <linux/compiler.h>
>  #include <linux/fs.h>
> +#include <linux/fscrypt.h>
>  #include <linux/iomap.h>
>  #include <linux/backing-dev.h>
>  #include <linux/uio.h>
> @@ -183,11 +184,16 @@ static void
>  iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
>  		unsigned len)
>  {
> +	struct inode *inode = file_inode(dio->iocb->ki_filp);
>  	struct page *page = ZERO_PAGE(0);
>  	int flags = REQ_SYNC | REQ_IDLE;
>  	struct bio *bio;
>  
>  	bio = bio_alloc(GFP_KERNEL, 1);
> +
> +	/* encrypted direct I/O is guaranteed to be fs-block aligned */
> +	WARN_ON_ONCE(fscrypt_needs_contents_encryption(inode));
> +
>  	bio_set_dev(bio, iomap->bdev);
>  	bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
>  	bio->bi_private = dio;
> @@ -253,6 +259,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  		ret = nr_pages;
>  		goto out;
>  	}
> +	nr_pages = fscrypt_limit_io_pages(inode, pos, nr_pages);
>  
>  	if (need_zeroout) {
>  		/* zero out from the start of the block to the write offset */
> @@ -270,6 +277,8 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  		}
>  
>  		bio = bio_alloc(GFP_KERNEL, nr_pages);
> +		fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
> +					  GFP_KERNEL);
>  		bio_set_dev(bio, iomap->bdev);
>  		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
>  		bio->bi_write_hint = dio->iocb->ki_hint;
> @@ -306,9 +315,10 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  		dio->size += n;
>  		copied += n;
>  
> -		nr_pages = iov_iter_npages(dio->submit.iter, BIO_MAX_PAGES);
>  		iomap_dio_submit_bio(dio, iomap, bio, pos);
>  		pos += n;
> +		nr_pages = iov_iter_npages(dio->submit.iter, BIO_MAX_PAGES);
> +		nr_pages = fscrypt_limit_io_pages(inode, pos, nr_pages);
>  	} while (nr_pages);
>  
>  	/*
> -- 
> 2.28.0.rc0.105.gf9edc3c819-goog
