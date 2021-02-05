Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F2D3107D1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 10:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbhBEJ1F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 04:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbhBEJYs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 04:24:48 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52F2C061793;
        Fri,  5 Feb 2021 01:24:07 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id n10so4110648pgl.10;
        Fri, 05 Feb 2021 01:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q2XdoJkLIugwL6PyCTK0JiidlqGVW8dYDvt5+f3iTgo=;
        b=HbEpzL/prLHZw4lsA0c+8XxX5cS+ZWm4/dPyLpy8GWitl401Md5AGB2JzjYrcTEkwL
         5pZ0HXj79jg2ghQPjH3IIp/GY3y2vzaiz7EnF6LZg3scLvN8K9qBb0sT/SxIFZ1vliFm
         jwa8tTekHufDnt7jBbdj3JI34ny6/e4bBJqYkCIs3mrl+ckS/ft7xFwc2bIpY8p8SMz0
         ciIDbw1aNo0YPdOBJAwlyULFn4ZjwKNMZn7gCpf/aP0kIYlpUZFNJnbmZcwJqoSLR2Zn
         iFmk2oXY9KzU+4AMBi+UWpFunMMymDUM5zjay+NK2jy+DATH4crNVAk/dQCjeBmiuw/c
         SnHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q2XdoJkLIugwL6PyCTK0JiidlqGVW8dYDvt5+f3iTgo=;
        b=aAMPxB8tnc6+039fb1QIDw/l7aCrz7+D8NPOd7T9zNq5M47LyNVkEMrUCQGZ8tEse8
         x0qE0iYp/8Zaw90KTok5lXAX5zRyvwjN2Uz6dvXLSJ6qS37DLdmdXNPfVOhZmInXhxwY
         3L5TSxHL+k/+2+iDKzccT31cZ/wLH5Pxq7QWRyNacORXCulyc/cZ8qPixJP/AMnFY1mC
         YFnvfwnS9UpKjspqCF556DemEcPD45tQ1XBphm9qrfTg+syojdy3Qz2UAuTRRdArNZcl
         q+PLDY2y7U7fKV38Gp6oMf9PBiVDuoGC1acn0V2g0eu+v+zM1VdfJR42pzJ7sx06PNxh
         15EQ==
X-Gm-Message-State: AOAM532kVwz9ufCLxQk25dsTZ3oo4c43WUvIBGg+dxD9CKU9e6PXnbt4
        SpefU1zVJj7B44xOK1PfiHtDX/72MukNFe4VTyg=
X-Google-Smtp-Source: ABdhPJx0l70MIZqD5qtN1LAQxR401emhKr9GK5VLLauOP1OVKdj7bASNmX6cF8xvawt83I5j0x3CcDaNZjzFPPhqamM=
X-Received: by 2002:a65:678b:: with SMTP id e11mr3480265pgr.140.1612517047283;
 Fri, 05 Feb 2021 01:24:07 -0800 (PST)
MIME-Version: 1.0
References: <20210125153057.3623715-1-balsini@android.com> <20210125153057.3623715-8-balsini@android.com>
In-Reply-To: <20210125153057.3623715-8-balsini@android.com>
From:   Peng Tao <bergwolf@gmail.com>
Date:   Fri, 5 Feb 2021 17:23:56 +0800
Message-ID: <CA+a=Yy71JUwWwAPEi0Ngn_kt7Gt3KZwJgx_u=CBefJJTE_mYYw@mail.gmail.com>
Subject: Re: [PATCH RESEND V12 7/8] fuse: Use daemon creds in passthrough mode
To:     Alessio Balsini <balsini@android.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <duostefano93@gmail.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, wuyan <wu-yan@tcl.com>,
        fuse-devel@lists.sourceforge.net, kernel-team@android.com,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 25, 2021 at 11:31 PM Alessio Balsini <balsini@android.com> wrote:
>
> When using FUSE passthrough, read/write operations are directly
> forwarded to the lower file system file through VFS, but there is no
> guarantee that the process that is triggering the request has the right
> permissions to access the lower file system. This would cause the
> read/write access to fail.
>
> In passthrough file systems, where the FUSE daemon is responsible for
> the enforcement of the lower file system access policies, often happens
> that the process dealing with the FUSE file system doesn't have access
> to the lower file system.
> Being the FUSE daemon in charge of implementing the FUSE file
> operations, that in the case of read/write operations usually simply
> results in the copy of memory buffers from/to the lower file system
> respectively, these operations are executed with the FUSE daemon
> privileges.
>
> This patch adds a reference to the FUSE daemon credentials, referenced
> at FUSE_DEV_IOC_PASSTHROUGH_OPEN ioctl() time so that they can be used
> to temporarily raise the user credentials when accessing lower file
> system files in passthrough.
> The process accessing the FUSE file with passthrough enabled temporarily
> receives the privileges of the FUSE daemon while performing read/write
> operations. Similar behavior is implemented in overlayfs.
> These privileges will be reverted as soon as the IO operation completes.
> This feature does not provide any higher security privileges to those
> processes accessing the FUSE file system with passthrough enabled. This
> is because it is still the FUSE daemon responsible for enabling or not
> the passthrough feature at file open time, and should enable the feature
> only after appropriate access policy checks.
>
> Signed-off-by: Alessio Balsini <balsini@android.com>
> ---
>  fs/fuse/fuse_i.h      |  5 ++++-
>  fs/fuse/passthrough.c | 11 +++++++++++
>  2 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index c4730d893324..815af1845b16 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -182,10 +182,13 @@ struct fuse_release_args;
>
>  /**
>   * Reference to lower filesystem file for read/write operations handled in
> - * passthrough mode
> + * passthrough mode.
> + * This struct also tracks the credentials to be used for handling read/write
> + * operations.
>   */
>  struct fuse_passthrough {
>         struct file *filp;
> +       struct cred *cred;
>  };
>
>  /** FUSE specific file data */
> diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
> index c7fa1eeb7639..24866c5fe7e2 100644
> --- a/fs/fuse/passthrough.c
> +++ b/fs/fuse/passthrough.c
> @@ -52,6 +52,7 @@ ssize_t fuse_passthrough_read_iter(struct kiocb *iocb_fuse,
>                                    struct iov_iter *iter)
>  {
>         ssize_t ret;
> +       const struct cred *old_cred;
>         struct file *fuse_filp = iocb_fuse->ki_filp;
>         struct fuse_file *ff = fuse_filp->private_data;
>         struct file *passthrough_filp = ff->passthrough.filp;
> @@ -59,6 +60,7 @@ ssize_t fuse_passthrough_read_iter(struct kiocb *iocb_fuse,
>         if (!iov_iter_count(iter))
>                 return 0;
>
> +       old_cred = override_creds(ff->passthrough.cred);
>         if (is_sync_kiocb(iocb_fuse)) {
>                 ret = vfs_iter_read(passthrough_filp, iter, &iocb_fuse->ki_pos,
>                                     iocb_to_rw_flags(iocb_fuse->ki_flags,
> @@ -77,6 +79,7 @@ ssize_t fuse_passthrough_read_iter(struct kiocb *iocb_fuse,
>                 if (ret != -EIOCBQUEUED)
>                         fuse_aio_cleanup_handler(aio_req);
>         }
> +       revert_creds(old_cred);
cred should be reverted when kmalloc() fails above.

Cheers,
Tao
-- 
Into Sth. Rich & Strange
