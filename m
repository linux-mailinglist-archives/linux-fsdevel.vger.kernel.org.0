Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65D7414EECD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2020 15:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbgAaOxo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jan 2020 09:53:44 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:36024 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728825AbgAaOxo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jan 2020 09:53:44 -0500
Received: by mail-il1-f196.google.com with SMTP id b15so6386994iln.3;
        Fri, 31 Jan 2020 06:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fqQcjBrZh3VTK71cXXBXjuHv3p2/IvJ38yPD/lY1ysQ=;
        b=PZycrQaU/gRr7IH3HZN2O4KvOSs6Fgx3kl5uoFBFRLVTK8mQcfBwxsH7vZk9vso/Og
         v+NrCUNu+5Az/ChDCRebwebNA8NiIKGQ4ud2rCMdM1jMEw0cDbTTs2382njQILTIwggX
         1mTdBHVhFaBz3rV2ahhcK0Sv2Io9Rrfk6/HG5yt1+eTSgGJ944cM7R63CqYJ3bcLxQF1
         3Fa+YrNJaD8La2oe0tZtVbCS+4NetIzYv6ZGg2YKMUr6EViN8pIZ5YLrjasY/RgJEKmo
         1Uqlm+/96Z6YHODnhABsqHNw5y+kjQCXT+dNMxybJilqXud4NEupVs9y0jdF+/nGbOx1
         sH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fqQcjBrZh3VTK71cXXBXjuHv3p2/IvJ38yPD/lY1ysQ=;
        b=rZ1/LERk9a9U1zjI2TIuCSJO1BaH268NW30w7sKToPi7wf+80Wiz31Y7/eRv1q1T4N
         PdWpIjqkR1wMpurzAGmQK7T68Tl15/i/pbJipPt6ejbb5HQc+2J9l71zJ/eykhPuLHit
         /2UDWOphx2IhTOj7Y3nkTo3ZYwpeAsvjjX0TcQn66VAF+41vGyvuTb0Gy46aNu7hK1Lr
         VbBJ+o7/zqurYi5zmiyNi5XnKmud+Y+DnIxk98hU0u+gxXJfl1ExKnrAH1X7a4H97Uc+
         sORZQjEZHV4rIUUI0cT48XFM52nV3JxGutHFtruaNBM8S9YHe4Yh7UxaWXJPYFnXy7ZD
         yWkw==
X-Gm-Message-State: APjAAAWdGlU8c3+uAf5/KJs0lNP1snuIKjcfh6/AOzm6SM0Vs4pKcWVN
        QjxEvO9WIvJLBNgnvnYfSXhcNWrFpc4dUR4d0Y8=
X-Google-Smtp-Source: APXvYqxJeD9xFMFUPkeb7vh0CuwkdGxKEPwYnMjgzVx2xaqeRB0RvlSwRqFiaywfp/QryywsP1mFtvSvA7Gjs6vEkog=
X-Received: by 2002:a92:9c8c:: with SMTP id x12mr3031854ill.275.1580482422175;
 Fri, 31 Jan 2020 06:53:42 -0800 (PST)
