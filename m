Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 262FA3A5F68
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 11:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbhFNJxL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 05:53:11 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55264 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbhFNJxL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 05:53:11 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A7E5B21978;
        Mon, 14 Jun 2021 09:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623664267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ADpTy1Zsz+YbXQxTcfSvsIEb4OaYKOLvMPfGISmBi/w=;
        b=oDbB5BUJOLmHLTQP8nZZcsRjKHsbYgE4ls1yW45QOQ+bxakqgfUmYAAcc7fgDAM5K+MLJx
        /hRShLJJw6s8W0Uffd8bew356/OX9BPKLzD+RSh4xODqQDGPiFHUDMbNIML++FDskYAAKb
        njvKpF2N60hMC7a1HvlDg2LzmMFewW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623664267;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ADpTy1Zsz+YbXQxTcfSvsIEb4OaYKOLvMPfGISmBi/w=;
        b=BjyVGykxE34GN41hhuif4YcFLs81vP53GGU3gwK+M5Tcybqa4Uqclf0F/GfrY1YaOfcex+
        VETnzjnEc25usXCw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 8CCACA3B87;
        Mon, 14 Jun 2021 09:51:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 668161F2B82; Mon, 14 Jun 2021 11:51:07 +0200 (CEST)
Date:   Mon, 14 Jun 2021 11:51:07 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm: require ->set_page_dirty to be explicitly wire up
Message-ID: <20210614095107.GD26615@quack2.suse.cz>
References: <20210614061512.3966143-1-hch@lst.de>
 <20210614061512.3966143-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614061512.3966143-4-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 14-06-21 08:15:12, Christoph Hellwig wrote:
> Remove the CONFIG_BLOCK default to __set_page_dirty_buffers and just
> wire that method up for the missing instances.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Make sense. Did you somehow autogenerate this? If this patch would race
with addition of new aops struct, we'd get null-ptr-defer out of that so
maybe providing the script would be better. But other than that the changes
look good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>


								Honza

