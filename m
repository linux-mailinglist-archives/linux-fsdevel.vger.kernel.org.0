Return-Path: <linux-fsdevel+bounces-17685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCEC8B1806
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 02:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33C4E1C252D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 00:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4B317C9;
	Thu, 25 Apr 2024 00:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdcL3kbv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498FF208A1;
	Thu, 25 Apr 2024 00:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714004827; cv=none; b=IGyX3CsD4G2LvRr10p8n4Y2MqCUncb98pmI3BB7JENAvJ4JWGj+F/sqIbwnXT+t5suVhn1qY1UdEL62IkAXi60++QHU29aS8YccZYIV1w/vhuStDMYijCg4kft/clZO3lwUaisE7WEIwNwQ8+7G+Wf6mSVXFR4GBMch1NnrYWIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714004827; c=relaxed/simple;
	bh=L+EO7uHsqmpNtdpDoISufgE4lupcoPvO3rGNjU+4ZK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZlIc1jDXRK9O6wHup3OtqQGblPboRb+5OaG1bvxispxU6I3MdH15NUwkUXPznvJvEi5IFiWX0JIWCfjQaDdfONtR7df4HbVYqce53X02VyGFfd/UcRxKK+PHnIoyrHl/YLJQRrMzov066v8Wm6pKqz2YZAwsClxSO6C+JxGdzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdcL3kbv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F75C113CD;
	Thu, 25 Apr 2024 00:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714004826;
	bh=L+EO7uHsqmpNtdpDoISufgE4lupcoPvO3rGNjU+4ZK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pdcL3kbv0oO2mMnLhUbkZxNdG/nctDWW8fAOIH/H3i4fuTPG+ZsQQakgGCq4mv4Vd
	 Z3wF4EoZ+i9LR+DS+gi3D1yZmlRiYtOk9PeAYppGKlCehYhQAkejL7aENjbXvGUIWc
	 vL4rVJZEhiBAH2+rx+ZE+HMx9RL350PMAFFuSnxuL3uN1sUu96LoWSpSQRvgx0QXqO
	 nRCoLE77k7+VEFqnhLUwj77Q66VSxfWgUVkQxrYT+PqD7SKo2QepnBAWERnLiwX69k
	 /y5Dfz/gQA/G2tKyJPkiux0+0kp0LHWHpv/WQmjqfYgEaaIKrobBVhN+IGENTg+Yso
	 DM3AbuTuLrgqw==
Date: Wed, 24 Apr 2024 17:27:06 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: aalbersh@redhat.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 03/13] fsverity: support block-based Merkle tree caching
Message-ID: <20240425002706.GS360919@frogsfrogsfrogs>
References: <171175867829.1987804.15934006844321506283.stgit@frogsfrogsfrogs>
 <171175867913.1987804.4275409634176359386.stgit@frogsfrogsfrogs>
 <20240405023145.GB1958@quark.localdomain>
 <20240424212523.GO360919@frogsfrogsfrogs>
 <20240424220858.GC749176@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424220858.GC749176@google.com>

On Wed, Apr 24, 2024 at 10:08:58PM +0000, Eric Biggers wrote:
> On Wed, Apr 24, 2024 at 02:25:23PM -0700, Darrick J. Wong wrote:
> > > For checking whether the bitmap is in use, it's simpler and more efficient to
> > > just directly check whether vi->hash_block_verified is NULL, as the existing
> > > code does.  Only the code that allocates the bitmap actually needs to be aware
> > > of the details of when the bitmap gets enabled.
> > > 
> > > fsverity_caches_blocks() has a similar issue, where it could just be replaced
> > > with checking vops->read_merkle_tree_block != NULL directly (or equivalently
> > > vops->drop_merkle_tree_block, which works well in
> > > fsverity_drop_merkle_tree_block() since that's the function pointer it's
> > > calling).  The WARN_ON_ONCE() should be done in fsverity_create_info(), not
> > > inlined multiple times into the verification code.
> > 
> > Ok, I'll move the WARN_ON_ONCE there:
> > 
> > 	/*
> > 	 * If the filesystem implementation supplies Merkle tree content on a
> > 	 * per-block basis, it must implement both the read and drop functions.
> > 	 * If it supplies content on a per-page basis, neither should be
> > 	 * provided.
> > 	 */
> > 	if (vops->read_merkle_tree_block)
> > 		WARN_ON_ONCE(vops->drop_merkle_tree_block == NULL);
> > 	else
> > 		WARN_ON_ONCE(vops->drop_merkle_tree_block != NULL);
> 
> Checking ->read_merkle_tree_page would make sense too, right?  I.e. we should
> enforce that one of the following two cases holds:
> 
>     1. read_merkle_tree_page != NULL &&
>        read_merkle_tree_block == NULL &&
>        drop_merkle_tree_block == NULL
> 
>     2. read_merkle_tree_page == NULL &&
>        read_merkle_tree_block != NULL &&
>        drop_merkle_tree_block != NULL

