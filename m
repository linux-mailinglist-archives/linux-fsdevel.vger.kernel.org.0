Return-Path: <linux-fsdevel+bounces-52967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1318AE8D19
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 20:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56D89188C1C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 18:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9251F2D5C82;
	Wed, 25 Jun 2025 18:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DI7Kj+9A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50F61CAA7B;
	Wed, 25 Jun 2025 18:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750877690; cv=none; b=sJSH8fPYj0ZQJtx54eEmbs2jGa3CIdlVSa1f7pZPCHTl7ouAiEv7vb+1dx38mtw7YKGTcmA2LMknF0x0PUQ8L+WSfLoP+budZXMNnjeVpE5Rkn5DJ2njzPRVRw2uuU/86v5RMYAQeBo1DZj0T4xKJrAhjU+H8pz/KqUUn4w3il4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750877690; c=relaxed/simple;
	bh=34bkaC6muZ1T2cBnMF0jRBSyYCAhNY7E0Wi2wp12RWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tD6p45GXQr0dUoZuqNV8Y1cKuC4TvsQzxO59nUrG791DCH7nsW1VveAItE/DZWgBUKaZ4q9SGGdT8BetYa2IxkUcWqwmAYsZ4BOunIcWFeLhvaFat9rvrowyQnM69F2ZbtBmsStBPTs8D+njstSQg1iGT80L1Q0Oc+t2zBz2USI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DI7Kj+9A; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-60c63a9bbabso628262a12.0;
        Wed, 25 Jun 2025 11:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750877686; x=1751482486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWoAlDFTymk8HdCMWfca4zZLZQTGPvOHymatY5l6RDE=;
        b=DI7Kj+9AcIIKWviPZS4i9sUXW8mbUimp9lt9wHP7g08aXWrNNgiuxKIyHbf5TiipQi
         PJp7C4yxwwDzqEwk/jZUJGBX/GKEn527bo6Hmb9DYjUV2knUOdaCoy2EGAh0jp/9R6rd
         dRcXaG3bD2pJRbHUzufI0vaF148gjZt1fShiW1CSaswbgtRBB38PFm3hxZvacmg9Qg6W
         h8JtglyASNNb+8VuTuWsua2tqBlUTw7da+FUVa73VSOvHlq86ye9Kpc2EQW36QcVGvVf
         LFVbFHdSN9DptW5YfiUXoYa8++XTbVZP39b8qUmOnlj9I6Cs/j1d2QPwd3yV68vrKfzY
         MUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750877686; x=1751482486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pWoAlDFTymk8HdCMWfca4zZLZQTGPvOHymatY5l6RDE=;
        b=O+Smknc0cbz3/pQT1iKm+JMjSO0u+n494sU8zWXHVSWFTWB0QhkVIKTq2hoy3l6n6v
         cnYrIV6a97GoaiCVUXtwlSTSEJBy3fxEBiTX8u50sF5K/+INmGFze4O0ZZFV0Qu254ij
         MhskQO8Y526j+sNhvKPN4yheyqr6sDwPqF/gJFhzuYgAhzqnuM8c3xTau3MPntVCpJR7
         laKb1JPZvovpqQ8y59C1meCDVc+LuQFeQtN528IGlqTkfd9LxergGmdJtXXDpfB2Lxo/
         GENYpOQLqxTiXaS3ez+b4BFljd6LwJlRxXwr9QJYyhl+qUhxYxWsREX+Ttvi/KPp4e1b
         oxvA==
