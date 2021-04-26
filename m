Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6669E36B937
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 20:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239442AbhDZSnm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 14:43:42 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47488 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239380AbhDZSna (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:43:30 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id DE3D31F41E82
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com, tytso@mit.edu, djwong@kernel.org
Cc:     david@fromorbit.com, jack@suse.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH RFC 07/15] fsnotify: Support FS_ERROR event type
Date:   Mon, 26 Apr 2021 14:41:53 -0400
Message-Id: <20210426184201.4177978-8-krisman@collabora.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426184201.4177978-1-krisman@collabora.com>
References: <20210426184201.4177978-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Expose a new type of fsnotify event for filesystems to report errors for
userspace monitoring tools.  fanotify will send this type of
notification for FAN_ERROR marks.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/notify/fsnotify.c             |  2 +-
 include/linux/fsnotify_backend.h | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 30d422b8c0fc..9fff35e67b37 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -558,7 +558,7 @@ static __init int fsnotify_init(void)
 {
 	int ret;
 
-	BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) != 25);
+	BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) != 26);
 
 	ret = init_srcu_struct(&fsnotify_mark_srcu);
 	if (ret)
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index a1a4dd69e5ed..f850bfbe30d4 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -48,6 +48,8 @@
 #define FS_ACCESS_PERM		0x00020000	/* access event in a permissions hook */
 #define FS_OPEN_EXEC_PERM	0x00040000	/* open/exec event in a permission hook */
 
+#define FS_ERROR		0x00100000	/* Used for filesystem error reporting */
+
 #define FS_EXCL_UNLINK		0x04000000	/* do not send events if object is unlinked */
 /*
  * Set on inode mark that cares about things that happen to its children.
@@ -74,6 +76,8 @@
 #define ALL_FSNOTIFY_PERM_EVENTS (FS_OPEN_PERM | FS_ACCESS_PERM | \
 				  FS_OPEN_EXEC_PERM)
 
+#define ALL_FSNOTIFY_ERROR_EVENTS	FS_ERROR
+
 #define FSN_SUBMISSION_RING_BUFFER	0x00000080
 
 /*
@@ -95,6 +99,7 @@
 
 /* Events that can be reported to backends */
 #define ALL_FSNOTIFY_EVENTS (ALL_FSNOTIFY_DIRENT_EVENTS | \
+			     ALL_FSNOTIFY_ERROR_EVENTS |  \
 			     FS_EVENTS_POSS_ON_CHILD | \
 			     FS_DELETE_SELF | FS_MOVE_SELF | FS_DN_RENAME | \
 			     FS_UNMOUNT | FS_Q_OVERFLOW | FS_IN_IGNORED)
@@ -272,6 +277,17 @@ enum fsnotify_data_type {
 	FSNOTIFY_EVENT_NONE,
 	FSNOTIFY_EVENT_PATH,
 	FSNOTIFY_EVENT_INODE,
+	FSNOTIFY_EVENT_ERROR,
+};
+
+struct fs_error_report {
+	int error;
+
+	int line;
+	const char *function;
+
+	size_t fs_data_size;
+	void *fs_data;
 };
 
 static inline struct inode *fsnotify_data_inode(const void *data, int data_type)
-- 
2.31.0

