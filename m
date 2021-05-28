Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 688A9394450
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 May 2021 16:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236306AbhE1OlH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 May 2021 10:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236324AbhE1OlF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 May 2021 10:41:05 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB539C061574;
        Fri, 28 May 2021 07:39:29 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id g24so2644574pji.4;
        Fri, 28 May 2021 07:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SuUtFT7bIVivZR5ps0dFd9PsqAyY9zXdI0c6lNEWZ/Q=;
        b=AqCOKow8BzXpyBYQA4hALzihVUDWiOfdtUbJquxeuNJYENkj6DwJxuck/KTPsp2X1w
         16peOoVuoqYC+o2gWx0RISCnFAnNqGJr5dFX988+0uqPNfetuQD4RndSStByvWzyWccP
         Cq6//WNjymumiMNjm+3kluX/8mc3q9VWMbUByYSjQ6fzV3prHxcSbVvdwmIUs301i+W7
         6QfZR2iToSqegzgaYxxnWMH4vkgWdbJSg3uMcUktdleaFZLzYJe/oUo2iov3tIA7awAd
         6XEntAOTefUuHk7C1eb3X7GavDVm9K1naBFy9hiLS1x4bM2zcPdU10uJ5+5iTDthB5VV
         +4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SuUtFT7bIVivZR5ps0dFd9PsqAyY9zXdI0c6lNEWZ/Q=;
        b=hLhMHB/ETQGCu5hfuRl/MPBiz+NLmP7c6bgRe00PGfC81KgDk0A0up5ECU5/5v/d+3
         zYUvizQ7O2XALTMqyA2RTmtSeu334aE6MaQlXL08JhOOf3/yihwre8ybu2H7qmG8Q8/s
         APsOO57SVrJXThnHH/axdsK0bmLUycvgVdsvK1k8GuI5CuiSKG0bB/JDpSc3LmvLv/m9
         4veS0qKWbhVMOMFx9lM9J6n6F7mwkEpnxM2dU4yAxaW4s2D7XlHHsBAvkGjcty6bm1gA
         Sl7PsyVOdrj11+afL7rPHT7OdJGVhZCluYtueJxywWFbOQ7ihmsypMXh7IyBfWCucxUC
         eakw==
X-Gm-Message-State: AOAM532dGZ5gKUwKnk+kjvYuKS2llXFO2/8ghMkgREPMIXB09+VyB7C8
        07lxnkfz6e9gjWzDHuhKtso=
X-Google-Smtp-Source: ABdhPJzWoWJHPFMvuHgtoRmHNOGBzNFG8zg4DmL8uNwyIsLlF3X4B9pGHzvPnrrfEe4vZDAhHEW+3A==
X-Received: by 2002:a17:90a:e501:: with SMTP id t1mr4895794pjy.32.1622212769472;
        Fri, 28 May 2021 07:39:29 -0700 (PDT)
Received: from localhost ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id p17sm4778164pjg.54.2021.05.28.07.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 07:39:29 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: dong.menglong@zte.com.cn
To:     mhiramat@kernel.org, mcgrof@kernel.org, josh@joshtriplett.org
Cc:     viro@zeniv.linux.org.uk, keescook@chromium.org,
        samitolvanen@google.com, ojeda@kernel.org, johan@kernel.org,
        jeyu@kernel.org, masahiroy@kernel.org, dong.menglong@zte.com.cn,
        joe@perches.com, axboe@kernel.dk, jack@suse.cz, hare@suse.de,
        tj@kernel.org, gregkh@linuxfoundation.org, song@kernel.org,
        neilb@suse.de, akpm@linux-foundation.org, f.fainelli@gmail.com,
        wangkefeng.wang@huawei.com, arnd@arndb.de,
        linux@rasmusvillemoes.dk, brho@google.com, rostedt@goodmis.org,
        vbabka@suse.cz, pmladek@suse.com, glider@google.com,
        chris@chrisdown.name, jojing64@gmail.com, ebiederm@xmission.com,
        mingo@kernel.org, terrelln@fb.com, geert@linux-m68k.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com
Subject: [PATCH v3 3/3] init/do_mounts.c: fix rootfs_fs_type with ramfs
Date:   Fri, 28 May 2021 22:38:02 +0800
Message-Id: <20210528143802.78635-4-dong.menglong@zte.com.cn>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210528143802.78635-1-dong.menglong@zte.com.cn>
References: <20210528143802.78635-1-dong.menglong@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Menglong Dong <dong.menglong@zte.com.cn>

As for the existence of 'user root' which is introduced in previous
patch, 'rootfs_fs_type', which is used as the root of mount tree,
is not used directly any more. So it make no sense to make it tmpfs
while 'INITRAMFS_USER_ROOT' is enabled.

Make 'rootfs_fs_type' ramfs when 'INITRAMFS_USER_ROOT' enabled.

Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
---
 include/linux/init.h |  5 +++++
 init/do_mounts.c     | 10 +++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/init.h b/include/linux/init.h
index 045ad1650ed1..d65b12fe438c 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -148,7 +148,12 @@ extern unsigned int reset_devices;
 /* used by init/main.c */
 void setup_arch(char **);
 void prepare_namespace(void);
+#ifndef CONFIG_INITRAMFS_USER_ROOT
 void __init init_rootfs(void);
+#else
+static inline void __init init_rootfs(void) { }
+#endif
+
 extern struct file_system_type rootfs_fs_type;
 
 #if defined(CONFIG_STRICT_KERNEL_RWX) || defined(CONFIG_STRICT_MODULE_RWX)
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 2fd168cca480..74f5b0fc8bdf 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -716,7 +716,14 @@ void __init init_user_rootfs(void)
 		}
 	}
 }
-#endif
+
+struct file_system_type rootfs_fs_type = {
+	.name		= "rootfs",
+	.init_fs_context = ramfs_init_fs_context,
+	.kill_sb	= kill_litter_super,
+};
+
+#else
 
 static bool is_tmpfs;
 static int rootfs_init_fs_context(struct fs_context *fc)
@@ -739,3 +746,4 @@ void __init init_rootfs(void)
 		(!root_fs_names || strstr(root_fs_names, "tmpfs")))
 		is_tmpfs = true;
 }
+#endif
-- 
2.32.0.rc0


