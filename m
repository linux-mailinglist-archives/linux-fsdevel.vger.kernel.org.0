Return-Path: <linux-fsdevel+bounces-20599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C138D58F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 05:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28EB4282D03
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 03:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BC078286;
	Fri, 31 May 2024 03:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="noastvRp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB4777F08
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 May 2024 03:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717125488; cv=none; b=jSTdfnaRls1tuhnfJkfnVeyceAEL5fz2/zKB80DpZW17f/hbZmd7TVf7bMyV+95f41/u7tZp5xISU6LOIdJvFi8fFVj/Dz7EYDSYsL8ra8LN/lCGz5cKnOGpK2FelGd6qbvE7I5gWiOtz6dOzV8EdYqmx4YIdDEo8lnmblTPY+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717125488; c=relaxed/simple;
	bh=12Wh4CN9IyGrP6vXAGI1xZ385wWRKk7z/rbDPpQefJo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XJixT5y+naJtWvYvHboFy+qp75pgmjcQRNXn3y9wbhA0r9lAnm4U12YtVABlvD3J2fF4x0mgXtf3dB5oOdJsmBbp9taeJzvfj8H+XfCyfUUMpl4sQ4HzXqYYK26DR94hHbkOcwc4I2Oartw1zbdm6MskVbE0eh0yOSWwIRUwPvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=noastvRp; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=RH5yXj3mT6NhivtPSruU2ADmTNRHtkWSb+lzvCMQ1Ko=; b=noastvRpzAGb/PwRNDwoPDpKtJ
	sPhiEfM7rcnB42qzGhVvinwdwoMtGAui9YA5Ztx+YUWnh+eB17k5wt1jJSFFBqR2bm9V2O6s2izbL
	RVQq8QIylbgY3/m9mXem8Ja9+47ai9qIw1DanS/3ReIKNNLKrp1JPMaF3hMO/MGRrkEIV5X9CrPG/
	l/ndVCnOjKJLFQ0mcTKuC3CIFaZ7By7033pJBaqFQlDW1OMomNc50cF9o2CxjmAs4Z/yiHOxQnsYA
	VyaViKnw3o9oZzNhEuo0DSRAB4IYljqgJGxKtuMeTZR4EY43fPavgvcIxB0eDp67OqTnrVMRFYDGI
	AAwBVKmQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sCsmI-007XCf-25;
	Fri, 31 May 2024 03:18:02 +0000
Date: Fri, 31 May 2024 04:18:02 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [RFC] struct fd situation
Message-ID: <20240531031802.GA1629371@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	I've done another round of review of users.

1)  There are two leaks I'd missed earlier; missing fdput() on a failure
exit in arch/powerpc/kvm/powerpc.c and in drivers/media/rc/lirc_dev.c.
	I'll throw fixes into #fixes and send a pull request; that
part is obvious.

2)  Almost all values come from fdget(), fdget_raw() or fdget_pos().
Exceptions: several places that initialize to empty and a couple
of overlayfs functions that construct the sucker manually.  The latter
can bloody well generate bogus values on error.  fdget_pos() pairs
with fdput_pos(), everything else pairs with fdput().

3)  fdput(empty) should be a no-op; we have enough places relying upon
that and it makes sense in general.  Currently it is true, but compiler
has no way to figure that out.

4)  emptiness check is done by absolute majority of users as the
first thing after initialization.  The way it is implemented is
"check if fd.file is NULL"; currently we almost always skip fdput()
if that condition holds.  There are exceptions where we have fdput()
called (kernel_read_file_from_fd(), ksys_sync_file_range(),
do_utimes_fd(), ksys_readahead(), f_dupfd_query(), snd_pcm_link(),
xfs_find_handle(), finit_module(2)) regardless of emptiness.
That may result in excessive check (we look at FDPUT_FPUT in fd.flags,
which is never going to be set when fd.file is NULL).

Said that, there's a worse (still minor) problem with code generation -
most of the places checking for emptiness do not bother with
unlikely().  IMO that's a convincing argument in favour of explicit
fd_empty() or whatever we end up calling it.

5)  the most common (by far) pattern is
	f = fdget(n);
	if (!f.file)
		bugger off
	stuff using f.file
	fdput(f);
_usually_ the failure happens with -EBADF, but there's a weirdness galore
there - EINVAL, ENOENT, ENXIO, EBADFD (almost certainly misspelled EBADF),
etc.

There are several groups of unusual cases:
	* as mentioned above, some do fdput() on all exits, including the
"fd is empty" one.  Otherwise identical to the common variant.
	* two CLASS(fd{,_raw}) users.  Equivalent to the above.
	* a few places where we have struct fd initialized empty (NULL, 0),
with fdget() done in some cases, followed by unconditional fdput().
	* ipc/mqueue.c:do_mq_notify(); struct fd reused - fdget() after
fdput().  Usual otherwise.
	* net/socket.c; sockfd_lookup_light().  What happens there is
