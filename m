Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F1436B94C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 20:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238652AbhDZSpw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 14:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239506AbhDZSn4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:43:56 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4D0C06175F;
        Mon, 26 Apr 2021 11:43:13 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 92ECC1F422D6
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com, tytso@mit.edu, djwong@kernel.org
Cc:     david@fromorbit.com, jack@suse.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH RFC 13/15] ext4: Send notifications on error
Date:   Mon, 26 Apr 2021 14:41:59 -0400
Message-Id: <20210426184201.4177978-14-krisman@collabora.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426184201.4177978-1-krisman@collabora.com>
References: <20210426184201.4177978-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Send a FS_ERROR message via fsnotify to a userspace monitoring tool
whenever a ext4 error condition is triggered.  This follows the existing
error conditions in ext4, so it is hooked to the ext4_error* functions.

It also follows the current dmesg reporting in the format.  The
filesystem message is composed mostly by the string that would be
otherwise printed in dmesg.

A new ext4 specific record format is exposed in the uapi, such that a
monitoring tool knows what to expect when listening errors of an ext4
filesystem.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/ext4/super.c                  | 60 ++++++++++++++++++++++++--------
 include/uapi/linux/ext4-notify.h | 17 +++++++++
 2 files changed, 62 insertions(+), 15 deletions(-)
 create mode 100644 include/uapi/linux/ext4-notify.h

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index b9693680463a..032e29e7ff6a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -46,6 +46,8 @@
 #include <linux/part_stat.h>
 #include <linux/kthread.h>
 #include <linux/freezer.h>
+#include <linux/fsnotify.h>
+#include <uapi/linux/ext4-notify.h>
 
 #include "ext4.h"
 #include "ext4_extents.h"	/* Needed for trace points definition */
@@ -727,6 +729,22 @@ static void flush_stashed_error_work(struct work_struct *work)
 	ext4_commit_super(sbi->s_sb);
 }
 
+static void ext4_fsnotify_error(int error, struct inode *inode, __u64 block,
+				const char *func, int line,
+				const char *desc, struct va_format *vaf)
+{
+	struct ext4_error_inode_report report;
+
+	if (inode->i_sb->s_fsnotify_marks) {
+		report.inode = inode ? inode->i_ino : -1L;
+		report.block = block ? block : -1L;
+
+		snprintf(report.desc, EXT4_FSN_DESC_LEN, "%s%pV\n", desc?:"", vaf);
+
+		fsnotify_error_event(error, inode, func, line, &report, sizeof(report));
+	}
+}
+
 #define ext4_error_ratelimit(sb)					\
 		___ratelimit(&(EXT4_SB(sb)->s_err_ratelimit_state),	\
 			     "EXT4-fs error")
@@ -742,15 +760,18 @@ void __ext4_error(struct super_block *sb, const char *function,
 		return;
 
 	trace_ext4_error(sb, function, line);
+
+	va_start(args, fmt);
+	vaf.fmt = fmt;
+	vaf.va = &args;
 	if (ext4_error_ratelimit(sb)) {
-		va_start(args, fmt);
-		vaf.fmt = fmt;
-		vaf.va = &args;
 		printk(KERN_CRIT
 		       "EXT4-fs error (device %s): %s:%d: comm %s: %pV\n",
 		       sb->s_id, function, line, current->comm, &vaf);
-		va_end(args);
+
 	}
+	ext4_fsnotify_error(error, sb->s_root->d_inode, block, function, line, NULL, &vaf);
+	va_end(args);
 	ext4_handle_error(sb, force_ro, error, 0, block, function, line);
 }
 
@@ -765,10 +786,10 @@ void __ext4_error_inode(struct inode *inode, const char *function,
 		return;
 
 	trace_ext4_error(inode->i_sb, function, line);
+	va_start(args, fmt);
+	vaf.fmt = fmt;
+	vaf.va = &args;
 	if (ext4_error_ratelimit(inode->i_sb)) {
-		va_start(args, fmt);
-		vaf.fmt = fmt;
-		vaf.va = &args;
 		if (block)
 			printk(KERN_CRIT "EXT4-fs error (device %s): %s:%d: "
 			       "inode #%lu: block %llu: comm %s: %pV\n",
@@ -779,8 +800,11 @@ void __ext4_error_inode(struct inode *inode, const char *function,
 			       "inode #%lu: comm %s: %pV\n",
 			       inode->i_sb->s_id, function, line, inode->i_ino,
 			       current->comm, &vaf);
-		va_end(args);
 	}
+
+	ext4_fsnotify_error(error, inode, block, function, line, NULL, &vaf);
+	va_end(args);
+
 	ext4_handle_error(inode->i_sb, false, error, inode->i_ino, block,
 			  function, line);
 }
@@ -798,13 +822,16 @@ void __ext4_error_file(struct file *file, const char *function,
 		return;
 
 	trace_ext4_error(inode->i_sb, function, line);
+
+	path = file_path(file, pathname, sizeof(pathname));
+	if (IS_ERR(path))
+		path = "(unknown)";
+
+	va_start(args, fmt);
+	vaf.fmt = fmt;
+	vaf.va = &args;
+
 	if (ext4_error_ratelimit(inode->i_sb)) {
-		path = file_path(file, pathname, sizeof(pathname));
-		if (IS_ERR(path))
-			path = "(unknown)";
-		va_start(args, fmt);
-		vaf.fmt = fmt;
-		vaf.va = &args;
 		if (block)
 			printk(KERN_CRIT
 			       "EXT4-fs error (device %s): %s:%d: inode #%lu: "
@@ -817,8 +844,10 @@ void __ext4_error_file(struct file *file, const char *function,
 			       "comm %s: path %s: %pV\n",
 			       inode->i_sb->s_id, function, line, inode->i_ino,
 			       current->comm, path, &vaf);
-		va_end(args);
 	}
+	ext4_fsnotify_error(EFSCORRUPTED, inode, block, function, line, NULL, &vaf);
+	va_end(args);
+
 	ext4_handle_error(inode->i_sb, false, EFSCORRUPTED, inode->i_ino, block,
 			  function, line);
 }
@@ -886,6 +915,7 @@ void __ext4_std_error(struct super_block *sb, const char *function,
 		printk(KERN_CRIT "EXT4-fs error (device %s) in %s:%d: %s\n",
 		       sb->s_id, function, line, errstr);
 	}
+	ext4_fsnotify_error(errno, NULL, -1L, function, line, errstr, NULL);
 
 	ext4_handle_error(sb, false, -errno, 0, 0, function, line);
 }
diff --git a/include/uapi/linux/ext4-notify.h b/include/uapi/linux/ext4-notify.h
new file mode 100644
index 000000000000..31a3bbcafd13
--- /dev/null
+++ b/include/uapi/linux/ext4-notify.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+/*
+ * Copyright 2021, Collabora Ltd.
+ */
+
+#ifndef EXT4_NOTIFY_H
+#define EXT4_NOTIFY_H
+
+#define EXT4_FSN_DESC_LEN	256
+
+struct ext4_error_inode_report {
+	u64 inode;
+	u64 block;
+	char desc[EXT4_FSN_DESC_LEN];
+};
+
+#endif
-- 
2.31.0

