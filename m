Return-Path: <linux-fsdevel+bounces-62907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1D6BA4AEF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 18:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CB93171BF1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 16:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6AB2FE59E;
	Fri, 26 Sep 2025 16:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4/UebMW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80944242D9A
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 16:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758904883; cv=none; b=J/qLHk8jFUcgGjacAjMESdKfPlPpfet6PNRnAiY/vvapCuY7yX2EUJz8HOs3KQDhreAacrFAYyAU2/Ban03mm0tecez2BPN5Rl2CHICJqWP2GSy5Cb6MI82L7cdwglQZ1zp6mqsFir+bbLJckIEfMpf94B72Rf7dlfU6mO0HE6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758904883; c=relaxed/simple;
	bh=5mxOqn276cZg4ZJyYBfHlffj4S+pZWP2iZ+tRwd2SqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rJ32s2dxzleJTCed//gq6rxjUvnceP8nxfFpjCv+RFs9P3YDY1jl6R7be2y73GehnM8Ex5CCxHY1nvphevLOZyaWKGd7WiidPc36S1CSfZ02JYErzXdjH83LEf1ZHxG6rTqTXy9NA7E0+BmnXCagf45dnr6Nvo+RhL2tJ7IrBf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4/UebMW; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-62fa062a1abso3635150a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 09:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758904880; x=1759509680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RMURj4wm9EgxmlNbK0JwwKh8JgbBOk6R5/EhDJjhG0=;
        b=Q4/UebMWe88ckRzMs8lqy1A+Uvn4wSlF/Z44AOJjBxCWi13iYAg97HntmQPtlaDfB5
         0FOuadfixRbJoaAWtOAbgSgg/JlqsxSOJmtZJo9RrwCXTDht0IogX1k/0OZVbDvdpsT0
         Jhba3N0qX0SNC8D690RvlZxHiWD75eiduFrnYdd3iqa25CpY2yQ3ecyyiS2/bm0KzUZD
         zgj9pEoJ9xYf9dS3jiD8l7ZUOKnhhxfldHTjjS3Vobv5+cXEFF/8P6y37iaevJbKxgvJ
         J4jgFcg1CtDqueXzU58k4/NI4M1YrWzqEi9D2EgB8OnIE24A6Xq48mcxg29eC6YAEzaO
         it5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758904880; x=1759509680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3RMURj4wm9EgxmlNbK0JwwKh8JgbBOk6R5/EhDJjhG0=;
        b=m685oREqiH0daCXtiZ9MU6CvIaoNGFrviLXeyl/BI+Q/tynWE1mKT624iQoClYpxIr
         KzpGOsvsD+BD1xsxqj5MXbhvqwo2BlFY7zck+NR4z3PyU3In8kmsrNcYpn7Y0+4rT1C8
         R/ueXJlAUWRua0ZVa7O1YdLUYnIUhdiKzH2C8sf12MzSatA/m1C72+gB0u+NW4zw3QK1
         5NKBHz9maT1y2iC+krB++gIFYg4jABJGXH3NQamHSSZv8eWzmW/J9+qIFZ1bK8d6/MGK
         NDLczCTsXZ2Ty/EKaKAKbsGW2n7up6WmbSgUVMOafJ+qCIlnQOF2It5VWg/cV2VVhYUV
         yd6w==
X-Forwarded-Encrypted: i=1; AJvYcCW6k5v82avTj0rItlBpZ8RYaT0ahmiTkOoK5PJPnPOCinan+KHMuA2EmOAUWcp7g0CzJ3CPaUrqbv4DAj/b@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4eHnfTq3MFJxLFy1nib2mnylT46ERdosLgywVYt2YWP0x3xeZ
	tUqV0ZZhN6LBXbhBjIYvtmqA891D/ZWHaNZuyepiYlGdb3Ol81JDIjyLbQqYHfZjSok3IWqmR+I
	BXjKAPOqcEO9noGDMdG23//ZTDY+po1A=
X-Gm-Gg: ASbGnctWaTlVwhi1AaEaAtJ1RKR1qxM1GvatQs5+YsY3Ys8bFwJXDqoX4aPVIo+iQFq
	SCs62FdiJLtZQIdgoKdqCse27Qy7hiydBw6FGyagDGpdzILMX0URatFxu2cKoCuy/KKgBsl6Y90
	rY7Zy5v0GxUjO83zsV06EsXXgF1tAJyTmRTajwTrgab/F0te0BpawYfLIhP+tN4m2G+jTv9jkEM
	oK3LBSmuniO8x+tCqCJI3Kw7nhff5GXGTl8Hw==
