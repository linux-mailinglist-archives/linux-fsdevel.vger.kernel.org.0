Return-Path: <linux-fsdevel+bounces-9828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8AC845421
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 10:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA7261C23D46
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 09:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E6E15DBBC;
	Thu,  1 Feb 2024 09:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="jLp9ZHx/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4AF15B118;
	Thu,  1 Feb 2024 09:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706780066; cv=none; b=Cn80PBZBgr/fPw770A3IkNKH9M7ICL3TkAGfeECvxFAwgiywsfj5scIOQj+Jm7J4VL9d66Kdn3Jc0SDqWsBwyUQbiSciPub8GA2AdV740qZHR1VA4tty+AGPxh+KO4hduv+eeK1LWDRWJZGZ8jL7/9+sNoGKROCCd2qz5slL8vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706780066; c=relaxed/simple;
	bh=4DCJWDNY54pVWFJWSQe81n3ZGgHdx18f6qRCAFzEAVQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sulMSzSj5M47rV6pzjYZKFfzDu2xLW2rAhnGAIDFk5YdoKBLwR5Xly1WC9dehPMzeZ+Bca3NlLuz4+k8JXE0mV1jNl26ATXbix/71jO5IWIF2KzTaey68X8Z2TdCHUv6gEP0kqeOn0Gn7ldczmhAEafAr54YmOd6fPeaeRPs5Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=jLp9ZHx/; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1706780062; x=1707039262;
	bh=i2b20zoMNoEak8nrSmXQ3s/Guoh1bpSZ5F9Ndi7Z2IA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=jLp9ZHx/c5Y8MqfrseK7YBvpjUXCY8y0S9/k/Il5AxxXmU0QcolE7Yv+vZhZuvPN5
	 otoJcRdGisGU02rinhWOp30ZE8fGgnMJxThyxwG52fNqICOgUPOXBOoX35vMffQipX
	 FDTiLnxlhUsBQ/yN6oCrrCsfiUmjfoImlkVxg0OrFDCJg0qrcTwKC4YnY9MHLk2Abh
	 WovcE6/6z40+y0ISAYF9Rk4bjvWsiS9R7ky/FNTNwztgsiCJWUqvilJfUi84B+mTQ1
	 YrQUik8V+lTZs6sIhlmj9zgAOOX9c/jRmeQfYEkc4xbXwVgOe+D8JDS9fv1HrSGmOu
	 nPZ+OwXFxPYeA==
Date: Thu, 01 Feb 2024 09:33:59 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 9/9] rust: file: add abstraction for `poll_table`
Message-ID: <50317af4-9f3c-4f72-bd8e-4e39fb4e108f@proton.me>
In-Reply-To: <CAH5fLgjMvh65PXdxnkPAtxNH82UDAwtyXmPK+VJPFTtXfiN2JQ@mail.gmail.com>
References: <20240118-alice-file-v3-0-9694b6f9580c@google.com> <20240118-alice-file-v3-9-9694b6f9580c@google.com> <1ac11c65-7024-41c3-a788-cfcad8fb6c55@proton.me> <CAH5fLgjMvh65PXdxnkPAtxNH82UDAwtyXmPK+VJPFTtXfiN2JQ@mail.gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.01.24 18:08, Alice Ryhl wrote:
> On Wed, Jan 24, 2024 at 11:11=E2=80=AFAM Benno Lossin <benno.lossin@proto=
n.me> wrote:
>>
>> On 18.01.24 15:36, Alice Ryhl wrote:
>>> +/// Wraps the kernel's `struct poll_table`.
>>> +///
>>> +/// # Invariants
>>> +///
>>> +/// This struct contains a valid `struct poll_table`.
>>> +///
>>> +/// For a `struct poll_table` to be valid, its `_qproc` function must =
follow the safety
>>> +/// requirements of `_qproc` functions. It must ensure that when the w=
aiter is removed and a rcu
>>
>> The first sentence sounds a bit weird, what is meant by `_qproc` functio=
ns?
>> Do you have a link to where that is defined? Or is the whole definition =
the
>> next sentence?
>=20
> Yeah. Does this wording work better for you?
>=20
> /// For a `struct poll_table` to be valid, its `_qproc` function must
> follow the safety
> /// requirements of `_qproc` functions:
> ///
> /// * The `_qproc` function is given permission to enqueue a waiter to

Does it make sense to change "waiter" to `wait_queue_head`?

> the provided `poll_table`
> ///   during the call. Once the waiter is removed and an rcu grace
> period has passed, it must no
> ///   longer access the `wait_queue_head`.

Yes that is better.

--=20
Cheers,
Benno



