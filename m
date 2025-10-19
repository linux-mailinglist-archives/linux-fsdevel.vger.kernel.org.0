Return-Path: <linux-fsdevel+bounces-64613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E3DBEE2B9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Oct 2025 12:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B15853E68DF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Oct 2025 10:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C136D2E2EEF;
	Sun, 19 Oct 2025 10:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUoNz66S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FCD1B4223
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Oct 2025 10:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760868916; cv=none; b=a/dLimmPnPUSej/FCoKsDb/K+b0lLvMrBbYMOfnK5T33qwr3BlZIDNu/Tlccu+k+Yok3O1QjTmxoa4hTCCdpAmlSyz75tvmiRXzfBzn9ktrHNx4VbQARx9sxAihn46es3Y8XOoEqPZtIJ6qKb/DGipOSIsLqZf1a1qIoX5NGJOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760868916; c=relaxed/simple;
	bh=4CRPgWtM3j91DKCIvbDSy92nc09dVtgbJc7Icvvrbd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W94mGUlhyPQ066onlOCoIkbIsHrpAqjLb2+th0V8pvEp2YpvF+3BWm0E+8V1elX6viAiOStRaB1FjgJXn1p5Xf/NAo6W5lYWn3uP1g0Fl1TKtgqUXknoGeI9V5H1xBP/fayCotknZNRmUpCZSnCojT8+QCilk0bFqP2Zk8+p+5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUoNz66S; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-63994113841so5830927a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Oct 2025 03:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760868912; x=1761473712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65TwLyokT9f7+dXRtYmxr/UA1zc8XVUWRlaM2GyEWqg=;
        b=LUoNz66SKKWyQ0eX8kxWYvaMswQcEPqMBoVD5AdCrDinIjGX7PZgTW1Yy0r75nbNWI
         f+tvSrNF00HZ6OXNUD7RztsJyynHV31fFpTDABRdjVZqowSgmViuwlK5YaxjD3yNQGif
         7Zj2bJIfr35sjdccKXRCPQh4OAdpgZs+kD3rrqBGmxkIV9OqX5TR5VIzjELuR+Myr+rY
         wwqFoY/4XfqrN2Li4pBy34e1ekryp6nZV1RSPVyMELcVHc4/+ROK1eONGkC8Naafm1B2
         9oUL0Myld+hQi+EIXLOSUIdeH7OoBFwsMHsgRp17h1otyVIW7XcM/KlqL96pWtkoE7o9
         ocjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760868912; x=1761473712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=65TwLyokT9f7+dXRtYmxr/UA1zc8XVUWRlaM2GyEWqg=;
        b=V4tnQ4cYPKWiZPL9BGlznVLqIF5ODY+n6AJ0dKmS8qwcD9KujVg94dSANgZD3t1qoo
         BN1lsKA/i57c+TyC3/Ta/FMs5+ULgYCqst5BFuW3zAFMwywXm6CU+9qvRDzcH7lrqqgt
         hR+d6+U0T4WBLJPMrcUIh53olu+fexUSOV5FrNpjWn/PAgbKk8vpC2GbjvdxJWhDivgN
         e7MJyoCVn9qFwWCPvaqnoucgYVAK09XXVIN+Sw+o7pJt3uO8gu69hHVXSNBwINaLb4un
         D/ClNFiQ9yip/uRH0ubVI1pMnPTm/c/J37XC0hFH1zUwv+ag+yoKrjvKKC7o3pHaloQ5
         iSSQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/dCKhjEi6/VLhoffi+yzxcRrhbu+Q5DNWmblhxphpo5YE1u+hXKwCeSXJlBBaB5LdJqbg7PAWVDejVMoP@vger.kernel.org
X-Gm-Message-State: AOJu0YzPSxK46ZqagI/j+dn/GA/HL9lwY8WpQZTnvHjUIhp61Ajh4Ips
	dIyfKFiFFRoGytnz8RrmTSLPnthmCYcjBlYVnuKLc3J8UzZhGDbUf9ho8GkMASa39vL2CR5gHCc
	9YzzdoIveWqhYzisp+8AFAnAe3H9xMRY=
