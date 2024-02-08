Return-Path: <linux-fsdevel+bounces-10777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C308D84E3AB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 16:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E69D41C23E58
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 15:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514407AE79;
	Thu,  8 Feb 2024 15:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wAi5tOo2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE71567E93
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Feb 2024 15:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707404744; cv=none; b=eqAlRmXymfjVCjK0CiDxwuNtNaHOQsi0F7Lw/jpR3yLo7w3FWNKRPrr6Gkcs6Whkt4d6wsyIrlOR3Amn8B8TreXWUDNhnclRpc2n65l43UswwKSntlzZ3DJKcf5NUXcQ1zwvZylDZpKITWD2GHowK08so5eNEUINSbJ6+FWO5qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707404744; c=relaxed/simple;
	bh=bWFo1Lrp7yi5ftyvRv/uFM8AEPJoN0Y0hTCzDzCPAXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j+/uW8v1spezBiGIc9XqGP6LCg8vfE8D77q121cuTgTHaABDXHz/f44sStMMnKd9+e6XrivbEd04X7kj+FhylltMwiA6o5zute5wVdOHBFR2d3cb31xUkz2sWX4lONkJ1fBg12WzS7zhW6jjMQdvnN24wqKXdpXnHRmI9i8oTUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wAi5tOo2; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-46d57e3892eso291846137.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Feb 2024 07:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707404741; x=1708009541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1RcVIIytdlhLHmoNj+deLulYTGt9lRpDm9txekPAmg=;
        b=wAi5tOo2p4V8WRiTq6PjVFVAwRi8AWnE7+zMhnJpKP93/F7hPShu4TBrnmuhDkJaQS
         MICwUURUu5joh3w/qL/mjvg4PKvhTolfiUaN9ud1nmkVfMgeDJC8CIVkw3YNgJRpmAfL
         /sj7M/mWEA113M+6ZZrZkCh19psXNgRACtNVF5R2wT9Oz13lvANEUaNXEvyVqoQyiXfw
         MwGMeCIV+apNEcgaWKECqG/gzYtQ6LFl5yXgkGwVUIJ1YqUmViQs+OT/rRLrVtATjb3Y
         syoobWQAurH7cxHuN/QmTqB4+b6cO6d/rG9EDq7g4qxpFMFQuR8EhyUPohyVXoTmt85D
         Gd4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707404741; x=1708009541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/1RcVIIytdlhLHmoNj+deLulYTGt9lRpDm9txekPAmg=;
        b=vkdxgmzUDxPLJf30o6AjaPTuZG3PmLWlAiVzRgen7AA6QnRlqTEtfbuTq3xHK+s9Rf
         YFMWJmPRJfO9CvAr1MslS4lb37yF45MCqC9lE43wL+ThWUvxMsxMWr6Fp1CAPEue2NSg
         gqVcHiDK1o6TFkiy1lXe5UWE1MXX0EB2wCRPXKW6h2LU7ar2/wt+gzHqupuNItWG8ZEn
         iwmNaCNa9JMkmr4QW9omMHYBTNr5S5hpW6Lx3/WuEHk2FA/LE0gmHz5ftpjjnq+uJDFl
         THuc1u9gzZVFyOX0JLywtq1MkLCnfcv0hKsSIWMybwXXJFij9xb4o581o7/Pvh3ZD8kH
         1tFQ==
X-Gm-Message-State: AOJu0YzR87zda1AGHTWvq7yTuiE0jfDzXHVldVknlcJAfhoGydongPYq
	v2KmLOJx+ulehri/GrzA6vfT0aFeyfARbWnuT8X+tYy6+JYhwbodUC7+w7CpEZyaGTksBevAhD3
	yDT0cdvEgsex4Iid+R1gv3hB9UYU4IquLvktV
