Return-Path: <linux-fsdevel+bounces-54617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB841B01A58
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 13:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52E28543C30
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 11:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21869288C97;
	Fri, 11 Jul 2025 11:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhglzM31"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF2FA920;
	Fri, 11 Jul 2025 11:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752232227; cv=none; b=XRpzRVR8p7Vlfl8s6B8SA+/CY+ECM/3KBMIWFupenfMzU96UUUb+vGsmejIxO6iIELjfsVdgR9sgcdKio0ZsPLBkfaV3ocIdElh8S9NT1LkPrLqRn5f3X6QUNX5YIwOLv0sVuXcICpIlwfT/DHDMYzfMAjD/l2su0KeSuixTaLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752232227; c=relaxed/simple;
	bh=MNVFRQBb1mpkUhjpug1HvPYguSX7MeTn/XVB+0scZIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HHbL4h/3n58tCzAbYJDsg8zGZA4L1bl36wpx/vmzFlLQwCZycpEm6wSxwmL3ZctmYrAFVwlPoCbQ/O9ZpE3fLjtpbr02Qi+/anqcX7w35HBQCyD3euJCE62B9On28FL5LeYkWvWILrVfY1CTnP7ImQ0HXPsMQuslqqCNv+79ULk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhglzM31; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-60780d74c8cso3180552a12.2;
        Fri, 11 Jul 2025 04:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752232224; x=1752837024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gg3qyx8p6TAsnDbO5hjjKwE3qgr0yfg3/+8H9qS89Fk=;
        b=WhglzM31V7CmWU+cjv/kF2UAOju+6noVs7+Xvx/nkwiVn4AmRg+7rPTKYVmRoBELCe
         ufAdEPWulxMAd59Y7DIlAWr1KV8yHpoGSWxF4C1qLGciRXJHggXsR4/YsTctoWHvUkor
         uxRvdy+q4E0xF0ThseyZPpZfR5nymDKDdEVPbyD7C5TltukSpf6+iq7TKoDaBMJ60WbZ
         2xkVojJ9+i+RXEu8oGCqZM4Re8OY5QBLQz/vxFDlXNzIi1IyJ6BNkQgqcn0ZpM7PxJQ5
         nuB6rmTU2dFNDyy1wTLEsONazuUUvXbgz3OLS+0Cz20geQ0Fm9689jxwUWoaGZHvw//S
         gizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752232224; x=1752837024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gg3qyx8p6TAsnDbO5hjjKwE3qgr0yfg3/+8H9qS89Fk=;
        b=L4IHpON4LN3c4yD5kEGuOHqrAFSObcPMrBJ7JNCZNseItgM3WizTK3w9DOKQsgLEP5
         a0X5ut/NRs+eySFGs+ftLZbEC9yX7h817rSVhykfjYWVtgjaqdQmTXQcyQWiZYMvyBnP
         x4NONee7gUxTGsxSI8hs1YSuTY75Llqpp2PHF/B3+30rFnpVxF17zqAuCq8Q41+tZJvT
         SqpS4l1+Lwx/+a6d2ymgT+KIJn2sWSibh6xQkv3ilLI9P6y47wtbuIB26hzUNUgCGbaE
         HISH6O1HWclTxDISHumeZ+2NlAX8qI+smrPljuSn8360dWAoMSr+lLUVdUdngyb+o0kQ
         d3Mg==
X-Forwarded-Encrypted: i=1; AJvYcCUF91ZyhKUrJ0AaIKiMgZ/ZGIX7aoZqQbTMxP4DryR3avCQ8pnBmIvINCVagqh1cqtqYlKxHpcK4wQ4VLqBXA==@vger.kernel.org, AJvYcCV92o+x3ZHK8new6Gsp7nMUcaujS+zkoa2mc1uUSS41EmtQctOS0ZMQ2M9CDhyAAb56xmvg8+UKCQoZ8OtY@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8HCTvUUL8osGbYpiNNen4hmQ0M6W9ju0Yl9OI8CSvM8WGxr4M
	vQWhwowu4Jb/fJeQEC1VA+Rltsdj8rU1LgjsOZVeGTBp0q9FpSrS0+AWFTV+idCb7arRSTv8X4+
	PQ2JvvyIwCqX2RlPbO5EG94wRho1OFtI=
X-Gm-Gg: ASbGncvk/ibmUrILzi9FdFOduxoljC1wnpNDBrxrKiairUPowAxtkWm646v/M5N1VfP
	bTlzwS/KQe+bdnSptZT9AYkmbPSWXlGie5URiE7EuFxFvBLP2OynL7K/29FGFIukPDdQhXarU2A
	/Q0FAwphJ0132yQ81hv/711b8IBsGhGELWDobktpMYxv6L30OvfvTzffNql+ylDk7KrKBqxBP1s
	5/khEJoZ6Jw1fSytQ==
X-Google-Smtp-Source: AGHT+IF3shfHVJOWr9Mwj9Gu+iSa0K0wQmI0NDhozntDwY7VKgpyVKerEa8XAAkmOl6l5WECUBA5KJUrnuusfWcpVhA=
X-Received: by 2002:a17:907:3d42:b0:ada:4b3c:ea81 with SMTP id
 a640c23a62f3a-ae6fca6db62mr253232366b.39.1752232223349; Fri, 11 Jul 2025
 04:10:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710232109.3014537-1-neil@brown.name> <20250710232109.3014537-4-neil@brown.name>
