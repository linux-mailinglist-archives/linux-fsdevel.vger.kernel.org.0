Return-Path: <linux-fsdevel+bounces-45370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA659A76AC4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 17:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DED6118960FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 15:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8561D215160;
	Mon, 31 Mar 2025 15:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jV/6qwf/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2156321CC71
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Mar 2025 15:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743433595; cv=none; b=cLa6mXK/tlnuP8/69mHECLXh80FE4z4iA5rrQtdhaPDioXVYRZ3sUxb9Ye1T5kEA3t9czgfiJiIrxh1d0B5o55oUigfVOuxUfVspKiqA5pkMULFibtyNR9ygQ7PSsS+f40FQdfmMflhugf1vvKSLUcX7kDbG+qFMgWOHp8eABvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743433595; c=relaxed/simple;
	bh=cI2p9AZ8jDEpQRz512+u/IndJ5Sua1F5xjQhUnpghj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b/7/AM/wRfaxgpxkDnfA8bS+GgamZyCuWb/roVDOg7158+8LxEkaW0q3PlbnUbrwn+ynp3C1/snDnU2aOlZ2bTGFi71MH+SWYHrg0jpFMzOekmMgIxgDU+tFvCmB9//w3MUQkUnHUV4rApV3vfImRDafIe4fSvZ8Uroe5FcXNYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jV/6qwf/; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac2bdea5a38so754909766b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Mar 2025 08:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743433591; x=1744038391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7X4Gb59B5aiHKB2Rjos7GpRbKABTIzfmNTJ1Ry+xOE=;
        b=jV/6qwf/ga6XpX4NTpKzt+iohLhb5V0ZUAwhKE7rklI4hcNeNQ7bD5lkwNQCB/zGzh
         2LEbd2oF51OqbQfCqxrun0LyDuZ0UocqWe8W/ip4KD2TNnU/d3QIV4G6lIjFYK1CsZb+
         wJgpl+j5pZvjFQAXJlI8sqEoDy89n635gx6fvkFZ8N1oXysmpeExuD+KmL8PmtfHz/Fp
         7nQUMP7t6HbgZcnPeZ6s2JYCA3b9Rp+B8TzHTCNL/FDWgfgHZw/slEzLyykcgYjRtypO
         57CE9sQZ58TcJj8/JgG9n287drsONTN4HWg68UpuDpqk8OZOB54ef/zJVR1BlS/+82gV
         7MtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743433591; x=1744038391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7X4Gb59B5aiHKB2Rjos7GpRbKABTIzfmNTJ1Ry+xOE=;
        b=jjz6hDPPttzMV8Eyj1OjXfgnzSLO3U8X/sK8gojFL07odzh0/RXxANzFdGmDC7Lzh+
         DdBKP0PHYGK3+P2CD79HNWJs+R+3W/4qyrkgWgbqvXIQknWoxI1y9ZbdxM0Y4xDKpbMf
         YMfeQ6QDSUIodDNhEJc/hvWbwOsJcBwGS7f7XYuVhb07mnNTeyGYhP443//jeuBCIBaE
         pF5HfRZOue3BmRSonrumT/6D7We+vhs28f5V4VXvNSa6J7WtxfLodPm5AhwtWWCNES4B
         kjIBYuq3duf0bao2fLuU4FsOQrML41TPJcJQCOuKSAMboFQRImANlnmcrWqFi3F8no8l
         WXUA==
X-Forwarded-Encrypted: i=1; AJvYcCXb0dvsZaZGfQqdznAggGU83zpkgpF2qsrUoCGJf4EF9GoEJSFDMYXMqBHsv1Cpo0oI+t2ZlWtyHCcAPDHd@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7D4VZksK1+Ox0XY0XVebpsK2rshe9XDc4p4d1svY3jwZAcuG9
	slzgUfZ2IreZZzNst4kIxcGyurEKNQRRT9aBGwG4cDu342o0Ck54Kj4PdTVR30TQPA2tnF2T4aX
	U7tYeRpf8jO5e2eAQnIcIIH9AphbDtQ8Y
