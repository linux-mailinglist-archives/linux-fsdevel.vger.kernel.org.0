Return-Path: <linux-fsdevel+bounces-20129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5388CEA3A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 21:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 381D6281D59
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 19:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AFB4084D;
	Fri, 24 May 2024 19:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bzoAE1ea"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612631E4AB
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 May 2024 19:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716578240; cv=none; b=Hyanv9VaaJ98VZAqmeZHI3XGUS6eCoj1s8kYo2T8rbWFfHw/7616ZWkFH9s2F87hzmwxM9upxtmPMO74q/CUue5v1dnDy/ym1ZVsNWWwSMyP5UjCHHv6f5e1VKYKVTvWZaTK00Nabiu1Ywg08ut/J4TfyDU6H/DQDHPkpE8zSHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716578240; c=relaxed/simple;
	bh=LvStvlUD3FEleo26U6AeZb2J9g+eQFpOb4x03axt8hY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mYVk3QscePmrkv/mcUm9M3sq85Zptt/mEZcyN+/WPw07OZDgXPAZ6+FhztuDL4q+AL3YkREt0wI4Ypvzhw1B6GX3hipQUeQ9ie0EcHvGrSGGuR/tYKdMtA+Sbdh2ESmjCglNhjLx26lr23Q0eiy3mjXSjOMYjxHdLh3cjVUTkHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bzoAE1ea; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-df7721f2e70so911649276.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 May 2024 12:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716578237; x=1717183037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zPX62fogG5NxdE2+Y2K0WEbL+Aj3r8wEBw8X4GGHQTk=;
        b=bzoAE1ea/XHn3vkpbSoiFKDnx6m05QufPe+u/qnd3oiUqMQiMvtiKV5Ebkz8823hGD
         3jewZWYLBdMMX0SBeCOo6OSS9VBVCYLrRRUR/erzGUkReGKOZrYMND9fQpHYB7DShEWL
         8/M3iOOZhA8SBEr8dlb+IJ0AtOeOHxvDCvU+B/NtqyIyGQnMAa3ym1UjnoIzqSLmF/Dl
         GUQAELYASP/88AYzMP8VU/Hy8/qQYioG5bU37ODwygY0NGyuwTqGMieI1FzFMLSf2d8R
         KWWvzZ0sE8ZWhuxpXP3+F9chm7ZGU5Wgryyr3gxZ/4sxc7A5O6+VweJPeZqUN+ybFKNr
         sWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716578237; x=1717183037;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zPX62fogG5NxdE2+Y2K0WEbL+Aj3r8wEBw8X4GGHQTk=;
        b=gi1/9gI/J1SzQaknhwva/TYr6b633VzUnWr8lUPWqKTtQCeAeVflPqVehYyjDW2J7q
         19VduVa1duSdCWmuMaG1JnHmECDoVbPQsOOeutDXcF63m0TVMsucfQIZhEI7cwUbFqPR
         +BVavaN0KLoTV++KuVqC/fEI4PqAqclNA4ATPWwaFFoeU6cxyYEdXFp/YJqXPHrnoBg2
         2iurWfRYlzv/O34baBJFlTPugB2Qaq7hxK1+pMQDp0seyoy+D5tpbusKc3mG068Tcif7
         ruvr52lA+lx52gPPOZ9aRmkthQfxlK9IUS1Zfb44cCtzsDNwRlGNrBrZL57lwLDiEC6f
         eXag==
X-Forwarded-Encrypted: i=1; AJvYcCUuSk/oGZDSeng34h/WYJQ6AKNRuUi3zKbjUgecRip5KBUMKG5/H4gCR6YmLTqJdFJH+GrLxQ9RwjCZjr6fY1RsdgNthIy34DLQ4cGV3w==
X-Gm-Message-State: AOJu0Yx8D+Bo0z5T6PNKt3Dd6//Jd3E4QN97QOjp6q96ehsye+v1pg1p
	k/EO1lqsSNmDXYoX/2amUA+J7qd7+6EQG72VgYtTXPdWl6xfVbg2YWLcv7CyeW0rN98zHEc1fHx
	Z0gSYWYEJW30ruw==
X-Google-Smtp-Source: AGHT+IGZR5AY3XRY53m283409ObAnpZkyDMfKCviRS5GQoOLh1QOGKeod7hkSpUgVyNTigvLQJanb0uuETXbGbg=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:154b:b0:dda:c4ec:7db5 with SMTP
 id 3f1490d57ef6-df770e1555dmr909499276.4.1716578237460; Fri, 24 May 2024
 12:17:17 -0700 (PDT)
