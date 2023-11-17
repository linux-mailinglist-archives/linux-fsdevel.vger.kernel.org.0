Return-Path: <linux-fsdevel+bounces-3107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE2A7EFB23
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 23:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9127B20B3A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 22:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FFF433A9;
	Fri, 17 Nov 2023 22:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3AiHvLl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B09D2F1
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 22:04:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDFE0C433C8;
	Fri, 17 Nov 2023 22:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700258678;
	bh=0+Ed/CCyvVXVovIv6ls9AP/OYPO5BVF8CYFib2Hb1cE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D3AiHvLl2g6o48qtJ710hpIRVNNKUMlJPz/RVo4zRJbi5CFxe2sOtsHMLMRe6Kdc5
	 KiHcrlCHD/iLWfB5j2PzN96IdGq2ap3ZhDIH3O3I4/Uxdr+hry0lv/fLM6qHXU8uCA
	 uY5UeiFXVRyjvCCYRXqJj8IgawqTs/OuNeYMLv35myINPt63bUhH8f8IRDF53hdLy6
	 OiG2yE8AkN7wSodsGwMOookny3P0wCswaAk7RV9su1FMleZX7OG2ogEYlfW296bzLc
	 UVPda3gk71QTXycOciONbA6ygclnZyoUVRJmowA4Qp+fYlmCLVm0zqH/yMBIvqHTHn
	 mDIWA+KRQjalw==
Date: Fri, 17 Nov 2023 14:04:37 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: Rename mapping private members
Message-ID: <20231117220437.GF36211@frogsfrogsfrogs>
References: <20231117215823.2821906-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117215823.2821906-1-willy@infradead.org>

On Fri, Nov 17, 2023 at 09:58:23PM +0000, Matthew Wilcox (Oracle) wrote:
> It is hard to find where mapping->private_lock, mapping->private_list and
> mapping->private_data are used, due to private_XXX being a relatively
> common name for variables and structure members in the kernel.  To fit
> with other members of struct address_space, rename them all to have an
> i_ prefix.  Tested with an allmodconfig build.

/me wonders if the prefix ought to be "as_" for address space instead of
inode.  Even though inode begat address_space, they're not the same
anymore.

--D

> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/aio.c               |  16 +++---
>  fs/btrfs/extent_io.c   |  52 ++++++++++----------
>  fs/btrfs/subpage.c     |   4 +-
>  fs/buffer.c            | 108 ++++++++++++++++++++---------------------
>  fs/ext4/inode.c        |   4 +-
>  fs/gfs2/glock.c        |   2 +-
>  fs/gfs2/ops_fstype.c   |   2 +-
>  fs/hugetlbfs/inode.c   |   4 +-
>  fs/inode.c             |   8 +--
>  fs/nfs/write.c         |  12 ++---
>  fs/nilfs2/inode.c      |   4 +-
>  fs/ntfs/aops.c         |  10 ++--
>  include/linux/fs.h     |  12 ++---
>  mm/hugetlb.c           |   2 +-
>  mm/migrate.c           |   6 +--
>  virt/kvm/guest_memfd.c |   6 +--
>  16 files changed, 126 insertions(+), 126 deletions(-)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index f8589caef9c1..d02842156b35 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -266,7 +266,7 @@ static struct file *aio_private_file(struct kioctx *ctx, loff_t nr_pages)
>  		return ERR_CAST(inode);
>  
>  	inode->i_mapping->a_ops = &aio_ctx_aops;
> -	inode->i_mapping->private_data = ctx;
> +	inode->i_mapping->i_private_data = ctx;
>  	inode->i_size = PAGE_SIZE * nr_pages;
>  
>  	file = alloc_file_pseudo(inode, aio_mnt, "[aio]",
> @@ -316,10 +316,10 @@ static void put_aio_ring_file(struct kioctx *ctx)
>  
>  		/* Prevent further access to the kioctx from migratepages */
>  		i_mapping = aio_ring_file->f_mapping;
> -		spin_lock(&i_mapping->private_lock);
> -		i_mapping->private_data = NULL;
> +		spin_lock(&i_mapping->i_private_lock);
> +		i_mapping->i_private_data = NULL;
>  		ctx->aio_ring_file = NULL;
> -		spin_unlock(&i_mapping->private_lock);
> +		spin_unlock(&i_mapping->i_private_lock);
>  
>  		fput(aio_ring_file);
>  	}
> @@ -422,9 +422,9 @@ static int aio_migrate_folio(struct address_space *mapping, struct folio *dst,
>  
>  	rc = 0;
>  
> -	/* mapping->private_lock here protects against the kioctx teardown.  */
> -	spin_lock(&mapping->private_lock);
> -	ctx = mapping->private_data;
> +	/* mapping->i_private_lock here protects against the kioctx teardown.  */
> +	spin_lock(&mapping->i_private_lock);
> +	ctx = mapping->i_private_data;
>  	if (!ctx) {
>  		rc = -EINVAL;
>  		goto out;
> @@ -476,7 +476,7 @@ static int aio_migrate_folio(struct address_space *mapping, struct folio *dst,
>  out_unlock:
>  	mutex_unlock(&ctx->ring_lock);
>  out:
> -	spin_unlock(&mapping->private_lock);
> +	spin_unlock(&mapping->i_private_lock);
>  	return rc;
>  }
>  #else
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 03cef28d9e37..3431a53bf3fd 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -870,7 +870,7 @@ static int attach_extent_buffer_page(struct extent_buffer *eb,
>  	 * will not race with any other ebs.
>  	 */
>  	if (page->mapping)
> -		lockdep_assert_held(&page->mapping->private_lock);
> +		lockdep_assert_held(&page->mapping->i_private_lock);
>  
>  	if (fs_info->nodesize >= PAGE_SIZE) {
>  		if (!PagePrivate(page))
> @@ -1736,16 +1736,16 @@ static int submit_eb_subpage(struct page *page, struct writeback_control *wbc)
>  		 * Take private lock to ensure the subpage won't be detached
>  		 * in the meantime.
>  		 */
> -		spin_lock(&page->mapping->private_lock);
> +		spin_lock(&page->mapping->i_private_lock);
>  		if (!PagePrivate(page)) {
> -			spin_unlock(&page->mapping->private_lock);
> +			spin_unlock(&page->mapping->i_private_lock);
>  			break;
>  		}
>  		spin_lock_irqsave(&subpage->lock, flags);
>  		if (!test_bit(bit_start + fs_info->subpage_info->dirty_offset,
>  			      subpage->bitmaps)) {
>  			spin_unlock_irqrestore(&subpage->lock, flags);
> -			spin_unlock(&page->mapping->private_lock);
> +			spin_unlock(&page->mapping->i_private_lock);
>  			bit_start++;
>  			continue;
>  		}
> @@ -1759,7 +1759,7 @@ static int submit_eb_subpage(struct page *page, struct writeback_control *wbc)
>  		 */
>  		eb = find_extent_buffer_nolock(fs_info, start);
>  		spin_unlock_irqrestore(&subpage->lock, flags);
> -		spin_unlock(&page->mapping->private_lock);
> +		spin_unlock(&page->mapping->i_private_lock);
>  
>  		/*
>  		 * The eb has already reached 0 refs thus find_extent_buffer()
> @@ -1811,9 +1811,9 @@ static int submit_eb_page(struct page *page, struct btrfs_eb_write_context *ctx)
>  	if (btrfs_sb(page->mapping->host->i_sb)->nodesize < PAGE_SIZE)
>  		return submit_eb_subpage(page, wbc);
>  
> -	spin_lock(&mapping->private_lock);
> +	spin_lock(&mapping->i_private_lock);
>  	if (!PagePrivate(page)) {
> -		spin_unlock(&mapping->private_lock);
> +		spin_unlock(&mapping->i_private_lock);
>  		return 0;
>  	}
>  
> @@ -1824,16 +1824,16 @@ static int submit_eb_page(struct page *page, struct btrfs_eb_write_context *ctx)
>  	 * crashing the machine for something we can survive anyway.
>  	 */
>  	if (WARN_ON(!eb)) {
> -		spin_unlock(&mapping->private_lock);
> +		spin_unlock(&mapping->i_private_lock);
>  		return 0;
>  	}
>  
>  	if (eb == ctx->eb) {
> -		spin_unlock(&mapping->private_lock);
> +		spin_unlock(&mapping->i_private_lock);
>  		return 0;
>  	}
>  	ret = atomic_inc_not_zero(&eb->refs);
> -	spin_unlock(&mapping->private_lock);
> +	spin_unlock(&mapping->i_private_lock);
>  	if (!ret)
>  		return 0;
>  
> @@ -3056,7 +3056,7 @@ static bool page_range_has_eb(struct btrfs_fs_info *fs_info, struct page *page)
>  {
>  	struct btrfs_subpage *subpage;
>  
> -	lockdep_assert_held(&page->mapping->private_lock);
> +	lockdep_assert_held(&page->mapping->i_private_lock);
>  
>  	if (PagePrivate(page)) {
>  		subpage = (struct btrfs_subpage *)page->private;
> @@ -3079,14 +3079,14 @@ static void detach_extent_buffer_page(struct extent_buffer *eb, struct page *pag
>  
>  	/*
>  	 * For mapped eb, we're going to change the page private, which should
> -	 * be done under the private_lock.
> +	 * be done under the i_private_lock.
>  	 */
>  	if (mapped)
> -		spin_lock(&page->mapping->private_lock);
> +		spin_lock(&page->mapping->i_private_lock);
>  
>  	if (!PagePrivate(page)) {
>  		if (mapped)
> -			spin_unlock(&page->mapping->private_lock);
> +			spin_unlock(&page->mapping->i_private_lock);
>  		return;
>  	}
>  
> @@ -3110,7 +3110,7 @@ static void detach_extent_buffer_page(struct extent_buffer *eb, struct page *pag
>  			detach_page_private(page);
>  		}
>  		if (mapped)
> -			spin_unlock(&page->mapping->private_lock);
> +			spin_unlock(&page->mapping->i_private_lock);
>  		return;
>  	}
>  
> @@ -3133,7 +3133,7 @@ static void detach_extent_buffer_page(struct extent_buffer *eb, struct page *pag
>  	if (!page_range_has_eb(fs_info, page))
>  		btrfs_detach_subpage(fs_info, page);
>  
> -	spin_unlock(&page->mapping->private_lock);
> +	spin_unlock(&page->mapping->i_private_lock);
>  }
>  
>  /* Release all pages attached to the extent buffer */
> @@ -3514,7 +3514,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
>  
>  	/*
>  	 * Preallocate page->private for subpage case, so that we won't
> -	 * allocate memory with private_lock nor page lock hold.
> +	 * allocate memory with i_private_lock nor page lock hold.
>  	 *
>  	 * The memory will be freed by attach_extent_buffer_page() or freed
>  	 * manually if we exit earlier.
> @@ -3535,10 +3535,10 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
>  			goto free_eb;
>  		}
>  
> -		spin_lock(&mapping->private_lock);
> +		spin_lock(&mapping->i_private_lock);
>  		exists = grab_extent_buffer(fs_info, p);
>  		if (exists) {
> -			spin_unlock(&mapping->private_lock);
> +			spin_unlock(&mapping->i_private_lock);
>  			unlock_page(p);
>  			put_page(p);
>  			mark_extent_buffer_accessed(exists, p);
> @@ -3558,7 +3558,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
>  		 * Thus needs no special handling in error path.
>  		 */
>  		btrfs_page_inc_eb_refs(fs_info, p);
> -		spin_unlock(&mapping->private_lock);
> +		spin_unlock(&mapping->i_private_lock);
>  
>  		WARN_ON(btrfs_page_test_dirty(fs_info, p, eb->start, eb->len));
>  		eb->pages[i] = p;
> @@ -4563,12 +4563,12 @@ static int try_release_subpage_extent_buffer(struct page *page)
>  	 * Finally to check if we have cleared page private, as if we have
>  	 * released all ebs in the page, the page private should be cleared now.
>  	 */
> -	spin_lock(&page->mapping->private_lock);
> +	spin_lock(&page->mapping->i_private_lock);
>  	if (!PagePrivate(page))
>  		ret = 1;
>  	else
>  		ret = 0;
> -	spin_unlock(&page->mapping->private_lock);
> +	spin_unlock(&page->mapping->i_private_lock);
>  	return ret;
>  
>  }
> @@ -4584,9 +4584,9 @@ int try_release_extent_buffer(struct page *page)
>  	 * We need to make sure nobody is changing page->private, as we rely on
>  	 * page->private as the pointer to extent buffer.
>  	 */
> -	spin_lock(&page->mapping->private_lock);
> +	spin_lock(&page->mapping->i_private_lock);
>  	if (!PagePrivate(page)) {
> -		spin_unlock(&page->mapping->private_lock);
> +		spin_unlock(&page->mapping->i_private_lock);
>  		return 1;
>  	}
>  
> @@ -4601,10 +4601,10 @@ int try_release_extent_buffer(struct page *page)
>  	spin_lock(&eb->refs_lock);
>  	if (atomic_read(&eb->refs) != 1 || extent_buffer_under_io(eb)) {
>  		spin_unlock(&eb->refs_lock);
> -		spin_unlock(&page->mapping->private_lock);
> +		spin_unlock(&page->mapping->i_private_lock);
>  		return 0;
>  	}
> -	spin_unlock(&page->mapping->private_lock);
> +	spin_unlock(&page->mapping->i_private_lock);
>  
>  	/*
>  	 * If tree ref isn't set then we know the ref on this eb is a real ref,
> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
> index 1b999c6e4193..2347cf15278b 100644
> --- a/fs/btrfs/subpage.c
> +++ b/fs/btrfs/subpage.c
> @@ -200,7 +200,7 @@ void btrfs_page_inc_eb_refs(const struct btrfs_fs_info *fs_info,
>  		return;
>  
>  	ASSERT(PagePrivate(page) && page->mapping);
> -	lockdep_assert_held(&page->mapping->private_lock);
> +	lockdep_assert_held(&page->mapping->i_private_lock);
>  
>  	subpage = (struct btrfs_subpage *)page->private;
>  	atomic_inc(&subpage->eb_refs);
> @@ -215,7 +215,7 @@ void btrfs_page_dec_eb_refs(const struct btrfs_fs_info *fs_info,
>  		return;
>  
>  	ASSERT(PagePrivate(page) && page->mapping);
> -	lockdep_assert_held(&page->mapping->private_lock);
> +	lockdep_assert_held(&page->mapping->i_private_lock);
>  
>  	subpage = (struct btrfs_subpage *)page->private;
>  	ASSERT(atomic_read(&subpage->eb_refs));
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 4eb44ccdc6be..f653add0aed5 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -180,11 +180,11 @@ EXPORT_SYMBOL(end_buffer_write_sync);
>   * Various filesystems appear to want __find_get_block to be non-blocking.
>   * But it's the page lock which protects the buffers.  To get around this,
>   * we get exclusion from try_to_free_buffers with the blockdev mapping's
> - * private_lock.
> + * i_private_lock.
>   *
> - * Hack idea: for the blockdev mapping, private_lock contention
> + * Hack idea: for the blockdev mapping, i_private_lock contention
>   * may be quite high.  This code could TryLock the page, and if that
> - * succeeds, there is no need to take private_lock.
> + * succeeds, there is no need to take i_private_lock.
>   */
>  static struct buffer_head *
>  __find_get_block_slow(struct block_device *bdev, sector_t block)
> @@ -204,7 +204,7 @@ __find_get_block_slow(struct block_device *bdev, sector_t block)
>  	if (IS_ERR(folio))
>  		goto out;
>  
> -	spin_lock(&bd_mapping->private_lock);
> +	spin_lock(&bd_mapping->i_private_lock);
>  	head = folio_buffers(folio);
>  	if (!head)
>  		goto out_unlock;
> @@ -236,7 +236,7 @@ __find_get_block_slow(struct block_device *bdev, sector_t block)
>  		       1 << bd_inode->i_blkbits);
>  	}
>  out_unlock:
> -	spin_unlock(&bd_mapping->private_lock);
> +	spin_unlock(&bd_mapping->i_private_lock);
>  	folio_put(folio);
>  out:
>  	return ret;
> @@ -467,25 +467,25 @@ EXPORT_SYMBOL(mark_buffer_async_write);
>   *
>   * The functions mark_buffer_inode_dirty(), fsync_inode_buffers(),
>   * inode_has_buffers() and invalidate_inode_buffers() are provided for the
> - * management of a list of dependent buffers at ->i_mapping->private_list.
> + * management of a list of dependent buffers at ->i_mapping->i_private_list.
>   *
>   * Locking is a little subtle: try_to_free_buffers() will remove buffers
>   * from their controlling inode's queue when they are being freed.  But
>   * try_to_free_buffers() will be operating against the *blockdev* mapping
>   * at the time, not against the S_ISREG file which depends on those buffers.
> - * So the locking for private_list is via the private_lock in the address_space
> + * So the locking for i_private_list is via the i_private_lock in the address_space
>   * which backs the buffers.  Which is different from the address_space 
>   * against which the buffers are listed.  So for a particular address_space,
> - * mapping->private_lock does *not* protect mapping->private_list!  In fact,
> - * mapping->private_list will always be protected by the backing blockdev's
> - * ->private_lock.
> + * mapping->i_private_lock does *not* protect mapping->i_private_list!  In fact,
> + * mapping->i_private_list will always be protected by the backing blockdev's
> + * ->i_private_lock.
>   *
>   * Which introduces a requirement: all buffers on an address_space's
> - * ->private_list must be from the same address_space: the blockdev's.
> + * ->i_private_list must be from the same address_space: the blockdev's.
>   *
> - * address_spaces which do not place buffers at ->private_list via these
> - * utility functions are free to use private_lock and private_list for
> - * whatever they want.  The only requirement is that list_empty(private_list)
> + * address_spaces which do not place buffers at ->i_private_list via these
> + * utility functions are free to use i_private_lock and i_private_list for
> + * whatever they want.  The only requirement is that list_empty(i_private_list)
>   * be true at clear_inode() time.
>   *
>   * FIXME: clear_inode should not call invalidate_inode_buffers().  The
> @@ -508,7 +508,7 @@ EXPORT_SYMBOL(mark_buffer_async_write);
>   */
>  
>  /*
> - * The buffer's backing address_space's private_lock must be held
> + * The buffer's backing address_space's i_private_lock must be held
>   */
>  static void __remove_assoc_queue(struct buffer_head *bh)
>  {
> @@ -519,7 +519,7 @@ static void __remove_assoc_queue(struct buffer_head *bh)
>  
>  int inode_has_buffers(struct inode *inode)
>  {
> -	return !list_empty(&inode->i_data.private_list);
> +	return !list_empty(&inode->i_data.i_private_list);
>  }
>  
>  /*
> @@ -561,7 +561,7 @@ static int osync_buffers_list(spinlock_t *lock, struct list_head *list)
>   * sync_mapping_buffers - write out & wait upon a mapping's "associated" buffers
>   * @mapping: the mapping which wants those buffers written
>   *
> - * Starts I/O against the buffers at mapping->private_list, and waits upon
> + * Starts I/O against the buffers at mapping->i_private_list, and waits upon
>   * that I/O.
>   *
>   * Basically, this is a convenience function for fsync().
> @@ -570,13 +570,13 @@ static int osync_buffers_list(spinlock_t *lock, struct list_head *list)
>   */
>  int sync_mapping_buffers(struct address_space *mapping)
>  {
> -	struct address_space *buffer_mapping = mapping->private_data;
> +	struct address_space *buffer_mapping = mapping->i_private_data;
>  
> -	if (buffer_mapping == NULL || list_empty(&mapping->private_list))
> +	if (buffer_mapping == NULL || list_empty(&mapping->i_private_list))
>  		return 0;
>  
> -	return fsync_buffers_list(&buffer_mapping->private_lock,
> -					&mapping->private_list);
> +	return fsync_buffers_list(&buffer_mapping->i_private_lock,
> +					&mapping->i_private_list);
>  }
>  EXPORT_SYMBOL(sync_mapping_buffers);
>  
> @@ -673,17 +673,17 @@ void mark_buffer_dirty_inode(struct buffer_head *bh, struct inode *inode)
>  	struct address_space *buffer_mapping = bh->b_folio->mapping;
>  
>  	mark_buffer_dirty(bh);
> -	if (!mapping->private_data) {
> -		mapping->private_data = buffer_mapping;
> +	if (!mapping->i_private_data) {
> +		mapping->i_private_data = buffer_mapping;
>  	} else {
> -		BUG_ON(mapping->private_data != buffer_mapping);
> +		BUG_ON(mapping->i_private_data != buffer_mapping);
>  	}
>  	if (!bh->b_assoc_map) {
> -		spin_lock(&buffer_mapping->private_lock);
> +		spin_lock(&buffer_mapping->i_private_lock);
>  		list_move_tail(&bh->b_assoc_buffers,
> -				&mapping->private_list);
> +				&mapping->i_private_list);
>  		bh->b_assoc_map = mapping;
> -		spin_unlock(&buffer_mapping->private_lock);
> +		spin_unlock(&buffer_mapping->i_private_lock);
>  	}
>  }
>  EXPORT_SYMBOL(mark_buffer_dirty_inode);
> @@ -706,7 +706,7 @@ EXPORT_SYMBOL(mark_buffer_dirty_inode);
>   * bit, see a bunch of clean buffers and we'd end up with dirty buffers/clean
>   * page on the dirty page list.
>   *
> - * We use private_lock to lock against try_to_free_buffers while using the
> + * We use i_private_lock to lock against try_to_free_buffers while using the
>   * page's buffer list.  Also use this to protect against clean buffers being
>   * added to the page after it was set dirty.
>   *
> @@ -718,7 +718,7 @@ bool block_dirty_folio(struct address_space *mapping, struct folio *folio)
>  	struct buffer_head *head;
>  	bool newly_dirty;
>  
> -	spin_lock(&mapping->private_lock);
> +	spin_lock(&mapping->i_private_lock);
>  	head = folio_buffers(folio);
>  	if (head) {
>  		struct buffer_head *bh = head;
> @@ -734,7 +734,7 @@ bool block_dirty_folio(struct address_space *mapping, struct folio *folio)
>  	 */
>  	folio_memcg_lock(folio);
>  	newly_dirty = !folio_test_set_dirty(folio);
> -	spin_unlock(&mapping->private_lock);
> +	spin_unlock(&mapping->i_private_lock);
>  
>  	if (newly_dirty)
>  		__folio_mark_dirty(folio, mapping, 1);
> @@ -827,7 +827,7 @@ static int fsync_buffers_list(spinlock_t *lock, struct list_head *list)
>  		smp_mb();
>  		if (buffer_dirty(bh)) {
>  			list_add(&bh->b_assoc_buffers,
> -				 &mapping->private_list);
> +				 &mapping->i_private_list);
>  			bh->b_assoc_map = mapping;
>  		}
>  		spin_unlock(lock);
> @@ -851,7 +851,7 @@ static int fsync_buffers_list(spinlock_t *lock, struct list_head *list)
>   * probably unmounting the fs, but that doesn't mean we have already
>   * done a sync().  Just drop the buffers from the inode list.
>   *
> - * NOTE: we take the inode's blockdev's mapping's private_lock.  Which
> + * NOTE: we take the inode's blockdev's mapping's i_private_lock.  Which
>   * assumes that all the buffers are against the blockdev.  Not true
>   * for reiserfs.
>   */
> @@ -859,13 +859,13 @@ void invalidate_inode_buffers(struct inode *inode)
>  {
>  	if (inode_has_buffers(inode)) {
>  		struct address_space *mapping = &inode->i_data;
> -		struct list_head *list = &mapping->private_list;
> -		struct address_space *buffer_mapping = mapping->private_data;
> +		struct list_head *list = &mapping->i_private_list;
> +		struct address_space *buffer_mapping = mapping->i_private_data;
>  
> -		spin_lock(&buffer_mapping->private_lock);
> +		spin_lock(&buffer_mapping->i_private_lock);
>  		while (!list_empty(list))
>  			__remove_assoc_queue(BH_ENTRY(list->next));
> -		spin_unlock(&buffer_mapping->private_lock);
> +		spin_unlock(&buffer_mapping->i_private_lock);
>  	}
>  }
>  EXPORT_SYMBOL(invalidate_inode_buffers);
> @@ -882,10 +882,10 @@ int remove_inode_buffers(struct inode *inode)
>  
>  	if (inode_has_buffers(inode)) {
>  		struct address_space *mapping = &inode->i_data;
> -		struct list_head *list = &mapping->private_list;
> -		struct address_space *buffer_mapping = mapping->private_data;
> +		struct list_head *list = &mapping->i_private_list;
> +		struct address_space *buffer_mapping = mapping->i_private_data;
>  
> -		spin_lock(&buffer_mapping->private_lock);
> +		spin_lock(&buffer_mapping->i_private_lock);
>  		while (!list_empty(list)) {
>  			struct buffer_head *bh = BH_ENTRY(list->next);
>  			if (buffer_dirty(bh)) {
> @@ -894,7 +894,7 @@ int remove_inode_buffers(struct inode *inode)
>  			}
>  			__remove_assoc_queue(bh);
>  		}
> -		spin_unlock(&buffer_mapping->private_lock);
> +		spin_unlock(&buffer_mapping->i_private_lock);
>  	}
>  	return ret;
>  }
> @@ -1067,10 +1067,10 @@ static bool grow_dev_folio(struct block_device *bdev, sector_t block,
>  	 * lock to be atomic wrt __find_get_block(), which does not
>  	 * run under the folio lock.
>  	 */
> -	spin_lock(&inode->i_mapping->private_lock);
> +	spin_lock(&inode->i_mapping->i_private_lock);
>  	link_dev_buffers(folio, bh);
>  	end_block = folio_init_buffers(folio, bdev, size);
> -	spin_unlock(&inode->i_mapping->private_lock);
> +	spin_unlock(&inode->i_mapping->i_private_lock);
>  unlock:
>  	folio_unlock(folio);
>  	folio_put(folio);
> @@ -1162,7 +1162,7 @@ __getblk_slow(struct block_device *bdev, sector_t block,
>   * and then attach the address_space's inode to its superblock's dirty
>   * inode list.
>   *
> - * mark_buffer_dirty() is atomic.  It takes bh->b_folio->mapping->private_lock,
> + * mark_buffer_dirty() is atomic.  It takes bh->b_folio->mapping->i_private_lock,
>   * i_pages lock and mapping->host->i_lock.
>   */
>  void mark_buffer_dirty(struct buffer_head *bh)
> @@ -1240,10 +1240,10 @@ void __bforget(struct buffer_head *bh)
>  	if (bh->b_assoc_map) {
>  		struct address_space *buffer_mapping = bh->b_folio->mapping;
>  
> -		spin_lock(&buffer_mapping->private_lock);
> +		spin_lock(&buffer_mapping->i_private_lock);
>  		list_del_init(&bh->b_assoc_buffers);
>  		bh->b_assoc_map = NULL;
> -		spin_unlock(&buffer_mapping->private_lock);
> +		spin_unlock(&buffer_mapping->i_private_lock);
>  	}
>  	__brelse(bh);
>  }
> @@ -1632,7 +1632,7 @@ EXPORT_SYMBOL(block_invalidate_folio);
>  
>  /*
>   * We attach and possibly dirty the buffers atomically wrt
> - * block_dirty_folio() via private_lock.  try_to_free_buffers
> + * block_dirty_folio() via i_private_lock.  try_to_free_buffers
>   * is already excluded via the folio lock.
>   */
>  struct buffer_head *create_empty_buffers(struct folio *folio,
> @@ -1650,7 +1650,7 @@ struct buffer_head *create_empty_buffers(struct folio *folio,
>  	} while (bh);
>  	tail->b_this_page = head;
>  
> -	spin_lock(&folio->mapping->private_lock);
> +	spin_lock(&folio->mapping->i_private_lock);
>  	if (folio_test_uptodate(folio) || folio_test_dirty(folio)) {
>  		bh = head;
>  		do {
> @@ -1662,7 +1662,7 @@ struct buffer_head *create_empty_buffers(struct folio *folio,
>  		} while (bh != head);
>  	}
>  	folio_attach_private(folio, head);
> -	spin_unlock(&folio->mapping->private_lock);
> +	spin_unlock(&folio->mapping->i_private_lock);
>  
>  	return head;
>  }
> @@ -1709,7 +1709,7 @@ void clean_bdev_aliases(struct block_device *bdev, sector_t block, sector_t len)
>  			if (!folio_buffers(folio))
>  				continue;
>  			/*
> -			 * We use folio lock instead of bd_mapping->private_lock
> +			 * We use folio lock instead of bd_mapping->i_private_lock
>  			 * to pin buffers here since we can afford to sleep and
>  			 * it scales better than a global spinlock lock.
>  			 */
> @@ -2859,7 +2859,7 @@ EXPORT_SYMBOL(sync_dirty_buffer);
>   * are unused, and releases them if so.
>   *
>   * Exclusion against try_to_free_buffers may be obtained by either
> - * locking the folio or by holding its mapping's private_lock.
> + * locking the folio or by holding its mapping's i_private_lock.
>   *
>   * If the folio is dirty but all the buffers are clean then we need to
>   * be sure to mark the folio clean as well.  This is because the folio
> @@ -2870,7 +2870,7 @@ EXPORT_SYMBOL(sync_dirty_buffer);
>   * The same applies to regular filesystem folios: if all the buffers are
>   * clean then we set the folio clean and proceed.  To do that, we require
>   * total exclusion from block_dirty_folio().  That is obtained with
> - * private_lock.
> + * i_private_lock.
>   *
>   * try_to_free_buffers() is non-blocking.
>   */
> @@ -2922,7 +2922,7 @@ bool try_to_free_buffers(struct folio *folio)
>  		goto out;
>  	}
>  
> -	spin_lock(&mapping->private_lock);
> +	spin_lock(&mapping->i_private_lock);
>  	ret = drop_buffers(folio, &buffers_to_free);
>  
>  	/*
> @@ -2935,13 +2935,13 @@ bool try_to_free_buffers(struct folio *folio)
>  	 * the folio's buffers clean.  We discover that here and clean
>  	 * the folio also.
>  	 *
> -	 * private_lock must be held over this entire operation in order
> +	 * i_private_lock must be held over this entire operation in order
>  	 * to synchronise against block_dirty_folio and prevent the
>  	 * dirty bit from being lost.
>  	 */
>  	if (ret)
>  		folio_cancel_dirty(folio);
> -	spin_unlock(&mapping->private_lock);
> +	spin_unlock(&mapping->i_private_lock);
>  out:
>  	if (buffers_to_free) {
>  		struct buffer_head *bh = buffers_to_free;
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 61277f7f8722..0558c8c986d4 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1261,7 +1261,7 @@ static int write_end_fn(handle_t *handle, struct inode *inode,
>   * We need to pick up the new inode size which generic_commit_write gave us
>   * `file' can be NULL - eg, when called from page_symlink().
>   *
> - * ext4 never places buffers on inode->i_mapping->private_list.  metadata
> + * ext4 never places buffers on inode->i_mapping->i_private_list.  metadata
>   * buffers are managed internally.
>   */
>  static int ext4_write_end(struct file *file,
> @@ -3213,7 +3213,7 @@ static bool ext4_inode_datasync_dirty(struct inode *inode)
>  	}
>  
>  	/* Any metadata buffers to write? */
> -	if (!list_empty(&inode->i_mapping->private_list))
> +	if (!list_empty(&inode->i_mapping->i_private_list))
>  		return true;
>  	return inode->i_state & I_DIRTY_DATASYNC;
>  }
> diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
> index 2cb65f76eec8..f28c67181230 100644
> --- a/fs/gfs2/glock.c
> +++ b/fs/gfs2/glock.c
> @@ -1230,7 +1230,7 @@ int gfs2_glock_get(struct gfs2_sbd *sdp, u64 number,
>  		mapping->host = s->s_bdev->bd_inode;
>  		mapping->flags = 0;
>  		mapping_set_gfp_mask(mapping, GFP_NOFS);
> -		mapping->private_data = NULL;
> +		mapping->i_private_data = NULL;
>  		mapping->writeback_index = 0;
>  	}
>  
> diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
> index b108c5d26839..00ce89bdf32c 100644
> --- a/fs/gfs2/ops_fstype.c
> +++ b/fs/gfs2/ops_fstype.c
> @@ -117,7 +117,7 @@ static struct gfs2_sbd *init_sbd(struct super_block *sb)
>  	mapping->host = sb->s_bdev->bd_inode;
>  	mapping->flags = 0;
>  	mapping_set_gfp_mask(mapping, GFP_NOFS);
> -	mapping->private_data = NULL;
> +	mapping->i_private_data = NULL;
>  	mapping->writeback_index = 0;
>  
>  	spin_lock_init(&sdp->sd_log_lock);
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index f757d4f7ad98..05609ab15cbc 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -686,7 +686,7 @@ static void hugetlbfs_evict_inode(struct inode *inode)
>  	 * at inode creation time.  If this is a device special inode,
>  	 * i_mapping may not point to the original address space.
>  	 */
> -	resv_map = (struct resv_map *)(&inode->i_data)->private_data;
> +	resv_map = (struct resv_map *)(&inode->i_data)->i_private_data;
>  	/* Only regular and link inodes have associated reserve maps */
>  	if (resv_map)
>  		resv_map_release(&resv_map->refs);
> @@ -1000,7 +1000,7 @@ static struct inode *hugetlbfs_get_inode(struct super_block *sb,
>  				&hugetlbfs_i_mmap_rwsem_key);
>  		inode->i_mapping->a_ops = &hugetlbfs_aops;
>  		simple_inode_init_ts(inode);
> -		inode->i_mapping->private_data = resv_map;
> +		inode->i_mapping->i_private_data = resv_map;
>  		info->seals = F_SEAL_SEAL;
>  		switch (mode & S_IFMT) {
>  		default:
> diff --git a/fs/inode.c b/fs/inode.c
> index edcd8a61975f..788aa0aa542b 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -209,7 +209,7 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
>  	atomic_set(&mapping->nr_thps, 0);
>  #endif
>  	mapping_set_gfp_mask(mapping, GFP_HIGHUSER_MOVABLE);
> -	mapping->private_data = NULL;
> +	mapping->i_private_data = NULL;
>  	mapping->writeback_index = 0;
>  	init_rwsem(&mapping->invalidate_lock);
>  	lockdep_set_class_and_name(&mapping->invalidate_lock,
> @@ -396,8 +396,8 @@ static void __address_space_init_once(struct address_space *mapping)
>  {
>  	xa_init_flags(&mapping->i_pages, XA_FLAGS_LOCK_IRQ | XA_FLAGS_ACCOUNT);
>  	init_rwsem(&mapping->i_mmap_rwsem);
> -	INIT_LIST_HEAD(&mapping->private_list);
> -	spin_lock_init(&mapping->private_lock);
> +	INIT_LIST_HEAD(&mapping->i_private_list);
> +	spin_lock_init(&mapping->i_private_lock);
>  	mapping->i_mmap = RB_ROOT_CACHED;
>  }
>  
> @@ -618,7 +618,7 @@ void clear_inode(struct inode *inode)
>  	 * nor even WARN_ON(!mapping_empty).
>  	 */
>  	xa_unlock_irq(&inode->i_data.i_pages);
> -	BUG_ON(!list_empty(&inode->i_data.private_list));
> +	BUG_ON(!list_empty(&inode->i_data.i_private_list));
>  	BUG_ON(!(inode->i_state & I_FREEING));
>  	BUG_ON(inode->i_state & I_CLEAR);
>  	BUG_ON(!list_empty(&inode->i_wb_list));
> diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> index b664caea8b4e..7248705faef4 100644
> --- a/fs/nfs/write.c
> +++ b/fs/nfs/write.c
> @@ -192,13 +192,13 @@ static struct nfs_page *nfs_folio_find_private_request(struct folio *folio)
>  
>  	if (!folio_test_private(folio))
>  		return NULL;
> -	spin_lock(&mapping->private_lock);
> +	spin_lock(&mapping->i_private_lock);
>  	req = nfs_folio_private_request(folio);
>  	if (req) {
>  		WARN_ON_ONCE(req->wb_head != req);
>  		kref_get(&req->wb_kref);
>  	}
> -	spin_unlock(&mapping->private_lock);
> +	spin_unlock(&mapping->i_private_lock);
>  	return req;
>  }
>  
> @@ -769,13 +769,13 @@ static void nfs_inode_add_request(struct nfs_page *req)
>  	 * Swap-space should not get truncated. Hence no need to plug the race
>  	 * with invalidate/truncate.
>  	 */
> -	spin_lock(&mapping->private_lock);
> +	spin_lock(&mapping->i_private_lock);
>  	if (likely(!folio_test_swapcache(folio))) {
>  		set_bit(PG_MAPPED, &req->wb_flags);
>  		folio_set_private(folio);
>  		folio->private = req;
>  	}
> -	spin_unlock(&mapping->private_lock);
> +	spin_unlock(&mapping->i_private_lock);
>  	atomic_long_inc(&nfsi->nrequests);
>  	/* this a head request for a page group - mark it as having an
>  	 * extra reference so sub groups can follow suit.
> @@ -796,13 +796,13 @@ static void nfs_inode_remove_request(struct nfs_page *req)
>  		struct folio *folio = nfs_page_to_folio(req->wb_head);
>  		struct address_space *mapping = folio_file_mapping(folio);
>  
> -		spin_lock(&mapping->private_lock);
> +		spin_lock(&mapping->i_private_lock);
>  		if (likely(folio && !folio_test_swapcache(folio))) {
>  			folio->private = NULL;
>  			folio_clear_private(folio);
>  			clear_bit(PG_MAPPED, &req->wb_head->wb_flags);
>  		}
> -		spin_unlock(&mapping->private_lock);
> +		spin_unlock(&mapping->i_private_lock);
>  	}
>  
>  	if (test_and_clear_bit(PG_INODE_REF, &req->wb_flags)) {
> diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
> index 8fe784f62720..9c334c722fc1 100644
> --- a/fs/nilfs2/inode.c
> +++ b/fs/nilfs2/inode.c
> @@ -215,7 +215,7 @@ static bool nilfs_dirty_folio(struct address_space *mapping,
>  	/*
>  	 * The page may not be locked, eg if called from try_to_unmap_one()
>  	 */
> -	spin_lock(&mapping->private_lock);
> +	spin_lock(&mapping->i_private_lock);
>  	head = folio_buffers(folio);
>  	if (head) {
>  		struct buffer_head *bh = head;
> @@ -231,7 +231,7 @@ static bool nilfs_dirty_folio(struct address_space *mapping,
>  	} else if (ret) {
>  		nr_dirty = 1 << (folio_shift(folio) - inode->i_blkbits);
>  	}
> -	spin_unlock(&mapping->private_lock);
> +	spin_unlock(&mapping->i_private_lock);
>  
>  	if (nr_dirty)
>  		nilfs_set_file_dirty(inode, nr_dirty);
> diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
> index 71e31e789b29..548f3b51aa5f 100644
> --- a/fs/ntfs/aops.c
> +++ b/fs/ntfs/aops.c
> @@ -1690,7 +1690,7 @@ const struct address_space_operations ntfs_mst_aops = {
>   *
>   * If the page does not have buffers, we create them and set them uptodate.
>   * The page may not be locked which is why we need to handle the buffers under
> - * the mapping->private_lock.  Once the buffers are marked dirty we no longer
> + * the mapping->i_private_lock.  Once the buffers are marked dirty we no longer
>   * need the lock since try_to_free_buffers() does not free dirty buffers.
>   */
>  void mark_ntfs_record_dirty(struct page *page, const unsigned int ofs) {
> @@ -1702,11 +1702,11 @@ void mark_ntfs_record_dirty(struct page *page, const unsigned int ofs) {
>  	BUG_ON(!PageUptodate(page));
>  	end = ofs + ni->itype.index.block_size;
>  	bh_size = VFS_I(ni)->i_sb->s_blocksize;
> -	spin_lock(&mapping->private_lock);
> +	spin_lock(&mapping->i_private_lock);
>  	if (unlikely(!page_has_buffers(page))) {
> -		spin_unlock(&mapping->private_lock);
> +		spin_unlock(&mapping->i_private_lock);
>  		bh = head = alloc_page_buffers(page, bh_size, true);
> -		spin_lock(&mapping->private_lock);
> +		spin_lock(&mapping->i_private_lock);
>  		if (likely(!page_has_buffers(page))) {
>  			struct buffer_head *tail;
>  
> @@ -1730,7 +1730,7 @@ void mark_ntfs_record_dirty(struct page *page, const unsigned int ofs) {
>  			break;
>  		set_buffer_dirty(bh);
>  	} while ((bh = bh->b_this_page) != head);
> -	spin_unlock(&mapping->private_lock);
> +	spin_unlock(&mapping->i_private_lock);
>  	filemap_dirty_folio(mapping, page_folio(page));
>  	if (unlikely(buffers_to_free)) {
>  		do {
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index b2a3f1c61c19..5969e290f3d9 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -463,9 +463,9 @@ extern const struct address_space_operations empty_aops;
>   * @a_ops: Methods.
>   * @flags: Error bits and flags (AS_*).
>   * @wb_err: The most recent error which has occurred.
> - * @private_lock: For use by the owner of the address_space.
> - * @private_list: For use by the owner of the address_space.
> - * @private_data: For use by the owner of the address_space.
> + * @i_private_lock: For use by the owner of the address_space.
> + * @i_private_list: For use by the owner of the address_space.
> + * @i_private_data: For use by the owner of the address_space.
>   */
>  struct address_space {
>  	struct inode		*host;
> @@ -484,9 +484,9 @@ struct address_space {
>  	unsigned long		flags;
>  	struct rw_semaphore	i_mmap_rwsem;
>  	errseq_t		wb_err;
> -	spinlock_t		private_lock;
> -	struct list_head	private_list;
> -	void			*private_data;
> +	spinlock_t		i_private_lock;
> +	struct list_head	i_private_list;
> +	void *			i_private_data;
>  } __attribute__((aligned(sizeof(long)))) __randomize_layout;
>  	/*
>  	 * On most architectures that alignment is already the case; but
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 6feb3e0630d1..c466551e2fd9 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1141,7 +1141,7 @@ static inline struct resv_map *inode_resv_map(struct inode *inode)
>  	 * The VERY common case is inode->mapping == &inode->i_data but,
>  	 * this may not be true for device special inodes.
>  	 */
> -	return (struct resv_map *)(&inode->i_data)->private_data;
> +	return (struct resv_map *)(&inode->i_data)->i_private_data;
>  }
>  
>  static struct resv_map *vma_resv_map(struct vm_area_struct *vma)
> diff --git a/mm/migrate.c b/mm/migrate.c
> index ff0fbf95a384..d9d2b9432e81 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -746,7 +746,7 @@ static int __buffer_migrate_folio(struct address_space *mapping,
>  
>  recheck_buffers:
>  		busy = false;
> -		spin_lock(&mapping->private_lock);
> +		spin_lock(&mapping->i_private_lock);
>  		bh = head;
>  		do {
>  			if (atomic_read(&bh->b_count)) {
> @@ -760,7 +760,7 @@ static int __buffer_migrate_folio(struct address_space *mapping,
>  				rc = -EAGAIN;
>  				goto unlock_buffers;
>  			}
> -			spin_unlock(&mapping->private_lock);
> +			spin_unlock(&mapping->i_private_lock);
>  			invalidate_bh_lrus();
>  			invalidated = true;
>  			goto recheck_buffers;
> @@ -787,7 +787,7 @@ static int __buffer_migrate_folio(struct address_space *mapping,
>  	rc = MIGRATEPAGE_SUCCESS;
>  unlock_buffers:
>  	if (check_refs)
> -		spin_unlock(&mapping->private_lock);
> +		spin_unlock(&mapping->i_private_lock);
>  	bh = head;
>  	do {
>  		unlock_buffer(bh);
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index b99272396119..e2b9ef136fa4 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -97,7 +97,7 @@ static void kvm_gmem_invalidate_end(struct kvm_gmem *gmem, pgoff_t start,
>  
>  static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
>  {
> -	struct list_head *gmem_list = &inode->i_mapping->private_list;
> +	struct list_head *gmem_list = &inode->i_mapping->i_private_list;
>  	pgoff_t start = offset >> PAGE_SHIFT;
>  	pgoff_t end = (offset + len) >> PAGE_SHIFT;
>  	struct kvm_gmem *gmem;
> @@ -269,7 +269,7 @@ static int kvm_gmem_migrate_folio(struct address_space *mapping,
>  
>  static int kvm_gmem_error_page(struct address_space *mapping, struct page *page)
>  {
> -	struct list_head *gmem_list = &mapping->private_list;
> +	struct list_head *gmem_list = &mapping->i_private_list;
>  	struct kvm_gmem *gmem;
>  	pgoff_t start, end;
>  
> @@ -369,7 +369,7 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
>  	kvm_get_kvm(kvm);
>  	gmem->kvm = kvm;
>  	xa_init(&gmem->bindings);
> -	list_add(&gmem->entry, &inode->i_mapping->private_list);
> +	list_add(&gmem->entry, &inode->i_mapping->i_private_list);
>  
>  	fd_install(fd, file);
>  	return fd;
> -- 
> 2.42.0
> 

