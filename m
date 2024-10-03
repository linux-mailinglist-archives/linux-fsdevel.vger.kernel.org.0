Return-Path: <linux-fsdevel+bounces-30828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8828898E865
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 04:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52357286F70
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 02:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFAA171CD;
	Thu,  3 Oct 2024 02:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="g9JleLL/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD72E171AA
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Oct 2024 02:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727922059; cv=none; b=Mujel6iftb81bUkzFffSFPWvldkOPvEbLW51JJirbAKBNBBpKgI7oc69hmpQJGWacnexoqJc0/ujC1S3/p3wS3G0m5DWlGMRIxjh1Rb4UqbvLhItITDCUgn5bB49qwAYlXX1FgnmGRtdxz80eTyvO0PiXSqvd4jwn+eODMnC+II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727922059; c=relaxed/simple;
	bh=oCbr/02akKxRoebvZf+p2ecE4bYNdNI5xZGO00e/F1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDcjj0R2N5GKcDrwNBnQ/WPtaghDFqhlpMop0MLmiTmVHu/DLR5GClRoBMrZnhLthrwwXiiOgFu4nLRyeVHWO7cVZjX/OTBu+EgWscokoraWkxFbCok6ccR8zbpwU+j37R2j5PJIl8D+SzKBhpUdGJmiADzzUvuHgT/E+ZC0SyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=g9JleLL/; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20b7463dd89so4108925ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Oct 2024 19:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1727922057; x=1728526857; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DRAVVahBtKPYhKDPQzInqp36XmS5vLI+LiAMQFyEfX8=;
        b=g9JleLL/saheIiMs7/Y2Ao8HWkLsvR3ZTgcY3bynL6jMWqeBUYfhoB9wPfSOSaaN74
         vRdeq16MTnyLiS/GG30B8n1mUD9s8imcnsQevFWq17NYoL1cSzYxkttR61IjhVxXutmu
         92M53SImdrQ4vdA85DnOB7WpxqOU2/sTpVv4oXPuS+jxsZCqHMhDzDFEiLfxRZsQ7Ye8
         fnmFBl7KgUagItSAafm+dmD0v5vFVd+fepvXfj3QAWUcUuTqaSESQp+rjdt00hWpAe7f
         dh+B5Wkncruy0dCXyVqAv8QSP1HPw1lQF+JsIUzmp1hX/63FFkg+MbazyK3ESYEC4NTv
         cssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727922057; x=1728526857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRAVVahBtKPYhKDPQzInqp36XmS5vLI+LiAMQFyEfX8=;
        b=efAVCLoFv8Gca4jg66/zdKyQ/0Ffz9vJNhtsHN+3G5sgnlDat6BrOmZT+J4a+hOjRb
         Lr9b4nPb1JlGyMfWJIWG6LFtG/pBfVMqj2j5VZJF3/jo3BdTIuQcR6Kkc4FejVPjCs5A
         uyyqglphkuW/eeSgcy6d4ZRfecZlro1FX8jLogyyRMNMPZLpqpSuhpsdrjxDfNWJYFct
         6eA9PaccFdqRdvEc6SrKBhlUVEkhCW6csRIgSSGafXxCOpcbNLhUsQmErYRWulfirz0a
         IYlQ/4EXeIR336JT/xM/ZNU337tAxYLOUfZPbAdo0Jw8lMP8XV/TQRIUwhImYGXa9Zo3
         i53A==
X-Forwarded-Encrypted: i=1; AJvYcCWyBpQU+xlEB402T7mWmP4YTtrxOVy2WuRzgx/Skp7riMk6M3xKAN4ng44lLU6sT0eitKl0P5aLRa0ZPGdQ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywko+wc9oh925y2OxYdf1UncmJCRrpU7q5jXS0/41WovKGkBs1Q
	ZBkTl9N2IYOt/HeFpQGw6H16WRA55sWcXVg/CYdssz1Twx0GwTWDFhFhlyp7s2o=
