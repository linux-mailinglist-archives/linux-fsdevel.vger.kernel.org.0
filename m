Return-Path: <linux-fsdevel+bounces-62946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A67E4BA7077
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Sep 2025 14:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC0AC189A48E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Sep 2025 12:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1FC2DCF58;
	Sun, 28 Sep 2025 12:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHDQuwN1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C204286D6B
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Sep 2025 12:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759062403; cv=none; b=XKj+uOx1ahBZBKZN0kZqIUxtz0BGCBenp8HgoORo9Pqo3akfDlHJ37CR4IliXmeXzkspaqm4I4OOUm+KLfxTRoTm/j0L8A/OlmrVXNu2YsEztipj5lE630nY9YnCyAzNueh3uhlGOOC6WhnT9kNxg4S4vRTNhX1OhzXmne7X8b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759062403; c=relaxed/simple;
	bh=WleZ9fMPcCewau/as5yRtSyQqnwp7vNkryB7SZaVbTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o30oIxNOPtxXc7nS1HMynRwWBkZBfO/1oRUo6aPEe+7j90VrsKDLynEgvR3YoTxIYz2xuJJoieRMD0hQRhGaQnvWImwCiFp0hQ/PYCJeWTDPf/kfDZH8KXlgRnJPHy2ZrkCqU3ZRkn9ElxW7cB//uholypMc6g9W//2qwjpRvXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHDQuwN1; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b3727611d76so481511966b.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Sep 2025 05:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759062399; x=1759667199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=byrkqcj7J0nQsGjW69hgxSt740wZ0riNOmoAxvqy0Zc=;
        b=BHDQuwN1YqsB83cTbgYi2l4mEoSMnDuR5ouZIx4Y8FwZ1Pqz3WZP0PPe9f1lqHfXr1
         W6CCfr+a2qxcjGihldOIi7GGKEvOKwgvde5P3wfoKL4GzjITVYJs9L3HdzCxCHzFUIZn
         X+nV3hUzJULATopnD0Dm6GMJ96fCjBD2dXG9JoIyKPB+dITU+TJI28/ktEABf1vWY2gw
         xLvC8w+TrQ/ORddjZCvnuf1rsJTyr8uumlsPh6O5ehBNt3WnOe3y+dlwiA8RilYOtUyr
         wbzG0ly+OYVNdVM6aPFHovzcs6CbsMRVhBQs7CJpjF/LiLKcq0JOoj3eZVi7TUzg8zDs
         yFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759062399; x=1759667199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=byrkqcj7J0nQsGjW69hgxSt740wZ0riNOmoAxvqy0Zc=;
        b=gRlFYlXOtX0r0OBSHqx/OhIBtGu6LjIU8cy8Xa03GY+AXmDzNwxcSaPHVXShGwqNq0
         BVZgLUyYnYsOkSo8ewIqYbVthFRxArvPQC9pTw02soL1OXTENH4G0AaJpBzphqAbItbp
         c90kMWiSjlCBb2vSJbjXvo48IMHl3Aji+t7zFaobB/HjV58W/aRuNaAhzZCeodafTPtK
         Eok36o4RiFtEOZqT7Jy4xa64chDXD1BG1Szk2k9JWuj21hSogsoaOPju8R86YHEECopv
         Ejfhxfd1qlpeIuwdCMsQgRk8dlfaeUk45UZRmPG+RtLvI6SYxUo4iTsn/VmuSComYrDT
         lwCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKrTIAzG+GA22cei99hMU50vSlzmUR+XaQ/pBh1P577ZSgFElxYRRsx8kizvt7v668IxuONlcUP41mr8iO@vger.kernel.org
X-Gm-Message-State: AOJu0YwuPwarJsvfadTHHpo2u+FaKzsr1nM8VLFvjwiKirJF+MZ4kIut
	KqXGtJ9SblijEwQQqWoqZkmSsFLgRk72ZSoFyTuECgDNViUiFjChfs/7tJv9N4/sgErCmEsLZdY
	MTBlnEjOxSj3PwYAzKietki5VuphG0w4=
