Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8B422D32B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jul 2020 02:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgGYAOv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 20:14:51 -0400
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:41879 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726704AbgGYAOv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 20:14:51 -0400
Received: from dread.disaster.area (pa49-180-53-24.pa.nsw.optusnet.com.au [49.180.53.24])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id B54F51AA49D;
        Sat, 25 Jul 2020 10:14:44 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jz7pp-0001fR-24; Sat, 25 Jul 2020 10:14:41 +1000
Date:   Sat, 25 Jul 2020 10:14:41 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v6 1/7] fscrypt: Add functions for direct I/O support
Message-ID: <20200725001441.GQ2005@dread.disaster.area>
References: <20200724184501.1651378-1-satyat@google.com>
 <20200724184501.1651378-2-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724184501.1651378-2-satyat@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LPwYv6e9 c=1 sm=1 tr=0
        a=moVtWZxmCkf3aAMJKIb/8g==:117 a=moVtWZxmCkf3aAMJKIb/8g==:17
        a=kj9zAlcOel0A:10 a=_RQrkK6FrEwA:10 a=1XWaLZrsAAAA:8 a=7-415B0cAAAA:8
        a=Rqi5QEisB4je2o-fgwEA:9 a=938-DbcbG5wzybhJ:21 a=PkVgxCpPGaEuij1c:21
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 24, 2020 at 06:44:55PM +0000, Satya Tangirala wrote:
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
> ---
>  fs/crypto/crypto.c       |  8 +++++
>  fs/crypto/inline_crypt.c | 74 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/fscrypt.h  | 18 ++++++++++
>  3 files changed, 100 insertions(+)
> 
> diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
> index 9212325763b0..f72f22a718b2 100644
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
> + * Keep this in sync with fscrypt_limit_io_blocks().  fscrypt_limit_io_blocks()
> + * needs to know about any IV generation methods where the low bits of IV don't
> + * simply contain the lblk_num (e.g., IV_INO_LBLK_32).
> + */
>  void fscrypt_generate_iv(union fscrypt_iv *iv, u64 lblk_num,
>  			 const struct fscrypt_info *ci)
>  {
> diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
> index d7aecadf33c1..4cdf807b89b9 100644
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
> @@ -362,3 +363,76 @@ bool fscrypt_mergeable_bio_bh(struct bio *bio,
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

Doesn't this force user buffers to be filesystem block size aligned,
instead of 512 byte aligned as is typical for direct IO?

That's going to cause applications that work fine on normal
filesystems becaues the memalign() buffers to 512 bytes or logical
block device sector sizes (as per the open(2) man page) to fail on
encrypted volumes, and it's not going to be obvious to users as to
why this happens.

XFS has XFS_IOC_DIOINFO to expose exactly this information to
userspace on a per-file basis. Other filesystem and VFS developers
have said for the past 15 years "we don't need no stinking DIOINFO".
The same people shot down adding optional IO alignment
constraint fields to statx() a few years ago, too.

Yet here were are again, with alignment of DIO buffers being an
issue that userspace needs to know about....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
