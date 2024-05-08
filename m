Return-Path: <linux-fsdevel+bounces-19126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C18BC8C0567
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 22:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C100B21AEB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 20:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0AB130A64;
	Wed,  8 May 2024 20:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNAjxyIa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08996130A72;
	Wed,  8 May 2024 20:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715199271; cv=none; b=LWLT8cWYQA6biUuoQlHM2T2YhbRYPUkvDZLXyravQN2nDMwVzYLWhyVSVsqsIumdf6YjXGx62wJti+LRY8qezZUd8zLkBz5LU8xyTaBxM+WpkAQ8WoRsjTFdTPmWaZvIK2vRprPyY4AbZADvQWstwzr/a7hCTS2CXqqqN0jrTnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715199271; c=relaxed/simple;
	bh=L+Ol7kfXBT3RUCBAFLA55mOGHL2uIz7YXQL6uRrTZ8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvbISo9HNw6R6MZMIwkSa3dyx7j22FiD8CdjTihO9fcYiJPTmoeyPSNQ63YMPWg7zJP+q85VnxuHVo4XXLhmeTviXp/9f6K3BnijOqocS4LaQBZyA8/7QUBj4UwtujGEvXlkVzMVYXNqAwSLx5evmAJBIUopg4wZ3YPpUqgdlTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNAjxyIa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F271C113CC;
	Wed,  8 May 2024 20:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715199270;
	bh=L+Ol7kfXBT3RUCBAFLA55mOGHL2uIz7YXQL6uRrTZ8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JNAjxyIaIJBuJ8jnihB5qf7eOP0ac85N/NkFMu6sVvLZC0Ku4Uvw+NxkIAttwc7Mq
	 tfSACLAL+k6sd51tr4s+3VT1U320/Zw8mi6RkhibBSO16z2IqBatiAmqPoMSeHePwW
	 r9VdPv9eKNyUYSvSGZMycTDVbgcrKNTZGWuqkYrT3hUpoNEPirPJhxJyULQcUsvgkJ
	 WkAhBOnH345f7IkyvFRDOhofFgv/iYfT0RLhAUzNFzsTwVv3+M59kygyxDEbylmFnX
	 Tg6HDjbU108s+N7VYezmlJj8w1N/LidNqeB+CxMokQk0fKXNsN/SOFf9ymoANVtJQN
	 kJZflbm8C4YZQ==
Date: Wed, 8 May 2024 13:14:29 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, aalbersh@redhat.com,
	linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/18] fsverity: convert verification to use byte instead
 of page offsets
Message-ID: <20240508201429.GB360919@frogsfrogsfrogs>
References: <171444679542.955480.18087310571597618350.stgit@frogsfrogsfrogs>
 <171444679642.955480.14668034329027994356.stgit@frogsfrogsfrogs>
 <ZjHwOm-BeLtY25wc@infradead.org>
 <20240501223303.GF360919@frogsfrogsfrogs>
 <20240502004231.GC1853833@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502004231.GC1853833@google.com>

On Thu, May 02, 2024 at 12:42:31AM +0000, Eric Biggers wrote:
> On Wed, May 01, 2024 at 03:33:03PM -0700, Darrick J. Wong wrote:
> > On Wed, May 01, 2024 at 12:33:14AM -0700, Christoph Hellwig wrote:
> > > > +	const u64 end_pos = min(pos + length, vi->tree_params.tree_size);
> > > > +	struct backing_dev_info *bdi = inode->i_sb->s_bdi;
> > > > +	const u64 max_ra_bytes = min((u64)bdi->io_pages << PAGE_SHIFT,
> > > > +				     ULONG_MAX);
> > > > +	const struct merkle_tree_params *params = &vi->tree_params;
> > > 
> > > bdi->io_pages is really a VM readahead concept.  I know this is existing
> > > code, but can we rething why this is even used here?
> > 
> > I would get rid of it entirely for the merkle-by-block case, since we'd
> > have to walk the xattr tree again just to find the next block.  XFS
> > ignores the readahead value entirely.
> > 
> > I think this only makes sense for the merkle-by-page case, and only
> > because ext4 and friends are stuffing the merkle data in the posteof
> > parts of the file mapping.
> > 
> > And even then, shouldn't we figure out the amount of readahead going on
> > and only ask for enough readahead of the merkle tree to satisfy that
> > readahead?
> 
> The existing code is:
> 
>                 unsigned long num_ra_pages =
>                         min_t(unsigned long, last_index - index + 1,
>                               inode->i_sb->s_bdi->io_pages);
> 
> So it does limit the readahead amount to the amount remaining to be read.
> 
> In addition, it's limited to io_pages.  It's possible that's not the best value
> to use (maybe it should be ra_pages?), but the intent was to just use a large
> readahead size, since this code is doing a fully sequential read.