X-Forwarded-Encrypted: i=1; AJvYcCVqU7iSUKGdf8W8Yw0uFrTHfdw05MfG3x29uJdIFDV1vzqwgcvYYOfmAAMGkCbjBKptWkJIzOJ2/+0Z1Kah@vger.kernel.org, AJvYcCXYM0bNIZx9Hn91b1DWmZ1++2LwMX4z5IvK2YqoVKoSrXQhizdhldrVQNNw6bml5NrjsPAcdJE3Y+sHtvibtg==@vger.kernel.org
X-Gm-Message-State: AOJu0YycRc+CR7JnL0pam9uB1D4OIYjb8Dql5bvccO6xDrdlJhDyI2tt
	petnKnK2VxObSB78JP5RAqCjnMc2hVA18+NU0apDH17rO8ip4Als/6+XZ5QxLkPqodgPY51xfDQ
	2U4BAkw5GyLdiNYVT5YN/d/pZiovMl6U=
X-Gm-Gg: ASbGnctFRM4x2FbMn0ra2narQ9Txha+SwnxbENoL1NRBCXNTY+RT80DiTe+DPEDhQZK
	oAP3Kouc/yxXTW+X55LTTJu2PR1wjJuW0YooDGJPpc4Py0k2OWn/K/CnZMBtHdbx9Z4alF5X46k
	TPVv4ZXZGq5Aw3OIgpMWxIsc+/CTprdHObcdtxS5r2wkA=
X-Google-Smtp-Source: AGHT+IEM6A0Olxajw1m0eBBgW7+SUGg74M+fFD64tDKzJ1F7LbsNjLk66yAD8yd0jO8tGIsj+lujjEgh6nF4K4TtpVQ=
X-Received: by 2002:a17:907:72c8:b0:aca:d29e:53f1 with SMTP id
 a640c23a62f3a-ae0d25ab39fmr86555866b.12.1750877685837; Wed, 25 Jun 2025
 11:54:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624230636.3233059-1-neil@brown.name> <20250624230636.3233059-10-neil@brown.name>
In-Reply-To: <20250624230636.3233059-10-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 25 Jun 2025 20:54:34 +0200
X-Gm-Features: Ac12FXx526oxfI8C8gkd29u9Xtv3IeWgtv-z6d8VoCLnB0wRrZ1oRW8d9TnxexQ
Message-ID: <CAOQ4uxjr4TnZCpQoyqyN9nQ8KoJX81Rsxu__GK+30FWVT-o_UQ@mail.gmail.com>
Subject: Re: [PATCH 09/12] ovl: whiteout locking changes
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 1:07=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> ovl_writeout() relies on the workdir i_rwsem to provide exclusive access
> to ofs->writeout which it manipulates.  Rather than depending on this,

typo writeout/whiteout all over this commit message

