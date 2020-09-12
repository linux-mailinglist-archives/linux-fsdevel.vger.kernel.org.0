Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB75526794E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Sep 2020 11:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgILJzy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Sep 2020 05:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbgILJzr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Sep 2020 05:55:47 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2DCC061573;
        Sat, 12 Sep 2020 02:55:47 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id z13so13641328iom.8;
        Sat, 12 Sep 2020 02:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ILnavFmB530NSW4JujeZds8CazYIn/d4/dYZjbkRkws=;
        b=FRHwbJpvgo3N6mnc7f8cvpLJWXPhR2bhczHPdNES4Ao83Ts6mrbYODR/UmblJvQR+4
         5wuOAyZZOol5s9vHvjPglrFqoVfKGsTwYr63D93FKx2IVPOckLQQrB8EfcVx/U+hcTV0
         13GCBI7ECu5WEk4s04LttTcG+6Ygj/cFihJmTmF9kDewX9/+zwvpgunhCbWyWZDu7omS
         wocNW8XUOrecXd4m6jHmFI5lSfHu1le8TbQjisQrnaBZJcvK1xguqwoabyJLuV28ZIcy
         C8DrrdZCYq4oeaXPy/lnNsTla+bnPXFGu7t9+ANeQt6d2M8fFi8VS2FMT3NO87SLVVst
         5JXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ILnavFmB530NSW4JujeZds8CazYIn/d4/dYZjbkRkws=;
        b=aYwhhEeTJmnnigPyuTmXcGq6Rv0uZjsZu5layl6SVW1n+j9EQ1lCBBHNmv62kq4s8T
         foyP2rsrJNuRQuc5svyqssBJf0K2tGTk+eiSQgvxHI/StvP7jf0M7uPfc4ArK0cZTi+r
         5LGNDvPznBcC5fEXAf4QopOowAVYct2HkSWpzwAEa8XVD5g6YIcwIPGNDiLuM4MC9CFd
         +vAbb36dR8jW4k9ffWMLTJowZKoJKKuDQrDde+rUyrkj2WsyilXznWru1X+ZyDQ4h6oG
         5L/DecS5EFVPmVTPphBmvTo3MJRDRWFuQ6Bw3VXsYyv6qjQtvC67qRD5IMCvcSPKGWwN
         LBCQ==
X-Gm-Message-State: AOAM531Ik7tCJnLMEoIiaLfq+Sppu8kYjEwoziqYL52Xi3V/Qwyx4zDK
        D7AysRmigAzoRN7LdT8kfNEjcRyVDAh3lx8ZaCo=
X-Google-Smtp-Source: ABdhPJy9jAcZ3zN9P0k21fcW7dHWGLjh+fn1hWqO7pJNfDPhol0DsCsvCCFwb7pwAfB+uphFd4WkiS5qfoANmvgpvBg=
X-Received: by 2002:a02:76d5:: with SMTP id z204mr5356039jab.93.1599904546328;
 Sat, 12 Sep 2020 02:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200911163403.79505-1-balsini@android.com> <20200911163403.79505-3-balsini@android.com>
