Return-Path: <linux-fsdevel+bounces-41816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C83DCA3798D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 02:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82E1A168423
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 01:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE5A1487D5;
	Mon, 17 Feb 2025 01:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvmUCB+u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C8913C8EA;
	Mon, 17 Feb 2025 01:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739757547; cv=none; b=aH5SiWMNr7KAk+xgn9To8vrB4J1ldeyNpanvCQDK6cY0ovwltuxjn1Je1ghbFxVntcgBfn5EGJV7Z6+E4K5o3Q2HoHXAQvvRaYFzYuevIkTdkV7HnVK6mhK/oSYIiidkihVaOpxplD2jKFO75J0vsDL/OYQ/A9D1sc4ZEzWa3ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739757547; c=relaxed/simple;
	bh=qrBdUUzn/c2+kWZP64lRZLW82I3fxEupV0fKMARD7Rc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H+UUw50Aw8vfK3BaQrshfmhFKkg3iKSmL9syroepzXKRZQzHv7B4vRfk/Mopq9Bvh3RQqhklDNr0Grux9yECUpfaAIISRPhWn0qY+Xf0ysNWrZygcitfUhCtt3hTOtIGdoPrk6btNDSV/xtFWTbQwFf/Jf3kA0Qnmmgz96aOPgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvmUCB+u; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54529eeb38aso2634207e87.2;
        Sun, 16 Feb 2025 17:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739757543; x=1740362343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUoXJmnwLpnmj3OOHz3frrmLOV1F7Z9/EcBY2hSMhlY=;
        b=EvmUCB+uv4mKfQT5f5bjsXUzo0KJQQ6FcyaBaNcM37CHFuE7X0qqDuQ6vTg7xvVl7P
         DZJmJUJZ1t8aloIJopogah2HLwPcf6E2N1LouMOXFmn7gxd1IKVx1tLyrD9lyw0JVGz9
         XXmUJ9ndfICen2PiZQhxVvfY5IzukNBqzfin1hGBTFwsuQnayJO7GiTN+0KJq+A4iOTm
         zTSBMDSPNo7GA3jezM/HvBJloeIrVK2/V8c0q7XtN+8uZqn0ScQe8AwJSh/ZPrzb5lTX
         d20jGe+1G1ooVfVpQagXAU42MjxIT3yIi7R9dklDffyVirYGhExkBN03Xt5L/iZLWzhz
         Rkmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739757543; x=1740362343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tUoXJmnwLpnmj3OOHz3frrmLOV1F7Z9/EcBY2hSMhlY=;
        b=r6ahyUrPMoLLFm+voaCm0Rp4WleZWVbUnwVykV7FsQgN9aykSgtJVVHQf1s5X1C8D/
         Lv6WooFW+Kz2xUGDxaZ5rs4Wh2DZN3wPHMysEVuFFFmmYLTgizCVj66ux8e6ClLOJOh5
         biiDZZHmTJO7NlJlgHg88rWwo+/YS7bVdgx9uwRcCxfyDGFgJEgLYw7LdMrsfZMabyoV
         5BN8TU+Q8G005Osgyx7xXO8WFktYLocJkT8LGR+22jD9pE8bRf/VV5KX/ovscoeSWonB
         2O4HKM9L2FgQblxt4PX4UB86tPpoQf3MVhOpGsCNx4PKvxjwKahpOXBzxtN7ZXZz5Y9q
         TcxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDyRi7TWLAWx1528yS/mm3WDAeEVBYbyOdNBAISoxsiT1V80XBF2UJ+r0iPaoPka6a212mhUjd6AYo@vger.kernel.org, AJvYcCUQi4CM/xl1QjfQ24D1rGQdsk3DIhpFX2fi8GiZ3Zmjq/CH9D27Ev/5+Ssm3h6pe7LIXpeaUJCna0dI02uU@vger.kernel.org, AJvYcCVgmig8TKBzWgacJRWwO7b7XgTW/mUPWGWq6cpqwcQJXxkhnHUefN3yuZbS+ASdUP955nVUnYNWqYsUmrPE@vger.kernel.org, AJvYcCXVO4SlqeA61nlG5puLdtZ4zvamWJXEHKaUhKZO2H4IYgDVcxPvNInhZ4/34ALht4fK6NOgr/j1BA5p+ChJZCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUnlFsNuDgImN8tJqrZ+XNJhtfId94kvBf1qbTXPHbYvPxHJu2
	yao4qZhpt11Cgy0PsG4LTARrPkz1SACmRDM5+XVhsLTigvtD5R8kPFq5CzZwQc89tgHxtbwCu8c
	IjStvtVSigQpRwaDO++Iz4/TPFKE=
X-Gm-Gg: ASbGnctUzsM3ywNVuCc268ANlfeIPaqznHgo/wPBnG8IUKJkWOE2CwZcif9GUz2xEsR
	7IbAbL5cIgI8pPsdXWBms6ESgtUnqfEc2Db18lN65P1ZSeyaUKYy89PUqQVdG18LTLWjiKHA53E
	D7wfTOMdInzGL9W11r7P3+gd7pRTNLxlk=
