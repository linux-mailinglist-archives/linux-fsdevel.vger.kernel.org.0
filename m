Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB15F229DBF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 19:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731580AbgGVREv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 13:04:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:58918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726888AbgGVREv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 13:04:51 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16E18206F5;
        Wed, 22 Jul 2020 17:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595437490;
        bh=A6Jd4Cjj8c0g86XqWJrKT0fAAeTmScSyqf38YdNhjcU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e3EQYRL6Ci+f7UHqYc4tN9nFI+OtwsMDcOvs8kDdryl7Vlc5H+TGpBLaovGL2P3me
         mhbrpnrj0zUQxROoqAw0ujeO/PJ2cdNr1FU2NJNbjXk9X9a16k2SJBBvfQI+5Zfcif
         verquqt5Y1f1XAv/tlf9G1pX36AWK8lqnYg1SU44=
Date:   Wed, 22 Jul 2020 10:04:49 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v4 1/7] fscrypt: Add functions for direct I/O support
Message-ID: <20200722170449.GD3912099@google.com>
References: <20200720233739.824943-1-satyat@google.com>
 <20200720233739.824943-2-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720233739.824943-2-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/20, Satya Tangirala wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Introduce fscrypt_dio_supported() to check whether a direct I/O request
> is unsupported due to encryption constraints.
> 
> Also introduce fscrypt_limit_io_pages() to limit how many pages can be
> added to a bio being prepared for direct I/O. This is needed for the
> iomap direct I/O implementation to avoid DUN wraparound in the middle of
> a bio (which is possible with the IV_INO_LBLK_32 IV generation method).
> Elsewhere fscrypt_mergeable_bio() is used for this, but iomap operates
> on logical ranges directly and doesn't have a chance to call
> fscrypt_mergeable_bio() on every block or page. So we need this function
> which limits a logical range in one go.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> Co-developed-by: Satya Tangirala <satyat@google.com>
> Signed-off-by: Satya Tangirala <satyat@google.com>

Reviewed-by: Jaegeuk Kim <jaegeuk@kernel.org>

