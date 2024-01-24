Return-Path: <linux-fsdevel+bounces-8694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B650383A66F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 11:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2E231C209C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 10:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C9318E0C;
	Wed, 24 Jan 2024 10:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="iry3Xgxf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DFC18C01;
	Wed, 24 Jan 2024 10:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706091117; cv=none; b=qMl0e7aaBPn/p4PIOy6g38ZjPDwCaSC+W80rq6EeHHc1NWKE9ReCpTG5sVk2+twI7K076AwO6GOexfdwo/hZaAsh7CGy325wvt973dT54UqL/+beehEPJI89zF9RKS7pTWi9l0UYog0EIrjkX9EBk2eabmvRg5p7t9RlAqyFQMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706091117; c=relaxed/simple;
	bh=CvGTPg1l+fKHEbuwtqyFw/sMsPaw+N2FH23De9NheCg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YUdBQHizBx4sccvXIzoX38koooprTstZ7PGfWOYlt6vdX2PjElCUj5Cw8x4vGhPS2eMcmyQhTM1OXCbdz77EBj1C0y9T/WAJBA+f6DAfmWRZ14SVnu7C3WkDlCLnmEe1TQ1dkxx3hv2m09meJCBohi3f6wYsS7S49VunFWUOCMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=iry3Xgxf; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1706091112; x=1706350312;
	bh=CvGTPg1l+fKHEbuwtqyFw/sMsPaw+N2FH23De9NheCg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=iry3Xgxf5gYJLmOfXXe3OqnH84Sh3AYsH5iF6fpdwPQ9Xo6G4QAkK2/XKd2vQ3tJu
	 iW7L3R5bCo4qUuPv1czvMozTv6dN+Vnqe9QWEfviFUm/6BBVHXx84dvmljtjdU8UJf
	 xmQ7HYTGmO3JbIkry6K6LuvpqieYJrjSLJUVMcCRBoBukRkmNM7DM5ZzKMss7PdKvU
	 zxMUDCsvN3lFZCrIOrWCvvjvyBQR/Sa6p4i3Up5LD7pwMu/5lUbrwYDRzpzhM3ad6F
	 jvH5Zt2RLgeRZJbkkBv1TWXZdcHqbu+Q8JLVw+J0+0Q71t11kHRqPAkmKgDOdFaG3t
	 EHiZZu1qYvVdw==
Date: Wed, 24 Jan 2024 10:11:28 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 9/9] rust: file: add abstraction for `poll_table`
Message-ID: <1ac11c65-7024-41c3-a788-cfcad8fb6c55@proton.me>
In-Reply-To: <20240118-alice-file-v3-9-9694b6f9580c@google.com>
References: <20240118-alice-file-v3-0-9694b6f9580c@google.com> <20240118-alice-file-v3-9-9694b6f9580c@google.com>
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
> +/// Wraps the kernel's `struct poll_table`.
> +///
> +/// # Invariants
> +///
> +/// This struct contains a valid `struct poll_table`.
> +///
> +/// For a `struct poll_table` to be valid, its `_qproc` function must fo=
llow the safety
> +/// requirements of `_qproc` functions. It must ensure that when the wai=
ter is removed and a rcu

The first sentence sounds a bit weird, what is meant by `_qproc` functions?
Do you have a link to where that is defined? Or is the whole definition the
next sentence?

--=20
Cheers,
Benno

> +/// grace period has passed, it must no longer access the `wait_queue_he=
ad`.
> +#[repr(transparent)]
> +pub struct PollTable(Opaque<bindings::poll_table>);


