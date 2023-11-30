Return-Path: <linux-fsdevel+bounces-4447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A677FF9B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 19:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E792B20806
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041F35A0ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ehwizPfW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF8F1A3;
	Thu, 30 Nov 2023 08:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1701362431; x=1701621631;
	bh=aUwMWJjNDKEwZmf6rHJqm0TKxpV/+zt7aI/cwBnNF/A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ehwizPfWAQhgd+7ta7CVxTTmFCLL9OZt2OTvHEdaMgrWXuHZyzNtxt32CUCB1M1PE
	 6Q+MytXCCWjdVY4dbSvh6ZJKpIPHcoYlRCO+llV1Xp7icXNkd0rCP0iJqnsIUNchCq
	 vhjmms7N2eQ7KF8DgyqKB/J40WXRCW17Ire313/raamQ4GRVNVJo1nW5l2u+gwoSrD
	 dGF7BTHj/ahSWnAkJBD+hsBw5ttmcbKOTao+Z8d3w4BlBlRvcdgDQAGODrIGsqu71+
	 rbRLbghNbiq+a+sjoiF4TvWS2W3VSuL2zQ0mH2WIU6Iv0P+QW5++cSqJPpi80t3Y51
	 C2KroYXNBsJbw==
Date: Thu, 30 Nov 2023 16:40:08 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/7] rust: file: add `FileDescriptorReservation`
Message-ID: <_xnOTacjwsOFSA4oog2DJs0VLa1w0EaSPM3rqDUjIZAmNgiq0V0-bJwfVZdDKaydes_rJb30Zz4TyacYImYZHK6i0-LR8AYbQa2T1l0h3K8=@proton.me>
In-Reply-To: <20231129-alice-file-v1-4-f81afe8c7261@google.com>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com> <20231129-alice-file-v1-4-f81afe8c7261@google.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/29/23 14:11, Alice Ryhl wrote:
> +impl FileDescriptorReservation {
> +    /// Creates a new file descriptor reservation.
> +    pub fn new(flags: u32) -> Result<Self> {
> +        // SAFETY: FFI call, there are no safety requirements on `flags`=
.
> +        let fd: i32 =3D unsafe { bindings::get_unused_fd_flags(flags) };
> +        if fd < 0 {
> +            return Err(Error::from_errno(fd));
> +        }

I think here we could also use the modified `to_result` function that
returns a `u32` if the value is non-negative.

> +        Ok(Self {
> +            fd: fd as _,
> +            _not_send_sync: PhantomData,
> +        })
> +    }
> +
> +    /// Returns the file descriptor number that was reserved.
> +    pub fn reserved_fd(&self) -> u32 {
> +        self.fd
> +    }
> +
> +    /// Commits the reservation.
> +    ///
> +    /// The previously reserved file descriptor is bound to `file`. This=
 method consumes the
> +    /// [`FileDescriptorReservation`], so it will not be usable after th=
is call.
> +    pub fn commit(self, file: ARef<File>) {
> +        // SAFETY: `self.fd` was previously returned by `get_unused_fd_f=
lags`, and `file.ptr` is
> +        // guaranteed to have an owned ref count by its type invariants.
> +        unsafe { bindings::fd_install(self.fd, file.0.get()) };
> +
> +        // `fd_install` consumes both the file descriptor and the file r=
eference, so we cannot run
> +        // the destructors.
> +        core::mem::forget(self);
> +        core::mem::forget(file);

Would be useful to have an `ARef::into_raw` function that would do
the `forget` for us.

--=20
Cheers,
Benno

