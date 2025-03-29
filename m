Return-Path: <linux-fsdevel+bounces-45277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B85C4A756F1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 16:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E2521890125
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 15:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034B81ACEAC;
	Sat, 29 Mar 2025 15:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4tqMMA6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE34D1E492
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Mar 2025 15:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743261846; cv=none; b=kfNUmXDKYPGJ3WrP0Yv7iPOoqog5D6JLlFrf5tR+Aaxb9HRtyjfRlSl5gZtyCclMVaeawocRyYhiK4eOmIs3tYupAv0iWKWoSgaoFp+iTVu9XNbc2n2oyWkNJGFRzxwpPHbPtMEX2Qqyw4SddHKXmaWX7kexjNS/hv+pmHVyZHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743261846; c=relaxed/simple;
	bh=LZJi+MhSfDSFVBzs+ROpTMa+0D3zXa8r0KC9VxoYvyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u6Rkchr9zdbPE+diVFt2HNn0QOmS3aLdeatM2JIDjjNmHVGDK75ihWP+eUlpvFqjUVaedADa+/VQ87BILa/kbVS87nGL8PZiPvNw0pHOIGqJJSyT72+DtFZu8OorAtVaBt7Dwbcpy7D47lLC7KKahuZkHOPvrVYdzacig5t7OAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4tqMMA6; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e5e22e6ed2so4734600a12.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Mar 2025 08:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743261843; x=1743866643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48Lf1nv24YZLLhLgxRiFP83ATj2AZx/C5bTV58bZ2uc=;
        b=Q4tqMMA6RbO2jgWOuvNIO8UV8rcWSCCn5QqD/FtV2cdnc9hTfm9VEDXPlxZqAYvyF3
         8sB7+hlpgjolLBJY9vddMWuRT86jFvzst/VfLiAMaGsuTe7Uv6Zr7gL2a5+WhFBWziNk
         avgqFtGlluL0kTuAGRTs9T5Rm24EQ3XbWf+z5zKtw+wIl1s8zEnwQOm9DndIxXfSAQAV
         lWNLHDTeK9ynDr9LBWDdtm4ukX75YjaRfFkONrV4wu3ubM8W7jXWucrY/0tqCtwns+Zx
         SXsIjMhE1vIu3UskNA/wn3IYPLMfN7shFY/v6nOycjfIocV3UV8mRA26DlWDEViCQ3vG
         UR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743261843; x=1743866643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=48Lf1nv24YZLLhLgxRiFP83ATj2AZx/C5bTV58bZ2uc=;
        b=n2Ff10n+sMTOWHGJQ7MBM00jrThbknKOMHYLknQmVMQJqIUKQgqkwDy5H1g99Sjae7
         LCrCVzy+zjdgZGkwwce03SMl1byd21oAQz1CqvQVXL2rqtdAereU3ADjNqly63plnDln
         E21vg5SfYkglvoPM+jYbQpl38SDFpLlbs1qGz3OPQgCVa8leIGGMFg2zpFrm0jK3Gqld
         q1qtmQ7GmElUW0qSC8chngQzc2BFNyo7FEUFscsLbVxaQ4QJfeqwEifwAM+sJyF6VRhz
         sUC22lfbRNSORatl3T8kqppxBkNaegE7eo8K84wZjmF0U9vLA8y7oKI+bbMBLhwz79fx
         wylg==
X-Forwarded-Encrypted: i=1; AJvYcCX6Xq5pcmIK4kpDRL9Zs3LefflBIZStfr/DFe7em7UCPwJAEgBaeNZV63QZXwkaAdetnzxcpHmqRYg05u6T@vger.kernel.org
X-Gm-Message-State: AOJu0YxDCwLDLbCbh3UTkbyukjXIbuNea/OEzztI8SLgvR8Ox9ogBb6J
	P5fhuxP0SHa9zNkP1tGKjEMXpjhr7ZFxM7paDXSb1xndn0pmO1ld3dTlHcSTyYjVrch0bAIc+29
	EKWlL923u+2lYAxuHqUD4qcvg9Jg=
