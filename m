Return-Path: <linux-fsdevel+bounces-42282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7392AA3FD96
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 18:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FA013BA1DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 17:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FA92505D8;
	Fri, 21 Feb 2025 17:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcE6nUxw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4390E35955;
	Fri, 21 Feb 2025 17:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740159167; cv=none; b=GnAxUThcVU3qz90ww6iDAyBLc46FwkkX0Q40k+NFK0ETKAi+JazQQyvKW2hYdgr8vOBXw1H8sAC7G8LmPqV4NBgJ1K79A1vGsIlZJZx5v/FkThmJOrmJTyIgy56RmJxiJxdJWOYl7ePUFs/msbYqYb4OJY+fSDdntKmasY/0ado=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740159167; c=relaxed/simple;
	bh=ZP/AZtmKekbdVa5h3wfllziVebzm3Pt0LiN8jFoe/t0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GVVp7JzsvnRdUWYPmg9P9XTTsDRI2+/S5hCo87dIAjicFtUKKxxNz2ErWl+TC9FHudNp32TZfRGqihsWukIKFgwwyVLCag8btZVkipFQtHLznT5oBk1w1mYD0ROZWSMA1xj6Qft2DkLJlo3/cwKXaAs+zv5iA6BhowOqV0Z4FUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcE6nUxw; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30a2594435dso34078941fa.1;
        Fri, 21 Feb 2025 09:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740159163; x=1740763963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJaML9956P6Qct9n7YoV3xhm6iSp4V2wMSvsIOJXqbc=;
        b=bcE6nUxwH6eW0OOHJDmFP4Zj5LHwD8oU46+OD9awqFqZOID8LIvURwGCs1UGIlOJI3
         PWjv0bjxMK7qBidibKtiHplDyD1qMgfc1IaDRiII30d7Uti4g8JH6sslQXyvCR12AonM
         eEdySvIxRzcd0KafXAQMtBXiOlKfQ1uCVGmaI6LbVrBNO4EV2jW5ppoOe1mgrQbOcbCP
         sMAhq8l0OXL2CIq5eWNjAU4eaAMM9QjDb2CYEttSrGXhOkpqSMcJd0sLAZVkZqMLYNlI
         K0/+fpfZj+I0oBIqPcBI4GwrXCll/2+TbWteK2dfJ/7f1dl99RPyX3X9/VoU7iLISJWd
         cTUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740159163; x=1740763963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJaML9956P6Qct9n7YoV3xhm6iSp4V2wMSvsIOJXqbc=;
        b=NUWZ8nNLvTC7Hzv0FKpiqWeV9Bm/DDUsrlcJsnxkkmdaMGt3ZSSsy26hjpGzrpXwhi
         zkOAigPl4QZ7raX0wg7eRl60Ne6Sf0xoIffCQhxSM8FFT8Eu7UqkmPHyX/nx27WpvRXm
         h8N9jLSsESv870UswzMaO9yYPgoFhDTM2SLleh/LRIP2qQC3aaKInV47wXY5d2i8UMkG
         S1kUpPzzm5Omn4DP6oSU0hoe3WTaR7QclPxOq9KrdDvULnubHXMYWOHmmoOUlvb30Ym6
         mXUwymUZOrqkPxD/scvHchuxZZvi9e9wSvQNAk0xFmJczagcp3CYcO69YjW67sN83HJw
         nVdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBJgwBlTQiF6ILPzJlzOggZX5HzzIA9j7ne7DHqb37dUekNOmbIamMMwT99+OeCieQ4tTFaD8aGlcjAoFw@vger.kernel.org, AJvYcCV6y7oVx9vd+AotpWnp3j9+7ZOGMjusl0dqHvdy+DJwVWvmML/dAblNvsa6tBO7wD/geAIhlArq40PSoxU8SgY=@vger.kernel.org, AJvYcCXZzbUqRa4UdwEzKDmFwAzDbaZ8sxuyljPVHL5mS40FFRe6h0IAhuQz4x3K9Pi+R1KR5l+cbz40Iqtm@vger.kernel.org, AJvYcCXmVzlQAAyqp6QV8QBhDIew0hBRbCy9Bkbx2aBDT4E5AWTryDLWDwrFg6koLaNHXV4nG8UZ2EpJbJ7QAeEg@vger.kernel.org
