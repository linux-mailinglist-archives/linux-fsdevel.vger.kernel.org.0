Return-Path: <linux-fsdevel+bounces-57353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCD1B20A95
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 15:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55A832A4129
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 13:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082282DEA69;
	Mon, 11 Aug 2025 13:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VY6PTkmo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50A922D9EB;
	Mon, 11 Aug 2025 13:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754919787; cv=none; b=V2uQbO6qwJK1cBSQO+QxE3A04Q6LtESatIcBIiEZl43Ou/b1uIXA5JRnpTND1oMPNrogHcstN3wEWMj0AWIysXz0brXdFySD98X8p7iwgNwTQxrpcn1iq6fKJ8buW5/0MqnLwhmZmWymIs44iaHIaVRix5uLqrfn1CS2IbFplFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754919787; c=relaxed/simple;
	bh=bxGTblfXM96v9fwAt5ERR+OhrAYP0OeaDKLMoS7oZ3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vt21tR6dRkkYFWjtW0AjPtCZ4mbZHtBm91eZz76WoZ5/LEWn9krPPuaVifTChXagRfb2epdbBZf/HeOfmDPee4XhS1nnNwjt56bztKXIXDqWxMM4eNfmZKEYvJNlNvpINO8732jetrFXimQYWs272l9GAEGWFJRJTuETPaoIg6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VY6PTkmo; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-32ce1b2188dso49318091fa.3;
        Mon, 11 Aug 2025 06:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754919784; x=1755524584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2uF7vPpkuTtX/qbaQwoJviWpFHx9vCm0V6L9tSQgUI=;
        b=VY6PTkmoXcx/6w1seCuTk/5k87vxHX6VFBi69Nx+QtVQ0yp+vy/IRDXNUZqWTCwxzr
         riwlzH8314AqJ2UnaYHWNPrvIbtddRUcELhHwfn3ISzNhmnFbtTFYoitkwW+v00mzZuz
         Gjod4OoRPaWRUXMp4XtyzWLCCh568XuGp24XbUsKDi/ECA+wP5Fd7n1c7lKMEOne5e+B
         yCCwuf3+qblJgPLTnV2FAbhJqwpuiiFNEIU3OtwBcVIZT975SC6OqUnSya8pNq9R1zGg
         uqAE3mgMa0rpoV1I6k7Pq2/HytPg3eRJt5WD/hZTYrtJ/LYWnaS9auCq8teH/hpDJMdO
         PQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754919784; x=1755524584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e2uF7vPpkuTtX/qbaQwoJviWpFHx9vCm0V6L9tSQgUI=;
        b=Ioa8YaA2sffYMIEMeDsNQD20HEqlUG8vPvC3LDxb3qgz+umfM/Moj6sseKx+pUjkwz
         Y2F7Q7cLepg3rM3SpwfDQu/40io//uNYeRhw/wSJycKwy/7XB92w4GmwYk9eDoHK7NC/
         pWO+CRRPsayy5J2avudRXP7qInsNSZP/6tVfBV+g/+DePqTNoNU0Tx756VNGXsbSMEgH
         bpT9S2mhe0R1ZdCpvQT8klfp0J0wCY2rzlhFW57q1FOWlraariKFZHwXZqnz54QBFF5s
         9ZCNRTbiY9J1WBWjQ1wRj01U413TntrBycGw+jdDEL4B/A8aKIVIatLz1OjXBWfBCWSF
         twww==
X-Forwarded-Encrypted: i=1; AJvYcCUQVenADesbB1tpY7icWV+to7W+/BA1RPJqcKYGPwlyLdKNO75xf7WYWvgOzOriJl1NmxzpukfESZ/9ClkD@vger.kernel.org, AJvYcCUh/4E3f9i/2+LtFja6P5AKgkVPNQ43XYwlsgEaPWyuYA6iKuRfBazRcO6yAMoJboyCs5mo0avw+Np3EuSd5iQ=@vger.kernel.org, AJvYcCV/ozI9CjfscGvbSJgDbu2XrbchXLZEAseWPzeB6aU7upFCLWXJhvkIenxt6C5Oe7p45G6dSwB2A6CXPCT3@vger.kernel.org
X-Gm-Message-State: AOJu0YytfZibd6lLiglBV/E4jciSUa8u7CmFlh7uIH+2hewGZCq4otvs
	4ySfky2ToyhgAIeHboEmqEVfzIm/oF90PtPgKXxBCuLQVonZuKKwzD+9kq7Sb5FkHRPvtq/Z2Vt
	ycO63JQFkM06BmYDI3EoI6y2iSUDOND0=
X-Gm-Gg: ASbGnctYqFDDL32HUDDqNKm0sF0AmQ23CGE0uPImHlEoYC8LVDlrX/sSo01aDYd9dDq
	bIRgVUG6ynVa7//gwErIAy9BpyuUPQ8K5cfNirMIDd9duuUF33CIfwKGMmRACiZc1wu6RZmMzrP
	Pa/DyKOua1Z3U1e3cwn8o5ouaoVwsHC2P/TrDcPigN4a9wIyM1VGUdoe1AcbQkcneJ4ywcHd7L3
	t8MRMoGk8j13L966es=
