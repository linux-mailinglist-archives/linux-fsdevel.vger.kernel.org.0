Return-Path: <linux-fsdevel+bounces-17974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C238B4644
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 13:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74346288C7E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 11:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0264D5A0;
	Sat, 27 Apr 2024 11:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ai3JQzWU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6D0383B2;
	Sat, 27 Apr 2024 11:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714219106; cv=none; b=RWRhzcfC71VJjhNdi27iCwt9tvvH787h5W1JswgTpJ1HBDOK9Wla+Hg0osaAFh83TrNokcffQL2BpME106odA9vpegPMDC8UnBtEcnbZDVsai11isqqk+71NYpRoYD1cuzspRtP2x/co6/1mNjc0TKOV5AJAS+Wp+3iKfjrvLS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714219106; c=relaxed/simple;
	bh=4yBYy/e8fqD6PVLELNDiBeMDaQ8RxIXtGMJQ7flPNKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HCvZfVcNhwOq3Gthw2gvuM1H59wiriuvT1V/D/x/TjbLMx+dMa6n2X+6nMWGaNNf+3+0UAz6/jtCrPALi9ujZPvJAwt2zvO9KoUsvnDWNCSed5INcP4D37wNLaDiSet7HXS/qEnag7oLM/eqCosUtUbJtuvmkIax5OElet/cRPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ai3JQzWU; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-61af74a010aso29931577b3.0;
        Sat, 27 Apr 2024 04:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714219104; x=1714823904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMnQ9lC99MS72qmf7RGKrqRnKroV0Cshw6deBxLxYEk=;
        b=Ai3JQzWUrIoIRE2HCIO9eba5Iw+oLA0Abnddm7s2NAG21I8G9XEVaXJdpagE38CnUD
         ggwmggqE3zShNm68khUZycvBZptgxWv3KO3d4atiE5B+J146aOvQB+M4ZGWG/zHbzUYA
         7k8TISKgHnT7LL86L7uVwj0UIEWSwhbeGeNOn/EUnBDVpjJIbBF3UBsx7gfgc6yMEr6Y
         Rj4BuEel8x586Ea1/qH51nCKGXJQ+Q4FhL6BQ26x3c5y+0aADlbnhjBdQ4WrK8WSAwnO
         mZKnvlsCHCFpIHxhlIsue+TS8B16pzaPRraCqhDr0xPMmwRtenC0Xt4BnhF+SXWlpPGe
         DfOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714219104; x=1714823904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hMnQ9lC99MS72qmf7RGKrqRnKroV0Cshw6deBxLxYEk=;
        b=POMQzuUwPMrhbDIcCc5T5YK6nmlzrfvRcwA+8jddGlsLCui5nZMSQB3bQYzK3PCljI
         cId8gCxdZQgn5F+kn6+0UqnbiqzzDxrRaHBviGnihjXxzL+A/15MY0T3rPd2XiFmGNst
         hD+vN+XxeaRlG9R+UXjYe6R9+7he7SEJ85NAtGV4Qnmiw6Ui90mBo0Xar1zx4EVrBsEE
         FBcu1Ml61hAxbMKOXeP/PJqNJAPRrusqMH6yJi02VAyaKD81kgUpNxDlu2ErknpPutvV
         AlWmwSXPUWtO76afh1f1awiZSj+dlwVmnAJ6//xMPMC5Kzn/avxRmeD9cCt8FITjaaA4
         nGLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhUfqYPffyDx3RWtXcMHcMtX9vso6hEOSgnIrc1KaM3I0Zn4Dp7S93IVmJyW6t4eWnl917ngYFEfjeEAS5tD3RUIuKKmLof2LHMkPP0A==
X-Gm-Message-State: AOJu0YwDO7RhUunubQNmoMHplHaWmTTsxHpgr9hH9RnXwY7cYsR6OImy
	qE/Z3dD83qolJBaTv7lUo9u8X90TcoGpGeDcis8Dl0k6DTvPrAzRbmsSQZ7MtoyzaaBBDBUfo/E
	FYWEvX62Uap52ghzwrrIh+JT5MqQ=
