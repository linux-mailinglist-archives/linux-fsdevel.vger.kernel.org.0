Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC86939B8C6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jun 2021 14:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhFDMLV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Jun 2021 08:11:21 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35348 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhFDMLU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Jun 2021 08:11:20 -0400
Received: by mail-pl1-f194.google.com with SMTP id t21so4540501plo.2;
        Fri, 04 Jun 2021 05:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J2w6lJ9tyDoN4RErHRLN3HQrQm0J0xbweYwEB9vLpvA=;
        b=Lsy4uh3Tj7+c4AMJMbBMexS7jebkB9tckr2Pj162LLIcKXnwhqWziJ1U9/5ELhUgNA
         G2HF9zrbsDM1M3DGV3KXYe4wAb7izwYLmqxEuC9DaI10pnmRknfYbWcxE3x4eHbi4l7g
         bO5yqVOvor3rBX6b17YEPgg/XdoVx8tkxt7Gal9cf7JW0ppx4/DYRMti1Oe+fLQCdO9/
         XlFKrpNw8MbMhqrWxU6QhKTiSXdP9Uj9QwsixKZpSFZaBt3yKLeGwm073/daNqT1I7e9
         vNKUqmvPixZHwdR0jzKoOQauQuffCRkHB7BYcfqF9dFjRXby4ZGadCIkZ0VuqiwexTDy
         eNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J2w6lJ9tyDoN4RErHRLN3HQrQm0J0xbweYwEB9vLpvA=;
        b=jpjRC3LTKU03qck+i6Ds19CBE94dMVP+GYwnN16GuuW6KW1y8opaeH4AxQCqqtq0h1
         NxB8Y27+323npZH5PFSJ3CrfoKjVFhCXv003Q/VS6I7KziyvQgVM1+R7e8IUYNXyj6rh
         Wp2QVHPfg61Jyn/VB9fZ8Hp7jMBsnTh0VDUM33SecjivW82tHXeNuutCEYqDOVQqSIax
         F55gi2V6M9RQ6gayBOsYJNPBhULoX+vlVKC/j9EyR8xti2bnLNtz22kOm5wCEOffJ5DQ
         9zvcdXh/Bq5lEtIH3Aiv9zZ4Quj3Fp6XowY2Z+QF1pAwHzQcpKqNK4gQlB55tlwuGmUH
         WbdQ==
X-Gm-Message-State: AOAM530wRYbwBoTeIhuyG7bI6YEBZiTjygBNDRHQ9nTqYSLiIosZdQdf
        UMyKEocvWiN/LdqWhzF0/E0=
X-Google-Smtp-Source: ABdhPJwu7XEb6rkERKCVxgcVdP/J1dvfMCjrwAfv1s5I6dRvlE/zWbytlSecTkQod3HbH4MkNrjFTw==
X-Received: by 2002:a17:90a:9a4:: with SMTP id 33mr16684938pjo.180.1622808502459;
        Fri, 04 Jun 2021 05:08:22 -0700 (PDT)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id ev11sm4779146pjb.36.2021.06.04.05.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 05:08:22 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: dong.menglong@zte.com.cn
To:     christian.brauner@ubuntu.com
Cc:     viro@zeniv.linux.org.uk, keescook@chromium.org,
        samitolvanen@google.com, ojeda@kernel.org, johan@kernel.org,
        elver@google.com, masahiroy@kernel.org, dong.menglong@zte.com.cn,
        joe@perches.com, axboe@kernel.dk, hare@suse.de, jack@suse.cz,
        gregkh@linuxfoundation.org, tj@kernel.org, song@kernel.org,
        neilb@suse.de, akpm@linux-foundation.org, f.fainelli@gmail.com,
        arnd@arndb.de, palmerdabbelt@google.com,
        wangkefeng.wang@huawei.com, linux@rasmusvillemoes.dk,
        brho@google.com, mhiramat@kernel.org, rostedt@goodmis.org,
        vbabka@suse.cz, pmladek@suse.com, glider@google.com,
        chris@chrisdown.name, ebiederm@xmission.com, jojing64@gmail.com,
        geert@linux-m68k.org, mingo@kernel.org, terrelln@fb.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org, jeyu@kernel.org, bhelgaas@google.com,
        josh@joshtriplett.org
Subject: [PATCH v5 3/3] init/do_mounts.c: fix rootfs_fs_type with ramfs
Date:   Fri,  4 Jun 2021 05:07:27 -0700
Message-Id: <20210604120727.58410-4-dong.menglong@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210604120727.58410-1-dong.menglong@zte.com.cn>
References: <20210604120727.58410-1-dong.menglong@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Menglong Dong <dong.menglong@zte.com.cn>

As for the existence of second mount which is introduced in previous
patch, 'rootfs_fs_type', which is used as the root of mount tree, is
not used directly any more. So it make no sense to make it tmpfs
while 'CONFIG_INITRAMFS_MOUNT' is enabled.

Make 'rootfs_fs_type' ramfs when 'CONFIG_INITRAMFS_MOUNT' enabled.

Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
---
 include/linux/init.h |  4 ++++
 init/do_mounts.c     | 16 ++++++++++------
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/linux/init.h b/include/linux/init.h
index 889d538b6dfa..2309c066c383 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -148,7 +148,11 @@ extern unsigned int reset_devices;
 /* used by init/main.c */
 void setup_arch(char **);
 void prepare_namespace(void);
+#ifndef CONFIG_INITRAMFS_MOUNT
 void __init init_rootfs(void);
+#else
+static inline void __init init_rootfs(void) { }
+#endif
 bool ramdisk_exec_exist(void);
 extern struct file_system_type rootfs_fs_type;
 
diff --git a/init/do_mounts.c b/init/do_mounts.c
index ec914552d5bb..240192894892 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -660,7 +660,10 @@ void __init finish_mount_rootfs(void)
 	else
 		revert_mount_rootfs();
 }
-#endif
+
+#define rootfs_init_fs_context ramfs_init_fs_context
+
+#else
 
 static bool is_tmpfs;
 static int rootfs_init_fs_context(struct fs_context *fc)
@@ -671,13 +674,14 @@ static int rootfs_init_fs_context(struct fs_context *fc)
 	return ramfs_init_fs_context(fc);
 }
 
+void __init init_rootfs(void)
+{
+	is_tmpfs = is_tmpfs_enabled();
+}
+#endif
+
 struct file_system_type rootfs_fs_type = {
 	.name		= "rootfs",
 	.init_fs_context = rootfs_init_fs_context,
 	.kill_sb	= kill_litter_super,
 };
-
-void __init init_rootfs(void)
-{
-	is_tmpfs = is_tmpfs_enabled();
-}
-- 
2.32.0.rc0

