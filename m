Return-Path: <linux-fsdevel+bounces-49805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF118AC2D1E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 May 2025 04:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A04BF4E6B87
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 May 2025 02:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0367189B8B;
	Sat, 24 May 2025 02:24:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from brightrain.aerifal.cx (brightrain.aerifal.cx [104.156.224.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DA039FCE
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 May 2025 02:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.156.224.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748053466; cv=none; b=IEXlr9ic94/LR096luZ6C/CoQoLgRw8cWVH0xgxZDd3pU+nwrDjF5/YID7zEGtn9qJhRD6Xi8D9PuJ1l35CwQLQQ7fI8F5Ks6DULiQ69i/77zAywbJ7RIrwiKQd0W28yEBGTu3TXjoUnM18fLg638obl4laWhe51gi0MnJkq5n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748053466; c=relaxed/simple;
	bh=tXnoiaeURECG01yzcz0sFQiU92UZEA1UhkMDrWSOXso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=baKViNdavUnXjcJgU7bG58TsJP1PDkJGoDqj+6wC5sSuFj+294xeFiuJtYgAscXB4Ez1r4w0ibyklHTAx6hBPTxEqYFnJpkNX0ozK0lYeNDddLJKiX/JgGoZ3AUj/98ueGI3kTOvDaKkoqI4lqKhUFtI85TOKtLS5B1TRpRt3Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org; spf=pass smtp.mailfrom=aerifal.cx; arc=none smtp.client-ip=104.156.224.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aerifal.cx
Date: Fri, 23 May 2025 22:24:16 -0400
From: Rich Felker <dalias@libc.org>
To: Zack Weinberg <zack@owlfolio.org>
Cc: Alejandro Colomar <alx@kernel.org>,
	Vincent Lefevre <vincent@vinc17.net>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
	GNU libc development <libc-alpha@sourceware.org>
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from
 POSIX.1-2024
Message-ID: <20250524022416.GB6263@brightrain.aerifal.cx>
References: <a5tirrssh3t66q4vpwpgmxgxaumhqukw5nyxd4x6bevh7mtuvy@wtwdsb4oloh4>
 <efaffc5a404cf104f225c26dbc96e0001cede8f9.1747399542.git.alx@kernel.org>
 <20250516130547.GV1509@brightrain.aerifal.cx>
 <20250516143957.GB5388@qaa.vinc17.org>
 <20250517133251.GY1509@brightrain.aerifal.cx>
 <5jm7pblkwkhh4frqjptrw4ll4nwncn22ep2v7sli6kz5wxg5ik@pbnj6wfv66af>
 <8c47e10a-be82-4d5b-a45e-2526f6e95123@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c47e10a-be82-4d5b-a45e-2526f6e95123@app.fastmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)

On Fri, May 23, 2025 at 02:10:57PM -0400, Zack Weinberg wrote:
> Taking everything said in this thread into account, I have attempted to
> wordsmith new language for the close(2) manpage.  Please let me know
> what you think, and please help me with the bits marked in square
> brackets. I can make this into a proper patch for the manpages
> when everyone is happy with it.
> 
> zw
> 
> ---
> 
> DESCRIPTION
>     ... existing text ...
> 
>     close() always succeeds.  That is, after it returns, _fd_ has
>     always been disconnected from the open file it formerly referred
>     to, and its number can be recycled to refer to some other file.
>     Furthermore, if _fd_ was the last reference to the underlying
>     open file description, the resources associated with the open file
>     description will always have been scheduled to be released.
> 
>     However, close may report _delayed errors_ from a previous I/O
>     operation.  Therefore, its return value should not be ignored.
> 
> RETURN VALUE
>     close() returns zero if there are no delayed errors to report,
>     or -1 if there _might_ be delayed errors.
> 
>     When close() returns -1, check _errno_ to see what the situation
>     actually is.  Most, but not all, _errno_ codes indicate a delayed
>     I/O error that should be reported to the user.  See ERRORS and
>     NOTES for more detail.
> 
>     [QUERY: Is it ever possible to get delayed errors on close() from
>     a file that was opened with O_RDONLY?  What about a file that was
>     opened with O_RDWR but never actually written to?  If people only
>     have to worry about delayed errors if the file was actually
>     written to, we should say so at this point.
> 
>     It would also be good to mention whether it is possible to get a
>     delayed error on close() even if a previous call to fsync() or
>     fdatasync() succeeded and there haven’t been any more writes to
>     that file *description* (not necessarily via the fd being closed)
>     since.]
> 
> ERRORS
>     EBADF  _fd_ wasn’t open in the first place, or is outside the
>            valid numeric range for file descriptors.
> 
>     EINPROGRESS
>     EINTR
>            There are no delayed errors to report, but the kernel is
>            still doing some clean-up work in the background.  This
>            situation should be treated the same as if close() had
>            returned zero.  Do not retry the close(), and do not report
>            an error to the user.

Since this behavior for EINTR is non-conforming (and even prior to the
POSIX 2024 update, it was contrary to the general semantics for EINTR,
that no non-ignoreable side-effects have taken place), it should be
noted that it's Linux/glibc-specific.

>     EDQUOT
>     EFBIG
>     EIO
>     ENOSPC
>            These are the most common errno codes associated with
>            delayed I/O errors.  They should be treated as a hard
>            failure to write to the file that was formerly associated
>            with _fd_, the same as if an earlier write(2) had failed
>            with one of these codes.  The file has still been closed!
>            Do not retry the close().  But do report an error to the user.
> 
>     Depending on the underlying file, close() may return other errno
>     codes; these should generally also be treated as delayed I/O errors.
> 
> NOTES
>   Dealing with error returns from close()
> 
>     As discussed above, close() always closes the file.  Except when
>     errno is set to EBADF, EINPROGRESS, or EINTR, an error return from
>     close() reports a _delayed I/O error_ from a previous write()
>     operation.
> 
>     It is vital to report delayed I/O errors to the user; failing to
>     check the return value of close() can cause _silent_ loss of data.
>     The most common situations where this actually happens involve
>     networked filesystems, where, in the name of throughput, write()
>     often returns success before the server has actually confirmed a
>     successful write.
> 
>     However, it is also vital to understand that _no matter what_
>     close() returns, and _no matter what_ it sets errno to, when it
>     returns, _the file descriptor passed to close() has been closed_,
>     and its number is _immediately_ available for reuse by open(2),
>     dup(2), etc.  Therefore, one should never retry a close(), not
>     even if it set errno to a value that normally indicates the
>     operation needs to be retried (e.g. EINTR).  Retrying a close()
>     is a serious bug, particularly in a multithreaded program; if
>     the file descriptor number has already been reused, _that file_
>     will get closed out from under whatever other thread opened it.
> 
>     [Possibly something about fsync/fdatasync here?]

While I agree with all of this, I think the tone is way too
proscriptive. The man pages are to document the behaviors, not tell
people how to program. And again, it should be noted that the standard
behavior is that you *do* have to retry on EINTR, or arrange to ensure
it never happens (e.g. by not installing interrupting signal handlers,
or blocking signals across calls to close), and that treating EINTR as
"fd has been closed" is something you should only do on
known-nonconforming systems.

Aside: the reason EINTR *has to* be specified this way is that pthread
cancellation is aligned with EINTR. If EINTR were defined to have
closed the fd, then acting on cancellation during close would also
have closed the fd, but the cancellation handler would have no way to
distinguish this, leading to a situation where you're forced to either
leak fds or introduce a double-close vuln.

> BUGS
>     Prior to POSIX.1-2024, there was no official guarantee that
>     close() would always close the file descriptor, even on error.
>     Linux has always closed the file descriptor, even on error,
>     but other implementations might not have.
> 
>     The only such implementation we have heard of is HP-UX; at least
>     some versions of HP-UX’s man page for close() said it should be
>     retried if it returned -1 with errno set to EINTR.  (If you know
>     exactly which versions of HP-UX are affected, or of any other
>     Unix where close() doesn’t always close the file descriptor,
>     please contact us about it.)
> 
>     Portable code should nonetheless never retry a failed close(); the
>     consequences of a file descriptor leak are far less dangerous than
>     the consequences of closing a file out from under another thread.

This is explicitly the opposite of what's specified for portable code.

It sounds like you are intentionally omitting that POSIX says the
opposite of what you want it to, and treating the standard behavior as
a historical HP-UX quirk/bug. This is polemic, not the sort of
documentation that belongs in a man page.

An outline of what I'd like to see instead:

- Clear explanation of why double-close is a serious bug that must
  always be avoided. (I think we all agree on this.)

- Statement that the historical Linux/glibc behavior and current POSIX
  requirement differ, without language that tries to paint the POSIX
  behavior as a HP-UX bug/quirk. Possibly citing real sources/history
  of the issue (Austin Group tracker items 529, 614; maybe others).

- Consequence of just assuming the Linux behavior (fd leaks on
  conforming systems).

- Consequences of assuming the POSIX behavior (double-close vulns on
  GNU/Linux, maybe others).

- Survey of methods for avoiding the problem (ways to preclude EINTR,
  possibly ways to infer behavior, etc).


Rich

