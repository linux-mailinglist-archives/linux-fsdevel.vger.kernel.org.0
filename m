Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A491E3A5F57
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 11:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbhFNJrW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 05:47:22 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53682 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbhFNJrU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 05:47:20 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CF19421983;
        Mon, 14 Jun 2021 09:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623663915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fsDsmiHkPIfgD2wYZlCcHttz/fSsUL0oHswA0RIigKM=;
        b=GWOb+IsyurX12kNiUxOz4ySBKyDyWlyQ3AmCOMwmT0NkU2x31HHelAjjVkScfy7BW7krIh
        wYKE/axVa+ENnxvKsKwCtZux2Xhvlv0yzs8mHsU6s+XtzD2Avmu/WQxz9GlTy28rk6T3j/
        NXwboT+4VmZKSIzLgQUm3Zsmzx7uutQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623663915;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fsDsmiHkPIfgD2wYZlCcHttz/fSsUL0oHswA0RIigKM=;
        b=xLVP6icqu+7OweDIu1B9TqSgjCJpgXHaKPN5oKmjKCJD5b/E08PsWx63RgdTH/AzoqJdED
        X2KZ5tgP0Pn7RTDQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id BFADFA3B9F;
        Mon, 14 Jun 2021 09:45:15 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A5CDC1F2B82; Mon, 14 Jun 2021 11:45:15 +0200 (CEST)
Date:   Mon, 14 Jun 2021 11:45:15 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] fs: move ramfs_aops to libfs
Message-ID: <20210614094515.GC26615@quack2.suse.cz>
References: <20210614061512.3966143-1-hch@lst.de>
 <20210614061512.3966143-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614061512.3966143-3-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 14-06-21 08:15:11, Christoph Hellwig wrote:
