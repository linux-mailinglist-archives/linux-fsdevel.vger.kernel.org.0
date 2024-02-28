Return-Path: <linux-fsdevel+bounces-13140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A8686BC1E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 00:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6478282E32
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 23:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745B376EFA;
	Wed, 28 Feb 2024 23:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vh9jhLEA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6B82261D
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 23:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709162508; cv=none; b=DUarzime2s1mF9hDLGOPVufGdIYzk36zuJLE1oKMcKkLMpe9q6k1p/2nr/dlrSUkjpjOMhtCZKkal/58+h83+e4ddaPuQ+fzLVOyxwvkXXJL/NUnI2A780dDsDKbBRKTQagSEaDbZg7vMPQVMYQgnp2QyoOinQi2nHgcW0TE9oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709162508; c=relaxed/simple;
	bh=XXMlSmdPcKCBNYEC5ni4wZ7lE5m6PMF7OgTyKEFpHhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kp57BeC9J2SspAePL6YAraOBvWpn9S3r0hQg3GQ65gdNRcyNflKydO5s6qc1BIddzBHaE0JupwvfuORIrSr6vs8i5j84trP33P9oy962Pg8OYQxWWo/v1SzQ9ElcVO3Z1tIhS1TVf8ZovSStAzS8JQZeicYG5SCAeNtjlbsoDTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vh9jhLEA; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 28 Feb 2024 18:21:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709162504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GhXgUfHYdW3CUzoOL4/AC9rsi+BkTI4tCn2fBpQOL0c=;
	b=vh9jhLEAk3RPjg1RRjS9elSh6Uo7W0u3FrB5freJr9NhYgknj9a4mP6F0C2wQrbXDwc62Q
	r0XmfKkLzKI0SOe8S192Cy7kbFi1qHOM44y4WFOgn4R+Suq198o0jShK8P4MYB0YS8lPPx
	wOxuoNWP5H6O+ZozQdkiu/T5ZDpTZvw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Chinner <david@fromorbit.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm <linux-mm@kvack.org>, Daniel Gomez <da.gomez@samsung.com>, 
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
Message-ID: <w7incr52m75dfwbwcblrfivlgxdr3apsgyvloqmw3yejsmibis@mldv3ywv3ljh>
References: <Zdkxfspq3urnrM6I@bombadil.infradead.org>
 <xhymmlbragegxvgykhaddrkkhc7qn7soapca22ogbjlegjri35@ffqmquunkvxw>
 <Zd5ecZbF5NACZpGs@dread.disaster.area>
 <d2zbdldh5l6flfwzcwo6pnhjpoihfiaafl7lqeqmxdbpgoj77y@fjpx3tcc4oev>
 <CAHk-=wjXu68Fs4gikqME1FkbcxBcGQxStXyBevZGOy+NX9BMJg@mail.gmail.com>
 <4uiwkuqkx3lt7cbqlqchhxjq4pxxb3kdt6foblkkhxxpohlolb@iqhjdbz2oy22>
 <CAHk-=wiMf=W68wKXXnONVc9U+W7mfuhuHMHcowoZwh0b6SXPNg@mail.gmail.com>
 <amsqvy3aq5mzyk7esf5mzzgdjl32gosq5fgphjv5qzp6r25dke@sadcguvzo26m>
 <CAHk-=wgZAhEAK=POkKaUJP6_g4VUMUaiTM+PPH5jELy-JAyo8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgZAhEAK=POkKaUJP6_g4VUMUaiTM+PPH5jELy-JAyo8g@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 28, 2024 at 12:17:50PM -0800, Linus Torvalds wrote:
> On Wed, 28 Feb 2024 at 11:29, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >
> > The more concerning sitution to me would be if breaking write atomicity
> > means that we end up with data in the file that doesn't correspond to an
> > total ordering of writes; e.g. part of write a, then write b, then the
> > rest of write a overlaying part of write b.
> >
> > Maybe that can't happen as long as writes are always happening in
> > ascending folio order?
> 
> So that was what my suggestion about just overlapping one lock at a
> time was about - we always do writes in ascending order, and
> contiguously (even if the data source obviously isn't necessarily some
> contiguous thing).
> 
> And I think that's actually fundamental and not something we're likely
> to get out of. If you do non-contiguous writes, you'll always treat
> them as separate things.
> 
> Then just the "lock the next folio before unlocking the previous one"
> would already give some relevant guarantees, in that at least you
> wouldn't get overlapping writes where the write data would be mixed
> up.
> 
> So you'd get *some* ordering, and while I wouldn't call it "total
> ordering" (and I think with readers not taking locks you can't get
> that anyway because readers will *always* see partial writes), I think
> it's much better than some re-write model.

