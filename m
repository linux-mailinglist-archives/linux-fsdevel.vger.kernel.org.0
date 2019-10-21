Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF04DEE0D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 15:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbfJUNle (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 09:41:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:56812 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729714AbfJUNle (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:41:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EFE89B15A;
        Mon, 21 Oct 2019 13:41:31 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A1D551E4AA0; Mon, 21 Oct 2019 15:41:31 +0200 (CEST)
Date:   Mon, 21 Oct 2019 15:41:31 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v5 07/12] ext4: introduce direct I/O read using iomap
 infrastructure
Message-ID: <20191021134131.GF25184@quack2.suse.cz>
References: <cover.1571647178.git.mbobrowski@mbobrowski.org>
 <280de880787dc7c064c309efb685f95d4ff732a9.1571647179.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <280de880787dc7c064c309efb685f95d4ff732a9.1571647179.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 21-10-19 20:18:37, Matthew Bobrowski wrote:
> This patch introduces a new direct I/O read path which makes use of
> the iomap infrastructure.
> 
> The new function ext4_do_read_iter() is responsible for calling into
> the iomap infrastructure via iomap_dio_rw(). If the read operation
> performed on the inode is not supported, which is checked via
> ext4_dio_supported(), then we simply fallback and complete the I/O
> using buffered I/O.
> 
> Existing direct I/O read code path has been removed, as it is no
> longer required.
> 
> Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

BTW, I think I gave you my Reviewed-by tag for this patch also last time
and this patch didn't change since then. You can just include the tag in
your posting in that case.

								Honza

> ---
>  fs/ext4/file.c  | 46 +++++++++++++++++++++++++++++++++++++++++++++-
>  fs/ext4/inode.c | 32 +-------------------------------
>  2 files changed, 46 insertions(+), 32 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index ab75aee3e687..6ea7e00e0204 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -34,6 +34,46 @@
>  #include "xattr.h"
>  #include "acl.h"
>  
> +static bool ext4_dio_supported(struct inode *inode)
> +{
> +	if (IS_ENABLED(CONFIG_FS_ENCRYPTION) && IS_ENCRYPTED(inode))
> +		return false;
> +	if (fsverity_active(inode))
> +		return false;
> +	if (ext4_should_journal_data(inode))
> +		return false;
> +	if (ext4_has_inline_data(inode))
> +		return false;
> +	return true;
> +}
> +
> +static int ext4_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
> +{
> +	ssize_t ret;
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +
> +	inode_lock_shared(inode);
> +	if (!ext4_dio_supported(inode)) {
> +		inode_unlock_shared(inode);
> +		/*
> +		 * Fallback to buffered I/O if the operation being performed on
> +		 * the inode is not supported by direct I/O. The IOCB_DIRECT
> +		 * flag needs to be cleared here in order to ensure that the
> +		 * direct I/O path within generic_file_read_iter() is not
> +		 * taken.
> +		 */
> +		iocb->ki_flags &= ~IOCB_DIRECT;
> +		return generic_file_read_iter(iocb, to);
> +	}
> +
> +	ret = iomap_dio_rw(iocb, to, &ext4_iomap_ops, NULL,
> +			   is_sync_kiocb(iocb));
> +	inode_unlock_shared(inode);
> +
> +	file_accessed(iocb->ki_filp);
> +	return ret;
> +}
> +
>  #ifdef CONFIG_FS_DAX
>  static ssize_t ext4_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  {
> @@ -64,7 +104,9 @@ static ssize_t ext4_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  
>  static ssize_t ext4_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  {
> -	if (unlikely(ext4_forced_shutdown(EXT4_SB(file_inode(iocb->ki_filp)->i_sb))))
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +
> +	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
>  		return -EIO;
>  
>  	if (!iov_iter_count(to))
> @@ -74,6 +116,8 @@ static ssize_t ext4_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  	if (IS_DAX(file_inode(iocb->ki_filp)))
>  		return ext4_dax_read_iter(iocb, to);
>  #endif
> +	if (iocb->ki_flags & IOCB_DIRECT)
> +		return ext4_dio_read_iter(iocb, to);
>  	return generic_file_read_iter(iocb, to);
>  }
>  
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index ebeedbf3900f..03a9e2b85e46 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -863,9 +863,6 @@ int ext4_dio_get_block(struct inode *inode, sector_t iblock,
>  {
>  	/* We don't expect handle for direct IO */
>  	WARN_ON_ONCE(ext4_journal_current_handle());
> -
> -	if (!create)
> -		return _ext4_get_block(inode, iblock, bh, 0);
>  	return ext4_get_block_trans(inode, iblock, bh, EXT4_GET_BLOCKS_CREATE);
>  }
>  
> @@ -3865,30 +3862,6 @@ static ssize_t ext4_direct_IO_write(struct kiocb *iocb, struct iov_iter *iter)
>  	return ret;
>  }
>  
> -static ssize_t ext4_direct_IO_read(struct kiocb *iocb, struct iov_iter *iter)
> -{
> -	struct address_space *mapping = iocb->ki_filp->f_mapping;
> -	struct inode *inode = mapping->host;
> -	size_t count = iov_iter_count(iter);
> -	ssize_t ret;
> -
> -	/*
> -	 * Shared inode_lock is enough for us - it protects against concurrent
> -	 * writes & truncates and since we take care of writing back page cache,
> -	 * we are protected against page writeback as well.
> -	 */
> -	inode_lock_shared(inode);
> -	ret = filemap_write_and_wait_range(mapping, iocb->ki_pos,
> -					   iocb->ki_pos + count - 1);
> -	if (ret)
> -		goto out_unlock;
> -	ret = __blockdev_direct_IO(iocb, inode, inode->i_sb->s_bdev,
> -				   iter, ext4_dio_get_block, NULL, NULL, 0);
> -out_unlock:
> -	inode_unlock_shared(inode);
> -	return ret;
> -}
> -
>  static ssize_t ext4_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>  {
>  	struct file *file = iocb->ki_filp;
> @@ -3915,10 +3888,7 @@ static ssize_t ext4_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>  		return 0;
>  
>  	trace_ext4_direct_IO_enter(inode, offset, count, iov_iter_rw(iter));
> -	if (iov_iter_rw(iter) == READ)
> -		ret = ext4_direct_IO_read(iocb, iter);
> -	else
> -		ret = ext4_direct_IO_write(iocb, iter);
> +	ret = ext4_direct_IO_write(iocb, iter);
>  	trace_ext4_direct_IO_exit(inode, offset, count, iov_iter_rw(iter), ret);
>  	return ret;
>  }
> -- 
> 2.20.1
> 
> --<M>--
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
