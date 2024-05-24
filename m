Return-Path: <linux-fsdevel+bounces-20111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 855DE8CE565
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 14:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB37F1F2121E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 12:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED8186244;
	Fri, 24 May 2024 12:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1LOAeed"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9C184E17
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 May 2024 12:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716554163; cv=none; b=Ya/iN07S/vj+ovV+UnPF+bYKCqrh10ob1bMJxq1IM24X5ReRI+QtnwykwifM5gubZhnDF+VNh0nTizsVkJCRvGq5eigmVWhhL7GluVnRG7mmfdSVFXKAS4UxgIqm0Jh80z2Y4nrJWhbjCyzH++bqKRcn4NFfiM4XKCaW4hTV0lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716554163; c=relaxed/simple;
	bh=Z/FSgRW9iKfsnF5sCmsurdYI6VCr9eM6fNJI4hVJUFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WhRHorT/hzI5D86tVzVxWK0jXnZ2Fi28DzE8QtSnsltyIC3/NWTinZUbQqNK/X7bRXDQnnmfkSxrEOvweJQ+h3JLt92u8F/ItuF9+zPZDfznxBT2rDcE1x4CA7VsiFN62ZuYx6e8VmSBeU+lqogHw0wOOiJEGfanpTIcIyb3xdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1LOAeed; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-794ab12341aso60621585a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 May 2024 05:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716554160; x=1717158960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXUd/5WW9Ebq3hlEZmky3n9q7umb5jUl+/ZHNJ/uQuM=;
        b=N1LOAeedOAeQAIl8ziXvTLC00ww7WMRg5Dp13u4zMteiQ1iYXddoA0H9ol4q91YzwK
         lYAr8fZB+w3wx5AiOs001FFiwsq0ukIF4sbuMvSVVRM+TJk1BFJr0pBQFJ1AlcU0QMW8
         Pv0y34ju/J5VJhllPm/dP+JgNq5gZapH/v+qDkTB9Ds+dGU4jJnrfLtWCcNjTT08W4kp
         CCJeauOiI1b7dpq2OEZ8smPckbKCcfWLgIoVlBPhObDXYnq+KtAw91+i+RJGc/Njg8GR
         +N/UooQLCpy7/WYowHs9NkjkGuCe+wJjxJ0w01DcTkeB2aLDBXNy7sMlZTq4Vji/HE1S
         8Xww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716554160; x=1717158960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SXUd/5WW9Ebq3hlEZmky3n9q7umb5jUl+/ZHNJ/uQuM=;
        b=FZ944boqZ8c2GZARVv1krvQruUDUWX53BA5+OX70cF1GD7WrunWjFLEKIdqJEXh3z6
         orzyuCOdEXaZT4MZWVPMVfCn6ufv1TKi3r+2ydTC8FIsGs+IcDmmqal8647M8sFw8LgO
         XkDa3vjhDiq7X5I5khzLJhFfEz7b7l7f/AUsL89V2g/RrUdkwetRxpQBFsSEv+vxXL9j
         KRL+dQrnNdtKvjMn8sM+f51Lc5bVYPvGz3iRIEH/E0dkFzGVIN3qSUtcYGSwsD0+oqFU
         YmOOO7LD7ifbgPuIeo2AHVXxoGRjQdMwoI3EW4cPABvDvwaA9Xpoiv+7GYl0CJFwW7I9
         XxNA==
X-Forwarded-Encrypted: i=1; AJvYcCVJqsZdRrDZLSbbEicQm20h+O4j8nJ1RPlLL/ocQgv/a2CnCMmQuyXaMSx2iUKkJQMQDv89I6TU6XPQ7i7TqlOuoVgj974iFk2vPQeWqw==
X-Gm-Message-State: AOJu0YzLm7+BGC2/ZIG0Z3s1zT6o07+NIj5dekAq5olwJn52y1lcOTCB
	TqXC8BtCp3gfzlK3RwugajGf2nUG3k41dYWoQJRvi+mXz1O2uZPSmNh/mLoSu6jQSwY/i+6zsiU
	PSn8DKO8zkUAmoPoGPyQLjnpflz46+/f0
