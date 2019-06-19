Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 352884BD68
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2019 18:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfFSQB5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jun 2019 12:01:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:42364 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726332AbfFSQB5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jun 2019 12:01:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8E0FEAD4C;
        Wed, 19 Jun 2019 16:01:55 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 538551E434D; Wed, 19 Jun 2019 18:01:54 +0200 (CEST)
Date:   Wed, 19 Jun 2019 18:01:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] fs: Move mark_inode_dirty out of __generic_write_end
Message-ID: <20190619160154.GA13630@quack2.suse.cz>
References: <20190618144716.8133-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618144716.8133-1-agruenba@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 18-06-19 16:47:16, Andreas Gruenbacher wrote:
> Remove the mark_inode_dirty call from __generic_write_end and add it to
> generic_write_end and the high-level iomap functions where necessary.
> That way, large writes will only dirty inodes at the end instead of
> dirtying them once per page.  This fixes a performance bottleneck on
> gfs2.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

So the patch looks correct but honestly I don't like how we duplicate inode
dirtying over several places. I was wondering whether we could not move the
logic to iomap_apply() or something like that.

								Honza

> ---
>  fs/buffer.c | 26 ++++++++++++++++++--------
>  fs/iomap.c  | 42 ++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 56 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index e450c55f6434..1b51003bc9d2 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2089,8 +2089,7 @@ EXPORT_SYMBOL(block_write_begin);
>  void __generic_write_end(struct inode *inode, loff_t pos, unsigned copied,
>  		struct page *page)
>  {
> -	loff_t old_size = inode->i_size;
> -	bool i_size_changed = false;
> +	loff_t old_size;
>  
>  	/*
>  	 * No need to use i_size_read() here, the i_size cannot change under us
> @@ -2099,23 +2098,21 @@ void __generic_write_end(struct inode *inode, loff_t pos, unsigned copied,
>  	 * But it's important to update i_size while still holding page lock:
>  	 * page writeout could otherwise come in and zero beyond i_size.
>  	 */
> -	if (pos + copied > inode->i_size) {
> +	old_size = inode->i_size;
> +	if (pos + copied > old_size)
>  		i_size_write(inode, pos + copied);
> -		i_size_changed = true;
> -	}
>  
>  	unlock_page(page);
>  
>  	if (old_size < pos)
>  		pagecache_isize_extended(inode, old_size, pos);
> +
>  	/*
>  	 * Don't mark the inode dirty under page lock. First, it unnecessarily
>  	 * makes the holding time of page lock longer. Second, it forces lock
>  	 * ordering of page lock and transaction start for journaling
>  	 * filesystems.
>  	 */
> -	if (i_size_changed)
> -		mark_inode_dirty(inode);
>  }
>  
>  int block_write_end(struct file *file, struct address_space *mapping,
> @@ -2158,9 +2155,22 @@ int generic_write_end(struct file *file, struct address_space *mapping,
>  			loff_t pos, unsigned len, unsigned copied,
>  			struct page *page, void *fsdata)
>  {
> +	struct inode *inode = mapping->host;
> +	loff_t old_size;
> +
> +	/*
> +	 * No need to use i_size_read() here, the i_size cannot change under us
> +	 * because we hold i_rwsem.
> +	 */
> +	old_size = inode->i_size;
> +
>  	copied = block_write_end(file, mapping, pos, len, copied, page, fsdata);
> -	__generic_write_end(mapping->host, pos, copied, page);
> +	__generic_write_end(inode, pos, copied, page);
>  	put_page(page);
> +
> +	if (old_size != inode->i_size)
> +		mark_inode_dirty(inode);
> +
>  	return copied;
>  }
>  EXPORT_SYMBOL(generic_write_end);
> diff --git a/fs/iomap.c b/fs/iomap.c
> index 23ef63fd1669..9454568a7f5e 100644
> --- a/fs/iomap.c
> +++ b/fs/iomap.c
> @@ -881,6 +881,13 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *iter,
>  {
>  	struct inode *inode = iocb->ki_filp->f_mapping->host;
>  	loff_t pos = iocb->ki_pos, ret = 0, written = 0;
> +	loff_t old_size;
> +
> +        /*
> +	 * No need to use i_size_read() here, the i_size cannot change under us
> +	 * because we hold i_rwsem.
> +	 */
> +	old_size = inode->i_size;
>  
>  	while (iov_iter_count(iter)) {
>  		ret = iomap_apply(inode, pos, iov_iter_count(iter),
> @@ -891,6 +898,9 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *iter,
>  		written += ret;
>  	}
>  
> +	if (old_size != inode->i_size)
> +		mark_inode_dirty(inode);
> +
>  	return written ? written : ret;
>  }
>  EXPORT_SYMBOL_GPL(iomap_file_buffered_write);
> @@ -961,18 +971,30 @@ int
>  iomap_file_dirty(struct inode *inode, loff_t pos, loff_t len,
>  		const struct iomap_ops *ops)
>  {
> +	loff_t old_size;
>  	loff_t ret;
>  
> +        /*
> +	 * No need to use i_size_read() here, the i_size cannot change under us
> +	 * because we hold i_rwsem.
> +	 */
> +	old_size = inode->i_size;
> +
>  	while (len) {
>  		ret = iomap_apply(inode, pos, len, IOMAP_WRITE, ops, NULL,
>  				iomap_dirty_actor);
>  		if (ret <= 0)
> -			return ret;
> +			goto out;
>  		pos += ret;
>  		len -= ret;
>  	}
> +	ret = 0;
>  
> -	return 0;
> +out:
> +	if (old_size != inode->i_size)
> +		mark_inode_dirty(inode);
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(iomap_file_dirty);
>  
> @@ -1039,19 +1061,31 @@ int
>  iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
>  		const struct iomap_ops *ops)
>  {
> +	loff_t old_size;
>  	loff_t ret;
>  
> +        /*
> +	 * No need to use i_size_read() here, the i_size cannot change under us
> +	 * because we hold i_rwsem.
> +	 */
> +	old_size = inode->i_size;
> +
>  	while (len > 0) {
>  		ret = iomap_apply(inode, pos, len, IOMAP_ZERO,
>  				ops, did_zero, iomap_zero_range_actor);
>  		if (ret <= 0)
> -			return ret;
> +			goto out;
>  
>  		pos += ret;
>  		len -= ret;
>  	}
> +	ret = 0;
>  
> -	return 0;
> +out:
> +	if (old_size != inode->i_size)
> +		mark_inode_dirty(inode);
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(iomap_zero_range);
>  
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
