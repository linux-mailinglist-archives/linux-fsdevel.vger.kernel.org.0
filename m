Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D533E09E7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Aug 2021 23:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbhHDVOZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Aug 2021 17:14:25 -0400
Received: from mail2.protonmail.ch ([185.70.40.22]:20351 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhHDVOY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Aug 2021 17:14:24 -0400
Date:   Wed, 04 Aug 2021 21:14:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1628111649; bh=Sueof2mSbT38YoOrzDTbsGFRl33df6YFmIbjhH9HY7w=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=PlHBv3a0v0d/szrTEloO+kNwIIn0gGL42mRi4BfRFv59VXz4mPTKYgUPSRwK1icaT
         wpUU1Kz9wrDd+Revinzsyw2Gr+EiXvTFqpTC7CoRQDWKT2Jz4kXe/uNv6YJdUFqb7a
         UpiLHfl4SEfk+vw67N8/peMe9dOGa6CQKQKUOF1OqHr+ZAY8ED9EpUmvLFBiCuSlPb
         4KpGNQfOaLSJmn8iS7y3meHLAET6S3UrafvNLPQ7pq/ivP/EStTyiHH/htknUNQ5IN
         vxX2zwU+uAvgH43A8vW1yyPvKdWQo/6VG+HoFWmAUZ9zk3F7dnSHzNXipMP364pael
         FtAFlPGu6cShg==
To:     Alexander Viro <viro@zeniv.linux.org.uk>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     Alexander Lobakin <alobakin@pm.me>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Joe Perches <joe@perches.com>, John Wood <john.wood@gmx.com>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Hannes Reinecke <hare@suse.de>, Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: Re: [PATCH] do_mounts: always prefer tmpfs for rootfs when available
Message-ID: <20210804210627.32421-1-alobakin@pm.me>
In-Reply-To: <20210702233727.21301-1-alobakin@pm.me>
References: <20210702233727.21301-1-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Alexander Lobakin <alobakin@pm.me>
Date: Fri, 02 Jul 2021 23:44:35 +0000

> Inspired by the situation from [0].
>
> The roots of choosing tmpfs/ramfs backend for rootfs go far back
> in history, and it's unclear at all why it was decided to select
> full-blown tmpfs when "root=3D" is not specified and feature-poor
> ramfs otherwise.
> There are several cases when "root=3D" is not needed at all to work,
> and it doesn't break anything or make any [negative] sense. On the
> other hand, such separation is rather counter-intuitive and makes
> debugging more difficult.
> Simply always use tmpfs when it's available -- just like devtmpfs
> does [for over a decade].
>
> [0] https://lore.kernel.org/kernel-hardening/20210701234807.50453-1-aloba=
kin@pm.me/
>
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>

Ping?

> ---
>  fs/namespace.c       |  2 --
>  include/linux/init.h |  1 -
>  init/do_mounts.c     | 26 +++++++-------------------
>  3 files changed, 7 insertions(+), 22 deletions(-)
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index ab4174a3c802..310ab44fdbe7 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -17,7 +17,6 @@
>  #include <linux/security.h>
>  #include <linux/cred.h>
>  #include <linux/idr.h>
> -#include <linux/init.h>=09=09/* init_rootfs */
>  #include <linux/fs_struct.h>=09/* get_fs_root et.al. */
>  #include <linux/fsnotify.h>=09/* fsnotify_vfsmount_delete */
>  #include <linux/file.h>
> @@ -4248,7 +4247,6 @@ void __init mnt_init(void)
>  =09if (!fs_kobj)
>  =09=09printk(KERN_WARNING "%s: kobj create error\n", __func__);
>  =09shmem_init();
> -=09init_rootfs();
>  =09init_mount_tree();
>  }
>
> diff --git a/include/linux/init.h b/include/linux/init.h
> index d82b4b2e1d25..10839922a1d3 100644
> --- a/include/linux/init.h
> +++ b/include/linux/init.h
> @@ -148,7 +148,6 @@ extern unsigned int reset_devices;
>  /* used by init/main.c */
>  void setup_arch(char **);
>  void prepare_namespace(void);
> -void __init init_rootfs(void);
>  extern struct file_system_type rootfs_fs_type;
>
>  #if defined(CONFIG_STRICT_KERNEL_RWX) || defined(CONFIG_STRICT_MODULE_RW=
X)
> diff --git a/init/do_mounts.c b/init/do_mounts.c
> index 74aede860de7..c00b05015a66 100644
> --- a/init/do_mounts.c
> +++ b/init/do_mounts.c
> @@ -611,24 +611,12 @@ void __init prepare_namespace(void)
>  =09init_chroot(".");
>  }
>
> -static bool is_tmpfs;
> -static int rootfs_init_fs_context(struct fs_context *fc)
> -{
> -=09if (IS_ENABLED(CONFIG_TMPFS) && is_tmpfs)
> -=09=09return shmem_init_fs_context(fc);
> -
> -=09return ramfs_init_fs_context(fc);
> -}
> -
>  struct file_system_type rootfs_fs_type =3D {
> -=09.name=09=09=3D "rootfs",
> -=09.init_fs_context =3D rootfs_init_fs_context,
> -=09.kill_sb=09=3D kill_litter_super,
> +=09.name=09=09=09=3D "rootfs",
> +#ifdef CONFIG_TMPFS
> +=09.init_fs_context=09=3D shmem_init_fs_context,
> +#else
> +=09.init_fs_context=09=3D ramfs_init_fs_context,
> +#endif
> +=09.kill_sb=09=09=3D kill_litter_super,
>  };
> -
> -void __init init_rootfs(void)
> -{
> -=09if (IS_ENABLED(CONFIG_TMPFS) && !saved_root_name[0] &&
> -=09=09(!root_fs_names || strstr(root_fs_names, "tmpfs")))
> -=09=09is_tmpfs =3D true;
> -}
> --
> 2.32.0

Thanks,
Al

