Return-Path: <linux-fsdevel+bounces-62945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51999BA7051
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Sep 2025 14:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1D233B8846
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Sep 2025 12:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B43271A71;
	Sun, 28 Sep 2025 12:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6SfkVjd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26277260A
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Sep 2025 12:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759061168; cv=none; b=AK9BWZ3Izv39QHbkUJxS2+WYNIBo3E85g8YsxuDGgf/bNbZwu8EqW1isIx1/Zk2Og1JUNfNEzEJZ8rrafujhu6+djm9AxlpvuRQUKUWYRG2dpQxyuXD+fkLHwCEgXh5+g19wKIB0+z/nAkhvMuFzEY8JVGF4z1dfN8f2BCDK1wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759061168; c=relaxed/simple;
	bh=8zk6wRu+r7ljfpwSGGsUZVuiVwvDzjXewo7wCIT59vs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d18SMTJmr86ZPqiKwfcZ1/W1TC6bPDzdZDsvb3+X/7FSl50ZnzY+njAYmnPlydZKRPasqQIR1NVpZQyEd0X2nrRfFbd9jCZ6vPr/nnp/CE/L7yQIRqeMxcnBNspqKCRTQwg3Yy/AmnRNjW1PQPn3SvuAVa8f1AhanDEr1O4lpNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6SfkVjd; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-62fc14af3fbso4698190a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Sep 2025 05:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759061165; x=1759665965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ow5wX4SR2uw3EJvsEbLl6mp845LXcjIP7U8ttzCl3lQ=;
        b=m6SfkVjdOEdZruUttVyW1X5ZIMO4hIrUaY/Y3QrHDUnQr9XBbNK831Hd1TI2RfuDpT
         1w6GI0S8GcDuk2wVRVl7uk76oDoiy/H2Z0Pg4ybRx0f+FIRGE6ZmZwrBwEF3GRHEgXgG
         HVkDNeCiNodzbvmZjEk7Kl5Vdn7/QEgieaKZmflY6P35MSfLz4IM7Q0iGPau3PKdHimI
         isAGBVba1aR0SRKvMW81qhhYHjfVPu9kt/u77Xp5cdVmfevmDVFclAWkF7BFXfApl2+9
         PTuUiB2TbIUntP9z1uvtLfGJ/RriT08Wa9b/n7s88pxp1MJv5OC0T9wj5H4qanELWdpc
         r05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759061165; x=1759665965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ow5wX4SR2uw3EJvsEbLl6mp845LXcjIP7U8ttzCl3lQ=;
        b=bpXBZC8QaE1ZtmaCGR4cmmTvX/xEmQ78ibHAWDWzXRJq18p4Knw2cxpaUbvQHpgWko
         XUPMUIL7a1Ro3wFPRjoSbzmhug+MpC5KKFFWJazm2gl1G2M+FYP4Uq3jBRiWFzT2Qayq
         oNhhASKHjq2WAWR26CFp6CQr/9jLy9MfspjbUUjkWz1P+4KqsXNQF43+Ef3N3atJaaQR
         wxnKldiwcMfNlBYmXUa8dQlUxLqYdliR+JSR4O8nFN8CGkVNlCM27/qkpq0AqXnqUnil
         AgE+FGO1TskMzAhGMOZ50qdVbftjKvPrDd56ONa6RlpKZvsf71bOFOfjxB6geqNj7YqQ
         L1zg==
X-Forwarded-Encrypted: i=1; AJvYcCUimNrVu2nw6UHUGKZ8UeKhKTRJNkvfMZtYoBZwqb/cm+dnrDLTSknmPNhajHREE4sJpGuruKI3fC1cTaQD@vger.kernel.org
X-Gm-Message-State: AOJu0YyDiUGNicfmqX1KIJZBU5Qok28TinH8VhYTf3TlvS1LHBSropBh
	uDyw32zbVq6eAa8XBeHICm4fxs4OR26fcs+qW+YtKgWyhhn02R4zCaiZvGIYPl+fncjgyCtqaru
	aisOVFaWzk2G0GAxLhtEd5+poP79sizgaFF3GHB0=
