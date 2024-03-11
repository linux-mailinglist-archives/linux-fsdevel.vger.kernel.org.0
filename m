Return-Path: <linux-fsdevel+bounces-14136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3858783BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 16:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43ABE286021
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 15:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5872654662;
	Mon, 11 Mar 2024 15:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8Ibd6nX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87383537E3;
	Mon, 11 Mar 2024 15:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710170706; cv=none; b=QbiI4KDmO5zj0tSHKAyWGQ2pWN5uWqFXR3IAbl/98tZTX7L094xaUDfgMWfzeyjjoOr6g25Dj3I1K9+T2VPB+Ir8VIf2YmiPi/8mznIntPryVXeCzZA//siTF7abrdl6MO8BPB9SrKw/fvgMlOuZbmL00601+c97qBamXKx79So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710170706; c=relaxed/simple;
	bh=CGzWqsJ7frSAKYWFgtAomBph2AhOzcXXbKmK9G1kT6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACF1V+b+K6R15HTjuslhnWkoqP9pRT7qlw+Mc419kIjJ0hohtEJBqFU4Yu2BchmRmdRf18qcZ43rk0hjdOAjoqtLzzXEd0W1A5puYhjMPfLUDpXC9NtfSKEg092jUb1EEs01ADsU5ehTn+WCdHNKgoizyIA3mT9Bpmc2Yz7QzIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8Ibd6nX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6ABC433F1;
	Mon, 11 Mar 2024 15:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710170706;
	bh=CGzWqsJ7frSAKYWFgtAomBph2AhOzcXXbKmK9G1kT6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P8Ibd6nXnzzaiZI3dnQ/A65crvw2Tfw7i2m6lAzO/i7pXlckp6/7kL2+EHJcfICtb
	 +1aARpi9BnUfU3W4WoV6y2R9M+lUbg47IVBqrB7Mx36rXH97FY9WHseG6/aC9lL9kf
	 2USgF8tJNld5dHvZMwhxoHwBTya8Hi+kn0aoqG8eveiiryUi+XWJqQX8a0acVobZTJ
	 4coxpV+cGNvPQQV01TyouU9a1tW/scUN/daSkHkRzzxtvIGjU2ff4ES8QKwgO5o4yo
	 hdKMv5S7heVBh838511dFLCAiFrTwStvPaepsYb/o3Jx1heuyvyj5NLJ3LkTFRk2VG
	 6Ng00XFnPvBaA==
Date: Mon, 11 Mar 2024 08:25:05 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com, ebiggers@kernel.org
Subject: Re: [PATCH v5 11/24] xfs: add XBF_VERITY_SEEN xfs_buf flag
Message-ID: <20240311152505.GR1927156@frogsfrogsfrogs>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-13-aalbersh@redhat.com>
 <20240307224654.GB1927156@frogsfrogsfrogs>
 <ZepxHObVLb3JLCl/@dread.disaster.area>
 <20240308033138.GN6184@frogsfrogsfrogs>
 <20240309162828.GQ1927156@frogsfrogsfrogs>
 <Ze5PsMopkWqZZ1NX@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ze5PsMopkWqZZ1NX@dread.disaster.area>

