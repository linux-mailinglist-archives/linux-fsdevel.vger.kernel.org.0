Return-Path: <linux-fsdevel+bounces-54652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A651B01E47
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 15:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 242281CA7909
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 13:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F392DC33F;
	Fri, 11 Jul 2025 13:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpZXCs03"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438882D7800;
	Fri, 11 Jul 2025 13:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752241841; cv=none; b=a3LGXcFl6gX8OBFg6u4NEIBDFgJZ+E4mWOCyc3XI/AJ86iKOuFJ1dFfRhH3zhvwFRvm0wEHUyrIyJ4L6JrTPSQOlapa8Z07aWuNTWUGQmJpW7vnZ83PhL3lSqMiwN+7Sy4oqCVR9wldzQbkgLB7nPQMlU8npiZatFebxnVMIviI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752241841; c=relaxed/simple;
	bh=xZV8pk/PHJ1tnQtUB3riW/LrmaADunXr1F25omzcEJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O0Moic/nUhs0dyzCCaiVWGG/QoPYo6wpF0OszeYVf2L02e/rEE8dhqgeX05QSFI0x9K25lvYfD/jEg5sYwO+S3jCOZdSzBw2V3IwaYa9eMzoaOdmg6dw5tVV02bt2+ThEC2BhD8ZERl7OJFAd9OdO+vPISOeHGK7DpnmowmQ4Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpZXCs03; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae0e0271d82so385723566b.3;
        Fri, 11 Jul 2025 06:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752241836; x=1752846636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rV2vM3ikiUw8M6wn+bitLpWrdCLg4EyTRU149CL2ozA=;
        b=MpZXCs03vOCOaBt0jiYa+8nAm2HVySWGukAcsr9bGFy9/DxMg1JtpGXZSIHbbRQDMc
         xVr4LWsnHWRJukYY4K2hCiQitalUb4QkcW3YzRBDPFKIMZTwQnoicJfVAb7supaH/qXW
         Ball4EIipRhx6U9hRNVSOZEeX7Qsx3bADvO4AyFEupDlAOUNNhYtvsO0lIyF5h6qIOFO
         kxpLlaL3GBNNlo650kT0e+vyjLU4H+L6TKT/vK4tbeCMXKdhRsEdQH/fGGefN4CjEHMp
         fVa3TMYuZUHlT8lLZA0k0TnVU9pBIWxsmrlLbsgOiceOLvTxk4aDppeJ9gvm5tl6nHHl
         oEKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752241836; x=1752846636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rV2vM3ikiUw8M6wn+bitLpWrdCLg4EyTRU149CL2ozA=;
        b=AoLHFjVd/XYyg+s7IRK8QMWGC6W+1NorxoMG9JqL5QYEg2lRQTqFK0OM+NouHQic1/
         wIy3HhHzreazEj1NyBBEjcSOKrBDdEskv1wK4p+nJDW/H/d/lfLIdlkEzpOFPJgkPB9I
         HKltX0jLoHai/dkAZ9CRzc3DL1YyqpBPXP760MeQVIh+yMhBytKHZRTkXzdp/ABG2YmO
         Wb/q3dWpvxH+sUrsrP7tNnCs6Jb3V9tw0ZoezeUCD7qbuMSOZWwmpQk0WYsW2kxJN6vs
         MZivAW6fe2QUtJmEYmDakVNdK/rrBBSDWfsTtzwmXCKKtVqefBs+K3rwIcKXesNEeY1T
         7RKg==
X-Forwarded-Encrypted: i=1; AJvYcCWf+D71ZrxAVkKL0WL4g/Uz0J6IpHYEie3nhkEG71nld2ugqhMrbZiY1y7CSiziZQVuwrJoomDcCtdMBPeVQA==@vger.kernel.org, AJvYcCXrETKGG2enyCaqK5LVrtOgH9YYdPoW2E0VTXXH/s3+Ivgsx+mhN3z/UeJVtdX9mL1RtwH2WwVMWzcdTyUW@vger.kernel.org
X-Gm-Message-State: AOJu0YyFnsTl1hgI2LsAu753dJk/cL0nDeANieN7UrFuPImYrnl7sFQr
	dG3eTLu3nE0VANw0pPrTYH/4lFEAeWcO67uyVqElpoyxwG6qzcABUKsZ+FOojTNPQhK+ySMpaMs
	vCJ/TQZBX6J7a5Xzl5j8vNCTfCGgcPvw=
