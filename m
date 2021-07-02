Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7BC3BA650
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jul 2021 01:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhGBXrT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jul 2021 19:47:19 -0400
Received: from mail1.protonmail.ch ([185.70.40.18]:54613 "EHLO
        mail1.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbhGBXrT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jul 2021 19:47:19 -0400
Date:   Fri, 02 Jul 2021 23:44:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1625269485; bh=KiuoheV+rOeQ0KZx+f54tToH3dfxAD3L6DQcwD8631A=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=kMSyPy1On3N9/xnxVjwdW94ISH3bdhx+cSzuJYpk8rJoYEcZdIqCpUhObRQau9rNQ
         mO+9QRRGJNvlxr0VbJ6g/IiYZeJu/FLkNHlPBCXVAwq/JmT7rlImtfDS3HHB8JfaWH
         9GoY2jIFYQKyRyOIOmfaZyiLOa1n2YzGYxSv9E2TL4ALhy2FenOH8yVYALAVBJTR+w
         Ws5WfCMd1a3/IuHrEk2Djnw/muAADcVOBQcgq8EBzNsP9tfJqGkwDl8laOLKlSXG8b
         0nPQU5pFXRFxQj+bR0gvf1SilQJyb5EMmtJULaVUeq3a18BovDsNwIYk9MMMbTrTbc
         5fCvzF9O6IS8w==
To:     Alexander Viro <viro@zeniv.linux.org.uk>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Joe Perches <joe@perches.com>,
        Alexander Lobakin <alobakin@pm.me>,
        John Wood <john.wood@gmx.com>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, Hannes Reinecke <hare@suse.de>,
        Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: [PATCH] do_mounts: always prefer tmpfs for rootfs when available
Message-ID: <20210702233727.21301-1-alobakin@pm.me>
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

Inspired by the situation from [0].

The roots of choosing tmpfs/ramfs backend for rootfs go far back
in history, and it's unclear at all why it was decided to select
full-blown tmpfs when "root=3D" is not specified and feature-poor
ramfs otherwise.
There are several cases when "root=3D" is not needed at all to work,
and it doesn't break anything or make any [negative] sense. On the
other hand, such separation is rather counter-intuitive and makes
debugging more difficult.
Simply always use tmpfs when it's available -- just like devtmpfs
does [for over a decade].

[0] https://lore.kernel.org/kernel-hardening/20210701234807.50453-1-alobaki=
n@pm.me/

Signed-off-by: Alexander Lobakin <alobakin@pm.me>
---
 fs/namespace.c       |  2 --
 include/linux/init.h |  1 -
 init/do_mounts.c     | 26 +++++++-------------------
 3 files changed, 7 insertions(+), 22 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index ab4174a3c802..310ab44fdbe7 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -17,7 +17,6 @@
 #include <linux/security.h>
 #include <linux/cred.h>
 #include <linux/idr.h>
-#include <linux/init.h>=09=09/* init_rootfs */
 #include <linux/fs_struct.h>=09/* get_fs_root et.al. */
 #include <linux/fsnotify.h>=09/* fsnotify_vfsmount_delete */
 #include <linux/file.h>
@@ -4248,7 +4247,6 @@ void __init mnt_init(void)
 =09if (!fs_kobj)
 =09=09printk(KERN_WARNING "%s: kobj create error\n", __func__);
 =09shmem_init();
-=09init_rootfs();
 =09init_mount_tree();
 }

diff --git a/include/linux/init.h b/include/linux/init.h
index d82b4b2e1d25..10839922a1d3 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -148,7 +148,6 @@ extern unsigned int reset_devices;
 /* used by init/main.c */
 void setup_arch(char **);
 void prepare_namespace(void);
-void __init init_rootfs(void);
 extern struct file_system_type rootfs_fs_type;

 #if defined(CONFIG_STRICT_KERNEL_RWX) || defined(CONFIG_STRICT_MODULE_RWX)
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 74aede860de7..c00b05015a66 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -611,24 +611,12 @@ void __init prepare_namespace(void)
 =09init_chroot(".");
 }

-static bool is_tmpfs;
-static int rootfs_init_fs_context(struct fs_context *fc)
-{
-=09if (IS_ENABLED(CONFIG_TMPFS) && is_tmpfs)
-=09=09return shmem_init_fs_context(fc);
-
-=09return ramfs_init_fs_context(fc);
-}
-
 struct file_system_type rootfs_fs_type =3D {
-=09.name=09=09=3D "rootfs",
-=09.init_fs_context =3D rootfs_init_fs_context,
-=09.kill_sb=09=3D kill_litter_super,
+=09.name=09=09=09=3D "rootfs",
+#ifdef CONFIG_TMPFS
+=09.init_fs_context=09=3D shmem_init_fs_context,
+#else
+=09.init_fs_context=09=3D ramfs_init_fs_context,
+#endif
+=09.kill_sb=09=09=3D kill_litter_super,
 };
-
-void __init init_rootfs(void)
-{
-=09if (IS_ENABLED(CONFIG_TMPFS) && !saved_root_name[0] &&
-=09=09(!root_fs_names || strstr(root_fs_names, "tmpfs")))
-=09=09is_tmpfs =3D true;
-}
--
2.32.0


