Return-Path: <linux-fsdevel+bounces-14171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E70B878B7B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 00:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65FF0B20C26
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 23:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E342258ACC;
	Mon, 11 Mar 2024 23:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aI8sNSmf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E3458AB2;
	Mon, 11 Mar 2024 23:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710199372; cv=none; b=f7H4KctZtfW5gyHhN9jnI/x2Oh8GCdj1HRYgErv4DAamcF81DZS/WA5xM+HIKsiqRDXZtUdWKRGPITGCf0lGhXPbNro5RMlBsa21z/ndAEM+AWKtbg9H08/iZAymaB8FAfEmrV0r1qBF9seaOfIwWZKqlBYq8kpSqSNdcTeNZSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710199372; c=relaxed/simple;
	bh=++0gZ01phWcCIjanW8svUbK+/Zgcr1cOZTHwY/T9hFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tnv3iaaf7QDxQ/bTDhy3m4mvDBOXHZ3A5fPPgpPJoxFwYY7wYlm4JKOYs3jbiSm+H3DylQ6wCCp8bHhOH7Z+Ym38M49n6JuuX4H/88GXMctJ53J3Ams9dGg8R2OhgMtxUaiB+yetljgsQBNY6VrvHVqSuCd+sxzyBy6/QhsI0Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aI8sNSmf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8DB3C433F1;
	Mon, 11 Mar 2024 23:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710199371;
	bh=++0gZ01phWcCIjanW8svUbK+/Zgcr1cOZTHwY/T9hFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aI8sNSmfZ8PA4UB4eAvqxWxmHkjPe4B4GhP5vTL9NbX0iJNcUvAvSL/QvhYPyHQ0F
	 vOYsYbR259J6mUVSd+Tyfpei2nRAkurRm9iDaFMiLt9shbaBBhh1PSC72JfOExRrCE
	 UuNc2h5Qkr1LKkyG9cAKP0euzmhi5L1Wnd9a5GqlOr9CeEAiEHWLXGGOTvFJAnHYoP
	 Q/qARWy4wK97fWUsWpJvnJnWnChyzZrPivhbcDBMbRan1uCtxo24r5jGW2HbqkzBC2
	 yjnklgA+25uwTK0ad2UqmjRMMjQ9cbQVFHlcDqAajSbPgEe6xyNWPoLq0HJe+zrrRw
	 y7+NahvSDTAcw==
Date: Mon, 11 Mar 2024 16:22:51 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, chandan.babu@oracle.com,
	ebiggers@kernel.org
Subject: Re: [PATCH v5 07/24] fsverity: support block-based Merkle tree
 caching
Message-ID: <20240311232251.GX1927156@frogsfrogsfrogs>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-9-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304191046.157464-9-aalbersh@redhat.com>

