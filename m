Return-Path: <linux-fsdevel+bounces-17673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D228B152D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 23:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E51161C23B04
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 21:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD526156F20;
	Wed, 24 Apr 2024 21:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzY6SBTf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E52213C9DE;
	Wed, 24 Apr 2024 21:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713993925; cv=none; b=HGTQ/hr2sAzxAkEavDZte6jsapfm8Z4wn3vfM0tgXceOcGQFUOdw972aX0gvb/eXiDxbh93xipr50tVyCq0tvS6t6nXtbzjYJH2iszVfmpNyIlSNPELUFj0bhUkJ0rBgi4lPQ1INhqHdMVAg3KCXPCqDSnKOC3cnRsF06cfU2aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713993925; c=relaxed/simple;
	bh=qmoelaSnsv79xA9eO0AeLK2Q3e6NRWKS92bzs2F83Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ll1NonTELUDZiBao0ALfg0JyoUBSzU+pnIOyrWaPUFTVq9mvNhqFVGayX7CobyqEZCGYl+Jp9hHzMJ5bvAONwd7UF2mNbSY01X3G7HPvi1XSDj15exkvKGP6Rs/SgZ0C14wC3G/Lkv6SFKl2uNh7nygoW2O/aqZHl7zmg/L+Khw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzY6SBTf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8A2C113CD;
	Wed, 24 Apr 2024 21:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713993924;
	bh=qmoelaSnsv79xA9eO0AeLK2Q3e6NRWKS92bzs2F83Ew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qzY6SBTfiDMSVU4ueHW8X5i180oTmTP57vBr6VQdOdcvn5FI1TVjjUyMQdqMpihsh
	 c5vq0Es8tY1pxy6It45QmlXJKrev5zpDFdNAf7poVl3F43CKNShpUEIUUyD5JBX+vb
	 89ed/Vomy5VPzhSCuR0WRsHpMaX+PYyY0mNwpVnZJ3DX5VmgPwUxDJafuy9akijnhX
	 idpj2oQmQ11XE9s9z4eFKYXieCyKK2esyU4On68K3RZyefUjXWT9J/u+cZDRwEk5zb
	 kjXI73uCG4I8OGMQzNK7xkxOoIcVWkVuOfib1sYIffEEPS5/UCOqNATUszLf4boYUc
	 qLHwXxfZr9QtA==
Date: Wed, 24 Apr 2024 14:25:23 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: aalbersh@redhat.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 03/13] fsverity: support block-based Merkle tree caching
Message-ID: <20240424212523.GO360919@frogsfrogsfrogs>
References: <171175867829.1987804.15934006844321506283.stgit@frogsfrogsfrogs>
 <171175867913.1987804.4275409634176359386.stgit@frogsfrogsfrogs>
 <20240405023145.GB1958@quark.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405023145.GB1958@quark.localdomain>

On Thu, Apr 04, 2024 at 10:31:45PM -0400, Eric Biggers wrote:
> On Fri, Mar 29, 2024 at 05:33:27PM -0700, Darrick J. Wong wrote:
> > diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
> > index b3506f56e180b..c9d97c2bebd84 100644
> > --- a/fs/verity/fsverity_private.h
> > +++ b/fs/verity/fsverity_private.h
> > @@ -154,4 +154,41 @@ static inline void fsverity_init_signature(void)
> >  
> >  void __init fsverity_init_workqueue(void);
> >  
> > +static inline bool fsverity_caches_blocks(const struct inode *inode)
> > +{
> > +	const struct fsverity_operations *vops = inode->i_sb->s_vop;
> > +
> > +	WARN_ON_ONCE(vops->read_merkle_tree_block &&
> > +		     !vops->drop_merkle_tree_block);
> > +
> > +	return vops->read_merkle_tree_block != NULL;
> > +}
> > +
> > +static inline bool fsverity_uses_bitmap(const struct fsverity_info *vi,
> > +					const struct inode *inode)
> > +{
> > +	if (fsverity_caches_blocks(inode))
> > +		return false;
> > +
> > +	/*
> > +	 * If fs uses block-based Merkle tree caching, then fs-verity must use
> > +	 * hash_block_verified bitmap as there's no page to mark it with
> > +	 * PG_checked.
> > +	 */
> > +	return vi->tree_params.block_size != PAGE_SIZE;
> > +}
> 
> For checking whether the bitmap is in use, it's simpler and more efficient to
> just directly check whether vi->hash_block_verified is NULL, as the existing
> code does.  Only the code that allocates the bitmap actually needs to be aware
> of the details of when the bitmap gets enabled.
> 
> fsverity_caches_blocks() has a similar issue, where it could just be replaced
> with checking vops->read_merkle_tree_block != NULL directly (or equivalently
> vops->drop_merkle_tree_block, which works well in
> fsverity_drop_merkle_tree_block() since that's the function pointer it's
> calling).  The WARN_ON_ONCE() should be done in fsverity_create_info(), not
> inlined multiple times into the verification code.

