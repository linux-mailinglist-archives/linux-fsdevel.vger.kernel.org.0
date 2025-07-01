Return-Path: <linux-fsdevel+bounces-53575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A20AF03C0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 21:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1AEF16519A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 19:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A3A281532;
	Tue,  1 Jul 2025 19:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XekQ0CZe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F99382;
	Tue,  1 Jul 2025 19:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751398074; cv=none; b=vFsRv/+pgU0/RD1rbpCl5LuwiHBwu2c5lPgPofrLSULuIZfZPAGGWP01P1gCpT/iJ7DUxzcom8Px6j6Q0LlWVf0AuaDWQfg2HMgoJDJtPuNJ2UQSyBUBlVMAvHN4HULTsjDkDhihm85lhAFjFXXVOf6qDzL/z8beWrJzQbb3CjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751398074; c=relaxed/simple;
	bh=rmP4QkIQr7280GzspZY1+OxQJ0TEo2ixRUXugBM3ums=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQj6pVSeftQ3nCIpOwo1WTDBD9v0tvz7MQvSZbGLiSPv2FtXUrRq83MJ/vO5Ttcv0kK3VzHQvehBHHUPvUl9IkUczV8xZhbEHTdxlHCk+J2I26GYctBHLBwteLiJaH5We7/NCn3mxjGxFeBoHjc1Rjv5bk+XVH25dRo97uEfdac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XekQ0CZe; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae0de0c03e9so899701166b.2;
        Tue, 01 Jul 2025 12:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751398071; x=1752002871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCnKmwN8fD9OHrDs0F2yjhsuMLHRmagugfKXbARIJLs=;
        b=XekQ0CZe0Bucb7KtFDuv8y88nGlALvOrTsXEXvlcL4I+C42+eXwkPRsUPDxzSBG4VE
         6CrL3ZzkQn8ibH5n8QTB2q/krF43rVX6HqPbaADGlj8exHg3LDHs8WMexRwljZ/MWrHl
         7bNt9M1G1Q0E4aBU5nrGm53q5io77HtkVuvD592IaPXu+4AXtKpHLKlLaaPjvqxxKvoM
         Dd0SelqtcUJ/ODDuZatTubd2jaK3wZrRxIlKWfaEXMtIjZE/NJTz12zXdHp47TQVX6P4
         7ier8xvkpacEkkTKv/6QlcIMXzrtWdz3RzyIxEQGJeWZFZzRtm634xaBtRU5Nt3XLG3b
         Ap/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751398071; x=1752002871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PCnKmwN8fD9OHrDs0F2yjhsuMLHRmagugfKXbARIJLs=;
        b=Z2XOGAAArTZfyR5GWkrXoNRMVmvvqadjPCGVn+o9JsarVwpVvp3m/NCdXLMq1VvuRA
         Y8y0xyqfoCiss4wHL/tqa82HALky09vOMaJpgjlKMZTOpBBNtg6cbVpM/mLqW7wZ+Cfs
         2iXzdfeCqHNmVmWd71dV5aCTN7Nx1bXFYdauhAGQvXEYOXABWzt4zkzegbZcl3Mjm0fP
         rz52z2PR6hPcDEq+ZVSZF71cPbYePt93kXnaoFmWBl3bRIL4TMVwsl0OdzdtUECVJ8q0
         WKx3z4459TfEGnqzQywes4ah2enmrH6fCmVd5lZ0C1XnY2ixqrpagQj6Z5Bzl8web1Fw
         S8ag==
X-Forwarded-Encrypted: i=1; AJvYcCUtvxWtxX9Lg5Mb9EuYN/XRfYW3f6o9xwU1Y7aRTJaQtb2plvMxdeHutkkMzQ5tQ9UyPaYhzGeoYvZZYno48A==@vger.kernel.org, AJvYcCV8PohwxLZc7xnPrvyTCnTHzlAQ2TJNJLSsVvOsx7/w1HbZwVtUJSQKIokX9ckg+eJCdr1IKIdP08M=@vger.kernel.org, AJvYcCWte2coNtSzTE63RRfPLeaIkLtbFoMw/hFBjDSIaEmRp28Yp9x36fYPEEJakcJWkMcI4WO/Nb8F/Mllhwb9@vger.kernel.org, AJvYcCXpME5TuJSUxB0Ic98wk7VRKjayiaFKpZM0DawgMY63I6x5sXCmhmxy1LANdaQMQqEeHdZhmRFan4DT@vger.kernel.org, AJvYcCXyWk787F+PZDv7fOQUGsmaIGRmGYiN6gSLq8NiaCGk1SJV0bnWlLIIP51NpW/orhT94sH9ClRxzA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy492uQ07B7/WBPpwZrDcbJqfSyzPYHShrQq3fEU9TaIcylYdli
	a20UCvYDYAp/Zh1mrD8P77PSmn9wq5MNFkcVLbAu9GtiHKRlpMm9BbXbZc5ZR7qvng7jsX9Q1Og
	Iy8cw/BIueSAgDdTnvQN3dKGovcp2QwI=
X-Gm-Gg: ASbGnctYVFJxr+plKaOOArXQ3ZAYu3ABcSUHr3PZoow11mR/VJL1gAMruQIU+pwKPvw
	/akZOQRaIg5EfLM65deScQcv3pdsETDqgXCd+2kbk6YcZzLOG1xyOYA2rvzQxmJ8bwvjCFdWoLj
	QLRGx59RtSn7hPXnLPrshO+gIkHbZyRBBgCypIxCROgDU=
