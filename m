Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7DCD3EAC97
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 23:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237877AbhHLVlc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 17:41:32 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45792 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhHLVlc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 17:41:32 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 863131F41890
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com, jack@suse.com
Cc:     linux-api@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, khazhy@google.com,
        dhowells@redhat.com, david@fromorbit.com, tytso@mit.edu,
        djwong@kernel.org, repnop@google.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v6 10/21] fsnotify: Support FS_ERROR event type
Date:   Thu, 12 Aug 2021 17:39:59 -0400
Message-Id: <20210812214010.3197279-11-krisman@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210812214010.3197279-1-krisman@collabora.com>
References: <20210812214010.3197279-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Expose a new type of fsnotify event for filesystems to report errors for
userspace monitoring tools.  fanotify will send this type of
notification for FAN_FS_ERROR events.  This also introduce a helper for
generating the new event.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v5:
  - pass sb inside data field (jan)
Changes since v3:
  - Squash patch ("fsnotify: Introduce helpers to send error_events")
  - Drop reviewed-bys!

Changes since v2:
  - FAN_ERROR->FAN_FS_ERROR (Amir)

Changes since v1:
  - Overload FS_ERROR with FS_IN_IGNORED
  - Implement support for this type on fsnotify_data_inode (Amir)
---
 fs/notify/fsnotify.c             |  3 +++
 include/linux/fsnotify.h         | 13 +++++++++++++
 include/linux/fsnotify_backend.h | 18 +++++++++++++++++-
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 536db02cb26e..6d3b3de4f8ee 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -103,6 +103,9 @@ static struct super_block *fsnotify_data_sb(const void *data, int data_type)
 	struct inode *inode = fsnotify_data_inode(data, data_type);
 	struct super_block *sb = inode ? inode->i_sb : NULL;
 
+	if (!sb && data_type == FSNOTIFY_EVENT_ERROR)
+		sb = ((struct fs_error_report *) data)->sb;
+
 	return sb;
 }
 
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index f8acddcf54fb..521234af1827 100644
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
+		.sb = sb,
+	};
+
+	return fsnotify(FS_ERROR, &report, FSNOTIFY_EVENT_ERROR,
+			NULL, NULL, NULL, 0);
+}
+
 #endif	/* _LINUX_FS_NOTIFY_H */
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index e027af3cd8dd..277b6f3e0998 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -42,6 +42,12 @@
 
 #define FS_UNMOUNT		0x00002000	/* inode on umount fs */
 #define FS_Q_OVERFLOW		0x00004000	/* Event queued overflowed */
+#define FS_ERROR		0x00008000	/* Filesystem Error (fanotify) */
+
+/*
+ * FS_IN_IGNORED overloads FS_ERROR.  It is only used internally by inotify
+ * which does not support FS_ERROR.
+ */
 #define FS_IN_IGNORED		0x00008000	/* last inotify event here */
 
 #define FS_OPEN_PERM		0x00010000	/* open event in an permission hook */
@@ -95,7 +101,8 @@
 #define ALL_FSNOTIFY_EVENTS (ALL_FSNOTIFY_DIRENT_EVENTS | \
 			     FS_EVENTS_POSS_ON_CHILD | \
 			     FS_DELETE_SELF | FS_MOVE_SELF | FS_DN_RENAME | \
-			     FS_UNMOUNT | FS_Q_OVERFLOW | FS_IN_IGNORED)
+			     FS_UNMOUNT | FS_Q_OVERFLOW | FS_IN_IGNORED | \
+			     FS_ERROR)
 
 /* Extra flags that may be reported with event or control handling of events */
 #define ALL_FSNOTIFY_FLAGS  (FS_EXCL_UNLINK | FS_ISDIR | FS_IN_ONESHOT | \
@@ -248,6 +255,13 @@ enum fsnotify_data_type {
 	FSNOTIFY_EVENT_NONE,
 	FSNOTIFY_EVENT_PATH,
 	FSNOTIFY_EVENT_INODE,
+	FSNOTIFY_EVENT_ERROR,
+};
+
+struct fs_error_report {
+	int error;
+	struct inode *inode;
+	struct super_block *sb;
 };
 
 static inline struct inode *fsnotify_data_inode(const void *data, int data_type)
@@ -257,6 +271,8 @@ static inline struct inode *fsnotify_data_inode(const void *data, int data_type)
 		return (struct inode *)data;
 	case FSNOTIFY_EVENT_PATH:
 		return d_inode(((const struct path *)data)->dentry);
+	case FSNOTIFY_EVENT_ERROR:
+		return ((struct fs_error_report *)data)->inode;
 	default:
 		return NULL;
 	}
-- 
2.32.0

