Return-Path: <linux-fsdevel+bounces-17677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 637238B15D5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 00:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63082B217FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 22:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C023416190B;
	Wed, 24 Apr 2024 22:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1AizFSd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2601015CD7C;
	Wed, 24 Apr 2024 22:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713996540; cv=none; b=or5BvsWHvtWHY5tt/NtLzZWHMMgf040GLL4RYF+RlffqJdx9YTI6NFSS2Fv3wHuL6+YMhJwiqqxyrFLiUF2aE43T4z9ciSMwjoAxzI6BukWJAB9XYUrxe+6OTTFD2TjO4wywuAxyCOsyy31Llz4zOEQu9rJvW4K3jVa7sBIIqVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713996540; c=relaxed/simple;
	bh=JfSixAGoHpfd/0Q+v3RdU4R7VBrNriFyk4wEdQZHnok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PsijYSYS/psSHaMrUcx/kW8dmJbT2HXjjkqYcrWk21yclm8hv1Y3oB17c2GPSoR6wkIDG2QvCQSwFg835yXrnCeHsMal4yNevLSoDKGJ93zrI4YO7m8Os4+D6yPoqKt+g4e2NmKccrnsw2HKPZZ8ZP0oRMawRbJGfekbryfBZDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1AizFSd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98FCC113CD;
	Wed, 24 Apr 2024 22:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713996540;
	bh=JfSixAGoHpfd/0Q+v3RdU4R7VBrNriFyk4wEdQZHnok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V1AizFSdWqxQjWXSILF1UWcYP0kK4IDtkG7WO4g/vGRZAwtEw01W81ThIh0ayjq5V
	 wJdfH5p3/INPZPanNi73+tiphqM2IgodNsL1m2abuC1nKReA1+KU4Slla2L5WPeuLU
	 1Y7ydnciXqx+ncNRxngCp7iMsAHoKumgFCvJyaSW7+wUXGLbUsjFYSKV2W3aNBVFAd
	 D5qfGYzkFyTrf0OOWRZg5wcdmKsvR+4d+lIzL9iqrmpO8vqFP1ZTbJfINbhMWVT5JH
	 UAVW7FzKHdJwAOYOZez2vxzL5WlB6OyvzV+xh9vhM54VC9GTAWE4vLzydiTsPBrLWW
	 hVlP2LtREFYJg==
Date: Wed, 24 Apr 2024 22:08:58 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: aalbersh@redhat.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 03/13] fsverity: support block-based Merkle tree caching
Message-ID: <20240424220858.GC749176@google.com>
References: <171175867829.1987804.15934006844321506283.stgit@frogsfrogsfrogs>
 <171175867913.1987804.4275409634176359386.stgit@frogsfrogsfrogs>
 <20240405023145.GB1958@quark.localdomain>
 <20240424212523.GO360919@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424212523.GO360919@frogsfrogsfrogs>

On Wed, Apr 24, 2024 at 02:25:23PM -0700, Darrick J. Wong wrote:
> > For checking whether the bitmap is in use, it's simpler and more efficient to
> > just directly check whether vi->hash_block_verified is NULL, as the existing
> > code does.  Only the code that allocates the bitmap actually needs to be aware
> > of the details of when the bitmap gets enabled.
> > 
> > fsverity_caches_blocks() has a similar issue, where it could just be replaced
> > with checking vops->read_merkle_tree_block != NULL directly (or equivalently
> > vops->drop_merkle_tree_block, which works well in
> > fsverity_drop_merkle_tree_block() since that's the function pointer it's
> > calling).  The WARN_ON_ONCE() should be done in fsverity_create_info(), not
> > inlined multiple times into the verification code.
> 
> Ok, I'll move the WARN_ON_ONCE there:
> 
> 	/*
> 	 * If the filesystem implementation supplies Merkle tree content on a
> 	 * per-block basis, it must implement both the read and drop functions.
> 	 * If it supplies content on a per-page basis, neither should be
> 	 * provided.
> 	 */
> 	if (vops->read_merkle_tree_block)
> 		WARN_ON_ONCE(vops->drop_merkle_tree_block == NULL);
> 	else
> 		WARN_ON_ONCE(vops->drop_merkle_tree_block != NULL);

