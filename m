Return-Path: <linux-fsdevel+bounces-18463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2B38B92E1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 02:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DEB11C214B9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 00:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEF2D52F;
	Thu,  2 May 2024 00:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZp3fz1z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506C210FD;
	Thu,  2 May 2024 00:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714610553; cv=none; b=bRl3CgbZY9pH4bWU7G9zHet7sX6mAJzo6IGYna//U712kMv4j4a7bk59C36jxvA+N2d/7NqDrQkwZOivnxB4abRG8y+0nrgifjuh/TZJY1NjUihzcoaBIbN+uAQl4nRn2K4t84YGwGre0CC+iZRby0q50bJbmCuAaSAob93TpOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714610553; c=relaxed/simple;
	bh=M6P/GB5xmMbnjz0ggyELWwz+6xWQrcFl0TE7Xgu4o+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jG0e48NkAvY1X52zE9y77Up6QFc8YAmf9c8K9ROQMXdikuNCKu1rZV2nDFX8Q1ySdr26QXvo53f2tBze7QVDRG8Ub+iKvy+gO/i9qf14NoSlpOVfdofnGjhKNUVlr+9g3aOfDveEIGI0BvU5vKyIriiElA7kR2ba/SkJYfgNYmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZp3fz1z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3530C072AA;
	Thu,  2 May 2024 00:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714610552;
	bh=M6P/GB5xmMbnjz0ggyELWwz+6xWQrcFl0TE7Xgu4o+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cZp3fz1z75Z74koblFxhlXDf20OpFIE0s77ulLj/KbSbi0NFuF34GIEztqX6A4xyV
	 zCyIYH6zHMtQqe0Y+JCIfdsw8/4xguHZYIkfi+tRDAlkr2oNayGnp2vz3TC9WiOM/B
	 VyWpl9PSg1j70TlT+NLybraXhb5WG+JpBRyNqcjcI7Y3gH/LmIKq2jjJi2KMNukv5x
	 tQOH02ZQpnJnF41Ow3+mEUEmSRQ08n56Dbgr/s+EP4SIZV3IHtDZxTivShiD50jfQw
	 5rgf9uanhSuZo39RvRGKp01glS4kLJCg3meLBnuW0jAvA3ejpekvR20Bw4+GSTUk8d
	 UbLsStfpUh/Jg==
Date: Thu, 2 May 2024 00:42:31 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, aalbersh@redhat.com,
	linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/18] fsverity: convert verification to use byte instead
 of page offsets
Message-ID: <20240502004231.GC1853833@google.com>
References: <171444679542.955480.18087310571597618350.stgit@frogsfrogsfrogs>
 <171444679642.955480.14668034329027994356.stgit@frogsfrogsfrogs>
 <ZjHwOm-BeLtY25wc@infradead.org>
 <20240501223303.GF360919@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501223303.GF360919@frogsfrogsfrogs>

On Wed, May 01, 2024 at 03:33:03PM -0700, Darrick J. Wong wrote:
> On Wed, May 01, 2024 at 12:33:14AM -0700, Christoph Hellwig wrote:
> > > +	const u64 end_pos = min(pos + length, vi->tree_params.tree_size);
> > > +	struct backing_dev_info *bdi = inode->i_sb->s_bdi;
> > > +	const u64 max_ra_bytes = min((u64)bdi->io_pages << PAGE_SHIFT,
> > > +				     ULONG_MAX);
> > > +	const struct merkle_tree_params *params = &vi->tree_params;
> > 
> > bdi->io_pages is really a VM readahead concept.  I know this is existing
> > code, but can we rething why this is even used here?
> 
> I would get rid of it entirely for the merkle-by-block case, since we'd
> have to walk the xattr tree again just to find the next block.  XFS
> ignores the readahead value entirely.
> 
> I think this only makes sense for the merkle-by-page case, and only
> because ext4 and friends are stuffing the merkle data in the posteof
> parts of the file mapping.
> 
> And even then, shouldn't we figure out the amount of readahead going on
> and only ask for enough readahead of the merkle tree to satisfy that
> readahead?

The existing code is:

                unsigned long num_ra_pages =
                        min_t(unsigned long, last_index - index + 1,
                              inode->i_sb->s_bdi->io_pages);

So it does limit the readahead amount to the amount remaining to be read.

In addition, it's limited to io_pages.  It's possible that's not the best value
to use (maybe it should be ra_pages?), but the intent was to just use a large
readahead size, since this code is doing a fully sequential read.

I do think that the concept of Merkle tree readahead makes sense regardless of
how the blocks are being stored.  Having to go to disk every time a new 4K
Merkle tree block is needed increases read latencies.  It doesn't need to be
included in the initial implementation though.

> > And the returned/passed value should be a kernel pointer to the start
> > of the in-memory copy of the block?
> > to 
> 
> <shrug> This particular callsite is reading merkle data on behalf of an
> ioctl that exports data.  Maybe we want the filesystem's errors to be
> bounced up to userspace?

Yes, I think so.

> > > +static bool is_hash_block_verified(struct inode *inode,
> > > +				   struct fsverity_blockbuf *block,
> > >  				   unsigned long hblock_idx)
> > 
> > Other fsverify code seems to use the (IMHO) much more readable
> > two-tab indentation for prototype continuations, maybe stick to that?
> 
> I'll do that, if Eric says so. :)

My preference is to align continuations with the line that they're continuing:

static bool is_hash_block_verified(struct inode *inode,
				   struct fsverity_blockbuf *block,
				   unsigned long hblock_idx)

> > >
> > >  {
> > > +	struct fsverity_info *vi = inode->i_verity_info;
> > > +	struct page *hpage = (struct page *)block->context;
> > 
> > block->context is a void pointer, no need for casting it.
> 
> Eric insisted on it:
> https://lore.kernel.org/linux-xfs/20240306035622.GA68962@sol.localdomain/

No, I didn't.  It showed up in some code snippets that I suggested, but the
casts originated from the patch itself.  Leaving out the cast is fine with me.

> 
> > > +	for (; level > 0; level--)
> > > +		fsverity_drop_merkle_tree_block(inode, &hblocks[level - 1].block);
> > 
> > Overlh long line here.  But the loop kinda looks odd anyway with the
> > exta one off in the body instead of the loop.
> 
> I /think/ that's a side effect of reusing the value of @level after the
> first loop fails as the initial conditions of the unwind loop.  AFAICT
> it doesn't leak, but it's not entirely straightforward.

When an error occurs either ascending or descending the tree, we end up here
with 'level' containing the number of levels that need to be cleaned up.  It
might be clearer if it was called 'num_levels', though that could be confused
with 'params->num_levels'.  Or we could use: 'while (level-- > 0)'.

This is unrelated to this patch though.

- Eric

