Return-Path: <linux-fsdevel+bounces-55095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E4AB06E98
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 09:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78BE47AA47D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 07:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224BF28B503;
	Wed, 16 Jul 2025 07:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAck8Y7F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897F128A1D1;
	Wed, 16 Jul 2025 07:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752649993; cv=none; b=ty3fssNXiirdbTWyRTYt3c1kV7znMYo15D3GLowD6UvlUAQ8k9HWoXzti6g5FaU0hhC5kjBgzrQEoGqaNryV5Gtx5QaCJp6PCBu78dk/FJ0WqVEa5chiTQ34lko/B+j2CC6J4mp9H8vslIKJppLGi3LdaT+pwSvBfcvNpbgh/bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752649993; c=relaxed/simple;
	bh=rVI88CwI8o0lMLWcULXTTJs9y0VpFUbe8QyZHCUQjgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iT75iVlbFvPCiZABmUdetdD7aQvXJomOCgjJx50PH6ucFZZaYKmuIicJyZF+wXMDDtbuc9BR6AANq+eiQo1srp1HBj0ZMd9aN02Grawg66Tl3oCEN4HThe7KuU8ALccVGh3DRSWic9l24L3sSRCjVqqdPOrGe5/CjG01hH7b4uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAck8Y7F; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ad56cbc7b07so1057787266b.0;
        Wed, 16 Jul 2025 00:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752649990; x=1753254790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJA6NMGpWQEwMnRvWfLY4XBrdSyY7NzjmSjRq3mJajI=;
        b=WAck8Y7FD4fwPnKse4hfqPMfo1tpNX82MXx3tOnQD0j86+icbrCaa8YyDDrutlCbPI
         qaeC0sVbXuhxGetU8vfog5LgXIqdOm/F/Re2i9pPHd6KFgJq2cLKyu1SNU8UaQxSHvtd
         15PN6ABETCXLrMqeOUxxRqhSC/ACrfHx89bxIZnEGlJIFIC/ZOuS1kZmOHB2om4F704f
         8dRG9T1Pqx92MlFWrBKVlxOckCH0WbdCXQU+3324/ZJT0kLWvPmXsTEIEb1rOUbsinr6
         M8x8bIJxtLvIsV2T7LDHuFOGBmXStH4/XSSnHHPilBXpsVtRd+BKQTxLGSZ6TRO+yGTN
         kkxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752649990; x=1753254790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJA6NMGpWQEwMnRvWfLY4XBrdSyY7NzjmSjRq3mJajI=;
        b=PKJ2G7fSdsxJulIq71Io1fcVkCkpLCXjUZ8PMVtBV/HIgILkKUWI4A/zTNOzKbLE6a
         Fb+RMzUfFO6Xnrixh0Vw9utOEpa2f/gWAnwghBxs7xu9sYnQOHenlnQeJWsONFtBaT++
         bic7/QtW250S2uGl3kvo0ykCbS/F98sWa0b5xcapl7W/nTOguCILdglza+UKQx3645vq
         Hx3bXNZUM4nQW817PN0tU/YKZ63mT388Pcv2e3cjROzRIBqB634Ln0wZrnZZHgI8Cc5l
         lAVfqooUWIqXjzGJaEWtWwf7ODU+1eArjFOluuojiNQ5j/2C4huLeMhtdSAsm1JoD06o
         aziQ==
X-Forwarded-Encrypted: i=1; AJvYcCVssPuPiGAmFnoQdfF6xOPhZt2cpqbaA4CK96ET9F9Npg112Qfax5OUWQeTfgrYoh6oU3EnW6kg2v2QgOxW@vger.kernel.org, AJvYcCXLdNtwho1jkhq/FuSSCIMs4Adwb0EXQjRzXUd/PJmr3/1ci10pVVqrHuBAl7nAXRnq/DwD1NnM0FwYdfYRow==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+44JGKygBgvBCRUkWpHwORPY5GYUh3Vs2nCm/bldhzN4pVh7x
	IqF5Ns0d/+odqC6JXZbPfxpJxNzzbzKnm/XuPGk0jgGMhYRq8zrMRUMkHdczvMyDbe3OU/LiUK9
	xVEfQ+cTuujAvWaCvdMB7nQvln+99QeMOMhUmJU4=
X-Gm-Gg: ASbGncs+vB4Koa848j/X8HSHoMSJ9fc1rXxBERHWdvH8ryZbhKdQi6yxRhIyUhVwG+o
	pQZf03Up8Kkiwz070yHEmT1tC2uWW2AZ6+Qf1pS8njvq9aJZKjX6NPinEIA7Zq1/i34rP3IOb/w
	1ON8b91KcXmUvJbBkuJkrTeY7TuK1sdrsh5z8FMx6HPj3n5NzeKBzNNPmBjgY/fgFenmwPilWx3
	lrjuEI=
X-Google-Smtp-Source: AGHT+IHc1rDyamIUCkqJyt/PMFaAhG35LjqU64mxB5r4rzampw05GSXk+vDzR9X10hJ8F764RcsVynppWRg9WmbgfKI=
X-Received: by 2002:a17:906:7315:b0:ade:4121:8d3d with SMTP id
 a640c23a62f3a-ae9cddaa5f5mr143698866b.12.1752649989361; Wed, 16 Jul 2025
 00:13:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716004725.1206467-1-neil@brown.name> <20250716004725.1206467-2-neil@brown.name>
