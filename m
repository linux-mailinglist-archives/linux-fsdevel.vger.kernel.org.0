Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E052289A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 22:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbgGUULp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 16:11:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:44556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbgGUULo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 16:11:44 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 066C320684;
        Tue, 21 Jul 2020 20:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595362304;
        bh=qoQKgWZhAvGtgKCUrR3MgpQoIvX416jAmXkYrTf5C4o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bMWyWlB/11MTlbsMxh/UBrlE+PK1UfU+8098QuYaeXP4gnmt57SZVQ4oHkG5Bmx7c
         y37NhSgDyEyTuRp2QUZ0i/ZCMWvbKfqv2HTlM7bvw7DIE9G9y9s15zy03EMcbENl7E
         Yyq19zoKHdpAYxs4E/ewwfdjJbbRCSXhjDWvFOtw=
Date:   Tue, 21 Jul 2020 13:11:43 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v4 5/7] f2fs: support direct I/O with fscrypt using
 blk-crypto
Message-ID: <20200721201143.GB43066@google.com>
References: <20200720233739.824943-1-satyat@google.com>
 <20200720233739.824943-6-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720233739.824943-6-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/20, Satya Tangirala wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Wire up f2fs with fscrypt direct I/O support. direct I/O with fscrypt is
> only supported through blk-crypto (i.e. CONFIG_BLK_INLINE_ENCRYPTION must
> have been enabled, the 'inlinecrypt' mount option must have been specified,
> and either hardware inline encryption support must be present or
> CONFIG_BLK_INLINE_ENCYRPTION_FALLBACK must have been enabled). Further,
> direct I/O on encrypted files is only supported when I/O is aligned
> to the filesystem block size (which is *not* necessarily the same as the
> block device's block size).
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> Co-developed-by: Satya Tangirala <satyat@google.com>
> Signed-off-by: Satya Tangirala <satyat@google.com>

Acked-by: Jaegeuk Kim <jaegeuk@kernel.org>

> ---
>  fs/f2fs/f2fs.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index b35a50f4953c..978130b5a195 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -4082,7 +4082,11 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
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
>  	if (f2fs_is_multi_device(sbi))
>  		return true;
> -- 
> 2.28.0.rc0.105.gf9edc3c819-goog
