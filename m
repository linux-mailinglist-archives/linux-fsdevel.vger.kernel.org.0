Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C17D432AF9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 02:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbhJSAGu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 20:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhJSAGt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 20:06:49 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48C0C06161C;
        Mon, 18 Oct 2021 17:04:36 -0700 (PDT)
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1007])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 231451F40F21;
        Tue, 19 Oct 2021 01:04:34 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v8 30/32] ext4: Send notifications on error
Date:   Mon, 18 Oct 2021 21:00:13 -0300
Message-Id: <20211019000015.1666608-31-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211019000015.1666608-1-krisman@collabora.com>
References: <20211019000015.1666608-1-krisman@collabora.com>
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

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

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

