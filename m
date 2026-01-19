Return-Path: <linux-fsdevel+bounces-74370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EDFD39E94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 07:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDCAB303D882
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 06:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BA126FA60;
	Mon, 19 Jan 2026 06:34:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A4A26C3A2;
	Mon, 19 Jan 2026 06:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768804441; cv=none; b=rcQLr/Rrg5Ne3IhXFsMUykuriXbryP+XxDMqjPBYjtAwW02zXwTZwCG67cBlmj4zKSbnT8kpaVGw30bMPFJ/zc0M1wBQGG4wfrUm7PkE8NjhmqeBoXvRO8HvtjqsdqI1LDFBMhMUYT/f4G1rXmqNzVUGQQ1X99C+sx06o/rRdvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768804441; c=relaxed/simple;
	bh=tiasUID9V3LyXmNQ/3VFu+opuMBWShf55UGKactveAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKVqv/UbVYJpRKJC/XELu68MmQ4FAzk2xCmqzQl8FG1FeqgMP16yJedJ8TLCAWhLLYJo81+eyo5ULsxuuBP2K3YTmVCznfVHSSyxTRSoZrw+wahf52I1DbbcUCJuviTNYagjaHwoZRNsrPkjyv/sauW5WdNFI4ZE7eTGaBGgcbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B8DD9227A88; Mon, 19 Jan 2026 07:33:49 +0100 (CET)
Date: Mon, 19 Jan 2026 07:33:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, ebiggers@kernel.org,
	linux-fsdevel@vger.kernel.org, aalbersh@kernel.org,
	david@fromorbit.com, hch@lst.de, tytso@mit.edu,
	linux-ext4@vger.kernel.org, jaegeuk@kernel.org, chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: fsverity metadata offset, was: Re: [PATCH v2 0/23] fs-verity
 support for XFS with post EOF merkle tree
Message-ID: <20260119063349.GA643@lst.de>
References: <cover.1768229271.patch-series@thinky> <aWZ0nJNVTnyuFTmM@casper.infradead.org> <op5poqkjoachiv2qfwizunoeg7h6w5x2rxdvbs4vhryr3aywbt@cul2yevayijl> <aWci_1Uu5XndYNkG@casper.infradead.org> <20260114061536.GG15551@frogsfrogsfrogs> <5z5r6jizgxqz5axvzwbdmtkadehgdf7semqy2oxsfytmzzu6ik@zfvhexcp3fz2> <6r24wj3o3gctl3vz4n3tdrfjx5ftkybdjmmye2hejdcdl6qseh@c2yvpd5d4ocf>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6r24wj3o3gctl3vz4n3tdrfjx5ftkybdjmmye2hejdcdl6qseh@c2yvpd5d4ocf>
User-Agent: Mutt/1.5.17 (2007-11-01)

While looking at fsverity I'd like to understand the choise of offset
in ext4 and f2fs, and wonder about an issue.

Both ext4 and f2fs round up the inode size to the next 64k boundary
and place the metadata there.  Both use the 65536 magic number for that
instead of a well documented constant unfortunately.

I assume this was picked to align up to the largest reasonable page
size?  Unfortunately for that:

 a) not all architectures are reasonable.  As Darrick pointed out
    hexagon seems to support page size up to 1MiB.  While I don't know
    if they exist in real life, powerpc supports up to 256kiB pages,
    and I know they are used for real in various embedded settings
 b) with large folio support in the page cache, the folios used to
    map files can be much larger than the base page size, with all
    the same issues as a larger page size

So assuming that fsverity is trying to avoid the issue of a page/folio
that covers both data and fsverity metadata, how does it copy with that?
Do we need to disable fsverity on > 64k page size and disable large
folios on fsverity files?  The latter would mean writing back all cached
data first as well.

And going forward, should we have a v2 format that fixes this?  For that
we'd still need a maximum folio size of course.   And of course I'd like
to get all these things right from the start in XFS, while still being as
similar as possible to ext4/f2fs.

On Wed, Jan 14, 2026 at 10:53:00AM +0100, Andrey Albershteyn wrote:
> On 2026-01-14 09:20:34, Andrey Albershteyn wrote:
> > On 2026-01-13 22:15:36, Darrick J. Wong wrote:
> > > On Wed, Jan 14, 2026 at 05:00:47AM +0000, Matthew Wilcox wrote:
> > > > On Tue, Jan 13, 2026 at 07:45:47PM +0100, Andrey Albershteyn wrote:
> > > > > On 2026-01-13 16:36:44, Matthew Wilcox wrote:
> > > > > > On Mon, Jan 12, 2026 at 03:49:44PM +0100, Andrey Albershteyn wrote:
> > > > > > > The tree is read by iomap into page cache at offset 1 << 53. This is far
> > > > > > > enough to handle any supported file size.
> > > > > > 
> > > > > > What happens on 32-bit systems?  (I presume you mean "offset" as
> > > > > > "index", so this is 1 << 65 bytes on machines with a 4KiB page size)
> > > > > > 
> > > > > it's in bytes, yeah I missed 32-bit systems, I think I will try to
> > > > > convert this offset to something lower on 32-bit in iomap, as
> > > > > Darrick suggested.
> > > > 
> > > > Hm, we use all 32 bits of folio->index on 32-bit plaftorms.  That's
> > > > MAX_LFS_FILESIZE.  Are you proposing reducing that?
> > > > 
> > > > There are some other (performance) penalties to using 1<<53 as the lowest
> > > > index for metadata on 64-bit.  The radix tree is going to go quite high;
> > > > we use 6 bits at each level, so if you have a folio at 0 and a folio at
> > > > 1<<53, you'll have a tree of height 9 and use 17 nodes.
> > > > 
> > > > That's going to be a lot of extra cache misses when walking the XArray
> > > > to find any given folio.  Allowing the filesystem to decide where the
> > > > metadata starts for any given file really is an important optimisation.
> > > > Even if it starts at index 1<<29, you'll almost halve the number of
> > > > nodes needed.
> > 
> > Thanks for this overview!
> > 
> > > 
> > > 1<<53 is only the location of the fsverity metadata in the ondisk
> > > mapping.  For the incore mapping, in theory we could load the fsverity
> > > anywhere in the post-EOF part of the pagecache to save some bits.
> > > 
> > > roundup(i_size_read(), 1<<folio_max_order)) would work, right?
> > 
> > Then, there's probably no benefits to have ondisk mapping differ,
> > no?
> 
> oh, the fixed ondisk offset will help to not break if filesystem
> would be mounted by machine with different page size.
> 
> -- 
> - Andrey
---end quoted text---