X-Gm-Gg: ASbGncuDGGLQ8F+ux6A3JfNrOP843j2h43ocCaw64ZSCwZHyZIxkplRa/qNPIlvPNEq
	u0p2gj/lC0xBXTf2iBjsgvkj0QlcSb0YMl9JzdH/c3aBj8wWhyg9iwSrhGXH1ml8j+niGIiF7L0
	Vw1PENzts3Qf5f86+EWWxs3ubXzFrWPjFyohj7+RBQOxat07IAf6fKjRPAEmL27y5TMJYg9sfo3
	u5r5Kpi7gkYVLFBNZdwv6r26F9PJe3bBFgG5pNciU8E/oPlOQNLH/u9v5DXm04=
X-Google-Smtp-Source: AGHT+IG1fxu377+eMVU1kVTM+FKzAWvQKEo23k2k7xisV+0bCAEXXBSoFO5CkMhvkmFsU3uXGMxIZjTdrAThA3BZ+FQ=
X-Received: by 2002:a05:6402:3552:b0:634:5371:d713 with SMTP id
 4fb4d7f45d1cf-6349fcaf2b0mr12472793a12.14.1759061164850; Sun, 28 Sep 2025
 05:06:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926025015.1747294-1-neilb@ownmail.net> <20250926025015.1747294-8-neilb@ownmail.net>
In-Reply-To: <20250926025015.1747294-8-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 28 Sep 2025 14:05:53 +0200
X-Gm-Features: AS18NWDDinZMYz26BZDeKiDpeReUOvAK9mdesGFHk6nRpApqqmYeEbbFkkwTsPg
Message-ID: <CAOQ4uxhb-fKixuGz-XS09qktVmm5DwK6oUf8ufV_vqKiA2YPww@mail.gmail.com>
Subject: Re: [PATCH 07/11] VFS: add start_creating_killable() and start_removing_killable()
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 4:51=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
>
> From: NeilBrown <neil@brown.name>
>
> These are similar to start_creating() and start_removing(), but allow a
> fatal signal to abort waiting for the lock.
>
> They are used in btrfs for subvol creation and removal.
>
> btrfs_may_create() no longer needs IS_DEADDIR() and
> start_creating_killable() includes that check.

TBH, I think there is not much to gain from this removal
and now the comment
/* copy of may_create in fs/namei.c() */
is less accurate, so I would not change btrfs_may_create()

>
> Signed-off-by: NeilBrown <neil@brown.name>

Apart from that and the other comment below, the callers look good
so you may add:
Reviewed-by: Amir Goldstein <amir73il@gmail.com>


