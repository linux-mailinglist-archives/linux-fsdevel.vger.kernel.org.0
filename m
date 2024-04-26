Return-Path: <linux-fsdevel+bounces-17916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C22D68B3BD5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 17:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79619283605
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 15:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64A414A4E9;
	Fri, 26 Apr 2024 15:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6cYZBNM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D171DFFC;
	Fri, 26 Apr 2024 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714146109; cv=none; b=EkXAQ+Lkc022e8VOVtGuv9QCT9c1u5cMq83Rdow89jfs04NArtzk1L/2g1QpOTbYoir4krmxA/ZadPAPWr582wxLveqAmfX4o6HAjNaxcQ3T3UfzbITUMKPXBVGgovxETUDuhIKZacnXsrHV2nn0SPThLd6C023yDcVmXTOMlSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714146109; c=relaxed/simple;
	bh=99RhRtaIbb0Ed6KO0jgs26+/9qaZVd6Jg+DHPUfFkgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UK572D23y8h//HS4ldgUSOuxeksorPteAQLEejgnwkRaYBq+IWGCammuWM2kwt/Vxv1/UCve/HNSAOY4su0s5ycJ2wInCpEjgwO47ejyomCFAy1/anr1lppiiFQlz/xAsBi1zL10n5RZc/2iq8hKxPPDHnttyx0D8FCfqbZHjSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6cYZBNM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996B5C113CD;
	Fri, 26 Apr 2024 15:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714146108;
	bh=99RhRtaIbb0Ed6KO0jgs26+/9qaZVd6Jg+DHPUfFkgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A6cYZBNMtjZbQY7L9HFYIk7rwn/UUy6nh1hD92HIVWknr42vKTHltlphxn2BLOyE/
	 D1hzf0HJOCt6aqBaDoPABCt665Rfn8qBX4L7DaE41TjHFA7EtJ9P4faOglesiyfHVZ
	 qltJBRCAqlSfoOe6Ec43FMNAvsnhBscDhUblrQ1sDVwqbjXTxSsaBiGwlCBBPkkIn/
	 QiybFWGOoMJThMRkqtzMsxX+9vQe64m+I0Wb4qXkcp7kYh3IaE1DSpWcuBUMUkDct8
	 8THBbFIt0ecBWX88llxFCkN39jSi4jK7zp3L+T+oLx3FNBDOIaNqwOX6QOXh6ckDiu
	 uevU6EdUIDd8g==
Date: Fri, 26 Apr 2024 08:41:48 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>
Subject: Re: [RFCv3 4/7] ext2: Implement seq counter for validating cached
 iomap
Message-ID: <20240426154148.GL360919@frogsfrogsfrogs>
References: <cover.1714046808.git.ritesh.list@gmail.com>
 <009d08646b77e0d774b4ce248675b86564bca9ee.1714046808.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <009d08646b77e0d774b4ce248675b86564bca9ee.1714046808.git.ritesh.list@gmail.com>

