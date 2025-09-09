Return-Path: <linux-fsdevel+bounces-60669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA8BB4FEDF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 16:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BD711BC0D97
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 14:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBED9298CBE;
	Tue,  9 Sep 2025 14:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNULyLcn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA16343D7B
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Sep 2025 14:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757426848; cv=none; b=fgsnCIqEA8IbhYuzbQ1O4T/RBZLLHaQQib4jvrzPbRysAfpHj4eJPVfwjq8kigyz/+RxWY1iLAGUfE05hiJEcm4OJZL57EpJFW0RQz7qntgW9X1Q3bYxSdVer2Nlgiq66r/3u/Re/aXU4JjGmF3ZXJTAoSSt06jwfkar0YsgCNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757426848; c=relaxed/simple;
	bh=6SJzcu7ziDwKI0p32XaUxbSne8eVd4XzD5XfgQ/65JI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=njlBWwg+Z3tvsuJVDX0lUc0MKU5mF1w6WkJgrvPnSAZIIFRqKBsCNHHgUOn17xynNpYocD2C0/FHqaL0hmeS0F4EOIZuSj9Vzn4NClNqhwat6J3izKKEQLIfDHuz+5K8W33VyNsIctpI2xbm3ogWzDyu1Bp/P/wx6eyaKgsyKOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNULyLcn; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-62733e779bbso2754852a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Sep 2025 07:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757426844; x=1758031644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qI3uCi+I3Vp/FkZTD+FJaco20QjAvvZpJVWAsLDwf0k=;
        b=hNULyLcn8k4+qk7Ha7035HyM+EmZMIUKEkh3yRdBfqAgu59usqm8Kt771omEBYFgE7
         aLO3kIaKOPr7fNiLNcm0DZo/wrQlWk9e8wPrRW1tOU9dDRuuJjUmfhDBnC8vQxcxCz5q
         LeTNLjRESY//KKAGYdSvhTkiDm+ONrmB05Ce65lZUfjIUamT9ToLJAi9UqK2HRvipu+3
         oFEZprwYwiyBDZTQvAE0wiTLKGx1BmxloEF8xUnhTx5zPOlMTRm+rE2mLSWzmIupFLex
         CQfE/UO3QdlhIll2oxULuye/64ViLv1yO+m6fkt+Nz6v59xlyQx22ep2biYNQ8mykem7
         AMVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757426844; x=1758031644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qI3uCi+I3Vp/FkZTD+FJaco20QjAvvZpJVWAsLDwf0k=;
        b=H9/dGdtRHEHgrOYXT4EKFt240YNMO8ipvmk+jYauI6qMyLbofbPIBfPqFNwbDJ275r
         kJ83fBGF54MU+Be/aLS3EZgfif67WaLRNoRUJDJXZluZ9RJ8uKWKwzOxSVml6+f64J5n
         4R6p+Av6POANgJy9kCOGg2/prICrSgAM+hF4JpWfX718PY2IyRz+XKY04hNuxF1H+Amz
         dLZwuFE8kpJ2v+Ne9ilIWzncFrT4vn0WPstKI/kTb1ZL6TkDOA2SrFpJjf9M8Gs9sNub
         EQ94u1a/s8GKEnG673QqWiIN5LAWLquv9t1RgG80trfqTPPUgHi/mPyx9qh8ApypCFEg
         Yhqw==
X-Forwarded-Encrypted: i=1; AJvYcCVVbYZb+TCJlqQ78iLE4m+pn71D+mzygIgXZXj4IrUWY/rxqGNNuSWa4lf/fVuHZkahhhr4C6Cj/D4Ev9yV@vger.kernel.org
X-Gm-Message-State: AOJu0YywAsjDR8KgRhkljPVGRLsJ13cLlBzG3boKnexNT5mr+s1s4Tto
	yBnAE3CiYfkHlOcWW97+0fAPBlA9QFPhdydCp0CgWwm1xwyshN3Ej/yb+tL5RGh2LSzX0J31J9F
	SFUft9eS9haEEKAQM4938VbUte81f3xE=
