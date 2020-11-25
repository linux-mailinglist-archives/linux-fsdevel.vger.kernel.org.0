Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3A02C418A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 14:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729734AbgKYN6a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 08:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbgKYN6a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 08:58:30 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACF3C0613D4;
        Wed, 25 Nov 2020 05:58:20 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id j23so2209962iog.6;
        Wed, 25 Nov 2020 05:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vyv3DCHRYxAkJcP/gmoU9rGkUfS59k3U7EB7yLTC/Bc=;
        b=TCzd9/PSmzb7ZWuEzTo7mf6d55efRywMAMEtqKvTyyX4zgMyO+D4lnuRzcKwt7BgFy
         gZXFCOhGwOpCYilFzbVqMgpSqlgCSQzFgjN688RXc09Gfx37ED9t+4kAs6cqBtDRZwRl
         1xbyaHiQI7uvy8sTQ25PwE0ysSeaNhJftOgUHBQnKJxdvXKb2l+3GnvAizMO8EUbSVjb
         D3MUzFsyM8H5MPqyH+MT3YoC+gcvOyZ+O4bW6/WouJ4nYWpb0ecITfLbsup6HThcDBA8
         uvutv6BIRxdiz4XMRGtb0B6U3yeN8dvbVQBWJWt11x9LZL2Q622jOi+6jY743pJyIspF
         JYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vyv3DCHRYxAkJcP/gmoU9rGkUfS59k3U7EB7yLTC/Bc=;
        b=T3Jtm2p8oujawwrzhhEbEo8Emx1+X10vVCgKGWvH7cIlqjyDEmh/4EEF3Q6imQQCNt
         O7u/KoQ5uhWbqz0hRPm6wImIudZZ5wM/4FopUg6WG+Cf5zulxlKL2Svlw56c+qchaOlj
         72JvdXzMJ2wSRDoX3CaS7Ooli+iqSADUDZL+DDhbFg8Qlv2dGEbAqIC08KXYz+1eSUSr
         CkDW7Mf/w7in8n1OItmY9ruU6hGgD+SDoinA5aiSjDAcO0fwS/2y2N5QLOMBKkTYXcwN
         Qi6wn0L7JmLLtWaubZ1PFmTijM51dGAoOlMA5C+28DXm4V4QWyYx47a7YIDcD8rayZO6
         NHQQ==
X-Gm-Message-State: AOAM533DQsnwAC7Ik+zzgrAZT/RJww9+iFXMB7Oo/0XqaF6H9JxMlOG8
        J3nQY+SJysbb5GOR/6TddpbR0m9Zj82wb3hrKqo=
X-Google-Smtp-Source: ABdhPJweLssFo+c9h2WTcdsqco4qBHn/NrsDYdvmgBpFnpWxDywnYKtjzOsmQ7B7xgclB8g9lHfDCKvnggWf3SUWx6k=
X-Received: by 2002:a05:6602:5de:: with SMTP id w30mr2653384iox.64.1606312699585;
 Wed, 25 Nov 2020 05:58:19 -0800 (PST)
MIME-Version: 1.0
References: <20201125104621.18838-1-sargun@sargun.me> <20201125104621.18838-3-sargun@sargun.me>
In-Reply-To: <20201125104621.18838-3-sargun@sargun.me>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 25 Nov 2020 15:58:08 +0200
Message-ID: <CAOQ4uxhxOiCWnOKt02+w8MgJm7gruqt6_yej8DLgO=kBOpDfxQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] overlay: Add the ability to remount volatile
 directories when safe
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 25, 2020 at 12:46 PM Sargun Dhillon <sargun@sargun.me> wrote:
>
> Overlayfs added the ability to setup mounts where all syncs could be
> short-circuted in (2a99ddacee43: ovl: provide a mount option "volatile").
>
> A user might want to remount this fs, but we do not let the user because
> of the "incompat" detection feature. In the case of volatile, it is safe
> to do something like[1]:
>
> $ sync -f /root/upperdir
> $ rm -rf /root/workdir/incompat/volatile
>
> There are two ways to go about this. You can call sync on the underlying
> filesystem, check the error code, and delete the dirty file if everything
> is clean. If you're running lots of containers on the same filesystem, or
> you want to avoid all unnecessary I/O, this may be suboptimal.
>
> Alternatively, you can blindly delete the dirty file, and "hope for the
> best".
>
> This patch introduces transparent functionality to check if it is
> (relatively) safe to reuse the upperdir. It ensures that the filesystem
> hasn't been remounted, the system hasn't been rebooted, nor has the
> overlayfs code changed. Since the structure is explicitly not meant to be
> used between different versions of the code, its stability does not matter
> so much.
>

