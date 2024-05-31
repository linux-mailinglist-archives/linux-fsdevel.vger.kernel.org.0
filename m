Return-Path: <linux-fsdevel+bounces-20676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CACD8D6BF6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 23:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCAE9B2709B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 21:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBE17F7EF;
	Fri, 31 May 2024 21:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFsNzDFj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DE2AD59;
	Fri, 31 May 2024 21:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717192350; cv=none; b=hcZS0fRgPML3MVAagauCqFtn+kY0gj2U5PYgloZV7x0lmTq1e8Jr8OEAGAebBKbDGAfk22x+DrmRdqrshpvbmDzrprnylNEYiwXJi/Av6mcmwuqKhq0NSfVO8MPLvDO99RhY3gg4FO6w3C69gB11oQdLqQNoyI9R84kKaljaO5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717192350; c=relaxed/simple;
	bh=QGFa1su3G1GQlhYw2Bl1frsvO5x1Io9tnw4wIHm8v4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lioW62HB4g77DgjjtH0riGZruOhEvcjM3JHX/H6V/cn35Nslxkd0mlfnP2xdMxoD62SeSdk2pkyb2pRb4lpYUxiHhaGsBu4JFipwvEQXqQSmbzHworkNBDi7cmNLMT65WCPdR/XUCLVpz3fJewCt7zOUfbhGxxnSJu9JKfv7JD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFsNzDFj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6393FC116B1;
	Fri, 31 May 2024 21:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717192349;
	bh=QGFa1su3G1GQlhYw2Bl1frsvO5x1Io9tnw4wIHm8v4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OFsNzDFj0NCEqWTvkytvVOXDu/bYefFjFt8aMHe03+SKhpJHrPkbNeDIYLzE3xKVb
	 2Hr2VSqNPxXX9OkxQqS//w29agcrCI/Egzn6jVpAaydrIU8xXcpkYsei2TJVf+ZROQ
	 1tfG9C6CYTa6YuJk8iHt0e7VFk+OF2VCAge13fKs8iCD6shhzReiCkWiKl1UUR82JJ
	 h4CB2mPV1QZD/tzn0EEmOogtl9Ihn6hqXKlSlf1Jz+cUCdyjynnqYP6vl+e+qlPY85
	 tZ1TEqaSCmxtYZmzCLRa30jDi0Lij9bJklY101KmpQjj+rdiMmgjzc4qbDQOzlV7/s
	 Sl4FpLtM4FvXA==
Date: Fri, 31 May 2024 21:52:28 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, Andrey Albershteyn <aalbersh@redhat.com>
Subject: Re: [PATCH] fsverity: support block-based Merkle tree caching
Message-ID: <20240531215228.GD2838215@google.com>
References: <20240515015320.323443-1-ebiggers@kernel.org>
 <20240531213212.GV52987@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531213212.GV52987@frogsfrogsfrogs>

On Fri, May 31, 2024 at 02:32:12PM -0700, Darrick J. Wong wrote:
> On Tue, May 14, 2024 at 06:53:20PM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Currently fs/verity/ assumes that filesystems cache Merkle tree blocks
> > in the page cache.  Specifically, it requires that filesystems provide a
> > ->read_merkle_tree_page() method which returns a page of blocks.  It
> > also stores the "is the block verified" flag in PG_checked, or (if there
> > are multiple blocks per page) in a bitmap, with PG_checked used to
> > detect cache evictions instead.  This solution is specific to the page
> > cache, as a different cache would store the flag in a different way.
> > 
> > To allow XFS to use a custom Merkle tree block cache, this patch
> > refactors the Merkle tree caching interface to be based around the
> > concept of reading and dropping blocks (not pages), where the storage of
> > the "is the block verified" flag is up to the implementation.
> > 
> > The existing pagecache based solution, used by ext4, f2fs, and btrfs, is
> > reimplemented using this interface.
> > 
> > Co-developed-by: Andrey Albershteyn <aalbersh@redhat.com>
> > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > Co-developed-by: Darrick J. Wong <djwong@kernel.org>
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > ---
> > 
> > This reworks the block-based caching patch to clean up many different
> > things, including putting the pagecache based caching behind the same
> > interface as suggested by Christoph.
> 
> I gather this means that you ported btrfs/f2fs/ext4 to use the read/drop
> merkle_tree_block interfaces?

Yes, this patch does that.

> >                                       This applies to mainline commit
> > a5131c3fdf26.  It corresponds to the following patches in Darrick's v5.6
> > patchset:
> > 
> >     fsverity: convert verification to use byte instead of page offsets
> >     fsverity: support block-based Merkle tree caching
> >     fsverity: pass the merkle tree block level to fsverity_read_merkle_tree_block
> >     fsverity: pass the zero-hash value to the implementation
> > 
> > (I don't really understand the split between the first two, as I see
> > them as being logically part of the same change.  The new parameters
> > would make sense to split out though.)
> 
> I separated the first two to reduce the mental burden of rebasing these
> patches against new -rc1 kernels.  It's a lot less effort if one only
> has to concentrate on one aspect at a time.  You might have heard that
> it's difficult to add an xfs feature without it taking multiple kernel
> cycles.
> 
> (That said, 6.10 wasn't bad at all.)
> 

I'd be glad to start applying some of the fsverity patches for 6.11.  This one
seems good to me (if it's revised to split the new parameters back into separate
patches again), but it only really makes sense if XFS is going to use it, and
that seems uncertain now.  Either way though, we could go ahead with the
workqueue change, FS_XFLAG_VERITY, and tracepoints.

- Eric