X-Google-Smtp-Source: AGHT+IEfVR1JnMAHscvY1fWCLOOEGs4G86L/s2D/8NkD8WMpQgRXWxXW9dSpI7hf2duQRjABmX7rhihhIFyUb8Qkg8s=
X-Received: by 2002:a05:690c:6f84:b0:61a:b7c8:ea05 with SMTP id
 je4-20020a05690c6f8400b0061ab7c8ea05mr6507837ywb.35.1714219103780; Sat, 27
 Apr 2024 04:58:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425101556.573616-1-mszeredi@redhat.com>
In-Reply-To: <20240425101556.573616-1-mszeredi@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 27 Apr 2024 14:58:12 +0300
Message-ID: <CAOQ4uxgD3tTNKScRPD4r+ePuGkS5s2X2A3chMA1MXbfz-_P5PA@mail.gmail.com>
Subject: Re: [PATCH] ovl: implement tmpfile
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 1:16=E2=80=AFPM Miklos Szeredi <mszeredi@redhat.com=
> wrote:
>
> Combine inode creation with opening a file.
>
> There are six separate objects that are being set up: the backing inode,
> dentry and file and the overlay inode, dentry and file.  Cleanup in case =
of
> an error is a bit of a challenge and is difficult to test, so careful
> review is needed.

Did you try running the xfstests with the t_open_tmpfiles test program?
(generic/530 generic/531)
Note that those tests also run without O_TMPFILE support, so if you run
them you should verify that they do not fall back to unlinked files.

There are also a few tests that require O_TMPFILE support:
_require_xfs_io_command "-T"
(generic/004 generic/389 generic/509)

There are some tests in src/vfs/vfstest that run sgid tests
with O_TMPFILE if it is supported.
I identified generic/696 and generic/697, but only the latter
currently runs on overlayfs.


