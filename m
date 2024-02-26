Return-Path: <linux-fsdevel+bounces-12898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC85786849B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 00:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7F6E1C22095
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 23:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6829135A4F;
	Mon, 26 Feb 2024 23:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KOS/Is2c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8483513541B
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 23:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708990194; cv=none; b=L9YyNhESlzfWQWPDxOHdK3TWf32g/NVyY4c8dVHBqJWQ8GytqThuorEEwdhaZRM+OLgZCtGzL0a2YDUprLbrXld6ypeSN2pxo/Xa9iJWIDE41IRP+JLTrZEGR/SymPV6vOK6aDBogBBLsHwVqIXtP8MpEhlTW3TF8aMGtgbr7YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708990194; c=relaxed/simple;
	bh=M53+h9VHmYN+4rx+iVhMHzx9zJUos5PKoZ+P6IeAFdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g9lSCvuqCEl4aNGzpNNHkhN/cZ/n9Wp/Jo5WNVT74KFNYK4zWjmHpsdF30wYhljaEUrvmvnPn/CjShYIJe0o4HNmUKCXpvtkAr6uKrY6s0tuOqQL2wfgx48e8OXWbOeHjOu/h+FynoxUL/2eIdItC2et/ybDYhj2dGet9B4PdCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KOS/Is2c; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 26 Feb 2024 18:29:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708990189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qSjgjFLRQ0svTT7XtovrXKdNHpVCE/4+Eriq1XuSmJU=;
	b=KOS/Is2cfdoW661ygrKDejmtPCmybEJjs4pEptbp6vWppWENgBdu9LcEXuVLXOoUYeiYO+
	QmhXm9xJNRIe0Xgw5xH5Zvbn6SLX3Lt3BO31kRCfGsLFavRHdz9/SRx1p5UiD9eeel5DEa
	TIOw+GSt/IOMIbMJJXy7sweyKQxiMLI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>, 
	Daniel Gomez <da.gomez@samsung.com>, Pankaj Raghav <p.raghav@samsung.com>, 
	Jens Axboe <axboe@kernel.dk>, Dave Chinner <david@fromorbit.com>, 
	Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
Message-ID: <5c6ueuv5vlyir76yssuwmfmfuof3ukxz6h5hkyzfvsm2wkncrl@7wvkfpmvy2gp>
References: <Zduto30LUEqIHg4h@casper.infradead.org>
 <CAHk-=wibYaWYqs5A30a7ywJdsW5LDT1LYysjcCmzjzkK=uh+tQ@mail.gmail.com>
 <bk45mgxpdbm5gfa6wl37nhecttnb5bxh6wo3slixsray77azu5@pi3bblfn3c5u>
 <CAHk-=wjnW96+oP0zhEd1zjPNqOHvrddKkwp0+CuS5HpZavfmMQ@mail.gmail.com>
 <Zdv8dujdOg0dD53k@duke.home>
 <CAHk-=wiEVcqTU1oQPSjaJvxj5NReg3GzkBO8zpL1tXFG1UVyvg@mail.gmail.com>
 <Zdz9p_Kn0puI1KEL@casper.infradead.org>
 <znixgiqxzoksfwwzggmzsu6hwpqfszigjh5k6hx273qil7dx5t@5dxcovjdaypk>
 <upnvhnqaitifuwwbxcpa4zgf2hribfrtqzxtcrv5djbyjs2ond@axetql2wrwnt>
 <fb4d944e-fde7-423b-a376-25db0b317398@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb4d944e-fde7-423b-a376-25db0b317398@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 26, 2024 at 01:55:10PM -0800, Paul E. McKenney wrote:
