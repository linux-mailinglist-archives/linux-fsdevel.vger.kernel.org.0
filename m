Return-Path: <linux-fsdevel+bounces-10310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB69849A58
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 13:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7FF6281FD1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 12:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54431BC58;
	Mon,  5 Feb 2024 12:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="iBUOeyK3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31861BC3D;
	Mon,  5 Feb 2024 12:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136430; cv=none; b=VnktjnX13JwxB98ZS73hZwhAEo4QfPrZ02pXjEyq1iZL5lTXwDvXM1WTC+Z4eubYvvD1BXkpBM1fHshSxs88pgKmf+9N4W2rP6cfENuQbKPBz1wfFLBB3bfs4U36IXGjn6RQPCQkzQcG0viHlA4mhd4fZWlSiCwpMJfohPYILWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136430; c=relaxed/simple;
	bh=ZCWpwwDP32QW23OHxqcS6dyIhG+EZnGUM+vdeUCbChQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V7SmIVp0gP4d+fbwFrY+mJJD1d/QwBXH8/IRc+9re6gOfTEB4KkAAcNJ82qysgJNpHwNP6Cj+WTpKRNXH2LPRihIjPzq6JYoCMZvX0NbAj6rA4MByQOzOvKhNOUVqDzC/EnXv79oUE6LikYkraWuE0GvIeTuzEvWFf9FUKOgWNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=iBUOeyK3; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1707136426; x=1707395626;
	bh=Koptk02WV6BeYNID6QKo1BWynpaJzVcgM9vAm9rLNbY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=iBUOeyK3HhTdc8lgsE31Vu767CZcsaMMDP2tX5btt8UO6ecAU3r5SIFXNFT8CxKmW
	 UDvqP7UFoBd5+PLkiet7e8Srvgz9iCnpUha32FSvKqm6wqIpetUlXLeHnVOK0cVti3
	 Z8Kp9lbiwZ3rD/YKzyroZkhAgyclBEOIrzk7SmLjN/Q+B7GwocbhuiOR7ZgIQGViu6
	 2vcp2bI1QtvMuR5R5O8Pp/9ZvyL2OiA18NuOn/739FzH8ZLBpdiQTCEIc67EBprkI9
	 pFP8AsdiGUxdpNRtsxxBUP3m5aAAjYur3XL0aAcuukoNAN1PULQUfNwsOoUxxu2Xwp
	 YLTQ3nFKlq+ng==
Date: Mon, 05 Feb 2024 12:33:27 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 3/9] rust: file: add Rust abstraction for `struct file`
Message-ID: <5f261c6a-785b-4bc5-974f-ad43c3a312b9@proton.me>
In-Reply-To: <20240202-alice-file-v4-3-fc9c2080663b@google.com>
References: <20240202-alice-file-v4-0-fc9c2080663b@google.com> <20240202-alice-file-v4-3-fc9c2080663b@google.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/2/24 11:55, Alice Ryhl wrote:
> From: Wedson Almeida Filho <wedsonaf@gmail.com>
>=20
> This abstraction makes it possible to manipulate the open files for a
> process. The new `File` struct wraps the C `struct file`. When accessing
> it using the smart pointer `ARef<File>`, the pointer will own a
> reference count to the file. When accessing it as `&File`, then the
> reference does not own a refcount, but the borrow checker will ensure
> that the reference count does not hit zero while the `&File` is live.
>=20
> Since this is intended to manipulate the open files of a process, we
> introduce an `fget` constructor that corresponds to the C `fget`
> method. In future patches, it will become possible to create a new fd in
> a process and bind it to a `File`. Rust Binder will use these to send
> fds from one process to another.
>=20
> We also provide a method for accessing the file's flags. Rust Binder
> will use this to access the flags of the Binder fd to check whether the
> non-blocking flag is set, which affects what the Binder ioctl does.
>=20
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
>=20
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

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

--=20
Cheers,
Benno


