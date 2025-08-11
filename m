Return-Path: <linux-fsdevel+bounces-57410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C74B213D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 20:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E23E27A110D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 18:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811E12D6E46;
	Mon, 11 Aug 2025 18:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kriOUhy9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075A32147F5;
	Mon, 11 Aug 2025 18:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754935421; cv=none; b=Ub8DE+kExASMSQpmfjq3qLgW3Tldq6fiT1FvdgdewhWvZKbmpO+7LCL0kUcIqnFEcl6jei4vI/UTecMb8eNzfecmee4ypLvOxY7lCK+J+16blng5Kt3dQcHvLoG27wv907gkt8zGK6kcP/ieaOWQ11mTqlvH+d90BEIFfVov2Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754935421; c=relaxed/simple;
	bh=7yn1n7Qpf2iPDWVSr/zIL7FWuQMJ307xYh/Er4cR4pc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o3isEA7P8HprjvqOmPpy8CiIpTwaK/REv35nXfP4WEatqbacSO4yOkyVSMczJsdl4YCOmHKvC9+ehdk7gfYbo+yiC6dl4s3uivdiaqegOXLtJ5DavsqlS5Xt6zTJJr+WeJOZsekpC5wDviI82U5litJqGjqimRfRydRLkjTxJNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kriOUhy9; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3324e2e6f54so52010101fa.1;
        Mon, 11 Aug 2025 11:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754935417; x=1755540217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d///4wuoQangGNst6fYpzsgtPxISb9SbCVVJE+l8aHU=;
        b=kriOUhy9hlYSlYXeOxpcHC0GFvAM5EX8uEbedhcgy1zrVZD+KWcNZXcNXb6MJsuajT
         iUSLKinwSbkFxBiHilorRc19R7rnXVNwVNxsRSDFdoGLsIyd51aM2sDzZtXRiFjnSjXv
         O87owJjefL1lpnvd8JiXxXi55hV7HsSOWLVhHG3uI1PEMr5sVBKzf68qtf765wvcDi4r
         4h+qjaTbkR1udnOBk6YQXuA9+Pra2CA1OttDEu2FYWs1syfSo9JTa2cc6/fVgBII7z6o
         O9fnkXXfZEJ9tTVTttD9eF1J/7JqXlpCh084ZMVRP3RqNS7WgMWpvNRJgUT9kXZ3iKNM
         xEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754935417; x=1755540217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d///4wuoQangGNst6fYpzsgtPxISb9SbCVVJE+l8aHU=;
        b=FS0M4vNaZueUpvEbrSEa9tb9Nw+z+Zg5KKJQvOmo37b5vmGljp6/tyh5pbRqlM8L+M
         qvru+32UX6nJPIATTw/ydBQ0XHrxbA895PJHv0kug4UTCdcTQ63j8jtH91iOTB/Wf0AS
         XOmEAEEbqSF9nLD+NLxL5fHUvD6i9TMYzdBMMJwWYjYbH/2tx4YTVEvkaE1iM432HZSw
         zp1lVM4r4xjoQyJNlqSwM0uEl2oTKyR+Er/9Ip+hQp9dnAKD5u8ANCv0FMzgwQlnoUM8
         vCMBs3Z8cStwQB75UYtuPbHGNbTSKFjTIsBjHAFXL7asVnjWt6uCujdl4r34sXFrwS6e
         s+Ow==
X-Forwarded-Encrypted: i=1; AJvYcCVRX2DYeGPJH0W+fkIs9NEvTg91kkUlGMRA6dhQFiCKg2aBhS23Wxp773B328bR/9DqGpCiXZ815livdK3x@vger.kernel.org, AJvYcCX109MflOUUma3nI14REKTFUiZLfs/WIpISqQka0UiuTyxdcu/e2JRSldhy93C8ZK14X+4rYnaoMSuzKzCr@vger.kernel.org, AJvYcCXWeZyMMsJzhPPzH688VXSW16xx3ME8MwZv2i17EyvjDSnpHPCcDM2RJfLJRjrKwxZ/fJZMagZLCR92p4rB2Wk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK9SNatG8XEvy6yqk2UsXMVvrA/D/rnbM4WmRQe33bfaTq6MH3
	rGGeiQM3X24z7911CS7zzO+xXQRSGP568Vd3gAoAp7nM/wJAtBmCqJOOKYnsoEy1vCnsNfmdLOd
	hZ9MF8YUr4rBnYgOOA8AekEb1wyuHzAY=
