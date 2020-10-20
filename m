Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4D12942DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Oct 2020 21:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438064AbgJTTQN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Oct 2020 15:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437985AbgJTTQN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Oct 2020 15:16:13 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA11C0613CE;
        Tue, 20 Oct 2020 12:16:12 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 7705F1F44C45
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     dhowells@redhat.com
Cc:     viro@zeniv.linux.org.uk, tytso@mit.edu, khazhy@google.com,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH RFC 7/7] ext4: Implement SB error notification through watch_sb
Date:   Tue, 20 Oct 2020 15:15:43 -0400
Message-Id: <20201020191543.601784-8-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020191543.601784-1-krisman@collabora.com>
References: <20201020191543.601784-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This follows the same implementation of ext4 error reporting via dmesg,
but expose that information via the new watch_queue notifications API.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/ext4/super.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 8b2736283481..ad96cf4bf6a5 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -542,15 +542,17 @@ void __ext4_error(struct super_block *sb, const char *function,
 		return;
 
 	trace_ext4_error(sb, function, line);
+	va_start(args, fmt);
 	if (ext4_error_ratelimit(sb)) {
-		va_start(args, fmt);
 		vaf.fmt = fmt;
 		vaf.va = &args;
 		printk(KERN_CRIT
 		       "EXT4-fs error (device %s): %s:%d: comm %s: %pV\n",
 		       sb->s_id, function, line, current->comm, &vaf);
-		va_end(args);
 	}
+	notify_sb_error(sb, function, line, error, fmt, &args);
+	va_end(args);
+
 	save_error_info(sb, error, 0, block, function, line);
 	ext4_handle_error(sb);
 }
@@ -566,8 +568,8 @@ void __ext4_error_inode(struct inode *inode, const char *function,
 		return;
 
 	trace_ext4_error(inode->i_sb, function, line);
+	va_start(args, fmt);
 	if (ext4_error_ratelimit(inode->i_sb)) {
-		va_start(args, fmt);
 		vaf.fmt = fmt;
 		vaf.va = &args;
 		if (block)
@@ -580,8 +582,11 @@ void __ext4_error_inode(struct inode *inode, const char *function,
 			       "inode #%lu: comm %s: %pV\n",
 			       inode->i_sb->s_id, function, line, inode->i_ino,
 			       current->comm, &vaf);
-		va_end(args);
 	}
+	notify_sb_inode_error(inode->i_sb, function, line, error, inode->i_ino, block,
+			      fmt, &args);
+	va_end(args);
+
 	save_error_info(inode->i_sb, error, inode->i_ino, block,
 			function, line);
 	ext4_handle_error(inode->i_sb);
@@ -600,11 +605,11 @@ void __ext4_error_file(struct file *file, const char *function,
 		return;
 
 	trace_ext4_error(inode->i_sb, function, line);
+	va_start(args, fmt);
 	if (ext4_error_ratelimit(inode->i_sb)) {
 		path = file_path(file, pathname, sizeof(pathname));
 		if (IS_ERR(path))
 			path = "(unknown)";
-		va_start(args, fmt);
 		vaf.fmt = fmt;
 		vaf.va = &args;
 		if (block)
@@ -619,8 +624,11 @@ void __ext4_error_file(struct file *file, const char *function,
 			       "comm %s: path %s: %pV\n",
 			       inode->i_sb->s_id, function, line, inode->i_ino,
 			       current->comm, path, &vaf);
-		va_end(args);
 	}
+	notify_sb_inode_error(inode->i_sb, function, line, EFSCORRUPTED,
+			      inode->i_ino, block, fmt, &args);
+	va_end(args);
+
 	save_error_info(inode->i_sb, EFSCORRUPTED, inode->i_ino, block,
 			function, line);
 	ext4_handle_error(inode->i_sb);
@@ -690,6 +698,8 @@ void __ext4_std_error(struct super_block *sb, const char *function,
 		       sb->s_id, function, line, errstr);
 	}
 
+	notify_sb_error(sb, function, line, errno, errstr, NULL);
+
 	save_error_info(sb, -errno, 0, 0, function, line);
 	ext4_handle_error(sb);
 }
@@ -719,6 +729,7 @@ void __ext4_abort(struct super_block *sb, const char *function,
 	vaf.va = &args;
 	printk(KERN_CRIT "EXT4-fs error (device %s): %s:%d: %pV\n",
 	       sb->s_id, function, line, &vaf);
+	notify_sb_error(sb, function, line, error, fmt, &args);
 	va_end(args);
 
 	if (sb_rdonly(sb) == 0) {
@@ -752,6 +763,7 @@ void __ext4_msg(struct super_block *sb,
 	vaf.fmt = fmt;
 	vaf.va = &args;
 	printk("%sEXT4-fs (%s): %pV\n", prefix, sb->s_id, &vaf);
+	notify_sb_msg(sb, fmt, &args);
 	va_end(args);
 }
 
@@ -776,6 +788,7 @@ void __ext4_warning(struct super_block *sb, const char *function,
 	vaf.va = &args;
 	printk(KERN_WARNING "EXT4-fs warning (device %s): %s:%d: %pV\n",
 	       sb->s_id, function, line, &vaf);
+	notify_sb_warning(sb, function, line, fmt, &args);
 	va_end(args);
 }
 
@@ -794,6 +807,7 @@ void __ext4_warning_inode(const struct inode *inode, const char *function,
 	printk(KERN_WARNING "EXT4-fs warning (device %s): %s:%d: "
 	       "inode #%lu: comm %s: %pV\n", inode->i_sb->s_id,
 	       function, line, inode->i_ino, current->comm, &vaf);
+	notify_sb_inode_warning(inode->i_sb, function, line, inode->i_ino, 0, fmt, &args);
 	va_end(args);
 }
 
@@ -813,8 +827,8 @@ __acquires(bitlock)
 	trace_ext4_error(sb, function, line);
 	__save_error_info(sb, EFSCORRUPTED, ino, block, function, line);
 
+	va_start(args, fmt);
 	if (ext4_error_ratelimit(sb)) {
-		va_start(args, fmt);
 		vaf.fmt = fmt;
 		vaf.va = &args;
 		printk(KERN_CRIT "EXT4-fs error (device %s): %s:%d: group %u, ",
@@ -825,8 +839,10 @@ __acquires(bitlock)
 			printk(KERN_CONT "block %llu:",
 			       (unsigned long long) block);
 		printk(KERN_CONT "%pV\n", &vaf);
-		va_end(args);
 	}
+	notify_sb_inode_error(sb, function, line, EFSCORRUPTED,
+			      ino, block, fmt, &args);
+	va_end(args);
 
 	if (test_opt(sb, WARN_ON_ERROR))
 		WARN_ON_ONCE(1);
-- 
2.28.0

