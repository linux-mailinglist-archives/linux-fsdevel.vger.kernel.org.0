Return-Path: <linux-fsdevel+bounces-63104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15580BAC22F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 10:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF8B33BB5DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 08:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841E32F3C3A;
	Tue, 30 Sep 2025 08:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKjDgcYv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3CE256C6C
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 08:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759222483; cv=none; b=r5L6VQRwzuOwMpstuT6z3swTYtUMOU+siDse+dSiuqh3+5lNJVRn/2As4lfDpYrv+f9Wbd29rmNVYiBoKZX9A856R5RpxK67Fh6db8q+0NY16rvD4GX59eUYyrUPYWGphMVx5/U5YGiN+u5W6tXvmm40IK/57kegQjZwq+UpLXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759222483; c=relaxed/simple;
	bh=hayFXOMfD5vgMUQoPF4fdL7bXy+0A32irZhxm7yWhys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i8rWZtfFWYhar9cCVVMbgRahWB63CqRpDWGj19AiQATaRQkQRmr6yPKXR5CebNOly9EAZj8v6VFjlsfdXb4Bnud20uh/biA34xJTp34cVU9yEK3BtZSWmX8Sw5XZ9+/59CG8R1i9TJ29BM4hyQNM3uQoF5seV+76Y2jMSD0yYzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKjDgcYv; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63667e8069aso822583a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 01:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759222480; x=1759827280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etwyqv6WiwWVqHd14DkewTI6+EsdkLo0GDboLp9t+6Y=;
        b=GKjDgcYvqtlrQZyXKlSHYa0j41UpxfeMQNXkBpJsRjgGfewbmvnP88Oi6dr6vMNtpw
         aOUK8GwmTul1GNlNDMDC06b0FQaMtIdYzozXZyc2yf7LcK7wzbVN3/XPcOBd3eUcYeVN
         XVG1MGZyzjpeuFWcehoOD56xNedfYhxPD41H4XaCMe1gZCBAakYQEWNYF0x9FDY4tUnC
         w8vuiAalC83k+kLafSXhGpwSew3H9ksHM9yReY5XwJ8akTuxQgNu9Rh3R6+kcDJr5/aV
         w6ab8tCcwUJr9u45FDO/B4QuJskk+0UlfzmJGR3Pb3HE34KGLmElMZS7WwWtW4BmaSVK
         E/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759222480; x=1759827280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=etwyqv6WiwWVqHd14DkewTI6+EsdkLo0GDboLp9t+6Y=;
        b=pa7yWT1ioyN2MD46ZYC2/rAapk8MDc1+HaBwCAbHjzaE3xn4pMqYC+oeZJHPa0vbHa
         HhWEJRKpYc8Wf4rQO9Ymg0ksHlzkvWo9XdblEEhaG4yIqyU8G02okHsuJjeDcscOG0ZS
         P0Ot6x2vj2deE4lwVyK4GJx9OvBIPvq4wNqaFKQYGPI1w0/lLamUs4eFdb1yzEuhbJkH
         fSZhVjiorhriLSMPwFf/p02UUte4WUr987aWXlOfZn8Yso4hrkj77fkaBft3hBUgAaEJ
         FPshg/6T7KW5gLuv0fuqiewJFZrXFXjcO9caNTxTYhEnwSsIhr37i3iF42u8/cRFFH0n
         bpYA==
X-Forwarded-Encrypted: i=1; AJvYcCUaWV1r2X1y4jKQ+ehM5Dt3v7bmlZpszyLrcvd9q/zKrIy8YepYyAnODka8PsGlUmzX5Eg6D0kMSxkjbVcZ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc71tbOmyglXNYtXXkaXOxdfOrIhe8D0RLVfsx7HL2sxn5Cvgb
	1TMfIo2wpZnWiRc7eBUD0lWRHo1Eci10zk4Wo2avsl7NACe+rVJEXTa/G5RMQVraq59pntjQc4Y
	xg3j6+hmlzrvezzQDhnY8oZVqhRvlraqKCuHeIcw=
X-Gm-Gg: ASbGnctebrdwonbw64CAmYzoWwvaEgLtfKYbl5l90bLTDCGw2yn8J0h4BQeymxaYDWL
	CJGGkQlEi8TgIUvUWxk9NpMc8Vug2if9F7AJM7ztGPDn648hSAlde7zs6Fx+QkyizSyyNPz/rHi
	2jeIBS61Fh3IkubzPOw2jDO0a7WVyljxlNnL6mZhGBZbb9ZikxwYttPoJQKK+NG/73EvppgGfXW
	nO4xdMJi4dQmL0nNISntu/EJCBpswCf52VGjlI0HG3R48rXK7sW8eQ8O63TJCDCBA==