> add a new mutex, "writeout_lock" to explicitly provide the required
> locking.
>
> Then take the lock on workdir only when needed - to lookup the temp name
> and to do the whiteout or link.  So ovl_writeout() and similarly
> ovl_cleanup_and_writeout() and ovl_workdir_cleanup() are now called
> without the lock held.  This requires changes to
> ovl_remove_and_whiteout(), ovl_cleanup_index(), ovl_indexdir_cleanup(),
> and ovl_workdir_create().
>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/overlayfs/dir.c       | 71 +++++++++++++++++++++-------------------
>  fs/overlayfs/overlayfs.h |  2 +-
>  fs/overlayfs/ovl_entry.h |  1 +
>  fs/overlayfs/params.c    |  2 ++
>  fs/overlayfs/readdir.c   | 31 ++++++++++--------
>  fs/overlayfs/super.c     |  9 +++--
>  fs/overlayfs/util.c      |  7 ++--
>  7 files changed, 67 insertions(+), 56 deletions(-)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 5afe17cee305..78b0d956b0ac 100644
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
> @@ -85,47 +84,51 @@ static struct dentry *ovl_whiteout(struct ovl_fs *ofs=
)
>         struct dentry *workdir =3D ofs->workdir;
>         struct inode *wdir =3D workdir->d_inode;
>
> +       mutex_lock(&ofs->whiteout_lock);
>         if (!ofs->whiteout) {
> +               inode_lock(wdir);
>                 whiteout =3D ovl_lookup_temp(ofs, workdir);
> +               if (!IS_ERR(whiteout)) {
> +                       err =3D ovl_do_whiteout(ofs, wdir, whiteout);
> +                       if (err) {
> +                               dput(whiteout);
> +                               whiteout =3D ERR_PTR(err);
> +                       }
> +               }
> +               inode_unlock(wdir);
>                 if (IS_ERR(whiteout))
>                         goto out;
> -
> -               err =3D ovl_do_whiteout(ofs, wdir, whiteout);
> -               if (err) {
> -                       dput(whiteout);
> -                       whiteout =3D ERR_PTR(err);
> -                       goto out;
> -               }
>                 ofs->whiteout =3D whiteout;
>         }
>
>         if (!ofs->no_shared_whiteout) {
> +               inode_lock(wdir);
>                 whiteout =3D ovl_lookup_temp(ofs, workdir);
> -               if (IS_ERR(whiteout))
> -                       goto out;
> -
> -               err =3D ovl_do_link(ofs, ofs->whiteout, wdir, whiteout);
> -               if (!err)
> +               if (!IS_ERR(whiteout)) {
> +                       err =3D ovl_do_link(ofs, ofs->whiteout, wdir, whi=
teout);
> +                       if (err) {
> +                               dput(whiteout);
> +                               whiteout =3D ERR_PTR(err);
> +                       }
> +               }
> +               inode_unlock(wdir);
> +               if (!IS_ERR(whiteout) || PTR_ERR(whiteout) !=3D -EMLINK)
>                         goto out;
>
> -               if (err !=3D -EMLINK) {
> -                       pr_warn("Failed to link whiteout - disabling whit=
eout inode sharing(nlink=3D%u, err=3D%i)\n",
> -                               ofs->whiteout->d_inode->i_nlink, err);
> -                       ofs->no_shared_whiteout =3D true;
> -               }
> -               dput(whiteout);

Where did this dput go?

> +               pr_warn("Failed to link whiteout - disabling whiteout ino=
de sharing(nlink=3D%u, err=3D%i)\n",
> +                       ofs->whiteout->d_inode->i_nlink, err);
> +               ofs->no_shared_whiteout =3D true;
>         }
>         whiteout =3D ofs->whiteout;
>         ofs->whiteout =3D NULL;
>  out:
> +       mutex_unlock(&ofs->whiteout_lock);
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
> @@ -138,18 +141,26 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, st=
ruct dentry *dir,
>         if (d_is_dir(dentry))
>                 flags =3D RENAME_EXCHANGE;
>
> -       err =3D ovl_do_rename(ofs, ofs->workdir, whiteout, dir, dentry, f=
lags);
> +       err =3D ovl_lock_rename_workdir(ofs->workdir, dir);
> +       if (!err) {
> +               if (whiteout->d_parent =3D=3D ofs->workdir)
> +                       err =3D ovl_do_rename(ofs, ofs->workdir, whiteout=
, dir,
> +                                           dentry, flags);
> +               else
> +                       err =3D -EINVAL;
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
> @@ -777,15 +788,11 @@ static int ovl_remove_and_whiteout(struct dentry *d=
entry,
>                         goto out;
>         }
>
> -       err =3D ovl_lock_rename_workdir(workdir, upperdir);
> -       if (err)
> -               goto out_dput;
> -
> -       upper =3D ovl_lookup_upper(ofs, dentry->d_name.name, upperdir,
> -                                dentry->d_name.len);
> +       upper =3D ovl_lookup_upper_unlocked(ofs, dentry->d_name.name, upp=
erdir,
> +                                         dentry->d_name.len);
>         err =3D PTR_ERR(upper);
>         if (IS_ERR(upper))
> -               goto out_unlock;
> +               goto out_dput;
>
>         err =3D -ESTALE;
>         if ((opaquedir && upper !=3D opaquedir) ||
> @@ -803,8 +810,6 @@ static int ovl_remove_and_whiteout(struct dentry *den=
try,
>         d_drop(dentry);
>  out_dput_upper:
>         dput(upper);
> -out_unlock:
> -       unlock_rename(workdir, upperdir);
>  out_dput:
>         dput(opaquedir);
>  out:
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 508003e26e08..25378b81251e 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -732,7 +732,7 @@ void ovl_cleanup_whiteouts(struct ovl_fs *ofs, struct=
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
> diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
> index afb7762f873f..4c1bae935ced 100644
> --- a/fs/overlayfs/ovl_entry.h
> +++ b/fs/overlayfs/ovl_entry.h
> @@ -88,6 +88,7 @@ struct ovl_fs {
>         /* Shared whiteout cache */
>         struct dentry *whiteout;
>         bool no_shared_whiteout;
> +       struct mutex whiteout_lock;
>         /* r/o snapshot of upperdir sb's only taken on volatile mounts */
>         errseq_t errseq;
>  };
> diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
> index f42488c01957..cb1a17c066cd 100644
> --- a/fs/overlayfs/params.c
> +++ b/fs/overlayfs/params.c
> @@ -797,6 +797,8 @@ int ovl_init_fs_context(struct fs_context *fc)
>         fc->s_fs_info           =3D ofs;
>         fc->fs_private          =3D ctx;
>         fc->ops                 =3D &ovl_context_ops;
> +
> +       mutex_init(&ofs->whiteout_lock);
>         return 0;
>
>  out_err:
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index 2a222b8185a3..fd98444dacef 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -1141,7 +1141,8 @@ static int ovl_workdir_cleanup_recurse(struct ovl_f=
s *ofs, const struct path *pa
>                 if (IS_ERR(dentry))
>                         continue;
>                 if (dentry->d_inode)
> -                       err =3D ovl_workdir_cleanup(ofs, dir, path->mnt, =
dentry, level);
> +                       err =3D ovl_workdir_cleanup(ofs, path->dentry, pa=
th->mnt,
> +                                                 dentry, level);
>                 dput(dentry);
>                 if (err)
>                         break;
> @@ -1152,24 +1153,27 @@ static int ovl_workdir_cleanup_recurse(struct ovl=
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
>         if (!d_is_dir(dentry) || level > 1) {
> -               return ovl_cleanup(ofs, dir, dentry);
> +               return ovl_cleanup_unlocked(ofs, parent, dentry);
>         }
>
> -       err =3D ovl_do_rmdir(ofs, dir, dentry);
> +       inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
> +       if (dentry->d_parent =3D=3D parent)
> +               err =3D ovl_do_rmdir(ofs, parent->d_inode, dentry);
> +       else
> +               err =3D -EINVAL;
> +       inode_unlock(parent->d_inode);
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
> @@ -1180,7 +1184,6 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
>         int err;
>         struct dentry *indexdir =3D ofs->workdir;
>         struct dentry *index =3D NULL;
> -       struct inode *dir =3D indexdir->d_inode;
>         struct path path =3D { .mnt =3D ovl_upper_mnt(ofs), .dentry =3D i=
ndexdir };
>         LIST_HEAD(list);
>         struct ovl_cache_entry *p;
> @@ -1194,7 +1197,6 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
>         if (err)
>                 goto out;
>
> -       inode_lock_nested(dir, I_MUTEX_PARENT);
>         list_for_each_entry(p, &list, l_node) {
>                 if (p->name[0] =3D=3D '.') {
>                         if (p->len =3D=3D 1)
> @@ -1202,7 +1204,8 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
>                         if (p->len =3D=3D 2 && p->name[1] =3D=3D '.')
>                                 continue;
>                 }
> -               index =3D ovl_lookup_upper(ofs, p->name, indexdir, p->len=
);
> +               index =3D ovl_lookup_upper_unlocked(ofs, p->name, indexdi=
r,
> +                                                 p->len);
>                 if (IS_ERR(index)) {
>                         err =3D PTR_ERR(index);
>                         index =3D NULL;
> @@ -1210,7 +1213,8 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
>                 }
>                 /* Cleanup leftover from index create/cleanup attempt */
>                 if (index->d_name.name[0] =3D=3D '#') {
> -                       err =3D ovl_workdir_cleanup(ofs, dir, path.mnt, i=
ndex, 1);
> +                       err =3D ovl_workdir_cleanup(ofs, indexdir, path.m=
nt,
> +                                                 index, 1);
>                         if (err)
>                                 break;
>                         goto next;
> @@ -1220,7 +1224,7 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
>                         goto next;
>                 } else if (err =3D=3D -ESTALE) {
>                         /* Cleanup stale index entries */
> -                       err =3D ovl_cleanup(ofs, dir, index);
> +                       err =3D ovl_cleanup_unlocked(ofs, indexdir, index=
);
>                 } else if (err !=3D -ENOENT) {
>                         /*
>                          * Abort mount to avoid corrupting the index if
> @@ -1236,7 +1240,7 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
>                         err =3D ovl_cleanup_and_whiteout(ofs, indexdir, i=
ndex);
>                 } else {
>                         /* Cleanup orphan index entries */
> -                       err =3D ovl_cleanup(ofs, dir, index);
> +                       err =3D ovl_cleanup_unlocked(ofs, indexdir, index=
);
>                 }
>
>                 if (err)
> @@ -1247,7 +1251,6 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
>                 index =3D NULL;
>         }
>         dput(index);
> -       inode_unlock(dir);
>  out:
>         ovl_cache_free(&list);
>         if (err)
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 576b5c3b537c..3583e359655f 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -299,8 +299,8 @@ static struct dentry *ovl_workdir_create(struct ovl_f=
s *ofs,
>         int err;
>         bool retried =3D false;
>
> -       inode_lock_nested(dir, I_MUTEX_PARENT);
>  retry:
> +       inode_lock_nested(dir, I_MUTEX_PARENT);
>         work =3D ovl_lookup_upper(ofs, name, ofs->workbasedir, strlen(nam=
e));
>
>         if (!IS_ERR(work)) {
> @@ -311,6 +311,7 @@ static struct dentry *ovl_workdir_create(struct ovl_f=
s *ofs,
>
>                 if (work->d_inode) {
>                         err =3D -EEXIST;
> +                       inode_unlock(dir);
>                         if (retried)
>                                 goto out_dput;
>
> @@ -318,7 +319,8 @@ static struct dentry *ovl_workdir_create(struct ovl_f=
s *ofs,
>                                 goto out_unlock;
>
>                         retried =3D true;
> -                       err =3D ovl_workdir_cleanup(ofs, dir, mnt, work, =
0);
> +                       err =3D ovl_workdir_cleanup(ofs, ofs->workbasedir=
, mnt,
> +                                                 work, 0);
>                         dput(work);
>                         if (err =3D=3D -EINVAL) {
>                                 work =3D ERR_PTR(err);
> @@ -328,6 +330,7 @@ static struct dentry *ovl_workdir_create(struct ovl_f=
s *ofs,
>                 }
>
>                 work =3D ovl_do_mkdir(ofs, dir, work, attr.ia_mode);
> +               inode_unlock(dir);
>                 err =3D PTR_ERR(work);
>                 if (IS_ERR(work))
>                         goto out_err;
> @@ -365,11 +368,11 @@ static struct dentry *ovl_workdir_create(struct ovl=
_fs *ofs,
>                 if (err)
>                         goto out_dput;
>         } else {
> +               inode_unlock(dir);
>                 err =3D PTR_ERR(work);
>                 goto out_err;
>         }
>  out_unlock:

This label name is now misleading

> -       inode_unlock(dir);
>         return work;
>

Thanks,
Amir.