On Mon, Mar 11, 2024 at 11:26:24AM +1100, Dave Chinner wrote:
> On Sat, Mar 09, 2024 at 08:28:28AM -0800, Darrick J. Wong wrote:
> > On Thu, Mar 07, 2024 at 07:31:38PM -0800, Darrick J. Wong wrote:
> > > On Fri, Mar 08, 2024 at 12:59:56PM +1100, Dave Chinner wrote:
> > > > > (Ab)using the fsbuf code did indeed work (and passed all the fstests -g
> > > > > verity tests), so now I know the idea is reasonable.  Patches 11, 12,
> > > > > 14, and 15 become unnecessary.  However, this solution is itself grossly
> > > > > overengineered, since all we want are the following operations:
> > > > > 
> > > > > peek(key): returns an fsbuf if there's any data cached for key
> > > > > 
> > > > > get(key): returns an fsbuf for key, regardless of state
> > > > > 
> > > > > store(fsbuf, p): attach a memory buffer p to fsbuf
> > > > > 
> > > > > Then the xfs ->read_merkle_tree_block function becomes:
> > > > > 
> > > > > 	bp = peek(key)
> > > > > 	if (bp)
> > > > > 		/* return bp data up to verity */
> > > > > 
> > > > > 	p = xfs_attr_get(key)
> > > > > 	if (!p)
> > > > > 		/* error */
> > > > > 
> > > > > 	bp = get(key)
> > > > > 	store(bp, p)
> > > > 
> > > > Ok, that looks good - it definitely gets rid of a lot of the
> > > > nastiness, but I have to ask: why does it need to be based on
> > > > xfs_bufs?
> > > 
> > > (copying from IRC) It was still warm in my brain L2 after all the xfile
> > > buftarg cleaning and merging that just got done a few weeks ago.   So I
> > > went with the simplest thing I could rig up to test my ideas, and now
> > > we're at the madly iterate until exhaustion stage. ;)
> > > 
> > > >            That's just wasting 300 bytes of memory on a handle to
> > > > store a key and a opaque blob in a rhashtable.
> > > 
> > > Yep.  The fsbufs implementation was a lot more slender, but a bunch more
> > > code.  I agree that I ought to go look at xarrays or something that's
> > > more of a direct mapping as a next step.  However, i wanted to get
> > > Andrey's feedback on this general approach first.
> > > 
> > > > IIUC, the key here is a sequential index, so an xarray would be a
> > > > much better choice as it doesn't require internal storage of the
> > > > key.
> > > 
> > > I wonder, what are the access patterns for merkle blobs?  Is it actually
> > > sequential, or is more like 0 -> N -> N*N as we walk towards leaves?
> 
> I think the leaf level (i.e. individual record) access patterns
> largely match data access patterns, so I'd just treat it like as if
> it's a normal file being accessed....

<nod> The latest version of this tries to avoid letting reclaim take the
top of the tree.  Logically this makes sense to me to reduce read verify
latency, but I was hoping Eric or Andrey or someone with more
familiarity with fsverity would chime in on whether or not that made
sense.

> > > Also -- the fsverity block interfaces pass in a "u64 pos" argument.  Was
> > > that done because merkle trees may some day have more than 2^32 blocks
> > > in them?  That won't play well with things like xarrays on 32-bit
> > > machines.
> > > 
> > > (Granted we've been talking about deprecating XFS on 32-bit for a while
> > > now but we're not the whole world)
> > > 
> > > > i.e.
> > > > 
> > > > 	p = xa_load(key);
> > > > 	if (p)
> > > > 		return p;
> > > > 
> > > > 	xfs_attr_get(key);
> > > > 	if (!args->value)
> > > > 		/* error */
> > > > 
> > > > 	/*
> > > > 	 * store the current value, freeing any old value that we
> > > > 	 * replaced at this key. Don't care about failure to store,
> > > > 	 * this is optimistic caching.
> > > > 	 */
> > > > 	p = xa_store(key, args->value, GFP_NOFS);
> > > > 	if (p)
> > > > 		kvfree(p);
> > > > 	return args->value;
> > > 
> > > Attractive.  Will have to take a look at that tomorrow.
> > 
> > Done.  I think.  Not sure that I actually got all the interactions
> > between the shrinker and the xarray correct though.  KASAN and lockdep
> > don't have any complaints running fstests, so that's a start.
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=fsverity-cleanups-6.9_2024-03-09
> 
> My initial impression is "over-engineered".

Overly focused on unfamiliar data structures -- I've never built
anything with an xarray before.

> I personally would have just allocated the xattr value buffer with a
> little extra size and added all the external cache information (a
> reference counter is all we need as these are fixed sized blocks) to
> the tail of the blob we actually pass to fsverity.

Oho, that's a good idea.  I didn't like the separate allocation anyway.
Friday was mostly chatting with willy and trying to make sure I got the
xarray access patterns correct.

>                                                    If we tag the
> inode in the radix tree as having verity blobs that can be freed, we
> can then just extend the existing fs sueprblock shrinker callout to
> also walk all the verity inodes with cached data to try to reclaim
> some objects...

This too is a wonderful suggestion -- use the third radix tree tag to
mark inodes with extra incore caches that can be reclaimed, then teach
xfs_reclaim_inodes_{nr,count} to scan them.  Allocating a per-inode
shrinker was likely to cause problems with flooding debugfs with too
many knobs anyway.

> But, if a generic blob cache is what it takes to move this forwards,
> so be it.

Not necessarily. ;)

--D

> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