Well, the re-write model is for the case where we have to bail out, drop
locks and re-fault, and that's no different here. But that's a side
issue.

The "just take the next lock before dropping the previous lock" approach
- I agree that works just as well. I'm still trying to come up with a
satisfying proof as to why - but one writer can't pass another writer,
it's basically that.

> 
> However, the "lock consecutive pages as you go along" does still have
> the issue of "you have to be able to take a page fault in the middle".
> 
> And right now that actually depends on us always dropping the page
> lock in between iterations.
> 
> This issue is solvable - if you get a partial read while you hold a
> page lock, you can always just see "are the pages I hold locks on not
> up-to-date?" And decide to do the read yourself (and mark them
> up-to-date). We don't do that right now because it's simpler not to,
> but it's not conceptually a huge problem.

Hang on, I think you're talking about two different issues. The "oops,
copying from the _user_ buffer faulted" is the more annoying one here.
If the destination folio wasn't uptodate, we just read that inline, we
don't drop locks for that (at least my code doesn't; I'd have to have a
look at filemap.c and iomap for those versions).

There is another funny corner case where the destination folio wasn't
uptodate, and we decided we didn't need to read it in because we were
going to be fully overwriting it, but then we _didn't_ fully overwrite
it - then we have to revert that part of the write.

But if that happened it was because the useer copy didn't copy as much
as we expected, i.e. it would've needed to take a page fault, so we have
to bail out, drop locks and refault anyways.

As an aside, the "copy_to_(from|user) may recurse into arbitrary code
and take arbitrary locks" is some scary stuff, and I very much doubt
it's handled correctly everywhere. If I ever do the ioctl v2 proposal I
wrote up awhile back, I think part of that should be doubble buffering
approximately at the syscall layer so that we're not doing that from
within rando driver/fs code holding rando locks; the 1% of cases that
care about performance can do something special, but most shouldn't.

> It *is* a practical problem, though.
> 
> For example, in generic_perform_write(), we've left page locking on
> writes to the filesystems (ie it's done by
> "->write_begin/->write_end"), so I think in reality that "don't
> release the lock on folio N until after you've taken the lock on folio
> N+1" isn't actually wonderful. It has some really nasty practical
> issues.

yeah, write_begin and write_end are... odd, to say the least.

> And yes, those practical issues are because of historical mistakes
> (some of them very much by yours truly). Having one single "page lock"
> was probably one of those historical mistakes. If we use a different
> bit for serializing page writers, the above problem would go away as
> an issue.

well, it's a difficult situation, a _lot_ of different code ends up
wanting to communicate state machine style through page flags.

but yeah, we're not clear on whether folio lock protects
 - the data within the folio?
 - is it used for signalling read completion? (sometimes!)
 - is it used for guarding against against truncate/invalidate? There's
   multiple different truncate/invalidate paths, for doing different
   things based on folio dirty/writeback and perhaps locked
 - does it protect other filesystem state hanging off folio->private?
   you might thing so, but I came to the conclusion that that was a bad
   idea

> ANYWAY.
> 
> At least with the current setup we literally depend on that "one page
> at a time" behavior right now, and even XFS - which takes the inode
> lock shared for reading - does *not* do it for reading a page during a
> page fault for all these reasons.
> 
> XFS uses iomap_write_iter() instead of generic_perform_write(), but
> the solution there is exactly the same, and the issue is fairly
> fundamental (unless you want to always read in pages that you are
> going to overwrite first).
> 
> This is also one of the (many) reasons I think the POSIX atomicity
> model is complete garbage. I think the whole "reads are atomic with
> respect to writes" is a feel-good bedtime story. It's simplistic, and
> it's just not *real*, because it's basically not compatible with mmap.

oh, I wouldn't go that far.

I think the real problem is just undocumented behaviour that differs
across filesystems, and we've got too many filesystems doing their own
thing where their smart stuff should've been lifted up to the vfs (and
yes, I am a guilty party here too).

And another part of what makes this stuff hard is that it's always such
a goddamn hassle to extend userspace interfaces, even just to add a
couple flags. People have a real fear of that stuff, and when things are
proposed they end up getting bikeshed to death, and then we _overdesign_
stuff so that we don't have to repeat that process... no. Make it easy
to add new userspace interfaces, do it in small bite sized chunks, one
thing at a time, learn from our mistakes, depracate and add new
revisions for the stuff that turned out to be crap.

...What we really want here is just some flags so that userspace can
specify what locking model they want. We're clearly capable of
implementing multiple locking models, and the real nightmare scenario is
some userspace program depending on stupidly subtle atomicity guarantees
that only one filesystem implements AND THERE'S NOTHING TO GREP FOR IN
THE CODE TO FIND IT.

