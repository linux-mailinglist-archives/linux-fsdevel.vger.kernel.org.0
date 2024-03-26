Return-Path: <linux-fsdevel+bounces-15316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D8888C1DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 13:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 563501C35A69
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 12:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FD871B24;
	Tue, 26 Mar 2024 12:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKU0TMDg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84991804F;
	Tue, 26 Mar 2024 12:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711455438; cv=none; b=F/gydIqqkB4mcwSK/HvhkVnp/4DA3MwYDSK6p608cCmfMtWCz6Xfm+BwTfXW52uZT2wOm5Ab5hswGlJdOS1LvzTcjpoA8pi+RDq0hE9lGuhiPQ7GWWwkLnWTqj498ZQXYD+Ggp7m/kOqT+qcT+DcTadlTRkCkdSLLGGCvQto6i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711455438; c=relaxed/simple;
	bh=Dt0T6V3vcn3a+aSpTutkV9rwOiEdimyLRfIl6wNYK2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yinj58rO58FaqAJRlzQn4Ny4p02yDEuWOutgDvh60rzjYpNwYyKfeb2U0rgVidegBIFPW4xImklvu2avGc6UzMNvH6ePEiQ3ysbTVyshzfm3/jmhWrSmqzES6gzDzd8RVVpc6JNDSxY8bvVMNTd4xVxHtnaghuw54TEldddbg7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKU0TMDg; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ea838bf357so2834887b3a.0;
        Tue, 26 Mar 2024 05:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711455436; x=1712060236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dt0T6V3vcn3a+aSpTutkV9rwOiEdimyLRfIl6wNYK2k=;
        b=fKU0TMDgvu6sgUCMB5FDd0gNYXuaae4/x0JVHiWk6v6bYS2067VIunjRy3VDUMX7iz
         8RvaxuISjRQMtNdb7tB6iGsBuIuWfZ+V74anmF7TQC5JodFJFprd04NIM/s+knnBTmP/
         6n9DEk5a49vhknmuxSvRn6iQvxaTrWpFX2vUgr+cjP6hf/It4W3CR0meblkRpsjKBZPR
         TnYTFQveGbIRN0+fJPCdQrkxKx9zRH3DCOFs3vI/On5fUNkvnO9s4qgL0zGazWJY/wlC
         hH2ljLTl71txgst1Xxdnpzd1A3JMeFAMgusLxoYx7ADrp1Ff6jk0dr/jaNAqqgMWOeJG
         O3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711455436; x=1712060236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dt0T6V3vcn3a+aSpTutkV9rwOiEdimyLRfIl6wNYK2k=;
        b=H3IKZX29jQXJ/mWYH9gp8wJaCt+2LjWci6vQLP2SByD2xznX8/S4Z+KBDrAfIdTqQm
         hCIjCZJHjWqY1LI/t3sfCZIJazvkp1NfZPZkaKjMB1EU7xlDPZbjsdtgo27zE/KajzhA
         HduhG+TMEbPvxZn+Aa3I8VMkYQOGK5p6Kf5RZGj/qr31wOJvh/W/Z7Zt4Z96PVtnlxfF
         pKgJO8hWapXXeB6vL4adAv3BMfvP9nSkvzFycAgEVrHx1Z7qKhOwQkITi2Kl8BK5JcYT
         gJSr7K7ECjytyZAlTZgXHxNnXklFM5t0vypG9XSSBL+9Qy1OI6YZdv99tkwvpLO2dw5m
         pjKA==
X-Forwarded-Encrypted: i=1; AJvYcCVSZf6ueL4634hR6D3gBzwRUvqSvzolKFXNsQu4PI5u0y0OS+k0+qRUiJOSc/DC0A+YrPbKRA/UPnllQYg+HXGOF9jGCINtkkRTSxm38FGmZB+j8tVWCtCyLKvTqztPOaCtuMhCppzjkbu6u2KK
X-Gm-Message-State: AOJu0Yz9cM9+EairnomrJgM76HYqKaXOkdOQmDxRiTrdcgHsr5+Jkcea
	1Pa+o0o4Apirp6ixVCDwgTE3g9v+8NVhN+1zBRewCrD+qrpQxgmwxywKNG+kz0GBxENL+sxtFEg
	TpB/WmKpjU0G2omBfhBYZ+s3tGOQ=
X-Google-Smtp-Source: AGHT+IF9/Fj72BK7UBXjIumW02cGwOxIINbIQgiOjOPO1QmJgX9I+JN+WPgCESKLPWR1q7KCgXnOckhQsyjxd05iu6Q=
X-Received: by 2002:a05:6a20:2d21:b0:1a3:6a71:8282 with SMTP id
 g33-20020a056a202d2100b001a36a718282mr11323963pzl.0.1711455435940; Tue, 26
 Mar 2024 05:17:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240309235927.168915-2-mcanal@igalia.com> <20240309235927.168915-4-mcanal@igalia.com>
 <CAH5fLgi9uaOOT=fHKWmXT7ETv+Nf6_TVttuWoyMtuYNguCGYtw@mail.gmail.com>
 <c8279ceb44cf430e039a66d67ac2aa1d75e7e285.camel@redhat.com>
 <f0b1ca50-dd0c-447e-bf21-6e6cac2d3afb@nvidia.com> <Zfzc09QY5IWKeeUB@Boquns-Mac-mini.home>
In-Reply-To: <Zfzc09QY5IWKeeUB@Boquns-Mac-mini.home>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 26 Mar 2024 13:16:48 +0100
Message-ID: <CANiq72kmRJpAf07f7LE=M2RRtTrqbc40A8kP2T_xWA_-q4o4Fg@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] rust: xarray: Add an abstraction for XArray
To: Boqun Feng <boqun.feng@gmail.com>
Cc: John Hubbard <jhubbard@nvidia.com>, Philipp Stanner <pstanner@redhat.com>, 
	Alice Ryhl <aliceryhl@google.com>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Matthew Wilcox <willy@infradead.org>, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 2:20=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> One more extra point from myself only: if one is using Rust for drivers
> or subsystem they are going to take care of it in the future, it's
> totally fine for them to pick coding styles that they feel comfortable,
> I don't want to make people who do the real work feel frustrated because
> "this is how Rust idioms must be", also I don't believe tools should
> restrict people. But in the "kernel" crate (i.e. for core kernel part),
> I want to make it "Rusty" since it's the point of the experiement ("you
> asked for it ;-)).

We should aim to be as consistent as possible for all the kernel, not
just the "core kernel".

Yes, there should be flexibility. In fact, sometimes it is just
impossible, unreasonable, impractical and/or annoying to be
consistent. And, as you say, we should definitely avoid making people
frustrated for inane reasons.

But we should not introduce flexibility for bad reasons either.

And this is the kind of thing that it is very hard to restrict later.
So even if we are a bit "over the top" in some cases now (the current
compiler/Clippy flags could be already arguably so, at times), the
point is to figure out what makes sense to keep long term. In other
words, instead of discussing how to create local coding styles, we
should be discussing what should be changed for everybody (e.g.
because a particular diagnostic may too annoying now, because a style
is found to be better than another like `if ret < 0 ...` vs.
`to_result` and so on).

Cheers,
Miguel

