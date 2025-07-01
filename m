Return-Path: <linux-fsdevel+bounces-53556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 394CFAF0137
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 19:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AF275220A6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 17:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB35D27FD45;
	Tue,  1 Jul 2025 17:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iim3kv90"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE0826AD9;
	Tue,  1 Jul 2025 17:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751389377; cv=none; b=gyMXqSXN9ZWKIqtvpkklDc2uwMT4afjq59anZjfLrpL7yI+Uyr460kW7H1gYoC9atKEOnyQsmKT2sGCYFw0gWBKAmANJyyRDhLtkiDdpJZb//3Xv59aJ+kHm2GP+BC5p1sGcQFkd+WKDqqQGFWKS9tEF0QHdzBbS4ZF4UF4mxAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751389377; c=relaxed/simple;
	bh=tF+F6vbwRT/TGOAfonF5tzLO4RbYJ5+3fe5HV4xoYe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4MdVcaZfw8LJC7S71l5T1nG47ExeOeCB8AL9InIeFfsKDMUdMsAu7Bkz/W9Bjv/4Wl7XDR1JlkxCHIM6y+7E06KZ04qgCYnNYRvFM1nq8e30nngJqyKSdMsJSGycjWKv38BaLCaNjBUcQyJMHQBKtSPJHLHvLgJ5XNMEuGGnhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iim3kv90; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6fb1be9ba89so35438496d6.2;
        Tue, 01 Jul 2025 10:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751389374; x=1751994174; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XjCEuJi7S3Vb9cPEHWAVTRgm6DeaRYcjyCpGP2zAxb8=;
        b=iim3kv90OVV7fb4t8Xer/LhKFoIByUI7/pT71E+kRDz1syQ+fnLh5RfxlJN8sB+w1c
         fGEZBnHQQt3Ipv2bSK3I21GBY9NSSS7o/Gq3r8ZXPWv77e09msc3JNzgGSTnSWfMlciZ
         HGaClCPVgvBdBDz/jW6PrS6PHq7nwTafXdcw8FCMEza0t2kJDIPPfa7nS7cdeJIACth7
         W8q14GhYWPWxDk0MKP8h8q2MhEtmMohzztClP+AcLrmjKQq2J6DSVd0Dp6/2wp22VQ3J
         XlsNZpMDZejhXxmWE0hjP0fvZ/NVYezXtLY6SLvURWYJoPn66S7sKxl5Ac8lSwHLkfH2
         TZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751389374; x=1751994174;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XjCEuJi7S3Vb9cPEHWAVTRgm6DeaRYcjyCpGP2zAxb8=;
        b=o4OePWR+h8xVmzXNOxNPtqJmf+OX3ehXLcEgLfJ/w03cocx3uPkPJ3jnI4Um3OZAcF
         JPnjsSez8SjEu/lDBPwJz3j5CrSYPkb6ux9tgSppr/q3G8eOX22nuMUGgppTukxXVEkN
         wG3UOX1u8CORU4N8yYQCg/nMhQ+kT2RvJCEZTtVc6vel55QK/P+fkONtr2bjsM1lOjWp
         A/Yi266fGHe0iyCHC30FgkLUd/lCFRAS+rOH3CP9RHXZyoAj+BjlyKkrhzzezYvy2Io/
         ZwcGbnvRB5QljEq6re0+jCJJTksTosUOdZqibb1vZDNjn2u/QV3IMld8FQjPcOGbXkzP
         ynQw==