On Mon, Mar 04, 2024 at 08:10:30PM +0100, Andrey Albershteyn wrote:
> In the current implementation fs-verity expects filesystem to
> provide PAGEs filled with Merkle tree blocks. Then, when fs-verity
> is done with processing the blocks, reference to PAGE is freed. This
> doesn't fit well with the way XFS manages its memory.
> 
> To allow XFS integrate fs-verity this patch adds ability to
> fs-verity verification code to take Merkle tree blocks instead of
> PAGE reference. This way ext4, f2fs, and btrfs are still able to
> pass PAGE references and XFS can pass reference to Merkle tree
> blocks stored in XFS's buffer infrastructure.
> 
> Another addition is invalidation function which tells fs-verity to
> mark part of Merkle tree as not verified. This function is used
> by filesystem to tell fs-verity to invalidate block which was
> evicted from memory.
> 
> Depending on Merkle tree block size fs-verity is using either bitmap
> or PG_checked flag to track "verified" status of the blocks. With a
> Merkle tree block caching (XFS) there is no PAGE to flag it as
> verified. fs-verity always uses bitmap to track verified blocks for
> filesystems which use block caching.
> 
> Further this patch allows filesystem to make additional processing
> on verified pages via fsverity_drop_block() instead of just dropping
> a reference. This will be used by XFS for internal buffer cache
> manipulation in further patches. The btrfs, ext4, and f2fs just drop
> the reference.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> ---
>  fs/verity/fsverity_private.h |   8 +++
>  fs/verity/open.c             |   8 ++-
>  fs/verity/read_metadata.c    |  64 +++++++++++-------
>  fs/verity/verify.c           | 125 +++++++++++++++++++++++++++--------
>  include/linux/fsverity.h     |  65 ++++++++++++++++++
>  5 files changed, 217 insertions(+), 53 deletions(-)
> 
> diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
> index b3506f56e180..dad33e6ff0d6 100644
> --- a/fs/verity/fsverity_private.h
> +++ b/fs/verity/fsverity_private.h
> @@ -154,4 +154,12 @@ static inline void fsverity_init_signature(void)
>  
>  void __init fsverity_init_workqueue(void);
>  
> +/*
> + * Drop 'block' obtained with ->read_merkle_tree_block(). Calls out back to
> + * filesystem if ->drop_block() is set, otherwise, drop the reference in the
> + * block->context.
> + */
> +void fsverity_drop_block(struct inode *inode,
> +			 struct fsverity_blockbuf *block);
> +
>  #endif /* _FSVERITY_PRIVATE_H */
> diff --git a/fs/verity/open.c b/fs/verity/open.c
> index fdeb95eca3af..6e6922b4b014 100644
> --- a/fs/verity/open.c
> +++ b/fs/verity/open.c
> @@ -213,7 +213,13 @@ struct fsverity_info *fsverity_create_info(const struct inode *inode,
>  	if (err)
>  		goto fail;
>  
> -	if (vi->tree_params.block_size != PAGE_SIZE) {
> +	/*
> +	 * If fs passes Merkle tree blocks to fs-verity (e.g. XFS), then
> +	 * fs-verity should use hash_block_verified bitmap as there's no page
> +	 * to mark it with PG_checked.
> +	 */
> +	if (vi->tree_params.block_size != PAGE_SIZE ||
> +			inode->i_sb->s_vop->read_merkle_tree_block) {
>  		/*
>  		 * When the Merkle tree block size and page size differ, we use
>  		 * a bitmap to keep track of which hash blocks have been
> diff --git a/fs/verity/read_metadata.c b/fs/verity/read_metadata.c
> index f58432772d9e..5da40b5a81af 100644
> --- a/fs/verity/read_metadata.c
> +++ b/fs/verity/read_metadata.c
> @@ -18,50 +18,68 @@ static int fsverity_read_merkle_tree(struct inode *inode,
>  {
>  	const struct fsverity_operations *vops = inode->i_sb->s_vop;
>  	u64 end_offset;
> -	unsigned int offs_in_page;
> +	unsigned int offs_in_block;
>  	pgoff_t index, last_index;
>  	int retval = 0;
>  	int err = 0;
> +	const unsigned int block_size = vi->tree_params.block_size;
> +	const u8 log_blocksize = vi->tree_params.log_blocksize;
>  
>  	end_offset = min(offset + length, vi->tree_params.tree_size);
>  	if (offset >= end_offset)
>  		return 0;
> -	offs_in_page = offset_in_page(offset);
> -	last_index = (end_offset - 1) >> PAGE_SHIFT;
> +	offs_in_block = offset & (block_size - 1);
> +	last_index = (end_offset - 1) >> log_blocksize;
>  
>  	/*
> -	 * Iterate through each Merkle tree page in the requested range and copy
> -	 * the requested portion to userspace.  Note that the Merkle tree block
> -	 * size isn't important here, as we are returning a byte stream; i.e.,
> -	 * we can just work with pages even if the tree block size != PAGE_SIZE.
> +	 * Iterate through each Merkle tree block in the requested range and
> +	 * copy the requested portion to userspace. Note that we are returning
> +	 * a byte stream.
>  	 */
> -	for (index = offset >> PAGE_SHIFT; index <= last_index; index++) {
> +	for (index = offset >> log_blocksize; index <= last_index; index++) {
>  		unsigned long num_ra_pages =
>  			min_t(unsigned long, last_index - index + 1,
>  			      inode->i_sb->s_bdi->io_pages);
>  		unsigned int bytes_to_copy = min_t(u64, end_offset - offset,
> -						   PAGE_SIZE - offs_in_page);
> -		struct page *page;
> -		const void *virt;
> +						   block_size - offs_in_block);
> +		struct fsverity_blockbuf block = {
> +			.size = block_size,
> +		};
>  
> -		page = vops->read_merkle_tree_page(inode, index, num_ra_pages);
> -		if (IS_ERR(page)) {
> -			err = PTR_ERR(page);
> +		if (!vops->read_merkle_tree_block) {
> +			unsigned int blocks_per_page =
> +				vi->tree_params.blocks_per_page;
> +			unsigned long page_idx =
> +				round_down(index, blocks_per_page);
> +			struct page *page = vops->read_merkle_tree_page(inode,
> +					page_idx, num_ra_pages);
> +
> +			if (IS_ERR(page)) {
> +				err = PTR_ERR(page);
> +			} else {
> +				block.kaddr = kmap_local_page(page) +
> +					((index - page_idx) << log_blocksize);
> +				block.context = page;
> +			}
> +		} else {
> +			err = vops->read_merkle_tree_block(inode,
> +					index << log_blocksize,
> +					&block, log_blocksize, num_ra_pages);
> +		}
> +
> +		if (err) {
>  			fsverity_err(inode,
> -				     "Error %d reading Merkle tree page %lu",
> -				     err, index);
> +				     "Error %d reading Merkle tree block %lu",
> +				     err, index << log_blocksize);
>  			break;
>  		}
>  
> -		virt = kmap_local_page(page);
> -		if (copy_to_user(buf, virt + offs_in_page, bytes_to_copy)) {
> -			kunmap_local(virt);
> -			put_page(page);
> +		if (copy_to_user(buf, block.kaddr + offs_in_block, bytes_to_copy)) {
> +			fsverity_drop_block(inode, &block);
>  			err = -EFAULT;
>  			break;
>  		}
> -		kunmap_local(virt);
> -		put_page(page);
> +		fsverity_drop_block(inode, &block);
>  
>  		retval += bytes_to_copy;
>  		buf += bytes_to_copy;
> @@ -72,7 +90,7 @@ static int fsverity_read_merkle_tree(struct inode *inode,
>  			break;
>  		}
>  		cond_resched();
> -		offs_in_page = 0;
> +		offs_in_block = 0;
>  	}
>  	return retval ? retval : err;
>  }
> diff --git a/fs/verity/verify.c b/fs/verity/verify.c
> index 4fcad0825a12..de71911d400c 100644
> --- a/fs/verity/verify.c
> +++ b/fs/verity/verify.c
> @@ -13,14 +13,17 @@
>  static struct workqueue_struct *fsverity_read_workqueue;
>  
>  /*
> - * Returns true if the hash block with index @hblock_idx in the tree, located in
> - * @hpage, has already been verified.
> + * Returns true if the hash block with index @hblock_idx in the tree has
> + * already been verified.
>   */
> -static bool is_hash_block_verified(struct fsverity_info *vi, struct page *hpage,
> +static bool is_hash_block_verified(struct inode *inode,
> +				   struct fsverity_blockbuf *block,
>  				   unsigned long hblock_idx)
>  {
>  	unsigned int blocks_per_page;
>  	unsigned int i;
> +	struct fsverity_info *vi = inode->i_verity_info;
> +	struct page *hpage = (struct page *)block->context;
>  
>  	/*
>  	 * When the Merkle tree block size and page size are the same, then the
> @@ -34,6 +37,12 @@ static bool is_hash_block_verified(struct fsverity_info *vi, struct page *hpage,
>  	if (!vi->hash_block_verified)
>  		return PageChecked(hpage);
>  
> +	/*
> +	 * Filesystems which use block based caching (e.g. XFS) always use
> +	 * bitmap.
> +	 */
> +	if (inode->i_sb->s_vop->read_merkle_tree_block)
> +		return test_bit(hblock_idx, vi->hash_block_verified);
>  	/*
>  	 * When the Merkle tree block size and page size differ, we use a bitmap
>  	 * to indicate whether each hash block has been verified.
> @@ -95,15 +104,15 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
>  	const struct merkle_tree_params *params = &vi->tree_params;
>  	const unsigned int hsize = params->digest_size;
>  	int level;
> +	int err;

FWIW, Dan Carpenter complained that err can be used uninitialized
here...

> +	int num_ra_pages;
>  	u8 _want_hash[FS_VERITY_MAX_DIGEST_SIZE];
>  	const u8 *want_hash;
>  	u8 real_hash[FS_VERITY_MAX_DIGEST_SIZE];
>  	/* The hash blocks that are traversed, indexed by level */
>  	struct {
> -		/* Page containing the hash block */
> -		struct page *page;
> -		/* Mapped address of the hash block (will be within @page) */
> -		const void *addr;
> +		/* Buffer containing the hash block */
> +		struct fsverity_blockbuf block;
>  		/* Index of the hash block in the tree overall */
>  		unsigned long index;
>  		/* Byte offset of the wanted hash relative to @addr */
> @@ -144,10 +153,11 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
>  		unsigned long next_hidx;
>  		unsigned long hblock_idx;
>  		pgoff_t hpage_idx;
> +		u64 hblock_pos;
>  		unsigned int hblock_offset_in_page;
>  		unsigned int hoffset;
>  		struct page *hpage;
> -		const void *haddr;
> +		struct fsverity_blockbuf *block = &hblocks[level].block;
>  
>  		/*
>  		 * The index of the block in the current level; also the index
> @@ -165,29 +175,49 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
>  		hblock_offset_in_page =
>  			(hblock_idx << params->log_blocksize) & ~PAGE_MASK;
>  
> +		/* Offset of the Merkle tree block into the tree */
> +		hblock_pos = hblock_idx << params->log_blocksize;
> +
>  		/* Byte offset of the hash within the block */
>  		hoffset = (hidx << params->log_digestsize) &
>  			  (params->block_size - 1);
>  
> -		hpage = inode->i_sb->s_vop->read_merkle_tree_page(inode,
> -				hpage_idx, level == 0 ? min(max_ra_pages,
> -					params->tree_pages - hpage_idx) : 0);
> -		if (IS_ERR(hpage)) {
> +		num_ra_pages = level == 0 ?
> +			min(max_ra_pages, params->tree_pages - hpage_idx) : 0;
> +
> +		if (inode->i_sb->s_vop->read_merkle_tree_block) {
> +			err = inode->i_sb->s_vop->read_merkle_tree_block(
> +				inode, hblock_pos, block, params->log_blocksize,
> +				num_ra_pages);
> +		} else {
> +			unsigned int blocks_per_page =
> +				vi->tree_params.blocks_per_page;
> +			hblock_idx = round_down(hblock_idx, blocks_per_page);
> +			hpage = inode->i_sb->s_vop->read_merkle_tree_page(
> +				inode, hpage_idx, (num_ra_pages << PAGE_SHIFT));
> +
> +			if (IS_ERR(hpage)) {
> +				err = PTR_ERR(hpage);
> +			} else {
> +				block->kaddr = kmap_local_page(hpage) +
> +					hblock_offset_in_page;
> +				block->context = hpage;

...in the case where hpage is not an error.  I'll fix that in my tree.

https://lore.kernel.org/oe-kbuild-all/f9e79efc-a16f-495d-8e53-d5a9eef5936e@moroto.mountain/T/#u

--D

> +			}
> +		}
> +
> +		if (err) {
>  			fsverity_err(inode,
> -				     "Error %ld reading Merkle tree page %lu",
> -				     PTR_ERR(hpage), hpage_idx);
> +				     "Error %d reading Merkle tree block %lu",
> +				     err, hblock_idx);
>  			goto error;
>  		}
> -		haddr = kmap_local_page(hpage) + hblock_offset_in_page;
> -		if (is_hash_block_verified(vi, hpage, hblock_idx)) {
> -			memcpy(_want_hash, haddr + hoffset, hsize);
> +
> +		if (is_hash_block_verified(inode, block, hblock_idx)) {
> +			memcpy(_want_hash, block->kaddr + hoffset, hsize);
>  			want_hash = _want_hash;
> -			kunmap_local(haddr);
> -			put_page(hpage);
> +			fsverity_drop_block(inode, block);
>  			goto descend;
>  		}
> -		hblocks[level].page = hpage;
> -		hblocks[level].addr = haddr;
>  		hblocks[level].index = hblock_idx;
>  		hblocks[level].hoffset = hoffset;
>  		hidx = next_hidx;
> @@ -197,10 +227,11 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
>  descend:
>  	/* Descend the tree verifying hash blocks. */
>  	for (; level > 0; level--) {
> -		struct page *hpage = hblocks[level - 1].page;
> -		const void *haddr = hblocks[level - 1].addr;
> +		struct fsverity_blockbuf *block = &hblocks[level - 1].block;
> +		const void *haddr = block->kaddr;
>  		unsigned long hblock_idx = hblocks[level - 1].index;
>  		unsigned int hoffset = hblocks[level - 1].hoffset;
> +		struct page *hpage = (struct page *)block->context;
>  
>  		if (fsverity_hash_block(params, inode, haddr, real_hash) != 0)
>  			goto error;
> @@ -217,8 +248,7 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
>  			SetPageChecked(hpage);
>  		memcpy(_want_hash, haddr + hoffset, hsize);
>  		want_hash = _want_hash;
> -		kunmap_local(haddr);
> -		put_page(hpage);
> +		fsverity_drop_block(inode, block);
>  	}
>  
>  	/* Finally, verify the data block. */
> @@ -235,10 +265,8 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
>  		     params->hash_alg->name, hsize, want_hash,
>  		     params->hash_alg->name, hsize, real_hash);
>  error:
> -	for (; level > 0; level--) {
> -		kunmap_local(hblocks[level - 1].addr);
> -		put_page(hblocks[level - 1].page);
> -	}
> +	for (; level > 0; level--)
> +		fsverity_drop_block(inode, &hblocks[level - 1].block);
>  	return false;
>  }
>  
> @@ -362,3 +390,42 @@ void __init fsverity_init_workqueue(void)
>  	if (!fsverity_read_workqueue)
>  		panic("failed to allocate fsverity_read_queue");
>  }
> +
> +/**
> + * fsverity_invalidate_block() - invalidate Merkle tree block
> + * @inode: inode to which this Merkle tree blocks belong
> + * @block: block to be invalidated
> + *
> + * This function invalidates/clears "verified" state of Merkle tree block
> + * in the fs-verity bitmap. The block needs to have ->offset set.
> + */
> +void fsverity_invalidate_block(struct inode *inode,
> +		struct fsverity_blockbuf *block)
> +{
> +	struct fsverity_info *vi = inode->i_verity_info;
> +	const unsigned int log_blocksize = vi->tree_params.log_blocksize;
> +
> +	if (block->offset > vi->tree_params.tree_size) {
> +		fsverity_err(inode,
> +"Trying to invalidate beyond Merkle tree (tree %lld, offset %lld)",
> +			     vi->tree_params.tree_size, block->offset);
> +		return;
> +	}
> +
> +	clear_bit(block->offset >> log_blocksize, vi->hash_block_verified);
> +}
> +EXPORT_SYMBOL_GPL(fsverity_invalidate_block);
> +
> +void fsverity_drop_block(struct inode *inode,
> +		struct fsverity_blockbuf *block)
> +{
> +	if (inode->i_sb->s_vop->drop_block)
> +		inode->i_sb->s_vop->drop_block(block);
> +	else {
> +		struct page *page = (struct page *)block->context;
> +
> +		kunmap_local(block->kaddr);
> +		put_page(page);
> +	}
> +	block->kaddr = NULL;
> +}
> diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
> index ac58b19f23d3..0973b521ac5a 100644
> --- a/include/linux/fsverity.h
> +++ b/include/linux/fsverity.h
> @@ -26,6 +26,33 @@
>  /* Arbitrary limit to bound the kmalloc() size.  Can be changed. */
>  #define FS_VERITY_MAX_DESCRIPTOR_SIZE	16384
>  
> +/**
> + * struct fsverity_blockbuf - Merkle Tree block buffer
> + * @kaddr: virtual address of the block's data
> + * @offset: block's offset into Merkle tree
> + * @size: the Merkle tree block size
> + * @context: filesystem private context
> + *
> + * Buffer containing single Merkle Tree block. These buffers are passed
> + *  - to filesystem, when fs-verity is building merkel tree,
> + *  - from filesystem, when fs-verity is reading merkle tree from a disk.
> + * Filesystems sets kaddr together with size to point to a memory which contains
> + * Merkle tree block. Same is done by fs-verity when Merkle tree is need to be
> + * written down to disk.
> + *
> + * While reading the tree, fs-verity calls ->read_merkle_tree_block followed by
> + * ->drop_block to let filesystem know that memory can be freed.
> + *
> + * The context is optional. This field can be used by filesystem to passthrough
> + * state from ->read_merkle_tree_block to ->drop_block.
> + */
> +struct fsverity_blockbuf {
> +	void *kaddr;
> +	u64 offset;
> +	unsigned int size;
> +	void *context;
> +};
> +
>  /* Verity operations for filesystems */
>  struct fsverity_operations {
>  
> @@ -107,6 +134,32 @@ struct fsverity_operations {
>  					      pgoff_t index,
>  					      unsigned long num_ra_pages);
>  
> +	/**
> +	 * Read a Merkle tree block of the given inode.
> +	 * @inode: the inode
> +	 * @pos: byte offset of the block within the Merkle tree
> +	 * @block: block buffer for filesystem to point it to the block
> +	 * @log_blocksize: log2 of the size of the expected block
> +	 * @ra_bytes: The number of bytes that should be
> +	 *		prefetched starting at @pos if the page at @pos
> +	 *		isn't already cached.  Implementations may ignore this
> +	 *		argument; it's only a performance optimization.
> +	 *
> +	 * This can be called at any time on an open verity file.  It may be
> +	 * called by multiple processes concurrently.
> +	 *
> +	 * In case that block was evicted from the memory filesystem has to use
> +	 * fsverity_invalidate_block() to let fsverity know that block's
> +	 * verification state is not valid anymore.
> +	 *
> +	 * Return: 0 on success, -errno on failure
> +	 */
> +	int (*read_merkle_tree_block)(struct inode *inode,
> +				      u64 pos,
> +				      struct fsverity_blockbuf *block,
> +				      unsigned int log_blocksize,
> +				      u64 ra_bytes);
> +
>  	/**
>  	 * Write a Merkle tree block to the given inode.
>  	 *
> @@ -122,6 +175,16 @@ struct fsverity_operations {
>  	 */
>  	int (*write_merkle_tree_block)(struct inode *inode, const void *buf,
>  				       u64 pos, unsigned int size);
> +
> +	/**
> +	 * Release the reference to a Merkle tree block
> +	 *
> +	 * @block: the block to release
> +	 *
> +	 * This is called when fs-verity is done with a block obtained with
> +	 * ->read_merkle_tree_block().
> +	 */
> +	void (*drop_block)(struct fsverity_blockbuf *block);
>  };
>  
>  #ifdef CONFIG_FS_VERITY
> @@ -175,6 +238,8 @@ int fsverity_ioctl_read_metadata(struct file *filp, const void __user *uarg);
>  bool fsverity_verify_blocks(struct folio *folio, size_t len, size_t offset);
>  void fsverity_verify_bio(struct bio *bio);
>  void fsverity_enqueue_verify_work(struct work_struct *work);
> +void fsverity_invalidate_block(struct inode *inode,
> +		struct fsverity_blockbuf *block);
>  
>  #else /* !CONFIG_FS_VERITY */
>  
> -- 
> 2.42.0
> 
> 

