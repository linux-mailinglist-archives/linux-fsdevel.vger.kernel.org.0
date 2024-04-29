Return-Path: <linux-fsdevel+bounces-18173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EF18B61AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 21:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 610D2285317
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1C213BC0B;
	Mon, 29 Apr 2024 19:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5Kux2z6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD1213B292;
	Mon, 29 Apr 2024 19:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714417649; cv=none; b=k1/IFoqpI3934V5N0UvTfEdMdQYLZ6V5YWUrJy94z/koEiwbDeDA6MhzyuOP4y84VaAiYIdPs1hEmAlZVnx3RHIWjady2R98pTDn8PhU2VvGDBfNocYdoU1ze3Fuwl/QW+OvqNyeRryQPGI8VkOs5IbngTF8Qz0B05K8O7CuciQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714417649; c=relaxed/simple;
	bh=l287cd4njOKmT6AA4KYcCQ6NSJ+333sG+ZFhLWqFwwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jr1f9d46aoy3nKAiZUCjQ+j/Pd6rAY165+W98DLoS0l2u3xM8YbPJ++pFWU67zKYLmoYYrBI1QlUDJvN35zwZ9QEIkfPMnCSh0xWgpZnkMFO7x+xp6E6bu6h2+lcamK8xrJnCRlc7JdBNuedhX5bsrhPsWp0GimFtu1g3tacgxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5Kux2z6; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c865f01b2bso964557b6e.1;
        Mon, 29 Apr 2024 12:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714417645; x=1715022445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yfq8fQBC1vOguGKElgOyuiJT5MSvv9BGfdbpn+E9Eig=;
        b=K5Kux2z6+dc4sqTLoALKmoEZQfVJjnNiX1tjKmPcXVeETleFW5pGhxEv/8vIDTgg4v
         lWdB9+IRbmRRlJ+eGnrbx9vm8upDn8wjWmhEdJj7qMF9RL4WWnTLK1bRV+SXgqCXxFA7
         BPSpqLpb+vPnzrTL8YtrC+6JXM9pRBTNWHj/CuASkR630vnDaacOCo4HvoZh4PuBFdFS
         2XGsC6fRo+ofWRFFiHU6VZvTTscAh8VCvFJvpX5Pe30v1dU61UaRudgOR3dTn4W1t10R
         hPvfpU1n+kp/fVpC5kQ9e/jQQV1bHpCNVyQsxKZXVWOxVhLtl6nwCXQ4HBfQXk5+HZYq
         6amg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714417645; x=1715022445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yfq8fQBC1vOguGKElgOyuiJT5MSvv9BGfdbpn+E9Eig=;
        b=vfKEWqqJQTbpK04QENx9n/KfItX1GKtIztC7b8Qfw5EeS2fk7lSqmbBTFhEzIa5/W0
         SljhoBoQ3IoITBWAmA1A9wrhkI976dFUWJHqFoCwTDbs98MfMzoQ953s86qWis0zENvj
         fz241XFoCXgeIv9w2SrumNuKvwuteFOAt5/w79B6FEnpwc6iEbhYm9Rr6cHqqdU2S26j
         iOgz8qRk1IWgdnoWRkEP3HjfFMMVDpng9iXJGGYHF4tOgDZgaGkg9S8P2eF9zOiLxv5e
         tTvO264dYwOhlyNGEdGDCp+JU6NqxO45uGmmqn+bMASWz77Q7bS/6yy4ETfb0L2WevgQ
         A9zQ==
X-Forwarded-Encrypted: i=1; AJvYcCWY3sn3XPn62smnwd3jMBIE2Jof6HP6bYd/W5qetnEFnVktzAdnqaAJLejAMl5ljltSjX+6Sj/8tI5DWF2VLu1lvitSjJtYsmeYZgu1Rg==
X-Gm-Message-State: AOJu0YzHF5g8Pzt+0VexDTtPmpKadZkTG28utYBmtn5MbJlPd3U6WbDz
	fbih0gB69G3JIDo9n8jF6NAR+du3gjNEc764lfFeg/6S0shIqcDg82QFZBR/e+8bKZZ362tZ+L6
	sKxBmYtpklRX/SCeJjCjNMbCSiDjhJzWo