X-Gm-Message-State: AOJu0YxU6PHjgW+wjEm9rLZOSNcwKPj23QbRbJGsikXgs9IZ5o8fd63g
	bOEF/drkEw10cTuV+GU8gzJd2rhYuU/MprgTxnyiBN5bKxwpHzlr+GR9VPC6XTgPCPVcxR7PJOp
	zit03K5e3IMCUNtXXNZf+75ZgyKA=
X-Gm-Gg: ASbGnct8ezAk7rZ9ip3uurpVvqx0NZHoxHfThugK6lWYz4VTlHA3b23tAuezouIyGdD
	o19tAGzbJKkmXQaINr/T10aKk5CndKOFddSiQ6f/lEzfDX8UGhZH1YrRabkG7zi8RXRkKKEDBBW
	Qrw48upo7A2TlHKWMR5xQ4/+ttaVvwqyVjITLmFObh3Q==
X-Google-Smtp-Source: AGHT+IFxT4w66GaPlc3A/wTppIBJfgqA6VUJQjnIKnRHSb865LLrlRfQ3PC+ljynjrcEeQeBBsji2Xh3J+hIuoVgSws=
X-Received: by 2002:a2e:95cf:0:b0:309:271d:711a with SMTP id
 38308e7fff4ca-30a5997e02dmr13064501fa.13.1740159163087; Fri, 21 Feb 2025
 09:32:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218-rust-xarray-bindings-v17-0-f3a99196e538@gmail.com>
 <20250218-rust-xarray-bindings-v17-2-f3a99196e538@gmail.com> <Z7imafmrrK0_TO65@pollux>
In-Reply-To: <Z7imafmrrK0_TO65@pollux>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 21 Feb 2025 12:32:06 -0500
X-Gm-Features: AWEUYZmPYku9SRhQtPs7zcM_PkSwe-MlLN_XcNfWi4R554FoIu-TSTRLf0mVB_s
Message-ID: <CAJ-ks9nQhjXYfjr=kPU1RQON83iWkFXrxM7oXzSrSxRVbg_xTg@mail.gmail.com>
Subject: Re: [PATCH v17 2/3] rust: xarray: Add an abstraction for XArray
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
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(resending because gmail decided =F0=9F=91=8D is only allowed in HTML)

