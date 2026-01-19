Return-Path: <linux-fsdevel+bounces-74527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 487EDD3B7D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 20:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E1B3308A573
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 19:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BBC2EBB99;
	Mon, 19 Jan 2026 19:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opDvoJ/B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEA62DB78A;
	Mon, 19 Jan 2026 19:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768852697; cv=none; b=FJh4Xj7w+B0xsHvbEdEqDZu2ug1DgrN5PFzLDi6nCF7gwg9F5Nd3C+VmMFObprG3P6v85GDLjZKNZX/RBsq2K5X7XX2K2kJdNRlHIq7s4Ea0lOdBGa+9+TqF62tSeAPmOTEVlcuKHJ9fAM/KYZ8Wb9qciGGKQITrxuhpFAhpJwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768852697; c=relaxed/simple;
	bh=ekOFZ1V/tiINPTPwNqibbQ8QbrvjFe8w7udiVRxxOpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HkR06XAZxU12Rp4BfDEflW/RqUm6gw+C4RGKJTUOEsBitBMHNl5/UzEmZLMsQvAVOSR2RPZm8Pxu0M1Cl5eGHzhQZ/WfGTPrOZAOyF9rPO1mc2pENjT6WU81LN2Wg4YXs5csssoIFjScyYWI3f/kJuyOuMuPj6fkr/5G1ozu19M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opDvoJ/B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C41C116C6;
	Mon, 19 Jan 2026 19:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768852696;
	bh=ekOFZ1V/tiINPTPwNqibbQ8QbrvjFe8w7udiVRxxOpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=opDvoJ/BL/3HrZfozw1vZeKcO2AfiVX13r49Js/xnBacs6lr4J69698T5qbJFoPhF
	 Hyquvzbftvy/unT3a0r1kjS6KNIgKv7cQKog+t4/oKmvO88Qmns5MDAyoVhCx/nt7G
	 SGljfyFAEKsRfUkMW4C+U9oVuWWD8KTo1ibgj11x2nzHPjE3W7Wsum+qqMKkewExvi
	 ckt9ZWbVueWQ9DxcFk2y+iL4TuQlVTaNsaf7z7mI5iDn4tofUa5zVp3Krc10rnpvFR
	 wuUpIG34bLSpOJmi2Me11FYjEDGSlLfA7WN2BXNAMtELS/MunAAvCPK/Xvngs3kgiW
	 bdFwpeWLWxW/g==
Date: Mon, 19 Jan 2026 11:58:16 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	aalbersh@kernel.org, david@fromorbit.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org, jaegeuk@kernel.org, chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: fsverity metadata offset, was: Re: [PATCH v2 0/23] fs-verity
 support for XFS with post EOF merkle tree
Message-ID: <20260119195816.GA15583@frogsfrogsfrogs>
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

They *did* way back in the day, I worked with some seekrit PPC440s early
in my career.  I don't know that any of them still exist, but the code
is still there...

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
> 
> I don't think large folios are quite as problematic.
> ext4_read_merkle_tree_page() and f2fs_read_merkle_tree_page() read a
> folio and return the appropriate page in it, and fs/verity/verify.c
> operates on the page.  If it's a page in the folio that spans EOF, I
> think everything will actually still work, except userspace will be able
> to see Merkle tree data after a 64K boundary past EOF if the file is
> mmapped using huge pages.

We don't allow mmapping file data beyond the EOF basepage, even if the
underlying folio is a large folio.  See generic/749, though recently
Kiryl Shutsemau tried to remove that restriction[1], until dchinner and
willy told him no.

> The mmap issue isn't great, but I'm not sure how much it matters,
> especially when the zeroes do still go up to a 64K boundary.

I'm concerned that post-eof zeroing of a 256k folio could accidentally
obliterate merkle tree content that was somehow previously loaded.
Though afaict from the existing codebases, none of them actually make
that mistake.

> If we do need to fix this, there are a couple things we could consider
> doing without changing the on-disk format in ext4 or f2fs: putting the
> data in the page cache at a different offset than it exists on-disk, or
> using "small" pages for EOF specifically.

I'd leave the ondisk offset as-is, but change the pagecache offset to
roundup(i_size_read(), mapping_max_folio_size_supported()) just to keep
file data and fsverity metadata completely separate.

> But yes, XFS should choose a larger alignment than 64K.

The roundup() formula above is what I'd choose for the pagecache offset
for xfs.  The ondisk offset of 1<<53 is ok with me.

--D

[1] https://lore.kernel.org/linux-fsdevel/20251014175214.GW6188@frogsfrogsfrogs/

