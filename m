Return-Path: <linux-fsdevel+bounces-27748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4E7963804
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 03:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29F441F23BEC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 01:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9FE24B28;
	Thu, 29 Aug 2024 01:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqplHE6j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A19D4C62
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 01:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724896671; cv=none; b=mSKcHNmnoV1Uck7UxhFzqDP4rm1aqyE9rb7dWa4/qlW3MZfiGyb5A7bXAFBDz1MMg+2qAROfIzW0mXebq0qioI+Wn7FKii3AINZzV85p65eFLx7SHMPi50jfkwYfVpCe76FCY9dJ6nY7rcybBEoAUcrfYWfI+2zLNifF8IeAXc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724896671; c=relaxed/simple;
	bh=Qvx+apGcbN4nZHydbVqaOgx1biaUDs1Xcd9GqmLYBTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rj2FncIrvzS1wjWoBxFHkigprv9rzCqBCHMkPwsQiKlfks5Ue+OgVyRAmuSQYE6/17o2ZIkIvv9bjg12FyoN45fltgrp0w3bDng+oUk5873GWss7MfA2r1XmbaPLRxc7LmRoA4DCvlK3q5Qxc/MuDiZ+ZA9cm/QmWureLQdRXrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqplHE6j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117BDC4CEC0;
	Thu, 29 Aug 2024 01:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724896671;
	bh=Qvx+apGcbN4nZHydbVqaOgx1biaUDs1Xcd9GqmLYBTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aqplHE6jvB8UjSgCTxE3yJrpk/rwOgjIBSOCJdFj28036dNGLVlwVHxiW2AVr0Ty1
	 COFcHnkdXLz80jWYlXNFZwhKUge2Kf3zyEGBZQWo3XTKcNb2TO46j34Vig1nNQm0hP
	 3PN6nKDBF11DsrTGbsCi82Ndts67xvqZf6sO16OpbWXbKvno6Q9Ju7iJrKZcEvJZsm
	 G65oKF/XdZWJTMMb618Cy8HyIePsKFK4WK3UsbQb3nhc/z4MaK9TKwDVepCVhqTfF9
	 u+Ev6gQxDFwK7AwgFeBOOPfZro6Djw9JR9CHcexh06g+5KrWaCdGctzAN30WfB5xu+
	 E1x3RRHHf+6tA==
Date: Wed, 28 Aug 2024 18:57:50 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
	"Darrick J. Wong" <darrick.wong@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>
Subject: Re: VFS caching of file extents
Message-ID: <20240829015750.GB6216@frogsfrogsfrogs>
References: <Zs97qHI-wA1a53Mm@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs97qHI-wA1a53Mm@casper.infradead.org>

On Wed, Aug 28, 2024 at 08:34:00PM +0100, Matthew Wilcox wrote:
> Today it is the responsibility of each filesystem to maintain the mapping
> from file logical addresses to disk blocks (*).  There are various ways
> to query that information, eg calling get_block() or using iomap.
> 
> What if we pull that information up into the VFS?  Filesystems obviously
> _control_ that information, so need to be able to invalidate entries.
> And we wouldn't want to store all extents in the VFS all the time, so
> would need to have a way to call into the filesystem to populate ranges
> of files.  We'd need to decide how to lock/protect that information
> -- a per-file lock?  A per-extent lock?  No locking, just a seqcount?
> We need a COW bit in the extent which tells the user that this extent
> is fine for reading through, but if there's a write to be done then the
> filesystem needs to be asked to create a new extent.
> 
> There are a few problems I think this can solve.  One is efficient
> implementation of NFS READPLUS.  Another is the callback from iomap

Wouldn't readplus (and maybe a sparse copy program) rather have
something that is "SEEK_DATA, fill the buffer with data from that file
position, and tell me what pos the data came from"?

> to the filesystem when doing buffered writeback.  A third is having a
> common implementation of FIEMAP.  I've heard rumours that FUSE would like
> something like this, and maybe there are other users that would crop up.

My 2-second hot take on this is that FUSE might benefit from an incore
mapping cache, but only because (rcu)locking the cache to query it is
likely faster than jumping out to userspace to ask the server process.
If the fuse server could invalidate parts of that cache, that might not
be too terrible.

> Anyway, this is as far as my thinking has got on this topic for now.
> Maybe there's a good idea here, maybe it's all a huge overengineered mess
> waiting to happen.  I'm sure other people know this area of filesystems
> better than I do.

I also suspect that devising a "simple" mapping tree for simple
filesystems will quickly devolve into a mess of figuring out their adhoc
locking and making that work.  Even enabling iomap one long-tail fs at a
time sounds like a 10 year project, and they already usually have some
weird notion of coordination of mapping.

"But then there's ext4" etc.

--D

> (*) For block device filesystems.  Obviously network filesystems and
> synthetic filesystems don't care and can stop reading now.  Umm, unless
> maybe they _want_ to use it, eg maybe there's a sharded thing going on and
> the fs wants to store information about each shard in the extent cache?
> 

