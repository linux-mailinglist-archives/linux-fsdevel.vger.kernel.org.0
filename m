Return-Path: <linux-fsdevel+bounces-17664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2688B131F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 21:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C211A1F282AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 19:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BBE20B0F;
	Wed, 24 Apr 2024 19:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="peNbFt+7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B116A1DDF4;
	Wed, 24 Apr 2024 19:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713985367; cv=none; b=m9WHYzeIt2NHhkgL0/jZjKmhztQ32IkAHh62oLjACoAz4wmTJO7aoQxKcoW0XyCos1ZQJ88y+DP9dBb2DEQlsN33/TbaiVU+moHfzqnruhI5aXf6mOH3GtAUgk8yFfrDzY2DOEbho6Bhve/+jDha8kZDnmUgnSPSKtCGQFjpsXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713985367; c=relaxed/simple;
	bh=bpScCuSOD6I7HPErlxMDhSP8i32n5CZR6oNHqgULV4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnEQbIltOQmelShHcZg6CA9VoSH6pL5q/C7iyenm1Z3cOfLBx01ZVZuZoVk0G3nxKhB67jSr5+fHwqxe3EMDOV7XWwa32/kFnc7mGWx18A3z9cOqR1N7Kvc4Bb1ak1sycGKyZMNmFhYiSWpqPXcKKrvnXlmj9jJ76t0gE11xbJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=peNbFt+7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44888C113CD;
	Wed, 24 Apr 2024 19:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713985367;
	bh=bpScCuSOD6I7HPErlxMDhSP8i32n5CZR6oNHqgULV4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=peNbFt+7duPR2YwHyaqmGswWQ/sFqMFQ7lBHcsNMH82tZ9V5/9/RFEFxbSXsIddT8
	 7KqmCFVqkvu0N1+wkmkGJhPPzjQ3ph0Aol1MfrWiS2rR1Wek7/kz46XBE7vo9To1Ws
	 0kWYdDLE6IuyMEvxvyh+hBe1Yby1qMqQ1HJH/tY8CG1f+u60KwLPDIH8unF8DuUDu4
	 35ndI8I5Raf7B5763swDabI40V48xolaJVeg6Iguy7q5qGN0j42pw0NX8zlH4fLs/G
	 skEbxccveU8+DGN6bl3NQYAFYSyGt58JlW47bRnF34DNdEhsOM7bj0YwXx8STQ5orM
	 2ngT9W0++am8g==
Date: Wed, 24 Apr 2024 12:02:46 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: aalbersh@redhat.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 10/13] fsverity: pass the zero-hash value to the
 implementation
Message-ID: <20240424190246.GL360919@frogsfrogsfrogs>
References: <171175867829.1987804.15934006844321506283.stgit@frogsfrogsfrogs>
 <171175868031.1987804.13138670908694064691.stgit@frogsfrogsfrogs>
 <20240405025750.GH1958@quark.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405025750.GH1958@quark.localdomain>

On Thu, Apr 04, 2024 at 10:57:50PM -0400, Eric Biggers wrote:
> On Fri, Mar 29, 2024 at 05:35:17PM -0700, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Compute the hash of a data block full of zeros, and then supply this to
> > the merkle tree read and write methods.  A subsequent xfs patch will use
> 
> This should say "hash of a block", not "hash of a data block".  What you
> actually care about is the hash of a Merkle tree block, not the hash of a data
> block.  Yet, there is no difference in how the hashes are calculated for the two
> types of blocks, so we should simply write "hash of a block".

I think I could go further with the precision of the description --

"Compute the hash of one filesystem block's worth of zeroes.  Any merkle
tree block containing only this hash can be elided at write time, and
its contents synthesized at read time."

I don't think this is going to happen very often above the leaf levels
of the merkle tree, but as written there's nothing to prevent the
elision of internal nodes.  Also note that the elision can happen for
internal nodes even when merkle tree blocksize != i_blocksize.

> > diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
> > index de8798f141d4a..195a92f203bba 100644
> > --- a/fs/verity/fsverity_private.h
> > +++ b/fs/verity/fsverity_private.h
> > @@ -47,6 +47,8 @@ struct merkle_tree_params {
> >  	u64 tree_size;			/* Merkle tree size in bytes */
> >  	unsigned long tree_pages;	/* Merkle tree size in pages */
> >  
> > +	u8 zero_digest[FS_VERITY_MAX_DIGEST_SIZE]; /* hash of zeroed data block */
> 
> Similarly, "block" instead of "data block".

How about "the hash of an i_blocksize-sized buffer of zeroes" for all
three?

--D

> > diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
> > index 5dacd30d65353..761a0b76eefec 100644
> > --- a/include/linux/fsverity.h
> > +++ b/include/linux/fsverity.h
> > @@ -66,6 +66,8 @@ struct fsverity_blockbuf {
> >   *		if the page at @block->offset isn't already cached.
> >   *		Implementations may ignore this argument; it's only a
> >   *		performance optimization.
> > + * @zero_digest: the hash for a data block of zeroes
> 
> Likewise.
> 
> >  /**
> > @@ -81,12 +85,16 @@ struct fsverity_readmerkle {
> >   * @level: level of the block; level 0 are the leaves
> >   * @num_levels: number of levels in the tree total
> >   * @log_blocksize: log2 of the size of the block
> > + * @zero_digest: the hash for a data block of zeroes
> > + * @digest_size: size of zero_digest
> 
> Likewise.
> 
> - Eric
> 

