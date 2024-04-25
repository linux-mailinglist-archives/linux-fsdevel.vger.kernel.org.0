Return-Path: <linux-fsdevel+bounces-17692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4418B1831
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 02:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD0281F248AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 00:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A8B5CA1;
	Thu, 25 Apr 2024 00:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGMxrTaW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D394B2599;
	Thu, 25 Apr 2024 00:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714006434; cv=none; b=lJ8OGe2fJ02S+EuwZWlu9k/dHUO9OWSTzD5WN1Qm9aho17l7KhXAMX9B2tKaVtp0FbEOgzEJMstwZZRVimwSRoigoGxtD5LX+3lVRMD1LNZM1UUFJsG3TcLFrAfNZb6z5CweOUrfi4CnRYeEiVerV/ywVPOgKSWvmLqt1YR5u/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714006434; c=relaxed/simple;
	bh=GpbhgEQfQGV3vs+GigJSsGOXuqZaGMpUKiPP7mmX8RI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUKtxBE0ghVbNYJpF4Uv181t/VGBSpYCfDylW5AUesZ0eWMtrW4y/zFAOvrMJHjvyLtuP98M0+bGT8rCub1nbd8HM3UmXjH5g0tN9j/1BY60uzXFogpfK2PEoAdqxU/IvaUfE9c2LWmzNp36DxD0JxlHzXqdFvE7NwcQEpVraxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGMxrTaW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C62C113CD;
	Thu, 25 Apr 2024 00:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714006434;
	bh=GpbhgEQfQGV3vs+GigJSsGOXuqZaGMpUKiPP7mmX8RI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BGMxrTaW8U4ApS76rNon95ANd4KzVwwRpSGxcaQ4vx8BEDYMesjV1oerel8b2haWA
	 KVzJXiiQD+6g5Jkyy7mUtB/ucn92qRQXgXHhu1AmRtXHiU5m47SXl/7X2I+z/uedFM
	 57RN3NQNozr65CJefbAtegW+prUDo5itHSg71m9gO3CK03X88N+3WXatRQ2UbY75mf
	 njPBI90xP1izzggnNUXKNgfhgSF24rX9D4rLVBO3bI9SaGOlpjtIRFpjiU/LqC5ZG9
	 6tjT3YusfsIGQLTiKUK7qVTT2eG1J0NRIn5tU36ZrZDqHPLtTO5SvFD2sC6EAZxHX0
	 wVb9FHZdsG7Sw==
Date: Wed, 24 Apr 2024 17:53:53 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: aalbersh@redhat.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 03/13] fsverity: support block-based Merkle tree caching
Message-ID: <20240425005353.GW360919@frogsfrogsfrogs>
References: <171175867829.1987804.15934006844321506283.stgit@frogsfrogsfrogs>
 <171175867913.1987804.4275409634176359386.stgit@frogsfrogsfrogs>
 <20240405023145.GB1958@quark.localdomain>
 <20240424212523.GO360919@frogsfrogsfrogs>
 <20240424220858.GC749176@google.com>
 <20240425002706.GS360919@frogsfrogsfrogs>
 <20240425004626.GD749176@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425004626.GD749176@google.com>

On Thu, Apr 25, 2024 at 12:46:26AM +0000, Eric Biggers wrote:
> On Wed, Apr 24, 2024 at 05:27:06PM -0700, Darrick J. Wong wrote:
> > > > > > +		err = fsverity_read_merkle_tree_block(inode, &vi->tree_params,
> > > > > > +				pos - offs_in_block, ra_bytes, &block);
> > > > > > +		if (err) {
> > > > > >  			fsverity_err(inode,
> > > > > > -				     "Error %d reading Merkle tree page %lu",
> > > > > > -				     err, index);
> > > > > > +				     "Error %d reading Merkle tree block %llu",
> > > > > > +				     err, pos);
> > > > > >  			break;
> > > > > 
> > > > > The error message should go into fsverity_read_merkle_tree_block() so that it
> > > > > does not need to be duplicated in its two callers.  This would, additionally,
> > > > > eliminate the need to introduce the 'err' variable in verify_data_block().
> > > > 
> > > > Do you want that to be a separate cleanup patch?
> > > 
> > > I think it makes sense to do it in this patch, since this patch introduces
> > > fsverity_read_merkle_tree_block().  This patch also adds the 'err' variable back
> > > to verify_data_block(), which may mislead people into thinking it's the actual
> > > error code that users see (this has happened before) --- that could be avoided.
> > 
> > Let's rename it "bad" in verify.c then.
> 
> Anything wrong with just 'if (fsverity_read_merkle_tree_block(...) != 0) {'?

Nope.

> > I'm assuming that you /do/ want the error code in fsverity_read_merkle_tree?
> 
> Yes, that's needed to log it.

Got it.

> > > It makes sense to cache the blocks by index regardless of whether you get passed
> > > the index directly.  So this is just a question of what the
> > > ->read_merkle_tree_block function prototype should be.
> > > 
> > > Currently the other fsverity_operations functions are just aligned with what the
> > > filesystems actually need: ->read_merkle_tree_page takes a page index, whereas
> > > ->write_merkle_tree_block takes a pos and size.  xfs_fsverity_read_merkle()
> > > needs pos, index, and size, and fsverity_read_merkle_tree_block() computes the
> > > index already.  So that's why I'd probably go with pos, index, and size instead
> > > of pos, log2_blocksize, and size.  There's no right answer though.
> > 
> > How about just index and size?  I think XFS will work just fine without
> > the byte position since it's using that as a key for the cache and the
> > ondisk xattrs anyway.  Even if we can't decide on which data structure
> > to use for caching. ;)
> 
> Currently XFS is using the byte position as the key for the ondisk xattrs.  That
> could be changed if you want it to be the block index instead, though.

/me slaps forehead

Yeah, I forgot that the ondisk format uses the byte position, it's only
the caching layer that cares about the block index.  And it doesn't even
have to do that, the per-AG rhashtable is working fine and doesn't
impose a 16-byte expansion on every xfs_inode everywhere.

> (I also notice you're using big endian, which isn't a great choice these days.
> But I assume it's for consistency with the rest of XFS.)

Yep.

--D

> - Eric
> 

