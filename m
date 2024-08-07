Return-Path: <linux-fsdevel+bounces-25239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A322394A368
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 10:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D39011C226E1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 08:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745631CCB35;
	Wed,  7 Aug 2024 08:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GzjZGlae"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1DB1CB337
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Aug 2024 08:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723020647; cv=none; b=e9mUWV/NaNpuZC/uMZtEi4mQaXQyKVKX3ZZQgbV9C0KPiH8n2OFcH1D0yuC6hRqNQDtwjcdvz+mF6xZD4hyJTM4wj7a1NGNWMMC0UvHXyjUiwFGWXey+1OPBxUz/9PgOhBUqsY+6ZReolfwZe/oNZP3kqcDwe3cUEJt3h/OidbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723020647; c=relaxed/simple;
	bh=0UtNcQiBJHj5NT3vENREIzfZcUewciu8UD/RmQsY0WE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s/S8KxZUhwEJYTm/J6Fy0Rr0rMS7SwIgJAKhB8H680J7AbGEeLJj4qiapv/Fi0mRInJ1zgJzu1zzIEeAwyeOPbaJx/y1yxHiM3MmVi5pi1QDLy5ub49ylMZhsYC+iYIW2T8utwB98355BEPxq8O1UOPslBBrfKLQ1GtCZdKCd3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GzjZGlae; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ef27bfd15bso15688571fa.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Aug 2024 01:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723020644; x=1723625444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6uGG/bPgpOPhR7OkqXBHMSIeIgp9LFX//Nhl/4vdqg=;
        b=GzjZGlaeBVpzHighw8MHNjfOWpidJfcdKgNPykjrbsmaMXelJPExRjFoYlInPR+W8U
         DNkwkBWDrxQRMhvmk+TH3+TMCHZF4g4lL+xjtJ4TGfMnXCt1L8G8Wo/wjIfHcxWO2AVL
         iRfaQSsl37T1dEb9ODAgvzLWEyuYL30nPSzwq9PjyxtdqexvHiYVsUjp6UFr75mRZQ10
         RNfAWzJ2nmAYgjjLAl/P8lKHuDBVCjx0yDXqi9jjctPWJWBvPA5EQEG4IU6onjGA2afW
         vy1WBeqka9JfMXScinDzeMwJuZ7UBOnlES6prUz36YmGHwVLo7yypu/FijzZGf2ptRmc
         c47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723020644; x=1723625444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6uGG/bPgpOPhR7OkqXBHMSIeIgp9LFX//Nhl/4vdqg=;
        b=LARUvAbhSFvFHSkqlab60orz5w2s445uj727DZ0yE+T8QAjO0DSJDZEqO51jAlC6OG
         gfydJ7WHnrVSaUM7miAofmK3Zzrx7Qe+o8PqQJ/zGJZIGaKuNGt/HoyIIvsi4BQD4kYi
         AEwBmd5R+t1sWLcaLkUUBer5WdRqY8ua/vmOvtSiYFvWILL27p99Z0/Sf3KHMrpKRD8G
         tlUwuJ4ZLbufDNdmK2BMn7wNN0hg2uIojw5Xid2Pcf7nj5+yN1UpCz7yddicEbNlk2gr
         9SRjy36nR6Sggm9+82sM/RdcxO3Sxcoz/B+Pd62ZUSHHceuZh4FIkA5OeRA06G1aepTO
         S4mg==
X-Forwarded-Encrypted: i=1; AJvYcCWcQog00nsfN6nWbMu4EBJdEu4gc0SXXrZrADyxaAQ1Nnijd+MwkjJMK4AlHYzYG/Uy4INj2ctnO5XUfUu1/RjKPwiqgLZvqC4e1wqEyw==
X-Gm-Message-State: AOJu0YzvDScqu2jBeKL5WMhMJW1uvFpi43DIbn9JJxBqQTeM+dQTMojU
	jjLK8JLhor4twXEzKI4Onz+uTNh2S9TpCy2KoRhw/vadIWjXARt/2nw1EMGKK15m/tgIdsMiVn7
	daTTBV+ZmrWbca+7idxt9ucdCxIRaY7J3dsqX
X-Google-Smtp-Source: AGHT+IGccCHlno0tQbb4yPLv0HzWQPlEIf88SJrHYSG7o6Dmgd4Psom8noOTBXPXyYsqb4J1FgwIajAF4YxG75Q1TCk=
X-Received: by 2002:a2e:91d0:0:b0:2ef:1c0f:d490 with SMTP id
 38308e7fff4ca-2f15ab0c2a1mr126113241fa.39.1723020644050; Wed, 07 Aug 2024
 01:50:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725-alice-file-v8-0-55a2e80deaa8@google.com>
 <20240725-alice-file-v8-3-55a2e80deaa8@google.com> <4bf5bf3b-88f4-4ee4-80fd-c566428d9f69@proton.me>
 <CAH5fLgi0MGUhbD0WV99NtU+08HCJG+LYMtx+Ca4gwfo9FR+hTw@mail.gmail.com> <ZrJ5kORJHsITlxr6@boqun-archlinux>
In-Reply-To: <ZrJ5kORJHsITlxr6@boqun-archlinux>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 7 Aug 2024 10:50:32 +0200
Message-ID: <CAH5fLgj2XEvjourzW4aoRDQwMGkKTNiE7Wu9FVRrG=7ae1hiWA@mail.gmail.com>
Subject: Re: [PATCH v8 3/8] rust: file: add Rust abstraction for `struct file`
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 9:30=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> wr=
ote:
>
> On Tue, Aug 06, 2024 at 10:48:11AM +0200, Alice Ryhl wrote:
> [...]
> > > > +    /// Returns the flags associated with the file.
> > > > +    ///
> > > > +    /// The flags are a combination of the constants in [`flags`].
> > > > +    #[inline]
> > > > +    pub fn flags(&self) -> u32 {
> > > > +        // This `read_volatile` is intended to correspond to a REA=
D_ONCE call.
> > > > +        //
> > > > +        // SAFETY: The file is valid because the shared reference =
guarantees a nonzero refcount.
> > > > +        //
> > > > +        // FIXME(read_once): Replace with `read_once` when availab=
le on the Rust side.
> > >
> > > Do you know the status of this?
> >
> > It's still unavailable.
> >
>
> I think with our own Atomic API, we can just use atomic_read() here:
> yes, I know that to make this is not a UB, we need the C side to also do
> atomic write on this `f_flags`, however, my reading of C code seems to
> suggest that FS relies on writes to this field is atomic, therefore
> unless someone is willing to convert all writes to `f_flags` in C into
> a WRITE_ONCE(), nothing more we can do on Rust side. So using
> atomic_read() is the correct thing to begin with.

Huh? The C side uses atomic reads for this?

Alice

