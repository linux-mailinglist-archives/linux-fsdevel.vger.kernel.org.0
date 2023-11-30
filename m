Return-Path: <linux-fsdevel+bounces-4453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7B27FF9BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 19:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB400B20DE6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C7A5A0E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="SmOdraL9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540D410F8;
	Thu, 30 Nov 2023 08:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1701362933; x=1701622133;
	bh=ma6iKXmyJ476bBrogFjyVSkUY7XrgEHkL0/Xftslrt4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=SmOdraL93gFqTu2k/5T2ohP1ZJp2b+CgRREaU2e5H1ZUq4x+EQvILLt2aSngvbMa6
	 PuK9x5xisRVyi5GJs6FPfdfzAX85fwq8Xrl5f6AnTNOgFSBCQzSrvkP5g4+EGQDsHL
	 EDBFtQ/XfIaDvnkhJpKS55tbPYn/LRm42eGm3PN6XQjcfWymtg7hYZG97eEo82RFCS
	 DhIXHhEsObboS66pGMYvBvB+X7350grHi5wzpZmkhB6NTESy/2TtQQClKyerIxp0qL
	 RQT4giTnYFEp7mYhmjHeCd9EKaUCvyy8q3Cqe1rdbp4PpCBmDq+9ZX4rAFkBo0Sd5R
	 Gasrmyqv2pBdw==
Date: Thu, 30 Nov 2023 16:48:29 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/7] rust: file: add `Kuid` wrapper
Message-ID: <1fDBLge_kImhS4koYYda8t5pmIAeA9Zxo8haE_x1zKgxqGtrQd3wHhOgTbV8db3exz-Q6kXoDh3XWMyX4aox0oGTDSX2udA6ZDSV3r3D1_U=@proton.me>
In-Reply-To: <20231129-alice-file-v1-5-f81afe8c7261@google.com>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com> <20231129-alice-file-v1-5-f81afe8c7261@google.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/29/23 14:12, Alice Ryhl wrote:
> +    /// Returns the given task's pid in the current pid namespace.
> +    pub fn pid_in_current_ns(&self) -> Pid {
> +        // SAFETY: We know that `self.0.get()` is valid by the type inva=
riant. The rest is just FFI
> +        // calls.
> +        unsafe {
> +            let namespace =3D bindings::task_active_pid_ns(bindings::get=
_current());
> +            bindings::task_tgid_nr_ns(self.0.get(), namespace)
> +        }

I would split this into two `unsafe` blocks.

> +    }
> +
>      /// Wakes up the task.
>      pub fn wake_up(&self) {
>          // SAFETY: By the type invariant, we know that `self.0.get()` is=
 non-null and valid.
> @@ -147,6 +180,42 @@ pub fn wake_up(&self) {
>      }
>  }
>=20
> +impl Kuid {
> +    /// Get the current euid.
> +    pub fn current_euid() -> Kuid {
> +        // SAFETY: Just an FFI call.
> +        Self {
> +            kuid: unsafe { bindings::current_euid() },
> +        }

Would expect a call to `from_raw` here instead of `Self {}`.

> +    }
> +
> +    /// Create a `Kuid` given the raw C type.
> +    pub fn from_raw(kuid: bindings::kuid_t) -> Self {
> +        Self { kuid }
> +    }

Is there a reason that this is named `from_raw` and not just a normal
`From` impl? AFAICT any `bindings::kuid_t` is a valid `Kuid`.

> +
> +    /// Turn this kuid into the raw C type.
> +    pub fn into_raw(self) -> bindings::kuid_t {
> +        self.kuid
> +    }
> +
> +    /// Converts this kernel UID into a UID that userspace understands. =
Uses the namespace of the
> +    /// current task.

Why not:

    /// Converts this kernel UID into a userspace UID.
    ///
    /// Uses the namespace of the current task.

--=20
Cheers,
Benno

> +    pub fn into_uid_in_current_ns(self) -> bindings::uid_t {
> +        // SAFETY: Just an FFI call.
> +        unsafe { bindings::from_kuid(bindings::current_user_ns(), self.k=
uid) }
> +    }
> +}

