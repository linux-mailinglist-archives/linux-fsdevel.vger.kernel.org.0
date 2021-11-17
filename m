Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD0C453FA7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Nov 2021 05:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbhKQEjS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 23:39:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:42926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231650AbhKQEjS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 23:39:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E4DC61057;
        Wed, 17 Nov 2021 04:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637123780;
        bh=E1RMQyQ1o278jtKYWl02xaL/o/kpGIsOvWkEkyEhar0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cqEexBgInBaGptBCHf607kGYoapKMJD3H0ONHzuyKdXOyWcyOfmY3UkeFMzQCjNlu
         VFW0oVtSzxVC/gvN8924aUiNHOuzk1AgmiJ21C9pTdl/7nnQjwUu/jH2zAxmDORdCC
         gPhsxqscFrhtBaJxfKjlymSlyV5xNG5V62tqbcKhs9AMSgbTgJhf19hCe2bzpJYTvy
         XWPEmKkS2A78mHsX66CBI4Vrg8FCQNW3JT/nzlWioI9zF5eaGIuXdNUDQiIcJJ9r4J
         pMvaQg+hkW0eZvEmUFdpOnRDb0MyautszWgKIW12aTqlbvKUwg9Bts3PTkQRU+OGA0
         rTuC5PmqDXkVw==
Date:   Tue, 16 Nov 2021 20:36:19 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 03/28] fs: Remove FS_THP_SUPPORT
Message-ID: <20211117043619.GN24307@magnolia>
References: <20211108040551.1942823-1-willy@infradead.org>
 <20211108040551.1942823-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108040551.1942823-4-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 08, 2021 at 04:05:26AM +0000, Matthew Wilcox (Oracle) wrote:
> Instead of setting a bit in the fs_flags to set a bit in the
> address_space, set the bit in the address_space directly.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Makes sense,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/inode.c              |  2 --
>  include/linux/fs.h      |  1 -
>  include/linux/pagemap.h | 16 ++++++++++++++++
>  mm/shmem.c              |  3 ++-
>  4 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 9abc88d7959c..d6386b6d5a6e 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -180,8 +180,6 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
>  	mapping->a_ops = &empty_aops;
>  	mapping->host = inode;
>  	mapping->flags = 0;
> -	if (sb->s_type->fs_flags & FS_THP_SUPPORT)
> -		__set_bit(AS_THP_SUPPORT, &mapping->flags);
>  	mapping->wb_err = 0;
>  	atomic_set(&mapping->i_mmap_writable, 0);
>  #ifdef CONFIG_READ_ONLY_THP_FOR_FS
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 4137a9bfae7a..3c2fcabf9d12 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2518,7 +2518,6 @@ struct file_system_type {
>  #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
>  #define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
>  #define FS_ALLOW_IDMAP         32      /* FS has been updated to handle vfs idmappings. */
> -#define FS_THP_SUPPORT		8192	/* Remove once all fs converted */
>  #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
>  	int (*init_fs_context)(struct fs_context *);
>  	const struct fs_parameter_spec *parameters;
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index db2c3e3eb1cf..471f0c422831 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -126,6 +126,22 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
>  	m->gfp_mask = mask;
>  }
>  
> +/**
> + * mapping_set_large_folios() - Indicate the file supports multi-page folios.
> + * @mapping: The file.
> + *
> + * The filesystem should call this function in its inode constructor to
> + * indicate that the VFS can use multi-page folios to cache the contents
> + * of the file.
> + *
> + * Context: This should not be called while the inode is active as it
> + * is non-atomic.
> + */
> +static inline void mapping_set_large_folios(struct address_space *mapping)
> +{
> +	__set_bit(AS_THP_SUPPORT, &mapping->flags);
> +}
> +
>  static inline bool mapping_thp_support(struct address_space *mapping)
>  {
>  	return test_bit(AS_THP_SUPPORT, &mapping->flags);
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 23c91a8beb78..54422933fa2d 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2303,6 +2303,7 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
>  		INIT_LIST_HEAD(&info->swaplist);
>  		simple_xattrs_init(&info->xattrs);
>  		cache_no_acl(inode);
> +		mapping_set_large_folios(inode->i_mapping);
>  
>  		switch (mode & S_IFMT) {
>  		default:
> @@ -3920,7 +3921,7 @@ static struct file_system_type shmem_fs_type = {
>  	.parameters	= shmem_fs_parameters,
>  #endif
>  	.kill_sb	= kill_litter_super,
> -	.fs_flags	= FS_USERNS_MOUNT | FS_THP_SUPPORT,
> +	.fs_flags	= FS_USERNS_MOUNT,
>  };
>  
>  int __init shmem_init(void)
> -- 
> 2.33.0
> 
