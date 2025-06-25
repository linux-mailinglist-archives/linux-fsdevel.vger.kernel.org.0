Return-Path: <linux-fsdevel+bounces-52968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04264AE8D2B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 20:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E2324A5A00
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 18:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04ADD2DAFDF;
	Wed, 25 Jun 2025 18:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWP+aHMS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4142BD01A;
	Wed, 25 Jun 2025 18:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750877859; cv=none; b=DV2o8QOOGcNi7vwsm63k9UtwYRvlZhC0IHezXDIkEUiwmvBo61e3idVfGYXbueyWGlf4M//Pr/l6szcdEcyJ0eWkzqeIfdcYbII/cgI8esSbTZD6YBSfysljM4m22nm/cO6RN37QH+cTehRbyD8mLF347HRAO8arG2S45xS+qf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750877859; c=relaxed/simple;
	bh=eynCjIWennniUN5neFaT2yEXIri6aTPIW6cIBcgZItE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aRlHUdpwzkeFToeCjPtmGC8YToqeipoAZ841K82U1dkr6I0otMTFn1av5gOtfQd8JAgB/0EOTB5rB2bX3KuT1H5aKn2mpR1fvSytSFYI6G2yKKrb7XxcSObZPUcxTAWGc1ShXDZEUoZREkSRrhaQTfFuenis89LP3MjS/Q5DUnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWP+aHMS; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60bfcada295so257789a12.1;
        Wed, 25 Jun 2025 11:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750877856; x=1751482656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e15bSJYNFi8GQVQnHfGq/IYjQ/GQg8y3RwHl2c2u/LE=;
        b=MWP+aHMSlgz/Ag6+KNIjS3yxG/Sp+hssqu5IgK2XdPw0oYJJ8RZJtuCbGyhmb+kxPC
         l/C8AG4szCM4IB/gPhDSWtRom06r5OMLs3JDAvqZvB8vJs+ku5AjrK1MmTaxeAMrW79A
         JuteHNcKa6S/aOn8ez8PiGmg8473veuzFMIJ8J/OTD/q9aRNbWS7+IYi4UaMcQavsIbO
         6V8phdT1U6o4Qf6qr3QeY4xv7ASE/jZ052IutWsVgLhUj7o/3CFRjeoYbZGQ5E0XGUwo
         bS6yPCEKPhUQhlwgHyiqRJHT7kJ09AG9+0Up3SEiV6bd8VDuicZ09tRavm3ZzypEucux
         7xkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750877856; x=1751482656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e15bSJYNFi8GQVQnHfGq/IYjQ/GQg8y3RwHl2c2u/LE=;
        b=JCz9YtfJfWvZIvz1Vr0PWYSbfvxqoiOBuEN1VDIZ7FsEiFjnv4ZYYWHbaiDc1r6naP
         RxhmFvwKakgor2GGZxWxmXlCCJCskKb5EJtCMpeCl56e6/0vYwwzmItVSp48r/j8IQZO
         MRmwRdjqLROvLYgcygAN1q3t49cKumudmToJjndNMWYLP1ADvQiaAaUATXhq2+riRfA/
         gyrL7u7LQGmdaNI7xTqLrPTHxIyEuydwu5s4Zur78WOpW39r5MEaLW+S21RaKXbOyJT2
         3wI3tC4K83hyQJCjw/UocNUpafs8I/kdj5AMtnfdlbHQoY/YTMVGzR4JYZcnyxo7iHT2
         JR0w==
X-Forwarded-Encrypted: i=1; AJvYcCXByD8w0mURyiLE8fYe+tkj3e0MOJ24Gm+rLPq3gmz1P7LJrKoVaX/3zNR3ponWtUXTteMxwT4CEVRWyoIKGA==@vger.kernel.org, AJvYcCXl7fgrQobRL3wWIKKA7N5Nm6iFu/3PWgJIE0dh0KP+MWDyznX11GKfV+5B3WK95E/kZIz6rOidmmGeAGQB@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6OAVWbg/OrL+KtmBIgtboIwgozqfUen3LUFfPVApSiRo+Kf/9
	MsvCHj7F8kKNQxGg9zLjS9MIlo5b0sKy5KaLP6x6bo4UN1q0k906gUTFDvzirpbodAO5RyRhtey
	d752P2vD8VfAknbT4q0BN9VAowG+mgQE=