X-Google-Smtp-Source: AGHT+IFlt/9TeSz1ZcNz4mzYTu9/hS+QWIuxwo1eK8IeftC9DKNkugSgJWL8G2Bj+quTFozsoLQAMUtyXuxKuWiibTA=
X-Received: by 2002:a17:906:2987:b0:b3f:3efc:35d5 with SMTP id
 a640c23a62f3a-b3f3efc3dd4mr502040166b.15.1759222479470; Tue, 30 Sep 2025
 01:54:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926025015.1747294-1-neilb@ownmail.net> <20250926025015.1747294-4-neilb@ownmail.net>
In-Reply-To: <20250926025015.1747294-4-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 30 Sep 2025 10:54:28 +0200
X-Gm-Features: AS18NWBPghJu1CgEyoC3lhiG6AGWAI_TQl00g541PFLDr-vaBF_A3p_pRPW_i6s
Message-ID: <CAOQ4uxidJeex=7H9z8rNEm5OrLqEQ-RRzTU8V3Rt_05Jr4iMPw@mail.gmail.com>
Subject: Re: [PATCH 03/11] VFS/nfsd/cachefiles/ovl: add start_creating() and end_creating()
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
> start_creating() is similar to simple_start_creating() but is not so
> simple.
> It takes a qstr for the name, includes permission checking, and does NOT
> report an error if the name already exists, returning a positive dentry
> instead.
>
> This is currently used by nfsd, cachefiles, and overlayfs.
>
> end_creating() is called after the dentry has been used.
> end_creating() drops the reference to the dentry as it is generally no
> longer needed.  This is exactly end_dirop_mkdir(),
> but using that everywhere looks a bit odd...
>
> These calls help encapsulate locking rules so that directory locking can
> be changed.
>
> Occasionally this change means that the parent lock is held for a
> shorter period of time, for example in cachefiles_commit_tmpfile().
> As this function now unlocks after an unlink and before the following
> lookup, it is possible that the lookup could again find a positive
> dentry, so a while loop is introduced there.
>
> In overlayfs the ovl_lookup_temp() function has ovl_tempname()
> split out to be used in ovl_start_creating_temp().  The other use
> of ovl_lookup_temp() is preparing for a rename.  When rename handling
> is updated, ovl_lookup_temp() will be removed.
>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/cachefiles/namei.c    | 37 ++++++++--------
>  fs/namei.c               | 27 ++++++++++++
>  fs/nfsd/nfs3proc.c       | 14 +++---
>  fs/nfsd/nfs4proc.c       | 14 +++---
>  fs/nfsd/nfs4recover.c    | 16 +++----
>  fs/nfsd/nfsproc.c        | 11 +++--
>  fs/nfsd/vfs.c            | 42 +++++++-----------
>  fs/overlayfs/copy_up.c   | 19 ++++----
>  fs/overlayfs/dir.c       | 94 ++++++++++++++++++++++++----------------
>  fs/overlayfs/overlayfs.h |  8 ++++
>  fs/overlayfs/super.c     | 32 +++++++-------
>  include/linux/namei.h    | 18 ++++++++
>  12 files changed, 187 insertions(+), 145 deletions(-)
>
> diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> index d1edb2ac3837..965b22b2f58d 100644
> --- a/fs/cachefiles/namei.c
> +++ b/fs/cachefiles/namei.c
> @@ -93,12 +93,11 @@ struct dentry *cachefiles_get_directory(struct cachef=
iles_cache *cache,
>         _enter(",,%s", dirname);
>
>         /* search the current directory for the element name */
> -       inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
>
>  retry:
>         ret =3D cachefiles_inject_read_error();
>         if (ret =3D=3D 0)
> -               subdir =3D lookup_one(&nop_mnt_idmap, &QSTR(dirname), dir=
);
> +               subdir =3D start_creating(&nop_mnt_idmap, dir, &QSTR(dirn=
ame));
>         else
>                 subdir =3D ERR_PTR(ret);
>         trace_cachefiles_lookup(NULL, dir, subdir);
> @@ -141,7 +140,7 @@ struct dentry *cachefiles_get_directory(struct cachef=
iles_cache *cache,
>                 trace_cachefiles_mkdir(dir, subdir);
>
>                 if (unlikely(d_unhashed(subdir) || d_is_negative(subdir))=
) {
> -                       dput(subdir);
> +                       end_creating(subdir, dir);
>                         goto retry;
>                 }
>                 ASSERT(d_backing_inode(subdir));
> @@ -154,7 +153,8 @@ struct dentry *cachefiles_get_directory(struct cachef=
iles_cache *cache,
>
>         /* Tell rmdir() it's not allowed to delete the subdir */
>         inode_lock(d_inode(subdir));
> -       inode_unlock(d_inode(dir));
> +       dget(subdir);
> +       end_creating(subdir, dir);
>
>         if (!__cachefiles_mark_inode_in_use(NULL, d_inode(subdir))) {
>                 pr_notice("cachefiles: Inode already in use: %pd (B=3D%lx=
)\n",
> @@ -196,14 +196,11 @@ struct dentry *cachefiles_get_directory(struct cach=
efiles_cache *cache,
>         return ERR_PTR(-EBUSY);
>
>  mkdir_error:
> -       inode_unlock(d_inode(dir));
> -       if (!IS_ERR(subdir))
> -               dput(subdir);
> +       end_creating(subdir, dir);
>         pr_err("mkdir %s failed with error %d\n", dirname, ret);
>         return ERR_PTR(ret);
>
>  lookup_error:
> -       inode_unlock(d_inode(dir));
>         ret =3D PTR_ERR(subdir);
>         pr_err("Lookup %s failed with error %d\n", dirname, ret);
>         return ERR_PTR(ret);
> @@ -679,36 +676,37 @@ bool cachefiles_commit_tmpfile(struct cachefiles_ca=
che *cache,
>
>         _enter(",%pD", object->file);
>
> -       inode_lock_nested(d_inode(fan), I_MUTEX_PARENT);
>         ret =3D cachefiles_inject_read_error();
>         if (ret =3D=3D 0)
> -               dentry =3D lookup_one(&nop_mnt_idmap, &QSTR(object->d_nam=
e), fan);
> +               dentry =3D start_creating(&nop_mnt_idmap, fan, &QSTR(obje=
ct->d_name));
>         else
>                 dentry =3D ERR_PTR(ret);
>         if (IS_ERR(dentry)) {
>                 trace_cachefiles_vfs_error(object, d_inode(fan), PTR_ERR(=
dentry),
>                                            cachefiles_trace_lookup_error)=
;
>                 _debug("lookup fail %ld", PTR_ERR(dentry));
> -               goto out_unlock;
> +               goto out;
>         }
>
> -       if (!d_is_negative(dentry)) {
> +       while (!d_is_negative(dentry)) {
>                 ret =3D cachefiles_unlink(volume->cache, object, fan, den=
try,
>                                         FSCACHE_OBJECT_IS_STALE);
>                 if (ret < 0)
> -                       goto out_dput;
> +                       goto out_end;
> +
> +               end_creating(dentry, fan);
>
> -               dput(dentry);
>                 ret =3D cachefiles_inject_read_error();
>                 if (ret =3D=3D 0)
> -                       dentry =3D lookup_one(&nop_mnt_idmap, &QSTR(objec=
t->d_name), fan);
> +                       dentry =3D start_creating(&nop_mnt_idmap, fan,
> +                                               &QSTR(object->d_name));
>                 else
>                         dentry =3D ERR_PTR(ret);
>                 if (IS_ERR(dentry)) {
>                         trace_cachefiles_vfs_error(object, d_inode(fan), =
PTR_ERR(dentry),
>                                                    cachefiles_trace_looku=
p_error);
>                         _debug("lookup fail %ld", PTR_ERR(dentry));
> -                       goto out_unlock;
> +                       goto out;
>                 }
>         }
>
> @@ -729,10 +727,9 @@ bool cachefiles_commit_tmpfile(struct cachefiles_cac=
he *cache,
>                 success =3D true;
>         }
>
> -out_dput:
> -       dput(dentry);
> -out_unlock:
> -       inode_unlock(d_inode(fan));
> +out_end:
> +       end_creating(dentry, fan);
> +out:
>         _leave(" =3D %u", success);
>         return success;
>  }
> diff --git a/fs/namei.c b/fs/namei.c
> index 81cbaabbbe21..064cb44a3a46 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3242,6 +3242,33 @@ struct dentry *lookup_noperm_positive_unlocked(str=
uct qstr *name,
>  }
>  EXPORT_SYMBOL(lookup_noperm_positive_unlocked);
>
> +/**
> + * start_creating - prepare to create a given name with permission check=
ing
> + * @idmap - idmap of the mount
> + * @parent - directory in which to prepare to create the name
> + * @name - the name to be created
> + *
> + * Locks are taken and a lookup in performed prior to creating

typo: is performed

> + * an object in a directory.  Permission checking (MAY_EXEC) is performe=
d
> + * against @idmap.
> + *
> + * If the name already exists, a positive dentry is returned, so
> + * behaviour is similar to O_CREAT without O_EXCL, which doesn't fail
> + * with -EEXIST.
> + *
> + * Returns: a negative or positive dentry, or an error.
> + */
> +struct dentry *start_creating(struct mnt_idmap *idmap, struct dentry *pa=
rent,
> +                             struct qstr *name)
> +{
> +       int err =3D lookup_one_common(idmap, name, parent);
> +
> +       if (err)
> +               return ERR_PTR(err);
> +       return start_dirop(parent, name, LOOKUP_CREATE);
> +}
> +EXPORT_SYMBOL(start_creating);
> +
>  #ifdef CONFIG_UNIX98_PTYS
>  int path_pts(struct path *path)
>  {
> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index b6d03e1ef5f7..e2aac0def2cb 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -281,14 +281,11 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct sv=
c_fh *fhp,
>         if (host_err)
>                 return nfserrno(host_err);
>
> -       inode_lock_nested(inode, I_MUTEX_PARENT);
> -
> -       child =3D lookup_one(&nop_mnt_idmap,
> -                          &QSTR_LEN(argp->name, argp->len),
> -                          parent);
> +       child =3D start_creating(&nop_mnt_idmap, parent,
> +                              &QSTR_LEN(argp->name, argp->len));
>         if (IS_ERR(child)) {
>                 status =3D nfserrno(PTR_ERR(child));
> -               goto out;
> +               goto out_write;
>         }
>
>         if (d_really_is_negative(child)) {
> @@ -367,9 +364,8 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_=
fh *fhp,
>         status =3D nfsd_create_setattr(rqstp, fhp, resfhp, &attrs);
>
>  out:
> -       inode_unlock(inode);
> -       if (child && !IS_ERR(child))
> -               dput(child);
> +       end_creating(child, parent);
> +out_write:
>         fh_drop_write(fhp);
>         return status;
>  }
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 71b428efcbb5..35d48221072f 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -264,14 +264,11 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct sv=
c_fh *fhp,
>         if (is_create_with_attrs(open))
>                 nfsd4_acl_to_attr(NF4REG, open->op_acl, &attrs);
>
> -       inode_lock_nested(inode, I_MUTEX_PARENT);
> -
> -       child =3D lookup_one(&nop_mnt_idmap,
> -                          &QSTR_LEN(open->op_fname, open->op_fnamelen),
> -                          parent);
> +       child =3D start_creating(&nop_mnt_idmap, parent,
> +                              &QSTR_LEN(open->op_fname, open->op_fnamele=
n));
>         if (IS_ERR(child)) {
>                 status =3D nfserrno(PTR_ERR(child));
> -               goto out;
> +               goto out_write;
>         }
>
>         if (d_really_is_negative(child)) {
> @@ -379,10 +376,9 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc=
_fh *fhp,
>         if (attrs.na_aclerr)
>                 open->op_bmval[0] &=3D ~FATTR4_WORD0_ACL;
>  out:
> -       inode_unlock(inode);
> +       end_creating(child, parent);
>         nfsd_attrs_free(&attrs);
> -       if (child && !IS_ERR(child))
> -               dput(child);
> +out_write:
>         fh_drop_write(fhp);
>         return status;
>  }
> diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> index 2231192ec33f..93b2a3e764db 100644
> --- a/fs/nfsd/nfs4recover.c
> +++ b/fs/nfsd/nfs4recover.c
> @@ -216,13 +216,11 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
>                 goto out_creds;
>
>         dir =3D nn->rec_file->f_path.dentry;
> -       /* lock the parent */
> -       inode_lock(d_inode(dir));
>
> -       dentry =3D lookup_one(&nop_mnt_idmap, &QSTR(dname), dir);
> +       dentry =3D start_creating(&nop_mnt_idmap, dir, &QSTR(dname));
>         if (IS_ERR(dentry)) {
>                 status =3D PTR_ERR(dentry);
> -               goto out_unlock;
> +               goto out;
>         }
>         if (d_really_is_positive(dentry))
>                 /*
> @@ -233,15 +231,13 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
>                  * In the 4.0 case, we should never get here; but we may
>                  * as well be forgiving and just succeed silently.
>                  */
> -               goto out_put;
> +               goto out_end;
>         dentry =3D vfs_mkdir(&nop_mnt_idmap, d_inode(dir), dentry, S_IRWX=
U);
>         if (IS_ERR(dentry))
>                 status =3D PTR_ERR(dentry);
> -out_put:
> -       if (!status)
> -               dput(dentry);
> -out_unlock:
> -       inode_unlock(d_inode(dir));
> +out_end:
> +       end_creating(dentry, dir);
> +out:
>         if (status =3D=3D 0) {
>                 if (nn->in_grace)
>                         __nfsd4_create_reclaim_record_grace(clp, dname,
> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> index 8f71f5748c75..ee1b16e921fd 100644
> --- a/fs/nfsd/nfsproc.c
> +++ b/fs/nfsd/nfsproc.c
> @@ -306,18 +306,16 @@ nfsd_proc_create(struct svc_rqst *rqstp)
>                 goto done;
>         }
>
> -       inode_lock_nested(dirfhp->fh_dentry->d_inode, I_MUTEX_PARENT);
> -       dchild =3D lookup_one(&nop_mnt_idmap, &QSTR_LEN(argp->name, argp-=
>len),
> -                           dirfhp->fh_dentry);
> +       dchild =3D start_creating(&nop_mnt_idmap, dirfhp->fh_dentry,
> +                               &QSTR_LEN(argp->name, argp->len));
>         if (IS_ERR(dchild)) {
>                 resp->status =3D nfserrno(PTR_ERR(dchild));
> -               goto out_unlock;
> +               goto out_write;
>         }
>         fh_init(newfhp, NFS_FHSIZE);
>         resp->status =3D fh_compose(newfhp, dirfhp->fh_export, dchild, di=
rfhp);
>         if (!resp->status && d_really_is_negative(dchild))
>                 resp->status =3D nfserr_noent;
> -       dput(dchild);
>         if (resp->status) {
>                 if (resp->status !=3D nfserr_noent)
>                         goto out_unlock;
> @@ -423,7 +421,8 @@ nfsd_proc_create(struct svc_rqst *rqstp)
>         }
>
>  out_unlock:
> -       inode_unlock(dirfhp->fh_dentry->d_inode);
> +       end_creating(dchild, dirfhp->fh_dentry);
> +out_write:
>         fh_drop_write(dirfhp);
>  done:
>         fh_put(dirfhp);
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index aa4a95713a48..90c830c59c60 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1605,19 +1605,16 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh=
 *fhp,
>         if (host_err)
>                 return nfserrno(host_err);
>
> -       inode_lock_nested(dentry->d_inode, I_MUTEX_PARENT);
> -       dchild =3D lookup_one(&nop_mnt_idmap, &QSTR_LEN(fname, flen), den=
try);
> +       dchild =3D start_creating(&nop_mnt_idmap, dentry, &QSTR_LEN(fname=
, flen));
>         host_err =3D PTR_ERR(dchild);
> -       if (IS_ERR(dchild)) {
> -               err =3D nfserrno(host_err);
> -               goto out_unlock;
> -       }
> +       if (IS_ERR(dchild))
> +               return nfserrno(host_err);
> +
>         err =3D fh_compose(resfhp, fhp->fh_export, dchild, fhp);
>         /*
>          * We unconditionally drop our ref to dchild as fh_compose will h=
ave
>          * already grabbed its own ref for it.
>          */
> -       dput(dchild);
>         if (err)
>                 goto out_unlock;
>         err =3D fh_fill_pre_attrs(fhp);
> @@ -1626,7 +1623,7 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *=
fhp,
>         err =3D nfsd_create_locked(rqstp, fhp, attrs, type, rdev, resfhp)=
;
>         fh_fill_post_attrs(fhp);
>  out_unlock:
> -       inode_unlock(dentry->d_inode);
> +       end_creating(dchild, dentry);
>         return err;
>  }
>
> @@ -1712,11 +1709,9 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh=
 *fhp,
>         }
>
>         dentry =3D fhp->fh_dentry;
> -       inode_lock_nested(dentry->d_inode, I_MUTEX_PARENT);
> -       dnew =3D lookup_one(&nop_mnt_idmap, &QSTR_LEN(fname, flen), dentr=
y);
> +       dnew =3D start_creating(&nop_mnt_idmap, dentry, &QSTR_LEN(fname, =
flen));
>         if (IS_ERR(dnew)) {
>                 err =3D nfserrno(PTR_ERR(dnew));
> -               inode_unlock(dentry->d_inode);
>                 goto out_drop_write;
>         }
>         err =3D fh_fill_pre_attrs(fhp);
> @@ -1729,11 +1724,11 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_f=
h *fhp,
>                 nfsd_create_setattr(rqstp, fhp, resfhp, attrs);
>         fh_fill_post_attrs(fhp);
>  out_unlock:
> -       inode_unlock(dentry->d_inode);
> +       end_creating(dnew, dentry);
>         if (!err)
>                 err =3D nfserrno(commit_metadata(fhp));
> -       dput(dnew);
> -       if (err=3D=3D0) err =3D cerr;
> +       if (!err)
> +               err =3D cerr;
>  out_drop_write:
>         fh_drop_write(fhp);
>  out:
> @@ -1788,32 +1783,31 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *=
ffhp,
>
>         ddir =3D ffhp->fh_dentry;
>         dirp =3D d_inode(ddir);
> -       inode_lock_nested(dirp, I_MUTEX_PARENT);
> +       dnew =3D start_creating(&nop_mnt_idmap, ddir, &QSTR_LEN(name, len=
));
>
> -       dnew =3D lookup_one(&nop_mnt_idmap, &QSTR_LEN(name, len), ddir);
>         if (IS_ERR(dnew)) {
>                 host_err =3D PTR_ERR(dnew);
> -               goto out_unlock;
> +               goto out_drop_write;
>         }
>
>         dold =3D tfhp->fh_dentry;
>
>         err =3D nfserr_noent;
>         if (d_really_is_negative(dold))
> -               goto out_dput;
> +               goto out_unlock;
>         err =3D fh_fill_pre_attrs(ffhp);
>         if (err !=3D nfs_ok)
> -               goto out_dput;
> +               goto out_unlock;
>         host_err =3D vfs_link(dold, &nop_mnt_idmap, dirp, dnew, NULL);
>         fh_fill_post_attrs(ffhp);
> -       inode_unlock(dirp);
> +out_unlock:
> +       end_creating(dnew, ddir);
>         if (!host_err) {
>                 host_err =3D commit_metadata(ffhp);
>                 if (!host_err)
>                         host_err =3D commit_metadata(tfhp);
>         }
>
> -       dput(dnew);
>  out_drop_write:
>         fh_drop_write(tfhp);
>         if (host_err =3D=3D -EBUSY) {
> @@ -1828,12 +1822,6 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *f=
fhp,
>         }
>  out:
>         return err !=3D nfs_ok ? err : nfserrno(host_err);
> -
> -out_dput:
> -       dput(dnew);
> -out_unlock:
> -       inode_unlock(dirp);
> -       goto out_drop_write;
>  }
>
>  static void
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index 27396fe63f6d..6a31ea34ff80 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -613,9 +613,9 @@ static int ovl_link_up(struct ovl_copy_up_ctx *c)
>         if (err)
>                 goto out;
>
> -       inode_lock_nested(udir, I_MUTEX_PARENT);
> -       upper =3D ovl_lookup_upper(ofs, c->dentry->d_name.name, upperdir,
> -                                c->dentry->d_name.len);
> +       upper =3D ovl_start_creating_upper(ofs, upperdir,
> +                                        &QSTR_LEN(c->dentry->d_name.name=
,
> +                                                  c->dentry->d_name.len)=
);
>         err =3D PTR_ERR(upper);
>         if (!IS_ERR(upper)) {
>                 err =3D ovl_do_link(ofs, ovl_dentry_upper(c->dentry), udi=
r, upper);
> @@ -626,9 +626,8 @@ static int ovl_link_up(struct ovl_copy_up_ctx *c)
>                         ovl_dentry_set_upper_alias(c->dentry);
>                         ovl_dentry_update_reval(c->dentry, upper);
>                 }
> -               dput(upper);
> +               end_creating(upper, upperdir);
>         }
> -       inode_unlock(udir);
>         if (err)
>                 goto out;
>
> @@ -894,16 +893,14 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_c=
tx *c)
>         if (err)
>                 goto out;
>
> -       inode_lock_nested(udir, I_MUTEX_PARENT);
> -
> -       upper =3D ovl_lookup_upper(ofs, c->destname.name, c->destdir,
> -                                c->destname.len);
> +       upper =3D ovl_start_creating_upper(ofs, c->destdir,
> +                                        &QSTR_LEN(c->destname.name,
> +                                                  c->destname.len));
>         err =3D PTR_ERR(upper);
>         if (!IS_ERR(upper)) {
>                 err =3D ovl_do_link(ofs, temp, udir, upper);
> -               dput(upper);
> +               end_creating(upper, c->destdir);
>         }
> -       inode_unlock(udir);
>
>         if (err)
>                 goto out;
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index dbd63a74df4b..0ae79efbfce7 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -59,15 +59,21 @@ int ovl_cleanup(struct ovl_fs *ofs, struct dentry *wo=
rkdir,
>         return 0;
>  }
>
> -struct dentry *ovl_lookup_temp(struct ovl_fs *ofs, struct dentry *workdi=
r)
> +#define OVL_TEMPNAME_SIZE 20
> +static void ovl_tempname(char name[OVL_TEMPNAME_SIZE])
>  {
> -       struct dentry *temp;
> -       char name[20];
>         static atomic_t temp_id =3D ATOMIC_INIT(0);
>
>         /* counter is allowed to wrap, since temp dentries are ephemeral =
*/
> -       snprintf(name, sizeof(name), "#%x", atomic_inc_return(&temp_id));
> +       snprintf(name, OVL_TEMPNAME_SIZE, "#%x", atomic_inc_return(&temp_=
id));
> +}
> +
> +struct dentry *ovl_lookup_temp(struct ovl_fs *ofs, struct dentry *workdi=
r)
> +{
> +       struct dentry *temp;
> +       char name[OVL_TEMPNAME_SIZE];
>
> +       ovl_tempname(name);
>         temp =3D ovl_lookup_upper(ofs, name, workdir, strlen(name));
>         if (!IS_ERR(temp) && temp->d_inode) {
>                 pr_err("workdir/%s already exists\n", name);
> @@ -78,6 +84,16 @@ struct dentry *ovl_lookup_temp(struct ovl_fs *ofs, str=
uct dentry *workdir)
>         return temp;
>  }
>
> +static struct dentry *ovl_start_creating_temp(struct ovl_fs *ofs,
> +                                             struct dentry *workdir)
> +{
> +       char name[OVL_TEMPNAME_SIZE];
> +
> +       ovl_tempname(name);
> +       return start_creating(ovl_upper_mnt_idmap(ofs), workdir,
> +                             &QSTR(name));
> +}
> +
>  static struct dentry *ovl_whiteout(struct ovl_fs *ofs)
>  {
>         int err;
> @@ -88,35 +104,31 @@ static struct dentry *ovl_whiteout(struct ovl_fs *of=
s)
>         guard(mutex)(&ofs->whiteout_lock);
>
>         if (!ofs->whiteout) {
> -               inode_lock_nested(wdir, I_MUTEX_PARENT);
> -               whiteout =3D ovl_lookup_temp(ofs, workdir);
> -               if (!IS_ERR(whiteout)) {
> -                       err =3D ovl_do_whiteout(ofs, wdir, whiteout);
> -                       if (err) {
> -                               dput(whiteout);
> -                               whiteout =3D ERR_PTR(err);
> -                       }
> -               }
> -               inode_unlock(wdir);
> +               whiteout =3D ovl_start_creating_temp(ofs, workdir);
>                 if (IS_ERR(whiteout))
>                         return whiteout;
> -               ofs->whiteout =3D whiteout;
> +               err =3D ovl_do_whiteout(ofs, wdir, whiteout);
> +               if (!err)
> +                       ofs->whiteout =3D dget(whiteout);
> +               end_creating(whiteout, workdir);
> +               if (err)
> +                       return ERR_PTR(err);
>         }
>
>         if (!ofs->no_shared_whiteout) {
> -               inode_lock_nested(wdir, I_MUTEX_PARENT);
> -               whiteout =3D ovl_lookup_temp(ofs, workdir);
> -               if (!IS_ERR(whiteout)) {
> -                       err =3D ovl_do_link(ofs, ofs->whiteout, wdir, whi=
teout);
> -                       if (err) {
> -                               dput(whiteout);
> -                               whiteout =3D ERR_PTR(err);
> -                       }
> -               }
> -               inode_unlock(wdir);
> -               if (!IS_ERR(whiteout))
> +               struct dentry *ret =3D NULL;

For clarity please name this var "link".

> +
> +               whiteout =3D ovl_start_creating_temp(ofs, workdir);
> +               if (IS_ERR(whiteout))
>                         return whiteout;
> -               if (PTR_ERR(whiteout) !=3D -EMLINK) {
> +               err =3D ovl_do_link(ofs, ofs->whiteout, wdir, whiteout);
> +               if (!err)
> +                       ret =3D dget(whiteout);
> +               end_creating(whiteout, workdir);
> +               if (ret)
> +                       return ret;
> +
> +               if (err !=3D -EMLINK) {
>                         pr_warn("Failed to link whiteout - disabling whit=
eout inode sharing(nlink=3D%u, err=3D%lu)\n",
>                                 ofs->whiteout->d_inode->i_nlink,
>                                 PTR_ERR(whiteout));
> @@ -225,10 +237,13 @@ struct dentry *ovl_create_temp(struct ovl_fs *ofs, =
struct dentry *workdir,
>                                struct ovl_cattr *attr)
>  {
>         struct dentry *ret;
> -       inode_lock_nested(workdir->d_inode, I_MUTEX_PARENT);
> -       ret =3D ovl_create_real(ofs, workdir,
> -                             ovl_lookup_temp(ofs, workdir), attr);
> -       inode_unlock(workdir->d_inode);
> +       ret =3D ovl_start_creating_temp(ofs, workdir);
> +       if (IS_ERR(ret))
> +               return ret;
> +       ret =3D ovl_create_real(ofs, workdir, ret, attr);
> +       if (!IS_ERR(ret))
> +               dget(ret);
> +       end_creating(ret, workdir);
>         return ret;
>  }
>
> @@ -327,18 +342,21 @@ static int ovl_create_upper(struct dentry *dentry, =
struct inode *inode,
>  {
>         struct ovl_fs *ofs =3D OVL_FS(dentry->d_sb);
>         struct dentry *upperdir =3D ovl_dentry_upper(dentry->d_parent);
> -       struct inode *udir =3D upperdir->d_inode;
>         struct dentry *newdentry;
>         int err;
>
> -       inode_lock_nested(udir, I_MUTEX_PARENT);
> -       newdentry =3D ovl_create_real(ofs, upperdir,
> -                                   ovl_lookup_upper(ofs, dentry->d_name.=
name,
> -                                                    upperdir, dentry->d_=
name.len),
> -                                   attr);
> -       inode_unlock(udir);
> +       newdentry =3D ovl_start_creating_upper(ofs, upperdir,
> +                                            &QSTR_LEN(dentry->d_name.nam=
e,
> +                                                      dentry->d_name.len=
));
>         if (IS_ERR(newdentry))
>                 return PTR_ERR(newdentry);
> +       newdentry =3D ovl_create_real(ofs, upperdir, newdentry, attr);
> +       if (IS_ERR(newdentry)) {
> +               end_creating(newdentry, upperdir);
> +               return PTR_ERR(newdentry);
> +       }
> +       dget(newdentry);
> +       end_creating(newdentry, upperdir);

See suggestion below to make this:

        newdentry =3D end_creating_dentry(newdentry, upperdir);
        if (IS_ERR(newdentry))
                   return PTR_ERR(newdentry);

>
>         if (ovl_type_merge(dentry->d_parent) && d_is_dir(newdentry) &&
>             !ovl_allow_offline_changes(ofs)) {
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 4f84abaa0d68..c24c2da953bd 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -415,6 +415,14 @@ static inline struct dentry *ovl_lookup_upper_unlock=
ed(struct ovl_fs *ofs,
>                                    &QSTR_LEN(name, len), base);
>  }
>
> +static inline struct dentry *ovl_start_creating_upper(struct ovl_fs *ofs=
,
> +                                                     struct dentry *pare=
nt,
> +                                                     struct qstr *name)
> +{
> +       return start_creating(ovl_upper_mnt_idmap(ofs),
> +                             parent, name);
> +}
> +
>  static inline bool ovl_open_flags_need_copy_up(int flags)
>  {
>         if (!flags)
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index bd3d7ba8fb95..67abb62e205b 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -300,8 +300,7 @@ static struct dentry *ovl_workdir_create(struct ovl_f=
s *ofs,
>         bool retried =3D false;
>
>  retry:
> -       inode_lock_nested(dir, I_MUTEX_PARENT);
> -       work =3D ovl_lookup_upper(ofs, name, ofs->workbasedir, strlen(nam=
e));
> +       work =3D ovl_start_creating_upper(ofs, ofs->workbasedir, &QSTR(na=
me));
>
>         if (!IS_ERR(work)) {
>                 struct iattr attr =3D {
> @@ -310,14 +309,13 @@ static struct dentry *ovl_workdir_create(struct ovl=
_fs *ofs,
>                 };
>
>                 if (work->d_inode) {
> +                       dget(work);
> +                       end_creating(work, ofs->workbasedir);
> +                       if (persist)
> +                               return work;
>                         err =3D -EEXIST;
> -                       inode_unlock(dir);
>                         if (retried)
>                                 goto out_dput;
> -
> -                       if (persist)
> -                               return work;
> -
>                         retried =3D true;
>                         err =3D ovl_workdir_cleanup(ofs, ofs->workbasedir=
, mnt, work, 0);
>                         dput(work);
> @@ -328,7 +326,9 @@ static struct dentry *ovl_workdir_create(struct ovl_f=
s *ofs,
>                 }
>
>                 work =3D ovl_do_mkdir(ofs, dir, work, attr.ia_mode);
> -               inode_unlock(dir);
> +               if (!IS_ERR(work))
> +                       dget(work);
> +               end_creating(work, ofs->workbasedir);
>                 err =3D PTR_ERR(work);
>                 if (IS_ERR(work))
>                         goto out_err;
> @@ -366,7 +366,6 @@ static struct dentry *ovl_workdir_create(struct ovl_f=
s *ofs,
>                 if (err)
>                         goto out_dput;
>         } else {
> -               inode_unlock(dir);
>                 err =3D PTR_ERR(work);
>                 goto out_err;
>         }
> @@ -616,14 +615,17 @@ static struct dentry *ovl_lookup_or_create(struct o=
vl_fs *ofs,
>                                            struct dentry *parent,
>                                            const char *name, umode_t mode=
)
>  {
> -       size_t len =3D strlen(name);
>         struct dentry *child;
>
> -       inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
> -       child =3D ovl_lookup_upper(ofs, name, parent, len);
> -       if (!IS_ERR(child) && !child->d_inode)
> -               child =3D ovl_create_real(ofs, parent, child, OVL_CATTR(m=
ode));
> -       inode_unlock(parent->d_inode);
> +       child =3D ovl_start_creating_upper(ofs, parent, &QSTR(name));
> +       if (!IS_ERR(child)) {
> +               if (!child->d_inode)
> +                       child =3D ovl_create_real(ofs, parent, child,
> +                                               OVL_CATTR(mode));
> +               if (!IS_ERR(child))
> +                       dget(child);
> +               end_creating(child, parent);

We have a few of those things open code which are not so pretty IMO.
How about:

child =3D end_creating_dentry(child, parent);

Which is a variant of the void end_creating() which does dget()
in the non error case?

end_creating_dentry() could be matched with start_creating_dentry()
in common cases where we had a ref on the child before creating and
we want to keep the ref on the child after creating.

> +       }
>         dput(parent);
>
>         return child;
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index a7800ef04e76..4cbe930054a1 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -88,6 +88,24 @@ struct dentry *lookup_one_positive_killable(struct mnt=
_idmap *idmap,
>                                             struct qstr *name,
>                                             struct dentry *base);
>
> +struct dentry *start_creating(struct mnt_idmap *idmap, struct dentry *pa=
rent,
> +                             struct qstr *name);
> +
> +/* end_creating - finish action started with start_creating
> + * @child - dentry returned by start_creating()
> + * @parent - dentry given to start_creating()
> + *
> + * Unlock and release the child.
> + *
> + * Unlike end_dirop() this can only be called if start_creating() succee=
ded.
> + * It handles @child being and error as vfs_mkdir() might have converted=
 the
> + * dentry to an error - in that case the parent still needs to be unlock=
ed.
> + */
> +static inline void end_creating(struct dentry *child, struct dentry *par=
ent)
> +{
> +       end_dirop_mkdir(child, parent);
> +}
> +

That concludes my out-of-order review of this series.

The ovl changes look overall good to me.
I will wait for v2 without end_dirop_mkdir() to re-review this patch.

Feel free to take or discard my suggestion for end_creating_dentry().

I agree with Jeff that the conversion of if condition to a while loop in
cachefiles feels odd, because it is not clear if there should be a stop
condition. Anyway, best if cachefiles developers could review this
code anyway.

Thanks,
Amir.

