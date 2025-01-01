Return-Path: <linux-fsdevel+bounces-38312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6965D9FF3BE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jan 2025 11:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A3253A2840
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jan 2025 10:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E08A1C5F32;
	Wed,  1 Jan 2025 10:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VbWcPwZi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDDD1C5F2A
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jan 2025 10:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735729124; cv=none; b=C9qODBtikmqwqOKi6uTLXy8AsroaFhPKrBU6kQZvoYjj1eGyqkBpaA2eUEkWs9eOYKS4yVOaznsyAOCh+2xVU7wcZ+u5wd/w+jp0YEMOXe7+qQzOIZtljW134WQzpWZ0Q1yWws2csY4kRLFuVnKscyqjZwzZI/GKQs+YWzQz5Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735729124; c=relaxed/simple;
	bh=fCuq/ONMjNaCfFasR2GTlo0DNJM+JuiwetjgveXIf4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dbcDxtL9ltazm4H/rCbEJjYy7Rwt8ttqyrjohRrU2OaguK5bFX6VT4vQ9TZ2aq1g4B0sIguiMEC9r8uwRQFXuNhgNAGDy4NMDWmQug3V7wiJ/9dn0hHzsB5PNFA8PYh94AGkqr/GQjbwm2SXRBWsou3V2vKb2iJYDTk4HpzMKMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VbWcPwZi; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4b11a110e4eso3032570137.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jan 2025 02:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735729121; x=1736333921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VlMmc5wf7chAH1JWK1f2H4ud03YjMtzt75evMb8xhCs=;
        b=VbWcPwZiYU2xun1t/kSf947Du2Ub36jzZORbbRzN+KuRNNQaXL5ra24O2hIPlis1Oz
         3A9Ssr/+9TXiHU9QL4bwMm01I638qvAvl462U9cR9eFdpveuAvDV4CJI0MWLb1M7XxiM
         EgseicG/eDA+S2y9YOFY0RrNvovPhRpoVQKeqK5vzhAL0BeTYAMmea8X6dmxIKHIeOdH
         zUt9oDWKtlqTOULI0TsJg/3Fe7PT7YbpvZ2c/YPKLap3lNiLTk8EnwvU1FXhhrslA/ab
         f9eTJJ3V5Hru1qEzyItn+0cv/VDvRcA+Db0/S70FANmxAE4GDQom8uIw+s82if6bTs7i
         ViIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735729121; x=1736333921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VlMmc5wf7chAH1JWK1f2H4ud03YjMtzt75evMb8xhCs=;
        b=vIouR5o9D4AU/0hlmP+orpKiGTxrNVGoxN4u17RszrfoFCLfCnUDj+qTISpvBXJwPT
         gILVz3C+FykmiJABu7u7vobZyA/5fnqUI43EmSpz8Sy2gujt3QUtB2JlYIAwoM+HXSeI
         mQcy/Kb4rpDDgYjFKNRPLCxE/zXw1sTO2h18TpNFRo4beNLdeC8R3vfGcaiknjP9q4XD
         NRA51AvsHFpGVyWBC+plKOS+8RbkOLmB6oj+Ef0R8COo035W3BccD8C8rVUykLaWeDAz
         8eKJUnomhMYih+SEWQ8eUfJtqozd0Bt9YMLZlmtw6vUK97B+gzWKnIDVfxMrbjk3T7gI
         wSyA==
X-Forwarded-Encrypted: i=1; AJvYcCVnQd7k9y7ITrSmhOphpSmQihpUFYiDMh8zCkWin8iISxRPKyo1WXTeijP3TpA4zRaZ1Y6ZfEkxy0Frbc2S@vger.kernel.org
X-Gm-Message-State: AOJu0YxxjYayrszAT4yXPQpdkyk5Xgyy62EIkNG4tgVFdNz1ik74XPiC
	DLdCDjDMEoEN2p8Lj/NA/lnErqJ0exP61DENelopfU72uYM9KN7gozDuvXPj8rwCFJtUnhsia4m
	ywrm8rvyz9xuEEZh7lSA/zrU2kJMBsM6/kEag
X-Gm-Gg: ASbGncvJnJ0BEzjl2S657iTAU6oSmzk6xWNW5DMV4jk9ReeyUYHML6GxphENT1oLHZD
	B3TJLmQ0XpoIdImi3jGkfJCYjmTtknOZuVc2j4GWTxZGo7D3f4DAuK7ba4gZw1N25oig6H5A=
