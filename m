Return-Path: <linux-fsdevel+bounces-71464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 052A5CC20E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 12:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04D4F301D321
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 11:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F5733B943;
	Tue, 16 Dec 2025 11:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJPhlEXf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92562D7DD0
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Dec 2025 11:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765882933; cv=none; b=ezNqx9UtvC3z8qeyNnu9eZmY19aR2/lYzY5CgG7TbyUb8JUqBsqEYr8IKlj75rHTwgVc9BjsbxIIU5Vc1SiYNH37ior9474JhEUH0Dfc/dU3h2A/awyadZUBA7lrfrbRHClfg6DJpLZRGXwo4khrMhIIAJ9us6yZiJ46SRg21TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765882933; c=relaxed/simple;
	bh=WUrt5wreEtdeMGsRTHrHnffO1diYTbvYtAmbWabpiyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m0GwmAbEKfvUlt5fUEeRKsgKM/+ns5XMiqHWiqqrffJ3/v1Je7+PNc5PdP2tBnqy24VNq/5crQsCyuUNRlKxQd6kHGtblb+mecHqmkbd71SKGu/zq5fiB7FJx+TpAcXWmbMazzetB9h6voG7b9zQaJrOipxSsV+k0TMbc10rTEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJPhlEXf; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64979bee42aso6542677a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Dec 2025 03:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765882930; x=1766487730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2CkIub37vOFODWJl1qR29+Sg6lxKE6FMwvaStqz0ty4=;
        b=gJPhlEXfAmsn9x8WAKaXKTAisBqnM3iDrLb8JaKhYvWsPj+T9MdDl/mYkY+19Esr/N
         +tFy725WPSJsqZheRlJXDey4vXjv+5UWSeFPGHhS8YtR01rH3/YYpP9LnGo6ZyzTUIOF
         /3QW/wdE+/SUii7AT8Xm0ky1IJ+tvdSMwjufXERtkbUZREeTB25PquZY2d65n9kPjNIG
         ZFS7gVxHstRE3go+Xlt34IFcRuLsWPpUeGHWS1+yHtq4qPrbgLgbYjRepo3kjPdvlWHq
         bFT2efAq8IlERLCncJazslPINeVsKthPcw89uGp/vGKN3MorVczkSt6pnJCeFcuOw2/G
         UtuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765882930; x=1766487730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2CkIub37vOFODWJl1qR29+Sg6lxKE6FMwvaStqz0ty4=;
        b=qLUQbZ/NtcP425V/XX8KprcRiRV/cFAyY7BCyhDn7PCH+16+oVYwB5nn9kDuVoW8d6
         ZU4Xp907jd4pS3V7KILiBjQmR7N9gar+QU+9ypL9wE6WNghih+Lv+XhDHPG2aZfIW/rd
         BIRmjTt7ScPDNxNxhlQgtY7bDIWBPIELyGcCYhzzzwaZwpAuTKoRqR5m+xIIPSY5oaJw
         LLmQR8K4dXMZiLClWkwk4tc3Gn6vB6q9TB4kjJdG7flcBt/LBzaAX8wENqcCjgxYXukG
         sDgCLasqmoApBHNFxo7HzOcKjg0nAE81PFLRFlOu75vKaXagEyiLFdPU57YWq6rEU34V
         4eXw==
X-Forwarded-Encrypted: i=1; AJvYcCUa5FTTvojQBqQfq25fvK4MJHlVj40UFzd9X0MPhs+PGsT+jVCJS32188BKHUMO1WJ0bp/5HajGAKkIG0uf@vger.kernel.org
X-Gm-Message-State: AOJu0YzYBDFNSTI/w5KsTJvN/60Skoi8pZn+kb8TFGlZsXjRhi8mB6+7
	66PV24/+zGED4pGiCLkb2jtTQKZ7LfdI2J6pX0QP290lLWayeJucGGG4lsPDmvUVZfIY3UCCZvy
	MnCKJONa3v/uu581BApb0toMXrjtiB0M=
