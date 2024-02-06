Return-Path: <linux-fsdevel+bounces-10414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D9984AC4F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 03:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 882731C239C9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 02:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868AD6E2D2;
	Tue,  6 Feb 2024 02:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="SybyMvBJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206786DD1A
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 02:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707187709; cv=none; b=pBMaVxOmoeU+RJigkc8Gw9Zs8uzsSu6agUuyIj5iiyGwOOrygFw03ipPl+9xRpsgY2Yln9Og9xXwGkqak7wE+OqDMAoHs6CpwqU7AsxtZdd7ARoZC1b+MetuQ23uRGfc48DbQr4FEjftCf/hAaXjb56L9CTZSJ5CG4o+GFHxxZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707187709; c=relaxed/simple;
	bh=9OzVKt8dleAFVHUaJf2FWAI8P+7Rrlq9X1m8aubTuvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pl1bi3ZUF7vZMRSzmr/UohO/hy8018sp5BX8Qpe4D2t35KyjniihU7NJhsIAOxGwins1rOi08JyGFwJ3GuKlrQgH62V8M7fAk3nhyW0cLL7Xip0TzGGCW30eNvcxhfHG53ABuzPKWAIEZ4GwjS2AzsvSuNr+ya1WejIJS5PCqcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=SybyMvBJ; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc6d8f31930so115074276.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Feb 2024 18:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1707187706; x=1707792506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=isYZDUvsWr/7v30nHxpavVqqhW2SR7yBo8lUWUfPuz4=;
        b=SybyMvBJSknQOzDFyIVESBl2pUXnBCAj83bq27PJpMVlHYjMKqw0pJayuHxOXL7BsJ
         HAV2NZV8WEugOIB2bUABJm1DoENeDD/II7Sa5DdTmHeqa8mo8m/Tk68JQYXsAdNj5hS3
         Y7UuQHGUDwrpbhQhQixtsMJO2eWNS+9UhjMKf+MEURzg0PE+BPfL/wUi+rhh+RJma22i
         nslV5tXb/gI1GVSRl38Ky87dQsoTJYu3oNQ/f5IyPo7wpN9paXeXhm9q9UF0YaAZlicV
         I883D2inkbJOfQB6e79gSh5MPFUWJJwp+T/FZULXxr/+TuZbKG2qYJb6/0T03sgZtXtI
         wEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707187706; x=1707792506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=isYZDUvsWr/7v30nHxpavVqqhW2SR7yBo8lUWUfPuz4=;
        b=aYfuaWGonsTsTyLCD20dsKPqdwXyuolsZq2GiD9gIoV1YPtgm2jV/kwaVZ3BvQzbgf
         5kE+t6WTfTOMGYU/OgZZ7PKr276XYbrIMJnW41agnYeZqYkOezZKBUzAnrmfLW6X4zCM
         gBS7YG/2FDpkPRHxQwCBcdqaD3PfIGCpp9+PXc4OyTE8Ks9PIaS4EV5W1q3U+J8AQyK2
         9Se9DZIKVRcgcfkpoo0uqZ3rZb2vcnILe/LzhKBL62+3QvVKhAVYFahH/3hwJ1EMKqYR
         o0LXFoeOegc1wsHCZfyOT+OfZMkR141o1fhqGg5w1vtQK5YALIbFw4jLhllGPN0fOhmq
         ZtIQ==
X-Gm-Message-State: AOJu0YyvlFzPVVER3aTrOShW8HTeSGncrmn2T1bgKBGX9oAKAQnwtae1
	j0Z8uNnftiKZozDRp1TVsHHj0ROspNt+xDC3WgDhvpmovv6EqEugKC9Iel2NxSO9Bboojaqhh8S
	u8LGMddSsyCXeAXJsThSEz2tjJwoCGpoWTQVHlg==
X-Google-Smtp-Source: AGHT+IEPbFtEPvYCN56yH9yNQS8NYqPda1fHbxAek5H/68ZxD3iz03Yu/GlEBnHjzndnqCkPskBUKo8w2e7mg2dSRzI=
X-Received: by 2002:a25:d347:0:b0:dc6:b146:8567 with SMTP id
 e68-20020a25d347000000b00dc6b1468567mr340585ybf.1.1707187705980; Mon, 05 Feb
 2024 18:48:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202-alice-file-v4-0-fc9c2080663b@google.com> <20240202-alice-file-v4-3-fc9c2080663b@google.com>