Ok, I'll move the WARN_ON_ONCE there:

	/*
	 * If the filesystem implementation supplies Merkle tree content on a
	 * per-block basis, it must implement both the read and drop functions.
	 * If it supplies content on a per-page basis, neither should be
	 * provided.
	 */
	if (vops->read_merkle_tree_block)
		WARN_ON_ONCE(vops->drop_merkle_tree_block == NULL);
	else
		WARN_ON_ONCE(vops->drop_merkle_tree_block != NULL);


> (I think the name "fsverity_caches_blocks()" is also confusing because the
> fsverity support layer does not cache blocks, but all the filesystems do.  What
> it's actually trying to convey is a difference in how the filesystem caches the
> blocks, which I don't think it does a good job at.)

Ok, I'll drop both and open-code them with nicer comments.

> > +int fsverity_read_merkle_tree_block(struct inode *inode,
> > +				    const struct merkle_tree_params *params,
> > +				    u64 pos, unsigned long ra_bytes,
> > +				    struct fsverity_blockbuf *block);
> > +
> > +/*
> > + * Drop 'block' obtained with ->read_merkle_tree_block(). Calls out back to
> > + * filesystem if ->drop_merkle_tree_block() is set, otherwise, drop the
> > + * reference in the block->context.
> 
> "drop the reference" => "drops the reference"

Fixed.

> > +	/*
> > +	 * If fs uses block-based Merkle tree cachin, then fs-verity must use
> > +	 * hash_block_verified bitmap as there's no page to mark it with
> > +	 * PG_checked.
> > +	 */
> > +	if (fsverity_uses_bitmap(vi, inode)) {
> 
> The comment contradicts the code.

Urrrk, yes, it does. Sorry about that.

	/*
	 * If the fs supplies Merkle tree blocks on a per-page basis and the
	 * page size doesn't match the block size, fs-verity must use the
	 * hash_block_verified bitmap instead of PG_checked.
	 */
	if (vops->read_merkle_tree_block == NULL &&
	    vi->tree_params.block_size != PAGE_SIZE) {

		...allocate bitmap...
	}

> 
> > diff --git a/fs/verity/read_metadata.c b/fs/verity/read_metadata.c
> > index f58432772d9ea..94fffa060f829 100644
> > --- a/fs/verity/read_metadata.c
> > +++ b/fs/verity/read_metadata.c
> > @@ -14,65 +14,60 @@
> >  
> >  static int fsverity_read_merkle_tree(struct inode *inode,
> >  				     const struct fsverity_info *vi,
> > -				     void __user *buf, u64 offset, int length)
> > +				     void __user *buf, u64 pos, int length)
> >  {
> > -	const struct fsverity_operations *vops = inode->i_sb->s_vop;
> > -	u64 end_offset;
> > -	unsigned int offs_in_page;
> > -	pgoff_t index, last_index;
> > +	const u64 end_pos = min(pos + length, vi->tree_params.tree_size);
> > +	const struct merkle_tree_params *params = &vi->tree_params;
> > +	unsigned int offs_in_block = pos & (params->block_size - 1);
> >  	int retval = 0;
> >  	int err = 0;
> >  
> > -	end_offset = min(offset + length, vi->tree_params.tree_size);
> > -	if (offset >= end_offset)
> > +	if (pos >= end_pos)
> >  		return 0;
> 
> The above 'pos >= end_pos' check is no longer necessary.

Aha, good catch.

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
> > -		unsigned long num_ra_pages =
> > -			min_t(unsigned long, last_index - index + 1,
> > -			      inode->i_sb->s_bdi->io_pages);
> > -		unsigned int bytes_to_copy = min_t(u64, end_offset - offset,
> > -						   PAGE_SIZE - offs_in_page);
> > -		struct page *page;
> > -		const void *virt;
> > +	while (pos < end_pos) {
> > +		unsigned long ra_bytes;
> > +		unsigned int bytes_to_copy;
> > +		struct fsverity_blockbuf block = {
> > +			.size = params->block_size,
> > +		};
> >  
> > -		page = vops->read_merkle_tree_page(inode, index, num_ra_pages);
> > -		if (IS_ERR(page)) {
> > -			err = PTR_ERR(page);
> > +		ra_bytes = min_t(unsigned long, end_pos - pos + 1,
> > +				 inode->i_sb->s_bdi->io_pages << PAGE_SHIFT);
> 
> This introduces an off-by-one error in the calculation of ra_bytes.  end_pos
> is exclusive, but the calculation of ra_bytes assumes it is inclusive.
> 
> Also, might io_pages << PAGE_SHIFT overflow an unsigned long?

I hope not -- max io and readahead should never be 4GB.  I'm a little
surprised this isn't s_bdi->ra_pages.

	struct backing_dev_info *bdi = inode->i_sb->s_bdi;
	const u64 max_ra_bytes = min((u64)bdi->io_pages << PAGE_SHIFT,
				     ULONG_MAX);

	while (pos < end_pos) {
		ra_bytes = min_t(unsigned long, end_pos - pos, max_ra_bytes);

> > +		bytes_to_copy = min_t(u64, end_pos - pos,
> > +				      params->block_size - offs_in_block);
> > +
> > +		err = fsverity_read_merkle_tree_block(inode, &vi->tree_params,
> > +				pos - offs_in_block, ra_bytes, &block);
> > +		if (err) {
> >  			fsverity_err(inode,
> > -				     "Error %d reading Merkle tree page %lu",
> > -				     err, index);
> > +				     "Error %d reading Merkle tree block %llu",
> > +				     err, pos);
> >  			break;
> 
> The error message should go into fsverity_read_merkle_tree_block() so that it
> does not need to be duplicated in its two callers.  This would, additionally,
> eliminate the need to introduce the 'err' variable in verify_data_block().

Do you want that to be a separate cleanup patch?

> > diff --git a/fs/verity/verify.c b/fs/verity/verify.c
> > index 4fcad0825a120..0b5e11073e883 100644
> > --- a/fs/verity/verify.c
> > +++ b/fs/verity/verify.c
> > @@ -13,14 +13,27 @@
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
> 
> The comment should be updated to mention @block.

I'll mention @inode too:

/*
 * Returns true if the hash @block with index @hblock_idx in the merkle tree
 * for @inode has already been verified.
 */


> > @@ -143,11 +156,9 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
> >  	for (level = 0; level < params->num_levels; level++) {
> >  		unsigned long next_hidx;
> >  		unsigned long hblock_idx;
> > -		pgoff_t hpage_idx;
> > -		unsigned int hblock_offset_in_page;
> > +		u64 hblock_pos;
> >  		unsigned int hoffset;
> > -		struct page *hpage;
> > -		const void *haddr;
> > +		struct fsverity_blockbuf *block = &hblocks[level].block;
> >  
> >  		/*
> >  		 * The index of the block in the current level; also the index
> > @@ -158,36 +169,34 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
> >  		/* Index of the hash block in the tree overall */
> >  		hblock_idx = params->level_start[level] + next_hidx;
> >  
> > -		/* Index of the hash page in the tree overall */
> > -		hpage_idx = hblock_idx >> params->log_blocks_per_page;
> > -
> > -		/* Byte offset of the hash block within the page */
> > -		hblock_offset_in_page =
> > -			(hblock_idx << params->log_blocksize) & ~PAGE_MASK;
> > +		/* Byte offset of the hash block in the tree overall */
> > +		hblock_pos = hblock_idx << params->log_blocksize;
> 
> 'hblock_idx << params->log_blocksize' may overflow an unsigned long, so
> 'hblock_idx' needs to be cast to u64 before doing the shift.

Fixed.

> > +		if (level == 0)
> > +			ra_bytes = min(max_ra_bytes,
> > +				       params->tree_size - hblock_pos);
> > +		else
> > +			ra_bytes = 0;
> 
> The first argument to min() has type unsigned long, and the second has type u64.
> Doesn't this generate a warning on 32-bit systems?

Probably.  I'll turn it into a min_t(u64...).

> > @@ -325,7 +333,7 @@ void fsverity_verify_bio(struct bio *bio)
> >  
> >  	bio_for_each_folio_all(fi, bio) {
> >  		if (!verify_data_blocks(fi.folio, fi.length, fi.offset,
> > -					max_ra_pages)) {
> > +					max_ra_pages << PAGE_SHIFT)) {
> >  			bio->bi_status = BLK_STS_IOERR;
> >  			break;
> 
> This function should calculate max_ra_bytes as bio->bi_iter.bi_size >> 2.  It's
> not necessary to convert to pages, then back to bytes again.

Aha, Andrey and I missed that.  Fixed.

> > +/**
> > + * fsverity_read_merkle_tree_block() - read Merkle tree block
> > + * @inode: inode to which this Merkle tree blocks belong
> 
> "this Merkle tree blocks belong" => "this Merkle tree block belongs"
> 
> > + * @params: merkle tree parameters
> > + * @pos: byte position within merkle tree
> > + * @ra_bytes: try to read ahead this many btes
> 
> "btes" => "bytes"

Both fixed.

> > +int fsverity_read_merkle_tree_block(struct inode *inode,
> > +				    const struct merkle_tree_params *params,
> > +				    u64 pos, unsigned long ra_bytes,
> > +				    struct fsverity_blockbuf *block)
> > +{
> > +	const struct fsverity_operations *vops = inode->i_sb->s_vop;
> > +	unsigned long page_idx;
> > +	struct page *page;
> > +	unsigned long index;
> > +	unsigned int offset_in_page;
> > +
> > +	if (fsverity_caches_blocks(inode)) {
> > +		block->verified = false;
> > +		return vops->read_merkle_tree_block(inode, pos, ra_bytes,
> > +				params->log_blocksize, block);
> > +	}
> > +
> > +	index = pos >> params->log_blocksize;
> 
> Should the fourth parameter to ->read_merkle_tree_block be the block index
> (which is computed above) instead of log_blocksize?  XFS only uses
> params->log_blocksize to compute the block index anyway.

I don't know.  XFS is infamous for everyone having a different opinion
and developers being unable to drive a consensus and being able to get a
patchset to completion.  So:

Andrey wrote an implementation that used the buffer cache and used block
indexes to load/store from the xattr structure.  I didn't like that
because layering violation.

willy suggested hanging an xarray off struct xfs_inode and using that to
cache merkle tree blocks.  For that design, we want the xarray indexes
in units of blocks to conserve space, which means passing in (pos,
log_blocksize) or a direct block index.

Christoph then suggested using a per-AG rhashtable to reduce per-inode
memory overhead, in which case the lookup key can be either (inumber,
pos) or (inumber, block index).  This is a better design if there aren't
really going to be that many xfs inodes with verity enabled, though we
lose per-inode sharding of the merkle blocks.

Dave thinks that verity inodes could constitute the majority of xfs
inodes some day and it should be in the inode instead.

Andrey and I do not have crystal balls, we have no idea how this
dchinner/hch disagreement will play out.  Earlier I got the sense that
you wanted to move towards expressing all the merkle tree info in units
of bytes.

In a lot of ways it would be preferable to move to block indexes
instead, since there's never going to be a meaningful access to merkle
position 1337.  But you're the maintainer, so it's up to you. :)

> > +/**
> > + * struct fsverity_blockbuf - Merkle Tree block buffer
> > + * @kaddr: virtual address of the block's data
> > + * @offset: block's offset into Merkle tree
> > + * @size: the Merkle tree block size
> > + * @context: filesystem private context
> > + * @verified: has this buffer been validated?
> > + *
> > + * Buffer containing single Merkle Tree block. These buffers are passed
> > + *  - to filesystem, when fs-verity is building merkel tree,
> > + *  - from filesystem, when fs-verity is reading merkle tree from a disk.
> > + * Filesystems sets kaddr together with size to point to a memory which contains
> > + * Merkle tree block. Same is done by fs-verity when Merkle tree is need to be
> > + * written down to disk.
> 
> This comment still incorrectly claims that fsverity_blockbuf is being used for
> writes.

Oops, I forgot to delete that.

--D

> 
> - Eric
> 

