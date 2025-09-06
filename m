Return-Path: <linux-fsdevel+bounces-60419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDB9B46A5A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 11:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C47A188BC14
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 09:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477052877DF;
	Sat,  6 Sep 2025 09:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnRmb1PV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D422765C3
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Sep 2025 09:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757149796; cv=none; b=BbjNzA2EOY3KETtDqZEeI2eJjQIF/TX79Ts4FUPwrJwX5L2qbV2+cuEdP8k4ldlNh956EYWh+oSpolvt3YNzAAWaJsh1CcISxWUQkmR0Dbv+V8HKkGk4Aivur3nAZVyc6U9kCAPyD67F/O5DExoDbUZ2QeVZgrOOch74ThLm63w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757149796; c=relaxed/simple;
	bh=OV1+fv3Ng1jypL5QY2WD2lpiS5YBycLjNDYxv5cDjKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FAbU17oTILAQ/0EgPK63FBomkn/aEhHuLFInHVOMNYCdEQt4GUhtatzmdgP28gN9YfMVCkBEVrQUAtY5ddT+IBEoftrHn2nSb63IxZTVK+XB64bmMpks/Slt2vNDuvBdfbFTLgE1+Kw2hblgIM6dEF5zAD+W9Ej/q+lLFv64M4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnRmb1PV; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61d3d622a2bso5310227a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 Sep 2025 02:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757149793; x=1757754593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQxDCcALcXDkv+enBTAENkzW4SozSvu3j+yUUOm9ADY=;
        b=hnRmb1PVqqrhKgrAcXO34Q33Cx+dzggY3lN//1huIXoonSsVTZYS9kOdxupF/D/Ou/
         WFsFs/SXnt0RovbaLYuRhRu6aHHRMDYB2plp614CCp4VEM3HTCMI7KalJvP0W/hrcJm1
         zXYQkAIEdSVW4okj2xZXk6kmNIFK5xpqAUmS6n/5QVP4XXkuiQYWMX86xaLiUZI8koii
         2FysZKSFDRaSPPjvMIF5bkc5QcOnn2/dpn0KhhhiDWK/auRyCD7oCDMWtKcge8yC1AAR
         0LUegwoI8p0TLvE6GVIw9NbaZHKsKxvgCEO4QNU3BLC4ku3ahSmVd1YN/r6mHzHyzQET
         r5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757149793; x=1757754593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQxDCcALcXDkv+enBTAENkzW4SozSvu3j+yUUOm9ADY=;
        b=oW+bmN76KomqymoOlkZQwuuBfXiWFr3lQYojn6Nb8/fDWhV5AXxyatuDWQqc3pU3Qp
         4LweWLR9KyberKdyrtFayrPUd4k7bCyNHtug2PL1153lTecKh8mRw1lOksYY5eYVrJ5/
         r8R7vWzLsy7OhTWiNNXb0WVVj23fk8OTZ9yKpXi0i1s5BUdiPgqP625jR42DwOmLExhV
         l+nLLnLrmSw2GqXfsocIX5rRRjYiORNi1qKjz2aCTirQd2kCmuD1blou+0ERNBAH/Iom
         vcQqKr05nMML3JqPH2yfpTbglrYSZjo0ceDKdse3G7yeHeAhCz++lo0L0iGh/rTS4ZGx
         YeMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgNwCyCkKWBjdqGaSITbMYlESGS4LHP7BTrcs1UeVofyyXlJEno4mlr2nvvPfye/yI8ZsmUoM2omJbLjIe@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5haqyGp5rfssyhShtLGa6S9lmDM/PexGhphy1qb5bqWCbW6R0
	3NRNmrHZAPqGpp09hfOv8Ub4Y3mh31o9pM20khgCDDQkyflsI1dkCMEhH98z3R42X6ZuZEIkHKz
	Kvr/2uYYQ1E6UoLnIvlZDVTcqMIIijjU=
X-Gm-Gg: ASbGnctpXzTY6y5SbOp6EMYIGVkKPljKbC9ivDcrAK5YXaDp05khIbCtkWcNriNFCHc
	Hz1yTx6LTqhmofwQUIJFndEd+xqNhu8WpJdIzA/wjUTdmnJjsPkakw/E7eDnREIiEzB633tuMO7
	OquuoMlPr6Dd7sAwyFYP11LUx6X6kutxx3DvreGURfS0oQAH5v1A9OtmcPc0hKBedcNad0z/75O
	XgdC2U=