X-Gm-Gg: ASbGnctsZhc7XU2OTJ1uL8uuO/BdZKt8VpW3XF3LBTJvEgxDDSXXu1ZVSsdnug/TeFJ
	oGHzUSI0LvRsMU2L8LXPx2WsOepamlUAovcHJ7VdZs3l4jmHi7GT+z86QcpcZQSXwu9Ezs1U0KB
	5dK4n2iXa/rOegwmKEWS0jjQImZg==
X-Google-Smtp-Source: AGHT+IHNGvDammoXWOswNmfOzW+dECuYWoiHdu5T47ATIr2CTwXj5C15/w4b4KZIuwUTow7J8whKkQ6SA7p1VjCqED8=
X-Received: by 2002:a05:6402:2713:b0:5e5:437b:74a7 with SMTP id
 4fb4d7f45d1cf-5edfceacec3mr2392377a12.8.1743261842580; Sat, 29 Mar 2025
 08:24:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250329143312.1350603-1-amir73il@gmail.com> <20250329143312.1350603-3-amir73il@gmail.com>
 <CAOQ4uxhf6WPN-MCFy125Ot6fCGM4vTyh25zYC2+4srtOBA_HUg@mail.gmail.com> <20250329144419.sgrp5wet5uwmtul3@pali>
