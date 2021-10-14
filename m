Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3C142E3AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 23:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbhJNVmI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 17:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbhJNVmH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 17:42:07 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5921CC061570;
        Thu, 14 Oct 2021 14:40:02 -0700 (PDT)
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1007])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id B0DE71F415A6;
        Thu, 14 Oct 2021 22:40:00 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        repnop@google.com, Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v7 26/28] ext4: Send notifications on error
Date:   Thu, 14 Oct 2021 18:36:44 -0300
Message-Id: <20211014213646.1139469-27-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211014213646.1139469-1-krisman@collabora.com>
References: <20211014213646.1139469-1-krisman@collabora.com>
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
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

---
Changes since v6:
  - Report ext4_std_errors agains superblock (jan)
---
 fs/ext4/super.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 88d5d274a868..67183e6b1920 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -46,6 +46,7 @@
 #include <linux/part_stat.h>
 #include <linux/kthread.h>
 #include <linux/freezer.h>
+#include <linux/fsnotify.h>
 
 #include "ext4.h"
 #include "ext4_extents.h"	/* Needed for trace points definition */
@@ -759,6 +760,8 @@ void __ext4_error(struct super_block *sb, const char *function,
 		       sb->s_id, function, line, current->comm, &vaf);
 		va_end(args);
 	}
+	fsnotify_sb_error(sb, NULL, error);
+
 	ext4_handle_error(sb, force_ro, error, 0, block, function, line);
 }
 
@@ -789,6 +792,8 @@ void __ext4_error_inode(struct inode *inode, const char *function,
 			       current->comm, &vaf);
 		va_end(args);
 	}
+	fsnotify_sb_error(inode->i_sb, inode, error);
+
 	ext4_handle_error(inode->i_sb, false, error, inode->i_ino, block,
 			  function, line);
 }
@@ -827,6 +832,8 @@ void __ext4_error_file(struct file *file, const char *function,
 			       current->comm, path, &vaf);
 		va_end(args);
 	}
+	fsnotify_sb_error(inode->i_sb, inode, EFSCORRUPTED);
+
 	ext4_handle_error(inode->i_sb, false, EFSCORRUPTED, inode->i_ino, block,
 			  function, line);
 }
@@ -894,6 +901,7 @@ void __ext4_std_error(struct super_block *sb, const char *function,
 		printk(KERN_CRIT "EXT4-fs error (device %s) in %s:%d: %s\n",
 		       sb->s_id, function, line, errstr);
 	}
+	fsnotify_sb_error(sb, NULL, errno);
 
 	ext4_handle_error(sb, false, -errno, 0, 0, function, line);
 }
-- 
2.33.0

