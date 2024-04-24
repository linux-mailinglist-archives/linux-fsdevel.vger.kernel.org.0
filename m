Return-Path: <linux-fsdevel+bounces-17667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3818B1375
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 21:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A2BA284A44
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 19:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D066A84FB3;
	Wed, 24 Apr 2024 19:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhkDwy2E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383B384D04;
	Wed, 24 Apr 2024 19:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713986392; cv=none; b=mhy9aA81Ijfjcxj9Juk8edM3iu79nvBn9oShGdjWyV+6sCixJ1sNkMbwEfcjZhjwpLxf/kyAkMk93P2jXXp/nKCv9C4iHU46/e+iOIG+uI2DTWdkXItMUFnf2JNf1oQ9dsu4G+39MY/a6yz0PPZSOzK0T2AJ95SO6/P3RXCXIFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713986392; c=relaxed/simple;
	bh=SG4Lo4rIx0jK9AyJvfk3b3JplxqCs2y9vsJcG+z8OAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQPK7B40TagwJl4Qre7VJsMc5pYbB46TvMy1pWvb3aqsi3dKy96BGUUPFuuGdBQzb7ETrCAZfGspa4le8LvrimFAhUX840ZyvdchwJ2Emzl4ASyxXG8lKoF8juz9asX79/P84K7kxP1iOdHZtohyLR/F9sUlpXIbuFmzLfec1VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhkDwy2E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9718FC113CD;
	Wed, 24 Apr 2024 19:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713986391;
	bh=SG4Lo4rIx0jK9AyJvfk3b3JplxqCs2y9vsJcG+z8OAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IhkDwy2E5Sp/2EIyCvai21RmJiQghHwApl+U1e7VVx/1T22gEcEhBZ2KtPBPmpXn4
	 S4vJSNcC9bGcPBxQHXDFqgNL2ro9FK7Vgm3QIt1MCjfAw3EbsDR60zaycTJ+o5kmyW
	 4tpgrqZnEgLJLPkPhYfE///Khp/IAY39qTFYtafe+YVkB0L8yKqUnnBHOtNidpic9/
	 1triYxSXquy3ogOlLrTyURNlhYYLf0fp3GinUHf/XV1yiwFCd79IgX8CxiTgiQHfjN
	 027/d4lbTlK6owYBlxQSnPUTkZqVbZ2e5XHKYGMmnOxck+uq8GkAphut0dHKRK4QP9
	 mDLiRl4YPmtGQ==
Date: Wed, 24 Apr 2024 19:19:50 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: aalbersh@redhat.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 10/13] fsverity: pass the zero-hash value to the
 implementation
Message-ID: <20240424191950.GA749176@google.com>
References: <171175867829.1987804.15934006844321506283.stgit@frogsfrogsfrogs>
 <171175868031.1987804.13138670908694064691.stgit@frogsfrogsfrogs>
 <20240405025750.GH1958@quark.localdomain>
 <20240424190246.GL360919@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424190246.GL360919@frogsfrogsfrogs>

On Wed, Apr 24, 2024 at 12:02:46PM -0700, Darrick J. Wong wrote:
> On Thu, Apr 04, 2024 at 10:57:50PM -0400, Eric Biggers wrote:
> > On Fri, Mar 29, 2024 at 05:35:17PM -0700, Darrick J. Wong wrote:
> > > From: Darrick J. Wong <djwong@kernel.org>
> > > 
> > > Compute the hash of a data block full of zeros, and then supply this to
> > > the merkle tree read and write methods.  A subsequent xfs patch will use
> > 
> > This should say "hash of a block", not "hash of a data block".  What you
> > actually care about is the hash of a Merkle tree block, not the hash of a data
> > block.  Yet, there is no difference in how the hashes are calculated for the two
> > types of blocks, so we should simply write "hash of a block".
> 
> I think I could go further with the precision of the description --
> 
> "Compute the hash of one filesystem block's worth of zeroes.  Any merkle
> tree block containing only this hash can be elided at write time, and
> its contents synthesized at read time."
> 
> I don't think this is going to happen very often above the leaf levels
> of the merkle tree, but as written there's nothing to prevent the
> elision of internal nodes.  Also note that the elision can happen for
> internal nodes even when merkle tree blocksize != i_blocksize.
> 
> > > diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
> > > index de8798f141d4a..195a92f203bba 100644
> > > --- a/fs/verity/fsverity_private.h
> > > +++ b/fs/verity/fsverity_private.h
> > > @@ -47,6 +47,8 @@ struct merkle_tree_params {
> > >  	u64 tree_size;			/* Merkle tree size in bytes */
> > >  	unsigned long tree_pages;	/* Merkle tree size in pages */
> > >  
> > > +	u8 zero_digest[FS_VERITY_MAX_DIGEST_SIZE]; /* hash of zeroed data block */
> > 
> > Similarly, "block" instead of "data block".
> 
> How about "the hash of an i_blocksize-sized buffer of zeroes" for all
> three?

It's the Merkle tree block size, not the filesystem block size.  Or did you
actually intend for this to use the filesystem block size?

In struct merkle_tree_params, the "block size" is always the Merkle tree block
size, so the type of block size seems clear in that context.  My complaint was
just that it used the term "data block" to mean a block that is not necessarily
a file contents block (which is what "data block" means elsewhere).

- Eric

