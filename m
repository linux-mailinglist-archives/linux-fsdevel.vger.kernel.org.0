Return-Path: <linux-fsdevel+bounces-12887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6710186835B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 22:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 199841F227BC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 21:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0FB131E28;
	Mon, 26 Feb 2024 21:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfNJyr1c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708B612F388
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 21:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708984511; cv=none; b=GejFW1yT+keZ52JZH2J+B5Seomci+Z4KFQAL6lQT+KOccTIaoitrXmsGbp4w074qJk7kImhVZD4edjmwoNzJbm2cDj5lO0K+39NUtjRB5OsIVvi567OMr13dSXqCLfQ167KDmGOBBS3ageKmxbCpUSIG+S36RwWYPhOxSBn+Wd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708984511; c=relaxed/simple;
	bh=QSYRZy9FUoynzy1lLrNSLVKDLhKHxKpJtpQ/pB5dh7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYb10n7OvWXcCbCcLc5f0B4Jw4MCIaqw3jleXcDJ4FwKeOTZbR26ipvwEo6M5S2FRMmpPlMyzmkHKhYOPn508HeecVVzlBPJNmeReNIvaK23ESgvrxSpfu1Nx0zZGhCX+JQya4YHmisOAc75xiG8ZxECRRDH0etBI2Cd0TJTh8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfNJyr1c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6AEAC433F1;
	Mon, 26 Feb 2024 21:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708984511;
	bh=QSYRZy9FUoynzy1lLrNSLVKDLhKHxKpJtpQ/pB5dh7s=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=NfNJyr1ca61qNnElH4a4LKcqC9/Uvmept7lOTssDeHjaW6SXTNjDYpP39n51VkntJ
	 54Wu6Hc4t7+P13aAaBF6XHuGTBUYAI7WUQqMfmk5SRix8yH2xPiXHfO1sPykmI/hQw
	 q/x6lw58BYkBA96dx7UERNmO3ATWUNyuWSi0sZug6zu3KvsETjnKMapjVGKFiEWToD
	 IgcsdIrp6ItY/983qAj7GtcXf05RfIodQaBNqJq85FxkhvlHqJKKvBjrRPeqAf7EC6
	 0LJoZ/Es9G+FwwixfpefXajRi1Dy0pyU4xyA5ZmEhn6FQaoKq8nJb6c9CeQbeJiUo9
	 HdQbfpuzKw0aw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8F33ECE0E27; Mon, 26 Feb 2024 13:55:10 -0800 (PST)
Date: Mon, 26 Feb 2024 13:55:10 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Matthew Wilcox <willy@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Al Viro <viro@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm <linux-mm@kvack.org>, Daniel Gomez <da.gomez@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>,
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
	Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
Message-ID: <fb4d944e-fde7-423b-a376-25db0b317398@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAHk-=wgVPHPPjZPoV8E_q59L7i8zFjHo_5hHo_+qECYuy7FF6g@mail.gmail.com>
 <Zduto30LUEqIHg4h@casper.infradead.org>
 <CAHk-=wibYaWYqs5A30a7ywJdsW5LDT1LYysjcCmzjzkK=uh+tQ@mail.gmail.com>
 <bk45mgxpdbm5gfa6wl37nhecttnb5bxh6wo3slixsray77azu5@pi3bblfn3c5u>
 <CAHk-=wjnW96+oP0zhEd1zjPNqOHvrddKkwp0+CuS5HpZavfmMQ@mail.gmail.com>
 <Zdv8dujdOg0dD53k@duke.home>
 <CAHk-=wiEVcqTU1oQPSjaJvxj5NReg3GzkBO8zpL1tXFG1UVyvg@mail.gmail.com>
 <Zdz9p_Kn0puI1KEL@casper.infradead.org>
 <znixgiqxzoksfwwzggmzsu6hwpqfszigjh5k6hx273qil7dx5t@5dxcovjdaypk>
 <upnvhnqaitifuwwbxcpa4zgf2hribfrtqzxtcrv5djbyjs2ond@axetql2wrwnt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <upnvhnqaitifuwwbxcpa4zgf2hribfrtqzxtcrv5djbyjs2ond@axetql2wrwnt>

