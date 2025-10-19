Return-Path: <linux-fsdevel+bounces-64610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34925BEE282
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Oct 2025 11:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1A763E3A91
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Oct 2025 09:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EAF204F8B;
	Sun, 19 Oct 2025 09:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhRXvPmP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2B229E117
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Oct 2025 09:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760867790; cv=none; b=CjzehTg86kcEX9wNio7Ak9tcvPm2qZrCZDsIEgMNROqSyTBDsbNxP6M8sNGpzuqQ5UWzw/yfz6Qn3TJXi/UtiAy6v+hjFpp8IPxoVsMjkn2FjZNgTs+YxUSPsTcIt4uegXDq9BYhZh479rGzdUe0EFsSX5pYDty8T88vmJ5hkRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760867790; c=relaxed/simple;
	bh=qY2mY/zlaTe4uR6Bt53LNeihAPTCA/n6VMqtSMt2pAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K11zSUxgqrKYM3zQaR4GLxuJbYVuDcApXV6QVFTtWuR3XqJbfC158I1NnanPzlE3IiFDaXk+0ZZHEnRtCX72AVl+ajKkGF3a+ZJHLDhHT7Ar2oWUwssSwtUdHZxqGOq2vswa7clbx+yz2Ztu/y4cde2B7ck+PK9dobhLdy9IDTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhRXvPmP; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63c11011e01so5202908a12.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Oct 2025 02:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760867787; x=1761472587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wb5/q9eQ4QgSpm2HrRDgs4yCJU5iZBJCSL7FBpW6s8=;
        b=XhRXvPmPSYudHDuLtNVwHhUF2e52cmLQ2jaTPVWRL7v3JCyFnPQBkrgwctmQmTSc0w
         0zvtmxv4CEry36x2/xQ3oQcEyHgQYqH4Tz+6+83AHRDvprIRywLlVqI5sh8ANpWesvL0
         8j35LmhoYz4D+f61v+pE0mza1XkaHaTdhF7L/OsWmxbJLcF2EMocjGrQOHq4EzDuK8nL
         xKaokr8wcKehB0MqD2ppTuh6x4sqvXdp6EeApxguK/DK7kxNNQY3L8dYxg+sFeAY1Kpe
         JHGzIMZmAxjOkdD12tYE0EBugR/pjylAesjmggJOtfOvdI9KPdGRyYJIducvMDBlt3bu
         0Tmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760867787; x=1761472587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9wb5/q9eQ4QgSpm2HrRDgs4yCJU5iZBJCSL7FBpW6s8=;
        b=q9cMEe4MtpByj9hX1bK3GMmnyQsWjTB4GShD333Ms6bU7HYOq6I0iMhzJipMWCYoNg
         w8S5MdJzRrH7tvafKtb5BDBnRAGz8ZKrYT8lU03HQhqhFSjvGvH10/Ams38AMl/ZRjIT
         IZhVvdO5hG35mqS1RSqvHIY/NFDUys6ckOq1fxYvST6qzR/4i7r4qeyTP8XCiCdYRnOO
         vkbb0NixbTct9JXW+uD1b3kwi9RRBrcF+0Ha9WQ6A9Of4TalK0RYnT7D5XBQ08ZLfvSU
         Vk9GCi7TmICKNYeLJMJi371eZwIgGZrupJNgm8tvY6HC5qz4plNqWRgxvpOeDnHlBTKG
         Cu8A==
X-Forwarded-Encrypted: i=1; AJvYcCVZY7E5kJNIYpZ5VyrTukRR/g3DMER6052AD6omlC5NVjM1qdcCY0NmV61/XFUbLqIljteLpkTVuUsV8tFq@vger.kernel.org
X-Gm-Message-State: AOJu0YxnGQmqmP3C3EAcbJn6TMCVaqRfolCWQHVslIRXC2roh7IQmofv
	Q3wUmzCrQdtVgXrW2lJ+R66TvEogb6EJ6y+ws0y8Ra6ejhVkDHXIwcZA32/C+niBiFkSR5njgOd
	PQCuZzbmIDgyS+EZN9yAK0DHhrC1Jl6U=
X-Gm-Gg: ASbGnctMV48EB/8uIZA3e2+zJFNP/3OoI5g8Gb4xwyqHqfP7Z2HT5QvXZ0XmKcNIZ8a
	ieOwixWMvZYc1XDD8XF/HdsJhzXphOVEtQuycFjA0c6pd1F15J//BM+Nn+ox2UMvmZGaUlKZunh
	Z9HiP8+HFefG/Sq6UQe44/Ga9vm3wO5eR3jRGr+jQ9Hx3RgjXLUaMhi7L2EeaybSvAgs8T0dqO3
	ApP9KdWoMrNzqXtNmem7SkqwNTUhNCHfh1IeD08HP4CJxdHGqFErhP41yNyKX1gIqRUL6ucscf4
	caW7o7bDWP9mW0AAqJk=
