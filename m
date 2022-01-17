Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12F24909AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 14:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbiAQNoS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 08:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233849AbiAQNoR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 08:44:17 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB3DC06161C;
        Mon, 17 Jan 2022 05:44:16 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id y17so19176680qtx.9;
        Mon, 17 Jan 2022 05:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DXdJ1Wu64slVHJ1cuUusc0RVIkVBLrraxvrfe/fkEAc=;
        b=PBYzj9/f5BfD87HuXENKRr4lCmln39PPI1X8u1+hoDdGbYkv02jO+YFPHp4Mm+3Eip
         YMoMJzlDNp2Di5yLDVEpomX688I8CF8YrWTwh3WyW48nXt+dkupEXk+vS1WrdY2Ezc8f
         sDDnY/pEA/l06PIjoFP44G26k7p3F7ZXP1TcNxJTWZQAIB6YmbpBTdQY7cgjrPwnCmey
         I1CGXRWUrQW4FEq9DXOG38Syqe8mtZPSdTP+GbDuIEleY03G0tcwMCG1jlvBSS4taQAP
         r+HKcqKiLccjmsYva346xf2XCNgq6y+T1mKGnTNBqhIZi/FOm26I3IbfQHWcmVnXSOy5
         nomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DXdJ1Wu64slVHJ1cuUusc0RVIkVBLrraxvrfe/fkEAc=;
        b=5lCiswHNRUEg/OSZbAUxVwjOyF2DTFxOutxYlrrylVTAd4t3T6VQzltoEq1sBWECeR
         QTA2lUIX/4zSvh7aSF4zmyzsGnQDSnOdZnztXHtFqmgF5dqTwuSvAXuhAsRo6RX7tOko
         fmGmFVBvhSwFWfWLHTkccji5gN6cQkdO+IsN0kNo+Cp99iuMAodL26683YfA0OTaQWiv
         2fCYRC5wOhz6cNgj6S4SRPHkrFnhKDHdLfy/7tS1KjSsaUOIZSOOqBxl/vNfMT7oMgXx
         zt8vHml8yn5pYZ8pfLzHkRr+Rshfg6cGSocl4l9WqTSUcVilMArFOiIQZ3kVQdfX/qmD
         rmRw==
X-Gm-Message-State: AOAM5310NoCr1Us2//MBoNmpqXdtKuMfTN1QATfQpXtEUw8zf9Mf2g2p
        /zUIuUSoKbebfuClUExDtcE=
X-Google-Smtp-Source: ABdhPJwW56XhB17V4FOfsibHf7gI3R9NsaIBYqJc14q+k44PVnI7Wc10DN080EnTikhRXdOwmTBESA==
X-Received: by 2002:a05:622a:15c9:: with SMTP id d9mr5759731qty.681.1642427056076;
        Mon, 17 Jan 2022 05:44:16 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s1sm9124073qtw.25.2022.01.17.05.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 05:44:15 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: zhang.yunkai@zte.com.cn
To:     mhiramat@kernel.org
Cc:     viro@zeniv.linux.org.uk, keescook@chromium.org,
        samitolvanen@google.com, ojeda@kernel.org, johan@kernel.org,
        bhelgaas@google.com, elver@google.com, masahiroy@kernel.org,
        zhang.yunkai@zte.com.cn, axboe@kernel.dk, vgoyal@redhat.com,
        jack@suse.cz, leon@kernel.org, akpm@linux-foundation.org,
        rppt@kernel.org, linux@rasmusvillemoes.dk,
        palmerdabbelt@google.com, f.fainelli@gmail.com,
        wangkefeng.wang@huawei.com, rostedt@goodmis.org,
        ahalaney@redhat.com, valentin.schneider@arm.com,
        peterz@infradead.org, geert@linux-m68k.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <dong.menglong@zte.com.cn>
Subject: [PATCH v7 1/2] init/main.c: introduce function ramdisk_exec_exist()
Date:   Mon, 17 Jan 2022 13:43:51 +0000
Message-Id: <20220117134352.866706-2-zhang.yunkai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220117134352.866706-1-zhang.yunkai@zte.com.cn>
References: <20220117134352.866706-1-zhang.yunkai@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Zhang Yunkai <zhang.yunkai@zte.com.cn>

Introduce the function ramdisk_exec_exist, which is used to check the
exist of 'ramdisk_execute_command'.

To make path lookup follow the mount on '/', use vfs_path_lookup() in
init_eaccess(), and make the filesystem that mounted on '/' as root
during path lookup.

Reported-by: Menglong Dong <dong.menglong@zte.com.cn>
Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
---
 fs/init.c            | 11 +++++++++--
 include/linux/init.h |  1 +
 init/main.c          |  7 ++++++-
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/init.c b/fs/init.c
index 5c36adaa9b44..166356a1f15f 100644
--- a/fs/init.c
+++ b/fs/init.c
@@ -112,14 +112,21 @@ int __init init_chmod(const char *filename, umode_t mode)
 
 int __init init_eaccess(const char *filename)
 {
-	struct path path;
+	struct path path, root;
 	int error;
 
-	error = kern_path(filename, LOOKUP_FOLLOW, &path);
+	error = kern_path("/", LOOKUP_DOWN, &root);
 	if (error)
 		return error;
+	error = vfs_path_lookup(root.dentry, root.mnt, filename,
+				LOOKUP_FOLLOW, &path);
+	if (error)
+		goto on_err;
 	error = path_permission(&path, MAY_ACCESS);
+
 	path_put(&path);
+on_err:
+	path_put(&root);
 	return error;
 }
 
diff --git a/include/linux/init.h b/include/linux/init.h
index d82b4b2e1d25..889d538b6dfa 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -149,6 +149,7 @@ extern unsigned int reset_devices;
 void setup_arch(char **);
 void prepare_namespace(void);
 void __init init_rootfs(void);
+bool ramdisk_exec_exist(void);
 extern struct file_system_type rootfs_fs_type;
 
 #if defined(CONFIG_STRICT_KERNEL_RWX) || defined(CONFIG_STRICT_MODULE_RWX)
diff --git a/init/main.c b/init/main.c
index bb984ed79de0..ed1c63f4ed87 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1577,6 +1577,11 @@ void __init console_on_rootfs(void)
 	fput(file);
 }
 
+bool __init ramdisk_exec_exist(void)
+{
+	return init_eaccess(ramdisk_execute_command) == 0;
+}
+
 static noinline void __init kernel_init_freeable(void)
 {
 	/* Now the scheduler is fully set up and can do blocking allocations */
@@ -1618,7 +1623,7 @@ static noinline void __init kernel_init_freeable(void)
 	 * check if there is an early userspace init.  If yes, let it do all
 	 * the work
 	 */
-	if (init_eaccess(ramdisk_execute_command) != 0) {
+	if (!ramdisk_exec_exist()) {
 		ramdisk_execute_command = NULL;
 		prepare_namespace();
 	}
-- 
2.25.1