X-Gm-Gg: AY/fxX7VykVyTKNlkAlohHp4wnmVcmOaB1pIJNOfo9mxD29tt1gCN4LtXWwHvLim0EO
	FQgBTbMi7+5r3aDre5esIG2mVbRBA66L1du/6XUb3fNN2xhTHQIUKHyn+/3AEBp74qkOWRryjl6
	UFugDTYzBxWJYd3bN7cVZc4tdekTt2Q6gE2wyKvDuuTcM+HBmdgnIwTRGVxmf/rLZeaZMI7hrtT
	zM6IfzEuac5AKa5N5z+1eSymLLbGyj2RaG+b/E+hWgD7nVHRiqXNBnDmbDh0DJRFGLkRSuQFtMN
	ZxhPwRLeQ8jQKgktzc9rRUQ2XYoyqwcExGiDkI5R
X-Google-Smtp-Source: AGHT+IE/YZvTuNbIzwilNOH7J10PqIjczJtnHyIT8f+bec0Zb671JutkhTKf69MMn3tRQ4MtOQd2dSnMYJgVAyuS+x8=
X-Received: by 2002:a05:6402:2341:b0:647:b4cf:b4ff with SMTP id
 4fb4d7f45d1cf-6499b1c27c0mr15290973a12.17.1765882929936; Tue, 16 Dec 2025
 03:02:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212181254.59365-1-luis@igalia.com> <20251212181254.59365-7-luis@igalia.com>
In-Reply-To: <20251212181254.59365-7-luis@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 16 Dec 2025 12:01:58 +0100
X-Gm-Features: AQt7F2oQyGGewsM65Xzp3QAouxnGTu5phNuNFQuAgjUkEycVmDfQIrSGZD4hZNc
Message-ID: <CAOQ4uxh++mVfJXpPt0UH2Xf87Y9qwhJvtTAU=bXvZk0yR0QUEQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 6/6] fuse: implementation of export_operations with FUSE_LOOKUP_HANDLE
To: Luis Henriques <luis@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, "Darrick J. Wong" <djwong@kernel.org>, 
	Bernd Schubert <bschubert@ddn.com>, Kevin Chen <kchen@ddn.com>, 
	Horst Birthelmer <hbirthelmer@ddn.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Matt Harvey <mharvey@jumptrading.com>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2025 at 7:13=E2=80=AFPM Luis Henriques <luis@igalia.com> wr=
ote:
>
> This patch allows the NFS handle to use the new file handle provided by t=
he
> LOOKUP_HANDLE operation.  It still allows the usage of nodeid+generation =
as
> an handle if this operation is not supported by the FUSE server or if no
> handle is available for a specific inode.  I.e. it can mix both file hand=
le
> types FILEID_INO64_GEN{_PARENT} and FILEID_FUSE_WITH{OUT}_PARENT.

Why the mix? I dont get it.