X-Google-Smtp-Source: AGHT+IEPukGXqQ439i1BwZcOH5ZvJyZWuw0tpLzJeKjFZMZ1evAb6RhxUb92HdvKFtsm3kUTCAcEI2vHgh/+/h+M4Ic=
X-Received: by 2002:a05:6102:6e88:b0:4b2:ad50:a99c with SMTP id
 ada2fe7eead31-4b2fc2d6005mr17739023137.2.1735729120887; Wed, 01 Jan 2025
 02:58:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEW=TRr7CYb4LtsvQPLj-zx5Y+EYBmGfM24SuzwyDoGVNoKm7w@mail.gmail.com>
 <3d7e9844-6f6e-493a-a93a-4d2407378395@bsbernd.com> <CAEW=TRriHeY3TG-tep29ZnkRjU8Nfr5SHmuUmoc0oWRRy8fq3A@mail.gmail.com>
 <CAOQ4uxhch3DUj3BtYBaZx6X3Jvpw4OqjcdnkXA_qQh2AQwAo1A@mail.gmail.com> <CAOQ4uxjM1pkA+w8XF_cJBC-q5n0_9G1g-JYm7dOt2uSRLX8m4w@mail.gmail.com>
In-Reply-To: <CAOQ4uxjM1pkA+w8XF_cJBC-q5n0_9G1g-JYm7dOt2uSRLX8m4w@mail.gmail.com>
From: Prince Kumar <princer@google.com>
Date: Wed, 1 Jan 2025 16:28:29 +0530
X-Gm-Features: AbW1kvY55iOfeyAKJaAGnXVPbOaFiNKJiFPqjBlQ9s9n7fWRd7WHI_oQr5c1wzg
Message-ID: <CAEW=TRqohNhOH-xbfdNMxCNSwbyQZzzTdMW1TVTKc0BcDrk2_A@mail.gmail.com>
Subject: Re: Fuse: directory cache eviction stopped working in the linux 6.9.X
 and onwards
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bernd@bsbernd.com>, linux-fsdevel@vger.kernel.org, 
	Charith Chowdary <charithc@google.com>, Mayuresh Pise <mpise@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks a lot Amir, for making time for this despite the holiday season!!

Great to know, we have a fix for this.

Prince, if you can, please provide Tested-by.
> I would love to validate the changes. Although I haven't built or validat=
ed the kernel changes before, so would require some help here.

Could you please help with some basic questions?
(a) Do we need to build the complete kernel code or just fuse drivers?
(b) I see there is documentation to build the source code - but it's
too vast. Could you please point to the specific section which I need
to follow?
(c) Can we build the kernel-source code and deploy it as a docker container=
?
(d) Please provide any other information which you feel important to
test for newcomers like me.

Thanks again for the help here, Happy holidays!!

Regards,
Prince Kumar.



On Tue, Dec 31, 2024 at 9:39=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Tue, Dec 31, 2024 at 5:03=E2=80=AFPM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> >
> > On Tue, Dec 31, 2024 at 4:36=E2=80=AFAM Prince Kumar <princer@google.co=
m> wrote:
> > >
> > > Thanks Bernd for looking into this!
> > >
> > > I think 6.9 added passthrough support. Are you using that?
> > > > Not yet, but we have plans to try this out.
> > >
> > > FOPEN_CACHE_DIR is default when there is no fuse-server open method
> > > defined - does your implementation have an open/dir_open?
> > > > Yes, here is the implementation in GCSFuse (internally uses jacobsa=
/fuse library) - https://github.com/GoogleCloudPlatform/gcsfuse/blob/b0ca9c=
5b2c0a35aeb8a48fe7a36120d7b33216aa/internal/fs/fs.go#L2328
> > > Here, op.CacheDir maps to FOPEN_CACHE_DIR and op.KeepCache maps to
> > > FOPEN_KEEP_CACHE.
> > >
> > > I think the only user of FOPEN_CACHE_DIR is in fs/fuse/readdir.c and
> > > that always checks if it is set - either the flag gets set or does no=
t
> > > come into role at all, because passthrough is used?
> > > > Being honest, I don't have much idea of linux source code. As a use=
r, to me the FOPEN_CACHE_DIR flag is working as expected.
> > > The problem is with the FOPEN_KEEP_CACHE flags, setting this should
> > > evict the dir cache, but it's not happening for linux 6.9.x and above=
.
> > > Although I see  a line in fs/fuse/dir.c
> > > (https://github.com/torvalds/linux/blob/ccb98ccef0e543c2bd4ef1a722704=
61957f3d8d0/fs/fuse/dir.c#L718)
> > > which invalidates the inode pages if FOPEN_KEEP_CACHE is not set.
> > >
> > > So my ultimate question would be:
> > > (1) Do you see such recent changes in fs/fuse which explains the abov=
e
> > > regression?
> > > (2) If the changes are intentional, what should be the right way for
> > > fuse-server to evict the dir-cache (other than auto eviction due to
> > > change in dir-content, e.g., addition of new file inside a dir)?
> > >
> >
> > Hi Prince,
> >
> > The change is not international.
> > It is a regression due to commit
> > 7de64d521bf92 ("fuse: break up fuse_open_common()") that missed the fac=
t
> > the fuse_dir_open() may need to clean the page cache.
> >
> > Can you test the attached fix patch?
> > It is only compile tested.
> > Due to holidays, I had no time to verify the fix.
> >
>
> Miklos, FYI, in case you plan to send a fixes PR,
> pushed my untested patch to branch fuse-fixes in my github.
>
> Prince, if you can, please provide Tested-by.
>
> Thanks,
> Amir.

