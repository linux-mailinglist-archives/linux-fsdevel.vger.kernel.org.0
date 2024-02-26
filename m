Return-Path: <linux-fsdevel+bounces-12881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E248868260
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 22:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B48AE1C24C79
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 21:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60579130E53;
	Mon, 26 Feb 2024 21:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EgIwleAL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C091DFC4
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 21:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708981681; cv=none; b=W1tgAd+zZxkSZYCb1/l23TRpDUTGFyKA96FT8M+BHhfXEDFprRCYHeBS0qsBI07Sbomv6BrXiWTctUlXhm99wv3qIpsAN0Nqr7+JVzB1rsLwKnjA8fQG8JoA0fVNJC1TC9I9hKtyyFeZv67nABT6FekkHoH1H2P6WmwXahDQ7Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708981681; c=relaxed/simple;
	bh=gJrqi+6xBIASn6JXt0s+x+iSTghuYaMMw3+lzOH6Ubk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJYo2z4/0HJTcgtqcrRjfrLJqs1aawuBSoblHHweqwSu7kxRC1XlEajHE8wHHwFSmGfQoCMfBGQNd2m7c01MZaEtG9aLSoBIGC82ej6TefgoHrYVstJ16C/tzivHKVspnetv9qsxuUgS6A4nV2OOmH8uQUSgyoN7Da35/mfHOuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EgIwleAL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yx2ecZmSxs5OJEzpli0ea56NCZw1og6Vtd4aLoQQyOw=; b=EgIwleALwyWPB08e/Qecjsk35I
	rPwHOusf4Jbre5vKPqJkUJMFqLzmcQhbRervfw6C6ylpIqQbB+12oeD0rvMIUJBgr47G7973iDZrL
	DFLFHgW06KZ7lTjELcSn/2DCEm7crmH3PeKwLoSC3yI7ms8tv9+vMniAds3u4dYnBSqrx2jY1MPFS
	UQZ01WN3hiR1S3REBkIKlQlw+odqAcNreY13TqrLmZZwXEkiYmVoaStBFMtuDi+zJm+1mKD7wpx8F
	M8JC0fUyUwWO7O/5RRsvq+q+uUqz9oQpNOFiTgWMddRcNgxlrqKRc7Pd2IXQejoczyuKMqNwTcKSa
	aPGOezKA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reiCV-00000000awV-4B1r;
	Mon, 26 Feb 2024 21:07:52 +0000
Date: Mon, 26 Feb 2024 21:07:51 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>,
	Luis Chamberlain <mcgrof@kernel.org>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm <linux-mm@kvack.org>, Daniel Gomez <da.gomez@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>,
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
	Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
Message-ID: <Zdz9p_Kn0puI1KEL@casper.infradead.org>
References: <CAHk-=wjUkYLv23KtF=EyCrQcmf9NGwE8Yo1cuxdaLF8gqx5zWw@mail.gmail.com>
 <o4a6577t2z5xytjwmixqkl33h23vfnjypwbx7jaaldtldpvjf5@dzbzkhrzyobb>
 <Zds8T9O4AYAmdS9d@casper.infradead.org>
 <CAHk-=wgVPHPPjZPoV8E_q59L7i8zFjHo_5hHo_+qECYuy7FF6g@mail.gmail.com>
 <Zduto30LUEqIHg4h@casper.infradead.org>
 <CAHk-=wibYaWYqs5A30a7ywJdsW5LDT1LYysjcCmzjzkK=uh+tQ@mail.gmail.com>
 <bk45mgxpdbm5gfa6wl37nhecttnb5bxh6wo3slixsray77azu5@pi3bblfn3c5u>
 <CAHk-=wjnW96+oP0zhEd1zjPNqOHvrddKkwp0+CuS5HpZavfmMQ@mail.gmail.com>
 <Zdv8dujdOg0dD53k@duke.home>
 <CAHk-=wiEVcqTU1oQPSjaJvxj5NReg3GzkBO8zpL1tXFG1UVyvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiEVcqTU1oQPSjaJvxj5NReg3GzkBO8zpL1tXFG1UVyvg@mail.gmail.com>

On Mon, Feb 26, 2024 at 09:17:33AM -0800, Linus Torvalds wrote:
> Willy - tangential side note: I looked closer at the issue that you
> reported (indirectly) with the small reads during heavy write
> activity.
> 
> Our _reading_ side is very optimized and has none of the write-side
> oddities that I can see, and we just have
> 
>   filemap_read ->
>     filemap_get_pages ->
>         filemap_get_read_batch ->
>           folio_try_get_rcu()
> 
> and there is no page locking or other locking involved (assuming the
> page is cached and marked uptodate etc, of course).
> 
> So afaik, it really is just that *one* atomic access (and the matching
> page ref decrement afterwards).

Yep, that was what the customer reported on their ancient kernel, and
we at least didn't make that worse ...

> We could easily do all of this without getting any ref to the page at
> all if we did the page cache release with RCU (and the user copy with
> "copy_to_user_atomic()").  Honestly, anything else looks like a
> complete disaster. For tiny reads, a temporary buffer sounds ok, but
> really *only* for tiny reads where we could have that buffer on the
> stack.
> 
> Are tiny reads (handwaving: 100 bytes or less) really worth optimizing
> for to that degree?
> 
> In contrast, the RCU-delaying of the page cache might be a good idea
> in general. We've had other situations where that would have been
> nice. The main worry would be low-memory situations, I suspect.
> 
> The "tiny read" optimization smells like a benchmark thing to me. Even
> with the cacheline possibly bouncing, the system call overhead for
> tiny reads (particularly with all the mitigations) should be orders of
> magnitude higher than two atomic accesses.

Ah, good point about the $%^&^*^ mitigations.  This was pre mitigations.
I suspect that this customer would simply disable them; afaik the machine
is an appliance and one interacts with it purely by sending transactions
to it (it's not even an SQL system, much less a "run arbitrary javascript"
kind of system).  But that makes it even more special case, inapplicable
to the majority of workloads and closer to smelling like a benchmark.

I've thought about and rejected RCU delaying of the page cache in the
past.  With the majority of memory in anon memory & file memory, it just
feels too risky to have so much memory waiting to be reused.  We could
also improve gup-fast if we could rely on RCU freeing of anon memory.
Not sure what workloads might benefit from that, though.

It'd be cute if we could restrict free memory to be only reallocatable by
the process that had previously allocated it until an RCU grace period
had passed.  That way you could still snoop, but only on yourself which
wouldn't be all that exciting.  Doubt it'd be worth the effort of setting
up per-mm freelists, although it would allow us to skip zeroing the page
under some circumstances ...


