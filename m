Return-Path: <linux-fsdevel+bounces-53539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B276CAEFFFA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 18:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9013169E30
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 16:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B3427C154;
	Tue,  1 Jul 2025 16:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCDr6Bkw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D06919994F;
	Tue,  1 Jul 2025 16:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751387821; cv=none; b=Eol5qAUY5htkR5rRbuhoMrYj8FYl8n9SE/lZ4xhcik9kgXfYAld7NwL4R8gWnvhrC72WQbZa4bXqd3MelTEF8fEguQf+4+kuGz0vcLbbPY8FvLmyvEEzj7fap7Xuy0TrdA7f3GXQCqZ3gVmlyZjtcGY3Um+BQfn89vBu16LgjGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751387821; c=relaxed/simple;
	bh=9DgFIrLkwE3noyfPke5sVBHJbvoThEKAcnkbqSUaWWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AxxE8YReVfKZ7Cu8j2KPRErHB7d1uTnpOP4k57SsRRjp7f4YLTHSgQArdzkjfLVDCJuRcSjWIWGqQ4tFNhGMVf64BNX5QEgWVHUKyTx6vm896bT36PlchEClJ94eUGHBv7VVmG3jFbQTjsZuI7BYXUXR/v8A5TubGkKxudNeU2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCDr6Bkw; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-32b5931037eso46364431fa.2;
        Tue, 01 Jul 2025 09:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751387818; x=1751992618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgyVkx3d9RLCvXLZyf3F2xIgeVZ3LcaqlbEZ/2Q1Ka0=;
        b=mCDr6BkwzALZnfZNGiZdKPtaRl8MfTqjEU5fwma+lbawBfCZKdXaq2IdlfSUdVZRVf
         jrYYSRUYnD3iVNOwzxKFYnw1VBQNruBi3EzpvnxfVOnCMvI/x1pllG9DnZhEcD3BKsLC
         atOnPFrFUs3rKyodhjkE/jwYz/0R+jd1A2RjVQ9E9jLbjiLm9VB39Q5swyVmU5hUYgga
         kZL7KbbKEWI5iTztNvRG9ZN1F7vkfTPM9SMbOzlwiQ5T7kI4UrmZj5rcIqyMmm07PYZz
         SF+DUfz9YbGPriKTY2QWSYTWI3lcjlX7lWSsj8zIwo0bBCCJ9NCKq3tgpi3zOIzx36W6
         pr6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751387818; x=1751992618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hgyVkx3d9RLCvXLZyf3F2xIgeVZ3LcaqlbEZ/2Q1Ka0=;
        b=LOBwz9b2VVAPVTfEhtp3yPsGxJP0rwYI0EOWu7JiFCuzqwxIWRr/iHM+bqIfPAcYdd
         12xOBOPYZeviCSE/3DnjuNKN61/MpRiZoHvvngMoioAQ3rsyxKR66AOOx62l/LMiNoyz
         c1ahNoSnoxTuj9HsSXZI/RrTeRdhunNSpmIziBmK9YHqiSnkvdzeS2wobQPeVr6Ldnkj
         BsySv0C5yxiX5nlXA1lOn8onfaz9Rwv245qOwCf9BVN7b+JRvrGgfRBzuZ3Bn7iXi4sb
         lYtBIaPaEhBpVTRTiKJgrUDPL6c3rpJ+B59UrbrM/CSpNf4NJkiM4Vbscp5SURH/WyC3
         N4BQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJhEbfUSCqH8cZxUdAeirC08CJD6zw7rboq2zrNM/1NGNfa9zADvbQOU/D/UsOT3dAkhHbYUJDRHukl9p3@vger.kernel.org, AJvYcCW34wJktDaUasUZdbTkdXv5+5m3HtJX0+Gk/xmegnk5yOJwnKFmgxiavrXZfTPuKaRF8czuQq01gz6M7Z96@vger.kernel.org, AJvYcCXovkcXPyh6KQFOwIERhqNX962SoeAQJGChOZFDahcYWyUmCJ+f34nuPvk8PU58o1pS2F3DANA0LQXZcQliHt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeVcLlD1pz9CJGgbd9mgmRxBjpcAZmLSqESZ9CpXaJFyRzuR/6
	4N8mYim9E87JJPhWiz8WSXEox5xd+XCqK0gnQxU9PEJddHeKrHzJI/fUPNJIEGSvf3004H/6emR
	S9iqkxjaHCaOJxZFHIB+9MiDHwG5rhrc=
