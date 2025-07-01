Return-Path: <linux-fsdevel+bounces-53538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C35AEFFF7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 18:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A098E18854DC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 16:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B573F27AC2A;
	Tue,  1 Jul 2025 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqU07gre"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978C01AA1DB;
	Tue,  1 Jul 2025 16:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751387722; cv=none; b=DJzN6k+LI95djQQ4F3N2rAu2Bt5IEnR2TE5CyYnABVAswPynN6SKZl+CBdeRci//C3Lo8DFV8NDLd5xxjxkieH2j0JR6ONiA93HapyYRdHQCYKKeBfwWpfCDehokaldZu18czYbL5/HzG3+8rBm10yWlIs2SGLeZncNvv2I2Lvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751387722; c=relaxed/simple;
	bh=4hsshI57Z9C4/sYvwAkYfdFuTtX1WltnX6JifWIWylc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANiwWN2OUZrNkO7Nk+IpSG9C8qwVcG1tat3tj2Sk3wVf3DzUZOk8AXWZ/NmPNg5ErMmuWhCnUfRMMpZuFr8TlebN6zEhux3snde8SlixjHBui8lZu0fB/sAsNjJUHcZXDrwrvGs1Lq22ly2b/HiZv8a/SI6r/63x4ERRxDWcfoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqU07gre; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6fb0eb0f0fbso62985086d6.1;
        Tue, 01 Jul 2025 09:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751387719; x=1751992519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5+0hrUrWdaTQSD5NTP041Iw08AxAQ4FPS5CuAQJAhY=;
        b=RqU07greEN/iJULK0HB9fLamt3RmNd/uttNr2cBIL3PeCAyMWhbw2JS9mGlDatOFwN
         VdMvuIBwdb3VzBVhqRI3i75zO+HjHQsKpXAmB8l2lvXIuZwnqRsQIsTdF2TGEzFZFO4p
         bhfnDVQLhbebJw0SxqwTqJEN8FX9m43mAQytg4ctr+hXOYmnk8p0XZNz747PxDYUuoMm
         KjkaNm/m3zPQyj12jifLjyLx0u1e37KCT5qCxsMJx0/9AT7F96xQk/kBlkUrQz54KE4t
         ZoYOvEaXuUjOwR9yzMmnsDlix25OWwriTYWwmMd7Ze12RTeahMAvdQ1S0sV2hYAjJA8b
         nPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751387719; x=1751992519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z5+0hrUrWdaTQSD5NTP041Iw08AxAQ4FPS5CuAQJAhY=;
        b=arnper7/u0rkDZEAYY9gHoKqA78HsiWTwyadIusCnn9Qr31L5UQDntlUiSu4h3eHzT
         LK/ePsDYz8O2WQ8ikI2Lf80sWq0dqOaYmhMiBanqOQA95UFKwuTcuPinLgw+IdoXY1QR
         tGZdF1PWqoEkRN3Pc/7HFisNWSRXrZRk1E8o/+lIZ0z5mjjQeiENo03Zt8VQIt9xieGL
         PlZSH/DcPe309hH/UpAMHBWLxNubl9X/+//vRPFYPB1/gVsKB4ZkuUztLEiJJPFvhQRL
         kkheX9OBoASbxqRr+KJdOGJk1fE1q4cYj/NpVGwSUaZndQUQtW60Ruq8oudww15DHaAw
         tkow==
X-Forwarded-Encrypted: i=1; AJvYcCU7qMHiTRRKUthiSiuf1Uoute2bYi4o/OSliNUa7pmQ0Jb6dXu7ThPegAoXIWf+WqyJCrMXD5E4066bim+sZsc=@vger.kernel.org, AJvYcCVZahPpQtCmPuYu5vmchX3PEJFvcS/6XnWAlkMq6aCi8npclTBDYT+AL7tLfjhY+fktquW9UM9tTp49+ym2@vger.kernel.org, AJvYcCXtLYE7usbVXETv9RNu+HBQ0wHM4iHn3MXS0CV4Z8TJp2wegcOnlE8xFq0bRe/WoNAY3dhiVm4fL3wjBm37@vger.kernel.org
X-Gm-Message-State: AOJu0YxjqWShLfzVZSAmz5pA3nNiPyJi33JCg+qJJ3y+OAZPT/2b4Kdg
	ZCcwJ018whtyrl4CiP4A+mi+O5KtDXzRySGJzSTXuxYoZ+fMQDsF+TnG
X-Gm-Gg: ASbGnctKXhbJue5fdvWgs6cJWqD6ioiRpsIFDJCKE4FFu9T+/la7YSM/NERfCHDVBMl
	fn78pgdfTPcnK/3sb7Sx2OgR6mbWSQYCBRouFZHX0afYd7DnnV/v5/xFnHUI1S8DfYgh9w5cVrQ
	eeSuNdulSHsUnOf8GF6pdZNIxMzFGUhmwYjZwB6ZUewq2KPswMUmSU+dKgXxPLOtfSRpMMd+YXw
	TGHMrCe5Tnds9VwE/j0uNYQ8RSkTnCrz8S325JcLA/UYrkqUZX5xRodQnbYmg3O9pdq5RVQEzVa
	GTeTwgsPOzqZK+Ai543VMphf16aTlnxMzmn/vhuZp2/OoDZ+VjYPUKbU14cYEBMadGHOUKAogB9
	I4VmzFXoD7Udgayjw/MhAGeNYERMRSyVP35c9mS2RZ/UjxR0XbTXbE5+JTbL4GoA=
