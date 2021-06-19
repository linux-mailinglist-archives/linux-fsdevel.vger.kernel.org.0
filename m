Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD473AD8F8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Jun 2021 11:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbhFSJeW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Jun 2021 05:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbhFSJeV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Jun 2021 05:34:21 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2171C061574;
        Sat, 19 Jun 2021 02:32:10 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id l64so9825990ioa.7;
        Sat, 19 Jun 2021 02:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ULd8HYJuBB9qyXhRiZpjAxSxHjvEWdS1msfJBI8/NOM=;
        b=sFOPmplaWQsaZAkwWKz47rQhHjXUT7QZW2Bc+kSp1aCjzkyWNGBVbc4dE0obQIFQyK
         t0FGlr0K+bnPg1raw9hEUre/ViL5aihx0bihjtZ1kB7K5B8nAskLn89JdxLhV2VeoPNu
         fmZoNArScvycfQR20WiyVWkUOObXUfb740gAF+nRsJDZ0ZDGoUh+H9f8BMbVt8esXT3i
         3sdVNoT5ctvs7fQMYl8IFXtKlGAgk1jShNYby4g3sMyNkFR5WLcBbVn9y1dXWAFg+djn
         g9qr/cZCgjbuXuz5GTf8unmwczAANGRDq5rbQ770vIM5rzzA1qsd90cwUmAMWrM7Iw67
         5dBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ULd8HYJuBB9qyXhRiZpjAxSxHjvEWdS1msfJBI8/NOM=;
        b=Nd1gG9d7c7Q90MNEzNGxOMOrGck8eATtDS2UMwK+LwVspRifAaABGBAEoaJ5Ws76vu
         b9SNMYTjza97mAOufEzbBxF00B0foT9Q1oivf/iirUGE74+Qo6WlZ1mtkw+PWRUpYFzC
         ZlSfVcLvMP8XDrOjzdVJ0JqZyzajPujjt3ln19YPtCBYffMl7N25IWf+1dfsXNg9iUW8
         /Aod5UHJlUqqC/Ed/Vw5+4ip905ycaFGjiW8cw6lA/eKj0AiqIKReb97ZqkNm5FdzrnN
         ss8zzFux29UrhiatI4DvdXlfdv39WuzCDgUs/PpbSM9fRCijW0BNM0nh6zqjxSox7bDK
         6dLA==
X-Gm-Message-State: AOAM5330x7/TZC7EXzjrlq5xgEqOA37MSJnfbOLcfjDoydNJ/cjGYljz
        JBYWNlEk1j+/mIQEUwchGCJIaFjKpTJPJkjoAZbNMeIQ
X-Google-Smtp-Source: ABdhPJzO6wrkVfFRApgMcLyrrKX042iKgt9EOFU0bxVFTZjQIAr4ex7z7p2ZGlzYsxXry9a+3LxM1LA7LXQ8ZKTiHEk=
X-Received: by 2002:a05:6602:2d83:: with SMTP id k3mr11699793iow.5.1624095130093;
 Sat, 19 Jun 2021 02:32:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210619092619.1107608-1-amir73il@gmail.com> <20210619092619.1107608-2-amir73il@gmail.com>
In-Reply-To: <20210619092619.1107608-2-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 19 Jun 2021 12:31:58 +0300
Message-ID: <CAOQ4uxjS79g5wnOM59De6e4FG88e8h8Z58M8V+zKs-r80=Tv5w@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] fs: add generic helper for filling statx attribute flags
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Chengguang Xu <cgxu519@mykernel.net>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Mike Marshall <hubcap@omnibond.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Forgot to CC linux-fsdevel and vfs/orangefs maintainers

