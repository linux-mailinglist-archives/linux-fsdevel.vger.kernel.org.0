Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA5F79DFA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 07:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjIMF7b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 01:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238142AbjIMF71 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 01:59:27 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05784F5;
        Tue, 12 Sep 2023 22:59:23 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-7a85540d220so430993241.1;
        Tue, 12 Sep 2023 22:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694584762; x=1695189562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OeYKm4CnIjUG85mGmBFtIGL5LILW0gw2bFjgVlhwj/s=;
        b=iv9+g+m0FgEr+47cSa5VuUQefueLz1avDadOC6eSo5OIAqLK/DkdG01sGEI1Se0L4b
         b+1SczuRGDsl7f2ElysWQbII18noyi80cYmDJnH3wKt/ocPLBgLc50fgT7qfTqOWlX0x
         MORr2gBNCWC7yAw26tq0cIsBNyNlxPod3PlxOhqU+Ije9G3i7SP8VMoBJQKixQkVfkcn
         dNnDP2j1+Sj9FBq/6t+tDGc82MpVhCmqH5/2T5T7mcqIRQXZNYSUwJQqqxGHDfoJCUxK
         Y/fs1QrFKdsHhUPucRPyEgRhh0AIGGXK6beEvFg04IQIbzTu20XAK3Oqb0NNwKut4xe6
         8f1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694584762; x=1695189562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OeYKm4CnIjUG85mGmBFtIGL5LILW0gw2bFjgVlhwj/s=;
        b=VgEl2RiKMV9GFKcEM1HRIQlCezaHXA9nnn3YXTW0EkcbW2bTJbyf2ZRTSGtFxCPPnX
         FIOSPy6MW1E7gU7IM+hRGO1funlFscaBZqa6fvD2F3+VLDpWl/jFq8DdlB+nXOmfXSX+
         pWu2MRWd6UU8zwgYx6C4g9nOw+AdDKxrajUpVuhnFh24bCKGzgBqkFeJUJzt9bScc+Wv
         wu9CGUGK/siIFPFx8TT6lyBItf/p6qMspuZsh79x0Hq3HqjGctcVNTWmZo7ph2XVEqH0
         hkiGZJYzLF4GwPBT+42JZnDOIMUMrE5N0VfjP+47RHCjM3nRPaxGKBco19w1xARbtVUl
         29Tg==
X-Gm-Message-State: AOJu0Yx28nE/E/px1nn+DGFCI4lFuP0dE9yvj4otxE6g+pdyJuhgpCdz
        qDyRVr3iLiscHBdsK1oicBW/CrTtovwhBIkYi8SZxc/3
X-Google-Smtp-Source: AGHT+IF1NpbAhX038+0eCDq/66zfddkdohSG2yU+HmaNV5/goRK3yCDQAELUKuxp3Cfk4pZbuaSvBokpjfDc+RA11+I=
X-Received: by 2002:a67:de06:0:b0:447:7a6b:2c8b with SMTP id
 q6-20020a67de06000000b004477a6b2c8bmr1082622vsk.30.1694584761947; Tue, 12 Sep
 2023 22:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230912185408.3343163-1-amir73il@gmail.com>
In-Reply-To: <20230912185408.3343163-1-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 13 Sep 2023 08:59:10 +0300
Message-ID: <CAOQ4uxhJKRqKMc5r08u+onn4M_LHxgVQH3WctsvZZa_vEsaAkQ@mail.gmail.com>
Subject: Re: [PATCH] ovl: factor out some common helpers for backing files io
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[forgot to CC overlayfs list]