X-Gm-Gg: ASbGncsCoS0fI7RufRTS6SAb7gEteF6M4lRQrOIZ0J4gG2yUFO7xkB9N/HeuYENHpYV
	6XquXzH/k8VqoqFj7xZmh4fD1zyLufi42/g3sq6GZKm65Sbxhtdcw9g32l4In2dhmCHuxObud52
	dDNpZyMnpAkLuKO89O0YTljWDsJ2k0xBQuLmEfCoIOqOpjTMT+qpJW146wPVcajhy48bzRWBFzs
	8X8Nm62koMGlirRJ0Q0PP8G4s4LKehHAme6Z61H+ebjotPshk82
X-Google-Smtp-Source: AGHT+IEIACM11KtOF47O6Ozjrys8TpyoLQYla/VZwgyzK6kb7GIPdMv8Ryq947hK0pxUYJvxAalPfrpf/h56I++cpo4=
X-Received: by 2002:a17:906:6a0e:b0:b3e:bb87:772c with SMTP id
 a640c23a62f3a-b3ebb878463mr20116766b.17.1759062399326; Sun, 28 Sep 2025
 05:26:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926025015.1747294-1-neilb@ownmail.net> <20250926025015.1747294-6-neilb@ownmail.net>
In-Reply-To: <20250926025015.1747294-6-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 28 Sep 2025 14:26:28 +0200
X-Gm-Features: AS18NWDCW5uhSx_Wo60y0JUAv9N4uixHjHQBq6g7FHMnw5bMi0AWiNl3OHdMSRE
Message-ID: <CAOQ4uxiJ6PD7m=w8JtzL3mQTsT5pNmwaNZaggp7aax3tSFdTHA@mail.gmail.com>
Subject: Re: [PATCH 05/11] VFS: introduce start_creating_noperm() and start_removing_noperm()
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 4:50=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
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

Feel free to add:
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

But see question below

> ---
>  fs/fuse/dir.c            | 19 +++++++---------
>  fs/namei.c               | 48 ++++++++++++++++++++++++++++++++++++++++
>  fs/xfs/scrub/orphanage.c | 11 ++++-----
>  include/linux/namei.h    |  2 ++
>  ipc/mqueue.c             | 31 +++++++++-----------------
>  5 files changed, 73 insertions(+), 38 deletions(-)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 5c569c3cb53f..88bc512639e2 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -1404,27 +1404,25 @@ int fuse_reverse_inval_entry(struct fuse_conn *fc=
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
> @@ -1452,10 +1450,9 @@ int fuse_reverse_inval_entry(struct fuse_conn *fc,=
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
> index 0d9e98961758..bd5c45801756 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3296,6 +3296,54 @@ struct dentry *start_removing(struct mnt_idmap *id=
map, struct dentry *parent,
>  }
>  EXPORT_SYMBOL(start_removing);
>
> +/**
> + * start_creating_noperm - prepare to create a given name without permis=
sion checking
> + * @parent - directory in which to prepare to create the name
> + * @name - the name to be created
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
> + * @parent - directory in which to find the name
> + * @name - the name to be removed
> + *
> + * Locks are taken and a lookup in performed prior to removing
> + * an object from a directory.
> + *
> + * If the name doesn't exist, an error is returned.
> + *
> + * end_removing() should be called when removal is complete, or aborted.
> + *
> + * Returns: a positive dentry, or an error.

I noticed that this does not say "...whose parent is @parent"
and "whose d_parent/d_name are guaranteed to remain stable
until the call to end_removing()"

Do you think this is something that should be spelled out before
the parent lock is dropped??

The reason I am asking is...

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
> index 63941fdbc23d..20a88a46fe92 100644
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
>  /* end_creating - finish action started with start_creating
>   * @child - dentry returned by start_creating()
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

This code (rightfully) assumes that (mnt->mnt_root =3D=3D dentry->d_parent)

Maybe that's obvious and does not need any clarification, but since
you are properly documenting a new interface, maybe this is worth
mentioning for clarity.

Really up to you.

Thanks,
Amir.

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

