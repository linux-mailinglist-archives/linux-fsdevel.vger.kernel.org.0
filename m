Return-Path: <linux-fsdevel+bounces-53616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D896DAF1091
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 11:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4764E189001D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 09:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB0624A05B;
	Wed,  2 Jul 2025 09:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZWAMP+p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43F9248886;
	Wed,  2 Jul 2025 09:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751449735; cv=none; b=UR5lyrggaDlrP421LrmkCWxiaWdsF+EjHACu42qIW6wN/EHT1kB6PovmsdjWtI1JiEbJudTa02rrSuKYHtvvh9P3nQKJavsAxovDkKWQw4OURViipI6SkbeBEYTTCdnmH3wXnkMMk33HKSLxRYAVipIvU65Rhx2vTf2cW6/SiTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751449735; c=relaxed/simple;
	bh=8bvu6RQ9bOq4O7IorMEYHaYhu7iXNr7d73XJajJuo6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tyV0W7Dit1h3OoyrF8QF4+0VVNge3Z8qHslDcMcGKU1tH65xlVbpR0Uk6TkhzjvXEhp2g0EJn1geEU6IIgq1vmftNB7M8qfX0Tic2N2e10nL0yPQmknyRb8K8e2qO3aEqW07NJ64AlY58kjz7RJKIEOXpWm4Cybtc8XrlHCVY2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZWAMP+p; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae36e88a5daso837394066b.1;
        Wed, 02 Jul 2025 02:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751449732; x=1752054532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hybYjnvwAm+UD7pG+n18JpAuRvA2jfHhyn3nT8VWieU=;
        b=RZWAMP+pdn09WkZJWHC+rLdnmbhJ9BcCP6rro+7vAHY1rR+mwRTcpk+JTnQxuh9WCN
         wFTxn+Bt72bLjDELkFhLT4/asx5mV1rTmKJdgXyafQNnQ2eVCr0NXfkSZXzazUrQq42/
         fw9kuF+bXBeYVGd7y0VsoJVIuAf4kR0L1DXsW7NX4MrLwoTqKZLGyxEil3mw4o9CPb7K
         c2r7ojZYOhm5/wTBF/rNDA729B2A+VjOGDHHiPd5TB+qhJQeJDeYlsrS1huGpL064Tiu
         0q0FKHiMYrWfEIkqzIsO1Ph+v+GifLlvjLR3huA5/96lbVwp2/Ghkh+369ec8RPIUJEt
         xVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751449732; x=1752054532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hybYjnvwAm+UD7pG+n18JpAuRvA2jfHhyn3nT8VWieU=;
        b=McpFZj9PFcqKMQVmb24dPxgXn7wiF9F18fS/3w+m4hHRn2xlkbafWVSN13t41d4rai
         mXthYtOYpccjhg/IrM5T0Pbfzr0JtZmh10HX5dhk5RVo+0Ru+VA3P8yAmCS7072fAzRw
         UGuiWK9qoqooUU56+9vHzfaxxuldrjoufGD6PuVwzImOs8aW0dRspXbktzm5+73RNlM8
         vU9MAjs6454CJ0Pj744dDaks4IErERQj5sOw4WjG5adf4wuPkNf45D94qe4UaO+kDC1m
         X3N63e/EvjtYXmDJqAsvnKWMtHS8XD3TAPZhamixU8UcIpWl+/sXYAVRtbp0w1SF5cXQ
         j7ZA==
X-Forwarded-Encrypted: i=1; AJvYcCWGWAgXVAQXXVXfk29P8QD9YzPI/jUn5/WoDrurxRYAT6aSyWAQclrXJSfOUto9760RzfONi1iExrxk5qel@vger.kernel.org, AJvYcCWg+4ontzOtx9wo6E4SXW2Vo0M640ErrVQhZwnJEhAygnj8AwM6D/Br/06sTvRo7F+hKy4GmoZRGgo=@vger.kernel.org, AJvYcCWjU3N7SwsApTPCYwTMbkE2fS2aBHNmdM2+3htgZQ/qh/1nLA2I5zhRUSOMAj3/j8GTT51EZ177D/nRbW4zzg==@vger.kernel.org, AJvYcCXJy/6hoJnq4QSScexFbyDUoy5MFbdcldSOkXUv+7CXm7c7f52tvCJgXp9a3Jq7HkYYj7Z6T/wO7Yy8@vger.kernel.org, AJvYcCXLAgRpKFKp96WtnajaJXQUopwGX+VzgyIjEI7gAoNFxBzfUV1IDKAkTc3hzSoCcfX0zudtd2WT0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxY50VAqqBwKxhXfoyxX3CR9GQQLt3UZEFyaRMxvfStdXbR2SRQ
	qPJJkesoXKZ1LlHwC9TtAnM2yS/O+vlV2uZlD3yv74CO54m/887mUMW4o9fBHZ1h8Xsw0hH4wcr
	GoeNbyK3Jr0oKBxn6hKKSvF/YE0+P2dI=
