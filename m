Return-Path: <linux-fsdevel+bounces-17689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD5E8B1824
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 02:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 719401F2598E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 00:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FEF17F8;
	Thu, 25 Apr 2024 00:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSjbXsEa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD69FA21;
	Thu, 25 Apr 2024 00:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714005988; cv=none; b=oCOeLbcf6C82rFl8GUgo/WFrFaRrVmON353XcN7btMNLrd8E4dtxPOepu5AmpIgZCC9cKeKjV98GioKZ7do+Xi4our7QMwz3BMb1PKnMHW2oPQwP1sfM40Jy2A3/nPTOw0vGWADyLRgDPykHst9C1pH9Kkb5EHm4wpfEkrlaqIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714005988; c=relaxed/simple;
	bh=TAbIKjW67B8fHeTQjQdb/Iq1xywUhM6k0382kEtQXbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LuMijWxBZc7kOYMSDQd7MFn3D2nUJztidq8TYm1hoCc4XSFnvs1Dux1v48XgSlcPWJB+4Xeqf2TBEL/ln+IJ4FbA6aZcFr4JWcdOL/ei5fudtJFTuQ/yjaLJ1Dpkxne9BAt5XLwiXEbY5iF9oXBhQg0Zs2N/xFTKXYd+B0I7kOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSjbXsEa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692B5C113CD;
	Thu, 25 Apr 2024 00:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714005988;
	bh=TAbIKjW67B8fHeTQjQdb/Iq1xywUhM6k0382kEtQXbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RSjbXsEalIcVmYP1zEO4zz6P1f8twL2VIC/1xSgFd9/s1mvZzQtFYmkz4BMTnwWp6
	 JiP6WGUyzqBLTTaTA9N/Fxn60pfpx9tVU9mlzCCrao/g/6S8YtgQjFOUXty01T3CT7
	 jo+MAOtLLsAK9ZgfLjn3M9lhTok5bOzhgtEaiytLj5z9TI5iErf/5tBY4xotaXW2FC
	 g2WsMz9yA0Ijvw/ztVqSCv7xWmbTUeaawXvFlnQ8vSzsngp5ta/jpfFOmQwDYsXiAi
	 KkDAUlwAXZWj15QDvYuZYjcxgh1s+iTL5vnPh9oKxgDGD1CNfVgfRfdP6/tv4VAp/3
	 5Mg1dSAnzL30w==
Date: Thu, 25 Apr 2024 00:46:26 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: aalbersh@redhat.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 03/13] fsverity: support block-based Merkle tree caching
Message-ID: <20240425004626.GD749176@google.com>
References: <171175867829.1987804.15934006844321506283.stgit@frogsfrogsfrogs>
 <171175867913.1987804.4275409634176359386.stgit@frogsfrogsfrogs>
 <20240405023145.GB1958@quark.localdomain>
 <20240424212523.GO360919@frogsfrogsfrogs>
 <20240424220858.GC749176@google.com>
 <20240425002706.GS360919@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425002706.GS360919@frogsfrogsfrogs>

On Wed, Apr 24, 2024 at 05:27:06PM -0700, Darrick J. Wong wrote:
> > > > > +		err = fsverity_read_merkle_tree_block(inode, &vi->tree_params,
> > > > > +				pos - offs_in_block, ra_bytes, &block);
> > > > > +		if (err) {
> > > > >  			fsverity_err(inode,
> > > > > -				     "Error %d reading Merkle tree page %lu",
> > > > > -				     err, index);
> > > > > +				     "Error %d reading Merkle tree block %llu",
> > > > > +				     err, pos);
> > > > >  			break;
> > > > 
> > > > The error message should go into fsverity_read_merkle_tree_block() so that it
> > > > does not need to be duplicated in its two callers.  This would, additionally,
> > > > eliminate the need to introduce the 'err' variable in verify_data_block().
> > > 
> > > Do you want that to be a separate cleanup patch?
> > 
> > I think it makes sense to do it in this patch, since this patch introduces
> > fsverity_read_merkle_tree_block().  This patch also adds the 'err' variable back
> > to verify_data_block(), which may mislead people into thinking it's the actual
> > error code that users see (this has happened before) --- that could be avoided.
> 
> Let's rename it "bad" in verify.c then.

Anything wrong with just 'if (fsverity_read_merkle_tree_block(...) != 0) {'?

> I'm assuming that you /do/ want the error code in fsverity_read_merkle_tree?

Yes, that's needed to log it.

> > It makes sense to cache the blocks by index regardless of whether you get passed
> > the index directly.  So this is just a question of what the
> > ->read_merkle_tree_block function prototype should be.
> > 
> > Currently the other fsverity_operations functions are just aligned with what the
> > filesystems actually need: ->read_merkle_tree_page takes a page index, whereas
> > ->write_merkle_tree_block takes a pos and size.  xfs_fsverity_read_merkle()
> > needs pos, index, and size, and fsverity_read_merkle_tree_block() computes the
> > index already.  So that's why I'd probably go with pos, index, and size instead
> > of pos, log2_blocksize, and size.  There's no right answer though.
> 
> How about just index and size?  I think XFS will work just fine without
> the byte position since it's using that as a key for the cache and the
> ondisk xattrs anyway.  Even if we can't decide on which data structure
> to use for caching. ;)

Currently XFS is using the byte position as the key for the ondisk xattrs.  That
could be changed if you want it to be the block index instead, though.

(I also notice you're using big endian, which isn't a great choice these days.
But I assume it's for consistency with the rest of XFS.)

- Eric

