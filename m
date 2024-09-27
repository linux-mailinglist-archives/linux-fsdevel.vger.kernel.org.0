Return-Path: <linux-fsdevel+bounces-30234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6354D9880F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 11:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BC201F213ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 09:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559A018A6CE;
	Fri, 27 Sep 2024 09:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="SLJgvnan"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9979618784A;
	Fri, 27 Sep 2024 09:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727427607; cv=none; b=XsmDLUa0m69IJrZEpmTeRC7HbWBNy9aJsw5lq7/XrHYICc696D72UEyig+FQuUgKWCBCDnni6ucEpPtgL8T+85C+ZurSvJxqmdoni3cs2iJxeRJV5nre5mqVazg8wXN9bb43bfFBYTh+DJxCcnxLMloFh6BGaEFPaB6wJgw2+gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727427607; c=relaxed/simple;
	bh=NCPx3oyoIORdORbeMUU52vP2IIzunctq8Og5kXekV4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W8GGtyw5tUJpp1DtVFnUbtXOLNQ8jMDBXWJzEBRpOewXnNreQzt1fxVqurDHpEtZ5ylZ1ITVju9GXhVejq1TWjWP+CCtEpttgjw/Wcud6FY4xEnBqQJi+jLbS+zfLjE6aQOxBnGdycqTd5hDJPft7TPTut+GpAwRFZ4PPY8PtmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=SLJgvnan; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1727427601; bh=XDsaYEQJSqlM/dsX+Q8V0Fi1KLK/ALVyoM+CJIpv0AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SLJgvnanfwRxOijicIZH9MJ7/5JoOTmBpGBWhOh4jB8p+vwA062qQCc08+OhewMr1
	 gBtciZy9mgCHPJ9pA5P2NLYP5J0dsT5e0nIruxf2hQe1S+oU2BwiEh6eCU8mKgolRF
	 YgfMprLlgOXL3rCTJO0Kgpqqh4T7rsKTzi9Puaq4=
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] rust: types: add Opaque::try_ffi_init
Date: Fri, 27 Sep 2024 11:00:00 +0200
Message-ID: <583DE983-D767-4941-AAA7-D56D0E3C2782@kloenk.dev>
In-Reply-To: <20240926-b4-miscdevice-v1-1-7349c2b2837a@google.com>
References: <20240926-b4-miscdevice-v1-0-7349c2b2837a@google.com>
 <20240926-b4-miscdevice-v1-1-7349c2b2837a@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable



On 26 Sep 2024, at 16:58, Alice Ryhl wrote:

> This will be used by the miscdevice abstractions, as the C function
> `misc_register` is fallible.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---

Reviewed-by: Fiona Behrens <me@kloenk.dev>


>  rust/kernel/types.rs | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 3238ffaab031..dd9c606c515c 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -299,6 +299,22 @@ pub fn ffi_init(init_func: impl FnOnce(*mut T)) ->=
 impl PinInit<Self> {
>          }
>      }
>
> +    /// Creates a fallible pin-initializer from the given initializer =
closure.
> +    ///
> +    /// The returned initializer calls the given closure with the poin=
ter to the inner `T` of this
> +    /// `Opaque`. Since this memory is uninitialized, the closure is n=
ot allowed to read from it.
> +    ///
> +    /// This function is safe, because the `T` inside of an `Opaque` i=
s allowed to be
> +    /// uninitialized. Additionally, access to the inner `T` requires =
`unsafe`, so the caller needs
> +    /// to verify at that point that the inner value is valid.
> +    pub fn try_ffi_init<E>(
> +        init_func: impl FnOnce(*mut T) -> Result<(), E>,
> +    ) -> impl PinInit<Self, E> {
> +        // SAFETY: We contain a `MaybeUninit`, so it is OK for the `in=
it_func` to not fully
> +        // initialize the `T`.
> +        unsafe { init::pin_init_from_closure::<_, E>(move |slot| init_=
func(Self::raw_get(slot))) }
> +    }
> +
>      /// Returns a raw pointer to the opaque data.
>      pub const fn get(&self) -> *mut T {
>          UnsafeCell::get(&self.value).cast::<T>()
>
> -- =

> 2.46.0.792.g87dc391469-goog