X-Google-Smtp-Source: AGHT+IFI7ZWp14k/vsiNuCsC14zracI6uPQ5n4K6w+W+p0PX77SSq0c6hM8pYT54WP2BrSP3BnbFRA==
X-Received: by 2002:a17:903:32cc:b0:20b:a25e:16c5 with SMTP id d9443c01a7336-20bc5a87644mr79576035ad.53.1727922056848;
        Wed, 02 Oct 2024 19:20:56 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e10196sm89873705ad.145.2024.10.02.19.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 19:20:56 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1swBSX-00DCIv-2L;
	Thu, 03 Oct 2024 12:20:53 +1000
Date: Thu, 3 Oct 2024 12:20:53 +1000
From: Dave Chinner <david@fromorbit.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org
Subject: Re: [RFC PATCH 0/7] vfs: improving inode cache iteration scalability
Message-ID: <Zv3/hQs+Rz/dcQnP@dread.disaster.area>
References: <20241002014017.3801899-1-david@fromorbit.com>
 <20241002-lethargisch-hypnose-fd06ae7a0977@brauner>
 <Zv098heGHOtGfw1R@dread.disaster.area>
 <CAHk-=wgBqi+1YjH=-AiSDqx8p0uA6yGZ=HmMKtkGC3Ey=OhXhw@mail.gmail.com>
 <kz36dz2tzysa7ih7qf6iuhvzrfvwytzcpcv46hzedtpdebazam@2op5ojw3xvse>
 <Zv3UdBPLutZkBeNg@dread.disaster.area>
 <dhv3pbtrwyt6myltrhvgxobsvrejpsguo4xn6p572j3t3t3axl@d6x455tgwi2s>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dhv3pbtrwyt6myltrhvgxobsvrejpsguo4xn6p572j3t3t3axl@d6x455tgwi2s>

On Wed, Oct 02, 2024 at 09:22:38PM -0400, Kent Overstreet wrote:
> On Thu, Oct 03, 2024 at 09:17:08AM GMT, Dave Chinner wrote:
> > On Wed, Oct 02, 2024 at 04:28:35PM -0400, Kent Overstreet wrote:
> > > On Wed, Oct 02, 2024 at 12:49:13PM GMT, Linus Torvalds wrote:
> > > > On Wed, 2 Oct 2024 at 05:35, Dave Chinner <david@fromorbit.com> wrote:
> > > > >
> > > > > On Wed, Oct 02, 2024 at 12:00:01PM +0200, Christian Brauner wrote:
> > > > >
> > > > > > I don't have big conceptual issues with the series otherwise. The only
> > > > > > thing that makes me a bit uneasy is that we are now providing an api
> > > > > > that may encourage filesystems to do their own inode caching even if
> > > > > > they don't really have a need for it just because it's there.  So really
> > > > > > a way that would've solved this issue generically would have been my
> > > > > > preference.
> > > > >
> > > > > Well, that's the problem, isn't it? :/
> > > > >
> > > > > There really isn't a good generic solution for global list access
> > > > > and management.  The dlist stuff kinda works, but it still has
> > > > > significant overhead and doesn't get rid of spinlock contention
> > > > > completely because of the lack of locality between list add and
> > > > > remove operations.
> > > > 
> > > > I much prefer the approach taken in your patch series, to let the
> > > > filesystem own the inode list and keeping the old model as the
> > > > "default list".
> > > > 
> > > > In many ways, that is how *most* of the VFS layer works - it exposes
> > > > helper functions that the filesystems can use (and most do), but
> > > > doesn't force them.
> > > > 
> > > > Yes, the VFS layer does force some things - you can't avoid using
> > > > dentries, for example, because that's literally how the VFS layer
> > > > deals with filenames (and things like mounting etc). And honestly, the
> > > > VFS layer does a better job of filename caching than any filesystem
> > > > really can do, and with the whole UNIX mount model, filenames
> > > > fundamentally cross filesystem boundaries anyway.
> > > > 
> > > > But clearly the VFS layer inode list handling isn't the best it can
> > > > be, and unless we can fix that in some fundamental way (and I don't
> > > > love the "let's use crazy lists instead of a simple one" models) I do
> > > > think that just letting filesystems do their own thing if they have
> > > > something better is a good model.
> > > 
> > > Well, I don't love adding more indirection and callbacks.
> > 
> > It's way better than open coding inode cache traversals everywhere.
> 
> Eh? You had a nice iterator for dlock-list :)