X-Google-Smtp-Source: AGHT+IHrvgChnHRLQop/GTLdypgo/Y4B/6ZJX9HvVoQCliybeF507Jujs6WqBjVrtBn/c7EOFc7trzSSoJzSAT3C1eI=
X-Received: by 2002:a05:6214:3904:b0:6ad:5b0d:e169 with SMTP id
 6a1803df08f44-6ad5b0df94emr15487366d6.15.1716554160156; Fri, 24 May 2024
 05:36:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524-vfs-open_by_handle_at-v1-1-3d4b7d22736b@kernel.org>
In-Reply-To: <20240524-vfs-open_by_handle_at-v1-1-3d4b7d22736b@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 24 May 2024 15:35:47 +0300
Message-ID: <CAOQ4uxhjQwvJZEcuPyOg02rcDgcLfHQL-zhUGUmTf1VD8cCg4w@mail.gmail.com>
Subject: Re: [PATCH RFC] : fhandle: relax open_by_handle_at() permission checks
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 1:19=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> A current limitation of open_by_handle_at() is that it's currently not po=
ssible
> to use it from within containers at all because we require CAP_DAC_READ_S=
EARCH
> in the initial namespace. That's unfortunate because there are scenarios =
where
> using open_by_handle_at() from within containers.
>
> Two examples:
>
> (1) cgroupfs allows to encode cgroups to file handles and reopen them wit=
h
>     open_by_handle_at().
> (2) Fanotify allows placing filesystem watches they currently aren't usab=
le in
>     containers because the returned file handles cannot be used.
>
> Here's a proposal for relaxing the permission check for open_by_handle_at=
().
>
> (1) Opening file handles when the caller has privileges over the filesyst=
em
>     (1.1) The caller has an unobstructed view of the filesystem.
>     (1.2) The caller has permissions to follow a path to the file handle.
>
> This doesn't address the problem of opening a file handle when only a por=
tion
> of a filesystem is exposed as is common in containers by e.g., bind-mount=
ing a
> subtree. The proposal to solve this use-case is:
>
> (2) Opening file handles when the caller has privileges over a subtree
>     (2.1) The caller is able to reach the file from the provided mount fd=
.
>     (2.2) The caller has permissions to construct an unobstructed path to=
 the
>           file handle.
>     (2.3) The caller has permissions to follow a path to the file handle.
>
> The relaxed permission checks are currently restricted to directory file
> handles which are what both cgroupfs and fanotify need. Handling disconne=
cted
> non-directory file handles would lead to a potentially non-deterministic =
api.
> If a disconnected non-directory file handle is provided we may fail to de=
code
> a valid path that we could use for permission checking. That in itself is=
n't a
> problem as we would just return EACCES in that case. However, confusion m=
ay
> arise if a non-disconnected dentry ends up in the cache later and those o=
pening
> the file handle would suddenly succeed.
>
> * It's potentially possible to use timing information (side-channel) to i=
nfer
>   whether a given inode exists. I don't think that's particularly
>   problematic. Thanks to Jann for bringing this to my attention.
>
> * An unrelated note (IOW, these are thoughts that apply to
>   open_by_handle_at() generically and are unrelated to the changes here):
>   Jann pointed out that we should verify whether deleted files could
>   potentially be reopened through open_by_handle_at(). I don't think that=
's
>   possible though.

AFAICT, the only thing that currently makes this impossible in this patch
is the O_DIRECTORY limitation.
Because there could be non-directory non-hashed aliases of deleted
files in dcache.

>
>   Another potential thing to check is whether open_by_handle_at() could b=
e
>   abused to open internal stuff like memfds or gpu stuff. I don't think s=
o
>   but I haven't had the time to completely verify this.

Yeh, I don't think that those fs have ->s_export_op.

