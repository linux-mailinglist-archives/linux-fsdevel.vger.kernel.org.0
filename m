Return-Path: <linux-fsdevel+bounces-32850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4139AF8C5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 06:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEFD01C22B25
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 04:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E948D18C915;
	Fri, 25 Oct 2024 04:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="XsiTcJZt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC263611B
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2024 04:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729829425; cv=none; b=sRkL48cwDdfZ8ioCAKAfqBFKD3Cvcf2Unl/tun3GS6e3Q0nGuqCsoAI7mCcPFlp06JocwX/DBBhKUBJVPLIctJn4Ag/9sfo9EMkQaFmCMhyQbV9DxLyyI//7jI9DcuReeIKDKbUTuf13FVSVPGUdDfi6ggKwwpjiS0Tl7yNqvL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729829425; c=relaxed/simple;
	bh=ekdJWWct6csrgu0g3q5eQ/4BZKKv6zAydS4GjVC4oKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rswNUWkmI5rbLbGXHB4ICbPhYxKw1Af4CxxTq10x+fTNIkRSzuX12RMqriqWwDdKjhbXIgNTeYTvl6bbCvVq0Iwng/OlbxXjKfqI8pi1GDpqLJOIbxCkG4zeiuRPvhHeGVQlw9VQEnxFES1a5RlXJM0RLExAWPqQ1ksMlbIdiwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=XsiTcJZt; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e5fadb5e23so14840217b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 21:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1729829421; x=1730434221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1IUI/Dv7tIqR57YCOc1ojUu2ND9yCjRYfTcqCJ6tlg=;
        b=XsiTcJZt/kvwxxuwjK2mIW3fryNvVfNF/PSKw0KAnW4nHJNz93eKzVIsWmb8x+UhVo
         AkpJOO4F3dw4SPohytlDLN5kAqEdzCeHnDXhhEmlnb+cOEvOg02qMKVeXxuggICdUH5f
         eOcM1+3/xAXdzIajZuLT6HF6TaJ9n9p4c8JLzRgf+B8P8qLTnEHieJ74qQdDoWJWBnIV
         h9BEl5LZBtlTTaVsmfqo2QJli9/1BCSdmUtwrl45EK6MNujht1hT6Bj6KLWwT9yOzyZX
         +vJftNqhTpFB8Fk+IVGXaM1h/iej2z0u2w1FkF2d7r0EQnUvoi14ARNrgetuprPWKYNL
         0+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729829421; x=1730434221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b1IUI/Dv7tIqR57YCOc1ojUu2ND9yCjRYfTcqCJ6tlg=;
        b=j0FOhSBh2jo3gspfJ/CN/9YldOobH6kp6RqPEmdgB81FCOPZR85KKGVobMWDrAeWmE
         9JTBex+IKIS6N/SKd3IW/Ol+t2SvNP4WwXilIuxk95/n9NpH2GcytZdAXkf9fr/Rqk9z
         apVjV8gwe4JKD5EsTI16IE36M9pjTAegGRUX74FVCBsVAUJPZWTCFu+GFFs0wfGmRejy
         TXy2jKueg3yiLTAvbXGMa9HftxcTNW00dUfi/b4Oew48RnmB0EUSMexWCDXijGHREoK4
         vkUIYJ2za6/dWDRr70PxMQM54zw0AAfDlK9+OfgpQ2KUNfxOlSL6Z5t1ebXutiqUDaFj
         hXXg==
X-Forwarded-Encrypted: i=1; AJvYcCXEFrj7tSocZjDmUhh4MO9c6PxGIEdLM9A0WCUOEGf1XSsC842NCYZvAqJ0H54Y+ggKkgnEH4KUlYbYcQ1H@vger.kernel.org
X-Gm-Message-State: AOJu0YxMF44VJA3ERFhJPdINX/TJdF+XL2OD5+NAQMvS+KeB/RhBtd+z
	v0Yy6+hUuYqeJVqdm+AcgIIcd4v2fl82rIbeWtTrLHnquujLnrVpgYXQskkvDPCc+mQJVZsaySg
	GzxTbgJuSWpkb2egeKuWO1B88XmWz3yPYLbTQkg==
X-Google-Smtp-Source: AGHT+IHcK0AVcQUDIMsT5GR4MQ8q5gxpZbDoGV4WWKNOcxg9dr5CYVu9m9eOZ4ZodKrAUOmLJSUvoxDXs2zYREtYdNA=
X-Received: by 2002:a05:690c:ec1:b0:6e3:430c:b120 with SMTP id
 00721157ae682-6e85814c704mr43629697b3.5.1729829421356; Thu, 24 Oct 2024
 21:10:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001-b4-miscdevice-v2-0-330d760041fa@google.com> <20241001-b4-miscdevice-v2-1-330d760041fa@google.com>
In-Reply-To: <20241001-b4-miscdevice-v2-1-330d760041fa@google.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Thu, 24 Oct 2024 23:10:10 -0500
Message-ID: <CALNs47tbt46VAcT5rm0Y6QBP6kc4ocBFDPOZugthPmNdaHrwPQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rust: types: add Opaque::try_ffi_init
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Miguel Ojeda <ojeda@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 3:23=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> This will be used by the miscdevice abstractions, as the C function
> `misc_register` is fallible.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/types.rs | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 9e7ca066355c..070d03152937 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -299,6 +299,22 @@ pub fn ffi_init(init_func: impl FnOnce(*mut T)) -> i=
mpl PinInit<Self> {
>          }
>      }
>
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

[1] adjusts `ffi_init` to use `try_ffi_init`. Maybe this should do the same=
?

[1]: https://lore.kernel.org/rust-for-linux/20241022213221.2383-2-dakr@kern=
el.org/

