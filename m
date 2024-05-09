Return-Path: <linux-fsdevel+bounces-19214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FC28C14D1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 20:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A39B31C20BBF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 18:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18B27711E;
	Thu,  9 May 2024 18:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UX9XcSK2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5474CC2ED;
	Thu,  9 May 2024 18:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715279769; cv=none; b=sr2fkLT2momHjyRTo7LAz/VBuChGLgBs9xDMonbvaZDAoS+GQJBt7j9DvPU6Bexie1m9nEU9ZLXvRnAkpkhKbUzQFv/dyya0V4doS7XAwXXhRo1udqwpkSDAmS502TQcH/whc4ShTgmI8pBgK1Kyb4kPXVJzYiqxtrgnGTRnQzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715279769; c=relaxed/simple;
	bh=ReoQVfkgI5Yy1gn4gk0GN9bKjaXoguLs2ZNsOD5nsXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=de7cRh+Km7bcHeiPp2YEemGDOrufXPBUseNA4lmRon5m5aNN0WaPlFPcfHW3B0+yAgnU2yRZvLk59CX+v6TZwLLN4Uv0ZcL3f4IZA33PzIan/brxa89wzc1Ynujy9buk6CistIAKdLg32g8J2ghhqg+YNWjvZ5TAAVPx5hpjaCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UX9XcSK2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADCDAC116B1;
	Thu,  9 May 2024 18:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715279768;
	bh=ReoQVfkgI5Yy1gn4gk0GN9bKjaXoguLs2ZNsOD5nsXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UX9XcSK24RxO9U4z24YxGrk5evbxEvbYaE3xItk9AvWfBQXB63jb3XTZeFgEmUtUI
	 jp2fT1V2puyICdTqCkdc3cio7+geTpvkHi6C/C+jEAQteYoj9lqmr3+oy/V4Z35Cxi
	 uHgjPE90NRZUaELMv4Sao2HmdqUVwOVF54av8DngvElVLY6exjd0bxrMPZarLbEi5u
	 fRUxaVN7/QSNkrpLqV+ay54YrlslMJA+fjcHJ8umPwPctv7nvM5NYVaYYuYy+kyLLr
	 FH7rFlP4eiQBccep3EzXsJ28+d4YRtIzBBbTwqqCaXI5wNmEX67toYd8DVwMb92eDB
	 Rk5q5qreYRlaQ==
Date: Thu, 9 May 2024 18:36:07 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, aalbersh@redhat.com,
	linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 18/26] xfs: use merkle tree offset as attr hash
Message-ID: <20240509183607.GA1035117@google.com>
References: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
 <171444680671.957659.2149857258719599236.stgit@frogsfrogsfrogs>
 <ZjHmzBRVc3HcyX7-@infradead.org>
 <ZjHt1pSy4FqGWAB6@infradead.org>
 <20240507212454.GX360919@frogsfrogsfrogs>
 <ZjtmVIST_ujh_ld6@infradead.org>
 <20240508202603.GC360919@frogsfrogsfrogs>
 <20240509174652.GA2127@sol.localdomain>
 <20240509180427.GP360919@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509180427.GP360919@frogsfrogsfrogs>

On Thu, May 09, 2024 at 11:04:27AM -0700, Darrick J. Wong wrote:
> On Thu, May 09, 2024 at 10:46:52AM -0700, Eric Biggers wrote:
> > On Wed, May 08, 2024 at 01:26:03PM -0700, Darrick J. Wong wrote:
> > > > If we did that would be yet another indicator that they aren't attrs
> > > > but something else.  But maybe I should stop banging that drum and
> > > > agree that everything is a nail if all you got is a hammer.. :)
> > > 
> > > Hammer?  All I've got is a big block of cheese. :P
> > > 
> > > FWIW the fsverity code seems to cut us off at U32_MAX bytes of merkle
> > > data so that's going to be the limit until they rev the ondisk format.
> > > 
> > 
> > Where does that happen?
> 
> fsverity_init_merkle_tree_params has the following:
> 
> 	/*
> 	 * With block_size != PAGE_SIZE, an in-memory bitmap will need to be
> 	 * allocated to track the "verified" status of hash blocks.  Don't allow
> 	 * this bitmap to get too large.  For now, limit it to 1 MiB, which
> 	 * limits the file size to about 4.4 TB with SHA-256 and 4K blocks.
> 	 *
> 	 * Together with the fact that the data, and thus also the Merkle tree,
> 	 * cannot have more than ULONG_MAX pages, this implies that hash block
> 	 * indices can always fit in an 'unsigned long'.  But to be safe, we
> 	 * explicitly check for that too.  Note, this is only for hash block
> 	 * indices; data block indices might not fit in an 'unsigned long'.
> 	 */
> 	if ((params->block_size != PAGE_SIZE && offset > 1 << 23) ||
> 	    offset > ULONG_MAX) {
> 		fsverity_err(inode, "Too many blocks in Merkle tree");
> 		err = -EFBIG;
> 		goto out_err;
> 	}
> 
> Hmm.  I didn't read this correctly -- the comment says ULONG_MAX pages,
> not bytes.  I got confused by the units of @offset, because "u64"
> doesn't really help me distinguish bytes, blocks, or pages. :(
> 
> OTOH looking at how @offset is computed, it seems to be the total number
> of blocks in the merkle tree by the time we get here?

Yes, it's blocks here.

> So I guess we actually /can/ create a very large (e.g. 2^33 blocks)
> merkle tree on a 64-bit machine, which could then return -EFBIG on
> 32-bit?

Sure, but the page cache is indexed with unsigned long, and there are more data
pages than Merkle tree blocks, so that becomes a problem first.  That's why
fs/verity/ uses unsigned long for Merkle tree block indices.

> My dumb btree geometry calculator seems to think that an 8EiB file with
> a sha256 hash in 4k blocks would generate a 69,260,574,978MB merkle
> tree, or roughly a 2^44 block merkle tree?
> 
> Ok I guess xfs fsverity really does need a substantial amount of attr
> fork space then. :)

- Eric