X-Gm-Gg: ASbGncuYlJhIgvwsqqsln+W4nrt0YTBQrqJuqXg8qQK2WTrB5A+U8KdgC6X76V2r3xn
	ghfGig7IarEOQlvZaWs0ig9GHE2hxkh2kjsQLz1qi80QLBT5GWmKRcCLgtq7fio5GnaUphWw3ue
	uth8lXWv/3Ue6QX4wUNViLwJA7C2s4S/psdu4SI/Z/mCI=
X-Google-Smtp-Source: AGHT+IHc4WtCT7yqvMlo+uHtVpKzhUV9ojpBYkFgvbOOTHRmEwzv9S3+oiLAjKGkksdTnRCnJfnnGXo07+q6kJzN5o0=
X-Received: by 2002:a17:907:9805:b0:ad8:e477:970c with SMTP id
 a640c23a62f3a-ae0bebec056mr440686166b.23.1750877855349; Wed, 25 Jun 2025
 11:57:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624230636.3233059-1-neil@brown.name> <20250624230636.3233059-13-neil@brown.name>
In-Reply-To: <20250624230636.3233059-13-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 25 Jun 2025 20:57:23 +0200
X-Gm-Features: Ac12FXyRvf8F1ACdv7-DQegcDA6dlgnqWzjfcRFTLNTVHbJNAsDudGBwoE3T4LY
Message-ID: <CAOQ4uxjYCq1j2_QXVQhonhdCh4vHn+Q1dowADdQh61tKmRmfpw@mail.gmail.com>
Subject: Re: [PATCH 12/12] ovl: rename ovl_cleanup_unlocked() to ovl_cleanup()
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 1:07=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> The only remaining user of ovl_cleanup() is ovl_cleanup_locked(), so we
> no longer need both.
>
> This patch moves ovl_cleanup() code into ovl_cleanup_locked(), and then
> renames ovl_cleanup_locked() to ovl_cleanup().
>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/overlayfs/copy_up.c   |  4 +--
>  fs/overlayfs/dir.c       | 55 ++++++++++++++++++----------------------
>  fs/overlayfs/overlayfs.h |  3 +--
>  fs/overlayfs/readdir.c   | 10 ++++----
>  fs/overlayfs/super.c     |  4 +--
>  fs/overlayfs/util.c      |  2 +-
>  6 files changed, 35 insertions(+), 43 deletions(-)
>
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index 884c738b67ff..baaa46d00de6 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -569,7 +569,7 @@ static int ovl_create_index(struct dentry *dentry, co=
nst struct ovl_fh *fh,
>         unlock_rename(indexdir, indexdir);
>  out:
>         if (err)
> -               ovl_cleanup_unlocked(ofs, indexdir, temp);
> +               ovl_cleanup(ofs, indexdir, temp);
>         dput(temp);
>  free_name:
>         kfree(name.name);
> @@ -856,7 +856,7 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx=
 *c)
