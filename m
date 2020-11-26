Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6339A2C55C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 14:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390434AbgKZNdr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 08:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390431AbgKZNdq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:33:46 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B56C0617A7;
        Thu, 26 Nov 2020 05:33:46 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id x15so1164177pll.2;
        Thu, 26 Nov 2020 05:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lFqwseqjUdPHrT4EG6Wlq8LJBCMEaHP4XDjdijKJGlc=;
        b=HLDHVCRn7nXHzLWPEsCTQm0oacQ+FrI7yeyvocy+iLJ8XvEgfQ8pHutLqjiKa9VVVU
         h9hVvQZDMIEZCsoqcdRB9hTjvHw8BUtiWln0F+q8x7Gz4SkisFNLah7PVJFN44xIuTo2
         6IHpQzrB3L+MjzS5JeMJ/+YBpGW3kLpgvgz73elL3zvNHQS7H7JWXVphKNofsbNEFOfd
         1KC5+qXtqcie+H3aEu0SnNy0me5s6MyKYFDQmsPkorWntkeuPhy3ofYCnsUDBm0oeuqQ
         fxbCCAGquk+lfUss67dbaoGVqo1UDl9xBQ4j9QJJ9TakTg3cxHl7DLlvoolO7ofrLZjD
         M5Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lFqwseqjUdPHrT4EG6Wlq8LJBCMEaHP4XDjdijKJGlc=;
        b=qYtF7WKd2Gd0PAv4TlZmaKaLXgf7CzR4TlNiqMm2mbDOuYR2bTeirqc9iAzapB/i+r
         Alj7Pqt0qAkSUneFGgF+oNRcZZ1fydp/YoE8V3GVhJMAQKyjG4EHaqrBVxlXfG3u/sNU
         u+zPsgI/z8Q5nk127fh1UBG1Qbb/0GPyk8NqHylfvvSGzMQiflhA+jo3dZOAZa5uFFBZ
         UVeTK38d7BI5MtyatqWPU/i2niLuORlbXqcxvhXQP6PoX5fycoSx9Qii8FqNA848i4DR
         AAAZKxk6ljgK5dhI0H2jdQN7M+2K5GNxgfbIGxfEM4bizqnJtSV5/iDXDQdkP9SYDnTQ
         j8YQ==
X-Gm-Message-State: AOAM532YAb6y0K6nKguchL860QDvUcM9GMAakcAf8Chz2HkjgWOccgjo
        7RQSlkZJsH6hSEbSqXqzDf+BND8mg+CytSmNZKup6FMy9EwWfg==
X-Google-Smtp-Source: ABdhPJy4UYV9iR7zL6Oio11y665Er2PnqftzQKLkdvHfefSG1EqAPUZY6aP67ann4c6y4V4n3hBRO4CT/o/fSQvk/SA=
X-Received: by 2002:a17:902:7201:b029:d7:c439:b36f with SMTP id
 ba1-20020a1709027201b02900d7c439b36fmr2770558plb.26.1606397625580; Thu, 26
 Nov 2020 05:33:45 -0800 (PST)
MIME-Version: 1.0
References: <20201026125016.1905945-1-balsini@android.com> <20201026125016.1905945-3-balsini@android.com>
In-Reply-To: <20201026125016.1905945-3-balsini@android.com>
From:   Peng Tao <bergwolf@gmail.com>
Date:   Thu, 26 Nov 2020 21:33:34 +0800
Message-ID: <CA+a=Yy4bhC-432h8shxbsrY5vjTcRZopS-Ojo0924L49+Be3Cg@mail.gmail.com>
Subject: Re: [PATCH V10 2/5] fuse: Passthrough initialization and release
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
        Zimuzo Ezeozue <zezeozue@google.com>,
        fuse-devel@lists.sourceforge.net, kernel-team@android.com,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 27, 2020 at 12:19 AM Alessio Balsini <balsini@android.com> wrote:
>
> Implement the FUSE passthrough ioctl() that associates the lower
> (passthrough) file system file with the fuse_file.
>
> The file descriptor passed to the ioctl() by the FUSE daemon is used to
> access the relative file pointer, that will be copied to the fuse_file data
> structure to consolidate the link between the FUSE and lower file system.
>
> To enable the passthrough mode, userspace triggers the
> FUSE_DEV_IOC_PASSTHROUGH_OPEN ioctl() and, if the call succeeds,
> receives back an identifier that will be used at open/create response
> time in the fuse_open_out field to associate the FUSE file to the lower
> file system file.
> The value returned by the ioctl() to userspace can be:
> - > 0: success, the identifier can be used as part of an open/create
>   reply.
> - < 0: an error occurred.
> The value 0 has been left unused for backward compatibility: the
> fuse_open_out field that is used to pass the passthrough_fh back to the
> kernel uses the same bits that were previously as struct padding,
> zero-initialized in the common libfuse implementation. Removing the 0
> value fixes the ambiguity between the case in which 0 corresponds to a
> real passthrough_fh or a missing implementation, simplifying the
> userspace implementation.
>
> For the passthrough mode to be successfully activated, the lower file
> system file must implement both read_ and write_iter file operations.
> This extra check avoids special pseudo files to be targeted for this
> feature.
> Passthrough comes with another limitation: no further file system stacking
> is allowed for those FUSE file systems using passthrough.
>
> Signed-off-by: Alessio Balsini <balsini@android.com>
> ---
>  fs/fuse/inode.c       |  5 +++
>  fs/fuse/passthrough.c | 80 +++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 83 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 6738dd5ff5d2..1e94c54d1455 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1034,6 +1034,11 @@ EXPORT_SYMBOL_GPL(fuse_send_init);
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
> index 594060c654f8..a135c955cc33 100644
> --- a/fs/fuse/passthrough.c
> +++ b/fs/fuse/passthrough.c
> @@ -3,19 +3,95 @@
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
> +               return -EBADF;
> +       }
> +
> +       passthrough = kmalloc(sizeof(struct fuse_passthrough), GFP_KERNEL);
> +       if (!passthrough)
> +               return -ENOMEM;
> +
> +       passthrough->filp = passthrough_filp;
> +
> +       idr_preload(GFP_KERNEL);
> +       spin_lock(&fc->passthrough_req_lock);
> +       res = idr_alloc(&fc->passthrough_req, passthrough, 1, 0, GFP_ATOMIC);
> +       spin_unlock(&fc->passthrough_req_lock);
> +       idr_preload_end();
> +       if (res <= 0) {
> +               fuse_passthrough_release(passthrough);
> +               kfree(passthrough);
> +       }
> +
> +       return res;
>  }
>
>  int fuse_passthrough_setup(struct fuse_conn *fc, struct fuse_file *ff,
>                            struct fuse_open_out *openarg)
>  {
> -       return -EINVAL;
> +       struct inode *passthrough_inode;
> +       struct super_block *passthrough_sb;
> +       struct fuse_passthrough *passthrough;
> +       int passthrough_fh = openarg->passthrough_fh;
> +
> +       if (!fc->passthrough)
> +               return -EPERM;
> +
> +       /* Default case, passthrough is not requested */
> +       if (passthrough_fh <= 0)
> +               return -EINVAL;
> +
> +       spin_lock(&fc->passthrough_req_lock);
> +       passthrough = idr_remove(&fc->passthrough_req, passthrough_fh);
> +       spin_unlock(&fc->passthrough_req_lock);
> +
> +       if (!passthrough)
> +               return -EINVAL;
> +
> +       passthrough_inode = file_inode(passthrough->filp);
> +       passthrough_sb = passthrough_inode->i_sb;
> +       if (passthrough_sb->s_stack_depth >= FILESYSTEM_MAX_STACK_DEPTH) {
Hi Alessio,

passthrough_sb is the underlying filesystem superblock, right? It
seems to prevent fuse passthrough fs from stacking on another fully
stacked file system, instead of preventing other file systems from
stacking on this fuse passthrough file system. Am I misunderstanding
it?

Cheers,
Tao
--
Into Sth. Rich & Strange