In-Reply-To: <20240202-alice-file-v4-3-fc9c2080663b@google.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Mon, 5 Feb 2024 21:48:14 -0500
Message-ID: <CALNs47uxe6N7VLqC10k5PH=r-CKBLqGf7JBQMw46LXPUBi3X8w@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] rust: file: add Rust abstraction for `struct file`
To: Alice Ryhl <aliceryhl@google.com>
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

On Fri, Feb 2, 2024 at 5:56=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> From: Wedson Almeida Filho <wedsonaf@gmail.com>
>
> This abstraction makes it possible to manipulate the open files for a
> process. The new `File` struct wraps the C `struct file`. When accessing
> it using the smart pointer `ARef<File>`, the pointer will own a
> reference count to the file. When accessing it as `&File`, then the
> reference does not own a refcount, but the borrow checker will ensure
> that the reference count does not hit zero while the `&File` is live.
>
> Since this is intended to manipulate the open files of a process, we
> introduce an `fget` constructor that corresponds to the C `fget`
> method. In future patches, it will become possible to create a new fd in
> a process and bind it to a `File`. Rust Binder will use these to send
> fds from one process to another.
>
> We also provide a method for accessing the file's flags. Rust Binder
> will use this to access the flags of the Binder fd to check whether the
> non-blocking flag is set, which affects what the Binder ioctl does.
>
> This introduces a struct for the EBADF error type, rather than just
> using the Error type directly. This has two advantages:
> * `File::from_fd` returns a `Result<ARef<File>, BadFdError>`, which the
>   compiler will represent as a single pointer, with null being an error.
>   This is possible because the compiler understands that `BadFdError`
>   has only one possible value, and it also understands that the
>   `ARef<File>` smart pointer is guaranteed non-null.
> * Additionally, we promise to users of the method that the method can
>   only fail with EBADF, which means that they can rely on this promise
>   without having to inspect its implementation.
> That said, there are also two disadvantages:
> * Defining additional error types involves boilerplate.
> * The question mark operator will only utilize the `From` trait once,
>   which prevents you from using the question mark operator on
>   `BadFdError` in methods that return some third error type that the
>   kernel `Error` is convertible into. (However, it works fine in methods
>   that return `Error`.)
>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Co-developed-by: Daniel Xu <dxu@dxuuu.xyz>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  fs/file.c                       |   7 +
>  rust/bindings/bindings_helper.h |   2 +
>  rust/helpers.c                  |   7 +
>  rust/kernel/file.rs             | 249 ++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs              |   1 +
>  5 files changed, 266 insertions(+)
>  create mode 100644 rust/kernel/file.rs
>
> diff --git a/fs/file.c b/fs/file.c
> index 3b683b9101d8..f2eab5fcb87f 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -1115,18 +1115,25 @@ EXPORT_SYMBOL(task_lookup_next_fdget_rcu);
>  /*
>   * Lightweight file lookup - no refcnt increment if fd table isn't share=
d.
>   *
>   * You can use this instead of fget if you satisfy all of the following
>   * conditions:
>   * 1) You must call fput_light before exiting the syscall and returning =
control
>   *    to userspace (i.e. you cannot remember the returned struct file * =
after
>   *    returning to userspace).
>   * 2) You must not call filp_close on the returned struct file * in betw=
een
>   *    calls to fget_light and fput_light.
>   * 3) You must not clone the current task in between the calls to fget_l=
ight
>   *    and fput_light.
>   *
>   * The fput_needed flag returned by fget_light should be passed to the
>   * corresponding fput_light.
> + *
> + * (As an exception to rule 2, you can call filp_close between fget_ligh=
t and
> + * fput_light provided that you capture a real refcount with get_file be=
fore
> + * the call to filp_close, and ensure that this real refcount is fput *a=
fter*
> + * the fput_light call.)
> + *
> + * See also the documentation in rust/kernel/file.rs.
>   */
>  static unsigned long __fget_light(unsigned int fd, fmode_t mask)
>  {

Should this be split to its own patch so it can be applied separately if ne=
eded?

> [...]
> +    /// Also known as `O_NDELAY`.
> +    ///
> +    /// This is effectively the same flag as [`O_NONBLOCK`] on all archi=
tectures
> +    /// except SPARC64.
> +    pub const O_NDELAY: u32 =3D bindings::O_NDELAY;

This is O_NDELAY, should the AKA say O_NONBLOCK?
> [...]
> +/// Wraps the kernel's `struct file`.

It is probably better to say what it does for the summary, and mention
what it wraps later.

> +/// # Refcounting
> +///
> +/// Instances of this type are reference-counted. The reference count is=
 incremented by the
> +/// `fget`/`get_file` functions and decremented by `fput`. The Rust type=
 `ARef<File>` represents a
> +/// pointer that owns a reference count on the file.
> +///
> +/// Whenever a process opens a file descriptor (fd), it stores a pointer=
 to the file in its `struct
> +/// files_struct`. This pointer owns a reference count to the file, ensu=
ring the file isn't
> +/// prematurely deleted while the file descriptor is open. In Rust termi=
nology, the pointers in
> +/// `struct files_struct` are `ARef<File>` pointers.
> +///
> +/// ## Light refcounts
> +///
> +/// Whenever a process has an fd to a file, it may use something called =
a "light refcount" as a
> +/// performance optimization. Light refcounts are acquired by calling `f=
dget` and released with
> +/// `fdput`. The idea behind light refcounts is that if the fd is not cl=
osed between the calls to
> +/// `fdget` and `fdput`, then the refcount cannot hit zero during that t=
ime, as the `struct
> +/// files_struct` holds a reference until the fd is closed. This means t=
hat it's safe to access the
> +/// file even if `fdget` does not increment the refcount.
> +///
> +/// The requirement that the fd is not closed during a light refcount ap=
plies globally across all
> +/// threads - not just on the thread using the light refcount. For this =
reason, light refcounts are
> +/// only used when the `struct files_struct` is not shared with other th=
reads, since this ensures
> +/// that other unrelated threads cannot suddenly start using the fd and =
close it. Therefore,
> +/// calling `fdget` on a shared `struct files_struct` creates a normal r=
efcount instead of a light
> +/// refcount.
> +///
> +/// Light reference counts must be released with `fdput` before the syst=
em call returns to
> +/// userspace. This means that if you wait until the current system call=
 returns to userspace, then
> +/// all light refcounts that existed at the time have gone away.
> +///
> +/// ## Rust references
> +///
> +/// The reference type `&File` is similar to light refcounts:
> +///
> +/// * `&File` references don't own a reference count. They can only exis=
t as long as the reference
> +///   count stays positive, and can only be created when there is some m=
echanism in place to ensure
> +///   this.
> +///
> +/// * The Rust borrow-checker normally ensures this by enforcing that th=
e `ARef<File>` from which
> +///   a `&File` is created outlives the `&File`.
> +///
> +/// * Using the unsafe [`File::from_ptr`] means that it is up to the cal=
ler to ensure that the
> +///   `&File` only exists while the reference count is positive.
> +///
> +/// * You can think of `fdget` as using an fd to look up an `ARef<File>`=
 in the `struct
> +///   files_struct` and create an `&File` from it. The "fd cannot be clo=
sed" rule is like the Rust
> +///   rule "the `ARef<File>` must outlive the `&File`".
> +///
> +/// # Invariants
> +///
> +/// * Instances of this type are refcounted using the `f_count` field.
> +/// * If an fd with active light refcounts is closed, then it must be th=
e case that the file
> +///   refcount is positive until all light refcounts of the fd have been=
 dropped.
> +/// * A light refcount must be dropped before returning to userspace.
> +#[repr(transparent)]
> +pub struct File(Opaque<bindings::file>);
> +
> +// SAFETY:
> +// - `File::dec_ref` can be called from any thread.
> +// - It is okay to send ownership of `File` across thread boundaries.

Shouldn't this be lowecase `file` because it is referring to the
underlying C object?

> +unsafe impl Send for File {}
> [...]
> +    /// Returns the flags associated with the file.
> +    ///
> +    /// The flags are a combination of the constants in [`flags`].
> +    pub fn flags(&self) -> u32 {

A typedef used here and in the constants module could be useful

    type FileFlags =3D u32;

> +        // This `read_volatile` is intended to correspond to a READ_ONCE=
 call.
> +        //
> +        // SAFETY: The file is valid because the shared reference guaran=
tees a nonzero refcount.
> +        //
> +        // TODO: Replace with `read_once` when available on the Rust sid=
e.

Shouldn't the TODO become a `FIXME(read_once): ...` since it is going
into the codebase?

> +        unsafe { core::ptr::addr_of!((*self.as_ptr()).f_flags).read_vola=
tile() }
> +    }
> +}

Some suggestions but nothing blocking

Reviewed-by: Trevor Gross <tmgross@umich.edu>

