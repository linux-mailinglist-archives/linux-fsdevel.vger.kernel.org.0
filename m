Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90DF82942D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Oct 2020 21:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438060AbgJTTQK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Oct 2020 15:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438032AbgJTTQJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Oct 2020 15:16:09 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D225C0613CE;
        Tue, 20 Oct 2020 12:16:09 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 05E431F44C41
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     dhowells@redhat.com
Cc:     viro@zeniv.linux.org.uk, tytso@mit.edu, khazhy@google.com,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH RFC 6/7] fs: Add more superblock error subtypes
Date:   Tue, 20 Oct 2020 15:15:42 -0400
Message-Id: <20201020191543.601784-7-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020191543.601784-1-krisman@collabora.com>
References: <20201020191543.601784-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Expose new SB notification subtype for warnings, errors and general
messages.  This is modeled after the information exposed by ext4, but
should be the same for other filesystems.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 include/linux/fs.h               | 118 +++++++++++++++++++++++++++++++
 include/uapi/linux/watch_queue.h |  33 +++++++++
 2 files changed, 151 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index be9f7b480f50..8a11aed95798 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3513,6 +3513,28 @@ static inline void notify_sb(struct super_block *s,
 #endif
 }
 
+/**
+ * notify_sb_msg: Post superblock message.
+ * @s: The superblock the notification is about.
+ * @fmt: Formating string for extra information appended to the notification
+ * @args: arguments for extra information string appended to the notification
+ */
+static inline void notify_sb_msg(struct super_block *s, const char *fmt, va_list *args)
+{
+#ifdef CONFIG_SB_NOTIFICATIONS
+	if (unlikely(s->s_watchers)) {
+		struct superblock_msg_notification n = {
+			.s.watch.type	= WATCH_TYPE_SB_NOTIFY,
+			.s.watch.subtype = NOTIFY_SUPERBLOCK_MSG,
+			.s.watch.info	= watch_sizeof(n),
+			.s.sb_id	= s->s_unique_id,
+		};
+
+		post_sb_notification(s, &n.s, fmt, args);
+	}
+#endif
+}
+
 /**
  * notify_sb_error: Post superblock error notification.
  * @s: The superblock the notification is about.
@@ -3546,6 +3568,35 @@ static inline int notify_sb_error(struct super_block *s, const char *function,
 	return error;
 }
 
+/**
+ * notify_sb_warning: Post superblock warning notification.
+ * @s: The superblock the notification is about.
+ * @function: function name reported as source of the warning.
+ * @line: source code line reported as source of the warning.
+ * @fmt: Formating string for extra information appended to the notification
+ * @args: arguments for extra information string appended to the notification
+ */
+static inline void notify_sb_warning(struct super_block *s, const char *function,
+				    int line, const char *fmt, va_list *args)
+{
+#ifdef CONFIG_SB_NOTIFICATIONS
+	if (unlikely(s->s_watchers)) {
+		struct superblock_error_notification n = {
+			.s.watch.type	= WATCH_TYPE_SB_NOTIFY,
+			.s.watch.subtype = NOTIFY_SUPERBLOCK_WARNING,
+			.s.watch.info	= watch_sizeof(n),
+			.s.sb_id	= s->s_unique_id,
+			.line		= line,
+		};
+
+		memcpy(&n.function, function, SB_NOTIFICATION_FNAME_LEN);
+		n.function[SB_NOTIFICATION_FNAME_LEN-1] = '\0';
+
+		post_sb_notification(s, &n.s, fmt, args);
+	}
+#endif
+}
+
 /**
  * notify_sb_EDQUOT: Post superblock quota overrun notification.
  * @s: The superblock the notification is about.
@@ -3567,4 +3618,71 @@ static inline int notify_sb_EQDUOT(struct super_block *s)
 	return -EDQUOT;
 }
 
+/**
+ * notify_sb_inode_error: Post superblock inode error notification.
+ * @s: The superblock the notification is about.
+ * @function: function name reported as source of the warning.
+ * @line: source code line reported as source of the warning.
+ * @error: The error number to be recorded.
+ * @ino: The inode number being accessed.
+ * @block: The block being accessed.
+ * @fmt: Formating string for extra information appended to the notification
+ * @args: arguments for extra information string appended to the notification
+ */
+static inline int notify_sb_inode_error(struct super_block *s, const char *function,
+					int line, int error, u64 ino, u64 block,
+					const char *fmt, va_list *args)
+{
+#ifdef CONFIG_SB_NOTIFICATIONS
+	if (unlikely(s->s_watchers)) {
+		struct superblock_inode_error_notification n = {
+			.s.watch.type	= WATCH_TYPE_SB_NOTIFY,
+			.s.watch.subtype = NOTIFY_SUPERBLOCK_INODE_ERROR,
+			.s.watch.info	= watch_sizeof(n),
+			.s.sb_id	= s->s_unique_id,
+			.error_number	= error,
+			.error_cookie	= 0,
+			.line		= line,
+			.inode		= ino,
+			.block		= block
+		};
+
+		memcpy(&n.function, function, SB_NOTIFICATION_FNAME_LEN);
+		n.function[SB_NOTIFICATION_FNAME_LEN-1] = '\0';
+
+		post_sb_notification(s, &n.s, fmt, args);
+	}
+#endif
+	return error;
+}
+
+/**
+ * notify_sb_inode_warning: Post superblock inode warning notification.
+ * @s: The superblock the notification is about.
+ * @function: function name reported as source of the warning.
+ * @line: source code line reported as source of the warning.
+ * @ino: The inode number being accessed.
+ * @block: The block being accessed.
+ * @fmt: Formating string for extra information appended to the notification
+ * @args: arguments for extra information string appended to the notification
+ */
+static inline void notify_sb_inode_warning(struct super_block *s, const char *function,
+					   int line, u64 ino, u64 block, const char *fmt,
+					   va_list *args)
+{
+#ifdef CONFIG_SB_NOTIFICATIONS
+	if (unlikely(s->s_watchers)) {
+		struct superblock_inode_warning_notification n = {
+			.s.watch.type	= WATCH_TYPE_SB_NOTIFY,
+			.s.watch.subtype = NOTIFY_SUPERBLOCK_INODE_WARNING,
+			.s.watch.info	= watch_sizeof(n),
+			.s.sb_id	= s->s_unique_id,
+			.inode		= ino,
+			.block		= block
+		};
+
+		post_sb_notification(s, &n.s, fmt, args);
+	}
+#endif
+}
 #endif /* _LINUX_FS_H */
