Return-Path: <linux-fsdevel+bounces-47742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74072AA544D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 20:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E6CF3BB008
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 18:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36032686AD;
	Wed, 30 Apr 2025 18:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/piF3xZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE4A2DC791;
	Wed, 30 Apr 2025 18:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746039470; cv=none; b=fEsM66xrMcu6UhfFM4+rnkXGQn5qFinaatELc485uU6XHwS3r4kUrVENrq1guXnmiexyCjdzdKJyvv6qMLl1ILcnF0pJmV6XmxmKVuenoVA4jPWMiTeckKQVkHfapfEd5PMWKpKsSNtLfBM/R/TDT+sOBg5vGciCf/a5q5/mJMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746039470; c=relaxed/simple;
	bh=7EType9Ekri4xFukCiBkZYBLTBbz1N02VuyHzWgqMd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mOLl1JPCamwOdx9lKuu+1/wJlAlmqDaaN4F6kl5b/tXevMhXQ/pJ8/DJHWSV5wzFv4eina2KS5LxZkI5D01rV955Q/Uor+a1vaulXYO8Jwep2SbzDZzA/MpWKY96/W6pC16gj7ekB80wUOYZYsa8csAr/vLCHDMY01KwV9p/8A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/piF3xZ; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3105ef2a08dso1151331fa.0;
        Wed, 30 Apr 2025 11:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746039466; x=1746644266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Co0Xi2Cn214P/EVHXLtALOOsLQy1qRLIvjB8w1y55A=;
        b=X/piF3xZlLrh0DHFMMGx1OnWlmiGeyM8Jb4mOXKmiJjSWFp9AKaARVhkMuC7RREGH5
         Bu5pMn12+P4ci0ui9ycgXTeYmnyFJ1ajW3cM5aYbrK9UjNSE5SBIIsA7uABCqimxErXU
         RtOch9aGBl7vJ7O6mODCMx7HXlYqb2WIYOuvUC3M4ZZZIzoiwBNglW9wICLXpJPHcSlF
         af/SwuXfRNvRWrCXAlQo787FbyrwNu+xWhw8nmJDIIVJN4gcZJMollnSoH+I2TWqG2Vt
         yJA36/FYbIWfGhqQG9nWM4dTwcHXQwHwYIjKF3jl+F2XhVmwnkkYsNw90Ov7+POd5KIX
         hsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746039466; x=1746644266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Co0Xi2Cn214P/EVHXLtALOOsLQy1qRLIvjB8w1y55A=;
        b=qiMzYzRWkpT8Bz5r34bCCCjh9I8XVY/oum3d0b4JJWrwW6bks7das1rhqucT2tB/+K
         j3wfXYrS3bcSzojx1KaHLZ/t44juwfKIEKkKpasebCffpUGch0WT+PuHRCsYtbh7QQSE
         rd7ExT6hAyaGdd0QN1RhHQfIcieF81kxtXJDMFnXfgW/chyl1jpfKfHQeQI2J1J0X2lC
         yxjnge1vh0fxi+a9A9+fhIGUmYquibTJ0LKB18tKV4JiT//B312Jd+DGAjWtuSo4y/pX
         iLiu+l5YSMXx8PLWg6zwHAqtK0Fo7D8Zl70AznDwojs1JnJIPq6vYABY6wyQ4fNuKXqy
         BVzw==
X-Forwarded-Encrypted: i=1; AJvYcCU8awR4MYFo4iT/D2jakoIrXP3ap32lqYbTQaU2oEThSLKFVgBAN6un3IdXf3Kt2TnK6CqHAZlcU7dMLKga@vger.kernel.org, AJvYcCUAvYVJ9xW/LAxFtgYOARBaUXcNwU4W5WwRSfNSfY4KrA0AbDK1gHfC+bV8FnulxByPQTQy/v9jWtdH@vger.kernel.org, AJvYcCW64LOdVAb6P5utO4xNkBiXXcuPZG34wYZ0/qbQDwK+TIuRWalQqHRIr02XQR7TxhLJAaUd/DqBbrOr+HGe@vger.kernel.org, AJvYcCXCe7U3nA1WT3Mp7g3O47RnB4H396bFqrfxfU4yi9QL7yKL5AyXdC7pemLd3oyLDuEjp4sNe/+Nxv2kZCluKwg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx670BepcyGDR2N3w+w9eavdHixU6KOZlYMuDEPBQZOvNxf6qdg
	JA1tvPDjQ+4aCYspn2+1i1LLYGbruXv8NO7zakIlTrS9fw/WL8jVyOuLXypWdqRWimYvf2ZTllg
	sefj1mbxo3yR6lnG65So++fmbx0M=