X-Google-Smtp-Source: AGHT+IEol4/14g1RdFTVWvKKfnfbHDYflaB3EmyktN+uy3kEuQJOPffANVEaEm6xSj3auWaeo5zGZxx39z1GzBXm49o=
X-Received: by 2002:a05:651c:222a:b0:331:ed39:6a2 with SMTP id
 38308e7fff4ca-333a2107c71mr28463591fa.6.1754919783604; Mon, 11 Aug 2025
 06:43:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250713-xarray-insert-reserve-v2-0-b939645808a2@gmail.com>
 <iPv7ly-33WYOq_9Fait3DBD6dQCAn1WCRGwXjlPgNBmuj5yejzu0D6-qfg3VYyJfwu9uS4rJOu9o3L2ebudROw==@protonmail.internalid>
 <20250713-xarray-insert-reserve-v2-3-b939645808a2@gmail.com> <87o6smf0no.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87o6smf0no.fsf@t14s.mail-host-address-is-not-set>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 11 Aug 2025 09:42:26 -0400
X-Gm-Features: Ac12FXwkTewa4VnDdAm-sjbFCbNz-t0XSzJ_IMvpOUXuMOMHXyVuYMlS2C03l70
Message-ID: <CAJ-ks9kTacXO_PbcH8c-60Ae88vJ_w6_pbmXLzOpzTKgRjiXPw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] rust: xarray: add `insert` and `reserve`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	Daniel Almeida <daniel.almeida@collabora.com>, Janne Grunau <j@jannau.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 9:29=E2=80=AFAM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> "Tamir Duberstein" <tamird@gmail.com> writes:
>
> > Add `Guard::{insert,reserve}` and `Guard::{insert,reserve}_limit`, whic=
h
> > are akin to `__xa_{alloc,insert}` in C.
> >
> > Note that unlike `xa_reserve` which only ensures that memory is
> > allocated, the semantics of `Reservation` are stricter and require
> > precise management of the reservation. Indices which have been reserved
> > can still be overwritten with `Guard::store`, which allows for C-like
> > semantics if desired.
> >
> > `__xa_cmpxchg_raw` is exported to facilitate the semantics described
> > above.
> >
> > Tested-by: Janne Grunau <j@jannau.net>
> > Reviewed-by: Janne Grunau <j@jannau.net>
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>
> <cut>
>
> > +    /// Stores an element somewhere in the given range of indices.
> > +    ///
> > +    /// On success, takes ownership of `ptr`.
> > +    ///
> > +    /// On failure, ownership returns to the caller.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// `ptr` must be `NULL` or have come from a previous call to `T::=
into_foreign`.
> > +    unsafe fn alloc(
>
>
> The naming of this method in C is confusing. Could we call it
> insert_limit_raw on the Rust side?

I think I prefer to hew close to the C naming. Is there prior art
where Rust names deviate from C names?

> Even though this is private, I think we should also document that the
> effect of inserting NULL is to reserve the entry.

=F0=9F=91=8D

> > +        &mut self,
> > +        limit: impl ops::RangeBounds<u32>,
> > +        ptr: *mut T::PointedTo,
> > +        gfp: alloc::Flags,
> > +    ) -> Result<usize> {
> > +        // NB: `xa_limit::{max,min}` are inclusive.
> > +        let limit =3D bindings::xa_limit {
> > +            max: match limit.end_bound() {
> > +                ops::Bound::Included(&end) =3D> end,
> > +                ops::Bound::Excluded(&end) =3D> end - 1,
> > +                ops::Bound::Unbounded =3D> u32::MAX,
> > +            },
> > +            min: match limit.start_bound() {
> > +                ops::Bound::Included(&start) =3D> start,
> > +                ops::Bound::Excluded(&start) =3D> start + 1,
> > +                ops::Bound::Unbounded =3D> 0,
> > +            },
> > +        };
> > +
> > +        let mut index =3D u32::MAX;
> > +
> > +        // SAFETY:
> > +        // - `self.xa` is always valid by the type invariant.
> > +        // - `self.xa` was initialized with `XA_FLAGS_ALLOC` or `XA_FL=
AGS_ALLOC1`.
> > +        //
> > +        // INVARIANT: `ptr` is either `NULL` or came from `T::into_for=
eign`.
> > +        match unsafe {
> > +            bindings::__xa_alloc(
> > +                self.xa.xa.get(),
> > +                &mut index,
> > +                ptr.cast(),
> > +                limit,
> > +                gfp.as_raw(),
> > +            )
> > +        } {
> > +            0 =3D> Ok(to_usize(index)),
> > +            errno =3D> Err(Error::from_errno(errno)),
> > +        }
> > +    }
> > +
> > +    /// Allocates an entry somewhere in the array.
>
> Should we rephrase this to match `alloc`?
>
>   Stores an entry somewhere in the given range of indices.

=F0=9F=91=8D

> <cut>
>
> > +impl<T: ForeignOwnable> Reservation<'_, T> {
> > +    /// Returns the index of the reservation.
> > +    pub fn index(&self) -> usize {
> > +        self.index
> > +    }
> > +
> > +    /// Replaces the reserved entry with the given entry.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// `ptr` must be `NULL` or have come from a previous call to `T::=
into_foreign`.
>
> We should document the effect of replacing with NULL.

=F0=9F=91=8D

> Best regards,
> Andreas Hindborg
>
>