X-Google-Smtp-Source: AGHT+IEmwObDL46vfet4G7Fopwh0zKA/S4nyqfpYFe0pBOmffsq+xJw8oRzo7fIbf05BB5gSvMSIfVVP0vLSCcC9gtg=
X-Received: by 2002:a05:6402:13ca:b0:61c:90c:ee97 with SMTP id
 4fb4d7f45d1cf-623db0772a4mr1327127a12.4.1757149792778; Sat, 06 Sep 2025
 02:09:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250906050015.3158851-1-neilb@ownmail.net> <20250906050015.3158851-7-neilb@ownmail.net>
In-Reply-To: <20250906050015.3158851-7-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 6 Sep 2025 11:09:41 +0200
X-Gm-Features: Ac12FXzYK2_Cj1KsJMZurChQX6tdd_RB9gA8rSR0cayi-Mv6VavUxZ0BfrIelpk
Message-ID: <CAOQ4uxj_JAT6ctwGkw-jVm0_9GDmzcAhL4yVFpxm=1mZ0oWceQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] VFS: rename kern_path_locked() to kern_path_removing()
To: NeilBrown <neilb@ownmail.net>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 6, 2025 at 7:01=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote:
>
> From: NeilBrown <neil@brown.name>
>
> Also rename user_path_locked_at() to user_path_removing_at()
>
> Add done_path_removing() to clean up after these calls.
>
> The only credible need for a locked positive dentry is to remove it, so
> make that explicit in the name.

That's a pretty bold statement...

I generally like the done_ abstraction that could be also used as a guard
cleanup helper.

The problem I have with this is that {kern,done}_path_removing rhymes with
{kern,done}_path_create, while in fact they are very different.

What is the motivation for the function rename (you did not specify it)?
Is it just because done_path_locked() sounds weird or something else?

I wonder if using guard semantics could be the better choice if
looking to clarify the code.

Thanks,
Amir.

>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  Documentation/filesystems/porting.rst | 10 ++++++++++
>  drivers/base/devtmpfs.c               | 12 ++++--------
>  fs/bcachefs/fs-ioctl.c                |  6 ++----
>  fs/namei.c                            | 23 +++++++++++++++++------
>  include/linux/namei.h                 |  5 +++--
>  5 files changed, 36 insertions(+), 20 deletions(-)
>
> diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesy=
stems/porting.rst
> index 85f590254f07..defbae457310 100644
> --- a/Documentation/filesystems/porting.rst
> +++ b/Documentation/filesystems/porting.rst
> @@ -1285,3 +1285,13 @@ rather than a VMA, as the VMA at this stage is not=
 yet valid.
>  The vm_area_desc provides the minimum required information for a filesys=
tem
>  to initialise state upon memory mapping of a file-backed region, and out=
put
>  parameters for the file system to set this state.
> +
> +---
> +
> +**mandatory**
> +
> +kern_path_locked and user_path_locked_at() are renamed to
> +kern_path_removing() and user_path_removing_at() and should only
> +be used when removing a name.  done_path_removing() should be called
> +after removal.
> +
> diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
> index 31bfb3194b4c..26d0beead1f0 100644
> --- a/drivers/base/devtmpfs.c
> +++ b/drivers/base/devtmpfs.c
> @@ -256,7 +256,7 @@ static int dev_rmdir(const char *name)
>         struct dentry *dentry;
>         int err;
>
> -       dentry =3D kern_path_locked(name, &parent);
> +       dentry =3D kern_path_removing(name, &parent);
>         if (IS_ERR(dentry))
>                 return PTR_ERR(dentry);
>         if (d_inode(dentry)->i_private =3D=3D &thread)
> @@ -265,9 +265,7 @@ static int dev_rmdir(const char *name)
>         else
>                 err =3D -EPERM;
>
> -       dput(dentry);
> -       inode_unlock(d_inode(parent.dentry));
> -       path_put(&parent);
> +       done_path_removing(dentry, &parent);
>         return err;
>  }
>
> @@ -325,7 +323,7 @@ static int handle_remove(const char *nodename, struct=
 device *dev)