X-Gm-Gg: ASbGncveGWTrmLrtvHgJ5blCB7q+Un8K8cdYDDIHUXm7vZPTfsu1KbD4144EmyrW4DB
	Np9h8GVZkdnpmsKXD/Xoq8AA03I9Fe6/ZFmGpp8MBRMyIbqcQled0GZUMinZ7s2UKy7s8Gy91pT
	An7GZXCUVjM5KD+ozGtGhD6ZM+thZrSR4aH8yCFze7Zd2FQ2cVKq1cy7CNJfkSdmh6vmWQNNiBT
	aa6X6035VJsG9srPU1+Z8NeWvA35tVaQsFMkrQpQGQ8R9YS0wdIugag7PhWPhUOefPZAxg8z+Fn
	PlS4L9bXgpI0RSrAa/at+ASSIuso9A==
X-Google-Smtp-Source: AGHT+IHdK+sLWTZ5/t7kGYKcFQ4HmxS3FEhlpzGGf4Qp8vOy25rgCp1bdUCdm685u4ovw9gjI+xSkJWigvpFwn7swa0=
X-Received: by 2002:a05:6402:1e91:b0:62f:5424:7371 with SMTP id
 4fb4d7f45d1cf-63c1f631cb9mr9166849a12.8.1760868912326; Sun, 19 Oct 2025
 03:15:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015014756.2073439-1-neilb@ownmail.net> <20251015014756.2073439-7-neilb@ownmail.net>
In-Reply-To: <20251015014756.2073439-7-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 19 Oct 2025 12:15:01 +0200
X-Gm-Features: AS18NWCf4evCNHHuHDhhhQaxnkjvdUag9j3J6JrWP9q8yANDya1DGy38exX8zJ0
Message-ID: <CAOQ4uxgRx_QLJ9PbRqNHJn_=s59bD1RHjcvU1GCCyGbe6uJ_cA@mail.gmail.com>
Subject: Re: [PATCH v2 06/14] VFS: introduce start_creating_noperm() and start_removing_noperm()
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 3:48=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
>
> From: NeilBrown <neil@brown.name>
>
> xfs, fuse, ipc/mqueue need variants of start_creating or start_removing
> which do not check permissions.
> This patch adds _noperm versions of these functions.
>
> Note that do_mq_open() was only calling mntget() so it could call
> path_put() - it didn't really need an extra reference on the mnt.
> Now it doesn't call mntget() and uses end_creating() which does
> the dput() half of path_put().
>
> Signed-off-by: NeilBrown <neil@brown.name>

I noticed that both Jeff and I had already given our RVB on v1
and it's not here, so has this patch changed in some fundamental way since =
v1?
I could really use a "changed since v1" section when that happens.

