Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3598925314C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Aug 2020 16:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgHZO3C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Aug 2020 10:29:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:52378 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbgHZO3A (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:29:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A0627AC46;
        Wed, 26 Aug 2020 14:29:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DE0881E12AF; Wed, 26 Aug 2020 16:28:57 +0200 (CEST)
Date:   Wed, 26 Aug 2020 16:28:57 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     viro@zeniv.linux.org.uk, jaegeuk@kernel.org, chao@kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Jamie Liu <jamieliu@google.com>, kernel@collabora.com
Subject: Re: [PATCH 1/2] direct-io: defer alignment check until after EOF
 check
Message-ID: <20200826142857.GA8760@quack2.suse.cz>
References: <20200819200731.2972195-1-krisman@collabora.com>
 <20200819200731.2972195-2-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819200731.2972195-2-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 19-08-20 16:07:30, Gabriel Krisman Bertazi wrote:
> From: Jamie Liu <jamieliu@google.com>
> 
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
> Signed-off-by: Jamie Liu <jamieliu@google.com>
> Co-developed-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Looks sane to me but I'd note that your patch also makes unaligned 0-length
reads succeed (probably don't care). Also your patch makes unaligned DIO reads
write-out page cache before returning EINVAL - that actually looks a bit
strange. Not that it would be outright bug but it seems strange to wait
couple of seconds doing writeback only to return EINVAL... So I'd maybe
restructure the code like:

	if (dio->flags & DIO_LOCKING && iov_iter_rw(iter) == READ)
		inode_lock(inode)
	dio->i_size = i_size_read(inode);
	... i_size checks ...
	... alignment checks ...
	if (dio->flags & DIO_LOCKING && iov_iter_rw(iter) == READ)
		... writeout ...

What do you think?
								Honza

> ---
>  fs/direct-io.c | 31 ++++++++++++++++++-------------
>  1 file changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/direct-io.c b/fs/direct-io.c
> index 183299892465..77400b033d63 100644
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -1160,19 +1160,6 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
>  	struct blk_plug plug;
>  	unsigned long align = offset | iov_iter_alignment(iter);
>  
> -	/*
> -	 * Avoid references to bdev if not absolutely needed to give
> -	 * the early prefetch in the caller enough time.
> -	 */
> -
> -	if (align & blocksize_mask) {
> -		if (bdev)
> -			blkbits = blksize_bits(bdev_logical_block_size(bdev));
> -		blocksize_mask = (1 << blkbits) - 1;
> -		if (align & blocksize_mask)
> -			goto out;
> -	}
> -
>  	/* watch out for a 0 len io from a tricksy fs */
>  	if (iov_iter_rw(iter) == READ && !count)
>  		return 0;
> @@ -1217,6 +1204,24 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
>  		goto out;
>  	}
>  
> +	/*
> +	 * Avoid references to bdev if not absolutely needed to give
> +	 * the early prefetch in the caller enough time.
> +	 */
> +
> +	if (align & blocksize_mask) {
> +		if (bdev)
> +			blkbits = blksize_bits(bdev_logical_block_size(bdev));
> +		blocksize_mask = (1 << blkbits) - 1;
> +		if (align & blocksize_mask) {
> +			if (iov_iter_rw(iter) == READ && dio->flags & DIO_LOCKING)
> +				inode_unlock(inode);
> +			kmem_cache_free(dio_cache, dio);
> +			retval = -EINVAL;
> +			goto out;
> +		}
> +	}
> +
>  	/*
>  	 * For file extending writes updating i_size before data writeouts
>  	 * complete can expose uninitialized blocks in dumb filesystems.
> -- 
> 2.28.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