Date: Fri, 24 May 2024 19:17:13 +0000
In-Reply-To: <20240524-anhieb-bundesweit-e1b0227fd3ed@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240524-anhieb-bundesweit-e1b0227fd3ed@brauner>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240524191714.2950286-1-aliceryhl@google.com>
Subject: Re: [PATCH v6 3/8] rust: file: add Rust abstraction for `struct file`
From: Alice Ryhl <aliceryhl@google.com>
To: brauner@kernel.org
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, aliceryhl@google.com, 
	arve@android.com, benno.lossin@proton.me, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, cmllamas@google.com, dan.j.williams@intel.com, 
	dxu@dxuuu.xyz, gary@garyguo.net, gregkh@linuxfoundation.org, 
	joel@joelfernandes.org, keescook@chromium.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, maco@android.com, ojeda@kernel.org, 
	peterz@infradead.org, rust-for-linux@vger.kernel.org, surenb@google.com, 
	tglx@linutronix.de, tkjos@android.com, tmgross@umich.edu, 
	viro@zeniv.linux.org.uk, wedsonaf@gmail.com, willy@infradead.org, 
	yakoyoku@gmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 6:12=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Fri, May 17, 2024 at 09:30:36AM +0000, Alice Ryhl wrote:
> > From: Wedson Almeida Filho <wedsonaf@gmail.com>
> >
> > This abstraction makes it possible to manipulate the open files for a
> > process. The new `File` struct wraps the C `struct file`. When accessin=
g
> > it using the smart pointer `ARef<File>`, the pointer will own a
> > reference count to the file. When accessing it as `&File`, then the
> > reference does not own a refcount, but the borrow checker will ensure
> > that the reference count does not hit zero while the `&File` is live.
> >
> > Since this is intended to manipulate the open files of a process, we
> > introduce an `fget` constructor that corresponds to the C `fget`
> > method. In future patches, it will become possible to create a new fd i=
n
> > a process and bind it to a `File`. Rust Binder will use these to send
> > fds from one process to another.
> >
> > We also provide a method for accessing the file's flags. Rust Binder
> > will use this to access the flags of the Binder fd to check whether the
> > non-blocking flag is set, which affects what the Binder ioctl does.
> >
> > This introduces a struct for the EBADF error type, rather than just
> > using the Error type directly. This has two advantages:
> > * `File::fget` returns a `Result<ARef<File>, BadFdError>`, which the
> > =C2=A0 compiler will represent as a single pointer, with null being an =
error.
> > =C2=A0 This is possible because the compiler understands that `BadFdErr=
or`
> > =C2=A0 has only one possible value, and it also understands that the
> > =C2=A0 `ARef<File>` smart pointer is guaranteed non-null.
> > * Additionally, we promise to users of the method that the method can
> > =C2=A0 only fail with EBADF, which means that they can rely on this pro=
mise
> > =C2=A0 without having to inspect its implementation.
> > That said, there are also two disadvantages:
> > * Defining additional error types involves boilerplate.
> > * The question mark operator will only utilize the `From` trait once,
> > =C2=A0 which prevents you from using the question mark operator on
> > =C2=A0 `BadFdError` in methods that return some third error type that t=
he
> > =C2=A0 kernel `Error` is convertible into. (However, it works fine in m=
ethods
> > =C2=A0 that return `Error`.)
> >
> > Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > Co-developed-by: Daniel Xu <dxu@dxuuu.xyz>
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> > Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> > Reviewed-by: Trevor Gross <tmgross@umich.edu>
> > Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> > =C2=A0fs/file.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 7 +
> > =C2=A0rust/bindings/bindings_helper.h | =C2=A0 2 +
> > =C2=A0rust/helpers.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| =C2=A0 7 +
> > =C2=A0rust/kernel/file.rs =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 3=
30 ++++++++++++++++++++++++++++++++++++++++
> > =C2=A0rust/kernel/lib.rs =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| =C2=A0 1 +
> > =C2=A0rust/kernel/types.rs =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
=C2=A0 8 +
> > =C2=A06 files changed, 355 insertions(+)
> >
> > diff --git a/fs/file.c b/fs/file.c
> > index 3b683b9101d8..f2eab5fcb87f 100644
> > --- a/fs/file.c
> > +++ b/fs/file.c
> > @@ -1127,6 +1127,13 @@ EXPORT_SYMBOL(task_lookup_next_fdget_rcu);
> > =C2=A0 *
> > =C2=A0 * The fput_needed flag returned by fget_light should be passed t=
o the
> > =C2=A0 * corresponding fput_light.
> > + *
> > + * (As an exception to rule 2, you can call filp_close between fget_li=
ght and
> > + * fput_light provided that you capture a real refcount with get_file =
before
> > + * the call to filp_close, and ensure that this real refcount is fput =
*after*
> > + * the fput_light call.)
> > + *
> > + * See also the documentation in rust/kernel/file.rs.
> > =C2=A0 */
> > =C2=A0static unsigned long __fget_light(unsigned int fd, fmode_t mask)
> > =C2=A0{
> > diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_h=
elper.h
> > index ddb5644d4fd9..541afef7ddc4 100644
> > --- a/rust/bindings/bindings_helper.h
> > +++ b/rust/bindings/bindings_helper.h
> > @@ -9,6 +9,8 @@
> > =C2=A0#include <kunit/test.h>
> > =C2=A0#include <linux/errname.h>
> > =C2=A0#include <linux/ethtool.h>
> > +#include <linux/file.h>
> > +#include <linux/fs.h>
> > =C2=A0#include <linux/jiffies.h>
> > =C2=A0#include <linux/mdio.h>
> > =C2=A0#include <linux/phy.h>
> > diff --git a/rust/helpers.c b/rust/helpers.c
> > index 4c8b7b92a4f4..5545a00560d1 100644
> > --- a/rust/helpers.c
> > +++ b/rust/helpers.c
> > @@ -25,6 +25,7 @@
> > =C2=A0#include <linux/build_bug.h>
> > =C2=A0#include <linux/err.h>
> > =C2=A0#include <linux/errname.h>
> > +#include <linux/fs.h>
> > =C2=A0#include <linux/mutex.h>
> > =C2=A0#include <linux/refcount.h>
> > =C2=A0#include <linux/sched/signal.h>
> > @@ -157,6 +158,12 @@ void rust_helper_init_work_with_key(struct work_st=
ruct *work, work_func_t func,
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL_GPL(rust_helper_init_work_with_key);
> >
> > +struct file *rust_helper_get_file(struct file *f)
> > +{
> > + =C2=A0 =C2=A0 return get_file(f);
> > +}
> > +EXPORT_SYMBOL_GPL(rust_helper_get_file);
> > +
> > =C2=A0/*
> > =C2=A0 * `bindgen` binds the C `size_t` type as the Rust `usize` type, =
so we can
> > =C2=A0 * use it in contexts where Rust expects a `usize` like slice (ar=
ray) indices.
> > diff --git a/rust/kernel/file.rs b/rust/kernel/file.rs
> > new file mode 100644
> > index 000000000000..ad881e67084c
> > --- /dev/null
> > +++ b/rust/kernel/file.rs
> > @@ -0,0 +1,330 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! Files and file descriptors.
> > +//!
> > +//! C headers: [`include/linux/fs.h`](srctree/include/linux/fs.h) and
> > +//! [`include/linux/file.h`](srctree/include/linux/file.h)
> > +
> > +use crate::{
> > + =C2=A0 =C2=A0bindings,
> > + =C2=A0 =C2=A0error::{code::*, Error, Result},
> > + =C2=A0 =C2=A0types::{ARef, AlwaysRefCounted, Opaque},
> > +};
> > +use core::{marker::PhantomData, ptr};
> > +
> > +/// Flags associated with a [`File`].
> > +pub mod flags {
> > + =C2=A0 =C2=A0/// File is opened in append mode.
> > + =C2=A0 =C2=A0pub const O_APPEND: u32 =3D bindings::O_APPEND;
> > +
> > + =C2=A0 =C2=A0/// Signal-driven I/O is enabled.
> > + =C2=A0 =C2=A0pub const O_ASYNC: u32 =3D bindings::FASYNC;
> > +
> > + =C2=A0 =C2=A0/// Close-on-exec flag is set.
> > + =C2=A0 =C2=A0pub const O_CLOEXEC: u32 =3D bindings::O_CLOEXEC;
> > +
> > + =C2=A0 =C2=A0/// File was created if it didn't already exist.
> > + =C2=A0 =C2=A0pub const O_CREAT: u32 =3D bindings::O_CREAT;
> > +
> > + =C2=A0 =C2=A0/// Direct I/O is enabled for this file.
> > + =C2=A0 =C2=A0pub const O_DIRECT: u32 =3D bindings::O_DIRECT;
> > +
> > + =C2=A0 =C2=A0/// File must be a directory.
> > + =C2=A0 =C2=A0pub const O_DIRECTORY: u32 =3D bindings::O_DIRECTORY;
> > +
> > + =C2=A0 =C2=A0/// Like [`O_SYNC`] except metadata is not synced.
> > + =C2=A0 =C2=A0pub const O_DSYNC: u32 =3D bindings::O_DSYNC;
> > +
> > + =C2=A0 =C2=A0/// Ensure that this file is created with the `open(2)` =
call.
> > + =C2=A0 =C2=A0pub const O_EXCL: u32 =3D bindings::O_EXCL;
> > +
> > + =C2=A0 =C2=A0/// Large file size enabled (`off64_t` over `off_t`).
> > + =C2=A0 =C2=A0pub const O_LARGEFILE: u32 =3D bindings::O_LARGEFILE;
> > +
> > + =C2=A0 =C2=A0/// Do not update the file last access time.
> > + =C2=A0 =C2=A0pub const O_NOATIME: u32 =3D bindings::O_NOATIME;
> > +
> > + =C2=A0 =C2=A0/// File should not be used as process's controlling ter=
minal.
> > + =C2=A0 =C2=A0pub const O_NOCTTY: u32 =3D bindings::O_NOCTTY;
> > +
> > + =C2=A0 =C2=A0/// If basename of path is a symbolic link, fail open.
> > + =C2=A0 =C2=A0pub const O_NOFOLLOW: u32 =3D bindings::O_NOFOLLOW;
> > +
> > + =C2=A0 =C2=A0/// File is using nonblocking I/O.
> > + =C2=A0 =C2=A0pub const O_NONBLOCK: u32 =3D bindings::O_NONBLOCK;
> > +
> > + =C2=A0 =C2=A0/// File is using nonblocking I/O.
> > + =C2=A0 =C2=A0///
> > + =C2=A0 =C2=A0/// This is effectively the same flag as [`O_NONBLOCK`] =
on all architectures
> > + =C2=A0 =C2=A0/// except SPARC64.
> > + =C2=A0 =C2=A0pub const O_NDELAY: u32 =3D bindings::O_NDELAY;
> > +
> > + =C2=A0 =C2=A0/// Used to obtain a path file descriptor.
> > + =C2=A0 =C2=A0pub const O_PATH: u32 =3D bindings::O_PATH;
> > +
> > + =C2=A0 =C2=A0/// Write operations on this file will flush data and me=
tadata.
> > + =C2=A0 =C2=A0pub const O_SYNC: u32 =3D bindings::O_SYNC;
> > +
> > + =C2=A0 =C2=A0/// This file is an unnamed temporary regular file.
> > + =C2=A0 =C2=A0pub const O_TMPFILE: u32 =3D bindings::O_TMPFILE;
> > +
> > + =C2=A0 =C2=A0/// File should be truncated to length 0.
> > + =C2=A0 =C2=A0pub const O_TRUNC: u32 =3D bindings::O_TRUNC;
> > +
> > + =C2=A0 =C2=A0/// Bitmask for access mode flags.
> > + =C2=A0 =C2=A0///
> > + =C2=A0 =C2=A0/// # Examples
> > + =C2=A0 =C2=A0///
> > + =C2=A0 =C2=A0/// ```
> > + =C2=A0 =C2=A0/// use kernel::file;
> > + =C2=A0 =C2=A0/// # fn do_something() {}
> > + =C2=A0 =C2=A0/// # let flags =3D 0;
> > + =C2=A0 =C2=A0/// if (flags & file::flags::O_ACCMODE) =3D=3D file::fla=
gs::O_RDONLY {
> > + =C2=A0 =C2=A0/// =C2=A0 =C2=A0 do_something();
> > + =C2=A0 =C2=A0/// }
> > + =C2=A0 =C2=A0/// ```
> > + =C2=A0 =C2=A0pub const O_ACCMODE: u32 =3D bindings::O_ACCMODE;
> > +
> > + =C2=A0 =C2=A0/// File is read only.
> > + =C2=A0 =C2=A0pub const O_RDONLY: u32 =3D bindings::O_RDONLY;
> > +
> > + =C2=A0 =C2=A0/// File is write only.
> > + =C2=A0 =C2=A0pub const O_WRONLY: u32 =3D bindings::O_WRONLY;
> > +
> > + =C2=A0 =C2=A0/// File can be both read and written.
> > + =C2=A0 =C2=A0pub const O_RDWR: u32 =3D bindings::O_RDWR;
> > +}
> > +
> > +/// Compile-time information for keeping track of how a [`File`] is sh=
ared.
> > +///
> > +/// The `fdget_pos` method can be used to access the file's position w=
ithout taking `f_pos_lock`,
> > +/// as long as the file is not shared with any other threads. During s=
uch calls to `fdget_pos`, the
> > +/// file must remain non-shared, so it must not be possible to move th=
e file to another thread. For
> > +/// example, if the file is moved to another thread, then it could be =
passed to `fd_install`, at
> > +/// which point the remote process could touch the file position.
> > +///
> > +/// The share mode only keeps track of whether there are active `fdget=
_pos` calls that did not take
> > +/// the `f_pos_lock`, and does not keep track of `fdget` calls. This i=
s okay because `fdget` does
> > +/// not care about the refcount of the underlying `struct file`; as lo=
ng as the entry in the
> > +/// current thread's fd table does not get removed, it's okay to share=
 the file. For example,
> > +/// `fd_install`ing the `struct file` into another process is okay dur=
ing an `fdget` call, because
> > +/// the other process can't touch the fd table of the original process=
.
> > +mod share_mode {
> > + =C2=A0 =C2=A0/// Trait implemented by the two sharing modes that a fi=
le might have.
> > + =C2=A0 =C2=A0pub trait FileShareMode {}
> > +
> > + =C2=A0 =C2=A0/// Represents a file for which there might be an active=
 call to `fdget_pos` that did not take
> > + =C2=A0 =C2=A0/// the `f_pos_lock` lock.
> > + =C2=A0 =C2=A0pub enum MaybeFdgetPos {}
> > +
> > + =C2=A0 =C2=A0/// Represents a file for which it is known that all act=
ive calls to `fdget_pos` (if any) took
> > + =C2=A0 =C2=A0/// the `f_pos_lock` lock.
> > + =C2=A0 =C2=A0pub enum NoFdgetPos {}
> > +
> > + =C2=A0 =C2=A0impl FileShareMode for MaybeFdgetPos {}
> > + =C2=A0 =C2=A0impl FileShareMode for NoFdgetPos {}
> > +}
> > +pub use self::share_mode::{FileShareMode, MaybeFdgetPos, NoFdgetPos};
> > +
> > +/// Wraps the kernel's `struct file`.
> > +///
> > +/// This represents an open file rather than a file on a filesystem. P=
rocesses generally reference
> > +/// open files using file descriptors. However, file descriptors are n=
ot the same as files. A file
> > +/// descriptor is just an integer that corresponds to a file, and a si=
ngle file may be referenced
> > +/// by multiple file descriptors.
> > +///
> > +/// # Refcounting
> > +///
> > +/// Instances of this type are reference-counted. The reference count =
is incremented by the
> > +/// `fget`/`get_file` functions and decremented by `fput`. The Rust ty=
pe `ARef<File>` represents a
> > +/// pointer that owns a reference count on the file.
> > +///
> > +/// Whenever a process opens a file descriptor (fd), it stores a point=
er to the file in its fd
> > +/// table (`struct files_struct`). This pointer owns a reference count=
 to the file, ensuring the
> > +/// file isn't prematurely deleted while the file descriptor is open. =
In Rust terminology, the
> > +/// pointers in `struct files_struct` are `ARef<File>` pointers.
> > +///
> > +/// ## Light refcounts
> > +///
> > +/// Whenever a process has an fd to a file, it may use something calle=
d a "light refcount" as a
> > +/// performance optimization. Light refcounts are acquired by calling =
`fdget` and released with
> > +/// `fdput`. The idea behind light refcounts is that if the fd is not =
closed between the calls to
> > +/// `fdget` and `fdput`, then the refcount cannot hit zero during that=
 time, as the `struct
> > +/// files_struct` holds a reference until the fd is closed. This means=
 that it's safe to access the
> > +/// file even if `fdget` does not increment the refcount.
> > +///
> > +/// The requirement that the fd is not closed during a light refcount =
applies globally across all
> > +/// threads - not just on the thread using the light refcount. For thi=
s reason, light refcounts are
> > +/// only used when the `struct files_struct` is not shared with other =
threads, since this ensures
> > +/// that other unrelated threads cannot suddenly start using the fd an=
d close it. Therefore,
> > +/// calling `fdget` on a shared `struct files_struct` creates a normal=
 refcount instead of a light
> > +/// refcount.
> > +///
> > +/// Light reference counts must be released with `fdput` before the sy=
stem call returns to
> > +/// userspace. This means that if you wait until the current system ca=
ll returns to userspace, then
> > +/// all light refcounts that existed at the time have gone away.
>
> You obviously are aware of this but I'm just spelling it out. Iirc,
> there will practically only ever be one light refcount per file.
>
> For a light refcount to be used we know that the file descriptor table
> isn't shared with any other task. So there are no threads that could
> concurrently access the file descriptor table. We also know that the
> file descriptor table cannot become shared while we're in system call
> context because the caller can't create new threads and they can't
> unshare the file descriptor table.
>
> So there's only one fdget() caller (Yes, they could call fdget()
> multiple times and then have to do fdput() multiple times but that's a
> level of weirdness that we don't need to worry about.).

Hmm. Is it not the case that different processes with different file
descriptor tables could reference the same underlying `struct file` and
both use light refcounts to do so, as long as each fd table is not
shared? So there could be multiple light refcounts to the same `struct
file` at the same time on different threads.

And this does *not* apply to `fdget_pos`, which checks the refcount of
the `struct file` instead of the refcount of the fd table.

> > +///
> > +/// ### The file position
> > +///
> > +/// Each `struct file` has a position integer, which is protected by t=
he `f_pos_lock` mutex.
> > +/// However, if the `struct file` is not shared, then the kernel may a=
void taking the lock as a
> > +/// performance optimization.
> > +///
> > +/// The condition for avoiding the `f_pos_lock` mutex is different fro=
m the condition for using
> > +/// `fdget`. With `fdget`, you may avoid incrementing the refcount as =
long as the current fd table
> > +/// is not shared; it is okay if there are other fd tables that also r=
eference the same `struct
> > +/// file`. However, `fdget_pos` can only avoid taking the `f_pos_lock`=
 if the entire `struct file`
> > +/// is not shared, as different processes with an fd to the same `stru=
ct file` share the same
> > +/// position.
> > +///
> > +/// ## Rust references
> > +///
> > +/// The reference type `&File` is similar to light refcounts:
> > +///
> > +/// * `&File` references don't own a reference count. They can only ex=
ist as long as the reference
> > +/// =C2=A0 count stays positive, and can only be created when there is=
 some mechanism in place to ensure
> > +/// =C2=A0 this.
> > +///
> > +/// * The Rust borrow-checker normally ensures this by enforcing that =
the `ARef<File>` from which
> > +/// =C2=A0 a `&File` is created outlives the `&File`.
> > +///
> > +/// * Using the unsafe [`File::from_ptr`] means that it is up to the c=
aller to ensure that the
> > +/// =C2=A0 `&File` only exists while the reference count is positive.
> > +///
> > +/// * You can think of `fdget` as using an fd to look up an `ARef<File=
>` in the `struct
> > +/// =C2=A0 files_struct` and create an `&File` from it. The "fd cannot=
 be closed" rule is like the Rust
> > +/// =C2=A0 rule "the `ARef<File>` must outlive the `&File`".
> > +///
> > +/// # Invariants
> > +///
> > +/// * All instances of this type are refcounted using the `f_count` fi=
eld.
> > +/// * If the file sharing mode is `MaybeFdgetPos`, then all active cal=
ls to `fdget_pos` that did
> > +/// =C2=A0 not take the `f_pos_lock` mutex must be on the same thread =
as this `File`.
> > +/// * If the file sharing mode is `NoFdgetPos`, then there must not be=
 active calls to `fdget_pos`
> > +/// =C2=A0 that did not take the `f_pos_lock` mutex.
> > +#[repr(transparent)]
> > +pub struct File<S: FileShareMode> {
> > + =C2=A0 =C2=A0inner: Opaque<bindings::file>,
> > + =C2=A0 =C2=A0_share_mode: PhantomData<S>,
> > +}
> > +
> > +// SAFETY: This file is known to not have any local active `fdget_pos`=
 calls, so it is safe to
> > +// transfer it between threads.
> > +unsafe impl Send for File<NoFdgetPos> {}
> > +
> > +// SAFETY: This file is known to not have any local active `fdget_pos`=
 calls, so it is safe to
> > +// access its methods from several threads in parallel.
> > +unsafe impl Sync for File<NoFdgetPos> {}
> > +
> > +/// File methods that only exist under the [`MaybeFdgetPos`] sharing m=
ode.
> > +impl File<MaybeFdgetPos> {
> > + =C2=A0 =C2=A0/// Constructs a new `struct file` wrapper from a file d=
escriptor.
> > + =C2=A0 =C2=A0///
> > + =C2=A0 =C2=A0/// The file descriptor belongs to the current process, =
and there might be active local calls
> > + =C2=A0 =C2=A0/// to `fdget_pos`.
> > + =C2=A0 =C2=A0pub fn fget(fd: u32) -> Result<ARef<File<MaybeFdgetPos>>=
, BadFdError> {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0// SAFETY: FFI call, there are no requirem=
ents on `fd`.
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0let ptr =3D ptr::NonNull::new(unsafe { bin=
dings::fget(fd) }).ok_or(BadFdError)?;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0// SAFETY: `bindings::fget` created a refc=
ount, and we pass ownership of it to the `ARef`.
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0//
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0// INVARIANT: This file is in the fd table=
 on this thread, so either all `fdget_pos` calls
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0// are on this thread, or the file is shar=
ed, in which case `fdget_pos` calls took the
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0// `f_pos_lock` mutex.
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0Ok(unsafe { ARef::from_raw(ptr.cast()) })
> > + =C2=A0 =C2=A0}
>
> I'm a little unclear how this is supposed to be used. What I
> specifically struggle with is what function does one have to call to
> translate from a file descriptor to a file? IOW, where are the actual
> entry points for turning fds into files? That's what I want to see and
> that's what we need to make this interface usable generically.

That is File::fget. It takes a file descriptor and returns a long-term
reference to a file.

> Because naively, what I'm looking for is a Rust version of fdget() and
> fdget_pos() that give me back a File<MaybeFdget> or a
> File<MaybeFdgetPos>.
>
> And then those both implement a get_file() method so the caller can take
> an explicit long-term reference to the file.

Even if you call `get_file` to get a long-term reference from something
you have an fdget_pos reference to, that doesn't necessarily mean that
you can share that long-term reference with other threads. You would
need to release the fdget_pos reference first. For that reason, the
long-term reference returned by `get_file` would still need to have the
`File<MaybeFdgetPos>` type.

(But you could convert it to a `File<NoFdgetPos>` afterwards. The
`assume_no_fdget_pos` method performs that conversion.)

As a sidenote, the reason that this patchset does not implement `fdget`
or `fdget_pos` is that Rust Binder does not use them. Like C Binder, it
just uses `fget` to immediately obtain a long-term reference. I was told
that as an exception, Rust code can be merged *before* its user, but
that we couldn't merge Rust code with no upcoming user. However, I can
include implementations of `fdget` and `fdget_pos` in the next version
if you prefer that. After all, it seems rather likely that we will
eventually have a user for fdget.

> The fget() above is really confusing to me because it always takes a
> reference on the file that's pointed to by the fd and then it returns a
> MaybeFdgetPos because presumably you want to indicate that the file
> descriptor may refer to a file that may or may not be referenced by
> another thread via fdget()/fdget_pos() already.

No, not another thread. It is because it may or may not be referenced by
fdget_pos by *the same* thread already.

Here's how I think of it: The `fget` method takes a file descriptor and
returns a long term reference (an ARef) to a `struct file`. It does not
return a file descriptor, since it doesn't store anywhere which fd it
came from.

The `File::fget` method returns a `File<MaybeFdgetPos>` in case *the
same thread* is also using `fdget_pos` on the same file descriptor. It's
okay if other threads are using `fdget_pos` because in that case the
file is already shared, so those other `fdget_pos` calls necessarily the
f_pos_lock mutex.

Note that since it forgets which fd and fd table it came from, calls to
`fdget` are actually not a problem for sending our long-term references
across threads. The `fdget` requirements only care about things that
touch the entry in the file descriptor table, such as closing the fd.
The `ARef<File>` type does not provide any methods that could lead to
that happening, so sharing it across threads is okay *even if* there is
an light reference. That's why I have an `MaybeFdgetPos` but no
`MaybeFdget`.

> So I've _skimmed_ the binder RFC and looked at:
> 20231101-rust-binder-v1-13-08ba9197f637@google.com
> which states:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Add support for sending fds over binder.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Unlike the other object types, file descripto=
rs are not translated until
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 the transaction is actually received by the r=
ecipient. Until that
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 happens, we store `u32::MAX` as the fd.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Translating fds is done in a two-phase proces=
s. First, the file
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 descriptors are allocated and written to the =
allocation. Then, once we
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 have allocated all of them, we commit them to=
 the files in question.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Using this strategy, we are able to guarantee=
 that we either send all of
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 the fds, or none of them.
>
> So I'm curious. How does the binder fd sending work exactly? Because I
> feel that this is crucial to understand here. Some specific questions:
>
> * When file descriptors are passed the reference to these files via
> =C2=A0 fget() are taken _synchronously_, i.e., by the sending task, not t=
he
> =C2=A0 receiver? IOW, is binder_translate_fd() called in the context of t=
he
> =C2=A0 sender or the receiver. I assume it must be the sender because
> =C2=A0 otherwise the sender and receiver must share a file descriptor tab=
le
> =C2=A0 in order for the receiver to call fget().

binder_translate_fd is called in the context of the sender.

> * The receiving task then allocates new file descriptors and installs
> =C2=A0 the received files into its file descriptor table?

That happens in binder_apply_fd_fixups, which is called in the context
of the receiver.

I can see how the sentence "Until that happens, we store `u32::MAX` as
the fd." is really confusing here. What happens when you send a fd is
this:

In the sender's ioctl:
1. The sender wishes to send a byte array to the recipient. The sender
   tells the kernel that at specific offsets in this array,=C2=A0there are
   some file descriptors that it wishes to send.

2. The kernel copies the byte array directly into the recipient's
   address space. The offsets in the byte array with file descriptors
   are not copied - instead u32::MAX is written temporarily at those
   offsets.

3. For each fd being sent, the kernel uses fget to obtain a reference to
   the underlying `struct file`. These pointers are stored in an array.

In the receiver's ioctl:
1. Go through the list of `struct file` pointers and create a
   `FileDescriptorReservation` for each.

2. Go through the list of `struct file` pointers again and `fd_install`
   them into the current thread's fd table. This is infallible due to
   the reservations we just made.

3. Finally, overwrite the u32::MAX values in the byte array with the
   actual file descriptors that the files were assigned.

This is the same as how it works in C Binder.

> And so basically, what I'm after here is that the binder_translate_fd()
> that calls fget() is done in the context of the sender and we _know_
> that the fds can't have light references. Because if they did it could
> only be by the calling task but they don't since the calling task uses
> fget() on them. And if the calling task is multi-threaded and another
> thread has called fdget() or fdget_pos() we know that they have taken
> their own reference because the file descriptor table is shared.
>
> So why is that fget() in here returning a File<MaybeFdgetPos>? This
> doesn't make sense to me at first glance.

Because when you call `File::fget`, then there could also be a different
call to `fdget_pos` on the same thread on the same file descriptor.

	fdget_pos(my_fd);
	let my_file =3D File::fget(my_fd)?;
	// oh no!
	send_to_another_thread(my_file);

In the above code, the file becomes shared even though `fdget_pos` might
not have taken the `f_pos_lock` mutex. That's not okay. We could end up
with a data race on the file position.

One of the primary design principles of Rust is that, if the user of our
API has *any* way of using it that could trigger a memory safety
problem, then we must be able to point at an unsafe block *in the user's
code* that is at fault. This must be the case no matter how contrived
the use of the API is.

As a corollary, if the user can trigger memory safety problems with our
API without using any unsafe blocks, then that is a bug in the API.
We cannot assign the blame to an unsafe block in the user's code, so the
blame *must* lie with an unsafe block inside the API.

So, to follow that design principle, I have designed the API in a way
that prevents the above data race. Concretely, because the
`File<MaybeFdgetPos>` type is not thread safe (or in Rust terms "is not
Send"), it's not possible to send values of that type across thread
boundaries. E.g., our `send_to_another_thread` would have a requirement
in its signature saying that it can only be called with types that are
thread safe, so calling it with a type that isn't results in a type
error.



Now, what if you *want* to send it to another thread? Let's consider
Rust Binder, which needs to do exactly that. The relevant code in Rust
Binder would need to be updated to look like this:

	let file =3D File::fget(my_fd)?;
	// SAFETY: We know that there are no active `fdget_pos` calls on
	// the current thread, since this is an ioctl and we have not
	// called `fdget_pos` inside the Binder driver.
	let thread_safe_file =3D unsafe { file.assume_no_fdget_pos() };

(search for File::from_fd in the RFC to find where this would go)

The `assume_no_fdget_pos` call has no effect at runtime - it is purely a
compile-time thing to force the user to use unsafe to "promise" that
there aren't any `fdget_pos` calls on the same fd.

If Rust Binder uses `assume_no_fdget_pos` and ends up triggering memory
unsafety because it sent a file to another thread, then we can point to
the unsafe block that calls `assume_no_fdget_pos` and say "that unsafe
block is at fault because it assumed that there was no `fdget_pos` call,
but that assumption was false."

> > + =C2=A0 =C2=A0/// Assume that there are no active `fdget_pos` calls th=
at prevent us from sharing this file.
> > + =C2=A0 =C2=A0///
> > + =C2=A0 =C2=A0/// This makes it safe to transfer this file to other th=
reads. No checks are performed, and
> > + =C2=A0 =C2=A0/// using it incorrectly may lead to a data race on the =
file position if the file is shared
> > + =C2=A0 =C2=A0/// with another thread.
> > + =C2=A0 =C2=A0///
> > + =C2=A0 =C2=A0/// This method is intended to be used together with [`F=
ile::fget`] when the caller knows
> > + =C2=A0 =C2=A0/// statically that there are no `fdget_pos` calls on th=
e current thread. For example, you
> > + =C2=A0 =C2=A0/// might use it when calling `fget` from an ioctl, sinc=
e ioctls usually do not touch the file
> > + =C2=A0 =C2=A0/// position.
> > + =C2=A0 =C2=A0///
> > + =C2=A0 =C2=A0/// # Safety
> > + =C2=A0 =C2=A0///
> > + =C2=A0 =C2=A0/// There must not be any active `fdget_pos` calls on th=
e current thread.
> > + =C2=A0 =C2=A0pub unsafe fn assume_no_fdget_pos(me: ARef<Self>) -> ARe=
f<File<NoFdgetPos>> {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0// INVARIANT: There are no `fdget_pos` cal=
ls on the current thread, and by the type
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0// invariants, if there is a `fdget_pos` c=
all on another thread, then it took the
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0// `f_pos_lock` mutex.
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0//
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0// SAFETY: `File<MaybeFdgetPos>` and `File=
<NoFdgetPos>` have the same layout.
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0unsafe { ARef::from_raw(ARef::into_raw(me)=
.cast()) }
> > + =C2=A0 =C2=A0}
> > +}
> > +
> > +/// File methods that exist under all sharing modes.
> > +impl<S: FileShareMode> File<S> {
> > + =C2=A0 =C2=A0/// Creates a reference to a [`File`] from a valid point=
er.
> > + =C2=A0 =C2=A0///
> > + =C2=A0 =C2=A0/// # Safety
> > + =C2=A0 =C2=A0///
> > + =C2=A0 =C2=A0/// * The caller must ensure that `ptr` points at a vali=
d file and that the file's refcount is
> > + =C2=A0 =C2=A0/// =C2=A0 positive for the duration of 'a.
> > + =C2=A0 =C2=A0/// * The caller must ensure that the requirements for u=
sing the chosen file sharing mode are
> > + =C2=A0 =C2=A0/// =C2=A0 upheld.
> > + =C2=A0 =C2=A0pub unsafe fn from_ptr<'a>(ptr: *const bindings::file) -=
> &'a File<S> {
>
> I think I requested from_raw_file() in the last revision?

Ah, yeah, I totally forgot about this. I'll make the change in the next
version.

> > + =C2=A0 =C2=A0/// Returns a raw pointer to the inner C struct.
> > + =C2=A0 =C2=A0#[inline]
> > + =C2=A0 =C2=A0pub fn as_ptr(&self) -> *mut bindings::file {
>
> And that was supposed to be into_raw_file() or as_raw_file()?

Per the Rust API guidelines [1], this should be `as_raw_file`. The
`into_*` prefix is for conversions that destroy the object you call it
on. (E.g., because it takes ownership of the underlying allocation or
refcount.)

As always, thank you for the very detailed questions!

Alice

[1]: https://rust-lang.github.io/api-guidelines/naming.html#ad-hoc-conversi=
ons-follow-as_-to_-into_-conventions-c-conv

