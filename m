Return-Path: <linux-fsdevel+bounces-10948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB3584F51D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 13:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0252B22B43
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 12:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4FB33CFC;
	Fri,  9 Feb 2024 12:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxYsDVHZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA12328B1
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 12:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707481176; cv=none; b=noosUw4NAzfJvRMkKrIdlf1KEOQHwezMQV4o4YPUAwm3kQP2bM03TthIrd4NkUX2HkSu4hkTEZuQQ7O82CaDxy13M9kZVjI1vocaAXpT2tBDp6hBTcoE7jNTcVxKhxBt7d0dVy4adGKEWcYHGXdXzZeieJZl3wmTTqF0CrAB0lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707481176; c=relaxed/simple;
	bh=GtL7d6tLBgpZOIedoVYlQbBMYbCJeaqByqP2+8SMRMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rqJ0Y+uNsmgek4qdV6KFrAiwv5/ELCs2QHyqiW621VZMTOwGoqc1Jwp10eks/lGvWveqEETTvPAxVJ1D6Cokv9+ySrs+fm7Bof11hmmXLwgqm3CeyyTuChzM42trpI+QlWGyeyoVAoDFo+VGhsJYtH5/8Vko1iBrg71D1+QOIAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxYsDVHZ; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-68ca3ab3358so4762436d6.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 04:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707481174; x=1708085974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HpoJQWcmbo6HfOPDCeeATiPEUlYgluKILYpW3A8wgg=;
        b=AxYsDVHZU9pCZ5PVwB9i0fHse9ska8E42I7KMzTBr/dQ395v6AV+AWmXlEfwEWKDmI
         jRPi4C+cbOc4f6/aEL0r3OfThgyWTg2m/PQ16zA0RGfB8MnZC87K4WRfvbE19XtFTEUQ
         P7YAg79IyidotAw/R6eEUNpKHa3kPrcfEjlUSXyvNe6GpMJDE1HkLuGCatZxcPAzzKbZ
         15yEXyzaGHffzurXJ+wlF1L1F7p2BKG786SWxK3Lk3uHRnsF7kvTQa3Mj5BS6AS4ojvZ
         OwBZRpcLwaBHTPV9CdxWm3tos+HtYkUEB5oDHvTexLXqXXA3fW7gb4w9GnWQEDQQESWE
         okAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707481174; x=1708085974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2HpoJQWcmbo6HfOPDCeeATiPEUlYgluKILYpW3A8wgg=;
        b=W+S7aqupOj5JC8cvywYZj3mz7ZET07V/QWGTSCsQH4EhO0veMKYkp4Tcjlm/FHAVi2
         ken6hCML+S2T+3fhc79NaItY5+erfMCXq8a07G7UdutEN+mjE6U0kKzc3+6vYK2SV+Yi
         BpI98UXV+noWgzNbG1QOC+IwRJioQuOblqx+SnJuf/erMFpMOkVkdZgYgGcQWy47sW6u
         Maj4OU3DezLdyMIaDH5xWgw/NTMPbevsIW2DY3nz91NN9PE96gxKa+vcf3RbYctAq5V7
         P1RpsGBWdETYQCHZ+TE4iP+U+vh03NIf5Q8XrvSG2+MmOOu/geUseGppZCYNejWPirXV
         BWbA==
X-Forwarded-Encrypted: i=1; AJvYcCVjlLRa6QWc2tBmi3SmhJNnWPhFLZ+coTh76R6JNWrP4WATpdYEd4fB856idbqQdsc9AiVfBehXCfMwpj+1U3F1prF1y5jKTzXGEknFTw==
X-Gm-Message-State: AOJu0Yz9fHvMUB0B/vwGD2E4B9AJ6hdFM/6MZnMZOBCQU7TI8380aOJr
	JEvpe48NfMMIxuFXvb7IPGtoJx2APTcaB2bVHR5+MkqqAHsWfGhqAUYFweZUu2MyIM15gmCNWgg
	v3hwTqrbkrVEvtYj7DWTYQG68KeQ=
X-Google-Smtp-Source: AGHT+IEv1u0GEshf5l+4cmmjZVD3jw4ZTjJnTjQiWFhY//2RYL2IUkA6bsf0xvhqpjYfUWH2u7muChEkAOvztc+Uhuw=
X-Received: by 2002:a0c:d983:0:b0:68c:9ac4:59b5 with SMTP id
 y3-20020a0cd983000000b0068c9ac459b5mr1227061qvj.53.1707481173859; Fri, 09 Feb
 2024 04:19:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208170603.2078871-1-amir73il@gmail.com> <20240208170603.2078871-10-amir73il@gmail.com>
 <CAJfpegtcqPgb6zwHtg7q7vfC4wgo7YPP48O213jzfF+UDqZraw@mail.gmail.com>
 <1be6f498-2d56-4c19-9f93-0678ad76e775@fastmail.fm> <f44c0101-0016-4f82-a02d-0dcfefbf4e96@fastmail.fm>
 <CAOQ4uxi9X=a6mvmXXdrSYX-r5EUdVfRiGW0nwFj2ZZTzHQJ5jw@mail.gmail.com>