X-Google-Smtp-Source: AGHT+IEY2ByVkNEN3UjGhBw+s+R76GQY5mORN4q/KxYOm33iYXtZhs16cLB9m8Be93IGfxGLxDUWCBjpCt2qsNKXysQ=
X-Received: by 2002:a05:6402:5210:b0:634:a546:de45 with SMTP id
 4fb4d7f45d1cf-634a546e2c6mr6007643a12.23.1758904879462; Fri, 26 Sep 2025
 09:41:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926025015.1747294-1-neilb@ownmail.net> <20250926025015.1747294-3-neilb@ownmail.net>
In-Reply-To: <20250926025015.1747294-3-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 26 Sep 2025 18:41:06 +0200
X-Gm-Features: AS18NWBEpyzd16vNmMy1gdapXtOo1842aqFjwhgqrqqXy681ZGPF67JCl6-6G2w
Message-ID: <CAOQ4uxi=sM54cByg-WYrw2umocTNzrX4_nhObVbxRP7Muz5JeA@mail.gmail.com>
Subject: Re: [PATCH 02/11] VFS: introduce start_dirop() and end_dirop()
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

--- from here
> As vfs_mkdir() drops the dentry on error we cannot use end_dirop() as
> that won't unlock when the dentry IS_ERR().  For those cases we have
> end_dirop_mkdir().
>
> end_dirop() can always be called on the result of start_dirop(), but not
> after vfs_mkdir().
> end_dirop_mkdir() can only be called on the result of start_dirop() if
> that was not an error, and can also be called on the result of
> vfs_mkdir().
>
> When we change vfs_mkdir() to drop the lock when it drops the dentry,
> end_dirop_mkdir() can be discarded.
---until here

I am really struggling swallowing end_dirop_mkdir() as a temp helper
It's has such fluid and weird semantics nobody has a chance to
remember or guess, it is scheduled to be removed, and it is
only used in two helpers end_creating_path() and end_creating()
(right?) both of which have perfectly understandable and normal
semantics.

So how about we stop pretending that end_dirop_mkdir() is a sane
abstraction and open code it twice inside the helpers where
the code makes sense and is well documented?

Am I missing some subtlety? or missing the bigger picture?

