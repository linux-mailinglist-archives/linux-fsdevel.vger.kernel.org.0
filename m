Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A5331DB13
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 15:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbhBQOBB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 09:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhBQOA6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 09:00:58 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F61AC061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Feb 2021 06:00:18 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id l192so6606947vsd.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Feb 2021 06:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mUiZCwMmsWsrhaAe2fPZND6ofvBT8klJLiYwu6OuvSQ=;
        b=LLs6QXryF5u6+AxYq5B0es7Kss78Bqzk0m8UEQAEvVpAnHAsldDfCQBM9cpP28ex2m
         SN1XOgbZElUQjqfgDsbCv0xV9gUcWMBDsKFbMq9J/zscqgF73jadReNdIooV1Fw/Ds7H
         BLShsw3Lp77h7PYOPm0Qk0JDpBwXgXj6mWiGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mUiZCwMmsWsrhaAe2fPZND6ofvBT8klJLiYwu6OuvSQ=;
        b=ppG055QvPQwJ4QF6aZPvDw+NbJhy+ovYeCwZwlJNMStAUiBRMu+vbCrFUyndOXRVWS
         UHbo6ShV8ahEc4Q9+BOAYkB3wEyi9el4XJJVmg/WulOGXZSnVMSo5/QQ9zFGwOOHZlqp
         8mfx7hBL3Gp7ryUPZjY7ga9FnKpuub87IE1hKkaNbPaJRqq9b3n9MbLZp+4vsUci7PNb
         kl44AaR+VL79ZhWJplZnhlDPI/fHTGPxd59KD3GkypVEekpAJ0T+DTmqa1kbBNZ7HFYa
         lHrEn7WWGbHKkgoiSVAb6R1NKEGYx/1jnUf2NA23KpWuoPzmX5Wt16CtqHk/SH19QH20
         WTyg==
X-Gm-Message-State: AOAM533lSpgbbsHqI8Vi0hHtxyhkvke+c/xauSxUkwsHcpOqD/mI/MnR
        0wEGI94h4T+dgiw0+QIUkjYDWrs33asQvcyFwl/eag==
X-Google-Smtp-Source: ABdhPJwfb9G2cFPKESqOMZU5xuNw8j8pH4Wm65jNdBkCXp0E5XGfX8vecy+Nu4FxGh06JSFL5+errxq5Hhe2dCMSOi4=
X-Received: by 2002:a67:8844:: with SMTP id k65mr1266666vsd.9.1613570417388;
 Wed, 17 Feb 2021 06:00:17 -0800 (PST)
MIME-Version: 1.0
References: <20210125153057.3623715-1-balsini@android.com> <20210125153057.3623715-6-balsini@android.com>
In-Reply-To: <20210125153057.3623715-6-balsini@android.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 17 Feb 2021 15:00:06 +0100
Message-ID: <CAJfpegtpX93S00LrbChQmC8wc968t5Hd9OFMTrF9g10Hk0E+Zg@mail.gmail.com>
Subject: Re: [PATCH RESEND V12 5/8] fuse: Introduce synchronous read and write
 for passthrough
To:     Alessio Balsini <balsini@android.com>
Cc:     Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Peng Tao <bergwolf@gmail.com>,
        Stefano Duo <duostefano93@gmail.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, wuyan <wu-yan@tcl.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        kernel-team <kernel-team@android.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 25, 2021 at 4:31 PM Alessio Balsini <balsini@android.com> wrote:
>
> All the read and write operations performed on fuse_files which have the
> passthrough feature enabled are forwarded to the associated lower file
> system file via VFS.
>
> Sending the request directly to the lower file system avoids the
> userspace round-trip that, because of possible context switches and
> additional operations might reduce the overall performance, especially
> in those cases where caching doesn't help, for example in reads at
> random offsets.
>
> Verifying if a fuse_file has a lower file system file associated with
> can be done by checking the validity of its passthrough_filp pointer.
> This pointer is not NULL only if passthrough has been successfully
> enabled via the appropriate ioctl().
> When a read/write operation is requested for a FUSE file with
> passthrough enabled, a new equivalent VFS request is generated, which
> instead targets the lower file system file.
> The VFS layer performs additional checks that allow for safer operations
> but may cause the operation to fail if the process accessing the FUSE
> file system does not have access to the lower file system.
>
> This change only implements synchronous requests in passthrough,
> returning an error in the case of asynchronous operations, yet covering
> the majority of the use cases.
>
> Signed-off-by: Alessio Balsini <balsini@android.com>
> ---
>  fs/fuse/file.c        |  8 ++++--
>  fs/fuse/fuse_i.h      |  2 ++
>  fs/fuse/passthrough.c | 57 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 65 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 953f3034c375..cddada1e8bd9 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1581,7 +1581,9 @@ static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>         if (FUSE_IS_DAX(inode))
>                 return fuse_dax_read_iter(iocb, to);
>
> -       if (!(ff->open_flags & FOPEN_DIRECT_IO))
> +       if (ff->passthrough.filp)
> +               return fuse_passthrough_read_iter(iocb, to);
> +       else if (!(ff->open_flags & FOPEN_DIRECT_IO))
>                 return fuse_cache_read_iter(iocb, to);
>         else
>                 return fuse_direct_read_iter(iocb, to);
> @@ -1599,7 +1601,9 @@ static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>         if (FUSE_IS_DAX(inode))
>                 return fuse_dax_write_iter(iocb, from);
>
> -       if (!(ff->open_flags & FOPEN_DIRECT_IO))
> +       if (ff->passthrough.filp)
> +               return fuse_passthrough_write_iter(iocb, from);
> +       else if (!(ff->open_flags & FOPEN_DIRECT_IO))
>                 return fuse_cache_write_iter(iocb, from);
>         else
>                 return fuse_direct_write_iter(iocb, from);
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 8d39f5304a11..c4730d893324 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1239,5 +1239,7 @@ int fuse_passthrough_open(struct fuse_dev *fud,
>  int fuse_passthrough_setup(struct fuse_conn *fc, struct fuse_file *ff,
>                            struct fuse_open_out *openarg);
>  void fuse_passthrough_release(struct fuse_passthrough *passthrough);
> +ssize_t fuse_passthrough_read_iter(struct kiocb *iocb, struct iov_iter *to);
> +ssize_t fuse_passthrough_write_iter(struct kiocb *iocb, struct iov_iter *from);
>
>  #endif /* _FS_FUSE_I_H */
> diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
> index cf993e83803e..d949ca07a83b 100644
> --- a/fs/fuse/passthrough.c
> +++ b/fs/fuse/passthrough.c
> @@ -4,6 +4,63 @@
>
>  #include <linux/fuse.h>
>  #include <linux/idr.h>
> +#include <linux/uio.h>
> +
> +#define PASSTHROUGH_IOCB_MASK                                                  \
> +       (IOCB_APPEND | IOCB_DSYNC | IOCB_HIPRI | IOCB_NOWAIT | IOCB_SYNC)
> +
> +static void fuse_copyattr(struct file *dst_file, struct file *src_file)
> +{
> +       struct inode *dst = file_inode(dst_file);
> +       struct inode *src = file_inode(src_file);
> +
> +       i_size_write(dst, i_size_read(src));
> +}

Hmm, I see why this is done, yet it's contrary to what's been set out
at the beginning: "All the requests other than reads or writes are
still handled by the userspace FUSE daemon."

Maybe just use fuse_write_update_size() instead of copying the size
from the underlying inode.

> +
> +ssize_t fuse_passthrough_read_iter(struct kiocb *iocb_fuse,
> +                                  struct iov_iter *iter)
> +{
> +       ssize_t ret;
> +       struct file *fuse_filp = iocb_fuse->ki_filp;
> +       struct fuse_file *ff = fuse_filp->private_data;
> +       struct file *passthrough_filp = ff->passthrough.filp;
> +
> +       if (!iov_iter_count(iter))
> +               return 0;
> +
> +       ret = vfs_iter_read(passthrough_filp, iter, &iocb_fuse->ki_pos,
> +                           iocb_to_rw_flags(iocb_fuse->ki_flags,
> +                                            PASSTHROUGH_IOCB_MASK));

Please split this line up into:

rwf = ioctb_to_rw_flags(...);
ret = vfs_iter_read(..., rwf);

> +
> +       return ret;
> +}
> +
> +ssize_t fuse_passthrough_write_iter(struct kiocb *iocb_fuse,
> +                                   struct iov_iter *iter)
> +{
> +       ssize_t ret;
> +       struct file *fuse_filp = iocb_fuse->ki_filp;
> +       struct fuse_file *ff = fuse_filp->private_data;
> +       struct inode *fuse_inode = file_inode(fuse_filp);
> +       struct file *passthrough_filp = ff->passthrough.filp;
> +
> +       if (!iov_iter_count(iter))
> +               return 0;
> +
> +       inode_lock(fuse_inode);
> +
> +       file_start_write(passthrough_filp);
> +       ret = vfs_iter_write(passthrough_filp, iter, &iocb_fuse->ki_pos,
> +                            iocb_to_rw_flags(iocb_fuse->ki_flags,
> +                                             PASSTHROUGH_IOCB_MASK));

Same here.

Thanks,
Miklos