X-Google-Smtp-Source: AGHT+IEoMShy52NGy3PEC2IwHz3gdRZDwYYZFVffmPGxVRYp7qsQCGC6Djl7RsJDcz7ap48T1sRdL7Fb8Uoid41YSj4=
X-Received: by 2002:a05:6512:1194:b0:545:102f:8788 with SMTP id
 2adb3069b0e04-5452fe485d4mr2399912e87.19.1739757543185; Sun, 16 Feb 2025
 17:59:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207-rust-xarray-bindings-v16-0-256b0cf936bd@gmail.com>
 <20250207-rust-xarray-bindings-v16-2-256b0cf936bd@gmail.com> <96d799a7-ec70-4d3f-951b-52c56b545255@proton.me>
In-Reply-To: <96d799a7-ec70-4d3f-951b-52c56b545255@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 16 Feb 2025 20:58:27 -0500
X-Gm-Features: AWEUYZl7QPySmiOwtQ3cZuVsbg9zM2Ta3RU49N3UwfR8ssyiFeRahnKYhUoPDy4
Message-ID: <CAJ-ks9nemf0XbVhEMeDVRq0SBcdMRUJn3Pmfotbx5CJBj7QTTQ@mail.gmail.com>
Subject: Re: [PATCH v16 2/4] rust: types: add `ForeignOwnable::PointedTo`
To: Benno Lossin <benno.lossin@proton.me>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Matthew Wilcox <willy@infradead.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	"Rob Herring (Arm)" <robh@kernel.org>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, Fiona Behrens <me@kloenk.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2025 at 8:39=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On 07.02.25 14:58, Tamir Duberstein wrote:
> > Allow implementors to specify the foreign pointer type; this exposes
> > information about the pointed-to type such as its alignment.
> >
> > This requires the trait to be `unsafe` since it is now possible for
> > implementors to break soundness by returning a misaligned pointer.
> >
> > Encoding the pointer type in the trait (and avoiding pointer casts)
> > allows the compiler to check that implementors return the correct
> > pointer type. This is preferable to directly encoding the alignment in
> > the trait using a constant as the compiler would be unable to check it.
> >
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> > Reviewed-by: Fiona Behrens <me@kloenk.dev>
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> >  rust/kernel/alloc/kbox.rs | 38 ++++++++++++++++++++------------------
> >  rust/kernel/miscdevice.rs |  7 ++++++-
> >  rust/kernel/pci.rs        |  2 ++
> >  rust/kernel/platform.rs   |  2 ++
> >  rust/kernel/sync/arc.rs   | 21 ++++++++++++---------
> >  rust/kernel/types.rs      | 46 +++++++++++++++++++++++++++++++--------=
-------
> >  6 files changed, 73 insertions(+), 43 deletions(-)
>
> When compiling this (on top of rust-next), I get the following error:
>
>     error[E0308]: mismatched types
>        --> rust/kernel/miscdevice.rs:300:62
>         |
>     300 |     let device =3D unsafe { <T::Ptr as ForeignOwnable>::borrow(=
private) };
>         |                           ---------------------------------- ^^=
^^^^^ expected `*mut <<T as MiscDevice>::Ptr as ForeignOwnable>::PointedTo`=
, found `*mut c_void`
>         |                           |
>         |                           arguments to this function are incorr=
ect
>         |
>         =3D note: expected raw pointer `*mut <<T as MiscDevice>::Ptr as F=
oreignOwnable>::PointedTo`
>                    found raw pointer `*mut c_void`
>         =3D help: consider constraining the associated type `<<T as MiscD=
evice>::Ptr as ForeignOwnable>::PointedTo` to `c_void` or calling a method =
that returns `<<T as MiscDevice>::Ptr as ForeignOwnable>::PointedTo`
>         =3D note: for more information, visit https://doc.rust-lang.org/b=
ook/ch19-03-advanced-traits.html
>     note: associated function defined here
>        --> rust/kernel/types.rs:98:15
>         |
>     98  |     unsafe fn borrow<'a>(ptr: *mut Self::PointedTo) -> Self::Bo=
rrowed<'a>;
>         |               ^^^^^^
>
>     error: aborting due to 1 previous error
>
> Can anyone reproduce?
>
> ---
> Cheers,
> Benno
>

Looks like this code is behind #[cfg(CONFIG_COMPAT)] and I missed
updating it. It is fixed by

diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index f1a081dd64c7..004dc87f441f 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -296,6 +296,7 @@ impl<T: MiscDevice> VtableHelper<T> {
 ) -> c_long {
     // SAFETY: The compat ioctl call of a file can access the private data=
.
     let private =3D unsafe { (*file).private_data };
+    let private =3D private.cast();
     // SAFETY: Ioctl calls can borrow the private data of the file.
     let device =3D unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };

I'll include that in the next version.

