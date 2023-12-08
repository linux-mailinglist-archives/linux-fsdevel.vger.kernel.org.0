Return-Path: <linux-fsdevel+bounces-5347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A696080AC26
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 19:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CDA41F210A6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 18:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5272341BC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 18:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="RDUdK0QZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EAE1998;
	Fri,  8 Dec 2023 08:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1702053614; x=1702312814;
	bh=iOcAdvmkOxmMqWA6VMNdNeHSDm9Y1yQ4G8UPvASaJ3o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=RDUdK0QZ007pRxsGGYl1Y1rMyM8MlCsVdH41VwLUTLTVAl+7ARMq5nMpGZEb88xF6
	 cIHqptWrxnculVk7rkFGCH7Gfry1clDWcMtxwV1vlzp7cCLjd6G5BtkgTt3XuCSDxh
	 9jDpt2Z5gbuAdCWK+5UO1aKvO/VLgMVjNFAJjBnnLPl+K3KBza38L0lQGnjkznzjDy
	 ztFuU3mx32rtI9nWlns6oSXANQuDgiqtS5/YSlb2Wcr1SaF3ysmxGVaM4QK/M/raZj
	 bHIbXgY8eyl/yKbEkWF0bwkQTmE8Hoydwg4wr7/ArOsh0LoTxrH1dMvAYXAQbh/9oW
	 mma2vT8fEJ4mQ==
Date: Fri, 08 Dec 2023 16:40:09 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] rust: file: add `Kuid` wrapper
Message-ID: <jtCKrRw-FNajNJOXOuI1sweeDxI8T_uYnJ7DxMuqnJc9sgWjS0zouT_XIS-KmPferL7lU51BwD6nu73jZtzzB0T17pDeQP0-sFGRQxdjnaA=@proton.me>
In-Reply-To: <20231206-alice-file-v2-5-af617c0d9d94@google.com>
References: <20231206-alice-file-v2-0-af617c0d9d94@google.com> <20231206-alice-file-v2-5-af617c0d9d94@google.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/6/23 12:59, Alice Ryhl wrote:
> +    /// Returns the given task's pid in the current pid namespace.
> +    pub fn pid_in_current_ns(&self) -> Pid {
> +        // SAFETY: Calling `task_active_pid_ns` with the current task is=
 always safe.
> +        let namespace =3D unsafe { bindings::task_active_pid_ns(bindings=
::get_current()) };

Why not create a safe wrapper for `bindings::get_current()`?
This patch series has three occurrences of `get_current`, so I think it
should be ok to add a wrapper.
I would also prefer to move the call to `bindings::get_current()` out of
the `unsafe` block.

> +        // SAFETY: We know that `self.0.get()` is valid by the type inva=
riant.

What about `namespace`?

--=20
Cheers,
Benno

> +        unsafe { bindings::task_tgid_nr_ns(self.0.get(), namespace) }
> +    }

