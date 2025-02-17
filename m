Return-Path: <linux-fsdevel+bounces-41815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E95A3797D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 02:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E71A1886FFC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 01:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECAE54652;
	Mon, 17 Feb 2025 01:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="lG3nEJqN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4429F33DF
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Feb 2025 01:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739756391; cv=none; b=kgxF0t4eMo/Ekuc8nl7NskWjPvvFKl+EDPNBS0lU/EZWB2lMQ1qNvlA8AVERyR91JWgeAjLQq/IXBKzeqHxUeULZne2/Y7PvpDTc0d1xobNsZlRC3k5SzRre47fTk5pqLuxlyAn3yWy+yzWPT+wQAtab0fJ5Ju1dSIysqN9V1Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739756391; c=relaxed/simple;
	bh=BuQYXFVdDJPPhv1pziXzthdB75Ya4reXuJeQX0zuavI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TGl9Q50oziwfcz25j9+jJq2d2YwOpWt0/Rvy9FneXde3UZKkZvDkCvdYO4SJTq38KYqm3oLwxCiDrCiRF2MYJFg/YYD7QBuyRKr6t8jYe08QrY2yBmx0JGUpsXQobRJyiFg7peNf+etLug3/pyv7GGHbYpdrmFAY38r509/ZnZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=lG3nEJqN; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1739756387; x=1740015587;
	bh=LNKYDRqDPh1bV1rGmlu4ASajTHrQBDpcbKn79N6aAqs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=lG3nEJqNEfBjTDUxCWnBqj/hJTGFDXPKfruXfQmni+zvYFDHOF5FhOa006u42lSoo
	 J8ZfqnfJ6A1aZid5svRtTyL9V0LYBURORD5GWbfauiEkissoO/e3tPTfDxAJrzdP+C
	 LA1hiK9QSIRV+igFN4a44vyMI9yhyTuBGqeA8hGjkGd67hALji1JDCOPgPC8QGLWju
	 iLH46Ac8dL9+M3smESf7FVjLreryjQ3yMuEYoTINpyD1fol/oMqucC4tOtPUynLscy
	 PO4zynOWUwWH0mpU1yRzXqyyPQHnh9gSUxE/He/3HTKuWtkT/bs7Z89zek+JR6PVFb
	 lQ6fzc7jld4Iw==
Date: Mon, 17 Feb 2025 01:39:40 +0000
To: Tamir Duberstein <tamird@gmail.com>, Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Matthew Wilcox <willy@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, FUJITA Tomonori <fujita.tomonori@gmail.com>, "Rob Herring (Arm)" <robh@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: =?utf-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, Fiona Behrens <me@kloenk.dev>
Subject: Re: [PATCH v16 2/4] rust: types: add `ForeignOwnable::PointedTo`
Message-ID: <96d799a7-ec70-4d3f-951b-52c56b545255@proton.me>
In-Reply-To: <20250207-rust-xarray-bindings-v16-2-256b0cf936bd@gmail.com>
References: <20250207-rust-xarray-bindings-v16-0-256b0cf936bd@gmail.com> <20250207-rust-xarray-bindings-v16-2-256b0cf936bd@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 74555bcf96b0441dbbd7381c1fe15a43bf637c32
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07.02.25 14:58, Tamir Duberstein wrote:
> Allow implementors to specify the foreign pointer type; this exposes
> information about the pointed-to type such as its alignment.
>=20
> This requires the trait to be `unsafe` since it is now possible for
> implementors to break soundness by returning a misaligned pointer.
>=20
> Encoding the pointer type in the trait (and avoiding pointer casts)
> allows the compiler to check that implementors return the correct
> pointer type. This is preferable to directly encoding the alignment in
> the trait using a constant as the compiler would be unable to check it.
>=20
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Reviewed-by: Fiona Behrens <me@kloenk.dev>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  rust/kernel/alloc/kbox.rs | 38 ++++++++++++++++++++------------------
>  rust/kernel/miscdevice.rs |  7 ++++++-
>  rust/kernel/pci.rs        |  2 ++
>  rust/kernel/platform.rs   |  2 ++
>  rust/kernel/sync/arc.rs   | 21 ++++++++++++---------
>  rust/kernel/types.rs      | 46 +++++++++++++++++++++++++++++++----------=
-----
>  6 files changed, 73 insertions(+), 43 deletions(-)

When compiling this (on top of rust-next), I get the following error:

    error[E0308]: mismatched types
       --> rust/kernel/miscdevice.rs:300:62
        |
    300 |     let device =3D unsafe { <T::Ptr as ForeignOwnable>::borrow(pr=
ivate) };
        |                           ---------------------------------- ^^^^=
^^^ expected `*mut <<T as MiscDevice>::Ptr as ForeignOwnable>::PointedTo`, =
found `*mut c_void`
        |                           |
        |                           arguments to this function are incorrec=
t
        |
        =3D note: expected raw pointer `*mut <<T as MiscDevice>::Ptr as For=
eignOwnable>::PointedTo`
                   found raw pointer `*mut c_void`
        =3D help: consider constraining the associated type `<<T as MiscDev=
ice>::Ptr as ForeignOwnable>::PointedTo` to `c_void` or calling a method th=
at returns `<<T as MiscDevice>::Ptr as ForeignOwnable>::PointedTo`
        =3D note: for more information, visit https://doc.rust-lang.org/boo=
k/ch19-03-advanced-traits.html
    note: associated function defined here
       --> rust/kernel/types.rs:98:15
        |
    98  |     unsafe fn borrow<'a>(ptr: *mut Self::PointedTo) -> Self::Borr=
owed<'a>;
        |               ^^^^^^
   =20
    error: aborting due to 1 previous error

Can anyone reproduce?

---
Cheers,
Benno


