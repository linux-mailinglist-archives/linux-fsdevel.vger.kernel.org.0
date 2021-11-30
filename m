Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326B1462CBC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 07:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbhK3G3L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 01:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbhK3G3K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 01:29:10 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC9AC061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Nov 2021 22:25:52 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id p23so24686385iod.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Nov 2021 22:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CiWJfc9uFfZgnUVHbrcxB/R4h/i9zbaeFJjEo3eLGF8=;
        b=b1ytRX+YfBz+hyZmgPG1OM46JS4pbF3XU5zxFhT/TT1iOmilgdxRygefrJg6ZynZmO
         yV3Xu4CbyTIEu0WS8U/LZrVMjyd+/yTlaSvm7/qizSZwjZKvqgWvJrMr6MCb5dp2Azx6
         ocOtVaMd9F0OdLY7Oe+HhFAWnaLqGhEBlR6jCAv9GZbDh/W2+7M/mNW/UbS5596RgHqF
         k8GkwMc/cyZYdL3mnidg8z+hTSysiE1aSeOWqoO7MXrETHu5M2Lph/lAWQKopm4HEffX
         McH/4riitcovtwxNWGP5NTXE8ze3fJcErh0K3zbUHwX3aTS73MfJvYy1/Z7tNmiep3go
         CR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CiWJfc9uFfZgnUVHbrcxB/R4h/i9zbaeFJjEo3eLGF8=;
        b=B4VIKEA4aZJfRX+a4JtHjJXGmJTyPGOryaTmLhQ4fRIECVEnnLydAukIlXWAt6s3aU
         rp2B3BSxvEhEctBSg3W73TfQNwnJ1QIf4lz4IdGDQrumhgYeuqvrW4Q6q2kaciKLoYIs
         1bYWfH6C5jAjFz+gszSjJfYdXDhghXuq506x+5ywF1QzOOd5YQI+pGvojqVJI8CcPic0
         SiepUiMEH4uk4RrHgk0+DLEjJkuH6CiibtKf3A9YUGEPCnHmVqtQyc9rogzmeL4e8bxk
         9EQL2hDqX8LiYhuiShvBMuaNqnDX+6w7YMaVjcK3Vz0i0Fkr+uB7GzzOKiqNk/W0vyVD
         J8Ew==
X-Gm-Message-State: AOAM530zXhiIYSOYa3jD/xhZdyJ7O5ZuR1bA2UYX+XzMi8NXIi8IKk/g
        hJVJ9f1CmDhOt9RJ9j9MFUHEBRkfkbgp3OltOMy2jrGJLoo=
X-Google-Smtp-Source: ABdhPJyozFj3/wNfFhK+DMe8sfVwmmBmkIFYlzW6KWZlrBPOhnlAxAxsdDZMmUzhHdNeT0DDlMP6fugvamEEAiC/0tU=
X-Received: by 2002:a02:9f87:: with SMTP id a7mr71673967jam.136.1638253551431;
 Mon, 29 Nov 2021 22:25:51 -0800 (PST)