X-Google-Smtp-Source: AGHT+IFG2xUktSvwU+EER62yZRuzZqKyfRpRl3qFBJ5ZDs6RHlJiShu9xXRYU7XzQXhCkY/NTXrav94rSS/Jhexlyo8=
X-Received: by 2002:a05:6122:2326:b0:4c0:230c:1143 with SMTP id
 bq38-20020a056122232600b004c0230c1143mr5804657vkb.10.1707404741486; Thu, 08
 Feb 2024 07:05:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202-alice-file-v4-0-fc9c2080663b@google.com>
 <20240202-alice-file-v4-3-fc9c2080663b@google.com> <CALNs47uxe6N7VLqC10k5PH=r-CKBLqGf7JBQMw46LXPUBi3X8w@mail.gmail.com>
In-Reply-To: <CALNs47uxe6N7VLqC10k5PH=r-CKBLqGf7JBQMw46LXPUBi3X8w@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 8 Feb 2024 16:05:30 +0100
Message-ID: <CAH5fLgjsoQP_7=fxHY13Oz+o3zyr7_iFwF_h9PSeUs5Kr5cn6A@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] rust: file: add Rust abstraction for `struct file`
To: Trevor Gross <tmgross@umich.edu>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 3:48=E2=80=AFAM Trevor Gross <tmgross@umich.edu> wro=
te:
>
> On Fri, Feb 2, 2024 at 5:56=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
> >
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
> > * `File::from_fd` returns a `Result<ARef<File>, BadFdError>`, which the
> >   compiler will represent as a single pointer, with null being an error=
.
> >   This is possible because the compiler understands that `BadFdError`
> >   has only one possible value, and it also understands that the
> >   `ARef<File>` smart pointer is guaranteed non-null.
> > * Additionally, we promise to users of the method that the method can
> >   only fail with EBADF, which means that they can rely on this promise
> >   without having to inspect its implementation.
> > That said, there are also two disadvantages:
> > * Defining additional error types involves boilerplate.
> > * The question mark operator will only utilize the `From` trait once,
> >   which prevents you from using the question mark operator on
> >   `BadFdError` in methods that return some third error type that the
> >   kernel `Error` is convertible into. (However, it works fine in method=
s
> >   that return `Error`.)
> >
> > Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > Co-developed-by: Daniel Xu <dxu@dxuuu.xyz>
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> >  fs/file.c                       |   7 +
> >  rust/bindings/bindings_helper.h |   2 +
> >  rust/helpers.c                  |   7 +
> >  rust/kernel/file.rs             | 249 ++++++++++++++++++++++++++++++++
> >  rust/kernel/lib.rs              |   1 +
> >  5 files changed, 266 insertions(+)
> >  create mode 100644 rust/kernel/file.rs
> >
> > diff --git a/fs/file.c b/fs/file.c
> > index 3b683b9101d8..f2eab5fcb87f 100644
> > --- a/fs/file.c
> > +++ b/fs/file.c
> > @@ -1115,18 +1115,25 @@ EXPORT_SYMBOL(task_lookup_next_fdget_rcu);
> >  /*
> >   * Lightweight file lookup - no refcnt increment if fd table isn't sha=
red.
> >   *
> >   * You can use this instead of fget if you satisfy all of the followin=
g
> >   * conditions:
> >   * 1) You must call fput_light before exiting the syscall and returnin=
g control
> >   *    to userspace (i.e. you cannot remember the returned struct file =
* after
> >   *    returning to userspace).
> >   * 2) You must not call filp_close on the returned struct file * in be=
tween
> >   *    calls to fget_light and fput_light.
> >   * 3) You must not clone the current task in between the calls to fget=
_light
> >   *    and fput_light.
> >   *
> >   * The fput_needed flag returned by fget_light should be passed to the
> >   * corresponding fput_light.
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
> >   */
> >  static unsigned long __fget_light(unsigned int fd, fmode_t mask)
> >  {
>
> Should this be split to its own patch so it can be applied separately if =
needed?

I don't think that's necessary.

> > [...]
> > +    /// Also known as `O_NDELAY`.
> > +    ///
> > +    /// This is effectively the same flag as [`O_NONBLOCK`] on all arc=
hitectures
> > +    /// except SPARC64.
> > +    pub const O_NDELAY: u32 =3D bindings::O_NDELAY;
>
> This is O_NDELAY, should the AKA say O_NONBLOCK?
> > [...]
> > +/// Wraps the kernel's `struct file`.
>
> It is probably better to say what it does for the summary, and mention
> what it wraps later.

I added a bit more info.

> > +/// # Refcounting
> > +///
> > +/// Instances of this type are reference-counted. The reference count =
is incremented by the
> > +/// `fget`/`get_file` functions and decremented by `fput`. The Rust ty=
pe `ARef<File>` represents a
> > +/// pointer that owns a reference count on the file.
> > +///
> > +/// Whenever a process opens a file descriptor (fd), it stores a point=
er to the file in its `struct
> > +/// files_struct`. This pointer owns a reference count to the file, en=
suring the file isn't
> > +/// prematurely deleted while the file descriptor is open. In Rust ter=
minology, the pointers in
> > +/// `struct files_struct` are `ARef<File>` pointers.
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
> > +///
> > +/// ## Rust references
> > +///
> > +/// The reference type `&File` is similar to light refcounts:
> > +///
> > +/// * `&File` references don't own a reference count. They can only ex=
ist as long as the reference
> > +///   count stays positive, and can only be created when there is some=
 mechanism in place to ensure
> > +///   this.
> > +///
> > +/// * The Rust borrow-checker normally ensures this by enforcing that =
the `ARef<File>` from which
> > +///   a `&File` is created outlives the `&File`.
> > +///
> > +/// * Using the unsafe [`File::from_ptr`] means that it is up to the c=
aller to ensure that the
> > +///   `&File` only exists while the reference count is positive.
> > +///
> > +/// * You can think of `fdget` as using an fd to look up an `ARef<File=
>` in the `struct
> > +///   files_struct` and create an `&File` from it. The "fd cannot be c=
losed" rule is like the Rust
> > +///   rule "the `ARef<File>` must outlive the `&File`".
> > +///
> > +/// # Invariants
> > +///
> > +/// * Instances of this type are refcounted using the `f_count` field.
> > +/// * If an fd with active light refcounts is closed, then it must be =
the case that the file
> > +///   refcount is positive until all light refcounts of the fd have be=
en dropped.
> > +/// * A light refcount must be dropped before returning to userspace.
> > +#[repr(transparent)]
> > +pub struct File(Opaque<bindings::file>);
> > +
> > +// SAFETY:
> > +// - `File::dec_ref` can be called from any thread.
> > +// - It is okay to send ownership of `File` across thread boundaries.
>
> Shouldn't this be lowecase `file` because it is referring to the
> underlying C object?

Done.

> > +unsafe impl Send for File {}
> > [...]
> > +    /// Returns the flags associated with the file.
> > +    ///
> > +    /// The flags are a combination of the constants in [`flags`].
> > +    pub fn flags(&self) -> u32 {
>
> A typedef used here and in the constants module could be useful
>
>     type FileFlags =3D u32;

Maybe, but it doesn't actually do anything as far as the type checker
is concerned, so meh.

> > +        // This `read_volatile` is intended to correspond to a READ_ON=
CE call.
> > +        //
> > +        // SAFETY: The file is valid because the shared reference guar=
antees a nonzero refcount.
> > +        //
> > +        // TODO: Replace with `read_once` when available on the Rust s=
ide.
>
> Shouldn't the TODO become a `FIXME(read_once): ...` since it is going
> into the codebase?

I'm not sure we necessarily have a convention for that? But I'll change it.

>
> Some suggestions but nothing blocking
>
> Reviewed-by: Trevor Gross <tmgross@umich.edu>