Looks good.
You forgot to allow reuse only as volatile...
Other than that just a few comments.

> [1]: https://lore.kernel.org/linux-unionfs/CAOQ4uxhKr+j5jFyEC2gJX8E8M19mQ3CqdTYaPZOvDQ9c0qLEzw@mail.gmail.com/T/#m6abe713e4318202ad57f301bf28a414e1d824f9c
>
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-unionfs@vger.kernel.org
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Amir Goldstein <amir73il@gmail.com>
> ---
>  Documentation/filesystems/overlayfs.rst |  6 +-
>  fs/overlayfs/overlayfs.h                | 37 ++++++++++-
>  fs/overlayfs/readdir.c                  | 88 +++++++++++++++++++++----
>  fs/overlayfs/super.c                    | 74 ++++++++++++++++-----
>  fs/overlayfs/util.c                     |  2 +
>  5 files changed, 175 insertions(+), 32 deletions(-)
>
> diff --git a/Documentation/filesystems/overlayfs.rst b/Documentation/filesystems/overlayfs.rst
> index 580ab9a0fe31..18237c79fb4e 100644
> --- a/Documentation/filesystems/overlayfs.rst
> +++ b/Documentation/filesystems/overlayfs.rst
> @@ -581,7 +581,11 @@ checks for this directory and refuses to mount if present. This is a strong
>  indicator that user should throw away upper and work directories and create
>  fresh one. In very limited cases where the user knows that the system has
>  not crashed and contents of upperdir are intact, The "volatile" directory
> -can be removed.
> +can be removed.  In some cases, the filesystem can detect if the upperdir
> +can be reused safely in a subsequent volatile mount.  If the filesystem is able
> +to determine this, it will not require the user to manually delete the volatile
> +directory and mounting will proceed as normal.
> +
>
>  Testsuite
>  ---------
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index f8880aa2ba0e..de694ee99d7c 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -32,8 +32,13 @@ enum ovl_xattr {
>         OVL_XATTR_NLINK,
>         OVL_XATTR_UPPER,
>         OVL_XATTR_METACOPY,
> +       OVL_XATTR_VOLATILE,
>  };
>
> +#define OVL_INCOMPATDIR_NAME "incompat"
> +#define OVL_VOLATILEDIR_NAME "volatile"
> +#define OVL_VOLATILE_DIRTY_NAME "dirty"
> +
>  enum ovl_inode_flag {
>         /* Pure upper dir that may contain non pure upper entries */
>         OVL_IMPURE,
> @@ -57,6 +62,31 @@ enum {
>         OVL_XINO_ON,
>  };
>
> +/*
> + * This is copied into the volatile xattr, and the user does not interact with
> + * it. There is no stability requirement, as a reboot explicitly invalidates
> + * a volatile workdir. It is explicitly meant not to be a stable api.
> + *
> + * Although this structure isn't meant to be stable it is exposed to potentially
> + * unprivileged users. We don't do any kind of cryptographic operations with
> + * the structure, so it could be tampered with, or inspected. Don't put
> + * kernel memory pointers in it, or anything else that could cause problems,
> + * or information disclosure.
> + */
> +struct ovl_volatile_info {
> +       /*
> +        * This uniquely identifies a boot, and is reset if overlayfs itself
> +        * is reloaded. Therefore we check our current / known boot_id
> +        * against this before looking at any other fields to validate:
> +        * 1. Is this datastructure laid out in the way we expect? (Overlayfs
> +        *    module, reboot, etc...)
> +        * 2. Could something have changed (like the s_instance_id counter
> +        *    resetting)
> +        */
> +       uuid_t          ovl_boot_id;    /* Must stay first member */
> +       u64             s_instance_id;
> +} __packed;
> +
>  /*
>   * The tuple (fh,uuid) is a universal unique identifier for a copy up origin,
>   * where:
> @@ -422,8 +452,8 @@ void ovl_cleanup_whiteouts(struct dentry *upper, struct list_head *list);
>  void ovl_cache_free(struct list_head *list);
>  void ovl_dir_cache_free(struct inode *inode);
>  int ovl_check_d_type_supported(struct path *realpath);
> -int ovl_workdir_cleanup(struct inode *dir, struct vfsmount *mnt,
> -                       struct dentry *dentry, int level);
> +int ovl_workdir_cleanup(struct ovl_fs *ofs, struct inode *dir,
> +                       struct vfsmount *mnt, struct dentry *dentry, int level);
>  int ovl_indexdir_cleanup(struct ovl_fs *ofs);
>
>  /* inode.c */
> @@ -520,3 +550,6 @@ int ovl_set_origin(struct dentry *dentry, struct dentry *lower,
>
>  /* export.c */
>  extern const struct export_operations ovl_export_operations;
> +
> +/* super.c */
> +extern uuid_t ovl_boot_id;
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index 01620ebae1bd..4e3e2bc3ea43 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -1080,10 +1080,68 @@ int ovl_check_d_type_supported(struct path *realpath)
>
>         return rdd.d_type_supported;
>  }
> +static int ovl_verify_volatile_info(struct ovl_fs *ofs,
> +                                   struct dentry *volatiledir)
> +{
> +       int err;
> +       struct ovl_volatile_info info;
> +
> +       err = ovl_do_getxattr(ofs, volatiledir, OVL_XATTR_VOLATILE, &info,
> +                             sizeof(info));
> +       if (err < 0) {
> +               pr_debug("Unable to read volatile xattr: %d\n", err);
> +               return -EINVAL;
> +       }
> +
> +       if (err != sizeof(info)) {
> +               pr_debug("ovl_volatile_info is of size %d expected %ld\n", err,
> +                        sizeof(info));
> +               return -EINVAL;
> +       }
> +
> +       if (!uuid_equal(&ovl_boot_id, &info.ovl_boot_id)) {
> +               pr_debug("boot id has changed (reboot or module reloaded)\n");
> +               return -EINVAL;
> +       }
> +
> +       if (volatiledir->d_sb->s_instance_id != info.s_instance_id) {
> +               pr_debug("workdir has been unmounted and remounted\n");
> +               return -EINVAL;
> +       }
>
> -#define OVL_INCOMPATDIR_NAME "incompat"
> +       return 1;
> +}
>
> -static int ovl_workdir_cleanup_recurse(struct path *path, int level)
> +/*
> + * ovl_check_incompat checks this specific incompat entry for incompatibility.
> + * If it is found to be incompatible -EINVAL will be returned.
> + *
> + * If the directory should be preserved, then this function returns 1.
> + */
> +static int ovl_check_incompat(struct ovl_fs *ofs, struct ovl_cache_entry *p,
> +                             struct path *path)
> +{
> +       int err = -EINVAL;
> +       struct dentry *d;
> +

if p->name is not OVL_VOLATILEDIR_NAME, there is no reason to lookup
and unless ofs->config.ovl_volatile, you can already fail the check.


> +       d = lookup_one_len(p->name, path->dentry, p->len);
> +       if (IS_ERR(d))
> +               return PTR_ERR(d);
> +
> +       if (!strcmp(p->name, OVL_VOLATILEDIR_NAME))
> +               err = ovl_verify_volatile_info(ofs, d);
> +
> +       if (err == -EINVAL)
> +               pr_err("incompat feature '%s' cannot be mounted\n", p->name);
> +       else
> +               pr_debug("incompat '%s' handled: %d\n", p->name, err);
> +
> +       dput(d);
> +       return err;
> +}
> +
> +static int ovl_workdir_cleanup_recurse(struct ovl_fs *ofs, struct path *path,
> +                                      int level)
>  {
>         int err;
>         struct inode *dir = path->dentry->d_inode;
> @@ -1125,16 +1183,19 @@ static int ovl_workdir_cleanup_recurse(struct path *path, int level)
>                         if (p->len == 2 && p->name[1] == '.')
>                                 continue;
>                 } else if (incompat) {
> -                       pr_err("overlay with incompat feature '%s' cannot be mounted\n",
> -                               p->name);
> -                       err = -EINVAL;
> -                       break;
> +                       err = ovl_check_incompat(ofs, p, path);
> +                       if (err < 0)
> +                               break;
> +                       /* Skip cleaning this */
> +                       if (err == 1)
> +                               continue;
>                 }
>                 dentry = lookup_one_len(p->name, path->dentry, p->len);
>                 if (IS_ERR(dentry))
>                         continue;
>                 if (dentry->d_inode)
> -                       err = ovl_workdir_cleanup(dir, path->mnt, dentry, level);
> +                       err = ovl_workdir_cleanup(ofs, dir, path->mnt, dentry,
> +                                                 level);
>                 dput(dentry);
>                 if (err)
>                         break;
> @@ -1142,11 +1203,13 @@ static int ovl_workdir_cleanup_recurse(struct path *path, int level)
>         inode_unlock(dir);
>  out:
>         ovl_cache_free(&list);
> +       if (incompat && err >= 0)
> +               return 1;
>         return err;
>  }
>
> -int ovl_workdir_cleanup(struct inode *dir, struct vfsmount *mnt,
> -                        struct dentry *dentry, int level)
> +int ovl_workdir_cleanup(struct ovl_fs *ofs, struct inode *dir,
> +                       struct vfsmount *mnt, struct dentry *dentry, int level)
>  {
>         int err;
>
> @@ -1159,7 +1222,7 @@ int ovl_workdir_cleanup(struct inode *dir, struct vfsmount *mnt,
>                 struct path path = { .mnt = mnt, .dentry = dentry };
>
>                 inode_unlock(dir);
> -               err = ovl_workdir_cleanup_recurse(&path, level + 1);
> +               err = ovl_workdir_cleanup_recurse(ofs, &path, level + 1);
>                 inode_lock_nested(dir, I_MUTEX_PARENT);
>                 if (!err)
>                         err = ovl_cleanup(dir, dentry);
> @@ -1206,9 +1269,10 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
>                 }
>                 /* Cleanup leftover from index create/cleanup attempt */
>                 if (index->d_name.name[0] == '#') {
> -                       err = ovl_workdir_cleanup(dir, path.mnt, index, 1);
> -                       if (err)
> +                       err = ovl_workdir_cleanup(ofs, dir, path.mnt, index, 1);
> +                       if (err < 0)
>                                 break;
> +                       err = 0;
>                         goto next;
>                 }
>                 err = ovl_verify_index(ofs, index);
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 290983bcfbb3..9a1b07907662 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -15,6 +15,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/posix_acl_xattr.h>
>  #include <linux/exportfs.h>
> +#include <linux/uuid.h>
>  #include "overlayfs.h"
>
>  MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
> @@ -23,6 +24,7 @@ MODULE_LICENSE("GPL");
>
>
>  struct ovl_dir_cache;
> +uuid_t ovl_boot_id;
>
>  #define OVL_MAX_STACK 500
>
> @@ -722,20 +724,24 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
>                                 goto out_unlock;
>
>                         retried = true;
> -                       err = ovl_workdir_cleanup(dir, mnt, work, 0);
> -                       dput(work);
> -                       if (err == -EINVAL) {
> -                               work = ERR_PTR(err);
> -                               goto out_unlock;
> +                       err = ovl_workdir_cleanup(ofs, dir, mnt, work, 0);
> +                       /* check if we should reuse the workdir */
> +                       if (err != 1) {
> +                               dput(work);
> +                               if (err == -EINVAL) {
> +                                       work = ERR_PTR(err);
> +                                       goto out_unlock;
> +                               }
> +                               goto retry;
>                         }
> -                       goto retry;
> +               } else {
> +                       work = ovl_create_real(dir, work,
> +                                              OVL_CATTR(attr.ia_mode));
> +                       err = PTR_ERR(work);
> +                       if (IS_ERR(work))
> +                               goto out_err;
>                 }
>
> -               work = ovl_create_real(dir, work, OVL_CATTR(attr.ia_mode));
> -               err = PTR_ERR(work);
> -               if (IS_ERR(work))
> -                       goto out_err;
> -
>                 /*
>                  * Try to remove POSIX ACL xattrs from workdir.  We are good if:
>                  *
> @@ -1237,26 +1243,59 @@ static struct dentry *ovl_lookup_or_create(struct dentry *parent,
>         return child;
>  }
>
> +static int ovl_set_volatile_info(struct ovl_fs *ofs, struct dentry *volatiledir)
> +{
> +       int err;
> +       struct ovl_volatile_info info = {
> +               .s_instance_id = volatiledir->d_sb->s_instance_id,
> +       };
> +
> +       uuid_copy(&info.ovl_boot_id, &ovl_boot_id);
> +       err = ovl_do_setxattr(ofs, volatiledir, OVL_XATTR_VOLATILE, &info,
> +                             sizeof(info));
> +
> +       if (err == -EOPNOTSUPP)
> +               return 0;
> +
> +       return err;
> +}
> +
>  /*
>   * Creates $workdir/work/incompat/volatile/dirty file if it is not already
>   * present.
>   */
>  static int ovl_create_volatile_dirty(struct ovl_fs *ofs)
>  {
> +       int err;
>         unsigned int ctr;
> -       struct dentry *d = dget(ofs->workbasedir);
> +       struct dentry *volatiledir, *d = dget(ofs->workbasedir);
>         static const char *const volatile_path[] = {
> -               OVL_WORKDIR_NAME, "incompat", "volatile", "dirty"
> +               OVL_WORKDIR_NAME,
> +               OVL_INCOMPATDIR_NAME,
> +               OVL_VOLATILEDIR_NAME,
> +               OVL_VOLATILE_DIRTY_NAME,
>         };
>         const char *const *name = volatile_path;
>
> -       for (ctr = ARRAY_SIZE(volatile_path); ctr; ctr--, name++) {
> -               d = ovl_lookup_or_create(d, *name, ctr > 1 ? S_IFDIR : S_IFREG);
> +       /* Stop before the dirty file is created */
> +       for (ctr = 0; ctr < ARRAY_SIZE(volatile_path) - 1; ctr++, name++) {
> +               d = ovl_lookup_or_create(d, *name, S_IFDIR);
>                 if (IS_ERR(d))
>                         return PTR_ERR(d);
>         }
> -       dput(d);
> -       return 0;
> +       volatiledir = dget(d);
> +
> +       /* Create the dirty file exists before we set the xattr */
> +       d = ovl_lookup_or_create(d, *name, S_IFREG);

There is really no point in including OVL_VOLATILE_DIRTY_NAME in the array
this is just too confusing, use the name explicitly.

Thanks,
Amir.
