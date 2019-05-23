Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8F427F0E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 16:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730789AbfEWOEs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 10:04:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:53788 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730323AbfEWOEs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 10:04:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5E988AD55;
        Thu, 23 May 2019 14:04:46 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B02DA1E3C69; Thu, 23 May 2019 16:04:45 +0200 (CEST)
Date:   Thu, 23 May 2019 16:04:45 +0200
From:   Jan Kara <jack@suse.cz>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, kilobyte@angband.pl,
        linux-fsdevel@vger.kernel.org, jack@suse.cz, david@fromorbit.com,
        willy@infradead.org, hch@lst.de, darrick.wong@oracle.com,
        dsterba@suse.cz, nborisov@suse.com, linux-nvdimm@lists.01.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 16/18] btrfs: Writeprotect mmap pages on snapshot
Message-ID: <20190523140445.GD2949@quack2.suse.cz>
References: <20190429172649.8288-1-rgoldwyn@suse.de>
 <20190429172649.8288-17-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429172649.8288-17-rgoldwyn@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 29-04-19 12:26:47, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Inorder to make sure mmap'd files don't change after snapshot,
> writeprotect the mmap pages on snapshot. This is done by performing
> a data writeback on the pages (which simply mark the pages are
> wrprotected). This way if the user process tries to access the memory
> we will get another fault and we can perform a CoW.
> 
> In order to accomplish this, we tag all CoW pages as
> PAGECACHE_TAG_TOWRITE, and add the mmapd inode in delalloc_inodes.
> During snapshot, it starts writeback of all delalloc'd inodes and
> here we perform a data writeback. We don't want to keep the inodes
> in delalloc_inodes until it umount (WARN_ON), so we remove it
> during inode evictions.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

OK, so here you use PAGECACHE_TAG_TOWRITE. But why is not
PAGECACHE_TAG_DIRTY enough for you? Also why isn't the same needed also for
normal non-DAX inodes? There you also need to trigger CoW on mmap write so
I just don't see the difference...

								Honza

> ---
>  fs/btrfs/ctree.h |  3 ++-
>  fs/btrfs/dax.c   |  7 +++++++
>  fs/btrfs/inode.c | 13 ++++++++++++-
>  3 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index ee1ed18f8b3c..d1b70f24adeb 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3252,7 +3252,8 @@ int btrfs_create_subvol_root(struct btrfs_trans_handle *trans,
>  			     struct btrfs_root *new_root,
>  			     struct btrfs_root *parent_root,
>  			     u64 new_dirid);
> - void btrfs_set_delalloc_extent(struct inode *inode, struct extent_state *state,
> +void btrfs_add_delalloc_inodes(struct btrfs_root *root, struct inode *inode);
> +void btrfs_set_delalloc_extent(struct inode *inode, struct extent_state *state,
>  			       unsigned *bits);
>  void btrfs_clear_delalloc_extent(struct inode *inode,
>  				 struct extent_state *state, unsigned *bits);
> diff --git a/fs/btrfs/dax.c b/fs/btrfs/dax.c
> index bf2ddac5b5a1..20ec2ec49c68 100644
> --- a/fs/btrfs/dax.c
> +++ b/fs/btrfs/dax.c
> @@ -222,10 +222,17 @@ vm_fault_t btrfs_dax_fault(struct vm_fault *vmf)
>  {
>  	vm_fault_t ret;
>  	pfn_t pfn;
> +	struct inode *inode = file_inode(vmf->vma->vm_file);
> +	struct btrfs_inode *binode = BTRFS_I(inode);
>  	ret = dax_iomap_fault(vmf, PE_SIZE_PTE, &pfn, NULL, &btrfs_iomap_ops);
>  	if (ret & VM_FAULT_NEEDDSYNC)
>  		ret = dax_finish_sync_fault(vmf, PE_SIZE_PTE, pfn);
>  
> +	/* Insert into delalloc so we get writeback calls on snapshots */
> +	if (vmf->flags & FAULT_FLAG_WRITE &&
> +			!test_bit(BTRFS_INODE_IN_DELALLOC_LIST, &binode->runtime_flags))
> +		btrfs_add_delalloc_inodes(binode->root, inode);
> +
>  	return ret;
>  }
>  
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 7e88280a2c3b..e98fb512e1ca 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1713,7 +1713,7 @@ void btrfs_merge_delalloc_extent(struct inode *inode, struct extent_state *new,
>  	spin_unlock(&BTRFS_I(inode)->lock);
>  }
>  
> -static void btrfs_add_delalloc_inodes(struct btrfs_root *root,
> +void btrfs_add_delalloc_inodes(struct btrfs_root *root,
>  				      struct inode *inode)
>  {
>  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> @@ -5358,12 +5358,17 @@ void btrfs_evict_inode(struct inode *inode)
>  {
>  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>  	struct btrfs_trans_handle *trans;
> +	struct btrfs_inode *binode = BTRFS_I(inode);
>  	struct btrfs_root *root = BTRFS_I(inode)->root;
>  	struct btrfs_block_rsv *rsv;
>  	int ret;
>  
>  	trace_btrfs_inode_evict(inode);
>  
> +	if (IS_DAX(inode)
> +	    && test_bit(BTRFS_INODE_IN_DELALLOC_LIST, &binode->runtime_flags))
> +		btrfs_del_delalloc_inode(root, binode);
> +
>  	if (!root) {
>  		clear_inode(inode);
>  		return;
> @@ -8683,6 +8688,10 @@ static int btrfs_dax_writepages(struct address_space *mapping,
>  {
>  	struct inode *inode = mapping->host;
>  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> +	struct btrfs_inode *binode = BTRFS_I(inode);
> +	if ((wbc->sync_mode == WB_SYNC_ALL) &&
> +	    test_bit(BTRFS_INODE_IN_DELALLOC_LIST, &binode->runtime_flags))
> +		btrfs_del_delalloc_inode(binode->root, binode);
>  	return dax_writeback_mapping_range(mapping, fs_info->fs_devices->latest_bdev,
>  			wbc);
>  }
> @@ -9981,6 +9990,8 @@ static void btrfs_run_delalloc_work(struct btrfs_work *work)
>  	delalloc_work = container_of(work, struct btrfs_delalloc_work,
>  				     work);
>  	inode = delalloc_work->inode;
> +	if (IS_DAX(inode))
> +		filemap_fdatawrite(inode->i_mapping);
>  	filemap_flush(inode->i_mapping);
>  	if (test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
>  				&BTRFS_I(inode)->runtime_flags))
> -- 
> 2.16.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
