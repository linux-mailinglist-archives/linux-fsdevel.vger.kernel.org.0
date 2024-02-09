Return-Path: <linux-fsdevel+bounces-10944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C864384F512
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 13:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED12B1C21ABD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 12:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFAA31759;
	Fri,  9 Feb 2024 12:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmmW1eAg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5254689
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 12:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707480776; cv=none; b=E2LgL3fxRndcGk3oKlJJzoo7Au9H27g9Qgwcdso2kf9VnyIqi1oAg0nSWiW5qTnAdxStgK9fbLataf4BUpU89w8CaWHPwSI70Oj6D42Y06KeKx6gMHlQH91xfh5/YgPpja/OdfIA7T+2nlS4L7klpw6SxxJL611IK60f11xeRKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707480776; c=relaxed/simple;
	bh=AdZwYy03Z+RlRTB8+mojQI3HHtiCb/HCLs/tvdyQIvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aHqHH3rH9QYe7ENfiW2NpDoVAzoOqDJbZV88t57wpVL2WFx/pXjdFeD3noZYqM1ff1pTmUtoA9OSIsCn6NFBN4fwOfSijwjsw58dcGKuIRoHVDQf1eV+AV3nn3+EQ6jUwuQRgTORR/NBgBCpABTtpXLBpgzjTiLdnUFckT83rPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UmmW1eAg; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-42a9f4935a6so14818211cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 04:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707480770; x=1708085570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkWat1ZcPTFVPKXPMx1CEXUldoA1mGsayuRtblqmlJk=;
        b=UmmW1eAgOO91pnqEX0K1EEPqOZgcUX12Zlv1m8moAlxuKnGhoSQusHZtmTK+EJ1RXr
         CEjdO1DSGQ8weG3QCg8NAzhGrKUfDbU0gX6kL7h9zd9DFZFL0/NL5mWky3zUWsZACiRp
         q8pZdUZ4qlynXmbLZ7zr9Fy4d2sLYBPEb1LiIO7OEXE6SMw0hcWvZ8dzwq1zq/rt35I8
         8kckccE6ZNDzgY06O4Vm3ml6Y8KSnWKL4CxHe5yedFelaHX8tlpfJkrmpi04tc4GGO1M
         vAwMTO5BtKfww39baj22LMnZtPbrLDxkTe7PqYRVesqbOxaLHsdTBdCmxQRZS3NHeebc
         qEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707480770; x=1708085570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lkWat1ZcPTFVPKXPMx1CEXUldoA1mGsayuRtblqmlJk=;
        b=ZLradOAA4nH59CltWhufwHvyq+kNgB4y342k47WIIovzpXt+ywXJV1V+NMR3+bGEJW
         WXV8gQSj59l40qc6MHS8vzxzECIPC2XKKK/30HhPBle7C80GXciRWKFjILbuCnfHWOlL
         VoCZB7Xzv1F9HDRCfeD/5oTd3fISJ7D7sxNSqwxLrvmk4MYeJ3XHYgUMmefTu63BskcQ
         GJZJHIMmq9OosRdT0x2U0PeVza1O88fc62DnEYcf4bKyk5x1ZqYGhAfTwRFOrLJ2bOHm
         XHedDcH1k3ikMuDDzDK0EgNpHZsrkvFx6LjwBOVOr6stmpuaP+NDRBwTmP2E8l8HRlp+
         XFjg==
X-Forwarded-Encrypted: i=1; AJvYcCUtpFis30kWeUbwQaGSACWc1Eig/rmo4r7FYC005ba5CR1gmqzHMGqzPWCXF6vspLLtlQNcG46i4h7/UtsuJLGKlm3i9G00duAvLUuryA==
X-Gm-Message-State: AOJu0YyaDSkpAIkWTjNOqAPbpzXvpcZSkhYC/6In+ALDF6XN/UEt2yiD
	2Tp+hn/gUiJp+/8rHi3qMnL90wr8FenvftfA0+8Wsy/Wz5I6Uy43vLAuYR+L4JP2SUmKBNgzEF+
	ZWZe5x6ygTxxtWT73UYZmRbz5C+y14ESiBsw=
X-Google-Smtp-Source: AGHT+IGxFFCJiGiV+lPgtPbcOPBdZxC2rc/RmsKzMJFzznfYAgvnE1fa6mP/kziLRpD2rmHRlE05CkCFF6VE1E7Yt+I=
X-Received: by 2002:a05:6214:5154:b0:68c:7f05:a42f with SMTP id
 kh20-20020a056214515400b0068c7f05a42fmr902348qvb.18.1707480770200; Fri, 09
 Feb 2024 04:12:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208170603.2078871-1-amir73il@gmail.com> <20240208170603.2078871-10-amir73il@gmail.com>
 <CAJfpegtcqPgb6zwHtg7q7vfC4wgo7YPP48O213jzfF+UDqZraw@mail.gmail.com>
 <1be6f498-2d56-4c19-9f93-0678ad76e775@fastmail.fm> <f44c0101-0016-4f82-a02d-0dcfefbf4e96@fastmail.fm>