Which was painful to work with because
it maintains the existing spin lock based traversal pattern. This
was necessary because the iterator held a spinlock internally. I
really didn't like that aspect of it because it perpeutated the need
to open code the iget/iput game to allow the spinlock to be dropped
across the inode operation that needed to be performed.

i.e. adding an dlist iterator didn't clean up any of the other mess
that sb->s_inodes iteration required...

> > We simply cannot do things like that without a new iteration model.
> > Abstraction is necessary to facilitate a new iteration model, and a
> > model that provides independent object callbacks allows scope for
> > concurrent processing of individual objects.
> 
> Parallelized iteration is a slick possibility.
> 
> My concern is that we've been trying to get away from callbacks for
> iteration - post spectre they're quite a bit more expensive than
> external iterators, and we've generally been successful with that. 

So everyone keeps saying, but the old adage applies here: Penny
wise, pound foolish.

Optimising away the callbacks might bring us a few percent
performance improvement for each operation (e.g. via the dlist
iterator mechanisms) in a traversal, but that iteration is still
only single threaded. Hence the maximum processing rate is
determined by the performance of a single CPU core.

However, if we change the API to allow for parallelism at the cost
of a few percent per object operation, then a single CPU core will
not process quite as many objects as before. However, the moment we
allow multiple CPU cores to process in parallel, we acheive
processing rate improvements measured in integer multiples.

Modern CPUs have concurrency to burn.  Optimising APIs for minimum
per-operation overhead rather than for concurrent processing
implementations is the wrong direction to be taking....

> > > Converting the standard inode hash table to an rhashtable (or more
> > > likely, creating a new standard implementation and converting
> > > filesystems one at a time) still needs to happen, and then the "use the
> > > hash table for iteration" approach could use that without every
> > > filesystem having to specialize.
> > 
> > Yes, but this still doesn't help filesystems like XFS where the
> > structure of the inode cache is highly optimised for the specific
> > on-disk and in-memory locality of inodes. We aren't going to be
> > converting XFS to a rhashtable based inode cache anytime soon
> > because it simply doesn't provide the functionality we require.
> > e.g. efficient lockless sequential inode number ordered traversal in
> > -every- inode cluster writeback operation.
> 
> I was going to ask what your requirements are - I may take on the
> general purpose inode rhashtable code, although since I'm still pretty
> buried we'll see.
> 
> Coincidentally, just today I'm working on an issue in bcachefs where
> we'd also prefer an ordered data structure to a hash table for the inode
> cache - in online fsck, we need to be able to check if an inode is still
> open, but checking for an inode in an interior snapshot node means we
> have to do a scan and check if any of the open inodes are in a
> descendent subvolume.
> 
> Radix tree doesn't work for us, since our keys are { inum, subvol } - 96
> bits -

Sure it does - you just need two layers of radix trees. i.e have a
radix tree per subvol to index inodes by inum, and a per-sb radix
tree to index the subvols. With some code to propagate radix tree
bits from the inode radix tree to the subvol radix tree they then
largely work in conjunction for filtered searches.

This is -exactly- the internal inode cache structure that XFS has.
We have a per-sb radix tree indexing the allocation groups, and a
radix tree per allocation group indexing inodes by inode number.
Hence an inode lookup involves splitting the inum into agno/agino
pairs, then doing a perag lookup with the agno, and doing a perag
inode cache lookup with the agino. All of these radix tree
lookups are lockless...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

