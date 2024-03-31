Return-Path: <linux-fsdevel+bounces-15803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 054D6893136
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Mar 2024 12:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE7391F21057
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Mar 2024 10:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E35177F1B;
	Sun, 31 Mar 2024 10:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWgBL+qV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A3777620;
	Sun, 31 Mar 2024 10:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711880838; cv=none; b=N5Z1ojrJ+gJwyhtuVo4RN++hBunKXxFl7NkHOX4UoAPx5Mr3CTSj8r2oF0a+a/1CPJ45S4hDJDYBL8kPkLPSIka4BwnCMQzq9upfqmbd2RPR7Th9DLW+bfAtzrhII9WES6tzGwlvfE5kIo4AJufoe9nbYZ7rP7yyIVWc9YzMmus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711880838; c=relaxed/simple;
	bh=lOXebHqDjv7+CsO26vpn2Z87+IhF/5Rp8Ms/Vf7+noY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sPf5/ZbTMf4pi6RtvKWIMpP5NUktd9VkZ91XHZ7QfoiYjMYnFKlAuvhyWwTMx9wGQybr9eKyp36h5NfF2afu/RF0ajgWgI1lY+PN8Uq//KC3KByKwwEekiDqxw6BXprHlyVK7d8njUdNslMv0+XcVQlIiFUkKQYseQjL3FdkTzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWgBL+qV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4850C433F1;
	Sun, 31 Mar 2024 10:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711880838;
	bh=lOXebHqDjv7+CsO26vpn2Z87+IhF/5Rp8Ms/Vf7+noY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cWgBL+qVQcrZeY6hz1o+C2TbEb+6Hg0Z73F8wCc1FVQbReyqTrOn52MBHUiJ+YGW8
	 fiHAKoBr9bMy6TP8GsJHgEu16UrRg4nN3KSL9d7i7OIA5rmKGyBMh5Fk7eS8wYpQdH
	 wldMkmULHBt82g5hAtstNxJ4kD2B4lLq/z4h1fIYZVZPBQ2N0rJlJ//TdyXxW+TYNg
	 aoQwbozm9kqGr55IcKOQjsA9RGvzaZNF0I366fmhV5fiv+yKHv/q+toxmuDCIlrgJV
	 4ZVEwHpwcWI2MsUqRTxV8WA/xn05bgdOyKNZ6h5XMCJwdRKU7DLqGGa7MsQKGbxWYN
	 kQT7G+HhW4bFA==
Date: Sun, 31 Mar 2024 12:26:44 +0200
From: Christian Brauner <brauner@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v5 8/9] rust: file: add `DeferredFdCloser`
Message-ID: <20240331-waran-geldregen-aa3d299c6680@brauner>
References: <20240209-alice-file-v5-0-a37886783025@google.com>
 <20240209-alice-file-v5-8-a37886783025@google.com>
 <20240320-massieren-lackschaden-9b30825babec@brauner>
 <CAH5fLgjeet1nhycCqdaKE9CSY02XW85jn302zNEjJNQaJ1czGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgjeet1nhycCqdaKE9CSY02XW85jn302zNEjJNQaJ1czGQ@mail.gmail.com>

On Thu, Mar 21, 2024 at 02:28:15PM +0100, Alice Ryhl wrote:
> On Wed, Mar 20, 2024 at 3:22 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Fri, Feb 09, 2024 at 11:18:21AM +0000, Alice Ryhl wrote:
> > >
> > > +/// Helper used for closing file descriptors in a way that is safe even if the file is currently
> > > +/// held using `fdget`.
> > > +///
> > > +/// Additional motivation can be found in commit 80cd795630d6 ("binder: fix use-after-free due to
> > > +/// ksys_close() during fdget()") and in the comments on `binder_do_fd_close`.
> > > +pub struct DeferredFdCloser {
> > > +    inner: Box<DeferredFdCloserInner>,
> > > +}
> > > +
> > > +/// SAFETY: This just holds an allocation with no real content, so there's no safety issue with
> > > +/// moving it across threads.
> > > +unsafe impl Send for DeferredFdCloser {}
> > > +unsafe impl Sync for DeferredFdCloser {}
> > > +
> > > +/// # Invariants
> > > +///
> > > +/// If the `file` pointer is non-null, then it points at a `struct file` and owns a refcount to
> > > +/// that file.
> > > +#[repr(C)]
> > > +struct DeferredFdCloserInner {
> > > +    twork: mem::MaybeUninit<bindings::callback_head>,
> > > +    file: *mut bindings::file,
> > > +}
> > > +
> > > +impl DeferredFdCloser {
> >
> > So the explicitly deferred close is due to how binder works so it's not
> > much of a general purpose interface as I don't recall having other
> > codepaths with similar problems. So this should live in the binder
> > specific rust code imo.
> 
> Hmm. Are there really no other ioctls that call ksys_close on a
> user-provided fd?

No, I don't think there are otherwise they would have the same bug that
binder had. io_uring comes closest but they have their own task work
and deferred close implementation.

> 
> As far as I can tell, this kind of deferred API is the only way for us
> to provide a fully safe Rust api for closing an fd. Directly calling
> ksys_close must unsafely assert that the fd does not have an active
> fdget call. So it makes sense to me as an API that others might want
> to use.

I'm sorry, I don't quite understand you here.

What binder is doing iirc is that it's performing an ioctl() using a fd
to /dev/binderfs/$device-node or similar. The fatal flaw is that binder
now allows that fd to be closed during that ioctl - and by accident at
that. It's effectively closing a file it's relying on to not go away.
That's the original nonsense/creativity that necessitates this whole
manual task work shenanigans binder is doing. Unless I misremember.

But that's really frowned upon generally and absolutely not encouraged
by providing a generic interface for this stuff.

Sure, we have some users in the kernel that do stuff like call
close_fd() on a file descriptor they just installed into their file
descriptor table. That's usually bad design with maybe a few valid
exceptions. One example where that's still done and should be fixed is
e.g., cachefiles in fs/cachefiles/ondemand.c. The point is that they at
least close a file descriptor that they just installed and that they
don't rely on being valid.

So really, I need more details why without this interface it would
prevent Rust from implementing safe file descriptor closing because
right now all I see is a design flaw in binder being promoted to a
generic interface. And unless there's detailed reasons for it's
existence we're not going to do it.

