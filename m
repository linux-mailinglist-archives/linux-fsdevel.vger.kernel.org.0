Return-Path: <linux-fsdevel+bounces-27008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE9C95DAA2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 04:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34E8F284754
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 02:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2A626AFB;
	Sat, 24 Aug 2024 02:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YwL2qKBU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCBFEEC0
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Aug 2024 02:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724466323; cv=none; b=KD1zMlal+dlF3Orw42sRMWcbyY1PRrx++uiAm/5RZ42pVVgkG51Teuv7wDPAlvOVravGbjf4XV6/8BzFbwEk3lU7rO9dtnbZHaiU2rr5LQ/+n9R+PhrhGLvipgO4K9Xf0zbZbxS6teaePOhaj9rOziWnbDAgjDbklL3x5gf9DFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724466323; c=relaxed/simple;
	bh=Qqf15j6v2yiLLe8CF3OCSjA/vKpAkg09Fp7KgnUeagw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LnoWU0Mdh/ryKCnMIpCBC6vOF8KMC3BWSKzRe4XBpvoF86vW1Dfhjqkyt3pCtLb9he6DZt+NswwERmPxU+C+aqUicRWYFd/pLhrEA1qNO6XByayAlIlMvMkLbp+UbVLr2iApUbeSeJ11y+jM8zjC571D8TszEhLTiZgl1mB8cUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YwL2qKBU; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8696e9bd24so257438266b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 19:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724466320; x=1725071120; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2xKPzNyZISPiEHK/cpzIhG4H3Lo5I0AHNFIjgfYtaa8=;
        b=YwL2qKBUS/r0SNnrw7mB1sx0+KXpvOHNmsKeM/YQpjspukQlK5OPy6fey2wtH75G7o
         HVgb2GTQ4UbICMTLrgAugiDZp3P7KtLTMrg+k8tGbzpFghJ9o0I7E88pV/JwMSDNkLm7
         okK21cPYeqmfUptWTPIJ1/O8YWU3k6GXW/POU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724466320; x=1725071120;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2xKPzNyZISPiEHK/cpzIhG4H3Lo5I0AHNFIjgfYtaa8=;
        b=pGdXzhCVFZWtp68Sb07jP3EbapsNTRodgwALXwUoA3fbqQkPwPioebw/8HG4l8aORH
         7sD9D+yZ4WymNiTZCn5YhmRX4zglNV6JVKsiVfXFC3Un1bTVcIXkXyXC2at0d1tmmP2+
         2lkirDI7cJGQPvz1yvqIaIx/RGaox3RK2vDAX/ijrVGnTGd6RnzC9hjt+Tp7tzxStGf+
         i9fx6esO2Ilm5GhjmxOOBNlua+hlGiLWS0utu3BkB4HxOSbvhnc+RKnDojUre+/qc0+z
         BuzvlxPXGKtIbElFuTPjmMvOtM3gOR+FOUNXa59I5psgI3CGIq9AcOo+dWvOEGU9x4mF
         Y1rw==
X-Forwarded-Encrypted: i=1; AJvYcCUx4l6xFkh0k6C/+zTPQeNCiiEgrrUCKQAYC1JcSgp3Qr9J24De5hzQ2AvE2mrGri6sE5m2a34nxArqC93A@vger.kernel.org
X-Gm-Message-State: AOJu0YyQBRgtlR6Pgru1nGrTFS3CfNuge2pWfbMNVPvFmlmZj5GBfWtG
	1s0LGbX4dKQk/KSNxKITwM0APelJt762MB0KPuuR36OE0ijXbjJThQRMfgcl8vGO/CBovdIgyEO
	JF5WZQw==
X-Google-Smtp-Source: AGHT+IFgeb9qBEb8taoJyzTiFDJuCgWKiOr/AooGQYRdRmjxQnqB+yifpdOpnZdHamUS9OzI252nrA==
X-Received: by 2002:a17:907:e6a4:b0:a7a:ab8a:38a with SMTP id a640c23a62f3a-a86a52b8a16mr286485766b.27.1724466319545;
        Fri, 23 Aug 2024 19:25:19 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f2b1563sm336036866b.85.2024.08.23.19.25.18
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 19:25:18 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5bec7d380caso2799100a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 19:25:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUud6LsN5t5ceijyF/CTjFO/y42SjLEi7xpFWsYtkIV3VPUMtKFoC1Atxl8+LSdbx7/wUgeRRwFQBTuVcXl@vger.kernel.org
X-Received: by 2002:a05:6402:43cc:b0:5bf:8f3:7869 with SMTP id
 4fb4d7f45d1cf-5c0891791e4mr2666131a12.21.1724466318472; Fri, 23 Aug 2024
 19:25:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <sctzes5z3s2zoadzldrpw3yfycauc4kpcsbpidjkrew5hkz7yf@eejp6nunfpin>
 <CAHk-=wj1Oo9-g-yuwWuHQZU8v=VAsBceWCRLhWxy7_-QnSa1Ng@mail.gmail.com> <kj5vcqbx5ztolv5y3g4csc6te4qmi7y7kmqfora2sxbobnrbrm@rcuffqncku74>
In-Reply-To: <kj5vcqbx5ztolv5y3g4csc6te4qmi7y7kmqfora2sxbobnrbrm@rcuffqncku74>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 24 Aug 2024 10:25:02 +0800
X-Gmail-Original-Message-ID: <CAHk-=wjuLtz5F12hgCb1Yp1OVr4Bbo481m-k3YhheHWJQLpA0g@mail.gmail.com>
Message-ID: <CAHk-=wjuLtz5F12hgCb1Yp1OVr4Bbo481m-k3YhheHWJQLpA0g@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs fixes for 6.11-rc5
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 24 Aug 2024 at 10:14, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> On Sat, Aug 24, 2024 at 09:23:00AM GMT, Linus Torvalds wrote:
> > On Sat, 24 Aug 2024 at 02:54, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> > >
> > > Hi Linus, big one this time...
> >
> > Yeah, no, enough is enough. The last pull was already big.
> >
> > This is too big, it touches non-bcachefs stuff, and it's not even
> > remotely some kind of regression.
> >
> > At some point "fix something" just turns into development, and this is
> > that point.
> >
> > Nobody sane uses bcachefs and expects it to be stable, so every single
> > user is an experimental site.
>
> Eh?
>
> Universal consensus has been that bcachefs is _definitely_ more
> trustworthy than brtfs,

I'll believe that when there are major distros that use it and you
have lots of varied use.

But it doesn't even change the issue: you aren't fixing a regression,
you are doing new development to fix some old probl;em, and now you
are literally editing non-bcachefs files too.

Enough is enough.

                   Linus

