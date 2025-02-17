Return-Path: <linux-fsdevel+bounces-41855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB06A38504
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 14:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23B5E171F7C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 13:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE2021CFFD;
	Mon, 17 Feb 2025 13:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Le7bBUR8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDC0215F5E;
	Mon, 17 Feb 2025 13:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739799832; cv=none; b=E8aaZKwvUkl4V0c96B0J0+raTIZ5KJWZx0hDevbGJPMRZufk3Yr+4AI3totGfQ65qcNDn6IvGNp1w8lhaKjF7F560aLOF9OPe+Z78vL3xey4Qz75RYEDUX2sUekAxXXh7J5zb8C6TVXHFTI6+3nGBYFD3ZMHgUC10aUOVmZJosg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739799832; c=relaxed/simple;
	bh=WVNMGjJD3dZlBPYRQlTCwkvWflEt7J/nxBUl4MK3yB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rPF+4EXZN+vXO0Rsvb9/u9gUZTg+JtYpEGHQiQThxy8D07yuAW0LaQEMjuXjXRp8bmZVBZi7qQ+tyw0EYjiZ+RXmgGcNvjT6vL44RtLC6KS3CQi25cmPkohcUDrjZSm9+QGLSkE/eTW0i+BQCBOTc6P5NcRLtCnsYKlL8nLgRBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Le7bBUR8; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30613802a59so44905481fa.0;
        Mon, 17 Feb 2025 05:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739799828; x=1740404628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRc9Tpy+5Xu/CpzQwWLNCPWUPWW3j83ejbPU3Fk2+Hk=;
        b=Le7bBUR8PraaBtlySTEWoVu5EoUjBhsSDowbyaGQUe7kfZg7yIVmcoWqQMJvDybHcL
         cYqpS3lf12qLzZICdCRzwNi0/7LOKkQV++mOoFruR92Jlg2KXzURDyL/f1t7JIbEVcg2
         hSzz4Y++LpGmDj0JO5712l+qAcItQ2qqwIS3f3DJtS3tYgt3FagyC+MIlR6ZshFBv+Qh
         yzCR3ZQEJEIdWVwCpcefOtmL960mi8JPv5StPUA5T0EpUqNw9dNUvWkwHlOtvI1vKIts
         yeS5Fi+vnIFxLQ+Cpx2o8hcQjwgy3pFR12SX22g8rTFfJekyqqrw+u7prNI6zj2qAMsN
         OChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739799828; x=1740404628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bRc9Tpy+5Xu/CpzQwWLNCPWUPWW3j83ejbPU3Fk2+Hk=;
        b=YYUx6D50Zbi0ea6B2kZiePFiISl12OlMC1CF2bxKYgks8TAq9fxFTfCHKYYk/LSpsT
         foGTiOCcFs4SKj5O5dge4HqqkBeima5MxSfN50Yvyqhs4/Bu/6a1elw+uYK+HTTjiDKL
         ISrQegdrsZmhvWf92D8RdtI3yaMQlo4wWBJJZKCvvFpS+1Jjp6/XsUakTDnxvE4RQR4D
         YnsNWKeE7/06wt5dqqrnJ8lgB23Lpo+OEinqSuVP7Z+QeykhHt3Dmm4U6c5R+xEJHpQF
         297iyVch/LaoSUYblG2+QeLpHNfGvehoo3n5sJy0FyG/njv9VKupzATMB5Lyg+T+2wr4
         yDHA==
X-Forwarded-Encrypted: i=1; AJvYcCUW/+CM6VCQZquLuAb7NWmcE0FwNnPjXX63ZeUuKlRvZNAaX4KMkW/v8t+ABIAbPbs2I7Ipcaj5n2/zwGJN@vger.kernel.org, AJvYcCWfivUL+jI1BxZTPK9HcgnD1MzRWStpF6Lmyb3xxXsAz7mGK3TBChQjydfbYtdYoRVQrYAsoQ2zZyxP@vger.kernel.org, AJvYcCXG3Ut8NaxcZ0qVy0PQBKDRT/k3tQsTuGruZkOlN+buNJGW+uSBal9xYHKPI3CZ47LKJQCq9aiZnWiUTVJQ7kU=@vger.kernel.org, AJvYcCXpxwKRs4wL5+mLzzvN04mi1FzL4BZs9WQWj9KTmzWSHVhMcCONdblGUigwrwr4maBQTiyUzqj462dmBeZ4@vger.kernel.org
X-Gm-Message-State: AOJu0Yydc926H5FzexHo/5aIMAnRGKjYBHRuMD7wFhs4y3BousG8nqKr
	1OmXP5H0FR8BkKbdyzgng2ZJU0pamUiJkam6KtLwcu25KdIJRrMgjr1dNq/l+7jnhY4b+oXnuoe
	l82XyS5sU1aCU0ek47Gu8Z+RhM9Y=
