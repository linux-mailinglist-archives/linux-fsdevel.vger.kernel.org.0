Return-Path: <linux-fsdevel+bounces-13149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D057886BDAC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 02:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86996282FA5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 01:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0B9374FF;
	Thu, 29 Feb 2024 00:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CoJg5ftQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D593717B
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 00:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709168273; cv=none; b=jTM0g7YseJSs6n1YFP0zK2qF3e5Qgg2XtZB2gpTXkuXXioUZkA42ZL5loPknR8CiJaNvwrlSTzhcCSEtQNEmw+I3FoUZfm/kHC7UVQEyLhh0/Y7Y/VW4u2Ehs/97btJd+il4MPPKqBBvTknieAIaXgIxflmFzphDGXanD0TKwEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709168273; c=relaxed/simple;
	bh=kOjAe9f7Zl6vHEFXDo46CNLA9Ap8qKxU6JLXInxvghM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJrZYBuzBVgvCEfFW6Dyf3Z7XxaF7eImqcwWBcTWpTcHBYzLba9fYdrG6WLlA+uz/+//aQuckdzZIoWEigdn7RJReGNCodD1lUFupHQaIBRMmKlSd0/oaxB5eSDXMJ4Ixg1ccijEIDMPdXMsnwYq00sk9U3CpIoa2xVWAJGHfuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CoJg5ftQ; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 28 Feb 2024 19:57:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709168268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uv9ar9mptQNlelTUKQCvcTXiPbKJ6d2oz0Pm8eqFib8=;
	b=CoJg5ftQ2RT3INjKRvVwkfK50lqwXKBx8DL7czNU7vZmC3/2qOgG4uUCm3aMs+udtbrXv3
	ACpl4ucd7ojjtLp7xme7EQm6Arh7k7N+Ka1rwpVUaaQzhZ5t6PgqLgZQdDg2MuzcIYc0iE
	jFV2YbiUzRXWdnkBxiGOc6gd2zaNlvc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dave Chinner <david@fromorbit.com>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>, Chris Mason <clm@fb.com>, 
	Matthew Wilcox <willy@infradead.org>, Daniel Gomez <da.gomez@samsung.com>, 
	linux-mm <linux-mm@kvack.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, 
	Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Measuring limits and enhancing
 buffered IO
Message-ID: <j6cvqvq2az45kj5tjepbklm7r3h24rl4mj65ygf3uozaseauuv@hdr7tmidxx5u>
References: <Zdkxfspq3urnrM6I@bombadil.infradead.org>
 <xhymmlbragegxvgykhaddrkkhc7qn7soapca22ogbjlegjri35@ffqmquunkvxw>
 <Zd5ecZbF5NACZpGs@dread.disaster.area>
 <d2zbdldh5l6flfwzcwo6pnhjpoihfiaafl7lqeqmxdbpgoj77y@fjpx3tcc4oev>
 <Zd5lORiOCUsARPWq@dread.disaster.area>
 <CAOQ4uxi=fdjXq7q0_+0mDovmBd6Afb=xteFBSnE-rUmQMJYgRQ@mail.gmail.com>
 <Zd/O/S3rdvZ8OxZJ@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zd/O/S3rdvZ8OxZJ@dread.disaster.area>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 29, 2024 at 11:25:33AM +1100, Dave Chinner wrote:
