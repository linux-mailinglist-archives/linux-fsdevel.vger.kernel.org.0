Return-Path: <linux-fsdevel+bounces-13932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4648759C9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 22:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B24B61C21A42
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 21:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A40513B7BE;
	Thu,  7 Mar 2024 21:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKH8dIbS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7597B12E1FA;
	Thu,  7 Mar 2024 21:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709848443; cv=none; b=Jo6F/5m1EgL78Cwuv7oUWI9BnGMzT3hS1aI65R7oW0APUPFxB3fEGGqIP1Lf8o7wbuwNBnNmggSMzUr1+BHdugDTOdm6czk1sPBZACe0Gkh2KBtlPtTcN4FF3m4aTWzUPlGq/3XgAD0Rgk3XqsqIM2dGwyG32fZ86rP6jwsHC0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709848443; c=relaxed/simple;
	bh=6AMAkHGTh18ChiOyYqaMd1ag3eg0KoMZ9+oaIvGk2U0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MITy8jkXReK5UNzQ/VPixZzWWBeSGXeAf4i4STOzYt3CIPho8kkTZmMGfMHTtgo3BL38uEPGdf+/TgcDtZdj0GwJwWz039xQmx3C3B4JrsAoztfeUkg+6w6mFuDudra9ck396v0EPyLi1bihWbLq+7LqautRQaY47h3DyKRqPa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKH8dIbS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C292FC433C7;
	Thu,  7 Mar 2024 21:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709848442;
	bh=6AMAkHGTh18ChiOyYqaMd1ag3eg0KoMZ9+oaIvGk2U0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jKH8dIbSt9oGftK3cPJt3bAjk0HNgWa+yNm73qZ2Hlid8jkbJxASWBwPHwmiu4Cf7
	 zh+uHXGOB+mz7znqsSORzvNoT6hHcd8t+tqh0iD2FlGdghq+cfGdgkvMrgXMv1/Fj1
	 /WLHM18auxH+utA1EH8TxdWPI+QqYK1nQBMwDz0BiNDqZwywMcsTvu226mHrTjUQRu
	 B/0NgQ0OKiJTUjxWt5wYyotL7H74uxgKXE2k1ZG0e0ohraPa7/goS2D4983IwJNV5Z
	 KS9m0603Voym8FYTKzFx2IaAvRxiTBv+dpOPGc19jEbPWx/Qg+pwIPZVTj17HKyBar
	 QxnZwnwf7xJaw==
Date: Thu, 7 Mar 2024 13:54:01 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com
Subject: Re: [PATCH v5 07/24] fsverity: support block-based Merkle tree
 caching
Message-ID: <20240307215401.GR1927156@frogsfrogsfrogs>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-9-aalbersh@redhat.com>
 <20240306035622.GA68962@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306035622.GA68962@sol.localdomain>

On Tue, Mar 05, 2024 at 07:56:22PM -0800, Eric Biggers wrote:
> On Mon, Mar 04, 2024 at 08:10:30PM +0100, Andrey Albershteyn wrote:
> > diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
> > index b3506f56e180..dad33e6ff0d6 100644
> > --- a/fs/verity/fsverity_private.h
> > +++ b/fs/verity/fsverity_private.h
> > @@ -154,4 +154,12 @@ static inline void fsverity_init_signature(void)
> >  
> >  void __init fsverity_init_workqueue(void);
> >  
> > +/*
> > + * Drop 'block' obtained with ->read_merkle_tree_block(). Calls out back to
> > + * filesystem if ->drop_block() is set, otherwise, drop the reference in the
> > + * block->context.
> > + */
> > +void fsverity_drop_block(struct inode *inode,
> > +			 struct fsverity_blockbuf *block);
> > +
> >  #endif /* _FSVERITY_PRIVATE_H */
> 
> This should be paired with a helper function that reads a Merkle tree block by
> calling ->read_merkle_tree_block or ->read_merkle_tree_page as needed.  Besides
> being consistent with having a helper function for drop, this would prevent code
> duplication between verify_data_block() and fsverity_read_merkle_tree().
> 
> I recommend that it look like this:
> 
> int fsverity_read_merkle_tree_block(struct inode *inode, u64 pos,
> 				    unsigned long ra_bytes,
> 				    struct fsverity_blockbuf *block);
> 
> 'pos' would be the byte position of the block in the Merkle tree, and 'ra_bytes'
> would be the number of bytes for the filesystem to (optionally) readahead if the
> block is not yet cached.  I think that things work out simpler if these values
> are measured in bytes, not blocks.  'block' would be at the end because it's an
> output, and it can be confusing to interleave inputs and outputs in parameters.