X-Google-Smtp-Source: AGHT+IHPuVm5X6/V6Y6ozrMdjj8rGAidZSiuaMJIbUTy0MxSjjYB4uoxLPCKT2h7nQTZaSV7v4ivTg==
X-Received: by 2002:a05:6214:4003:b0:6fa:a5f6:ffce with SMTP id 6a1803df08f44-7010a9c4834mr67949186d6.19.1751387719283;
        Tue, 01 Jul 2025 09:35:19 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd773151dbsm86553886d6.115.2025.07.01.09.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 09:35:18 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 33D02F40066;
	Tue,  1 Jul 2025 12:35:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 01 Jul 2025 12:35:18 -0400
X-ME-Sender: <xms:Rg5kaO2_yW7MpV1A9zjpBZO7mmcU7Mrllmke9WfuNPLKrVVmRWU7DQ>
    <xme:Rg5kaBHCxyrMeFS1JShTQ5RAIdT3-v35kv7sfFr3fCTZbWYszA6y8N5EFmIgkknNd
    Uc_6QbCGzMeWlberw>
X-ME-Received: <xmr:Rg5kaG4_dUyxJsBa50ercYT3IYMIgLtiwQWR1bw91EWohV85DDkjxVfuQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduhedtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopedukedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepthgrmhhirhgusehgmhgrihhlrdgtohhmpdhrtghpthhtoheprgdrhhhinhgusg
    horhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhef
    pghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtoheplhhoshhsihhnsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtgho
    mhdprhgtphhtthhopehtmhhgrhhoshhssehumhhitghhrdgvughu
X-ME-Proxy: <xmx:Rg5kaP1BNAfvhS696e5mAtZ9SW-AsKrQhObKKjqW0odq5Dphb3bxYQ>
    <xmx:Rg5kaBErCXx0yLCro1mqntOmPXgZXOTafBAonT3NYnu6jW3U3agelA>
    <xmx:Rg5kaI84K_9F2c3aba6s1VsFFCYR5xQ7FiSXmh_ij8GB3HRJldPfPg>
    <xmx:Rg5kaGkgqRLeHYWrLbiNYVaOggUO_YYKWE7CdwCIeUImlkROHCcT1A>
    <xmx:Rg5kaJHvndzRnF7fcqkxs3_AMbjQGlAGHKTegbbuDi1Qd-6rYRV29vBh>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 12:35:17 -0400 (EDT)
Date: Tue, 1 Jul 2025 09:35:16 -0700
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
Message-ID: <aGQORK02N8jMOhy6@Mac.home>
References: <20250701-xarray-insert-reserve-v1-0-25df2b0d706a@gmail.com>
 <20250701-xarray-insert-reserve-v1-1-25df2b0d706a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701-xarray-insert-reserve-v1-1-25df2b0d706a@gmail.com>

On Tue, Jul 01, 2025 at 12:27:17PM -0400, Tamir Duberstein wrote:
> Using the prelude is customary in the kernel crate.
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  rust/kernel/xarray.rs | 34 ++++++++++++++++++++--------------
>  1 file changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
> index 75719e7bb491..436faad99c89 100644
> --- a/rust/kernel/xarray.rs
> +++ b/rust/kernel/xarray.rs
> @@ -5,16 +5,15 @@
>  //! C header: [`include/linux/xarray.h`](srctree/include/linux/xarray.h)
>  
>  use crate::{
> -    alloc, bindings, build_assert,
> -    error::{Error, Result},
> +    alloc,
> +    prelude::*,
>      types::{ForeignOwnable, NotThreadSafe, Opaque},
>  };
> -use core::{iter, marker::PhantomData, mem, pin::Pin, ptr::NonNull};
> -use pin_init::{pin_data, pin_init, pinned_drop, PinInit};
> +use core::{iter, marker::PhantomData, mem, ptr::NonNull};
>  
>  /// An array which efficiently maps sparse integer indices to owned objects.
>  ///
> -/// This is similar to a [`crate::alloc::kvec::Vec<Option<T>>`], but more efficient when there are
> +/// This is similar to a [`Vec<Option<T>>`], but more efficient when there are
>  /// holes in the index space, and can be efficiently grown.
>  ///
>  /// # Invariants
> @@ -104,16 +103,23 @@ pub fn new(kind: AllocKind) -> impl PinInit<Self> {
>      fn iter(&self) -> impl Iterator<Item = NonNull<T::PointedTo>> + '_ {
>          let mut index = 0;
>  
> -        // SAFETY: `self.xa` is always valid by the type invariant.
> -        iter::once(unsafe {
> -            bindings::xa_find(self.xa.get(), &mut index, usize::MAX, bindings::XA_PRESENT)
> -        })
> -        .chain(iter::from_fn(move || {
> +        core::iter::Iterator::chain(

Does this part come from using the prelude? If not, either we need to
split the patch or we need to mention it in the changelog at least.

Also since we `use core::iter` above, we can avoid the `core::` here.

Regards,
Boqun

>              // SAFETY: `self.xa` is always valid by the type invariant.
> -            Some(unsafe {
> -                bindings::xa_find_after(self.xa.get(), &mut index, usize::MAX, bindings::XA_PRESENT)
> -            })
> -        }))
> +            iter::once(unsafe {
> +                bindings::xa_find(self.xa.get(), &mut index, usize::MAX, bindings::XA_PRESENT)
> +            }),
> +            iter::from_fn(move || {
> +                // SAFETY: `self.xa` is always valid by the type invariant.
> +                Some(unsafe {
> +                    bindings::xa_find_after(
> +                        self.xa.get(),
> +                        &mut index,
> +                        usize::MAX,
> +                        bindings::XA_PRESENT,
> +                    )
> +                })
> +            }),
> +        )
>          .map_while(|ptr| NonNull::new(ptr.cast()))
>      }
>  
> 
> -- 
> 2.50.0
> 