> On Wed, Feb 28, 2024 at 09:48:46AM +0200, Amir Goldstein wrote:
> > On Wed, Feb 28, 2024 at 12:42 AM Dave Chinner via Lsf-pc
> > <lsf-pc@lists.linux-foundation.org> wrote:
> > >
> > > On Tue, Feb 27, 2024 at 05:21:20PM -0500, Kent Overstreet wrote:
> > > > On Wed, Feb 28, 2024 at 09:13:05AM +1100, Dave Chinner wrote:
> > > > > On Tue, Feb 27, 2024 at 05:07:30AM -0500, Kent Overstreet wrote:
> > > > > > AFAIK every filesystem allows concurrent direct writes, not just xfs,
> > > > > > it's _buffered_ writes that we care about here.
> > > > >
> > > > > We could do concurrent buffered writes in XFS - we would just use
> > > > > the same locking strategy as direct IO and fall back on folio locks
> > > > > for copy-in exclusion like ext4 does.
> > > >
> > > > ext4 code doesn't do that. it takes the inode lock in exclusive mode,
> > > > just like everyone else.
> > >
> > > Uhuh. ext4 does allow concurrent DIO writes. It's just much more
> > > constrained than XFS. See ext4_dio_write_checks().
> > >
> > > > > The real question is how much of userspace will that break, because
> > > > > of implicit assumptions that the kernel has always serialised
> > > > > buffered writes?
> > > >
> > > > What would break?
> > >
> > > Good question. If you don't know the answer, then you've got the
> > > same problem as I have. i.e. we don't know if concurrent
> > > applications that use buffered IO extensively (eg. postgres) assume
> > > data coherency because of the implicit serialisation occurring
> > > during buffered IO writes?
> > >
> > > > > > If we do a short write because of a page fault (despite previously
> > > > > > faulting in the userspace buffer), there is no way to completely prevent
> > > > > > torn writes an atomicity breakage; we could at least try a trylock on
> > > > > > the inode lock, I didn't do that here.
> > > > >
> > > > > As soon as we go for concurrent writes, we give up on any concept of
> > > > > atomicity of buffered writes (esp. w.r.t reads), so this really
> > > > > doesn't matter at all.
> > > >
> > > > We've already given up buffered write vs. read atomicity, have for a
> > > > long time - buffered read path takes no locks.
> > >
> > > We still have explicit buffered read() vs buffered write() atomicity
> > > in XFS via buffered reads taking the inode lock shared (see
> > > xfs_file_buffered_read()) because that's what POSIX says we should
> > > have.
> > >
> > > Essentially, we need to explicitly give POSIX the big finger and
> > > state that there are no atomicity guarantees given for write() calls
> > > of any size, nor are there any guarantees for data coherency for
> > > any overlapping concurrent buffered IO operations.
> > >
> > 
> > I have disabled read vs. write atomicity (out-of-tree) to make xfs behave
> > as the other fs ever since Jan has added the invalidate_lock and I believe
> > that Meta kernel has done that way before.
> > 
> > > Those are things we haven't completely given up yet w.r.t. buffered
> > > IO, and enabling concurrent buffered writes will expose to users.
> > > So we need to have explicit policies for this and document them
> > > clearly in all the places that application developers might look
> > > for behavioural hints.
> > 
> > That's doable - I can try to do that.
> > What is your take regarding opt-in/opt-out of legacy behavior?
> 
> Screw the legacy code, don't even make it an option. No-one should
> be relying on large buffered writes being atomic anymore, and with
> high order folios in the page cache most small buffered writes are
> going to be atomic w.r.t. both reads and writes anyway.

That's a new take...

> 
> > At the time, I have proposed POSIX_FADV_TORN_RW API [1]
> > to opt-out of the legacy POSIX behavior, but I guess that an xfs mount
> > option would make more sense for consistent and clear semantics across
> > the fs - it is easier if all buffered IO to inode behaved the same way.
> 
> No mount options, just change the behaviour. Applications already
> have to avoid concurrent overlapping buffered reads and writes if
> they care about data integrity and coherency, so making buffered
> writes concurrent doesn't change anything.

Honestly - no.

Userspace would really like to see some sort of definition for this kind
of behaviour, and if we just change things underneath them without
telling anyone, _that's a dick move_.

POSIX_FADV_TORN_RW is a terrible name, though.

And fadvise() is the wrong API for this because it applies to ranges,
this should be an open flag or an fcntl.

