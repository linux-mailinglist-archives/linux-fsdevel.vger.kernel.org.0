Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 880692C663F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Nov 2020 14:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbgK0NFM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Nov 2020 08:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgK0NFM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Nov 2020 08:05:12 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EBDC0613D1;
        Fri, 27 Nov 2020 05:05:11 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id s10so4759585ioe.1;
        Fri, 27 Nov 2020 05:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/aCfQfU+2NxErOuM6SBa5QT3V1nalBKQFOreo5Hzh9M=;
        b=QUyskmOA4jrVRCDiEEaw/xep3qOSEwiJOzF5wkZqQJ5/IU5vX86Gtg8l6TJXWoYt6I
         5Y5AHGhR2V6+jQX/lmtsWDKiGkynWmimvQzbqKDUD4d2msWTYRpi+89ahnASVLVYJilp
         hWOhwA8q0uFDT8pnSz4pfTaMupMG7T25comj3rVGKw58aPWh64PZeUPqYak4ZFkIwv6c
         IwxnruDEjL/7MJ0DfTCNofqZNpcqhttmRodC9B8gnLUBBrlENU2JSbAKmjn0HharHtjV
         auK8Hhn5NEsfj9I+ZAynv/SWJjPoY7eMT+XbUdUGXL6lvvf7sBiWmP/A93ZOuFO6ETuZ
         sxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/aCfQfU+2NxErOuM6SBa5QT3V1nalBKQFOreo5Hzh9M=;
        b=rLSynWAvFZZRt3Ht/nbXoIDxad0AprtICQxE8QuSNCgEarbuvdR6Kacg6skftnMQUP
         2R9qbnMgIr7koGGUimJbcS7Duhr/h2IkIfVXVzJH3T+UI0PVFB3x4Am4rp5Sg8kofKZt
         9rR0Jzd3Y+cWA5IpkhAcfFo/DRVsqWX9FOl7YolToX7b7dDYqu5YBSbBSiDLRwXoqnz3
         U6ks5hNGs7KnU0DGkvsiCjEGKQEYw+YtGzMPiyp/mobc8DdI7hwrXC6sQY4znmU9Mghk
         Xg40iYpuWKMC9UMlF0QgP9BpCajwg6rx2DZ4FNRRwYcEY/wtARK5cJ2YvnIesJgvcH2b
         OFlA==
X-Gm-Message-State: AOAM532eKLfxNS0lYG/8C9uSJ4Z7vyeSZeMOKFy4MYF59AX6tLE1E27C
        Ch2r0CKkuKkjGqJRiNJnk9uIne4ytVrsWSmcxT4=
X-Google-Smtp-Source: ABdhPJyOqC/zPrxlOuXVupO3nkYt6H58mtxUArgl0z5u7cunUAUWf6a9Q4tAIzMFNEp8f8LoszQYvTaQD/LB/ejt5d0=
X-Received: by 2002:a02:ccd6:: with SMTP id k22mr7375006jaq.93.1606482311192;
 Fri, 27 Nov 2020 05:05:11 -0800 (PST)
MIME-Version: 1.0
References: <20201127092058.15117-1-sargun@sargun.me> <20201127092058.15117-4-sargun@sargun.me>
In-Reply-To: <20201127092058.15117-4-sargun@sargun.me>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 27 Nov 2020 15:04:59 +0200
Message-ID: <CAOQ4uxhE4qQrRn2gVs+EoyyCQdGCBZLHdfKf+oDBvii0m3aX4Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] overlay: Add the ability to remount volatile
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

On Fri, Nov 27, 2020 at 11:21 AM Sargun Dhillon <sargun@sargun.me> wrote:
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
> [1]: https://lore.kernel.org/linux-unionfs/CAOQ4uxhKr+j5jFyEC2gJX8E8M19mQ3CqdTYaPZOvDQ9c0qLEzw@mail.gmail.com/T/#m6abe713e4318202ad57f301bf28a414e1d824f9c
>
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-unionfs@vger.kernel.org
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>

