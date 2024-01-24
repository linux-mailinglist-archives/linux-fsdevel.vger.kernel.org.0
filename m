Return-Path: <linux-fsdevel+bounces-8690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0D983A60B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 10:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 259882875E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 09:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E4F18C31;
	Wed, 24 Jan 2024 09:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="RuYwM4uE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A2C18AEA;
	Wed, 24 Jan 2024 09:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706090134; cv=none; b=H/TvaJxY6Kjrz/sYhFdxFb6Ki4PHXjjr5WTnWPUbsqx96+QAZsoGDR4cn24l/BGY66ed2TG0AV6KngZ1b8iP9puFEj4vQRxHqBfyaimZZWoQ/t8GoELs2Irru1HaOHLwfUZaU2/gfl/hj5n2pdBkljFAxPXNWcD9w3vEST/hKZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706090134; c=relaxed/simple;
	bh=KYp0r/IeTknl471W5NYtHm0z9oJasItGz6So8cefBHE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o0zO3rIxSCxcMPtoqEl/oAnEJp+JPC8g9iVzSykTp8s5M1Xy2HaOTBD+wLThLz5yJqGFQgPgaa4+XhigBotAYGEda/Cu/k0GMyS9wGcKpe7o90ZjkwzX6Y3mlfxO8YKhC97Usl2fPKr5aAPZXOj2funWv1Dxoy0U+x2NVAi3wbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=RuYwM4uE; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1706090129; x=1706349329;
	bh=sM5FO5ZYOTkgArwratQF0EUhkGp44P1qkTq6Csk6zNQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=RuYwM4uE1gT9XsXdO5bgnbCffYCCJ7/a4SPlzP4uX/70IuPhKSFGUzcrgawnQmhQA
	 6tc9FhJNuijrz5i9OZoD96K0WEeWuWJyMij63c8kqGjKCILXvg0L0CuBLF2UKqA7F8
	 q5U38FH13rgdVwpHh7H+e3U2QmpubVFj7QZkFxTLe7hA/l79r2twIlTXvDNflc1aA1
	 xh4qptNVl/RAwZ6/CoQiVpSs0u4kT5vWfxPjdhaHPvTOaqykohy7FyUt2hYK8u7hHI
	 mShCFG9gOPgtQ6w72dOTSUv8IaqHmj2EdAYuocZ6bcpmh3KvoNXhRFQRRR1+oc/zWd
	 a8GhDvarK283w==
Date: Wed, 24 Jan 2024 09:55:21 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 7/9] rust: file: add `Kuid` wrapper
Message-ID: <3405588c-46c2-4e7d-8c5a-15079e774d62@proton.me>
In-Reply-To: <20240118-alice-file-v3-7-9694b6f9580c@google.com>
References: <20240118-alice-file-v3-0-9694b6f9580c@google.com> <20240118-alice-file-v3-7-9694b6f9580c@google.com>
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
> Adds a wrapper around `kuid_t` called `Kuid`. This allows us to define
> various operations on kuids such as equality and current_euid. It also
> lets us provide conversions from kuid into userspace values.
>=20
> Rust Binder needs these operations because it needs to compare kuids for
> equality, and it needs to tell userspace about the pid and uid of
> incoming transactions.
>=20
> To read kuids from a `struct task_struct`, you must currently use
> various #defines that perform the appropriate field access under an RCU
> read lock. Currently, we do not have a Rust wrapper for rcu_read_lock,
> which means that for this patch, there are two ways forward:
>=20
>   1. Inline the methods into Rust code, and use __rcu_read_lock directly
>      rather than the rcu_read_lock wrapper. This gives up lockdep for
>      these usages of RCU.
>=20
>   2. Wrap the various #defines in helpers and call the helpers from Rust.
>=20
> This patch uses the second option. One possible disadvantage of the
> second option is the possible introduction of speculation gadgets, but
> as discussed in [1], the risk appears to be acceptable.
>=20
> Of course, once a wrapper for rcu_read_lock is available, it is
> preferable to use that over either of the two above approaches.
>=20
> Link: https://lore.kernel.org/all/202312080947.674CD2DC7@keescook/ [1]
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>   rust/bindings/bindings_helper.h |  1 +
>   rust/helpers.c                  | 45 ++++++++++++++++++++
>   rust/kernel/cred.rs             |  5 ++-
>   rust/kernel/task.rs             | 74 ++++++++++++++++++++++++++++++++-
>   4 files changed, 122 insertions(+), 3 deletions(-)

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

--=20
Cheers,
Benno



