Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 280FA2AFAC9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Nov 2020 22:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgKKVwo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Nov 2020 16:52:44 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49794 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgKKVwo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Nov 2020 16:52:44 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 5BB801F45EB0
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     dhowells@redhat.com
Cc:     viro@zeniv.linux.org.uk, tytso@mit.edu, khazhy@google.com,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH RFC v2 5/8] vfs: Include origin of the SB error notification
Date:   Wed, 11 Nov 2020 16:52:10 -0500
Message-Id: <20201111215213.4152354-6-krisman@collabora.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201111215213.4152354-1-krisman@collabora.com>
References: <20201111215213.4152354-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When reporting a filesystem error, we really need to know where the
error came from, therefore, include "function:line" information in the
notification sent to userspace.  There is no current users of notify_sb
in the kernel, so there are no callers to update.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 include/linux/fs.h               | 11 +++++++++--
 include/uapi/linux/watch_queue.h |  3 +++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index cf5245f414c2..81aaa673ada7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3498,14 +3498,17 @@ static inline void notify_sb(struct super_block *s,
 /**
  * notify_sb_error: Post superblock error notification.
  * @s: The superblock the notification is about.
+ * @function: function name reported as source of the warning.
+ * @line: source code line reported as source of the warning.
  * @error: The error number to be recorded.
  * @inode: The inode the error refers to (if available, 0 otherwise)
  * @block: The block the error refers to (if available, 0 otherwise)
  * @fmt: Formating string for extra information appended to the notification
  * @args: arguments for extra information string appended to the notification
  */
-static inline int notify_sb_error(struct super_block *s, int error,  u64 inode,
-				  u64 block, const char *fmt, va_list *args)
+static inline int notify_sb_error(struct super_block *s, const char *function, int line,
+				  int error, u64 inode, u64 block,
+				  const char *fmt, va_list *args)
 {
 #ifdef CONFIG_SB_NOTIFICATIONS
 	if (unlikely(s->s_watchers)) {
@@ -3518,8 +3521,12 @@ static inline int notify_sb_error(struct super_block *s, int error,  u64 inode,
 			.error_cookie	= 0,
 			.inode		= inode,
 			.block		= block,
+			.line		= line,
 		};
 
+		memcpy(&n.function, function, SB_NOTIFICATION_FNAME_LEN);
+		n.function[SB_NOTIFICATION_FNAME_LEN-1] = '\0';
+
 		post_sb_notification(s, &n.s, fmt, args);
 	}
 #endif
diff --git a/include/uapi/linux/watch_queue.h b/include/uapi/linux/watch_queue.h
index 937363d9f7b3..5fa5286c5cc7 100644
--- a/include/uapi/linux/watch_queue.h
+++ b/include/uapi/linux/watch_queue.h
@@ -114,6 +114,7 @@ enum superblock_notification_type {
 
 #define NOTIFY_SUPERBLOCK_IS_NOW_RO	WATCH_INFO_FLAG_0 /* Superblock changed to R/O */
 
+#define SB_NOTIFICATION_FNAME_LEN 30
 /*
  * Superblock notification record.
  * - watch.type = WATCH_TYPE_MOUNT_NOTIFY
@@ -130,6 +131,8 @@ struct superblock_error_notification {
 	__u32	error_cookie;
 	__u64	inode;
 	__u64	block;
+	char	function[SB_NOTIFICATION_FNAME_LEN];
+	__u16	line;
 	char	desc[0];
 };
 
-- 
2.29.2