>
> Signed-off-by: Luis Henriques <luis@igalia.com>
> ---
>  fs/fuse/export.c         | 162 ++++++++++++++++++++++++++++++++++++---
>  include/linux/exportfs.h |   7 ++
>  2 files changed, 160 insertions(+), 9 deletions(-)
>
> diff --git a/fs/fuse/export.c b/fs/fuse/export.c
> index 4a9c95fe578e..b40d146a32f2 100644
> --- a/fs/fuse/export.c
> +++ b/fs/fuse/export.c
> @@ -3,6 +3,7 @@
>   * FUSE NFS export support.
>   *
>   * Copyright (C) 2001-2008  Miklos Szeredi <miklos@szeredi.hu>
> + * Copyright (C) 2025 Jump Trading LLC, author: Luis Henriques <luis@iga=
lia.com>
>   */
>
>  #include "fuse_i.h"
> @@ -10,7 +11,8 @@
>
>  struct fuse_inode_handle {
>         u64 nodeid;
> -       u32 generation;
> +       u32 generation; /* XXX change to u64, and use fid->i64.ino in enc=
ode/decode? */
> +       struct fuse_file_handle fh;

If anything this should be a union
or maybe I don't understand what you were trying to accomplish.
Please try to explain the design better in the commit message.

>  };
>
>  static struct dentry *fuse_get_dentry(struct super_block *sb,
> @@ -67,8 +69,8 @@ static struct dentry *fuse_get_dentry(struct super_bloc=
k *sb,
>         return ERR_PTR(err);
>  }
>
> -static int fuse_encode_fh(struct inode *inode, u32 *fh, int *max_len,
> -                          struct inode *parent)
> +static int fuse_encode_gen_fh(struct inode *inode, u32 *fh, int *max_len=
,
> +                             struct inode *parent)
>  {
>         int len =3D parent ? 6 : 3;
>         u64 nodeid;
> @@ -96,38 +98,180 @@ static int fuse_encode_fh(struct inode *inode, u32 *=
fh, int *max_len,
>         }
>
>         *max_len =3D len;
> +
>         return parent ? FILEID_INO64_GEN_PARENT : FILEID_INO64_GEN;
>  }
>
> -static struct dentry *fuse_fh_to_dentry(struct super_block *sb,
> -               struct fid *fid, int fh_len, int fh_type)
> +static int fuse_encode_fuse_fh(struct inode *inode, u32 *fh, int *max_le=
n,
> +                              struct inode *parent)
> +{
> +       struct fuse_inode *fi =3D get_fuse_inode(inode);
> +       struct fuse_inode *fip =3D NULL;
> +       struct fuse_inode_handle *handle =3D (void *)fh;
> +       int type =3D FILEID_FUSE_WITHOUT_PARENT;
> +       int len, lenp =3D 0;
> +       int buflen =3D *max_len << 2; /* max_len: number of words */
> +
> +       len =3D sizeof(struct fuse_inode_handle) + fi->fh->size;
> +       if (parent) {
> +               fip =3D get_fuse_inode(parent);
> +               if (fip->fh && fip->fh->size) {
> +                       lenp =3D sizeof(struct fuse_inode_handle) +
> +                               fip->fh->size;
> +                       type =3D FILEID_FUSE_WITH_PARENT;
> +               }
> +       }
> +
> +       if (buflen < (len + lenp)) {
> +               *max_len =3D (len + lenp) >> 2;
> +               return  FILEID_INVALID;
> +       }
> +
> +       handle[0].nodeid =3D fi->nodeid;
> +       handle[0].generation =3D inode->i_generation;
> +       memcpy(&handle[0].fh, fi->fh, len);
> +       if (lenp) {
> +               handle[1].nodeid =3D fip->nodeid;
> +               handle[1].generation =3D parent->i_generation;
> +               memcpy(&handle[1].fh, fip->fh, lenp);
> +       }
> +
> +       *max_len =3D (len + lenp) >> 2;
> +
> +       return type;
> +}
> +
> +static int fuse_encode_fh(struct inode *inode, u32 *fh, int *max_len,
> +                          struct inode *parent)
> +{
> +       struct fuse_conn *fc =3D get_fuse_conn(inode);
> +       struct fuse_inode *fi =3D get_fuse_inode(inode);
> +
> +       if (fc->lookup_handle && fi->fh && fi->fh->size)
> +               return fuse_encode_fuse_fh(inode, fh, max_len, parent);
> +
> +       return fuse_encode_gen_fh(inode, fh, max_len, parent);
> +}
> +
> +static struct dentry *fuse_fh_gen_to_dentry(struct super_block *sb,
> +                                           struct fid *fid, int fh_len)
>  {
>         struct fuse_inode_handle handle;
>
> -       if ((fh_type !=3D FILEID_INO64_GEN &&
> -            fh_type !=3D FILEID_INO64_GEN_PARENT) || fh_len < 3)
> +       if (fh_len < 3)

I dont understand why this was changed.

>                 return NULL;
>
>         handle.nodeid =3D (u64) fid->raw[0] << 32;
>         handle.nodeid |=3D (u64) fid->raw[1];
>         handle.generation =3D fid->raw[2];
> +
>         return fuse_get_dentry(sb, &handle);
>  }
>
> -static struct dentry *fuse_fh_to_parent(struct super_block *sb,
> +static struct dentry *fuse_fh_fuse_to_dentry(struct super_block *sb,
> +                                            struct fid *fid, int fh_len)
> +{
> +       struct fuse_inode_handle *handle;
> +       struct dentry *dentry;
> +       int len =3D sizeof(struct fuse_file_handle);
> +
> +       handle =3D (void *)fid;
> +       len +=3D handle->fh.size;
> +
> +       if ((fh_len << 2) < len)
> +               return NULL;
> +
> +       handle =3D kzalloc(len, GFP_KERNEL);
> +       if (!handle)
> +               return NULL;
> +
> +       memcpy(handle, fid, len);
> +
> +       dentry =3D fuse_get_dentry(sb, handle);
> +       kfree(handle);
> +
> +       return dentry;
> +}
> +
> +static struct dentry *fuse_fh_to_dentry(struct super_block *sb,
>                 struct fid *fid, int fh_len, int fh_type)
> +{
> +       switch (fh_type) {
> +       case FILEID_INO64_GEN:
> +       case FILEID_INO64_GEN_PARENT:
> +               return fuse_fh_gen_to_dentry(sb, fid, fh_len);
> +       case FILEID_FUSE_WITHOUT_PARENT:
> +       case FILEID_FUSE_WITH_PARENT:
> +               return fuse_fh_fuse_to_dentry(sb, fid, fh_len);
> +       }
> +
> +       return NULL;
> +
> +}
> +
> +static struct dentry *fuse_fh_gen_to_parent(struct super_block *sb,
> +                                           struct fid *fid, int fh_len)
>  {
>         struct fuse_inode_handle parent;
>
> -       if (fh_type !=3D FILEID_INO64_GEN_PARENT || fh_len < 6)
> +       if (fh_len < 6)
>                 return NULL;
>
>         parent.nodeid =3D (u64) fid->raw[3] << 32;
>         parent.nodeid |=3D (u64) fid->raw[4];
>         parent.generation =3D fid->raw[5];
> +
>         return fuse_get_dentry(sb, &parent);
>  }
>
> +static struct dentry *fuse_fh_fuse_to_parent(struct super_block *sb,
> +                                            struct fid *fid, int fh_len)
> +{
> +       struct fuse_inode_handle *handle;
> +       struct dentry *dentry;
> +       int total_len;
> +       int len;
> +
> +       handle =3D (void *)fid;
> +       total_len =3D len =3D sizeof(struct fuse_inode_handle) + handle->=
fh.size;
> +
> +       if ((fh_len << 2) < total_len)
> +               return NULL;
> +
> +       handle =3D (void *)(fid + len);
> +       len =3D sizeof(struct fuse_file_handle) + handle->fh.size;
> +       total_len +=3D len;
> +
> +       if ((fh_len << 2) < total_len)
> +               return NULL;
> +
> +       handle =3D kzalloc(len, GFP_KERNEL);
> +       if (!handle)
> +               return NULL;
> +
> +       memcpy(handle, fid, len);
> +
> +       dentry =3D fuse_get_dentry(sb, handle);
> +       kfree(handle);
> +
> +       return dentry;
> +}
> +
> +static struct dentry *fuse_fh_to_parent(struct super_block *sb,
> +               struct fid *fid, int fh_len, int fh_type)
> +{
> +       switch (fh_type) {
> +       case FILEID_INO64_GEN:
> +       case FILEID_INO64_GEN_PARENT:
> +               return fuse_fh_gen_to_parent(sb, fid, fh_len);
> +       case FILEID_FUSE_WITHOUT_PARENT:
> +       case FILEID_FUSE_WITH_PARENT:
> +               return fuse_fh_fuse_to_parent(sb, fid, fh_len);
> +       }
> +
> +       return NULL;
> +}
> +
>  static struct dentry *fuse_get_parent(struct dentry *child)
>  {
>         struct inode *child_inode =3D d_inode(child);
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index f0cf2714ec52..db783f6b28bc 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -110,6 +110,13 @@ enum fid_type {
>          */
>         FILEID_INO64_GEN_PARENT =3D 0x82,
>
> +       /*
> +        * 64 bit nodeid number, 32 bit generation number,
> +        * variable length handle.
> +        */
> +       FILEID_FUSE_WITHOUT_PARENT =3D 0x91,
> +       FILEID_FUSE_WITH_PARENT =3D 0x92,
> +


Do we even need a handle with inode+gen+server specific handle?
I didn't think we would. If we do, please explain why.

Thanks,
Amir.

