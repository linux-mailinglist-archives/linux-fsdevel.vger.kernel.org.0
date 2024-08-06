Return-Path: <linux-fsdevel+bounces-25057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0029486D8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 03:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61CF81C223AB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 01:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D38FBA20;
	Tue,  6 Aug 2024 01:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="VIZi7iX0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE6B847C
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 01:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722906142; cv=none; b=uI/huC5rLIZEeEHOVk6z3HbbJbsG7k26wZcK/mCMg1rROj3zjeeg080CGFVKFJ37VOetOZN0qiL6ad7yblkc1WecRG4J1hW/pw26+Hvbezit7PZFgA9R7PtL7qGN6RVD98b7BJzwA5fSxFobgNB/QR4qKcEcXyMzg2vLNzroI0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722906142; c=relaxed/simple;
	bh=o+hS/f8DwZatc+CaeME10Hjurv3XQmZIFOfZnfnYmg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FKC3SdojVOcwUJj5cA1qYO6WwU837qy77k9XdP/qMNqSEUmq5qXZSByO2KVT7mOm0S+B4B2do6WmXXKaBRK6Sz9MlcoClZvcQ8QIVigI/kQVMSgPDTIGQBXBmHSQzgvlzlxgs7kx3D6TdrHmzsnppxZbTXbyGfWG7VJYmbd9v9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=VIZi7iX0; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KWiVU+zaFYfYjoZnB+Wf2CUE2+cCS8AwsYIMpLKDHV0=; b=VIZi7iX0E4eQP9+qW3p5Y6M122
	jtHB0QoQ0MzrRQy1zUhjqeCKlMseEc4V2GgAN6ZxZClKfBu5EQBN6ia9cNVz+/tsSlFWOzprI4mcd
	9H1gXgoNUQwK9jXpjoBI/kaQhDmlOX2e1mkCxfvGNqh3bHGe5qRqcFtGGfaw4RjjAfwC/2YRGLhf2
	8oGJdtfa3nM27wG2a+Xnt1mu23amdkdgZtN0z/7FA4DIt9ji9Z0GtCtCL1QFlzNEsAKAKXgJnjtNB
	y0QVR1S42tD6/rTJmtc6t0hPhuO59tq1DhkPIAiDyjBbtzXFkrW4sVms5l1d2rRO5c5Dbqxdg7XTh
	BTb5ALBg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sb8af-00000001p4O-3eC3;
	Tue, 06 Aug 2024 01:02:17 +0000
Date: Tue, 6 Aug 2024 02:02:17 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fix bitmap corruption on close_range() with
 CLOSE_RANGE_UNSHARE
Message-ID: <20240806010217.GL5334@ZenIV>
References: <20240803225054.GY5334@ZenIV>
 <CAHk-=wgDgy++ydcF6U2GOLAAxTB526ctk1SS7s1y=1HaexwcvA@mail.gmail.com>
 <20240804003405.GA5334@ZenIV>
 <20240804034739.GB5334@ZenIV>
 <CAHk-=wgH=M9G02hhgPL36cN3g21MmGbg7zAeS6HtN9LarY_PYg@mail.gmail.com>
 <20240804211322.GD5334@ZenIV>
 <20240805234456.GK5334@ZenIV>
 <CAHk-=wjb1pGkNuaJOyJf9Uois648to5NJNLXHk5ELFTB_HL0PA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjb1pGkNuaJOyJf9Uois648to5NJNLXHk5ELFTB_HL0PA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Aug 05, 2024 at 05:04:05PM -0700, Linus Torvalds wrote:
> On Mon, 5 Aug 2024 at 16:45, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > So... do we really need that indirect?  The problem would be
> > seeing ->max_fds update before that of the array pointers.
> 
> The reason is simply so that we can have one single allocation.
> 
> In fact, quite often, it's zero allocations when you can use the
> 'struct fdtable fdtab' that is embedded in 'struct files_struct'.

More to the point, we use arrays embedded into files_struct.

>But
> the 'struct fdtable' was a convenient way to allocate all those
> bitmaps _and_ the 'struct file *' array all together.

I don't think so - IIRC, it was introduced when we added RCU'd
file lookup.  Let me check...  Yep; badf16621c1f "[PATCH] files:
break up files struct", with RCU support as rationale.  Followed
by ab2af1f50050 "[PATCH] files: files struct with RCU".

Before those commits ->max_fds and ->fd used to live in
files_struct and fget() (OK, fcheck_files()) had been taking
->files_lock, so that concurrent expand_files() would not
screw us over.

The problem was not just the need to delay freeing old ->fd
array; that could be dealt with easily enough.  Think what
would've happened if fcheck_files() ended up fetching
new value of ->max_fds and old value of ->fd, which pointed
to pre-expansion array.  Indirection allowed to update
both in one store.

The thing is, ->max_fds for successive ->fdt is monotonously
increasing.  So a lockless reader seeing the old size is
fine with the new table - we just need to prevent the opposite.

Would rcu_assign_pointer of pointers + smp_store_release of max_fds on expand
(all under ->files_lock, etc.) paired with
smp_load_acquire of max_fds + rcu_dereference of ->fd on file lookup side
be enough, or do we need an explicit smp_wmb/smp_rmb in there?

> And yes, I think it's entirely a historical artifact of how that thing
> grew to be. Long long long ago there was no secondary allocation at
> all, and MAX_OPEN was fixed at 20.

Yes - but that had changed way before 2005 when those patches went in.
Separate allocation of bitmaps is 2.3.12pre7 and separate allocation of
->fd is even older - 2.1.90pre1.  NR_OPEN had been 1024 at that point;
earlier history is
	0.97: 20 -> 32
	0.98.4: 32 -> 256
	2.1.26: 256 -> 1024

