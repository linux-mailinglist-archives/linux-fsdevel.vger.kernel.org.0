Return-Path: <linux-fsdevel+bounces-61781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0B7B59DB1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 18:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 246177B6C5D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 16:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70F62F260D;
	Tue, 16 Sep 2025 16:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CQwXsDXk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8410D2F25F7
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 16:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758040286; cv=none; b=LyXZ4ABHSu6r0+cw6QJWIHAW3Sfa6i49zvea8keDM3GpYQPyYZ5wV1Afh2EBbnlscFk0ruXj27YNgIvksiP/Cs04TKy+j5HyEnPt2UggyCpx7XXcPTKh0vPJ4hMtQU2NFzhyJpcAEr+f2NXjl/Nie4Xoev44JGzUmHxN+74GTns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758040286; c=relaxed/simple;
	bh=dAyZBLZ3deSFmd3TqM+cMI9+qPNkumh+pm2PAUP11RE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fQAmMEDy9xosow9AeAM+vs+CsCCsuxzGB7lHp24ZYH6IEC+ryQ/Xnur5mYZg7BaxVcx0oaGVzz/eMojq6kuz+gMUJ0fnBJ+emZPuaQI+/VcbPDvHOZCxQu4l4H/PdS/cSXrELKp77ILX2d5gAL2BYI1zEQBZxSB+4Nv2LwPxGAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CQwXsDXk; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-251fc032d1fso63906745ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 09:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758040284; x=1758645084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sh23vzAY4zhgyBViC+bSV8XfkSwZGUCWtaMJhyioQaQ=;
        b=CQwXsDXkXTcjWAHOESGdi8repuaQFY8GhlmqgERYtW/tNIXgyzWjkM+kYU4qJ4o89D
         e5ce062Yf+ISphAap/rWN4viVKXcgI6ZJoE5d7n5m0tiNcMBVSy/p/M6eiBBmIqtQw9u
         GYawp+HOqj/tCjRTXdUGg0q464hI8DrwdqiQNuVy4JT7DuIchFHGjpWm64ZaxVh/gr3i
         19MZ7j+d9okgaoj7jWrUuaC1BTKzz8D8Zi4Da1Q2iqgHDw6NirYq0UeFOizuwtyGRxIx
         4KG2VopkGQ6fBrNwRKT+PcyXsYmJqZBDHkTBOgd4eEyS61TOaDNJuZ4yRhsGN4ed6r/G
         twzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758040284; x=1758645084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sh23vzAY4zhgyBViC+bSV8XfkSwZGUCWtaMJhyioQaQ=;
        b=RLdP56QWt16gtsuiebCGnq6emuOGG2sniZu3xShnjmM2SeUymou0M2cmt6m8rb8y0W
         lIlqxLHEt5nc3oN7ETXAxjVneDqHoAJiVadzSVcFs32InXaSD1si3AW6xvSNoyTHOwcX
         tZiuC4NzzFEEs8VBo2T1CyJEomUmn0yby+y21GjDbzybuDmmWE2/q+5JU4p0xMBLAe60
         SlxcmbIMHG3eExwH2PUMHHtFyuiDSTLkyrOtOPEXkjlw9vUCaaQcPcFdC0BvssLvz3H/
         tCq5VzvZs+LeYd6CwcNL5ci5mxPALofrpv3yKuYvMvFKfPCOH7d+Vf7smvG7X0S+y8Pt
         BQ+w==
X-Forwarded-Encrypted: i=1; AJvYcCWPcrnMVfz9l2+53AFMAwtv59suVYSqvK9BmuQ0EwyvsGuNEwS/C+hMCyt/ZsoMjSX0AMRb/dzeOV2PfqZZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxkzFCxXwCoQ/M+cNRodVMbIP6D3GntQNBPadAgWKyst7iKq8kJ
	KHKY4u3zLvG3da44hdxoqC+YjGM3JqRJFxbticP/SkH4K0s+QwOrP15Fvum/kBIGc25kNkwewdC
	RkDPNC5am0sWvIcrBjlTA9BK9kxtS919Qg7uNswClWA==