> ---
>  fs/btrfs/ioctl.c      | 43 +++++++----------------
>  fs/namei.c            | 80 +++++++++++++++++++++++++++++++++++++++++--
>  include/linux/namei.h |  6 ++++
>  3 files changed, 95 insertions(+), 34 deletions(-)
>
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 7e13de2bdcbf..3a007f59f7f2 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -880,8 +880,6 @@ static inline int btrfs_may_create(struct mnt_idmap *=
idmap,
>  {
>         if (d_really_is_positive(child))
>                 return -EEXIST;
> -       if (IS_DEADDIR(dir))
> -               return -ENOENT;
>         if (!fsuidgid_has_mapping(dir->i_sb, idmap))
>                 return -EOVERFLOW;
>         return inode_permission(idmap, dir, MAY_WRITE | MAY_EXEC);
> @@ -904,14 +902,9 @@ static noinline int btrfs_mksubvol(struct dentry *pa=
rent,
>         struct fscrypt_str name_str =3D FSTR_INIT((char *)qname->name, qn=
ame->len);
>         int ret;
>
> -       ret =3D down_write_killable_nested(&dir->i_rwsem, I_MUTEX_PARENT)=
;
> -       if (ret =3D=3D -EINTR)
> -               return ret;
> -
> -       dentry =3D lookup_one(idmap, qname, parent);
> -       ret =3D PTR_ERR(dentry);
> +       dentry =3D start_creating_killable(idmap, parent, qname);
>         if (IS_ERR(dentry))
> -               goto out_unlock;
> +               return PTR_ERR(dentry);
>
>         ret =3D btrfs_may_create(idmap, dir, dentry);
>         if (ret)
> @@ -940,9 +933,7 @@ static noinline int btrfs_mksubvol(struct dentry *par=
ent,
>  out_up_read:
>         up_read(&fs_info->subvol_sem);
>  out_dput:
> -       dput(dentry);
> -out_unlock:
> -       btrfs_inode_unlock(BTRFS_I(dir), 0);
> +       end_creating(dentry, parent);
>         return ret;
>  }
>
> @@ -2417,18 +2408,10 @@ static noinline int btrfs_ioctl_snap_destroy(stru=
ct file *file,
>                 goto free_subvol_name;
>         }
>
> -       ret =3D down_write_killable_nested(&dir->i_rwsem, I_MUTEX_PARENT)=
;
> -       if (ret =3D=3D -EINTR)
> -               goto free_subvol_name;
> -       dentry =3D lookup_one(idmap, &QSTR(subvol_name), parent);
> +       dentry =3D start_removing_killable(idmap, parent, &QSTR(subvol_na=
me));
>         if (IS_ERR(dentry)) {
>                 ret =3D PTR_ERR(dentry);
> -               goto out_unlock_dir;
> -       }
> -
> -       if (d_really_is_negative(dentry)) {
> -               ret =3D -ENOENT;
> -               goto out_dput;
> +               goto out_end_removing;
>         }
>
>         inode =3D d_inode(dentry);
> @@ -2449,7 +2432,7 @@ static noinline int btrfs_ioctl_snap_destroy(struct=
 file *file,
>                  */
>                 ret =3D -EPERM;
>                 if (!btrfs_test_opt(fs_info, USER_SUBVOL_RM_ALLOWED))
> -                       goto out_dput;
> +                       goto out_end_removing;
>
>                 /*
>                  * Do not allow deletion if the parent dir is the same
> @@ -2460,21 +2443,21 @@ static noinline int btrfs_ioctl_snap_destroy(stru=
ct file *file,
>                  */
>                 ret =3D -EINVAL;
>                 if (root =3D=3D dest)
> -                       goto out_dput;
> +                       goto out_end_removing;
>
>                 ret =3D inode_permission(idmap, inode, MAY_WRITE | MAY_EX=
EC);
>                 if (ret)
> -                       goto out_dput;
> +                       goto out_end_removing;
>         }
>
>         /* check if subvolume may be deleted by a user */
>         ret =3D btrfs_may_delete(idmap, dir, dentry, 1);
>         if (ret)
> -               goto out_dput;
> +               goto out_end_removing;
>
>         if (btrfs_ino(BTRFS_I(inode)) !=3D BTRFS_FIRST_FREE_OBJECTID) {
>                 ret =3D -EINVAL;
> -               goto out_dput;
> +               goto out_end_removing;
>         }
>
>         btrfs_inode_lock(BTRFS_I(inode), 0);
> @@ -2483,10 +2466,8 @@ static noinline int btrfs_ioctl_snap_destroy(struc=
t file *file,
>         if (!ret)
>                 d_delete_notify(dir, dentry);
>
> -out_dput:
> -       dput(dentry);
> -out_unlock_dir:
> -       btrfs_inode_unlock(BTRFS_I(dir), 0);
> +out_end_removing:
> +       end_removing(dentry);
>  free_subvol_name:
>         kfree(subvol_name_ptr);
>  free_parent:
> diff --git a/fs/namei.c b/fs/namei.c
> index cb4d40af12ae..f5c96f801b74 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2778,19 +2778,33 @@ static int filename_parentat(int dfd, struct file=
name *name,
>   * Returns: a locked dentry, or an error.
>   *
>   */
> -struct dentry *start_dirop(struct dentry *parent, struct qstr *name,
> -                          unsigned int lookup_flags)
> +static struct dentry *__start_dirop(struct dentry *parent, struct qstr *=
name,
> +                                   unsigned int lookup_flags,
> +                                   unsigned int state)
>  {
>         struct dentry *dentry;
>         struct inode *dir =3D d_inode(parent);
>
> -       inode_lock_nested(dir, I_MUTEX_PARENT);
> +       if (state =3D=3D TASK_KILLABLE) {
> +               int ret =3D down_write_killable_nested(&dir->i_rwsem,
> +                                                    I_MUTEX_PARENT);
> +               if (ret)
> +                       return ERR_PTR(ret);
> +       } else {
> +               inode_lock_nested(dir, I_MUTEX_PARENT);
> +       }

IIRC, Al is not fond of helpers that lock conditionally
(or conditionally killable).
Unless you plan to have many other uses to __start_dirop()
the compiler is likely to inline 3 copies of __start_dirop(), so
a variant start_dirop_killable() without the conditional may make
more sense here.

Thanks,
Amir.

>         dentry =3D lookup_one_qstr_excl(name, parent, lookup_flags);
>         if (IS_ERR(dentry))
>                 inode_unlock(dir);
>         return dentry;
>  }
>
> +struct dentry *start_dirop(struct dentry *parent, struct qstr *name,
> +                          unsigned int lookup_flags)
> +{
> +       return __start_dirop(parent, name, lookup_flags, TASK_NORMAL);
> +}
> +
>  /**
>   * end_dirop - signal completion of a dirop
>   * @de - the dentry which was returned by start_dirop or similar.
> @@ -3296,6 +3310,66 @@ struct dentry *start_removing(struct mnt_idmap *id=
map, struct dentry *parent,
>  }
>  EXPORT_SYMBOL(start_removing);
>
> +/**
> + * start_creating_killable - prepare to create a given name with permiss=
ion checking
> + * @idmap - idmap of the mount
> + * @parent - directory in which to prepare to create the name
> + * @name - the name to be created
> + *
> + * Locks are taken and a lookup in performed prior to creating
> + * an object in a directory.  Permission checking (MAY_EXEC) is performe=
d
> + * against @idmap.
> + *
> + * If the name already exists, a positive dentry is returned.
> + *
> + * If a signal is received or was already pending, the function aborts
> + * with -EINTR;
> + *
> + * Returns: a negative or positive dentry, or an error.
> + */
> +struct dentry *start_creating_killable(struct mnt_idmap *idmap,
> +                                      struct dentry *parent,
> +                                      struct qstr *name)
> +{
> +       int err =3D lookup_one_common(idmap, name, parent);
> +
> +       if (err)
> +               return ERR_PTR(err);
> +       return __start_dirop(parent, name, LOOKUP_CREATE, TASK_KILLABLE);
> +}
> +EXPORT_SYMBOL(start_creating_killable);
> +
> +/**
> + * start_removing_killable - prepare to remove a given name with permiss=
ion checking
> + * @idmap - idmap of the mount
> + * @parent - directory in which to find the name
> + * @name - the name to be removed
> + *
> + * Locks are taken and a lookup in performed prior to removing
> + * an object from a directory.  Permission checking (MAY_EXEC) is perfor=
med
> + * against @idmap.
> + *
> + * If the name doesn't exist, an error is returned.
> + *
> + * end_removing() should be called when removal is complete, or aborted.
> + *
> + * If a signal is received or was already pending, the function aborts
> + * with -EINTR;
> + *
> + * Returns: a positive dentry, or an error.
> + */
> +struct dentry *start_removing_killable(struct mnt_idmap *idmap,
> +                                      struct dentry *parent,
> +                                      struct qstr *name)
> +{
> +       int err =3D lookup_one_common(idmap, name, parent);
> +
> +       if (err)
> +               return ERR_PTR(err);
> +       return __start_dirop(parent, name, 0, TASK_KILLABLE);
> +}
> +EXPORT_SYMBOL(start_removing_killable);
> +
>  /**
>   * start_creating_noperm - prepare to create a given name without permis=
sion checking
>   * @parent - directory in which to prepare to create the name
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index 32a007f1043e..9771ec940b72 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -92,6 +92,12 @@ struct dentry *start_creating(struct mnt_idmap *idmap,=
 struct dentry *parent,
>                               struct qstr *name);
>  struct dentry *start_removing(struct mnt_idmap *idmap, struct dentry *pa=
rent,
>                               struct qstr *name);
> +struct dentry *start_creating_killable(struct mnt_idmap *idmap,
> +                                      struct dentry *parent,
> +                                      struct qstr *name);
> +struct dentry *start_removing_killable(struct mnt_idmap *idmap,
> +                                      struct dentry *parent,
> +                                      struct qstr *name);
>  struct dentry *start_creating_noperm(struct dentry *parent, struct qstr =
*name);
>  struct dentry *start_removing_noperm(struct dentry *parent, struct qstr =
*name);
>  struct dentry *start_removing_dentry(struct dentry *parent,
> --
> 2.50.0.107.gf914562f5916.dirty
>