In-Reply-To: <20250716004725.1206467-2-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 16 Jul 2025 09:12:57 +0200
X-Gm-Features: Ac12FXxHO8K5QI7x8x15CCP5ulA2igm_xTn8-IEIO1jW9gQm8idHtxcJwCioqSc
Message-ID: <CAOQ4uxh0qfhDGBPhV2uk_WqUN2qWOxH9jprMOhRyu_VSy5CYiw@mail.gmail.com>
Subject: Re: [PATCH v3 01/21] ovl: simplify an error path in ovl_copy_up_workdir()
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 2:47=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> If ovl_copy_up_data() fails the error is not immediately handled but the
> code continues on to call ovl_start_write() and lock_rename(),
> presumably because both of these locks are needed for the cleanup.
> Only then (if the lock was successful) is the error checked.
>
> This makes the code a little hard to follow and could be fragile.
>
> This patch changes to handle the error after the ovl_start_write()
> (which cannot fail, so there aren't multiple errors to deail with).  A
> new ovl_cleanup_unlocked() is created which takes the required directory
> lock.  This will be used extensively in later patches.
>
> In general we need to check the parent is still correct after taking the
> lock (as ovl_copy_up_workdir() does after a successful lock_rename()) so
> that is included in ovl_cleanup_unlocked() using new ovl_parent_lock()
> and ovl_parent_unlock() calls (it is planned to move this API into VFS co=
de
> eventually, though in a slightly different form).
>
> Signed-off-by: NeilBrown <neil@brown.name>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/copy_up.c   | 20 +++++++++++---------
>  fs/overlayfs/dir.c       | 15 +++++++++++++++
>  fs/overlayfs/overlayfs.h |  6 ++++++
>  fs/overlayfs/util.c      | 10 ++++++++++
>  4 files changed, 42 insertions(+), 9 deletions(-)
>
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index 8a3c0d18ec2e..79f41ef6ffa7 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -794,23 +794,24 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_c=
tx *c)
>          */
>         path.dentry =3D temp;
>         err =3D ovl_copy_up_data(c, &path);
> +       ovl_start_write(c->dentry);
> +       if (err)
> +               goto cleanup_unlocked;
> +
>         /*
>          * We cannot hold lock_rename() throughout this helper, because o=
f
>          * lock ordering with sb_writers, which shouldn't be held when ca=
lling
>          * ovl_copy_up_data(), so lock workdir and destdir and make sure =
that
>          * temp wasn't moved before copy up completion or cleanup.
>          */
> -       ovl_start_write(c->dentry);
>         trap =3D lock_rename(c->workdir, c->destdir);
>         if (trap || temp->d_parent !=3D c->workdir) {
>                 /* temp or workdir moved underneath us? abort without cle=
anup */
>                 dput(temp);
>                 err =3D -EIO;
> -               if (IS_ERR(trap))
> -                       goto out;
> -               goto unlock;
> -       } else if (err) {
> -               goto cleanup;
> +               if (!IS_ERR(trap))
> +                       unlock_rename(c->workdir, c->destdir);
> +               goto out;
>         }
>
>         err =3D ovl_copy_up_metadata(c, temp);
> @@ -846,7 +847,6 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx=
 *c)
>         ovl_inode_update(inode, temp);
>         if (S_ISDIR(inode->i_mode))
>                 ovl_set_flag(OVL_WHITEOUTS, inode);
> -unlock:
>         unlock_rename(c->workdir, c->destdir);
>  out:
>         ovl_end_write(c->dentry);
> @@ -854,9 +854,11 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ct=
x *c)
>         return err;
>
>  cleanup:
> -       ovl_cleanup(ofs, wdir, temp);
> +       unlock_rename(c->workdir, c->destdir);
> +cleanup_unlocked:
> +       ovl_cleanup_unlocked(ofs, c->workdir, temp);
>         dput(temp);
> -       goto unlock;
> +       goto out;
>  }
>
>  /* Copyup using O_TMPFILE which does not require cross dir locking */
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 4fc221ea6480..67cad3dba8ad 100644
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
> +       err =3D ovl_parent_lock(workdir, wdentry);
> +       if (err)
> +               return err;
> +
> +       ovl_cleanup(ofs, workdir->d_inode, wdentry);
> +       ovl_parent_unlock(workdir);
> +
> +       return 0;
> +}
> +
>  struct dentry *ovl_lookup_temp(struct ovl_fs *ofs, struct dentry *workdi=
r)
>  {
>         struct dentry *temp;
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 42228d10f6b9..6737a4692eb2 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -416,6 +416,11 @@ static inline bool ovl_open_flags_need_copy_up(int f=
lags)
>  }
>
>  /* util.c */
> +int ovl_parent_lock(struct dentry *parent, struct dentry *child);
> +static inline void ovl_parent_unlock(struct dentry *parent)
> +{
> +       inode_unlock(parent->d_inode);
> +}
>  int ovl_get_write_access(struct dentry *dentry);
>  void ovl_put_write_access(struct dentry *dentry);
>  void ovl_start_write(struct dentry *dentry);
> @@ -843,6 +848,7 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs,
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
> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index 2b4754c645ee..f4944f11d5eb 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -1544,3 +1544,13 @@ void ovl_copyattr(struct inode *inode)
>         i_size_write(inode, i_size_read(realinode));
>         spin_unlock(&inode->i_lock);
>  }
> +
> +int ovl_parent_lock(struct dentry *parent, struct dentry *child)
> +{
> +       inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
> +       if (!child || child->d_parent =3D=3D parent)
> +               return 0;
> +
> +       inode_unlock(parent->d_inode);
> +       return -EINVAL;
> +}
> --
> 2.49.0
>