X-Gm-Gg: ASbGnct+SngJHs4UMKAso/imSOaCqOJB3mOrN3IZY0fqQvt8/yJkbMS6/pa/icfPmhu
	Emy97ZW6nFj6S5zZZxWerUEj5dq5XgysDxgbhzADMhR4qWPqD9BDsoyAdIKflwuHBK1xAZiAET3
	1U8QfQV1ZGdXeXzUBk5sfJ4jH6uhsEyXgaEZsDiS1FEHQ=
X-Google-Smtp-Source: AGHT+IHLqiR5a8+aLQTtKNl+EMNjlPIqitVXeaPDfSISN7eMa1focgYCTjl8R2KUTfI0pf6WE2boiiwz9b4vZPegI9E=
X-Received: by 2002:a17:906:c105:b0:ae3:a799:8e81 with SMTP id
 a640c23a62f3a-ae3c2e198fcmr211718066b.39.1751449731340; Wed, 02 Jul 2025
 02:48:51 -0700 (PDT)
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
 <CAOQ4uxjZWGz2bqen4F+fkQqZYQjKyufFVky4tOTnwng4D5G4nQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxjZWGz2bqen4F+fkQqZYQjKyufFVky4tOTnwng4D5G4nQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 2 Jul 2025 11:48:39 +0200
X-Gm-Features: Ac12FXxV4u1B6-BmM0AZMJvjzMTREyX2SAzPlWjz7bFYcU7JeOVoqxtdkyrdRVE
Message-ID: <CAOQ4uxhrW--Du4XvSWficnRenv24U4hwnCQtNsH4F5d4jaPjFg@mail.gmail.com>
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

