Return-Path: <linux-fsdevel+bounces-74528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D5CD3B7E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 21:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A3053063820
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 20:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F8D2E764D;
	Mon, 19 Jan 2026 20:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PkKWgeLG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3886D16A395;
	Mon, 19 Jan 2026 20:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768852854; cv=none; b=diMgkMDsGgLvdUxlJbW2aobrfxoIftptaijkXnN9TBPZBEKPb7CYcWXvAas0L2fDSpkl9ij0PzubPXepOgrBAgV1jY9agv6xkcbMjMCKcIuzD2ZC1MjU67xcXA8ni/C8M2eQFOgnqaGB8TyCnl/yrFgky0amIEm5PDecsDn+kdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768852854; c=relaxed/simple;
	bh=BqkcSD9fWqlhrwz3aObG4sEFqK5z8A2c8MZ1+Xcp/uU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jaEcDdqfNJxXjXIqSA65C4cYSJzCmX3NjdpJLelFjXk+CQc2ZTsrk+RNdOJUNIiplWWBs52JqzbhoO7lg7rcCeLRoPEf1UXattevrOZ8ax0z0ZkpY1a48y9rjHeW0aMRk2rdSDlEEj53xeyUl0HcPSYa7dqFJrfCypvncRewk84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PkKWgeLG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FRKiCSA7rKWJel5+3BbX0cg/N3+Hr+jXkHWboVk9B18=; b=PkKWgeLGDbX9229PwsBfHnNC6a
	ZROjbZ37Pu5RNnsaags+fn2KGYNRtGURT3Yq5twxJPoK5wMdWmchHOvhQlfZt1P20IV8EgAP/hx3G
	ti6u8FqNn8o9ukls4Okp+XGa60zPjLmljUjTpdwweu1/af3IsRxrczqc9kSR0s3pld+FYJUEbtt3o
	s+/pHjiU1na8EvCU77e7YSAW8VvnquMWFGWuaXgCYu6G8Cm5VG0gGhl9/e6xYDgjG4Arb3qs5HhnT
	dmD6zT7a0lOMeAfQjo+drREd0Aen4TUdsje40EyK1i4GHDjZTw9J0iiccD208K6+AltBGN0+JJr9A
	SN6zcziQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhvQe-0000000DlZy-0U4y;
	Mon, 19 Jan 2026 20:00:48 +0000
Date: Mon, 19 Jan 2026 20:00:47 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	aalbersh@kernel.org, david@fromorbit.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org, jaegeuk@kernel.org, chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: fsverity metadata offset, was: Re: [PATCH v2 0/23] fs-verity
 support for XFS with post EOF merkle tree
Message-ID: <aW6NbyQgCMnjkFZ8@casper.infradead.org>
References: <cover.1768229271.patch-series@thinky>
 <aWZ0nJNVTnyuFTmM@casper.infradead.org>
 <op5poqkjoachiv2qfwizunoeg7h6w5x2rxdvbs4vhryr3aywbt@cul2yevayijl>
 <aWci_1Uu5XndYNkG@casper.infradead.org>
 <20260114061536.GG15551@frogsfrogsfrogs>
 <5z5r6jizgxqz5axvzwbdmtkadehgdf7semqy2oxsfytmzzu6ik@zfvhexcp3fz2>
 <6r24wj3o3gctl3vz4n3tdrfjx5ftkybdjmmye2hejdcdl6qseh@c2yvpd5d4ocf>
 <20260119063349.GA643@lst.de>
 <20260119193242.GB13800@sol>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119193242.GB13800@sol>

On Mon, Jan 19, 2026 at 11:32:42AM -0800, Eric Biggers wrote:
> On Mon, Jan 19, 2026 at 07:33:49AM +0100, Christoph Hellwig wrote:
> > While looking at fsverity I'd like to understand the choise of offset
> > in ext4 and f2fs, and wonder about an issue.
> > 
> > Both ext4 and f2fs round up the inode size to the next 64k boundary
> > and place the metadata there.  Both use the 65536 magic number for that
> > instead of a well documented constant unfortunately.
> > 
> > I assume this was picked to align up to the largest reasonable page
> > size?  Unfortunately for that:
> > 
> >  a) not all architectures are reasonable.  As Darrick pointed out
> >     hexagon seems to support page size up to 1MiB.  While I don't know
> >     if they exist in real life, powerpc supports up to 256kiB pages,
> >     and I know they are used for real in various embedded settings
> >  b) with large folio support in the page cache, the folios used to
> >     map files can be much larger than the base page size, with all
> >     the same issues as a larger page size
> > 
> > So assuming that fsverity is trying to avoid the issue of a page/folio
> > that covers both data and fsverity metadata, how does it copy with that?
> > Do we need to disable fsverity on > 64k page size and disable large
> > folios on fsverity files?  The latter would mean writing back all cached
> > data first as well.
> > 
> > And going forward, should we have a v2 format that fixes this?  For that
> > we'd still need a maximum folio size of course.   And of course I'd like
> > to get all these things right from the start in XFS, while still being as
> > similar as possible to ext4/f2fs.
> 
> Yes, if I recall correctly it was intended to be the "largest reasonable
> page size".  It looks like PAGE_SIZE > 65536 can't work as-is, so indeed
> we should disable fsverity support in that configuration.

I don't think anybody will weep for lack of fsverity support in these
weirdo large PAGE_SIZE configurations.

> I don't think large folios are quite as problematic.
> ext4_read_merkle_tree_page() and f2fs_read_merkle_tree_page() read a
> folio and return the appropriate page in it, and fs/verity/verify.c
> operates on the page.  If it's a page in the folio that spans EOF, I
> think everything will actually still work, except userspace will be able
> to see Merkle tree data after a 64K boundary past EOF if the file is
> mmapped using huge pages.
> 
> The mmap issue isn't great, but I'm not sure how much it matters,
> especially when the zeroes do still go up to a 64K boundary.

We actually refuse to map pages after EOF.  See filemap_map_pages()

        if ((file_end >= folio_next_index(folio) || shmem_mapping(mapping)) &&
            filemap_map_pmd(vmf, folio, start_pgoff)) {
                ret = VM_FAULT_NOPAGE;
                goto out;
        }

along with the other treatment of end_pgoff.