X-Forwarded-Encrypted: i=1; AJvYcCUvS7Q7pDeGnQRftAt0UdJE6pgu1F2W+Hia8NlDH/EHKtJ2ppATOtLVboNgDcISQfOpzfhBEgzz7HFFXORM@vger.kernel.org, AJvYcCUynGEU68sgFx975HtEd3acG0WhFAkKWsvVNPE1lRZrisDEXD8W26neQPdexHF46ExlHAklIZO+SyfCyXT9@vger.kernel.org, AJvYcCXMwd2AlcJE/HCvd8uO4bzv5eGJIVe4eNPZpK4ZUWxr4WNg3iNNzaT6BSk8XCVL+LB49S+ozsOUJp6loPOhqgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZGjPLk02rBdhSYJLHHukWtSdJLDyDsRgzvzyrBOjvf3K90tip
	qL9WuGpCsIXLU0cpRtTuao9k7GflKNHJjuZ33OZw+8Y2/6KBMW62sn3a
X-Gm-Gg: ASbGncvQurTygONgFBi58Tw0yLEjyTObq/t24WqPx9kPG0pmvL8eS141b+ml7krkjDc
	Y9KRnos/SbCCn94AInnKWOy1fmhbL9hxiJocrmqju0S1aHJDSQhFlQvbgxS0yddbMgvWTGTc2NF
	QcFgPDuEmcGOlp4AGxCMhlRDbwZ20vih2LA7ScxzVSSQzrvQp/3bfP5p6z8tFmWPyAIjbARDcyq
	i0m4O3MLA3gMQVrlNb9VFRD1IzaZWLlKF38hrA56f79sIzFI8Kinm/lTigqK9C7u+xKIuQZ+THO
	2rW9rV1ArJRqlKX83kIXFHIGULQvzybAuGfV5eDwFFThbAY+sifjp7md6YAc6w0WTGm/IEyEacr
	AxAKqjfFDemsk7dAHtAWlKPrufWGKfsUlADyy4pfgQ4NfoAixQncAMSaA1LSiMGw=
X-Google-Smtp-Source: AGHT+IHugx9tngMNAd30vXM01xwYxG6EdwTSmE6fUcbPIYcJFrpxlqnr6+0gzBeNI9kYx5TJeBl1fg==
X-Received: by 2002:a05:6214:e4a:b0:6ff:154a:aa4e with SMTP id 6a1803df08f44-6fffdcfc05emr298545156d6.7.1751389374320;
        Tue, 01 Jul 2025 10:02:54 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd7718d913sm87464226d6.15.2025.07.01.10.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 10:02:53 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 584B2F40072;
	Tue,  1 Jul 2025 13:02:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 01 Jul 2025 13:02:53 -0400
X-ME-Sender: <xms:vRRkaHogP08JptMyKpjGJ9vjSfz-xchZnevLvVoqBkJNoGOAJ4TEVg>
    <xme:vRRkaBqMfHksysq_VBCLW6o6nQQsik6GodarjTVjpvU3XRxe_wTv3fbaG58MXVNXY
    LGtt8EoAkmMBa4xAw>
X-ME-Received: <xmr:vRRkaENbP0teyIUY2eojnys_dEK7xtPZEz-ctxGKtzPCYmiubIWLUva-2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduhedtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekrodttddtjeenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeffleekfedutefhkefhheekhfelvdejgfegvdejjeffudelkedtffeiveejteet
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepudekpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehtrghmihhrugesghhmrghilhdrtghomhdprhgtphhtthhopegrrdhhihhnug
    gsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprh
    gtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhn
    fegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopehlohhsshhinheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgt
    ohhmpdhrtghpthhtohepthhmghhrohhsshesuhhmihgthhdrvgguuh
X-ME-Proxy: <xmx:vRRkaK55n3bGF1vq83GLtHragV_yWSggo7CWYJ2LlNbP4suA-tp5Tw>
    <xmx:vRRkaG7n5BUEVHqcPP6jD_Z6OABuDCJUXFsY7adE7GOwoghQuA_JHg>
    <xmx:vRRkaCj6sTji6NMW6ZBlvXBQxlurVjKvunvBC0-e5_G-c0vTqvl9cA>
    <xmx:vRRkaI4EBcpCsief3wlhL58R5G7gn043PXZPEha7nH-QXy7jkD3dug>
    <xmx:vRRkaFJR0-Ut-WKIny6rdXv6L6SZ0YrpGMu5BnGQoKJKkQuVqyI5xC3h>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 13:02:51 -0400 (EDT)
