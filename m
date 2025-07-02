Return-Path: <linux-fsdevel+bounces-53596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EC1AF0C2D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 09:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CBB04E0F25
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 07:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CB9225A38;
	Wed,  2 Jul 2025 07:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMsVscb8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90468DF42;
	Wed,  2 Jul 2025 07:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751439825; cv=none; b=jhsJ5MJQ3x+Q/Z4IgiF6o/obEJpOGLrugaNfMffHH3D6Cu6nzNBBEOpkUTfbdEaRfz8vKlJcJYPtwIBtS3dAzZFXyj9Awei+UrtvvzhyBNy/VQkorVZN6FdjB2v/bwGWIGOO2tbHdgcJtpqvxzGAEZe/TNwQdM1HuU694+DMnv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751439825; c=relaxed/simple;
	bh=V6vCs0c8yyA0t3ljD5Y3SHjSTlVe2lP5Rg5mSGLSYDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rKYellTlIRt+SJqaRugWFIMeS7Hbca9ma7FR7wJh3+PZruRM0aH7P80YqNQbezr00bAsxgV449A7zU41wijWOReIjvWKBjOIbUPazHht2JaTFh5UCgmPtMhp2cNb3t3bFYFsx69TegFCVi7eq3XftORnY+mFR81NHCbSlvfQGBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMsVscb8; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae0ccfd5ca5so572832466b.3;
        Wed, 02 Jul 2025 00:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751439822; x=1752044622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0frIadAGCzwpkQRRNha5PFzuZ3qy68wHuqlhythiwpU=;
        b=eMsVscb85RgAXMQNjadqpKttgQulmti9h106KHfljhMmtCFbsTU/z9zkhWLEmpPG5Q
         TVEtTKZj8Qt8P6a8b0Qir8yoNp5t5sb8XYff1AiqP57h2gFJ+iMQ+7LeA5waWNJnguIg
         06Y1KLlrNCGYqW9QR2wABs6O6T0H+C8gQ9PK60/rSh8xgUZhvlYFkHF7RNLR5euMTgO4
         qhiHzTgGkgoMRWyLzRHgd2RXC9bpeFq6wg7A2yOLk2frem0hEkPpoaidaCVvtNe0KpOn
         cu5MkDAT8lk4ESEcAbSnAyC06s5oudqu1zt/z3QSlhWkByUhQQoBhGfr/JFuYz9Hjl8D
         bLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751439822; x=1752044622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0frIadAGCzwpkQRRNha5PFzuZ3qy68wHuqlhythiwpU=;
        b=lMz7ovE5Ay+u/EGcFAUpI7fK+lZw1v9RQX3Q08Ub0mAvUk7jQlxTOOvM9ChOtjoBoz
         4d/AcsXGaOTKL8Ywd0hO98vwj4cI5at93s4kpWSD5fKk3qoy+eB3Y3fRM2FcIspp/1I+
         h5zBYmAwlfdmBNjuLeQogyzp78wgXfcyE+1oqNkZqAjK/QIE5WnqBp2AqgXL/5FI2Ejy
         8rJkxd/ybOl8Uc3crffSTxK/VJNGkwhp8mn0TJhXak3YMgshprVCkQ2RbTpnw/FdWiAP
         PbEUm2FFpBK1Cg9cyI6xLZb5oC8dhgo4Hs2lhDfv+7tiLqOxEVBij9KwaTmP7HK+vS2I
         Wpyg==
X-Forwarded-Encrypted: i=1; AJvYcCU+X4ZRHeE2/QPwEJCXMzhYj17cm2B3XhEV55KF8uLF/ZdfifPZR4lja+hw2JRIDMbcHJDA1xF4fdg=@vger.kernel.org, AJvYcCUv4fxdq7KPK38NkctSymFdMCI04Va/gCZXBJ3pyH2+BcG2g+DDUwGzo1SJCJRUiZWYeuCxxlUf+CvU@vger.kernel.org, AJvYcCVUeO8VuOSyvWmAqmePCxfnqC5l8f02AFmaqKpcK3GbjAnWe2ZoCozYPfLgX51lK9Hyt2PSUZyyXTPoK1ayCQ==@vger.kernel.org, AJvYcCX2BMTPqJEDQ58AwLpLrhvZoRYwoACsMbHtDYMMbCkRwRdLgj8pCdirgnOs1FB+DyxE+9wCSoMfxg==@vger.kernel.org, AJvYcCXLmcydCSg0xasHAqsW3rot9shVaUK1wdOGYqGioWgFWk9Jc/G6XpWc/h4UdftEGNN2pjWIvDpky9c4jhFR@vger.kernel.org
X-Gm-Message-State: AOJu0YxGQd6Ycwa+Q+1L52meoX+fMty0bvzeFVf1A8zS06NNGdghsER5
	Xd+ZtQ5WlFClLZYwx/JV2KfRdA6Ox+UMF1JI+mDvqtrq9i7X5PQxaddPotYmWlC4YfKVOw8WT1+
	JMGE9a+puC/V/RPhiZigUg8p9zfjaSQI=
