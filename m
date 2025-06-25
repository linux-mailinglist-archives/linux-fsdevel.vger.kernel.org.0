Return-Path: <linux-fsdevel+bounces-52927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C69ADAE887E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 17:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00F2568068B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 15:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876D0142E83;
	Wed, 25 Jun 2025 15:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1pw25xC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8B1267721;
	Wed, 25 Jun 2025 15:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750866281; cv=none; b=m3AREQ7g8R/j87l5xgpPEyAOGgVobO7iDm9ut8i7cjx6sP34QuO6bn2vXZac86bf90eMuLU6oWcO3iXg5HC1PE9aVupCXH20giH0Rr81vFEf+eAjyks5GmeOLiWje9kmDfpIemyFf9C6tEewMR2rHLT597jkxWWDqLisG/HN+dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750866281; c=relaxed/simple;
	bh=jVcitCmIG9OFAAkzgWCUh6R0EUafgcwkNbACsW/PsU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g21EhXx8vwAKYe05ZOn4Lov73I5h1ccFIP/iZgIVdBIG2HxB1RnHqbucthmQZXe6efe3fXO2MkMjTxImCjiI9VNgYWTXd7Vxe7JScGYPTfaxJ2MbHslPUu14pJdS4jdRvkybLT1FugoxrTVt/g55AKjOdpbrjn1vH/QpBAttNyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1pw25xC; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-60768f080d8so11687901a12.1;
        Wed, 25 Jun 2025 08:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750866275; x=1751471075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vUmJJAmhqGBQfI6N/dyOtxWj3ElGK7yuWXaDsisufE=;
        b=N1pw25xC5CEG+n0HbCjEI+TzhhTi+aFUNvfpxPmMKYyQF6RQCY2r6XZsNP5mfMsCpd
         kZwj10f8D1qw5ThGOfKa0b2z2LyvDPDgr9rB5af4uufFpMS4/8fxCuKKjjblnCxwcATD
         QMWNvv69KTsr7bUP/NLQ6S4MtbZCVteBtAStFC88C+liHzFZZUFoLfqndMqojoWV2DGr
         OjmS/P8xVMXeq5hOHfiVI/oRzXzCzDgeWDKOOjrL+RKdsXtFinxVgsa3VR0IdLw+HLd/
         fkUS7T1sPEqgaksSxp4Ua3ZfxipSIQDd+VjMt40NymDnvnkdNxjx9BB660kBwWnV0UEq
         u6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750866275; x=1751471075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9vUmJJAmhqGBQfI6N/dyOtxWj3ElGK7yuWXaDsisufE=;
        b=DBhbmF9NDdU6xooM4xwShmWI/hK7oJeeQYIOU16ac7n+meuC+aMW64AOvuoS+J0IF4
         AFO4zVoFgvfbjVFqXoEoNLpqdPZKOQIvNsNjGVVcR3hmDxrL0zpwMSyRpXo7vxI8guaB
         KM1NMl7xptGFv9Rwq9nb6kiuss93z2wwmCIPaPVXuCztVJy3sxxjUNuGf3ekCk/eOeup
         2GzMA8DNthu6VUKNwtIrN+ml+Yfe3xSXm8vnltd1QoIyQarRf85Ub5MqVxmsB0/zn8KF
         YFKOqkFTHYeVe6jXr+b8rlvnOy+tgyMKvsl0ywsRel43eLl900YZX3POWCFal6GHZXcK
         gkJQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0huL29+3hrAsbOG7lvHX4R0oSx4p+YM1OL4E1ORPo32/GpN/J+DKeZERMFph19J9F96GXxVFwJd0plR8g@vger.kernel.org, AJvYcCX5Adj+7IlKou5TnQTwjZWaaqVRqGOsTHZEZEnjF3alQgQhWEMX3nBh3Hd87msoSlNIG2paNr9z4tY6y/Cipg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdbxupEf1+mTjcUWIwatXeSrt1qtZ416ZTS6yzsfnyT1pbQFMK
	Y/Qu7fZx2Q2SulTto/bU6ZEsl1qszAFrdh8F+pyamzquQu1Se1UnVo3eRCNL8UbSqcfuUe+Kr38
	HXuMz6rSaET9FTSNB+BSfxqqHgXd0VLU=
X-Gm-Gg: ASbGncu0yQpkOJrLZg11sEML3WWbcGWVgpAQILFz63QbEPD1PfSIipkjGThtxcOc8Ja
	+qyEiXLlOsXcnCF5qKNgdnZRUaUj95Ook6FSK6L0Px+KAdIVk1rfUOT7884o0ExgZoP6B6r69ZZ
	4DGAK1P6IoonMOSBkgh1UJRdhABOIyHAPrRlOXxxigKpc=
