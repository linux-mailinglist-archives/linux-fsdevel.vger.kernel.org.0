Return-Path: <linux-fsdevel+bounces-45439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D89EDA77A6B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 14:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40E4B188CDD4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 12:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA67202C52;
	Tue,  1 Apr 2025 12:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOeGSze7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB761EFFB2;
	Tue,  1 Apr 2025 12:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743509570; cv=none; b=nWdRCwYQKN9LjfPCW6neJNvaAwfrtpXXMAB1Wp/AacKKqGP6yFYhfzTEhpVN1qxxF1Tgs0zgwoU33m/bAS70HemjvjJsqNE28X0oPJq43tx9oeys3Yk0uL4m1nxqsFsMYSG22CsR/2GcdBjEHnkBVCuh2FPQ8E8DPplg2M6MXsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743509570; c=relaxed/simple;
	bh=knCnkkwxfCa4lLEVbhONUxiuYykKQ35GfgIida0h9Z0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GGAkKAJTWTl1PaikRbqUU3kmsuhZpg3lXP1UYuE4XyxZFgTirAaNDaciQ3aG3hLIb5rXtYfX53qhfDi4Ww0noDK4NmvrvsSdhcWjW0hnsxdUwKpbNfaofPa3BAipd3Q9yk3X0OsIgEVJtrJgmlkjIq0ETOvxv2SKI8FUB0gDD5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOeGSze7; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac73723b2d5so604227766b.3;
        Tue, 01 Apr 2025 05:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743509567; x=1744114367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ttvd/FU9GliLSJnLsshyif2Zg4QG1YVDozGF70kbh4w=;
        b=KOeGSze7U8rF55WItYlqy004mIgyQMdABQ46Ai/COS9laYIwUfb1NOsHErOpEKCbyz
         i8h6TnKgw8XH+tdZtNZ4VVhQbds9aWoYxaI2AyqNMqTEIhRrZa5liT6g2w9wzCa04gs9
         tGDxZS4lZzZzI27PCRj3XOvJnW2xUumTn6b5eMcLAbAW6XstqaqPYXrFODiLyjWPoyZG
         ezYZrvB6cIvv3tqMxmV3JkkKp1bRlq13I66nsGfScl7XlrEuDiQ3fY3lwgNHifq/ZXi0
         NryZLJxt2XZwAiqgYQ3dLEtCNJnI+wW9TJg/K8jMNBOz8zRRYKd7UnxFSwB3ozUMz8nb
         QbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743509567; x=1744114367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ttvd/FU9GliLSJnLsshyif2Zg4QG1YVDozGF70kbh4w=;
        b=c4NR0DL3pUS8rmMPtgAw6TdBHie6Hj5sfrtjpGETj0tAY2T6R+t3o63M/gArEFCNny
         Ut8JUybFeMGka+VGOHuEnzGT3b59Yc8ohDMuBFR8EiPUmOu4X/Rjbx4UDl9OJvYH5zq9
         Du9eNDv0AKML20UBTofJVIm+3HsIMO/wTxxlIWBiZYzpCqRlZExhQLtXWXSz6P28aCoO
         baKaDfrbjWlS47cDMkyaBTXppzWQGc8cBKVU+yeoVmueBq58OooXPJ1/6S/3JZz3Ws/K
         0L57/WzF5hRgNCqhbQBfhMFEYzaxk6z+aml/EFdCh3qp8kWc/mZ1eUeFy8lOcwhlAP61
         YQGg==
X-Forwarded-Encrypted: i=1; AJvYcCUh4A+FYEFRNn/Yc3VSn6s0XusxKGaPtR0H2puRhPttoLc4D4Sw0jOMGIyPl2FwrVSOrbGBq2hehn2y3D6g@vger.kernel.org, AJvYcCXTJ3WvaVr5VAgNRpIbjpWjoas43hmAFKu+bE5w2E1XUaEL0SMOz19T/Jx1TnIzVWxzGEkGdH4xL8I1q1MJ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwt2SamktlR3SC4pM9QZd+xSHHKJxLgRpSKGtYzWs/K0TTNPXv
	gAz0YRARRAfYXyrdVzWrO7VTdcu0l80tXQ0As1uNcKoJF4Ko+V5NOkMq8I6tlyw77hF8jOqCxLQ
	Sa3ngHGoW5nyGlHqxQ4q1pBE7fM0=