X-Gm-Gg: ASbGncviXejWAgNBSvHr/h7iTaMOIqdqBJXeOZfHMGnqk4wrRHM3GBeB2DMvVlHSkNL
	qnXPq+LHuchQNyLmD2qtVXeQYo5Jx8tToxkbx4UFDiTOWZtoAZ85WdGfmNedXWFJei4i5NH9CW1
	D6MIyA+RWh+ONmdxd62DzoajvFVsAhrk0XNkc6Hw==
X-Google-Smtp-Source: AGHT+IF62wGd3AfAa3XTDcFU/dPLNWBxd1QSHgut41yotsDhq90Ax3o7BbN69lIZuWjx7Qcb09Y6taep9E5GyXqSrz4=
X-Received: by 2002:a2e:bc2a:0:b0:30c:12b8:fb9e with SMTP id
 38308e7fff4ca-31e6bb7a15bmr14926991fa.37.1746039465963; Wed, 30 Apr 2025
 11:57:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423-rust-xarray-bindings-v19-0-83cdcf11c114@gmail.com>
 <20250423-rust-xarray-bindings-v19-1-83cdcf11c114@gmail.com> <20250430193112.4faaff3d.gary@garyguo.net>
In-Reply-To: <20250430193112.4faaff3d.gary@garyguo.net>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 30 Apr 2025 11:57:09 -0700
X-Gm-Features: ATxdqUHKJsF_Ztw_vWWyO_xzKD0VXWU8jKaoIxBKRujg2qGm_nE7_XyrN0RqM-Q
Message-ID: <CAJ-ks9nrrKvbfjt-6RPk0G-qENukWDvw=6ePPxyBS-me-joTcw@mail.gmail.com>
Subject: Re: [PATCH v19 1/3] rust: types: add `ForeignOwnable::PointedTo`
To: Gary Guo <gary@garyguo.net>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Matthew Wilcox <willy@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, "Rob Herring (Arm)" <robh@kernel.org>, 
	=?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 11:31=E2=80=AFAM Gary Guo <gary@garyguo.net> wrote:
>
> On Wed, 23 Apr 2025 09:54:37 -0400
> Tamir Duberstein <tamird@gmail.com> wrote:
>
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
> > Acked-by: Danilo Krummrich <dakr@kernel.org>
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> >  rust/kernel/alloc/kbox.rs | 38 ++++++++++++++++++++------------------
> >  rust/kernel/miscdevice.rs | 10 +++++-----
> >  rust/kernel/pci.rs        |  2 +-
> >  rust/kernel/platform.rs   |  2 +-
> >  rust/kernel/sync/arc.rs   | 21 ++++++++++++---------
> >  rust/kernel/types.rs      | 46 +++++++++++++++++++++++++++++++--------=
-------
> >  6 files changed, 70 insertions(+), 49 deletions(-)
> >
> > diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
> > index b77d32f3a58b..6aa88b01e84d 100644
> > --- a/rust/kernel/alloc/kbox.rs
> > +++ b/rust/kernel/alloc/kbox.rs
> > @@ -360,68 +360,70 @@ fn try_init<E>(init: impl Init<T, E>, flags: Flag=
s) -> Result<Self, E>
> >      }
> >  }
> >
> > -impl<T: 'static, A> ForeignOwnable for Box<T, A>
> > +// SAFETY: The `into_foreign` function returns a pointer that is well-=
aligned.
> > +unsafe impl<T: 'static, A> ForeignOwnable for Box<T, A>
> >  where
> >      A: Allocator,
> >  {
> > +    type PointedTo =3D T;
>
> I don't think this is the correct solution for this. The returned
> pointer is supposed to opaque, and exposing this type may encourage
> this is to be wrongly used.

Can you give an example?

> IIUC, the only reason for this to be exposed is for XArray to be able
> to check alignment. However `align_of::<PointedTo>()` is not the
> minimum guaranteed alignment.
>
> For example, if the type is allocated via kernel allocator then it can
> always guarantee to be at least usize-aligned. ZST can be arbitrarily
> aligned so ForeignOwnable` implementation could return a
> validly-aligned pointer for XArray. Actually, I think all current
> ForeignOwnable implementation can be modified to always give 4-byte
> aligned pointers.

Is your concern that this is *too restrictive*? It might be that the
minimum alignment is greater than `align_of::<PointedTo>()`, but not
less.

> Having a const associated item indicating the minimum guaranteed
> alignment for *that specific container* is the correct way IMO, not to
> reason about the pointee type!

How do you determine the value? You're at quite some distance from the
allocator implementation.