> ---
>  fs/crypto/crypto.c       |  8 ++++
>  fs/crypto/inline_crypt.c | 82 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/fscrypt.h  | 19 ++++++++++
>  3 files changed, 109 insertions(+)
> 
> diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
> index a52cf32733ab..fb34364360b3 100644
> --- a/fs/crypto/crypto.c
> +++ b/fs/crypto/crypto.c
> @@ -69,6 +69,14 @@ void fscrypt_free_bounce_page(struct page *bounce_page)
>  }
>  EXPORT_SYMBOL(fscrypt_free_bounce_page);
>  
> +/*
> + * Generate the IV for the given logical block number within the given file.
> + * For filenames encryption, lblk_num == 0.
> + *
> + * Keep this in sync with fscrypt_limit_io_pages().  fscrypt_limit_io_pages()
> + * needs to know about any IV generation methods where the low bits of IV don't
> + * simply contain the lblk_num (e.g., IV_INO_LBLK_32).
> + */
>  void fscrypt_generate_iv(union fscrypt_iv *iv, u64 lblk_num,
>  			 const struct fscrypt_info *ci)
>  {
> diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
> index d7aecadf33c1..578739712e00 100644
> --- a/fs/crypto/inline_crypt.c
> +++ b/fs/crypto/inline_crypt.c
> @@ -16,6 +16,7 @@
>  #include <linux/blkdev.h>
>  #include <linux/buffer_head.h>
>  #include <linux/sched/mm.h>
> +#include <linux/uio.h>
>  
>  #include "fscrypt_private.h"
>  
> @@ -362,3 +363,84 @@ bool fscrypt_mergeable_bio_bh(struct bio *bio,
>  	return fscrypt_mergeable_bio(bio, inode, next_lblk);
>  }
>  EXPORT_SYMBOL_GPL(fscrypt_mergeable_bio_bh);
> +
> +/**
> + * fscrypt_dio_supported() - check whether a direct I/O request is unsupported
> + *			     due to encryption constraints
> + * @iocb: the file and position the I/O is targeting
> + * @iter: the I/O data segment(s)
> + *
> + * Return: true if direct I/O is supported
> + */
> +bool fscrypt_dio_supported(struct kiocb *iocb, struct iov_iter *iter)
> +{
> +	const struct inode *inode = file_inode(iocb->ki_filp);
> +	const unsigned int blocksize = i_blocksize(inode);
> +
> +	/* If the file is unencrypted, no veto from us. */
> +	if (!fscrypt_needs_contents_encryption(inode))
> +		return true;
> +
> +	/* We only support direct I/O with inline crypto, not fs-layer crypto */
> +	if (!fscrypt_inode_uses_inline_crypto(inode))
> +		return false;
> +
> +	/*
> +	 * Since the granularity of encryption is filesystem blocks, the I/O
> +	 * must be block aligned -- not just disk sector aligned.
> +	 */
> +	if (!IS_ALIGNED(iocb->ki_pos | iov_iter_alignment(iter), blocksize))
> +		return false;
> +
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(fscrypt_dio_supported);
> +
> +/**
> + * fscrypt_limit_io_pages() - limit I/O pages to avoid discontiguous DUNs
> + * @inode: the file on which I/O is being done
> + * @pos: the file position (in bytes) at which the I/O is being done
> + * @nr_pages: the number of pages we want to submit starting at @pos
> + *
> + * Determine the limit to the number of pages that can be submitted in the bio
> + * targeting @pos without causing a data unit number (DUN) discontinuity.
> + *
> + * This is normally just @nr_pages, as normally the DUNs just increment along
> + * with the logical blocks.  (Or the file is not encrypted.)
> + *
> + * In rare cases, fscrypt can be using an IV generation method that allows the
> + * DUN to wrap around within logically continuous blocks, and that wraparound
> + * will occur.  If this happens, a value less than @nr_pages will be returned so
> + * that the wraparound doesn't occur in the middle of the bio.  Note that we
> + * only support block_size == PAGE_SIZE (and page-aligned DIO) in such cases.
> + *
> + * Return: the actual number of pages that can be submitted
> + */
> +int fscrypt_limit_io_pages(const struct inode *inode, loff_t pos, int nr_pages)
> +{
> +	const struct fscrypt_info *ci = inode->i_crypt_info;
> +	u32 dun;
> +
> +	if (!fscrypt_inode_uses_inline_crypto(inode))
> +		return nr_pages;
> +
> +	if (nr_pages <= 1)
> +		return nr_pages;
> +
> +	if (!(fscrypt_policy_flags(&ci->ci_policy) &
> +	      FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32))
> +		return nr_pages;
> +
> +	/*
> +	 * fscrypt_select_encryption_impl() ensures that block_size == PAGE_SIZE
> +	 * when using FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32.
> +	 */
> +	if (WARN_ON_ONCE(i_blocksize(inode) != PAGE_SIZE))
> +		return 1;
> +
> +	/* With IV_INO_LBLK_32, the DUN can wrap around from U32_MAX to 0. */
> +
> +	dun = ci->ci_hashed_ino + (pos >> inode->i_blkbits);
> +
> +	return min_t(u64, nr_pages, (u64)U32_MAX + 1 - dun);
> +}
> diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
> index bb257411365f..c205c214b35e 100644
> --- a/include/linux/fscrypt.h
> +++ b/include/linux/fscrypt.h
> @@ -559,6 +559,11 @@ bool fscrypt_mergeable_bio(struct bio *bio, const struct inode *inode,
>  bool fscrypt_mergeable_bio_bh(struct bio *bio,
>  			      const struct buffer_head *next_bh);
>  
> +bool fscrypt_dio_supported(struct kiocb *iocb, struct iov_iter *iter);
> +
> +int fscrypt_limit_io_pages(const struct inode *inode, loff_t pos,
> +			   int nr_pages);
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
> +static inline int fscrypt_limit_io_pages(const struct inode *inode, loff_t pos,
> +					 int nr_pages)
> +{
> +	return nr_pages;
> +}
>  #endif /* !CONFIG_FS_ENCRYPTION_INLINE_CRYPT */
>  
>  /**
> -- 
> 2.28.0.rc0.105.gf9edc3c819-goog
