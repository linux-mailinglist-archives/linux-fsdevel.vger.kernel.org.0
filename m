Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE1638BC8B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 04:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238673AbhEUCno (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 22:43:44 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54916 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbhEUCnn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 22:43:43 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 58FEB1F43D6A
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, "Darrick J . Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>, jack@suse.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH 06/11] fsnotify: Support FS_ERROR event type
Date:   Thu, 20 May 2021 22:41:29 -0400
Message-Id: <20210521024134.1032503-7-krisman@collabora.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210521024134.1032503-1-krisman@collabora.com>
References: <20210521024134.1032503-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Expose a new type of fsnotify event for filesystems to report errors for
userspace monitoring tools.  fanotify will send this type of
notification for FAN_ERROR events.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v1:
  - Overload FS_ERROR with FS_IN_IGNORED
---
 include/linux/fsnotify_backend.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 1ce66748a2d2..bbef2df3fbc7 100644
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
@@ -248,6 +255,12 @@ enum fsnotify_data_type {
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
-- 
2.31.0

