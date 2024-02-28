Return-Path: <linux-fsdevel+bounces-13070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E65686ACAD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 12:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4195E1C2259E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 11:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20F312BF1D;
	Wed, 28 Feb 2024 11:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKUcGGQB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7E412BE9D
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 11:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709118491; cv=none; b=koliGaU9OGuOG886xaPnblQ52wn7sqdObFgkKrQgcxpju6PaO5VEPUNUxO9gGvYh4VBTSChDh9RdF6DLBobunQZE2uP/mDjWR3ql5+smSyG7kEovCYA+MHEe8Y9a3x8/5pJxcyMHdblTv4SlXMZiOUK8w1/rSqqHwHWoaoeoXag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709118491; c=relaxed/simple;
	bh=K0Y2zvvmr/NaWVKAGQOhEqATXo2mlnmT3sVCtxx1/c0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SveUsZDopcAqwz27Z+4S7PsHSe+7zULOuyl4Xyue6F4UCluN4Ch46mwyPIqqY9doCaE2Go8TZd0uPIIZoTLZDDEy/S+Y4KCw/fm94rAfxIwfVF7kcDXdbpg3aM46sm5n3acOV+Af4H3YqOlX3ekqE0c1D00PR5vc8p0i7P3Ni4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKUcGGQB; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-42ea808d0f7so5027041cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 03:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709118488; x=1709723288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfQLT/52VKGUqe8FfBdbPD14C1SyOkjBQX299iyeZ9g=;
        b=PKUcGGQBY2J8z9KnF2RWK7CpEmT/iOVqQHkaa3IeBiVTiVovOL0pla3eAqWTYr6ipi
         Aw/4a6avmrjV2qaYliAyZTwRY0qu7XHnX70aNP6NmwzYc9rC+eS8GcC26Yat3pOhk9qQ
         kVFHYlxDggX2uweh3x+zxm2JpKbNZQqXT9R6lNzFVThJcCeFVzHGXvU6b3o5+sZZICLm
         ds/XLXvRk++4ctF6xOG/OAZ1u1qMlvfxcorsedJmrVlc5Hp2GIKvV44kov14MsA/ook8
         1D6d7uBuseEXDxaOQBATgMwnouU0i4vRlunpGW4qsPXPZn+RccUbvO4L+D/XH/dkTEGm
         pEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709118488; x=1709723288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dfQLT/52VKGUqe8FfBdbPD14C1SyOkjBQX299iyeZ9g=;
        b=h+k15btrMDk+PtVv0AKUPuZSDe3OdfYq1J0v3FuE7+N7CBW1BwpG1vWNJGoIPed69d
         /hS26+x1gQAr1xExD7U78RswPGJSo38l+NK/5t5s58m5ynl7CcYZlQW4PxuT9T6ROwdJ
         HhJyKUb/YpqhAAYx0T5Dn+2uiyqr3fppPP2u/xaQ+IEvN7dkDUAb4nggXr3DBWXWcGdW
         ZtH+JH25GGUZNugDCnkq/3nHEJBNDNPRGoleUcLAPhiye6nVOzDZ7JmLjrI+Dp0MjwqX
         0n/61evjroIt2a9VTjipuFbnn4xjCrb3rXwPP3D41QQStMaJ/+RUhWMbcCb9N3vRHXG7
         hqPw==
X-Forwarded-Encrypted: i=1; AJvYcCWbXqokKU2xMvTmPlhCYlRFSGCFb48vi/rIgN5i+fVPTaxPLZrj/+HkRgYgT8gbb1Trf1NNbaDVPvA2wIm9F2aBOLNNmSyo95mXfLKaMg==
X-Gm-Message-State: AOJu0YwtNeJobix1vTIPFfdiOVtFo/XXktUcrM+rCaYGR/LkRuESO9kL
	LVAmDXLkNOpy4qOuvksDjgl3ud1gpkTUz8KWrrOMhCsIwmByER09vOkAtI0jzAVa++/Mttji1Vk
	cfYY/LFAY/hgqimNff4ae5BhAetE=