X-Google-Smtp-Source: AGHT+IF8LlW9x/sPFnWg+ussaX6jewyVQBfQb0N7+Tenm58kWTVgksge3FThuK/TDc24Luh9Af8eoNjZibU0avXRsXs=
X-Received: by 2002:a05:6808:42:b0:3c8:4d1c:19fc with SMTP id
 v2-20020a056808004200b003c84d1c19fcmr783031oic.6.1714417645365; Mon, 29 Apr
 2024 12:07:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429132620.659012-1-mszeredi@redhat.com>
In-Reply-To: <20240429132620.659012-1-mszeredi@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 29 Apr 2024 22:07:14 +0300
Message-ID: <CAOQ4uxjn7OT5VF3xd=_XKCyohcemKth=t+oi1dYKNEkGd+Ofvg@mail.gmail.com>
Subject: Re: [PATCH v2] ovl: implement tmpfile
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 4:26=E2=80=AFPM Miklos Szeredi <mszeredi@redhat.com=
> wrote:
>
> Combine inode creation with opening a file.
>
> There are six separate objects that are being set up: the backing inode,
> dentry and file, and the overlay inode, dentry and file.  Cleanup in case
> of an error is a bit of a challenge and is difficult to test, so careful
> review is needed.
>
> All tmpfile testcases except generic/509 now run/pass, and no regressions
> are observed with full xfstests.
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

I have nothing queued in the overlayfs tree for 6.10 and no plans
of driving any ovl work for 6.10, so feel free to use the overlayfs-next
branch to queue this patch.

Thanks,
Amir.

