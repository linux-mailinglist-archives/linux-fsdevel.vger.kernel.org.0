Return-Path: <linux-fsdevel+bounces-24648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BAB94246F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 04:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1A64285C51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 02:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EFFFC0A;
	Wed, 31 Jul 2024 02:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpCikfnb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC8FDF53
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2024 02:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722392048; cv=none; b=WUU/T2s7guJYtaedCgE3cdlQCvRYzl2du98tgSFqTiLxvqJ9HPELDPGxMr7kA4pGdOBIjQGww2f/nWaBMTmNNYMXs27UApNzcIf2H7rsrB/VX7POc9KTX6MJ0DOivfIoUohFAl3Ir60rV3UGTZFHAcBjhZvjGOj8Q7HPC/CukPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722392048; c=relaxed/simple;
	bh=IwHmDr/6AOvbUA5NBPurj9Jd8olUrtQOjuSdFrVmZH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DoxSfWB1bZm7UdQiZ69u8H+uBIUInSzXBf5RPfBYZfn2LonUzryTLLvEwgvPTCE1qeRFJChNv142DJOweRsSiJ84NLInjb2aL1AICB5p/jC7/Gc92OsonOVXCnXXEHhTXHuCr1dlWT0Vf/fslroy5cI8kEcZ3ZHjA9BI4WBY2Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpCikfnb; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b78c980981so27807316d6.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jul 2024 19:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722392046; x=1722996846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+7xiLySG+hz6zuGSOT84ftq1x8Sq+p4QvHPng5w10E=;
        b=KpCikfnbyRSL/HPTU/ImzUJ9BeLdza7p5JbRgd+1VYfMX3Qm1VJ7V0xV66PoiLfe2T
         quinnlrVtR4OOMZyJws0rKdFSAOUY+sXNGCQV/JYtEiTEysS7Kqm8eIxGGWyggpaXbJV
         amSQTWIHJA0/USBaIFkImeZ1H0GlaSplchPdxAZUNIkhnnse+9ERgSdVPQY592e1pH9/
         Cu+N51RMtK3kESAeOprJMkZAuzVRwD5KLi+/pFSd5GNEZwpj1eSUowHqWdqepV7f3M2Y
         q2S/PgFMQ5SWlMlov3304FhaTyZ63WnE61LcfDDy4YLKnUT+/X6B3d8V0MAWHB9t/LAZ
         eakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722392046; x=1722996846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r+7xiLySG+hz6zuGSOT84ftq1x8Sq+p4QvHPng5w10E=;
        b=xO/Qnd3j3FH8Fkmzc1gE8GjdVNNW8w9LHR365hKfXEgQL0dvk3GfEuvB87cRJ3hU5F
         p/33SG+YwP/6E1aaiFfeYeWCNZNv9YVo6QtfrHS7yWvcnrAom1YrvhnZ08qp11muQRqH
         rNkXvoW/pk5v7UU5gsYSp+n3NtLhFcQ8udI2BIIY78xql80GTxbbnYPq6eztpjlKqC+u
         DYB5pzs4SAMLSRDu8FNlHQfhS5LNnQsUERp1UnPnqmXq5lG9OWAPxkPs+GyLCS/e+11G
         3U7vtfJtw8/4EMT24QjGoT/CTsZWwDacVFHTh84rUlUMCRDePcr3ejYJ6kX6b896q1wm
         ersQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV0xP6nLxXS/9NIt4d82sKvAzAxND2cJXnmznJCTOJSRs+PW7aMDhGoJysmTRKB8FswDj2fm5+w6lt2bLuwx64Gqqg0Xl1ZS66StnyNQ==
X-Gm-Message-State: AOJu0YztVKcKCN38yDDjyWLdT3UBDh4a46R1ccReDJBYLIJ5Obe4qYTX
	qMyulHgLZQX9oS7tVfQtfPowIM99ZZwehm4uDLZRnsSBzaNliRWkXfwC0RkoIXctlozl2YbdaAP
	FucJO+mkm+2rUB7C/vz3FQvwmVZg=
X-Google-Smtp-Source: AGHT+IHGX5zr/57DVl0yI7Tw4f+MtW0Wan5Czym4xLqRoQi9TTJQdcn0PJgL+YUJOTEfhBIethEKGDfSbsEyDKM9VuA=
X-Received: by 2002:a05:6214:212e:b0:6b7:a182:4130 with SMTP id
 6a1803df08f44-6bb55ac6f9bmr199597366d6.49.1722392045887; Tue, 30 Jul 2024
 19:14:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730002348.3431931-1-joannelkoong@gmail.com>
 <CALOAHbD=PY+forv4WebU06igfTdk2UpuwEpNosimWKE=Y=QmYg@mail.gmail.com> <CAJnrk1ZQReyeySuPZctDFKt=_AwRfBE8cZEjLNU3SbEuaO49+w@mail.gmail.com>