X-Google-Smtp-Source: AGHT+IERhg8i5XjKFwsl5nEgb8udBjbA0HxRrQegnh8szJI9kSfMKY7ie2qIty1AUptveVACQik7botAG+tAaiPeMaI=
X-Received: by 2002:ac8:5848:0:b0:42e:80e7:5b04 with SMTP id
 h8-20020ac85848000000b0042e80e75b04mr10334097qth.36.1709118488200; Wed, 28
 Feb 2024 03:08:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206142453.1906268-1-amir73il@gmail.com> <20240206142453.1906268-4-amir73il@gmail.com>
 <450d8b2d-c1d0-4d53-b998-74495e9eca3f@linux.alibaba.com>
In-Reply-To: <450d8b2d-c1d0-4d53-b998-74495e9eca3f@linux.alibaba.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 28 Feb 2024 13:07:57 +0200
Message-ID: <CAOQ4uxhAY1m7ubJ3p-A3rSufw_53WuDRMT1Zqe_OC0bP_Fb3Zw@mail.gmail.com>
Subject: Re: [PATCH v15 3/9] fuse: implement ioctls to manage backing files
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	linux-fsdevel@vger.kernel.org, Alessio Balsini <balsini@android.com>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 12:50=E2=80=AFPM Jingbo Xu <jefflexu@linux.alibaba.=
com> wrote:
>
> Hi Amir,
>
> On 2/6/24 10:24 PM, Amir Goldstein wrote:
> > FUSE server calls the FUSE_DEV_IOC_BACKING_OPEN ioctl with a backing fi=
le
> > descriptor.  If the call succeeds, a backing file identifier is returne=
d.
> >
> > A later change will be using this backing file id in a reply to OPEN
> > request with the flag FOPEN_PASSTHROUGH to setup passthrough of file
> > operations on the open FUSE file to the backing file.
> >
> > The FUSE server should call FUSE_DEV_IOC_BACKING_CLOSE ioctl to close t=
he
> > backing file by its id.
> >
> > This can be done at any time, but if an open reply with FOPEN_PASSTHROU=
GH
> > flag is still in progress, the open may fail if the backing file is
> > closed before the fuse file was opened.
> >
> > Setting up backing files requires a server with CAP_SYS_ADMIN privilege=
s.
> > For the backing file to be successfully setup, the backing file must
> > implement both read_iter and write_iter file operations.
> >
> > The limitation on the level of filesystem stacking allowed for the
> > backing file is enforced before setting up the backing file.
> >
> > Signed-off-by: Alessio Balsini <balsini@android.com>
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
>
> [...]
>
> > +int fuse_backing_close(struct fuse_conn *fc, int backing_id)
> > +{
> > +     struct fuse_backing *fb =3D NULL;
> > +     int err;
> > +
> > +     pr_debug("%s: backing_id=3D%d\n", __func__, backing_id);
> > +
> > +     /* TODO: relax CAP_SYS_ADMIN once backing files are visible to ls=
of */
> > +     err =3D -EPERM;
> > +     if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
> > +             goto out;
>
> Sorry for the late comment as I started reading this series these days.
>
> I don't understand why CAP_SYS_ADMIN is required for the fuse server,
> though I can understand it's a security constraint.  I can only find
> that this constraint is newly added since v14, but failed to find any
> related discussion or hint.
>

This requirement is from Miklos.
The concern is that FUSE_DEV_IOC_BACKING_OPEN opens a file,
which then prevent clean unmount of fs, is not accounted in the user's rlim=
it
and is not visible in lsof, because it is not in any process file
descriptors table.
Miklos suggested that every FUSE connection will have a kernel thread
that those open fds could be associated with.
Hence the comment:
/* TODO: relax CAP_SYS_ADMIN once backing files are visible to lsof */

But since then, Christian has made some changes to the lifetime of file obj=
ects,
which require that backing_file must never be installed in files table, so =
this
solution is not as straightforward to implement.

In any case, we decided to defer this problem to the future.

> Besides, is there any chance relaxing the constraint to
> ns_capable(CAP_SYS_ADMIN), as FUSE supports FS_USERNS_MOUNT, i.e.
> support passthrough mode in user namespace?
>

I don't think so, because it will allow unprivileged user to exceed its
nested rlimits and hide open files that are invisble to lsof.

Thanks,
Amir.

