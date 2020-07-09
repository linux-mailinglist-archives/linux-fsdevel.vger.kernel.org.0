Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0CCB21AA0A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jul 2020 23:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgGIVzB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jul 2020 17:55:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:41952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgGIVzB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jul 2020 17:55:01 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2723820672;
        Thu,  9 Jul 2020 21:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594331700;
        bh=17t7u5FxwRuwcW6rNtkihmGzGdOtOv+v6GD8suZEV3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cdkjFt0Ue4fI7oesmV7oIhfgvjKMAvuK4weMQ7ZeIomAJzcsxEkDPbbh5xldjJfmp
         tFWjL3tgmhIE/NE2SHWnz+zmMJPFpkLgGKEDrWBmnasWoYSoeWMMTmqH6dm8F0RvgY
         qjFgRYIh+npFHQvidp2glKI5JuYgo711bveB1GCU=
Date:   Thu, 9 Jul 2020 14:54:58 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/5] fscrypt: Add functions for direct I/O support
Message-ID: <20200709215458.GC3855682@gmail.com>
References: <20200709194751.2579207-1-satyat@google.com>
 <20200709194751.2579207-2-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709194751.2579207-2-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 09, 2020 at 07:47:47PM +0000, Satya Tangirala via Linux-f2fs-devel wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Introduce fscrypt_dio_supported() to check whether a direct I/O request
> is unsupported due to encryption constraints, and
> fscrypt_limit_dio_pages() to check how many pages may be added to a bio
> being prepared for direct I/O.
> 
> The IV_INO_LBLK_32 fscrypt policy introduces the possibility that DUNs
> in logically continuous file blocks might wrap from 0xffffffff to 0.
> Bios in which the DUN wraps around like this cannot be submitted. This
> is especially difficult to handle when block_size != PAGE_SIZE, since in
> that case the DUN can wrap in the middle of a page.
> 
> For now, we add direct I/O support while using IV_INO_LBLK_32 policies
> only for the case when block_size == PAGE_SIZE. When IV_INO_LBLK_32
> policy is used, fscrypt_dio_supported() rejects the bio when
> block_size != PAGE_SIZE. fscrypt_limit_dio_pages() returns the number of
> pages that may be added to the bio without causing the DUN to wrap
> around within the bio.

This commit message is a bit outdated, since the latest version of
"fscrypt: add inline encryption support" already makes IV_INO_LBLK_32
with block_size != PAGE_SIZE fall back to filesystem-layer encryption,
and hence it won't allow direct I/O.

> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Satya Tangirala <satyat@google.com>

Can you mention any changes you made, e.g.:

Signed-off-by: Eric Biggers <ebiggers@google.com>
[ST: split original change into separate patches, and updated to account
 for inline encryption no longer being allowed with IV_INO_LBLK_32 and
 blocksize != PAGE_SIZE]
Signed-off-by: Satya Tangirala <satyat@google.com>

> +/**
> + * fscrypt_limit_dio_pages() - limit I/O pages to avoid discontiguous DUNs
> + * @inode: the file on which I/O is being done
> + * @pos: the file position (in bytes) at which the I/O is being done
> + * @nr_pages: the number of pages we want to submit starting at @pos
> + *
> + * For direct I/O: limit the number of pages that will be submitted in the bio
> + * targeting @pos, in order to avoid crossing a data unit number (DUN)
> + * discontinuity.  This is only needed for certain IV generation methods.
> + *
> + * This assumes block_size == PAGE_SIZE; see fscrypt_dio_supported().

The note about block_size == PAGE_SIZE here is outdated.

I was also struggling a bit to decide what to name this function.  Note
that it's not really direct I/O specific.  Also, fs/iomap/direct-io.c
needs it but fs/direct-io.c does not.

What this function really does is batch together the mergeability checks
for a logical range.

Maybe the comment could explain this better, and maybe the function
should be called "fscrypt_limit_io_pages()" instead.

> + * Return: the actual number of pages that can be submitted
> + */
> +int fscrypt_limit_dio_pages(const struct inode *inode, loff_t pos, int nr_pages)
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
> +	if (WARN_ON_ONCE(i_blocksize(inode) != PAGE_SIZE))
> +		return 1;
> +
> +	/* With IV_INO_LBLK_32, the DUN can wrap around from U32_MAX to 0. */
> +
> +	dun = ci->ci_hashed_ino + (pos >> inode->i_blkbits);
> +
> +	return min_t(u64, nr_pages, (u64)U32_MAX + 1 - dun);
> +}

- Eric