FWIW I don't really like 'pos' here because that's usually short for
"file position", which is a byte, and this looks a lot more like a
merkle tree block number.

u64 blkno?

Or better yet use a typedef ("merkle_blkno_t") to make it really clear
when we're dealing with a tree block number.  Ignore checkpatch
complaining about typeedefs. :)

> Also, the drop function should be named consistently:
> 
> void fsverity_drop_merkle_tree_block(struct inode *inode,
>                                      struct fsverity_blockbuf *block);
> 
> It would be a bit long, but I think it's helpful for consistency and also
> because there are other types of "blocks" that it could be confused with.
> (Data blocks, filesystem blocks, internal blocks of the hash function.)

I agree.

> > diff --git a/fs/verity/open.c b/fs/verity/open.c
> > index fdeb95eca3af..6e6922b4b014 100644
> > --- a/fs/verity/open.c
> > +++ b/fs/verity/open.c
> > @@ -213,7 +213,13 @@ struct fsverity_info *fsverity_create_info(const struct inode *inode,
> >  	if (err)
> >  		goto fail;
> >  
> > -	if (vi->tree_params.block_size != PAGE_SIZE) {
> > +	/*
> > +	 * If fs passes Merkle tree blocks to fs-verity (e.g. XFS), then
> > +	 * fs-verity should use hash_block_verified bitmap as there's no page
> > +	 * to mark it with PG_checked.
> > +	 */
> > +	if (vi->tree_params.block_size != PAGE_SIZE ||
> > +			inode->i_sb->s_vop->read_merkle_tree_block) {
> 
> Technically, all filesystems "pass Merkle tree blocks to fs-verity".  Maybe
> stick to calling it "block-based Merkle tree caching", as you have in the commit
> title, as that seems clearer.
> 
> > diff --git a/fs/verity/read_metadata.c b/fs/verity/read_metadata.c
> > index f58432772d9e..5da40b5a81af 100644
> > --- a/fs/verity/read_metadata.c
> > +++ b/fs/verity/read_metadata.c
> > @@ -18,50 +18,68 @@ static int fsverity_read_merkle_tree(struct inode *inode,
> >  {
> >  	const struct fsverity_operations *vops = inode->i_sb->s_vop;
> >  	u64 end_offset;
> > -	unsigned int offs_in_page;
> > +	unsigned int offs_in_block;
> >  	pgoff_t index, last_index;
> >  	int retval = 0;
> >  	int err = 0;
> > +	const unsigned int block_size = vi->tree_params.block_size;
> > +	const u8 log_blocksize = vi->tree_params.log_blocksize;
> >  
> >  	end_offset = min(offset + length, vi->tree_params.tree_size);
> >  	if (offset >= end_offset)
> >  		return 0;
> > -	offs_in_page = offset_in_page(offset);
> > -	last_index = (end_offset - 1) >> PAGE_SHIFT;
> > +	offs_in_block = offset & (block_size - 1);
> > +	last_index = (end_offset - 1) >> log_blocksize;
> >  
> >  	/*
> > -	 * Iterate through each Merkle tree page in the requested range and copy
> > -	 * the requested portion to userspace.  Note that the Merkle tree block
> > -	 * size isn't important here, as we are returning a byte stream; i.e.,
> > -	 * we can just work with pages even if the tree block size != PAGE_SIZE.
> > +	 * Iterate through each Merkle tree block in the requested range and
> > +	 * copy the requested portion to userspace. Note that we are returning
> > +	 * a byte stream.
> >  	 */
> > -	for (index = offset >> PAGE_SHIFT; index <= last_index; index++) {
> > +	for (index = offset >> log_blocksize; index <= last_index; index++) {
> >  		unsigned long num_ra_pages =
> >  			min_t(unsigned long, last_index - index + 1,
> >  			      inode->i_sb->s_bdi->io_pages);
> >  		unsigned int bytes_to_copy = min_t(u64, end_offset - offset,
> > -						   PAGE_SIZE - offs_in_page);
> > -		struct page *page;
> > -		const void *virt;
> > +						   block_size - offs_in_block);
> > +		struct fsverity_blockbuf block = {
> > +			.size = block_size,
> > +		};
> >  
> > -		page = vops->read_merkle_tree_page(inode, index, num_ra_pages);
> > -		if (IS_ERR(page)) {
> > -			err = PTR_ERR(page);
> > +		if (!vops->read_merkle_tree_block) {
> > +			unsigned int blocks_per_page =
> > +				vi->tree_params.blocks_per_page;
> > +			unsigned long page_idx =
> > +				round_down(index, blocks_per_page);
> > +			struct page *page = vops->read_merkle_tree_page(inode,
> > +					page_idx, num_ra_pages);
> > +
> > +			if (IS_ERR(page)) {
> > +				err = PTR_ERR(page);
> > +			} else {
> > +				block.kaddr = kmap_local_page(page) +
> > +					((index - page_idx) << log_blocksize);
> > +				block.context = page;
> > +			}
> > +		} else {
> > +			err = vops->read_merkle_tree_block(inode,
> > +					index << log_blocksize,
> > +					&block, log_blocksize, num_ra_pages);
> > +		}
> > +
> > +		if (err) {
> >  			fsverity_err(inode,
> > -				     "Error %d reading Merkle tree page %lu",
> > -				     err, index);
> > +				     "Error %d reading Merkle tree block %lu",
> > +				     err, index << log_blocksize);
> >  			break;
> >  		}
> >  
> > -		virt = kmap_local_page(page);
> > -		if (copy_to_user(buf, virt + offs_in_page, bytes_to_copy)) {
> > -			kunmap_local(virt);
> > -			put_page(page);
> > +		if (copy_to_user(buf, block.kaddr + offs_in_block, bytes_to_copy)) {
> > +			fsverity_drop_block(inode, &block);
> >  			err = -EFAULT;
> >  			break;
> >  		}
> > -		kunmap_local(virt);
> > -		put_page(page);
> > +		fsverity_drop_block(inode, &block);
> >  
> >  		retval += bytes_to_copy;
> >  		buf += bytes_to_copy;
> > @@ -72,7 +90,7 @@ static int fsverity_read_merkle_tree(struct inode *inode,
> >  			break;
> >  		}
> >  		cond_resched();
> > -		offs_in_page = 0;
> > +		offs_in_block = 0;
> >  	}
> >  	return retval ? retval : err;
> >  }
> 
> This is one of the two places that would be simplified quite a bit by adding an
> fsverity_read_merkle_tree_block() helper function, especially if the loop
> variable was changed to measure bytes instead of blocks so that the Merkle tree
> block position and readahead amount can more easily be computed in bytes.  E.g.:

Yes!  I really agree here -- I downloaded the git repo, tried to read
this function, and felt that it would be a lot easier to understand if
the two access paths were separate functions instead of a lot of
switched logic within one function.

> static int fsverity_read_merkle_tree(struct inode *inode,
> 				     const struct fsverity_info *vi,
> 				     void __user *buf, u64 pos, int length)
> {
> 	const u64 end_pos = min(pos + length, vi->tree_params.tree_size);
> 	[...]
> 
> 	while (pos < end_pos) {
> 		// bytes_to_copy = remaining length in current block
> 		[...]
> 		err = fsverity_read_merkle_tree_block(inode,
> 						      pos - offs_in_block,
> 						      ra_bytes,
> 						      &block);
> 		[...]
> 		pos += bytes_to_copy;
> 		[...]
> 	}
> 
> > diff --git a/fs/verity/verify.c b/fs/verity/verify.c
> > index 4fcad0825a12..de71911d400c 100644
> > --- a/fs/verity/verify.c
> > +++ b/fs/verity/verify.c
> > @@ -13,14 +13,17 @@
> >  static struct workqueue_struct *fsverity_read_workqueue;
> >  
> >  /*
> > - * Returns true if the hash block with index @hblock_idx in the tree, located in
> > - * @hpage, has already been verified.
> > + * Returns true if the hash block with index @hblock_idx in the tree has
> > + * already been verified.
> >   */
> > -static bool is_hash_block_verified(struct fsverity_info *vi, struct page *hpage,
> > +static bool is_hash_block_verified(struct inode *inode,
> > +				   struct fsverity_blockbuf *block,
> >  				   unsigned long hblock_idx)
> >  {
> >  	unsigned int blocks_per_page;
> >  	unsigned int i;
> > +	struct fsverity_info *vi = inode->i_verity_info;
> > +	struct page *hpage = (struct page *)block->context;
> >  
> >  	/*
> >  	 * When the Merkle tree block size and page size are the same, then the
> > @@ -34,6 +37,12 @@ static bool is_hash_block_verified(struct fsverity_info *vi, struct page *hpage,
> >  	if (!vi->hash_block_verified)
> >  		return PageChecked(hpage);
> >  
> > +	/*
> > +	 * Filesystems which use block based caching (e.g. XFS) always use
> > +	 * bitmap.
> > +	 */
> > +	if (inode->i_sb->s_vop->read_merkle_tree_block)
> > +		return test_bit(hblock_idx, vi->hash_block_verified);
> >  	/*
> >  	 * When the Merkle tree block size and page size differ, we use a bitmap
> >  	 * to indicate whether each hash block has been verified.
> 
> This is hard to follow because the code goes from handling page-based caching to
> handling block-based caching to handling page-based caching again.  Also, the
> comment says that block-based caching uses the bitmap, but it doesn't give any
> hint at why the bitmap is being handled differently in that case from the
> page-based caching case that also uses the bitmap.
> 
> How about doing something like the following where the block-based caching case
> is handled first, before either block-based caching case:
> 
> 	/*
> 	 * If the filesystem uses block-based caching, then
> 	 * ->hash_block_verified is always used and the filesystem pushes
> 	 * invalidations to it as needed.
> 	 */
> 	if (inode->i_sb->s_vop->read_merkle_tree_block)
> 		return test_bit(hblock_idx, vi->hash_block_verified);
> 
> 	/* Otherwise, the filesystem uses page-based caching. */
> 	hpage = (struct page *)block->context;
> 
> Note, to avoid confusion, the 'hpage' variable shouldn't be set until it's been
> verified that the filesystem is using page-based caching.

(Yep.)

> > @@ -95,15 +104,15 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
> > verify_data_block(struct inode *inode, struct fsverity_info *vi,
> >		  const void *data, u64 data_pos, unsigned long max_ra_pages)
> 
> max_ra_pages should become max_ra_bytes.
> 
> > +	int num_ra_pages;
> 
> unsigned long ra_bytes.  Also, this should be declared in the scope later on
> where it's actually needed.

Agreed.

> > @@ -144,10 +153,11 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
> >  		unsigned long next_hidx;
> >  		unsigned long hblock_idx;
> >  		pgoff_t hpage_idx;
> > +		u64 hblock_pos;
> >  		unsigned int hblock_offset_in_page;
> 
> hpage_idx and hblock_offset_in_page should both go away.
> fsverity_read_merkle_tree_block() should do the conversion to/from pages.
> 
> >  		unsigned int hoffset;
> >  		struct page *hpage;
> > -		const void *haddr;
> > +		struct fsverity_blockbuf *block = &hblocks[level].block;
> >  
> >  		/*
> >  		 * The index of the block in the current level; also the index
> > @@ -165,29 +175,49 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
> >		/* Index of the hash block in the tree overall */
> >		hblock_idx = params->level_start[level] + next_hidx;
> >
> >		/* Byte offset of the hash block within the page */
> >  		hblock_offset_in_page =
> >  			(hblock_idx << params->log_blocksize) & ~PAGE_MASK;
> >  
> > +		/* Offset of the Merkle tree block into the tree */
> > +		hblock_pos = hblock_idx << params->log_blocksize;
> 
> The comment for hblock_pos should say:
> 
> 	/* Byte offset of the hash block in the tree overall */
> 
> ... so that it's consistent with the one for hblock_idx which says:
> 
> 	/* Index of the hash block in the tree overall */
> 
> > +		num_ra_pages = level == 0 ?
> > +			min(max_ra_pages, params->tree_pages - hpage_idx) : 0;
> > +
> > +		if (inode->i_sb->s_vop->read_merkle_tree_block) {
> > +			err = inode->i_sb->s_vop->read_merkle_tree_block(
> > +				inode, hblock_pos, block, params->log_blocksize,
> > +				num_ra_pages);
> > +		} else {
> > +			unsigned int blocks_per_page =
> > +				vi->tree_params.blocks_per_page;
> > +			hblock_idx = round_down(hblock_idx, blocks_per_page);
> > +			hpage = inode->i_sb->s_vop->read_merkle_tree_page(
> > +				inode, hpage_idx, (num_ra_pages << PAGE_SHIFT));
> > +
> > +			if (IS_ERR(hpage)) {
> > +				err = PTR_ERR(hpage);
> > +			} else {
> > +				block->kaddr = kmap_local_page(hpage) +
> > +					hblock_offset_in_page;
> > +				block->context = hpage;
> > +			}
> > +		}
> 
> This has the weirdness with the readahead amount again, where it's still being
> measured in pages.  I think it would make more sense to measure it in bytes.  It
> would stay bytes when passed to ->read_merkle_tree_block, or be converted to
> pages at the last minute for ->read_merkle_tree_page which works in pages.
> 
> > +		if (err) {
> >  			fsverity_err(inode,
> > -				     "Error %ld reading Merkle tree page %lu",
> > -				     PTR_ERR(hpage), hpage_idx);
> > +				     "Error %d reading Merkle tree block %lu",
> > +				     err, hblock_idx);
> >  			goto error;
> >  		}
> 
> This error message should go in fsverity_read_merkle_tree_block().
> 
> Doing that would also eliminate the need to add an 'err' variable to
> verify_data_block(), which could be confusing because it returns a bool.
> 
> >  	/* Descend the tree verifying hash blocks. */
> >  	for (; level > 0; level--) {
> > -		struct page *hpage = hblocks[level - 1].page;
> > -		const void *haddr = hblocks[level - 1].addr;
> > +		struct fsverity_blockbuf *block = &hblocks[level - 1].block;
> > +		const void *haddr = block->kaddr;
> >  		unsigned long hblock_idx = hblocks[level - 1].index;
> >  		unsigned int hoffset = hblocks[level - 1].hoffset;
> > +		struct page *hpage = (struct page *)block->context;
> >  
> >  		if (fsverity_hash_block(params, inode, haddr, real_hash) != 0)
> >  			goto error;
> > @@ -217,8 +248,7 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
> >		if (vi->hash_block_verified)
> >			set_bit(hblock_idx, vi->hash_block_verified);
> >		else
> >  			SetPageChecked(hpage);
> 
> Since the page is only valid when vi->hash_block_verified is NULL, remove the
> hpage variable and do 'SetPageChecked((struct page *)block->context);'.
> Yes, there's no issue until the pointer is actually dereferenced, but it's
> confusing to have incorrectly-typed pointer variables sitting around.
> 
> > +/**
> > + * fsverity_invalidate_block() - invalidate Merkle tree block
> > + * @inode: inode to which this Merkle tree blocks belong
> > + * @block: block to be invalidated
> > + *
> > + * This function invalidates/clears "verified" state of Merkle tree block
> > + * in the fs-verity bitmap. The block needs to have ->offset set.
> > + */
> > +void fsverity_invalidate_block(struct inode *inode,
> > +		struct fsverity_blockbuf *block)
> > +{
> > +	struct fsverity_info *vi = inode->i_verity_info;
> > +	const unsigned int log_blocksize = vi->tree_params.log_blocksize;
> > +
> > +	if (block->offset > vi->tree_params.tree_size) {
> > +		fsverity_err(inode,
> > +"Trying to invalidate beyond Merkle tree (tree %lld, offset %lld)",
> > +			     vi->tree_params.tree_size, block->offset);
> > +		return;
> > +	}
> > +
> > +	clear_bit(block->offset >> log_blocksize, vi->hash_block_verified);
> > +}
> > +EXPORT_SYMBOL_GPL(fsverity_invalidate_block);
> 
> I don't think this function should be using struct fsverity_blockbuf.  It only
> uses the 'offset' field, which is orthogonal to what ->read_merkle_tree_block
> and ->drop_merkle_tree_block use.
> 
> The function name fsverity_invalidate_block() also has the issue where it's not
> clear what type of block it's talking about.
> 
> How about changing the prototype to:
> 
> void fsverity_invalidate_merkle_tree_block(struct inode *inode, u64 pos);
>
> Also, is it a kernel bug for the pos to be beyond the end of the Merkle tree, or
> can it happen in cases like filesystem corruption?  If it can only happen due to
> kernel bugs, WARN_ON_ONCE() might be more appropriate than an error message.

I think XFS only passes to _invalidate_* the same pos that was passed to
->read_merkle_tree_block, so this is a kernel bug, not a fs corruption
problem.

Perhaps this function ought to note that @pos is supposed to be the same
value that was given to ->read_merkle_tree_block?

Or: make the implementations return 1 for "reloaded from disk", 0 for
"still in cache", or a negative error code.  Then fsverity can call
the invalidation routine itself and XFS doesn't have to worry about this
part.

(I think?  I have questions about the xfs_invalidate_blocks function.)

> Please note that there's also an off-by-one error.  pos > tree_size should be
> pos >= tree_size.
> 
> > +void fsverity_drop_block(struct inode *inode,
> > +		struct fsverity_blockbuf *block)
> 
> fsverity_drop_merkle_tree_block
> 
> > +{
> > +	if (inode->i_sb->s_vop->drop_block)
> > +		inode->i_sb->s_vop->drop_block(block);
> > +	else {
> 
> Add braces above.
> 
> (See line 213 of Documentation/process/coding-style.rst)
> 
> > +		struct page *page = (struct page *)block->context;
> > +
> > +		kunmap_local(block->kaddr);
> > +		put_page(page);
> 
> put_page((struct page *)block->context), and remove the page variable
> 
> > +	}
> > +	block->kaddr = NULL;
> 
> Also set block->context = NULL
> 
> > +/**
> > + * struct fsverity_blockbuf - Merkle Tree block buffer
> > + * @kaddr: virtual address of the block's data
> > + * @offset: block's offset into Merkle tree
> > + * @size: the Merkle tree block size
> > + * @context: filesystem private context
> > + *
> > + * Buffer containing single Merkle Tree block. These buffers are passed
> > + *  - to filesystem, when fs-verity is building merkel tree,
> > + *  - from filesystem, when fs-verity is reading merkle tree from a disk.
> > + * Filesystems sets kaddr together with size to point to a memory which contains
> > + * Merkle tree block. Same is done by fs-verity when Merkle tree is need to be
> > + * written down to disk.
> > + *
> > + * While reading the tree, fs-verity calls ->read_merkle_tree_block followed by
> > + * ->drop_block to let filesystem know that memory can be freed.
> > + *
> > + * The context is optional. This field can be used by filesystem to passthrough
> > + * state from ->read_merkle_tree_block to ->drop_block.
> > + */
> > +struct fsverity_blockbuf {
> > +	void *kaddr;
> > +	u64 offset;
> > +	unsigned int size;
> > +	void *context;
> > +};
> 
> If this is only used by ->read_merkle_tree_block and ->drop_merkle_tree_block,
> then it can be simplified.  The only fields needed are kaddr and context.
> 
> The comment also still incorrectly claims that the struct is used for writes.
> 
> > +	/**
> > +	 * Read a Merkle tree block of the given inode.
> > +	 * @inode: the inode
> > +	 * @pos: byte offset of the block within the Merkle tree
> > +	 * @block: block buffer for filesystem to point it to the block
> > +	 * @log_blocksize: log2 of the size of the expected block
> > +	 * @ra_bytes: The number of bytes that should be
> > +	 *		prefetched starting at @pos if the page at @pos
> > +	 *		isn't already cached.  Implementations may ignore this
> > +	 *		argument; it's only a performance optimization.
> > +	 *
> > +	 * This can be called at any time on an open verity file.  It may be
> > +	 * called by multiple processes concurrently.
> > +	 *
> > +	 * In case that block was evicted from the memory filesystem has to use
> > +	 * fsverity_invalidate_block() to let fsverity know that block's
> > +	 * verification state is not valid anymore.

Ah, ok, that's why fsverity_invalidate_block only does one block at a
time.

> > +	 *
> > +	 * Return: 0 on success, -errno on failure
> > +	 */
> > +	int (*read_merkle_tree_block)(struct inode *inode,
> > +				      u64 pos,
> > +				      struct fsverity_blockbuf *block,
> > +				      unsigned int log_blocksize,
> > +				      u64 ra_bytes);
> 
> How about:
> 	
> 	int (*read_merkle_tree_block)(struct inode *inode,
> 				      u64 pos,
> 				      unsigned int size,
> 				      unsigned long ra_bytes,
> 				      struct fsverity_blockbuf *block);
> 
> - size instead of log_blocksize, for consistency with other functions and
>   because it's what XFS actually wants
> 
> - ra_bytes as unsigned long, since u64 readahead amounts don't really make
>   sense.  (This isn't too important though; it could be u64 if you really want.)
> 
> - block at the end since it's an output parameter
> 
> It also needs to be clearly documented that filesystems must implement either
> ->read_merkle_tree_page, *or* both ->read_merkle_tree_block and
> ->drop_merkle_tree_block.
> 
> Also, the comment about invalidating the block is still unclear regarding the
> timing of when the filesystem must do it.
> 
> > +
> > +	/**
> > +	 * Release the reference to a Merkle tree block
> > +	 *
> > +	 * @block: the block to release
> > +	 *
> > +	 * This is called when fs-verity is done with a block obtained with
> > +	 * ->read_merkle_tree_block().
> > +	 */
> > +	void (*drop_block)(struct fsverity_blockbuf *block);
> 
> drop_merkle_tree_block, so that it's clearly paired with read_merkle_tree_block

Yep.  I noticed that xfs_verity.c doesn't put them together, which made
me wonder if the write_merkle_tree_block path made use of that.  It
doesn't, AFAICT.

And I think the reason is that when we're setting up the merkle tree,
we want to stream the contents straight to disk instead of ending up
with a huge cache that might not all be necessary?

--D

> - Eric
> 

