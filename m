Return-Path: <linux-fsdevel+bounces-71814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39016CD4B91
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 06:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86B34300F330
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 05:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D501F301471;
	Mon, 22 Dec 2025 05:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sM3F76iy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3EAA937;
	Mon, 22 Dec 2025 05:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766381533; cv=none; b=fbw1+5RCxj9Mu/5CnT8P2A3wpiyAGo8YIzvJZV9aKiyoYhnLGVYDYyMqolrtfUHjpB+jHmN75cJWuT9eiUKG2a/9RiEcWPOfu2v0u0FjuA42on6E2sjUMPzQt2NbsLhvjmo314nxQ20/9CenBEXfpRZLWFXk3eWW4Za4HW3IHyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766381533; c=relaxed/simple;
	bh=J2JGW0mysUx28At+ZIRDQst0grD7zKOVCdW3i8E0EXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ePrWeAy28Gl3ETVfOMtkL7b+Z3MKSXQKWyVOEiZNXET7kcuexAbmL8Ol9w+4D39f+iJe0o41uBwaH1B5UfqdSBAiCSTYsC89QciTPNK7jP1BkoWpsEUremHd6McxLJr6Y2L7eWTiR4Nz21iB+6n4viH9c/H1UkMgJ2NJr7CXTHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sM3F76iy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lX8y5tr+Ej6/Fte/ET0M0ceaoM1fpFqL+guGVcSXbfw=; b=sM3F76iyTio8JB//xIvz/ZMHEM
	ZOZa3523ThrZ7l9UIeOHEaWk3Tx9703GWNeD9Lo6fjjtwWgg9iuVGDZN3POBMeSMWhAvIwIc4WQ8M
	XAwhyFcGyBwNwDP738CoKJvToMayTT3tfX9MBh29ICxHug4rdkyl8evSbU2aQP02XOTyr2umbRM2s
	OM1qG8NqEpITxZfPGCK0yaZKewZMuI8uYYBOUGlzisDCPVXXMvh49vAaP89wGsCWMu+H3loDVsFc0
	gMWRf7aoDM2j4tP3orXqAPkPMHHbX8azIiDTzXBLH7zHc8nL/R7tyguBd+CRFt7oERae2Oh5wvjp7
	6DIPJwvQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXYWM-0000000BFuo-1Fwr;
	Mon, 22 Dec 2025 05:31:50 +0000
Date: Mon, 22 Dec 2025 05:31:50 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Shaurya Rane <ssrane_b23@ee.vjti.ac.in>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Meta kernel team <kernel-team@meta.com>, bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+09b7d050e4806540153d@syzkaller.appspotmail.com,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH bpf v2] lib/buildid: use __kernel_read() for sleepable
 context
Message-ID: <aUjXxSAD2-c4Ivy1@casper.infradead.org>
References: <20251218205505.2415840-1-shakeel.butt@linux.dev>
 <aUSUe9jHnYJ577Gh@casper.infradead.org>
 <3lf3ed3xn2oaenvlqjmypuewtm6gakzbecc7kgqsadggyvdtkr@uyw4boj6igqu>
 <aUTPl35UPcjc66l3@casper.infradead.org>
 <64muytpsnwmjcnc5szbz4gfnh2owgorsfdl5zmomtykptfry4s@tuajoyqmulqc>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64muytpsnwmjcnc5szbz4gfnh2owgorsfdl5zmomtykptfry4s@tuajoyqmulqc>

On Thu, Dec 18, 2025 at 09:58:43PM -0800, Shakeel Butt wrote:
> On Fri, Dec 19, 2025 at 04:07:51AM +0000, Matthew Wilcox wrote:
> > > I am assuming that __kernel_read() can return less data than the
> > > requested. Is that assumption incorrect?
> > 
> > I think it can, but I don't think a second call will get any more data.
> > For example, it could hit EOF.  What led you to think that calling it in
> > a loop was the right approach?
> 
> I am kind of following the convention of a userspace application doing
> read() syscall i.e. repeatedly call read() until you hit an error or EOF
> in which case 0 will be returned or you successfully read the amount of
> data you want. I am handling negative error and 0 and for 0, I am
> returning -EIO as that would be unexpected end of an ELF file.

Oh, you sweet summer child.  I hope Father Christmas leaves you an
extra special present in your stocking this week!

While it would be lovely to believe that userspace does that kind of loop,
it just doesn't.  That's why mounting NFS filesystems with the "intr"
option (before I made it a no-op) was dangerous -- userspace just isn't
prepared for short reads.  I mean, we're lucky if userspace even checks
for errors, let alone does this kind of advanced "oh, we got fewer bytes
than we wanted, keep trying" scheme.

A filesystem's ->read_iter() implementation can stop short of reading
all bytes requested if:

 - We hit EIO.  No amount of asking will return more bytes, the data's
   just not there any more.
 - We hit EOF.  There's no more data to read.
 - We're unable to access the buffer.  That's only possible for user
   buffers, not kernel buffers.
 - We receive a fatal signal.  I suppose there is the tiniest chance
   that the I/O completes while we're processing the "we returned early"
   loop, but in practice, the user has asked that we die now, and even
   trying again is rude.  Just die as quickly as we can.

I can't think of any other cases.  It's just not allowed to return
short reads to userspace (other than EIO/EOF), and that drives all
the behaviour.

> Anyways the question is if __kernel_read() returns less amount of data
> than requested, should we return error instead of retrying? I looked
> couple of callers of __kernel_read() & kernel_read(). Some are erroring
> out if received data is less than requested (e.g. big_key_read()) and
> some are calling in the loop (e.g. kernel_read_file()).

kernel_read_file() is wrong.  Thanks for reporting it; I'll send a patch.