>         int deleted =3D 0;
>         int err =3D 0;
>
> -       dentry =3D kern_path_locked(nodename, &parent);
> +       dentry =3D kern_path_removing(nodename, &parent);
>         if (IS_ERR(dentry))
>                 return PTR_ERR(dentry);
>
> @@ -349,10 +347,8 @@ static int handle_remove(const char *nodename, struc=
t device *dev)
>                 if (!err || err =3D=3D -ENOENT)
>                         deleted =3D 1;
>         }
> -       dput(dentry);
> -       inode_unlock(d_inode(parent.dentry));
> +       done_path_removing(dentry, &parent);
>
> -       path_put(&parent);
>         if (deleted && strchr(nodename, '/'))
>                 delete_path(nodename);
>         return err;
> diff --git a/fs/bcachefs/fs-ioctl.c b/fs/bcachefs/fs-ioctl.c
> index 4e72e654da96..9446cefbe249 100644
> --- a/fs/bcachefs/fs-ioctl.c
> +++ b/fs/bcachefs/fs-ioctl.c
> @@ -334,7 +334,7 @@ static long bch2_ioctl_subvolume_destroy(struct bch_f=
s *c, struct file *filp,
>         if (arg.flags)
>                 return -EINVAL;
>
> -       victim =3D user_path_locked_at(arg.dirfd, name, &path);
> +       victim =3D user_path_removing_at(arg.dirfd, name, &path);
>         if (IS_ERR(victim))
>                 return PTR_ERR(victim);
>
> @@ -351,9 +351,7 @@ static long bch2_ioctl_subvolume_destroy(struct bch_f=
s *c, struct file *filp,
>                 d_invalidate(victim);
>         }
>  err:
> -       inode_unlock(dir);
> -       dput(victim);
> -       path_put(&path);
> +       done_path_removing(victim, &path);
>         return ret;
>  }
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 104015f302a7..c750820b27b9 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2757,7 +2757,8 @@ static int filename_parentat(int dfd, struct filena=
me *name,
>  }
>
>  /* does lookup, returns the object with parent locked */
> -static struct dentry *__kern_path_locked(int dfd, struct filename *name,=
 struct path *path)
> +static struct dentry *__kern_path_removing(int dfd, struct filename *nam=
e,
> +                                          struct path *path)
>  {
>         struct path parent_path __free(path_put) =3D {};
>         struct dentry *d;
> @@ -2815,24 +2816,34 @@ struct dentry *kern_path_parent(const char *name,=
 struct path *path)
>         return d;
>  }
>
> -struct dentry *kern_path_locked(const char *name, struct path *path)
> +struct dentry *kern_path_removing(const char *name, struct path *path)
>  {
>         struct filename *filename =3D getname_kernel(name);
> -       struct dentry *res =3D __kern_path_locked(AT_FDCWD, filename, pat=
h);
> +       struct dentry *res =3D __kern_path_removing(AT_FDCWD, filename, p=
ath);
>
>         putname(filename);
>         return res;
>  }
>
> -struct dentry *user_path_locked_at(int dfd, const char __user *name, str=
uct path *path)
> +void done_path_removing(struct dentry *dentry, struct path *path)
> +{
> +       if (!IS_ERR(dentry)) {
> +               inode_unlock(path->dentry->d_inode);
> +               dput(dentry);
> +               path_put(path);
> +       }
> +}
> +EXPORT_SYMBOL(done_path_removing);
> +
> +struct dentry *user_path_removing_at(int dfd, const char __user *name, s=
truct path *path)
>  {
>         struct filename *filename =3D getname(name);
> -       struct dentry *res =3D __kern_path_locked(dfd, filename, path);
> +       struct dentry *res =3D __kern_path_removing(dfd, filename, path);
>
>         putname(filename);
>         return res;
>  }
> -EXPORT_SYMBOL(user_path_locked_at);
> +EXPORT_SYMBOL(user_path_removing_at);
>
>  int kern_path(const char *name, unsigned int flags, struct path *path)
>  {
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index 1d5038c21c20..37568f8055f9 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -62,8 +62,9 @@ struct dentry *kern_path_parent(const char *name, struc=
t path *parent);
>  extern struct dentry *kern_path_create(int, const char *, struct path *,=
 unsigned int);
>  extern struct dentry *user_path_create(int, const char __user *, struct =
path *, unsigned int);
>  extern void done_path_create(struct path *, struct dentry *);
> -extern struct dentry *kern_path_locked(const char *, struct path *);
> -extern struct dentry *user_path_locked_at(int , const char __user *, str=
uct path *);
> +extern struct dentry *kern_path_removing(const char *, struct path *);
> +extern struct dentry *user_path_removing_at(int , const char __user *, s=
truct path *);
> +void done_path_removing(struct dentry *dentry, struct path *path);
>  int vfs_path_parent_lookup(struct filename *filename, unsigned int flags=
,
>                            struct path *parent, struct qstr *last, int *t=
ype,
>                            const struct path *root);
> --
> 2.50.0.107.gf914562f5916.dirty
>