>  cleanup:
>         unlock_rename(c->workdir, c->destdir);
>  cleanup_unlocked:
> -       ovl_cleanup_unlocked(ofs, c->workdir, temp);
> +       ovl_cleanup(ofs, c->workdir, temp);
>         dput(temp);
>         goto out;
>  }
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 9a43ab23cf01..77a09b0190a2 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -24,16 +24,24 @@ MODULE_PARM_DESC(redirect_max,
>
>  static int ovl_set_redirect(struct dentry *dentry, bool samedir);
>
> -int ovl_cleanup(struct ovl_fs *ofs, struct inode *wdir, struct dentry *w=
dentry)
> +int ovl_cleanup(struct ovl_fs *ofs, struct dentry *workdir,
> +                        struct dentry *wdentry)
>  {
>         int err;
>
> -       dget(wdentry);
> -       if (d_is_dir(wdentry))
> -               err =3D ovl_do_rmdir(ofs, wdir, wdentry);
> -       else
> -               err =3D ovl_do_unlink(ofs, wdir, wdentry);
> -       dput(wdentry);
> +       inode_lock_nested(workdir->d_inode, I_MUTEX_PARENT);
> +       if (wdentry->d_parent =3D=3D workdir) {
> +               struct inode *wdir =3D workdir->d_inode;
> +
> +               dget(wdentry);
> +               if (d_is_dir(wdentry))
> +                       err =3D ovl_do_rmdir(ofs, wdir, wdentry);
> +               else
> +                       err =3D ovl_do_unlink(ofs, wdir, wdentry);
> +               dput(wdentry);
> +       } else
> +               err =3D -EINVAL;
> +       inode_unlock(workdir->d_inode);
>

The way that it looks now, I would rather keep it as
static inline ovl_cleanup_locked() helper
but I think that with the lock_parent() that I suggested in patch 2
the unified ovl_cleanup() version would be fine.

Thanks,
Amir.

>         if (err) {
>                 pr_err("cleanup of '%pd2' failed (%i)\n",
> @@ -43,21 +51,6 @@ int ovl_cleanup(struct ovl_fs *ofs, struct inode *wdir=
, struct dentry *wdentry)
>         return err;
>  }
>
> -int ovl_cleanup_unlocked(struct ovl_fs *ofs, struct dentry *workdir,
> -                        struct dentry *wdentry)
> -{
> -       int err;
> -
> -       inode_lock_nested(workdir->d_inode, I_MUTEX_PARENT);
> -       if (wdentry->d_parent =3D=3D workdir)
> -               ovl_cleanup(ofs, workdir->d_inode, wdentry);
> -       else
> -               err =3D -EINVAL;
> -       inode_unlock(workdir->d_inode);
> -
> -       return err;
> -}
> -
>  struct dentry *ovl_lookup_temp(struct ovl_fs *ofs, struct dentry *workdi=
r)
>  {
>         struct dentry *temp;
> @@ -153,14 +146,14 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, st=
ruct dentry *dir,
>         if (err)
>                 goto kill_whiteout;
>         if (flags)
> -               ovl_cleanup_unlocked(ofs, ofs->workdir, dentry);
> +               ovl_cleanup(ofs, ofs->workdir, dentry);
>
>  out:
>         dput(whiteout);
>         return err;
>
>  kill_whiteout:
> -       ovl_cleanup_unlocked(ofs, ofs->workdir, whiteout);
> +       ovl_cleanup(ofs, ofs->workdir, whiteout);
>         goto out;
>  }
>
> @@ -357,7 +350,7 @@ static int ovl_create_upper(struct dentry *dentry, st=
ruct inode *inode,
>         return err;
>
>  out_cleanup:
> -       ovl_cleanup_unlocked(ofs, upperdir, newdentry);
> +       ovl_cleanup(ofs, upperdir, newdentry);
>         dput(newdentry);
>         goto out;
>  }
> @@ -422,7 +415,7 @@ static struct dentry *ovl_clear_empty(struct dentry *=
dentry,
>         unlock_rename(workdir, upperdir);
>
>         ovl_cleanup_whiteouts(ofs, upper, list);
> -       ovl_cleanup_unlocked(ofs, workdir, upper);
> +       ovl_cleanup(ofs, workdir, upper);
>
>         /* dentry's upper doesn't match now, get rid of it */
>         d_drop(dentry);
> @@ -432,7 +425,7 @@ static struct dentry *ovl_clear_empty(struct dentry *=
dentry,
>  out_cleanup:
>         unlock_rename(workdir, upperdir);
>  out_cleanup_unlocked:
> -       ovl_cleanup_unlocked(ofs, workdir, opaquedir);
> +       ovl_cleanup(ofs, workdir, opaquedir);
>         dput(opaquedir);
>  out:
>         return ERR_PTR(err);
> @@ -527,7 +520,7 @@ static int ovl_create_over_whiteout(struct dentry *de=
ntry, struct inode *inode,
>                 if (err)
>                         goto out_cleanup;
>
> -               ovl_cleanup_unlocked(ofs, workdir, upper);
> +               ovl_cleanup(ofs, workdir, upper);
>         } else {
>                 err =3D ovl_do_rename(ofs, workdir, newdentry, upperdir, =
upper, 0);
>                 unlock_rename(workdir, upperdir);
> @@ -537,7 +530,7 @@ static int ovl_create_over_whiteout(struct dentry *de=
ntry, struct inode *inode,
>         ovl_dir_modified(dentry->d_parent, false);
>         err =3D ovl_instantiate(dentry, inode, newdentry, hardlink, NULL)=
;
>         if (err) {
> -               ovl_cleanup_unlocked(ofs, upperdir, newdentry);
> +               ovl_cleanup(ofs, upperdir, newdentry);
>                 dput(newdentry);
>         }
>  out_dput:
> @@ -552,7 +545,7 @@ static int ovl_create_over_whiteout(struct dentry *de=
ntry, struct inode *inode,
>  out_cleanup_locked:
>         unlock_rename(workdir, upperdir);
>  out_cleanup:
> -       ovl_cleanup_unlocked(ofs, workdir, newdentry);
> +       ovl_cleanup(ofs, workdir, newdentry);
>         dput(newdentry);
>         goto out_dput;
>  }
> @@ -1279,7 +1272,7 @@ static int ovl_rename(struct mnt_idmap *idmap, stru=
ct inode *olddir,
>         unlock_rename(new_upperdir, old_upperdir);
>
>         if (cleanup_whiteout)
> -               ovl_cleanup_unlocked(ofs, old_upperdir, newdentry);
> +               ovl_cleanup(ofs, old_upperdir, newdentry);
>
>         if (overwrite && d_inode(new)) {
>                 if (new_is_dir)
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 3d89e1c8d565..2f09c3c825f2 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -851,8 +851,7 @@ struct ovl_cattr {
>  struct dentry *ovl_create_real(struct ovl_fs *ofs,
>                                struct dentry *parent, struct dentry *newd=
entry,
>                                struct ovl_cattr *attr);
> -int ovl_cleanup(struct ovl_fs *ofs, struct inode *dir, struct dentry *de=
ntry);
> -int ovl_cleanup_unlocked(struct ovl_fs *ofs, struct dentry *workdir, str=
uct dentry *dentry);
> +int ovl_cleanup(struct ovl_fs *ofs, struct dentry *workdir, struct dentr=
y *dentry);
>  struct dentry *ovl_lookup_temp(struct ovl_fs *ofs, struct dentry *workdi=
r);
>  struct dentry *ovl_create_temp(struct ovl_fs *ofs, struct dentry *workdi=
r,
>                                struct ovl_cattr *attr);
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index fd98444dacef..9af73da04d2a 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -1048,7 +1048,7 @@ void ovl_cleanup_whiteouts(struct ovl_fs *ofs, stru=
ct dentry *upper,
>                         continue;
>                 }
>                 if (dentry->d_inode)
> -                       ovl_cleanup_unlocked(ofs, upper, dentry);
> +                       ovl_cleanup(ofs, upper, dentry);
>                 dput(dentry);
>         }
>  }
> @@ -1159,7 +1159,7 @@ int ovl_workdir_cleanup(struct ovl_fs *ofs, struct =
dentry *parent,
>         int err;
>
>         if (!d_is_dir(dentry) || level > 1) {
> -               return ovl_cleanup_unlocked(ofs, parent, dentry);
> +               return ovl_cleanup(ofs, parent, dentry);
>         }
>
>         inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
> @@ -1173,7 +1173,7 @@ int ovl_workdir_cleanup(struct ovl_fs *ofs, struct =
dentry *parent,
>
>                 err =3D ovl_workdir_cleanup_recurse(ofs, &path, level + 1=
);
>                 if (!err)
> -                       err =3D ovl_cleanup_unlocked(ofs, parent, dentry)=
;
> +                       err =3D ovl_cleanup(ofs, parent, dentry);
>         }
>
>         return err;
> @@ -1224,7 +1224,7 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
>                         goto next;
>                 } else if (err =3D=3D -ESTALE) {
>                         /* Cleanup stale index entries */
> -                       err =3D ovl_cleanup_unlocked(ofs, indexdir, index=
);
> +                       err =3D ovl_cleanup(ofs, indexdir, index);
>                 } else if (err !=3D -ENOENT) {
>                         /*
>                          * Abort mount to avoid corrupting the index if
> @@ -1240,7 +1240,7 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
>                         err =3D ovl_cleanup_and_whiteout(ofs, indexdir, i=
ndex);
>                 } else {
>                         /* Cleanup orphan index entries */
> -                       err =3D ovl_cleanup_unlocked(ofs, indexdir, index=
);
> +                       err =3D ovl_cleanup(ofs, indexdir, index);
>                 }
>
>                 if (err)
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 1ba1bffc4547..6dbfbad8aeca 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -594,11 +594,11 @@ static int ovl_check_rename_whiteout(struct ovl_fs =
*ofs)
>
>         /* Best effort cleanup of whiteout and temp file */
>         if (err)
> -               ovl_cleanup_unlocked(ofs, workdir, whiteout);
> +               ovl_cleanup(ofs, workdir, whiteout);
>         dput(whiteout);
>
>  cleanup_temp:
> -       ovl_cleanup_unlocked(ofs, workdir, temp);
> +       ovl_cleanup(ofs, workdir, temp);
>         release_dentry_name_snapshot(&name);
>         dput(temp);
>         dput(dest);
> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index 565f7d8c0147..b2c3e7be957b 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -1116,7 +1116,7 @@ static void ovl_cleanup_index(struct dentry *dentry=
)
>                                                indexdir, index);
>         } else {
>                 /* Cleanup orphan index entries */
> -               err =3D ovl_cleanup_unlocked(ofs, indexdir, index);
> +               err =3D ovl_cleanup(ofs, indexdir, index);
>         }
>
>         if (err)
> --
> 2.49.0
>