io_pages is supposed to be the optimal IO size, whereas ra_pages is the
readahead size for the block device.  I don't know why you chose
io_pages, but I'm assuming there's a reason there. :)

Somewhat confusingly, I think mm/readahead.c picks the maximum of
io_pages and ra_pages, which doesn't clear things up for me either.

Personally I think fsverity should be using ra_pages here, but changing
it should be a different patch with a separate justification.  This
patch simply has to translate the merkle-by-page code to handle by-block.

> I do think that the concept of Merkle tree readahead makes sense regardless of
> how the blocks are being stored.  Having to go to disk every time a new 4K
> Merkle tree block is needed increases read latencies.  It doesn't need to be
> included in the initial implementation though.

Of course, if we're really ok with xfs making a giant left turn and
storing the entire merkle tree as one big chunk of file range in the
attr fork, then suddenly it *does* make sense to allow merkle tree
readahead again.

> > > And the returned/passed value should be a kernel pointer to the start
> > > of the in-memory copy of the block?
> > > to 
> > 
> > <shrug> This particular callsite is reading merkle data on behalf of an
> > ioctl that exports data.  Maybe we want the filesystem's errors to be
> > bounced up to userspace?
> 
> Yes, I think so.

Ok, thanks for confirming that.

> > > > +static bool is_hash_block_verified(struct inode *inode,
> > > > +				   struct fsverity_blockbuf *block,
> > > >  				   unsigned long hblock_idx)
> > > 
> > > Other fsverify code seems to use the (IMHO) much more readable
> > > two-tab indentation for prototype continuations, maybe stick to that?
> > 
> > I'll do that, if Eric says so. :)
> 
> My preference is to align continuations with the line that they're continuing:
> 
> static bool is_hash_block_verified(struct inode *inode,
> 				   struct fsverity_blockbuf *block,
> 				   unsigned long hblock_idx)
> 
> > > >
> > > >  {
> > > > +	struct fsverity_info *vi = inode->i_verity_info;
> > > > +	struct page *hpage = (struct page *)block->context;
> > > 
> > > block->context is a void pointer, no need for casting it.
> > 
> > Eric insisted on it:
> > https://lore.kernel.org/linux-xfs/20240306035622.GA68962@sol.localdomain/
> 
> No, I didn't.  It showed up in some code snippets that I suggested, but the
> casts originated from the patch itself.  Leaving out the cast is fine with me.

Oh ok.  I'll drop those then.

> > 
> > > > +	for (; level > 0; level--)
> > > > +		fsverity_drop_merkle_tree_block(inode, &hblocks[level - 1].block);
> > > 
> > > Overlh long line here.  But the loop kinda looks odd anyway with the
> > > exta one off in the body instead of the loop.
> > 
> > I /think/ that's a side effect of reusing the value of @level after the
> > first loop fails as the initial conditions of the unwind loop.  AFAICT
> > it doesn't leak, but it's not entirely straightforward.
> 
> When an error occurs either ascending or descending the tree, we end up here
> with 'level' containing the number of levels that need to be cleaned up.  It
> might be clearer if it was called 'num_levels', though that could be confused
> with 'params->num_levels'.  Or we could use: 'while (level-- > 0)'.
> 
> This is unrelated to this patch though.

<nod>

--D

> - Eric
> 

