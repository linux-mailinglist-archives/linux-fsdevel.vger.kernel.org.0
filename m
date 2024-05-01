Return-Path: <linux-fsdevel+bounces-18448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 901288B91A5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 00:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D6D0B22AD5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 22:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14F412D76F;
	Wed,  1 May 2024 22:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4963b2x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4382B1E481;
	Wed,  1 May 2024 22:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714602784; cv=none; b=bdBGw6m1deOq7H82qtIdZf5cH4qsvcgYfqdFxMnEas4GSn2E35hsZjJ2jIjMuU7vwBcFzCkagzNtBQV0DhGMvQ2xtel3ogBh75qDhJTYCtXPAcribHZ+Gty49Q/W+R/M0Ua2rjEF/ts84x935U9t1jNDQ7SEOA8L0MLMqbbbFAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714602784; c=relaxed/simple;
	bh=SXUFuaOJoSac9lyY+40DWv0sbSS1T9Uq9O7o2TAjUR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k76KJ83iRrJjmZqjuLB4G9uKSqASr5QyJjMbyo1CAm7v6iIdNv3ECSl1R0GMCayKjkyM1ndwFFoft7KGmsxU5ssVLL+dovTUDey7/ZGxKHKWVSU/iW07VKBO0aND+KoNhTgT1oGiK+X29Edwgol6/g9Ll56o+6/GhWIGh7rxQHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4963b2x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10AC0C072AA;
	Wed,  1 May 2024 22:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714602784;
	bh=SXUFuaOJoSac9lyY+40DWv0sbSS1T9Uq9O7o2TAjUR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t4963b2xT5uS1LxZd3jXl14nSt5FL/Ad6apgV5Wcj6LwRXa5IYbS247mYVGMmfxdt
	 ui55y7CbF3lDMqNWloT3jnvmTwdPZR5+Bujot0HLehDNaP3n9hzMrpUzhbMlQAjanG
	 yLygY8yDsv9xxU+ArZ5inB/Y6yd6FlWu2ipPttqzWobKR1gyYTYERbbAa754q5WmR8
	 0BK4mLcYX2Bd68FBwBGlT0mUXxaQBYLtk4AC/h/NnO66AX99fkcgnxJzi5bROhFpvY
	 UwXDrha3ilJG2hvGtikuEY/8IPsJ4+4K/kSylxbwH8DtcZi4OCMPIFv5LLuQOstjHz
	 yvm0e29o9U2Fw==
Date: Wed, 1 May 2024 15:33:03 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: aalbersh@redhat.com, ebiggers@kernel.org, linux-xfs@vger.kernel.org,
	alexl@redhat.com, walters@verbum.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/18] fsverity: convert verification to use byte instead
 of page offsets
Message-ID: <20240501223303.GF360919@frogsfrogsfrogs>
References: <171444679542.955480.18087310571597618350.stgit@frogsfrogsfrogs>
 <171444679642.955480.14668034329027994356.stgit@frogsfrogsfrogs>
 <ZjHwOm-BeLtY25wc@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjHwOm-BeLtY25wc@infradead.org>

On Wed, May 01, 2024 at 12:33:14AM -0700, Christoph Hellwig wrote:
> > +	const u64 end_pos = min(pos + length, vi->tree_params.tree_size);
> > +	struct backing_dev_info *bdi = inode->i_sb->s_bdi;
> > +	const u64 max_ra_bytes = min((u64)bdi->io_pages << PAGE_SHIFT,
> > +				     ULONG_MAX);
> > +	const struct merkle_tree_params *params = &vi->tree_params;
> 
> bdi->io_pages is really a VM readahead concept.  I know this is existing
> code, but can we rething why this is even used here?

I would get rid of it entirely for the merkle-by-block case, since we'd
have to walk the xattr tree again just to find the next block.  XFS
ignores the readahead value entirely.

I think this only makes sense for the merkle-by-page case, and only
because ext4 and friends are stuffing the merkle data in the posteof
parts of the file mapping.

And even then, shouldn't we figure out the amount of readahead going on
and only ask for enough readahead of the merkle tree to satisfy that
readahead?

> > +	unsigned int offs_in_block = pos & (params->block_size - 1);
> >  	int retval = 0;
> >  	int err = 0;
> >  
> > +	 * Iterate through each Merkle tree block in the requested range and
> > +	 * copy the requested portion to userspace. Note that we are returning
> > +	 * a byte stream.
> >  	 */
> > +	while (pos < end_pos) {
> > +		unsigned long ra_bytes;
> > +		unsigned int bytes_to_copy;
> > +		struct fsverity_blockbuf block = { };
> >  
> > +		ra_bytes = min_t(unsigned long, end_pos - pos, max_ra_bytes);
> > +		bytes_to_copy = min_t(u64, end_pos - pos,
> > +				      params->block_size - offs_in_block);
> > +
> > +		err = fsverity_read_merkle_tree_block(inode, &vi->tree_params,
> > +						      pos - offs_in_block,
> > +						      ra_bytes, &block);
> 
> Maybe it's just me, but isn't passing a byte offset to a read...block
> routine a bit weird and this should operate on the block number instead?

I would think so, but here's the thing -- the write_merkle_tree_block
functions get passed pos and length in units of bytes.  Maybe fsverity
should clean be passing (blockno, blocksize) to the read and write
functions?  Eric said he could be persuaded to change it:

https://lore.kernel.org/linux-xfs/20240307224903.GE1799@sol.localdomain/

> > +		if (copy_to_user(buf, block.kaddr + offs_in_block, bytes_to_copy)) {
> 
> And the returned/passed value should be a kernel pointer to the start
> of the in-memory copy of the block?
> to 

<shrug> This particular callsite is reading merkle data on behalf of an
ioctl that exports data.  Maybe we want the filesystem's errors to be
bounced up to userspace?

> > +static bool is_hash_block_verified(struct inode *inode,
> > +				   struct fsverity_blockbuf *block,
> >  				   unsigned long hblock_idx)
> 
> Other fsverify code seems to use the (IMHO) much more readable
> two-tab indentation for prototype continuations, maybe stick to that?

I'll do that, if Eric says so. :)

> >
> >  {
> > +	struct fsverity_info *vi = inode->i_verity_info;
> > +	struct page *hpage = (struct page *)block->context;
> 
> block->context is a void pointer, no need for casting it.

Eric insisted on it:
https://lore.kernel.org/linux-xfs/20240306035622.GA68962@sol.localdomain/

> > +	for (; level > 0; level--)
> > +		fsverity_drop_merkle_tree_block(inode, &hblocks[level - 1].block);
> 
> Overlh long line here.  But the loop kinda looks odd anyway with the
> exta one off in the body instead of the loop.

I /think/ that's a side effect of reusing the value of @level after the
first loop fails as the initial conditions of the unwind loop.  AFAICT
it doesn't leak, but it's not entirely straightforward.

--D