> On Mon, Feb 26, 2024 at 04:19:14PM -0500, Kent Overstreet wrote:
> > +cc Paul
> > 
> > On Mon, Feb 26, 2024 at 04:17:19PM -0500, Kent Overstreet wrote:
> > > On Mon, Feb 26, 2024 at 09:07:51PM +0000, Matthew Wilcox wrote:
> > > > On Mon, Feb 26, 2024 at 09:17:33AM -0800, Linus Torvalds wrote:
> > > > > Willy - tangential side note: I looked closer at the issue that you
> > > > > reported (indirectly) with the small reads during heavy write
> > > > > activity.
> > > > > 
> > > > > Our _reading_ side is very optimized and has none of the write-side
> > > > > oddities that I can see, and we just have
> > > > > 
> > > > >   filemap_read ->
> > > > >     filemap_get_pages ->
> > > > >         filemap_get_read_batch ->
> > > > >           folio_try_get_rcu()
> > > > > 
> > > > > and there is no page locking or other locking involved (assuming the
> > > > > page is cached and marked uptodate etc, of course).
> > > > > 
> > > > > So afaik, it really is just that *one* atomic access (and the matching
> > > > > page ref decrement afterwards).
> > > > 
> > > > Yep, that was what the customer reported on their ancient kernel, and
> > > > we at least didn't make that worse ...
> > > > 
> > > > > We could easily do all of this without getting any ref to the page at
> > > > > all if we did the page cache release with RCU (and the user copy with
> > > > > "copy_to_user_atomic()").  Honestly, anything else looks like a
> > > > > complete disaster. For tiny reads, a temporary buffer sounds ok, but
> > > > > really *only* for tiny reads where we could have that buffer on the
> > > > > stack.
> > > > > 
> > > > > Are tiny reads (handwaving: 100 bytes or less) really worth optimizing
> > > > > for to that degree?
> > > > > 
> > > > > In contrast, the RCU-delaying of the page cache might be a good idea
> > > > > in general. We've had other situations where that would have been
> > > > > nice. The main worry would be low-memory situations, I suspect.
> > > > > 
> > > > > The "tiny read" optimization smells like a benchmark thing to me. Even
> > > > > with the cacheline possibly bouncing, the system call overhead for
> > > > > tiny reads (particularly with all the mitigations) should be orders of
> > > > > magnitude higher than two atomic accesses.
> > > > 
> > > > Ah, good point about the $%^&^*^ mitigations.  This was pre mitigations.
> > > > I suspect that this customer would simply disable them; afaik the machine
> > > > is an appliance and one interacts with it purely by sending transactions
> > > > to it (it's not even an SQL system, much less a "run arbitrary javascript"
> > > > kind of system).  But that makes it even more special case, inapplicable
> > > > to the majority of workloads and closer to smelling like a benchmark.
> > > > 
> > > > I've thought about and rejected RCU delaying of the page cache in the
> > > > past.  With the majority of memory in anon memory & file memory, it just
> > > > feels too risky to have so much memory waiting to be reused.  We could
> > > > also improve gup-fast if we could rely on RCU freeing of anon memory.
> > > > Not sure what workloads might benefit from that, though.
> > > 
> > > RCU allocating and freeing of memory can already be fairly significant
> > > depending on workload, and I'd expect that to grow - we really just need
> > > a way for reclaim to kick RCU when needed (and probably add a percpu
> > > counter for "amount of memory stranded until the next RCU grace
> > > period").
> 
> There are some APIs for that, though the are sharp-edged and mainly
> intended for rcutorture, and there are some hooks for a CI Kconfig
> option called RCU_STRICT_GRACE_PERIOD that could be organized into
> something useful.
> 
> Of course, if there is a long-running RCU reader, there is nothing
> RCU can do.  By definition, it must wait on all pre-existing readers,
> no exceptions.
> 
> But my guess is that you instead are thinking of memory-exhaustion
> emergencies where you would like RCU to burn more CPU than usual to
> reduce grace-period latency, there are definitely things that can be done.
> 
> I am sure that there are more questions that I should ask, but the one
> that comes immediately to mind is "Is this API call an occasional thing,
> or does RCU need to tolerate many CPUs hammering it frequently?"
> Either answer is fine, I just need to know.  ;-)

Well, we won't want it getting hammered on continuously - we should be
able to tune reclaim so that doesn't happen.

I think getting numbers on the amount of memory stranded waiting for RCU
is probably first order of business - minor tweak to kfree_rcu() et all
for that; there's APIs they can query to maintain that counter.

then, we can add a heuristic threshhold somewhere, something like 

if (rcu_stranded * multiplier > reclaimable_memory)
	kick_rcu()

