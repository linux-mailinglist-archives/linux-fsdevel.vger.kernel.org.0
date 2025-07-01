Return-Path: <linux-fsdevel+bounces-53558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1DEAF0144
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 19:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4B8A526BB2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 17:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21CC27F74E;
	Tue,  1 Jul 2025 17:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="diheASn7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44C226FA70;
	Tue,  1 Jul 2025 17:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751389505; cv=none; b=pQ/U7HLX3Shj+d/XNfBaG0y0q0VJZJ0Lzd6VPAgQzZ7DxCun7mK41aWifIj3CfRrpfZkoRjZOc1FamNT68jbWqSFzXtF8kFEwCwuZZuj+3C2SofDeLpBN7E2sIvu+fvGgYezjGw/UU6WwX1mCtQVa50tBImb+RzXNEF1+LuxUVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751389505; c=relaxed/simple;
	bh=8AtDB9ZOK1mJSfdffS72JMAaKzwesnXF2qFcjp0ossQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eo0S0VGB5m9gsK2zgyAuzHZGXhj6dLHCtWw+g3a1hwJ8mG+t74AXusU4o45yeryXovWzGwep/JIoeev7mNWRU/fiSV/d+ikT9qQrI/rj54bwXofGVdUep7+J1Y1aLJiymEB9kX+SoqPk9kZKRb9l8npQjvh2kMn6DCuClekheGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=diheASn7; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-32cd499007aso42602901fa.0;
        Tue, 01 Jul 2025 10:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751389500; x=1751994300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+K6ZF3dYWrim9dWHEWNEC7aeyZabJ9Egpf5a6k6P7g=;
        b=diheASn7C3q2BA8iH1KJ9Qgo8YK4aZanK4sXO3LgBXA+agoyTVyYhQh5xh1A9M9PEJ
         kPk2ik+k+NJVjvj99aZk7Vb2qinWNZB+7YigxzWvZtA7Rc3tygTvvfzB1NlAlObA2iXt
         3L4JVf/HYOCBDFBnR/BEvUkpvFWK1mizTEqiN3L/Xk+QrubTr7WDe4fCl9w3cnnIS/Jp
         oUFwMaL21ePPbuwYZyqwz1nFp9r/5LTagVxHKoUSlBfEDnLHaGVTukIwB6b7UZwa6SK/
         52BQX5uSCyP47Q3Q1MYzQGiD+6MdA8G4LapbPrC4pSALI+4qsmYDgBw2YTJYSK5Qca7P
         rRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751389500; x=1751994300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+K6ZF3dYWrim9dWHEWNEC7aeyZabJ9Egpf5a6k6P7g=;
        b=wuGNRbR5xrMWZY5G8xGHI//pKy36nOKmRizzFzpu04TtHgyP2ZxnpPf32vLx2OQMOm
         aNjqJXXUvNTPoAFrRpLc6dHFrPt/1tpYWTM0Edeg5X3F2p9ksmTXKZipPq2fpYIbhtcz
         AcEWJa6Ua9GuA3aZtNFZFv/UTLlDF5YPD7I6q+pK9kITzmGCKj5clcY2DyJYkuPFVnY0
         U7+TYPgUfRgOMkmNZ5wMQUNI6O1v25w+6EeqGhTN8Y178eutc7nRdll3oOQKLxQTESQE
         CkyGiGBdXtNPo28ZELDLkDMICvY9q8+PWRyAyduAd0XfKDvw3hTZdvqsgJhw+a2fp7q+
         jn6g==
X-Forwarded-Encrypted: i=1; AJvYcCVwf6Z9OBwLKcnc38TKurTp9YiGHCYm/rvFBCkKUD1oUUyqzuqfK/W9bCo4+rNBR1DXX0x2h3WiGV3HYOjo4YY=@vger.kernel.org, AJvYcCVzHzWHX6NwoA9K22l1t6pNdw7jGo4D/nbNeQMYZeI1vcrCJ6AWuYrbZi0aaX6mQGzCaPlYgEEgmvPSKYE7@vger.kernel.org, AJvYcCWppHx7m3eOZbTSBR6IrTEoDcRh1Y9MMifNtMKL3nUWAoFItGKpYZCyHfJ64zhvuUmgiDm7vbNgsvyN4Bc3@vger.kernel.org
X-Gm-Message-State: AOJu0YwF/L53v6eRZ91bHJJz4UdivsiobMFewyubY1G50xH1XFsWr5b7
	guCIxnhPhyyWmQnC2XsLdQj9Pha22MAlpSOPqdc0dOr5Q/BWfx32NgRMISfCO9TsvtY/tRhoGap
	V7ZakDilZzl4LTymZp0UqPO/jkDuCBQE=
X-Gm-Gg: ASbGncsNg9GLYqHjX672TGK3bS0P2blvfHIilVsnkQjLsMCxXZINS8YlTnR/dCrqUWj
	amabnCz8tHkMbh8HSvwpL8Gv7n5lskXz5855aKvxJAL+2CE5eDd6Bgnr/7Bb03zXVjLOA/mC5Z+
	0FVBRekd3iRk8VOHcjhzcd8XHGQZEaSgvEH649MH/ByXwI5ikbieZ+VA9ouE3a3pUGcNfrxS1s5
	wUw1ptAztn1J456