On Fri, Feb 21, 2025 at 11:14=E2=80=AFAM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> On Tue, Feb 18, 2025 at 09:37:44AM -0500, Tamir Duberstein wrote:
>
> [...]
>
> > +
> > +impl<T: ForeignOwnable> XArray<T> {
> > +    /// Creates a new [`XArray`].
> > +    pub fn new(kind: AllocKind) -> impl PinInit<Self> {
> > +        let flags =3D match kind {
> > +            AllocKind::Alloc =3D> bindings::XA_FLAGS_ALLOC,
> > +            AllocKind::Alloc1 =3D> bindings::XA_FLAGS_ALLOC1,
> > +        };
> > +        pin_init!(Self {
> > +            // SAFETY: `xa` is valid while the closure is called.
> > +            xa <- Opaque::ffi_init(|xa| unsafe {
> > +                bindings::xa_init_flags(xa, flags)
> > +            }),
> > +            _p: PhantomData,
> > +        })
>
> I think this needs an `INVARIANT` comment.

=F0=9F=91=8D

> [...]
>
> > +/// The error returned by [`store`](Guard::store).
> > +///
> > +/// Contains the underlying error and the value that was not stored.
> > +pub struct StoreError<T> {
> > +    /// The error that occurred.
> > +    pub error: Error,
> > +    /// The value that was not stored.
> > +    pub value: T,
> > +}
> > +
> > +impl<T> From<StoreError<T>> for Error {
> > +    fn from(value: StoreError<T>) -> Self {
> > +        let StoreError { error, value: _ } =3D value;
> > +        error
> > +    }
>
> Still think this should just be `value.error`.
>
> If it is important to especially point out that `value` is dropped, maybe=
 a
> comment is the better option.
>
> IMHO, adding additionally code here just throws up questions on why that
> additional code is needed.

OK.

> > +}
> > +
> > +impl<'a, T: ForeignOwnable> Guard<'a, T> {
> > +    fn load<F, U>(&self, index: usize, f: F) -> Option<U>
> > +    where
> > +        F: FnOnce(NonNull<T::PointedTo>) -> U,
> > +    {
> > +        // SAFETY: `self.xa.xa` is always valid by the type invariant.
> > +        let ptr =3D unsafe { bindings::xa_load(self.xa.xa.get(), index=
) };
> > +        let ptr =3D NonNull::new(ptr.cast())?;
> > +        Some(f(ptr))
> > +    }
> > +
> > +    /// Provides a reference to the element at the given index.
> > +    pub fn get(&self, index: usize) -> Option<T::Borrowed<'_>> {
> > +        self.load(index, |ptr| {
> > +            // SAFETY: `ptr` came from `T::into_foreign`.
> > +            unsafe { T::borrow(ptr.as_ptr()) }
> > +        })
> > +    }
> > +
> > +    /// Provides a mutable reference to the element at the given index=
.
> > +    pub fn get_mut(&mut self, index: usize) -> Option<T::BorrowedMut<'=
_>> {
> > +        self.load(index, |ptr| {
> > +            // SAFETY: `ptr` came from `T::into_foreign`.
> > +            unsafe { T::borrow_mut(ptr.as_ptr()) }
> > +        })
> > +    }
> > +
> > +    /// Removes and returns the element at the given index.
> > +    pub fn remove(&mut self, index: usize) -> Option<T> {
> > +        // SAFETY: `self.xa.xa` is always valid by the type invariant.
> > +        //
> > +        // SAFETY: The caller holds the lock.
>
> I think we only want one `SAFETY` section with an enumeration.

=F0=9F=91=8D

> > +        let ptr =3D unsafe { bindings::__xa_erase(self.xa.xa.get(), in=
dex) }.cast();
> > +        // SAFETY: `ptr` is either NULL or came from `T::into_foreign`=
.
> > +        //
> > +        // SAFETY: `&mut self` guarantees that the lifetimes of [`T::B=
orrowed`] and
> > +        // [`T::BorrowedMut`] borrowed from `self` have ended.
>
> Same here...

=F0=9F=91=8D

> > +        unsafe { T::try_from_foreign(ptr) }
> > +    }
> > +
> > +    /// Stores an element at the given index.
> > +    ///
> > +    /// May drop the lock if needed to allocate memory, and then reacq=
uire it afterwards.
> > +    ///
> > +    /// On success, returns the element which was previously at the gi=
ven index.
> > +    ///
> > +    /// On failure, returns the element which was attempted to be stor=
ed.
> > +    pub fn store(
> > +        &mut self,
> > +        index: usize,
> > +        value: T,
> > +        gfp: alloc::Flags,
> > +    ) -> Result<Option<T>, StoreError<T>> {
> > +        build_assert!(
> > +            mem::align_of::<T::PointedTo>() >=3D 4,
> > +            "pointers stored in XArray must be 4-byte aligned"
> > +        );
> > +        let new =3D value.into_foreign();
> > +
> > +        let old =3D {
> > +            let new =3D new.cast();
> > +            // SAFETY: `self.xa.xa` is always valid by the type invari=
ant.
> > +            //
> > +            // SAFETY: The caller holds the lock.
>
> ...and here.

=F0=9F=91=8D

> > +            //
> > +            // INVARIANT: `new` came from `T::into_foreign`.
> > +            unsafe { bindings::__xa_store(self.xa.xa.get(), index, new=
, gfp.as_raw()) }
> > +        };

