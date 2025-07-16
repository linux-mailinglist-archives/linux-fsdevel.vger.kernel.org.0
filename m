Return-Path: <linux-fsdevel+bounces-55105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E6BB06EBF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 09:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F4454E08B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 07:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A73B288C37;
	Wed, 16 Jul 2025 07:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ed3u+nB1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E8D22D78A;
	Wed, 16 Jul 2025 07:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752650200; cv=none; b=F6vQ5hLxiu9YfnJRbgNbTGri4uBfL9VQZjTJT4x+XDRUA7nDIUF5mM+TtDx2VBPK95bYtfNPyua6os6lZfGtE8sYB/MXYLu94+t0bYtIcvPZiAD7SPkjVOtH9zXmrWtYiKugoJKqXgGtP7anCClifWccxuDA+XdZ9St4eWe4q2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752650200; c=relaxed/simple;
	bh=JC9GUNxw/8pzww3EfietsMXHtRdfM+/T4D3Afhx7EmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jh3k/lLI3PxP05Iul8RxUz2TnBQz+lTf7qtabMoWLjwFoXazmoCcvmGNetkrumLeOrvmJRHvzw1y5z3txV5ES9+EcMPsICumELOWMdhI5rRYXHf/T4WRv8p2Ebvsx/Md49TIdzZUj978YNLOhl3dV/McXLP/qz5JG1v4v4KbENE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ed3u+nB1; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-60c5b8ee2d9so13416726a12.2;
        Wed, 16 Jul 2025 00:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752650195; x=1753254995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WO7d0+q2djUO52oCNRL7ZqwTJEPhE6HqCuxpBjsJbpo=;
        b=ed3u+nB1+uxMMBdYN6CiKRoj+WF0HfxaETfiBkHTIVuv0vo0HmoS1ZAlf8Pn/UXJPX
         CaIUyxIR44v1/jMzDy75tkSV+IhJ0oXypkTMG1kz60rfEh7Xlrkn9q2hB+ewzHuUbdbG
         2IPw9xAkxm//eftg7vkWlcS61MVDXqF5trSwTfCCS/XNRG+umAiLCDUwcG6l/EfWyh01
         qKfkrKuKqtbphdPv8Z6cIezoY1iZVuUt3geauHDoXSxn9ZEoVwr5ZnDmaMJmcjkKOrR5
         qGvDN93JXa2e1nAeRg+YMzFSmd86ornMv9dxs3fCb3YPhVLvcLw2DKk4flv3st+x88PR
         33cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752650195; x=1753254995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WO7d0+q2djUO52oCNRL7ZqwTJEPhE6HqCuxpBjsJbpo=;
        b=ss3r0xVpx2xrGDhYgQVJLPXN+Lx1ZfSCAvAJTNwLzlHNEPS20MRH+xWhCLIQfBaDYb
         UQakqAkTqf9FmZPFW2/eMYlQl/KqnKdPXuLqNTLnA4GV66pOyGS9wA+RGreUvz4sdv9+
         cA1SiVL1xiAvmtn12aGIx/eQWZ0rWLOrs0ntpZ8Ou3ef4g/yjAV7kdP5BY6WZrVWXCse
         VkvG2VgNaU90x928kcACfj5xQ2aHYeQm76TEtobCHyZ2FHsbATLFDhWRE0bcp2JMMQ8H
         Q50yMf1jzKtxVzsdENYff8x/Z/mQFOlzP32zAnsm0P+dyG8a3SZe1dDsZ4GpUz0ZXlFy
         CSyw==
X-Forwarded-Encrypted: i=1; AJvYcCW17BHDVq2hLcpyFnWnGNyT3loqX6xZDJXIOkNRA+adR7x53gIrd/CUQRlKeY5YUBZ44mbm1OtTgnsiqUxzFg==@vger.kernel.org, AJvYcCXC1eTiDJnumBT++Z31kXVcE6lMGNlNVDQVoCmLJ19xNAYputH9Ivut3y7UdoZ6tK99JyvImXpsVqUzy4QE@vger.kernel.org
X-Gm-Message-State: AOJu0YwwLF3T12hbf9WUfeHiXzhQmsrPIvaVb8490poJ1NMZcdUfxY1/
	TrTS0uYdTpfh72qDJa/rqG8SGraK+hPXWOM2kPMwZqQ+BmUJE/hQSpTXOSj8Zpc4KAu8CxF9RUe
	Dij8wB56PNOjcxLQSdAeoXDqCHkW/s5Zx5eBSTGQ=
X-Gm-Gg: ASbGncsV1NNyAzVV+UggHDI78w8Q7QAye0cxM8MpRvKrByqRLqTV76FKxOEFtqgvPr4
	0HhsFj8wyDF++ctObdwN0ZmQ25hhqRRLqk8rYN35iMOZbOscbsMgRfCT/fFKoy0tWcNv+H+LIdx
	jq8KrL9MMUAMRMjAIJFPUk/C29DjdUisUCuMJNMA8oBK410i4vuuYkOheZ85H/Q20GKi2he1kv1
	20eLfU=