X-Google-Smtp-Source: AGHT+IGqYOo2c8/8oI+jyXB0x4gWaxsVOe9Tp1zXFwmtuWqACbNl3YCeogJ+en7TpTeTnciAtjdBji+bnjdfRKFy2FM=
X-Received: by 2002:a2e:22c5:0:b0:32a:dcc7:f99e with SMTP id
 38308e7fff4ca-32cdc4ef298mr64711841fa.22.1751389499666; Tue, 01 Jul 2025
 10:04:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701-xarray-insert-reserve-v1-0-25df2b0d706a@gmail.com>
 <20250701-xarray-insert-reserve-v1-1-25df2b0d706a@gmail.com>
 <aGQORK02N8jMOhy6@Mac.home> <CAJ-ks9nqWHSJjjeg=QReVh3pq87LSLE-+NDOD5scp1axYV7k7Q@mail.gmail.com>
 <aGQUuuCpaBFrWrSe@Mac.home>
In-Reply-To: <aGQUuuCpaBFrWrSe@Mac.home>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 1 Jul 2025 13:04:22 -0400
X-Gm-Features: Ac12FXzUo3uf1OgsqLAqpL1VF9vNiKALMZv_azy7ZRgjbxDzg8RiT9byf5Y14Vc
Message-ID: <CAJ-ks9=Nfv+U8i-h7bb0fK5PMy5w78yiN+P14Hkx8Ckbw3xQ0Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] rust: xarray: use the prelude
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	Daniel Almeida <daniel.almeida@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 1:02=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> wr=
ote:
>
> On Tue, Jul 01, 2025 at 12:36:20PM -0400, Tamir Duberstein wrote:
> > On Tue, Jul 1, 2025 at 12:35=E2=80=AFPM Boqun Feng <boqun.feng@gmail.co=
m> wrote:
> > >
> > > On Tue, Jul 01, 2025 at 12:27:17PM -0400, Tamir Duberstein wrote:
> > > > Using the prelude is customary in the kernel crate.
> > > >
> > > > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > > > ---
> > > >  rust/kernel/xarray.rs | 34 ++++++++++++++++++++--------------
> > > >  1 file changed, 20 insertions(+), 14 deletions(-)
> > > >
> > > > diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
> > > > index 75719e7bb491..436faad99c89 100644
> > > > --- a/rust/kernel/xarray.rs
> > > > +++ b/rust/kernel/xarray.rs
> > > > @@ -5,16 +5,15 @@
> > > >  //! C header: [`include/linux/xarray.h`](srctree/include/linux/xar=
ray.h)
> > > >
> > > >  use crate::{
> > > > -    alloc, bindings, build_assert,
> > > > -    error::{Error, Result},
> > > > +    alloc,
> > > > +    prelude::*,
> > > >      types::{ForeignOwnable, NotThreadSafe, Opaque},
> > > >  };
> > > > -use core::{iter, marker::PhantomData, mem, pin::Pin, ptr::NonNull}=
;
> > > > -use pin_init::{pin_data, pin_init, pinned_drop, PinInit};
> > > > +use core::{iter, marker::PhantomData, mem, ptr::NonNull};
> > > >
> > > >  /// An array which efficiently maps sparse integer indices to owne=
d objects.
> > > >  ///
> > > > -/// This is similar to a [`crate::alloc::kvec::Vec<Option<T>>`], b=
ut more efficient when there are
> > > > +/// This is similar to a [`Vec<Option<T>>`], but more efficient wh=
en there are
> > > >  /// holes in the index space, and can be efficiently grown.
> > > >  ///
> > > >  /// # Invariants
> > > > @@ -104,16 +103,23 @@ pub fn new(kind: AllocKind) -> impl PinInit<S=
elf> {
> > > >      fn iter(&self) -> impl Iterator<Item =3D NonNull<T::PointedTo>=
> + '_ {
> > > >          let mut index =3D 0;
> > > >
> > > > -        // SAFETY: `self.xa` is always valid by the type invariant=
.
> > > > -        iter::once(unsafe {
> > > > -            bindings::xa_find(self.xa.get(), &mut index, usize::MA=
X, bindings::XA_PRESENT)
> > > > -        })
> > > > -        .chain(iter::from_fn(move || {
> > > > +        core::iter::Iterator::chain(
> > >
> > > Does this part come from using the prelude? If not, either we need to
> > > split the patch or we need to mention it in the changelog at least.
> >
> > Yes, it's from using the prelude - PinInit also has a chain method
> > that causes ambiguity here.
>
> Maybe you can mention this in the change log as well. Like "Calling
> iter::chain() with the associated function style to disambiguate with
> PinInit::chain()". Make it easier to review (and remember) why.

Yep, done for the next spin.

