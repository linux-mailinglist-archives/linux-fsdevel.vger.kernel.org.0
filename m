Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E86E3226F0B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 21:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730887AbgGTT3s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 15:29:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:44212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgGTT3s (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 15:29:48 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A1E620773;
        Mon, 20 Jul 2020 19:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595273387;
        bh=p9MSRNwJssID8LsizQqfdqvIlunqUMeWXc/JgkGaXi0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GquwQiP/sRX76vVq9CjrWtrz91gsYU5skbVXwteYGpXuvF418/XjmOcLHqQld9G4K
         3lrNMhrkXTB+kT0/xVAH8alRXHtdekNe4EKq+z+QZWLPKSTLoxRZA4ah54G8TlsWnh
         O+8/ei1YQ2RJZjTF7+98Xty5tQ+lTjHyqb+CbM1Y=
Date:   Mon, 20 Jul 2020 12:29:45 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH v3 3/7] iomap: support direct I/O with fscrypt using
 blk-crypto
Message-ID: <20200720192945.GG1292162@gmail.com>
References: <20200717014540.71515-1-satyat@google.com>
 <20200717014540.71515-4-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717014540.71515-4-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 17, 2020 at 01:45:36AM +0000, Satya Tangirala wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Wire up iomap direct I/O with the fscrypt additions for direct I/O,
> and set bio crypt contexts on bios when appropriate.
> 
> Make iomap_dio_bio_actor() call fscrypt_limit_io_pages() to ensure that
> DUNs remain contiguous within a bio, since it works directly with logical
> ranges and can't call fscrypt_mergeable_bio() on each page.

This commit message is still confusing.

How about the following:

"Wire up iomap direct I/O with the fscrypt additions for direct I/O.
This allows ext4 to support direct I/O on encrypted files when inline
encryption is enabled.

This change consists of two parts:

- Set a bio_crypt_ctx on bios for encrypted files, so that the file
  contents get encrypted (or decrypted).

- Ensure that encryption data unit numbers (DUNs) are contiguous within
  each bio.  Use the new function fscrypt_limit_io_pages() for this,
  since the iomap code works directly with logical ranges and thus
  doesn't have a chance to call fscrypt_mergeable_bio() on each page.

Note that fscrypt_limit_io_pages() is normally a no-op, as normally the
DUNs simply increment along with the logical blocks.  But it's needed to
handle an edge case in one of the fscrypt IV generation methods."

> @@ -183,11 +184,14 @@ static void
>  iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
>  		unsigned len)
>  {
> +	struct inode *inode = file_inode(dio->iocb->ki_filp);
>  	struct page *page = ZERO_PAGE(0);
>  	int flags = REQ_SYNC | REQ_IDLE;
>  	struct bio *bio;
>  
>  	bio = bio_alloc(GFP_KERNEL, 1);
> +	fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
> +				  GFP_KERNEL);
>  	bio_set_dev(bio, iomap->bdev);
>  	bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
>  	bio->bi_private = dio;

iomap_dio_zero() is only used on partial filesystem blocks.  But, we
only allow direct I/O on encrypted files when the I/O is
filesystem-block-aligned.

So this part appears to be unnecessary.

How about replacing it with:

	/* encrypted direct I/O is guaranteed to be fs-block aligned */
	WARN_ON_ONCE(fscrypt_needs_contents_encryption(inode));

> @@ -253,6 +257,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  		ret = nr_pages;
>  		goto out;
>  	}
> +	nr_pages = fscrypt_limit_io_pages(inode, pos, nr_pages);
>  
>  	if (need_zeroout) {
>  		/* zero out from the start of the block to the write offset */
> @@ -270,6 +275,8 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  		}
>  
>  		bio = bio_alloc(GFP_KERNEL, nr_pages);
> +		fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
> +					  GFP_KERNEL);
>  		bio_set_dev(bio, iomap->bdev);
>  		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
>  		bio->bi_write_hint = dio->iocb->ki_hint;
> @@ -307,6 +314,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  		copied += n;
>  
>  		nr_pages = iov_iter_npages(dio->submit.iter, BIO_MAX_PAGES);
> +		nr_pages = fscrypt_limit_io_pages(inode, pos, nr_pages);
>  		iomap_dio_submit_bio(dio, iomap, bio, pos);
>  		pos += n;
>  	} while (nr_pages);

I think the part at the end is wrong.

We want to limit the *next* bio, not the current one.

So 'pos' needs to be updated first.

I think it should be:

                iomap_dio_submit_bio(dio, iomap, bio, pos);
                pos += n;
                nr_pages = iov_iter_npages(dio->submit.iter, BIO_MAX_PAGES);
                nr_pages = fscrypt_limit_io_pages(inode, pos, nr_pages);