> ---
>  fs/adfs/inode.c     |  1 +
>  fs/affs/file.c      |  2 ++
>  fs/bfs/file.c       |  1 +
>  fs/block_dev.c      |  1 +
>  fs/exfat/inode.c    |  1 +
>  fs/ext2/inode.c     |  2 ++
>  fs/fat/inode.c      |  1 +
>  fs/gfs2/meta_io.c   |  2 ++
>  fs/hfs/inode.c      |  2 ++
>  fs/hfsplus/inode.c  |  2 ++
>  fs/hpfs/file.c      |  1 +
>  fs/jfs/inode.c      |  1 +
>  fs/minix/inode.c    |  1 +
>  fs/nilfs2/mdt.c     |  1 +
>  fs/ocfs2/aops.c     |  1 +
>  fs/omfs/file.c      |  1 +
>  fs/sysv/itree.c     |  1 +
>  fs/udf/file.c       |  1 +
>  fs/udf/inode.c      |  1 +
>  fs/ufs/inode.c      |  1 +
>  mm/page-writeback.c | 18 ++++--------------
>  21 files changed, 29 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/adfs/inode.c b/fs/adfs/inode.c
> index fb7ee026d101..adbb3a1edcbf 100644
> --- a/fs/adfs/inode.c
> +++ b/fs/adfs/inode.c
> @@ -73,6 +73,7 @@ static sector_t _adfs_bmap(struct address_space *mapping, sector_t block)
>  }
>  
>  static const struct address_space_operations adfs_aops = {
> +	.set_page_dirty	= __set_page_dirty_buffers,
>  	.readpage	= adfs_readpage,
>  	.writepage	= adfs_writepage,
>  	.write_begin	= adfs_write_begin,
> diff --git a/fs/affs/file.c b/fs/affs/file.c
> index d91b0133d95d..75ebd2b576ca 100644
> --- a/fs/affs/file.c
> +++ b/fs/affs/file.c
> @@ -453,6 +453,7 @@ static sector_t _affs_bmap(struct address_space *mapping, sector_t block)
>  }
>  
>  const struct address_space_operations affs_aops = {
> +	.set_page_dirty	= __set_page_dirty_buffers,
>  	.readpage = affs_readpage,
>  	.writepage = affs_writepage,
>  	.write_begin = affs_write_begin,
> @@ -833,6 +834,7 @@ static int affs_write_end_ofs(struct file *file, struct address_space *mapping,
>  }
>  
>  const struct address_space_operations affs_aops_ofs = {
> +	.set_page_dirty	= __set_page_dirty_buffers,
>  	.readpage = affs_readpage_ofs,
>  	//.writepage = affs_writepage_ofs,
>  	.write_begin = affs_write_begin_ofs,
> diff --git a/fs/bfs/file.c b/fs/bfs/file.c
> index 0dceefc54b48..7f8544abf636 100644
> --- a/fs/bfs/file.c
> +++ b/fs/bfs/file.c
> @@ -188,6 +188,7 @@ static sector_t bfs_bmap(struct address_space *mapping, sector_t block)
>  }
>  
>  const struct address_space_operations bfs_aops = {
> +	.set_page_dirty	= __set_page_dirty_buffers,
>  	.readpage	= bfs_readpage,
>  	.writepage	= bfs_writepage,
>  	.write_begin	= bfs_write_begin,
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 6cc4d4cfe0c2..eb34f5c357cf 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -1754,6 +1754,7 @@ static int blkdev_writepages(struct address_space *mapping,
>  }
>  
>  static const struct address_space_operations def_blk_aops = {
> +	.set_page_dirty	= __set_page_dirty_buffers,
>  	.readpage	= blkdev_readpage,
>  	.readahead	= blkdev_readahead,
>  	.writepage	= blkdev_writepage,
> diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
> index 1803ef3220fd..ca37d4344361 100644
> --- a/fs/exfat/inode.c
> +++ b/fs/exfat/inode.c
> @@ -491,6 +491,7 @@ int exfat_block_truncate_page(struct inode *inode, loff_t from)
>  }
>  
>  static const struct address_space_operations exfat_aops = {
> +	.set_page_dirty	= __set_page_dirty_buffers,
>  	.readpage	= exfat_readpage,
>  	.readahead	= exfat_readahead,
>  	.writepage	= exfat_writepage,
> diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> index 68178b2234bd..bf41f579ed3e 100644
> --- a/fs/ext2/inode.c
> +++ b/fs/ext2/inode.c
> @@ -961,6 +961,7 @@ ext2_dax_writepages(struct address_space *mapping, struct writeback_control *wbc
>  }
>  
>  const struct address_space_operations ext2_aops = {
> +	.set_page_dirty		= __set_page_dirty_buffers,
>  	.readpage		= ext2_readpage,
>  	.readahead		= ext2_readahead,
>  	.writepage		= ext2_writepage,
> @@ -975,6 +976,7 @@ const struct address_space_operations ext2_aops = {
>  };
>  
>  const struct address_space_operations ext2_nobh_aops = {
> +	.set_page_dirty		= __set_page_dirty_buffers,
>  	.readpage		= ext2_readpage,
>  	.readahead		= ext2_readahead,
>  	.writepage		= ext2_nobh_writepage,
> diff --git a/fs/fat/inode.c b/fs/fat/inode.c
> index bab9b202b496..de0c9b013a85 100644
> --- a/fs/fat/inode.c
> +++ b/fs/fat/inode.c
> @@ -342,6 +342,7 @@ int fat_block_truncate_page(struct inode *inode, loff_t from)
>  }
>  
>  static const struct address_space_operations fat_aops = {
> +	.set_page_dirty	= __set_page_dirty_buffers,
>  	.readpage	= fat_readpage,
>  	.readahead	= fat_readahead,
>  	.writepage	= fat_writepage,
> diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
> index d68184ebbfdd..7c9619997355 100644
> --- a/fs/gfs2/meta_io.c
> +++ b/fs/gfs2/meta_io.c
> @@ -89,11 +89,13 @@ static int gfs2_aspace_writepage(struct page *page, struct writeback_control *wb
>  }
>  
>  const struct address_space_operations gfs2_meta_aops = {
> +	.set_page_dirty	= __set_page_dirty_buffers,
>  	.writepage = gfs2_aspace_writepage,
>  	.releasepage = gfs2_releasepage,
>  };
>  
>  const struct address_space_operations gfs2_rgrp_aops = {
> +	.set_page_dirty	= __set_page_dirty_buffers,
>  	.writepage = gfs2_aspace_writepage,
>  	.releasepage = gfs2_releasepage,
>  };
> diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
> index 3fc5cb346586..4a95a92546a0 100644
> --- a/fs/hfs/inode.c
> +++ b/fs/hfs/inode.c
> @@ -159,6 +159,7 @@ static int hfs_writepages(struct address_space *mapping,
>  }
>  
>  const struct address_space_operations hfs_btree_aops = {
> +	.set_page_dirty	= __set_page_dirty_buffers,
>  	.readpage	= hfs_readpage,
>  	.writepage	= hfs_writepage,
>  	.write_begin	= hfs_write_begin,
> @@ -168,6 +169,7 @@ const struct address_space_operations hfs_btree_aops = {
>  };
>  
>  const struct address_space_operations hfs_aops = {
> +	.set_page_dirty	= __set_page_dirty_buffers,
>  	.readpage	= hfs_readpage,
>  	.writepage	= hfs_writepage,
>  	.write_begin	= hfs_write_begin,
> diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
> index 8ea447e5c470..70e8374ddac4 100644
> --- a/fs/hfsplus/inode.c
> +++ b/fs/hfsplus/inode.c
> @@ -156,6 +156,7 @@ static int hfsplus_writepages(struct address_space *mapping,
>  }
>  
>  const struct address_space_operations hfsplus_btree_aops = {
> +	.set_page_dirty	= __set_page_dirty_buffers,
>  	.readpage	= hfsplus_readpage,
>  	.writepage	= hfsplus_writepage,
>  	.write_begin	= hfsplus_write_begin,
> @@ -165,6 +166,7 @@ const struct address_space_operations hfsplus_btree_aops = {
>  };
>  
>  const struct address_space_operations hfsplus_aops = {
> +	.set_page_dirty	= __set_page_dirty_buffers,
>  	.readpage	= hfsplus_readpage,
>  	.writepage	= hfsplus_writepage,
>  	.write_begin	= hfsplus_write_begin,
> diff --git a/fs/hpfs/file.c b/fs/hpfs/file.c
> index 077c25128eb7..c3a49aacf20a 100644
> --- a/fs/hpfs/file.c
> +++ b/fs/hpfs/file.c
> @@ -196,6 +196,7 @@ static int hpfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  }
>  
>  const struct address_space_operations hpfs_aops = {
> +	.set_page_dirty	= __set_page_dirty_buffers,
>  	.readpage = hpfs_readpage,
>  	.writepage = hpfs_writepage,
>  	.readahead = hpfs_readahead,
> diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
> index 6f65bfa9f18d..3663dd5a23bc 100644
> --- a/fs/jfs/inode.c
> +++ b/fs/jfs/inode.c
> @@ -356,6 +356,7 @@ static ssize_t jfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>  }
>  
>  const struct address_space_operations jfs_aops = {
> +	.set_page_dirty	= __set_page_dirty_buffers,
>  	.readpage	= jfs_readpage,
>  	.readahead	= jfs_readahead,
>  	.writepage	= jfs_writepage,
> diff --git a/fs/minix/inode.c b/fs/minix/inode.c
> index a532a99bbe81..a71f1cf894b9 100644
> --- a/fs/minix/inode.c
> +++ b/fs/minix/inode.c
> @@ -442,6 +442,7 @@ static sector_t minix_bmap(struct address_space *mapping, sector_t block)
>  }
>  
>  static const struct address_space_operations minix_aops = {
> +	.set_page_dirty	= __set_page_dirty_buffers,
>  	.readpage = minix_readpage,
>  	.writepage = minix_writepage,
>  	.write_begin = minix_write_begin,
> diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
> index c0361ce45f62..97769fe4d588 100644
> --- a/fs/nilfs2/mdt.c
> +++ b/fs/nilfs2/mdt.c
> @@ -434,6 +434,7 @@ nilfs_mdt_write_page(struct page *page, struct writeback_control *wbc)
>  
>  
>  static const struct address_space_operations def_mdt_aops = {
> +	.set_page_dirty		= __set_page_dirty_buffers,
>  	.writepage		= nilfs_mdt_write_page,
>  };
>  
> diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
> index 1294925ac94a..b3517de178ff 100644
> --- a/fs/ocfs2/aops.c
> +++ b/fs/ocfs2/aops.c
> @@ -2454,6 +2454,7 @@ static ssize_t ocfs2_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>  }
>  
>  const struct address_space_operations ocfs2_aops = {
> +	.set_page_dirty		= __set_page_dirty_buffers,
>  	.readpage		= ocfs2_readpage,
>  	.readahead		= ocfs2_readahead,
>  	.writepage		= ocfs2_writepage,
> diff --git a/fs/omfs/file.c b/fs/omfs/file.c
> index 11e733aab25d..89725b15a64b 100644
> --- a/fs/omfs/file.c
> +++ b/fs/omfs/file.c
> @@ -372,6 +372,7 @@ const struct inode_operations omfs_file_inops = {
>  };
>  
>  const struct address_space_operations omfs_aops = {
> +	.set_page_dirty = __set_page_dirty_buffers,
>  	.readpage = omfs_readpage,
>  	.readahead = omfs_readahead,
>  	.writepage = omfs_writepage,
> diff --git a/fs/sysv/itree.c b/fs/sysv/itree.c
> index 8b2e99b7bc9f..749385015a8d 100644
> --- a/fs/sysv/itree.c
> +++ b/fs/sysv/itree.c
> @@ -495,6 +495,7 @@ static sector_t sysv_bmap(struct address_space *mapping, sector_t block)
>  }
>  
>  const struct address_space_operations sysv_aops = {
> +	.set_page_dirty = __set_page_dirty_buffers,
>  	.readpage = sysv_readpage,
>  	.writepage = sysv_writepage,
>  	.write_begin = sysv_write_begin,
> diff --git a/fs/udf/file.c b/fs/udf/file.c
> index 2846dcd92197..1baff8ddb754 100644
> --- a/fs/udf/file.c
> +++ b/fs/udf/file.c
> @@ -125,6 +125,7 @@ static int udf_adinicb_write_end(struct file *file, struct address_space *mappin
>  }
>  
>  const struct address_space_operations udf_adinicb_aops = {
> +	.set_page_dirty	= __set_page_dirty_buffers,
>  	.readpage	= udf_adinicb_readpage,
>  	.writepage	= udf_adinicb_writepage,
>  	.write_begin	= udf_adinicb_write_begin,
> diff --git a/fs/udf/inode.c b/fs/udf/inode.c
> index 0dd2f93ac048..4917670860a0 100644
> --- a/fs/udf/inode.c
> +++ b/fs/udf/inode.c
> @@ -235,6 +235,7 @@ static sector_t udf_bmap(struct address_space *mapping, sector_t block)
>  }
>  
>  const struct address_space_operations udf_aops = {
> +	.set_page_dirty	= __set_page_dirty_buffers,
>  	.readpage	= udf_readpage,
>  	.readahead	= udf_readahead,
>  	.writepage	= udf_writepage,
> diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
> index debc282c1bb4..ac628de69601 100644
> --- a/fs/ufs/inode.c
> +++ b/fs/ufs/inode.c
> @@ -526,6 +526,7 @@ static sector_t ufs_bmap(struct address_space *mapping, sector_t block)
>  }
>  
>  const struct address_space_operations ufs_aops = {
> +	.set_page_dirty = __set_page_dirty_buffers,
>  	.readpage = ufs_readpage,
>  	.writepage = ufs_writepage,
>  	.write_begin = ufs_write_begin,
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 0062d5c57d41..081fa02236c2 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -32,7 +32,6 @@
>  #include <linux/sysctl.h>
>  #include <linux/cpu.h>
>  #include <linux/syscalls.h>
> -#include <linux/buffer_head.h> /* __set_page_dirty_buffers */
>  #include <linux/pagevec.h>
>  #include <linux/timer.h>
>  #include <linux/sched/rt.h>
> @@ -2546,13 +2545,9 @@ EXPORT_SYMBOL(redirty_page_for_writepage);
>  /*
>   * Dirty a page.
>   *
> - * For pages with a mapping this should be done under the page lock
> - * for the benefit of asynchronous memory errors who prefer a consistent
> - * dirty state. This rule can be broken in some special cases,
> - * but should be better not to.
> - *
> - * If the mapping doesn't provide a set_page_dirty a_op, then
> - * just fall through and assume that it wants buffer_heads.
> + * For pages with a mapping this should be done under the page lock for the
> + * benefit of asynchronous memory errors who prefer a consistent dirty state.
> + * This rule can be broken in some special cases, but should be better not to.
>   */
>  int set_page_dirty(struct page *page)
>  {
> @@ -2560,7 +2555,6 @@ int set_page_dirty(struct page *page)
>  
>  	page = compound_head(page);
>  	if (likely(mapping)) {
> -		int (*spd)(struct page *) = mapping->a_ops->set_page_dirty;
>  		/*
>  		 * readahead/lru_deactivate_page could remain
>  		 * PG_readahead/PG_reclaim due to race with end_page_writeback
> @@ -2573,11 +2567,7 @@ int set_page_dirty(struct page *page)
>  		 */
>  		if (PageReclaim(page))
>  			ClearPageReclaim(page);
> -#ifdef CONFIG_BLOCK
> -		if (!spd)
> -			spd = __set_page_dirty_buffers;
> -#endif
> -		return (*spd)(page);
> +		return mapping->a_ops->set_page_dirty(page);
>  	}
>  	if (!PageDirty(page)) {
>  		if (!TestSetPageDirty(page))
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
