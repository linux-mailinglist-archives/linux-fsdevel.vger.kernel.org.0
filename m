Return-Path: <linux-fsdevel+bounces-8293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C9D8326DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 10:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 893E8B24687
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 09:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581213C481;
	Fri, 19 Jan 2024 09:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="aJewP+j1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE363C466;
	Fri, 19 Jan 2024 09:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705657308; cv=none; b=Ffq2RmpIeJ6twNBl0VSsIWI5ouG7t0KxIffOMMlv0Y/8O5M8MnSFwSkF1O7Cgnr00KT+cYu+1ksZWW9F5e82dxuFpJw7zBP7IGLK5MKRHOaj+SUEEJ128dK1UgBhYAqH8DXTwyYVLJnvEWH+7FhaSvGjExm63tYKwNFee4CdMjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705657308; c=relaxed/simple;
	bh=YJYpaPOgxUl899sEpsjsJ+i01DqQOHlIeRucsamnsTY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tWOMAgvk0A/zAUYWfe5prRYmRQEiH7jmCT2ZiAT30t7nabTt8Hov4rAcM+4X5rD+2sF0TMy5rUqi44qcEH0XmvoQRy2+PTJGAeMRXnHs8sNBVlKTaskTvijBWUWWjMMaGtRTtlqgUpwNWF6epIXGNYHeTwJxwuAupZp+EstCxNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=aJewP+j1; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1705657298; x=1705916498;
	bh=PA9uMImkdPnSEhbKs0t7oZyPPg/Vs65ttw5hB0eO9+s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=aJewP+j1hOit+BVVyJ7sdjKgMjBt2CWjkdqGui6wJzFrqjiFk59GM+0jiFBpUJ+L5
	 UOKslo5yT1R/Pz0W+VO0M9BjhTRRs388rvwCBZFe/lJncoxtp1PpePj3Ifq/SFq2Qc
	 uQS9nSU0MCEtBz5z+7oH7Mnyw3q9r4ZswYvXEgJl7UnNctBPYgi7QoYAG30ZYUpIR9
	 6hjSfYNV7q1471b8mAPsQcUUDkPfxKOd8Wm7ubWTW0Dxe461v8qPPgdZpBDUJDa4jv
	 jgwY5IycOlldcvfjyDVpRovgMTGpA+c6rSjG5eXYywkQoDaMOwq369N6pFHs/Q3FvD
	 ezt1sDwiYoiQg==
Date: Fri, 19 Jan 2024 09:41:15 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 3/9] rust: security: add abstraction for secctx
Message-ID: <e0be6c3f-7b9f-4116-9237-3f5715e21516@proton.me>
In-Reply-To: <20240118-alice-file-v3-3-9694b6f9580c@google.com>
References: <20240118-alice-file-v3-0-9694b6f9580c@google.com> <20240118-alice-file-v3-3-9694b6f9580c@google.com>
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
> Adds an abstraction for viewing the string representation of a security
> context.
>=20
> This is needed by Rust Binder because it has feature where a process can
> view the string representation of the security context for incoming
> transactions. The process can use that to authenticate incoming
> transactions, and since the feature is provided by the kernel, the
> process can trust that the security context is legitimate.
>=20
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

I have one nit below, with that fixed:

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

> +impl Drop for SecurityCtx {
> +    fn drop(&mut self) {
> +        // SAFETY: This frees a pointer that came from a successful call=
 to

I would add this to the beginning:

    By the invariant of `Self`, this frees ...

--=20
Cheers,
Benno

> +        // `security_secid_to_secctx` and has not yet been destroyed by =
`security_release_secctx`.
> +        unsafe { bindings::security_release_secctx(self.secdata, self.se=
clen as u32) };
> +    }
> +}
> --
> 2.43.0.381.gb435a96ce8-goog
>=20


