Return-Path: <linux-fsdevel+bounces-54643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5565B01D73
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 15:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68EFA3B51D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 13:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07F72D3750;
	Fri, 11 Jul 2025 13:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8VX+6Cg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6454F2D3747;
	Fri, 11 Jul 2025 13:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752240528; cv=none; b=j5BNOpuEA2quX4PVda4CpKW8dh3Ru+d/3DcfuDO0JwEIEdsgW32BBhCTvDU0Ljy8o4WKUC11D+vC+w6nVa0bI/3bzq16+XJz/QfQuX9zOXV6dJqTfrf9COzVEaSQUbGNSJlbMRozjVwJ56Qvdnetp5LuEA62DfTQetwmSGeQaSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752240528; c=relaxed/simple;
	bh=5HaL4EbHnJghoOi08JLadYxh/25z0kOc8VxK4LholdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XUTABGbSuiXio/G8JaBjE5vTn6MlHbfdCm1FSnMuHhvfbvWLrXn+MuaddkTnqY4Gm6YSdmNk6jPbk70qyPmVvTdagMmfIK7Eau0ljHWwMIhOIItwJDG0VmNNnz3Qf98rk6xZFZH21IgsnYrBrBhDl6FD+76wjAnQRxS+JK0rPNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8VX+6Cg; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae0df6f5758so376553366b.0;
        Fri, 11 Jul 2025 06:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752240525; x=1752845325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2h8SYkSmPLok+tWuAZWsvxqrpIO329lLu72xBDWCUQQ=;
        b=T8VX+6CgoZmOQ04XbPufLgELyvG4H534Vl+NGxU/9CN/NnW5YBffXC64ZGyj4NRlFB
         58mXH0Ah8h27BA6BDowwfS1/NbWJno3oPuaO411XyW0iwgKMl36Or6EdsQU/rpkS4Jxb
         VtBfnNUqRZxZhsjENDgAbKeVnlDDW0lRuV3HAVI8dEr9glPhqZq2nXj8YciEYEK943wQ
         y+b1O4/5r7bSVKgyGH/gd7LVWhi7tt075SX7W1874VwnqdB9++TEixftgwjai5UX3//k
         CZHDwgLhTYy6alSaoECkLheGRcbe00LJGKuOIwrzoB74U0MCGJoxMUXr5AA0FjZ2nsdw
         jQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752240525; x=1752845325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2h8SYkSmPLok+tWuAZWsvxqrpIO329lLu72xBDWCUQQ=;
        b=jIEVIKT7RCTLuieWoab/tbJq7mCm/1E4jk2BVtaWYghSewvmJnGb5z0TCyu46Y9ZVS
         fMtFzJL5iZvHBY/caxj0qyCQJfNlIisQIrIpoyBVWpFqSRJVSfNPrAa1PxiJHCtwJr6K
         /InjdoYZgPCEtYPTsKE11HKx/n/ki8qKtgUkprr6ZJbyr8AvJ+xUv48x7qGDpQ30mLtg
         +Is+aMk6ngGJJ2e4N154eDS04xPZ/39iCY+e4QdLN9vmq1T8AAbyY+iPHr+vPNSxGqFK
         tDegqiUKoRvW7sX2UCdAT7xGf/meETrCUcbV90loo6E3+4mDDElk9oOBgjbkmKPYVQuD
         1IrA==
X-Forwarded-Encrypted: i=1; AJvYcCUB8M0OEkMDyQe21eY6zcYeETF27kh2+wzmf5GRYcahSCshP9R9GbaViMVYnx0jF843bs1O23SnfDZrWVQa@vger.kernel.org, AJvYcCV4Wt1cn6Z17/VUcx2LHhAOg7IMd578JZ5BNC7ma1AO4LQaqK+1fK4TdkGV+lGg4tewwebIQmwBhUcFRPV6fQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxINxDbAgO1JfRJxCNa7RZ9cg0+RBNSt10wIj9p/pnDj3VwocfO
	N30NNCxqEzpvcO+/vVnm0fxwR/3t9WHQxOSF5SouLzxDa3wOJPxoY6CNSztfUgXf8aXO+2CR+0m
	WkaHey8RYMreb0EA9lkTCFpBZ4dpnGBcpw3J4NLI=
X-Gm-Gg: ASbGncs4xMJYCbkq4d2+h4i8OPUXaH8zCtJuqVuuW1GTM7NBzK0+YIoUnRCVWM0BIMA
	3LdEPadJBgoEI2ZU0sr3ogvdnPF1nANdI9X4vzJOnmGeUvdR/meVcot7bYFvbiXWlMa6u95YUIZ
	K4SOpFf0/5/DDHtbuM2kxZ1xQAT80deD72cF6MIPfiJlIDXaFd8zyVrZezdAlpXeeMmkxXnoguU
	Ho73R0=
X-Google-Smtp-Source: AGHT+IHHKUmW0pEOIW8uyvREUZX9l8RQ24inhFPdX5cHoy47KiKshuemM2K3zCSR/D5slwUAgUolCIOG6tUdk85zDVk=
X-Received: by 2002:a17:907:f1cf:b0:ade:2e4b:50d1 with SMTP id
 a640c23a62f3a-ae6fc1fc5b3mr346862766b.29.1752240524287; Fri, 11 Jul 2025
 06:28:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710232109.3014537-1-neil@brown.name> <20250710232109.3014537-15-neil@brown.name>
