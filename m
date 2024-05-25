Return-Path: <linux-fsdevel+bounces-20156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 162EB8CEFDD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 May 2024 17:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74F64B20F7D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 May 2024 15:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5B084D30;
	Sat, 25 May 2024 15:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="cpNihL3C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE6E29CE5;
	Sat, 25 May 2024 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716651653; cv=none; b=W59pFleZvNIRSjiFQUHlrU2TXrbJXFGH3Rwn/9Gvx7a/aLGeQuFvy86GC+U+V5RAMSURMDcr+vHBEhMIijcT3J9KfPGLVMPGpCPenlK1T/BzxeqQx7AN9CrYhpAHnTWjKwoTf6ZmVCz8MiIx4eYBFcUQTwXSLQ40ojTjsL7iX5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716651653; c=relaxed/simple;
	bh=nsMlYfrbACr4A+ifWYV1NJR6P+PBisHXcccRZav55lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zse0xXzNCXJ/I3D/6hyEizgtK0yMTzybEsj5VGCrBjGVpRlQzUP7QUPaFqKD9jGeC137pXrhS8t/x1ZPLHdCUb4QLG2MGHioxkaD/r3V0uIDTPUD6iSyJRoEGKTSyq2gDrGk//MkoAls3yRm01VMTKtiEbY5pDnk+XechZmZ8CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=cpNihL3C; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dNqXp/hhyPdCaPUnPmAwqKc/MFxMVyqfvLBtHgPIDRY=; b=cpNihL3CbSDMFHIuby+bAR0aRu
	K/gqLEIg3HgQ46NLOXM4zVdHTkovLsG/UAlkE+TIGDzCt5l6M2lDzzaMPba+kIIS+ThmRmnsrfcvo
	nYq9gyZrE87vvGYL8WO0BWZCwoOmch2U3df6gSNuCF6pTifr0vkUEJrc7Cm3ag71qzObNYMcZz6ZM
	qGJFeEGTcOQCkEl40yB3CsyBMShs6UB+ecDKxax3pM7r6e2nMqeP5Kt6bcvcg7iCs+Df+UE2m9Iwx
	fQ35wVYhr9nwQhVFKHMggNlZemQpPtyW979vmPhP0WC9KtGTJDtGRfKf6OGQZsq+hzBKkT/Ddc2tH
	GxMY5ZXg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sAtVM-007YFB-1K;
	Sat, 25 May 2024 15:40:20 +0000
Date: Sat, 25 May 2024 16:40:20 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Alice Ryhl <aliceryhl@google.com>
Cc: brauner@kernel.org, a.hindborg@samsung.com, alex.gaynor@gmail.com,
	arve@android.com, benno.lossin@proton.me, bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com, cmllamas@google.com, dan.j.williams@intel.com,
	dxu@dxuuu.xyz, gary@garyguo.net, gregkh@linuxfoundation.org,
	joel@joelfernandes.org, keescook@chromium.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	maco@android.com, ojeda@kernel.org, peterz@infradead.org,
	rust-for-linux@vger.kernel.org, surenb@google.com,
	tglx@linutronix.de, tkjos@android.com, tmgross@umich.edu,
	wedsonaf@gmail.com, willy@infradead.org, yakoyoku@gmail.com
Subject: Re: [PATCH v6 3/8] rust: file: add Rust abstraction for `struct file`
Message-ID: <20240525154020.GW2118490@ZenIV>
References: <20240524-anhieb-bundesweit-e1b0227fd3ed@brauner>
 <20240524191714.2950286-1-aliceryhl@google.com>
 <20240524225640.GU2118490@ZenIV>
 <20240525003305.GV2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240525003305.GV2118490@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, May 25, 2024 at 01:33:05AM +0100, Al Viro wrote:

