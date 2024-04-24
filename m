Return-Path: <linux-fsdevel+bounces-17676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 160CE8B1549
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 23:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15B88B227FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 21:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BB1156F5E;
	Wed, 24 Apr 2024 21:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzEpKcKA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C741156999;
	Wed, 24 Apr 2024 21:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713994998; cv=none; b=f06LYsOCzpSHT/fnBfeIcZALzgu+a/qCENlKnF/9200CHWnq873wof7fw6DmLLGhbCqrlIV1grYjedhLUPxwtf0uZNZoL1fdV1v9xQGKHtoi8lPu+zNOFOrTnzFZQUsq7kzj1Zj/sNbB0CHUhsXCO9XTcHS4gVSqG7+eD91XZ4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713994998; c=relaxed/simple;
	bh=n2EGh424KlWQpztRdqZHCVEuvuGAjHmXZDfAEc7Uk8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bk3IzDOflglDvh+hiyu4hdfoyDzsTr7qnoNcxQrfohc0nbHoDMo865/HEqmSsb1pbEtfHpYh2R3J61KQnr42k/rOP4agbC6LkhI+zVzcDCm4zTKZ1eVdYDaNF8UN247UsJyJUiYRqDrg3Mgca/ITeG+HdEXyri/ojdYlecOtPyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzEpKcKA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A60C9C113CD;
	Wed, 24 Apr 2024 21:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713994997;
	bh=n2EGh424KlWQpztRdqZHCVEuvuGAjHmXZDfAEc7Uk8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lzEpKcKAUrC9iz4Aea/vtIQFq9yjR1iu57BEmM/PCWkWtZJBLsj6wi3J6t0WE3v35
	 84N6LiJ2H8QFKFFuYaaZjVFmJ//oHuoRv7elmbsk0kIRZm1wKK9GrzWw9KgyimPpyj
	 GzJUH1mz6vHxnUHhwWnf8SKTvYGmNoLT6Sd4Tvs//JCgXSy3bh7ZU9lkWFJKJKVYsu
	 nYlZN9bzEpUumZSe8ALcNRHFdvPtzfLwRQEBgv3O4wWEFb10DETT/+PS6v4D/FJm0/
	 ZkQOpqLh/MogTCHO8FD1b69uFEtQrjT+LVU2tNhP72qvUXkzCRcUO89zpjAGJUaBth
	 aZDw8IXlJj+7g==
Date: Wed, 24 Apr 2024 14:43:17 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: aalbersh@redhat.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 10/13] fsverity: pass the zero-hash value to the
 implementation
Message-ID: <20240424214317.GR360919@frogsfrogsfrogs>
References: <171175867829.1987804.15934006844321506283.stgit@frogsfrogsfrogs>
 <171175868031.1987804.13138670908694064691.stgit@frogsfrogsfrogs>
 <20240405025750.GH1958@quark.localdomain>
 <20240424190246.GL360919@frogsfrogsfrogs>
 <20240424191950.GA749176@google.com>
 <20240424202348.GN360919@frogsfrogsfrogs>
 <20240424205941.GB749176@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424205941.GB749176@google.com>