X-Gm-Gg: ASbGncvbl/1TI6c4tjMoR3dVWF7XqUbrk6GN1VXZ+7dyA+JJHy343KlmirOD+Nz7f8r
	6HmyfbgyC2G3flum34M9h/CHxOVqGGJJk16HLl4MIOP2nA7a0sFZIPDyxAx0mEr1+IqC2zAyCgF
	kY5RFAW47jmq+frWOY2uksKiDEQifl2yBrEpxXtjlpDIQ=
X-Google-Smtp-Source: AGHT+IGMD2AU5x3an/OFXUbjEqkI5gyhDCd4v/OLCCvyRko2Nm8hqZl2hgGEc9WpyGFDasYi1aIion4MMfTDkJhJ7xs=
X-Received: by 2002:a17:907:1c16:b0:ae0:c8f9:4529 with SMTP id
 a640c23a62f3a-ae3c2df35cfmr154148966b.49.1751439821267; Wed, 02 Jul 2025
 00:03:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
 <20250630-xattrat-syscall-v6-5-c4e3bc35227b@kernel.org> <20250701183105.GP10009@frogsfrogsfrogs>
 <CAOQ4uxiCpGcZ7V8OqssP2xKsN0ZiAO7mQ_1Qt705BrcHeSPmBg@mail.gmail.com>
 <20250701194002.GS10009@frogsfrogsfrogs> <20250701195405.xf27mjknu5bnunue@pali>
In-Reply-To: <20250701195405.xf27mjknu5bnunue@pali>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 2 Jul 2025 09:03:29 +0200
X-Gm-Features: Ac12FXzpApZdbBfdtdr7BbHG_-JJ4nQlGUsVSEHxt4nNW1vlwAVqQ_bZMiyKoME
Message-ID: <CAOQ4uxjZWGz2bqen4F+fkQqZYQjKyufFVky4tOTnwng4D5G4nQ@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] fs: prepare for extending file_get/setattr()
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Andrey Albershteyn <aalbersh@redhat.com>, 
	Arnd Bergmann <arnd@arndb.de>, Casey Schaufler <casey@schaufler-ca.com>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Paul Moore <paul@paul-moore.com>, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	selinux@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 9:54=E2=80=AFPM Pali Roh=C3=A1r <pali@kernel.org> wr=
ote:
>
> On Tuesday 01 July 2025 12:40:02 Darrick J. Wong wrote:
> > On Tue, Jul 01, 2025 at 09:27:38PM +0200, Amir Goldstein wrote:
> > > On Tue, Jul 1, 2025 at 8:31=E2=80=AFPM Darrick J. Wong <djwong@kernel=
.org> wrote:
> > > >
> > > > On Mon, Jun 30, 2025 at 06:20:15PM +0200, Andrey Albershteyn wrote:
> > > > > From: Amir Goldstein <amir73il@gmail.com>
> > > > >
> > > > > We intend to add support for more xflags to selective filesystems=
 and
> > > > > We cannot rely on copy_struct_from_user() to detect this extensio=
n.
> > > > >
> > > > > In preparation of extending the API, do not allow setting xflags =
unknown
> > > > > by this kernel version.
> > > > >
> > > > > Also do not pass the read-only flags and read-only field fsx_next=
ents to
> > > > > filesystem.
> > > > >
> > > > > These changes should not affect existing chattr programs that use=
 the
