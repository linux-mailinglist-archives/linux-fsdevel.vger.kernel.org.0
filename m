Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2045F4A2A96
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jan 2022 01:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344709AbiA2A1r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 19:27:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344642AbiA2A1q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 19:27:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56447C061714;
        Fri, 28 Jan 2022 16:27:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F189061F6B;
        Sat, 29 Jan 2022 00:27:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B71C340E7;
        Sat, 29 Jan 2022 00:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643416065;
        bh=pMYiYWwTXCaMUttKGxLCbba/TS8VTa1Kq/qthmLQc8A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hTAM+kCV/tcMtH1taJy3HbXKHFdeNrapKvJ55E6k6BNArYcDR9hvzVgpghKlX+fo8
         HSMYhybQBTB3flb/RRUQcCjU/wcnYCL3Jt1CTeg+J9diUVbSi1+k/E6nd9NK8ZSRHU
         QPAuxWZPSPNSrt2i47uKzMi7EydVnxmMd06oSEIaEqbxc5XzW539kHtLE5NeNWKwyg
         GF1Y/+nW/SESPfVZxVHkIqFDwtt1JIUzHbBjA7oeQIhiTtmv6Gt8OqmagKkT/tsq0r
         staxJFN6kFqa9jRH5RC5sjz723a4e4C3jEV0y6EyJ2XFxaPkcfzlFoVx9/KThoREV1
         ybqbbx6by3l4A==
Date:   Fri, 28 Jan 2022 16:27:43 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Satya Tangirala <satyat@google.com>
Subject: Re: [PATCH v11 4/5] f2fs: support direct I/O with fscrypt using
 blk-crypto
Message-ID: <YfSJ/xstxw8mFw80@google.com>
References: <20220128233940.79464-1-ebiggers@kernel.org>
 <20220128233940.79464-5-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128233940.79464-5-ebiggers@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 01/28, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Encrypted files traditionally haven't supported DIO, due to the need to
> encrypt/decrypt the data.  However, when the encryption is implemented
> using inline encryption (blk-crypto) instead of the traditional
> filesystem-layer encryption, it is straightforward to support DIO.
> 
> Therefore, make f2fs support DIO on files that are using inline
> encryption.  Since f2fs uses iomap for DIO, and fscrypt support was
> already added to iomap DIO, this just requires two small changes:
> 
> - Let DIO proceed when supported, by checking fscrypt_dio_supported()
>   instead of assuming that encrypted files never support DIO.
> 
> - In f2fs_iomap_begin(), use fscrypt_limit_io_blocks() to limit the
>   length of the mapping in the rare case where a DUN discontiguity
>   occurs in the middle of an extent.  The iomap DIO implementation
>   requires this, since it assumes that it can submit a bio covering (up
>   to) the whole mapping, without checking fscrypt constraints itself.
> 
> Co-developed-by: Satya Tangirala <satyat@google.com>
> Signed-off-by: Satya Tangirala <satyat@google.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Acked-by: Jaegeuk Kim <jaegeuk@kernel.org>

> ---
>  fs/f2fs/data.c | 7 +++++++
>  fs/f2fs/f2fs.h | 6 +++++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 8c417864c66ae..020d47f97969c 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -4044,6 +4044,13 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  
>  	iomap->offset = blks_to_bytes(inode, map.m_lblk);
>  
> +	/*
> +	 * When inline encryption is enabled, sometimes I/O to an encrypted file
> +	 * has to be broken up to guarantee DUN contiguity.  Handle this by
> +	 * limiting the length of the mapping returned.
> +	 */
> +	map.m_len = fscrypt_limit_io_blocks(inode, map.m_lblk, map.m_len);
> +
>  	if (map.m_flags & (F2FS_MAP_MAPPED | F2FS_MAP_UNWRITTEN)) {
>  		iomap->length = blks_to_bytes(inode, map.m_len);
>  		if (map.m_flags & F2FS_MAP_MAPPED) {
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index eb22fa91c2b26..db46f3cf0885d 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -4371,7 +4371,11 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>  	int rw = iov_iter_rw(iter);
>  
> -	if (f2fs_post_read_required(inode))
> +	if (!fscrypt_dio_supported(iocb, iter))
> +		return true;
> +	if (fsverity_active(inode))
> +		return true;
> +	if (f2fs_compressed_file(inode))
>  		return true;
>  
>  	/* disallow direct IO if any of devices has unaligned blksize */
> -- 
> 2.35.0