MIME-Version: 1.0
References: <20200131115004.17410-1-mszeredi@redhat.com> <20200131115004.17410-4-mszeredi@redhat.com>
In-Reply-To: <20200131115004.17410-4-mszeredi@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 31 Jan 2020 16:53:31 +0200
Message-ID: <CAOQ4uxjR+6wqWMKf18qOEKk-VndVaHPtttPf6c06yK=9OphB8Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] ovl: decide if revalidate needed on a per-dentry bases
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 31, 2020 at 1:51 PM Miklos Szeredi <mszeredi@redhat.com> wrote:
>
> Allow completely skipping ->revalidate() on a per-dentry bases, in case the
> underlying layers used for a dentry do not themselves have ->revalidate().
>
> E.g. negative overlay dentry has no underlying layers, hence revalidate is
> unnecessary.  Or if lower layer is remote but overlay dentry is pure-upper,
> then can skip revalidate.
>
> The following places need to update whether the dentry needs revalidate or
> not:
>
>  - fill-super (root dentry)
>  - lookup
>  - create
>  - fh_to_dentry
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/overlayfs/dir.c       |  3 +++
>  fs/overlayfs/export.c    |  2 ++
>  fs/overlayfs/namei.c     |  3 +++
>  fs/overlayfs/overlayfs.h |  3 ++-
>  fs/overlayfs/super.c     | 23 +++++++----------------
>  fs/overlayfs/util.c      | 15 ++++++++++++---
>  6 files changed, 29 insertions(+), 20 deletions(-)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 8e57d5372b8f..b3471ef51440 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -243,6 +243,9 @@ static int ovl_instantiate(struct dentry *dentry, struct inode *inode,
>
>         ovl_dir_modified(dentry->d_parent, false);
>         ovl_dentry_set_upper_alias(dentry);
> +       ovl_dentry_update_reval(dentry, newdentry,
> +                       DCACHE_OP_REVALIDATE | DCACHE_OP_WEAK_REVALIDATE);
> +
>         if (!hardlink) {
>                 /*
>                  * ovl_obtain_alias() can be called after ovl_create_real()
> diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
> index 6f54d70cef27..a58b3d9b06b9 100644
> --- a/fs/overlayfs/export.c
> +++ b/fs/overlayfs/export.c
> @@ -324,6 +324,8 @@ static struct dentry *ovl_obtain_alias(struct super_block *sb,
>                 if (upper_alias)
>                         ovl_dentry_set_upper_alias(dentry);
>         }
> +       ovl_dentry_update_reval(dentry, upper,
> +                       DCACHE_OP_REVALIDATE | DCACHE_OP_WEAK_REVALIDATE);
>
>         return d_instantiate_anon(dentry, inode);
>
> diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> index a5b998a93a24..76e61cc27822 100644
> --- a/fs/overlayfs/namei.c
> +++ b/fs/overlayfs/namei.c
> @@ -1077,6 +1077,9 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
>                         goto out_free_oe;
>         }
>
> +       ovl_dentry_update_reval(dentry, upperdentry,
> +                       DCACHE_OP_REVALIDATE | DCACHE_OP_WEAK_REVALIDATE);
> +
>         revert_creds(old_cred);
>         if (origin_path) {
>                 dput(origin_path->dentry);
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 3623d28aa4fa..68124a4f8f9b 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -229,7 +229,8 @@ struct dentry *ovl_indexdir(struct super_block *sb);
>  bool ovl_index_all(struct super_block *sb);
>  bool ovl_verify_lower(struct super_block *sb);
>  struct ovl_entry *ovl_alloc_entry(unsigned int numlower);
> -bool ovl_dentry_remote(struct dentry *dentry);
> +void ovl_dentry_update_reval(struct dentry *dentry, struct dentry *upperdentry,
> +                            unsigned int mask);
>  bool ovl_dentry_weird(struct dentry *dentry);
>  enum ovl_path_type ovl_path_type(struct dentry *dentry);
>  void ovl_path_upper(struct dentry *dentry, struct path *path);
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 7e294bf719ff..26d4153240a8 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -158,11 +158,6 @@ static int ovl_dentry_weak_revalidate(struct dentry *dentry, unsigned int flags)
>  static const struct dentry_operations ovl_dentry_operations = {
>         .d_release = ovl_dentry_release,
>         .d_real = ovl_d_real,
> -};
> -
> -static const struct dentry_operations ovl_reval_dentry_operations = {
> -       .d_release = ovl_dentry_release,
> -       .d_real = ovl_d_real,
>         .d_revalidate = ovl_dentry_revalidate,
>         .d_weak_revalidate = ovl_dentry_weak_revalidate,
>  };
> @@ -779,7 +774,7 @@ static int ovl_check_namelen(struct path *path, struct ovl_fs *ofs,
>  }
>
>  static int ovl_lower_dir(const char *name, struct path *path,
> -                        struct ovl_fs *ofs, int *stack_depth, bool *remote)
> +                        struct ovl_fs *ofs, int *stack_depth)
>  {
>         int fh_type;
>         int err;
> @@ -794,9 +789,6 @@ static int ovl_lower_dir(const char *name, struct path *path,
>
>         *stack_depth = max(*stack_depth, path->mnt->mnt_sb->s_stack_depth);
>
> -       if (ovl_dentry_remote(path->dentry))
> -               *remote = true;
> -
>         /*
>          * The inodes index feature and NFS export need to encode and decode
>          * file handles, so they require that all layers support them.
> @@ -1439,7 +1431,6 @@ static struct ovl_entry *ovl_get_lowerstack(struct super_block *sb,
>         char *lowertmp, *lower;
>         struct path *stack = NULL;
>         unsigned int stacklen, numlower = 0, i;
> -       bool remote = false;
>         struct ovl_entry *oe;
>
>         err = -ENOMEM;
> @@ -1471,7 +1462,7 @@ static struct ovl_entry *ovl_get_lowerstack(struct super_block *sb,
>         lower = lowertmp;
>         for (numlower = 0; numlower < stacklen; numlower++) {
>                 err = ovl_lower_dir(lower, &stack[numlower], ofs,
> -                                   &sb->s_stack_depth, &remote);
> +                                   &sb->s_stack_depth);
>                 if (err)
>                         goto out_err;
>
> @@ -1499,11 +1490,6 @@ static struct ovl_entry *ovl_get_lowerstack(struct super_block *sb,
>                 oe->lowerstack[i].layer = &ofs->layers[i+1];
>         }
>
> -       if (remote)
> -               sb->s_d_op = &ovl_reval_dentry_operations;
> -       else
> -               sb->s_d_op = &ovl_dentry_operations;
> -
>  out:
>         for (i = 0; i < numlower; i++)
>                 path_put(&stack[i]);
> @@ -1597,6 +1583,8 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
>         struct cred *cred;
>         int err;
>
> +       sb->s_d_op = &ovl_dentry_operations;
> +
>         err = -ENOMEM;
>         ofs = kzalloc(sizeof(struct ovl_fs), GFP_KERNEL);
>         if (!ofs)
> @@ -1724,6 +1712,9 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
>         ovl_inode_init(d_inode(root_dentry), upperpath.dentry,
>                        ovl_dentry_lower(root_dentry), NULL);
>
> +       ovl_dentry_update_reval(root_dentry, upperpath.dentry,
> +                               DCACHE_OP_WEAK_REVALIDATE);
> +
>         sb->s_root = root_dentry;
>
>         return 0;
> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index 67cd2866aaa2..3ad8fb291f7d 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -90,10 +90,19 @@ struct ovl_entry *ovl_alloc_entry(unsigned int numlower)
>         return oe;
>  }
>
> -bool ovl_dentry_remote(struct dentry *dentry)

Removed too early. It still has users.
Otherwise looks ok.

Thanks,
Amir.