You may add:
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  Documentation/filesystems/overlayfs.rst | 18 +++--
>  fs/overlayfs/overlayfs.h                | 37 +++++++++-
>  fs/overlayfs/readdir.c                  | 98 ++++++++++++++++++++++---
>  fs/overlayfs/super.c                    | 73 +++++++++++++-----
>  fs/overlayfs/util.c                     |  2 +
>  5 files changed, 190 insertions(+), 38 deletions(-)
>
> diff --git a/Documentation/filesystems/overlayfs.rst b/Documentation/filesystems/overlayfs.rst
> index c6e30c1bc2f2..b485fdb65b85 100644
> --- a/Documentation/filesystems/overlayfs.rst
> +++ b/Documentation/filesystems/overlayfs.rst
> @@ -579,13 +579,17 @@ example, upon detecting a fault, ext4 can be configured to panic.
>  The advantage of mounting with the "volatile" option is that all forms of
>  sync calls to the upper filesystem are omitted.
>
> -When overlay is mounted with "volatile" option, the directory
> -"$workdir/work/incompat/volatile" is created.  During next mount, overlay
> -checks for this directory and refuses to mount if present. This is a strong
> -indicator that user should throw away upper and work directories and create
> -fresh one. In very limited cases where the user knows that the system has
> -not crashed and contents of upperdir are intact, The "volatile" directory
> -can be removed.
> +When overlay is mounted with the "volatile" option, the directory
> +"$workdir/work/incompat/volatile" is created.  This acts as a indicator
> +that the user should throw away upper and work directories and create fresh
> +ones.  In some cases, the overlayfs can detect if the upperdir can be
> +reused safely in a subsequent volatile mounts, and mounting will proceed as
> +normal.  If the filesystem is unable to determine if this is safe (due to a
> +reboot, upgraded kernel code, or loss of checkpoint, etc...), the user may
> +bypass these safety checks and remove the "volatile" directory if they know
> +the system did not encounter a fault and the contents of the upperdir are
> +intact. Then, the user can remount the filesystem as normal.
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
> index 01620ebae1bd..7b66fbb20261 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -1080,10 +1080,78 @@ int ovl_check_d_type_supported(struct path *realpath)
>
>         return rdd.d_type_supported;
>  }
> +static int ovl_verify_volatile_info(struct ovl_fs *ofs,
> +                                   struct dentry *volatiledir)
> +{
> +       int err;
> +       struct ovl_volatile_info info;
> +
> +       if (!volatiledir->d_inode)
> +               return 0;
> +
> +       if (!ofs->config.ovl_volatile) {
> +               pr_debug("Mount is not volatile; upperdir is marked volatile\n");
> +               return -EINVAL;
> +       }
> +
> +       err = ovl_do_getxattr(ofs, volatiledir, OVL_XATTR_VOLATILE, &info,
> +                             sizeof(info));
> +       if (err < 0) {
> +               pr_debug("Unable to read volatile xattr: %d\n", err);
> +               return -EINVAL;
> +       }
> +
> +       if (err != sizeof(info)) {
> +               pr_debug("%s xattr on-disk size is %d expected to read %zd\n",
> +                        ovl_xattr(ofs, OVL_XATTR_VOLATILE), err, sizeof(info));
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
> +
> +       return 1;
> +}
>
> -#define OVL_INCOMPATDIR_NAME "incompat"
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
> +       if (!strcmp(p->name, OVL_VOLATILEDIR_NAME)) {
> +               d = lookup_one_len(p->name, path->dentry, p->len);
> +               if (IS_ERR(d))
> +                       return PTR_ERR(d);
> +
> +               err = ovl_verify_volatile_info(ofs, d);
> +               dput(d);
> +       }
> +
> +       if (err == -EINVAL)
> +               pr_err("incompat feature '%s' cannot be mounted\n", p->name);
> +       else
> +               pr_debug("incompat '%s' handled: %d\n", p->name, err);
> +
> +       dput(d);

Letfover.

Thanks,
Amir.