In-Reply-To: <CAOQ4uxi9X=a6mvmXXdrSYX-r5EUdVfRiGW0nwFj2ZZTzHQJ5jw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 9 Feb 2024 14:19:22 +0200
Message-ID: <CAOQ4uxgm+bz-++8sNfVNzh3s3oSB+kJ3h2TXvgcagE2TgZttUQ@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] fuse: allow parallel dio writes with FUSE_DIRECT_IO_ALLOW_MMAP
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 2:12=E2=80=AFPM Amir Goldstein <amir73il@gmail.com> =
wrote:
>
> On Fri, Feb 9, 2024 at 1:48=E2=80=AFPM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
> >
> >
> >
> > On 2/9/24 12:21, Bernd Schubert wrote:
> > >
> > >
> > > On 2/9/24 11:50, Miklos Szeredi wrote:
> > >> On Thu, 8 Feb 2024 at 18:09, Amir Goldstein <amir73il@gmail.com> wro=
te:
> > >>
> > >>>  static int fuse_inode_get_io_cache(struct fuse_inode *fi)
> > >>>  {
> > >>> +       int err =3D 0;
> > >>> +
> > >>>         assert_spin_locked(&fi->lock);
> > >>> -       if (fi->iocachectr < 0)
> > >>> -               return -ETXTBSY;
> > >>> -       if (fi->iocachectr++ =3D=3D 0)
> > >>> -               set_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
> > >>> -       return 0;
> > >>> +       /*
> > >>> +        * Setting the bit advises new direct-io writes to use an e=
xclusive
> > >>> +        * lock - without it the wait below might be forever.
> > >>> +        */
> > >>> +       set_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
> > >>> +       while (!err && fuse_is_io_cache_wait(fi)) {
> > >>> +               spin_unlock(&fi->lock);
> > >>> +               err =3D wait_event_killable(fi->direct_io_waitq,
> > >>> +                                         !fuse_is_io_cache_wait(fi=
));
> > >>> +               spin_lock(&fi->lock);
> > >>> +       }
> > >>> +       /*
> > >>> +        * Enter caching mode or clear the FUSE_I_CACHE_IO_MODE bit=
 if we
> > >>> +        * failed to enter caching mode and no other caching open e=
xists.
> > >>> +        */
> > >>> +       if (!err)
> > >>> +               fi->iocachectr++;
> > >>> +       else if (fi->iocachectr <=3D 0)
> > >>> +               clear_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
> > >>
> > >> This seems wrong:  if the current task is killed, and there's anther
> > >> task trying to get cached open mode, then clearing
> > >> FUSE_I_CACHE_IO_MODE will allow new parallel writes, breaking this
> > >> logic.
> > >
> > > This is called holding a spin lock, another task cannot enter here?
> > > Neither can direct-IO, because it is also locked out. The bit helps D=
IO
> > > code to avoid trying to do parallel DIO without the need to take a sp=
in
> > > lock. When DIO decides it wants to do parallel IO, it first has to ge=
t
> > > past fi->iocachectr < 0 - if there is another task trying to do cache
> > > IO, either DIO gets < 0 first and the other cache task has to wait, o=
r
> > > cache tasks gets > 0 and dio will continue with the exclusive lock. O=
r
> > > do I miss something?
> >
> > Now I see what you mean, there is an unlock and another task might have=
 also already set the bit
> >
> > I think this should do
> >
> > diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
> > index acd0833ae873..7c22edd674cb 100644
> > --- a/fs/fuse/iomode.c
> > +++ b/fs/fuse/iomode.c
> > @@ -41,6 +41,8 @@ static int fuse_inode_get_io_cache(struct fuse_inode =
*fi)
> >                 err =3D wait_event_killable(fi->direct_io_waitq,
> >                                           !fuse_is_io_cache_wait(fi));
> >                 spin_lock(&fi->lock);
> > +               if (!err)
> > +                       /* Another interrupted task might have unset it=
 */
> > +                       set_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
> >         }
> >         /*
> >          * Enter caching mode or clear the FUSE_I_CACHE_IO_MODE bit if =
we
>
> I think this race can happen even if we remove killable_
> not sure - anyway, with fuse passthrough there is another error
> condition:
>
>         /*
>          * Check if inode entered passthrough io mode while waiting for p=
arallel
>          * dio write completion.
>          */
>         if (fuse_inode_backing(fi))
>                 err =3D -ETXTBSY;
>
> But in this condition, all waiting tasks should abort the wait,
> so it does not seem a problem to clean the flag.
>
> Anyway, IMO it is better to set the flag before every wait and on
> success. Like below.
>
> Thanks,
> Amir.
>
> --- a/fs/fuse/iomode.c
> +++ b/fs/fuse/iomode.c
> @@ -35,8 +35,8 @@ static int fuse_inode_get_io_cache(struct fuse_inode *f=
i)
>          * Setting the bit advises new direct-io writes to use an exclusi=
ve
>          * lock - without it the wait below might be forever.
>          */
> -       set_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
>         while (!err && fuse_is_io_cache_wait(fi)) {
> +               set_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
>                 spin_unlock(&fi->lock);
>                 err =3D wait_event_killable(fi->direct_io_waitq,
>                                           !fuse_is_io_cache_wait(fi));
> @@ -53,8 +53,8 @@ static int fuse_inode_get_io_cache(struct fuse_inode *f=
i)
>          * Enter caching mode or clear the FUSE_I_CACHE_IO_MODE bit if we
>          * failed to enter caching mode and no other caching open exists.
>          */
> -       if (!err)
> -               fi->iocachectr++;
> +       if (!err && fi->iocachectr++ =3D=3D 0)
> +               set_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
>         else if (fi->iocachectr <=3D 0)
>                 clear_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
>         return err;

Oops should be:

       if (!err) {
               fi->iocachectr++;
               set_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
       } else if (fi->iocachectr <=3D 0) {
               clear_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
       }
       return err;