MIME-Version: 1.0
References: <20211123114227.3124056-1-brauner@kernel.org> <20211123114227.3124056-2-brauner@kernel.org>
In-Reply-To: <20211123114227.3124056-2-brauner@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 30 Nov 2021 08:25:40 +0200
Message-ID: <CAOQ4uxj-iyqbcpNaNr3s7Eb2u12MHQmc3cDZQh9UZOFDQyxCeA@mail.gmail.com>
Subject: Re: [PATCH 01/10] fs: add is_mapped_mnt() helper
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@digitalocean.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 23, 2021 at 2:18 PM Christian Brauner <brauner@kernel.org> wrote:
>
> From: Christian Brauner <christian.brauner@ubuntu.com>
>
> Multiple places open-code the same check to determine whether a given
> mount is idmapped. Introduce a simple helper function that can be used
> instead. This allows us to get rid of the fragile open-coding. We will
> later change the check that is used to determine whether a given mount
> is idmapped. Introducing a helper allows us to do this in a single
> place instead of doing it for multiple places.
>
> Cc: Seth Forshee <sforshee@digitalocean.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> CC: linux-fsdevel@vger.kernel.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
>  fs/cachefiles/bind.c |  2 +-
>  fs/ecryptfs/main.c   |  2 +-
>  fs/namespace.c       |  2 +-
>  fs/nfsd/export.c     |  2 +-
>  fs/overlayfs/super.c |  2 +-
>  fs/proc_namespace.c  |  2 +-
>  include/linux/fs.h   | 14 ++++++++++++++
>  7 files changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/fs/cachefiles/bind.c b/fs/cachefiles/bind.c
> index d463d89f5db8..8130142d89c2 100644
> --- a/fs/cachefiles/bind.c
> +++ b/fs/cachefiles/bind.c
> @@ -117,7 +117,7 @@ static int cachefiles_daemon_add_cache(struct cachefiles_cache *cache)
>         root = path.dentry;
>
>         ret = -EINVAL;
> -       if (mnt_user_ns(path.mnt) != &init_user_ns) {
> +       if (is_mapped_mnt(path.mnt)) {
>                 pr_warn("File cache on idmapped mounts not supported");
>                 goto error_unsupported;
>         }
> diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
> index d66bbd2df191..331ac3a59515 100644
> --- a/fs/ecryptfs/main.c
> +++ b/fs/ecryptfs/main.c
> @@ -537,7 +537,7 @@ static struct dentry *ecryptfs_mount(struct file_system_type *fs_type, int flags
>                 goto out_free;
>         }
>
> -       if (mnt_user_ns(path.mnt) != &init_user_ns) {
> +       if (is_mapped_mnt(path.mnt)) {
>                 rc = -EINVAL;
>                 printk(KERN_ERR "Mounting on idmapped mounts currently disallowed\n");
>                 goto out_free;
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 659a8f39c61a..7d7b80b375a4 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -3936,7 +3936,7 @@ static int can_idmap_mount(const struct mount_kattr *kattr, struct mount *mnt)
>          * mapping. It makes things simpler and callers can just create
>          * another bind-mount they can idmap if they want to.
>          */
> -       if (mnt_user_ns(m) != &init_user_ns)
> +       if (is_mapped_mnt(m))
>                 return -EPERM;
>
>         /* The underlying filesystem doesn't support idmapped mounts yet. */
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index 9421dae22737..292bde9e1eb3 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -427,7 +427,7 @@ static int check_export(struct path *path, int *flags, unsigned char *uuid)
>                 return -EINVAL;
>         }
>
> -       if (mnt_user_ns(path->mnt) != &init_user_ns) {
> +       if (is_mapped_mnt(path->mnt)) {
>                 dprintk("exp_export: export of idmapped mounts not yet supported.\n");
>                 return -EINVAL;
>         }
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 265181c110ae..113575fc6155 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -873,7 +873,7 @@ static int ovl_mount_dir_noesc(const char *name, struct path *path)
>                 pr_err("filesystem on '%s' not supported\n", name);
>                 goto out_put;
>         }
> -       if (mnt_user_ns(path->mnt) != &init_user_ns) {
> +       if (is_mapped_mnt(path->mnt)) {
>                 pr_err("idmapped layers are currently not supported\n");
>                 goto out_put;
>         }
> diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
> index 392ef5162655..788c687bb052 100644
> --- a/fs/proc_namespace.c
> +++ b/fs/proc_namespace.c
> @@ -80,7 +80,7 @@ static void show_mnt_opts(struct seq_file *m, struct vfsmount *mnt)
>                         seq_puts(m, fs_infop->str);
>         }
>
> -       if (mnt_user_ns(mnt) != &init_user_ns)
> +       if (is_mapped_mnt(mnt))
>                 seq_puts(m, ",idmapped");
>  }
>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 1cb616fc1105..192242476b2b 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2725,6 +2725,20 @@ static inline struct user_namespace *file_mnt_user_ns(struct file *file)
>  {
>         return mnt_user_ns(file->f_path.mnt);
>  }
> +
> +/**
> + * is_mapped_mnt - check whether a mount is mapped
> + * @mnt: the mount to check
> + *
> + * If @mnt has an idmapping attached to it @mnt is mapped.
> + *
> + * Return: true if mount is mapped, false if not.
> + */
> +static inline bool is_mapped_mnt(const struct vfsmount *mnt)
> +{
> +       return mnt_user_ns(mnt) != &init_user_ns;
> +}
> +

Maybe is_idmapped_mnt?

Thanks,
Amir.