X-Gm-Gg: ASbGncu0biPcpghf85FZ5AzMB/uC9x8hiX5Kahj6rTwuQQDIZGmSgtqk6SY04BBfNs4
	ShR5g3fO22eOdNmOG60G9XZYjIpesH8TR7vapYN8ln8ppyKbudR+gOX7omYt++6Rwq+tB/GOqJS
	ezKFNz4aMRs2TNysOQ5MfUm9FiD7k4a7q8UFYa0B5KY/uwQlwwoBKoh5Cu8GJyPSzGDeK2fgZRb
	ckkQ7E=
X-Google-Smtp-Source: AGHT+IEtm9B3E8k9y9MRKD7eZ9jZLIK6z4krT9HCWtigilkcuAW+csk7vvW2dgnU8JkqDF7ceZCLt/GQt92PrGAJK04=
X-Received: by 2002:a05:6402:4309:b0:627:c107:8443 with SMTP id
 4fb4d7f45d1cf-627c1080c85mr8194972a12.14.1757426843032; Tue, 09 Sep 2025
 07:07:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909044637.705116-1-neilb@ownmail.net> <20250909044637.705116-6-neilb@ownmail.net>
In-Reply-To: <20250909044637.705116-6-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 9 Sep 2025 16:07:10 +0200
X-Gm-Features: AS18NWANpmTEICXJJvH9OLRxkRhYawtBCnNP8LIaJqbZ1iwZFrL403KkfyGVE20
Message-ID: <CAOQ4uxhEEVz2KRK-TtS=xjdMbLiOCkT=y66vx8NfzGQOgCZ=MA@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] VFS: rename kern_path_locked() and related functions.
To: neil@brown.name
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 6:48=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote:
>
> From: NeilBrown <neil@brown.name>
>
> kern_path_locked() is now only used to prepare for removing an object
> from the filesystem (and that is the only credible reason for wanting a
> positive locked dentry).  Thus it corresponds to kern_path_create() and
> so should have a corresponding name.
>
> Unfortunately the name "kern_path_create" is somewhat misleading as it
> doesn't actually create anything.  The recently added
> simple_start_creating() provides a better pattern I believe.  The
> "start" can be matched with "end" to bracket the creating or removing.
>
> So this patch changes names:
>
>  kern_path_locked -> start_removing_path
>  kern_path_create -> start_creating_path
>  user_path_create -> start_creating_user_path
>  user_path_locked_at -> start_removing_user_path_at
>  done_path_create -> end_creating_path

This looks nice.

With one comment below fixed feel free to add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

>
> and also introduces end_removing_path() which is identical to
> end_creating_path().
>
> __start_removing_path (which was __kern_path_locked) is enhanced to
> call mnt_want_write() for consistency with the start_creating_path().
>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  Documentation/filesystems/porting.rst        | 12 ++++
>  arch/powerpc/platforms/cell/spufs/syscalls.c |  4 +-
>  drivers/base/devtmpfs.c                      | 22 +++-----
>  fs/bcachefs/fs-ioctl.c                       | 10 ++--
>  fs/init.c                                    | 17 +++---
>  fs/namei.c                                   | 58 ++++++++++++--------
>  fs/ocfs2/refcounttree.c                      |  4 +-
>  fs/smb/server/vfs.c                          |  8 +--
>  include/linux/namei.h                        | 14 +++--
>  kernel/bpf/inode.c                           |  4 +-
>  net/unix/af_unix.c                           |  6 +-
>  11 files changed, 92 insertions(+), 67 deletions(-)
>
> diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesy=
stems/porting.rst
> index 85f590254f07..e0494860be6b 100644
> --- a/Documentation/filesystems/porting.rst
> +++ b/Documentation/filesystems/porting.rst
> @@ -1285,3 +1285,15 @@ rather than a VMA, as the VMA at this stage is not=
 yet valid.