In-Reply-To: <20200911163403.79505-3-balsini@android.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 12 Sep 2020 12:55:35 +0300
Message-ID: <CAOQ4uxhxiuZV3LVk=ihqt4S7ktNK=gZcyLh19iZ1+je0fhc3Uw@mail.gmail.com>
Subject: Re: [PATCH V8 2/3] fuse: Introduce synchronous read and write for passthrough
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
> All the read and write operations performed on fuse_files which have the
> passthrough feature enabled are forwarded to the associated lower file
> system file.
>
> Sending the request directly to the lower file system avoids the userspace
> round-trip that, because of possible context switches and additional
> operations might reduce the overall performance, especially in those cases
> where caching doesn't help, for example in reads at random offsets.
>
> If a fuse_file has a lower file system file associated for passthrough can
> be verified by checking the validity of its passthrough_filp pointer, which
> is not null only passthrough has been successfully enabled via the
> appropriate ioctl(). When a read/write operation is requested for a FUSE
> file with passthrough enabled, the request is directly forwarded to the
> corresponding file_operations of the lower file system file. After the
> read/write operation is completed, the file stats change is notified (and
> propagated) to the lower file system.
>
> This change only implements synchronous requests in passthrough, returning
> an error in the case of ansynchronous operations, yet covering the majority
> of the use cases.
>
> Signed-off-by: Alessio Balsini <balsini@android.com>
> ---
>  fs/fuse/file.c        |  8 +++--
>  fs/fuse/fuse_i.h      |  2 ++
>  fs/fuse/passthrough.c | 81 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 89 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 6c0ec742ce74..c3289ff0cd33 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1552,7 +1552,9 @@ static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>         if (is_bad_inode(file_inode(file)))
>                 return -EIO;
>
> -       if (!(ff->open_flags & FOPEN_DIRECT_IO))
> +       if (ff->passthrough_filp)
> +               return fuse_passthrough_read_iter(iocb, to);
> +       else if (!(ff->open_flags & FOPEN_DIRECT_IO))
>                 return fuse_cache_read_iter(iocb, to);
>         else
>                 return fuse_direct_read_iter(iocb, to);
> @@ -1566,7 +1568,9 @@ static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>         if (is_bad_inode(file_inode(file)))
>                 return -EIO;
>
> -       if (!(ff->open_flags & FOPEN_DIRECT_IO))
> +       if (ff->passthrough_filp)
> +               return fuse_passthrough_write_iter(iocb, from);
> +       else if (!(ff->open_flags & FOPEN_DIRECT_IO))
>                 return fuse_cache_write_iter(iocb, from);
>         else
>                 return fuse_direct_write_iter(iocb, from);
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 6c5166447905..21ba30a6a661 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1106,5 +1106,7 @@ void fuse_free_conn(struct fuse_conn *fc);
>
>  int fuse_passthrough_setup(struct fuse_req *req, unsigned int fd);
>  void fuse_passthrough_release(struct fuse_file *ff);
> +ssize_t fuse_passthrough_read_iter(struct kiocb *iocb, struct iov_iter *to);
> +ssize_t fuse_passthrough_write_iter(struct kiocb *iocb, struct iov_iter *from);
>
>  #endif /* _FS_FUSE_I_H */
> diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
> index 86ab4eafa7bf..44a78e02f45d 100644
> --- a/fs/fuse/passthrough.c
> +++ b/fs/fuse/passthrough.c
> @@ -2,6 +2,87 @@
>
>  #include "fuse_i.h"
>
> +#include <linux/fs_stack.h>
> +#include <linux/fsnotify.h>
> +#include <linux/uio.h>
> +
> +static void fuse_copyattr(struct file *dst_file, struct file *src_file,
> +                         bool write)
> +{
> +       if (write) {
> +               struct inode *dst = file_inode(dst_file);
> +               struct inode *src = file_inode(src_file);
> +
> +               fsnotify_modify(src_file);
> +               fsstack_copy_inode_size(dst, src);
> +       } else {
> +               fsnotify_access(src_file);
> +       }
> +}
> +
> +
> +ssize_t fuse_passthrough_read_iter(struct kiocb *iocb_fuse,
> +                                  struct iov_iter *iter)
> +{
> +       ssize_t ret;
> +       struct file *fuse_filp = iocb_fuse->ki_filp;
> +       struct fuse_file *ff = fuse_filp->private_data;
> +       struct file *passthrough_filp = ff->passthrough_filp;
> +
> +       if (!iov_iter_count(iter))
> +               return 0;
> +
> +       if (is_sync_kiocb(iocb_fuse)) {
> +               struct kiocb iocb;
> +
> +               kiocb_clone(&iocb, iocb_fuse, passthrough_filp);
> +               ret = call_read_iter(passthrough_filp, &iocb, iter);
> +               iocb_fuse->ki_pos = iocb.ki_pos;
> +               if (ret >= 0)
> +                       fuse_copyattr(fuse_filp, passthrough_filp, false);
> +
> +       } else {
> +               ret = -EIO;
> +       }
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
> +       struct file *passthrough_filp = ff->passthrough_filp;
> +
> +       if (!iov_iter_count(iter))
> +               return 0;
> +
> +       inode_lock(fuse_inode);
> +
> +       if (is_sync_kiocb(iocb_fuse)) {
> +               struct kiocb iocb;
> +
> +               kiocb_clone(&iocb, iocb_fuse, passthrough_filp);
> +
> +               file_start_write(passthrough_filp);
> +               ret = call_write_iter(passthrough_filp, &iocb, iter);

Why not vfs_iter_write()/vfs_iter_read()?

You are bypassing many internal VFS checks that seem pretty important.

Thanks,
Amir.