> ---
> v2:
>   - don't pass real_idmap to backing_tmpfile_open()
>   - move ovl_dir_modified() from ovl_instantiate() to callers
>   - use ovl_instantiate() for tmpfile
>   - call d_mark_tmpfile() before d_instantiate() in ovl_instantiate();
>     no longer need to mess with nlink
>   - extract helper ovl_setup_cred_for_create() from ovl_create_or_link()
>   - don't apply umask to mode, VFS will do that when creating the tmpfile
>   - add comment above file->private_data cleanup
>
> ---
>  fs/backing-file.c            |  23 ++++++
>  fs/internal.h                |   3 +
>  fs/namei.c                   |   6 +-
>  fs/overlayfs/dir.c           | 145 ++++++++++++++++++++++++++++++-----
>  fs/overlayfs/file.c          |   3 -
>  fs/overlayfs/overlayfs.h     |   3 +
>  include/linux/backing-file.h |   3 +
>  7 files changed, 161 insertions(+), 25 deletions(-)
>
> diff --git a/fs/backing-file.c b/fs/backing-file.c
> index 740185198db3..afb557446c27 100644
> --- a/fs/backing-file.c
> +++ b/fs/backing-file.c
> @@ -52,6 +52,29 @@ struct file *backing_file_open(const struct path *user=
_path, int flags,
>  }
>  EXPORT_SYMBOL_GPL(backing_file_open);
>
> +struct file *backing_tmpfile_open(const struct path *user_path, int flag=
s,
> +                                 const struct path *real_parentpath,
> +                                 umode_t mode, const struct cred *cred)
> +{
> +       struct mnt_idmap *real_idmap =3D mnt_idmap(real_parentpath->mnt);
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
> index 0f8b4a719237..cac21ef546fe 100644
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
> @@ -260,14 +261,13 @@ static int ovl_set_opaque(struct dentry *dentry, st=
ruct dentry *upperdentry)
>   * may not use to instantiate the new dentry.
>   */
>  static int ovl_instantiate(struct dentry *dentry, struct inode *inode,
> -                          struct dentry *newdentry, bool hardlink)
> +                          struct dentry *newdentry, bool hardlink, struc=
t file *tmpfile)
>  {
>         struct ovl_inode_params oip =3D {
>                 .upperdentry =3D newdentry,
>                 .newinode =3D inode,
>         };
>
> -       ovl_dir_modified(dentry->d_parent, false);
>         ovl_dentry_set_upper_alias(dentry);
>         ovl_dentry_init_reval(dentry, newdentry, NULL);
>
> @@ -295,6 +295,9 @@ static int ovl_instantiate(struct dentry *dentry, str=
uct inode *inode,
>                 inc_nlink(inode);
>         }
>
> +       if (tmpfile)
> +               d_mark_tmpfile(tmpfile, inode);
> +
>         d_instantiate(dentry, inode);
>         if (inode !=3D oip.newinode) {
>                 pr_warn_ratelimited("newly created inode found in cache (=
%pd2)\n",
> @@ -345,7 +348,8 @@ static int ovl_create_upper(struct dentry *dentry, st=
ruct inode *inode,
>                 ovl_set_opaque(dentry, newdentry);
>         }
>
> -       err =3D ovl_instantiate(dentry, inode, newdentry, !!attr->hardlin=
k);
> +       ovl_dir_modified(dentry->d_parent, false);
> +       err =3D ovl_instantiate(dentry, inode, newdentry, !!attr->hardlin=
k, NULL);
>         if (err)
>                 goto out_cleanup;
>  out_unlock:
> @@ -529,7 +533,8 @@ static int ovl_create_over_whiteout(struct dentry *de=
ntry, struct inode *inode,
>                 if (err)
>                         goto out_cleanup;
>         }
> -       err =3D ovl_instantiate(dentry, inode, newdentry, hardlink);
> +       ovl_dir_modified(dentry->d_parent, false);
> +       err =3D ovl_instantiate(dentry, inode, newdentry, hardlink, NULL)=
;
>         if (err) {
>                 ovl_cleanup(ofs, udir, newdentry);
>                 dput(newdentry);
> @@ -551,12 +556,35 @@ static int ovl_create_over_whiteout(struct dentry *=
dentry, struct inode *inode,
>         goto out_dput;
>  }
>
> +static int ovl_setup_cred_for_create(struct dentry *dentry, struct inode=
 *inode,
> +                                    umode_t mode, const struct cred *old=
_cred)
> +{
> +       int err;
> +       struct cred *override_cred;
> +
> +       override_cred =3D prepare_creds();
> +       if (!override_cred)
> +               return -ENOMEM;
> +
> +       override_cred->fsuid =3D inode->i_uid;
> +       override_cred->fsgid =3D inode->i_gid;
> +       err =3D security_dentry_create_files_as(dentry, mode, &dentry->d_=
name,
> +                                             old_cred, override_cred);
> +       if (err) {
> +               put_cred(override_cred);
> +               return err;
> +       }
> +       put_cred(override_creds(override_cred));
> +       put_cred(override_cred);
> +
> +       return 0;
> +}
> +
>  static int ovl_create_or_link(struct dentry *dentry, struct inode *inode=
,
>                               struct ovl_cattr *attr, bool origin)
>  {
>         int err;
>         const struct cred *old_cred;
> -       struct cred *override_cred;
>         struct dentry *parent =3D dentry->d_parent;
>
>         old_cred =3D ovl_override_creds(dentry->d_sb);
> @@ -572,10 +600,6 @@ static int ovl_create_or_link(struct dentry *dentry,=
 struct inode *inode,
>         }
>
>         if (!attr->hardlink) {
> -               err =3D -ENOMEM;
> -               override_cred =3D prepare_creds();
> -               if (!override_cred)
> -                       goto out_revert_creds;
>                 /*
>                  * In the creation cases(create, mkdir, mknod, symlink),
>                  * ovl should transfer current's fs{u,g}id to underlying
> @@ -589,17 +613,9 @@ static int ovl_create_or_link(struct dentry *dentry,=
 struct inode *inode,
>                  * create a new inode, so just use the ovl mounter's
>                  * fs{u,g}id.
>                  */
> -               override_cred->fsuid =3D inode->i_uid;
> -               override_cred->fsgid =3D inode->i_gid;
> -               err =3D security_dentry_create_files_as(dentry,
> -                               attr->mode, &dentry->d_name, old_cred,
> -                               override_cred);
> -               if (err) {
> -                       put_cred(override_cred);
> +               err =3D ovl_setup_cred_for_create(dentry, inode, attr->mo=
de, old_cred);
> +               if (err)
>                         goto out_revert_creds;
> -               }
> -               put_cred(override_creds(override_cred));
> -               put_cred(override_cred);
>         }
>
>         if (!ovl_dentry_is_whiteout(dentry))
> @@ -1290,6 +1306,96 @@ static int ovl_rename(struct mnt_idmap *idmap, str=
uct inode *olddir,
>         return err;
>  }
>
> +static int ovl_create_tmpfile(struct file *file, struct dentry *dentry,
> +                             struct inode *inode, umode_t mode)
> +{
> +       const struct cred *old_cred;
> +       struct path realparentpath;
> +       struct file *realfile;
> +       struct dentry *newdentry;
> +       /* It's okay to set O_NOATIME, since the owner will be current fs=
uid */
> +       int flags =3D file->f_flags | OVL_OPEN_FLAGS;
> +       int err;
> +
> +       err =3D ovl_copy_up(dentry->d_parent);
> +       if (err)
> +               return err;
> +
> +       old_cred =3D ovl_override_creds(dentry->d_sb);
> +       err =3D ovl_setup_cred_for_create(dentry, inode, mode, old_cred);
> +       if (err)
> +               goto out_revert_creds;
> +
> +       ovl_path_upper(dentry->d_parent, &realparentpath);
> +       realfile =3D backing_tmpfile_open(&file->f_path, flags, &realpare=
ntpath,
> +                                       mode, current_cred());
> +       err =3D PTR_ERR(realfile);
> +       if (IS_ERR(realfile))
> +               goto out_revert_creds;
> +
> +       /* ovl_instantiate() consumes the newdentry reference on success =
*/
> +       newdentry =3D dget(realfile->f_path.dentry);
> +       err =3D ovl_instantiate(dentry, inode, newdentry, false, file);
> +       if (!err) {
> +               file->private_data =3D realfile;
> +       } else {
> +               dput(newdentry);
> +               fput(realfile);
> +       }
> +out_revert_creds:
> +       revert_creds(old_cred);
> +       return err;
> +}
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
> +       /* Without FMODE_OPENED ->release() won't be called on @file */
> +       if (!(file->f_mode & FMODE_OPENED))
> +               fput(file->private_data);
> +put_inode:
> +       iput(inode);
> +drop_write:
> +       ovl_drop_write(dentry);
> +       return err;
> +}
> +
>  const struct inode_operations ovl_dir_inode_operations =3D {
>         .lookup         =3D ovl_lookup,
>         .mkdir          =3D ovl_mkdir,
> @@ -1310,4 +1416,5 @@ const struct inode_operations ovl_dir_inode_operati=
ons =3D {
>         .update_time    =3D ovl_update_time,
>         .fileattr_get   =3D ovl_fileattr_get,
>         .fileattr_set   =3D ovl_fileattr_set,
> +       .tmpfile        =3D ovl_tmpfile,
>  };
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index 05536964d37f..1a411cae57ed 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -24,9 +24,6 @@ static char ovl_whatisit(struct inode *inode, struct in=
ode *realinode)
>                 return 'm';
>  }
>
> -/* No atime modification on underlying */
> -#define OVL_OPEN_FLAGS (O_NOATIME)
> -
>  static struct file *ovl_open_realfile(const struct file *file,
>                                       const struct path *realpath)
>  {
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index ee949f3e7c77..0bfe35da4b7b 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -175,6 +175,9 @@ static inline int ovl_metadata_digest_size(const stru=
ct ovl_metacopy *metacopy)
>         return (int)metacopy->len - OVL_METACOPY_MIN_SIZE;
>  }
>
> +/* No atime modification on underlying */
> +#define OVL_OPEN_FLAGS (O_NOATIME)
> +
>  extern const char *const ovl_xattr_table[][2];
>  static inline const char *ovl_xattr(struct ovl_fs *ofs, enum ovl_xattr o=
x)
>  {
> diff --git a/include/linux/backing-file.h b/include/linux/backing-file.h
> index 3f1fe1774f1b..4b61b0e57720 100644
> --- a/include/linux/backing-file.h
> +++ b/include/linux/backing-file.h
> @@ -22,6 +22,9 @@ struct backing_file_ctx {
>  struct file *backing_file_open(const struct path *user_path, int flags,
>                                const struct path *real_path,
>                                const struct cred *cred);
> +struct file *backing_tmpfile_open(const struct path *user_path, int flag=
s,
> +                                 const struct path *real_parentpath,
> +                                 umode_t mode, const struct cred *cred);
>  ssize_t backing_file_read_iter(struct file *file, struct iov_iter *iter,
>                                struct kiocb *iocb, int flags,
>                                struct backing_file_ctx *ctx);
> --
> 2.44.0
>

