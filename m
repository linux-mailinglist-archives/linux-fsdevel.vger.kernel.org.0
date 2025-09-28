Return-Path: <linux-fsdevel+bounces-62947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D89DEBA708F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Sep 2025 14:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15D453B7C35
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Sep 2025 12:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6181E2DAFC1;
	Sun, 28 Sep 2025 12:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSVzMmBS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF39C1F5EA
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Sep 2025 12:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759063860; cv=none; b=gYOWlNlVUVA/QVXP3GQmL+98SDkF9G4eHYu5cWh+r3+IjkkvDBB5v8GbkOxHhXGjXn6rKY/YnJ+Gl73beFTKO1xXjaR5IlZmT4m2OjXyMYiP1G9cCfpAbjsNNzBRtfu4DkvWVFKFRrlQ+RDqqVgLwAGgrd9QxAn431TsTDX/GXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759063860; c=relaxed/simple;
	bh=9+0f/gs6ZRgwD+nhYdJCmJX/SF2qYxiaPLyrrgIa1ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L+AeyyzMSnnLQDhFGbq9OMT6WWSNrqAsbCdgR0PotqUqqzek1ppjyImjh+XQyhRSgCqfnYWNBZ/Y46rzL74OZ8ppoxw4fGw0QsKSHNtJzXiMnNqcewLStZLfgbWGLDaIVUMxoxrjT+kL0JIaGaACaYWg3HHgqORVwyoOLG252N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSVzMmBS; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b256c8ca246so217400366b.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Sep 2025 05:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759063857; x=1759668657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLEs+a/ZnMmYBffAwKZ0qUFixlBvL8INyN8mbvqTEnM=;
        b=OSVzMmBSa2O8eSkV99NPeIo2rq0I2ZJTA3yk1cE04IHyLTYrR1t2BS7tMBUAYXtrCJ
         yI1k8Z7M1xfrRk6kZmstr6iYk+9Zh9wFdkebrNID9+Eg/fggoZFnZN3E1coIQBgxNYeT
         M13qRCnXqbuYIwRZhWDTKERCUTkNmTnY0ni4jrqSep6Tw2jkgh70R8+OKouT/PozlMr/
         p7IHa8zlqZrTMvsg0fzmj0od4XGaM91XrFQ3rkB9RFti4hzEV08wloFF3iKPpTMbZvVe
         6Z6/uz/aqF82dE48P3s3h0374yQ/TitzLpKecWQu85pOrv2FBmTpIifBtsK0TgqMV52l
         pBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759063857; x=1759668657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZLEs+a/ZnMmYBffAwKZ0qUFixlBvL8INyN8mbvqTEnM=;
        b=mJXkpQexgfWjZON2GxKOAY3a7GXr8uwmGgP39RLCTLout9tL8ZZj2XWHhbp/HZsjpd
         ygJDB0ge1yRElWdt6OmQTQClgRJMKzSByY7au6IHs11IU6D6ccJThOZKNMTykv7/9bAh
         psu3f52nruA+jJpovxqgUiXbfhMrWMy53trZFNPD9hUZMv9FTs3Y7CgAIBu5gyM0eNB7
         vwLp9PoFL3bzorkPsClEqf65bOQkDjoU0a/CXerLXHl17jjqXXxAolQGdyRkohoyPThR
         Dnd8BPXqIpH9XvHl4avdINyEAYbsyyGeC5E2NfLAdWqNYf/YLjyL7y4/NCSzP2K45Kc5
         YpXA==
X-Forwarded-Encrypted: i=1; AJvYcCVvjGpxZAtfH63lsnD6zulqzsfcv5qDTFrpM0EfMMaoMg8Sleur95FAI+g/Z+FlOYqIZt2dm56AN/3iXXnw@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3RZPBYb7C/FfSysTHv+CXXrA2UyD6oVCkd575+2FJ4tQwH77u
	ZeAhX85oRNPxvKhZzGsBqYmxGWauLu5Cfe0xPMYfaY/4eUkb2i5FyXHDuTc3eUCRFbL/iroZ2QD
	OUstjccYELYIaNhEA/HC5idWoutbTJhA=