X-Gm-Gg: ASbGncuYi8Esiq7HFXHXZcDUEymN5fSWWCOQErmtBVI2HHpXUpD93us5wEPRaxDWINA
	JdM68JkaPzfURCjP0KU11VpDjmwPB4HecGS548om0xwfGjHZ+x2LKHH2fxfObqwgsmid0+lPQYA
	M6SpZKbGQ3AcHGd+gUVunmyLTLXgK+/LipbBLzbYyS+9snx1C3qfH4RYePm31WiClAAIjueoqyB
	sKaZEM=
X-Google-Smtp-Source: AGHT+IEOGjk3wOIWF/lDZGxDvz+ZNEhaBmwNdJb7reieN16QJL0LRVdqe0PhwMkhGGqYTpNESbLIOn2xxOIp1R599uc=
X-Received: by 2002:a17:906:4fc9:b0:ae3:6654:c0b2 with SMTP id
 a640c23a62f3a-ae6fbf22b31mr371341966b.28.1752241835920; Fri, 11 Jul 2025
 06:50:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710232109.3014537-1-neil@brown.name> <20250710232109.3014537-17-neil@brown.name>
In-Reply-To: <20250710232109.3014537-17-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 11 Jul 2025 15:50:24 +0200
X-Gm-Features: Ac12FXzDOWovo6hjKRsmdtvDn_T8EgbMhz5j3Xl23NEQg9fUHSZB0FPQIXLpLG0
Message-ID: <CAOQ4uxj30hzDAcQ9vbTvwPxvUw59ir59SKaiNi+ZfEPvc8+i1g@mail.gmail.com>
Subject: Re: [PATCH 16/20] ovl: change ovl_cleanup_and_whiteout() to take
 rename lock as needed
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 1:21=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> Rather than locking the directory(s) before calling
> ovl_cleanup_and_whiteout(), change it (and ovl_whiteout()) to do the
> locking, so the locking can be fine grained as will be needed for
> proposed locking changes.
>
> Sometimes this is called to whiteout something in the index dir, in
> which case only that dir must be locked.  In one case it is called on
> something in an upperdir, so two directories must be locked.  We use
> ovl_lock_rename_workdir() for this and remove the restriction that
> upperdir cannot be indexdir - because now sometimes it is.
>
> Signed-off-by: NeilBrown <neil@brown.name>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