X-Gm-Gg: ASbGncvJAQ4vaHo2HxDfSXhlP0+TQKYmIwJIm5J1SxhtepULeRH+1YYY+jntZE2wpwq
	br+TEJal5yp724YqqopeORWYY2tclJ/ifa2AdJ/hFguyTjoGFv26yN1yHQus3b7jlAier0XVgV+
	N2XCtuvU7fIe/N4HDGtPdi9DpK4sThaHqy44eTazEVgCUZrKYx6it++UMukbdkYv0r6/9qdpZUf
	+FTZQVJOtmcimX0MjeWqjauXfnWHY5Rt3SQO1bM5Fzpy6wm4HOotaYX5KqsFlEFY2BS/SI=
X-Google-Smtp-Source: AGHT+IECix1AVjlUybWwIVsJ9ka34tk4B2CLcGJk1N772RB5xGMQFqHG7lxLaX0geY/djsujO8rX54rNeXzB0pVIUu4=
X-Received: by 2002:a17:903:22c9:b0:246:4077:4563 with SMTP id
 d9443c01a7336-25d26077119mr182620025ad.34.1758040283778; Tue, 16 Sep 2025
 09:31:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYuFdesVkgGOow7+uQpw-QA6hdqBBUye8CKMxGAiwHagOA@mail.gmail.com>
 <arfepejkmgi63wepbkfhl2jjbhleh5degel7i3o7htgwjsayqg@z3pjoszloxni> <h3ov4pformuvguwsxtziqui2alarqno37kdru4bjsppeok4sth@yb4iposv7okd>
In-Reply-To: <h3ov4pformuvguwsxtziqui2alarqno37kdru4bjsppeok4sth@yb4iposv7okd>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 16 Sep 2025 22:01:11 +0530
X-Gm-Features: AS18NWAmN3EQ1CXxJUBXHQK10t01W_4u2E9Mk2iKi6ZR0XCV66DIDrPHefQHuH8
Message-ID: <CA+G9fYu7RAGNnHEJjLdH=YhEyUJ8gvcR-+JV79Z4OxO3ODTu-g@mail.gmail.com>
Subject: Re: next-20250915: LTP chdir01 df01_sh stat04 tst_device.c:97: TBROK:
 Could not stat loop device 0
To: Jan Kara <jack@suse.cz>
Cc: linux-block <linux-block@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	LTP List <ltp@lists.linux.it>, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>, 
	Christian Brauner <brauner@kernel.org>, chrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Amir Goldstein <amir73il@gmail.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Anuj Gupta <anuj20.g@samsung.com>, 
	Kanchan Joshi <joshi.k@samsung.com>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 16 Sept 2025 at 17:04, Jan Kara <jack@suse.cz> wrote:
>
> On Tue 16-09-25 13:04:42, Jan Kara wrote:
> > On Tue 16-09-25 12:57:26, Naresh Kamboju wrote:
> > > The following LTP chdir01 df01_sh and stat04 tests failed on the rock=
-pi-4b
> > > qemu-arm64 on the Linux next-20250915 tag build.
> > >
> > > First seen on next-20250915
> > > Good: next-20250912
> > > Bad: next-20250915
> > >
> > > Regression Analysis:
> > > - New regression? yes
> > > - Reproducibility? yes
> > >
> > > * rk3399-rock-pi-4b, ltp-smoke
> > > * qemu-arm64, ltp-smoke
> > > * qemu-arm64-compat, ltp-smoke
> > >  - chdir01
> > >   - df01_sh
> > >   - stat04
> > >
> > > Test regression: next-20250915: LTP chdir01 df01_sh stat04
> > > tst_device.c:97: TBROK: Could not stat loop device 0
> >
> > This is really strange. Those failing tests all start to complain that
> > /dev/loop0 doesn't exist (open gets ENOENT)... The fact that this is
> > limited to only a few archs suggests it's some race somewhere but I don=
't
> > see any relevant changes in linux-block in last three days...
>
> Ha, Mark Brown tracked this [1] to changes in VFS tree in
> extensible_ioctl_valid(). More discussion there I guess.

That right,
Ander=E2=80=99s bisection confirmed the same commit that Mark Brown reporte=
d.

# first bad commit:
 [60949057a2e71c9244e82608adf269e62e6ac443]
block: use extensible_ioctl_valid()

>
> [1] https://lore.kernel.org/all/02da33e3-6583-4344-892f-a9784b9c5b1b@sire=
na.org.uk
>
>                                                                 Honza
>
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

- Naresh

