Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9522A2D1F04
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 01:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbgLHAcp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 19:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgLHAcp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 19:32:45 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84549C061794;
        Mon,  7 Dec 2020 16:32:04 -0800 (PST)
Received: from localhost (unknown [IPv6:2804:14c:132:242d::1001])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 041961F44D31;
        Tue,  8 Dec 2020 00:32:02 +0000 (GMT)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     dhowells@redhat.com
Cc:     viro@zeniv.linux.org.uk, tytso@mit.edu, khazhy@google.com,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 7/8] ext4: Implement SB error notification through watch_sb
Date:   Mon,  7 Dec 2020 21:31:16 -0300
Message-Id: <20201208003117.342047-8-krisman@collabora.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208003117.342047-1-krisman@collabora.com>
References: <20201208003117.342047-1-krisman@collabora.com>
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
index 94472044f4c1..f239624003fc 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -713,15 +713,17 @@ void __ext4_error(struct super_block *sb, const char *function,
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
@@ -737,8 +739,8 @@ void __ext4_error_inode(struct inode *inode, const char *function,
 		return;
 
 	trace_ext4_error(inode->i_sb, function, line);
+	va_start(args, fmt);
 	if (ext4_error_ratelimit(inode->i_sb)) {
-		va_start(args, fmt);
 		vaf.fmt = fmt;
 		vaf.va = &args;
 		if (block)
@@ -751,8 +753,11 @@ void __ext4_error_inode(struct inode *inode, const char *function,
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
@@ -771,11 +776,11 @@ void __ext4_error_file(struct file *file, const char *function,
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
@@ -790,8 +795,11 @@ void __ext4_error_file(struct file *file, const char *function,
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
@@ -861,6 +869,8 @@ void __ext4_std_error(struct super_block *sb, const char *function,
 		       sb->s_id, function, line, errstr);
 	}
 
+	notify_sb_error(sb, function, line, errno, 0, 0, errstr, NULL);
+
 	save_error_info(sb, -errno, 0, 0, function, line);
 	ext4_handle_error(sb);
 }
@@ -890,6 +900,7 @@ void __ext4_abort(struct super_block *sb, const char *function,
 	vaf.va = &args;
 	printk(KERN_CRIT "EXT4-fs error (device %s): %s:%d: %pV\n",
 	       sb->s_id, function, line, &vaf);
+	notify_sb_error(sb, function, line, error, 0, 0, fmt, &args);
 	va_end(args);
 
 	if (sb_rdonly(sb) == 0) {
@@ -923,6 +934,7 @@ void __ext4_msg(struct super_block *sb,
 	vaf.fmt = fmt;
 	vaf.va = &args;
 	printk("%sEXT4-fs (%s): %pV\n", prefix, sb->s_id, &vaf);
+	notify_sb_msg(sb, fmt, &args);
 	va_end(args);
 }
 
@@ -947,6 +959,7 @@ void __ext4_warning(struct super_block *sb, const char *function,
 	vaf.va = &args;
 	printk(KERN_WARNING "EXT4-fs warning (device %s): %s:%d: %pV\n",
 	       sb->s_id, function, line, &vaf);
+	notify_sb_warning(sb, function, line, 0, 0, fmt, &args);
 	va_end(args);
 }
 
@@ -965,6 +978,7 @@ void __ext4_warning_inode(const struct inode *inode, const char *function,
 	printk(KERN_WARNING "EXT4-fs warning (device %s): %s:%d: "
 	       "inode #%lu: comm %s: %pV\n", inode->i_sb->s_id,
 	       function, line, inode->i_ino, current->comm, &vaf);
+	notify_sb_warning(inode->i_sb, function, line, inode->i_ino, 0, fmt, &args);
 	va_end(args);
 }
 
@@ -984,8 +998,8 @@ __acquires(bitlock)
 	trace_ext4_error(sb, function, line);
 	__save_error_info(sb, EFSCORRUPTED, ino, block, function, line);
 
+	va_start(args, fmt);
 	if (ext4_error_ratelimit(sb)) {
-		va_start(args, fmt);
 		vaf.fmt = fmt;
 		vaf.va = &args;
 		printk(KERN_CRIT "EXT4-fs error (device %s): %s:%d: group %u, ",
@@ -996,8 +1010,9 @@ __acquires(bitlock)
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