X-Gm-Gg: ASbGncuAa/03psWHNEsTrKsTOZyCVETyFcJ/drvuXn+oV7GPXHCDZdBgSX3zYEw36gE
	E9lS546LPugXxl5fzdpK/Y4gaQBy5BaUmvAbLeqpu3RK2AsClOaUu99GFkjE31j6ttc7xWPkV+k
	Lfqt0lqMVMxX+FWw35rlxlhSMbWFHbsTnRlNf7y0FetyqBCL0ASwS/Afdoz5mPgflr+jCB09REt
	JlUK5576E0acb96zNff2ThwKU5Xql3715tMniqU0A==
X-Google-Smtp-Source: AGHT+IHDbZOcLb5PRu+8Hkla5y/P5jJPoOP/iPTbX5AmrLmYjKvte1BCTozVIQP6MIwcRIzDub9xxAME+0t7RfUiGBE=
X-Received: by 2002:a17:907:7fac:b0:b2e:b50c:9f8 with SMTP id
 a640c23a62f3a-b34bad28543mr1302565266b.23.1759063856902; Sun, 28 Sep 2025
 05:50:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926025015.1747294-1-neilb@ownmail.net> <20250926025015.1747294-12-neilb@ownmail.net>
In-Reply-To: <20250926025015.1747294-12-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 28 Sep 2025 14:50:45 +0200
X-Gm-Features: AS18NWAl4zo9YIYe8aFkRkXjhb1WjUmzfYz5rNYuPKOhP8kXyavq4ScZfK48tEs
Message-ID: <CAOQ4uxjkJ4dvOkHHgSJV61ZGdCYOxc8JJ+C0EOZAG49XWKN3Pw@mail.gmail.com>
Subject: Re: [PATCH 11/11] ecryptfs: use new start_creaing/start_removing APIs
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 4:51=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
>
> From: NeilBrown <neil@brown.name>
>
> This requires the addition of start_creating_dentry().
>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/ecryptfs/inode.c   | 153 ++++++++++++++++++++----------------------
>  fs/namei.c            |  41 ++++++++++-
>  include/linux/namei.h |   2 +
>  3 files changed, 113 insertions(+), 83 deletions(-)
>
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index abd954c6a14e..25ef6ea8b150 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -24,18 +24,26 @@
>  #include <linux/unaligned.h>
>  #include "ecryptfs_kernel.h"
>
> -static int lock_parent(struct dentry *dentry,
> -                      struct dentry **lower_dentry,
> -                      struct inode **lower_dir)
> +static struct dentry *ecryptfs_start_creating_dentry(struct dentry *dent=
ry)
>  {
> -       struct dentry *lower_dir_dentry;
> +       struct dentry *parent =3D dget_parent(dentry->d_parent);
> +       struct dentry *ret;
>
> -       lower_dir_dentry =3D ecryptfs_dentry_to_lower(dentry->d_parent);
> -       *lower_dir =3D d_inode(lower_dir_dentry);
> -       *lower_dentry =3D ecryptfs_dentry_to_lower(dentry);
> +       ret =3D start_creating_dentry(ecryptfs_dentry_to_lower(parent),
> +                                   ecryptfs_dentry_to_lower(dentry));
> +       dput(parent);
> +       return ret;
> +}
>
> -       inode_lock_nested(*lower_dir, I_MUTEX_PARENT);
> -       return (*lower_dentry)->d_parent =3D=3D lower_dir_dentry ? 0 : -E=
INVAL;
> +static struct dentry *ecryptfs_start_removing_dentry(struct dentry *dent=
ry)
> +{
> +       struct dentry *parent =3D dget_parent(dentry->d_parent);
> +       struct dentry *ret;
> +
> +       ret =3D start_removing_dentry(ecryptfs_dentry_to_lower(parent),
> +                                   ecryptfs_dentry_to_lower(dentry));
> +       dput(parent);
> +       return ret;
>  }
>
>  static int ecryptfs_inode_test(struct inode *inode, void *lower_inode)
> @@ -141,15 +149,12 @@ static int ecryptfs_do_unlink(struct inode *dir, st=
ruct dentry *dentry,
>         struct inode *lower_dir;
>         int rc;
>
> -       rc =3D lock_parent(dentry, &lower_dentry, &lower_dir);
> -       dget(lower_dentry);     // don't even try to make the lower negat=
ive
> -       if (!rc) {
> -               if (d_unhashed(lower_dentry))
> -                       rc =3D -EINVAL;
> -               else
> -                       rc =3D vfs_unlink(&nop_mnt_idmap, lower_dir, lowe=
r_dentry,
> -                                       NULL);
> -       }
> +       lower_dentry =3D ecryptfs_start_removing_dentry(dentry);
> +       if (IS_ERR(lower_dentry))
> +               return PTR_ERR(lower_dentry);
> +
> +       lower_dir =3D lower_dentry->d_parent->d_inode;
> +       rc =3D vfs_unlink(&nop_mnt_idmap, lower_dir, lower_dentry, NULL);
>         if (rc) {
>                 printk(KERN_ERR "Error in vfs_unlink; rc =3D [%d]\n", rc)=
;
>                 goto out_unlock;
> @@ -158,8 +163,7 @@ static int ecryptfs_do_unlink(struct inode *dir, stru=
ct dentry *dentry,
>         set_nlink(inode, ecryptfs_inode_to_lower(inode)->i_nlink);
>         inode_set_ctime_to_ts(inode, inode_get_ctime(dir));
>  out_unlock:
> -       dput(lower_dentry);
> -       inode_unlock(lower_dir);
> +       end_removing(lower_dentry);
>         if (!rc)
>                 d_drop(dentry);
>         return rc;
> @@ -186,10 +190,12 @@ ecryptfs_do_create(struct inode *directory_inode,
>         struct inode *lower_dir;
>         struct inode *inode;
>
> -       rc =3D lock_parent(ecryptfs_dentry, &lower_dentry, &lower_dir);
> -       if (!rc)
> -               rc =3D vfs_create(&nop_mnt_idmap, lower_dir,
> -                               lower_dentry, mode, true);
> +       lower_dentry =3D ecryptfs_start_creating_dentry(ecryptfs_dentry);
> +       if (IS_ERR(lower_dentry))
> +               return ERR_CAST(lower_dentry);
> +       lower_dir =3D lower_dentry->d_parent->d_inode;
> +       rc =3D vfs_create(&nop_mnt_idmap, lower_dir,
> +                       lower_dentry, mode, true);
>         if (rc) {
>                 printk(KERN_ERR "%s: Failure to create dentry in lower fs=
; "
>                        "rc =3D [%d]\n", __func__, rc);
> @@ -205,7 +211,7 @@ ecryptfs_do_create(struct inode *directory_inode,
>         fsstack_copy_attr_times(directory_inode, lower_dir);
>         fsstack_copy_inode_size(directory_inode, lower_dir);
>  out_lock:
> -       inode_unlock(lower_dir);
> +       end_creating(lower_dentry, NULL);

These calls were surprising to me.
I did not recall any documentation that @parent could be NULL
when calling end_creating(). In fact, the documentation specifically
says that it should be the parent used for start_creating().

So either introduce end_creating_dentry(), which makes it clear
that it does not take an ERR_PTR child,
Or add WARN_ON to end_creating() in case it is called with NULL
parent and an ERR_PTR child to avoid dereferencing parent->d_inode
in that case.

Thanks,
Amir.

>         return inode;
>  }
>
> @@ -442,10 +448,12 @@ static int ecryptfs_link(struct dentry *old_dentry,=
 struct inode *dir,
>
>         file_size_save =3D i_size_read(d_inode(old_dentry));
>         lower_old_dentry =3D ecryptfs_dentry_to_lower(old_dentry);
> -       rc =3D lock_parent(new_dentry, &lower_new_dentry, &lower_dir);
> -       if (!rc)
> -               rc =3D vfs_link(lower_old_dentry, &nop_mnt_idmap, lower_d=
ir,
> -                             lower_new_dentry, NULL);
> +       lower_new_dentry =3D ecryptfs_start_creating_dentry(new_dentry);
> +       if (IS_ERR(lower_new_dentry))
> +               return PTR_ERR(lower_new_dentry);
> +       lower_dir =3D lower_new_dentry->d_parent->d_inode;
> +       rc =3D vfs_link(lower_old_dentry, &nop_mnt_idmap, lower_dir,
> +                     lower_new_dentry, NULL);
>         if (rc || d_really_is_negative(lower_new_dentry))
>                 goto out_lock;
>         rc =3D ecryptfs_interpose(lower_new_dentry, new_dentry, dir->i_sb=
);
> @@ -457,7 +465,7 @@ static int ecryptfs_link(struct dentry *old_dentry, s=
truct inode *dir,
>                   ecryptfs_inode_to_lower(d_inode(old_dentry))->i_nlink);
>         i_size_write(d_inode(new_dentry), file_size_save);
>  out_lock:
> -       inode_unlock(lower_dir);
> +       end_creating(lower_new_dentry, NULL);
>         return rc;
>  }
>
> @@ -477,9 +485,11 @@ static int ecryptfs_symlink(struct mnt_idmap *idmap,
>         size_t encoded_symlen;
>         struct ecryptfs_mount_crypt_stat *mount_crypt_stat =3D NULL;
>
> -       rc =3D lock_parent(dentry, &lower_dentry, &lower_dir);
> -       if (rc)
> -               goto out_lock;
> +       lower_dentry =3D ecryptfs_start_creating_dentry(dentry);
> +       if (IS_ERR(lower_dentry))
> +               return PTR_ERR(lower_dentry);
> +       lower_dir =3D lower_dentry->d_parent->d_inode;
> +
>         mount_crypt_stat =3D &ecryptfs_superblock_to_private(
>                 dir->i_sb)->mount_crypt_stat;
>         rc =3D ecryptfs_encrypt_and_encode_filename(&encoded_symname,
> @@ -499,7 +509,7 @@ static int ecryptfs_symlink(struct mnt_idmap *idmap,
>         fsstack_copy_attr_times(dir, lower_dir);
>         fsstack_copy_inode_size(dir, lower_dir);
>  out_lock:
> -       inode_unlock(lower_dir);
> +       end_creating(lower_dentry, NULL);
>         if (d_really_is_negative(dentry))
>                 d_drop(dentry);
>         return rc;
> @@ -510,12 +520,14 @@ static struct dentry *ecryptfs_mkdir(struct mnt_idm=
ap *idmap, struct inode *dir,
>  {
>         int rc;
>         struct dentry *lower_dentry;
> +       struct dentry *lower_dir_dentry;
>         struct inode *lower_dir;
>
> -       rc =3D lock_parent(dentry, &lower_dentry, &lower_dir);
> -       if (rc)
> -               goto out;
> -
> +       lower_dentry =3D ecryptfs_start_creating_dentry(dentry);
> +       if (IS_ERR(lower_dentry))
> +               return lower_dentry;
> +       lower_dir_dentry =3D dget(lower_dentry->d_parent);
> +       lower_dir =3D lower_dir_dentry->d_inode;
>         lower_dentry =3D vfs_mkdir(&nop_mnt_idmap, lower_dir,
>                                  lower_dentry, mode);
>         rc =3D PTR_ERR(lower_dentry);
> @@ -531,7 +543,7 @@ static struct dentry *ecryptfs_mkdir(struct mnt_idmap=
 *idmap, struct inode *dir,
>         fsstack_copy_inode_size(dir, lower_dir);
>         set_nlink(dir, lower_dir->i_nlink);
>  out:
> -       inode_unlock(lower_dir);
> +       end_creating(lower_dentry, lower_dir_dentry);
>         if (d_really_is_negative(dentry))
>                 d_drop(dentry);
>         return ERR_PTR(rc);
> @@ -543,21 +555,18 @@ static int ecryptfs_rmdir(struct inode *dir, struct=
 dentry *dentry)
>         struct inode *lower_dir;
>         int rc;
>
> -       rc =3D lock_parent(dentry, &lower_dentry, &lower_dir);
> -       dget(lower_dentry);     // don't even try to make the lower negat=
ive
> -       if (!rc) {
> -               if (d_unhashed(lower_dentry))
> -                       rc =3D -EINVAL;
> -               else
> -                       rc =3D vfs_rmdir(&nop_mnt_idmap, lower_dir, lower=
_dentry);
> -       }
> +       lower_dentry =3D ecryptfs_start_removing_dentry(dentry);
> +       if (IS_ERR(lower_dentry))
> +               return PTR_ERR(lower_dentry);
> +       lower_dir =3D lower_dentry->d_parent->d_inode;
> +
> +       rc =3D vfs_rmdir(&nop_mnt_idmap, lower_dir, lower_dentry);
>         if (!rc) {
>                 clear_nlink(d_inode(dentry));
>                 fsstack_copy_attr_times(dir, lower_dir);
>                 set_nlink(dir, lower_dir->i_nlink);
>         }
> -       dput(lower_dentry);
> -       inode_unlock(lower_dir);
> +       end_removing(lower_dentry);
>         if (!rc)
>                 d_drop(dentry);
>         return rc;
> @@ -571,10 +580,12 @@ ecryptfs_mknod(struct mnt_idmap *idmap, struct inod=
e *dir,
>         struct dentry *lower_dentry;
>         struct inode *lower_dir;
>
> -       rc =3D lock_parent(dentry, &lower_dentry, &lower_dir);
> -       if (!rc)
> -               rc =3D vfs_mknod(&nop_mnt_idmap, lower_dir,
> -                              lower_dentry, mode, dev);
> +       lower_dentry =3D ecryptfs_start_creating_dentry(dentry);
> +       if (IS_ERR(lower_dentry))
> +               return PTR_ERR(lower_dentry);
> +       lower_dir =3D lower_dentry->d_parent->d_inode;
> +
> +       rc =3D vfs_mknod(&nop_mnt_idmap, lower_dir, lower_dentry, mode, d=
ev);
>         if (rc || d_really_is_negative(lower_dentry))
>                 goto out;
>         rc =3D ecryptfs_interpose(lower_dentry, dentry, dir->i_sb);
> @@ -583,7 +594,7 @@ ecryptfs_mknod(struct mnt_idmap *idmap, struct inode =
*dir,
>         fsstack_copy_attr_times(dir, lower_dir);
>         fsstack_copy_inode_size(dir, lower_dir);
>  out:
> -       inode_unlock(lower_dir);
> +       end_removing(lower_dentry);
>         if (d_really_is_negative(dentry))
>                 d_drop(dentry);
>         return rc;
> @@ -599,7 +610,6 @@ ecryptfs_rename(struct mnt_idmap *idmap, struct inode=
 *old_dir,
>         struct dentry *lower_new_dentry;
>         struct dentry *lower_old_dir_dentry;
>         struct dentry *lower_new_dir_dentry;
> -       struct dentry *trap;
>         struct inode *target_inode;
>         struct renamedata rd =3D {};
>
> @@ -614,31 +624,13 @@ ecryptfs_rename(struct mnt_idmap *idmap, struct ino=
de *old_dir,
>
>         target_inode =3D d_inode(new_dentry);
>
> -       trap =3D lock_rename(lower_old_dir_dentry, lower_new_dir_dentry);
> -       if (IS_ERR(trap))
> -               return PTR_ERR(trap);
> -       dget(lower_new_dentry);
> -       rc =3D -EINVAL;
> -       if (lower_old_dentry->d_parent !=3D lower_old_dir_dentry)
> -               goto out_lock;
> -       if (lower_new_dentry->d_parent !=3D lower_new_dir_dentry)
> -               goto out_lock;
> -       if (d_unhashed(lower_old_dentry) || d_unhashed(lower_new_dentry))
> -               goto out_lock;
> -       /* source should not be ancestor of target */
> -       if (trap =3D=3D lower_old_dentry)
> -               goto out_lock;
> -       /* target should not be ancestor of source */
> -       if (trap =3D=3D lower_new_dentry) {
> -               rc =3D -ENOTEMPTY;
> -               goto out_lock;
> -       }
> +       rd.mnt_idmap  =3D &nop_mnt_idmap;
> +       rd.old_parent =3D lower_old_dir_dentry;
> +       rd.new_parent =3D lower_new_dir_dentry;
> +       rc =3D start_renaming_two_dentry(&rd, lower_old_dentry, lower_new=
_dentry);
> +       if (rc)
> +               return rc;
>
> -       rd.mnt_idmap            =3D &nop_mnt_idmap;
> -       rd.old_parent           =3D lower_old_dir_dentry;
> -       rd.old_dentry           =3D lower_old_dentry;
> -       rd.new_parent           =3D lower_new_dir_dentry;
> -       rd.new_dentry           =3D lower_new_dentry;
>         rc =3D vfs_rename(&rd);
>         if (rc)
>                 goto out_lock;
> @@ -649,8 +641,7 @@ ecryptfs_rename(struct mnt_idmap *idmap, struct inode=
 *old_dir,
>         if (new_dir !=3D old_dir)
>                 fsstack_copy_attr_all(old_dir, d_inode(lower_old_dir_dent=
ry));
>  out_lock:
> -       dput(lower_new_dentry);
> -       unlock_rename(lower_old_dir_dentry, lower_new_dir_dentry);
> +       end_renaming(&rd);
>         return rc;
>  }
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 23f9adb43401..80a687a95da0 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3418,6 +3418,39 @@ struct dentry *start_removing_noperm(struct dentry=
 *parent,
>  }
>  EXPORT_SYMBOL(start_removing_noperm);
>
> +/**
> + * start_creating_dentry - prepare to create a given dentry
> + * @parent - directory from which dentry should be removed
> + * @child - the dentry to be removed
> + *
> + * A lock is taken to protect the dentry again other dirops and
> + * the validity of the dentry is checked: correct parent and still hashe=
d.
> + *
> + * If the dentry is valid and negative a reference is taken and
> + * returned.  If not an error is returned.
> + *
> + * end_creating() should be called when creation is complete, or aborted=
.
> + *
> + * Returns: the valid dentry, or an error.
> + */
> +struct dentry *start_creating_dentry(struct dentry *parent,
> +                                    struct dentry *child)
> +{
> +       inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
> +       if (unlikely(IS_DEADDIR(parent->d_inode) ||
> +                    child->d_parent !=3D parent ||
> +                    d_unhashed(child))) {
> +               inode_unlock(parent->d_inode);
> +               return ERR_PTR(-EINVAL);
> +       }
> +       if (d_is_positive(child)) {
> +               inode_unlock(parent->d_inode);
> +               return ERR_PTR(-EEXIST);
> +       }
> +       return dget(child);
> +}
> +EXPORT_SYMBOL(start_creating_dentry);
> +
>  /**
>   * start_removing_dentry - prepare to remove a given dentry
>   * @parent - directory from which dentry should be removed
> @@ -3426,8 +3459,8 @@ EXPORT_SYMBOL(start_removing_noperm);
>   * A lock is taken to protect the dentry again other dirops and
>   * the validity of the dentry is checked: correct parent and still hashe=
d.
>   *
> - * If the dentry is valid a reference is taken and returned.  If not
> - * an error is returned.
> + * If the dentry is valid and positive a reference is taken and
> + * returned.  If not an error is returned.
>   *
>   * end_removing() should be called when removal is complete, or aborted.
>   *
> @@ -3443,6 +3476,10 @@ struct dentry *start_removing_dentry(struct dentry=
 *parent,
>                 inode_unlock(parent->d_inode);
>                 return ERR_PTR(-EINVAL);
>         }
> +       if (d_is_negative(child)) {
> +               inode_unlock(parent->d_inode);
> +               return ERR_PTR(-ENOENT);
> +       }
>         return dget(child);
>  }
>  EXPORT_SYMBOL(start_removing_dentry);
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index 434b10476e40..7ed299567da8 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -100,6 +100,8 @@ struct dentry *start_removing_killable(struct mnt_idm=
ap *idmap,
>                                        struct qstr *name);
>  struct dentry *start_creating_noperm(struct dentry *parent, struct qstr =
*name);
>  struct dentry *start_removing_noperm(struct dentry *parent, struct qstr =
*name);
> +struct dentry *start_creating_dentry(struct dentry *parent,
> +                                    struct dentry *child);
>  struct dentry *start_removing_dentry(struct dentry *parent,
>                                      struct dentry *child);
>
> --
> 2.50.0.107.gf914562f5916.dirty
>

