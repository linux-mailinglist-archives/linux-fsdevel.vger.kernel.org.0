Return-Path: <linux-fsdevel+bounces-41858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE3BA38555
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 15:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70752188510F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 14:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7558721D5AA;
	Mon, 17 Feb 2025 14:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSkZQWmm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EDD21CC5C;
	Mon, 17 Feb 2025 14:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739800973; cv=none; b=iPH2hGWdSm9rsI1D0RY1s22HEg49Tgy8QS8YAvmo6dzsfsLTn58YYLT+nYigd7tJGDtWj3Bp8hJfcX+TIRILxy+tx1QCchaqSYzIl8eunca16mrYPeezUbZeAps/Z87bd03/AxyhOggR/sxDjqrFphqLGbiGZHoglgxCGbcdcYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739800973; c=relaxed/simple;
	bh=eEMWVYsOAYZ5uEDaJWBhOQ2RhdPc8B5M1UPQRCMnI2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rQh40oZFV9kTKpi7SHcElVuOZ0Eu/AIvOklNteO0faPDsIRa8vdSnp8GJij2qHUXnu/Ws9rh9b5k0u3TIgUKuN0ZkGvkuPaJ+1ilY7vkGr5CQER6qFbeHy2aIr+96q61asf5tGePeDnN/RFH9lSWU2iYi9GtM6kVHoTfhhYgaMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSkZQWmm; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30a2f240156so9564201fa.3;
        Mon, 17 Feb 2025 06:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739800969; x=1740405769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1pq5eOfFzbGkYYPHO93ioyqJ39kYDVLWG64lfsmouk=;
        b=WSkZQWmmALFTD/+/WFUzJkzAp4D2Opm3cGrNMqFmiLhu7QDt+jVjWV8nUnbCG26ggw
         RHq1fXy6r801v/uq3YwarNE6iWwE46kDHaMydLjbQx8nuApfjgB76NwNnhLeGzWKjIHJ
         vTSeEtgVrqEJcH4Dgh2mLEZd5yEH3oekBZb9K2wpc2WwjU4GSmXHMA293SKoY/pB67nO
         BD8cJObIBBnCTm5Tt7a+XfY0HIYQKtvKP/r8cjL8sLpGP5tptnhavZtBfN+RcOfa+PT5
         BNnwGHDcO1hBSvu+7aj531iMhtPhyX/tSLKuucekc2AWU4JXUjDy0oGzTsIHIEtVgahX
         sMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739800969; x=1740405769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X1pq5eOfFzbGkYYPHO93ioyqJ39kYDVLWG64lfsmouk=;
        b=AFlGa6nVOgFZ8NqQufIzo+GOdpF7UE13G8SSQ0mEDb4jfFPU0WqfALIumDY5+w86A5
         YettGjmoHoEBiBR2KcI66NgekuO2pRhZAR/+DWiIVYNjnVrGtcL+51fvky3/T/VcKlKZ
         77uWGVe1mbSFbPJM4Rj5+oRdEXB+c4PQSOVvPTmCXPqdq2oxkJ3sC/PaBliPIqazzW3B
         9wt8B0jZNPZKegqaQRlKV5ZAybu9HGpkDwHpxfC7L8qrweDhRRuYQQX1Cq7W+nW03c3V
         blmAj3idi8gf1E+52A03nlPv9UlKi0f+71e4cmyBG53MDmP0U52ATTVl3FT3OxjjjfZA
         xP2A==
X-Forwarded-Encrypted: i=1; AJvYcCU5Ie/3x6UX0KfItv1hk9Eq+c+i+D/fftW+kR3E5KKBpDeEg4aQJ11m3idJjZyFTBoMGmTvzZWDhDz+I2zPGUo=@vger.kernel.org, AJvYcCUuAEGpaLzavwwjDEHt5hrvaUkIEe8GvxCOq1ScdJJwpnEHFNUUHs/keHdifYiKGJ4H/V+ud4PPt+i/LnCl@vger.kernel.org, AJvYcCW6LqsKUiFkahj23Tzbh/HT2/0WG+NvzmuhP8j5mVHONhkgfLDnIL5m/hKG34450+KIO4FMObInQviL@vger.kernel.org, AJvYcCXJMLuTIQPdTPzC8Mh92Ue8ohoRQOZ6uTINo4a2tDyVeW+bC1E1vdxs46xhFsHJVQOmK8YmOj/bAsISikxz@vger.kernel.org
X-Gm-Message-State: AOJu0YxTE55VhPI3yKrl2OvFB/8BxqjKfjaDnXiF9lMMecgk8sanDpa4
	gQS5Z8hSiJzQwcgZxcNiN3wLCRCaxj/NXZXll5/J2ZyIIfKrUXnra4K1ewAOw4Nw9o+OKcgSAy2
	XFvHmM5OADO1OnBZaljMCFdv83E4=
X-Gm-Gg: ASbGnctaGJWusOuxO4yBXSKVuhTKmlyzssMcKeaDN8r5uiZ4xRqLgRUHkO6ycfROAWQ
	hsFdz+KJiPYUNyK9dF99GafuqHPaNy4dWUmLJ1I/cqHlDoxnkKgNZSxLGBfNK6CwWRrh3xQFpF9
	vobB9+5Sn1CXN6na5qRmlusk+wAciiKYE=
