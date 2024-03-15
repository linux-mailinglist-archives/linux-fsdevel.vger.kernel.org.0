Return-Path: <linux-fsdevel+bounces-14437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3B187CD25
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 13:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85EF82838D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 12:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F5E1C694;
	Fri, 15 Mar 2024 12:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="IyfTnT7k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A68A1C696;
	Fri, 15 Mar 2024 12:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710505196; cv=none; b=hVEnm0oqFbykyB1GQy4y8RvLNpLsFy+VrXstnaoEZYovBBphX5hjzQmaL35QL1nqOUJAGN35pO02QDMZE9CpNieXQT0HTVc0DSlftW5x2CKX1i+bUssrJOpwjJf8SjwZrSUj8oMRBEVx2Ntn9LeZCMdVwV34FrEF4eONuJ4P1KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710505196; c=relaxed/simple;
	bh=eQPV+J4zFpjgNX9cMFlMvAWLLEHvyDyujFkI7bIr9pM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YhkfoXi8twWUEN8Nzpo4hzUa0KWwT+VQgcj8FWUaQfGc50weUNQq+UNNQGmcFe9Ro0SNYu7YeUuWeCgkeAUkfQn0CR2xZYUDoSHZx01ywOicCnZTK5G0rJfB7slB2v24b77xp/DNkJT4efAg0ximhHcFAUdXW1AuixV8akDOABU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=IyfTnT7k; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=2egbhkk2rfd2hpbcyznjwx537u.protonmail; t=1710505190; x=1710764390;
	bh=65NwudR1lOE2ENn7UhnnlxMGQQyUDmaHvqbnfkcSrss=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=IyfTnT7kgrPFoIQsjxjP1kDxpU92URnkX1avKOwjXRO1vqiyFPmRU1Qy8251b1aCM
	 YLXUcaWd5qWSxKhBO5TtI/pRlzznboUrWBSeIRb14Q37wFuMUqKc9VpTQyQsrxbrjg
	 W/94wCWnUv1z/VvrIVdYh+21XM2xNHX6hvaw8fcEvF+kGUb/8TwYjygu0KWZbdWhYW
	 QHWcS77DIf/MX+T9UyxLYaaM8fxUPWRawsK8MgauCbTcVg+iqTcNuiKzgaejSONG+l
	 drZ9V9COFjkA2Ov/YL3cyudCAROCAQTeV6SQ4VNob6AemjwAXmPAhbrWz/n3O1dQdQ
	 Z097QCyrI22qA==
Date: Fri, 15 Mar 2024 12:19:42 +0000
To: =?utf-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Matthew Wilcox <willy@infradead.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, kernel-dev@igalia.com
Subject: Re: [PATCH v8 1/2] rust: types: add FOREIGN_ALIGN to ForeignOwnable
Message-ID: <b73d15ac-49b4-497c-a5ea-4756e2704290@proton.me>
In-Reply-To: <20240309235927.168915-3-mcanal@igalia.com>
References: <20240309235927.168915-2-mcanal@igalia.com> <20240309235927.168915-3-mcanal@igalia.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/10/24 00:57, Ma=C3=ADra Canal wrote:
> There are cases where we need to check the alignment of the pointers
> returned by `into_foreign`. Currently, this is not possible to be done
> at build time. Therefore, add a property to the trait ForeignOwnable,
> which specifies the alignment of the pointers returned by
> `into_foreign`.
>=20
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> ---
>   rust/kernel/sync/arc.rs | 2 ++
>   rust/kernel/types.rs    | 7 +++++++
>   2 files changed, 9 insertions(+)
>=20
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 7d4c4bf58388..da5c8cc325b6 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -274,6 +274,8 @@ pub fn ptr_eq(this: &Self, other: &Self) -> bool {
>   }
>=20
>   impl<T: 'static> ForeignOwnable for Arc<T> {
> +    const FOREIGN_ALIGN: usize =3D core::mem::align_of::<ArcInner<T>>();
> +
>       type Borrowed<'a> =3D ArcBorrow<'a, T>;
>=20
>       fn into_foreign(self) -> *const core::ffi::c_void {
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index aa77bad9bce4..76cd4226dd35 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -20,6 +20,9 @@
>   /// This trait is meant to be used in cases when Rust objects are store=
d in C objects and
>   /// eventually "freed" back to Rust.
>   pub trait ForeignOwnable: Sized {
> +    /// The alignment of pointers returned by `into_foreign`.
> +    const FOREIGN_ALIGN: usize;
> +

I think we need to make the trait `unsafe`, since we want `unsafe` code
to be able to rely on this value being correct.

--=20
Cheers,
Benno

>       /// Type of values borrowed between calls to [`ForeignOwnable::into=
_foreign`] and
>       /// [`ForeignOwnable::from_foreign`].
>       type Borrowed<'a>;
> @@ -68,6 +71,8 @@ unsafe fn try_from_foreign(ptr: *const core::ffi::c_voi=
d) -> Option<Self> {
>   }
>=20
>   impl<T: 'static> ForeignOwnable for Box<T> {
> +    const FOREIGN_ALIGN: usize =3D core::mem::align_of::<T>();
> +
>       type Borrowed<'a> =3D &'a T;
>=20
>       fn into_foreign(self) -> *const core::ffi::c_void {
> @@ -90,6 +95,8 @@ unsafe fn from_foreign(ptr: *const core::ffi::c_void) -=
> Self {
>   }
>=20
>   impl ForeignOwnable for () {
> +    const FOREIGN_ALIGN: usize =3D core::mem::align_of::<()>();
> +
>       type Borrowed<'a> =3D ();
>=20
>       fn into_foreign(self) -> *const core::ffi::c_void {
> --
> 2.43.0
>=20


