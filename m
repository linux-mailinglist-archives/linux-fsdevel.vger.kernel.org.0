Return-Path: <linux-fsdevel+bounces-30447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F0598B77A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 10:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16921282B4F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 08:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8EF19D090;
	Tue,  1 Oct 2024 08:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="nz9t751U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C3C19B3F3
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Oct 2024 08:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727772401; cv=none; b=W4K3Mp0YuIZPdwJgdsebui7jomOz3tNJmI5AB1JQyEcCU7txOMV/47UmD7qfiOaq+DNhR5+/LONh1IIYA40cX65RkTh4XYtxTv3JzPN3Q7iaA+nDTA3dDvqkAVo3g39CSwAnb1kAL2KWqY5PrG35Oju0agHW3qJZ5E25MBhuCzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727772401; c=relaxed/simple;
	bh=n3Y6ASDlkI3ZkY4nGFCWmpxPfiDDBWBr1yndf3YF4vc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ihALtcx1pC9nBwUYzT5sn4NR9vw2D+Nsjg5lWbG0W29o4p2G+ZoQRD2f5zETWcrnf/aDPbO9TYG3GA0tV/D4y4pvLTA1/CxDlPFk3tQG5QoIaE8/Xn5QGQu8d89V1p7P4Ses9qeTDiF6O+zl7LrebpMAxRSUZW1ZXJsWpc9Y/ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=nz9t751U; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=hs6v3onqz5emdo3dj25npgdpvy.protonmail; t=1727772397; x=1728031597;
	bh=g1VQQYJsjsUnxadkJGJ8Fma6HLCkKyqxvROl+zkzNtA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=nz9t751Ub73yklIQj9ggK3GQji1z8rD84Iom4clLVB9MzLF8uye7YrAw4djPQN45f
	 Vpvlrwv3U6aFq6M9xlyolavJB81u4FDiLf/k8LX2XLd842Vk4cR0GRgR5Shrs+I0tn
	 0AK4aVG/aW8LIEwoAD7aRjyo/73dazax8+lFUvhnQg82uDkDCpfdgUgA69v7r24KYB
	 P7tMkHhbEpG2MXo1NxL/WpCyMANzmAaZq03y2HhUOAoAL0cKPdzyChDM7OtDOfu7XW
	 F8zEdsDGeUtirJxDHFz1iLz75ekwyUq9IjUhF/ABfcWzdNdDKRXqx3/zOrt+Lw79lt
	 xMfVqgNXmsmwQ==
Date: Tue, 01 Oct 2024 08:46:31 +0000
To: Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rust: types: add Opaque::try_ffi_init
Message-ID: <dca42b2e-f10f-45bc-bd79-ba86e78e3017@proton.me>
In-Reply-To: <20241001-b4-miscdevice-v2-1-330d760041fa@google.com>
References: <20241001-b4-miscdevice-v2-0-330d760041fa@google.com> <20241001-b4-miscdevice-v2-1-330d760041fa@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 4eb89e6f0ebb8860c65afe539cb44d414a1f2a39
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.10.24 10:22, Alice Ryhl wrote:
> This will be used by the miscdevice abstractions, as the C function
> `misc_register` is fallible.
>=20
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> ---
>  rust/kernel/types.rs | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 9e7ca066355c..070d03152937 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -299,6 +299,22 @@ pub fn ffi_init(init_func: impl FnOnce(*mut T)) -> i=
mpl PinInit<Self> {
>          }
>      }
>=20
> +    /// Creates a fallible pin-initializer from the given initializer cl=
osure.
> +    ///
> +    /// The returned initializer calls the given closure with the pointe=
r to the inner `T` of this
> +    /// `Opaque`. Since this memory is uninitialized, the closure is not=
 allowed to read from it.
> +    ///
> +    /// This function is safe, because the `T` inside of an `Opaque` is =
allowed to be
> +    /// uninitialized. Additionally, access to the inner `T` requires `u=
nsafe`, so the caller needs
> +    /// to verify at that point that the inner value is valid.
> +    pub fn try_ffi_init<E>(
> +        init_func: impl FnOnce(*mut T) -> Result<(), E>,
> +    ) -> impl PinInit<Self, E> {
> +        // SAFETY: We contain a `MaybeUninit`, so it is OK for the `init=
_func` to not fully
> +        // initialize the `T`.
> +        unsafe { init::pin_init_from_closure::<_, E>(move |slot| init_fu=
nc(Self::raw_get(slot))) }
> +    }
> +
>      /// Returns a raw pointer to the opaque data.
>      pub const fn get(&self) -> *mut T {
>          UnsafeCell::get(&self.value).cast::<T>()
>=20
> --
> 2.46.1.824.gd892dcdcdd-goog
>=20