On Thu, Apr 25, 2024 at 06:58:48PM +0530, Ritesh Harjani (IBM) wrote:
> There is a possibility of following race with iomap during
> writebck -
> 
> write_cache_pages()
>   cache extent covering 0..1MB range
>   write page at offset 0k
> 					truncate(file, 4k)
> 					  drops all relevant pages
> 					  frees fs blocks
> 					pwrite(file, 4k, 4k)
> 					  creates dirty page in the page cache
>   writes page at offset 4k to a stale block
> 
> This race can happen because iomap_writepages() keeps a cached extent mapping
> within struct iomap. While write_cache_pages() is going over each folio,
> (can cache a large extent range), if a truncate happens in parallel on the
> next folio followed by a buffered write to the same offset within the file,
> this can change logical to physical offset of the cached iomap mapping.
> That means, the cached iomap has now become stale.
> 
> This patch implements the seq counter approach for revalidation of stale
> iomap mappings. i_blkseq will get incremented for every block
> allocation/free. Here is what we do -
> 
> For ext2 buffered-writes, the block allocation happens at the
> ->write_iter time itself. So at writeback time,
> 1. We first cache the i_blkseq.
> 2. Call ext2_get_blocks(, create = 0) to get the no. of blocks
>    already allocated.
> 3. Call ext2_get_blocks() the second time with length to be same as
>    the no. of blocks we know were already allocated.
> 4. Till now it means, the cached i_blkseq remains valid as no block
>    allocation has happened yet.
> This means the next call to ->map_blocks(), we can verify whether the
> i_blkseq has raced with truncate or not. If not, then i_blkseq will
> remain valid.
> 
> In case of a hole (could happen with mmaped writes), we only allocate
> 1 block at a time anyways. So even if the i_blkseq value changes right
> after, we anyway need to allocate the next block in subsequent
> ->map_blocks() call.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  fs/ext2/balloc.c |  1 +
>  fs/ext2/ext2.h   |  6 +++++
>  fs/ext2/inode.c  | 57 ++++++++++++++++++++++++++++++++++++++++++++----
>  fs/ext2/super.c  |  2 +-
>  4 files changed, 61 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
> index 1bfd6ab11038..047a8f41a6f5 100644
> --- a/fs/ext2/balloc.c
> +++ b/fs/ext2/balloc.c
> @@ -495,6 +495,7 @@ void ext2_free_blocks(struct inode * inode, ext2_fsblk_t block,
>  	}
>  
>  	ext2_debug ("freeing block(s) %lu-%lu\n", block, block + count - 1);
> +	ext2_inc_i_blkseq(EXT2_I(inode));
>  
>  do_more:
>  	overflow = 0;
> diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
> index f38bdd46e4f7..67b1acb08eb2 100644
> --- a/fs/ext2/ext2.h
> +++ b/fs/ext2/ext2.h
> @@ -663,6 +663,7 @@ struct ext2_inode_info {
>  	struct rw_semaphore xattr_sem;
>  #endif
>  	rwlock_t i_meta_lock;
> +	unsigned int i_blkseq;
>  
>  	/*
>  	 * truncate_mutex is for serialising ext2_truncate() against
> @@ -698,6 +699,11 @@ static inline struct ext2_inode_info *EXT2_I(struct inode *inode)
>  	return container_of(inode, struct ext2_inode_info, vfs_inode);
>  }
>  
> +static inline void ext2_inc_i_blkseq(struct ext2_inode_info *ei)
> +{
> +	WRITE_ONCE(ei->i_blkseq, READ_ONCE(ei->i_blkseq) + 1);
> +}
> +
>  /* balloc.c */
>  extern int ext2_bg_has_super(struct super_block *sb, int group);
>  extern unsigned long ext2_bg_num_gdb(struct super_block *sb, int group);
> diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> index 2b62786130b5..946a614ddfc0 100644
> --- a/fs/ext2/inode.c
> +++ b/fs/ext2/inode.c
> @@ -406,6 +406,8 @@ static int ext2_alloc_blocks(struct inode *inode,
>  	ext2_fsblk_t current_block = 0;
>  	int ret = 0;
>  
> +	ext2_inc_i_blkseq(EXT2_I(inode));
> +
>  	/*
>  	 * Here we try to allocate the requested multiple blocks at once,
>  	 * on a best-effort basis.
> @@ -966,15 +968,62 @@ ext2_writepages(struct address_space *mapping, struct writeback_control *wbc)
>  	return mpage_writepages(mapping, wbc, ext2_get_block);
>  }
>  
> +static bool ext2_imap_valid(struct iomap_writepage_ctx *wpc, struct inode *inode,
> +			    loff_t offset)

ext2_iomap_valid, to stay consistent with the ext4 conversion series?

> +{
> +	if (offset < wpc->iomap.offset ||
> +	    offset >= wpc->iomap.offset + wpc->iomap.length)
> +		return false;
> +
> +	if (wpc->iomap.validity_cookie != READ_ONCE(EXT2_I(inode)->i_blkseq))
> +		return false;
> +
> +	return true;
> +}
> +
>  static int ext2_write_map_blocks(struct iomap_writepage_ctx *wpc,
>  				 struct inode *inode, loff_t offset,
>  				 unsigned len)
>  {
> -	if (offset >= wpc->iomap.offset &&
> -	    offset < wpc->iomap.offset + wpc->iomap.length)
> +	loff_t maxblocks = (loff_t)INT_MAX;
> +	u8 blkbits = inode->i_blkbits;
> +	u32 bno;
> +	bool new, boundary;
> +	int ret;
> +
> +	if (ext2_imap_valid(wpc, inode, offset))
>  		return 0;
>  
> -	return ext2_iomap_begin(inode, offset, inode->i_sb->s_blocksize,
> +	/*
> +	 * For ext2 buffered-writes, the block allocation happens at the
> +	 * ->write_iter time itself. So at writeback time -
> +	 * 1. We first cache the i_blkseq.
> +	 * 2. Call ext2_get_blocks(, create = 0) to get the no. of blocks
> +	 *    already allocated.
> +	 * 3. Call ext2_get_blocks() the second time with length to be same as
> +	 *    the no. of blocks we know were already allocated.
> +	 * 4. Till now it means, the cached i_blkseq remains valid as no block
> +	 *    allocation has happened yet.
> +	 * This means the next call to ->map_blocks(), we can verify whether the
> +	 * i_blkseq has raced with truncate or not. If not, then i_blkseq will
> +	 * remain valid.
> +	 *
> +	 * In case of a hole (could happen with mmaped writes), we only allocate
> +	 * 1 block at a time anyways. So even if the i_blkseq value changes, we
> +	 * anyway need to allocate the next block in subsequent ->map_blocks()
> +	 * call.

You might want to leave a comment here that ext2 doesn't support
unwritten extents, so the validation cookie is needed only for
writeback, and not for pagecache writes themselves.  I don't expect
anyone to port extents (and hence unwritten blocks) to ext2, so this is
a minor point.

> +	 */
> +	wpc->iomap.validity_cookie = READ_ONCE(EXT2_I(inode)->i_blkseq);
> +
> +	ret = ext2_get_blocks(inode, offset >> blkbits, maxblocks << blkbits,
> +			      &bno, &new, &boundary, 0);
> +	if (ret < 0)
> +		return ret;
> +	/*
> +	 * ret can be 0 in case of a hole which is possible for mmaped writes.
> +	 */
> +	ret = ret ? ret : 1;
> +	return ext2_iomap_begin(inode, offset, (loff_t)ret << blkbits,
>  				IOMAP_WRITE, &wpc->iomap, NULL);
>  }
>  
> @@ -1000,7 +1049,7 @@ ext2_dax_writepages(struct address_space *mapping, struct writeback_control *wbc
>  
>  const struct address_space_operations ext2_file_aops = {
>  	.dirty_folio		= iomap_dirty_folio,
> -	.release_folio 		= iomap_release_folio,
> +	.release_folio		= iomap_release_folio,

This fix should be in patch 2.

--D

>  	.invalidate_folio	= iomap_invalidate_folio,
>  	.read_folio		= ext2_file_read_folio,
>  	.readahead		= ext2_file_readahead,
> diff --git a/fs/ext2/super.c b/fs/ext2/super.c
> index 37f7ce56adce..32f5386284d6 100644
> --- a/fs/ext2/super.c
> +++ b/fs/ext2/super.c
> @@ -188,7 +188,7 @@ static struct inode *ext2_alloc_inode(struct super_block *sb)
>  #ifdef CONFIG_QUOTA
>  	memset(&ei->i_dquot, 0, sizeof(ei->i_dquot));
>  #endif
> -
> +	WRITE_ONCE(ei->i_blkseq, 0);
>  	return &ei->vfs_inode;
>  }
>  
> -- 
> 2.44.0
> 
> 

