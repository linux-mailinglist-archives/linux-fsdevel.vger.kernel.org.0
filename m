Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEF13A8D0B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 01:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbhFOX6w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 19:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbhFOX6r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 19:58:47 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713DEC061574;
        Tue, 15 Jun 2021 16:56:42 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 1A3A41F43336
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com
Cc:     kernel@collabora.com, djwong@kernel.org, tytso@mit.edu,
        david@fromorbit.com, jack@suse.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v2 10/14] fsnotify: Introduce helpers to send error_events
Date:   Tue, 15 Jun 2021 19:55:52 -0400
Message-Id: <20210615235556.970928-11-krisman@collabora.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210615235556.970928-1-krisman@collabora.com>
References: <20210615235556.970928-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce helpers for filesystems interested in reporting FS_ERROR
events.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v1:
  - Use the inode argument (Amir)
  - Protect s_fsnotify_marks with ifdef guard
---
 fs/notify/fsnotify.c             |  2 +-
 include/linux/fsnotify.h         | 20 ++++++++++++++++++++
 include/linux/fsnotify_backend.h |  1 +
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 36205a769dde..ac05eb3fb368 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -491,7 +491,7 @@ int __fsnotify(__u32 mask, const struct fsnotify_event_info *event_info)
 		 */
 		parent = event_info->dir;
 	}
-	sb = inode->i_sb;
+	sb = event_info->sb ?: inode->i_sb;
 
 	/*
 	 * Optimization: srcu_read_lock() has a memory barrier which can
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 8c2c681b4495..c0dbc5a65381 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -326,4 +326,24 @@ static inline void fsnotify_change(struct dentry *dentry, unsigned int ia_valid)
 		fsnotify_dentry(dentry, mask);
 }
 
+static inline int fsnotify_sb_error(struct super_block *sb, struct inode *inode,
+					int error)
+{
+#ifdef CONFIG_FSNOTIFY
+	if (sb->s_fsnotify_marks) {
+		struct fs_error_report report = {
+			.error = error,
+			.inode = inode,
+		};
+
+		return __fsnotify(FS_ERROR, &(struct fsnotify_event_info) {
+				.data = &report,
+				.data_type = FSNOTIFY_EVENT_ERROR,
+				.inode = NULL, .cookie = 0, .sb = sb
+			});
+	}
+#endif
+	return 0;
+}
+
 #endif	/* _LINUX_FS_NOTIFY_H */
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index ea5f5c7cc381..5a32c5010f45 100644
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
2.31.0

