Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641C824C326
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 18:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbgHTQOF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 12:14:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729474AbgHTQOA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 12:14:00 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B0E52072D;
        Thu, 20 Aug 2020 16:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597940040;
        bh=inkVScu8YnKW3Kj0Rfpvc2K7aHPX6KN8CibER59mPLQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sxxGeEcRfnwmJsuNNrTDEE+A1l8deIPxTlbxMr1/Ar3BlerSBgFtdGkOf4fWdkniC
         WQQa2qabyiQRBWWWB6Y/NGw6bPC+E9Umpdz0puGiqXG96sVrkYwIkni/IrBZ44hEaI
         TxmFbqY/5afDE/jc4evMaVg9y1WjFfmCGTwcjgrQ=
Date:   Thu, 20 Aug 2020 09:13:59 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     viro@zeniv.linux.org.uk, chao@kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel@collabora.com
Subject: Re: [PATCH 2/2] f2fs: Return EOF on unaligned end of file DIO read
Message-ID: <20200820161359.GB2375181@google.com>
References: <20200819200731.2972195-1-krisman@collabora.com>
 <20200819200731.2972195-3-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819200731.2972195-3-krisman@collabora.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Gabriel,

Thank you for the patch. Let me take this separately from the patch set.

Thanks,

On 08/19, Gabriel Krisman Bertazi wrote:
> Reading past end of file returns EOF for aligned reads but -EINVAL for
> unaligned reads on f2fs.  While documentation is not strict about this
> corner case, most filesystem returns EOF on this case, like iomap
> filesystems.  This patch consolidates the behavior for f2fs, by making
> it return EOF(0).
> 
> it can be verified by a read loop on a file that does a partial read
> before EOF (A file that doesn't end at an aligned address).  The
> following code fails on an unaligned file on f2fs, but not on
> btrfs, ext4, and xfs.
> 
>   while (done < total) {
>     ssize_t delta = pread(fd, buf + done, total - done, off + done);
>     if (!delta)
>       break;
>     ...
>   }
> 
> It is arguable whether filesystems should actually return EOF or
> -EINVAL, but since iomap filesystems support it, and so does the
> original DIO code, it seems reasonable to consolidate on that.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  fs/f2fs/data.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 5f527073143e..d9834ffe1da9 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -3510,6 +3510,9 @@ static int check_direct_IO(struct inode *inode, struct iov_iter *iter,
>  	unsigned long align = offset | iov_iter_alignment(iter);
>  	struct block_device *bdev = inode->i_sb->s_bdev;
>  
> +	if (iov_iter_rw(iter) == READ && offset >= i_size_read(inode))
> +		return 1;
> +
>  	if (align & blocksize_mask) {
>  		if (bdev)
>  			blkbits = blksize_bits(bdev_logical_block_size(bdev));
> -- 
> 2.28.0