On Wed, Jul 2, 2025 at 9:03=E2=80=AFAM Amir Goldstein <amir73il@gmail.com> =
wrote:
>
> On Tue, Jul 1, 2025 at 9:54=E2=80=AFPM Pali Roh=C3=A1r <pali@kernel.org> =
wrote:
> >
> > On Tuesday 01 July 2025 12:40:02 Darrick J. Wong wrote:
> > > On Tue, Jul 01, 2025 at 09:27:38PM +0200, Amir Goldstein wrote:
> > > > On Tue, Jul 1, 2025 at 8:31=E2=80=AFPM Darrick J. Wong <djwong@kern=
el.org> wrote:
> > > > >
> > > > > On Mon, Jun 30, 2025 at 06:20:15PM +0200, Andrey Albershteyn wrot=
e:
> > > > > > From: Amir Goldstein <amir73il@gmail.com>
> > > > > >
> > > > > > We intend to add support for more xflags to selective filesyste=
ms and
> > > > > > We cannot rely on copy_struct_from_user() to detect this extens=
ion.
> > > > > >
> > > > > > In preparation of extending the API, do not allow setting xflag=
s unknown
> > > > > > by this kernel version.
> > > > > >
> > > > > > Also do not pass the read-only flags and read-only field fsx_ne=
xtents to
> > > > > > filesystem.
> > > > > >
> > > > > > These changes should not affect existing chattr programs that u=
se the
> > > > > > ioctl to get fsxattr before setting the new values.
> > > > > >
> > > > > > Link: https://lore.kernel.org/linux-fsdevel/20250216164029.2067=
3-4-pali@kernel.org/
> > > > > > Cc: Pali Roh=C3=A1r <pali@kernel.org>
> > > > > > Cc: Andrey Albershteyn <aalbersh@redhat.com>
> > > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > > > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > > > > > ---
> > > > > >  fs/file_attr.c           |  8 +++++++-
> > > > > >  include/linux/fileattr.h | 20 ++++++++++++++++++++
> > > > > >  2 files changed, 27 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/fs/file_attr.c b/fs/file_attr.c
> > > > > > index 4e85fa00c092..62f08872d4ad 100644
> > > > > > --- a/fs/file_attr.c
> > > > > > +++ b/fs/file_attr.c
> > > > > > @@ -99,9 +99,10 @@ EXPORT_SYMBOL(vfs_fileattr_get);
> > > > > >  int copy_fsxattr_to_user(const struct fileattr *fa, struct fsx=
attr __user *ufa)
> > > > > >  {
> > > > > >       struct fsxattr xfa;
> > > > > > +     __u32 mask =3D FS_XFLAGS_MASK;
> > > > > >
> > > > > >       memset(&xfa, 0, sizeof(xfa));
> > > > > > -     xfa.fsx_xflags =3D fa->fsx_xflags;
> > > > > > +     xfa.fsx_xflags =3D fa->fsx_xflags & mask;
> > > > >
> > > > > I wonder, should it be an error if a filesystem sets an fsx_xflag=
s bit
> > > > > outside of FS_XFLAGS_MASK?  I guess that's one way to prevent
> > > > > filesystems from overriding the VFS bits. ;)
> > > >
> > > > I think Pali has a plan on how to ensure that later
> > > > when the mask is provided via the API.
> > > >
> > > > >
> > > > > Though couldn't that be:
> > > > >
> > > > >         xfa.fsx_xflags =3D fa->fsx_xflags & FS_XFLAGS_MASK;
> > > > >
> > > > > instead?  And same below?
> > > > >
> > > >
> > > > Indeed. There is a reason for the var, because the next series
> > > > by Pali will use a user provided mask, which defaults to FS_XFLAGS_=
MASK,
> > > > so I left it this way.
> > > >
> > > > I don't see a problem with it keeping as is, but if it bothers you
> > > > I guess we can re-add the var later.
> > >
> > > Nah, it doesn't bother me that much.
> > >
> > > > > >       xfa.fsx_extsize =3D fa->fsx_extsize;
> > > > > >       xfa.fsx_nextents =3D fa->fsx_nextents;
> > > > > >       xfa.fsx_projid =3D fa->fsx_projid;
> > > > > > @@ -118,11 +119,16 @@ static int copy_fsxattr_from_user(struct =
fileattr *fa,
> > > > > >                                 struct fsxattr __user *ufa)
> > > > > >  {
> > > > > >       struct fsxattr xfa;
> > > > > > +     __u32 mask =3D FS_XFLAGS_MASK;
> > > > > >
> > > > > >       if (copy_from_user(&xfa, ufa, sizeof(xfa)))
> > > > > >               return -EFAULT;
> > > > > >
> > > > > > +     if (xfa.fsx_xflags & ~mask)
> > > > > > +             return -EINVAL;
> > > > >
> > > > > I wonder if you want EOPNOTSUPP here?  We don't know how to suppo=
rt
> > > > > unknown xflags.  OTOH if you all have beaten this to death while =
I was
> > > > > out then don't start another round just for me. :P
> > > >
> > > > We have beaten this API almost to death for sure ;)
> > > > I don't remember if we discussed this specific aspect,
> > > > but I am personally in favor of
> > > > EOPNOTSUPP :=3D the fs does not support the set/get operation
> > > > EINVAL :=3D some flags provided as value is invalid
> > > >
> > > > For example, if the get API provides you with a mask of the
> > > > valid flags that you can set, if you try to set flags outside of
> > > > that mask you get EINVAL.
> > > >
> > > > That's my interpretation, but I agree that EOPNOTSUPP can also
> > > > make sense in this situation.
> > >
> > > <nod> I think I'd rather EOPNOTSUPP for "bits are set that the kernel
> > > doesn't recognize" and EINVAL (or maybe something else like
> > > EPROTONOSUPPORT) for "fs driver will not let you change this bit".
> > > At least for the syscall interface; we probably have to flatten that =
to
> > > EOPNOTSUPP for both legacy ioctls.
>
> Given the precedents of returning EOPNOTSUPP in xfs_fileattr_set()
> and ext4_ioctl_setflags() for flags that cannot be set, I agree.
>

Wait, I misparsed what you wrote, so I think I "agreed" only to the
first part of your suggestion.

My claim is that unlike the xfs_has_v3inodes() check in
xfs_ioctl_setattr_xflags(),
ext4/f2fs etc return EOPNOTSUPP for various flags depending on supported fs
features (e.g. casefold,dax,encryption), so I think it will be hard to
impose a strict rule
where "fs does not support the feature" returns EINVAL in the syscalls API.

Therefore, I propose to change the code in this patch to
return EOPNOTSUPP for flags that kernel does not support
and with coming changes from Pali, it will also return the same
EOPNOTSUPP for flags that the fs instance does not support.

Christian,

Can you please amend the return value in the following chunk:

@@ -119,11 +120,16 @@ static int copy_fsxattr_from_user(struct fileattr *fa=
,
                                  struct fsxattr __user *ufa)
 {
        struct fsxattr xfa;
+       __u32 mask =3D FS_XFLAGS_MASK;

        if (copy_from_user(&xfa, ufa, sizeof(xfa)))
                return -EFAULT;

+       if (xfa.fsx_xflags & ~mask)
+               return -EOPNOTSUPP;
+

Thanks,
Amir.