X-Gm-Gg: ASbGncuzr1WqqCQsrRa/Jh4xP2nqHBuN4rxeehJMf+DEnjwJbDUhSw0j+2xEpbYA4iJ
	+un74umVFP81rNELnsIYhUOGOkU39qiSRZDyt4NLMEZ9KezATEV8uv6PF2URDsGrW/BTpJKkdch
	0bo4SpSxnA83CLBDjVtIyJnO7/V6J6YI/OgcVhUBW2F36sFj4REbjWWgA3N4ZM75xohOMan6kjI
	mESmFIz
X-Google-Smtp-Source: AGHT+IEBGMWFwPBvVKkHkPwEpE2wMzzGocdD5JdNJj56rt+2ZuB0UWbX44hvIpNbmg6xFrgD/0gijWRDGE/YtO1Eu00=
X-Received: by 2002:a05:651c:19a0:b0:332:13d4:6f6e with SMTP id
 38308e7fff4ca-333d7ad9f94mr1663741fa.2.1754935416777; Mon, 11 Aug 2025
 11:03:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250713-xarray-insert-reserve-v2-0-b939645808a2@gmail.com>
 <20250713-xarray-insert-reserve-v2-3-b939645808a2@gmail.com>
 <aJnojv8AWj2isnit@arm.com> <CAJ-ks9=BU2jfT-MPzxDcXrZj7uQkKbVm6WhzGiJsM_628b2kmg@mail.gmail.com>
 <aJn_dtWDcoscYpgV@arm.com>
In-Reply-To: <aJn_dtWDcoscYpgV@arm.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 11 Aug 2025 14:02:59 -0400
X-Gm-Features: Ac12FXwh33fn1ZAGbWU8KHUjxEVF-ovI5P2-O31Ri2jQBQmGUO28sNFAyHxqAe4
Message-ID: <CAJ-ks9kECSobk0NX6SXn1US7My028POc=nLmw0AHZGiRUstP2g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] rust: xarray: add `insert` and `reserve`
To: Beata Michalska <beata.michalska@arm.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	Daniel Almeida <daniel.almeida@collabora.com>, Janne Grunau <j@jannau.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 10:35=E2=80=AFAM Beata Michalska
<beata.michalska@arm.com> wrote:
>
> On Mon, Aug 11, 2025 at 09:09:56AM -0400, Tamir Duberstein wrote:
> > On Mon, Aug 11, 2025 at 8:57=E2=80=AFAM Beata Michalska <beata.michalsk=
a@arm.com> wrote:
> > >
> > > Hi Tamir,
> > >
> > > Apologies for such a late drop.
> >
> > Hi Beata, no worries, thanks for your review.
> >
> > >
> > > On Sun, Jul 13, 2025 at 08:05:49AM -0400, Tamir Duberstein wrote:
> [snip] ...
> > > > +/// A reserved slot in an array.
> > > > +///
> > > > +/// The slot is released when the reservation goes out of scope.
> > > > +///
> > > > +/// Note that the array lock *must not* be held when the reservati=
on is filled or dropped as this
> > > > +/// will lead to deadlock. [`Reservation::fill_locked`] and [`Rese=
rvation::release_locked`] can be
> > > > +/// used in context where the array lock is held.
> > > > +#[must_use =3D "the reservation is released immediately when the r=
eservation is unused"]
> > > > +pub struct Reservation<'a, T: ForeignOwnable> {
> > > > +    xa: &'a XArray<T>,
> > > > +    index: usize,
> > > > +}
> > > > +
> [snip] ...
> > > > +
> > > > +impl<T: ForeignOwnable> Drop for Reservation<'_, T> {
> > > > +    fn drop(&mut self) {
> > > > +        // NB: Errors here are possible since `Guard::store` does =
not honor reservations.
> > > > +        let _: Result =3D self.release_inner(None);
> > > This seems bit risky as one can drop the reservation while still hold=
ing the
> > > lock?
> >
> > Yes, that's true. The only way to avoid it would be to make the
> > reservation borrowed from the guard, but that would exclude usage
> > patterns where the caller wants to reserve and fulfill in different
> > critical sections.
> >
> > Do you have a specific suggestion?
> I guess we could try with locked vs unlocked `Reservation' types, which w=
ould
> have different Drop implementations, and providing a way to convert locke=
d into
> unlocked. Just thinking out loud, so no, nothing specific here.
> At very least we could add 'rust_helper_spin_assert_is_held() ?'

