Return-Path: <linux-fsdevel+bounces-28664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 268F496CAA9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 01:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4626F1C22709
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 23:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6B417B4FA;
	Wed,  4 Sep 2024 23:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qldlD+ML"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C881372
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 23:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725491137; cv=none; b=IoNiIgCcI+dx0jRZ1NRPPqToQ4bw0bMQrrxE25eDzfVQo2yTG65pv/nibpquxWSJIteRZIj24dUtkoIXiAwX1dg39iWB8mRYNL5snI54LvHypCU4gQ1GWL7cSngRqb4YNIlAIuNR8Sg9e2gOYhOFvivsGce3a0UkttePLVpOtnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725491137; c=relaxed/simple;
	bh=AL7jBf/oj0Cd/KEMZtrNE6Gk35+GwCCya7UV9FRkstA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n15CxvIkiSmNQWlb/GeAzinyypJMZkbfURZphMlKp3ZL3vJq3jJuIH1Fc+Jhit00nkdCVf3uGmyMuXJ221Pjgv4yH4OpHfB7W60xiajkmSJKs6ITiCuiOQkd0Z1okUYwNxRSgzX0RhlqcGf0ROo7mCkgRjvcQDVONa3t00VfJik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qldlD+ML; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 4 Sep 2024 19:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725491134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KcVsx2vDwlHG4tKH3VNsA9AGL8ypQbgKqlGsi88qPzs=;
	b=qldlD+MLY/awoHP6h9eDQb6YaviSGzhThCweSL040WEvRSqzzpwPqgx4HAaievFjLWZKJt
	nQkeee2r7E5VxY5DhvIDWaXMdorCngIxHzEpFVSmRe+B0DEzFquLXaGVZsRk0xBPM5/Bz8
	Nd8G9AiWuM4qKc/av28TbAlF1hyYCF0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dave Chinner <david@fromorbit.com>
Cc: Michal Hocko <mhocko@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, 
	Yafang Shao <laoar.shao@gmail.com>, jack@suse.cz, Vlastimil Babka <vbabka@suse.cz>, 
	Dave Chinner <dchinner@redhat.com>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-bcachefs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2 v2] remove PF_MEMALLOC_NORECLAIM
Message-ID: <hebnghkaytxb5djjsh6w7eddl7czrbnd7duobwisauffs5ax2q@4itp76zkzsf7>
References: <20240902095203.1559361-1-mhocko@kernel.org>
 <ggrt5bn2lvxnnebqtzivmge3yjh3dnepqopznmjmkrcllb3b35@4vnnapwr36ur>
 <20240902145252.1d2590dbed417d223b896a00@linux-foundation.org>
 <yewfyeumr2vj3o6dqcrv6b2giuno66ki7vzib3syitrstjkksk@e2k5rx3xbt67>
 <qlkjvxqdm72ijaaiauifgsnyzx3mw4edl2hexfabnsdncvpyhd@dvxliffsmkl6>
 <ZtgI1bKhE3imqE5s@tiehlicka>
 <xjtcom43unuubdtzj7pudew3m5yk34jdrhim5nynvoalk3bgbu@4aohsslg5c5m>
 <ZtiOyJ1vjY3OjAUv@tiehlicka>
 <pmvxqqj5e6a2hdlyscmi36rcuf4kn37ry4ofdsp4aahpw223nk@lskmdcwkjeob>
 <Ztjgf/mzdnhj/szl@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ztjgf/mzdnhj/szl@dread.disaster.area>
X-Migadu-Flow: FLOW_OUT

On Thu, Sep 05, 2024 at 08:34:39AM GMT, Dave Chinner wrote:
> I've seen xfs_repair require a couple of TB of RAM to repair
> metadata heavy filesystems of relatively small size (sub-20TB).
> Once you get about a few hundred GB of metadata in the filesystem,
> the fsck cross-reference data set size can easily run into the TBs.
> 
> So 256GB might *seem* like a lot of memory, but we were seeing
> xfs_repair exceed that amount of RAM for metadata heavy filesystems
> at least a decade ago...
> 
> Indeed, we recently heard about a 6TB filesystem with 15 *billion*
> hardlinks in it.  The cross reference for resolving all those
> hardlinks would require somewhere in the order of 1.5TB of RAM to
> hold. The only way to reliably handle random access data sets this
> large is with pageable memory....

Christ...

This is also where space efficiency of metadata starts to really matter. 

Of course you store full backreferences for every hardlink, which is
nice in some ways and a pain in others.

> > Another more pressing one is the extents -> backpointers and
> > backpointers -> extents passes of fsck; we do a linear scan through one
> > btree checking references to another btree. For the btree we're checking
> > references to the lookups are random, so we need to cache and pin the
> > entire btree in ram if possible, or if not whatever will fit and we run
> > in multiple passes.
> > 
> > This is the #1 scalability issue hitting a number of users right now, so
> > I may need to rewrite it to pull backpointers into an eytzinger array
> > and do our random lookups for backpointers on that - but that will be
> > "the biggest vmalloc array we can possible allocate", so the INT_MAX
> > size limit is clearly an issue there...
> 
> Given my above comments, I think you are approaching this problem
> the wrong way. It is known that the data set that can exceed
> physical kernel memory size, hence it needs to be swappable. That
> way users can extend the kernel memory capacity via swapfiles when
> bcachefs.fsck needs more memory than the system has physical RAM.

Well, it depends on the locality of the cross references - I don't think
we want to go that route here, because if there isn't any locality in
the cross references we'll just be thrashing; better to run in multiple
passes, constraining each pass to what _will_ fit in ram...

It would be nice if we had a way to guesstimate locality in extents <->
backpointers references - if there is locality, then it's better to just
run in one pass - and we wouldn't bother with building up new tables,
we'd just rely on the btree node cache.

Perhaps that's what we'll do when online fsck is finished and we're
optimizing more for "don't disturb the rest of the system too much" than
"get it done as quick as possible".

I do need to start making use of Darrick's swappable memory code in at
least one other place though - the bucket tables when we're checking
basic allocation info. That one just exceeded the INT_MAX limit for a
user with a 30 TB hard drive, so I switched it to a radix tree for now,
but it really should be swappable memory.

Fortunately there's more locality in the accesses there.

> Hence Darrick designed and implemented pageable shmem backed memory
> files (xfiles) to hold these data sets. Hence the size limit of the
> online repair data set is physical RAM + swap space, same as it is
> for offline repair. You can find the xfile code in
> fs/xfs/scrub/xfile.[ch].
> 
> Support for large, sortable arrays of fixed size records built on
> xfiles can be found in xfarray.[ch], and blob storage in
> xfblob.[ch].

*nod*

I do wish we had normal virtually mapped swappable memory though - the
thing I don't like about xfarray is that it requires a radix tree walk
on every access, and we have _hardware_ that's meant to do that for
us.

But if you still care about 32 bit then that does necessitate Darrick's
approach. I'm willing to consider 32 bit legacy for bcachefs, though.

