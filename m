Return-Path: <linux-fsdevel+bounces-20674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CD78D6B94
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 23:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBCF0B24286
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 21:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285D27E776;
	Fri, 31 May 2024 21:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFDxO43X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BD9182B9;
	Fri, 31 May 2024 21:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717191133; cv=none; b=RwewkJcF9s61Fbd+/APQnPKbuYkQScSg6qT89vbz95zwKKTgilbzEygFdCDcLmEoyI47z8RbNZf8/9sjdDvaJ00hDcytuHpnlUqAhJMrbN/7eSu6tfUqIG89KbUBu3g2QNLSsOQfcs240geGbUPiAC9go0Y0v87OYtJ+W7ft2Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717191133; c=relaxed/simple;
	bh=U/AwVpK3shw0pohBz82pstk3y7QctajGGK6WiiFksd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KcbDYzTz1CY5ksZ0F5ea1dHwyaKaVwYgel3tU2g4ytJ0dtCe+yvAWDUvdBloES8q6wuRTfjlyL8Pu9ZCEybN0QIIJAet3onkqFx79J9743bqZq+fxF7P7YvRajq+7dNrP1jmt3aAOrvVrUUr6iXOrKZCv2+BZqUnFjQDo1K+AzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFDxO43X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519E0C116B1;
	Fri, 31 May 2024 21:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717191133;
	bh=U/AwVpK3shw0pohBz82pstk3y7QctajGGK6WiiFksd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IFDxO43X3mDTaRbE1ulHsQsyEkg0dEND9c9NDRyZ9UbeUTUiaLzEAoKyZZYSe+ElN
	 GZNbuOFyyp6CYzieVBE6idPPllGd6GRxpgutlDDeW5qiGsPLiYl2SqeFxCs0Qw856u
	 AznDzG43xRhM4zKDTwiPG2q4e+FwAwf1bwCAZmxaEgIBl5Sif/cKWb0FSllpVCOsBZ
	 qnZcNruzALu2xt9PoeLqldHMDmX3wsc1nmEPaqA89f2WTxiRS05KQxgYQJ2zg8T8AU
	 8GsZad+BbTOjxwaXuF3nHk8qdB/a9Y3eG6AQ4haJSaCeyRziR7f/22rzuVwgp8WYHH
	 r4NfHu6Aw/PfA==
Date: Fri, 31 May 2024 14:32:12 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, Andrey Albershteyn <aalbersh@redhat.com>
Subject: Re: [PATCH] fsverity: support block-based Merkle tree caching
Message-ID: <20240531213212.GV52987@frogsfrogsfrogs>
References: <20240515015320.323443-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515015320.323443-1-ebiggers@kernel.org>

On Tue, May 14, 2024 at 06:53:20PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Currently fs/verity/ assumes that filesystems cache Merkle tree blocks
> in the page cache.  Specifically, it requires that filesystems provide a
> ->read_merkle_tree_page() method which returns a page of blocks.  It
> also stores the "is the block verified" flag in PG_checked, or (if there
> are multiple blocks per page) in a bitmap, with PG_checked used to
> detect cache evictions instead.  This solution is specific to the page
> cache, as a different cache would store the flag in a different way.
> 
> To allow XFS to use a custom Merkle tree block cache, this patch
> refactors the Merkle tree caching interface to be based around the
> concept of reading and dropping blocks (not pages), where the storage of
> the "is the block verified" flag is up to the implementation.
> 
> The existing pagecache based solution, used by ext4, f2fs, and btrfs, is
> reimplemented using this interface.
> 
> Co-developed-by: Andrey Albershteyn <aalbersh@redhat.com>
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> Co-developed-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
> 
> This reworks the block-based caching patch to clean up many different
> things, including putting the pagecache based caching behind the same
> interface as suggested by Christoph.

I gather this means that you ported btrfs/f2fs/ext4 to use the read/drop
merkle_tree_block interfaces?

>                                       This applies to mainline commit
> a5131c3fdf26.  It corresponds to the following patches in Darrick's v5.6
> patchset:
> 
>     fsverity: convert verification to use byte instead of page offsets
>     fsverity: support block-based Merkle tree caching
>     fsverity: pass the merkle tree block level to fsverity_read_merkle_tree_block
>     fsverity: pass the zero-hash value to the implementation
> 
> (I don't really understand the split between the first two, as I see
> them as being logically part of the same change.  The new parameters
> would make sense to split out though.)

I separated the first two to reduce the mental burden of rebasing these
patches against new -rc1 kernels.  It's a lot less effort if one only
has to concentrate on one aspect at a time.  You might have heard that
it's difficult to add an xfs feature without it taking multiple kernel
cycles.

