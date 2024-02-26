Return-Path: <linux-fsdevel+bounces-12738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C28866769
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 02:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1481B20EF0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 01:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B8BD26A;
	Mon, 26 Feb 2024 01:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FAXnDyda"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65858BF1
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 01:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708909383; cv=none; b=GTzctgM0N86VGNz1do4DX0WeRlWNzZjP2E9mRALBEqtWG9sjIGFAFQVP5ehh8ApQ1xbdd+cPBV02BzxwZdDLtKAFOxIo/vFJeDV8OSps2ncpC9O7yWUQzTAKSKAXkPhRJt2j5Hz51n5qTklfzDuRBCh5BvhIOoNPzPZtoSdsHOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708909383; c=relaxed/simple;
	bh=WjanbFgKWQ8NA5yIHiybFePB7BT7lpCqJllNt/SjT+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pl/nZEaHwKstp78EIiz8dmWSxUicnZlgb1FjMjg2pCd+eDNr1qHGvnvoT70Ad4ADwAwboXvuxn9LRfBEv6umQHwL+xYEgErGu0N+UEezjEdP99aTO/wFcWka9gPh7p7F/eYjfksHFKpsKBoZd5nKcU7cyuI64esSWvwWrpw2wxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FAXnDyda; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 25 Feb 2024 20:02:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708909377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CRDocoIq5L5VL7T7kFqFldfUmNPgeWeF71pW5MECIhM=;
	b=FAXnDydagYHVkuck7VKRFcdjy2RLbMHqzE7QLwk5tK3SaP7afsd0VCs/sNjlrcMqNGb/52
	RKqalU0K1Fb7T8OTxtw38rHJV/Oz+OC2uN+CP/HWsa3NvbitBgxAKfRjW50mwx9lgfPA8D
	M1Fk0XAR7QbhTsw8yzVS4ykyquCGcqk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm <linux-mm@kvack.org>, Daniel Gomez <da.gomez@samsung.com>, 
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>, Dave Chinner <david@fromorbit.com>, 
	Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
Message-ID: <bk45mgxpdbm5gfa6wl37nhecttnb5bxh6wo3slixsray77azu5@pi3bblfn3c5u>
References: <Zdkxfspq3urnrM6I@bombadil.infradead.org>
 <Zdlsr88A6AAlJpcc@casper.infradead.org>
 <CAHk-=wjUkYLv23KtF=EyCrQcmf9NGwE8Yo1cuxdaLF8gqx5zWw@mail.gmail.com>
 <o4a6577t2z5xytjwmixqkl33h23vfnjypwbx7jaaldtldpvjf5@dzbzkhrzyobb>
 <Zds8T9O4AYAmdS9d@casper.infradead.org>
 <CAHk-=wgVPHPPjZPoV8E_q59L7i8zFjHo_5hHo_+qECYuy7FF6g@mail.gmail.com>
 <Zduto30LUEqIHg4h@casper.infradead.org>
 <CAHk-=wibYaWYqs5A30a7ywJdsW5LDT1LYysjcCmzjzkK=uh+tQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wibYaWYqs5A30a7ywJdsW5LDT1LYysjcCmzjzkK=uh+tQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sun, Feb 25, 2024 at 03:45:47PM -0800, Linus Torvalds wrote:
> On Sun, 25 Feb 2024 at 13:14, Matthew Wilcox <willy@infradead.org> wrote:
> >
> > Not artificial; this was a real customer with a real workload.  I don't
> > know how much about it I can discuss publically, but my memory of it was a
> > system writing a log with 64 byte entries, millions of entries per second.
> > Occasionally the system would have to go back and look at an entry in the
> > last few seconds worth of data (so it would still be in the page cache).
> 
> Honestly, that should never hit any kind of contention on the page cache.
> 
> Unless they did something else odd, that load should be entirely
> serialized by the POSIX "atomic write" requirements and the
> "inode_lock(inode)"  that writes take.
> 
> So it would end up literally being just one cache miss - and if you do
> things across CPU's and have cachelines moving around, that inode lock
> would be the bigger offender in that it is the one that would see any
> contention.
> 
> Now, *that* is locking that I despise, much more than the page cache
> lock.  It serializes unrelated writes to different areas, and the
> direct-IO people instead said "we don't care about POSIX" and did
> concurrent writes without it.

We could satisfy the posix atomic writes rule by just having a properly
vectorized buffered write path, no need for the inode lock - it really
should just be extending writes that have to hit the inode lock, same as
O_DIRECT.

(whenever people bring up range locks, I keep trying to tell them - we
already have that in the form of the folio lock, if you'd just use it
properly...)