X-Google-Smtp-Source: AGHT+IGMmMtl4ZvF5PbNQSE/m5LXCVZxbZOMP/SErwDzaF9MkOf1D3SRIUXAaNUMJ3BF3rdUVM7VHSmIMUtuuAZDdyM=
X-Received: by 2002:a17:907:3faa:b0:ad8:a935:b905 with SMTP id
 a640c23a62f3a-ae0be861637mr340358566b.22.1750866274660; Wed, 25 Jun 2025
 08:44:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624230636.3233059-1-neil@brown.name> <20250624230636.3233059-3-neil@brown.name>
In-Reply-To: <20250624230636.3233059-3-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 25 Jun 2025 17:44:23 +0200
X-Gm-Features: Ac12FXzYWAzT1DUNlveoJudUxySFtxqMK9fvg7WpOJSmhvmX6v-Vm4EufBws3do
Message-ID: <CAOQ4uxjzZGK6fw9=dFiC8kZCUtA7NVQVE_Sa2wdHLZ9ZD7upgA@mail.gmail.com>
Subject: Re: [PATCH 02/12] ovl: Call ovl_create_temp() and ovl_create_index()
 without lock held.
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 1:07=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> ovl currently locks a directory or two and then performs multiple actions
> in one or both directories.  This is incompatible with proposed changes
> which will lock just the dentry of objects being acted on.
>
> This patch moves calls to ovl_create_temp() and ovl_create_index() out
> of the locked region and has them take and release the relevant lock
> themselves.
>
> The lock that was taken before these functions are called is now taken
> after.  This means that any code between where the lock was taken and
> these calls is now unlocked.  This necessitates the creation of
> _unlocked() versions of ovl_cleanup() and ovl_lookup_upper().  These
> will be used more widely in future patches.
>
> ovl_cleanup_unlocked() takes a dentry for the directory rather than an
> inode as this simplifies calling slightly.
>
> Note that when we move a lookup or create out of a locked region in
> which the dentry is acted on, we need to ensure after taking the lock
> that the dentry is still in the directory we expect it to be in.  It is
> conceivable that it was moved.
>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/overlayfs/copy_up.c   | 37 +++++++++++-------
>  fs/overlayfs/dir.c       | 84 +++++++++++++++++++++++++---------------
>  fs/overlayfs/overlayfs.h | 10 +++++
>  fs/overlayfs/super.c     |  7 ++--
>  4 files changed, 88 insertions(+), 50 deletions(-)
>
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index 8a3c0d18ec2e..7a21ad1f2b6e 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -517,15 +517,12 @@ static int ovl_set_upper_fh(struct ovl_fs *ofs, str=
uct dentry *upper,
>
>  /*
>   * Create and install index entry.
> - *
> - * Caller must hold i_mutex on indexdir.
>   */
>  static int ovl_create_index(struct dentry *dentry, const struct ovl_fh *=
fh,
>                             struct dentry *upper)
>  {
>         struct ovl_fs *ofs =3D OVL_FS(dentry->d_sb);
>         struct dentry *indexdir =3D ovl_indexdir(dentry->d_sb);
> -       struct inode *dir =3D d_inode(indexdir);
>         struct dentry *index =3D NULL;
>         struct dentry *temp =3D NULL;
>         struct qstr name =3D { };
> @@ -558,17 +555,21 @@ static int ovl_create_index(struct dentry *dentry, =
const struct ovl_fh *fh,
>         err =3D ovl_set_upper_fh(ofs, upper, temp);
>         if (err)
>                 goto out;
> -
> +       lock_rename(indexdir, indexdir);

This is a really strange hack.
I assume your next patch set is going to remove this call, but I do not wis=
h
to merge this hack as is for an unknown period of time.

Please introduce helpers {un,}lock_parent()

>         index =3D ovl_lookup_upper(ofs, name.name, indexdir, name.len);
>         if (IS_ERR(index)) {
>                 err =3D PTR_ERR(index);
> +       } else if (temp->d_parent !=3D indexdir) {
> +               err =3D -EINVAL;
> +               dput(index);

This can be inside lock_parent(parent, child)
where child is an optional arg.

err =3D lock_parent(indexdir, temp);
if (err)
       goto out;

Because we should be checking this right after lock and
not after ovl_lookup_upper().

>         } else {
>                 err =3D ovl_do_rename(ofs, indexdir, temp, indexdir, inde=
x, 0);
>                 dput(index);
>         }
> +       unlock_rename(indexdir, indexdir);
>  out:
>         if (err)
> -               ovl_cleanup(ofs, dir, temp);
> +               ovl_cleanup_unlocked(ofs, indexdir, temp);
>         dput(temp);
>  free_name:
>         kfree(name.name);
> @@ -779,9 +780,7 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx=
 *c)
>                 return err;
>
>         ovl_start_write(c->dentry);
> -       inode_lock(wdir);
>         temp =3D ovl_create_temp(ofs, c->workdir, &cattr);
> -       inode_unlock(wdir);
>         ovl_end_write(c->dentry);
>         ovl_revert_cu_creds(&cc);
>
> @@ -794,6 +793,8 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx=
 *c)
>          */
>         path.dentry =3D temp;
>         err =3D ovl_copy_up_data(c, &path);
> +       if (err)
> +               goto cleanup_write_unlocked;
>         /*
>          * We cannot hold lock_rename() throughout this helper, because o=
f
>          * lock ordering with sb_writers, which shouldn't be held when ca=
lling
> @@ -801,6 +802,13 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ct=
x *c)
>          * temp wasn't moved before copy up completion or cleanup.
>          */
>         ovl_start_write(c->dentry);
> +
> +       if (S_ISDIR(c->stat.mode) && c->indexed) {
> +               err =3D ovl_create_index(c->dentry, c->origin_fh, temp);
> +               if (err)
> +                       goto cleanup_unlocked;
> +       }
> +
>         trap =3D lock_rename(c->workdir, c->destdir);
>         if (trap || temp->d_parent !=3D c->workdir) {
>                 /* temp or workdir moved underneath us? abort without cle=
anup */
> @@ -809,20 +817,12 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_c=
tx *c)
>                 if (IS_ERR(trap))
>                         goto out;
>                 goto unlock;
> -       } else if (err) {
> -               goto cleanup;
>         }
>
>         err =3D ovl_copy_up_metadata(c, temp);
>         if (err)
>                 goto cleanup;
>
> -       if (S_ISDIR(c->stat.mode) && c->indexed) {
> -               err =3D ovl_create_index(c->dentry, c->origin_fh, temp);
> -               if (err)
> -                       goto cleanup;
> -       }
> -
>         upper =3D ovl_lookup_upper(ofs, c->destname.name, c->destdir,
>                                  c->destname.len);
>         err =3D PTR_ERR(upper);
> @@ -857,6 +857,13 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ct=
x *c)
>         ovl_cleanup(ofs, wdir, temp);
>         dput(temp);
>         goto unlock;
> +
> +cleanup_write_unlocked:
> +       ovl_start_write(c->dentry);
> +cleanup_unlocked:
> +       ovl_cleanup_unlocked(ofs, c->workdir, temp);
> +       dput(temp);
> +       goto out;
>  }