X-Gm-Gg: ASbGncvuw6vX6xcNKAuuqtE9yQTPHCXZdI4e+3QXZJtNPaCJyDqPxasnwuXLNwi8bIW
	6eUGxcvquxiZeB0dvsXNtYjahrM3b2IXUBEuSlxaguWDWQrNvVOIDGaq3uh6pkobCmD6MYq+K3j
	7i+71t+TDyC7hb7YJRfcB9tk4Mobn72r5m7UdI
X-Google-Smtp-Source: AGHT+IGTHCfgpDdL2c7zBbwIp/1ZYJEtNBjOrq1ejpCJ7mDK61s5gN1g9qQU11dsE3Js8Kbm20VQYG7afGMqMkEuFzc=
X-Received: by 2002:a17:906:7955:b0:ac1:e00c:a566 with SMTP id
 a640c23a62f3a-ac738bbe6e9mr871169866b.45.1743433590986; Mon, 31 Mar 2025
 08:06:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250329143312.1350603-1-amir73il@gmail.com> <20250329143312.1350603-2-amir73il@gmail.com>
 <h3gmwgfcfv3zl65p2kwt364go5jzcm5asfzi5gbweyyc77emdk@twb3e246vvig>
In-Reply-To: <h3gmwgfcfv3zl65p2kwt364go5jzcm5asfzi5gbweyyc77emdk@twb3e246vvig>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 31 Mar 2025 17:06:19 +0200
X-Gm-Features: AQ5f1Jo0c7_bjlLGFmjpHvQewiCMOvE84pEND9xWr3UQy3CCMZeItl_NbiYpMyk
Message-ID: <CAOQ4uxgpwFhj-1FAU94wYyPt=3QJB=T=G7wPT43FxzX-R7cDGA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] fs: prepare for extending [gs]etfsxattrat()
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 4:43=E2=80=AFPM Andrey Albershteyn <aalbersh@redhat=
.com> wrote:
>
> On 2025-03-29 15:33:11, Amir Goldstein wrote:
> > We intend to add support for more xflags to selective filesystems and
> > We cannot rely on copy_struct_from_user() to detect this extention.
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
> > ---
> >  fs/inode.c               |  4 +++-
> >  fs/ioctl.c               | 19 +++++++++++++------
> >  include/linux/fileattr.h | 22 +++++++++++++++++++++-
> >  3 files changed, 37 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/inode.c b/fs/inode.c
> > index 3cfcb1b9865ea..6c4d08bd53052 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -3049,7 +3049,9 @@ SYSCALL_DEFINE5(setfsxattrat, int, dfd, const cha=
r __user *, filename,
> >       if (error)
> >               return error;
> >
> > -     fsxattr_to_fileattr(&fsx, &fa);
> > +     error =3D fsxattr_to_fileattr(&fsx, &fa);
> > +     if (error)
> > +             return error;
> >
> >       name =3D getname_maybe_null(filename, at_flags);
> >       if (!name) {
> > diff --git a/fs/ioctl.c b/fs/ioctl.c
> > index 840283d8c4066..b19858db4c432 100644
> > --- a/fs/ioctl.c
> > +++ b/fs/ioctl.c
> > @@ -540,8 +540,10 @@ EXPORT_SYMBOL(vfs_fileattr_get);
> >
> >  void fileattr_to_fsxattr(const struct fileattr *fa, struct fsxattr *fs=
x)
> >  {
> > +     __u32 mask =3D FS_XFALGS_MASK;
> > +
> >       memset(fsx, 0, sizeof(struct fsxattr));
> > -     fsx->fsx_xflags =3D fa->fsx_xflags;
> > +     fsx->fsx_xflags =3D fa->fsx_xflags & mask;
> >       fsx->fsx_extsize =3D fa->fsx_extsize;
> >       fsx->fsx_nextents =3D fa->fsx_nextents;
> >       fsx->fsx_projid =3D fa->fsx_projid;
> > @@ -568,13 +570,20 @@ int copy_fsxattr_to_user(const struct fileattr *f=
a, struct fsxattr __user *ufa)
> >  }
> >  EXPORT_SYMBOL(copy_fsxattr_to_user);
> >
> > -void fsxattr_to_fileattr(const struct fsxattr *fsx, struct fileattr *f=
a)
> > +int fsxattr_to_fileattr(const struct fsxattr *fsx, struct fileattr *fa=
)
> >  {
> > +     __u32 mask =3D FS_XFALGS_MASK;
> > +
> > +     if (fsx->fsx_xflags & ~mask)
> > +             return -EINVAL;
> > +
> >       fileattr_fill_xflags(fa, fsx->fsx_xflags);
> > +     fa->fsx_xflags &=3D ~FS_XFLAG_RDONLY_MASK;
> >       fa->fsx_extsize =3D fsx->fsx_extsize;
> > -     fa->fsx_nextents =3D fsx->fsx_nextents;
> >       fa->fsx_projid =3D fsx->fsx_projid;
> >       fa->fsx_cowextsize =3D fsx->fsx_cowextsize;
> > +
> > +     return 0;
> >  }
> >
> >  static int copy_fsxattr_from_user(struct fileattr *fa,
> > @@ -585,9 +594,7 @@ static int copy_fsxattr_from_user(struct fileattr *=
fa,
> >       if (copy_from_user(&xfa, ufa, sizeof(xfa)))
> >               return -EFAULT;
> >
> > -     fsxattr_to_fileattr(&xfa, fa);
> > -
> > -     return 0;
> > +     return fsxattr_to_fileattr(&xfa, fa);
> >  }
> >
> >  /*
> > diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
> > index 31888fa2edf10..f682bfc7749dd 100644
> > --- a/include/linux/fileattr.h
> > +++ b/include/linux/fileattr.h
> > @@ -14,6 +14,26 @@
> >        FS_XFLAG_NODUMP | FS_XFLAG_NOATIME | FS_XFLAG_DAX | \
> >        FS_XFLAG_PROJINHERIT)
> >
> > +/* Read-only inode flags */
>
> Maybe it's only me, but this "read-only" is a bit confusing, as
> those are not settable get-only flags and not flags of read-only
> inode
>

I am also not crazy about this name.
I am fine with GETONLY_MASK.

> > +#define FS_XFLAG_RDONLY_MASK \
> > +     (FS_XFLAG_PREALLOC | FS_XFLAG_HASATTR)
> > +
> > +/* Flags to indicate valid value of fsx_ fields */
> > +#define FS_XFLAG_VALUES_MASK \
> > +     (FS_XFLAG_EXTSIZE | FS_XFLAG_COWEXTSIZE)
> > +
> > +/* Flags for directories */
> > +#define FS_XFLAG_DIRONLY_MASK \
> > +     (FS_XFLAG_RTINHERIT | FS_XFLAG_NOSYMLINKS | FS_XFLAG_EXTSZINHERIT=
)
> > +
> > +/* Misc settable flags */
> > +#define FS_XFLAG_MISC_MASK \
> > +     (FS_XFLAG_REALTIME | FS_XFLAG_NODEFRAG | FS_XFLAG_FILESTREAM)
> > +
> > +#define FS_XFALGS_MASK \
> > +     (FS_XFLAG_COMMON | FS_XFLAG_RDONLY_MASK | FS_XFLAG_VALUES_MASK | =
\
> > +      FS_XFLAG_DIRONLY_MASK | FS_XFLAG_MISC_MASK)
> > +
>
> I like the splitting but do we want to split flags like this? I can
> imagine new flags just getting pushed into _MISK_MASK or these names
> just loosing any sense.
>

I mostly did this for my own sake of order, but I do not mind
if you decide to include this grouping or not. Up to you.
Just don't carry the typo FS_XFALGS_MASK ;)


> >  /*
> >   * Merged interface for miscellaneous file attributes.  'flags' origin=
ates from
> >   * ext* and 'fsx_flags' from xfs.  There's some overlap between the tw=
o, which
> > @@ -35,7 +55,7 @@ struct fileattr {
> >
> >  void fileattr_to_fsxattr(const struct fileattr *fa, struct fsxattr *fs=
x);
> >  int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __u=
ser *ufa);
> > -void fsxattr_to_fileattr(const struct fsxattr *fsx, struct fileattr *f=
a);
> > +int fsxattr_to_fileattr(const struct fsxattr *fsx, struct fileattr *fa=
);
> >
> >  void fileattr_fill_xflags(struct fileattr *fa, u32 xflags);
> >  void fileattr_fill_flags(struct fileattr *fa, u32 flags);
> > --
> > 2.34.1
> >
>
> Otherwise, this patch looks fine for limiting the interface for now
>
> I will include it in next iteration

Thanks!
Amir.