On Mon, Feb 26, 2024 at 04:19:14PM -0500, Kent Overstreet wrote:
> +cc Paul
> 
> On Mon, Feb 26, 2024 at 04:17:19PM -0500, Kent Overstreet wrote:
> > On Mon, Feb 26, 2024 at 09:07:51PM +0000, Matthew Wilcox wrote:
> > > On Mon, Feb 26, 2024 at 09:17:33AM -0800, Linus Torvalds wrote:
> > > > Willy - tangential side note: I looked closer at the issue that you
> > > > reported (indirectly) with the small reads during heavy write
> > > > activity.
> > > > 
> > > > Our _reading_ side is very optimized and has none of the write-side
> > > > oddities that I can see, and we just have
> > > > 
> > > >   filemap_read ->
> > > >     filemap_get_pages ->
> > > >         filemap_get_read_batch ->
> > > >           folio_try_get_rcu()
> > > > 
> > > > and there is no page locking or other locking involved (assuming the
> > > > page is cached and marked uptodate etc, of course).
> > > > 
> > > > So afaik, it really is just that *one* atomic access (and the matching
> > > > page ref decrement afterwards).
> > > 
> > > Yep, that was what the customer reported on their ancient kernel, and
> > > we at least didn't make that worse ...
> > > 
> > > > We could easily do all of this without getting any ref to the page at
> > > > all if we did the page cache release with RCU (and the user copy with
> > > > "copy_to_user_atomic()").  Honestly, anything else looks like a
> > > > complete disaster. For tiny reads, a temporary buffer sounds ok, but
> > > > really *only* for tiny reads where we could have that buffer on the
> > > > stack.
> > > > 
> > > > Are tiny reads (handwaving: 100 bytes or less) really worth optimizing
> > > > for to that degree?
> > > > 
> > > > In contrast, the RCU-delaying of the page cache might be a good idea
> > > > in general. We've had other situations where that would have been
> > > > nice. The main worry would be low-memory situations, I suspect.
> > > > 
> > > > The "tiny read" optimization smells like a benchmark thing to me. Even
> > > > with the cacheline possibly bouncing, the system call overhead for
> > > > tiny reads (particularly with all the mitigations) should be orders of
> > > > magnitude higher than two atomic accesses.
> > > 
> > > Ah, good point about the $%^&^*^ mitigations.  This was pre mitigations.
> > > I suspect that this customer would simply disable them; afaik the machine
> > > is an appliance and one interacts with it purely by sending transactions
> > > to it (it's not even an SQL system, much less a "run arbitrary javascript"
> > > kind of system).  But that makes it even more special case, inapplicable
> > > to the majority of workloads and closer to smelling like a benchmark.
> > > 
> > > I've thought about and rejected RCU delaying of the page cache in the
> > > past.  With the majority of memory in anon memory & file memory, it just
> > > feels too risky to have so much memory waiting to be reused.  We could
> > > also improve gup-fast if we could rely on RCU freeing of anon memory.
> > > Not sure what workloads might benefit from that, though.
> > 
> > RCU allocating and freeing of memory can already be fairly significant
> > depending on workload, and I'd expect that to grow - we really just need
> > a way for reclaim to kick RCU when needed (and probably add a percpu
> > counter for "amount of memory stranded until the next RCU grace
> > period").

There are some APIs for that, though the are sharp-edged and mainly
intended for rcutorture, and there are some hooks for a CI Kconfig
option called RCU_STRICT_GRACE_PERIOD that could be organized into
something useful.

Of course, if there is a long-running RCU reader, there is nothing
RCU can do.  By definition, it must wait on all pre-existing readers,
no exceptions.

But my guess is that you instead are thinking of memory-exhaustion
emergencies where you would like RCU to burn more CPU than usual to
reduce grace-period latency, there are definitely things that can be done.

I am sure that there are more questions that I should ask, but the one
that comes immediately to mind is "Is this API call an occasional thing,
or does RCU need to tolerate many CPUs hammering it frequently?"
Either answer is fine, I just need to know.  ;-)

							Thanx, Paul