<nod>

	if (vops->read_merkle_tree_page)
		WARN_ON_ONCE(vops->read_merkle_tree_block != NULL ||
			     vops->drop_merkle_tree_block != NULL);
	else
		WARN_ON_ONCE(vops->read_merkle_tree_block == NULL ||
			     vops->drop_merkle_tree_block == NULL);


> > > > +		bytes_to_copy = min_t(u64, end_pos - pos,
> > > > +				      params->block_size - offs_in_block);
> > > > +
> > > > +		err = fsverity_read_merkle_tree_block(inode, &vi->tree_params,
> > > > +				pos - offs_in_block, ra_bytes, &block);
> > > > +		if (err) {
> > > >  			fsverity_err(inode,
> > > > -				     "Error %d reading Merkle tree page %lu",
> > > > -				     err, index);
> > > > +				     "Error %d reading Merkle tree block %llu",
> > > > +				     err, pos);
> > > >  			break;
> > > 
> > > The error message should go into fsverity_read_merkle_tree_block() so that it
> > > does not need to be duplicated in its two callers.  This would, additionally,
> > > eliminate the need to introduce the 'err' variable in verify_data_block().
> > 
> > Do you want that to be a separate cleanup patch?
> 
> I think it makes sense to do it in this patch, since this patch introduces
> fsverity_read_merkle_tree_block().  This patch also adds the 'err' variable back
> to verify_data_block(), which may mislead people into thinking it's the actual
> error code that users see (this has happened before) --- that could be avoided.

Let's rename it "bad" in verify.c then.  I'm assuming that you /do/ want
the error code in fsverity_read_merkle_tree?

> > > > +int fsverity_read_merkle_tree_block(struct inode *inode,
> > > > +				    const struct merkle_tree_params *params,
> > > > +				    u64 pos, unsigned long ra_bytes,
> > > > +				    struct fsverity_blockbuf *block)
> > > > +{
> > > > +	const struct fsverity_operations *vops = inode->i_sb->s_vop;
> > > > +	unsigned long page_idx;
> > > > +	struct page *page;
> > > > +	unsigned long index;
> > > > +	unsigned int offset_in_page;
> > > > +
> > > > +	if (fsverity_caches_blocks(inode)) {
> > > > +		block->verified = false;
> > > > +		return vops->read_merkle_tree_block(inode, pos, ra_bytes,
> > > > +				params->log_blocksize, block);
> > > > +	}
> > > > +
> > > > +	index = pos >> params->log_blocksize;
> > > 
> > > Should the fourth parameter to ->read_merkle_tree_block be the block index
> > > (which is computed above) instead of log_blocksize?  XFS only uses
> > > params->log_blocksize to compute the block index anyway.
> > 
> > I don't know.  XFS is infamous for everyone having a different opinion
> > and developers being unable to drive a consensus and being able to get a
> > patchset to completion.  So:
> > 
> > Andrey wrote an implementation that used the buffer cache and used block
> > indexes to load/store from the xattr structure.  I didn't like that
> > because layering violation.
> > 
> > willy suggested hanging an xarray off struct xfs_inode and using that to
> > cache merkle tree blocks.  For that design, we want the xarray indexes
> > in units of blocks to conserve space, which means passing in (pos,
> > log_blocksize) or a direct block index.
> > 
> > Christoph then suggested using a per-AG rhashtable to reduce per-inode
> > memory overhead, in which case the lookup key can be either (inumber,
> > pos) or (inumber, block index).  This is a better design if there aren't
> > really going to be that many xfs inodes with verity enabled, though we
> > lose per-inode sharding of the merkle blocks.
> > 
> > Dave thinks that verity inodes could constitute the majority of xfs
> > inodes some day and it should be in the inode instead.
> > 
> > Andrey and I do not have crystal balls, we have no idea how this
> > dchinner/hch disagreement will play out.  Earlier I got the sense that
> > you wanted to move towards expressing all the merkle tree info in units
> > of bytes.
> > 
> > In a lot of ways it would be preferable to move to block indexes
> > instead, since there's never going to be a meaningful access to merkle
> > position 1337.  But you're the maintainer, so it's up to you. :)
> 
> It makes sense to cache the blocks by index regardless of whether you get passed
> the index directly.  So this is just a question of what the
> ->read_merkle_tree_block function prototype should be.
> 
> Currently the other fsverity_operations functions are just aligned with what the
> filesystems actually need: ->read_merkle_tree_page takes a page index, whereas
> ->write_merkle_tree_block takes a pos and size.  xfs_fsverity_read_merkle()
> needs pos, index, and size, and fsverity_read_merkle_tree_block() computes the
> index already.  So that's why I'd probably go with pos, index, and size instead
> of pos, log2_blocksize, and size.  There's no right answer though.

How about just index and size?  I think XFS will work just fine without
the byte position since it's using that as a key for the cache and the
ondisk xattrs anyway.  Even if we can't decide on which data structure
to use for caching. ;)

--D

> 
> - Eric
> 