Date: Tue, 1 Jul 2025 10:02:50 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	Daniel Almeida <daniel.almeida@collabora.com>
Subject: Re: [PATCH 1/3] rust: xarray: use the prelude
Message-ID: <aGQUuuCpaBFrWrSe@Mac.home>
References: <20250701-xarray-insert-reserve-v1-0-25df2b0d706a@gmail.com>
 <20250701-xarray-insert-reserve-v1-1-25df2b0d706a@gmail.com>
 <aGQORK02N8jMOhy6@Mac.home>
 <CAJ-ks9nqWHSJjjeg=QReVh3pq87LSLE-+NDOD5scp1axYV7k7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9nqWHSJjjeg=QReVh3pq87LSLE-+NDOD5scp1axYV7k7Q@mail.gmail.com>

On Tue, Jul 01, 2025 at 12:36:20PM -0400, Tamir Duberstein wrote:
> On Tue, Jul 1, 2025 at 12:35 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Tue, Jul 01, 2025 at 12:27:17PM -0400, Tamir Duberstein wrote:
> > > Using the prelude is customary in the kernel crate.
> > >
> > > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > > ---
> > >  rust/kernel/xarray.rs | 34 ++++++++++++++++++++--------------
> > >  1 file changed, 20 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
> > > index 75719e7bb491..436faad99c89 100644
> > > --- a/rust/kernel/xarray.rs
> > > +++ b/rust/kernel/xarray.rs
> > > @@ -5,16 +5,15 @@
> > >  //! C header: [`include/linux/xarray.h`](srctree/include/linux/xarray.h)
> > >
> > >  use crate::{
> > > -    alloc, bindings, build_assert,
> > > -    error::{Error, Result},
> > > +    alloc,
> > > +    prelude::*,
> > >      types::{ForeignOwnable, NotThreadSafe, Opaque},
> > >  };
> > > -use core::{iter, marker::PhantomData, mem, pin::Pin, ptr::NonNull};
> > > -use pin_init::{pin_data, pin_init, pinned_drop, PinInit};
> > > +use core::{iter, marker::PhantomData, mem, ptr::NonNull};
> > >
> > >  /// An array which efficiently maps sparse integer indices to owned objects.
> > >  ///
> > > -/// This is similar to a [`crate::alloc::kvec::Vec<Option<T>>`], but more efficient when there are
> > > +/// This is similar to a [`Vec<Option<T>>`], but more efficient when there are
> > >  /// holes in the index space, and can be efficiently grown.
> > >  ///
> > >  /// # Invariants
> > > @@ -104,16 +103,23 @@ pub fn new(kind: AllocKind) -> impl PinInit<Self> {
> > >      fn iter(&self) -> impl Iterator<Item = NonNull<T::PointedTo>> + '_ {
> > >          let mut index = 0;
> > >
> > > -        // SAFETY: `self.xa` is always valid by the type invariant.
> > > -        iter::once(unsafe {
> > > -            bindings::xa_find(self.xa.get(), &mut index, usize::MAX, bindings::XA_PRESENT)
> > > -        })
> > > -        .chain(iter::from_fn(move || {
> > > +        core::iter::Iterator::chain(
> >
> > Does this part come from using the prelude? If not, either we need to
> > split the patch or we need to mention it in the changelog at least.
> 
> Yes, it's from using the prelude - PinInit also has a chain method
> that causes ambiguity here.

Maybe you can mention this in the change log as well. Like "Calling
iter::chain() with the associated function style to disambiguate with
PinInit::chain()". Make it easier to review (and remember) why.

Regards,
Boqun

> 
> > Also since we `use core::iter` above, we can avoid the `core::` here.
> 
> Good point.
> 