>
> This dates back to discussions Amir and I had quite some time ago and tha=
nks to
> him for providing a lot of details around the export code and related pat=
ches!
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Apart from minor nits below, you may add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/exportfs/expfs.c      |   9 ++-
>  fs/fhandle.c             | 162 ++++++++++++++++++++++++++++++++++++-----=
------
>  fs/mount.h               |   1 +
>  fs/namespace.c           |   2 +-
>  fs/nfsd/nfsfh.c          |   2 +-
>  include/linux/exportfs.h |   1 +
>  6 files changed, 137 insertions(+), 40 deletions(-)
>
> diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
> index 07ea3d62b298..b23b052df715 100644
> --- a/fs/exportfs/expfs.c
> +++ b/fs/exportfs/expfs.c
> @@ -427,7 +427,7 @@ EXPORT_SYMBOL_GPL(exportfs_encode_fh);
>
>  struct dentry *
>  exportfs_decode_fh_raw(struct vfsmount *mnt, struct fid *fid, int fh_len=
,
> -                      int fileid_type,
> +                      int fileid_type, bool directory,
>                        int (*acceptable)(void *, struct dentry *),
>                        void *context)
>  {
> @@ -445,6 +445,11 @@ exportfs_decode_fh_raw(struct vfsmount *mnt, struct =
fid *fid, int fh_len,
>         if (IS_ERR_OR_NULL(result))
>                 return result;
>
> +       if (directory && !d_is_dir(result)) {
> +               err =3D -ENOTDIR;
> +               goto err_result;
> +       }
> +
>         /*
>          * If no acceptance criteria was specified by caller, a disconnec=
ted
>          * dentry is also accepatable. Callers may use this mode to query=
 if
> @@ -581,7 +586,7 @@ struct dentry *exportfs_decode_fh(struct vfsmount *mn=
t, struct fid *fid,
>  {
>         struct dentry *ret;
>
> -       ret =3D exportfs_decode_fh_raw(mnt, fid, fh_len, fileid_type,
> +       ret =3D exportfs_decode_fh_raw(mnt, fid, fh_len, fileid_type, fal=
se,
>                                      acceptable, context);
>         if (IS_ERR_OR_NULL(ret)) {
>                 if (ret =3D=3D ERR_PTR(-ENOMEM))
> diff --git a/fs/fhandle.c b/fs/fhandle.c
> index 8a7f86c2139a..c6ed832ddbb8 100644
> --- a/fs/fhandle.c
> +++ b/fs/fhandle.c
> @@ -115,88 +115,174 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, const=
 char __user *, name,
>         return err;
>  }
>
> -static struct vfsmount *get_vfsmount_from_fd(int fd)
> +static int get_path_from_fd(int fd, struct path *root)
>  {
> -       struct vfsmount *mnt;
> -
>         if (fd =3D=3D AT_FDCWD) {
>                 struct fs_struct *fs =3D current->fs;
>                 spin_lock(&fs->lock);
> -               mnt =3D mntget(fs->pwd.mnt);
> +               *root =3D fs->pwd;
> +               path_get(root);
>                 spin_unlock(&fs->lock);
>         } else {
>                 struct fd f =3D fdget(fd);
>                 if (!f.file)
> -                       return ERR_PTR(-EBADF);
> -               mnt =3D mntget(f.file->f_path.mnt);
> +                       return -EBADF;
> +               *root =3D f.file->f_path;
> +               path_get(root);
>                 fdput(f);
>         }
> -       return mnt;
> +
> +       return 0;
>  }
>
> +enum handle_to_path_flags {
> +       HANDLE_CHECK_PERMS   =3D (1 << 0),
> +       HANDLE_CHECK_SUBTREE =3D (1 << 1),
> +};
> +
> +struct handle_to_path_ctx {
> +       struct path root;
> +       enum handle_to_path_flags flags;
> +       bool directory;
> +};
> +
>  static int vfs_dentry_acceptable(void *context, struct dentry *dentry)
>  {
> -       return 1;
> +       struct handle_to_path_ctx *ctx =3D context;
> +       struct user_namespace *user_ns =3D current_user_ns();
> +       struct dentry *d, *root =3D ctx->root.dentry;
> +       struct mnt_idmap *idmap =3D mnt_idmap(ctx->root.mnt);
> +       int retval =3D 0;
> +
> +       if (!root)
> +               return 1;
> +
> +       /* Old permission model with global CAP_DAC_READ_SEARCH. */
> +       if (!ctx->flags)
> +               return 1;
> +
> +       /*
> +        * It's racy as we're not taking rename_lock but we're able to ig=
nore
> +        * permissions and we just need an approximation whether we were =
able
> +        * to follow a path to the file.
> +        */
> +       d =3D dget(dentry);
> +       while (d !=3D root && !IS_ROOT(d)) {
> +               struct dentry *parent =3D dget_parent(d);
> +
> +               /*
> +                * We know that we have the ability to override DAC permi=
ssions
> +                * as we've verified this earlier via CAP_DAC_READ_SEARCH=
. But
> +                * we also need to make sure that there aren't any unmapp=
ed
> +                * inodes in the path that would prevent us from reaching=
 the
> +                * file.
> +                */
> +               if (!privileged_wrt_inode_uidgid(user_ns, idmap,
> +                                                d_inode(parent))) {
> +                       dput(d);
> +                       dput(parent);
> +                       return retval;
> +               }
> +
> +               dput(d);
> +               d =3D parent;
> +       }
> +
> +       if (!(ctx->flags & HANDLE_CHECK_SUBTREE) || d =3D=3D root)
> +               retval =3D 1;
> +

Maybe leave an assertion, to make sure we have not missed
anything with the O_DIRECTORY assumptions:

WARN_ON_ONCE(d =3D=3D root || d =3D=3D root->d_sb->s_root);

> +       dput(d);
> +       return retval;
>  }
>
>  static int do_handle_to_path(int mountdirfd, struct file_handle *handle,
> -                            struct path *path)
> +                            struct path *path, struct handle_to_path_ctx=
 *ctx)