> FWIW, fdget()...fdput() form a scope.  The file reference _in_ that
> struct fd is just a normal file reference, period.
> 
> You can pass it to a function as an argument, etc.  You certainly can
> clone it (with get_file()).
> 
> The rules are basically "you can't spawn threads with CLONE_FILES inside
> the scope and you can't remove reference in your descriptor table while
> in scope".  The value in fd.file is guaranteed to stay with positive
> refcount through the entire scope, just as if you had
> 
> {
> 	struct file *f = fget(n);
> 
> 	if (!f)
> 		return -EBADF;
> 
> 	...
> 
> 	fput(f);
> }
> 
> The rules for access are exactly the same - you can pass f to a function
> called from the scope, you can use it while in scope, you can clone it
> and store it somewhere, etc.

If anything, fd = fdget(N) is "clone or borrow the file reference from the
Nth slot of your descriptor table into fd.file and record whether it had
been cloned or borrowed into fd.flags".

The rules for what can't be done in the scope of fd are there to guarantee
that the reference _can_ be borrowed in the common case when descriptor table
is not shared.

The tricks with calling conventions of __fdget() (it returns both the
reference and flags in single unsigned long, with flags in the lowest
bits) are implementation details; those should stay hidden from anyone
who uses struct fd.

Incidentally, there's no "light refcount" - "light references" are simply
the ones that had been borrowed from the descriptor table rather than
having them cloned.

One more thing: we never get fd.file == NULL && fd.flags != 0 - that
combination is never generated (NULL couldn't have been cloned).
As the result, if fd.file is NULL, fdput(fd) is a no-op.  Most of the
places where we use struct fd are making use of that -
	fd = fdget(n);
	if (fd.file) {
		do something
		fdput(fd);
	}
is equivalent to
	fd = fdget(n);
	if (fd.file)
		do something
	fdput(fd);
and the former is more common way to spell it.  In particular,
	fd = fdget(n);
	if (!fd.file)
		return -EBADF;
	error = do_something(fd.file);
	fdput(fd);
is often convenient and very common.  We could go for
	CLASS(fd, fd)(n);
	if (!fd.file)
		return -EBADF;
	return do_something(fd.file);
and let the compiler add fdput(fd) whenever it goes out of scope,
but that gets clumsy - we'd end up with a plenty of declarations
in the middle of blocks that way, and for C that looks wrong.

There are very few places where struct fd does not come from
fdget()/fdget_raw()/fdget_pos().  One variety is "initialize
it to NULL,0, then possibly replace with fdget() result;
unconditional fdput() will be safe either way" (a couple of places).
Another is overlayfs ovl_real_fdget() and ovl_real_fdget_meta().
Those two are arguably too clever for their readers' good.
It's still "borrow or clone, and remember which one had it been",
but that's mixed with returning errors:
	err = ovl_read_fdget(file, &fd);
may construct and store a junk value in fd if err is non-zero.
Not a bug, but only because all callers remember to ignore that
value in such case.
Another inconvenient bit is this:
static int vmsplice_type(struct fd f, int *type)
{
        if (!f.file)
                return -EBADF;
        if (f.file->f_mode & FMODE_WRITE) {
                *type = ITER_SOURCE;
        } else if (f.file->f_mode & FMODE_READ) {
                *type = ITER_DEST;
        } else {
                fdput(f);
                return -EBADF;
        }
        return 0;
}
It's a move if an error had been returned and borrow otherwise.
There's a couple of other examples of the same sort.
It might be better to lift fdput() into the callers (or, in this
case, just fold the entire sucker into its sole caller).

Finally, there's a non-obvious thing in net/socket.c -
sockfd_lookup_light()..fput_light().  What happens is that
if sock_from_file(f) is non-NULL, we are guaranteed that
sock_from_file(f)->file == f (and that reference does not
contribute to refcount of f).  So we do the same clone-or-borrow
thing, but we only keep the socket for the rest of operation;
when it comes to undoing the clone-or-borrow, we do that manually
and use sock->file to reconstruct the file pointer.
It's still an equivalent of fdget()/fdput() pair, but it slightly
reduces a register pressure in some very hot paths; hell knows
if it's warranted these days.  Avoiding an unconditional clone
in there is a really important part, but not keeping the struct
file reference in a local variable through the syscall...
probably not so much.  It is very localized - nothing of that
sort is done outside of net/socket.c (we probably ought to
move fput_light() over there - no other users).

That's about it as far as struct fd is concerned...

