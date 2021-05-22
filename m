Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7243538D5AB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 May 2021 13:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhEVLeB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 May 2021 07:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbhEVLd7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 May 2021 07:33:59 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BC8C06138B;
        Sat, 22 May 2021 04:32:34 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id k5so12302743pjj.1;
        Sat, 22 May 2021 04:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gMoIjw49tCKmARC8o/h0tKTVKazO9Xt+e5E4aVrjnoU=;
        b=lpYUhON/accv1wjgLICHGnfWXz+WVJwLrO/AFGhsXuWwYNs4uzWCiy7v1MRRVcTDUR
         xmcQrhoABorBzprCWYQePj2zdz4BXUaMBjzqtrhYRVLITJLDRfZnRG57LbIKrfNFVwEm
         CMog2vaf/0SKLlRvnvhlyre3Uz80Er6X+EHkGZhsqjET/UfKkTT/Atk9GylaI8gElwPX
         FUS2Bj8wCMwJ8XIJ7K7hzuir+ZWJJR+/EANtS9MQbhCQQb2qKlCgdFo1cBEJ9oqy4ahm
         7e/g+kKzbc8xXepj8ioNjDdgxAjnS8PHCzE2/8YN8oshQ2mFOpp5WUzLdwxeyZ0umadE
         6bvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gMoIjw49tCKmARC8o/h0tKTVKazO9Xt+e5E4aVrjnoU=;
        b=hzejsMnDK1FVG4dqltRxjYFHLamJ0hLFz3Z9PD52KyzTxf9DPPId3/+rXI0oztFfAd
         hrN3/LGNRZo/GvDsjjac4jmBtSJuvlqEEc5nuzDfSJXKoDY68nsFpkdkPyFl5rMa7Mk9
         aBNl6y8J0P5s5fk+SQmWplBaP7A8N/zWELq0xXcYwFHMAZqhqMl24AKGhtgKii94ngfj
         QLg7HiVyrDGWPMTeVllk8iCLi0rVLpJrag9n1Xv+wm40HrQZs3y50mAb2KHnS/+ekBN8
         ZlQKID/hp+vedL+5X9P0g8GwvkJA6j4wrl6XjGdxqMs4iaER8VFqCKGL8IyL4u6ChTQw
         1rgg==
X-Gm-Message-State: AOAM530Y/nz8nVUlCwSlWUpyqjSXzMkQff6J8nDxWIM7/3o0jZ9yJ2Un
        VAmfzNStoDRKnb8tTwyVtss=
X-Google-Smtp-Source: ABdhPJzzSe4kEagp786h+/BNwmomS0PWOLjti2uAfhYuyUjiWTR3f6VoXUKYpv6TVOqYj67bp/InXg==
X-Received: by 2002:a17:902:b18c:b029:f4:67e6:67af with SMTP id s12-20020a170902b18cb02900f467e667afmr16834162plr.17.1621683154069;
        Sat, 22 May 2021 04:32:34 -0700 (PDT)
Received: from localhost ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id k7sm10675164pjj.46.2021.05.22.04.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 04:32:33 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: dong.menglong@zte.com.cn
To:     mcgrof@kernel.org
Cc:     viro@zeniv.linux.org.uk, keescook@chromium.org,
        samitolvanen@google.com, johan@kernel.org, ojeda@kernel.org,
        jeyu@kernel.org, joe@perches.com, dong.menglong@zte.com.cn,
        masahiroy@kernel.org, jack@suse.cz, axboe@kernel.dk, hare@suse.de,
        gregkh@linuxfoundation.org, tj@kernel.org, song@kernel.org,
        neilb@suse.de, akpm@linux-foundation.org, brho@google.com,
        f.fainelli@gmail.com, wangkefeng.wang@huawei.com, arnd@arndb.de,
        linux@rasmusvillemoes.dk, mhiramat@kernel.org, rostedt@goodmis.org,
        vbabka@suse.cz, glider@google.com, pmladek@suse.com,
        ebiederm@xmission.com, jojing64@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] init/do_mounts.c: fix rootfs_fs_type with ramfs
Date:   Sat, 22 May 2021 19:31:55 +0800
Message-Id: <20210522113155.244796-4-dong.menglong@zte.com.cn>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210522113155.244796-1-dong.menglong@zte.com.cn>
References: <20210522113155.244796-1-dong.menglong@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Menglong Dong <dong.menglong@zte.com.cn>

As for the existence of 'user root' which is introduced in previous
patch, 'rootfs_fs_type', which is used as the root of mount tree,
is not used directly any more. So it make no sense to switch it
between ramfs and tmpfs, just fix it with ramfs to simplify the
code.

Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
---
 fs/namespace.c       |  2 --
 include/linux/init.h |  1 -
 init/do_mounts.c     | 18 +-----------------
 3 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index f63337828e1c..8d2b57938e3a 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -17,7 +17,6 @@
 #include <linux/security.h>
 #include <linux/cred.h>
 #include <linux/idr.h>
-#include <linux/init.h>		/* init_rootfs */
 #include <linux/fs_struct.h>	/* get_fs_root et.al. */
 #include <linux/fsnotify.h>	/* fsnotify_vfsmount_delete */
 #include <linux/file.h>
@@ -4241,7 +4240,6 @@ void __init mnt_init(void)
 	if (!fs_kobj)
 		printk(KERN_WARNING "%s: kobj create error\n", __func__);
 	shmem_init();
-	init_rootfs();
 	init_mount_tree();
 }
 
diff --git a/include/linux/init.h b/include/linux/init.h
index 045ad1650ed1..86bd92bb9550 100644
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
index 943cb58846fb..6d1253f75bb0 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -689,24 +689,8 @@ void __init init_user_rootfs(void)
 	}
 }
 
-static bool is_tmpfs;
-static int rootfs_init_fs_context(struct fs_context *fc)
-{
-	if (IS_ENABLED(CONFIG_TMPFS) && is_tmpfs)
-		return shmem_init_fs_context(fc);
-
-	return ramfs_init_fs_context(fc);
-}
-
 struct file_system_type rootfs_fs_type = {
 	.name		= "rootfs",
-	.init_fs_context = rootfs_init_fs_context,
+	.init_fs_context = ramfs_init_fs_context,
 	.kill_sb	= kill_litter_super,
 };
-
-void __init init_rootfs(void)
-{
-	if (IS_ENABLED(CONFIG_TMPFS) && !saved_root_name[0] &&
-		(!root_fs_names || strstr(root_fs_names, "tmpfs")))
-		is_tmpfs = true;
-}
-- 
2.31.1

