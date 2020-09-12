Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52972679A9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Sep 2020 13:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgILLGV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Sep 2020 07:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgILLGP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Sep 2020 07:06:15 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EA9C061573;
        Sat, 12 Sep 2020 04:06:14 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id r25so13832301ioj.0;
        Sat, 12 Sep 2020 04:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wt/BiPlhiIijnCfs5MY8bni1nAXL8ZGQRplqmawDiJw=;
        b=Fns5pJ8dHr9fbV01v6J6KIic9ztxehvvTUv2PP4jS9BV2Vn23ePY7bGsQaJE31zBqq
         obL6MK1BqJkbdTXnzld4/WYe11IMIQlZD+hQ+jL53jSQhWRqegm+3uXsQltWF6NVXaPG
         RMCegmlFyGmLJBolh222AzGmTCjd6U8sCroQcUmHSjyYgBwAdTvATszZPRAulmfIeijO
         HgNV5v2obfs6ausFSE7J6Ao/NUAtN7ao3AynpSOnEB8QfddahxEPdLainURp//WlAPP3
         MAk/Dn+ArmblaNKts9urkWkJzGz1ZNOgm4a2Md56a4tRgkQn65yGV9GQQewJYDWPPdMP
         PQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wt/BiPlhiIijnCfs5MY8bni1nAXL8ZGQRplqmawDiJw=;
        b=bDSrlfkwal/g0DqJrdtu9BO5PPWg0Zn66bxW0BljBOmnxuhSomNmG7+8p7eikH4JMv
         g44lVK2Zp4HHXIYfii/FYYKSVNE58igEFoQV24PvJ+HRzaeeMDb5zxN0qUtax2y00JiG
         AnVWBdCkxTGWa6w92lXbAQ4fU+464N5yaEWnBvQrNb3q5jaEgPGWKZiCCCAslNdCrwDI
         iMKKj6npgEndRel5zFYyV+7FSbBJ1II6XRUytV9f6Gw7nry4MWgOGaGQddzvqlMC+jz+
         bWBajUXC+4+y3xiRZP5RoGdmPJRHbzlkUG/K301QY7ju12yqEbhQk3rWYddpBUKyPxRn
         nbww==
X-Gm-Message-State: AOAM532LXqk++vZsT1DJST2nHizyPbSYqKgz9HlRYYBchRhmao+0jgPe
        J0H1ycXB9QwABpvsYAyP59WzysJNPL0CRWOzlal41wpogKzQUg==
X-Google-Smtp-Source: ABdhPJyIGOjyoDAt31kCPoFRuvy2qtq52QdjfvOdj5kyLn4eBQbJ3C431ebgVGnvmwoGOYeBsUw6DxNIh6c8W/JcPik=
X-Received: by 2002:a02:734f:: with SMTP id a15mr5944005jae.120.1599908773866;
 Sat, 12 Sep 2020 04:06:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200911163403.79505-1-balsini@android.com> <20200911163403.79505-2-balsini@android.com>
In-Reply-To: <20200911163403.79505-2-balsini@android.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 12 Sep 2020 14:06:02 +0300
Message-ID: <CAOQ4uxiWK5dNMkrriApMVZQi6apmnMijcCw5j4fa2thHFdnFcw@mail.gmail.com>
Subject: Re: [PATCH V8 1/3] fuse: Definitions and ioctl() for passthrough
To:     Alessio Balsini <balsini@android.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Akilesh Kailash <akailash@google.com>,
        David Anderson <dvander@google.com>,
        Eric Yan <eric.yan@oneplus.com>, Jann Horn <jannh@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <stefanoduo@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        kernel-team <kernel-team@android.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 11, 2020 at 7:34 PM Alessio Balsini <balsini@android.com> wrote:
>
> Introduce the new FUSE passthrough ioctl(), which allows userspace to
> specify a direct connection between a FUSE file and a lower file system
> file.
> Such ioctl() requires userspace to specify:
> - the file descriptor of one of its opened files,
> - the unique identifier of the FUSE request associated with a pending
>   open/create operation,
> both encapsulated into a fuse_passthrough_out data structure.
> The ioctl() will search for the pending FUSE request matching the unique
> identifier, and update the passthrough file pointer of the request with the
> file pointer referenced by the passed file descriptor.
> When that pending FUSE request is handled, the passthrough file pointer
> is copied to the fuse_file data structure, so that the link between FUSE
> and lower file system is consolidated.
>
> In order for the passthrough mode to be successfully activated, the lower
> file system file must implement both read_ and write_iter file operations.
> This extra check avoids special pseudofiles to be targets for this feature.
> An additional enforced limitation is that when FUSE passthrough is enabled,
> no further file system stacking is allowed.
>
> Signed-off-by: Alessio Balsini <balsini@android.com>
> ---
[...]
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index bba747520e9b..eb223130a917 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -965,6 +965,12 @@ static void process_init_reply(struct fuse_conn *fc, struct fuse_args *args,
>                                         min_t(unsigned int, FUSE_MAX_MAX_PAGES,
>                                         max_t(unsigned int, arg->max_pages, 1));
>                         }
> +                       if (arg->flags & FUSE_PASSTHROUGH) {
> +                               fc->passthrough = 1;
> +                               /* Prevent further stacking */
> +                               fc->sb->s_stack_depth =
> +                                       FILESYSTEM_MAX_STACK_DEPTH;
> +                       }

That seems a bit limiting.
I suppose what you really want to avoid is loops into FUSE fd.
There may be a way to do this with forbidding overlay over FUSE passthrough
or the other way around.

You can set fc->sb->s_stack_depth = FILESYSTEM_MAX_STACK_DEPTH - 1
here and in passthrough ioctl you can check for looping into a fuse fs with
passthrough enabled on the passed fd (see below) ...


>                 } else {
>                         ra_pages = fc->max_read / PAGE_SIZE;
>                         fc->no_lock = 1;
> @@ -1002,7 +1008,8 @@ void fuse_send_init(struct fuse_conn *fc)
>                 FUSE_WRITEBACK_CACHE | FUSE_NO_OPEN_SUPPORT |
>                 FUSE_PARALLEL_DIROPS | FUSE_HANDLE_KILLPRIV | FUSE_POSIX_ACL |
>                 FUSE_ABORT_ERROR | FUSE_MAX_PAGES | FUSE_CACHE_SYMLINKS |
> -               FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA;
> +               FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
> +               FUSE_PASSTHROUGH;
>         ia->args.opcode = FUSE_INIT;
>         ia->args.in_numargs = 1;
>         ia->args.in_args[0].size = sizeof(ia->in);
> diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
> new file mode 100644
> index 000000000000..86ab4eafa7bf
> --- /dev/null
> +++ b/fs/fuse/passthrough.c
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "fuse_i.h"
> +
> +int fuse_passthrough_setup(struct fuse_req *req, unsigned int fd)
> +{
> +       int ret;
> +       int fs_stack_depth;
> +       struct file *passthrough_filp;
> +       struct inode *passthrough_inode;
> +       struct super_block *passthrough_sb;
> +
> +       /* Passthrough mode can only be enabled at file open/create time */
> +       if (req->in.h.opcode != FUSE_OPEN && req->in.h.opcode != FUSE_CREATE) {
> +               pr_err("FUSE: invalid OPCODE for request.\n");
> +               return -EINVAL;
> +       }
> +
> +       passthrough_filp = fget(fd);
> +       if (!passthrough_filp) {
> +               pr_err("FUSE: invalid file descriptor for passthrough.\n");
> +               return -EINVAL;
> +       }
> +
> +       ret = -EINVAL;
> +       if (!passthrough_filp->f_op->read_iter ||
> +           !passthrough_filp->f_op->write_iter) {
> +               pr_err("FUSE: passthrough file misses file operations.\n");
> +               goto out;
> +       }
> +
> +       passthrough_inode = file_inode(passthrough_filp);
> +       passthrough_sb = passthrough_inode->i_sb;
> +       fs_stack_depth = passthrough_sb->s_stack_depth + 1;

... for example:

       if (fs_stack_depth && passthrough_sb->s_type == fuse_fs_type) {
               pr_err("FUSE: stacked passthrough file\n");
               goto out;
       }

But maybe we want to ban passthrough to any lower FUSE at least for start.

> +       ret = -EEXIST;

Why EEXIST? Why not EINVAL?

> +       if (fs_stack_depth > FILESYSTEM_MAX_STACK_DEPTH) {
> +               pr_err("FUSE: maximum fs stacking depth exceeded for passthrough\n");
> +               goto out;
> +       }
> +
> +       req->args->passthrough_filp = passthrough_filp;
> +       return 0;
> +out:
> +       fput(passthrough_filp);
> +       return ret;
> +}
> +

And speaking of overlayfs, I believe you may be able to test your code with
fuse-overlayfs (passthrough to upper files).

This is a project with real users running real workloads who may be
able to provide you with valuable feedback from testing.

Thanks,
Amir.

[1] https://github.com/containers/fuse-overlayfs