>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/backing-file.c            |  23 +++++++
>  fs/internal.h                |   3 +
>  fs/namei.c                   |   6 +-
>  fs/overlayfs/dir.c           | 130 +++++++++++++++++++++++++++++++++++
>  fs/overlayfs/file.c          |   3 -
>  fs/overlayfs/overlayfs.h     |   3 +
>  include/linux/backing-file.h |   4 ++
>  7 files changed, 166 insertions(+), 6 deletions(-)
>
> diff --git a/fs/backing-file.c b/fs/backing-file.c
> index 740185198db3..2dc3f7477d1d 100644
> --- a/fs/backing-file.c
> +++ b/fs/backing-file.c
> @@ -52,6 +52,29 @@ struct file *backing_file_open(const struct path *user=
_path, int flags,
>  }
>  EXPORT_SYMBOL_GPL(backing_file_open);
>
> +struct file *backing_tmpfile_open(const struct path *user_path, int flag=
s,
> +                                 struct mnt_idmap *real_idmap,
> +                                 const struct path *real_parentpath,
> +                                 umode_t mode, const struct cred *cred)
> +{
> +       struct file *f;
> +       int error;
> +
> +       f =3D alloc_empty_backing_file(flags, cred);
> +       if (IS_ERR(f))
> +               return f;
> +
> +       path_get(user_path);
> +       *backing_file_user_path(f) =3D *user_path;
> +       error =3D vfs_tmpfile(real_idmap, real_parentpath, f, mode);

We do not have a custom idmap in other backing_file helpers
don't see why we need real_idmap in this helper.
I think that should be:
mnt_idmap(real_parentpath.mnt)


> +       if (error) {
> +               fput(f);
> +               f =3D ERR_PTR(error);
> +       }
> +       return f;
> +}
> +EXPORT_SYMBOL(backing_tmpfile_open);
> +
>  struct backing_aio {
>         struct kiocb iocb;
>         refcount_t ref;
> diff --git a/fs/internal.h b/fs/internal.h
> index 7ca738904e34..ab2225136f60 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -62,6 +62,9 @@ int do_mkdirat(int dfd, struct filename *name, umode_t =
mode);
>  int do_symlinkat(struct filename *from, int newdfd, struct filename *to)=
;
>  int do_linkat(int olddfd, struct filename *old, int newdfd,
>                         struct filename *new, int flags);
> +int vfs_tmpfile(struct mnt_idmap *idmap,
> +               const struct path *parentpath,
> +               struct file *file, umode_t mode);
>
>  /*
>   * namespace.c
> diff --git a/fs/namei.c b/fs/namei.c
> index c5b2a25be7d0..13e50b0a49d2 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3668,9 +3668,9 @@ static int do_open(struct nameidata *nd,
>   * On non-idmapped mounts or if permission checking is to be performed o=
n the
>   * raw inode simply pass @nop_mnt_idmap.
>   */
> -static int vfs_tmpfile(struct mnt_idmap *idmap,
> -                      const struct path *parentpath,
> -                      struct file *file, umode_t mode)
> +int vfs_tmpfile(struct mnt_idmap *idmap,
> +               const struct path *parentpath,
> +               struct file *file, umode_t mode)
>  {
>         struct dentry *child;
>         struct inode *dir =3D d_inode(parentpath->dentry);
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 0f8b4a719237..91ac268986a9 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -14,6 +14,7 @@
>  #include <linux/posix_acl_xattr.h>
>  #include <linux/atomic.h>
>  #include <linux/ratelimit.h>
> +#include <linux/backing-file.h>
>  #include "overlayfs.h"
>
>  static unsigned short ovl_redirect_max =3D 256;
> @@ -1290,6 +1291,134 @@ static int ovl_rename(struct mnt_idmap *idmap, st=
ruct inode *olddir,
>         return err;
>  }
>
> +static int ovl_create_upper_tmpfile(struct file *file, struct dentry *de=
ntry,
> +                                   struct inode *inode, umode_t mode)
> +{
> +       struct ovl_inode_params oip;
> +       struct path realparentpath;
> +       struct file *realfile;
> +       /* It's okay to set O_NOATIME, since the owner will be current fs=
uid */
> +       int flags =3D file->f_flags | OVL_OPEN_FLAGS;
> +
> +       ovl_path_upper(dentry->d_parent, &realparentpath);
> +
> +       if (!IS_POSIXACL(d_inode(realparentpath.dentry)))
> +               mode &=3D ~current_umask();
> +
> +       realfile =3D backing_tmpfile_open(&file->f_path, flags,
> +                                       &nop_mnt_idmap, &realparentpath, =
mode,
> +                                       current_cred());

Using &nop_mnt_idmap here is not only unneeded but also looks wrong.

> +       if (IS_ERR(realfile))
> +               return PTR_ERR(realfile);
> +
> +       ovl_dentry_set_upper_alias(dentry);
> +       ovl_dentry_update_reval(dentry, realfile->f_path.dentry);
> +
> +       /* ovl_get_inode() consumes the .upperdentry reference on success=
 */
> +       oip =3D (struct ovl_inode_params) {
> +               .upperdentry =3D dget(realfile->f_path.dentry),
> +               .newinode =3D inode,
> +       };
> +
> +       inode =3D ovl_get_inode(dentry->d_sb, &oip);
> +       if (IS_ERR(inode))
> +               goto out_err;
> +
> +       /* d_tmpfile() expects inode to have a positive link count */
> +       set_nlink(inode, 1);
> +       d_tmpfile(file, inode);

Any reason not to reuse ovl_instantiate() to avoid duplicating some
of the subtlety? for example:

+       /* ovl_instantiate() consumes the .upperdentry reference on success=
 */
+       dget(realfile->f_path.dentry)
+       err =3D ovl_instantiate(dentry, inode, realfile->f_path.dentry, 0, =
1);
+       if (err)
+               goto out_err;

[...]

 static int ovl_instantiate(struct dentry *dentry, struct inode *inode,
-                          struct dentry *newdentry, bool hardlink)
+                          struct dentry *newdentry, bool hardlink,
bool tmpfile)
 {
        struct ovl_inode_params oip =3D {
                .upperdentry =3D newdentry,
@@ -295,6 +295,9 @@ static int ovl_instantiate(struct dentry *dentry,
struct inode *inode,
                inc_nlink(inode);
        }

+       if (tmpfile)
+               d_mark_tmpfile(dentry);
+
        d_instantiate(dentry, inode);


> +       file->private_data =3D realfile;
> +       return 0;
> +
> +out_err:
> +       dput(realfile->f_path.dentry);
> +       fput(realfile);
> +       return PTR_ERR(inode);
> +}
> +
> +static int ovl_create_tmpfile(struct file *file, struct dentry *dentry,
> +                             struct inode *inode, umode_t mode)
> +{
> +       int err;
> +       const struct cred *old_cred;
> +       struct cred *override_cred;
> +
> +       err =3D ovl_copy_up(dentry->d_parent);
> +       if (err)
> +               return err;
> +
> +       old_cred =3D ovl_override_creds(dentry->d_sb);
> +
> +       err =3D -ENOMEM;
> +       override_cred =3D prepare_creds();
> +       if (override_cred) {
> +               override_cred->fsuid =3D inode->i_uid;
> +               override_cred->fsgid =3D inode->i_gid;
> +               err =3D security_dentry_create_files_as(dentry, mode,
> +                                                     &dentry->d_name, ol=
d_cred,
> +                                                     override_cred);
> +               if (err) {
> +                       put_cred(override_cred);
> +                       goto out_revert_creds;
> +               }
> +               put_cred(override_creds(override_cred));
> +               put_cred(override_cred);
> +
> +               err =3D ovl_create_upper_tmpfile(file, dentry, inode, mod=
e);
> +       }
> +out_revert_creds:
> +       revert_creds(old_cred);
> +       return err;
> +}

This also shouts unneeded and subtle code duplication to me:

 static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
-                             struct ovl_cattr *attr, bool origin)
+                             struct ovl_cattr *attr, bool origin,
+                             struct file *tmpfile)
 {
        int err;
        const struct cred *old_cred;
@@ -602,7 +606,9 @@ static int ovl_create_or_link(struct dentry
*dentry, struct inode *inode,
                put_cred(override_cred);
        }

-       if (!ovl_dentry_is_whiteout(dentry))
+       if (tmpfile)
+               err =3D ovl_create_upper_tmpfile(tmpfile, dentry, inode,
attr->mode);
+       else if (!ovl_dentry_is_whiteout(dentry))
                err =3D ovl_create_upper(dentry, inode, attr);
        else
                err =3D ovl_create_over_whiteout(dentry, inode, attr);

> +
> +static int ovl_dummy_open(struct inode *inode, struct file *file)
> +{
> +       return 0;
> +}
> +
> +static int ovl_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
> +                      struct file *file, umode_t mode)
> +{
> +       int err;
> +       struct dentry *dentry =3D file->f_path.dentry;
> +       struct inode *inode;
> +
> +       err =3D ovl_want_write(dentry);
> +       if (err)
> +               return err;
> +
> +       err =3D -ENOMEM;
> +       inode =3D ovl_new_inode(dentry->d_sb, mode, 0);
> +       if (!inode)
> +               goto drop_write;
> +
> +       inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
> +       err =3D ovl_create_tmpfile(file, dentry, inode, inode->i_mode);
> +       if (err)
> +               goto put_inode;
> +
> +       /*
> +        * Check if the preallocated inode was actually used.  Having som=
ething
> +        * else assigned to the dentry shouldn't happen as that would ind=
icate
> +        * that the backing tmpfile "leaked" out of overlayfs.
> +        */
> +       err =3D -EIO;
> +       if (WARN_ON(inode !=3D d_inode(dentry)))
> +               goto put_realfile;
> +
> +       /* inode reference was transferred to dentry */
> +       inode =3D NULL;
> +       err =3D finish_open(file, dentry, ovl_dummy_open);
> +put_realfile:
> +       if (!(file->f_mode & FMODE_OPENED))
> +               fput(file->private_data);

This cleanup bit is very subtle and hard for me to review.
I wonder if there is a way to improve this subtlety?

Would it be possible to write this cleanup as:
+       if (err && file->private_data)
+               fput(file->private_data);

With a comment explaining where file->private_data is set?

Overall, I did not find any bugs, but I am hoping that the code could be
a bit easier to review and maintain.

Thanks,
Amir.