In-Reply-To: <CAJnrk1ZQReyeySuPZctDFKt=_AwRfBE8cZEjLNU3SbEuaO49+w@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 31 Jul 2024 10:13:29 +0800
Message-ID: <CALOAHbCWQOw6Hj6+zEiivRtfd4haqO+Q8KZQj2OPpsJ3M2=3AA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] fuse: add timeout option for requests
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 2:16=E2=80=AFAM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Mon, Jul 29, 2024 at 11:00=E2=80=AFPM Yafang Shao <laoar.shao@gmail.co=
m> wrote:
> >
> > On Tue, Jul 30, 2024 at 8:28=E2=80=AFAM Joanne Koong <joannelkoong@gmai=
l.com> wrote:
> > >
> > > There are situations where fuse servers can become unresponsive or ta=
ke
> > > too long to reply to a request. Currently there is no upper bound on
> > > how long a request may take, which may be frustrating to users who ge=
t
> > > stuck waiting for a request to complete.
> > >
> > > This patchset adds a timeout option for requests and two dynamically
> > > configurable fuse sysctls "default_request_timeout" and "max_request_=
timeout"
> > > for controlling/enforcing timeout behavior system-wide.
> > >
> > > Existing fuse servers will not be affected unless they explicitly opt=
 into the
> > > timeout.
> > >
> > > v1: https://lore.kernel.org/linux-fsdevel/20240717213458.1613347-1-jo=
annelkoong@gmail.com/
> > > Changes from v1:
> > > - Add timeout for background requests
> > > - Handle resend race condition
> > > - Add sysctls
> > >
> > > Joanne Koong (2):
> > >   fuse: add optional kernel-enforced timeout for requests
> > >   fuse: add default_request_timeout and max_request_timeout sysctls
> > >
> > >  Documentation/admin-guide/sysctl/fs.rst |  17 +++
> > >  fs/fuse/Makefile                        |   2 +-
> > >  fs/fuse/dev.c                           | 187 ++++++++++++++++++++++=
+-
> > >  fs/fuse/fuse_i.h                        |  30 ++++
> > >  fs/fuse/inode.c                         |  24 +++
> > >  fs/fuse/sysctl.c                        |  42 ++++++
> > >  6 files changed, 293 insertions(+), 9 deletions(-)
> > >  create mode 100644 fs/fuse/sysctl.c
> > >
> > > --
> > > 2.43.0
> > >
> >
> > Hello Joanne,
> >
> > Thanks for your update.
> >
> > I have tested your patches using my test case, which is similar to the
> > hello-fuse [0] example, with an additional change as follows:
> >
> > @@ -125,6 +125,8 @@ static int hello_read(const char *path, char *buf,
> > size_t size, off_t offset,
> >         } else
> >                 size =3D 0;
> >
> > +       // TO trigger timeout
> > +       sleep(60);
> >         return size;
> >  }
> >
> > [0] https://github.com/libfuse/libfuse/blob/master/example/hello.c
> >
> > However, it triggered a crash with the following setup:
> >
> > 1. Set FUSE timeout:
> >   sysctl -w fs.fuse.default_request_timeout=3D10
> >   sysctl -w fs.fuse.max_request_timeout =3D 20
> >
> > 2. Start FUSE daemon:
> >   ./hello /tmp/fuse
> >
> > 3. Read from FUSE:
> >   cat /tmp/fuse/hello
> >
> > 4. Kill the process within 10 seconds (to avoid the timeout being trigg=
ered).
> >    Then the crash will be triggered.
>
> Hi Yafang,
>
> Thanks for trying this out on your use case!
>
> How consistently are you able to repro this?

It triggers the crash every time.

> I tried reproing using
> your instructions above but I'm not able to get the crash.

Please note that it is the `cat /tmp/fuse/hello` process that was
killed, not the fuse daemon.
The crash seems to occur when the fuse daemon wakes up after
sleep(60). Please ensure that the fuse daemon can be woken up.

>
> From the crash logs you provided below, it looks like what's happening
> is that if the process gets killed, the timer isn't getting deleted.
> I'll look more into what happens in fuse when a process is killed and
> get back to you on this.

Thanks

--
Regards
Yafang