On Sat, Jun 19, 2021 at 12:26 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> The immutable and append-only properties on an inode are published on
> the inode's i_flags and enforced by the VFS.
>
> Create a helper to fill the corresponding STATX_ATTR_ flags in the kstat
> structure from the inode's i_flags.
>
> Only orange was converted to use this helper.
> Other filesystems could use it in the future.
>
> Suggested-by: Miklos Szeredi <miklos@szeredi.hu>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/orangefs/inode.c  |  7 +------
>  fs/stat.c            | 18 ++++++++++++++++++
>  include/linux/fs.h   |  1 +
>  include/linux/stat.h |  4 ++++
>  4 files changed, 24 insertions(+), 6 deletions(-)
>
> diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
> index 6bf35a0d61f3..4092009716a3 100644
> --- a/fs/orangefs/inode.c
> +++ b/fs/orangefs/inode.c
> @@ -883,12 +883,7 @@ int orangefs_getattr(struct user_namespace *mnt_userns, const struct path *path,
>                 if (!(request_mask & STATX_SIZE))
>                         stat->result_mask &= ~STATX_SIZE;
>
> -               stat->attributes_mask = STATX_ATTR_IMMUTABLE |
> -                   STATX_ATTR_APPEND;
> -               if (inode->i_flags & S_IMMUTABLE)
> -                       stat->attributes |= STATX_ATTR_IMMUTABLE;
> -               if (inode->i_flags & S_APPEND)
> -                       stat->attributes |= STATX_ATTR_APPEND;
> +               generic_fill_statx_attr(inode, stat);
>         }
>         return ret;
>  }
> diff --git a/fs/stat.c b/fs/stat.c
> index 1fa38bdec1a6..314269150b5b 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -59,6 +59,24 @@ void generic_fillattr(struct user_namespace *mnt_userns, struct inode *inode,
>  }
>  EXPORT_SYMBOL(generic_fillattr);
>
> +/**
> + * generic_fill_statx_attr - Fill in the statx attributes from the inode flags
> + * @inode:     Inode to use as the source
> + * @stat:      Where to fill in the attribute flags
> + *
> + * Fill in the STATX_ATTR_ flags in the kstat structure for properties of the
> + * inode that are published on i_flags and enforced by the VFS.
> + */
> +void generic_fill_statx_attr(struct inode *inode, struct kstat *stat)
> +{
> +       if (inode->i_flags & S_IMMUTABLE)
> +               stat->attributes |= STATX_ATTR_IMMUTABLE;
> +       if (inode->i_flags & S_APPEND)
> +               stat->attributes |= STATX_ATTR_APPEND;
> +       stat->attributes_mask |= KSTAT_ATTR_VFS_FLAGS;
> +}
> +EXPORT_SYMBOL(generic_fill_statx_attr);
> +
>  /**
>   * vfs_getattr_nosec - getattr without security checks
>   * @path: file to get attributes from
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c3c88fdb9b2a..647664316013 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3353,6 +3353,7 @@ extern int page_symlink(struct inode *inode, const char *symname, int len);
>  extern const struct inode_operations page_symlink_inode_operations;
>  extern void kfree_link(void *);
>  void generic_fillattr(struct user_namespace *, struct inode *, struct kstat *);
> +void generic_fill_statx_attr(struct inode *inode, struct kstat *stat);
>  extern int vfs_getattr_nosec(const struct path *, struct kstat *, u32, unsigned int);
>  extern int vfs_getattr(const struct path *, struct kstat *, u32, unsigned int);
>  void __inode_add_bytes(struct inode *inode, loff_t bytes);
> diff --git a/include/linux/stat.h b/include/linux/stat.h
> index fff27e603814..7df06931f25d 100644
> --- a/include/linux/stat.h
> +++ b/include/linux/stat.h
> @@ -34,6 +34,10 @@ struct kstat {
>          STATX_ATTR_ENCRYPTED |                         \
>          STATX_ATTR_VERITY                              \
>          )/* Attrs corresponding to FS_*_FL flags */
> +#define KSTAT_ATTR_VFS_FLAGS                           \
> +       (STATX_ATTR_IMMUTABLE |                         \
> +        STATX_ATTR_APPEND                              \
> +        ) /* Attrs corresponding to S_* flags that are enforced by the VFS */
>         u64             ino;
>         dev_t           dev;
>         dev_t           rdev;
> --
> 2.32.0
>
