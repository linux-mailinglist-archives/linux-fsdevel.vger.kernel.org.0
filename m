Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF3725D2AD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 09:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbgIDHth (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 03:49:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:46722 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgIDHth (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 03:49:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EEE40AD03;
        Fri,  4 Sep 2020 07:49:36 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D7D611E12D1; Fri,  4 Sep 2020 09:49:35 +0200 (CEST)
Date:   Fri, 4 Sep 2020 09:49:35 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        jack@suse.cz, khazhy@google.com, kernel@collabora.com,
        Jamie Liu <jamieliu@google.com>
Subject: Re: [PATCH v2 3/3] direct-io: defer alignment check until after the
 EOF check
Message-ID: <20200904074935.GC2867@quack2.suse.cz>
References: <20200903200414.673105-1-krisman@collabora.com>
 <20200903200414.673105-4-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903200414.673105-4-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 03-09-20 16:04:14, Gabriel Krisman Bertazi wrote:
> Prior to commit 9fe55eea7e4b ("Fix race when checking i_size on direct
> i/o read"), an unaligned direct read past end of file would trigger EOF,
> since generic_file_aio_read detected this read-at-EOF condition and
> skipped the direct IO read entirely, returning 0. After that change, the
> read now reaches dio_generic, which detects the misalignment and returns
> EINVAL.
> 
> This consolidates the generic direct-io to follow the same behavior of
> filesystems.  Apparently, this fix will only affect ocfs2 since other
> filesystems do this verification before calling do_blockdev_direct_IO,
> with the exception of f2fs, which has the same bug, but is fixed in the
> next patch.
> 
> it can be verified by a read loop on a file that does a partial read
> before EOF (On file that doesn't end at an aligned address).  The
> following code fails on an unaligned file on filesystems without
> prior validation without this patch, but not on btrfs, ext4, and xfs.
> 
>   while (done < total) {
>     ssize_t delta = pread(fd, buf + done, total - done, off + done);
>     if (!delta)
>       break;
>     ...
>   }
> 
> Fix this regression by moving the misalignment check to after the EOF
> check added by commit 74cedf9b6c60 ("direct-io: Fix negative return from
> dio read beyond eof").
> 
> Based on a patch by Jamie Liu.
> 
> Reported-by: Jamie Liu <jamieliu@google.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

This patch also looks good except for the fail_dio jump...

								Honza

> ---
>  fs/direct-io.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/direct-io.c b/fs/direct-io.c
> index 43460c8e0f90..01131a1674b8 100644
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -1165,14 +1165,6 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
>  	 * the early prefetch in the caller enough time.
>  	 */
>  
> -	if (align & blocksize_mask) {
> -		if (bdev)
> -			blkbits = blksize_bits(bdev_logical_block_size(bdev));
> -		blocksize_mask = (1 << blkbits) - 1;
> -		if (align & blocksize_mask)
> -			return -EINVAL;
> -	}
> -
>  	/* watch out for a 0 len io from a tricksy fs */
>  	if (iov_iter_rw(iter) == READ && !count)
>  		return 0;
> @@ -1200,6 +1192,14 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
>  		goto fail_dio;
>  	}
>  
> +	if (align & blocksize_mask) {
> +		if (bdev)
> +			blkbits = blksize_bits(bdev_logical_block_size(bdev));
> +		blocksize_mask = (1 << blkbits) - 1;
> +		if (align & blocksize_mask)
> +			goto fail_dio;
> +	}
> +
>  	if (dio->flags & DIO_LOCKING && iov_iter_rw(iter) == READ) {
>  		struct address_space *mapping = iocb->ki_filp->f_mapping;
>  
> -- 
> 2.28.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
