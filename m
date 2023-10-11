Return-Path: <linux-fsdevel+bounces-30-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2827C48A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 05:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B5841C20D5A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 03:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06B9D261;
	Wed, 11 Oct 2023 03:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jj8x5dA3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C29CC8FD;
	Wed, 11 Oct 2023 03:56:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E7CC433C8;
	Wed, 11 Oct 2023 03:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696996584;
	bh=G69Kz/UVYIJ7jk61XQ2XUoH3OiI7IAxqdXi+JLD7m14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jj8x5dA3eONLRr9H0i1k2M3VDMS9fb7EEh4VIShbE1Eku76Xrnddg0xWn4BMfUJt1
	 PmSCB3QJNVZjdVGhOf7QGuw2Z2N9vyEjrjGVgmrWPBirnKCb+hYfjNzUv1CfiQMJm0
	 2myyc/UJlIDML/MIid2zijvkZwx2uzNZAtmpjTEQPwu6ARItEEUdyM0Ck77wzRDRwH
	 Qdmw2Jd5Ei2zk0KFh4JQGzA8QMmuIJK7Fd3ovvr/1JGwHYflJdakAX3e0HRVqOWFTR
	 TrjQW3nzELm7JFmnYkS4ckN+gwBU1gJiCEIr5Hp1uHnBaS+AQBbA+Y15DPLre7u8Fq
	 2Ydh0cJHel1BQ==
Date: Tue, 10 Oct 2023 20:56:22 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	fsverity@lists.linux.dev, djwong@kernel.org, david@fromorbit.com,
	dchinner@redhat.com
Subject: Re: [PATCH v3 10/28] fsverity: operate with Merkle tree blocks
 instead of pages
Message-ID: <20231011035622.GE1185@sol.localdomain>
References: <20231006184922.252188-1-aalbersh@redhat.com>
 <20231006184922.252188-11-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006184922.252188-11-aalbersh@redhat.com>

On Fri, Oct 06, 2023 at 08:49:04PM +0200, Andrey Albershteyn wrote:
> fsverity: operate with Merkle tree blocks instead of pages

Well, it already does, just not for the Merkle tree caching.  A better title
might be something like "fsverity: support block-based Merkle tree caching".

> fsverity expects filesystem to provide PAGEs with Merkle tree
> blocks in it. Then, when fsverity is done with processing the
> blocks, reference to PAGE is freed. This doesn't fit well with the
> way XFS manages its memory.

BTW, I encourage using "fs/verity/" when referring specifically to the fsverity
support code in the kernel, which is located in that directory, as opposed to
the whole fsverity feature.

> This patch moves page reference management out of fsverity to
> filesystem. This way fsverity expects a kaddr to the Merkle tree
> block and filesystem can handle all caching and reference counting.

That's not done for the existing filesystems, though.  Which is probably the
right choice, but it isn't what this commit message says.