> ---
>  fs/overlayfs/dir.c     | 20 +++++++++-----------
>  fs/overlayfs/readdir.c |  3 ---
>  fs/overlayfs/util.c    |  7 -------
>  3 files changed, 9 insertions(+), 21 deletions(-)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 8580cd5c61e4..086719129be3 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -77,7 +77,6 @@ struct dentry *ovl_lookup_temp(struct ovl_fs *ofs, stru=
ct dentry *workdir)
>         return temp;
>  }
>
> -/* caller holds i_mutex on workdir */
>  static struct dentry *ovl_whiteout(struct ovl_fs *ofs)
>  {
>         int err;
> @@ -85,6 +84,7 @@ static struct dentry *ovl_whiteout(struct ovl_fs *ofs)
>         struct dentry *workdir =3D ofs->workdir;
>         struct inode *wdir =3D workdir->d_inode;
>
> +       inode_lock_nested(wdir, I_MUTEX_PARENT);
>         if (!ofs->whiteout) {
>                 whiteout =3D ovl_lookup_temp(ofs, workdir);
>                 if (IS_ERR(whiteout))
> @@ -118,14 +118,13 @@ static struct dentry *ovl_whiteout(struct ovl_fs *o=
fs)
>         whiteout =3D ofs->whiteout;
>         ofs->whiteout =3D NULL;
>  out:
> +       inode_unlock(wdir);
>         return whiteout;
>  }
>
> -/* Caller must hold i_mutex on both workdir and dir */
>  int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct dentry *dir,
>                              struct dentry *dentry)
>  {
> -       struct inode *wdir =3D ofs->workdir->d_inode;
>         struct dentry *whiteout;
>         int err;
>         int flags =3D 0;
> @@ -138,18 +137,22 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, st=
ruct dentry *dir,
>         if (d_is_dir(dentry))
>                 flags =3D RENAME_EXCHANGE;
>
> -       err =3D ovl_do_rename(ofs, ofs->workdir, whiteout, dir, dentry, f=
lags);
> +       err =3D ovl_lock_rename_workdir(ofs->workdir, whiteout, dir, dent=
ry);
> +       if (!err) {
> +               err =3D ovl_do_rename(ofs, ofs->workdir, whiteout, dir, d=
entry, flags);
> +               unlock_rename(ofs->workdir, dir);
> +       }
>         if (err)
>                 goto kill_whiteout;
>         if (flags)
> -               ovl_cleanup(ofs, wdir, dentry);
> +               ovl_cleanup_unlocked(ofs, ofs->workdir, dentry);
>
>  out:
>         dput(whiteout);
>         return err;
>
>  kill_whiteout:
> -       ovl_cleanup(ofs, wdir, whiteout);
> +       ovl_cleanup_unlocked(ofs, ofs->workdir, whiteout);
>         goto out;
>  }
>
> @@ -782,10 +785,6 @@ static int ovl_remove_and_whiteout(struct dentry *de=
ntry,
>                 goto out_dput_upper;
>         }
>
> -       err =3D ovl_lock_rename_workdir(workdir, NULL, upperdir, upper);
> -       if (err)
> -               goto out_dput_upper;
> -
>         err =3D ovl_cleanup_and_whiteout(ofs, upperdir, upper);
>         if (err)
>                 goto out_d_drop;
> @@ -793,7 +792,6 @@ static int ovl_remove_and_whiteout(struct dentry *den=
try,
>         ovl_dir_modified(dentry->d_parent, true);
>  out_d_drop:
>         d_drop(dentry);
> -       unlock_rename(workdir, upperdir);
>  out_dput_upper:
>         dput(upper);
>  out_dput:
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index 6cc5f885e036..4127d1f160b3 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -1179,7 +1179,6 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
>         int err;
>         struct dentry *indexdir =3D ofs->workdir;
>         struct dentry *index =3D NULL;
> -       struct inode *dir =3D indexdir->d_inode;
>         struct path path =3D { .mnt =3D ovl_upper_mnt(ofs), .dentry =3D i=
ndexdir };
>         LIST_HEAD(list);
>         struct ovl_cache_entry *p;
> @@ -1231,9 +1230,7 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
>                          * Whiteout orphan index to block future open by
>                          * handle after overlay nlink dropped to zero.
>                          */
> -                       inode_lock_nested(dir, I_MUTEX_PARENT);
>                         err =3D ovl_cleanup_and_whiteout(ofs, indexdir, i=
ndex);
> -                       inode_unlock(dir);
>                 } else {
>                         /* Cleanup orphan index entries */
>                         err =3D ovl_cleanup_unlocked(ofs, indexdir, index=
);
> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index 7369193b11ec..5218a477551b 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -1071,7 +1071,6 @@ static void ovl_cleanup_index(struct dentry *dentry=
)
>  {
>         struct ovl_fs *ofs =3D OVL_FS(dentry->d_sb);
>         struct dentry *indexdir =3D ovl_indexdir(dentry->d_sb);
> -       struct inode *dir =3D indexdir->d_inode;
>         struct dentry *lowerdentry =3D ovl_dentry_lower(dentry);
>         struct dentry *upperdentry =3D ovl_dentry_upper(dentry);
>         struct dentry *index =3D NULL;
> @@ -1113,10 +1112,8 @@ static void ovl_cleanup_index(struct dentry *dentr=
y)
>                 index =3D NULL;
>         } else if (ovl_index_all(dentry->d_sb)) {
>                 /* Whiteout orphan index to block future open by handle *=
/
> -               inode_lock_nested(dir, I_MUTEX_PARENT);
>                 err =3D ovl_cleanup_and_whiteout(OVL_FS(dentry->d_sb),
>                                                indexdir, index);
> -               inode_unlock(dir);
>         } else {
>                 /* Cleanup orphan index entries */
>                 err =3D ovl_cleanup_unlocked(ofs, indexdir, index);
> @@ -1224,10 +1221,6 @@ int ovl_lock_rename_workdir(struct dentry *workdir=
, struct dentry *work,
>  {
>         struct dentry *trap;
>
> -       /* Workdir should not be the same as upperdir */
> -       if (workdir =3D=3D upperdir)
> -               goto err;
> -
>         /* Workdir should not be subdir of upperdir and vice versa */
>         trap =3D lock_rename(workdir, upperdir);
>         if (IS_ERR(trap))
> --
> 2.49.0
>

