Return-Path: <linux-fsdevel+bounces-17671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC0B8B147E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 22:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F8851C22BE6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 20:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D9813DB99;
	Wed, 24 Apr 2024 20:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="If7mRMhf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3CD1EB30;
	Wed, 24 Apr 2024 20:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713990229; cv=none; b=ps3QVjkfrxhOPt3QkEvr8J1H7yFxL29fGOJcdAZbiTwVtl9au2MmN1t0QWglOcm/TaeVkvBCGNN7FgASopD9WMhi1js81XaoUDkAAGq6OqTDLvJ86J4+Y+1fwtbb6SbPVDTl/Vr8at2Sjq8r/NfKU4gkhx/qCK2aun8BZh8QYK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713990229; c=relaxed/simple;
	bh=AY+kv4CITXE38z705BVDYbLbsQ+iL0lnoEffZj3nC+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7S8dBphGvvC3XhMpu5lSVEaXec+HygSyMm29UUqNHc82eIiUchA5Dx9JqeMTPEiDUtdn6tly9cymYGazYWnjxBC1Y0vd5COeolCvyZHfV3aeSKNS2DB991YlvyZ6j0N4Iv093oE6jcJFnqo7f+HGuN2tj3MPSJKCgpHSstPIDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=If7mRMhf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F20C113CD;
	Wed, 24 Apr 2024 20:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713990229;
	bh=AY+kv4CITXE38z705BVDYbLbsQ+iL0lnoEffZj3nC+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=If7mRMhf8neTeFjRouh9LZkqI9WH6v/XhJNaPdDsMxfU/g5eoekKHRXQQWfDsvvxM
	 6ri1cTbycJy0Zzpzm19quHI7zWxaREFpDGw7oj0LOvbACU5WNBUvviFrSjwTwkKGmq
	 +JM7H0qT92AFD2CPD3bOpvZY5z7RW3uo2nPhBHcjQaP6gRW4uq0ahi/hHaRV1Hx9ut
	 Rp8Bb59S8arcARdlkCLV1sL9O2o44f7KWfwxhjZNITg5xwrqDfh/d1sfFKr5JktTBh
	 Dz70oyqnT8wDbE8xehY7a8nOKP0tmcXzBV2fLKlPRKKRNIGEDvpsjzDrbiKh+qgW49
	 YsG1j08wycOAw==
Date: Wed, 24 Apr 2024 13:23:48 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: aalbersh@redhat.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 10/13] fsverity: pass the zero-hash value to the
 implementation
Message-ID: <20240424202348.GN360919@frogsfrogsfrogs>
References: <171175867829.1987804.15934006844321506283.stgit@frogsfrogsfrogs>
 <171175868031.1987804.13138670908694064691.stgit@frogsfrogsfrogs>
 <20240405025750.GH1958@quark.localdomain>
 <20240424190246.GL360919@frogsfrogsfrogs>
 <20240424191950.GA749176@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424191950.GA749176@google.com>

On Wed, Apr 24, 2024 at 07:19:50PM +0000, Eric Biggers wrote:
> On Wed, Apr 24, 2024 at 12:02:46PM -0700, Darrick J. Wong wrote:
> > On Thu, Apr 04, 2024 at 10:57:50PM -0400, Eric Biggers wrote:
> > > On Fri, Mar 29, 2024 at 05:35:17PM -0700, Darrick J. Wong wrote:
> > > > From: Darrick J. Wong <djwong@kernel.org>
> > > > 
> > > > Compute the hash of a data block full of zeros, and then supply this to
> > > > the merkle tree read and write methods.  A subsequent xfs patch will use
> > > 
> > > This should say "hash of a block", not "hash of a data block".  What you
> > > actually care about is the hash of a Merkle tree block, not the hash of a data
> > > block.  Yet, there is no difference in how the hashes are calculated for the two
> > > types of blocks, so we should simply write "hash of a block".
> > 
> > I think I could go further with the precision of the description --
> > 
> > "Compute the hash of one filesystem block's worth of zeroes.  Any merkle
> > tree block containing only this hash can be elided at write time, and
> > its contents synthesized at read time."
> > 
> > I don't think this is going to happen very often above the leaf levels
> > of the merkle tree, but as written there's nothing to prevent the
> > elision of internal nodes.  Also note that the elision can happen for
> > internal nodes even when merkle tree blocksize != i_blocksize.
> > 
> > > > diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
> > > > index de8798f141d4a..195a92f203bba 100644
> > > > --- a/fs/verity/fsverity_private.h
> > > > +++ b/fs/verity/fsverity_private.h
> > > > @@ -47,6 +47,8 @@ struct merkle_tree_params {
> > > >  	u64 tree_size;			/* Merkle tree size in bytes */
> > > >  	unsigned long tree_pages;	/* Merkle tree size in pages */
> > > >  
> > > > +	u8 zero_digest[FS_VERITY_MAX_DIGEST_SIZE]; /* hash of zeroed data block */
> > > 
> > > Similarly, "block" instead of "data block".
> > 
> > How about "the hash of an i_blocksize-sized buffer of zeroes" for all
> > three?
> 
> It's the Merkle tree block size, not the filesystem block size.  Or did you
> actually intend for this to use the filesystem block size?

I actually did intend for this to be the fs block size, not the merkle
tree block size.  It's the bottom level that I care about shrinking.
Let's say that data[0-B] are the data blocks:

root
 +-internal0
 |   +-leaf0
 |   |   +-data0
 |   |   +-data1
 |   |   `-data2
 |   `-leaf1
 |       +-data3
 |       +-data4
 |       `-data5
 `-internal1
     +-leaf2
     |   +-data6
     |   +-data7
     |   `-data8
     `-leaf3
         +-data9
         +-dataA
         `-dataB

(thanks to https://arthursonzogni.com/Diagon/#Tree )

If data[3-5] are completely zeroes (unwritten blocks, sparse holes,
etc.) then I want to skip writing leaf1 of the merkle tree to disk.

If it happens that the hashes of leaf[0-1] match hash(data3) then it's
frosting on top (as it were) that we can also skip internal0.  However,
the merkle tree has a high fanout factor (4096/32==128 in the common
case), so I care /much/ less about eliding those levels.

> In struct merkle_tree_params, the "block size" is always the Merkle tree block
> size, so the type of block size seems clear in that context.  My complaint was
> just that it used the term "data block" to mean a block that is not necessarily
> a file contents block (which is what "data block" means elsewhere).

Hm.  Given the confusion, would it help if I said that zero_digest
should only be used to elide leaf nodes of the merkle tree that hash the
contents of file content blocks?  Or is "the hash of an
i_blocksize-sized buffer of zeroes" sufficient?

What do you think of the commit message saying:

"Compute the hash of one filesystem block's worth of zeroes.  Any merkle
tree leaf block containing only this hash can be elided at write time,
and its contents synthesized at read time.

"Let's pretend that there's a file containing six data blocks and whose
merkle tree looks roughly like this:

root
 +--leaf0
 |   +--data0
 |   +--data1
 |   `--data2
 `--leaf1
     +--data3
     +--data4
     `--data5

"If data[0-2] are sparse holes, then leaf0 will contain a repeating
sequence of @zero_digest.  Therefore, leaf0 need not be written to disk
because its contents can be synthesized."

--D

> 
> - Eric
> 

