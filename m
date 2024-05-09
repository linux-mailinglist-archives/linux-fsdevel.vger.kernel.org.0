Return-Path: <linux-fsdevel+bounces-19212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6E98C146F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 20:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0039C1F222FB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 18:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308AE770F3;
	Thu,  9 May 2024 18:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gc4VbZpb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810722556F;
	Thu,  9 May 2024 18:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715277868; cv=none; b=Kh1c3Y/NLw4SKjZdSDzteMZ0iHN7lGC+lGlvWIgerHQ/hxUwK80ztSZhGAuufVkdLKvM2MYc1VPYJc1JlSea8hUtkcxX5jHRlNSs5/p4YWHoZEdLGa2/1bgrazE1bkzJzr+nMUGEWYnKFqC5f/8CrROU6+xK4pWOWagbZM/7gSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715277868; c=relaxed/simple;
	bh=SgVQHDSWbJsBloahemxqvlLpLQ1EHgHXMCSqkDCrp8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjYPYzZ1RY9mFV01bI3AxIkQ8JC0SOBM6YhAogCMKonGM/cE+HfKp4a30CsVDlrxIoyq+YPqkpCloS+62UwdA8jQiE/VKToprxsLW3Tb++OxzA1P9tLvDKs5oDF2FAd00ZGCFmam4L4z4RzqjZMddK1O2NaOHXef5MD2fY6F+/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gc4VbZpb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55157C116B1;
	Thu,  9 May 2024 18:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715277868;
	bh=SgVQHDSWbJsBloahemxqvlLpLQ1EHgHXMCSqkDCrp8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gc4VbZpbBcj7pMCX2nbLRMrVyvOIV04pH0wbg/MFbCVtZ1wIQBRxWCLLFLsee9xci
	 vDCRxiLQBZFXDpmGChYD9CP+VqwV8Q9HQxhQPhnEDZvw5zXYgiBFBnipIEhTnaT+Sl
	 +cv+BlUI2QAtw/hYiSfDXITJ2ZW2uu+tdH/fI8NqHEw4PIWgxGLrMFVBdK9ngOHUZR
	 cI/79iA1Rf6VXYFl7fHiyAqeymDZE/+I883+xzRC4c9/UaN6ReS5xWExSBuskLYAc/
	 ObXQt61W/tj/FXsV5sTGHSQySAK2yrthBeDp6zJjo8pdeDE+5up59nUZtRK9l3eJ7L
	 IPicwOgRdvAEA==
Date: Thu, 9 May 2024 11:04:27 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, aalbersh@redhat.com,
	linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 18/26] xfs: use merkle tree offset as attr hash
Message-ID: <20240509180427.GP360919@frogsfrogsfrogs>
References: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
 <171444680671.957659.2149857258719599236.stgit@frogsfrogsfrogs>
 <ZjHmzBRVc3HcyX7-@infradead.org>
 <ZjHt1pSy4FqGWAB6@infradead.org>
 <20240507212454.GX360919@frogsfrogsfrogs>
 <ZjtmVIST_ujh_ld6@infradead.org>
 <20240508202603.GC360919@frogsfrogsfrogs>
 <20240509174652.GA2127@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509174652.GA2127@sol.localdomain>

On Thu, May 09, 2024 at 10:46:52AM -0700, Eric Biggers wrote:
> On Wed, May 08, 2024 at 01:26:03PM -0700, Darrick J. Wong wrote:
> > > If we did that would be yet another indicator that they aren't attrs
> > > but something else.  But maybe I should stop banging that drum and
> > > agree that everything is a nail if all you got is a hammer.. :)
> > 
> > Hammer?  All I've got is a big block of cheese. :P
> > 
> > FWIW the fsverity code seems to cut us off at U32_MAX bytes of merkle
> > data so that's going to be the limit until they rev the ondisk format.
> > 
> 
> Where does that happen?

fsverity_init_merkle_tree_params has the following:

	/*
	 * With block_size != PAGE_SIZE, an in-memory bitmap will need to be
	 * allocated to track the "verified" status of hash blocks.  Don't allow
	 * this bitmap to get too large.  For now, limit it to 1 MiB, which
	 * limits the file size to about 4.4 TB with SHA-256 and 4K blocks.
	 *
	 * Together with the fact that the data, and thus also the Merkle tree,
	 * cannot have more than ULONG_MAX pages, this implies that hash block
	 * indices can always fit in an 'unsigned long'.  But to be safe, we
	 * explicitly check for that too.  Note, this is only for hash block
	 * indices; data block indices might not fit in an 'unsigned long'.
	 */
	if ((params->block_size != PAGE_SIZE && offset > 1 << 23) ||
	    offset > ULONG_MAX) {
		fsverity_err(inode, "Too many blocks in Merkle tree");
		err = -EFBIG;
		goto out_err;
	}

Hmm.  I didn't read this correctly -- the comment says ULONG_MAX pages,
not bytes.  I got confused by the units of @offset, because "u64"
doesn't really help me distinguish bytes, blocks, or pages. :(

OTOH looking at how @offset is computed, it seems to be the total number
of blocks in the merkle tree by the time we get here?

So I guess we actually /can/ create a very large (e.g. 2^33 blocks)
merkle tree on a 64-bit machine, which could then return -EFBIG on
32-bit?

My dumb btree geometry calculator seems to think that an 8EiB file with
a sha256 hash in 4k blocks would generate a 69,260,574,978MB merkle
tree, or roughly a 2^44 block merkle tree?

Ok I guess xfs fsverity really does need a substantial amount of attr
fork space then. :)

--D

> - Eric
> 