X-Google-Smtp-Source: AGHT+IHxvrY3RQsSAM5bJ9mJ8xZdyqsVPXyP6tmLuS3bMlTr2irY5BCc98n4KdHOZxcfuFGKmbqbQ4OZ5A0E/BgJwP4=
X-Received: by 2002:a17:907:86a6:b0:ae0:dcd5:ea75 with SMTP id
 a640c23a62f3a-ae3c2b12b85mr3782466b.5.1751398070870; Tue, 01 Jul 2025
 12:27:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
 <20250630-xattrat-syscall-v6-5-c4e3bc35227b@kernel.org> <20250701183105.GP10009@frogsfrogsfrogs>
In-Reply-To: <20250701183105.GP10009@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 1 Jul 2025 21:27:38 +0200
X-Gm-Features: Ac12FXzze4b0bCyNN9Vfor-GxtAJktILQtSrwwxzdpICpJH_koiKfEAo3VjlDJg
Message-ID: <CAOQ4uxiCpGcZ7V8OqssP2xKsN0ZiAO7mQ_1Qt705BrcHeSPmBg@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] fs: prepare for extending file_get/setattr()
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	=?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, selinux@vger.kernel.org, 
	Andrey Albershteyn <aalbersh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 8:31=E2=80=AFPM Darrick J. Wong <djwong@kernel.org> =
wrote:
>
> On Mon, Jun 30, 2025 at 06:20:15PM +0200, Andrey Albershteyn wrote:
> > From: Amir Goldstein <amir73il@gmail.com>
> >
> > We intend to add support for more xflags to selective filesystems and
> > We cannot rely on copy_struct_from_user() to detect this extension.
> >
> > In preparation of extending the API, do not allow setting xflags unknow=
n
> > by this kernel version.
> >
> > Also do not pass the read-only flags and read-only field fsx_nextents t=
o
> > filesystem.
> >
> > These changes should not affect existing chattr programs that use the
> > ioctl to get fsxattr before setting the new values.
> >
> > Link: https://lore.kernel.org/linux-fsdevel/20250216164029.20673-4-pali=
@kernel.org/
> > Cc: Pali Roh=C3=A1r <pali@kernel.org>
> > Cc: Andrey Albershteyn <aalbersh@redhat.com>
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > ---
> >  fs/file_attr.c           |  8 +++++++-
> >  include/linux/fileattr.h | 20 ++++++++++++++++++++
> >  2 files changed, 27 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/file_attr.c b/fs/file_attr.c
> > index 4e85fa00c092..62f08872d4ad 100644
> > --- a/fs/file_attr.c
> > +++ b/fs/file_attr.c
> > @@ -99,9 +99,10 @@ EXPORT_SYMBOL(vfs_fileattr_get);
> >  int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __u=
ser *ufa)
> >  {
> >       struct fsxattr xfa;
> > +     __u32 mask =3D FS_XFLAGS_MASK;
> >
> >       memset(&xfa, 0, sizeof(xfa));
> > -     xfa.fsx_xflags =3D fa->fsx_xflags;
> > +     xfa.fsx_xflags =3D fa->fsx_xflags & mask;
>
> I wonder, should it be an error if a filesystem sets an fsx_xflags bit
> outside of FS_XFLAGS_MASK?  I guess that's one way to prevent
> filesystems from overriding the VFS bits. ;)

I think Pali has a plan on how to ensure that later
when the mask is provided via the API.

>
> Though couldn't that be:
>
>         xfa.fsx_xflags =3D fa->fsx_xflags & FS_XFLAGS_MASK;
>
> instead?  And same below?
>

Indeed. There is a reason for the var, because the next series
by Pali will use a user provided mask, which defaults to FS_XFLAGS_MASK,
so I left it this way.

I don't see a problem with it keeping as is, but if it bothers you
I guess we can re-add the var later.

> >       xfa.fsx_extsize =3D fa->fsx_extsize;
> >       xfa.fsx_nextents =3D fa->fsx_nextents;
> >       xfa.fsx_projid =3D fa->fsx_projid;
> > @@ -118,11 +119,16 @@ static int copy_fsxattr_from_user(struct fileattr=
 *fa,
> >                                 struct fsxattr __user *ufa)
> >  {
> >       struct fsxattr xfa;
> > +     __u32 mask =3D FS_XFLAGS_MASK;
> >
> >       if (copy_from_user(&xfa, ufa, sizeof(xfa)))
> >               return -EFAULT;
> >
> > +     if (xfa.fsx_xflags & ~mask)
> > +             return -EINVAL;
>
> I wonder if you want EOPNOTSUPP here?  We don't know how to support
> unknown xflags.  OTOH if you all have beaten this to death while I was
> out then don't start another round just for me. :P

We have beaten this API almost to death for sure ;)
I don't remember if we discussed this specific aspect,
but I am personally in favor of
EOPNOTSUPP :=3D the fs does not support the set/get operation
EINVAL :=3D some flags provided as value is invalid

For example, if the get API provides you with a mask of the
valid flags that you can set, if you try to set flags outside of
that mask you get EINVAL.

That's my interpretation, but I agree that EOPNOTSUPP can also
make sense in this situation.

Thanks,
Amir.

