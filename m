Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205C43CFECD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 18:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbhGTP21 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 11:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240517AbhGTPUm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 11:20:42 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFA0C061574;
        Tue, 20 Jul 2021 09:00:41 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id E01E41F43149
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Jan Kara <jack@suse.cz>
Subject: [PATCH v4 12/16] fsnotify: Introduce helpers to send error_events
Date:   Tue, 20 Jul 2021 11:59:40 -0400
Message-Id: <20210720155944.1447086-13-krisman@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210720155944.1447086-1-krisman@collabora.com>
References: <20210720155944.1447086-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce helpers for filesystems interested in reporting FS_ERROR
events.  When notifying errors, the file system might not have an inode
to report on the error.  To support this, allow the caller to specify
the superblock to which the error applies.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v2:
  - Drop reference to s_fnotify_marks and guards (Amir)

Changes since v1:
  - Use the inode argument (Amir)
  - Protect s_fsnotify_marks with ifdef guard
---
 fs/notify/fsnotify.c             |  2 +-
 include/linux/fsnotify.h         | 13 +++++++++++++
 include/linux/fsnotify_backend.h |  1 +
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 7c783c9df1dd..f66dff6e2d4e 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -487,7 +487,7 @@ int __fsnotify(__u32 mask, const struct fsnotify_event_info *event_info)
 		 */
 		parent = event_info->dir;
 	}
-	sb = inode->i_sb;
+	sb = event_info->sb ?: inode->i_sb;
 
 	/*
 	 * Optimization: srcu_read_lock() has a memory barrier which can
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index f8acddcf54fb..f118e20a9926 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -317,4 +317,17 @@ static inline void fsnotify_change(struct dentry *dentry, unsigned int ia_valid)
 		fsnotify_dentry(dentry, mask);
 }
 
+static inline int fsnotify_sb_error(struct super_block *sb, struct inode *inode,
+				    int error)
+{
+	struct fs_error_report report = {
+		.error = error,
+		.inode = inode,
+	};
+
+	return __fsnotify(FS_ERROR, &(struct fsnotify_event_info) {
+			.data = &report, .data_type = FSNOTIFY_EVENT_ERROR,
+			.sb = sb});
+}
+
 #endif	/* _LINUX_FS_NOTIFY_H */
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 33988fdf391a..fa1303b8c599 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -138,6 +138,7 @@ struct fsnotify_event_info {
 	struct inode *dir;
 	const struct qstr *name;
 	struct inode *inode;
+	struct super_block *sb;
 	u32 cookie;
 };
 
-- 
2.32.0