> diff --git a/fs/verity/open.c b/fs/verity/open.c
> index dfb9fe6aaae9..8665d8b40081 100644
> --- a/fs/verity/open.c
> +++ b/fs/verity/open.c
> @@ -126,19 +126,16 @@ int fsverity_init_merkle_tree_params(struct merkle_tree_params *params,
>  	}
>  
>  	/*
> -	 * With block_size != PAGE_SIZE, an in-memory bitmap will need to be
> -	 * allocated to track the "verified" status of hash blocks.  Don't allow
> -	 * this bitmap to get too large.  For now, limit it to 1 MiB, which
> -	 * limits the file size to about 4.4 TB with SHA-256 and 4K blocks.
> +	 * An in-memory bitmap will need to be allocated to track the "verified"
> +	 * status of hash blocks.  Don't allow this bitmap to get too large.
> +	 * For now, limit it to 1 MiB, which limits the file size to
> +	 * about 4.4 TB with SHA-256 and 4K blocks.
>  	 *
>  	 * Together with the fact that the data, and thus also the Merkle tree,
>  	 * cannot have more than ULONG_MAX pages, this implies that hash block
> -	 * indices can always fit in an 'unsigned long'.  But to be safe, we
> -	 * explicitly check for that too.  Note, this is only for hash block
> -	 * indices; data block indices might not fit in an 'unsigned long'.
> +	 * indices can always fit in an 'unsigned long'.
>  	 */
> -	if ((params->block_size != PAGE_SIZE && offset > 1 << 23) ||
> -	    offset > ULONG_MAX) {
> +	if (offset > (1 << 23)) {
>  		fsverity_err(inode, "Too many blocks in Merkle tree");
>  		err = -EFBIG;
>  		goto out_err;

This hunk should have been in the patch "fsverity: always use bitmap to track
verified status".

> diff --git a/fs/verity/read_metadata.c b/fs/verity/read_metadata.c
> index 197624cab43e..182bddf5dec5 100644
> --- a/fs/verity/read_metadata.c
> +++ b/fs/verity/read_metadata.c
> @@ -16,9 +16,9 @@ static int fsverity_read_merkle_tree(struct inode *inode,
>  				     const struct fsverity_info *vi,
>  				     void __user *buf, u64 offset, int length)
>  {
> -	const struct fsverity_operations *vops = inode->i_sb->s_vop;
>  	u64 end_offset;
> -	unsigned int offs_in_page;
> +	unsigned int offs_in_block;
> +	unsigned int block_size = vi->tree_params.block_size;

Maybe do here:

	const unsigned int block_size = vi->tree_params.block_size;
	const u8 log_blocksize = vi->tree_params.log_blocksize;

Then both are easily accessible to the rest of the function.

>  	pgoff_t index, last_index;
>  	int retval = 0;
>  	int err = 0;
> @@ -26,8 +26,8 @@ static int fsverity_read_merkle_tree(struct inode *inode,
>  	end_offset = min(offset + length, vi->tree_params.tree_size);
>  	if (offset >= end_offset)
>  		return 0;
> -	offs_in_page = offset_in_page(offset);
> -	last_index = (end_offset - 1) >> PAGE_SHIFT;
> +	offs_in_block = offset % block_size;

No modulo by non-constant values, please.  The block size always is a power of
2, so use 'offset & (block_size - 1)'.

> +	last_index = (end_offset - 1) >> vi->tree_params.log_blocksize;
>  
>  	/*
>	 * Iterate through each Merkle tree page in the requested range and copy
>	 * the requested portion to userspace.  Note that the Merkle tree block
>  	 * size isn't important here, as we are returning a byte stream; i.e.,
>  	 * we can just work with pages even if the tree block size != PAGE_SIZE.
>  	 */

The above comment needs to be updated.

> -	for (index = offset >> PAGE_SHIFT; index <= last_index; index++) {
> +	for (index = offset >> vi->tree_params.log_blocksize;
> +			index <= last_index; index++) {
>  		unsigned long num_ra_pages =
>  			min_t(unsigned long, last_index - index + 1,
>  			      inode->i_sb->s_bdi->io_pages);
>  		unsigned int bytes_to_copy = min_t(u64, end_offset - offset,
> -						   PAGE_SIZE - offs_in_page);
> -		struct page *page;
> -		const void *virt;
> +						   block_size - offs_in_block);
> +		struct fsverity_block block;
>  
> -		page = vops->read_merkle_tree_page(inode, index, num_ra_pages,
> -						   vi->tree_params.log_blocksize);
> -		if (IS_ERR(page)) {
> -			err = PTR_ERR(page);
> -			fsverity_err(inode,
> -				     "Error %d reading Merkle tree page %lu",
> -				     err, index);
> +		block.len = block_size;
> +		if (fsverity_read_merkle_tree_block(inode,
> +					index << vi->tree_params.log_blocksize,
> +					&block, num_ra_pages)) {
> +			fsverity_drop_block(inode, &block);
> +			err = -EFAULT;
>  			break;
>  		}

EFAULT is the wrong error code for an I/O error.

> diff --git a/fs/verity/verify.c b/fs/verity/verify.c
> index f556336ebd8d..dfe01f121843 100644
> --- a/fs/verity/verify.c
> +++ b/fs/verity/verify.c
> @@ -44,15 +44,15 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
>  	const struct merkle_tree_params *params = &vi->tree_params;
>  	const unsigned int hsize = params->digest_size;
>  	int level;
> +	int err;
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
> +		/* Block containing the hash block */
> +		struct fsverity_block block;

"Block containing the hash block" is nonsensical.  I think this indicates that
fsverity_block is misnamed.  It should be called something like
fsverity_blockbuf.  Then the above comment would be something like "Buffer
containing the hash block".

> @@ -93,10 +93,8 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
>  		unsigned long next_hidx;
>  		unsigned long hblock_idx;
>  		pgoff_t hpage_idx;
> -		unsigned int hblock_offset_in_page;
>  		unsigned int hoffset;
> -		struct page *hpage;
> -		const void *haddr;
> +		struct fsverity_block *block = &hblocks[level].block;
>  
>  		/*
>  		 * The index of the block in the current level; also the index
> @@ -110,34 +108,28 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
>  		/* Index of the hash page in the tree overall */
>  		hpage_idx = hblock_idx >> params->log_blocks_per_page;
>  
> -		/* Byte offset of the hash block within the page */
> -		hblock_offset_in_page =
> -			(hblock_idx << params->log_blocksize) & ~PAGE_MASK;
> -
>  		/* Byte offset of the hash within the block */
>  		hoffset = (hidx << params->log_digestsize) &
>  			  (params->block_size - 1);
>  
> -		hpage = inode->i_sb->s_vop->read_merkle_tree_page(inode,
> -				hpage_idx, level == 0 ? min(max_ra_pages,
> -					params->tree_pages - hpage_idx) : 0,
> -				params->log_blocksize);
> -		if (IS_ERR(hpage)) {
> +		block->len = params->block_size;
> +		num_ra_pages = level == 0 ?
> +			min(max_ra_pages, params->tree_pages - hpage_idx) : 0;

The fact that the readahead amount is still calculated in pages seems out of
place.  Maybe it should be done in bytes?

> -		if (vi->hash_block_verified)
> -			set_bit(hblock_idx, vi->hash_block_verified);
> -		else
> -			SetPageChecked(hpage);
> +		set_bit(hblock_idx, vi->hash_block_verified);

This hunk also should have been in "fsverity: always use bitmap to track
verified status".  But as I mentioned on that patch, I'm not sure we should
always use the bitmap.

> diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
> index cac012d4c86a..ce37a430bc97 100644
> --- a/include/linux/fsverity.h
> +++ b/include/linux/fsverity.h
> @@ -26,6 +26,24 @@
>  /* Arbitrary limit to bound the kmalloc() size.  Can be changed. */
>  #define FS_VERITY_MAX_DESCRIPTOR_SIZE	16384
>  
> +/**
> + * struct fsverity_block - Merkle Tree block
> + * @kaddr: virtual address of the block's data
> + * @len: length of the data

Maybe use size instead of len?  Currently it's pretty consistently called the
"block size", not "block length".

> + * @cached: true if block was already in cache, false otherwise

cached => already_cached?

> + * @verified: true if block is verified against Merkle tree
> + * @context: filesystem private context
> + *
> + * Merkle Tree blocks passed and requested from filesystem
> + */

It needs to be clearly documented how these fields flow between the filesystem
and fs/verity/ when ->read_merkle_tree_block() and ->drop_block() are used.  It
seems to be different for different fields.  Which are inputs and which are
outputs to which functions?

> +	/**
> +	 * Read a Merkle tree block of the given inode.
> +	 * @inode: the inode
> +	 * @index: 0-based index of the block within the Merkle tree
> +	 * @num_ra_pages: The number of pages with blocks that should be
> +	 *		  prefetched starting at @index if the page at @index
> +	 *		  isn't already cached.  Implementations may ignore this
> +	 *		  argument; it's only a performance optimization.
> +	 *
> +	 * This can be called at any time on an open verity file.  It may be
> +	 * called by multiple processes concurrently.
> +	 *
> +	 * Return: 0 on success, -errno on failure
> +	 */
> +	int (*read_merkle_tree_block)(struct inode *inode,
> +				      unsigned int index,
> +				      struct fsverity_block *block,
> +				      unsigned long num_ra_pages);

For the second parameter your code actually passes the block position (in
bytes), not the block index.  Perhaps you meant for it to be 'u64 pos'?  Either
way, 'unsigned int' is wrong.  Merkle tree block indices are unsigned long;
positions are u64.

> -static inline void fsverity_drop_page(struct inode *inode, struct page *page)
> +static inline void fsverity_drop_block(struct inode *inode,
> +		struct fsverity_block *block)
>  {
> -	if (inode->i_sb->s_vop->drop_page)
> -		inode->i_sb->s_vop->drop_page(page);
> -	else
> +	if (inode->i_sb->s_vop->drop_block)
> +		inode->i_sb->s_vop->drop_block(block);
> +	else {
> +		struct page *page = (struct page *)block->context;
> +
> +		if (block->verified)
> +			SetPageChecked(page);
> +

Why is PG_checked being set here?

> +/**
> + * fsverity_read_block_from_page() - layer between fs using read page
> + * and read block
> + * @inode: inode in use for verification or metadata reading
> + * @index: index of the block in the tree (offset into the tree)
> + * @block: block to be read
> + * @num_ra_pages: number of pages to readahead, may be ignored
> + *
> + * Depending on fs implementation use read_merkle_tree_block or
> + * read_merkle_tree_page.
> + */
> +static inline int fsverity_read_merkle_tree_block(struct inode *inode,
> +					unsigned int index,
> +					struct fsverity_block *block,
> +					unsigned long num_ra_pages)
> +{
> +	struct page *page;
> +
> +	if (inode->i_sb->s_vop->read_merkle_tree_block)
> +		return inode->i_sb->s_vop->read_merkle_tree_block(
> +			inode, index, block, num_ra_pages);
> +
> +	page = inode->i_sb->s_vop->read_merkle_tree_page(
> +			inode, index >> PAGE_SHIFT, num_ra_pages,
> +			block->len);
> +
> +	block->kaddr = page_address(page) + (index % PAGE_SIZE);
> +	block->cached = PageChecked(page);
> +	block->context = page;
> +
> +	if (IS_ERR(page))
> +		return PTR_ERR(page);
> +	else
> +		return 0;
> +}

This isn't handling errors from ->read_merkle_tree_page() correctly.  Also,
page_address() can't be used for pagecache pages unless the file has opted out
of highmem.  You need to use kmap_local_page(), as the code was doing before.

Also, since fsverity_read_merkle_tree_block() is a private function for
fs/verity/, not for filesystems to use, it should be put in
fs/verity/fsverity_private.h, not in include/linux/fsverity.h.

- Eric