I don't see how having two types of reservations would help.

Can you help me understand how you'd use `rust_helper_spin_assert_is_held` =
here?

> >
> > > > +    }
> > > >  }
> > > >
> > > >  // SAFETY: `XArray<T>` has no shared mutable state so it is `Send`=
 iff `T` is `Send`.
> > > > @@ -282,3 +617,136 @@ unsafe impl<T: ForeignOwnable + Send> Send fo=
r XArray<T> {}
> > > >  // SAFETY: `XArray<T>` serialises the interior mutability it provi=
des so it is `Sync` iff `T` is
> > > >  // `Send`.
> > > >  unsafe impl<T: ForeignOwnable + Send> Sync for XArray<T> {}
> > > > +
> > > > +#[macros::kunit_tests(rust_xarray_kunit)]
> > > > +mod tests {
> > > > +    use super::*;
> > > > +    use pin_init::stack_pin_init;
> > > > +
> > > > +    fn new_kbox<T>(value: T) -> Result<KBox<T>> {
> > > > +        KBox::new(value, GFP_KERNEL).map_err(Into::into)
> > > I believe this should be GFP_ATOMIC as it is being called while holdi=
ng the xa
> > > lock.
> >
> > I'm not sure what you mean - this function can be called in any
> > context, and besides: it is test-only code.
> Actually it cannot: allocations using GFP_KERNEL can sleep so should not =
be
> called from atomic context, which is what is happening in the test cases.

I see. There are no threads involved in these tests, so I think it is
just fine to sleep with this particular lock held. Can you help me
understand why this is incorrect?

>
> ---
> BR
> Beata
> >
> > >
> > > Otherwise:
> > >
> > > Tested-By: Beata Michalska <beata.michalska@arm.com>
> >
> > Thanks!
> > Tamir
> >
> > >
> > > ---
> > > BR
> > > Beata
> > > > +    }
> > > > +
> > > > +    #[test]
> > > > +    fn test_alloc_kind_alloc() -> Result {
> > > > +        test_alloc_kind(AllocKind::Alloc, 0)
> > > > +    }
> > > > +
> > > > +    #[test]
> > > > +    fn test_alloc_kind_alloc1() -> Result {
> > > > +        test_alloc_kind(AllocKind::Alloc1, 1)
> > > > +    }
> > > > +
> > > > +    fn test_alloc_kind(kind: AllocKind, expected_index: usize) -> =
Result {
> > > > +        stack_pin_init!(let xa =3D XArray::new(kind));
> > > > +        let mut guard =3D xa.lock();
> > > > +
> > > > +        let reservation =3D guard.reserve_limit(.., GFP_KERNEL)?;
> > > > +        assert_eq!(reservation.index(), expected_index);
> > > > +        reservation.release_locked(&mut guard)?;
> > > > +
> > > > +        let insertion =3D guard.insert_limit(.., new_kbox(0x1337)?=
, GFP_KERNEL);
> > > > +        assert!(insertion.is_ok());
> > > > +        let insertion_index =3D insertion.unwrap();
> > > > +        assert_eq!(insertion_index, expected_index);
> > > > +
> > > > +        Ok(())
> > > > +    }
> > > > +
> > > > +    #[test]
> > > > +    fn test_insert_and_reserve_interaction() -> Result {
> > > > +        const IDX: usize =3D 0x1337;
> > > > +
> > > > +        fn insert<T: ForeignOwnable>(
> > > > +            guard: &mut Guard<'_, T>,
> > > > +            value: T,
> > > > +        ) -> Result<(), StoreError<T>> {
> > > > +            guard.insert(IDX, value, GFP_KERNEL)
> > > > +        }
> > > > +
> > > > +        fn reserve<'a, T: ForeignOwnable>(guard: &mut Guard<'a, T>=
) -> Result<Reservation<'a, T>> {
> > > > +            guard.reserve(IDX, GFP_KERNEL)
> > > > +        }
> > > > +
> > > > +        #[track_caller]
> > > > +        fn check_not_vacant<'a>(guard: &mut Guard<'a, KBox<usize>>=
) -> Result {
> > > > +            // Insertion fails.
> > > > +            {
> > > > +                let beef =3D new_kbox(0xbeef)?;
> > > > +                let ret =3D insert(guard, beef);
> > > > +                assert!(ret.is_err());
> > > > +                let StoreError { error, value } =3D ret.unwrap_err=
();
> > > > +                assert_eq!(error, EBUSY);
> > > > +                assert_eq!(*value, 0xbeef);
> > > > +            }
> > > > +
> > > > +            // Reservation fails.
> > > > +            {
> > > > +                let ret =3D reserve(guard);
> > > > +                assert!(ret.is_err());
> > > > +                assert_eq!(ret.unwrap_err(), EBUSY);
> > > > +            }
> > > > +
> > > > +            Ok(())
> > > > +        }
> > > > +
> > > > +        stack_pin_init!(let xa =3D XArray::new(Default::default())=
);
> > > > +        let mut guard =3D xa.lock();
> > > > +
> > > > +        // Vacant.
> > > > +        assert_eq!(guard.get(IDX), None);
> > > > +
> > > > +        // Reservation succeeds.
> > > > +        let reservation =3D {
> > > > +            let ret =3D reserve(&mut guard);
> > > > +            assert!(ret.is_ok());
> > > > +            ret.unwrap()
> > > > +        };
> > > > +
> > > > +        // Reserved presents as vacant.
> > > > +        assert_eq!(guard.get(IDX), None);
> > > > +
> > > > +        check_not_vacant(&mut guard)?;
> > > > +
> > > > +        // Release reservation.
> > > > +        {
> > > > +            let ret =3D reservation.release_locked(&mut guard);
> > > > +            assert!(ret.is_ok());
> > > > +            let () =3D ret.unwrap();
> > > > +        }
> > > > +
> > > > +        // Vacant again.
> > > > +        assert_eq!(guard.get(IDX), None);
> > > > +
> > > > +        // Insert succeeds.
> > > > +        {
> > > > +            let dead =3D new_kbox(0xdead)?;
> > > > +            let ret =3D insert(&mut guard, dead);
> > > > +            assert!(ret.is_ok());
> > > > +            let () =3D ret.unwrap();
> > > > +        }
> > > > +
> > > > +        check_not_vacant(&mut guard)?;
> > > > +
> > > > +        // Remove.
> > > > +        assert_eq!(guard.remove(IDX).as_deref(), Some(&0xdead));
> > > > +
> > > > +        // Reserve and fill.
> > > > +        {
> > > > +            let beef =3D new_kbox(0xbeef)?;
> > > > +            let ret =3D reserve(&mut guard);
> > > > +            assert!(ret.is_ok());
> > > > +            let reservation =3D ret.unwrap();
> > > > +            let ret =3D reservation.fill_locked(&mut guard, beef);
> > > > +            assert!(ret.is_ok());
> > > > +            let () =3D ret.unwrap();
> > > > +        };
> > > > +
> > > > +        check_not_vacant(&mut guard)?;
> > > > +
> > > > +        // Remove.
> > > > +        assert_eq!(guard.remove(IDX).as_deref(), Some(&0xbeef));
> > > > +
> > > > +        Ok(())
> > > > +    }
> > > > +}
> > > >
> > > > --
> > > > 2.50.1
> > > >
> > > >
> >

