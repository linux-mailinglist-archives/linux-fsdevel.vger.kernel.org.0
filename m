Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9693B7863
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 21:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbhF2TPY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 15:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235504AbhF2TPX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 15:15:23 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EBFC061760;
        Tue, 29 Jun 2021 12:12:55 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 224C81F431AF
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        jack@suse.com, dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v3 11/15] fsnotify: Introduce helpers to send error_events
Date:   Tue, 29 Jun 2021 15:10:31 -0400
Message-Id: <20210629191035.681913-12-krisman@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210629191035.681913-1-krisman@collabora.com>
References: <20210629191035.681913-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce helpers for filesystems interested in reporting FS_ERROR
events.  When notifying errors, the file system might not have an inode
to report on the error.  To support this, allow the caller to specify
the superblock to which the error applies.

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
index 8c2c681b4495..684c79ca01b2 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -326,4 +326,17 @@ static inline void fsnotify_change(struct dentry *dentry, unsigned int ia_valid)
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
2.32.0