that struct fd instance is created in frame of sockfd_lookup_light(),
dropped if file is not a socket, then socket and fd.flags gets passed
to caller, with fput_light(sock->file, need_fput) done on subsequent
exits in caller.  Minimal patch would be to lift the struct fd into
the caller, along with dropping it on non-sockets and replace fput_light()
calls with fdput().  That would convert them to usual pattern; I don't
believe that it would make things any slower than they are now.
	* fs/splice.c:vmsplice_type().  One caller, called after fdget()
without a prior emptiness check, consumes struct fd on failure.  IMO
the call of fdput() ought to be lifted into the caller; perhaps the
entire thing should be expanded there.
	* fs/timerfd.c: timerfd_fget(): fdget() + check that it has the
right ->f_op then fdput() or move to caller's struct fd (passed by
reference).  Caller's instance is left uninitialized on error.  Only
two callers.  My preference would be to expand both, TBH - then
it would be the usual pattern.
	* kernel/events/core.c:perf_fget_light().  Similar to timerfd
case.
	* BPF: messy.  __bpf_map_get(f) is called right after fdget(),
without an emptiness check.  Verifies that fd is not empty, that
file is ours (fdput() if not), then returns file->private_data.
Note that proof of correctness requires showing that ->private_data is
never ERR_PTR() for those - otherwise the callers would leak.
IMO fdput() ought to be lifted into the callers, probably along with
the emptiness check.  All subsequent exits in the callers are
calling fdput() anyway... ____bpf_prog_get() is similar, but has
only one caller; I'd simply expand it.
	* overlayfs.  ovl_real_fdget() has rather unpleasant calling
conventions; it gets struct fd *real and returns an int; it builds
struct fd in *real and return 0 or -E...; the value left in *real
may be invalid unless 0 has been returned.  And it's not just left
uninitialized - bogus values are explicitly stored there.
ovl_real_fdget_meta() is similar.  Callers use it to initialize
their struct fd instance and return immediately if an error has
been returned.  All subsequent exits call fdput().

	That's it.

6)  The things clean up considerably if we use CLASS(fd{,_raw}) on
those suckers.  I've done mockup patches for that, and the end
result is a lot nicer than what we have right now.  The main issue
with doing such conversions is that failure exit on emptiness
grows an out-of-line check for FDPUT_FPUT and (never taken) call
of fput().  OTOH, the win from having that failure exit moved out
of line offsets that and it _is_ a slow path.

7)  Avoiding that stuff on EBADF exits is interesting.

It is possible to do without changing struct fd representation, but it's
somewhat iffy.  IME the following bit of ugliness
static always_inline void fdput(struct fd f)
{
	if (f.flags & FDPUT_FPUT && f.file)
		fput(f.file);
}

is enough for good code generation - I don's see any needless checks for
f.file in the resulting assembler, at least not with gcc 12 builds on x86.

gcc does manage to keep track of having seen a local struct member
NULL or non-NULL.

Alternative would be to turn struct fd into a struct-wrapped unsigned long
and either use a flag for emptiness checks (we can steal more from the
pointer) or just compare with zero for empitness check.

The former might allow to represent specific errors, which would give a neat
solution for ovl_real_fd() calling conventions - instead of "return an error,
fill user-supplied struct fd" it could just return an error-representing
struct fd and be done with that.

Unfortunately, gcc optimizer really stinks when it comes to bitops -
it can keep track of 'this field of struct has been found non-NULL'
easily, but 'this bit had been found set' is lost very easily.
So clever encodings are going to be brittle as far as code generation
is concerned.

	One lovely example (already posted in one of the old threads)
is this:
	if (v & 1)
		if (!(v & 1) && !(v & 2))
			foo();
is not recognized as a no-op.  Reason: gcc figures out that condition
in second if can be rewritten as !(v & 3) and after it does that
rewrite it can't figure out that if bit 0 is set, we can't have
both bit 0 and bit 1 clear.  clang manages that, gcc 12 does not.
It is possible to work around -
	if (v & 1)
		if (!(v & 1)) if (!(v & 2))
			foo();
is recognized to be a no-op.  But that kind of crap is too brittle -
minor changes in optimizer can screw it over.

That example is very close to what we'd need if fd_empty() turned
into checking a flag.  So unless somebody has a clever scheme that
would avoid that kind of fun, this is probably no-go.

If we give up on representing errors, we can use 0 for empty.
That means the following sequence of patches:
	* introduce fd_empty() and fd_file().
	* convert f.file accesses into fd_empty(f) (in boolean
contexts) and fd_file(f) (everything else).  That would have
to be done as a series of commits - doing a single-commit variant
would guarantee fuckloads of conflicts through the cycle, all
with the same commit.  And it's not entirely mechanical either.
	* switch representation.
	* follow with CLASS(fd, f) series of cleanups.
Doable, but it would be a long series.

Alternative would be to do the minimal fdput() modification (as above)
plus definitions of fd_empty() and fd_file(), followed by combinations
of "switch to fd_file/fd_empty, use CLASS(fd) where it makes sense" patches
from the first variant and finally switch the representation.  The series
is obviously shorter that way...

Comments?

