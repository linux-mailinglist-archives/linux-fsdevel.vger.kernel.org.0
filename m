Return-Path: <linux-fsdevel+bounces-9066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F21483DD06
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 16:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02F5C1F22941
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 15:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812021CA9C;
	Fri, 26 Jan 2024 15:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="AP0c6pbP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBFD7F;
	Fri, 26 Jan 2024 15:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706281489; cv=none; b=UXwz+t47OWnwW+w0kZK5j8kbR8Y+aQMChvw08+AezTNoYktN0Uakg6Mewd2sn0/9jv/NbFTK52VqVsXFa4jrfzUcyP4rRHFVy4ehy4VCIT+KWKWVE4hW2vHju0bsJCmMLraVsD8fADUMrxnkNpm/z2fPXGY0J3uUXWepYV8EicU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706281489; c=relaxed/simple;
	bh=+2ei/gy8yAIjRdSlj5GyuSIfvHi5rH2RqaMpvTFPKWI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qo5TwcWQRI8/Q19JkuYKlm+QAyff7d4wv6FDg/JmOGW3F5T4VR808nGO22PMHimqitoDE/N37ccs/ODWRnq+jcYKiAV6L8YsWnReE7XasAdrXU8P/3/y5LpOzNjrwxpd7JRd4iRLl/RMtS4vzaE8mifCXVft4j6sbgRwBv4Sc7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=AP0c6pbP; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1706281483; x=1706540683;
	bh=Wz2N1AcZwU0Mn94jWR065975cs5bO2b19pmlV+UYRdw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=AP0c6pbPVRMEfXf/3t1lpRi8IuxKSXky10bzvKc89aQUuXf81yWH/ZiIdqDEOTT+r
	 WTfXuf8iGd0dXb+ZecCa3GwnDZzuT0Uggjuq2ak+5s4r8OjmGtccIqR+h+MduPrKlF
	 TpUR6biatrUoYyPVEvWAZL/Be/uoaBc45fSHv/7s5zeVvaCiGmoTy04R7sZ8C0xNqE
	 k+M4hH+Xu9vEyWEAL4sDg82BtDtxFdEWfXKUqcYrQQmzIxsYMarlcNyC4EYQ0xCH+w
	 K27PSWXQnfDCSUQNULS9w46z007uYTVorJtgBR+te8ikZNmxCwTiQgVP2cJVkB1BnW
	 tAhwtK2ZexP1g==
Date: Fri, 26 Jan 2024 15:04:23 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/9] rust: file: add Rust abstraction for `struct file`
Message-ID: <5dbbaba2-fd7f-4734-9f44-15d2a09b4216@proton.me>
In-Reply-To: <20240118-alice-file-v3-1-9694b6f9580c@google.com>
References: <20240118-alice-file-v3-0-9694b6f9580c@google.com> <20240118-alice-file-v3-1-9694b6f9580c@google.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18.01.24 15:36, Alice Ryhl wrote:
> +/// Wraps the kernel's `struct file`.
> +///
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
> +///   refcount is positive until there are no more light refcounts creat=
ed from the fd that got

I think this wording can be easily misinterpreted: "until there
are no more light refcounts created" could mean that you are allowed
to drop the refcount to zero after the last light refcount has been
created. But in reality you want all light refcounts to be released
first.
I would suggest "until all light refcounts of the fd have been dropped"
or similar.

> +///   closed.
> +/// * A light refcount must be dropped before returning to userspace.
> +#[repr(transparent)]
> +pub struct File(Opaque<bindings::file>);
> +
> +// SAFETY: By design, the only way to access a `File` is via an immutabl=
e reference or an `ARef`.
> +// This means that the only situation in which a `File` can be accessed =
mutably is when the
> +// refcount drops to zero and the destructor runs. It is safe for that t=
o happen on any thread, so
> +// it is ok for this type to be `Send`.

Technically, `drop` is never called for `File`, since it is only used
via `ARef<File>` which calls `dec_ref` instead. Also since it only contains
an `Opaque`, dropping it is a noop.
But what does `Send` mean for this type? Since it is used together with
`ARef`, being `Send` means that `File::dec_ref` can be called from any
thread. I think we are missing this as a safety requirement on
`AlwaysRefCounted`, do you agree?
I think the safety justification here could be (with the requirement added
to `AlwaysRefCounted`):

     SAFETY:
     - `File::drop` can be called from any thread.
     - `File::dec_ref` can be called from any thread.

--
Cheers,
Benno

> +unsafe impl Send for File {}
> +
> +// SAFETY: All methods defined on `File` that take `&self` are safe to c=
all even if other threads
> +// are concurrently accessing the same `struct file`, because those meth=
ods either access immutable
> +// properties or have proper synchronization to ensure that such accesse=
s are safe.
> +unsafe impl Sync for File {}


