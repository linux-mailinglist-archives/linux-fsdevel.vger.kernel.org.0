Return-Path: <linux-fsdevel+bounces-22107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8C5912324
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 13:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFF841C217BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 11:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60870172BC7;
	Fri, 21 Jun 2024 11:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1qVOfPD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE5812D771;
	Fri, 21 Jun 2024 11:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718968654; cv=none; b=jcfm9dILGTBL8yQJXhoC8b/oG42SxgiBBV0j1bWJsLeufR/JWMNdYgIdTPMYyQiRSoGKofJj+B6zTH7FN9xpnZCu7ODq8popaioEJUfimpGhU0unnPbsmxXZWCM8DsdLrvICCFXJmi0X1jczKFvvgGrORexrFighyq3BZHLNAko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718968654; c=relaxed/simple;
	bh=sVzc/YicQt/3Bw6kdGjiDZDnTvmjCjYj4ieJizyeyeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=st9GX68wML/SRtWfTw3b6TRMkN55Kbdm9tMdu/6vF24Bg4wiCA+GAruL3VfG0T9sXbxwNboBmJIn6e5meZjNg7AfOufBb1pTS/sM4WAIMUC95cDimPLKU6CnGLMCY0iKGtWEI0FjiRLa+ex8LUAX5cYYG/0MGhlCzFk3130r0Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1qVOfPD; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6efacd25ecso104167766b.1;
        Fri, 21 Jun 2024 04:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718968651; x=1719573451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7Y9S7C57tDOTQYtWaBtzx3CbVPOS8YYr0zKSVtRrMQ=;
        b=O1qVOfPDlmJ8eXXLZUTXATPgo2AvFqF+kG61BUkdytglILlNJrPatFb0MeEI+9kXpO
         sAODLqsXQqLecBdonN4mtPfuD0l302pLXCpf0xTc0GqJ0pW9lLUz3z70PJ0uWhFXBmU2
         j4QZMqPR0yQhg1D2g3xwzFf21/F60o/LJB5QDDcDl6tFVWA5cpFMtswWLr1A3py1PkOa
         R8sFZfDxHU2O6M5Hlw0LfuDGw2GAUEzTccrWmUHWTS6NHeb1xCiRR7ZA/+mDvOGUDlep
         clxmHCGxBKokw1LLVoSFi4CFMRQ7KcX6Eh+fA9rJgTHE/OFOE3RKlm11igakPEBRB9sI
         RBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718968651; x=1719573451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g7Y9S7C57tDOTQYtWaBtzx3CbVPOS8YYr0zKSVtRrMQ=;
        b=NrRwmtZqzZvxR4g4+F0PbsMg4GsO30XZDsZXfW+iLuaCbX4NZAaZ0KM2xoiaDJk1SQ
         v84L8jDs9UAsigVl50oGvk09Ypo6QqNPchsGKz7N1C8u1mLjGwKvq/Kv8JTdx/8ZBWd6
         VfaYsqoh07O88GxZY4IdTJja15u67HXQzMAQVWzdi8TQL+tNhtCu+APwelgXn6WAVeyC
         0FmiIafFYJW8rcshlTcGQ7aMQBYWJziH43Jl0d60b7YXwy+LEFx3I1obJBCtor9GYs4+
         +ckxGRmI7BQ6le4s0XMpQfgyG7Z9QuMCJFp1lDIXI13/MCxBox0/J9ebbaRBMRnleb4G
         yDzw==
X-Forwarded-Encrypted: i=1; AJvYcCW1OrQhCBPhPyRFtPMj/FDrS3cIwjjxja8LK6WLUJpxyyepu8fRzcWC+5rJgei0tHackIBBM72avwDuaKIEi+4RiRcTDO/7QHQhAFTu8gR2sedfaYFSzrCbEf1QIYedanfC0eOJB+nOuw2D+w==
X-Gm-Message-State: AOJu0YyI7I+SPgTTG5cpvYM01qm/7zLmuLb4zOLZ6UNRkTzw22VHDOrh
	AyWboU1eRde1L4JBQY4bqpforwfH+CzI1MoZV9mQvJsVGC+Kq34JoLpLW5D4sIW9iZVQvYYboyu
	werolF/dRDyXbrs3afzh0sKYbqM8=