X-Gm-Gg: ASbGncv9/GD+zkbOu/suh79P6uLZVdVAQb+u0pap54LFvEESnX/FGugUYSq3RxcjB7o
	Pe32rTI0TWk5jHNcwGjHK9SDLklTD6/RAt0ladtf8W3PlxBZD0HooZAf95k34iZHwkXlhcTqlvu
	JQhnE7fc645aBtoaN/XG+GO2Ifh952v3v48Izf0HpIgd1jUk8jLE3Y/FPwB4XN89UkHuz3u54Q7
	HMyhqGi/RkzWtj4
X-Google-Smtp-Source: AGHT+IEqCqt2bO97VSw5brojzdV3SZzJg+MkUJyR8sldEgfU+5WSPMAXAbtSk5Z703LmfE/XJzygq6h09VCa1Ovh93Q=
X-Received: by 2002:a05:651c:3248:20b0:30b:f52d:148f with SMTP id
 38308e7fff4ca-32cdc482b6fmr28085101fa.18.1751387817386; Tue, 01 Jul 2025
 09:36:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701-xarray-insert-reserve-v1-0-25df2b0d706a@gmail.com>
 <20250701-xarray-insert-reserve-v1-1-25df2b0d706a@gmail.com> <aGQORK02N8jMOhy6@Mac.home>
In-Reply-To: <aGQORK02N8jMOhy6@Mac.home>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 1 Jul 2025 12:36:20 -0400
X-Gm-Features: Ac12FXzwtYZh48LsIbouap6aPSYLMEtyprvogrYztvEYzaNQhpMD-bJ8UxP3Ra4
Message-ID: <CAJ-ks9nqWHSJjjeg=QReVh3pq87LSLE-+NDOD5scp1axYV7k7Q@mail.gmail.com>
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

On Tue, Jul 1, 2025 at 12:35=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Tue, Jul 01, 2025 at 12:27:17PM -0400, Tamir Duberstein wrote:
> > Using the prelude is customary in the kernel crate.
> >
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> >  rust/kernel/xarray.rs | 34 ++++++++++++++++++++--------------
> >  1 file changed, 20 insertions(+), 14 deletions(-)
> >
> > diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
> > index 75719e7bb491..436faad99c89 100644
> > --- a/rust/kernel/xarray.rs
> > +++ b/rust/kernel/xarray.rs
> > @@ -5,16 +5,15 @@
> >  //! C header: [`include/linux/xarray.h`](srctree/include/linux/xarray.=
h)
> >
> >  use crate::{
> > -    alloc, bindings, build_assert,
> > -    error::{Error, Result},
> > +    alloc,
> > +    prelude::*,
> >      types::{ForeignOwnable, NotThreadSafe, Opaque},
> >  };
> > -use core::{iter, marker::PhantomData, mem, pin::Pin, ptr::NonNull};
> > -use pin_init::{pin_data, pin_init, pinned_drop, PinInit};
> > +use core::{iter, marker::PhantomData, mem, ptr::NonNull};
> >
> >  /// An array which efficiently maps sparse integer indices to owned ob=
jects.
> >  ///
> > -/// This is similar to a [`crate::alloc::kvec::Vec<Option<T>>`], but m=
ore efficient when there are
> > +/// This is similar to a [`Vec<Option<T>>`], but more efficient when t=
here are
> >  /// holes in the index space, and can be efficiently grown.
> >  ///
> >  /// # Invariants
> > @@ -104,16 +103,23 @@ pub fn new(kind: AllocKind) -> impl PinInit<Self>=
 {
> >      fn iter(&self) -> impl Iterator<Item =3D NonNull<T::PointedTo>> + =
'_ {
> >          let mut index =3D 0;
> >
> > -        // SAFETY: `self.xa` is always valid by the type invariant.
> > -        iter::once(unsafe {
> > -            bindings::xa_find(self.xa.get(), &mut index, usize::MAX, b=
indings::XA_PRESENT)
> > -        })
> > -        .chain(iter::from_fn(move || {
> > +        core::iter::Iterator::chain(
>
> Does this part come from using the prelude? If not, either we need to
> split the patch or we need to mention it in the changelog at least.

Yes, it's from using the prelude - PinInit also has a chain method
that causes ambiguity here.

> Also since we `use core::iter` above, we can avoid the `core::` here.

Good point.