On Tue, Sep 12, 2023 at 9:54=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> Overlayfs stores its files data in backing files on other filesystems.
>
> Factor out some common helpers to perform io to backing files, that will
> later be reused by fuse passthrough code.
>
> Suggested-by: Miklos Szeredi <miklos@szeredi.hu>
> Link: https://lore.kernel.org/r/CAJfpeguhmZbjP3JLqtUy0AdWaHOkAPWeP827BBWw=
RFEAUgnUcQ@mail.gmail.com
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>
> Miklos,
>
> This is the re-factoring that you suggested in the FUSE passthrough
> patches discussion linked above.
>
> This patch is based on the overlayfs prep patch set I just posted [1].
>
> Although overlayfs currently is the only user of these backing file
> helpers, I am sending this patch to a wider audience in case other
> filesystem developers want to comment on the abstraction.
>
> We could perhaps later considering moving backing_file_open() helper
> and related code to backing_file.c.
>
> In any case, if there are no objections, I plan to queue this work
> for 6.7 via the overlayfs tree.
>
> Thanks,
> Amir.
>
> [1] https://lore.kernel.org/linux-unionfs/20230912173653.3317828-1-amir73=
il@gmail.com/
>
>
>  MAINTAINERS                  |   2 +
>  fs/Kconfig                   |   4 +
>  fs/Makefile                  |   1 +
>  fs/backing_file.c            | 160 +++++++++++++++++++++++++++++++++++
>  fs/overlayfs/Kconfig         |   1 +
>  fs/overlayfs/file.c          | 137 ++----------------------------
>  fs/overlayfs/overlayfs.h     |   2 -
>  fs/overlayfs/super.c         |  11 +--
>  include/linux/backing_file.h |  22 +++++
>  9 files changed, 199 insertions(+), 141 deletions(-)
>  create mode 100644 fs/backing_file.c
>  create mode 100644 include/linux/backing_file.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 90f13281d297..4e1d21773e0e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16092,7 +16092,9 @@ L:      linux-unionfs@vger.kernel.org
>  S:     Supported
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.gi=
t
>  F:     Documentation/filesystems/overlayfs.rst
> +F:     fs/backing_file.c
>  F:     fs/overlayfs/
> +F:     include/linux/backing_file.h
>
>  P54 WIRELESS DRIVER
>  M:     Christian Lamparter <chunkeey@googlemail.com>
> diff --git a/fs/Kconfig b/fs/Kconfig
> index aa7e03cc1941..9027a88ffa47 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -26,6 +26,10 @@ config LEGACY_DIRECT_IO
>         depends on BUFFER_HEAD
>         bool
>
> +# Common backing file helpers
> +config FS_BACKING_FILE
> +       bool
> +
>  if BLOCK
>
>  source "fs/ext2/Kconfig"
> diff --git a/fs/Makefile b/fs/Makefile
> index f9541f40be4e..95ef06cff388 100644
> --- a/fs/Makefile
> +++ b/fs/Makefile
> @@ -39,6 +39,7 @@ obj-$(CONFIG_COMPAT_BINFMT_ELF)       +=3D compat_binfm=
t_elf.o
>  obj-$(CONFIG_BINFMT_ELF_FDPIC) +=3D binfmt_elf_fdpic.o
>  obj-$(CONFIG_BINFMT_FLAT)      +=3D binfmt_flat.o
>
> +obj-$(CONFIG_FS_BACKING_FILE)  +=3D backing_file.o
>  obj-$(CONFIG_FS_MBCACHE)       +=3D mbcache.o
>  obj-$(CONFIG_FS_POSIX_ACL)     +=3D posix_acl.o
>  obj-$(CONFIG_NFS_COMMON)       +=3D nfs_common/
> diff --git a/fs/backing_file.c b/fs/backing_file.c
> new file mode 100644
> index 000000000000..ea895ca1639d
> --- /dev/null
> +++ b/fs/backing_file.c
> @@ -0,0 +1,160 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Common helpers for backing file io.
> + * Forked from fs/overlayfs/file.c.
> + *
> + * Copyright (C) 2017 Red Hat, Inc.
> + * Copyright (C) 2023 CTERA Networks.
> + */
> +
> +#include <linux/backing_file.h>
> +
> +struct backing_aio_req {
> +       struct kiocb iocb;
> +       refcount_t ref;
> +       struct kiocb *orig_iocb;
> +       void (*cleanup)(struct kiocb *, long);
> +};
> +
> +static struct kmem_cache *backing_aio_req_cachep;
> +
> +#define BACKING_IOCB_MASK \
> +       (IOCB_NOWAIT | IOCB_HIPRI | IOCB_DSYNC | IOCB_SYNC | IOCB_APPEND)
> +
> +static rwf_t iocb_to_rw_flags(int flags)
> +{
> +       return (__force rwf_t)(flags & BACKING_IOCB_MASK);
> +}
> +
> +static void backing_aio_put(struct backing_aio_req *aio_req)
> +{
> +       if (refcount_dec_and_test(&aio_req->ref)) {
> +               fput(aio_req->iocb.ki_filp);
> +               kmem_cache_free(backing_aio_req_cachep, aio_req);
> +       }
> +}
> +
> +/* Completion for submitted/failed async rw io */
> +static void backing_aio_cleanup(struct backing_aio_req *aio_req, long re=
s)
> +{
> +       struct kiocb *iocb =3D &aio_req->iocb;
> +       struct kiocb *orig_iocb =3D aio_req->orig_iocb;
> +
> +       if (iocb->ki_flags & IOCB_WRITE)
> +               kiocb_end_write(iocb);
> +
> +       orig_iocb->ki_pos =3D iocb->ki_pos;
> +       if (aio_req->cleanup)
> +               aio_req->cleanup(orig_iocb, res);
> +
> +       backing_aio_put(aio_req);
> +}
> +
> +/* Completion for submitted async rw io */
> +static void backing_aio_rw_complete(struct kiocb *iocb, long res)
> +{
> +       struct backing_aio_req *aio_req =3D container_of(iocb,
> +                                              struct backing_aio_req, io=
cb);
> +       struct kiocb *orig_iocb =3D aio_req->orig_iocb;
> +
> +       backing_aio_cleanup(aio_req, res);
> +       orig_iocb->ki_complete(orig_iocb, res);
> +}
> +
> +
> +ssize_t backing_file_read_iter(struct file *file, struct iov_iter *iter,
> +                              struct kiocb *iocb, int flags,
> +                              void (*cleanup)(struct kiocb *, long))
> +{
> +       struct backing_aio_req *aio_req =3D NULL;
> +       ssize_t ret;
> +
> +       if (!iov_iter_count(iter))
> +               return 0;
> +
> +       if (iocb->ki_flags & IOCB_DIRECT &&
> +           !(file->f_mode & FMODE_CAN_ODIRECT))
> +               return -EINVAL;
> +
> +       if (is_sync_kiocb(iocb)) {
> +               rwf_t rwf =3D iocb_to_rw_flags(flags);
> +
> +               ret =3D vfs_iter_read(file, iter, &iocb->ki_pos, rwf);
> +               if (cleanup)
> +                       cleanup(iocb, ret);
> +       } else {
> +               aio_req =3D kmem_cache_zalloc(backing_aio_req_cachep, GFP=
_KERNEL);
> +               if (!aio_req)
> +                       return -ENOMEM;
> +
> +               aio_req->orig_iocb =3D iocb;
> +               aio_req->cleanup =3D cleanup;
> +               kiocb_clone(&aio_req->iocb, iocb, get_file(file));
> +               aio_req->iocb.ki_complete =3D backing_aio_rw_complete;
> +               refcount_set(&aio_req->ref, 2);
> +               ret =3D vfs_iocb_iter_read(file, &aio_req->iocb, iter);
> +               backing_aio_put(aio_req);
> +               if (ret !=3D -EIOCBQUEUED)
> +                       backing_aio_cleanup(aio_req, ret);
> +       }
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(backing_file_read_iter);
> +
> +ssize_t backing_file_write_iter(struct file *file, struct iov_iter *iter=
,
> +                               struct kiocb *iocb, int flags,
> +                               void (*cleanup)(struct kiocb *, long))
> +{
> +       ssize_t ret;
> +
> +       if (!iov_iter_count(iter))
> +               return 0;
> +
> +       if (iocb->ki_flags & IOCB_DIRECT &&
> +           !(file->f_mode & FMODE_CAN_ODIRECT))
> +               return -EINVAL;
> +
> +       if (is_sync_kiocb(iocb)) {
> +               rwf_t rwf =3D iocb_to_rw_flags(flags);
> +
> +               file_start_write(file);
> +               ret =3D vfs_iter_write(file, iter, &iocb->ki_pos, rwf);
> +               file_end_write(file);
> +               if (cleanup)
> +                       cleanup(iocb, ret);
> +       } else {
> +               struct backing_aio_req *aio_req;
> +
> +               aio_req =3D kmem_cache_zalloc(backing_aio_req_cachep, GFP=
_KERNEL);
> +               if (!aio_req)
> +                       return -ENOMEM;
> +
> +               aio_req->orig_iocb =3D iocb;
> +               aio_req->cleanup =3D cleanup;
> +               kiocb_clone(&aio_req->iocb, iocb, get_file(file));
> +               aio_req->iocb.ki_flags =3D flags;
> +               aio_req->iocb.ki_complete =3D backing_aio_rw_complete;
> +               refcount_set(&aio_req->ref, 2);
> +               kiocb_start_write(&aio_req->iocb);
> +               ret =3D vfs_iocb_iter_write(file, &aio_req->iocb, iter);
> +               backing_aio_put(aio_req);
> +               if (ret !=3D -EIOCBQUEUED)
> +                       backing_aio_cleanup(aio_req, ret);
> +       }
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(backing_file_write_iter);
> +
> +static int __init backing_aio_init(void)
> +{
> +       backing_aio_req_cachep =3D kmem_cache_create("backing_aio_req",
> +                                          sizeof(struct backing_aio_req)=
,
> +                                          0, SLAB_HWCACHE_ALIGN, NULL);
> +       if (!backing_aio_req_cachep)
> +               return -ENOMEM;
> +
> +       return 0;
> +}
> +fs_initcall(backing_aio_init);
> diff --git a/fs/overlayfs/Kconfig b/fs/overlayfs/Kconfig
> index fec5020c3495..7f52d9031cff 100644
> --- a/fs/overlayfs/Kconfig
> +++ b/fs/overlayfs/Kconfig
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config OVERLAY_FS
>         tristate "Overlay filesystem support"
> +       select FS_BACKING_FILE
>         select EXPORTFS
>         help
>           An overlay filesystem combines two filesystems - an 'upper' fil=
esystem
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index 05ec614f7054..81fe6a85cad9 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -13,16 +13,9 @@
>  #include <linux/security.h>
>  #include <linux/mm.h>
>  #include <linux/fs.h>
> +#include <linux/backing_file.h>
>  #include "overlayfs.h"
>
> -struct ovl_aio_req {
> -       struct kiocb iocb;
> -       refcount_t ref;
> -       struct kiocb *orig_iocb;
> -};
> -
> -static struct kmem_cache *ovl_aio_request_cachep;
> -
>  static char ovl_whatisit(struct inode *inode, struct inode *realinode)
>  {
>         if (realinode !=3D ovl_inode_upper(inode))
> @@ -262,24 +255,8 @@ static void ovl_file_accessed(struct file *file)
>         touch_atime(&file->f_path);
>  }
>
> -#define OVL_IOCB_MASK \
> -       (IOCB_NOWAIT | IOCB_HIPRI | IOCB_DSYNC | IOCB_SYNC | IOCB_APPEND)
> -
> -static rwf_t iocb_to_rw_flags(int flags)
> -{
> -       return (__force rwf_t)(flags & OVL_IOCB_MASK);
> -}
> -
> -static inline void ovl_aio_put(struct ovl_aio_req *aio_req)
> -{
> -       if (refcount_dec_and_test(&aio_req->ref)) {
> -               fput(aio_req->iocb.ki_filp);
> -               kmem_cache_free(ovl_aio_request_cachep, aio_req);
> -       }
> -}
> -
>  /* Completion for submitted/failed sync/async rw io */
> -static void ovl_rw_complete(struct kiocb *orig_iocb)
> +static void ovl_rw_complete(struct kiocb *orig_iocb, long res)
>  {
>         struct file *file =3D orig_iocb->ki_filp;
>
> @@ -292,32 +269,6 @@ static void ovl_rw_complete(struct kiocb *orig_iocb)
>         }
>  }
>
> -/* Completion for submitted/failed async rw io */
> -static void ovl_aio_cleanup(struct ovl_aio_req *aio_req)
> -{
> -       struct kiocb *iocb =3D &aio_req->iocb;
> -       struct kiocb *orig_iocb =3D aio_req->orig_iocb;
> -
> -       if (iocb->ki_flags & IOCB_WRITE)
> -               kiocb_end_write(iocb);
> -
> -       orig_iocb->ki_pos =3D iocb->ki_pos;
> -       ovl_rw_complete(orig_iocb);
> -
> -       ovl_aio_put(aio_req);
> -}
> -
> -/* Completion for submitted async rw io */
> -static void ovl_aio_rw_complete(struct kiocb *iocb, long res)
> -{
> -       struct ovl_aio_req *aio_req =3D container_of(iocb,
> -                                                  struct ovl_aio_req, io=
cb);
> -       struct kiocb *orig_iocb =3D aio_req->orig_iocb;
> -
> -       ovl_aio_cleanup(aio_req);
> -       orig_iocb->ki_complete(orig_iocb, res);
> -}
> -
>  static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>  {
>         struct file *file =3D iocb->ki_filp;
> @@ -332,38 +283,10 @@ static ssize_t ovl_read_iter(struct kiocb *iocb, st=
ruct iov_iter *iter)
>         if (ret)
>                 return ret;
>
> -       ret =3D -EINVAL;
> -       if (iocb->ki_flags & IOCB_DIRECT &&
> -           !(real.file->f_mode & FMODE_CAN_ODIRECT))
> -               goto out_fdput;
> -
>         old_cred =3D ovl_override_creds(file_inode(file)->i_sb);
> -       if (is_sync_kiocb(iocb)) {
> -               rwf_t rwf =3D iocb_to_rw_flags(iocb->ki_flags);
> -
> -               ret =3D vfs_iter_read(real.file, iter, &iocb->ki_pos, rwf=
);
> -               ovl_rw_complete(iocb);
> -       } else {
> -               struct ovl_aio_req *aio_req;
> -
> -               ret =3D -ENOMEM;
> -               aio_req =3D kmem_cache_zalloc(ovl_aio_request_cachep, GFP=
_KERNEL);
> -               if (!aio_req)
> -                       goto out;
> -
> -               real.flags =3D 0;
> -               aio_req->orig_iocb =3D iocb;
> -               kiocb_clone(&aio_req->iocb, iocb, get_file(real.file));
> -               aio_req->iocb.ki_complete =3D ovl_aio_rw_complete;
> -               refcount_set(&aio_req->ref, 2);
> -               ret =3D vfs_iocb_iter_read(real.file, &aio_req->iocb, ite=
r);
> -               ovl_aio_put(aio_req);
> -               if (ret !=3D -EIOCBQUEUED)
> -                       ovl_aio_cleanup(aio_req);
> -       }
> -out:
> +       ret =3D backing_file_read_iter(real.file, iter, iocb, iocb->ki_fl=
ags,
> +                                    ovl_rw_complete);
>         revert_creds(old_cred);
> -out_fdput:
>         fdput(real);
>
>         return ret;
> @@ -392,45 +315,13 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, s=
truct iov_iter *iter)
>         if (ret)
>                 goto out_unlock;
>
> -       ret =3D -EINVAL;
> -       if (iocb->ki_flags & IOCB_DIRECT &&
> -           !(real.file->f_mode & FMODE_CAN_ODIRECT))
> -               goto out_fdput;
> -
>         if (!ovl_should_sync(OVL_FS(inode->i_sb)))
>                 flags &=3D ~(IOCB_DSYNC | IOCB_SYNC);
>
>         old_cred =3D ovl_override_creds(inode->i_sb);
> -       if (is_sync_kiocb(iocb)) {
> -               rwf_t rwf =3D iocb_to_rw_flags(flags);
> -
> -               file_start_write(real.file);
> -               ret =3D vfs_iter_write(real.file, iter, &iocb->ki_pos, rw=
f);
> -               file_end_write(real.file);
> -               ovl_rw_complete(iocb);
> -       } else {
> -               struct ovl_aio_req *aio_req;
> -
> -               ret =3D -ENOMEM;
> -               aio_req =3D kmem_cache_zalloc(ovl_aio_request_cachep, GFP=
_KERNEL);
> -               if (!aio_req)
> -                       goto out;
> -
> -               real.flags =3D 0;
> -               aio_req->orig_iocb =3D iocb;
> -               kiocb_clone(&aio_req->iocb, iocb, get_file(real.file));
> -               aio_req->iocb.ki_flags =3D flags;
> -               aio_req->iocb.ki_complete =3D ovl_aio_rw_complete;
> -               refcount_set(&aio_req->ref, 2);
> -               kiocb_start_write(&aio_req->iocb);
> -               ret =3D vfs_iocb_iter_write(real.file, &aio_req->iocb, it=
er);
> -               ovl_aio_put(aio_req);
> -               if (ret !=3D -EIOCBQUEUED)
> -                       ovl_aio_cleanup(aio_req);
> -       }
> -out:
> +       ret =3D backing_file_write_iter(real.file, iter, iocb, flags,
> +                                     ovl_rw_complete);
>         revert_creds(old_cred);
> -out_fdput:
>         fdput(real);
>
>  out_unlock:
> @@ -742,19 +633,3 @@ const struct file_operations ovl_file_operations =3D=
 {
>         .copy_file_range        =3D ovl_copy_file_range,
>         .remap_file_range       =3D ovl_remap_file_range,
>  };
> -
> -int __init ovl_aio_request_cache_init(void)
> -{
> -       ovl_aio_request_cachep =3D kmem_cache_create("ovl_aio_req",
> -                                                  sizeof(struct ovl_aio_=
req),
> -                                                  0, SLAB_HWCACHE_ALIGN,=
 NULL);
> -       if (!ovl_aio_request_cachep)
> -               return -ENOMEM;
> -
> -       return 0;
> -}
> -
> -void ovl_aio_request_cache_destroy(void)
> -{
> -       kmem_cache_destroy(ovl_aio_request_cachep);
> -}
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 9817b2dcb132..64b98e67e826 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -799,8 +799,6 @@ struct dentry *ovl_create_temp(struct ovl_fs *ofs, st=
ruct dentry *workdir,
>
>  /* file.c */
>  extern const struct file_operations ovl_file_operations;
> -int __init ovl_aio_request_cache_init(void);
> -void ovl_aio_request_cache_destroy(void);
>  int ovl_real_fileattr_get(const struct path *realpath, struct fileattr *=
fa);
>  int ovl_real_fileattr_set(const struct path *realpath, struct fileattr *=
fa);
>  int ovl_fileattr_get(struct dentry *dentry, struct fileattr *fa);
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index def266b5e2a3..8c132467fca1 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -1530,14 +1530,10 @@ static int __init ovl_init(void)
>         if (ovl_inode_cachep =3D=3D NULL)
>                 return -ENOMEM;
>
> -       err =3D ovl_aio_request_cache_init();
> -       if (!err) {
> -               err =3D register_filesystem(&ovl_fs_type);
> -               if (!err)
> -                       return 0;
> +       err =3D register_filesystem(&ovl_fs_type);
> +       if (!err)
> +               return 0;
>
> -               ovl_aio_request_cache_destroy();
> -       }
>         kmem_cache_destroy(ovl_inode_cachep);
>
>         return err;
> @@ -1553,7 +1549,6 @@ static void __exit ovl_exit(void)
>          */
>         rcu_barrier();
>         kmem_cache_destroy(ovl_inode_cachep);
> -       ovl_aio_request_cache_destroy();
>  }
>
>  module_init(ovl_init);
> diff --git a/include/linux/backing_file.h b/include/linux/backing_file.h
> new file mode 100644
> index 000000000000..1428fe7b26bb
> --- /dev/null
> +++ b/include/linux/backing_file.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Common helpers for backing file io.
> + *
> + * Copyright (C) 2023 CTERA Networks.
> + */
> +
> +#ifndef _LINUX_BACKING_FILE_H
> +#define _LINUX_BACKING_FILE_H
> +
> +#include <linux/file.h>
> +#include <linux/uio.h>
> +#include <linux/fs.h>
> +
> +ssize_t backing_file_read_iter(struct file *file, struct iov_iter *iter,
> +                              struct kiocb *iocb, int flags,
> +                              void (*cleanup)(struct kiocb *, long));
> +ssize_t backing_file_write_iter(struct file *file, struct iov_iter *iter=
,
> +                               struct kiocb *iocb, int flags,
> +                               void (*cleanup)(struct kiocb *, long));
> +
> +#endif /* _LINUX_BACKING_FILE_H */
> --
> 2.34.1
>
