Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 322FE398D66
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jun 2021 16:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhFBOtD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 10:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbhFBOs5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 10:48:57 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BCBC06174A;
        Wed,  2 Jun 2021 07:47:01 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id c12so2388046pfl.3;
        Wed, 02 Jun 2021 07:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=66dg2aaZ9e2L3aFdWXYXkm2XrdcrMJS707lfJTzmtCY=;
        b=Mqm69tREmOki7zGalgEIFUx2JAWB7ku+FVd6VwEfrNyjvY3OBTEUhCALe/iIK6ycbP
         Om0+U0LVW60E4MNdLhb0bMd0soDzIEUpePiHLM6eiWCOPA+Ru308BjF45yw0/ognn1zo
         om+nYMQj0lLxoIuNEC6WYoKJtzuHjQbFBIvXLHX2o5V7L9Oct4wbGsDIv4icVeAxCSrd
         bePY4onuLJQCP3q1iOAUO2aR1YoBmoE3ADz7f0LjbqJoAJqhC6/5I7ehGsRKQIApsCaO
         b7UZJyu9IBnpE1VuuMfQltiwSVrgNzJ8F3yaIEBHzbOO8e04ttXPA2VwymjDEadF0mva
         CELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=66dg2aaZ9e2L3aFdWXYXkm2XrdcrMJS707lfJTzmtCY=;
        b=L44A+Py6xaHkIiXZW2BybbY1Dp+Z6DD6vlAqqDP4DMi2z0IcpLXottHetjM6KUn93Q
         G4cDBP6iBQl0whRirmVXlynBI7h5J1gkIKNbJcmMCIrlbr0WJMGtFrcBmqbHItiQQaE3
         ifyxVOV3bmLceFQkuHPsBCUoW2wq5urDOlkxBfcBPrXJbjXzjfKpdnORB3t12nEzcbJb
         a9CLN8ba1yFbRL37ZtXHvWRX2BCdwkIV7Lc1smUsVTZVYHVLKVybqGzJhSciUqxJD1qh
         LtOWMjU0c1ewWjw0vfHARZ22rbV2MlPkx8QYc7E+5JN83AwXnXdyFNcUkmt+DAHJMFuj
         0Zbw==
X-Gm-Message-State: AOAM533Zt5+8VW3zgOUz1ZTO2kKwlNoGbyP4cL3ijzEcTGfVwCVr3K8j
        TAsp9u6CQBDIPc5G0/4yhzA=
X-Google-Smtp-Source: ABdhPJypFWUKSRsDE8InvyvidioBQ9s3o0i03nMnzQqtC5R2RgsJx6mY2ECBN+A50r6eR8YockyYlg==
X-Received: by 2002:a65:6487:: with SMTP id e7mr5892054pgv.27.1622645221196;
        Wed, 02 Jun 2021 07:47:01 -0700 (PDT)
Received: from localhost ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id q24sm72235pgb.19.2021.06.02.07.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 07:47:00 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: dong.menglong@zte.com.cn
To:     christian.brauner@ubuntu.com
Cc:     viro@zeniv.linux.org.uk, keescook@chromium.org,
        samitolvanen@google.com, johan@kernel.org, ojeda@kernel.org,
        akpm@linux-foundation.org, dong.menglong@zte.com.cn,
        masahiroy@kernel.org, joe@perches.com, hare@suse.de,
        axboe@kernel.dk, jack@suse.cz, tj@kernel.org,
        gregkh@linuxfoundation.org, song@kernel.org, neilb@suse.de,
        brho@google.com, mcgrof@kernel.org, palmerdabbelt@google.com,
        arnd@arndb.de, f.fainelli@gmail.com, linux@rasmusvillemoes.dk,
        wangkefeng.wang@huawei.com, mhiramat@kernel.org,
        rostedt@goodmis.org, vbabka@suse.cz, pmladek@suse.com,
        glider@google.com, chris@chrisdown.name, ebiederm@xmission.com,
        jojing64@gmail.com, mingo@kernel.org, terrelln@fb.com,
        geert@linux-m68k.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, jeyu@kernel.org, bhelgaas@google.com,
        josh@joshtriplett.org
Subject: [PATCH v4 1/3] init/main.c: introduce function ramdisk_exec_exist()
Date:   Wed,  2 Jun 2021 22:46:28 +0800
Message-Id: <20210602144630.161982-2-dong.menglong@zte.com.cn>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210602144630.161982-1-dong.menglong@zte.com.cn>
References: <20210602144630.161982-1-dong.menglong@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Menglong Dong <dong.menglong@zte.com.cn>

Introduce the function ramdisk_exec_exist, which is used to check the
exist of 'ramdisk_execute_command'.

To make path lookup follow the mount on '/', use vfs_path_lookup() in
init_eaccess(), and make the filesystem that mounted on '/' as root
during path lookup.

Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
---
 fs/init.c   | 11 +++++++++--
 init/main.c |  7 ++++++-
 2 files changed, 15 insertions(+), 3 deletions(-)

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
 
diff --git a/init/main.c b/init/main.c
index eb01e121d2f1..1153571ca977 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1522,6 +1522,11 @@ void __init console_on_rootfs(void)
 	fput(file);
 }
 
+bool __init ramdisk_exec_exist(void)
+{
+	return init_eaccess(ramdisk_execute_command) == 0;
+}
+
 static noinline void __init kernel_init_freeable(void)
 {
 	/*
@@ -1568,7 +1573,7 @@ static noinline void __init kernel_init_freeable(void)
 	 * check if there is an early userspace init.  If yes, let it do all
 	 * the work
 	 */
-	if (init_eaccess(ramdisk_execute_command) != 0) {
+	if (!ramdisk_exec_exist()) {
 		ramdisk_execute_command = NULL;
 		prepare_namespace();
 	}
-- 
2.32.0.rc0

