Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 311B627F19C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Sep 2020 20:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgI3Su7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Sep 2020 14:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgI3Su7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Sep 2020 14:50:59 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38508C061755
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2020 11:50:59 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id k78so579207vka.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2020 11:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wmSfumn0oWbMOwz8WPSPk+BKE/F10/vN5718M+CpeNM=;
        b=hH0+us0sRtFEVg0PsQyWSZvQ4iL+djff3KUZxz4imKnBgS7e5010RMX600shlL/VJC
         /w/hAww6D1bbhZbdCn3h3BeZ69Y26sYtdKurWIPWWIhN60O9RXZlVu34DiEWBE58mTQ9
         FOWZgUgOwCZSQyObRXpkt/D7K110F/HOctD9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wmSfumn0oWbMOwz8WPSPk+BKE/F10/vN5718M+CpeNM=;
        b=XJpfvcNiK6HZcbA8Wsz95jh15Pu6knDr/kbU3dn5LRaQBVVGQlUDV0gC5+6aPZKAls
         5NE8cTMoNai/RR4LOvx4qJYJ2ETtPF2yu5y58vPN3oehM/fSiF0emz3jC8U8wYAeYk6u
         BBqx2iahaYwciFgl3wScNnw61fxuj4mg9S3pKM2rMQQ2UP7sCXBya/7MZdj41EGqyEH2
         49Zh/wG13WZ9evB0n39AwTW+Cq+sCA/3E6QACP7FFMnVsldC7fPnEh6sWhdxPdL15sLI
         Z+moK6nar4WaEJKBzb89qEvCCfoHwA+6evoT9xXq9aMxDMVtjJ6VXJr4962I+wdCfZJ1
         8axA==
X-Gm-Message-State: AOAM5320Jg0LywQ51ulRtPFywrPjw+f6AP2Pv5PsPQfxNjc0kFvvxUV/
        quCO239dXyvJNmZ9AI8R3yUEoZNhgABrN1NUj9MMVQ==
X-Google-Smtp-Source: ABdhPJyDxibOsNy6cxlRZP77c/QEsD8f1tOqt9bE+8HZX9EmQDTq3Num5DOIzF+72rNdfpVgS1IdXJERY5+AWjlHNVk=
X-Received: by 2002:a1f:95c4:: with SMTP id x187mr2666792vkd.10.1601491857873;
 Wed, 30 Sep 2020 11:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200924131318.2654747-1-balsini@android.com> <20200924131318.2654747-4-balsini@android.com>
In-Reply-To: <20200924131318.2654747-4-balsini@android.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 30 Sep 2020 20:50:46 +0200
Message-ID: <CAJfpegu=0QtzqSOGi_yd48eL3hgG1Hqf_YO2prWeiHBwwMHZyA@mail.gmail.com>
Subject: Re: [PATCH V9 3/4] fuse: Introduce synchronous read and write for passthrough
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
        Stefano Duo <stefanoduo@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        kernel-team <kernel-team@android.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 24, 2020 at 3:13 PM Alessio Balsini <balsini@android.com> wrote:
>
> All the read and write operations performed on fuse_files which have the
> passthrough feature enabled are forwarded to the associated lower file
> system file via VFS.
>
> Sending the request directly to the lower file system avoids the userspace
> round-trip that, because of possible context switches and additional
> operations might reduce the overall performance, especially in those cases
> where caching doesn't help, for example in reads at random offsets.
>
> Verifying if a fuse_file has a lower file system file associated for
> passthrough can be done by checking the validity of its passthrough_filp
> pointer. This pointer is not NULL only if passthrough has been successfully
> enabled via the appropriate ioctl().
> When a read/write operation is requested for a FUSE file with passthrough
> enabled, a new equivalent VFS request is generated, which instead targets
> the lower file system file.
> The VFS layer performs additional checks that allows for safer operations,
> but may cause the operation to fail if the process accessing the FUSE file
> system does not have access to the lower file system. This often happens in
> passthrough file systems, where the FUSE daemon is responsible for the
> enforcement of the lower file system access policies. In order to preserve
> this behavior, the current process accessing the FUSE file with passthrough
> enabled receives the privileges of the FUSE daemon while performing the
> read/write operation, emulating a behavior used in overlayfs. These
> privileges will be reverted as soon as the IO operation completes. This
> feature does not provide any higher security privileges to those processes
> accessing the FUSE file system with passthrough enabled. This because it is
> still the FUSE daemon responsible for enabling or not the passthrough
> feature at file open time, and should enable the feature only after
> appropriate access policy checks.
>
> This change only implements synchronous requests in passthrough, returning
> an error in the case of ansynchronous operations, yet covering the majority
> of the use cases.
>
> Signed-off-by: Alessio Balsini <balsini@android.com>
> ---
>  fs/fuse/file.c        |  8 +++-
>  fs/fuse/fuse_i.h      |  2 +
>  fs/fuse/passthrough.c | 93 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 101 insertions(+), 2 deletions(-)
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
> index 67bf5919f8d6..b0764ca4c4fd 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1109,5 +1109,7 @@ void fuse_free_conn(struct fuse_conn *fc);
>
>  int fuse_passthrough_setup(struct fuse_req *req, unsigned int fd);
>  void fuse_passthrough_release(struct fuse_file *ff);
> +ssize_t fuse_passthrough_read_iter(struct kiocb *iocb, struct iov_iter *to);
> +ssize_t fuse_passthrough_write_iter(struct kiocb *iocb, struct iov_iter *from);
>
>  #endif /* _FS_FUSE_I_H */
> diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
> index 86ab4eafa7bf..f70c0ef6945b 100644
> --- a/fs/fuse/passthrough.c
> +++ b/fs/fuse/passthrough.c
> @@ -2,6 +2,99 @@
>
>  #include "fuse_i.h"
>
> +#include <linux/uio.h>
> +
> +static void fuse_copyattr(struct file *dst_file, struct file *src_file)
> +{
> +       struct inode *dst = file_inode(dst_file);
> +       struct inode *src = file_inode(src_file);
> +
> +       i_size_write(dst, i_size_read(src));
> +}
> +
> +static rwf_t iocbflags_to_rwf(int ifl)
> +{
> +       rwf_t flags = 0;
> +
> +       if (ifl & IOCB_APPEND)
> +               flags |= RWF_APPEND;
> +       if (ifl & IOCB_DSYNC)
> +               flags |= RWF_DSYNC;
> +       if (ifl & IOCB_HIPRI)
> +               flags |= RWF_HIPRI;
> +       if (ifl & IOCB_NOWAIT)
> +               flags |= RWF_NOWAIT;
> +       if (ifl & IOCB_SYNC)
> +               flags |= RWF_SYNC;
> +
> +       return flags;
> +}
> +
> +static const struct cred *
> +fuse_passthrough_override_creds(const struct file *fuse_filp)
> +{
> +       struct inode *fuse_inode = file_inode(fuse_filp);
> +       struct fuse_conn *fc = fuse_inode->i_sb->s_fs_info;
> +
> +       return override_creds(fc->creator_cred);
> +}
> +
> +ssize_t fuse_passthrough_read_iter(struct kiocb *iocb_fuse,
> +                                  struct iov_iter *iter)
> +{
> +       ssize_t ret;
> +       const struct cred *old_cred;
> +       struct file *fuse_filp = iocb_fuse->ki_filp;
> +       struct fuse_file *ff = fuse_filp->private_data;
> +       struct file *passthrough_filp = ff->passthrough_filp;
> +
> +       if (!iov_iter_count(iter))
> +               return 0;
> +
> +       old_cred = fuse_passthrough_override_creds(fuse_filp);
> +       if (is_sync_kiocb(iocb_fuse)) {
> +               ret = vfs_iter_read(passthrough_filp, iter, &iocb_fuse->ki_pos,
> +                                   iocbflags_to_rwf(iocb_fuse->ki_flags));
> +       } else {
> +               ret = -EIO;
> +       }

Just do vfs_iter_read() unconditionally, instead of returning EIO.
It will work fine, except it won't be async.

Yeah, I know next patch is going to fix this, but still, lets not make
this patch return silly errors.

> +       revert_creds(old_cred);
> +
> +       return ret;
> +}
> +
> +ssize_t fuse_passthrough_write_iter(struct kiocb *iocb_fuse,
> +                                   struct iov_iter *iter)
> +{
> +       ssize_t ret;
> +       const struct cred *old_cred;
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
> +       old_cred = fuse_passthrough_override_creds(fuse_filp);
> +       if (is_sync_kiocb(iocb_fuse)) {
> +               file_start_write(passthrough_filp);
> +               ret = vfs_iter_write(passthrough_filp, iter, &iocb_fuse->ki_pos,
> +                                   iocbflags_to_rwf(iocb_fuse->ki_flags));
> +               file_end_write(passthrough_filp);
> +               if (ret > 0)
> +                       fuse_copyattr(fuse_filp, passthrough_filp);
> +       } else {
> +               ret = -EIO;
> +       }

And the same here.

> +       revert_creds(old_cred);
> +       inode_unlock(fuse_inode);
> +
> +       return ret;
> +}
> +
>  int fuse_passthrough_setup(struct fuse_req *req, unsigned int fd)
>  {
>         int ret;
> --
> 2.28.0.681.g6f77f65b4e-goog
>
