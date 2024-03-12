Return-Path: <linux-fsdevel+bounces-14178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 560B7878D1F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 03:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E0CD282BFD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 02:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC81B665;
	Tue, 12 Mar 2024 02:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wtlmvvkf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3590B642;
	Tue, 12 Mar 2024 02:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710211509; cv=none; b=F0fAaEmxlyzRqMVMxKOKUg6JE4E1qBRdZtVc05uyu55qIBqLGcK4rTeb89i3ZJ0nj9VbfFUB9GJQeRy9ojGuFeT4J36mLCBR46+hrD+smNU8NmZ1M4chQWLlsXSqGHNHqeTaN0HVIOeC66Dgs4sb8mq9W+DDBLtOFzobLFQ4mFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710211509; c=relaxed/simple;
	bh=IWjRq3Zt9+IbyXWPDrl7NyImTffOcT2SNVcI4dFZ4sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjIWBdNn6KvRJYpwQDrssCvL3dblWD2tThYrBnKC43Z0bNdlXyCQm5yAPJYz+1SrjiNA8Gn6A37oFLSbuAY27MI2zN8HR57og1EbFoIzPw0gG4kL3Z8yPyQFaBDGXmfhuBDkE77ikWHn37tLLLCm7MSg8m3oFR02iwipyTnkYik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wtlmvvkf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524B5C43394;
	Tue, 12 Mar 2024 02:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710211508;
	bh=IWjRq3Zt9+IbyXWPDrl7NyImTffOcT2SNVcI4dFZ4sg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WtlmvvkfXzfiLIqp6BhVR+GJHWnLHuXrlz3lD/nqKo7++pBVTSoBj7+wZjLAGUfFU
	 WYHiuSpduYPYrkiofxZXtZTUh1Gyfh0TojDDSoisxyQzC1J8FiE0zSLw0w175y3pJZ
	 TRRhIJ3SN8gu2RqSolvFUbt7KegUOpobXlKeQd2pPN/vKyZqG2iPdTG+FrQifjkozR
	 yn34T4BwlrMjuDYqDA9rtKPj34QZ0NKKT5pT0NoRYHHl4nj5lRwHT2J2X3z9dKbvcY
	 nwGLcSnIL/5xbTNX8Nad/WwiZYUBT7atS7aMoKo1BDKnJvJBsAa0tF15VYpCoC7siF
	 Qhi7uJ46Eo3Sg==
Date: Mon, 11 Mar 2024 19:45:07 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com, ebiggers@kernel.org
Subject: Re: [PATCH v5 11/24] xfs: add XBF_VERITY_SEEN xfs_buf flag
Message-ID: <20240312024507.GY1927156@frogsfrogsfrogs>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-13-aalbersh@redhat.com>
 <20240307224654.GB1927156@frogsfrogsfrogs>
 <ZepxHObVLb3JLCl/@dread.disaster.area>
 <20240308033138.GN6184@frogsfrogsfrogs>
 <20240309162828.GQ1927156@frogsfrogsfrogs>
 <Ze5PsMopkWqZZ1NX@dread.disaster.area>
 <20240311152505.GR1927156@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311152505.GR1927156@frogsfrogsfrogs>

On Mon, Mar 11, 2024 at 08:25:05AM -0700, Darrick J. Wong wrote:

<snip>

> <nod> The latest version of this tries to avoid letting reclaim take the
> top of the tree.  Logically this makes sense to me to reduce read verify
> latency, but I was hoping Eric or Andrey or someone with more
> familiarity with fsverity would chime in on whether or not that made
> sense.
> 
> > > > Also -- the fsverity block interfaces pass in a "u64 pos" argument.  Was
> > > > that done because merkle trees may some day have more than 2^32 blocks
> > > > in them?  That won't play well with things like xarrays on 32-bit
> > > > machines.
> > > > 
> > > > (Granted we've been talking about deprecating XFS on 32-bit for a while
> > > > now but we're not the whole world)
> > > > 
> > > > > i.e.
> > > > > 
> > > > > 	p = xa_load(key);
> > > > > 	if (p)
> > > > > 		return p;
> > > > > 
> > > > > 	xfs_attr_get(key);
> > > > > 	if (!args->value)
> > > > > 		/* error */
> > > > > 
> > > > > 	/*
> > > > > 	 * store the current value, freeing any old value that we
> > > > > 	 * replaced at this key. Don't care about failure to store,
> > > > > 	 * this is optimistic caching.
> > > > > 	 */
> > > > > 	p = xa_store(key, args->value, GFP_NOFS);
> > > > > 	if (p)
> > > > > 		kvfree(p);
> > > > > 	return args->value;
> > > > 
> > > > Attractive.  Will have to take a look at that tomorrow.
> > > 
> > > Done.  I think.  Not sure that I actually got all the interactions
> > > between the shrinker and the xarray correct though.  KASAN and lockdep
> > > don't have any complaints running fstests, so that's a start.
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=fsverity-cleanups-6.9_2024-03-09
> > 
> > My initial impression is "over-engineered".
> 
> Overly focused on unfamiliar data structures -- I've never built
> anything with an xarray before.
> 
> > I personally would have just allocated the xattr value buffer with a
> > little extra size and added all the external cache information (a
> > reference counter is all we need as these are fixed sized blocks) to
> > the tail of the blob we actually pass to fsverity.
> 
> Oho, that's a good idea.  I didn't like the separate allocation anyway.
> Friday was mostly chatting with willy and trying to make sure I got the
> xarray access patterns correct.
> 
> >                                                    If we tag the
> > inode in the radix tree as having verity blobs that can be freed, we
> > can then just extend the existing fs sueprblock shrinker callout to
> > also walk all the verity inodes with cached data to try to reclaim
> > some objects...
> 
> This too is a wonderful suggestion -- use the third radix tree tag to
> mark inodes with extra incore caches that can be reclaimed, then teach
> xfs_reclaim_inodes_{nr,count} to scan them.  Allocating a per-inode
> shrinker was likely to cause problems with flooding debugfs with too
> many knobs anyway.
> 
> > But, if a generic blob cache is what it takes to move this forwards,
> > so be it.
> 
> Not necessarily. ;)

And here's today's branch, with xfs_blobcache.[ch] removed and a few
more cleanups:
https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/tag/?h=fsverity-cleanups-6.9_2024-03-11

--D

> 
> --D
> 
> > -Dave.
> > -- 
> > Dave Chinner
> > david@fromorbit.com
> > 
> 

