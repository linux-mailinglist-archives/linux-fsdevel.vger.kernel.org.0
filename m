Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDE72AFACD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Nov 2020 22:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgKKVwz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Nov 2020 16:52:55 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49818 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbgKKVwz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Nov 2020 16:52:55 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id A2A7C1F45DAF
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     dhowells@redhat.com
Cc:     viro@zeniv.linux.org.uk, tytso@mit.edu, khazhy@google.com,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH RFC v2 7/8] ext4: Implement SB error notification through watch_sb
Date:   Wed, 11 Nov 2020 16:52:12 -0500
Message-Id: <20201111215213.4152354-8-krisman@collabora.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201111215213.4152354-1-krisman@collabora.com>
References: <20201111215213.4152354-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This follows the same implementation of ext4 error reporting via dmesg,
but expose that information via the new watch_queue notifications API.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/ext4/super.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c3b864588a0b..58dc1e48b683 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -724,15 +724,17 @@ void __ext4_error(struct super_block *sb, const char *function,
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
+	notify_sb_error(sb, function, line, error, 0, 0, fmt, &args);
+	va_end(args);
+
 	save_error_info(sb, error, 0, block, function, line);
 	ext4_handle_error(sb);
 }
@@ -748,8 +750,8 @@ void __ext4_error_inode(struct inode *inode, const char *function,
 		return;
 
 	trace_ext4_error(inode->i_sb, function, line);
+	va_start(args, fmt);
 	if (ext4_error_ratelimit(inode->i_sb)) {
-		va_start(args, fmt);
 		vaf.fmt = fmt;
 		vaf.va = &args;
 		if (block)
@@ -762,8 +764,11 @@ void __ext4_error_inode(struct inode *inode, const char *function,
 			       "inode #%lu: comm %s: %pV\n",
 			       inode->i_sb->s_id, function, line, inode->i_ino,
 			       current->comm, &vaf);
-		va_end(args);
 	}
+	notify_sb_error(inode->i_sb, function, line, error, inode->i_ino, block,
+			fmt, &args);
+	va_end(args);
+
 	save_error_info(inode->i_sb, error, inode->i_ino, block,
 			function, line);
 	ext4_handle_error(inode->i_sb);
@@ -782,11 +787,11 @@ void __ext4_error_file(struct file *file, const char *function,
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
@@ -801,8 +806,11 @@ void __ext4_error_file(struct file *file, const char *function,
 			       "comm %s: path %s: %pV\n",
 			       inode->i_sb->s_id, function, line, inode->i_ino,
 			       current->comm, path, &vaf);
-		va_end(args);
 	}
+	notify_sb_error(inode->i_sb, function, line, EFSCORRUPTED,
+			inode->i_ino, block, fmt, &args);
+	va_end(args);
+
 	save_error_info(inode->i_sb, EFSCORRUPTED, inode->i_ino, block,
 			function, line);
 	ext4_handle_error(inode->i_sb);
@@ -872,6 +880,8 @@ void __ext4_std_error(struct super_block *sb, const char *function,
 		       sb->s_id, function, line, errstr);
 	}
 
+	notify_sb_error(sb, function, line, errno, 0, 0, errstr, NULL);
+
 	save_error_info(sb, -errno, 0, 0, function, line);
 	ext4_handle_error(sb);
 }
@@ -901,6 +911,7 @@ void __ext4_abort(struct super_block *sb, const char *function,
 	vaf.va = &args;
 	printk(KERN_CRIT "EXT4-fs error (device %s): %s:%d: %pV\n",
 	       sb->s_id, function, line, &vaf);
+	notify_sb_error(sb, function, line, error, 0, 0, fmt, &args);
 	va_end(args);
 
 	if (sb_rdonly(sb) == 0) {
@@ -934,6 +945,7 @@ void __ext4_msg(struct super_block *sb,
 	vaf.fmt = fmt;
 	vaf.va = &args;
 	printk("%sEXT4-fs (%s): %pV\n", prefix, sb->s_id, &vaf);
+	notify_sb_msg(sb, fmt, &args);
 	va_end(args);
 }
 
@@ -958,6 +970,7 @@ void __ext4_warning(struct super_block *sb, const char *function,
 	vaf.va = &args;
 	printk(KERN_WARNING "EXT4-fs warning (device %s): %s:%d: %pV\n",
 	       sb->s_id, function, line, &vaf);
+	notify_sb_warning(sb, function, line, 0, 0, fmt, &args);
 	va_end(args);
 }
 
@@ -976,6 +989,7 @@ void __ext4_warning_inode(const struct inode *inode, const char *function,
 	printk(KERN_WARNING "EXT4-fs warning (device %s): %s:%d: "
 	       "inode #%lu: comm %s: %pV\n", inode->i_sb->s_id,
 	       function, line, inode->i_ino, current->comm, &vaf);
+	notify_sb_warning(inode->i_sb, function, line, inode->i_ino, 0, fmt, &args);
 	va_end(args);
 }
 
@@ -995,8 +1009,8 @@ __acquires(bitlock)
 	trace_ext4_error(sb, function, line);
 	__save_error_info(sb, EFSCORRUPTED, ino, block, function, line);
 
+	va_start(args, fmt);
 	if (ext4_error_ratelimit(sb)) {
-		va_start(args, fmt);
 		vaf.fmt = fmt;
 		vaf.va = &args;
 		printk(KERN_CRIT "EXT4-fs error (device %s): %s:%d: group %u, ",
@@ -1007,8 +1021,9 @@ __acquires(bitlock)
 			printk(KERN_CONT "block %llu:",
 			       (unsigned long long) block);
 		printk(KERN_CONT "%pV\n", &vaf);
-		va_end(args);
 	}
+	notify_sb_error(sb, function, line, EFSCORRUPTED, ino, block, fmt, &args);
+	va_end(args);
 
 	if (test_opt(sb, WARN_ON_ERROR))
 		WARN_ON_ONCE(1);
-- 
2.29.2

