Return-Path: <linux-fsdevel+bounces-41104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B2CA2AEC1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 18:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E72BD7A2F11
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 17:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCF1165F01;
	Thu,  6 Feb 2025 17:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aykkiNeM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D8B239572;
	Thu,  6 Feb 2025 17:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738862592; cv=none; b=Bz7LqsRfCRI855vcS3z1O+jtKAeuVIaRMqYPz1Qw345ehgAWeUJ6JD/oDFk5tbIfTDbAmLVSPgm0cXtRL2dkG//23wjMW8DnrU3/Jcx5m+2ROIuLyRjm13vQ3SrMMOC4trapgWedGHboCDolzMWAISzGk8Ln/xTeawYuWnOe/jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738862592; c=relaxed/simple;
	bh=aOlIb3GrtUb94/9tx8SwRQttF+ZHn3JmSd+o6phwsIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=psxO7tp0at4xDsI6M/vQp9q+AQaYkg5jpNvIOskL/WKlCj2pu9kfYxnn13rYWmnySIvpXPL+gxK39EEhrl4Q2DIAFh/+w4qHtuX5fA0lOuiACf8i6uWZWBSz/7F3j4TJJl/P4m83/su1Rum0uT/xE0fRdHSLoz8fUSANDjQkRao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aykkiNeM; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30737db1ab1so9773311fa.1;
        Thu, 06 Feb 2025 09:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738862589; x=1739467389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CtS2LSS0vjwz5nne7JgrymnedyIyoSCc7U6z284XAgw=;
        b=aykkiNeMFDqczhSbAD5It5yAjvjIEmKurj2wP0c+EU9naB7LRvBEomgTpV49XJeUnY
         RsVtHKhgTPZSOwFAuSpr8SlwkEFemsgU7sO2reNt6wjHFPUZ8H2ezu/4IfcgVx8GX7LH
         CVh0FTufqq7aJnsLZd9b0isxZFl+Qce5sfHyDJ53uHRIlx7X2lQ+2pGemf3DxmQaMRev
         LauFrn+/etVJxD+qyKg77fmmhwB9KYvB41Bj9l3hvYBz3H7fa/zxJfTLPBIgh/Kv65zq
         wrb11VSsuypLT5L2Odlgs5W7XS9WOqxluBeMHVZfNtD/X5lnj3BJ7CUD7ImUKV9xKNeT
         pZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738862589; x=1739467389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CtS2LSS0vjwz5nne7JgrymnedyIyoSCc7U6z284XAgw=;
        b=Nc3DYJimYuZr/adZUbEIcX+LP56qgdW6NUk0OKlVi13C4nFlIpyvYp/52Ufd3i1wgh
         FFPa5IkT7jRiMbXRPtcOce2jz2odPfPs7cTPFDt1ZYKit8j2WJ26TH6wU5E8z1K9JWJ0
         Y/sgJAslQNMUtetlO8SsjLE4BTkmgswJuWiuHKmt1MvF49G/OjrBktud92+j17HxNgb9
         eptBelMxlO3XhCYz3kMqR055QhdGjwixZ8YLsa/JwrnzucDRBWZWUG8GtCcKy+m1l/bI
         6FZ+KZ8hymttkFwIgVqotzx4vibKOOHmo7u8KMR90yayorBPJAI9zB7uhLLMU3JVnSMZ
         JMsg==
X-Forwarded-Encrypted: i=1; AJvYcCVjGUnM2NQ7+YeEsL0UPisaEmS9MWCDl+fH6LoBsLA0M9TNgCjSpK/FBXjwDeelPommKnKv1pCXaz2OPDQhgog=@vger.kernel.org, AJvYcCVuGTHWJw0OzKjEvHAUu9DQQp+ACi+RbYSoVx7MLun6EndbcSXO1Y2CgnOflIJ/ZU0f8gHiknc2wSee@vger.kernel.org, AJvYcCXK8v1rywsNSbj+m/WY8gA9/ilmkcrUsp1KsK/61yc5bXwHooFdUaxX63PhdTucM8P9mNEenOs3rP8rqmCH@vger.kernel.org, AJvYcCXsnxuVmwkRstHUQ0TCX8QkDo5vntfaqqv0ffhXnvdQp49cs1SgEJcDby6V+nEGuzWmAdZNLCAOLfcYPXHx@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4l+J1RwnERzvU4EOTKFLgPtdgpCTESbGpmZVXYRXXDiiFayEg
	FV2jxhT145AX0CB877En3GjmYxobhFvvQKyANuXDF69Ry3KiuFpWfdXF9lB0br6IbstoUpa2t+c
	OKHmeVWFVPSa53qqOzKi62TRztzY=
