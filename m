Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085BE432AB8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 02:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbhJSADy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 20:03:54 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40742 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhJSADw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 20:03:52 -0400
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1007])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 8E71E1F41A9C;
        Tue, 19 Oct 2021 01:01:36 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Jan Kara <jack@suse.cz>
Subject: [PATCH v8 10/32] fsnotify: Retrieve super block from the data field
Date:   Mon, 18 Oct 2021 20:59:53 -0300
Message-Id: <20211019000015.1666608-11-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211019000015.1666608-1-krisman@collabora.com>
References: <20211019000015.1666608-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some file system events (i.e. FS_ERROR) might not be associated with an
inode or directory.  For these, we can retrieve the super block from the
data field.  But, since the super_block is available in the data field
on every event type, simplify the code to always retrieve it from there,
through a new helper.

Suggested-by: Jan Kara <jack@suse.cz>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

--
Changes since v6:
  - Always use data field for superblock retrieval
Changes since v5:
  - add fsnotify_data_sb handle to retrieve sb from the data field. (jan)
---
 fs/notify/fsnotify.c             |  7 +++----
 include/linux/fsnotify_backend.h | 15 +++++++++++++++
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 963e6ce75b96..fde3a1115a17 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -455,16 +455,16 @@ static void fsnotify_iter_next(struct fsnotify_iter_info *iter_info)
  *		@file_name is relative to
  * @file_name:	optional file name associated with event
  * @inode:	optional inode associated with event -
- *		either @dir or @inode must be non-NULL.
- *		if both are non-NULL event may be reported to both.
+ *		If @dir and @inode are both non-NULL, event may be
+ *		reported to both.
  * @cookie:	inotify rename cookie
  */
 int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 	     const struct qstr *file_name, struct inode *inode, u32 cookie)
 {
 	const struct path *path = fsnotify_data_path(data, data_type);
+	struct super_block *sb = fsnotify_data_sb(data, data_type);
 	struct fsnotify_iter_info iter_info = {};
-	struct super_block *sb;
 	struct mount *mnt = NULL;
 	struct inode *parent = NULL;
 	int ret = 0;
@@ -483,7 +483,6 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 		 */
 		parent = dir;
 	}
-	sb = inode->i_sb;
 
 	/*
 	 * Optimization: srcu_read_lock() has a memory barrier which can
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index b323d0c4b967..035438fe4a43 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -289,6 +289,21 @@ static inline const struct path *fsnotify_data_path(const void *data,
 	}
 }
 
+static inline struct super_block *fsnotify_data_sb(const void *data,
+						   int data_type)
+{
+	switch (data_type) {
+	case FSNOTIFY_EVENT_INODE:
+		return ((struct inode *)data)->i_sb;
+	case FSNOTIFY_EVENT_DENTRY:
+		return ((struct dentry *)data)->d_sb;
+	case FSNOTIFY_EVENT_PATH:
+		return ((const struct path *)data)->dentry->d_sb;
+	default:
+		return NULL;
+	}
+}
+
 enum fsnotify_obj_type {
 	FSNOTIFY_OBJ_TYPE_INODE,
 	FSNOTIFY_OBJ_TYPE_PARENT,
-- 
2.33.0

