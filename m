Return-Path: <linux-fsdevel+bounces-12536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB09860A34
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 06:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 042E51F26360
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 05:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F4211C84;
	Fri, 23 Feb 2024 05:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ow4itGBx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B994611715;
	Fri, 23 Feb 2024 05:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708665901; cv=none; b=YrdQlsLQnXB041W2iq8S1G996dmMxmY5ShiSpJ69J+ZHZs00YII7DCjLxeY2jDsjRApClx5sRW0J7AkD8FbLEnE8BYN/c+IgOHpRzsDJWZsuvJ7UIbMP9mIx90sZa1//MV2Tz3S+jJ6Tj+J0e2i9DyJK6rwrQ4B+WUTvIEgzsUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708665901; c=relaxed/simple;
	bh=+dAuTSe+Gkaf2Cahb9ij1ousWZSqNb/lWta3cqicnF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9+jyEiKcPM1CKUeCusge25XaeIZ71YK1Ico2b7Q+wVC75fe6l3O2CwPRD/rXUqZk9LQ+c0WpAc/ir305k8xhsYg/6dZCsYz8k6gOOGLO+Ujyui41hVmQTzhFaUieOAUkhtlP64RnCuQX0MGrnpOtVl7X2I/z9Y9A3iDzcqykVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ow4itGBx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CEEC433F1;
	Fri, 23 Feb 2024 05:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708665901;
	bh=+dAuTSe+Gkaf2Cahb9ij1ousWZSqNb/lWta3cqicnF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ow4itGBxMa/cyRbAPE2hxXJG73F9a6ZDTefUiZYX8eYVxSDvNtPCeniuURdQ3Ujzx
	 D+Tqeh9uCDDLRZVICFmylYO/RZwHUrTofPm8bx4hC8e606cbrMQkSAurlS/iYqbGny
	 pTNGAbMHxMZkwx+SUYAolIk0zWZLfOJ+qcikWV0W3eidq520GQ45M/P04iyL00MsUA
	 kDvR4vSUd+0NgYYYPlzOIWWHbwy46ajHXTVvcp8cDmgCUq3Z2my8Y8Za5zCxXwtQA1
	 5tISJ98vHKLHjpOIruvOnpWTakCiOCvfjHOMon9bw1IOxxLf8b6nJDzKRoP9PMp8mq
	 313kig5HU0KKQ==
Date: Thu, 22 Feb 2024 21:24:59 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, chandan.babu@oracle.com,
	djwong@kernel.org
Subject: Re: [PATCH v4 07/25] fsverity: support block-based Merkle tree
 caching
Message-ID: <20240223052459.GC25631@sol.localdomain>
References: <20240212165821.1901300-1-aalbersh@redhat.com>
 <20240212165821.1901300-8-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212165821.1901300-8-aalbersh@redhat.com>

On Mon, Feb 12, 2024 at 05:58:04PM +0100, Andrey Albershteyn wrote:
> diff --git a/fs/verity/read_metadata.c b/fs/verity/read_metadata.c
> index f58432772d9e..7e153356e7bc 100644
> --- a/fs/verity/read_metadata.c
> +++ b/fs/verity/read_metadata.c
[...]
>  	/*
> -	 * Iterate through each Merkle tree page in the requested range and copy
> -	 * the requested portion to userspace.  Note that the Merkle tree block
> -	 * size isn't important here, as we are returning a byte stream; i.e.,
> -	 * we can just work with pages even if the tree block size != PAGE_SIZE.
> +	 * Iterate through each Merkle tree block in the requested range and
> +	 * copy the requested portion to userspace. Note that we are returning
> +	 * a byte stream, so PAGE_SIZE & block_size are not important here.

The block size *is* important here now, because this code is now working with
the data in blocks.  Maybe just delete the last sentence from the comment.

> +		fsverity_drop_block(inode, &block);
> +		block.kaddr = NULL;

Either the 'block.kaddr = NULL' should not be here, or it should be done
automatically in fsverity_drop_block().

> +		num_ra_pages = level == 0 ?
> +			min(max_ra_pages, params->tree_pages - hpage_idx) : 0;
> +		err = fsverity_read_merkle_tree_block(
> +			inode, hblock_idx << params->log_blocksize, block,
> +			params->log_blocksize, num_ra_pages);

'hblock_idx << params->log_blocksize' needs to be
'(u64)hblock_idx << params->log_blocksize'

>  	for (; level > 0; level--) {
> -		kunmap_local(hblocks[level - 1].addr);
> -		put_page(hblocks[level - 1].page);
> +		fsverity_drop_block(inode, &hblocks[level - 1].block);
>  	}

Braces should be removed above

> +/**
> + * fsverity_invalidate_range() - invalidate range of Merkle tree blocks
> + * @inode: inode to which this Merkle tree blocks belong
> + * @offset: offset into the Merkle tree
> + * @size: number of bytes to invalidate starting from @offset

Maybe use @pos instead of @offset, to make it clear that it's in bytes.

But, what happens if the region passed is not Merkle tree block aligned?
Perhaps this function should operate on blocks, to avoid that case?

> + * Note! As this function clears fs-verity bitmap and can be run from multiple
> + * threads simultaneously, filesystem has to take care of operation ordering
> + * while invalidating Merkle tree and caching it. See fsverity_invalidate_page()
> + * as reference.

I'm not sure what this means.  What specifically does the filesystem have to do?

> +/* fsverity_invalidate_page() - invalidate Merkle tree blocks in the page

Is this intended to be kerneldoc?  Kerneldoc comments start with /**

Also, this function is only used within fs/verity/verify.c itself.  So it should
be static, and it shouldn't be declared in include/linux/fsverity.h.

> + * @inode: inode to which this Merkle tree blocks belong
> + * @page: page which contains blocks which need to be invalidated
> + * @index: index of the first Merkle tree block in the page

The only value that is assigned to index is 'pos >> PAGE_SHIFT', which implies
it is in units of pages, not Merkle tree blocks.  Which is correct?

> + *
> + * This function invalidates "verified" state of all Merkle tree blocks within
> + * the 'page'.
> + *
> + * When the Merkle tree block size and page size are the same, then the
> + * ->hash_block_verified bitmap isn't allocated, and we use PG_checked
> + * to directly indicate whether the page's block has been verified. This
> + * function does nothing in this case as page is invalidated by evicting from
> + * the memory.
> + *
> + * Using PG_checked also guarantees that we re-verify hash pages that
> + * get evicted and re-instantiated from the backing storage, as new
> + * pages always start out with PG_checked cleared.

This comment duplicates information from the comment in the function itself.

> +void fsverity_drop_block(struct inode *inode,
> +		struct fsverity_blockbuf *block)
> +{
> +	if (inode->i_sb->s_vop->drop_block)
> +		inode->i_sb->s_vop->drop_block(block);
> +	else {
> +		struct page *page = (struct page *)block->context;
> +
> +		/* Merkle tree block size == PAGE_SIZE; */
> +		if (block->verified)
> +			SetPageChecked(page);
> +
> +		kunmap_local(block->kaddr);
> +		put_page(page);
> +	}
> +}