>
> As well as adding start_dirop() and end_dirop()/end_dirop_mkdir()
> this patch uses them in:
>  - simple_start_creating (which requires sharing lookup_noperm_common()
>         with libfs.c)
>  - start_removing_path / start_removing_user_path_at
>  - filename_create / end_creating_path()
>  - do_rmdir(), do_unlinkat()
>
> The change in do_unlinkat() opens the opportunity for some cleanup.
> As we don't need to unlock on lookup failure, "inode" can be local
> to the non-error patch.  Also the "slashes" handler is moved
> in-line with an "unlikely" annotation on the branch.
>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/internal.h      |   3 ++
>  fs/libfs.c         |  36 ++++++-------
>  fs/namei.c         | 126 +++++++++++++++++++++++++++++++--------------
>  include/linux/fs.h |   3 ++
>  4 files changed, 110 insertions(+), 58 deletions(-)
>
> diff --git a/fs/internal.h b/fs/internal.h
> index a33d18ee5b74..d11fe787bbc1 100644
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
> index ce8c496a6940..fc979becd536 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -2289,27 +2289,25 @@ void stashed_dentry_prune(struct dentry *dentry)
>         cmpxchg(stashed, dentry, NULL);
>  }
>
> -/* parent must be held exclusive */
> +/**
> + * simple_start_creating - prepare to create a given name
> + * @parent - directory in which to prepare to create the name
> + * @name - the name to be created
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
> index 507ca0d7878d..81cbaabbbe21 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2765,6 +2765,69 @@ static int filename_parentat(int dfd, struct filen=
ame *name,
>         return __filename_parentat(dfd, name, flags, parent, last, type, =
NULL);
>  }
>
> +/**
> + * start_dirop - begin a create or remove dirop, performing locking and =
lookup
> + * @parent - the dentry of the parent in which the operation will occur
> + * @name - a qstr holding the name within that parent
> + * @lookup_flags - intent and other lookup flags.
> + *
> + * The lookup is performed and necessary locks are taken so that, on suc=
cess,

typo: necessary

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
> + * @de - the dentry which was returned by start_dirop or similar.
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
> +/**
> + * end_dirop_mkdir - signal completion of a dirop which could have been =
vfs_mkdir
> + * @de - the dentry which was returned by start_dirop or similar.
> + * @parent - the parent in which the mkdir happened.
> + *
> + * Because vfs_mkdir() dput()s the dentry on failure, end_dirop() cannot
> + * be used with it.  Instead this function must be used, and it must not
> + * be called if the original lookup failed.
> + *
> + * If de is an error the parent is unlocked, else this behaves the same =
as
> + * end_dirop().
> + */
> +void end_dirop_mkdir(struct dentry *de, struct dentry *parent)
> +{
> +       if (IS_ERR(de))
> +               inode_unlock(parent->d_inode);
> +       else
> +               end_dirop(de);
> +}
> +EXPORT_SYMBOL(end_dirop_mkdir);
> +
>  /* does lookup, returns the object with parent locked */
>  static struct dentry *__start_removing_path(int dfd, struct filename *na=
me,
>                                            struct path *path)
> @@ -2781,10 +2844,9 @@ static struct dentry *__start_removing_path(int df=
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
> @@ -2792,10 +2854,9 @@ static struct dentry *__start_removing_path(int df=
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
> @@ -2910,7 +2971,7 @@ int vfs_path_lookup(struct dentry *dentry, struct v=
fsmount *mnt,
>  }
>  EXPORT_SYMBOL(vfs_path_lookup);
>
> -static int lookup_noperm_common(struct qstr *qname, struct dentry *base)
> +int lookup_noperm_common(struct qstr *qname, struct dentry *base)
>  {
>         const char *name =3D qname->name;
>         u32 len =3D qname->len;
> @@ -4223,21 +4284,18 @@ static struct dentry *filename_create(int dfd, st=
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
> @@ -4258,9 +4316,7 @@ EXPORT_SYMBOL(start_creating_path);
>
>  void end_creating_path(struct path *path, struct dentry *dentry)
>  {
> -       if (!IS_ERR(dentry))
> -               dput(dentry);
> -       inode_unlock(path->dentry->d_inode);
> +       end_dirop_mkdir(dentry, path->dentry);

I think it is better to open code end_dirop_mkdir()
here and document semantics of end_creating_path()
Yes, when you remove the parent lock there will be one
more place to remove a parent lock, but that place is in fs/namei.c
not in filesystems code, so I think that's reasonable.

>         mnt_drop_write(path->mnt);
>         path_put(path);
>  }
> @@ -4592,8 +4648,7 @@ int do_rmdir(int dfd, struct filename *name)
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
> @@ -4602,9 +4657,8 @@ int do_rmdir(int dfd, struct filename *name)
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
> @@ -4705,7 +4759,6 @@ int do_unlinkat(int dfd, struct filename *name)
>         struct path path;
>         struct qstr last;
>         int type;
> -       struct inode *inode =3D NULL;
>         struct inode *delegated_inode =3D NULL;
>         unsigned int lookup_flags =3D 0;
>  retry:
> @@ -4721,14 +4774,19 @@ int do_unlinkat(int dfd, struct filename *name)
>         if (error)
>                 goto exit2;
>  retry_deleg:
> -       inode_lock_nested(path.dentry->d_inode, I_MUTEX_PARENT);
> -       dentry =3D lookup_one_qstr_excl(&last, path.dentry, lookup_flags)=
;
> +       dentry =3D start_dirop(path.dentry, &last, lookup_flags);
>         error =3D PTR_ERR(dentry);

Maybe it's just me, but possibly

if (IS_ERR(dentry))
        goto exit_drop_write;

Could make this code look a bit easier to follow, because...

>         if (!IS_ERR(dentry)) {
> +               struct inode *inode =3D NULL;
>
>                 /* Why not before? Because we want correct error value */
> -               if (last.name[last.len])
> -                       goto slashes;
> +               if (unlikely(last.name[last.len])) {
> +                       if (d_is_dir(dentry))
> +                               error =3D -EISDIR;
> +                       else
> +                               error =3D -ENOTDIR;
> +                       goto exit3;
> +               }
>                 inode =3D dentry->d_inode;
>                 ihold(inode);
>                 error =3D security_path_unlink(&path, dentry);
> @@ -4737,12 +4795,10 @@ int do_unlinkat(int dfd, struct filename *name)
>                 error =3D vfs_unlink(mnt_idmap(path.mnt), path.dentry->d_=
inode,
>                                    dentry, &delegated_inode);
>  exit3:
> -               dput(dentry);
> +               end_dirop(dentry);
> +               if (inode)
> +                       iput(inode);    /* truncate the inode here */
>         }

The exit3 goto label inside the conditional scope looks
unconventional and feels wrong.

If you do not agree, feel free to ignore this comment.

Thanks,
Amir.