On Wed, Apr 24, 2024 at 08:59:41PM +0000, Eric Biggers wrote:
> On Wed, Apr 24, 2024 at 01:23:48PM -0700, Darrick J. Wong wrote:
> > > > How about "the hash of an i_blocksize-sized buffer of zeroes" for all
> > > > three?
> > > 
> > > It's the Merkle tree block size, not the filesystem block size.  Or did you
> > > actually intend for this to use the filesystem block size?
> > 
> > I actually did intend for this to be the fs block size, not the merkle
> > tree block size.  It's the bottom level that I care about shrinking.
> > Let's say that data[0-B] are the data blocks:
> > 
> > root
> >  +-internal0
> >  |   +-leaf0
> >  |   |   +-data0
> >  |   |   +-data1
> >  |   |   `-data2
> >  |   `-leaf1
> >  |       +-data3
> >  |       +-data4
> >  |       `-data5
> >  `-internal1
> >      +-leaf2
> >      |   +-data6
> >      |   +-data7
> >      |   `-data8
> >      `-leaf3
> >          +-data9
> >          +-dataA
> >          `-dataB
> > 
> > (thanks to https://arthursonzogni.com/Diagon/#Tree )
> > 
> > If data[3-5] are completely zeroes (unwritten blocks, sparse holes,
> > etc.) then I want to skip writing leaf1 of the merkle tree to disk.
> > 
> > If it happens that the hashes of leaf[0-1] match hash(data3) then it's
> > frosting on top (as it were) that we can also skip internal0.  However,
> > the merkle tree has a high fanout factor (4096/32==128 in the common
> > case), so I care /much/ less about eliding those levels.
> > 
> > > In struct merkle_tree_params, the "block size" is always the Merkle tree block
> > > size, so the type of block size seems clear in that context.  My complaint was
> > > just that it used the term "data block" to mean a block that is not necessarily
> > > a file contents block (which is what "data block" means elsewhere).
> > 
> > Hm.  Given the confusion, would it help if I said that zero_digest
> > should only be used to elide leaf nodes of the merkle tree that hash the
> > contents of file content blocks?  Or is "the hash of an
> > i_blocksize-sized buffer of zeroes" sufficient?
> > 
> > What do you think of the commit message saying:
> > 
> > "Compute the hash of one filesystem block's worth of zeroes.  Any merkle
> > tree leaf block containing only this hash can be elided at write time,
> > and its contents synthesized at read time.
> > 
> > "Let's pretend that there's a file containing six data blocks and whose
> > merkle tree looks roughly like this:
> > 
> > root
> >  +--leaf0
> >  |   +--data0
> >  |   +--data1
> >  |   `--data2
> >  `--leaf1
> >      +--data3
> >      +--data4
> >      `--data5
> > 
> > "If data[0-2] are sparse holes, then leaf0 will contain a repeating
> > sequence of @zero_digest.  Therefore, leaf0 need not be written to disk
> > because its contents can be synthesized."
> 
> It sounds like you're assuming that the file data is always hashed in filesystem
> block sized units.

Ohh!  Yes, I was making that assumption, and now I double-checked
enable.c and see this:

	/* Hash each data block, also hashing the tree blocks as they fill up */
	for (offset = 0; offset < data_size; offset += params->block_size) {
		ssize_t bytes_read;
		loff_t pos = offset;

		buffers[-1].filled = min_t(u64, params->block_size,
					   data_size - offset);
		bytes_read = __kernel_read(filp, buffers[-1].data,
					   buffers[-1].filled, &pos);

So yes, you're right, @zero_digest is a the hash of a *merkle tree
block-sized* buffer of zeroes.  And if ->write_merkle_tree_block sees
that the block is a repeating sequence of @zero_digest, it can skip
writing that block to disk, no matter where that block happens to be in
the tree.

> block sized units.  That's not how it works.  The block size that's selected for
> fsverity (which is a power of 2 between 1024 and min(fs_block_size, PAGE_SIZE),
> inclusively) is used for both the data blocks and the Merkle tree blocks.
> 
> This is intentional, so that people can e.g. calculate the fsverity digest of a
> file using a 4K block size, and deploy the file to both filesystems that use a
> 4K filesystem block size and filesystems that use a 16K filesystem block size,
> and get the same fsverity file digest each time.

Aha, yes, that makes more sense.  I had wondered if people actually
copied merkle tree data between filesystems.

> I've considered offering the ability to configure the data block size separately
> from the Merkle tree block size, like what dm-verity does.  This hasn't seemed
> useful, though.  And in any case, it should not be tied to the FS block size.
> 
> A better way to think about things might be that the Merkle tree actually
> *includes* the data, as opposed to being separate from it.  In this respect,
> it's natural that the Merkle tree parameters including block size, hash
> algorithm, and salt apply both to blocks that contain file data and to blocks
> that contain hashes.  In general, all the fsverity code and documentation
> probably needs to be clearer about whether, when referring to the Merkle tree,
> it means just the hash blocks, or if it means the conceptual full tree that
> includes the file's data.

Yes, that clears things right up.  Thank you for correcting me. :)

--D

> - Eric
> 

