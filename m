Return-Path: <linux-fsdevel+bounces-21665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38493907BAA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 20:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB963B21A90
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 18:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A894814B081;
	Thu, 13 Jun 2024 18:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhWY2K2g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862EB1474A8;
	Thu, 13 Jun 2024 18:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718304100; cv=none; b=n4EO0xvVBBPIXqXhy9TPllIL/b6Bw1rBA7BxVbFNR+0HFEekCTvnHmWvQLylaidTYbH09lYHguQxYFvpoohnbPGGQv1ZrPngutbDyZUgyVzdaAkjK8LFL1RcTMYFrfqWlgJdScUMqoqgsyLItuMTM6UHoFAZrdd30OTZ8ynMD4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718304100; c=relaxed/simple;
	bh=amGSNkuYZB0XCNHVCuqq5opb93LhyCeDQHR83Wi92Ko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SlMN3h41I3IFNEHPbqsJOgTgq7mmppNq5UjpaF+O/12UdoFUiMNvLuGR7Vp9fwRImSdi4ibhf4NFzjzj6Uh9s4wiIXCdLn8M72Gx0f8DYXLD3asZD891QFXvb+HpLHtMVNBQWvPkscnAe4qa8ldbDUiOjAaUkdZsdSoDFr0p36g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhWY2K2g; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a6f21ff4e6dso232437166b.3;
        Thu, 13 Jun 2024 11:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718304097; x=1718908897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amGSNkuYZB0XCNHVCuqq5opb93LhyCeDQHR83Wi92Ko=;
        b=XhWY2K2g3qx8HpRWTqsOL8TMmSCXK8Uryph5169lP0BHgJt8nJzxZR/Oe/DsevXiPg
         6jPpAQS4hWTsKZ+qrjX6UMR8aDQhWztczB6gVTwJtc+jS7JIjtJED+WdK20SOuYatq7h
         8W7dHypucoaN/1Z+y/a2DyPztzdsQUM0bK4MBB6JelteNrx7zhsK2VlBk7uHEpRO16Am
         M/RCiT+UONVpnRDYK38LG9ZkcezNZ/4Y32mzceto4QZmkWFfSMKJYDz0qECmrSBjeeuf
         Ogmob8t+sK6+qyLTDcBfIQY75kEEWURKxR85BItBEna+zDir3G6ewfauGnBK3+u8lMtv
         Jbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718304097; x=1718908897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=amGSNkuYZB0XCNHVCuqq5opb93LhyCeDQHR83Wi92Ko=;
        b=Yyf1UvJBKOefNVNTO5nP1eMQhYy7hcQrGeI/CrLM4K+1aGdXTQG2/sXgXXgNilB37T
         1Tl+0RdUJ5DgvwLhNM3t/wFkBTZc3oiRhTyS1Vodoby0u2LRxpIoZd3c9r42urlQw9z4
         ZcQkrFzGHRwfx+1Wwu/czrWOIW36+069JJGI2gkDK0aHPua3C6RtorzrS22+y4Lk7tns
         ogbZq+sZuJ9KKhjt8QezrrKzgccqenWbQK1q10/eFE+1AST7znKMshedJ5yMxiCDSqxW
         F6+JhhT7KM6jQhvsIZx7s+h51t+94ehuzrpUyhK9Tj1YvhBpkpunzJ8i9eryU8pK5q9X
         SRlA==
X-Forwarded-Encrypted: i=1; AJvYcCVVGXHiGBhooN+b45O7sZ0lmA9Qfs7733QHElGllkJR0MqC4PXCpjcHo9PRkOSwm0B0mbbs+RvsZCcrmocyTWT5FQEy2zYfZjdzKuTCeQNr6InFvpwFKKb6xEdP0n5KLLUGPbhAhas97+fRvA==
X-Gm-Message-State: AOJu0YxkJFIuji0W6XizF41LtprHC5w1seQhyc+U6t9dLgfrxnuIX8WV
	8A6vTULOXicWc9woN3cK+7VDxlyvxeqITZ8xvvMp9Wzm5c5xFUckw2P0bZftIv/LMQz4kulAEwL
	Vw2cDqcKa9khLgQeTwCi9pz3Z8oc=
