Return-Path: <linux-fsdevel+bounces-237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C45267C7BE9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 05:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D4B8B209B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 03:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2CCED7;
	Fri, 13 Oct 2023 03:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cm8OSBhz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153A0EA6;
	Fri, 13 Oct 2023 03:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E13C433C8;
	Fri, 13 Oct 2023 03:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697166730;
	bh=NYHI34uOZW76WOHd3rPCVjTdBM893fhqz6wst0gmhdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cm8OSBhzNy2O8iproEg02gP1ZCrhhtALvbD5HsU056LgPHKrtaUqknpifaMnelL9q
	 2TwwYIvrxlo57G4x8QKhW4KNTwcLk2+SprfASeebo9BBx5L9hzZdrnpCuiynVYWGM9
	 1RbHpayuQ+gRV2yl9yDPSrhsJkYV6pHHhxZCQKR83gEH8yo3oxncoMlNhnqVFCp9my
	 vlVBOng5/Oqc6+eca0fRXopdbozveiZ1kCUziYr2IZ50BwhnF0Nay2wbL/CKZFSGOI
	 UOHh3xpUxWbodZCGSNXHXY1fhiocPDQDPXuh/jmipEGfw7v33dED7xPfZCEA3D1v3F
	 EDx9cdjAsfW3w==
Date: Thu, 12 Oct 2023 20:12:09 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
	david@fromorbit.com, dchinner@redhat.com
Subject: Re: [PATCH v3 07/28] fsverity: always use bitmap to track verified
 status
Message-ID: <20231013031209.GS21298@frogsfrogsfrogs>
References: <20231006184922.252188-1-aalbersh@redhat.com>
 <20231006184922.252188-8-aalbersh@redhat.com>
 <20231011031543.GB1185@sol.localdomain>
 <q75t2etmyq2zjskkquikatp4yg7k2yoyt4oab4grhlg7yu4wyi@6eax4ysvavyk>
 <20231012072746.GA2100@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012072746.GA2100@sol.localdomain>

Hi Eric,

[Please excuse my ignorance, this is only the third time I've dived
into fsverity.]

On Thu, Oct 12, 2023 at 12:27:46AM -0700, Eric Biggers wrote:
> On Wed, Oct 11, 2023 at 03:03:55PM +0200, Andrey Albershteyn wrote:
> > > How complicated would it be to keep supporting using the page bit when
> > > merkle_tree_block_size == page_size and the filesystem supports it?  It's an
> > > efficient solution, so it would be a shame to lose it.  Also it doesn't have the
> > > max file size limit that the bitmap has.

How complex would it be to get rid of the bitmap entirely, and validate
all the verity tree blocks within a page all at once instead of
individual blocks within a page?

Assuming willy isn't grinding his axe to get rid of PGchecked,
obviously. ;)

> > Well, I think it's possible but my motivation was to step away from
> > page manipulation as much as possible with intent to not affect other
> > filesystems too much. I can probably add handling of this case to
> > fsverity_read_merkle_tree_block() but fs/verity still will create
> > bitmap and have a limit. The other way is basically revert changes
> > done in patch 09, then, it probably will be quite a mix of page/block
> > handling in fs/verity/verify.c
> 
> The page-based caching still has to be supported anyway, since that's what the
> other filesystems that support fsverity use, and it seems you don't plan to
> change that.

I frankly have been asking myself why /this/ patchset adds so much extra
code and flags and whatnot to XFS and fs/verity.  From what I can tell,
the xfs buffer cache has been extended to allocate double the memory so
that xattr contents can be shadowed.  getxattr for merkle tree contents
then pins the buffer, shadows the contents, and hands both back to the
caller (aka xfs_read_merkle_tree_block).   The shadow memory is then
handed to fs/verity to do its magic; following that, fsverity releases
the reference and we can eventually drop the xfs_buf reference.

But this seems way overcomplicated to me.  ->read_merkle_tree_page hands
us a pgoff_t and a suggestion for page readahead, and wants us to return
an uptodate locked page, right?

Why can't xfs allocate a page, walk the requested range to fill the page
with merkle tree blocks that were written to the xattr structure (or
zero the page contents if there is no xattr), and hand that page to
fsverity?  (It helps to provide the merkle tree block size to
xfs_read_merkle_tree_page, thanks for adding that).

Assuming fsverity also wants some caching, we could augment the
xfs_inode to point to a separate address_space for cached merkle tree
pages, and then xfs_read_merkle_tree_page can use __filemap_get_folio to
find uptodate cached pages, or instantiate one and make it uptodate.
Even better, we can pretty easily use multipage folios for this, though
AFAICT the fs/verity code isn't yet up to handling that.

The only thing I can't quite figure out is how to get memory reclaim to
scan the extra address_space when it wants to try to reclaim pages.
That part ext4 and f2fs got for free because they stuffed the merkle
tree in the posteof space.

But wouldn't that solve /all/ the plumbing problems without scattering
bits of new code and flags into the xfs buffer cache, the extended
attributes code, and elsewhere?  And then xfs would not need to burn up
vmap space to allocate 8K memory blocks just to provide 4k merkel tree
blocks to fs/verity.

That's just my 2 cents from spending a couple of hours hypothesizing how
I would fill out the fsverity_operations.

> The question is where the "block verified" flags should be stored.
> Currently there are two options: PG_checked and the separate bitmap.  I'm not
> yet convinced that removing the support for the PG_checked method is a good
> change.  PG_checked is a nice solution for the cases where it can be used; it
> requires no extra memory, no locking, and has no max file size.  Also, this
> change seems mostly orthogonal to what you're actually trying to accomplish.

That scheme sounds way better to me than the bitmap. ;)

--D

> > > > Also, this patch removes spinlock. The lock was used to reset bits
> > > > in bitmap belonging to one page. This patch works only with one
> > > > Merkle tree block and won't reset other blocks status.
> > > 
> > > The spinlock is needed when there are multiple Merkle tree blocks per page and
> > > the filesystem is using the page-based caching.  So I don't think you can remove
> > > it.  Can you elaborate on why you feel it can be removed?
> > 
> > With this patch is_hash_block_verified() doesn't reset bits for
> > blocks belonging to the same page. Even if page is re-instantiated
> > only one block is checked in this case. So, when other blocks are
> > checked they are reset.
> > 
> > 	if (block_cached)
> > 		return test_bit(hblock_idx, vi->hash_block_verified);
> 
> When part of the Merkle tree cache is evicted and re-instantiated, whether that
> part is a "page" or something else, the verified status of all the blocks
> contained in that part need to be invalidated so that they get re-verified.  The
> existing code does that.  I don't see how your proposed code does that.
> 
> - Eric