Otherwise, feel free to add:
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/fuse/dir.c            | 19 +++++++---------
>  fs/namei.c               | 48 ++++++++++++++++++++++++++++++++++++++++
>  fs/xfs/scrub/orphanage.c | 11 ++++-----
>  include/linux/namei.h    |  2 ++
>  ipc/mqueue.c             | 31 +++++++++-----------------
>  5 files changed, 73 insertions(+), 38 deletions(-)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index ecaec0fea3a1..40ca94922349 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -1397,27 +1397,25 @@ int fuse_reverse_inval_entry(struct fuse_conn *fc=
, u64 parent_nodeid,
>         if (!parent)
>                 return -ENOENT;
>
> -       inode_lock_nested(parent, I_MUTEX_PARENT);
>         if (!S_ISDIR(parent->i_mode))
> -               goto unlock;
> +               goto put_parent;
>
>         err =3D -ENOENT;
>         dir =3D d_find_alias(parent);
>         if (!dir)
> -               goto unlock;
> +               goto put_parent;
>
> -       name->hash =3D full_name_hash(dir, name->name, name->len);
> -       entry =3D d_lookup(dir, name);
> +       entry =3D start_removing_noperm(dir, name);
>         dput(dir);
> -       if (!entry)
> -               goto unlock;
> +       if (IS_ERR(entry))
> +               goto put_parent;
>
>         fuse_dir_changed(parent);
>         if (!(flags & FUSE_EXPIRE_ONLY))
>                 d_invalidate(entry);
>         fuse_invalidate_entry_cache(entry);
>
> -       if (child_nodeid !=3D 0 && d_really_is_positive(entry)) {
> +       if (child_nodeid !=3D 0) {
>                 inode_lock(d_inode(entry));
>                 if (get_node_id(d_inode(entry)) !=3D child_nodeid) {
>                         err =3D -ENOENT;
> @@ -1445,10 +1443,9 @@ int fuse_reverse_inval_entry(struct fuse_conn *fc,=
 u64 parent_nodeid,
>         } else {
>                 err =3D 0;
>         }
> -       dput(entry);
>
> - unlock:
> -       inode_unlock(parent);
> +       end_removing(entry);
> + put_parent:
>         iput(parent);
>         return err;
>  }
> diff --git a/fs/namei.c b/fs/namei.c
> index ae833dfa277c..696e4b794416 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3275,6 +3275,54 @@ struct dentry *start_removing(struct mnt_idmap *id=
map, struct dentry *parent,
>  }
>  EXPORT_SYMBOL(start_removing);
>
> +/**
> + * start_creating_noperm - prepare to create a given name without permis=
sion checking
> + * @parent: directory in which to prepare to create the name
> + * @name:   the name to be created
> + *
> + * Locks are taken and a lookup in performed prior to creating
> + * an object in a directory.
> + *
> + * If the name already exists, a positive dentry is returned.
> + *
> + * Returns: a negative or positive dentry, or an error.
> + */
> +struct dentry *start_creating_noperm(struct dentry *parent,
> +                                    struct qstr *name)
> +{
> +       int err =3D lookup_noperm_common(name, parent);
> +
> +       if (err)
> +               return ERR_PTR(err);
> +       return start_dirop(parent, name, LOOKUP_CREATE);
> +}
> +EXPORT_SYMBOL(start_creating_noperm);
> +
> +/**
> + * start_removing_noperm - prepare to remove a given name without permis=
sion checking
> + * @parent: directory in which to find the name
> + * @name:   the name to be removed
> + *
> + * Locks are taken and a lookup in performed prior to removing
> + * an object from a directory.
> + *
> + * If the name doesn't exist, an error is returned.
> + *
> + * end_removing() should be called when removal is complete, or aborted.
> + *
> + * Returns: a positive dentry, or an error.
> + */
> +struct dentry *start_removing_noperm(struct dentry *parent,
> +                                    struct qstr *name)
> +{
> +       int err =3D lookup_noperm_common(name, parent);
> +
> +       if (err)
> +               return ERR_PTR(err);
> +       return start_dirop(parent, name, 0);
> +}
> +EXPORT_SYMBOL(start_removing_noperm);
> +
>  #ifdef CONFIG_UNIX98_PTYS
>  int path_pts(struct path *path)
>  {
> diff --git a/fs/xfs/scrub/orphanage.c b/fs/xfs/scrub/orphanage.c
> index 9c12cb844231..e732605924a1 100644
> --- a/fs/xfs/scrub/orphanage.c
> +++ b/fs/xfs/scrub/orphanage.c
> @@ -152,11 +152,10 @@ xrep_orphanage_create(
>         }
>
>         /* Try to find the orphanage directory. */
> -       inode_lock_nested(root_inode, I_MUTEX_PARENT);
> -       orphanage_dentry =3D lookup_noperm(&QSTR(ORPHANAGE), root_dentry)=
;
> +       orphanage_dentry =3D start_creating_noperm(root_dentry, &QSTR(ORP=
HANAGE));
>         if (IS_ERR(orphanage_dentry)) {
>                 error =3D PTR_ERR(orphanage_dentry);
> -               goto out_unlock_root;
> +               goto out_dput_root;
>         }
>
>         /*
> @@ -170,7 +169,7 @@ xrep_orphanage_create(
>                                              orphanage_dentry, 0750);
>                 error =3D PTR_ERR(orphanage_dentry);
>                 if (IS_ERR(orphanage_dentry))
> -                       goto out_unlock_root;
> +                       goto out_dput_orphanage;
>         }
>
>         /* Not a directory? Bail out. */
> @@ -200,9 +199,7 @@ xrep_orphanage_create(
>         sc->orphanage_ilock_flags =3D 0;
>
>  out_dput_orphanage:
> -       dput(orphanage_dentry);
> -out_unlock_root:
> -       inode_unlock(VFS_I(sc->mp->m_rootip));
> +       end_creating(orphanage_dentry, root_dentry);
>  out_dput_root:
>         dput(root_dentry);
>  out:
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index 9ee76e88f3dd..688e157d6afc 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -92,6 +92,8 @@ struct dentry *start_creating(struct mnt_idmap *idmap, =
struct dentry *parent,
>                               struct qstr *name);
>  struct dentry *start_removing(struct mnt_idmap *idmap, struct dentry *pa=
rent,
>                               struct qstr *name);
> +struct dentry *start_creating_noperm(struct dentry *parent, struct qstr =
*name);
> +struct dentry *start_removing_noperm(struct dentry *parent, struct qstr =
*name);
>
>  /**
>   * end_creating - finish action started with start_creating
> diff --git a/ipc/mqueue.c b/ipc/mqueue.c
> index 093551fe66a7..060e8e9c4f59 100644
> --- a/ipc/mqueue.c
> +++ b/ipc/mqueue.c
> @@ -913,13 +913,11 @@ static int do_mq_open(const char __user *u_name, in=
t oflag, umode_t mode,
>                 goto out_putname;
>
>         ro =3D mnt_want_write(mnt);       /* we'll drop it in any case */
> -       inode_lock(d_inode(root));
> -       path.dentry =3D lookup_noperm(&QSTR(name->name), root);
> +       path.dentry =3D start_creating_noperm(root, &QSTR(name->name));
>         if (IS_ERR(path.dentry)) {
>                 error =3D PTR_ERR(path.dentry);
>                 goto out_putfd;
>         }
> -       path.mnt =3D mntget(mnt);
>         error =3D prepare_open(path.dentry, oflag, ro, mode, name, attr);
>         if (!error) {
>                 struct file *file =3D dentry_open(&path, oflag, current_c=
red());
> @@ -928,13 +926,12 @@ static int do_mq_open(const char __user *u_name, in=
t oflag, umode_t mode,
>                 else
>                         error =3D PTR_ERR(file);
>         }
> -       path_put(&path);
>  out_putfd:
>         if (error) {
>                 put_unused_fd(fd);
>                 fd =3D error;
>         }
> -       inode_unlock(d_inode(root));
> +       end_creating(path.dentry, root);
>         if (!ro)
>                 mnt_drop_write(mnt);
>  out_putname:
> @@ -957,7 +954,7 @@ SYSCALL_DEFINE1(mq_unlink, const char __user *, u_nam=
e)
>         int err;
>         struct filename *name;
>         struct dentry *dentry;
> -       struct inode *inode =3D NULL;
> +       struct inode *inode;
>         struct ipc_namespace *ipc_ns =3D current->nsproxy->ipc_ns;
>         struct vfsmount *mnt =3D ipc_ns->mq_mnt;
>
> @@ -969,26 +966,20 @@ SYSCALL_DEFINE1(mq_unlink, const char __user *, u_n=
ame)
>         err =3D mnt_want_write(mnt);
>         if (err)
>                 goto out_name;
> -       inode_lock_nested(d_inode(mnt->mnt_root), I_MUTEX_PARENT);
> -       dentry =3D lookup_noperm(&QSTR(name->name), mnt->mnt_root);
> +       dentry =3D start_removing_noperm(mnt->mnt_root, &QSTR(name->name)=
);
>         if (IS_ERR(dentry)) {
>                 err =3D PTR_ERR(dentry);
> -               goto out_unlock;
> +               goto out_drop_write;
>         }
>
>         inode =3D d_inode(dentry);
> -       if (!inode) {
> -               err =3D -ENOENT;
> -       } else {
> -               ihold(inode);
> -               err =3D vfs_unlink(&nop_mnt_idmap, d_inode(dentry->d_pare=
nt),
> -                                dentry, NULL);
> -       }
> -       dput(dentry);
> -
> -out_unlock:
> -       inode_unlock(d_inode(mnt->mnt_root));
> +       ihold(inode);
> +       err =3D vfs_unlink(&nop_mnt_idmap, d_inode(dentry->d_parent),
> +                        dentry, NULL);
> +       end_removing(dentry);
>         iput(inode);
> +
> +out_drop_write:
>         mnt_drop_write(mnt);
>  out_name:
>         putname(name);
> --
> 2.50.0.107.gf914562f5916.dirty
>