In-Reply-To: <20250710232109.3014537-15-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 11 Jul 2025 15:28:32 +0200
X-Gm-Features: Ac12FXxFnlJ6oaYabeeoHxoNa4ZO_b-tCX6m0kjhEpmLF9PD7NA0z7ZEbT0Ux4I
Message-ID: <CAOQ4uxgnwa8_CEYa03vy+exje8iM7fEUJ=ToRq-2ya2Twp5vQQ@mail.gmail.com>
Subject: Re: [PATCH 14/20] ovl: change ovl_workdir_cleanup() to take dir lock
 as needed.
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 1:21=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> Rather than calling ovl_workdir_cleanup() with the dir already locked,
> change it to take the dir lock only when needed.
>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/overlayfs/overlayfs.h |  2 +-
>  fs/overlayfs/readdir.c   | 30 +++++++++++++-----------------
>  fs/overlayfs/super.c     |  4 +---
>  3 files changed, 15 insertions(+), 21 deletions(-)
>
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index ec804d6bb2ef..ca74be44dddd 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -738,7 +738,7 @@ void ovl_cleanup_whiteouts(struct ovl_fs *ofs, struct=
 dentry *upper,
>  void ovl_cache_free(struct list_head *list);
>  void ovl_dir_cache_free(struct inode *inode);
>  int ovl_check_d_type_supported(const struct path *realpath);
> -int ovl_workdir_cleanup(struct ovl_fs *ofs, struct inode *dir,
> +int ovl_workdir_cleanup(struct ovl_fs *ofs, struct dentry *parent,
>                         struct vfsmount *mnt, struct dentry *dentry, int =
level);
>  int ovl_indexdir_cleanup(struct ovl_fs *ofs);
>
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index b3d44bf56c78..6cc5f885e036 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -1096,7 +1096,6 @@ static int ovl_workdir_cleanup_recurse(struct ovl_f=
s *ofs, const struct path *pa
>                                        int level)
>  {
>         int err;
> -       struct inode *dir =3D path->dentry->d_inode;
>         LIST_HEAD(list);
>         struct ovl_cache_entry *p;
>         struct ovl_readdir_data rdd =3D {
> @@ -1139,11 +1138,9 @@ static int ovl_workdir_cleanup_recurse(struct ovl_=
fs *ofs, const struct path *pa
>                 dentry =3D ovl_lookup_upper_unlocked(ofs, p->name, path->=
dentry, p->len);
>                 if (IS_ERR(dentry))
>                         continue;
> -               if (dentry->d_inode) {
> -                       inode_lock_nested(dir, I_MUTEX_PARENT);
> -                       err =3D ovl_workdir_cleanup(ofs, dir, path->mnt, =
dentry, level);
> -                       inode_unlock(dir);
> -               }
> +               if (dentry->d_inode)
> +                       err =3D ovl_workdir_cleanup(ofs, path->dentry, pa=
th->mnt,
> +                                                 dentry, level);
>                 dput(dentry);
>                 if (err)
>                         break;
> @@ -1153,24 +1150,25 @@ static int ovl_workdir_cleanup_recurse(struct ovl=
_fs *ofs, const struct path *pa
>         return err;
>  }
>
> -int ovl_workdir_cleanup(struct ovl_fs *ofs, struct inode *dir,
> +int ovl_workdir_cleanup(struct ovl_fs *ofs, struct dentry *parent,
>                         struct vfsmount *mnt, struct dentry *dentry, int =
level)
>  {
>         int err;
>
> -       if (!d_is_dir(dentry) || level > 1) {
> -               return ovl_cleanup(ofs, dir, dentry);
> -       }
> +       if (!d_is_dir(dentry) || level > 1)
> +               return ovl_cleanup_unlocked(ofs, parent, dentry);
>
> -       err =3D ovl_do_rmdir(ofs, dir, dentry);
> +       err =3D parent_lock(parent, dentry);
> +       if (err)
> +               return err;
> +       err =3D ovl_do_rmdir(ofs, parent->d_inode, dentry);
> +       parent_unlock(parent);

At this point, the code looks correct,
but it replaces unsafe uses of inode_lock_nested() with correct use of
parent_lock().

Please fix patches 11-13

Thanks,
Amir.

>         if (err) {
>                 struct path path =3D { .mnt =3D mnt, .dentry =3D dentry }=
;
>
> -               inode_unlock(dir);
>                 err =3D ovl_workdir_cleanup_recurse(ofs, &path, level + 1=
);
> -               inode_lock_nested(dir, I_MUTEX_PARENT);
>                 if (!err)
> -                       err =3D ovl_cleanup(ofs, dir, dentry);
> +                       err =3D ovl_cleanup_unlocked(ofs, parent, dentry)=
;
>         }
>
>         return err;
> @@ -1210,9 +1208,7 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
>                 }
>                 /* Cleanup leftover from index create/cleanup attempt */
>                 if (index->d_name.name[0] =3D=3D '#') {
> -                       inode_lock_nested(dir, I_MUTEX_PARENT);
> -                       err =3D ovl_workdir_cleanup(ofs, dir, path.mnt, i=
ndex, 1);
> -                       inode_unlock(dir);
> +                       err =3D ovl_workdir_cleanup(ofs, indexdir, path.m=
nt, index, 1);
>                         if (err)
>                                 break;
>                         goto next;
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 239ae1946edf..23f43f8131dd 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -319,9 +319,7 @@ static struct dentry *ovl_workdir_create(struct ovl_f=
s *ofs,
>                                 goto out;
>
>                         retried =3D true;
> -                       inode_lock_nested(dir, I_MUTEX_PARENT);
> -                       err =3D ovl_workdir_cleanup(ofs, dir, mnt, work, =
0);
> -                       inode_unlock(dir);
> +                       err =3D ovl_workdir_cleanup(ofs, ofs->workbasedir=
, mnt, work, 0);
>                         dput(work);
>                         if (err =3D=3D -EINVAL) {
>                                 work =3D ERR_PTR(err);
> --
> 2.49.0
>

