Return-Path: <linux-fsdevel+bounces-8292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C41E58326CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 10:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 302651F23ACC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 09:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A443C088;
	Fri, 19 Jan 2024 09:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="HoREC4/W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFAE1EB52;
	Fri, 19 Jan 2024 09:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705657064; cv=none; b=EZVUwBEeiUK0s2Wbs6Ca6ymBpqoWwLeDzSNS+JdTFHXAa2RZ0c8im0sa0eCx3qtDV+k8fuRgzCJq+Ee7a6ABKfR5UCq0mOZngdlozCcjPuqSzjPKsqgkkTOp9Pp+KM/O0jcqZdgtpYlrzrqonQj7QCXfe6D0yQSa84o/oK8Odag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705657064; c=relaxed/simple;
	bh=VQjoaasfjGj4Pt4jE9IK07lq2R6F63SB0ntq1hY/FL4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WT5Jar/Rg5gqe71HTRMyaOVI3vp4+X5O1MkXGG5Y+OSMtOsDe4HHOOg6PFU84/OG0SrJ2wd+E8GhWttraSDnz+KsAhyLmOCKWwI5OQnJMGESqPWESmOsYQY1gx376zVvfYyBgESfJK2WvrevBRJTl3d1hovfHoNhNUR5PQFAi4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=HoREC4/W; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1705657058; x=1705916258;
	bh=8e/rU8mWyRsdYMtNFKOr1SDmHGWMG+cSiKUa3CJl5vE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=HoREC4/WD32aiGHQKEf6Vt8D/QhA2+yVfqPC26y7RcTkaqB76qxUQGajzuP/uqxu3
	 LjsnRWMss/mjzog+QG4sGSF0w4VkIpuTt4GqDkLzqMEWJ1D2H9AGi1t/86SdJ7ShTr
	 KkzkFa+PBukrlzQLg78oNaRHNRzZ+rRJLx8Cl7+2IUjiFrGyH9SdPOS04esJf6/1xr
	 3zgULcYWxRQi+XKqin1dF99vjuTEDnw7jyPdTbl7YrpdDLvXH8PeERRSkDHdj52arq
	 0w9Kw7yekiwbuQeRATcEkaJFNivDu0Y2BysYVYZquCpVylzVs6bJM+38lxNSFSSgni
	 +1fbwBwxh59lQ==
Date: Fri, 19 Jan 2024 09:37:12 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 2/9] rust: cred: add Rust abstraction for `struct cred`
Message-ID: <67a9f08d-d551-4238-b02d-f1c7af3780ae@proton.me>
In-Reply-To: <20240118-alice-file-v3-2-9694b6f9580c@google.com>
References: <20240118-alice-file-v3-0-9694b6f9580c@google.com> <20240118-alice-file-v3-2-9694b6f9580c@google.com>
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
> diff --git a/rust/kernel/cred.rs b/rust/kernel/cred.rs
> new file mode 100644
> index 000000000000..ccec77242dfd
> --- /dev/null
> +++ b/rust/kernel/cred.rs
> @@ -0,0 +1,65 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Credentials management.
> +//!
> +//! C header: [`include/linux/cred.h`](../../../../include/linux/cred.h)

IIRC you can use `srctree/include/..` to avoid the `../..` madness.

> +//!
> +//! Reference: <https://www.kernel.org/doc/html/latest/security/credenti=
als.html>
> +
> +use crate::{
> +    bindings,
> +    types::{AlwaysRefCounted, Opaque},
> +};
> +
> +/// Wraps the kernel's `struct cred`.
> +///
> +/// # Invariants
> +///
> +/// Instances of this type are always ref-counted, that is, a call to `g=
et_cred` ensures that the
> +/// allocation remains valid at least until the matching call to `put_cr=
ed`.
> +#[repr(transparent)]
> +pub struct Credential(Opaque<bindings::cred>);
> +
> +// SAFETY: By design, the only way to access a `Credential` is via an im=
mutable reference or an
> +// `ARef`. This means that the only situation in which a `Credential` ca=
n be accessed mutably is
> +// when the refcount drops to zero and the destructor runs. It is safe f=
or that to happen on any
> +// thread, so it is ok for this type to be `Send`.

IMO the only important part is that calling `drop`/`dec_ref` is OK from
any thread.

In general I think it might be a good idea to make
`AlwaysRefCounted: Send + Sync`. But that is outside the scope of this
patch.

> +unsafe impl Send for Credential {}
> +
> +// SAFETY: It's OK to access `Credential` through shared references from=
 other threads because
> +// we're either accessing properties that don't change or that are prope=
rly synchronised by C code.
> +unsafe impl Sync for Credential {}
> +
> +impl Credential {
> +    /// Creates a reference to a [`Credential`] from a valid pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `ptr` is valid and remains valid for=
 the lifetime of the
> +    /// returned [`Credential`] reference.
> +    pub unsafe fn from_ptr<'a>(ptr: *const bindings::cred) -> &'a Creden=
tial {
> +        // SAFETY: The safety requirements guarantee the validity of the=
 dereference, while the
> +        // `Credential` type being transparent makes the cast ok.
> +        unsafe { &*ptr.cast() }
> +    }
> +
> +    /// Returns the effective UID of the given credential.
> +    pub fn euid(&self) -> bindings::kuid_t {
> +        // SAFETY: By the type invariant, we know that `self.0` is valid=
.

Is `euid` an immutable property, or why does this memory access not race
with something?

--=20
Cheers,
Benno

> +        unsafe { (*self.0.get()).euid }
> +    }
> +}
> +
> +// SAFETY: The type invariants guarantee that `Credential` is always ref=
-counted.
> +unsafe impl AlwaysRefCounted for Credential {
> +    fn inc_ref(&self) {
> +        // SAFETY: The existence of a shared reference means that the re=
fcount is nonzero.
> +        unsafe { bindings::get_cred(self.0.get()) };
> +    }
> +
> +    unsafe fn dec_ref(obj: core::ptr::NonNull<Credential>) {
> +        // SAFETY: The safety requirements guarantee that the refcount i=
s nonzero. The cast is okay
> +        // because `Credential` has the same representation as `struct c=
red`.
> +        unsafe { bindings::put_cred(obj.cast().as_ptr()) };
> +    }
> +}


