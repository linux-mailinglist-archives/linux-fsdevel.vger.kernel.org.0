Return-Path: <linux-fsdevel+bounces-12883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 704B08682D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 22:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90E111C244E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 21:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030CA131732;
	Mon, 26 Feb 2024 21:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Bu4rM9z3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E63130E5E
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 21:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708982250; cv=none; b=n5gG4AbKLVStnZ/N3ZakJURmZGDLc5pDMpueLP9IgS4KxVJgQtZB8UiEhuxeF2fHEcg2QrKg9sKUFK4wVEFajTrh0H1421RwDngCkeI71lobPROtEgy2EbFIX1g77RBizxXdoVHiuahUgpKdvhJ00A2Ge2kCJFBGTQq4eBJP5/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708982250; c=relaxed/simple;
	bh=OQ2KXAKulmXkfeRq8y5MuvIrr3vtbv4mwg/8vO1nJJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmCAYuxpYAZtKMJe/2FS3ybHKvvX8ecTLj/itvpZqmqGLWCALD/m7+byYflWxhFIayIAkSe+sVERSN8WsaI1iT9VvIHj9i56mp7S5nt2yJwVxF71Wo6IrwtII6oC2AfxtE3ylNbvKkOSZtD09YJNH6qqpAJKieSp0BQoZy6e+dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Bu4rM9z3; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 26 Feb 2024 16:17:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708982245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jLf3txpUuSUSMJ8XqtuKRPYwmCVpIzNopRtHeIncJA4=;
	b=Bu4rM9z3Wp3E+ZycnuTvhybTjYR4KFdnGFue8NWUvqNmDaD6dH45V2pfMRv8/IiI+Z3XrA
	yM14ZGch4szglv8fPpQ7wndHLu4JmC6PUFUUOhYMnnmbcpYY25m7B7U6c2yRaJ5O1F5Tqx
	FSQzNljdPRWVo2Y37IEQsH1gqT2Vd7I=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Al Viro <viro@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>, 
	Daniel Gomez <da.gomez@samsung.com>, Pankaj Raghav <p.raghav@samsung.com>, 
	Jens Axboe <axboe@kernel.dk>, Dave Chinner <david@fromorbit.com>, 
	Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
Message-ID: <znixgiqxzoksfwwzggmzsu6hwpqfszigjh5k6hx273qil7dx5t@5dxcovjdaypk>
References: <o4a6577t2z5xytjwmixqkl33h23vfnjypwbx7jaaldtldpvjf5@dzbzkhrzyobb>
 <Zds8T9O4AYAmdS9d@casper.infradead.org>
 <CAHk-=wgVPHPPjZPoV8E_q59L7i8zFjHo_5hHo_+qECYuy7FF6g@mail.gmail.com>
 <Zduto30LUEqIHg4h@casper.infradead.org>
 <CAHk-=wibYaWYqs5A30a7ywJdsW5LDT1LYysjcCmzjzkK=uh+tQ@mail.gmail.com>
 <bk45mgxpdbm5gfa6wl37nhecttnb5bxh6wo3slixsray77azu5@pi3bblfn3c5u>
 <CAHk-=wjnW96+oP0zhEd1zjPNqOHvrddKkwp0+CuS5HpZavfmMQ@mail.gmail.com>
 <Zdv8dujdOg0dD53k@duke.home>
 <CAHk-=wiEVcqTU1oQPSjaJvxj5NReg3GzkBO8zpL1tXFG1UVyvg@mail.gmail.com>
 <Zdz9p_Kn0puI1KEL@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zdz9p_Kn0puI1KEL@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 26, 2024 at 09:07:51PM +0000, Matthew Wilcox wrote:
> On Mon, Feb 26, 2024 at 09:17:33AM -0800, Linus Torvalds wrote:
> > Willy - tangential side note: I looked closer at the issue that you
> > reported (indirectly) with the small reads during heavy write
> > activity.
> > 
> > Our _reading_ side is very optimized and has none of the write-side
> > oddities that I can see, and we just have
> > 
> >   filemap_read ->
> >     filemap_get_pages ->
> >         filemap_get_read_batch ->
> >           folio_try_get_rcu()
> > 
> > and there is no page locking or other locking involved (assuming the
> > page is cached and marked uptodate etc, of course).
> > 
> > So afaik, it really is just that *one* atomic access (and the matching
> > page ref decrement afterwards).
> 
> Yep, that was what the customer reported on their ancient kernel, and
> we at least didn't make that worse ...
> 
> > We could easily do all of this without getting any ref to the page at
> > all if we did the page cache release with RCU (and the user copy with
> > "copy_to_user_atomic()").  Honestly, anything else looks like a
> > complete disaster. For tiny reads, a temporary buffer sounds ok, but
> > really *only* for tiny reads where we could have that buffer on the
> > stack.
> > 
> > Are tiny reads (handwaving: 100 bytes or less) really worth optimizing
> > for to that degree?
> > 
> > In contrast, the RCU-delaying of the page cache might be a good idea
> > in general. We've had other situations where that would have been
> > nice. The main worry would be low-memory situations, I suspect.
> > 
> > The "tiny read" optimization smells like a benchmark thing to me. Even
> > with the cacheline possibly bouncing, the system call overhead for
> > tiny reads (particularly with all the mitigations) should be orders of
> > magnitude higher than two atomic accesses.
> 
> Ah, good point about the $%^&^*^ mitigations.  This was pre mitigations.
> I suspect that this customer would simply disable them; afaik the machine
> is an appliance and one interacts with it purely by sending transactions
> to it (it's not even an SQL system, much less a "run arbitrary javascript"
> kind of system).  But that makes it even more special case, inapplicable
> to the majority of workloads and closer to smelling like a benchmark.
> 
> I've thought about and rejected RCU delaying of the page cache in the
> past.  With the majority of memory in anon memory & file memory, it just
> feels too risky to have so much memory waiting to be reused.  We could
> also improve gup-fast if we could rely on RCU freeing of anon memory.
> Not sure what workloads might benefit from that, though.

RCU allocating and freeing of memory can already be fairly significant
depending on workload, and I'd expect that to grow - we really just need
a way for reclaim to kick RCU when needed (and probably add a percpu
counter for "amount of memory stranded until the next RCU grace
period").