In-Reply-To: <f44c0101-0016-4f82-a02d-0dcfefbf4e96@fastmail.fm>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 9 Feb 2024 14:12:38 +0200
Message-ID: <CAOQ4uxi9X=a6mvmXXdrSYX-r5EUdVfRiGW0nwFj2ZZTzHQJ5jw@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] fuse: allow parallel dio writes with FUSE_DIRECT_IO_ALLOW_MMAP
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 1:48=E2=80=AFPM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 2/9/24 12:21, Bernd Schubert wrote:
> >
> >
> > On 2/9/24 11:50, Miklos Szeredi wrote:
> >> On Thu, 8 Feb 2024 at 18:09, Amir Goldstein <amir73il@gmail.com> wrote=
:
> >>
> >>>  static int fuse_inode_get_io_cache(struct fuse_inode *fi)
> >>>  {
> >>> +       int err =3D 0;
> >>> +
> >>>         assert_spin_locked(&fi->lock);
> >>> -       if (fi->iocachectr < 0)
> >>> -               return -ETXTBSY;
> >>> -       if (fi->iocachectr++ =3D=3D 0)
> >>> -               set_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
> >>> -       return 0;
> >>> +       /*
> >>> +        * Setting the bit advises new direct-io writes to use an exc=
lusive
> >>> +        * lock - without it the wait below might be forever.
> >>> +        */
> >>> +       set_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
> >>> +       while (!err && fuse_is_io_cache_wait(fi)) {
> >>> +               spin_unlock(&fi->lock);
> >>> +               err =3D wait_event_killable(fi->direct_io_waitq,
> >>> +                                         !fuse_is_io_cache_wait(fi))=
;
> >>> +               spin_lock(&fi->lock);
> >>> +       }
> >>> +       /*
> >>> +        * Enter caching mode or clear the FUSE_I_CACHE_IO_MODE bit i=
f we
> >>> +        * failed to enter caching mode and no other caching open exi=
sts.
> >>> +        */
> >>> +       if (!err)
> >>> +               fi->iocachectr++;
> >>> +       else if (fi->iocachectr <=3D 0)
> >>> +               clear_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
> >>
> >> This seems wrong:  if the current task is killed, and there's anther
> >> task trying to get cached open mode, then clearing
> >> FUSE_I_CACHE_IO_MODE will allow new parallel writes, breaking this
> >> logic.
> >
> > This is called holding a spin lock, another task cannot enter here?
> > Neither can direct-IO, because it is also locked out. The bit helps DIO
> > code to avoid trying to do parallel DIO without the need to take a spin
> > lock. When DIO decides it wants to do parallel IO, it first has to get
> > past fi->iocachectr < 0 - if there is another task trying to do cache
> > IO, either DIO gets < 0 first and the other cache task has to wait, or
> > cache tasks gets > 0 and dio will continue with the exclusive lock. Or
> > do I miss something?
>
> Now I see what you mean, there is an unlock and another task might have a=
lso already set the bit
>
> I think this should do
>
> diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
> index acd0833ae873..7c22edd674cb 100644
> --- a/fs/fuse/iomode.c
> +++ b/fs/fuse/iomode.c
> @@ -41,6 +41,8 @@ static int fuse_inode_get_io_cache(struct fuse_inode *f=
i)
>                 err =3D wait_event_killable(fi->direct_io_waitq,
>                                           !fuse_is_io_cache_wait(fi));
>                 spin_lock(&fi->lock);
> +               if (!err)
> +                       /* Another interrupted task might have unset it *=
/
> +                       set_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
>         }
>         /*
>          * Enter caching mode or clear the FUSE_I_CACHE_IO_MODE bit if we

I think this race can happen even if we remove killable_
not sure - anyway, with fuse passthrough there is another error
condition:

        /*
         * Check if inode entered passthrough io mode while waiting for par=
allel
         * dio write completion.
         */
        if (fuse_inode_backing(fi))
                err =3D -ETXTBSY;

But in this condition, all waiting tasks should abort the wait,
so it does not seem a problem to clean the flag.

Anyway, IMO it is better to set the flag before every wait and on
success. Like below.

Thanks,
Amir.

--- a/fs/fuse/iomode.c
+++ b/fs/fuse/iomode.c
@@ -35,8 +35,8 @@ static int fuse_inode_get_io_cache(struct fuse_inode *fi)
         * Setting the bit advises new direct-io writes to use an exclusive
         * lock - without it the wait below might be forever.
         */
-       set_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
        while (!err && fuse_is_io_cache_wait(fi)) {
+               set_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
                spin_unlock(&fi->lock);
                err =3D wait_event_killable(fi->direct_io_waitq,
                                          !fuse_is_io_cache_wait(fi));
@@ -53,8 +53,8 @@ static int fuse_inode_get_io_cache(struct fuse_inode *fi)
         * Enter caching mode or clear the FUSE_I_CACHE_IO_MODE bit if we
         * failed to enter caching mode and no other caching open exists.
         */
-       if (!err)
-               fi->iocachectr++;
+       if (!err && fi->iocachectr++ =3D=3D 0)
+               set_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
        else if (fi->iocachectr <=3D 0)
                clear_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
        return err;