In-Reply-To: <20250329144419.sgrp5wet5uwmtul3@pali>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 29 Mar 2025 16:23:51 +0100
X-Gm-Features: AQ5f1Jr0EeVJGx3Q8EokoCbJ2rzimarSm2Rmn-lpncTkWQMaXP0R0wy2r-iMqik
Message-ID: <CAOQ4uxitAkUOng4KUWrQ2_Uc6XJn=yjdo3_AN__Y9kaRVWbvig@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] fs: add support for custom fsx_xflags_mask
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 29, 2025 at 3:44=E2=80=AFPM Pali Roh=C3=A1r <pali@kernel.org> w=
rote:
>
> On Saturday 29 March 2025 15:43:06 Amir Goldstein wrote:
> > On Sat, Mar 29, 2025 at 3:33=E2=80=AFPM Amir Goldstein <amir73il@gmail.=
com> wrote:
> > >
> > > With getfsxattrat() syscall, filesystem may use this field to report
> > > its supported xflags.  Zero mask value means that supported flags are
> > > not advertized.
> > >
> > > With setfsxattrat() syscall, userspace may use this field to declare
> > > which xflags and fields are being set.  Zero mask value means that
> > > all known xflags and fields are being set.
> > >
> > > Programs that call getfsxattrat() to fill struct fsxattr before calli=
ng
> > > setfsxattrat() will not be affected by this change, but it allows
> > > programs that call setfsxattrat() without calling getfsxattrat() to m=
ake
> > > changes to some xflags and fields without knowing or changing the val=
ues
> > > of unrelated xflags and fields.
> > >
> > > Link: https://lore.kernel.org/linux-fsdevel/20250216164029.20673-4-pa=
li@kernel.org/
> > > Cc: Pali Roh=C3=A1r <pali@kernel.org>
> > > Cc: Andrey Albershteyn <aalbersh@redhat.com>
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >  fs/ioctl.c               | 35 +++++++++++++++++++++++++++++------
> > >  include/linux/fileattr.h |  1 +
> > >  include/uapi/linux/fs.h  |  3 ++-
> > >  3 files changed, 32 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/fs/ioctl.c b/fs/ioctl.c
> > > index b19858db4c432..a4838b3e7de90 100644
> > > --- a/fs/ioctl.c
> > > +++ b/fs/ioctl.c
> > > @@ -540,10 +540,13 @@ EXPORT_SYMBOL(vfs_fileattr_get);
> > >
> > >  void fileattr_to_fsxattr(const struct fileattr *fa, struct fsxattr *=
fsx)
> > >  {
> > > -       __u32 mask =3D FS_XFALGS_MASK;
> > > +       /* Filesystem may or may not advertize supported xflags */
> > > +       __u32 fs_mask =3D fa->fsx_xflags_mask & FS_XFALGS_MASK;
> > > +       __u32 mask =3D fs_mask ?: FS_XFALGS_MASK;
> > >
> > >         memset(fsx, 0, sizeof(struct fsxattr));
> > >         fsx->fsx_xflags =3D fa->fsx_xflags & mask;
> > > +       fsx->fsx_xflags_mask =3D fs_mask;
> > >         fsx->fsx_extsize =3D fa->fsx_extsize;
> > >         fsx->fsx_nextents =3D fa->fsx_nextents;
> > >         fsx->fsx_projid =3D fa->fsx_projid;
> > > @@ -562,6 +565,8 @@ int copy_fsxattr_to_user(const struct fileattr *f=
a, struct fsxattr __user *ufa)
> > >         struct fsxattr xfa;
> > >
> > >         fileattr_to_fsxattr(fa, &xfa);
> > > +       /* FS_IOC_FSGETXATTR ioctl does not report supported fsx_xfla=
gs_mask */
> > > +       xfa.fsx_xflags_mask =3D 0;
> > >
> > >         if (copy_to_user(ufa, &xfa, sizeof(xfa)))
> > >                 return -EFAULT;
> > > @@ -572,16 +577,30 @@ EXPORT_SYMBOL(copy_fsxattr_to_user);
> > >
> > >  int fsxattr_to_fileattr(const struct fsxattr *fsx, struct fileattr *=
fa)
> > >  {
> > > -       __u32 mask =3D FS_XFALGS_MASK;
> > > +       /* User may or may not provide custom xflags mask */
> > > +       __u32 mask =3D fsx->fsx_xflags_mask ?: FS_XFALGS_MASK;
> > >
> > > -       if (fsx->fsx_xflags & ~mask)
> > > +       if ((fsx->fsx_xflags & ~mask) || (mask & ~FS_XFALGS_MASK))
> > >                 return -EINVAL;
> > >
> > >         fileattr_fill_xflags(fa, fsx->fsx_xflags);
> > >         fa->fsx_xflags &=3D ~FS_XFLAG_RDONLY_MASK;
> > > -       fa->fsx_extsize =3D fsx->fsx_extsize;
> > > -       fa->fsx_projid =3D fsx->fsx_projid;
> > > -       fa->fsx_cowextsize =3D fsx->fsx_cowextsize;
> > > +       fa->fsx_xflags_mask =3D fsx->fsx_xflags_mask;
> > > +       /*
> > > +        * If flags mask is specified, we copy the fields value only =
if the
> > > +        * relevant flag is set in the mask.
> > > +        */
> > > +       if (!mask || (mask & (FS_XFLAG_EXTSIZE | FS_XFLAG_EXTSZINHERI=
T)))
> > > +               fa->fsx_extsize =3D fsx->fsx_extsize;
> > > +       if (!mask || (mask & FS_XFLAG_COWEXTSIZE))
> > > +               fa->fsx_cowextsize =3D fsx->fsx_cowextsize;
> > > +       /*
> > > +        * To save a mask flag (i.e. FS_XFLAG_PROJID), require settin=
g values
> > > +        * of fsx_projid and FS_XFLAG_PROJINHERIT flag values togethe=
r.
> > > +        * For a non-directory, FS_XFLAG_PROJINHERIT flag value shoul=
d be 0.
> > > +        */
> > > +       if (!mask || (mask & FS_XFLAG_PROJINHERIT))
> > > +               fa->fsx_projid =3D fsx->fsx_projid;
> >
> > Sorry, I ended up initializing the mask without a user provided mask
> > to FS_XFALGS_MASK, so these (!mask ||) conditions are not needed.
> >
> > Thanks,
> > Amir.
>
> And there is a typo: FS_XFLAGS_MASK

Oops.
Fixed typo and braino and pushed to
https://github.com/amir73il/linux/commits/fsxattr

Thanks,
Amir.