X-Google-Smtp-Source: AGHT+IEij0SFraMRbDWTv77RCsC6qMQVXeV0gVBm7kzi/ULX8SdmssM4kwH2M+1G7piP1h3CcusXE7c/eSKI60abv/Y=
X-Received: by 2002:a17:906:607:b0:a6f:53a7:ada9 with SMTP id
 a640c23a62f3a-a6f60dc1f9dmr34985666b.59.1718304096741; Thu, 13 Jun 2024
 11:41:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613001215.648829-1-mjguzik@gmail.com> <20240613001215.648829-2-mjguzik@gmail.com>
 <CAHk-=wgX9UZXWkrhnjcctM8UpDGQqWyt3r=KZunKV3+00cbF9A@mail.gmail.com>
 <CAHk-=wgPgGwPexW_ffc97Z8O23J=G=3kcV-dGFBKbLJR-6TWpQ@mail.gmail.com>
 <5cixyyivolodhsru23y5gf5f6w6ov2zs5rbkxleljeu6qvc4gu@ivawdfkvus3p>
 <20240613-pumpen-durst-fdc20c301a08@brauner> <CAHk-=wj0cmLKJZipHy-OcwKADygUgd19yU1rmBaB6X3Wb5jU3Q@mail.gmail.com>
 <CAGudoHHWL_CftUXyeZNU96qHsi5DT_OTL5ZLOWoCGiB45HvzVA@mail.gmail.com>
In-Reply-To: <CAGudoHHWL_CftUXyeZNU96qHsi5DT_OTL5ZLOWoCGiB45HvzVA@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 13 Jun 2024 20:41:23 +0200
Message-ID: <CAGudoHGRMnPo7bAGGz6VcvzMMROjyWapO3nYdb+fW-iDEYDbgQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] lockref: speculatively spin waiting for the lock to
 be released
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 8:13=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> On Thu, Jun 13, 2024 at 7:00=E2=80=AFPM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Thu, 13 Jun 2024 at 06:46, Christian Brauner <brauner@kernel.org> wr=
ote:
> > >
> > > I've picked Linus patch and your for testing into the vfs.inode.rcu b=
ranch.
> >
> > Btw, if you added [patch 2/2] too, I think the exact byte counts in
> > the comments are a bit misleading.
> >
> > The actual cacheline details will very much depend on 32-bit vs 64-bit
> > builds, but also on things like the slab allocator debug settings.
> >
>
> I indeed assumed "x86_64 production", with lines just copied from pahole.
>
> However, to the best of my understanding the counts are what one
> should expect on a 64-bit kernel.
>
> That said:
>
> > I think the important part is to keep the d_lockref - that is often
> > dirty and exclusive in the cache - away from the mostly RO parts of
> > the dentry that can be shared across CPU's in the cache.
> >
> > So rather than talk about exact byte offsets, maybe just state that
> > overall rule?
> >
>
> I would assume the rule is pretty much well known and instead an
> indicator where is what (as added in my comments) would be welcome.
>
> But if going that route, then perhaps:
> "Make sure d_lockref does not share a cacheline with fields used by
> RCU lookup, otherwise it can result in a signification throughput
> reduction. You can use pahole(1) to check the layout."
> [maybe a link to perfbook or something goes here?]
>
> Arguably a bunch of BUILD_BUG_ONs could be added to detect the overlap
> (only active without whatever runtime debug messing with the layout).
>

So I tried to add the BUILD_BUG_ONs but I got some compilation errors
immediately concerning the syntax, maybe I'm brainfarting here. I am
not pasting that in case you want to take a stab yourself from
scratch.

I did however type up the following:
/*
 * Note: dentries have a read-mostly area heavily used by RCU (denoted with
 * "RCU lookup touched fields") which must not share cachelines with a
 * frequently written-to field like d_lockref.
 *
 * If you are modifying the layout you can check with pahole(1) that there =
is
 * no overlap.
 */

could land just above the struct.

That's my $0,03. I am not going to give further commentary on the
matter, you guys touch it up however you see fit.

--=20
Mateusz Guzik <mjguzik gmail.com>