Wow these various cleanup flows are quite hard to follow.
This is a massive patch set which is very hard for me to review
and it will also be hard for me to maintain the code as it is.
We need to figure out a way to simplify the code flow
either more re-factoring or using some scoped cleanup hooks.
I am open to suggestions.

Thanks,
Amir.

>
>  /* Copyup using O_TMPFILE which does not require cross dir locking */
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 4fc221ea6480..a51a3dc02bf5 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -43,6 +43,21 @@ int ovl_cleanup(struct ovl_fs *ofs, struct inode *wdir=
, struct dentry *wdentry)
>         return err;
>  }
>
> +int ovl_cleanup_unlocked(struct ovl_fs *ofs, struct dentry *workdir,
> +                        struct dentry *wdentry)
> +{
> +       int err;
> +
> +       inode_lock_nested(workdir->d_inode, I_MUTEX_PARENT);
> +       if (wdentry->d_parent =3D=3D workdir)
> +               ovl_cleanup(ofs, workdir->d_inode, wdentry);
> +       else
> +               err =3D -EINVAL;
> +       inode_unlock(workdir->d_inode);
> +
> +       return err;
> +}
> +
>  struct dentry *ovl_lookup_temp(struct ovl_fs *ofs, struct dentry *workdi=
r)
>  {
>         struct dentry *temp;
> @@ -199,8 +214,12 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, s=
truct inode *dir,
>  struct dentry *ovl_create_temp(struct ovl_fs *ofs, struct dentry *workdi=
r,
>                                struct ovl_cattr *attr)
>  {
> -       return ovl_create_real(ofs, d_inode(workdir),
> -                              ovl_lookup_temp(ofs, workdir), attr);
> +       struct dentry *ret;
> +       inode_lock(workdir->d_inode);
> +       ret =3D ovl_create_real(ofs, d_inode(workdir),
> +                             ovl_lookup_temp(ofs, workdir), attr);
> +       inode_unlock(workdir->d_inode);
> +       return ret;
>  }
>
>  static int ovl_set_opaque_xerr(struct dentry *dentry, struct dentry *upp=
er,
> @@ -348,28 +367,30 @@ static struct dentry *ovl_clear_empty(struct dentry=
 *dentry,
>         if (WARN_ON(!workdir))
>                 return ERR_PTR(-EROFS);
>
> -       err =3D ovl_lock_rename_workdir(workdir, upperdir);
> -       if (err)
> -               goto out;
> -
>         ovl_path_upper(dentry, &upperpath);
>         err =3D vfs_getattr(&upperpath, &stat,
>                           STATX_BASIC_STATS, AT_STATX_SYNC_AS_STAT);
>         if (err)
> -               goto out_unlock;
> +               goto out;
>
>         err =3D -ESTALE;
>         if (!S_ISDIR(stat.mode))
> -               goto out_unlock;
> +               goto out;
>         upper =3D upperpath.dentry;
> -       if (upper->d_parent->d_inode !=3D udir)
> -               goto out_unlock;
> +       /* This test is racey but we re-test under the lock */
> +       if (upper->d_parent !=3D upperdir)
> +               goto out;
>
>         opaquedir =3D ovl_create_temp(ofs, workdir, OVL_CATTR(stat.mode))=
;
>         err =3D PTR_ERR(opaquedir);
>         if (IS_ERR(opaquedir))
> -               goto out_unlock;
> -
> +               /* workdir was unlocked, no upperdir */
> +               goto out;
> +       err =3D ovl_lock_rename_workdir(workdir, upperdir);
> +       if (err)
> +               goto out_cleanup_unlocked;
> +       if (upper->d_parent->d_inode !=3D udir)
> +               goto out_cleanup;
>         err =3D ovl_copy_xattr(dentry->d_sb, &upperpath, opaquedir);
>         if (err)
>                 goto out_cleanup;
> @@ -398,10 +419,10 @@ static struct dentry *ovl_clear_empty(struct dentry=
 *dentry,
>         return opaquedir;
>
>  out_cleanup:
> -       ovl_cleanup(ofs, wdir, opaquedir);
> -       dput(opaquedir);
> -out_unlock:
>         unlock_rename(workdir, upperdir);
> +out_cleanup_unlocked:
> +       ovl_cleanup_unlocked(ofs, workdir, opaquedir);
> +       dput(opaquedir);
>  out:
>         return ERR_PTR(err);
>  }
> @@ -439,15 +460,11 @@ static int ovl_create_over_whiteout(struct dentry *=
dentry, struct inode *inode,
>                         return err;
>         }
>
> -       err =3D ovl_lock_rename_workdir(workdir, upperdir);
> -       if (err)
> -               goto out;
> -
> -       upper =3D ovl_lookup_upper(ofs, dentry->d_name.name, upperdir,
> -                                dentry->d_name.len);
> +       upper =3D ovl_lookup_upper_unlocked(ofs, dentry->d_name.name, upp=
erdir,
> +                                         dentry->d_name.len);
>         err =3D PTR_ERR(upper);
>         if (IS_ERR(upper))
> -               goto out_unlock;
> +               goto out;
>
>         err =3D -ESTALE;
>         if (d_is_negative(upper) || !ovl_upper_is_whiteout(ofs, upper))
> @@ -458,6 +475,10 @@ static int ovl_create_over_whiteout(struct dentry *d=
entry, struct inode *inode,
>         if (IS_ERR(newdentry))
>                 goto out_dput;
>
> +       err =3D ovl_lock_rename_workdir(workdir, upperdir);
> +       if (err)
> +               goto out_cleanup;
> +
>         /*
>          * mode could have been mutilated due to umask (e.g. sgid directo=
ry)
>          */
> @@ -472,35 +493,35 @@ static int ovl_create_over_whiteout(struct dentry *=
dentry, struct inode *inode,
>                 err =3D ovl_do_notify_change(ofs, newdentry, &attr);
>                 inode_unlock(newdentry->d_inode);
>                 if (err)
> -                       goto out_cleanup;
> +                       goto out_cleanup_locked;
>         }
>         if (!hardlink) {
>                 err =3D ovl_set_upper_acl(ofs, newdentry,
>                                         XATTR_NAME_POSIX_ACL_ACCESS, acl)=
;
>                 if (err)
> -                       goto out_cleanup;
> +                       goto out_cleanup_locked;
>
>                 err =3D ovl_set_upper_acl(ofs, newdentry,
>                                         XATTR_NAME_POSIX_ACL_DEFAULT, def=
ault_acl);
>                 if (err)
> -                       goto out_cleanup;
> +                       goto out_cleanup_locked;
>         }
>
>         if (!hardlink && S_ISDIR(cattr->mode)) {
>                 err =3D ovl_set_opaque(dentry, newdentry);
>                 if (err)
> -                       goto out_cleanup;
> +                       goto out_cleanup_locked;
>
>                 err =3D ovl_do_rename(ofs, workdir, newdentry, upperdir, =
upper,
>                                     RENAME_EXCHANGE);
>                 if (err)
> -                       goto out_cleanup;
> +                       goto out_cleanup_locked;
>
>                 ovl_cleanup(ofs, wdir, upper);
>         } else {
>                 err =3D ovl_do_rename(ofs, workdir, newdentry, upperdir, =
upper, 0);
>                 if (err)
> -                       goto out_cleanup;
> +                       goto out_cleanup_locked;
>         }
>         ovl_dir_modified(dentry->d_parent, false);
>         err =3D ovl_instantiate(dentry, inode, newdentry, hardlink, NULL)=
;
> @@ -508,10 +529,9 @@ static int ovl_create_over_whiteout(struct dentry *d=
entry, struct inode *inode,
>                 ovl_cleanup(ofs, udir, newdentry);
>                 dput(newdentry);
>         }
> +       unlock_rename(workdir, upperdir);
>  out_dput:
>         dput(upper);
> -out_unlock:
> -       unlock_rename(workdir, upperdir);
>  out:
>         if (!hardlink) {
>                 posix_acl_release(acl);
> @@ -519,8 +539,10 @@ static int ovl_create_over_whiteout(struct dentry *d=
entry, struct inode *inode,
>         }
>         return err;
>
> +out_cleanup_locked:
> +       unlock_rename(workdir, upperdir);
>  out_cleanup:
> -       ovl_cleanup(ofs, wdir, newdentry);
> +       ovl_cleanup_unlocked(ofs, workdir, newdentry);
>         dput(newdentry);
>         goto out_dput;
>  }
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 42228d10f6b9..508003e26e08 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -407,6 +407,15 @@ static inline struct dentry *ovl_lookup_upper(struct=
 ovl_fs *ofs,
>         return lookup_one(ovl_upper_mnt_idmap(ofs), &QSTR_LEN(name, len),=
 base);
>  }
>
> +static inline struct dentry *ovl_lookup_upper_unlocked(struct ovl_fs *of=
s,
> +                                                      const char *name,
> +                                                      struct dentry *bas=
e,
> +                                                      int len)
> +{
> +       return lookup_one_unlocked(ovl_upper_mnt_idmap(ofs),
> +                                  &QSTR_LEN(name, len), base);
> +}
> +
>  static inline bool ovl_open_flags_need_copy_up(int flags)
>  {
>         if (!flags)
> @@ -843,6 +852,7 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs,
>                                struct inode *dir, struct dentry *newdentr=
y,
>                                struct ovl_cattr *attr);
>  int ovl_cleanup(struct ovl_fs *ofs, struct inode *dir, struct dentry *de=
ntry);
> +int ovl_cleanup_unlocked(struct ovl_fs *ofs, struct dentry *workdir, str=
uct dentry *dentry);
>  struct dentry *ovl_lookup_temp(struct ovl_fs *ofs, struct dentry *workdi=
r);
>  struct dentry *ovl_create_temp(struct ovl_fs *ofs, struct dentry *workdi=
r,
>                                struct ovl_cattr *attr);
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index db046b0d6a68..576b5c3b537c 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -558,13 +558,12 @@ static int ovl_check_rename_whiteout(struct ovl_fs =
*ofs)
>         struct name_snapshot name;
>         int err;
>
> -       inode_lock_nested(dir, I_MUTEX_PARENT);
> -
>         temp =3D ovl_create_temp(ofs, workdir, OVL_CATTR(S_IFREG | 0));
>         err =3D PTR_ERR(temp);
>         if (IS_ERR(temp))
> -               goto out_unlock;
> +               return err;
>
> +       lock_rename(workdir, workdir);
>         dest =3D ovl_lookup_temp(ofs, workdir);
>         err =3D PTR_ERR(dest);
>         if (IS_ERR(dest)) {
> @@ -600,7 +599,7 @@ static int ovl_check_rename_whiteout(struct ovl_fs *o=
fs)
>         dput(dest);
>
>  out_unlock:
> -       inode_unlock(dir);
> +       unlock_rename(workdir, workdir);
>
>         return err;
>  }
> --
> 2.49.0
>

