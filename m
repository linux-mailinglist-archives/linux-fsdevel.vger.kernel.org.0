Return-Path: <linux-fsdevel+bounces-8295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8988326F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 10:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99CB0B216D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 09:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C78C3C481;
	Fri, 19 Jan 2024 09:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="IPvtxXFj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E78B3C063;
	Fri, 19 Jan 2024 09:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705657756; cv=none; b=GOYVw3bfDFRr8s82cCXDmJb1jZG6dhS+i9qQNjnHEFvHIerltAmBlagBC7AGtPMSMJPwoCMIA3pS4/dBlMKYXple89tS8dIn2nnPYQtEsn61FlBxREc0pt+RI0VEjDqXzRmfUXeUmlVDdIT7u6/L5BWOCmTuvoM+0QstTiko4N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705657756; c=relaxed/simple;
	bh=sPvqaSxMPD3BnGdcH7OD60vhSLB2Rbvur4SVyjNqG5E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bfeIx6fjiogWoxgNAakvEW0Bzy3Pusdtx9/o8I+XMImeZ208211+G0Zn3gY4RGFBrl5iGHBtWakBQ994Zx0YTVjxkEF80Q7zflrn8STId9D+zdM0ecHMpyUUhl5b9Wog/qE3qHgWiHKS4Sh8bTk+jzyyBh40dmv2jAy1avcr5LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=IPvtxXFj; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1705657753; x=1705916953;
	bh=Q88luiGZXueycQwStfuEcmkDlp6/zu/vG2FfYmoeFK4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=IPvtxXFjEEEEZd3djhqkZPnt5Ye00sfCZAvx+5jDFWAKtjlpzMscB2uw0WeFo0nF6
	 pNR3Z6ErcoxDFPMmXVbW3pbtsQjzYu3oeVMORaM30lE3Tc518EqQpPNTHD1bL4mrM2
	 iUjTJ4pFpoTrS5m0wYIkQESwb+ELePJ9JSv29HUZfE5IuOrPcXWI9ycYPzT9A4YWgC
	 Sorqph4wQMY5O1Baymn2OGIvKqEgN9PH91b5Rqp651CECMOqH6yZWhNiMEkE7sjFmJ
	 LMuTXuXEroVaHSLCFUYAk9q57lQ2/vT64+7b7yIr8N3t+gMiJW/dLEBqeJ+GB4MtlM
	 yy+QOOV/M6vXQ==
Date: Fri, 19 Jan 2024 09:48:57 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 5/9] rust: file: add `FileDescriptorReservation`
Message-ID: <c8ffd601-e11c-46dc-82e6-9ac8ed471d7c@proton.me>
In-Reply-To: <20240118-alice-file-v3-5-9694b6f9580c@google.com>
References: <20240118-alice-file-v3-0-9694b6f9580c@google.com> <20240118-alice-file-v3-5-9694b6f9580c@google.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/18/24 15:36, Alice Ryhl wrote:
> From: Wedson Almeida Filho <wedsonaf@gmail.com>
>=20
> Allow for the creation of a file descriptor in two steps: first, we
> reserve a slot for it, then we commit or drop the reservation. The first
> step may fail (e.g., the current process ran out of available slots),
> but commit and drop never fail (and are mutually exclusive).
>=20
> This is needed by Rust Binder when fds are sent from one process to
> another. It has to be a two-step process to properly handle the case
> where multiple fds are sent: The operation must fail or succeed
> atomically, which we achieve by first reserving the fds we need, and
> only installing the files once we have reserved enough fds to send the
> files.
>=20
> Fd reservations assume that the value of `current` does not change
> between the call to get_unused_fd_flags and the call to fd_install (or
> put_unused_fd). By not implementing the Send trait, this abstraction
> ensures that the `FileDescriptorReservation` cannot be moved into a
> different process.
>=20
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---

I have one nit below, with that fixed:

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

> +impl Drop for FileDescriptorReservation {
> +    fn drop(&mut self) {
> +        // SAFETY: `self.fd` was previously returned by `get_unused_fd_f=
lags`. We have not yet used

I would again suggest mentioning the type invariant of `Self`.

--=20
Cheers,
Benno

> +        // the fd, so it is still valid, and `current` still refers to t=
he same task, as this type
> +        // cannot be moved across task boundaries.
> +        unsafe { bindings::put_unused_fd(self.fd) };
> +    }
> +}
> +
>  /// Represents the `EBADF` error code.
>  ///
>  /// Used for methods that can only fail with `EBADF`.
> --
> 2.43.0.381.gb435a96ce8-goog
>=20