diff --git a/include/uapi/linux/watch_queue.h b/include/uapi/linux/watch_queue.h
index d0a45a4ded7d..6bfe35dc7b5d 100644
--- a/include/uapi/linux/watch_queue.h
+++ b/include/uapi/linux/watch_queue.h
@@ -110,6 +110,10 @@ enum superblock_notification_type {
 	NOTIFY_SUPERBLOCK_ERROR		= 1, /* Error in filesystem or blockdev */
 	NOTIFY_SUPERBLOCK_EDQUOT	= 2, /* EDQUOT notification */
 	NOTIFY_SUPERBLOCK_NETWORK	= 3, /* Network status change */
+	NOTIFY_SUPERBLOCK_INODE_ERROR	= 4, /* Inode Error */
+	NOTIFY_SUPERBLOCK_WARNING	= 5, /* Filesystem warning */
+	NOTIFY_SUPERBLOCK_INODE_WARNING	= 6, /* Filesystem inode warning */
+	NOTIFY_SUPERBLOCK_MSG		= 7, /* Filesystem message */
 };
 
 #define NOTIFY_SUPERBLOCK_IS_NOW_RO	WATCH_INFO_FLAG_0 /* Superblock changed to R/O */
@@ -134,4 +138,33 @@ struct superblock_error_notification {
 	char	desc[0];
 };
 
+struct superblock_msg_notification {
+	struct superblock_notification s; /* subtype = notify_superblock_msg */
+	char desc[0];
+};
+
+struct superblock_warning_notification {
+	struct superblock_notification s; /* subtype = notify_superblock_warning */
+	char	function[SB_NOTIFICATION_FNAME_LEN];
+	__u16	line;
+	char desc[0];
+};
+
+struct superblock_inode_error_notification {
+	struct superblock_notification s;  /* subtype = notify_superblock_inode_error */
+	__u32	error_number;
+	__u32	error_cookie;
+	char	function[SB_NOTIFICATION_FNAME_LEN];
+	__u16	line;
+	__u64	inode;
+	__u64	block;
+	char desc[0];
+};
+
+struct superblock_inode_warning_notification {
+	struct superblock_notification s; /* subtype = notify_superblock_inode_warning */
+	__u64	inode;
+	__u64	block;
+	char desc[0];
+};
 #endif /* _UAPI_LINUX_WATCH_QUEUE_H */
-- 
2.28.0

