Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D45C31DAFC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 14:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbhBQNxH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 08:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbhBQNxC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 08:53:02 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460B6C061756
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Feb 2021 05:52:21 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id s19so1590143vsa.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Feb 2021 05:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u+NUZmqND6e9uR8Dv61QZBANqr635nV/1yFHKoBJdPc=;
        b=H168oDr6znL1bAzdishVNjYkiWvxyqpqsiOnK+ewzHVgzgedu0DD2TTJs05k3ZbQdI
         qrvJK+fjAB6lDeFFHVi4vJug9Xm9X/OuO/tZmYGfz+L1bUKqdrdHyqmgALamrqq6OV96
         gFpPipanZTrQM5tKNYZyzew6g/eghVCL6JfM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u+NUZmqND6e9uR8Dv61QZBANqr635nV/1yFHKoBJdPc=;
        b=VyxcnCX8ml2SKDAazPG5FZ41ij5dlegvxKbYo/mhGqZuPaJp7XLTKatFHuVguRcAhs
         azXN2n5GXJN8kk2pelM3ZcIrdRTvasEU0NHbOelZ4mR2R3OUHdcBGoE1f/snzwyh7dQG
         wEo4G91eh4pe6d/CC4+tFvsPx7s5z0kFOjkYfo8nEpaU6enGORs+gsJ4UFOsyREVCmuq
         kFq7ZhRILSBnDvPxJfJpIW3K00flV1dXwrRYV2YFMSpyVLONmzI63yup9S8rynt05vFB
         QOvZIoeaA8ethIkLEuifmw+DBF6xs6y+Q72pkC3XfSeA9UdVLDnzcAxeHBraFlLl64mC
         ZLIw==
X-Gm-Message-State: AOAM531nfk65SxyPJt8baYfeVC7R7U/xIYsjgi4DIUENoqrkYkS4e/ms
        Kk39RXBhTsDv1DKNLwiNXB7u9vbb4LQejOfX0S9vHA==
X-Google-Smtp-Source: ABdhPJz9u0lyGaYP1KskqqFNIeeg0qw97AO6urKwRFS3NKbjnyebZPKcWBXmLpBDtOfqDUWPI3M73bKVP8C5RObMj5M=
X-Received: by 2002:a67:a404:: with SMTP id n4mr1250550vse.0.1613569940285;
 Wed, 17 Feb 2021 05:52:20 -0800 (PST)
MIME-Version: 1.0
References: <20210125153057.3623715-1-balsini@android.com> <20210125153057.3623715-5-balsini@android.com>
In-Reply-To: <20210125153057.3623715-5-balsini@android.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 17 Feb 2021 14:52:09 +0100
Message-ID: <CAJfpegvL2kOCkbP9bBL8YD-YMFKiSazD3_wet2-+emFafA6y5A@mail.gmail.com>
Subject: Re: [PATCH RESEND V12 4/8] fuse: Passthrough initialization and release
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
> Implement the FUSE passthrough ioctl that associates the lower
> (passthrough) file system file with the fuse_file.
>
> The file descriptor passed to the ioctl by the FUSE daemon is used to
> access the relative file pointer, that will be copied to the fuse_file
> data structure to consolidate the link between the FUSE and lower file
> system.
>
> To enable the passthrough mode, user space triggers the
> FUSE_DEV_IOC_PASSTHROUGH_OPEN ioctl and, if the call succeeds, receives
> back an identifier that will be used at open/create response time in the
> fuse_open_out field to associate the FUSE file to the lower file system
> file.
> The value returned by the ioctl to user space can be:
> - > 0: success, the identifier can be used as part of an open/create
> reply.
> - <= 0: an error occurred.
> The value 0 represents an error to preserve backward compatibility: the
> fuse_open_out field that is used to pass the passthrough_fh back to the
> kernel uses the same bits that were previously as struct padding, and is
> commonly zero-initialized (e.g., in the libfuse implementation).
> Removing 0 from the correct values fixes the ambiguity between the case
> in which 0 corresponds to a real passthrough_fh, a missing
> implementation of FUSE passthrough or a request for a normal FUSE file,
> simplifying the user space implementation.
>
> For the passthrough mode to be successfully activated, the lower file
> system file must implement both read_iter and write_iter file
> operations. This extra check avoids special pseudo files to be targeted
> for this feature.
> Passthrough comes with another limitation: no further file system
> stacking is allowed for those FUSE file systems using passthrough.
>
> Signed-off-by: Alessio Balsini <balsini@android.com>
> ---
>  fs/fuse/inode.c       |  5 +++
>  fs/fuse/passthrough.c | 87 ++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 90 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index a1104d5abb70..7ebc398fbacb 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1133,6 +1133,11 @@ EXPORT_SYMBOL_GPL(fuse_send_init);
>
>  static int free_fuse_passthrough(int id, void *p, void *data)
>  {
> +       struct fuse_passthrough *passthrough = (struct fuse_passthrough *)p;
> +
> +       fuse_passthrough_release(passthrough);
> +       kfree(p);
> +
>         return 0;
>  }
>
> diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
> index 594060c654f8..cf993e83803e 100644
> --- a/fs/fuse/passthrough.c
> +++ b/fs/fuse/passthrough.c
> @@ -3,19 +3,102 @@
>  #include "fuse_i.h"
>
>  #include <linux/fuse.h>
> +#include <linux/idr.h>
>
>  int fuse_passthrough_open(struct fuse_dev *fud,
>                           struct fuse_passthrough_out *pto)
>  {
> -       return -EINVAL;
> +       int res;
> +       struct file *passthrough_filp;
> +       struct fuse_conn *fc = fud->fc;
> +       struct inode *passthrough_inode;
> +       struct super_block *passthrough_sb;
> +       struct fuse_passthrough *passthrough;
> +
> +       if (!fc->passthrough)
> +               return -EPERM;
> +
> +       /* This field is reserved for future implementation */
> +       if (pto->len != 0)
> +               return -EINVAL;
> +
> +       passthrough_filp = fget(pto->fd);
> +       if (!passthrough_filp) {
> +               pr_err("FUSE: invalid file descriptor for passthrough.\n");
> +               return -EBADF;
> +       }
> +
> +       if (!passthrough_filp->f_op->read_iter ||
> +           !passthrough_filp->f_op->write_iter) {
> +               pr_err("FUSE: passthrough file misses file operations.\n");
> +               res = -EBADF;
> +               goto err_free_file;
> +       }
> +
> +       passthrough_inode = file_inode(passthrough_filp);
> +       passthrough_sb = passthrough_inode->i_sb;
> +       if (passthrough_sb->s_stack_depth >= FILESYSTEM_MAX_STACK_DEPTH) {
> +               pr_err("FUSE: fs stacking depth exceeded for passthrough\n");

No need to print an error to the logs, this can be a perfectly normal
occurrence.  However I'd try to find a more unique error value than
EINVAL so that the fuse server can interpret this as "not your fault,
but can't support passthrough on this file".  E.g. EOPNOTSUPP.


> +               res = -EINVAL;
> +               goto err_free_file;
> +       }
> +
> +       passthrough = kmalloc(sizeof(struct fuse_passthrough), GFP_KERNEL);
> +       if (!passthrough) {
> +               res = -ENOMEM;
> +               goto err_free_file;
> +       }
> +
> +       passthrough->filp = passthrough_filp;
> +
> +       idr_preload(GFP_KERNEL);
> +       spin_lock(&fc->passthrough_req_lock);

Should be okay to use fc->lock, since neither adding nor removing the
passthrough ID should be a heavily used operation, and querying the
mapping is lockless.

Thanks,
Miklos
