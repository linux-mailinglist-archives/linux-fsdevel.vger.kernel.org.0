Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943DD3F3988
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Aug 2021 10:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbhHUIcH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Aug 2021 04:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbhHUIcH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Aug 2021 04:32:07 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DE6C061575;
        Sat, 21 Aug 2021 01:31:27 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d2so9497306qto.6;
        Sat, 21 Aug 2021 01:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=60oNYYqEgUuxhXEhLpFsW+N/qA8SeHbgIGElF6OtlQI=;
        b=UvHu7NYETiqF+KDwpi9Ts85gF2ERtHR3f5WT9sgyipZoIHFRRL3aswjGCtbVjusiKE
         MvT95ujf2I7CM+vbLrfXJI8JNnhdChtn4GXVbvArnoZULq3qjHqDKuCA8lK/8t8grM9u
         O4r91aaRp7ZwhP5gN55ddIuGaGmg3zbQ6++wLXVmDCBwZVcor0GXxuZad84cRfMr95mO
         pMNLjStBLbwcZYyGdTerb1XlCmVWl65iuEiqt00a595T5S3HfX0bjR7EzFNrtEIx3KBj
         oPbr6Uivejv9iMgUbi2y96L3vWZOMPxbzpkt73ZzCjQvZ7FNDJzBQmbfgcuaH+1mG77H
         x2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=60oNYYqEgUuxhXEhLpFsW+N/qA8SeHbgIGElF6OtlQI=;
        b=qPh/NLvuSJ4JPKG8Cf8Zrhg5yBqSQIWhl93oUT1o+g167//Q7J1Ov9DnR+vr15XgNb
         6uTGX1gnG9cksv+oypRFgsoE5F+PyZcRkjeOb01VMQwMcNNQzBu9934dWD0RwGnC4L3e
         J8dQNLjwPJsvVSeQAaohNQgMqa795o36F6z9A60f3C8NVxj75SnAOi3UJZReeL9g5zK/
         AcLgfPoJWt9T0Yvnho2SNsYq2LvUw/KuGtzvK8I+hGUSryfx7l8VTrG9A9XRkZvgn4Bf
         RzCy5SEyfdP8xDtWY0Y7dTWRqZJui1WCaldkLJnCL0AgHts3I11/ci4j/s5U5ogfYrYs
         qOFA==
X-Gm-Message-State: AOAM530uVEhFW3AFCFPTYH2fjZ8J5jFNRZkPXjS7M61CN24Sf1ZupSl9
        xSQcrR+0pXpCxbmy30sTeOkun/AqPEk=
X-Google-Smtp-Source: ABdhPJxhVsI2LO+td3CFA7aFyquPQTsY4clw1bMHZ4nsQCZqdXmfl43V9lNOmbMWGnRVCxMGQfnJyQ==
X-Received: by 2002:ac8:7dc6:: with SMTP id c6mr21339035qte.25.1629534687062;
        Sat, 21 Aug 2021 01:31:27 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id b25sm4435024qka.23.2021.08.21.01.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 01:31:26 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     viro@zeniv.linux.org.uk, christian.brauner@ubuntu.com,
        jamorris@linux.microsoft.com, gladkov.alexey@gmail.com
Cc:     yang.yang29@zte.com.cn, tj@kernel.org,
        paul.gortmaker@windriver.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] proc: prevent mount proc on same mountpoint in one pid namespace
Date:   Sat, 21 Aug 2021 01:31:05 -0700
Message-Id: <20210821083105.30336-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yang Yang <yang.yang29@zte.com.cn>

Patch "proc: allow to mount many instances of proc in one pid namespace"
aims to mount many instances of proc on different mountpoint, see
tools/testing/selftests/proc/proc-multiple-procfs.c.

But there is a side-effects, user can mount many instances of proc on
the same mountpoint in one pid namespace, which is not allowed before.
This duplicate mount makes no sense but wastes memory and CPU, and user
may be confused why kernel allows it.

The logic of this patch is: when try to mount proc on /mnt, check if
there is a proc instance mount on /mnt in the same pid namespace. If
answer is yes, return -EBUSY.

Since this check can't be done in proc_get_tree(), which call
get_tree_nodev() and will create new super_block unconditionally.
And other nodev fs may faces the same case, so add a new hook in
fs_context_operations.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
---
 fs/namespace.c             |  9 +++++++++
 fs/proc/root.c             | 15 +++++++++++++++
 include/linux/fs_context.h |  1 +
 3 files changed, 25 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index f79d9471cb76..84da649a70c5 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2878,6 +2878,7 @@ static int do_new_mount_fc(struct fs_context *fc, struct path *mountpoint,
 static int do_new_mount(struct path *path, const char *fstype, int sb_flags,
 			int mnt_flags, const char *name, void *data)
 {
+	int (*check_mntpoint)(struct fs_context *fc, struct path *path);
 	struct file_system_type *type;
 	struct fs_context *fc;
 	const char *subtype = NULL;
@@ -2906,6 +2907,13 @@ static int do_new_mount(struct path *path, const char *fstype, int sb_flags,
 	if (IS_ERR(fc))
 		return PTR_ERR(fc);
 
+	/* check if there is a same super_block mount on path*/
+	check_mntpoint = fc->ops->check_mntpoint;
+	if (check_mntpoint)
+		err = check_mntpoint(fc, path);
+	if (err < 0)
+		goto err_fc;
+
 	if (subtype)
 		err = vfs_parse_fs_string(fc, "subtype",
 					  subtype, strlen(subtype));
@@ -2920,6 +2928,7 @@ static int do_new_mount(struct path *path, const char *fstype, int sb_flags,
 	if (!err)
 		err = do_new_mount_fc(fc, path, mnt_flags);
 
+err_fc:
 	put_fs_context(fc);
 	return err;
 }
diff --git a/fs/proc/root.c b/fs/proc/root.c
index c7e3b1350ef8..0971d6b0bec2 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -237,11 +237,26 @@ static void proc_fs_context_free(struct fs_context *fc)
 	kfree(ctx);
 }
 
+static int proc_check_mntpoint(struct fs_context *fc, struct path *path)
+{
+	struct super_block *mnt_sb = path->mnt->mnt_sb;
+	struct proc_fs_info *fs_info;
+
+	if (strcmp(mnt_sb->s_type->name, "proc") == 0) {
+		fs_info = mnt_sb->s_fs_info;
+		if (fs_info->pid_ns == task_active_pid_ns(current) &&
+		    path->mnt->mnt_root == path->dentry)
+			return -EBUSY;
+	}
+	return 0;
+}
+
 static const struct fs_context_operations proc_fs_context_ops = {
 	.free		= proc_fs_context_free,
 	.parse_param	= proc_parse_param,
 	.get_tree	= proc_get_tree,
 	.reconfigure	= proc_reconfigure,
+	.check_mntpoint	= proc_check_mntpoint,
 };
 
 static int proc_init_fs_context(struct fs_context *fc)
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index 6b54982fc5f3..090a05fb2d7d 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -119,6 +119,7 @@ struct fs_context_operations {
 	int (*parse_monolithic)(struct fs_context *fc, void *data);
 	int (*get_tree)(struct fs_context *fc);
 	int (*reconfigure)(struct fs_context *fc);
+	int (*check_mntpoint)(struct fs_context *fc, struct path *path);
 };
 
 /*
-- 
2.25.1

