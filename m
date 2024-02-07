Return-Path: <linux-fsdevel+bounces-10594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A733084C92D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 12:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF457B25572
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 11:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283711805E;
	Wed,  7 Feb 2024 11:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LyUk6azY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A3E1B5B3;
	Wed,  7 Feb 2024 11:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707303979; cv=none; b=EFycXeqWdIOnYvj7J2xKofdmQAkKmPIkpyd/p8CuvooCbMRs5WE3fUH05MgjoIIAio6y+hz1ltrRZNX00cIVsvM53i9eh38F3Fz13GYjp/4MrJqgBnHRWLUp2blBlJ1eoaG99ckwxmDQLgNfqrUY7KmFmyE12n5GFIm2zfJJIhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707303979; c=relaxed/simple;
	bh=OqkbEuGG7NXNqpM7nP0dy4/Ha5w5xp44TS/914MtwbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fcZy1AqQovtjhlwq3bk9feiwVUO/BGJ73H8i1YNdpJrpyfKmgJGpOo0wgZAH/lmusqMD9ke2yQx4geFxp5gHfMOIFYM6rftMzLNfVnpueeff06VqLahY7b4z+2djmeNKNwr2JERZ9ptsYR8HPOPV6ONf2A7tjNxMJGi54U47ejY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LyUk6azY; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-60498c31743so2221627b3.3;
        Wed, 07 Feb 2024 03:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707303977; x=1707908777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqkbEuGG7NXNqpM7nP0dy4/Ha5w5xp44TS/914MtwbI=;
        b=LyUk6azYXsjk8lFUNp3vlorkUVdhQxGkTzC9RGkqmsJBYBY1TiVE5sLxZyVilP1hHi
         GqI/TVOdU8oVvf9+/Cj/ivxtO5ZpaKRIUCnKEkGANU3wMSUpYVZFyhTrKgTJkfFQh9v4
         Cse/bfx4IGX7qhhFExMVEFfhGADNkxMShjn4DgFWGdix2ykCXre7gVZkWe0iJJ3fGWZT
         qrSdRB7i9ikpVjmtPS0N0A2DdHTVbzvJ3oqM9oquCRlZZ3dfB4kKdxwPOXvGWlwSqP6s
         puDTzzWSUzsRlHFPlSK+m3+FrGc3ZNJcnhn487Hp+pO/ryoxQ2Mgnr5OfTHjYOhxITPE
         WKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707303977; x=1707908777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqkbEuGG7NXNqpM7nP0dy4/Ha5w5xp44TS/914MtwbI=;
        b=a0qhxnV6gAfql4FH1MS/s/4GKRvMSCLM8bMW2Khs6hxBVUY3ZTCXMcVJcu2As4h3jA
         Y6hM15iJk3dICV2eGiUDtgad+T/h8wOFC6gPLN6f6t9OdbvjVbNvrseOwV1LASs+bWfk
         aslUb8VHRauslJrtsLgf1Au3J4ez3CQOSUZtP1mFHCo6NLfq6uJqQZnEFXFyfiaUp7ec
         g+c7ezrBhG+DpQSJbkoAY7zQUTN1vK7tbYy08I/tJxpGWfFTKAeVqPP2O1Ckx6vuel7x
         xwU10V61OSN1UQLNfDFDaJQp6wbpO+xCgYSmmQUGSWJEUWXU6KqBgIkj+riJtOwre5sy
         CNHw==
X-Gm-Message-State: AOJu0YykJ80HphzGKg1NX0DesnzyqmEeAtzTRZxDXt0ElvRNH4LBLgnK
	E2jCwhu17A9DyPmXmdhHct9HK9fLd6LHd9wB2zGElmRH5yzz4iiv3ydh+jRMpOFv1TWRMdowzrb
	dilgCwfoPVZmXJIQAp/QNUR/uUc4=
X-Google-Smtp-Source: AGHT+IHsjU4hinncRp4nROnRthRfO5WuZrBm8ZzErP9Em5jlbg9uemMNuNGdo2qGiNircg3XmtvcQBYwXyIonIoOHNo=
X-Received: by 2002:a0d:d991:0:b0:604:9403:f76b with SMTP id
 b139-20020a0dd991000000b006049403f76bmr855659ywe.51.1707303977017; Wed, 07
 Feb 2024 03:06:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207055558.611606-1-tahbertschinger@gmail.com>
In-Reply-To: <20240207055558.611606-1-tahbertschinger@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 7 Feb 2024 12:06:05 +0100
Message-ID: <CANiq72=00+vZ+BqacSh+Xk8_VtNPVADH2Hcsyo-MPufojXvNFQ@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] bcachefs: add framework for internal Rust code
To: Thomas Bertschinger <tahbertschinger@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	kent.overstreet@linux.dev, bfoster@redhat.com, ojeda@kernel.org, 
	alex.gaynor@gmail.com, wedsonaf@gmail.com, masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 6:57=E2=80=AFAM Thomas Bertschinger
<tahbertschinger@gmail.com> wrote:
>
> This series adds support for Rust code into bcachefs. This only enables
> using Rust internally within bcachefs; there are no public Rust APIs
> added. Rust support is hidden behind a new config option,
> CONFIG_BCACHEFS_RUST. It is optional and bcachefs can still be built
> with full functionality without rust.

But is it the goal to make it use Rust always? If not, do you mean you
are you going to have 2 "modes" in bcachefs? i.e. one with all C, and
one with some parts replaced (i.e. duplicated) in Rust?

If it is the former (dropping C), then please note that it will limit
where bcachefs can be built for, i.e. architectures and configurations
(at least for the time being, i.e. we want to relax all that, but it
will take time).

If it is the latter (duplication), then please note that the kernel
has only gone the "duplication" route for "Rust reference drivers" as
an exceptional case that we requested to bootstrap their subsystems
and give Rust a try.

Could you please explain more about what is the intention here?

Either way, the approach you are taking in this patch series seems to
be about calling C code directly, rather than writing and using
abstractions in general. For instance, in one of the patches you
mention in a comment "If/when a Rust API is provided" to justify the
functions, but it is the other way around, i.e. you need to first
write the abstractions for that C code, upstream them through the
relevant tree/maintainers, and then you use them from your Rust code.

Instead, to bootstrap things, what about writing a bcachefs module in
Rust that uses e.g. the VFS abstractions posted by Wedson, and
perhaps, to experiment/prototype, fill it with calls to the relevant C
parts of bcachefs? That way you can start working on the abstractions
and code you will eventually need for a Rust bcachefs module, without
limiting what C bcachefs can do/build for. And that way it would also
help to justify the upstreaming of the VFS abstractions too, since you
would be another expected user of them, and so on.

> I wasn't sure if this needed to be an RFC based on the current status
> of accepting Rust code outside of the rust/ tree, so I designated it as
> such to be safe. However, Kent plans to merge rust+bcachefs code in the
> 6.9 merge window, so I hope at least the first 2 patches in this series,
> the ones that actually enable Rust for bcachefs, can be accepted.

This is worrying -- there has been no discussion about mixing C and
Rust like this, but you say it is targeted for 6.9. I feel there is a
disconnect somewhere. Perhaps it would be a good idea to have a quick
meeting about this.

Cheers,
Miguel

