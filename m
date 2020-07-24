Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C0922CB55
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 18:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgGXQqV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 12:46:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:58078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726987AbgGXQqT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 12:46:19 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94EBB206F0;
        Fri, 24 Jul 2020 16:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595609178;
        bh=ronJJOZmDzLOufnZltpx4KGJDoNF7F4ILWGJHIg9sQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SzwpohwRf7jIyzTvokD9BSXkKYQWQ7SxhS9EMWW0EOIlQNKTkFWhUcj/g19PoZETD
         M6TozYZaIDRbeW/LB7hVnaqpti/XueLY/iFNzJ4OwqOJdQJQx5nMyiTDujtf80klZS
         NleNkGmecr8ac/3eThBusaaGEt7DTegp7JEdbLVE=
Date:   Fri, 24 Jul 2020 09:46:17 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v5 1/7] fscrypt: Add functions for direct I/O support
Message-ID: <20200724164617.GA819@sol.localdomain>
References: <20200724121143.1589121-1-satyat@google.com>
 <20200724121143.1589121-2-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724121143.1589121-2-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 24, 2020 at 12:11:37PM +0000, Satya Tangirala wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Introduce fscrypt_dio_supported() to check whether a direct I/O request
> is unsupported due to encryption constraints.
> 
> Also introduce fscrypt_limit_io_blocks() to limit how many blocks can be
> added to a bio being prepared for direct I/O. This is needed for
> filesystems that use the iomap direct I/O implementation to avoid DUN
> wraparound in the middle of a bio (which is possible with the
> IV_INO_LBLK_32 IV generation method). Elsewhere fscrypt_mergeable_bio()
> is used for this, but iomap operates on logical ranges directly, so
> filesystems using iomap won't have a chance to call fscrypt_mergeable_bio()
> on every block added to a bio. So we need this function which limits a
> logical range in one go.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> Co-developed-by: Satya Tangirala <satyat@google.com>
> Signed-off-by: Satya Tangirala <satyat@google.com>
> Reviewed-by: Jaegeuk Kim <jaegeuk@kernel.org>

Note, generally you should drop Reviewed-by tags if you make nontrivial changes.

> +/**
> + * fscrypt_limit_io_blocks() - limit I/O blocks to avoid discontiguous DUNs
> + * @inode: the file on which I/O is being done
> + * @pos: the file position (in bytes) at which the I/O is being done
> + * @nr_blocks: the number of blocks we want to submit starting at @pos
> + *
> + * Determine the limit to the number of blocks that can be submitted in the bio
> + * targeting @pos without causing a data unit number (DUN) discontinuity.
> + *
> + * This is normally just @nr_blocks, as normally the DUNs just increment along
> + * with the logical blocks.  (Or the file is not encrypted.)
> + *
> + * In rare cases, fscrypt can be using an IV generation method that allows the
> + * DUN to wrap around within logically continuous blocks, and that wraparound
> + * will occur.  If this happens, a value less than @nr_blocks will be returned
> + * so that the wraparound doesn't occur in the middle of the bio.
> + *
> + * Return: the actual number of blocks that can be submitted
> + */
> +int fscrypt_limit_io_blocks(const struct inode *inode, loff_t pos,
> +			    unsigned int nr_blocks)

ext4 actually passes a block number for the second argument, not a position.

Also, we should make this ready for 64-bit block numbers.  When it's trivial to
do, we keep fs/crypto/ ready for 64-bit block numbers, even though it's not
needed yet.  E.g. see fscrypt_crypt_block() and fscrypt_generate_iv().

It's true that currently this function is a no-op except for IV_INO_LBLK_32, but
that's more of an implementation detail.

So the prototype I recommend is:

u64 fscrypt_limit_io_blocks(const struct inode *inode, u64 lblk, u64 nr_blocks);

> +{
> +	const struct fscrypt_info *ci = inode->i_crypt_info;
> +	u32 dun;
> +
> +	if (!fscrypt_inode_uses_inline_crypto(inode))
> +		return nr_blocks;
> +
> +	if (nr_blocks <= 1)
> +		return nr_blocks;
> +
> +	if (!(fscrypt_policy_flags(&ci->ci_policy) &
> +	      FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32))
> +		return nr_blocks;
> +
> +	/* With IV_INO_LBLK_32, the DUN can wrap around from U32_MAX to 0. */
> +
> +	dun = ci->ci_hashed_ino + (pos >> inode->i_blkbits);
> +
> +	return min_t(u64, nr_blocks, (u64)U32_MAX + 1 - dun);
> +}
> diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
> index bb257411365f..241266cba21f 100644
> --- a/include/linux/fscrypt.h
> +++ b/include/linux/fscrypt.h
> @@ -559,6 +559,11 @@ bool fscrypt_mergeable_bio(struct bio *bio, const struct inode *inode,
>  bool fscrypt_mergeable_bio_bh(struct bio *bio,
>  			      const struct buffer_head *next_bh);
>  
> +bool fscrypt_dio_supported(struct kiocb *iocb, struct iov_iter *iter);
> +
> +int fscrypt_limit_io_blocks(const struct inode *inode, loff_t pos,
> +			    unsigned int nr_blocks);
> +
>  #else /* CONFIG_FS_ENCRYPTION_INLINE_CRYPT */
>  
>  static inline bool __fscrypt_inode_uses_inline_crypto(const struct inode *inode)
> @@ -587,6 +592,20 @@ static inline bool fscrypt_mergeable_bio_bh(struct bio *bio,
>  {
>  	return true;
>  }
> +
> +static inline bool fscrypt_dio_supported(struct kiocb *iocb,
> +					 struct iov_iter *iter)
> +{
> +	const struct inode *inode = file_inode(iocb->ki_filp);
> +
> +	return !fscrypt_needs_contents_encryption(inode);
> +}
> +
> +static inline int fscrypt_limit_io_blocks(const struct inode *inode, loff_t pos,
> +					  unsigned int nr_blocks)
> +{
> +	return nr_blocks;
> +}
>  #endif /* !CONFIG_FS_ENCRYPTION_INLINE_CRYPT */
>  
>  /**
> -- 
> 2.28.0.rc0.142.g3c755180ce-goog
> 