> > > > > ioctl to get fsxattr before setting the new values.
> > > > >
> > > > > Link: https://lore.kernel.org/linux-fsdevel/20250216164029.20673-=
4-pali@kernel.org/
> > > > > Cc: Pali Roh=C3=A1r <pali@kernel.org>
> > > > > Cc: Andrey Albershteyn <aalbersh@redhat.com>
> > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > > > > ---
> > > > >  fs/file_attr.c           |  8 +++++++-
> > > > >  include/linux/fileattr.h | 20 ++++++++++++++++++++
> > > > >  2 files changed, 27 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/fs/file_attr.c b/fs/file_attr.c
> > > > > index 4e85fa00c092..62f08872d4ad 100644
> > > > > --- a/fs/file_attr.c
> > > > > +++ b/fs/file_attr.c
> > > > > @@ -99,9 +99,10 @@ EXPORT_SYMBOL(vfs_fileattr_get);
> > > > >  int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxat=
tr __user *ufa)
> > > > >  {
> > > > >       struct fsxattr xfa;
> > > > > +     __u32 mask =3D FS_XFLAGS_MASK;
> > > > >
> > > > >       memset(&xfa, 0, sizeof(xfa));
> > > > > -     xfa.fsx_xflags =3D fa->fsx_xflags;
> > > > > +     xfa.fsx_xflags =3D fa->fsx_xflags & mask;
> > > >
> > > > I wonder, should it be an error if a filesystem sets an fsx_xflags =
bit
> > > > outside of FS_XFLAGS_MASK?  I guess that's one way to prevent
> > > > filesystems from overriding the VFS bits. ;)
> > >
> > > I think Pali has a plan on how to ensure that later
> > > when the mask is provided via the API.
> > >
> > > >
> > > > Though couldn't that be:
> > > >
> > > >         xfa.fsx_xflags =3D fa->fsx_xflags & FS_XFLAGS_MASK;
> > > >
> > > > instead?  And same below?
> > > >
> > >
> > > Indeed. There is a reason for the var, because the next series
> > > by Pali will use a user provided mask, which defaults to FS_XFLAGS_MA=
SK,
> > > so I left it this way.
> > >
> > > I don't see a problem with it keeping as is, but if it bothers you
> > > I guess we can re-add the var later.
> >
> > Nah, it doesn't bother me that much.
> >
> > > > >       xfa.fsx_extsize =3D fa->fsx_extsize;
> > > > >       xfa.fsx_nextents =3D fa->fsx_nextents;
> > > > >       xfa.fsx_projid =3D fa->fsx_projid;
> > > > > @@ -118,11 +119,16 @@ static int copy_fsxattr_from_user(struct fi=
leattr *fa,
> > > > >                                 struct fsxattr __user *ufa)
> > > > >  {
> > > > >       struct fsxattr xfa;
> > > > > +     __u32 mask =3D FS_XFLAGS_MASK;
> > > > >
> > > > >       if (copy_from_user(&xfa, ufa, sizeof(xfa)))
> > > > >               return -EFAULT;
> > > > >
> > > > > +     if (xfa.fsx_xflags & ~mask)
> > > > > +             return -EINVAL;
> > > >
> > > > I wonder if you want EOPNOTSUPP here?  We don't know how to support
> > > > unknown xflags.  OTOH if you all have beaten this to death while I =
was
> > > > out then don't start another round just for me. :P
> > >
> > > We have beaten this API almost to death for sure ;)
> > > I don't remember if we discussed this specific aspect,
> > > but I am personally in favor of
> > > EOPNOTSUPP :=3D the fs does not support the set/get operation
> > > EINVAL :=3D some flags provided as value is invalid
> > >
> > > For example, if the get API provides you with a mask of the
> > > valid flags that you can set, if you try to set flags outside of
> > > that mask you get EINVAL.
> > >
> > > That's my interpretation, but I agree that EOPNOTSUPP can also
> > > make sense in this situation.
> >
> > <nod> I think I'd rather EOPNOTSUPP for "bits are set that the kernel
> > doesn't recognize" and EINVAL (or maybe something else like
> > EPROTONOSUPPORT) for "fs driver will not let you change this bit".
> > At least for the syscall interface; we probably have to flatten that to
> > EOPNOTSUPP for both legacy ioctls.

Given the precedents of returning EOPNOTSUPP in xfs_fileattr_set()
and ext4_ioctl_setflags() for flags that cannot be set, I agree.

>
> ... and this starting to be complicated if the "fs driver" is network
> based (as fs driver can support, but remote server not). See also:
> https://lore.kernel.org/linux-fsdevel/20241224160535.pi6nazpugqkhvfns@pal=
i/t/#u
>
> For backup/restore application it would be very useful to distinguish bet=
ween:
> - "kernel does not support flag X"
> - "target filesystem does not support flag X"
> - "wrong structure was passed / syscall incorrectly called"
>
> third option is bug in application - fatal error. second option is just
> a warning for user (sorry, we cannot set NEW FEATURE on FAT32, but if
> you would do restore to other fs, it is supported). and first option
> happens when you run new application on older kernel version, it is an
> recoverable error (or warning to user, but with more important level
> then second option as switching to different FS would not help).
>
> Could we return different errnos for these 3 situations?

That would be nice, but actually according to your plan
the get API returns the mask of flags supported by the filesystem
(on that specific object even), so userspace in fact has a way to
distinguish between the first two EOPNOTSUPP cases.

Thanks,
Amir.

