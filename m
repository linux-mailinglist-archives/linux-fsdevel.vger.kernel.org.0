Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43533B7861
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 21:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbhF2TPR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 15:15:17 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34942 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235503AbhF2TPR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 15:15:17 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 5252E1F431AF
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        jack@suse.com, dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v3 10/15] fsnotify: Support FS_ERROR event type
Date:   Tue, 29 Jun 2021 15:10:30 -0400
Message-Id: <20210629191035.681913-11-krisman@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210629191035.681913-1-krisman@collabora.com>
References: <20210629191035.681913-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Expose a new type of fsnotify event for filesystems to report errors for
userspace monitoring tools.  fanotify will send this type of
notification for FAN_FS_ERROR events.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v2:
  - FAN_ERROR->FAN_FS_ERROR (Amir)

Changes since v1:
  - Overload FS_ERROR with FS_IN_IGNORED
  - Implement support for this type on fsnotify_data_inode (Amir)
---
 include/linux/fsnotify_backend.h | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 8222fe12a6c9..ea5f5c7cc381 100644
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
@@ -263,6 +270,12 @@ enum fsnotify_data_type {
 	FSNOTIFY_EVENT_NONE,
 	FSNOTIFY_EVENT_PATH,
 	FSNOTIFY_EVENT_INODE,
+	FSNOTIFY_EVENT_ERROR,
+};
+
+struct fs_error_report {
+	int error;
+	struct inode *inode;
 };
 
 static inline struct inode *fsnotify_data_inode(const void *data, int data_type)
@@ -272,6 +285,8 @@ static inline struct inode *fsnotify_data_inode(const void *data, int data_type)
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

