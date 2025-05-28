Return-Path: <linux-fsdevel+bounces-49975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EFAAC6914
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 14:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3AAC1BC73BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 12:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7382857CA;
	Wed, 28 May 2025 12:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="V1xdKxUu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB012857C6;
	Wed, 28 May 2025 12:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748434703; cv=none; b=Q4caT1fhwmLz7E38f4/6rkYfyilD8QoochvWUeNts462REEyQmZSZ0xZLEi70wZjwi8sRmkNY8oe4FdI3hQPlC4AZgdzy1hlFsGT6yRQe6sgKDsGUAVgPsEw99N9RpS09aDksV0NlUFwGJyzcu3H8qxe5gqhKnfSwrTViLBg5Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748434703; c=relaxed/simple;
	bh=uOnOxiGiRtFBPj6Dx2RM0uaCIdaV8RxF4Qr13HjkeOA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dbHWnEd0wKezJF7MOcpjUQCheGtq45+dGNRqcQxExg38fEvKYOHk3gWMpnvthbGoCUUEBgYEvUaPPtvkkUj9WHO5qH5RRHsNK6Dag+TW2ZKD+VlMPt/tuGaXfRD7HWieIYUsw+WVLW46NyOhoMyzO4flzgQDxBlVpy1qXxZmVpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=V1xdKxUu; arc=none smtp.client-ip=185.70.43.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1748434693; x=1748693893;
	bh=uOnOxiGiRtFBPj6Dx2RM0uaCIdaV8RxF4Qr13HjkeOA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=V1xdKxUuzEhgw5ANtiZK8119K6kShVP7grRRaeaa1Y01FxhsEnCpNw7EvxdSW8jjz
	 y81Jf78Q8Zp6pgkoBNess1Lq4qnvTM8rmh8cqQcU12KlC3BLzuCu2lygXp6TbHN2go
	 ZYSFstqRksZPC8f93Vk5H1XnmY7tWLxLCAukSQ7gbbGx58LsjzrPquIdxxnYrISN5a
	 iRgjxb0nbMAc4ZOhLSEZpSqDJ07DrPrBMdFlYr81bqwMIPYqoRVIzxUkwLFn0BKXz+
	 DObzDLuzLzszveNBvwopkSSN/7klbhTMZ/KYCEA8q28Ic4IEE1Nrda2kxGZumjNft0
	 CbfhDKzewhvtw==
Date: Wed, 28 May 2025 12:18:11 +0000
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
From: Pekka Ristola <pekkarr@protonmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Jan Kara <jack@suse.cz>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rust: file: mark `LocalFile` as `repr(transparent)`
Message-ID: <a-h53UVYFV5_SzPX9oC8md8XoQLoabGTyT9utM2PavNqng5YUVxDRErEj5Eu19CZLmxQKc7rp1RiCmtaULw7mygUQ9cSUb5966WCLIQKwCQ=@protonmail.com>
In-Reply-To: <CANiq72kgu+qKBFOUfcsF9fJkq78p+uBA6KAnpY1Uz5McT0y=SA@mail.gmail.com>
References: <20250527204636.12573-1-pekkarr@protonmail.com> <CANiq72kgu+qKBFOUfcsF9fJkq78p+uBA6KAnpY1Uz5McT0y=SA@mail.gmail.com>
Feedback-ID: 29854222:user:proton
X-Pm-Message-ID: 34c9947c169696257b760e7dfd80b551cd248187
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wednesday, May 28th, 2025 at 13.52, Miguel Ojeda <miguel.ojeda.sandonis@=
gmail.com> wrote:

> On Tue, May 27, 2025 at 10:49=E2=80=AFPM Pekka Ristola <pekkarr@protonmai=
l.com> wrote:
>=20
> > Unsafe code in `LocalFile`'s methods assumes that the type has the same
> > layout as the inner `bindings::file`. This is not guaranteed by the def=
ault
> > struct representation in Rust, but requires specifying the `transparent=
`
> > representation.
> >=20
> > The `File` struct (which also wraps `bindings::file`) is already marked=
 as
> > `repr(transparent)`, so this change makes their layouts equivalent.
> >=20
> > Fixes: 851849824bb5 ("rust: file: add Rust abstraction for `struct file=
`")
> > Closes: https://github.com/Rust-for-Linux/linux/issues/1165
> > Signed-off-by: Pekka Ristola pekkarr@protonmail.com
>=20
>=20
> Thanks Pekka, both patches look good to me. I will close the issue
> when Christian applies them (or if I should take them, that is good
> too).

Thanks, I'm glad it went smoothly since this was my first patch to the
mailing list.

Pekka

