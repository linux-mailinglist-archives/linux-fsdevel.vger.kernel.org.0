Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 169BEAC05A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 21:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387591AbfIFTQS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 15:16:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37678 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbfIFTQS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 15:16:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id i1so7088795wro.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Sep 2019 12:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+aO/6jXNqNXXcS6p9tmtZukCpuO9djKLRLCvoL9fw9w=;
        b=CPEdVtfz1sgH31piL52ESoHaZuSFy/Ud5evLE2wfsAFP4EpHEngY9+aSlwZGLFTGjg
         t7h+LoforL25lp+jxOSpgwqETxQalIQAVRAdcsUXCOUvUxWjqoxYB4oDBLwZk1d//pXb
         AFLDeKck81gDkcR7C3A8rPLsygAnqnBflbA108pvtILpCddM3Yqd47a2oilbkrgJfd9H
         4tNfzPCOoArhAkv2gNbbogOy6Bbp0NtbhZRwPgUOr2m6qdX8jcWnPe8y9tqSl+LpOFtO
         bNAy+w0is8FJXKq3XT0Y7BH7cVJoa3anDwa7+h025PK2DZqIbNiGAJq9K8gO/put5cvL
         75Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+aO/6jXNqNXXcS6p9tmtZukCpuO9djKLRLCvoL9fw9w=;
        b=Tx5s6s3DC7HZ7XQMO9xP9rjuejrsWXK7QM+7LNGsnu8iiW0F8nwXOuqhjYgDOWu1Yv
         AFcyZO3frI2RZTM0UMd/vdL6s0QP0lrjGvKeGaAJPEQJTcq9YzukwZFOlk7VWYWPUDyX
         3bQ5+4TDTX8UEw5xnzQriDssvXb6dIIjYgkZBDNJIeWimHzAxoyqkXv5Y5uku12rFrEd
         qpFA6AA+aUqaNcptJ+hi4JJIAlQRaXW5t4HPKKUcuQlyxVG786wL3Ep98B5p7/ctKgyR
         Gsiththhn8F7AYxiWfNaWdSJQj65Zo4BGAJCgmW83iXyK8By/qp8ClfX111XqZVyAFXJ
         Zu6A==
X-Gm-Message-State: APjAAAW5Vh/OfXXrWEvyTMeeS5kNa0ZVrSNFtbNXXMWYshihECMoa2Yy
        LWmjOXp7Kq+aBRaNxRsCbiS09CmalMtTYznisDI=
X-Google-Smtp-Source: APXvYqxDpronZ22I8bbMJ2eikOWgbq16y8jbR/rEH4AS+PcNYJGuvORbphQy7pVKjwbE0EKn9q/bBp5nBmSuHK9s9lY=
X-Received: by 2002:a5d:4402:: with SMTP id z2mr8163279wrq.183.1567797376132;
 Fri, 06 Sep 2019 12:16:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190906100324.8492-1-stefanha@redhat.com>
In-Reply-To: <20190906100324.8492-1-stefanha@redhat.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Fri, 6 Sep 2019 21:16:04 +0200
Message-ID: <CAFLxGvw-n2VYcYR9kei7Hu2RBhCG9PeWuW7Z+SaiyDQVBRiugw@mail.gmail.com>
Subject: Re: [PATCH] init/do_mounts.c: add virtiofs root fs support
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     virtio-fs@redhat.com, Miklos Szeredi <mszeredi@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 6, 2019 at 1:15 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> Make it possible to boot directly from a virtiofs file system with tag
> 'myfs' using the following kernel parameters:
>
>   rootfstype=virtiofs root=myfs rw
>
> Booting directly from virtiofs makes it possible to use a directory on
> the host as the root file system.  This is convenient for testing and
> situations where manipulating disk image files is cumbersome.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> This patch is based on linux-next (next-20190904) but should apply
> cleanly to other virtiofs trees.
>
>  init/do_mounts.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/init/do_mounts.c b/init/do_mounts.c
> index 9634ecf3743d..030be2f1999a 100644
> --- a/init/do_mounts.c
> +++ b/init/do_mounts.c
> @@ -554,6 +554,16 @@ void __init mount_root(void)
>                         change_floppy("root floppy");
>         }
>  #endif
> +#ifdef CONFIG_VIRTIO_FS
> +       if (root_fs_names && !strcmp(root_fs_names, "virtiofs")) {
> +               if (!do_mount_root(root_device_name, "virtiofs",
> +                                  root_mountflags, root_mount_data))
> +                       return;
> +
> +               panic("VFS: Unable to mount root fs \"%s\" from virtiofs",
> +                     root_device_name);
> +       }
> +#endif

I think you don't need this, you can abuse a hack for mtd/ubi in
prepare_namespace().
At least for 9p it works well:
qemu-system-x86_64 -m 4G -M pc,accel=kvm -nographic -kernel
arch/x86/boot/bzImage -append "rootfstype=9p
rootflags=trans=virtio,version=9p2000.L root=mtdfake console=ttyS0 ro
init=/bin/sh" -virtfs
local,id=rootfs,path=/,security_model=passthrough,mount_tag=mtdfake

If this works too for virtiofs I suggest to cleanup the hack and
generalize it. B-)

-- 
Thanks,
//richard
