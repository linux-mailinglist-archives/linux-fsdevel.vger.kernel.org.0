Return-Path: <linux-fsdevel+bounces-583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B07857CD24F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 04:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 487BB1F23577
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 02:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771708F71;
	Wed, 18 Oct 2023 02:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCds61gu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67B98F4B;
	Wed, 18 Oct 2023 02:35:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C61C433C8;
	Wed, 18 Oct 2023 02:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697596511;
	bh=cMmfYKKoIIFRbudaqkTzyaO4jlPkLRxzqxupVt0Gkhc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gCds61guNDo/3Dw2aL1s3gLBwFlVzSLUGch7eBwDeKgolUm4sJgEgJsdD+ZFBN66c
	 yX/XOISW/VrbvdmVe4ysezdagdkY+lqFpEcY/dIliRRzbk+16N3ok/+N95957CRLEW
	 9DwrxUENc2sPqwi0ZeiwKz2QUzg2uE8zZhvjb9lSDrveRoec714QTLNaxv6We7r1n0
	 IcJWsMTgWOLekzIe6k0J0l64g5Q9A4oazqXMudJPzj1jCXeBy44XTeEHLZhdAYc9iz
	 MWThUMbVIiqBAgDXT1YdYNW4FKxuGxRvhzkk34bS7/3csy5uz2NeJ+fHTDxHZUXETO
	 YDTMHT7CVulog==
Date: Tue, 17 Oct 2023 19:35:09 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
	david@fromorbit.com, dchinner@redhat.com
Subject: Re: [PATCH v3 07/28] fsverity: always use bitmap to track verified
 status
Message-ID: <20231018023509.GD3195650@frogsfrogsfrogs>
References: <20231006184922.252188-1-aalbersh@redhat.com>
 <20231006184922.252188-8-aalbersh@redhat.com>
 <20231011031543.GB1185@sol.localdomain>
 <q75t2etmyq2zjskkquikatp4yg7k2yoyt4oab4grhlg7yu4wyi@6eax4ysvavyk>
 <20231012072746.GA2100@sol.localdomain>
 <20231013031209.GS21298@frogsfrogsfrogs>
 <20231017045834.GC1907@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017045834.GC1907@sol.localdomain>

On Mon, Oct 16, 2023 at 09:58:34PM -0700, Eric Biggers wrote:
> On Thu, Oct 12, 2023 at 08:12:09PM -0700, Darrick J. Wong wrote:
> > Hi Eric,
> > 
> > [Please excuse my ignorance, this is only the third time I've dived
> > into fsverity.]
> > 
> > On Thu, Oct 12, 2023 at 12:27:46AM -0700, Eric Biggers wrote:
> > > On Wed, Oct 11, 2023 at 03:03:55PM +0200, Andrey Albershteyn wrote:
> > > > > How complicated would it be to keep supporting using the page bit when
> > > > > merkle_tree_block_size == page_size and the filesystem supports it?  It's an
> > > > > efficient solution, so it would be a shame to lose it.  Also it doesn't have the
> > > > > max file size limit that the bitmap has.
> > 
> > How complex would it be to get rid of the bitmap entirely, and validate
> > all the verity tree blocks within a page all at once instead of
> > individual blocks within a page?
> > 
> > Assuming willy isn't grinding his axe to get rid of PGchecked,
> > obviously. ;)
> 
> See what I wrote earlier at
> https://lore.kernel.org/linux-xfs/Y5ltzp6yeMo1oDSk@sol.localdomain.
> Basically it would increase the worst-case latency by a lot.

Ahh.  Yeah, ok, got it, you don't necessarily want to prefault a bunch
more merkle tree blocks all at once just to read a single byte. :)

> > 
> > > > Well, I think it's possible but my motivation was to step away from
> > > > page manipulation as much as possible with intent to not affect other
> > > > filesystems too much. I can probably add handling of this case to
> > > > fsverity_read_merkle_tree_block() but fs/verity still will create
> > > > bitmap and have a limit. The other way is basically revert changes
> > > > done in patch 09, then, it probably will be quite a mix of page/block
> > > > handling in fs/verity/verify.c
> > > 
> > > The page-based caching still has to be supported anyway, since that's what the
> > > other filesystems that support fsverity use, and it seems you don't plan to
> > > change that.
> > 
> > I frankly have been asking myself why /this/ patchset adds so much extra
> > code and flags and whatnot to XFS and fs/verity.  From what I can tell,
> > the xfs buffer cache has been extended to allocate double the memory so
> > that xattr contents can be shadowed.  getxattr for merkle tree contents
> > then pins the buffer, shadows the contents, and hands both back to the
> > caller (aka xfs_read_merkle_tree_block).   The shadow memory is then
> > handed to fs/verity to do its magic; following that, fsverity releases
> > the reference and we can eventually drop the xfs_buf reference.
> > 
> > But this seems way overcomplicated to me.  ->read_merkle_tree_page hands
> > us a pgoff_t and a suggestion for page readahead, and wants us to return
> > an uptodate locked page, right?
> > 
> > Why can't xfs allocate a page, walk the requested range to fill the page
> > with merkle tree blocks that were written to the xattr structure (or
> > zero the page contents if there is no xattr), and hand that page to
> > fsverity?  (It helps to provide the merkle tree block size to
> > xfs_read_merkle_tree_page, thanks for adding that).
> 
> Earlier versions of this patchset did that.  But, it's only really feasible if
> the pages are actually cached.  Otherwise it's very inefficient and can result
> in random ENOMEM.
> 
> > Assuming fsverity also wants some caching, we could augment the
> > xfs_inode to point to a separate address_space for cached merkle tree
> > pages, and then xfs_read_merkle_tree_page can use __filemap_get_folio to
> > find uptodate cached pages, or instantiate one and make it uptodate.
> > Even better, we can pretty easily use multipage folios for this, though
> > AFAICT the fs/verity code isn't yet up to handling that.
> > 
> > The only thing I can't quite figure out is how to get memory reclaim to
> > scan the extra address_space when it wants to try to reclaim pages.
> > That part ext4 and f2fs got for free because they stuffed the merkle
> > tree in the posteof space.
> > 
> > But wouldn't that solve /all/ the plumbing problems without scattering
> > bits of new code and flags into the xfs buffer cache, the extended
> > attributes code, and elsewhere?  And then xfs would not need to burn up
> > vmap space to allocate 8K memory blocks just to provide 4k merkel tree
> > blocks to fs/verity.
> > 
> > That's just my 2 cents from spending a couple of hours hypothesizing how
> > I would fill out the fsverity_operations.
> 
> That might work.  I'm not sure about the details though, e.g. can mapping->host
> point to the file's inode or would it need to be a fake one.

Me neither.  I /think/ invalidate_mapping_pages would do the job, though
one would probably want to have a custom shrinker so we could find out
just how many pages are desired by reclaim, and then try to invalidate
only that many pages.  Not sure what happens if there are multiple
mappings whose ->host pointers point to the same inode.

Alternately I wonder if we could make a tmpfs file that would evict live
contents instead of writing them to the paging file... ;)

--D

> 
> - Eric