X-Google-Smtp-Source: AGHT+IH1ipk63EYNxQp4ZKLOM3YmVPf1FLtoKcQjixqR92g9P3uThKTnloXkMD0ccl6dXjmAmQbQpURoHi5tcUvo4xU=
X-Received: by 2002:a05:6402:2551:b0:62f:2afa:60e6 with SMTP id
 4fb4d7f45d1cf-63c1f64ececmr8302282a12.7.1760867786484; Sun, 19 Oct 2025
 02:56:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015014756.2073439-1-neilb@ownmail.net> <20251015014756.2073439-3-neilb@ownmail.net>
In-Reply-To: <20251015014756.2073439-3-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 19 Oct 2025 11:56:15 +0200
X-Gm-Features: AS18NWC4MQ_KBh2r4iIz2Zpj9w4SCQkfKkJxXVuTAQelA5X7rNncasQdTwM0cZI
Message-ID: <CAOQ4uxi4b=xuCu5b_Bw1z7LxLCRGMBM7KQsCOpHCOykkKOYThA@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] VFS: introduce start_dirop() and end_dirop()
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
> The fact that directory operations (create,remove,rename) are protected
> by a lock on the parent is known widely throughout the kernel.
> In order to change this - to instead lock the target dentry  - it is
> best to centralise this knowledge so it can be changed in one place.
>
> This patch introduces start_dirop() which is local to VFS code.
> It performs the required locking for create and remove.  Rename
> will be handled separately.
>
> Various functions with names like start_creating() or start_removing_path=
(),
> some of which already exist, will export this functionality beyond the VF=
S.
>
> end_dirop() is the partner of start_dirop().  It drops the lock and
> releases the reference on the dentry.
> It *is* exported so that various end_creating etc functions can be inline=
.
>
> As vfs_mkdir() drops the dentry on error we cannot use end_dirop() as
> that won't unlock when the dentry IS_ERR().  For now we need an explicit
> unlock when dentry IS_ERR().  I hope to change vfs_mkdir() to unlock
> when it drops a dentry so that explicit unlock can go away.
>
> end_dirop() can always be called on the result of start_dirop(), but not
> after vfs_mkdir().  After a vfs_mkdir() we still may need the explicit
> unlock as seen in end_creating_path().
>
> As well as adding start_dirop() and end_dirop()
> this patch uses them in:
>  - simple_start_creating (which requires sharing lookup_noperm_common()
>         with libfs.c)
>  - start_removing_path / start_removing_user_path_at
>  - filename_create / end_creating_path()
>  - do_rmdir(), do_unlinkat()
>
> Signed-off-by: NeilBrown <neil@brown.name>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/internal.h      |  3 ++
>  fs/libfs.c         | 36 ++++++++---------
>  fs/namei.c         | 98 ++++++++++++++++++++++++++++++++++------------
>  include/linux/fs.h |  2 +
>  4 files changed, 95 insertions(+), 44 deletions(-)
>
> diff --git a/fs/internal.h b/fs/internal.h
> index 9b2b4d116880..d08d5e2235e9 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -67,6 +67,9 @@ int vfs_tmpfile(struct mnt_idmap *idmap,
>                 const struct path *parentpath,
>                 struct file *file, umode_t mode);
>  struct dentry *d_hash_and_lookup(struct dentry *, struct qstr *);
> +struct dentry *start_dirop(struct dentry *parent, struct qstr *name,
> +                          unsigned int lookup_flags);
> +int lookup_noperm_common(struct qstr *qname, struct dentry *base);
>
>  /*
>   * namespace.c
> diff --git a/fs/libfs.c b/fs/libfs.c
> index ce8c496a6940..02371f45ef7d 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -2289,27 +2289,25 @@ void stashed_dentry_prune(struct dentry *dentry)
>         cmpxchg(stashed, dentry, NULL);
>  }
>
> -/* parent must be held exclusive */
> +/**
> + * simple_start_creating - prepare to create a given name
> + * @parent: directory in which to prepare to create the name
> + * @name:   the name to be created
> + *
> + * Required lock is taken and a lookup in performed prior to creating an
> + * object in a directory.  No permission checking is performed.
> + *
> + * Returns: a negative dentry on which vfs_create() or similar may
> + *  be attempted, or an error.
> + */
>  struct dentry *simple_start_creating(struct dentry *parent, const char *=
name)
>  {
> -       struct dentry *dentry;
> -       struct inode *dir =3D d_inode(parent);
> +       struct qstr qname =3D QSTR(name);
> +       int err;
>
> -       inode_lock(dir);
> -       if (unlikely(IS_DEADDIR(dir))) {
> -               inode_unlock(dir);
> -               return ERR_PTR(-ENOENT);
> -       }
> -       dentry =3D lookup_noperm(&QSTR(name), parent);
> -       if (IS_ERR(dentry)) {
> -               inode_unlock(dir);
> -               return dentry;
> -       }
> -       if (dentry->d_inode) {
> -               dput(dentry);
> -               inode_unlock(dir);
> -               return ERR_PTR(-EEXIST);
> -       }
> -       return dentry;
> +       err =3D lookup_noperm_common(&qname, parent);
> +       if (err)
> +               return ERR_PTR(err);
> +       return start_dirop(parent, &qname, LOOKUP_CREATE | LOOKUP_EXCL);
>  }
>  EXPORT_SYMBOL(simple_start_creating);
> diff --git a/fs/namei.c b/fs/namei.c
> index 7377020a2cba..3618efd4bcaa 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2765,6 +2765,48 @@ static int filename_parentat(int dfd, struct filen=
ame *name,
>         return __filename_parentat(dfd, name, flags, parent, last, type, =
NULL);
>  }
>
> +/**
> + * start_dirop - begin a create or remove dirop, performing locking and =
lookup
> + * @parent:       the dentry of the parent in which the operation will o=
ccur
> + * @name:         a qstr holding the name within that parent
> + * @lookup_flags: intent and other lookup flags.
> + *
> + * The lookup is performed and necessary locks are taken so that, on suc=
cess,
> + * the returned dentry can be operated on safely.
> + * The qstr must already have the hash value calculated.
> + *
> + * Returns: a locked dentry, or an error.
> + *
> + */
> +struct dentry *start_dirop(struct dentry *parent, struct qstr *name,
> +                          unsigned int lookup_flags)
> +{
> +       struct dentry *dentry;
> +       struct inode *dir =3D d_inode(parent);
> +
> +       inode_lock_nested(dir, I_MUTEX_PARENT);
> +       dentry =3D lookup_one_qstr_excl(name, parent, lookup_flags);
> +       if (IS_ERR(dentry))
> +               inode_unlock(dir);
> +       return dentry;
> +}
> +
> +/**
> + * end_dirop - signal completion of a dirop
> + * @de: the dentry which was returned by start_dirop or similar.
> + *
> + * If the de is an error, nothing happens. Otherwise any lock taken to
> + * protect the dentry is dropped and the dentry itself is release (dput(=
)).
> + */
> +void end_dirop(struct dentry *de)
> +{
> +       if (!IS_ERR(de)) {
> +               inode_unlock(de->d_parent->d_inode);
> +               dput(de);
> +       }
> +}
> +EXPORT_SYMBOL(end_dirop);
> +
>  /* does lookup, returns the object with parent locked */
>  static struct dentry *__start_removing_path(int dfd, struct filename *na=
me,
>                                            struct path *path)
> @@ -2781,10 +2823,9 @@ static struct dentry *__start_removing_path(int df=
d, struct filename *name,
>                 return ERR_PTR(-EINVAL);
>         /* don't fail immediately if it's r/o, at least try to report oth=
er errors */
>         error =3D mnt_want_write(parent_path.mnt);
> -       inode_lock_nested(parent_path.dentry->d_inode, I_MUTEX_PARENT);
> -       d =3D lookup_one_qstr_excl(&last, parent_path.dentry, 0);
> +       d =3D start_dirop(parent_path.dentry, &last, 0);
>         if (IS_ERR(d))
> -               goto unlock;
> +               goto drop;
>         if (error)
>                 goto fail;
>         path->dentry =3D no_free_ptr(parent_path.dentry);
> @@ -2792,10 +2833,9 @@ static struct dentry *__start_removing_path(int df=
d, struct filename *name,
>         return d;
>
>  fail:
> -       dput(d);
> +       end_dirop(d);
>         d =3D ERR_PTR(error);
> -unlock:
> -       inode_unlock(parent_path.dentry->d_inode);
> +drop:
>         if (!error)
>                 mnt_drop_write(parent_path.mnt);
>         return d;
> @@ -2910,7 +2950,7 @@ int vfs_path_lookup(struct dentry *dentry, struct v=
fsmount *mnt,
>  }
>  EXPORT_SYMBOL(vfs_path_lookup);
>
> -static int lookup_noperm_common(struct qstr *qname, struct dentry *base)
> +int lookup_noperm_common(struct qstr *qname, struct dentry *base)
>  {
>         const char *name =3D qname->name;
>         u32 len =3D qname->len;
> @@ -4223,21 +4263,18 @@ static struct dentry *filename_create(int dfd, st=
ruct filename *name,
>          */
>         if (last.name[last.len] && !want_dir)
>                 create_flags &=3D ~LOOKUP_CREATE;
> -       inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
> -       dentry =3D lookup_one_qstr_excl(&last, path->dentry,
> -                                     reval_flag | create_flags);
> +       dentry =3D start_dirop(path->dentry, &last, reval_flag | create_f=
lags);
>         if (IS_ERR(dentry))
> -               goto unlock;
> +               goto out_drop_write;
>
>         if (unlikely(error))
>                 goto fail;
>
>         return dentry;
>  fail:
> -       dput(dentry);
> +       end_dirop(dentry);
>         dentry =3D ERR_PTR(error);
> -unlock:
> -       inode_unlock(path->dentry->d_inode);
> +out_drop_write:
>         if (!error)
>                 mnt_drop_write(path->mnt);
>  out:
> @@ -4256,11 +4293,26 @@ struct dentry *start_creating_path(int dfd, const=
 char *pathname,
>  }
>  EXPORT_SYMBOL(start_creating_path);
>
> +/**
> + * end_creating_path - finish a code section started by start_creating_p=
ath()
> + * @path: the path instantiated by start_creating_path()
> + * @dentry: the dentry returned by start_creating_path()
> + *
> + * end_creating_path() will unlock and locks taken by start_creating_pat=
h()
> + * and drop an references that were taken.  It should only be called
> + * if start_creating_path() returned a non-error.
> + * If vfs_mkdir() was called and it returned an error, that error *shoul=
d*
> + * be passed to end_creating_path() together with the path.
> + */
>  void end_creating_path(const struct path *path, struct dentry *dentry)
>  {
> -       if (!IS_ERR(dentry))
> -               dput(dentry);
> -       inode_unlock(path->dentry->d_inode);
> +       if (IS_ERR(dentry))
> +               /* The parent is still locked despite the error from
> +                * vfs_mkdir() - must unlock it.
> +                */
> +               inode_unlock(path->dentry->d_inode);
> +       else
> +               end_dirop(dentry);
>         mnt_drop_write(path->mnt);
>         path_put(path);
>  }
> @@ -4592,8 +4644,7 @@ int do_rmdir(int dfd, struct filename *name)
>         if (error)
>                 goto exit2;
>
> -       inode_lock_nested(path.dentry->d_inode, I_MUTEX_PARENT);
> -       dentry =3D lookup_one_qstr_excl(&last, path.dentry, lookup_flags)=
;
> +       dentry =3D start_dirop(path.dentry, &last, lookup_flags);
>         error =3D PTR_ERR(dentry);
>         if (IS_ERR(dentry))
>                 goto exit3;
> @@ -4602,9 +4653,8 @@ int do_rmdir(int dfd, struct filename *name)
>                 goto exit4;
>         error =3D vfs_rmdir(mnt_idmap(path.mnt), path.dentry->d_inode, de=
ntry);
>  exit4:
> -       dput(dentry);
> +       end_dirop(dentry);
>  exit3:
> -       inode_unlock(path.dentry->d_inode);
>         mnt_drop_write(path.mnt);
>  exit2:
>         path_put(&path);
> @@ -4721,8 +4771,7 @@ int do_unlinkat(int dfd, struct filename *name)
>         if (error)
>                 goto exit2;
>  retry_deleg:
> -       inode_lock_nested(path.dentry->d_inode, I_MUTEX_PARENT);
> -       dentry =3D lookup_one_qstr_excl(&last, path.dentry, lookup_flags)=
;
> +       dentry =3D start_dirop(path.dentry, &last, lookup_flags);
>         error =3D PTR_ERR(dentry);
>         if (!IS_ERR(dentry)) {
>
> @@ -4737,9 +4786,8 @@ int do_unlinkat(int dfd, struct filename *name)
>                 error =3D vfs_unlink(mnt_idmap(path.mnt), path.dentry->d_=
inode,
>                                    dentry, &delegated_inode);
>  exit3:
> -               dput(dentry);
> +               end_dirop(dentry);
>         }
> -       inode_unlock(path.dentry->d_inode);
>         if (inode)
>                 iput(inode);    /* truncate the inode here */
>         inode =3D NULL;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c895146c1444..f4543612ef1e 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3609,6 +3609,8 @@ extern void iterate_supers_type(struct file_system_=
type *,
>  void filesystems_freeze(void);
>  void filesystems_thaw(void);
>
> +void end_dirop(struct dentry *de);
> +
>  extern int dcache_dir_open(struct inode *, struct file *);
>  extern int dcache_dir_close(struct inode *, struct file *);
>  extern loff_t dcache_dir_lseek(struct file *, loff_t, int);
> --
> 2.50.0.107.gf914562f5916.dirty
>