>  The vm_area_desc provides the minimum required information for a filesys=
tem
>  to initialise state upon memory mapping of a file-backed region, and out=
put
>  parameters for the file system to set this state.
> +
> +---
> +
> +**mandatory**
> +
> +Several functions are renamed:
> +
> +-  kern_path_locked -> start_removing_path
> +-  kern_path_create -> start_creating_path
> +-  user_path_create -> start_creating_user_path
> +-  user_path_locked_at -> start_removing_user_path_at
> +-  done_path_create -> end_creating_path
> diff --git a/arch/powerpc/platforms/cell/spufs/syscalls.c b/arch/powerpc/=
platforms/cell/spufs/syscalls.c
> index 157e046e6e93..ea4ba1b6ce6a 100644
> --- a/arch/powerpc/platforms/cell/spufs/syscalls.c
> +++ b/arch/powerpc/platforms/cell/spufs/syscalls.c
> @@ -67,11 +67,11 @@ static long do_spu_create(const char __user *pathname=
, unsigned int flags,
>         struct dentry *dentry;
>         int ret;
>
> -       dentry =3D user_path_create(AT_FDCWD, pathname, &path, LOOKUP_DIR=
ECTORY);
> +       dentry =3D start_creating_user_path(AT_FDCWD, pathname, &path, LO=
OKUP_DIRECTORY);
>         ret =3D PTR_ERR(dentry);
>         if (!IS_ERR(dentry)) {
>                 ret =3D spufs_create(&path, dentry, flags, mode, neighbor=
);
> -               done_path_create(&path, dentry);
> +               end_creating_path(&path, dentry);
>         }
>
>         return ret;
> diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
> index 31bfb3194b4c..9d4e46ad8352 100644
> --- a/drivers/base/devtmpfs.c
> +++ b/drivers/base/devtmpfs.c
> @@ -176,7 +176,7 @@ static int dev_mkdir(const char *name, umode_t mode)
>         struct dentry *dentry;
>         struct path path;
>
> -       dentry =3D kern_path_create(AT_FDCWD, name, &path, LOOKUP_DIRECTO=
RY);
> +       dentry =3D start_creating_path(AT_FDCWD, name, &path, LOOKUP_DIRE=
CTORY);
>         if (IS_ERR(dentry))
>                 return PTR_ERR(dentry);
>
> @@ -184,7 +184,7 @@ static int dev_mkdir(const char *name, umode_t mode)
>         if (!IS_ERR(dentry))
>                 /* mark as kernel-created inode */
>                 d_inode(dentry)->i_private =3D &thread;
> -       done_path_create(&path, dentry);
> +       end_creating_path(&path, dentry);
>         return PTR_ERR_OR_ZERO(dentry);
>  }
>
> @@ -222,10 +222,10 @@ static int handle_create(const char *nodename, umod=
e_t mode, kuid_t uid,
>         struct path path;
>         int err;
>
> -       dentry =3D kern_path_create(AT_FDCWD, nodename, &path, 0);
> +       dentry =3D start_creating_path(AT_FDCWD, nodename, &path, 0);
>         if (dentry =3D=3D ERR_PTR(-ENOENT)) {
>                 create_path(nodename);
> -               dentry =3D kern_path_create(AT_FDCWD, nodename, &path, 0)=
;
> +               dentry =3D start_creating_path(AT_FDCWD, nodename, &path,=
 0);
>         }
>         if (IS_ERR(dentry))
>                 return PTR_ERR(dentry);
> @@ -246,7 +246,7 @@ static int handle_create(const char *nodename, umode_=
t mode, kuid_t uid,
>                 /* mark as kernel-created inode */
>                 d_inode(dentry)->i_private =3D &thread;
>         }
> -       done_path_create(&path, dentry);
> +       end_creating_path(&path, dentry);
>         return err;
>  }
>
> @@ -256,7 +256,7 @@ static int dev_rmdir(const char *name)
>         struct dentry *dentry;
>         int err;
>
> -       dentry =3D kern_path_locked(name, &parent);
> +       dentry =3D start_removing_path(name, &parent);
>         if (IS_ERR(dentry))
>                 return PTR_ERR(dentry);
>         if (d_inode(dentry)->i_private =3D=3D &thread)
> @@ -265,9 +265,7 @@ static int dev_rmdir(const char *name)
>         else
>                 err =3D -EPERM;
>
> -       dput(dentry);
> -       inode_unlock(d_inode(parent.dentry));
> -       path_put(&parent);
> +       end_removing_path(&parent, dentry);
>         return err;
>  }
>
> @@ -325,7 +323,7 @@ static int handle_remove(const char *nodename, struct=
 device *dev)