X-Google-Smtp-Source: AGHT+IEhkQ8vlPjxvWHqrNDBF9jeXmjjfygC4xb6m+LKgmu7d8IhleJvuR7WydA+Upe6fEKOlXBsUaJ15zQJv6ENE00=
X-Received: by 2002:a2e:8890:0:b0:309:2000:4902 with SMTP id
 38308e7fff4ca-30927afe770mr23568901fa.36.1739800968510; Mon, 17 Feb 2025
 06:02:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207-rust-xarray-bindings-v16-0-256b0cf936bd@gmail.com>
 <20250207-rust-xarray-bindings-v16-2-256b0cf936bd@gmail.com> <Z7MnxKSSNY7IyExt@cassiopeiae>
In-Reply-To: <Z7MnxKSSNY7IyExt@cassiopeiae>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 17 Feb 2025 09:02:12 -0500
X-Gm-Features: AWEUYZlDYjYosA2ATuHScCNvNkvNJsoxbcnMNjsXryQL_RCrO2ZrK-WfuAXE8fI
Message-ID: <CAJ-ks9=OG2zPPPPfZd5KhGKgNsv3Qm9iHr2eWXFeL7Zv16QVdw@mail.gmail.com>
Subject: Re: [PATCH v16 2/4] rust: types: add `ForeignOwnable::PointedTo`
To: Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Matthew Wilcox <willy@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, "Rob Herring (Arm)" <robh@kernel.org>, 
	=?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, Fiona Behrens <me@kloenk.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 7:13=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Fri, Feb 07, 2025 at 08:58:25AM -0500, Tamir Duberstein wrote:
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
>
> I know that Andreas also asked you to pick up the RBs from [1], but - wit=
hout
> speaking for any of the people above - given that you changed this commit=
 after
> you received all those RBs you should also consider dropping them. Especi=
ally,
> since you do not mention the changes you did for this commit in the versi=
on
> history.
>
> Just to be clear, often it is also fine to keep tags for minor changes, b=
ut then
> you should make people aware of them in the version history, such that th=
ey get
> the chance to double check.

I will drop their RBs.

> [1] https://lore.kernel.org/rust-for-linux/20250131-configfs-v1-1-8794761=
1401c@kernel.org/
>
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
>
> I still think that it's unnecessary to factor this out, you can just do i=
t
> inline as you did in previous versions of this patch and as this code did
> before.

I will do as you ask here.

>
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
> > index 6c3bc14b42ad..eb25fabbff9c 100644
> > --- a/rust/kernel/pci.rs
> > +++ b/rust/kernel/pci.rs
> > @@ -73,6 +73,7 @@ extern "C" fn probe_callback(
> >          match T::probe(&mut pdev, info) {
> >              Ok(data) =3D> {
> >                  let data =3D data.into_foreign();
> > +                let data =3D data.cast();
>
> Same here and below, see also [2].

You're the maintainer, so I'll do what you ask here as well. I did it
this way because it avoids shadowing the git history with this change,
which I thought was the dominant preference.

> I understand you like this style and I'm not saying it's wrong or forbidd=
en and
> for code that you maintain such nits are entirely up to you as far as I'm
> concerned.
>
> But I also don't think there is a necessity to convert things to your pre=
ference
> wherever you touch existing code.

This isn't a conversion, it's a choice made specifically to avoid
touching code that doesn't need to be touched (in this instance).

> I already explicitly asked you not to do so in [3] and yet you did so whi=
le
> keeping my ACK. :(
>
> (Only saying the latter for reference, no need to send a new version of [=
3],
> otherwise I would have replied.)
>
> [2] https://lore.kernel.org/rust-for-linux/Z7MYNQgo28sr_4RS@cassiopeiae/
> [3] https://lore.kernel.org/rust-for-linux/20250213-aligned-alloc-v7-1-d2=
a2d0be164b@gmail.com/

I will drop [2] and leave the `as _` casts in place to minimize
controversy here.

> >                  // Let the `struct pci_dev` own a reference of the dri=
ver's private data.
> >                  // SAFETY: By the type invariant `pdev.as_raw` returns=
 a valid pointer to a
> >                  // `struct pci_dev`.
> > @@ -88,6 +89,7 @@ extern "C" fn remove_callback(pdev: *mut bindings::pc=
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
> > index dea104563fa9..53764cb7f804 100644
> > --- a/rust/kernel/platform.rs
> > +++ b/rust/kernel/platform.rs
> > @@ -64,6 +64,7 @@ extern "C" fn probe_callback(pdev: *mut bindings::pla=
tform_device) -> kernel::ff
> >          match T::probe(&mut pdev, info) {
> >              Ok(data) =3D> {
> >                  let data =3D data.into_foreign();
> > +                let data =3D data.cast();
> >                  // Let the `struct platform_device` own a reference of=
 the driver's private data.
> >                  // SAFETY: By the type invariant `pdev.as_raw` returns=
 a valid pointer to a
> >                  // `struct platform_device`.
> > @@ -78,6 +79,7 @@ extern "C" fn probe_callback(pdev: *mut bindings::pla=
tform_device) -> kernel::ff
> >      extern "C" fn remove_callback(pdev: *mut bindings::platform_device=
) {
> >          // SAFETY: `pdev` is a valid pointer to a `struct platform_dev=
ice`.
> >          let ptr =3D unsafe { bindings::platform_get_drvdata(pdev) };
> > +        let ptr =3D ptr.cast();
> >
> >          // SAFETY: `remove_callback` is only ever called after a succe=
ssful call to
> >          // `probe_callback`, hence it's guaranteed that `ptr` points t=
o a valid and initialized
>