X-Gm-Gg: ASbGnctyJIObwqG3bzjeUvl82LShzsGiKSdkCnMAlfot2Eln3MBvHZq4bWDtloMoEgw
	Npw280lQ7174hOwIM/ySGbGdHlbkhcCijD9I0/XlasR7eVJTrXUWAy6OcAN0Dn6tp6LieNSydMM
	sofVrdDvjF4KNBMEwkcOs/PaMt0BKNiN0=
X-Google-Smtp-Source: AGHT+IEoqrdP6BA+xmJrp1Ntv+tn9+EVPLG6b6TQnNe+iU9uYxEaRTb/VhqdaTjkMG0+dXeWdphjpaC9bNPdCM8V3xs=
X-Received: by 2002:a2e:bc0e:0:b0:309:1774:b279 with SMTP id
 38308e7fff4ca-30927afe14fmr33352141fa.31.1739799828218; Mon, 17 Feb 2025
 05:43:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207-rust-xarray-bindings-v16-0-256b0cf936bd@gmail.com>
 <20250207-rust-xarray-bindings-v16-3-256b0cf936bd@gmail.com> <Z7MfETop-rGSNLFo@cassiopeiae>
In-Reply-To: <Z7MfETop-rGSNLFo@cassiopeiae>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 17 Feb 2025 08:43:12 -0500
X-Gm-Features: AWEUYZlL0BvpYluikW83ADsKMq4gwCZJVzADFDTTLuYB-hkdRfR8GL3ph5jEPZI
Message-ID: <CAJ-ks9m4QhnztQ7McJLdxEQjNcfYUiHPXwpnbbG12GFfPXBGqw@mail.gmail.com>
Subject: Re: [PATCH v16 3/4] rust: xarray: Add an abstraction for XArray
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

On Mon, Feb 17, 2025 at 6:35=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Fri, Feb 07, 2025 at 08:58:26AM -0500, Tamir Duberstein wrote:
> > `XArray` is an efficient sparse array of pointers. Add a Rust
> > abstraction for this type.
> >
> > This implementation bounds the element type on `ForeignOwnable` and
> > requires explicit locking for all operations. Future work may leverage
> > RCU to enable lockless operation.
> >
> > Inspired-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> > Inspired-by: Asahi Lina <lina@asahilina.net>
> > Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> >  rust/bindings/bindings_helper.h |   6 +
> >  rust/helpers/helpers.c          |   1 +
> >  rust/helpers/xarray.c           |  28 ++++
> >  rust/kernel/alloc.rs            |   5 +
> >  rust/kernel/lib.rs              |   1 +
> >  rust/kernel/xarray.rs           | 276 ++++++++++++++++++++++++++++++++=
++++++++
> >  6 files changed, 317 insertions(+)
> >
> > diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> > index fc9c9c41cd79..77840413598d 100644
> > --- a/rust/kernel/alloc.rs
> > +++ b/rust/kernel/alloc.rs
> > @@ -39,6 +39,11 @@
> >  pub struct Flags(u32);
> >
> >  impl Flags {
> > +    /// Get a flags value with all bits unset.
> > +    pub fn empty() -> Self {
> > +        Self(0)
> > +    }
>
> No! Zero is not a reasonable default for GFP flags.

This is not a default.

> In fact, I don't know any
> place in the kernel where we would want no reclaim + no IO + no FS withou=
t any
> other flags (such as high-priority or kswapd can wake). Especially, becau=
se for
> NOIO and NOFS, memalloc_noio_{save, restore} and memalloc_nofs_{save, res=
tore}
> guards should be used instead.
>
> You also don't seem to use this anywhere anyways.

This was used in an earlier iteration that included support for
reservations. I used this value when fulfilling a reservation because
it was an invariant of the API that no allocation would take place.

> Please also make sure to not bury such changes in unrelated other patches=
.

Thank you for spotting this errant change. Please consider whether it
serves anyone's purpose to accuse someone of underhanded behavior.

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
>
> Why not just `value.error`?

I prefer the clarity that this results in the value being dropped. Is
there written guidance on this matter?

