Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11ACF3903AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 16:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbhEYORf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 10:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbhEYORa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 10:17:30 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC9DC061574;
        Tue, 25 May 2021 07:15:59 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id i5so22884066pgm.0;
        Tue, 25 May 2021 07:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SuUtFT7bIVivZR5ps0dFd9PsqAyY9zXdI0c6lNEWZ/Q=;
        b=cWgSLD1R917gAZOpogiffvofkdeLhXfBzx+5hzb+UqnvK7FtUp4PnY+3Ll3EgmVBNT
         sVyiBBk/tFdg7+oOeWWm42sQDhKwAWwp11ecTxDKK61GrpJBZL6v5GA+GNoZQoYxVEmA
         4aPwqX1QwrCNkdhCtvZjQcCfb6YKfczcBNK56MAsrzM4McCCoXZhYrdZSSNo+MlriYjQ
         dch7QPTdNQ5Uqi0//WL6k1LXb3mUw0GWYNDkUxDDaOueheQLJbUVhpHhjhNWZx8g6p8a
         mg5COU6q9GRUWk9F9g2EQtNTf3tmEa5KQ050O2C2SKpNCWAiHRwwB9+EF5ccXgbDOZL5
         z61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SuUtFT7bIVivZR5ps0dFd9PsqAyY9zXdI0c6lNEWZ/Q=;
        b=nMSVuwuXXrMGhCT0lqfX+Vh6y5gfolUPuzRZCZmmH5M9uAb0AtrXCZJZUUu0LfIHoQ
         J8uiLh3f3i7W2UrXbip9lFkikHVPre1OsrqKcIkGJX+JEUtRbqJlXKEzYqIvtDQqYgHf
         EUaOQiC4JEPTXO606EQ/MqltrlSDrxSYuMZCHSOXIAh60+kaeJNXEQ/STbUHYCivS+AH
         OHWnxWera/XdWGj/rIXWIHlewAvw7+dtNrrkUJhRgzvuUydKYLl9niWx6wOochZUhAil
         arAGIskJNatYtRjoeNL9f+RVFPfXR32Uotp2I6azIgz7CPmwluTVYKDw7Ix9YCzgX517
         OWIA==
X-Gm-Message-State: AOAM530jH4VrCsDZyHjeGi+rvtb8GqSgHy2qeCh9sodlltTV5lbT6t3C
        YKGJW/i9sStrMjNDkKKOpHU=
X-Google-Smtp-Source: ABdhPJwlXHT/ygDAwnSyyXOqbP4rCUtJ42z7h7gzukjpVvVpJc37jxPThlv3OpxUWgYHQaEQKk/+7A==
X-Received: by 2002:a62:5c1:0:b029:2a9:7589:dd30 with SMTP id 184-20020a6205c10000b02902a97589dd30mr30144626pff.66.1621952159421;
        Tue, 25 May 2021 07:15:59 -0700 (PDT)
Received: from localhost ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id gt23sm12687791pjb.13.2021.05.25.07.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 07:15:59 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: dong.menglong@zte.com.cn
To:     mcgrof@kernel.org, josh@joshtriplett.org
Cc:     viro@zeniv.linux.org.uk, keescook@chromium.org,
        samitolvanen@google.com, ojeda@kernel.org, johan@kernel.org,
        bhelgaas@google.com, masahiroy@kernel.org,
        dong.menglong@zte.com.cn, joe@perches.com, axboe@kernel.dk,
        hare@suse.de, jack@suse.cz, tj@kernel.org,
        gregkh@linuxfoundation.org, song@kernel.org, neilb@suse.de,
        akpm@linux-foundation.org, f.fainelli@gmail.com, arnd@arndb.de,
        linux@rasmusvillemoes.dk, wangkefeng.wang@huawei.com,
        brho@google.com, mhiramat@kernel.org, rostedt@goodmis.org,
        vbabka@suse.cz, glider@google.com, pmladek@suse.com,
        chris@chrisdown.name, ebiederm@xmission.com, jojing64@gmail.com,
        terrelln@fb.com, geert@linux-m68k.org, mingo@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        jeyu@kernel.org
Subject: [PATCH v2 3/3] init/do_mounts.c: fix rootfs_fs_type with ramfs
Date:   Tue, 25 May 2021 22:15:24 +0800
Message-Id: <20210525141524.3995-4-dong.menglong@zte.com.cn>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210525141524.3995-1-dong.menglong@zte.com.cn>
References: <20210525141524.3995-1-dong.menglong@zte.com.cn>
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


