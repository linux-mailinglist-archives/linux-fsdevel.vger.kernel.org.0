Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA94E181AA7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Mar 2020 15:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbgCKOBs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Mar 2020 10:01:48 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42717 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729428AbgCKOBs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Mar 2020 10:01:48 -0400
Received: by mail-wr1-f68.google.com with SMTP id v11so2748856wrm.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2020 07:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=+P7+pJIgh6gd0t13DtDNhTnBHDAH10Yd4Pyahm4lR54=;
        b=iOUsMJPFwYobPXu76nckVIEXev0vW2wwKkvMsyk7fXE21GKHgAqDB0SF4VoTuYZSUx
         PC6R1rsjHwKJnBWnbvHGFnrXm3xzrawBXmS8+qUmG3ujPQWziv14kLjQkr82D88w5N7C
         voNqdkP+bpk0A5J0PBPwmCSj48PuP6f0cD/Fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=+P7+pJIgh6gd0t13DtDNhTnBHDAH10Yd4Pyahm4lR54=;
        b=Y2sANnwbziTXdSKJAoruS46D5hPwBEGRAl9cg+CZw/O9Wbut/lTW9qbpsABlPLT/d5
         96MgamAdYozS5n2sHkFaYVGWdpIx+xUgss8jy6Hj0MeK5Pb2xc+YWQZEi9D2y38Ohv8l
         BDD0dDgpwkD2ZlY3eMtIFU2kDZG07oUv3lhUNJmVHqrYxRKKfJdRKllzZuRWEmvXtwmV
         GoNVSvF2FJEdnigX/B6XVnSItOyk6sN1f+U/7AKzXoVa5laUfa5skq074QW7Gw627Dzq
         ZzIdsdzdr3t2FZv8msRnsE7q2iJxXGLBkwE7bsr/o0ElkaKKT0qvtznEnuFZSeFKlyrO
         JvWA==
X-Gm-Message-State: ANhLgQ0S3li5w0v0XoiFkiEiB6UOAHvKPb4Cy+yM6zRb48dyJwpYb3PS
        VdiMfSDgC/TO7rc0Uu6DHNRXbxpXaC/HDN4iUWipQQ==
X-Google-Smtp-Source: ADFU+vsauYA6xe6B3HcZlg3SOKC1GH/qlO9NdrDS25tcn5h036TwrYu9RpchTcWmvGip4MX11xHU94vZtlYiRTqOLJ8=
X-Received: by 2002:a5d:420c:: with SMTP id n12mr4672779wrq.173.1583935306319;
 Wed, 11 Mar 2020 07:01:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200305193511.28621-1-ignat@cloudflare.com>
In-Reply-To: <20200305193511.28621-1-ignat@cloudflare.com>
From:   Ignat Korchagin <ignat@cloudflare.com>
Date:   Wed, 11 Mar 2020 14:01:35 +0000
Message-ID: <CALrw=nGp-N81=ZQNustvwM-CBcPhPCF7HO+D+B_J74ULD=8hrg@mail.gmail.com>
Subject: Re: [PATCH] mnt: add support for non-rootfs initramfs
To:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Following up on this: is there a way to move this forward somehow or
we're stuck with complex userspace code to achieve the same, like
https://git.kernel.org/pub/scm/libs/klibc/klibc.git/tree/usr/kinit/run-init/runinitlib.c,
but for tmpfs?

Just FYI, here is an example of a fix for a security issue, which is
caused by using chroot vs pivot_root in containers:
https://github.com/opencontainers/runc/commit/28a697cce3e4f905dca700eda81d681a30eef9cd

Alternatively, if the use-case is not generic enough, we could keep
the patch to ourselves - just would appreciate some advice/potential
concerns with this approach which we might have overlooked.

Thanks,
Ignat

On Thu, Mar 5, 2020 at 7:35 PM Ignat Korchagin <ignat@cloudflare.com> wrote:
>
> The main need for this is to support container runtimes on stateless Linux
> system (pivot_root system call from initramfs).
>
> Normally, the task of initramfs is to mount and switch to a "real" root
> filesystem. However, on stateless systems (booting over the network) it is just
> convenient to have your "real" filesystem as initramfs from the start.
>
> This, however, breaks different container runtimes, because they usually use
> pivot_root system call after creating their mount namespace. But pivot_root does
> not work from initramfs, because initramfs runs form rootfs, which is the root
> of the mount tree and can't be unmounted.
>
> One can solve this problem from userspace, but it is much more cumbersome. We
> either have to create a multilayered archive for initramfs, where the outer
> layer creates a tmpfs filesystem and unpacks the inner layer, switches root and
> does not forget to properly cleanup the old rootfs. Or we need to use keepinitrd
> kernel cmdline option, unpack initramfs to rootfs, run a script to create our
> target tmpfs root, unpack the same initramfs there, switch root to it and again
> properly cleanup the old root, thus unpacking the same archive twice and also
> wasting memory, because kernel stores compressed initramfs image indefinitely.
>
> With this change we can ask the kernel (by specifying nonroot_initramfs kernel
> cmdline option) to create a "leaf" tmpfs mount for us and switch root to it
> before the initramfs handling code, so initramfs gets unpacked directly into
> the "leaf" tmpfs with rootfs being empty and no need to clean up anything.
>
> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
> ---
>  fs/namespace.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 85b5f7bea82e..a1ec862e8146 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -3701,6 +3701,49 @@ static void __init init_mount_tree(void)
>         set_fs_root(current->fs, &root);
>  }
>
> +#if IS_ENABLED(CONFIG_TMPFS)
> +static int __initdata nonroot_initramfs;
> +
> +static int __init nonroot_initramfs_param(char *str)
> +{
> +       if (*str)
> +               return 0;
> +       nonroot_initramfs = 1;
> +       return 1;
> +}
> +__setup("nonroot_initramfs", nonroot_initramfs_param);
> +
> +static void __init init_nonroot_initramfs(void)
> +{
> +       int err;
> +
> +       if (!nonroot_initramfs)
> +               return;
> +
> +       err = ksys_mkdir("/root", 0700);
> +       if (err < 0)
> +               goto out;
> +
> +       err = do_mount("tmpfs", "/root", "tmpfs", 0, NULL);
> +       if (err)
> +               goto out;
> +
> +       err = ksys_chdir("/root");
> +       if (err)
> +               goto out;
> +
> +       err = do_mount(".", "/", NULL, MS_MOVE, NULL);
> +       if (err)
> +               goto out;
> +
> +       err = ksys_chroot(".");
> +       if (!err)
> +               return;
> +out:
> +       printk(KERN_WARNING "Failed to create a non-root filesystem for initramfs\n");
> +}
> +#endif /* IS_ENABLED(CONFIG_TMPFS) */
> +
>  void __init mnt_init(void)
>  {
>         int err;
> @@ -3734,6 +3777,10 @@ void __init mnt_init(void)
>         shmem_init();
>         init_rootfs();
>         init_mount_tree();
> +
> +#if IS_ENABLED(CONFIG_TMPFS)
> +       init_nonroot_initramfs();
> +#endif
>  }
>
>  void put_mnt_ns(struct mnt_namespace *ns)
> --
> 2.20.1
>