Checking ->read_merkle_tree_page would make sense too, right?  I.e. we should
enforce that one of the following two cases holds:

    1. read_merkle_tree_page != NULL &&
       read_merkle_tree_block == NULL &&
       drop_merkle_tree_block == NULL

    2. read_merkle_tree_page == NULL &&
       read_merkle_tree_block != NULL &&
       drop_merkle_tree_block != NULL

> > > +		bytes_to_copy = min_t(u64, end_pos - pos,
> > > +				      params->block_size - offs_in_block);
> > > +
> > > +		err = fsverity_read_merkle_tree_block(inode, &vi->tree_params,
> > > +				pos - offs_in_block, ra_bytes, &block);
> > > +		if (err) {
> > >  			fsverity_err(inode,
> > > -				     "Error %d reading Merkle tree page %lu",
> > > -				     err, index);
> > > +				     "Error %d reading Merkle tree block %llu",
> > > +				     err, pos);
> > >  			break;
> > 
> > The error message should go into fsverity_read_merkle_tree_block() so that it
> > does not need to be duplicated in its two callers.  This would, additionally,
> > eliminate the need to introduce the 'err' variable in verify_data_block().
> 
> Do you want that to be a separate cleanup patch?

I think it makes sense to do it in this patch, since this patch introduces
fsverity_read_merkle_tree_block().  This patch also adds the 'err' variable back
to verify_data_block(), which may mislead people into thinking it's the actual
error code that users see (this has happened before) --- that could be avoided.

> > > +int fsverity_read_merkle_tree_block(struct inode *inode,
> > > +				    const struct merkle_tree_params *params,
> > > +				    u64 pos, unsigned long ra_bytes,
> > > +				    struct fsverity_blockbuf *block)
> > > +{
> > > +	const struct fsverity_operations *vops = inode->i_sb->s_vop;
> > > +	unsigned long page_idx;
> > > +	struct page *page;
> > > +	unsigned long index;
> > > +	unsigned int offset_in_page;
> > > +
> > > +	if (fsverity_caches_blocks(inode)) {
> > > +		block->verified = false;
> > > +		return vops->read_merkle_tree_block(inode, pos, ra_bytes,
> > > +				params->log_blocksize, block);
> > > +	}
> > > +
> > > +	index = pos >> params->log_blocksize;
> > 
> > Should the fourth parameter to ->read_merkle_tree_block be the block index
> > (which is computed above) instead of log_blocksize?  XFS only uses
> > params->log_blocksize to compute the block index anyway.
> 
> I don't know.  XFS is infamous for everyone having a different opinion
> and developers being unable to drive a consensus and being able to get a
> patchset to completion.  So:
> 
> Andrey wrote an implementation that used the buffer cache and used block
> indexes to load/store from the xattr structure.  I didn't like that
> because layering violation.
> 
> willy suggested hanging an xarray off struct xfs_inode and using that to
> cache merkle tree blocks.  For that design, we want the xarray indexes
> in units of blocks to conserve space, which means passing in (pos,
> log_blocksize) or a direct block index.
> 
> Christoph then suggested using a per-AG rhashtable to reduce per-inode
> memory overhead, in which case the lookup key can be either (inumber,
> pos) or (inumber, block index).  This is a better design if there aren't
> really going to be that many xfs inodes with verity enabled, though we
> lose per-inode sharding of the merkle blocks.
> 
> Dave thinks that verity inodes could constitute the majority of xfs
> inodes some day and it should be in the inode instead.
> 
> Andrey and I do not have crystal balls, we have no idea how this
> dchinner/hch disagreement will play out.  Earlier I got the sense that
> you wanted to move towards expressing all the merkle tree info in units
> of bytes.
> 
> In a lot of ways it would be preferable to move to block indexes
> instead, since there's never going to be a meaningful access to merkle
> position 1337.  But you're the maintainer, so it's up to you. :)

It makes sense to cache the blocks by index regardless of whether you get passed
the index directly.  So this is just a question of what the
->read_merkle_tree_block function prototype should be.

Currently the other fsverity_operations functions are just aligned with what the
filesystems actually need: ->read_merkle_tree_page takes a page index, whereas
->write_merkle_tree_block takes a pos and size.  xfs_fsverity_read_merkle()
needs pos, index, and size, and fsverity_read_merkle_tree_block() computes the
index already.  So that's why I'd probably go with pos, index, and size instead
of pos, log2_blocksize, and size.  There's no right answer though.

- Eric