>  {
> -       int retval =3D 0;
>         int handle_dwords;
> +       struct vfsmount *mnt =3D ctx->root.mnt;
>
> -       path->mnt =3D get_vfsmount_from_fd(mountdirfd);
> -       if (IS_ERR(path->mnt)) {
> -               retval =3D PTR_ERR(path->mnt);
> -               goto out_err;
> -       }
>         /* change the handle size to multiple of sizeof(u32) */
>         handle_dwords =3D handle->handle_bytes >> 2;
> -       path->dentry =3D exportfs_decode_fh(path->mnt,
> +       path->dentry =3D exportfs_decode_fh_raw(mnt,
>                                           (struct fid *)handle->f_handle,
>                                           handle_dwords, handle->handle_t=
ype,
> -                                         vfs_dentry_acceptable, NULL);
> -       if (IS_ERR(path->dentry)) {
> -               retval =3D PTR_ERR(path->dentry);
> -               goto out_mnt;
> +                                         ctx->directory,
> +                                         vfs_dentry_acceptable, ctx);
> +       if (IS_ERR_OR_NULL(path->dentry)) {
> +               if (path->dentry =3D=3D ERR_PTR(-ENOMEM))
> +                       return -ENOMEM;
> +               return -ESTALE;
>         }
> +       path->mnt =3D mntget(mnt);
>         return 0;
> -out_mnt:
> -       mntput(path->mnt);
> -out_err:
> -       return retval;
>  }
>
>  static int handle_to_path(int mountdirfd, struct file_handle __user *ufh=
,
> -                  struct path *path)
> +                  struct path *path, unsigned int o_flags)
>  {
>         int retval =3D 0;
>         struct file_handle f_handle;
>         struct file_handle *handle =3D NULL;
> +       struct handle_to_path_ctx ctx =3D {};
> +
> +       retval =3D get_path_from_fd(mountdirfd, &ctx.root);
> +       if (retval)
> +               goto out_err;
>
> -       /*
> -        * With handle we don't look at the execute bit on the
> -        * directory. Ideally we would like CAP_DAC_SEARCH.
> -        * But we don't have that
> -        */
>         if (!capable(CAP_DAC_READ_SEARCH)) {
> +               /*
> +                * Allow relaxed permissions of file handles if the calle=
r has
> +                * the ability to mount the filesystem or create a bind-m=
ount
> +                * of the provided @mountdirfd.
> +                *
> +                * In both cases the caller may be able to get an unobstr=
ucted
> +                * way to the encoded file handle. If the caller is only =
able
> +                * to create a bind-mount we need to verify that there ar=
e no
> +                * locked mounts on top of it that could prevent us from
> +                * getting to the encoded file.
> +                *
> +                * In principle, locked mounts can prevent the caller fro=
m
> +                * mounting the filesystem but that only applies to procf=
s and
> +                * sysfs neither of which support decoding file handles.
> +                *
> +                * This is currently restricted to O_DIRECTORY to provide=
 a
> +                * deterministic API that avoids a confusing api in the f=
ace of
> +                * disconnected non-dir dentries.
> +                */
> +
>                 retval =3D -EPERM;
> -               goto out_err;
> +               if (!(o_flags & O_DIRECTORY))
> +                       goto out_path;
> +
> +               if (ns_capable(ctx.root.mnt->mnt_sb->s_user_ns, CAP_SYS_A=
DMIN))
> +                       ctx.flags =3D HANDLE_CHECK_PERMS;
> +               else if (ns_capable(real_mount(ctx.root.mnt)->mnt_ns->use=
r_ns, CAP_SYS_ADMIN) &&
> +                          !has_locked_children(real_mount(ctx.root.mnt),=
 ctx.root.dentry))
> +                       ctx.flags =3D HANDLE_CHECK_PERMS | HANDLE_CHECK_S=
UBTREE;
> +               else
> +                       goto out_path;
> +
> +               /* Are we able to override DAC permissions? */
> +               if (!ns_capable(current_user_ns(), CAP_DAC_READ_SEARCH))
> +                       goto out_path;
> +
> +               ctx.directory =3D true;
>         }
> +
>         if (copy_from_user(&f_handle, ufh, sizeof(struct file_handle))) {
>                 retval =3D -EFAULT;
> -               goto out_err;
> +               goto out_path;
>         }
>         if ((f_handle.handle_bytes > MAX_HANDLE_SZ) ||
>             (f_handle.handle_bytes =3D=3D 0)) {
>                 retval =3D -EINVAL;
> -               goto out_err;
> +               goto out_path;
>         }
>         handle =3D kmalloc(struct_size(handle, f_handle, f_handle.handle_=
bytes),
>                          GFP_KERNEL);
>         if (!handle) {
>                 retval =3D -ENOMEM;
> -               goto out_err;
> +               goto out_path;
>         }
>         /* copy the full handle */
>         *handle =3D f_handle;
> @@ -207,10 +293,14 @@ static int handle_to_path(int mountdirfd, struct fi=
le_handle __user *ufh,
>                 goto out_handle;
>         }
>
> -       retval =3D do_handle_to_path(mountdirfd, handle, path);
> +       retval =3D do_handle_to_path(mountdirfd, handle, path, &ctx);
> +       if (retval)
> +               goto out_handle;

no real need for this goto unless you wanted it here for future code.

>
>  out_handle:
>         kfree(handle);
> +out_path:
> +       path_put(&ctx.root);
>  out_err:
>         return retval;
>  }
> @@ -223,7 +313,7 @@ static long do_handle_open(int mountdirfd, struct fil=
e_handle __user *ufh,
>         struct file *file;
>         int fd;
>
> -       retval =3D handle_to_path(mountdirfd, ufh, &path);
> +       retval =3D handle_to_path(mountdirfd, ufh, &path, open_flag);
>         if (retval)
>                 return retval;
>
> diff --git a/fs/mount.h b/fs/mount.h
> index 4a42fc68f4cc..4adce73211ae 100644
> --- a/fs/mount.h
> +++ b/fs/mount.h
> @@ -152,3 +152,4 @@ static inline void move_from_ns(struct mount *mnt, st=
ruct list_head *dt_list)
>  }
>
>  extern void mnt_cursor_del(struct mnt_namespace *ns, struct mount *curso=
r);
> +bool has_locked_children(struct mount *mnt, struct dentry *dentry);
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 5a51315c6678..4386787210c7 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2078,7 +2078,7 @@ void drop_collected_mounts(struct vfsmount *mnt)
>         namespace_unlock();
>  }
>
> -static bool has_locked_children(struct mount *mnt, struct dentry *dentry=
)
> +bool has_locked_children(struct mount *mnt, struct dentry *dentry)
>  {
>         struct mount *child;
>
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index 0b75305fb5f5..3e7f81eb2818 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -247,7 +247,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqs=
tp, struct svc_fh *fhp)
>                 dentry =3D dget(exp->ex_path.dentry);
>         else {
>                 dentry =3D exportfs_decode_fh_raw(exp->ex_path.mnt, fid,
> -                                               data_left, fileid_type,
> +                                               data_left, fileid_type, f=
alse,
>                                                 nfsd_acceptable, exp);
>                 if (IS_ERR_OR_NULL(dentry)) {
>                         trace_nfsd_set_fh_dentry_badhandle(rqstp, fhp,
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index bb37ad5cc954..90c4b0111218 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -305,6 +305,7 @@ static inline int exportfs_encode_fid(struct inode *i=
node, struct fid *fid,
>  extern struct dentry *exportfs_decode_fh_raw(struct vfsmount *mnt,
>                                              struct fid *fid, int fh_len,
>                                              int fileid_type,
> +                                            bool directory,
>                                              int (*acceptable)(void *, st=
ruct dentry *),
>                                              void *context);
>  extern struct dentry *exportfs_decode_fh(struct vfsmount *mnt, struct fi=
d *fid,


This was confusing me when I saw callers that pass directory=3Dfalse
for any decode, until I realized this was only_directory.
But I got used to it already ;)

Thanks,
Amir.

