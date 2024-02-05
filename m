Return-Path: <linux-fsdevel+bounces-10296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF4D8499F8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 13:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B37A1C2267F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 12:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5254E1BC3F;
	Mon,  5 Feb 2024 12:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="gFJTrvji"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9B81C28B;
	Mon,  5 Feb 2024 12:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707135632; cv=none; b=FkCHE3wDCdkDTaOKI4aFDttQgpIG0pyk+3/sbcJxHZxnKtWidOXXU+aHbboME3nqUPj/vSEzfOxrptSscO4+tbjrDNCy5SBt0qZc49E5tfE8GfUkqPMarTW5+qxiAUtlM6eFEKRSXKBwtlbNsYDDjcIfMOXD3DX+Z2FobPjRh4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707135632; c=relaxed/simple;
	bh=FSqx85FKav5UTjkwrO0C/DvlGRzbLe0MGXGqjZ2Gkcc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MjkEmyCTDmUQSYhqOMCccVrljLbMwLbolsbNLINy5G6V4gCSxp4go5THxLCtY3Pd8XHQV4or3IFNy5pXNxUFyIjwjFC3KqBQpES66AX3gM9J+dGhJRR//rsQGVa3FHKgKvKpo8DHVdvXBdBxQsnt2NvJ00ZMj4r2B3ihpEbxffM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=gFJTrvji; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1707135628; x=1707394828;
	bh=DaP+uYIz8KmFM7LmToBkEKWVv9jbRasxcLtql4VpI7I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=gFJTrvjie5dIOI+j7tg45YffNTUKliKqj/6ogvDOw92xcJdevRwTRv/L2jitWhsEa
	 lVA4+dSQTvi183O0U8wfCAEzQ+FYQveY/lpgo11e4jarAdoValLvnsUG+8NMD4GgIY
	 3iui1LL21jOrHOjjmkdruPX104S42Id0+2vxUL176O0uB/kJCmtx2pSphyEX5rTK0j
	 hj8eqFHjl0bBaa6JI7j241HIpQ53sHqAyp4GCVe6SCzwy3AblHIT0NyXylOzcyR5NU
	 suEprCRfQyE+KqzNvgubSlF9VVblouIxj9acW+7Tc2sMo8G8Erf/Z6asOq/GfriHzp
	 NyvLUmpUfQ7uA==
Date: Mon, 05 Feb 2024 12:20:12 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 4/9] rust: cred: add Rust abstraction for `struct cred`
Message-ID: <4da53a00-77e5-4062-a743-c48e93235b97@proton.me>
In-Reply-To: <20240202-alice-file-v4-4-fc9c2080663b@google.com>
References: <20240202-alice-file-v4-0-fc9c2080663b@google.com> <20240202-alice-file-v4-4-fc9c2080663b@google.com>
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
> Add a wrapper around `struct cred` called `Credential`, and provide
> functionality to get the `Credential` associated with a `File`.
>=20
> Rust Binder must check the credentials of processes when they attempt to
> perform various operations, and these checks usually take a
> `&Credential` as parameter. The security_binder_set_context_mgr function
> would be one example. This patch is necessary to access these security_*
> methods from Rust.
>=20
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/bindings/bindings_helper.h |  1 +
>  rust/helpers.c                  | 13 ++++++
>  rust/kernel/cred.rs             | 72 +++++++++++++++++++++++++++++++++
>  rust/kernel/file.rs             | 13 ++++++
>  rust/kernel/lib.rs              |  1 +
>  5 files changed, 100 insertions(+)
>  create mode 100644 rust/kernel/cred.rs

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

--
Cheers,
Benno


