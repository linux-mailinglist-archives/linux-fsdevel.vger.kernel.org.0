Return-Path: <linux-fsdevel+bounces-57356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E05C4B20B0A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 16:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3114B18C4DA8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 14:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3A22E1745;
	Mon, 11 Aug 2025 13:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrfYGa6b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90922E11D5;
	Mon, 11 Aug 2025 13:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920606; cv=none; b=bukuGAi5xobqd7tWZaN/l095ieDM64F7sVRJ0KmtZ91JIavH4Chri4lYoPz8GcTFvR/gRkg/GH4a27k7hReLip+8GFyE4xytGSZdmflD0s7pGXm/K4INRI4ZL1dIh1lBvtOaRCrX1BgQElQF9m3moHzhBYxjg4V5qk98cAMncNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920606; c=relaxed/simple;
	bh=tCOQyeQgQCrSvbOG3qdi00ec7ZXwXD5w2RBXU1VKOdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y/JzrpLrIduRXJQF5EhyiJ06n9F7hPljbCkbQTQc5T8Fo2ZSLnmba7T0F6kUm4fzgedqBQ3FFFzHgVIseaubi1utpRO5LUJCkILaWdmb8BcvDVUl7eApBkKz6JZ8gSo1ZyWKdmdoNQ1OqG+5dWnf0Z2YNCjJSe8Oc1dopf8X+GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrfYGa6b; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b3be5f9287aso186597a12.3;
        Mon, 11 Aug 2025 06:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920604; x=1755525404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCOQyeQgQCrSvbOG3qdi00ec7ZXwXD5w2RBXU1VKOdY=;
        b=hrfYGa6b6+129OG86sexxlwxwflJlNWFJIqHUanMJtxuDf4v17INC1xppagw6GDixd
         88Mg8a3LxI+MAjDSy9wvAaKCcGvhzRhV9fVBf66krwAdCAdDasVT79L7yKx7qA7ceqJd
         xWffCfiEDfeg9rKEEgtnPiPYoFEjkWeJdHEBzYH3EDuvsuSZDKeJb7IFzZVwWSEfLRpE
         DqmwKSyDULU79gCORFnUQnMXSUuM/2vvBQOHgfYhY+VKyuvjuqSa6IG1qPyNFS53JDw/
         GQ72eBwtceIux3ByqcYP+AirfcBGfDd3uQqobnfqHKhuEVQGAwjEghT8/5VP7wNr80uT
         nI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920604; x=1755525404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tCOQyeQgQCrSvbOG3qdi00ec7ZXwXD5w2RBXU1VKOdY=;
        b=h8UxqLMMFm2n2vBL9aMdnK8TMKNUeFYIzs1k0ZXD6QTXwpDCS9K9nsYkGOkgDJoOB2
         q3fGj9HYpu+1RNlIY45L09kShpypVCwZPbwmUtH8hVosJrxwRi51+Ks9gDGRTJFFCjq5
         V9ei83V+7e8AkPq91C6Dc9gVneR72cRC//qBU61dPZxp28doldKYLDLC4H5fbK2e4l+o
         thaj0fZEggwm8MqreIH9VXkQsc1KE//O2PTL+7zwGyBV0txUwjIhaPlQyKyaVZKmrq+8
         y4xQq3Gj9OSlYBooKQjMkaBvUmVYmftZJEI/BkRiCTBaB8iUMvAtNmCAfmSaO4VTsvmg
         MdZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXPwnbocU3z8YC7/J9xImx7HF8Mt//ncqJjHaxHt0QMPjuzFrNBWYGhwQYcFPL4PhsLxHvEcQooXgR6k6vBzQ=@vger.kernel.org, AJvYcCVsINbtA4UXiza3jaW+l6UxHLKGWJBnTIuYmaObv2nmKhhKNhkskrAIgIMtEz1iQpaCPw3uJfgGv06/4tlZ@vger.kernel.org, AJvYcCXY/ifRvoqsAYvjC8bIgBMMRcv7I8Iel8LH/Vdl/6X58YEk3ohOwLdk3kPUyKPMuDYcWkwrkJC7zwwJzNUq@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ8goWJBk0V61tB/0t2U+D98Ek1djBkA7U3EBPNRtYOIVwyjkh
	Gjy/z4HMaoPK36AH0GgpwyT77wd8qHEgeutk5bdgpkvMHSChhoOfwVQTy82VvQNbyDQzF4v3Oo3
	/r6T04+IGPuriaNjJk4fE24gSKnqDF3c=
X-Gm-Gg: ASbGncsqF/6nGyMR10NCwzAmHjwbit/Isosrr2MKcIX0WOadL9AwAkb58d6fgKYd5bj
	eTfBsO5Ve25N6vac7VWPP8jL2PLRL1F+KJexdRr7C71x0JohxibkmVFVlzssPO+zAG8rA4xuRVe
	9wy32wQumIImwc0QPlPy0G4OH7wXXU6mspSwHYo0C0bQY9kv5kThgBj1gRTlHvZe7lmB/GHx3KC
	78jmWcF
X-Google-Smtp-Source: AGHT+IGm51CikGHL6+jYmpTwxrPxuovvEiRL6i4rcZPBDkpdQusZ94Avk47mANayPiICPGjLYk5AoIIPxCie5iZ/BD8=
X-Received: by 2002:a17:90b:1c85:b0:31f:3d6:6d98 with SMTP id
 98e67ed59e1d1-32199dcd917mr5571397a91.5.1754920604001; Mon, 11 Aug 2025
 06:56:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250713-xarray-insert-reserve-v2-0-b939645808a2@gmail.com>
 <iPv7ly-33WYOq_9Fait3DBD6dQCAn1WCRGwXjlPgNBmuj5yejzu0D6-qfg3VYyJfwu9uS4rJOu9o3L2ebudROw==@protonmail.internalid>
 <20250713-xarray-insert-reserve-v2-3-b939645808a2@gmail.com>
 <87o6smf0no.fsf@t14s.mail-host-address-is-not-set> <CAJ-ks9kTacXO_PbcH8c-60Ae88vJ_w6_pbmXLzOpzTKgRjiXPw@mail.gmail.com>
In-Reply-To: <CAJ-ks9kTacXO_PbcH8c-60Ae88vJ_w6_pbmXLzOpzTKgRjiXPw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 11 Aug 2025 15:56:32 +0200
X-Gm-Features: Ac12FXxaMvGNNkQ2aB4e9UkhjuY-poUIRWZU0YDLB8I_zmJcCDsbhfY45An33jQ
Message-ID: <CANiq72nR1EfB3SRyusswrHY0Wo1JYky_Cap8Lb1NjuHGwC9ggA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] rust: xarray: add `insert` and `reserve`
To: Tamir Duberstein <tamird@gmail.com>
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

On Mon, Aug 11, 2025 at 3:43=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> I think I prefer to hew close to the C naming. Is there prior art
> where Rust names deviate from C names?

If it is a name that exists in the standard library and that we have
to use (e.g. for another standard type/trait), then sometimes we pick
that name instead of the kernel one.

For certain things, like constructors, we try to follow the usual Rust
conventions.

Moreover, sometimes there has been arguments about the chance to
improve naming on Rust abstractions vs. the underlying APIs, e.g.
`iget_locked()` vs. `get_or_create_inode()`.

But, generally, we stick to the C names unless there is a good reason.
It depends on not just the code, but also the C side maintainers and
their plans.

Cheers,
Miguel

