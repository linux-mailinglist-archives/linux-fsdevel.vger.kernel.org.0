Return-Path: <linux-fsdevel+bounces-10303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D224849A22
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 13:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F49E1C22C84
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 12:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03F11BF33;
	Mon,  5 Feb 2024 12:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="MXwZl4Xc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902EC1BDDF;
	Mon,  5 Feb 2024 12:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136094; cv=none; b=Y3oCV62PkMy9vEx2ixeNLs9vg97f6g6aZKuazXlN5WWVYg59nd/FmE4IaEgDNfw4MRMGY+TsOBgJnNATj4wCaYlQwtkejVUIOLegvQgmLY/orKBYiz1plMifBhL47iSV7BmZq382wPv3qkIPloA0sJSJTgrpE0D0i0kJU8AucoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136094; c=relaxed/simple;
	bh=/FmTOpD7EsdsRiWnp+n9V95+jzTNKJcM3d3V70ANPwo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tLQGwUdL4wM5t5wqBg3gWbw2b+N++8qXSyV1A5cKwPz5BKv18s50Y4CUkwwHMMnFmaKINlXoI/+hygaszCoEjQH7pn6cfg51WxRZ1bVdh0DpR46P+BjssFx7/5t1/VkM2eRwS3MsPsLjRvkW+SfvJdkJPZLR8V+Nph0WcYbTaZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=MXwZl4Xc; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=nwtgodaxtrgdtpoqw2aktnr3gy.protonmail; t=1707136084; x=1707395284;
	bh=daleUQrt9HsLvgJZG6U/EET+1E8JHEi5VCW3vb8WDEM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=MXwZl4Xcq0NAM/InqXeNXPf9wRgAGPfjoSJbQTWGPg+AW9+mu6jo7lHfwz2uwHm6y
	 SW/keWP+h1kYMGk24bKAqlJYG84jVzG89V2jpOysGWNhvVmRN8G25TIhJgP3HeYa+x
	 ba8QeUFKlIDnEG26vJOylLSvn+CmS5kN+4RKFH74DQauATw2BuH/oQh+wiRqdL5krb
	 fddRCExmt3IBc9CQU0nI5FRshVR5VpRWw48nMvCd/d1U9UmidRYA0g0+S1YnucCdn1
	 AtW8fD5a+iW4VqXeo2xzbYlF2fplS2JrI+c1JJtW5tp+oS6c/5ThaXe4AmabVdTqRA
	 3bxadL17F0S8w==
Date: Mon, 05 Feb 2024 12:27:46 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 9/9] rust: file: add abstraction for `poll_table`
Message-ID: <9a35d753-793e-4953-9095-742953c06154@proton.me>
In-Reply-To: <20240202-alice-file-v4-9-fc9c2080663b@google.com>
References: <20240202-alice-file-v4-0-fc9c2080663b@google.com> <20240202-alice-file-v4-9-fc9c2080663b@google.com>
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
> The existing `CondVar` abstraction is a wrapper around
> `wait_queue_head`, but it does not support all use-cases of the C
> `wait_queue_head` type. To be specific, a `CondVar` cannot be registered
> with a `struct poll_table`. This limitation has the advantage that you
> do not need to call `synchronize_rcu` when destroying a `CondVar`.
>=20
> However, we need the ability to register a `poll_table` with a
> `wait_queue_head` in Rust Binder. To enable this, introduce a type
> called `PollCondVar`, which is like `CondVar` except that you can
> register a `poll_table`. We also introduce `PollTable`, which is a safe
> wrapper around `poll_table` that is intended to be used with
> `PollCondVar`.
>=20
> The destructor of `PollCondVar` unconditionally calls `synchronize_rcu`
> to ensure that the removal of epoll waiters has fully completed before
> the `wait_queue_head` is destroyed.
>=20
> That said, `synchronize_rcu` is rather expensive and is not needed in
> all cases: If we have never registered a `poll_table` with the
> `wait_queue_head`, then we don't need to call `synchronize_rcu`. (And
> this is a common case in Binder - not all processes use Binder with
> epoll.) The current implementation does not account for this, but if we
> find that it is necessary to improve this, a future patch could store a
> boolean next to the `wait_queue_head` to keep track of whether a
> `poll_table` has ever been registered.
>=20
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/bindings/bindings_helper.h |   1 +
>  rust/kernel/sync.rs             |   1 +
>  rust/kernel/sync/poll.rs        | 117 ++++++++++++++++++++++++++++++++
>  3 files changed, 119 insertions(+)
>  create mode 100644 rust/kernel/sync/poll.rs

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

--=20
Cheers,
Benno