> Move the ramfs aops to libfs and reuse them for kernfs and configfs.
> Thosw two did not wire up ->set_page_dirty before and now get
> __set_page_dirty_no_writeback, which is the right one for no-writeback
> address_space usage.
> 
> Drop the now unused exports of the libfs helpers only used for
> ramfs-style pagecache usage.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/configfs/inode.c |  8 +-------
>  fs/kernfs/inode.c   |  8 +-------
>  fs/libfs.c          | 17 +++++++++++++----
>  fs/ramfs/inode.c    |  9 +--------
>  include/linux/fs.h  |  5 +----
>  5 files changed, 17 insertions(+), 30 deletions(-)
> 
> diff --git a/fs/configfs/inode.c b/fs/configfs/inode.c
> index eb5ec3e46283..b601610e9907 100644
> --- a/fs/configfs/inode.c
> +++ b/fs/configfs/inode.c
> @@ -28,12 +28,6 @@
>  static struct lock_class_key default_group_class[MAX_LOCK_DEPTH];
>  #endif
>  
> -static const struct address_space_operations configfs_aops = {
> -	.readpage	= simple_readpage,
> -	.write_begin	= simple_write_begin,
> -	.write_end	= simple_write_end,
> -};
> -
>  static const struct inode_operations configfs_inode_operations ={
>  	.setattr	= configfs_setattr,
>  };
> @@ -114,7 +108,7 @@ struct inode *configfs_new_inode(umode_t mode, struct configfs_dirent *sd,
>  	struct inode * inode = new_inode(s);
>  	if (inode) {
>  		inode->i_ino = get_next_ino();
> -		inode->i_mapping->a_ops = &configfs_aops;
> +		inode->i_mapping->a_ops = &ram_aops;
>  		inode->i_op = &configfs_inode_operations;
>  
>  		if (sd->s_iattr) {
> diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
> index d73950fc3d57..26f2aa3586f9 100644
> --- a/fs/kernfs/inode.c
> +++ b/fs/kernfs/inode.c
> @@ -17,12 +17,6 @@
>  
>  #include "kernfs-internal.h"
>  
> -static const struct address_space_operations kernfs_aops = {
> -	.readpage	= simple_readpage,
> -	.write_begin	= simple_write_begin,
> -	.write_end	= simple_write_end,
> -};
> -
>  static const struct inode_operations kernfs_iops = {
>  	.permission	= kernfs_iop_permission,
>  	.setattr	= kernfs_iop_setattr,
> @@ -203,7 +197,7 @@ static void kernfs_init_inode(struct kernfs_node *kn, struct inode *inode)
>  {
>  	kernfs_get(kn);
>  	inode->i_private = kn;
> -	inode->i_mapping->a_ops = &kernfs_aops;
> +	inode->i_mapping->a_ops = &ram_aops;
>  	inode->i_op = &kernfs_iops;
>  	inode->i_generation = kernfs_gen(kn);
>  
> diff --git a/fs/libfs.c b/fs/libfs.c
> index e9b29c6ffccb..2d7f086b93d6 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -512,7 +512,7 @@ int simple_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
>  }
>  EXPORT_SYMBOL(simple_setattr);
>  
> -int simple_readpage(struct file *file, struct page *page)
> +static int simple_readpage(struct file *file, struct page *page)
>  {
>  	clear_highpage(page);
>  	flush_dcache_page(page);
> @@ -520,7 +520,6 @@ int simple_readpage(struct file *file, struct page *page)
>  	unlock_page(page);
>  	return 0;
>  }
> -EXPORT_SYMBOL(simple_readpage);
>  
>  int simple_write_begin(struct file *file, struct address_space *mapping,
>  			loff_t pos, unsigned len, unsigned flags,
> @@ -568,7 +567,7 @@ EXPORT_SYMBOL(simple_write_begin);
>   *
>   * Use *ONLY* with simple_readpage()
>   */
> -int simple_write_end(struct file *file, struct address_space *mapping,
> +static int simple_write_end(struct file *file, struct address_space *mapping,
>  			loff_t pos, unsigned len, unsigned copied,
>  			struct page *page, void *fsdata)
>  {
> @@ -597,7 +596,17 @@ int simple_write_end(struct file *file, struct address_space *mapping,
>  
>  	return copied;
>  }
> -EXPORT_SYMBOL(simple_write_end);
> +
> +/*
> + * Provides ramfs-style behavior: data in the pagecache, but no writeback.
> + */
> +const struct address_space_operations ram_aops = {
> +	.readpage	= simple_readpage,
> +	.write_begin	= simple_write_begin,
> +	.write_end	= simple_write_end,
> +	.set_page_dirty	= __set_page_dirty_no_writeback,
> +};
> +EXPORT_SYMBOL(ram_aops);
>  
>  /*
>   * the inodes created here are not hashed. If you use iunique to generate
> diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
> index 9ebd17d7befb..65e7e56005b8 100644
> --- a/fs/ramfs/inode.c
> +++ b/fs/ramfs/inode.c
> @@ -53,13 +53,6 @@ struct ramfs_fs_info {
>  static const struct super_operations ramfs_ops;
>  static const struct inode_operations ramfs_dir_inode_operations;
>  
> -static const struct address_space_operations ramfs_aops = {
> -	.readpage	= simple_readpage,
> -	.write_begin	= simple_write_begin,
> -	.write_end	= simple_write_end,
> -	.set_page_dirty	= __set_page_dirty_no_writeback,
> -};
> -
>  struct inode *ramfs_get_inode(struct super_block *sb,
>  				const struct inode *dir, umode_t mode, dev_t dev)
>  {
> @@ -68,7 +61,7 @@ struct inode *ramfs_get_inode(struct super_block *sb,
>  	if (inode) {
>  		inode->i_ino = get_next_ino();
>  		inode_init_owner(&init_user_ns, inode, dir, mode);
> -		inode->i_mapping->a_ops = &ramfs_aops;
> +		inode->i_mapping->a_ops = &ram_aops;
>  		mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
>  		mapping_set_unevictable(inode->i_mapping);
>  		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c3c88fdb9b2a..869909345420 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3422,13 +3422,10 @@ extern void noop_invalidatepage(struct page *page, unsigned int offset,
>  		unsigned int length);
>  extern ssize_t noop_direct_IO(struct kiocb *iocb, struct iov_iter *iter);
>  extern int simple_empty(struct dentry *);
> -extern int simple_readpage(struct file *file, struct page *page);
>  extern int simple_write_begin(struct file *file, struct address_space *mapping,
>  			loff_t pos, unsigned len, unsigned flags,
>  			struct page **pagep, void **fsdata);
> -extern int simple_write_end(struct file *file, struct address_space *mapping,
> -			loff_t pos, unsigned len, unsigned copied,
> -			struct page *page, void *fsdata);
> +extern const struct address_space_operations ram_aops;
>  extern int always_delete_dentry(const struct dentry *);
>  extern struct inode *alloc_anon_inode(struct super_block *);
>  extern int simple_nosetlease(struct file *, long, struct file_lock **, void **);
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
