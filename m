Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC8931DB19
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 15:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbhBQOF7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 09:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbhBQOF7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 09:05:59 -0500
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02FBC061756
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Feb 2021 06:05:18 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id v66so2886220vkd.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Feb 2021 06:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2BrS0+ssNbJaJ+JUXxaNPnqL/g3xkyb+nz2Bw22EZU0=;
        b=dLLwCciDAgieVeCKNhmfIyOnK4x8JBF1YjzqcE1BwosEwGEJGA+vDKuP8fLkl5ek2Y
         xAx8x1cQFNXOO2JoiBvJsQh46wvYxkT3epAucH35ZYU46ld7TNa+JxCWCh7VfY7QMTME
         gTW1OFVJRd8Kx6fleDGiSQchqTXQnRKKShZUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2BrS0+ssNbJaJ+JUXxaNPnqL/g3xkyb+nz2Bw22EZU0=;
        b=Ci93DUNqp5E9FGLdayIA198MNibMww19usmadhOkTXK4q9+RKz+pd6Ol5G6VmIEwnY
         6DiQG/cDKn37jIXcpBdhM9yjABgcjkoBlZsFz/bPQUaaKmleymeU3xyMpXK3OKqwoSbR
         7CpG2WdahtCQVmzu5eSiXX9YXQw5h2ytSHrYwm9a/FWGGi2rMEmbWvt/Nb6ntxlBZ2gF
         /1ahPjBpvopwv4n/xUPkaKMmL+fp5jvJ2Z3q6EqqWvSmOIP/6crh3Bkl6yrvZPzKYrLL
         3UhlLTI4PlYcYI4SkYBJIrdtWXsd7kmM62lZq99wSfkC+qaJNSxBABRyHCGtpk74Q8O7
         P7pg==
X-Gm-Message-State: AOAM532XSharVwE4KJTrBX1jYio5ZIqORqPKS2QiXsiBewAaMYrZqr7b
        AtACAJwA7cgNCcSEsJLTBLQG2FxCwqcnhd784piCoQ==
X-Google-Smtp-Source: ABdhPJx5hHCDxneRfWzPI9tduXBZmSAklUQN/iesIhOWfiBz1SzpTJTAsc7m83sGdPW2/Zdwe8cSxGKSc05rhrtvdR4=
X-Received: by 2002:a1f:c108:: with SMTP id r8mr14181633vkf.11.1613570717742;
 Wed, 17 Feb 2021 06:05:17 -0800 (PST)
MIME-Version: 1.0
References: <20210125153057.3623715-1-balsini@android.com> <20210125153057.3623715-9-balsini@android.com>
In-Reply-To: <20210125153057.3623715-9-balsini@android.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 17 Feb 2021 15:05:07 +0100
Message-ID: <CAJfpegsphqg=AMDj37cMUobtCHu_-0EiHrEYvHZkE-RphRgWVw@mail.gmail.com>
Subject: Re: [PATCH RESEND V12 8/8] fuse: Introduce passthrough for mmap
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
> Enabling FUSE passthrough for mmap-ed operations not only affects
> performance, but has also been shown as mandatory for the correct
> functioning of FUSE passthrough.
> yanwu noticed [1] that a FUSE file with passthrough enabled may suffer
> data inconsistencies if the same file is also accessed with mmap. What
> happens is that read/write operations are directly applied to the lower
> file system (and its cache), while mmap-ed operations are affecting the
> FUSE cache.
>
> Extend the FUSE passthrough implementation to also handle memory-mapped
> FUSE file, to both fix the cache inconsistencies and extend the
> passthrough performance benefits to mmap-ed operations.
>
> [1] https://lore.kernel.org/lkml/20210119110654.11817-1-wu-yan@tcl.com/
>
> Signed-off-by: Alessio Balsini <balsini@android.com>
> ---
>  fs/fuse/file.c        |  3 +++
>  fs/fuse/fuse_i.h      |  1 +
>  fs/fuse/passthrough.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 45 insertions(+)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index cddada1e8bd9..e3741a94c1f9 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -2370,6 +2370,9 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
>         if (FUSE_IS_DAX(file_inode(file)))
>                 return fuse_dax_mmap(file, vma);
>
> +       if (ff->passthrough.filp)
> +               return fuse_passthrough_mmap(file, vma);
> +
>         if (ff->open_flags & FOPEN_DIRECT_IO) {
>                 /* Can't provide the coherency needed for MAP_SHARED */
>                 if (vma->vm_flags & VM_MAYSHARE)
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 815af1845b16..7b0d65984608 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1244,5 +1244,6 @@ int fuse_passthrough_setup(struct fuse_conn *fc, struct fuse_file *ff,
>  void fuse_passthrough_release(struct fuse_passthrough *passthrough);
>  ssize_t fuse_passthrough_read_iter(struct kiocb *iocb, struct iov_iter *to);
>  ssize_t fuse_passthrough_write_iter(struct kiocb *iocb, struct iov_iter *from);
> +ssize_t fuse_passthrough_mmap(struct file *file, struct vm_area_struct *vma);
>
>  #endif /* _FS_FUSE_I_H */
> diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
> index 24866c5fe7e2..284979f87747 100644
> --- a/fs/fuse/passthrough.c
> +++ b/fs/fuse/passthrough.c
> @@ -135,6 +135,47 @@ ssize_t fuse_passthrough_write_iter(struct kiocb *iocb_fuse,
>         return ret;
>  }
>
> +ssize_t fuse_passthrough_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +       int ret;
> +       const struct cred *old_cred;
> +       struct fuse_file *ff = file->private_data;
> +       struct inode *fuse_inode = file_inode(file);
> +       struct file *passthrough_filp = ff->passthrough.filp;
> +       struct inode *passthrough_inode = file_inode(passthrough_filp);
> +
> +       if (!passthrough_filp->f_op->mmap)
> +               return -ENODEV;
> +
> +       if (WARN_ON(file != vma->vm_file))
> +               return -EIO;
> +
> +       vma->vm_file = get_file(passthrough_filp);
> +
> +       old_cred = override_creds(ff->passthrough.cred);
> +       ret = call_mmap(vma->vm_file, vma);
> +       revert_creds(old_cred);
> +
> +       if (ret)
> +               fput(passthrough_filp);
> +       else
> +               fput(file);
> +
> +       if (file->f_flags & O_NOATIME)
> +               return ret;
> +
> +       if ((!timespec64_equal(&fuse_inode->i_mtime,
> +                              &passthrough_inode->i_mtime) ||
> +            !timespec64_equal(&fuse_inode->i_ctime,
> +                              &passthrough_inode->i_ctime))) {
> +               fuse_inode->i_mtime = passthrough_inode->i_mtime;
> +               fuse_inode->i_ctime = passthrough_inode->i_ctime;

Again, violation of rules.   Not sure why this is needed, mmap(2)
isn't supposed to change mtime or ctime, AFAIK.

Thanks,
Miklos