X-Gm-Gg: ASbGncumolXMLnGDwGp29sv4W9Cg5Px7LAcZYlvmyS0cJ+Re/lXOCatLhsrE5RfDYsG
	TauKRJ2sN3y+wW6NlXA1pG0q/VEnfdwjD58RjQ/wBmzVqHFqJX772pgUv8Cy3WLgfQRMY4RQiSY
	0n8i26L3ZuzGUQZB7vUveLW9NX
X-Google-Smtp-Source: AGHT+IGY6gqFjHlNJ0Psb1PqUb4iCC58bx68X71kLnLB+BblrscpEbBl1WGCDY68G4o8ArXnr51fyd+Oa6UBiG+CAM0=
X-Received: by 2002:a17:907:d26:b0:ac3:bd68:24e4 with SMTP id
 a640c23a62f3a-ac738c222a0mr1036879966b.53.1743509567100; Tue, 01 Apr 2025
 05:12:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250329192821.822253-1-mjguzik@gmail.com> <20250329192821.822253-3-mjguzik@gmail.com>
 <20250401-fernhalten-lockvogel-ba56b2b108d2@brauner>
In-Reply-To: <20250401-fernhalten-lockvogel-ba56b2b108d2@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 1 Apr 2025 14:12:34 +0200
X-Gm-Features: AQ5f1JomYiaVAhBSzMDo4Ka0dgwxOzGnw63hneixUfWHSIDBOrRIQVSlNKqu1kE
Message-ID: <CAGudoHEEPYFUfSkBY93KWinOXQJeS89dMK+HKSwuzpeF8YZX_Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] fs: cache the string generated by reading /proc/filesystems
To: Christian Brauner <brauner@kernel.org>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 12:31=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Sat, Mar 29, 2025 at 08:28:21PM +0100, Mateusz Guzik wrote:
> > It is being read surprisingly often (e.g., by mkdir, ls and even sed!).
> >
> > This is lock-protected pointer chasing over a linked list to pay for
> > sprintf for every fs (32 on my boxen).
> >
> > Instead cache the result.
> >
> > While here mark the file as permanent to avoid atomic refs on each op
> > (which can also degrade to taking a spinlock).
> >
> > open+read+close cycle single-threaded (ops/s):
> > before:       450929
> > after:        982308 (+117%)
> >
> > Here the main bottleneck is memcg.
> >
> > open+read+close cycle with 20 processes (ops/s):
> > before:       578654
> > after:        3163961 (+446%)
> >
> > The main bottleneck *before* is spinlock acquire in procfs eliminated b=
y
> > marking the file as permanent. The main bottleneck *after* is the
> > spurious lockref trip on open.
> >
> > The file looks like a sterotypical C from the 90s, right down to an
> > open-code and slightly obfuscated linked list. I intentionally did not
> > clean up any of it -- I think the file will be best served by a Rust
> > rewrite when the time comes.
> >
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > ---
>
> > +     pde =3D proc_create_single("filesystems", 0, NULL, filesystems_pr=
oc_show);
> > +     proc_make_permanent(pde);
> >       return 0;
>
> This all looks good enough for me especially if it's really that much of
> a bottleneck for some workloads. But the above part is broken because
> proc_create_single() may return NULL afair and that means
> proc_make_permanent()->pde_make_permanent() will NULL-deref.
>
> I'll fix that up locally.

oh huh, indeed my bad. But in that case it should perhaps complain? WARN_ON=
?

I would argue if this fails then something really went wrong.

--=20
Mateusz Guzik <mjguzik gmail.com>