X-Gm-Gg: ASbGnctmCFF+yYOxzHkqCR/501Q9AkP2IqCNtr4UJtJvzGJaw8IeKVvXfJDXjn35gz5
	pt8AumxxUlRfHgasurgNIPlR5kbdenw69hDpV2xZR10IHqsk+bt5xgGnC0Q5mlt2OV0cIG1CPAy
	eygaFDpRXcmYCEiDn9IOp7eaQaW2rttg==
X-Google-Smtp-Source: AGHT+IFCKQidDHUSKUVfNzVCxtO4kJumyNyooPKxZlUf9l5k1u7tlukxnKOcJOAct8R4yY7ySfTSLrOK29uReAM9QWk=
X-Received: by 2002:a05:651c:509:b0:300:3e1c:b8b1 with SMTP id
 38308e7fff4ca-307cf3140b0mr32469311fa.18.1738862588347; Thu, 06 Feb 2025
 09:23:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206-rust-xarray-bindings-v15-0-a22b5dcacab3@gmail.com>
 <20250206-rust-xarray-bindings-v15-1-a22b5dcacab3@gmail.com> <Z6Tlsn2RIiE121Lg@cassiopeiae>
In-Reply-To: <Z6Tlsn2RIiE121Lg@cassiopeiae>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 6 Feb 2025 12:22:32 -0500
X-Gm-Features: AWEUYZlsb7hvkfENYsFn-FcmN-sfRN0LGVKAr5ROPUMS7Hi6j_4LKu_iYv0VAsw
Message-ID: <CAJ-ks9kzfM+U=UptZaafoxCHz-4Dtjxc8o1bpTe93+NEMwN5EA@mail.gmail.com>
Subject: Re: [PATCH v15 1/3] rust: types: add `ForeignOwnable::PointedTo`
To: Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Matthew Wilcox <willy@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	=?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 11:39=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Thu, Feb 06, 2025 at 11:24:43AM -0500, Tamir Duberstein wrote:
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
> > Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> >  rust/kernel/alloc/kbox.rs | 38 ++++++++++++++++++++------------------
> >  rust/kernel/miscdevice.rs |  7 ++++++-
> >  rust/kernel/pci.rs        |  5 ++++-
> >  rust/kernel/platform.rs   |  5 ++++-
> >  rust/kernel/sync/arc.rs   | 21 ++++++++++++---------
> >  rust/kernel/types.rs      | 46 +++++++++++++++++++++++++++++++--------=
-------
> >  6 files changed, 77 insertions(+), 45 deletions(-)
> >
> > diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
> > index e14433b2ab9d..f1a081dd64c7 100644
> > --- a/rust/kernel/miscdevice.rs
> > +++ b/rust/kernel/miscdevice.rs
> > @@ -225,13 +225,15 @@ impl<T: MiscDevice> VtableHelper<T> {
> >          Ok(ptr) =3D> ptr,
> >          Err(err) =3D> return err.to_errno(),
> >      };
> > +    let ptr =3D ptr.into_foreign();
> > +    let ptr =3D ptr.cast();
> >
> >      // This overwrites the private data with the value specified by th=
e user, changing the type of
> >      // this file's private data. All future accesses to the private da=
ta is performed by other
> >      // fops_* methods in this file, which all correctly cast the priva=
te data to the new type.
> >      //
> >      // SAFETY: The open call of a file can access the private data.
> > -    unsafe { (*raw_file).private_data =3D ptr.into_foreign() };
> > +    unsafe { (*raw_file).private_data =3D ptr };
>
> Why not just ptr.into_foreign().cast()?

That would work too. I was trying to move stuff out of the unsafe block.