In-Reply-To: <20250710232109.3014537-4-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 11 Jul 2025 13:10:11 +0200
X-Gm-Features: Ac12FXzk3sd0GOGIopxlHdOWzmN6WgDPsXitWFqRRWJvtDy-v2wLBOmWu1j59OY
Message-ID: <CAOQ4uxgBe_w1wJ-xC6NhEFNVKKULhkaHV2EJgWVc=qGoRNOcXA@mail.gmail.com>
Subject: Re: [PATCH 03/20] ovl: Call ovl_create_temp() without lock held.
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 1:21=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> ovl currently locks a directory or two and then performs multiple actions
> in one or both directories.  This is incompatible with proposed changes
> which will lock just the dentry of objects being acted on.
>
> This patch moves calls to ovl_create_temp() out of the locked regions and
> has it take and release the relevant lock itself.
>
> The lock that was taken before this function was called is now taken
> after.  This means that any code between where the lock was taken and
> ovl_create_temp() is now unlocked.  This necessitates the use of
> ovl_cleanup_unlocked() and the creation of ovl_lookup_upper_unlocked().
> These will be used more widely in future patches.
>
> Now that the file is created before the lock is taken for rename, we
> need to ensure the parent wasn't changed before the lock was gained.
> ovl_lock_rename_workdir() is changed to optionally receive the dentries
> that will be involved in the rename.  If either is present but has the
> wrong parent, an error is returned.
>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/overlayfs/copy_up.c   |  5 ---
>  fs/overlayfs/dir.c       | 67 ++++++++++++++++++++--------------------
>  fs/overlayfs/overlayfs.h | 12 ++++++-
>  fs/overlayfs/super.c     | 11 ++++---
>  fs/overlayfs/util.c      |  7 ++++-
>  5 files changed, 58 insertions(+), 44 deletions(-)
>
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index 25be0b80a40b..eafb46686854 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -523,7 +523,6 @@ static int ovl_create_index(struct dentry *dentry, co=
nst struct ovl_fh *fh,
>  {
>         struct ovl_fs *ofs =3D OVL_FS(dentry->d_sb);
>         struct dentry *indexdir =3D ovl_indexdir(dentry->d_sb);
> -       struct inode *dir =3D d_inode(indexdir);
>         struct dentry *index =3D NULL;
>         struct dentry *temp =3D NULL;
>         struct qstr name =3D { };
> @@ -549,9 +548,7 @@ static int ovl_create_index(struct dentry *dentry, co=
nst struct ovl_fh *fh,
>                 return err;
>
>         ovl_start_write(dentry);
> -       inode_lock(dir);
>         temp =3D ovl_create_temp(ofs, indexdir, OVL_CATTR(S_IFDIR | 0));
> -       inode_unlock(dir);
>         err =3D PTR_ERR(temp);
>         if (IS_ERR(temp))
>                 goto free_name;
> @@ -785,9 +782,7 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx=
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
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index cee35d69e0e6..144e1753d0c9 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -214,8 +214,12 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, s=
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
> @@ -353,7 +357,6 @@ static struct dentry *ovl_clear_empty(struct dentry *=
dentry,
>         struct dentry *workdir =3D ovl_workdir(dentry);
>         struct inode *wdir =3D workdir->d_inode;
>         struct dentry *upperdir =3D ovl_dentry_upper(dentry->d_parent);
> -       struct inode *udir =3D upperdir->d_inode;
>         struct path upperpath;
>         struct dentry *upper;
>         struct dentry *opaquedir;
> @@ -363,28 +366,25 @@ static struct dentry *ovl_clear_empty(struct dentry=
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
>
>         opaquedir =3D ovl_create_temp(ofs, workdir, OVL_CATTR(stat.mode))=
;
>         err =3D PTR_ERR(opaquedir);
>         if (IS_ERR(opaquedir))
> -               goto out_unlock;
> -
> +               /* workdir was unlocked, no upperdir */
> +               goto out;

Strong lint error here. Don't use multi lines (inc. comments) without {}
TBH this comment adds no clarity for me. I would remove it.

> +       err =3D ovl_lock_rename_workdir(workdir, opaquedir, upperdir, upp=
er);
> +       if (err)
> +               goto out_cleanup_unlocked;

Nit: please keep the empty line after goto as it was in the code before.
I removed this empty line in other patches as well and it hurts my eyes.
I know we do not have a 100% consistent style in that regard in overlayfs c=
ode
(e.g. S_ISDIR check above), but please try to avoid changing the existing
style of code in that regard.

>         err =3D ovl_copy_xattr(dentry->d_sb, &upperpath, opaquedir);
>         if (err)
>                 goto out_cleanup;
> @@ -413,10 +413,10 @@ static struct dentry *ovl_clear_empty(struct dentry=
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
> @@ -454,15 +454,11 @@ static int ovl_create_over_whiteout(struct dentry *=
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
> @@ -473,6 +469,10 @@ static int ovl_create_over_whiteout(struct dentry *d=
entry, struct inode *inode,
>         if (IS_ERR(newdentry))
>                 goto out_dput;
>
> +       err =3D ovl_lock_rename_workdir(workdir, newdentry, upperdir, upp=
er);
> +       if (err)
> +               goto out_cleanup;
> +

goto out_cleanup_unlocked here please
and leave the rest of the goto cleanup be
just like you did in ovl_clear_empty().

This looks way better than v1 patch 2 that overflowed my review context sta=
ck.
With minor nits above fixed, feel free to add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>


Thanks,
Amir.

