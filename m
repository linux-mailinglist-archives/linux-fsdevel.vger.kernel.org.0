Return-Path: <linux-fsdevel+bounces-16457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9301C89DF7C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 17:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D44DFB3488E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 15:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B4A13AD03;
	Tue,  9 Apr 2024 15:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="KLi1iWm8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF2E13A896
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Apr 2024 15:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712676777; cv=none; b=cZbfb3h+IinUdwNvIonygFrLE1jIwOjbzmi1RT1PZlA6tafe/V1mO4MVTq2utXofgs1pHibksHDaMqTnC3C9CMDfam5LaVvolfudFwjItdfA7xsQCpufTclPXHoScfHaIVGx2f5vb+b5aOBfaKDTK+XdXUL7Z0lmt/Z0A+f7RAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712676777; c=relaxed/simple;
	bh=pxYdE2tUTziWhsuBHLYU8SODWvRN6W4AwZMK96UqRqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p7Ou8nTQhTKWmS2k+yGK/th+8rOoOV0BAehe5Eh7VdK5MXDXzIniMtEHmkX/0oZ+CrW689NVBfMWX7vi0RaulMVRSoPvjqQcRC0x6LXXVv525DyvOeDG5aTFboQKMPqtdn/pU7QdNg7V2Kr1fRFm/+4TgZwdYluVewaR30eKGqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=KLi1iWm8; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56e6646d78bso2352335a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Apr 2024 08:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1712676773; x=1713281573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lux4fuEejmp7pHOhlDAlx7SEqQjawSZtSREoaHvQcNI=;
        b=KLi1iWm8PUPVmQ68Ymji8WYtHjvGuV5uwhzd3QVc8KI6N35sVyz6qcm24ueuAdieFh
         c+r6zAVynPQEfitb19Cm/mx/0Vx0N1Ma4AKSk5MTrKU7WU0EWp9Bt91mfnq+ExpYrs2c
         UM516AAaj/U59jKLEkSbqoic+dMRAHnihutaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712676773; x=1713281573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lux4fuEejmp7pHOhlDAlx7SEqQjawSZtSREoaHvQcNI=;
        b=r5QSuQH8+6UO62Pr6kxX+d3nsf/Vi8Jgl4W2f0Rf+jiWnorA5lh5h/OhckSEPla9jz
         IBNRxWonpGBImd5W+XKkdPJ8Svba3JISzGgCM+ffWmil0uTxP+R6bLFggBWIoJGIYQbx
         bFF99ihfmQASeaa6Mfk+HU4tQtt+l8+QRXnhZxYUiVYE82XCTQ95krmPL1Wcb/+4WSnL
         4HLnp3CzXwIJmTbpWEHVRRUBdBdbejtoH1g3hj7q3vtZImRM4Ch72zL90OwWpcRVIjvK
         0m9MUX/wT3HFADauJsy7UH0nU7QIZUC9k98mMLDbsR30AtUk1I3+kYUrx8hqLi/QMkcI
         tpvw==
X-Forwarded-Encrypted: i=1; AJvYcCVEyGEppvFBY1Xz0kmFk6VZTC8J3txXqJczORYvB7CG2dK6tR7tILZURhP+nBXWBQY0sF46xbMngQLs5usAvHek1UcswAfj1xKW6Z+Jnw==
X-Gm-Message-State: AOJu0YxHWFvUx/TT/8WEN52mo7SzuUHSBIpbYz8eIdFuNZOXR8jhEdBS
	unCdZufd5OXYuYW341BHzhta8CZvw8ytD3r6rS036dCQpVwsGmEV7ElWIpZot+QGSDK1p6qwwFL
	1FoT5nshAgNHxwNO5P7cqWJoYpzM233oqaWGgfw==
X-Google-Smtp-Source: AGHT+IGzO1opr2srAv+Xo6/m9bu2tTLKd0hOvlmgkgtp8vOWdntmv6QWNIVa2y174Eq0cssQtBvjdmJIn4hidd+6Sys=
X-Received: by 2002:a17:906:6a1a:b0:a4e:4278:8a01 with SMTP id
 qw26-20020a1709066a1a00b00a4e42788a01mr10109881ejc.11.1712676773619; Tue, 09
 Apr 2024 08:32:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407155758.575216-1-amir73il@gmail.com> <20240407155758.575216-2-amir73il@gmail.com>
 <CAJfpegs+Uc=hrE508Wkif6BbYOMTp3wjQwrbo==FkL2r6sr0Uw@mail.gmail.com> <CAOQ4uxgFBqfpU=w6qBvHCWXYzrfG6VXtxi_wMaJTtjnDAmZs3Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxgFBqfpU=w6qBvHCWXYzrfG6VXtxi_wMaJTtjnDAmZs3Q@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 9 Apr 2024 17:32:41 +0200
Message-ID: <CAJfpegtFB8k+_Bq+NB9ykewrNZ-j5vdZJ9WaBZ_P2m-_8sZ5EQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] fuse: fix wrong ff->iomode state changes from
 parallel dio write
To: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, 
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 9 Apr 2024 at 17:10, Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Tue, Apr 9, 2024 at 4:33=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
> >
> > On Sun, 7 Apr 2024 at 17:58, Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > There is a confusion with fuse_file_uncached_io_{start,end} interface=
.
> > > These helpers do two things when called from passthrough open()/relea=
se():
> > > 1. Take/drop negative refcount of fi->iocachectr (inode uncached io m=
ode)
> > > 2. State change ff->iomode IOM_NONE <-> IOM_UNCACHED (file uncached o=
pen)
> > >
> > > The calls from parallel dio write path need to take a reference on
> > > fi->iocachectr, but they should not be changing ff->iomode state,
> > > because in this case, the fi->iocachectr reference does not stick aro=
und
> > > until file release().
> >
> > Okay.
> >
> > >
> > > Factor out helpers fuse_inode_uncached_io_{start,end}, to be used fro=
m
> > > parallel dio write path and rename fuse_file_*cached_io_{start,end}
> > > helpers to fuse_file_*cached_io_{open,release} to clarify the differe=
nce.
> > >
> > > Add a check of ff->iomode in mmap(), so that fuse_file_cached_io_open=
()
> > > is called only on first mmap of direct_io file.
> >
> > Is this supposed to be an optimization?
>
> No.
> The reason I did this is because I wanted to differentiate
> the refcount semantics (start/end)
> from the state semantics (open/release)
> and to make it clearer that there is only one state change
> and refcount increment on the first mmap().
>
> > AFAICS it's wrong, because it
> > moves the check outside of any relevant locks.
> >
>
> Aren't concurrent mmap serialized on some lock?

Only on current->mm, which doesn't serialize mmaps of the same file in
different processes.

>
> Anyway, I think that the only "bug" that this can trigger is the
> WARN_ON(ff->iomode !=3D IOM_NONE)
> so if we ....
>
> >
> > > @@ -56,8 +57,7 @@ int fuse_file_cached_io_start(struct inode *inode, =
struct fuse_file *ff)
> > >                 return -ETXTBSY;
> > >         }
> > >
> > > -       WARN_ON(ff->iomode =3D=3D IOM_UNCACHED);
> > > -       if (ff->iomode =3D=3D IOM_NONE) {
> > > +       if (!WARN_ON(ff->iomode !=3D IOM_NONE)) {
> >
> > This double negation is ugly.  Just let the compiler optimize away the
> > second comparison.
>
> ...drop this change, we should be good.
>
> If you agree, do you need me to re-post?

Okay, but then what's the point of the unlocked check?

Thanks,
Miklos

