Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1EF942E35B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 23:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbhJNVjR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 17:39:17 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53954 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbhJNVjQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 17:39:16 -0400
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1007])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id C627F1F44F69;
        Thu, 14 Oct 2021 22:37:09 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        repnop@google.com, kernel@collabora.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v7 01/28] fsnotify: pass data_type to fsnotify_name()
Date:   Thu, 14 Oct 2021 18:36:19 -0300
Message-Id: <20211014213646.1139469-2-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211014213646.1139469-1-krisman@collabora.com>
References: <20211014213646.1139469-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Amir Goldstein <amir73il@gmail.com>

Align the arguments of fsnotify_name() to those of fsnotify().

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 include/linux/fsnotify.h | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 12d3a7d308ab..d1144d7c3536 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -26,20 +26,21 @@
  * FS_EVENT_ON_CHILD mask on the parent inode and will not be reported if only
  * the child is interested and not the parent.
  */
-static inline void fsnotify_name(struct inode *dir, __u32 mask,
-				 struct inode *child,
-				 const struct qstr *name, u32 cookie)
+static inline int fsnotify_name(__u32 mask, const void *data, int data_type,
+				struct inode *dir, const struct qstr *name,
+				u32 cookie)
 {
 	if (atomic_long_read(&dir->i_sb->s_fsnotify_connectors) == 0)
-		return;
+		return 0;
 
-	fsnotify(mask, child, FSNOTIFY_EVENT_INODE, dir, name, NULL, cookie);
+	return fsnotify(mask, data, data_type, dir, name, NULL, cookie);
 }
 
 static inline void fsnotify_dirent(struct inode *dir, struct dentry *dentry,
 				   __u32 mask)
 {
-	fsnotify_name(dir, mask, d_inode(dentry), &dentry->d_name, 0);
+	fsnotify_name(mask, d_inode(dentry), FSNOTIFY_EVENT_INODE,
+		      dir, &dentry->d_name, 0);
 }
 
 static inline void fsnotify_inode(struct inode *inode, __u32 mask)
@@ -154,8 +155,10 @@ static inline void fsnotify_move(struct inode *old_dir, struct inode *new_dir,
 		new_dir_mask |= FS_ISDIR;
 	}
 
-	fsnotify_name(old_dir, old_dir_mask, source, old_name, fs_cookie);
-	fsnotify_name(new_dir, new_dir_mask, source, new_name, fs_cookie);
+	fsnotify_name(old_dir_mask, source, FSNOTIFY_EVENT_INODE,
+		      old_dir, old_name, fs_cookie);
+	fsnotify_name(new_dir_mask, source, FSNOTIFY_EVENT_INODE,
+		      new_dir, new_name, fs_cookie);
 
 	if (target)
 		fsnotify_link_count(target);
@@ -209,7 +212,8 @@ static inline void fsnotify_link(struct inode *dir, struct inode *inode,
 	fsnotify_link_count(inode);
 	audit_inode_child(dir, new_dentry, AUDIT_TYPE_CHILD_CREATE);
 
-	fsnotify_name(dir, FS_CREATE, inode, &new_dentry->d_name, 0);
+	fsnotify_name(FS_CREATE, inode, FSNOTIFY_EVENT_INODE,
+		      dir, &new_dentry->d_name, 0);
 }
 
 /*
-- 
2.33.0