> >
> >      0
> >  }
> > @@ -246,6 +248,7 @@ impl<T: MiscDevice> VtableHelper<T> {
> >  ) -> c_int {
> >      // SAFETY: The release call of a file owns the private data.
> >      let private =3D unsafe { (*file).private_data };
> > +    let private =3D private.cast();
> >      // SAFETY: The release call of a file owns the private data.
> >      let ptr =3D unsafe { <T::Ptr as ForeignOwnable>::from_foreign(priv=
ate) };
> >
> > @@ -267,6 +270,7 @@ impl<T: MiscDevice> VtableHelper<T> {
> >  ) -> c_long {
> >      // SAFETY: The ioctl call of a file can access the private data.
> >      let private =3D unsafe { (*file).private_data };
> > +    let private =3D private.cast();
> >      // SAFETY: Ioctl calls can borrow the private data of the file.
> >      let device =3D unsafe { <T::Ptr as ForeignOwnable>::borrow(private=
) };
> >
> > @@ -316,6 +320,7 @@ impl<T: MiscDevice> VtableHelper<T> {
> >  ) {
> >      // SAFETY: The release call of a file owns the private data.
> >      let private =3D unsafe { (*file).private_data };
> > +    let private =3D private.cast();
> >      // SAFETY: Ioctl calls can borrow the private data of the file.
> >      let device =3D unsafe { <T::Ptr as ForeignOwnable>::borrow(private=
) };
> >      // SAFETY:
> > diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> > index 4c98b5b9aa1e..eb25fabbff9c 100644
> > --- a/rust/kernel/pci.rs
> > +++ b/rust/kernel/pci.rs
> > @@ -72,10 +72,12 @@ extern "C" fn probe_callback(
> >
> >          match T::probe(&mut pdev, info) {
> >              Ok(data) =3D> {
> > +                let data =3D data.into_foreign();
> > +                let data =3D data.cast();
> >                  // Let the `struct pci_dev` own a reference of the dri=
ver's private data.
> >                  // SAFETY: By the type invariant `pdev.as_raw` returns=
 a valid pointer to a
> >                  // `struct pci_dev`.
> > -                unsafe { bindings::pci_set_drvdata(pdev.as_raw(), data=
.into_foreign() as _) };
> > +                unsafe { bindings::pci_set_drvdata(pdev.as_raw(), data=
) };
>
> This change isn't necessary for this patch, is it? I think it makes sense=
 to
> replace `as _` with cast(), but this should be a separate patch then.

Sure, I can make this a separate (prequel) patch.

> >              }
> >              Err(err) =3D> return Error::to_errno(err),
> >          }
> > @@ -87,6 +89,7 @@ extern "C" fn remove_callback(pdev: *mut bindings::pc=
i_dev) {
> >          // SAFETY: The PCI bus only ever calls the remove callback wit=
h a valid pointer to a
> >          // `struct pci_dev`.
> >          let ptr =3D unsafe { bindings::pci_get_drvdata(pdev) };
> > +        let ptr =3D ptr.cast();
> >
> >          // SAFETY: `remove_callback` is only ever called after a succe=
ssful call to
> >          // `probe_callback`, hence it's guaranteed that `ptr` points t=
o a valid and initialized
> > diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
> > index 50e6b0421813..53764cb7f804 100644
> > --- a/rust/kernel/platform.rs
> > +++ b/rust/kernel/platform.rs
> > @@ -63,10 +63,12 @@ extern "C" fn probe_callback(pdev: *mut bindings::p=
latform_device) -> kernel::ff
> >          let info =3D <Self as driver::Adapter>::id_info(pdev.as_ref())=
;
> >          match T::probe(&mut pdev, info) {
> >              Ok(data) =3D> {
> > +                let data =3D data.into_foreign();
> > +                let data =3D data.cast();
> >                  // Let the `struct platform_device` own a reference of=
 the driver's private data.
> >                  // SAFETY: By the type invariant `pdev.as_raw` returns=
 a valid pointer to a
> >                  // `struct platform_device`.
> > -                unsafe { bindings::platform_set_drvdata(pdev.as_raw(),=
 data.into_foreign() as _) };
> > +                unsafe { bindings::platform_set_drvdata(pdev.as_raw(),=
 data) };
>
> Same here.

Yep. Will do.

