Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144C242E3A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 23:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbhJNVmB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 17:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbhJNVmB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 17:42:01 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36439C061570;
        Thu, 14 Oct 2021 14:39:56 -0700 (PDT)
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1007])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 72A9D1F415A6;
        Thu, 14 Oct 2021 22:39:54 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        repnop@google.com, Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v7 25/28] fanotify: Allow users to request FAN_FS_ERROR events
Date:   Thu, 14 Oct 2021 18:36:43 -0300
Message-Id: <20211014213646.1139469-26-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211014213646.1139469-1-krisman@collabora.com>
References: <20211014213646.1139469-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Wire up the FAN_FS_ERROR event in the fanotify_mark syscall, allowing
user space to request the monitoring of FAN_FS_ERROR events.

These events are limited to filesystem marks, so check it is the
case in the syscall handler.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/notify/fanotify/fanotify.c      | 2 +-
 fs/notify/fanotify/fanotify_user.c | 5 +++++
 include/linux/fanotify.h           | 6 +++++-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 47e28f418711..d449a23d603f 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -827,7 +827,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	BUILD_BUG_ON(FAN_OPEN_EXEC_PERM != FS_OPEN_EXEC_PERM);
 	BUILD_BUG_ON(FAN_FS_ERROR != FS_ERROR);
 
-	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 19);
+	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 20);
 
 	mask = fanotify_group_event_mask(group, iter_info, mask, data,
 					 data_type, dir);
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 8f7c2f4ce674..5edfd7e3f356 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1585,6 +1585,11 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 		fsid = &__fsid;
 	}
 
+	if (mask & FAN_FS_ERROR && mark_type != FAN_MARK_FILESYSTEM) {
+		ret = -EINVAL;
+		goto path_put_and_out;
+	}
+
 	/* inode held in place by reference to path; group by fget on fd */
 	if (mark_type == FAN_MARK_INODE)
 		inode = path.dentry->d_inode;
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 52d464802d99..616af2ea20f3 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -91,9 +91,13 @@ extern struct ctl_table fanotify_table[]; /* for sysctl */
 #define FANOTIFY_INODE_EVENTS	(FANOTIFY_DIRENT_EVENTS | \
 				 FAN_ATTRIB | FAN_MOVE_SELF | FAN_DELETE_SELF)
 
+/* Events that can only be reported with data type FSNOTIFY_EVENT_ERROR */
+#define FANOTIFY_ERROR_EVENTS	(FAN_FS_ERROR)
+
 /* Events that user can request to be notified on */
 #define FANOTIFY_EVENTS		(FANOTIFY_PATH_EVENTS | \
-				 FANOTIFY_INODE_EVENTS)
+				 FANOTIFY_INODE_EVENTS | \
+				 FANOTIFY_ERROR_EVENTS)
 
 /* Events that require a permission response from user */
 #define FANOTIFY_PERM_EVENTS	(FAN_OPEN_PERM | FAN_ACCESS_PERM | \
-- 
2.33.0