>         int deleted =3D 0;
>         int err =3D 0;
>
> -       dentry =3D kern_path_locked(nodename, &parent);
> +       dentry =3D start_removing_path(nodename, &parent);
>         if (IS_ERR(dentry))
>                 return PTR_ERR(dentry);
>
> @@ -349,10 +347,8 @@ static int handle_remove(const char *nodename, struc=
t device *dev)
>                 if (!err || err =3D=3D -ENOENT)
>                         deleted =3D 1;
>         }
> -       dput(dentry);
> -       inode_unlock(d_inode(parent.dentry));
> +       end_removing_path(&parent, dentry);
>
> -       path_put(&parent);
>         if (deleted && strchr(nodename, '/'))
>                 delete_path(nodename);
>         return err;
> diff --git a/fs/bcachefs/fs-ioctl.c b/fs/bcachefs/fs-ioctl.c
> index 4e72e654da96..43510da5e734 100644
> --- a/fs/bcachefs/fs-ioctl.c
> +++ b/fs/bcachefs/fs-ioctl.c
> @@ -255,7 +255,7 @@ static long bch2_ioctl_subvolume_create(struct bch_fs=
 *c, struct file *filp,
>                 snapshot_src =3D inode_inum(to_bch_ei(src_path.dentry->d_=
inode));
>         }
>
> -       dst_dentry =3D user_path_create(arg.dirfd,
> +       dst_dentry =3D start_creating_user_path(arg.dirfd,
>                         (const char __user *)(unsigned long)arg.dst_ptr,
>                         &dst_path, lookup_flags);
>         error =3D PTR_ERR_OR_ZERO(dst_dentry);
> @@ -314,7 +314,7 @@ static long bch2_ioctl_subvolume_create(struct bch_fs=
 *c, struct file *filp,
>         d_instantiate(dst_dentry, &inode->v);
>         fsnotify_mkdir(dir, dst_dentry);
>  err3:
> -       done_path_create(&dst_path, dst_dentry);
> +       end_creating_path(&dst_path, dst_dentry);
>  err2:
>         if (arg.src_ptr)
>                 path_put(&src_path);
> @@ -334,7 +334,7 @@ static long bch2_ioctl_subvolume_destroy(struct bch_f=
s *c, struct file *filp,
>         if (arg.flags)
>                 return -EINVAL;
>
> -       victim =3D user_path_locked_at(arg.dirfd, name, &path);
> +       victim =3D start_removing_user_path_at(arg.dirfd, name, &path);
>         if (IS_ERR(victim))
>                 return PTR_ERR(victim);
>
> @@ -351,9 +351,7 @@ static long bch2_ioctl_subvolume_destroy(struct bch_f=
s *c, struct file *filp,
>                 d_invalidate(victim);
>         }
>  err:
> -       inode_unlock(dir);
> -       dput(victim);
> -       path_put(&path);
> +       end_removing_path(&path, victim);
>         return ret;
>  }
>
> diff --git a/fs/init.c b/fs/init.c
> index eef5124885e3..07f592ccdba8 100644
> --- a/fs/init.c
> +++ b/fs/init.c
> @@ -149,7 +149,7 @@ int __init init_mknod(const char *filename, umode_t m=
ode, unsigned int dev)
>         else if (!(S_ISBLK(mode) || S_ISCHR(mode)))
>                 return -EINVAL;
>
> -       dentry =3D kern_path_create(AT_FDCWD, filename, &path, 0);
> +       dentry =3D start_creating_path(AT_FDCWD, filename, &path, 0);
>         if (IS_ERR(dentry))
>                 return PTR_ERR(dentry);
>
> @@ -158,7 +158,7 @@ int __init init_mknod(const char *filename, umode_t m=
ode, unsigned int dev)
>         if (!error)
>                 error =3D vfs_mknod(mnt_idmap(path.mnt), path.dentry->d_i=
node,
>                                   dentry, mode, new_decode_dev(dev));
> -       done_path_create(&path, dentry);
> +       end_creating_path(&path, dentry);
>         return error;
>  }
>
> @@ -173,7 +173,7 @@ int __init init_link(const char *oldname, const char =
*newname)
>         if (error)
>                 return error;
>
> -       new_dentry =3D kern_path_create(AT_FDCWD, newname, &new_path, 0);
> +       new_dentry =3D start_creating_path(AT_FDCWD, newname, &new_path, =
0);
>         error =3D PTR_ERR(new_dentry);
>         if (IS_ERR(new_dentry))
>                 goto out;
> @@ -191,7 +191,7 @@ int __init init_link(const char *oldname, const char =
*newname)
>         error =3D vfs_link(old_path.dentry, idmap, new_path.dentry->d_ino=
de,
>                          new_dentry, NULL);
>  out_dput:
> -       done_path_create(&new_path, new_dentry);
> +       end_creating_path(&new_path, new_dentry);
>  out:
>         path_put(&old_path);
>         return error;
> @@ -203,14 +203,14 @@ int __init init_symlink(const char *oldname, const =
char *newname)
>         struct path path;
>         int error;
>
> -       dentry =3D kern_path_create(AT_FDCWD, newname, &path, 0);
> +       dentry =3D start_creating_path(AT_FDCWD, newname, &path, 0);
>         if (IS_ERR(dentry))
>                 return PTR_ERR(dentry);
>         error =3D security_path_symlink(&path, dentry, oldname);
>         if (!error)
>                 error =3D vfs_symlink(mnt_idmap(path.mnt), path.dentry->d=
_inode,
>                                     dentry, oldname);
> -       done_path_create(&path, dentry);
> +       end_creating_path(&path, dentry);
>         return error;
>  }
>
> @@ -225,7 +225,8 @@ int __init init_mkdir(const char *pathname, umode_t m=
ode)
>         struct path path;
>         int error;
>
> -       dentry =3D kern_path_create(AT_FDCWD, pathname, &path, LOOKUP_DIR=
ECTORY);
> +       dentry =3D start_creating_path(AT_FDCWD, pathname, &path,
> +                                    LOOKUP_DIRECTORY);
>         if (IS_ERR(dentry))
>                 return PTR_ERR(dentry);
>         mode =3D mode_strip_umask(d_inode(path.dentry), mode);
> @@ -236,7 +237,7 @@ int __init init_mkdir(const char *pathname, umode_t m=
ode)
>                 if (IS_ERR(dentry))
>                         error =3D PTR_ERR(dentry);
>         }
> -       done_path_create(&path, dentry);
> +       end_creating_path(&path, dentry);
>         return error;
>  }
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 4017bc8641d3..ee693d16086e 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2758,7 +2758,8 @@ static int filename_parentat(int dfd, struct filena=
me *name,
>  }
>
>  /* does lookup, returns the object with parent locked */
> -static struct dentry *__kern_path_locked(int dfd, struct filename *name,=
 struct path *path)