X-Google-Smtp-Source: AGHT+IGVZAg20oIBvCbGXF8iXdeGiupDamoCVJcG/qovlSTHPYhqL6+kjJ32aTE5BJxHG1JdE+Baw+bQq4LcCmgRuwU=
X-Received: by 2002:a50:9fc9:0:b0:57d:3df:f881 with SMTP id
 4fb4d7f45d1cf-57d07e0d0a9mr6050621a12.3.1718968651088; Fri, 21 Jun 2024
 04:17:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620120359.151258-1-mjguzik@gmail.com> <20240621-affekt-denkzettel-3c115f68355a@brauner>
In-Reply-To: <20240621-affekt-denkzettel-3c115f68355a@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 21 Jun 2024 13:17:17 +0200
Message-ID: <CAGudoHFeNy55qOw676ohM9-9P-n_P9HNX2qL+kRT-B2SmwguSQ@mail.gmail.com>
Subject: Re: [PATCH] vfs: reorder checks in may_create_in_sticky
To: Christian Brauner <brauner@kernel.org>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 9:45=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, Jun 20, 2024 at 02:03:59PM GMT, Mateusz Guzik wrote:
> > The routine is called for all directories on file creation and weirdly
> > postpones the check if the dir is sticky to begin with. Instead it firs=
t
> > checks fifos and regular files (in that order), while avoidably pulling
> > globals.
> >
> > No functional changes.
> >
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > ---
> >  fs/namei.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 63d1fb06da6b..b1600060ecfb 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -1246,9 +1246,9 @@ static int may_create_in_sticky(struct mnt_idmap =
*idmap,
> >       umode_t dir_mode =3D nd->dir_mode;
> >       vfsuid_t dir_vfsuid =3D nd->dir_vfsuid;
> >
> > -     if ((!sysctl_protected_fifos && S_ISFIFO(inode->i_mode)) ||
> > -         (!sysctl_protected_regular && S_ISREG(inode->i_mode)) ||
> > -         likely(!(dir_mode & S_ISVTX)) ||
> > +     if (likely(!(dir_mode & S_ISVTX)) ||
> > +         (S_ISREG(inode->i_mode) && !sysctl_protected_regular) ||
> > +         (S_ISFIFO(inode->i_mode) && !sysctl_protected_fifos) ||
> >           vfsuid_eq(i_uid_into_vfsuid(idmap, inode), dir_vfsuid) ||
> >           vfsuid_eq_kuid(i_uid_into_vfsuid(idmap, inode), current_fsuid=
()))
> >               return 0;
>
> I think we really need to unroll this unoly mess to make it more readable=
?
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 3e23fbb8b029..1dd2d328bae3 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1244,25 +1244,43 @@ static int may_create_in_sticky(struct mnt_idmap =
*idmap,
>                                 struct nameidata *nd, struct inode *const=
 inode)
>  {
>         umode_t dir_mode =3D nd->dir_mode;
> -       vfsuid_t dir_vfsuid =3D nd->dir_vfsuid;
> +       vfsuid_t dir_vfsuid =3D nd->dir_vfsuid, i_vfsuid;
> +       int ret;
> +
> +       if (likely(!(dir_mode & S_ISVTX)))
> +               return 0;
> +
> +       if (S_ISREG(inode->i_mode) && !sysctl_protected_regular)
> +               return 0;
> +
> +       if (S_ISFIFO(inode->i_mode) && !sysctl_protected_fifos)
> +               return 0;
> +
> +       i_vfsuid =3D i_uid_into_vfsuid(idmap, inode);
> +
> +       if (vfsuid_eq(i_vfsuid, dir_vfsuid))
> +               return 0;
>
> -       if (likely(!(dir_mode & S_ISVTX)) ||
> -           (S_ISREG(inode->i_mode) && !sysctl_protected_regular) ||
> -           (S_ISFIFO(inode->i_mode) && !sysctl_protected_fifos) ||
> -           vfsuid_eq(i_uid_into_vfsuid(idmap, inode), dir_vfsuid) ||
> -           vfsuid_eq_kuid(i_uid_into_vfsuid(idmap, inode), current_fsuid=
()))
> +       if (vfsuid_eq_kuid(i_vfsuid, current_fsuid()))
>                 return 0;
>
> -       if (likely(dir_mode & 0002) ||
> -           (dir_mode & 0020 &&
> -            ((sysctl_protected_fifos >=3D 2 && S_ISFIFO(inode->i_mode)) =
||
> -             (sysctl_protected_regular >=3D 2 && S_ISREG(inode->i_mode))=
))) {
> -               const char *operation =3D S_ISFIFO(inode->i_mode) ?
> -                                       "sticky_create_fifo" :
> -                                       "sticky_create_regular";
> -               audit_log_path_denied(AUDIT_ANOM_CREAT, operation);
> +       if (likely(dir_mode & 0002)) {
> +               audit_log_path_denied(AUDIT_ANOM_CREAT, "sticky_create");
>                 return -EACCES;
>         }
> +
> +       if (dir_mode & 0020) {
> +               if (sysctl_protected_fifos >=3D 2 && S_ISFIFO(inode->i_mo=
de)) {
> +                       audit_log_path_denied(AUDIT_ANOM_CREAT, "sticky_c=
reate_fifo");
> +                       return -EACCES;
> +               }
> +
> +               if (sysctl_protected_regular >=3D 2 && S_ISREG(inode->i_m=
ode)) {
> +                       audit_log_path_denied(AUDIT_ANOM_CREAT, "sticky_c=
reate_regular");
> +                       return -EACCES;
> +               }
> +       }
> +
>         return 0;
>  }
>
> That gives us:
>
> static int may_create_in_sticky(struct mnt_idmap *idmap,
>                                 struct nameidata *nd, struct inode *const=
 inode)
> {
>         umode_t dir_mode =3D nd->dir_mode;
>         vfsuid_t dir_vfsuid =3D nd->dir_vfsuid, i_vfsuid;
>         int ret;
>
>         if (likely(!(dir_mode & S_ISVTX)))
>                 return 0;
>
>         if (S_ISREG(inode->i_mode) && !sysctl_protected_regular)
>                 return 0;
>
>         if (S_ISFIFO(inode->i_mode) && !sysctl_protected_fifos)
>                 return 0;
>
>         i_vfsuid =3D i_uid_into_vfsuid(idmap, inode);
>
>         if (vfsuid_eq(i_vfsuid, dir_vfsuid))
>                 return 0;
>
>         if (vfsuid_eq_kuid(i_vfsuid, current_fsuid()))
>                 return 0;
>
>         if (likely(dir_mode & 0002)) {
>                 audit_log_path_denied(AUDIT_ANOM_CREAT, "sticky_create");
>                 return -EACCES;
>         }
>
>         if (dir_mode & 0020) {
>                 if (sysctl_protected_fifos >=3D 2 && S_ISFIFO(inode->i_mo=
de)) {
>                         audit_log_path_denied(AUDIT_ANOM_CREAT, "sticky_c=
reate_fifo");
>                         return -EACCES;
>                 }
>
>                 if (sysctl_protected_regular >=3D 2 && S_ISREG(inode->i_m=
ode)) {
>                         audit_log_path_denied(AUDIT_ANOM_CREAT, "sticky_c=
reate_regular");
>                         return -EACCES;
>                 }
>         }
>
>         return 0;
> }

That does look better. :)

So as far as I'm concerned my patch can be just dropped, just in case
I'll note there is no need to mention me anywhere near this.

--=20
Mateusz Guzik <mjguzik gmail.com>