(That said, 6.10 wasn't bad at all.)

--D

> If we do go with my version of the patch, also let me know if there are
> any preferences for who should be author / co-developer / etc.
> 
>  fs/btrfs/verity.c            |  36 +++---
>  fs/ext4/verity.c             |  20 ++--
>  fs/f2fs/verity.c             |  20 ++--
>  fs/verity/fsverity_private.h |  13 ++-
>  fs/verity/open.c             |  38 ++++--
>  fs/verity/read_metadata.c    |  68 +++++------
>  fs/verity/verify.c           | 216 +++++++++++++++++++++++++----------
>  include/linux/fsverity.h     | 112 +++++++++++++++---
>  8 files changed, 366 insertions(+), 157 deletions(-)
> 
> diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
> index 4042dd6437ae..c4ecae418669 100644
> --- a/fs/btrfs/verity.c
> +++ b/fs/btrfs/verity.c
> @@ -699,33 +699,28 @@ int btrfs_get_verity_descriptor(struct inode *inode, void *buf, size_t buf_size)
>  }
>  
>  /*
>   * fsverity op that reads and caches a merkle tree page.
>   *
> - * @inode:         inode to read a merkle tree page for
> - * @index:         page index relative to the start of the merkle tree
> - * @num_ra_pages:  number of pages to readahead. Optional, we ignore it
> - *
>   * The Merkle tree is stored in the filesystem btree, but its pages are cached
>   * with a logical position past EOF in the inode's mapping.
> - *
> - * Returns the page we read, or an ERR_PTR on error.
>   */
> -static struct page *btrfs_read_merkle_tree_page(struct inode *inode,
> -						pgoff_t index,
> -						unsigned long num_ra_pages)
> +static int btrfs_read_merkle_tree_block(const struct fsverity_readmerkle *req,
> +					struct fsverity_blockbuf *block)
>  {
> +	struct inode *inode = req->inode;
>  	struct folio *folio;
> -	u64 off = (u64)index << PAGE_SHIFT;
> +	u64 off = req->pos;
>  	loff_t merkle_pos = merkle_file_pos(inode);
> +	pgoff_t index;
>  	int ret;
>  
>  	if (merkle_pos < 0)
> -		return ERR_PTR(merkle_pos);
> +		return merkle_pos;
>  	if (merkle_pos > inode->i_sb->s_maxbytes - off - PAGE_SIZE)
> -		return ERR_PTR(-EFBIG);
> -	index += merkle_pos >> PAGE_SHIFT;
> +		return -EFBIG;
> +	index = (merkle_pos + off) >> PAGE_SHIFT;
>  again:
>  	folio = __filemap_get_folio(inode->i_mapping, index, FGP_ACCESSED, 0);
>  	if (!IS_ERR(folio)) {
>  		if (folio_test_uptodate(folio))
>  			goto out;
> @@ -733,28 +728,28 @@ static struct page *btrfs_read_merkle_tree_page(struct inode *inode,
>  		folio_lock(folio);
>  		/* If it's not uptodate after we have the lock, we got a read error. */
>  		if (!folio_test_uptodate(folio)) {
>  			folio_unlock(folio);
>  			folio_put(folio);
> -			return ERR_PTR(-EIO);
> +			return -EIO;
>  		}
>  		folio_unlock(folio);
>  		goto out;
>  	}
>  
>  	folio = filemap_alloc_folio(mapping_gfp_constraint(inode->i_mapping, ~__GFP_FS),
>  				    0);
>  	if (!folio)
> -		return ERR_PTR(-ENOMEM);
> +		return -ENOMEM;
>  
>  	ret = filemap_add_folio(inode->i_mapping, folio, index, GFP_NOFS);
>  	if (ret) {
>  		folio_put(folio);
>  		/* Did someone else insert a folio here? */
>  		if (ret == -EEXIST)
>  			goto again;
> -		return ERR_PTR(ret);
> +		return ret;
>  	}
>  
>  	/*
>  	 * Merkle item keys are indexed from byte 0 in the merkle tree.
>  	 * They have the form:
> @@ -763,20 +758,21 @@ static struct page *btrfs_read_merkle_tree_page(struct inode *inode,
>  	 */
>  	ret = read_key_bytes(BTRFS_I(inode), BTRFS_VERITY_MERKLE_ITEM_KEY, off,
>  			     folio_address(folio), PAGE_SIZE, &folio->page);
>  	if (ret < 0) {
>  		folio_put(folio);
> -		return ERR_PTR(ret);
> +		return ret;
>  	}
>  	if (ret < PAGE_SIZE)
>  		folio_zero_segment(folio, ret, PAGE_SIZE);
>  
>  	folio_mark_uptodate(folio);
>  	folio_unlock(folio);
>  
>  out:
> -	return folio_file_page(folio, index);
> +	fsverity_set_block_page(req, block, folio_file_page(folio, index));
> +	return 0;
>  }
>  
>  /*
>   * fsverity op that writes a Merkle tree block into the btree.
>   *
> @@ -800,11 +796,13 @@ static int btrfs_write_merkle_tree_block(struct inode *inode, const void *buf,
>  	return write_key_bytes(BTRFS_I(inode), BTRFS_VERITY_MERKLE_ITEM_KEY,
>  			       pos, buf, size);
>  }
>  
>  const struct fsverity_operations btrfs_verityops = {
> +	.uses_page_based_merkle_caching = 1,
>  	.begin_enable_verity     = btrfs_begin_enable_verity,
>  	.end_enable_verity       = btrfs_end_enable_verity,
>  	.get_verity_descriptor   = btrfs_get_verity_descriptor,
> -	.read_merkle_tree_page   = btrfs_read_merkle_tree_page,
> +	.read_merkle_tree_block  = btrfs_read_merkle_tree_block,
> +	.drop_merkle_tree_block  = fsverity_drop_page_merkle_tree_block,
>  	.write_merkle_tree_block = btrfs_write_merkle_tree_block,
>  };
> diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
> index 2f37e1ea3955..5a3a3991d661 100644
> --- a/fs/ext4/verity.c
> +++ b/fs/ext4/verity.c
> @@ -355,31 +355,33 @@ static int ext4_get_verity_descriptor(struct inode *inode, void *buf,
>  			return err;
>  	}
>  	return desc_size;
>  }
>  
> -static struct page *ext4_read_merkle_tree_page(struct inode *inode,
> -					       pgoff_t index,
> -					       unsigned long num_ra_pages)
> +static int ext4_read_merkle_tree_block(const struct fsverity_readmerkle *req,
> +				       struct fsverity_blockbuf *block)
>  {
> +	struct inode *inode = req->inode;
> +	pgoff_t index = (req->pos +
> +			 ext4_verity_metadata_pos(inode)) >> PAGE_SHIFT;
> +	unsigned long num_ra_pages = req->ra_bytes >> PAGE_SHIFT;
>  	struct folio *folio;
>  
> -	index += ext4_verity_metadata_pos(inode) >> PAGE_SHIFT;
> -
>  	folio = __filemap_get_folio(inode->i_mapping, index, FGP_ACCESSED, 0);
>  	if (IS_ERR(folio) || !folio_test_uptodate(folio)) {
>  		DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, index);
>  
>  		if (!IS_ERR(folio))
>  			folio_put(folio);
>  		else if (num_ra_pages > 1)
>  			page_cache_ra_unbounded(&ractl, num_ra_pages, 0);
>  		folio = read_mapping_folio(inode->i_mapping, index, NULL);
>  		if (IS_ERR(folio))
> -			return ERR_CAST(folio);
> +			return PTR_ERR(folio);
>  	}
> -	return folio_file_page(folio, index);
> +	fsverity_set_block_page(req, block, folio_file_page(folio, index));
> +	return 0;
>  }
>  
>  static int ext4_write_merkle_tree_block(struct inode *inode, const void *buf,
>  					u64 pos, unsigned int size)
>  {
> @@ -387,11 +389,13 @@ static int ext4_write_merkle_tree_block(struct inode *inode, const void *buf,
>  
>  	return pagecache_write(inode, buf, size, pos);
>  }
>  
>  const struct fsverity_operations ext4_verityops = {
> +	.uses_page_based_merkle_caching = 1,
>  	.begin_enable_verity	= ext4_begin_enable_verity,
>  	.end_enable_verity	= ext4_end_enable_verity,
>  	.get_verity_descriptor	= ext4_get_verity_descriptor,
> -	.read_merkle_tree_page	= ext4_read_merkle_tree_page,
> +	.read_merkle_tree_block	= ext4_read_merkle_tree_block,
> +	.drop_merkle_tree_block	= fsverity_drop_page_merkle_tree_block,
>  	.write_merkle_tree_block = ext4_write_merkle_tree_block,
>  };
> diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
> index f7bb0c54502c..859ab2d8d734 100644
> --- a/fs/f2fs/verity.c
> +++ b/fs/f2fs/verity.c
> @@ -252,31 +252,33 @@ static int f2fs_get_verity_descriptor(struct inode *inode, void *buf,
>  			return res;
>  	}
>  	return size;
>  }
>  
> -static struct page *f2fs_read_merkle_tree_page(struct inode *inode,
> -					       pgoff_t index,
> -					       unsigned long num_ra_pages)
> +static int f2fs_read_merkle_tree_block(const struct fsverity_readmerkle *req,
> +				       struct fsverity_blockbuf *block)
>  {
> +	struct inode *inode = req->inode;
> +	pgoff_t index = (req->pos +
> +			 f2fs_verity_metadata_pos(inode)) >> PAGE_SHIFT;
> +	unsigned long num_ra_pages = req->ra_bytes >> PAGE_SHIFT;
>  	struct folio *folio;
>  
> -	index += f2fs_verity_metadata_pos(inode) >> PAGE_SHIFT;
> -
>  	folio = __filemap_get_folio(inode->i_mapping, index, FGP_ACCESSED, 0);
>  	if (IS_ERR(folio) || !folio_test_uptodate(folio)) {
>  		DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, index);
>  
>  		if (!IS_ERR(folio))
>  			folio_put(folio);
>  		else if (num_ra_pages > 1)
>  			page_cache_ra_unbounded(&ractl, num_ra_pages, 0);
>  		folio = read_mapping_folio(inode->i_mapping, index, NULL);
>  		if (IS_ERR(folio))
> -			return ERR_CAST(folio);
> +			return PTR_ERR(folio);
>  	}
> -	return folio_file_page(folio, index);
> +	fsverity_set_block_page(req, block, folio_file_page(folio, index));
> +	return 0;
>  }
>  
>  static int f2fs_write_merkle_tree_block(struct inode *inode, const void *buf,
>  					u64 pos, unsigned int size)
>  {
> @@ -284,11 +286,13 @@ static int f2fs_write_merkle_tree_block(struct inode *inode, const void *buf,
>  
>  	return pagecache_write(inode, buf, size, pos);
>  }
>  
>  const struct fsverity_operations f2fs_verityops = {
> +	.uses_page_based_merkle_caching = 1,
>  	.begin_enable_verity	= f2fs_begin_enable_verity,
>  	.end_enable_verity	= f2fs_end_enable_verity,
>  	.get_verity_descriptor	= f2fs_get_verity_descriptor,
> -	.read_merkle_tree_page	= f2fs_read_merkle_tree_page,
> +	.read_merkle_tree_block	= f2fs_read_merkle_tree_block,
> +	.drop_merkle_tree_block	= fsverity_drop_page_merkle_tree_block,
>  	.write_merkle_tree_block = f2fs_write_merkle_tree_block,
>  };
> diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
> index b3506f56e180..da8ba0d626d6 100644
> --- a/fs/verity/fsverity_private.h
> +++ b/fs/verity/fsverity_private.h
> @@ -45,10 +45,13 @@ struct merkle_tree_params {
>  	u8 log_blocks_per_page;		/* log2(blocks_per_page) */
>  	unsigned int num_levels;	/* number of levels in Merkle tree */
>  	u64 tree_size;			/* Merkle tree size in bytes */
>  	unsigned long tree_pages;	/* Merkle tree size in pages */
>  
> +	/* The hash of a merkle block-sized buffer of zeroes */
> +	u8 zero_digest[FS_VERITY_MAX_DIGEST_SIZE];
> +
>  	/*
>  	 * Starting block index for each tree level, ordered from leaf level (0)
>  	 * to root level ('num_levels - 1')
>  	 */
>  	unsigned long level_start[FS_VERITY_MAX_LEVELS];
> @@ -59,11 +62,11 @@ struct merkle_tree_params {
>   *
>   * When a verity file is first opened, an instance of this struct is allocated
>   * and stored in ->i_verity_info; it remains until the inode is evicted.  It
>   * caches information about the Merkle tree that's needed to efficiently verify
>   * data read from the file.  It also caches the file digest.  The Merkle tree
> - * pages themselves are not cached here, but the filesystem may cache them.
> + * blocks themselves are not cached here, but the filesystem may cache them.
>   */
>  struct fsverity_info {
>  	struct merkle_tree_params tree_params;
>  	u8 root_hash[FS_VERITY_MAX_DIGEST_SIZE];
>  	u8 file_digest[FS_VERITY_MAX_DIGEST_SIZE];
> @@ -150,8 +153,16 @@ static inline void fsverity_init_signature(void)
>  }
>  #endif /* !CONFIG_FS_VERITY_BUILTIN_SIGNATURES */
>  
>  /* verify.c */
>  
> +int fsverity_read_merkle_tree_block(struct inode *inode,
> +				    const struct merkle_tree_params *params,
> +				    int level, u64 pos, unsigned long ra_bytes,
> +				    struct fsverity_blockbuf *block);
> +
> +void fsverity_drop_merkle_tree_block(struct inode *inode,
> +				     struct fsverity_blockbuf *block);
> +
>  void __init fsverity_init_workqueue(void);
>  
>  #endif /* _FSVERITY_PRIVATE_H */
> diff --git a/fs/verity/open.c b/fs/verity/open.c
> index fdeb95eca3af..daa37007adfd 100644
> --- a/fs/verity/open.c
> +++ b/fs/verity/open.c
> @@ -10,10 +10,22 @@
>  #include <linux/mm.h>
>  #include <linux/slab.h>
>  
>  static struct kmem_cache *fsverity_info_cachep;
>  
> +/*
> + * If the filesystem caches Merkle tree blocks in the pagecache, and the Merkle
> + * tree block size differs from the page size, then a bitmap is needed to keep
> + * track of which hash blocks have been verified.
> + */
> +static bool needs_bitmap(const struct inode *inode,
> +			 const struct merkle_tree_params *params)
> +{
> +	return inode->i_sb->s_vop->uses_page_based_merkle_caching &&
> +		params->block_size != PAGE_SIZE;
> +}
> +
>  /**
>   * fsverity_init_merkle_tree_params() - initialize Merkle tree parameters
>   * @params: the parameters struct to initialize
>   * @inode: the inode for which the Merkle tree is being built
>   * @hash_algorithm: number of hash algorithm to use
> @@ -124,28 +136,36 @@ int fsverity_init_merkle_tree_params(struct merkle_tree_params *params,
>  		params->level_start[level] = offset;
>  		offset += blocks_in_level[level];
>  	}
>  
>  	/*
> -	 * With block_size != PAGE_SIZE, an in-memory bitmap will need to be
> -	 * allocated to track the "verified" status of hash blocks.  Don't allow
> -	 * this bitmap to get too large.  For now, limit it to 1 MiB, which
> -	 * limits the file size to about 4.4 TB with SHA-256 and 4K blocks.
> +	 * If an in-memory bitmap will need to be allocated to track the
> +	 * "verified" status of hash blocks, don't allow this bitmap to get too
> +	 * large.  For now, limit it to 1 MiB, which limits the file size to
> +	 * about 4.4 TB with SHA-256 and 4K blocks.
>  	 *
>  	 * Together with the fact that the data, and thus also the Merkle tree,
>  	 * cannot have more than ULONG_MAX pages, this implies that hash block
>  	 * indices can always fit in an 'unsigned long'.  But to be safe, we
>  	 * explicitly check for that too.  Note, this is only for hash block
>  	 * indices; data block indices might not fit in an 'unsigned long'.
>  	 */
> -	if ((params->block_size != PAGE_SIZE && offset > 1 << 23) ||
> +	if ((needs_bitmap(inode, params) && offset > 1 << 23) ||
>  	    offset > ULONG_MAX) {
>  		fsverity_err(inode, "Too many blocks in Merkle tree");
>  		err = -EFBIG;
>  		goto out_err;
>  	}
>  
> +	/* Calculate the digest of the all-zeroes block. */
> +	err = fsverity_hash_block(params, inode, page_address(ZERO_PAGE(0)),
> +				  params->zero_digest);
> +	if (err) {
> +		fsverity_err(inode, "Error %d computing zero digest", err);
> +		goto out_err;
> +	}
> +
>  	params->tree_size = offset << log_blocksize;
>  	params->tree_pages = PAGE_ALIGN(params->tree_size) >> PAGE_SHIFT;
>  	return 0;
>  
>  out_err:
> @@ -211,16 +231,14 @@ struct fsverity_info *fsverity_create_info(const struct inode *inode,
>  	err = fsverity_verify_signature(vi, desc->signature,
>  					le32_to_cpu(desc->sig_size));
>  	if (err)
>  		goto fail;
>  
> -	if (vi->tree_params.block_size != PAGE_SIZE) {
> +	if (needs_bitmap(inode, &vi->tree_params)) {
>  		/*
> -		 * When the Merkle tree block size and page size differ, we use
> -		 * a bitmap to keep track of which hash blocks have been
> -		 * verified.  This bitmap must contain one bit per hash block,
> -		 * including alignment to a page boundary at the end.
> +		 * The bitmap must contain one bit per hash block, including
> +		 * alignment to a page boundary at the end.
>  		 *
>  		 * Eventually, to support extremely large files in an efficient
>  		 * way, it might be necessary to make pages of this bitmap
>  		 * reclaimable.  But for now, simply allocating the whole bitmap
>  		 * is a simple solution that works well on the files on which
> diff --git a/fs/verity/read_metadata.c b/fs/verity/read_metadata.c
> index f58432772d9e..61f419df1ea1 100644
> --- a/fs/verity/read_metadata.c
> +++ b/fs/verity/read_metadata.c
> @@ -12,69 +12,59 @@
>  #include <linux/sched/signal.h>
>  #include <linux/uaccess.h>
>  
>  static int fsverity_read_merkle_tree(struct inode *inode,
>  				     const struct fsverity_info *vi,
> -				     void __user *buf, u64 offset, int length)
> +				     void __user *buf, u64 pos, int length)
>  {
> -	const struct fsverity_operations *vops = inode->i_sb->s_vop;
> -	u64 end_offset;
> -	unsigned int offs_in_page;
> -	pgoff_t index, last_index;
> +	const struct merkle_tree_params *params = &vi->tree_params;
> +	const u64 end_pos = min(pos + length, params->tree_size);
> +	struct backing_dev_info *bdi = inode->i_sb->s_bdi;
> +	const unsigned long max_ra_bytes =
> +		min_t(u64, (u64)bdi->io_pages << PAGE_SHIFT, ULONG_MAX);
> +	unsigned int offs_in_block = pos & (params->block_size - 1);
>  	int retval = 0;
>  	int err = 0;
>  
> -	end_offset = min(offset + length, vi->tree_params.tree_size);
> -	if (offset >= end_offset)
> -		return 0;
> -	offs_in_page = offset_in_page(offset);
> -	last_index = (end_offset - 1) >> PAGE_SHIFT;
> -
>  	/*
> -	 * Iterate through each Merkle tree page in the requested range and copy
> -	 * the requested portion to userspace.  Note that the Merkle tree block
> -	 * size isn't important here, as we are returning a byte stream; i.e.,
> -	 * we can just work with pages even if the tree block size != PAGE_SIZE.
> +	 * Iterate through each Merkle tree block in the requested range and
> +	 * copy the requested portion to userspace.
>  	 */
> -	for (index = offset >> PAGE_SHIFT; index <= last_index; index++) {
> -		unsigned long num_ra_pages =
> -			min_t(unsigned long, last_index - index + 1,
> -			      inode->i_sb->s_bdi->io_pages);
> -		unsigned int bytes_to_copy = min_t(u64, end_offset - offset,
> -						   PAGE_SIZE - offs_in_page);
> -		struct page *page;
> -		const void *virt;
> -
> -		page = vops->read_merkle_tree_page(inode, index, num_ra_pages);
> -		if (IS_ERR(page)) {
> -			err = PTR_ERR(page);
> -			fsverity_err(inode,
> -				     "Error %d reading Merkle tree page %lu",
> -				     err, index);
> +	while (pos < end_pos) {
> +		unsigned long ra_bytes;
> +		unsigned int bytes_to_copy;
> +		struct fsverity_blockbuf block;
> +
> +		ra_bytes = min_t(u64, end_pos - pos, max_ra_bytes);
> +		bytes_to_copy = min_t(u64, end_pos - pos,
> +				      params->block_size - offs_in_block);
> +
> +		err = fsverity_read_merkle_tree_block(inode, params,
> +						      FSVERITY_STREAMING_READ,
> +						      pos - offs_in_block,
> +						      ra_bytes, &block);
> +		if (err)
>  			break;
> -		}
>  
> -		virt = kmap_local_page(page);
> -		if (copy_to_user(buf, virt + offs_in_page, bytes_to_copy)) {
> -			kunmap_local(virt);
> -			put_page(page);
> +		if (copy_to_user(buf, block.kaddr + offs_in_block,
> +				 bytes_to_copy)) {
> +			fsverity_drop_merkle_tree_block(inode, &block);
>  			err = -EFAULT;
>  			break;
>  		}
> -		kunmap_local(virt);
> -		put_page(page);
> +		fsverity_drop_merkle_tree_block(inode, &block);
>  
>  		retval += bytes_to_copy;
>  		buf += bytes_to_copy;
> -		offset += bytes_to_copy;
> +		pos += bytes_to_copy;
>  
>  		if (fatal_signal_pending(current))  {
>  			err = -EINTR;
>  			break;
>  		}
>  		cond_resched();
> -		offs_in_page = 0;
> +		offs_in_block = 0;
>  	}
>  	return retval ? retval : err;
>  }
>  
>  /* Copy the requested portion of the buffer to userspace. */
> diff --git a/fs/verity/verify.c b/fs/verity/verify.c
> index 4fcad0825a12..aa6f5ca719b3 100644
> --- a/fs/verity/verify.c
> +++ b/fs/verity/verify.c
> @@ -76,10 +76,131 @@ static bool is_hash_block_verified(struct fsverity_info *vi, struct page *hpage,
>  	smp_wmb();
>  	SetPageChecked(hpage);
>  	return false;
>  }
>  
> +/**
> + * fsverity_set_block_page() - fill in a fsverity_blockbuf using a page
> + * @req: The Merkle tree block read request
> + * @block: The fsverity_blockbuf to initialize
> + * @page: The page containing the block's data at offset @req->pos % PAGE_SIZE.
> + *
> + * This is a helper function for filesystems that cache Merkle tree blocks in
> + * the pagecache.  It should be called at the end of
> + * fsverity_operations::read_merkle_tree_block().  It takes ownership of a ref
> + * to the page, maps the page, and uses the PG_checked flag and (if needed) the
> + * fsverity_info::hash_block_verified bitmap to check whether the block has been
> + * verified or not.  It initializes the fsverity_blockbuf accordingly.
> + *
> + * This must be paired with fsverity_drop_page_merkle_tree_block(), called from
> + * fsverity_operations::drop_merkle_tree_block().
> + */
> +void fsverity_set_block_page(const struct fsverity_readmerkle *req,
> +			     struct fsverity_blockbuf *block,
> +			     struct page *page)
> +{
> +	struct fsverity_info *vi = req->inode->i_verity_info;
> +
> +	block->kaddr = kmap_local_page(page) + (req->pos & ~PAGE_MASK);
> +	block->context = page;
> +	block->verified = is_hash_block_verified(vi, page, block->index);
> +}
> +EXPORT_SYMBOL_GPL(fsverity_set_block_page);
> +
> +/**
> + * fsverity_drop_page_merkle_tree_block() - drop a Merkle tree block for
> + *					    filesystems using page-based caching
> + * @inode: The inode to which the Merkle tree belongs
> + * @block: The fsverity_blockbuf to drop
> + *
> + * This pairs with fsverity_set_block_page().  It marks the block as verified if
> + * needed, and then it unmaps and puts the page.  Filesystems that use
> + * fsverity_set_block_page() need to set ->drop_merkle_tree_block to this.
> + */
> +void fsverity_drop_page_merkle_tree_block(struct inode *inode,
> +					  struct fsverity_blockbuf *block)
> +{
> +	struct fsverity_info *vi = inode->i_verity_info;
> +	struct page *page = block->context;
> +
> +	if (block->newly_verified) {
> +		/*
> +		 * This must be atomic and idempotent, as the same hash block
> +		 * might be verified by multiple threads concurrently.
> +		 */
> +		if (vi->hash_block_verified != NULL)
> +			set_bit(block->index, vi->hash_block_verified);
> +		else
> +			SetPageChecked(page);
> +	}
> +	unmap_and_put_page(page, block->kaddr);
> +}
> +EXPORT_SYMBOL_GPL(fsverity_drop_page_merkle_tree_block);
> +
> +/**
> + * fsverity_read_merkle_tree_block() - read a Merkle tree block
> + * @inode: inode to which the Merkle tree belongs
> + * @params: inode's Merkle tree parameters
> + * @level: level of the block, or FSVERITY_STREAMING_READ to indicate a
> + *	   streaming read.  Level 0 means the leaf level.
> + * @pos: position of the block in the Merkle tree, in bytes
> + * @ra_bytes: on cache miss, try to read ahead this many bytes
> + * @block: struct in which the block is returned
> + *
> + * This function reads a block from a file's Merkle tree.  It must be paired
> + * with fsverity_drop_merkle_tree_block().
> + *
> + * Return: 0 on success, -errno on failure
> + */
> +int fsverity_read_merkle_tree_block(struct inode *inode,
> +				    const struct merkle_tree_params *params,
> +				    int level, u64 pos, unsigned long ra_bytes,
> +				    struct fsverity_blockbuf *block)
> +{
> +	struct fsverity_readmerkle req = {
> +		.inode = inode,
> +		.pos = pos,
> +		.size = params->block_size,
> +		.digest_size = params->digest_size,
> +		.level = level,
> +		.num_levels = params->num_levels,
> +		.ra_bytes = ra_bytes,
> +		.zero_digest = params->zero_digest,
> +	};
> +	int err;
> +
> +	memset(block, 0, sizeof(*block));
> +	block->index = pos >> params->log_blocksize;
> +
> +	err = inode->i_sb->s_vop->read_merkle_tree_block(&req, block);
> +	if (err)
> +		fsverity_err(inode, "Error %d reading Merkle tree block %lu",
> +			     err, block->index);
> +	block->newly_verified = false;
> +	return err;
> +}
> +
> +/**
> + * fsverity_drop_merkle_tree_block() - drop a Merkle tree block buffer
> + * @inode: inode to which the Merkle tree belongs
> + * @block: block buffer to be dropped
> + *
> + * This releases the resources that were acquired by
> + * fsverity_read_merkle_tree_block().  If the block is newly verified, it also
> + * saves a record of that in the appropriate location.  If a process nests the
> + * reads of multiple blocks, they must be dropped in reverse order; this is
> + * needed to accommodate the use of local kmaps to map the blocks' contents.
> + */
> +void fsverity_drop_merkle_tree_block(struct inode *inode,
> +				     struct fsverity_blockbuf *block)
> +{
> +	inode->i_sb->s_vop->drop_merkle_tree_block(inode, block);
> +
> +	block->context = NULL;
> +	block->kaddr = NULL;
> +}
> +
>  /*
>   * Verify a single data block against the file's Merkle tree.
>   *
>   * In principle, we need to verify the entire path to the root node.  However,
>   * for efficiency the filesystem may cache the hash blocks.  Therefore we need
> @@ -88,27 +209,24 @@ static bool is_hash_block_verified(struct fsverity_info *vi, struct page *hpage,
>   *
>   * Return: %true if the data block is valid, else %false.
>   */
>  static bool
>  verify_data_block(struct inode *inode, struct fsverity_info *vi,
> -		  const void *data, u64 data_pos, unsigned long max_ra_pages)
> +		  const void *data, u64 data_pos, unsigned long max_ra_bytes)
>  {
>  	const struct merkle_tree_params *params = &vi->tree_params;
>  	const unsigned int hsize = params->digest_size;
>  	int level;
> +	unsigned long ra_bytes;
>  	u8 _want_hash[FS_VERITY_MAX_DIGEST_SIZE];
>  	const u8 *want_hash;
>  	u8 real_hash[FS_VERITY_MAX_DIGEST_SIZE];
>  	/* The hash blocks that are traversed, indexed by level */
>  	struct {
> -		/* Page containing the hash block */
> -		struct page *page;
> -		/* Mapped address of the hash block (will be within @page) */
> -		const void *addr;
> -		/* Index of the hash block in the tree overall */
> -		unsigned long index;
> -		/* Byte offset of the wanted hash relative to @addr */
> +		/* Buffer containing the hash block */
> +		struct fsverity_blockbuf block;
> +		/* Byte offset of the wanted hash in the block */
>  		unsigned int hoffset;
>  	} hblocks[FS_VERITY_MAX_LEVELS];
>  	/*
>  	 * The index of the previous level's block within that level; also the
>  	 * index of that block's hash within the current level.
> @@ -141,86 +259,67 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
>  	 * until we reach the root.
>  	 */
>  	for (level = 0; level < params->num_levels; level++) {
>  		unsigned long next_hidx;
>  		unsigned long hblock_idx;
> -		pgoff_t hpage_idx;
> -		unsigned int hblock_offset_in_page;
> +		u64 hblock_pos;
>  		unsigned int hoffset;
> -		struct page *hpage;
> -		const void *haddr;
> +		struct fsverity_blockbuf *block = &hblocks[level].block;
>  
>  		/*
>  		 * The index of the block in the current level; also the index
>  		 * of that block's hash within the next level.
>  		 */
>  		next_hidx = hidx >> params->log_arity;
>  
>  		/* Index of the hash block in the tree overall */
>  		hblock_idx = params->level_start[level] + next_hidx;
>  
> -		/* Index of the hash page in the tree overall */
> -		hpage_idx = hblock_idx >> params->log_blocks_per_page;
> -
> -		/* Byte offset of the hash block within the page */
> -		hblock_offset_in_page =
> -			(hblock_idx << params->log_blocksize) & ~PAGE_MASK;
> +		/* Byte offset of the hash block in the tree overall */
> +		hblock_pos = (u64)hblock_idx << params->log_blocksize;
>  
>  		/* Byte offset of the hash within the block */
>  		hoffset = (hidx << params->log_digestsize) &
>  			  (params->block_size - 1);
>  
> -		hpage = inode->i_sb->s_vop->read_merkle_tree_page(inode,
> -				hpage_idx, level == 0 ? min(max_ra_pages,
> -					params->tree_pages - hpage_idx) : 0);
> -		if (IS_ERR(hpage)) {
> -			fsverity_err(inode,
> -				     "Error %ld reading Merkle tree page %lu",
> -				     PTR_ERR(hpage), hpage_idx);
> +		if (level == 0)
> +			ra_bytes = min_t(u64, max_ra_bytes,
> +					 params->tree_size - hblock_pos);
> +		else
> +			ra_bytes = 0;
> +
> +		if (fsverity_read_merkle_tree_block(inode, params, level,
> +						    hblock_pos, ra_bytes,
> +						    block) != 0)
>  			goto error;
> -		}
> -		haddr = kmap_local_page(hpage) + hblock_offset_in_page;
> -		if (is_hash_block_verified(vi, hpage, hblock_idx)) {
> -			memcpy(_want_hash, haddr + hoffset, hsize);
> +
> +		if (block->verified) {
> +			memcpy(_want_hash, block->kaddr + hoffset, hsize);
>  			want_hash = _want_hash;
> -			kunmap_local(haddr);
> -			put_page(hpage);
> +			fsverity_drop_merkle_tree_block(inode, block);
>  			goto descend;
>  		}
> -		hblocks[level].page = hpage;
> -		hblocks[level].addr = haddr;
> -		hblocks[level].index = hblock_idx;
>  		hblocks[level].hoffset = hoffset;
>  		hidx = next_hidx;
>  	}
>  
>  	want_hash = vi->root_hash;
>  descend:
>  	/* Descend the tree verifying hash blocks. */
>  	for (; level > 0; level--) {
> -		struct page *hpage = hblocks[level - 1].page;
> -		const void *haddr = hblocks[level - 1].addr;
> -		unsigned long hblock_idx = hblocks[level - 1].index;
> +		struct fsverity_blockbuf *block = &hblocks[level - 1].block;
> +		const void *haddr = block->kaddr;
>  		unsigned int hoffset = hblocks[level - 1].hoffset;
>  
>  		if (fsverity_hash_block(params, inode, haddr, real_hash) != 0)
>  			goto error;
>  		if (memcmp(want_hash, real_hash, hsize) != 0)
>  			goto corrupted;
> -		/*
> -		 * Mark the hash block as verified.  This must be atomic and
> -		 * idempotent, as the same hash block might be verified by
> -		 * multiple threads concurrently.
> -		 */
> -		if (vi->hash_block_verified)
> -			set_bit(hblock_idx, vi->hash_block_verified);
> -		else
> -			SetPageChecked(hpage);
> +		block->newly_verified = true;
>  		memcpy(_want_hash, haddr + hoffset, hsize);
>  		want_hash = _want_hash;
> -		kunmap_local(haddr);
> -		put_page(hpage);
> +		fsverity_drop_merkle_tree_block(inode, block);
>  	}
>  
>  	/* Finally, verify the data block. */
>  	if (fsverity_hash_block(params, inode, data, real_hash) != 0)
>  		goto error;
> @@ -233,20 +332,18 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
>  		     "FILE CORRUPTED! pos=%llu, level=%d, want_hash=%s:%*phN, real_hash=%s:%*phN",
>  		     data_pos, level - 1,
>  		     params->hash_alg->name, hsize, want_hash,
>  		     params->hash_alg->name, hsize, real_hash);
>  error:
> -	for (; level > 0; level--) {
> -		kunmap_local(hblocks[level - 1].addr);
> -		put_page(hblocks[level - 1].page);
> -	}
> +	for (; level > 0; level--)
> +		fsverity_drop_merkle_tree_block(inode, &hblocks[level - 1].block);
>  	return false;
>  }
>  
>  static bool
>  verify_data_blocks(struct folio *data_folio, size_t len, size_t offset,
> -		   unsigned long max_ra_pages)
> +		   unsigned long max_ra_bytes)
>  {
>  	struct inode *inode = data_folio->mapping->host;
>  	struct fsverity_info *vi = inode->i_verity_info;
>  	const unsigned int block_size = vi->tree_params.block_size;
>  	u64 pos = (u64)data_folio->index << PAGE_SHIFT;
> @@ -260,11 +357,11 @@ verify_data_blocks(struct folio *data_folio, size_t len, size_t offset,
>  		void *data;
>  		bool valid;
>  
>  		data = kmap_local_folio(data_folio, offset);
>  		valid = verify_data_block(inode, vi, data, pos + offset,
> -					  max_ra_pages);
> +					  max_ra_bytes);
>  		kunmap_local(data);
>  		if (!valid)
>  			return false;
>  		offset += block_size;
>  		len -= block_size;
> @@ -306,28 +403,29 @@ EXPORT_SYMBOL_GPL(fsverity_verify_blocks);
>   * All filesystems must also call fsverity_verify_page() on holes.
>   */
>  void fsverity_verify_bio(struct bio *bio)
>  {
>  	struct folio_iter fi;
> -	unsigned long max_ra_pages = 0;
> +	unsigned long max_ra_bytes = 0;
>  
>  	if (bio->bi_opf & REQ_RAHEAD) {
>  		/*
>  		 * If this bio is for data readahead, then we also do readahead
>  		 * of the first (largest) level of the Merkle tree.  Namely,
> -		 * when a Merkle tree page is read, we also try to piggy-back on
> -		 * some additional pages -- up to 1/4 the number of data pages.
> +		 * when there is a cache miss for a Merkle tree block, we try to
> +		 * piggy-back some additional blocks onto the read, with size up
> +		 * to 1/4 the size of the data being read.
>  		 *
>  		 * This improves sequential read performance, as it greatly
>  		 * reduces the number of I/O requests made to the Merkle tree.
>  		 */
> -		max_ra_pages = bio->bi_iter.bi_size >> (PAGE_SHIFT + 2);
> +		max_ra_bytes = bio->bi_iter.bi_size >> 2;
>  	}
>  
>  	bio_for_each_folio_all(fi, bio) {
>  		if (!verify_data_blocks(fi.folio, fi.length, fi.offset,
> -					max_ra_pages)) {
> +					max_ra_bytes)) {
>  			bio->bi_status = BLK_STS_IOERR;
>  			break;
>  		}
>  	}
>  }
> diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
> index 1eb7eae580be..2b9137061379 100644
> --- a/include/linux/fsverity.h
> +++ b/include/linux/fsverity.h
> @@ -24,13 +24,77 @@
>  #define FS_VERITY_MAX_DIGEST_SIZE	SHA512_DIGEST_SIZE
>  
>  /* Arbitrary limit to bound the kmalloc() size.  Can be changed. */
>  #define FS_VERITY_MAX_DESCRIPTOR_SIZE	16384
>  
> +/**
> + * struct fsverity_blockbuf - Merkle tree block buffer
> + * @context: filesystem private context
> + * @kaddr: virtual address of the block's data
> + * @index: index of the block in the Merkle tree
> + * @verified: was this block already verified when it was requested?
> + * @newly_verified: was verification of this block just done?
> + *
> + * This struct describes a buffer containing a Merkle tree block.  When a Merkle
> + * tree block needs to be read, this struct is passed to the filesystem's
> + * ->read_merkle_tree_block function, with just the @index field set.  The
> + * filesystem sets @kaddr, and optionally @context and @verified.  Filesystems
> + * must set @verified only if the filesystem was previously told that the same
> + * block was verified (via ->drop_merkle_tree_block() seeing @newly_verified)
> + * and the block wasn't evicted from cache in the intervening time.
> + *
> + * To release the resources acquired by a read, this struct is passed to
> + * ->drop_merkle_tree_block, with @newly_verified set if verification of the
> + * block was just done.
> + */
> +struct fsverity_blockbuf {
> +	void *context;
> +	void *kaddr;
> +	unsigned long index;
> +	unsigned int verified : 1;
> +	unsigned int newly_verified : 1;
> +};
> +
> +/**
> + * struct fsverity_readmerkle - Request to read a Merkle tree block
> + * @inode: inode to which the Merkle tree belongs
> + * @pos: position of the block in the Merkle tree, in bytes
> + * @size: size of the Merkle tree block, in bytes
> + * @digest_size: size of zero_digest, in bytes
> + * @level: level of the block, or FSVERITY_STREAMING_READ to indicate a
> + *	   streaming read.  Level 0 means the leaf level.
> + * @num_levels: number of levels in the tree total
> + * @ra_bytes: number of bytes that should be prefetched starting at @pos if the
> + *	      block isn't already cached.  Implementations may ignore this
> + *	      argument; it's only a performance optimization.
> + * @zero_digest: hash of a merkle block-sized buffer of zeroes
> + */
> +struct fsverity_readmerkle {
> +	struct inode *inode;
> +	u64 pos;
> +	unsigned int size;
> +	unsigned int digest_size;
> +	int level;
> +	int num_levels;
> +	unsigned long ra_bytes;
> +	const u8 *zero_digest;
> +};
> +
> +#define FSVERITY_STREAMING_READ	(-1)
> +
>  /* Verity operations for filesystems */
>  struct fsverity_operations {
>  
> +	/**
> +	 * This must be set if the filesystem chooses to cache Merkle tree
> +	 * blocks in the pagecache, i.e. if it uses fsverity_set_block_page()
> +	 * and fsverity_drop_page_merkle_tree_block().  It causes the allocation
> +	 * of the bitmap needed by those helper functions when the Merkle tree
> +	 * block size is less than the page size.
> +	 */
> +	unsigned int uses_page_based_merkle_caching : 1;
> +
>  	/**
>  	 * Begin enabling verity on the given file.
>  	 *
>  	 * @filp: a readonly file descriptor for the file
>  	 *
> @@ -83,29 +147,46 @@ struct fsverity_operations {
>  	 */
>  	int (*get_verity_descriptor)(struct inode *inode, void *buf,
>  				     size_t bufsize);
>  
>  	/**
> -	 * Read a Merkle tree page of the given inode.
> +	 * Read a Merkle tree block of the given inode.
>  	 *
> -	 * @inode: the inode
> -	 * @index: 0-based index of the page within the Merkle tree
> -	 * @num_ra_pages: The number of Merkle tree pages that should be
> -	 *		  prefetched starting at @index if the page at @index
> -	 *		  isn't already cached.  Implementations may ignore this
> -	 *		  argument; it's only a performance optimization.
> +	 * @req: read request; see struct fsverity_readmerkle
> +	 * @block: struct in which the filesystem returns the block.
> +	 *	   It also contains the block index.
>  	 *
>  	 * This can be called at any time on an open verity file.  It may be
> -	 * called by multiple processes concurrently, even with the same page.
> +	 * called by multiple processes concurrently.
> +	 *
> +	 * Implementations of this function should cache the Merkle tree blocks
> +	 * and issue I/O only if the block isn't already cached.  The filesystem
> +	 * can implement a custom cache or use the pagecache based helpers.
> +	 *
> +	 * Return: 0 on success, -errno on failure
> +	 */
> +	int (*read_merkle_tree_block)(const struct fsverity_readmerkle *req,
> +				      struct fsverity_blockbuf *block);
> +
> +	/**
> +	 * Release a Merkle tree block buffer.
> +	 *
> +	 * @inode: the inode the block is being dropped for
> +	 * @block: the block buffer to release
>  	 *
> -	 * Note that this must retrieve a *page*, not necessarily a *block*.
> +	 * This is called to release a Merkle tree block that was obtained with
> +	 * ->read_merkle_tree_block().  If multiple reads were nested, the drops
> +	 * are done in reverse order (to accommodate the use of local kmaps).
>  	 *
> -	 * Return: the page on success, ERR_PTR() on failure
> +	 * If @block->newly_verified is true, then implementations of this
> +	 * function should cache a flag saying that the block is verified, and
> +	 * return that flag from later ->read_merkle_tree_block() for the same
> +	 * block if the block hasn't been evicted from the cache in the
> +	 * meantime.  This avoids unnecessary revalidation of blocks.
>  	 */
> -	struct page *(*read_merkle_tree_page)(struct inode *inode,
> -					      pgoff_t index,
> -					      unsigned long num_ra_pages);
> +	void (*drop_merkle_tree_block)(struct inode *inode,
> +				       struct fsverity_blockbuf *block);
>  
>  	/**
>  	 * Write a Merkle tree block to the given inode.
>  	 *
>  	 * @inode: the inode for which the Merkle tree is being built
> @@ -168,10 +249,15 @@ static inline void fsverity_cleanup_inode(struct inode *inode)
>  
>  int fsverity_ioctl_read_metadata(struct file *filp, const void __user *uarg);
>  
>  /* verify.c */
>  
> +void fsverity_set_block_page(const struct fsverity_readmerkle *req,
> +			     struct fsverity_blockbuf *block,
> +			     struct page *page);
> +void fsverity_drop_page_merkle_tree_block(struct inode *inode,
> +					  struct fsverity_blockbuf *block);
>  bool fsverity_verify_blocks(struct folio *folio, size_t len, size_t offset);
>  void fsverity_verify_bio(struct bio *bio);
>  void fsverity_enqueue_verify_work(struct work_struct *work);
>  
>  #else /* !CONFIG_FS_VERITY */
> 
> base-commit: a5131c3fdf2608f1c15f3809e201cf540eb28489
> -- 
> 2.45.0
> 
> 