> +static struct dentry *__start_removing_path(int dfd, struct filename *na=
me,
> +                                          struct path *path)
>  {
>         struct path parent_path __free(path_put) =3D {};
>         struct dentry *d;
> @@ -2770,15 +2771,25 @@ static struct dentry *__kern_path_locked(int dfd,=
 struct filename *name, struct
>                 return ERR_PTR(error);
>         if (unlikely(type !=3D LAST_NORM))
>                 return ERR_PTR(-EINVAL);

This abnormal error handling pattern deserves a comment:
  /* don't fail immediately if it's r/o, at least try to report other error=
s */

> +       error =3D mnt_want_write(path->mnt);
>         inode_lock_nested(parent_path.dentry->d_inode, I_MUTEX_PARENT);
>         d =3D lookup_one_qstr_excl(&last, parent_path.dentry, 0);
> -       if (IS_ERR(d)) {
> -               inode_unlock(parent_path.dentry->d_inode);
> -               return d;
> -       }
> +       if (IS_ERR(d))
> +               goto unlock;
> +       if (error)
> +               goto fail;
>         path->dentry =3D no_free_ptr(parent_path.dentry);
>         path->mnt =3D no_free_ptr(parent_path.mnt);
>         return d;
> +
> +fail:
> +       dput(d);
> +       d =3D ERR_PTR(error);
> +unlock:
> +       inode_unlock(parent_path.dentry->d_inode);
> +       if (!error)
> +               mnt_drop_write(path->mnt);
> +       return d;
>  }
>
>  /**
> @@ -2816,24 +2827,26 @@ struct dentry *kern_path_parent(const char *name,=
 struct path *path)
>         return d;
>  }
>
> -struct dentry *kern_path_locked(const char *name, struct path *path)
> +struct dentry *start_removing_path(const char *name, struct path *path)
>  {
>         struct filename *filename =3D getname_kernel(name);
> -       struct dentry *res =3D __kern_path_locked(AT_FDCWD, filename, pat=
h);
> +       struct dentry *res =3D __start_removing_path(AT_FDCWD, filename, =
path);
>
>         putname(filename);
>         return res;
>  }
>
> -struct dentry *user_path_locked_at(int dfd, const char __user *name, str=
uct path *path)
> +struct dentry *start_removing_user_path_at(int dfd,
> +                                          const char __user *name,
> +                                          struct path *path)
>  {
>         struct filename *filename =3D getname(name);
> -       struct dentry *res =3D __kern_path_locked(dfd, filename, path);
> +       struct dentry *res =3D __start_removing_path(dfd, filename, path)=
;
>
>         putname(filename);
>         return res;
>  }
> -EXPORT_SYMBOL(user_path_locked_at);
> +EXPORT_SYMBOL(start_removing_user_path_at);
>
>  int kern_path(const char *name, unsigned int flags, struct path *path)
>  {
> @@ -4223,8 +4236,8 @@ static struct dentry *filename_create(int dfd, stru=
ct filename *name,
>         return dentry;
>  }
>
> -struct dentry *kern_path_create(int dfd, const char *pathname,
> -                               struct path *path, unsigned int lookup_fl=
ags)
> +struct dentry *start_creating_path(int dfd, const char *pathname,
> +                                  struct path *path, unsigned int lookup=
_flags)
>  {
>         struct filename *filename =3D getname_kernel(pathname);
>         struct dentry *res =3D filename_create(dfd, filename, path, looku=
p_flags);
> @@ -4232,9 +4245,9 @@ struct dentry *kern_path_create(int dfd, const char=
 *pathname,
>         putname(filename);
>         return res;
>  }
> -EXPORT_SYMBOL(kern_path_create);
> +EXPORT_SYMBOL(start_creating_path);
>
> -void done_path_create(struct path *path, struct dentry *dentry)
> +void end_creating_path(struct path *path, struct dentry *dentry)
>  {
>         if (!IS_ERR(dentry))
>                 dput(dentry);
> @@ -4242,10 +4255,11 @@ void done_path_create(struct path *path, struct d=
entry *dentry)
>         mnt_drop_write(path->mnt);
>         path_put(path);
>  }
> -EXPORT_SYMBOL(done_path_create);
> +EXPORT_SYMBOL(end_creating_path);
>
> -inline struct dentry *user_path_create(int dfd, const char __user *pathn=
ame,
> -                               struct path *path, unsigned int lookup_fl=
ags)
> +inline struct dentry *start_creating_user_path(
> +       int dfd, const char __user *pathname,
> +       struct path *path, unsigned int lookup_flags)
>  {
>         struct filename *filename =3D getname(pathname);
>         struct dentry *res =3D filename_create(dfd, filename, path, looku=
p_flags);
> @@ -4253,7 +4267,7 @@ inline struct dentry *user_path_create(int dfd, con=
st char __user *pathname,
>         putname(filename);
>         return res;
>  }
> -EXPORT_SYMBOL(user_path_create);
> +EXPORT_SYMBOL(start_creating_user_path);
>
>  /**
>   * vfs_mknod - create device node or file
> @@ -4361,7 +4375,7 @@ static int do_mknodat(int dfd, struct filename *nam=
e, umode_t mode,
>                         break;
>         }
>  out2:
> -       done_path_create(&path, dentry);
> +       end_creating_path(&path, dentry);
>         if (retry_estale(error, lookup_flags)) {
>                 lookup_flags |=3D LOOKUP_REVAL;
>                 goto retry;
> @@ -4465,7 +4479,7 @@ int do_mkdirat(int dfd, struct filename *name, umod=
e_t mode)
>                 if (IS_ERR(dentry))
>                         error =3D PTR_ERR(dentry);
>         }
> -       done_path_create(&path, dentry);
> +       end_creating_path(&path, dentry);
>         if (retry_estale(error, lookup_flags)) {
>                 lookup_flags |=3D LOOKUP_REVAL;
>                 goto retry;
> @@ -4819,7 +4833,7 @@ int do_symlinkat(struct filename *from, int newdfd,=
 struct filename *to)
>         if (!error)
>                 error =3D vfs_symlink(mnt_idmap(path.mnt), path.dentry->d=
_inode,
>                                     dentry, from->name);
> -       done_path_create(&path, dentry);
> +       end_creating_path(&path, dentry);
>         if (retry_estale(error, lookup_flags)) {
>                 lookup_flags |=3D LOOKUP_REVAL;
>                 goto retry;
> @@ -4988,7 +5002,7 @@ int do_linkat(int olddfd, struct filename *old, int=
 newdfd,
>         error =3D vfs_link(old_path.dentry, idmap, new_path.dentry->d_ino=
de,
>                          new_dentry, &delegated_inode);
>  out_dput:
> -       done_path_create(&new_path, new_dentry);
> +       end_creating_path(&new_path, new_dentry);
>         if (delegated_inode) {
>                 error =3D break_deleg_wait(&delegated_inode);
>                 if (!error) {
> diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
> index 8f732742b26e..267b50e8e42e 100644
> --- a/fs/ocfs2/refcounttree.c
> +++ b/fs/ocfs2/refcounttree.c
> @@ -4418,7 +4418,7 @@ int ocfs2_reflink_ioctl(struct inode *inode,
>                 return error;
>         }
>
> -       new_dentry =3D user_path_create(AT_FDCWD, newname, &new_path, 0);
> +       new_dentry =3D start_creating_user_path(AT_FDCWD, newname, &new_p=
ath, 0);
>         error =3D PTR_ERR(new_dentry);
>         if (IS_ERR(new_dentry)) {
>                 mlog_errno(error);
> @@ -4435,7 +4435,7 @@ int ocfs2_reflink_ioctl(struct inode *inode,
>                                   d_inode(new_path.dentry),
>                                   new_dentry, preserve);
>  out_dput:
> -       done_path_create(&new_path, new_dentry);
> +       end_creating_path(&new_path, new_dentry);
>  out:
>         path_put(&old_path);
>
> diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
> index 07739055ac9f..1cfa688904b2 100644
> --- a/fs/smb/server/vfs.c
> +++ b/fs/smb/server/vfs.c
> @@ -196,7 +196,7 @@ int ksmbd_vfs_create(struct ksmbd_work *work, const c=
har *name, umode_t mode)
>                 pr_err("File(%s): creation failed (err:%d)\n", name, err)=
;
>         }
>
> -       done_path_create(&path, dentry);
> +       end_creating_path(&path, dentry);
>         return err;
>  }
>
> @@ -237,7 +237,7 @@ int ksmbd_vfs_mkdir(struct ksmbd_work *work, const ch=
ar *name, umode_t mode)
>         if (!err && dentry !=3D d)
>                 ksmbd_vfs_inherit_owner(work, d_inode(path.dentry), d_ino=
de(dentry));
>
> -       done_path_create(&path, dentry);
> +       end_creating_path(&path, dentry);
>         if (err)
>                 pr_err("mkdir(%s): creation failed (err:%d)\n", name, err=
);
>         return err;
> @@ -669,7 +669,7 @@ int ksmbd_vfs_link(struct ksmbd_work *work, const cha=
r *oldname,
>                 ksmbd_debug(VFS, "vfs_link failed err %d\n", err);
>
>  out3:
> -       done_path_create(&newpath, dentry);
> +       end_creating_path(&newpath, dentry);
>  out2:
>         path_put(&oldpath);
>  out1:
> @@ -1325,7 +1325,7 @@ struct dentry *ksmbd_vfs_kern_path_create(struct ks=
mbd_work *work,
>         if (!abs_name)
>                 return ERR_PTR(-ENOMEM);
>
> -       dent =3D kern_path_create(AT_FDCWD, abs_name, path, flags);
> +       dent =3D start_creating_path(AT_FDCWD, abs_name, path, flags);
>         kfree(abs_name);
>         return dent;
>  }
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index 1d5038c21c20..a7800ef04e76 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -59,11 +59,15 @@ struct dentry *lookup_one_qstr_excl(const struct qstr=
 *name,
>  extern int kern_path(const char *, unsigned, struct path *);
>  struct dentry *kern_path_parent(const char *name, struct path *parent);
>
> -extern struct dentry *kern_path_create(int, const char *, struct path *,=
 unsigned int);
> -extern struct dentry *user_path_create(int, const char __user *, struct =
path *, unsigned int);
> -extern void done_path_create(struct path *, struct dentry *);
> -extern struct dentry *kern_path_locked(const char *, struct path *);
> -extern struct dentry *user_path_locked_at(int , const char __user *, str=
uct path *);
> +extern struct dentry *start_creating_path(int, const char *, struct path=
 *, unsigned int);
> +extern struct dentry *start_creating_user_path(int, const char __user *,=
 struct path *, unsigned int);
> +extern void end_creating_path(struct path *, struct dentry *);
> +extern struct dentry *start_removing_path(const char *, struct path *);
> +extern struct dentry *start_removing_user_path_at(int , const char __use=
r *, struct path *);
> +static inline void end_removing_path(struct path *path , struct dentry *=
dentry)
> +{
> +       end_creating_path(path, dentry);
> +}
>  int vfs_path_parent_lookup(struct filename *filename, unsigned int flags=
,
>                            struct path *parent, struct qstr *last, int *t=
ype,
>                            const struct path *root);
> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> index 5c2e96b19392..fadf3817a9c5 100644
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c
> @@ -442,7 +442,7 @@ static int bpf_obj_do_pin(int path_fd, const char __u=
ser *pathname, void *raw,
>         umode_t mode;
>         int ret;
>
> -       dentry =3D user_path_create(path_fd, pathname, &path, 0);
> +       dentry =3D start_creating_user_path(path_fd, pathname, &path, 0);
>         if (IS_ERR(dentry))
>                 return PTR_ERR(dentry);
>
> @@ -471,7 +471,7 @@ static int bpf_obj_do_pin(int path_fd, const char __u=
ser *pathname, void *raw,
>                 ret =3D -EPERM;
>         }
>  out:
> -       done_path_create(&path, dentry);
> +       end_creating_path(&path, dentry);
>         return ret;
>  }
>
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 6d7c110814ff..768098dec231 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -1387,7 +1387,7 @@ static int unix_bind_bsd(struct sock *sk, struct so=
ckaddr_un *sunaddr,
>          * Get the parent directory, calculate the hash for last
>          * component.
>          */
> -       dentry =3D kern_path_create(AT_FDCWD, addr->name->sun_path, &pare=
nt, 0);
> +       dentry =3D start_creating_path(AT_FDCWD, addr->name->sun_path, &p=
arent, 0);
>         if (IS_ERR(dentry)) {
>                 err =3D PTR_ERR(dentry);
>                 goto out;
> @@ -1417,7 +1417,7 @@ static int unix_bind_bsd(struct sock *sk, struct so=
ckaddr_un *sunaddr,
>         unix_table_double_unlock(net, old_hash, new_hash);
>         unix_insert_bsd_socket(sk);
>         mutex_unlock(&u->bindlock);
> -       done_path_create(&parent, dentry);
> +       end_creating_path(&parent, dentry);
>         return 0;
>
>  out_unlock:
> @@ -1427,7 +1427,7 @@ static int unix_bind_bsd(struct sock *sk, struct so=
ckaddr_un *sunaddr,
>         /* failed after successful mknod?  unlink what we'd created... */
>         vfs_unlink(idmap, d_inode(parent.dentry), dentry, NULL);
>  out_path:
> -       done_path_create(&parent, dentry);
> +       end_creating_path(&parent, dentry);
>  out:
>         unix_release_addr(addr);
>         return err =3D=3D -EEXIST ? -EADDRINUSE : err;
> --
> 2.50.0.107.gf914562f5916.dirty
>