I don't think this is the logical place for the call to SetPageChecked().
verity_data_block() currently does:

        if (vi->hash_block_verified)
                set_bit(hblock_idx, vi->hash_block_verified);
        else
                SetPageChecked(page);

You're proposing moving the SetPageChecked() to fsverity_drop_block().  Why?  We
should try to do things in a consistent place.

Similarly, I don't see why is_hash_block_verified() shouldn't keep the
PageChecked().

If we just keep PG_checked be get and set in the same places it currently is,
then adding fsverity_blockbuf::verified wouldn't be necessary.

Maybe you intended to move the awareness of PG_checked out of fs/verity/ and
into the filesystems?  Your change in how PG_checked is get and set is sort of a
step towards that, but it doesn't complete it.  It doesn't make sense to leave
in this half-finished state.  IMO, keeping fs/verity/ aware of PG_checked is
fine for now.  It avoids the need for some indirect calls, which is nice.

> +/**
> + * struct fsverity_blockbuf - Merkle Tree block
> + * @kaddr: virtual address of the block's data
> + * @size: buffer size

Is "buffer size" different from block size?

> + * @verified: true if block is verified against Merkle tree

This field has confusing semantics, as it's not used by the filesystems but only
by fs/verity/ internally.  As per my feedback above, I don't think this field is
necessary.

> + * Buffer containing single Merkle Tree block. These buffers are passed
> + *  - to filesystem, when fs-verity is building/writing merkel tree,
> + *  - from filesystem, when fs-verity is reading merkle tree from a disk.
> + * Filesystems sets kaddr together with size to point to a memory which contains
> + * Merkle tree block. Same is done by fs-verity when Merkle tree is need to be
> + * written down to disk.

Writes actually still use fsverity_operations::write_merkle_tree_block(), which
does not use this struct.

> + * For Merkle tree block == PAGE_SIZE, fs-verity sets verified flag to true if
> + * block in the buffer was verified.

Again, I think we can do without this field.

> +	/**
> +	 * Read a Merkle tree block of the given inode.
> +	 * @inode: the inode
> +	 * @pos: byte offset of the block within the Merkle tree
> +	 * @block: block buffer for filesystem to point it to the block
> +	 * @log_blocksize: size of the expected block

Presumably @log_blocksize is the log2 of the size of the block?

> +	 * @num_ra_pages: The number of pages with blocks that should be
> +	 *		  prefetched starting at @index if the page at @index
> +	 *		  isn't already cached.  Implementations may ignore this
> +	 *		  argument; it's only a performance optimization.

There's no parameter named @index.

> +	 * As filesystem does caching of the blocks, this functions needs to tell
> +	 * fsverity which blocks are not valid anymore (were evicted from memory)
> +	 * by calling fsverity_invalidate_range().

This function only reads a single block, so what does this mean by "blocks"?

Since there's only one block being read, why isn't the validation status just
conveyed through a bool in fsverity_blockbuf?

> +	/**
> +	 * Release the reference to a Merkle tree block
> +	 *
> +	 * @page: the block to release

@block, not @page

- Eric