X-Google-Smtp-Source: AGHT+IH7Tf0Dv9xgNOtVschpdAHoXMzspY2cZ+oAOYce/rwmz8bh9cgeVyxh93h6vv+qVlE84PeHK9Vq1jv8FqTMZmo=
X-Received: by 2002:a17:906:d7e0:b0:ad8:9b5d:2c1e with SMTP id
 a640c23a62f3a-ae9c9b14a24mr210116566b.29.1752650194648; Wed, 16 Jul 2025
 00:16:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716004725.1206467-1-neil@brown.name> <20250716004725.1206467-16-neil@brown.name>
In-Reply-To: <20250716004725.1206467-16-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 16 Jul 2025 09:16:23 +0200
X-Gm-Features: Ac12FXyyR2BZbXbMs44FVpVuuvIL0S4IahIHf9DA6yzJnKhnxKyvMbosxzlsFq8
Message-ID: <CAOQ4uxgFZR1tSrRU-Lf9M5v8c=zp4=dcYNAW1Luwism2+jUsww@mail.gmail.com>
Subject: Re: [PATCH v3 15/21] ovl: change ovl_workdir_cleanup() to take dir
 lock as needed.
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 2:47=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> Rather than calling ovl_workdir_cleanup() with the dir already locked,
> change it to take the dir lock only when needed.
>
> Also change ovl_workdir_cleanup() to take a dentry for the parent rather
> than an inode.
>
> Signed-off-by: NeilBrown <neil@brown.name>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/overlayfs.h |  2 +-
>  fs/overlayfs/readdir.c   | 36 +++++++++++++-----------------------
>  fs/overlayfs/super.c     |  6 +-----
>  3 files changed, 15 insertions(+), 29 deletions(-)
>
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index cff5bb625e9d..f6023442a45c 100644
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
> index b0f9e5a00c1a..e2d0c314df6c 100644
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
> @@ -1139,14 +1138,9 @@ static int ovl_workdir_cleanup_recurse(struct ovl_=
fs *ofs, const struct path *pa
>                 dentry =3D ovl_lookup_upper_unlocked(ofs, p->name, path->=
dentry, p->len);
>                 if (IS_ERR(dentry))
>                         continue;
> -               if (dentry->d_inode) {
> -                       err =3D ovl_parent_lock(path->dentry, dentry);
> -                       if (!err) {
> -                               err =3D ovl_workdir_cleanup(ofs, dir, pat=
h->mnt,
> -                                                         dentry, level);
> -                               ovl_parent_unlock(path->dentry);
> -                       }
> -               }
> +               if (dentry->d_inode)
> +                       err =3D ovl_workdir_cleanup(ofs, path->dentry, pa=
th->mnt,
> +                                                 dentry, level);
>                 dput(dentry);
>                 if (err)
>                         break;
> @@ -1156,24 +1150,25 @@ static int ovl_workdir_cleanup_recurse(struct ovl=
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
> +       err =3D ovl_parent_lock(parent, dentry);
> +       if (err)
> +               return err;
> +       err =3D ovl_do_rmdir(ofs, parent->d_inode, dentry);
> +       ovl_parent_unlock(parent);
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
> @@ -1184,7 +1179,6 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
>         int err;
>         struct dentry *indexdir =3D ofs->workdir;
>         struct dentry *index =3D NULL;
> -       struct inode *dir =3D indexdir->d_inode;
>         struct path path =3D { .mnt =3D ovl_upper_mnt(ofs), .dentry =3D i=
ndexdir };
>         LIST_HEAD(list);
>         struct ovl_cache_entry *p;
> @@ -1213,11 +1207,7 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
>                 }
>                 /* Cleanup leftover from index create/cleanup attempt */
>                 if (index->d_name.name[0] =3D=3D '#') {
> -                       err =3D ovl_parent_lock(indexdir, index);
> -                       if (!err) {
> -                               err =3D ovl_workdir_cleanup(ofs, dir, pat=
h.mnt, index, 1);
> -                               ovl_parent_unlock(indexdir);
> -                       }
> +                       err =3D ovl_workdir_cleanup(ofs, indexdir, path.m=
nt, index, 1);
>                         if (err)
>                                 break;
>                         goto next;
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index cb2551a155d8..4c3736bf2db4 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -319,11 +319,7 @@ static struct dentry *ovl_workdir_create(struct ovl_=
fs *ofs,
>                                 return work;
>
>                         retried =3D true;
> -                       err =3D ovl_parent_lock(ofs->workbasedir, work);
> -                       if (!err) {
> -                               err =3D ovl_workdir_cleanup(ofs, dir, mnt=
, work, 0);
> -                               ovl_parent_unlock(ofs->workbasedir);
> -                       }
> +                       err =3D ovl_workdir_cleanup(ofs, ofs->workbasedir=
, mnt, work, 0);
>                         dput(work);
>                         if (err =3D=3D -EINVAL)
>                                 return ERR_PTR(err);
> --
> 2.49.0
>

