Return-Path: <linux-fsdevel+bounces-20145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FC28CED3C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 May 2024 02:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56C0C1F21C55
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 May 2024 00:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB4C15A4;
	Sat, 25 May 2024 00:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Dkpt89zx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D292C19F;
	Sat, 25 May 2024 00:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716597214; cv=none; b=ps7M6N907qWrTmiJ1Peup0QaBb9UW+zw3sJ91qtkP6OHea552N5dh8wNjqKwydaGukBMfB6lyAB6PcHiH1nJChS1rJuVNepuPPVfdcmJAKtQC8zz5uSclI+BUg40eUhZixWR7OmXXQnQ/aGE66KpzZM3tWM0ctgwu7Ivk3kBokA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716597214; c=relaxed/simple;
	bh=SBoBqp5H2jstUoiElLxDDyOySxfQO7AJZpliHn5IBcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IvajPk/yqDHxFpz50p7tI6fCcD/uHuupIHp6WYQunT7kvPnUib2yfkRObtEsedvaF8DaWVvNWju6JoBtdVcr3I6O/7ICNlGBLO7ezJhTjjYRDlKnWm++uy8/K0DFbyFMEMFWuzjooFRqRu3dGupW4ZC+iS/rQlPRY6hVTgJkyyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Dkpt89zx; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AKFDFifpgAYcYyj7oGfSh/TUuvOwTWkGTEpq3zJ3iZM=; b=Dkpt89zx8Zgga93SOenoun+9Pm
	4VAJwctCI21cbvKL2j64Cy5//7Yc6zggrrdEIuHfLoMaNK4RPJSMGVDKFYIzc5yt5Gzz0Hey6JKG9
	lyZuYv+5G+yXpXbNbPGLHTfpztZoxthWXm/VvSUSHggUBt5BwAwsOLg9abhI6beyPNiCDOYmXx8XV
	O24lTy6VjToP+Os0MiRbSRjreeOUuPikt1NQL2eTnEpDB1G6mLcBe0+5WMpMNRZ74njC0wmWNzaf+
	l/bHJF+LApIFZsqHrMtTmE/i5FJJScZrPVvJvyMpqZdTJXbmnfnPqyjlNGsoOmNaFTPIq0YPyQCfL
	J8shMWxQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sAfLN-0067qI-0i;
	Sat, 25 May 2024 00:33:05 +0000
Date: Sat, 25 May 2024 01:33:05 +0100
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
Message-ID: <20240525003305.GV2118490@ZenIV>
References: <20240524-anhieb-bundesweit-e1b0227fd3ed@brauner>
 <20240524191714.2950286-1-aliceryhl@google.com>
 <20240524225640.GU2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524225640.GU2118490@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, May 24, 2024 at 11:56:40PM +0100, Al Viro wrote:
> > Even if you call `get_file` to get a long-term reference from something
> > you have an fdget_pos reference to, that doesn't necessarily mean that
> > you can share that long-term reference with other threads. You would
> > need to release the fdget_pos reference first. For that reason, the
> > long-term reference returned by `get_file` would still need to have the
> > `File<MaybeFdgetPos>` type.
> 
> Why would you want such a bizarre requirement?

FWIW, fdget()...fdput() form a scope.  The file reference _in_ that
struct fd is just a normal file reference, period.

You can pass it to a function as an argument, etc.  You certainly can
clone it (with get_file()).

The rules are basically "you can't spawn threads with CLONE_FILES inside
the scope and you can't remove reference in your descriptor table while
in scope".  The value in fd.file is guaranteed to stay with positive
refcount through the entire scope, just as if you had

{
	struct file *f = fget(n);

	if (!f)
		return -EBADF;

	...

	fput(f);
}

The rules for access are exactly the same - you can pass f to a function
called from the scope, you can use it while in scope, you can clone it
and store it somewhere, etc.

As far as the type system goes, fd::file is a normal counting reference.
Depending upon the descriptor table sharing it might or might not have
had to increment ->f_count, but that's not something users of the value
need to be concerned about.  It *is* a concern for fdput() in the end
of scope, but that's it.

You can't do
	fd = fdget(n);
	...
	fput(fd.file);
but then you can't call unbalanced put on a member of object and
expect that to work - if nothing else,
	fd = fdget(n);
	...
	fput(fd.file);
	foo(fd);
would be a clear bug - the thing you pass to foo() is obviously not
a normal struct fd instance.

fdget_pos()...fdput_pos() is a red herring; we could've just as well
done it as
	fd = fdget(n);
	maybe_lock(&fd);
	...
	maybe_unlock(fd);
	fdput(fd);
It's a convenience helper; again, fd.file is the usual reference, with
guaranteed positive ->f_count through the entire scope.

For the sake of completeness, here's possible maybe_lock()/maybe_unlock()
implementation:

static inline void maybe_lock(struct fd *fd)
{
	if (fd->file && file_needs_f_pos_lock(fd->file)) {
		fd->flags |= FDPUT_POS_UNLOCK;
		mutex_lock(&fd->file->f_pos_lock);
	}
}

static inline void maybe_unlock(struct fd fd)
{
	if (fd.flags & FDPUT_POS_UNLOCK)
		mutex_unlock(&fd.file->f_pos_lock);
}

That's it.  Sure, we need to pair fdput_pos() with fdget_pos(), but that's
not a matter of memory safety of any sort.  And we certainly can
pass get_file(fd.file) anywhere we want without waiting for fdput_pos()
(or maybe_unlock(), if we went that way).  You'd get a cloned reference
to file, that would stay valid until the matching fput().  Sure, that
file will have ->f_pos_lock held until fdput_pos(); what's the problem?

IDGI...  Was that the fact that current file_needs_f_pos_lock() happens
to look at ->f_count in some cases?  The reasons are completely unrelated
and we do *NOT* assume anything about state at the end of scope - that's
why we store that in fd.flags.

