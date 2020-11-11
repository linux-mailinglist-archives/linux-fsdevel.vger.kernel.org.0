Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0532AFACB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Nov 2020 22:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgKKVwv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Nov 2020 16:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgKKVwv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Nov 2020 16:52:51 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5325DC0613D1;
        Wed, 11 Nov 2020 13:52:51 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 8A3D21F45E06
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     dhowells@redhat.com
Cc:     viro@zeniv.linux.org.uk, tytso@mit.edu, khazhy@google.com,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH RFC v2 6/8] fs: Add more superblock error subtypes
Date:   Wed, 11 Nov 2020 16:52:11 -0500
Message-Id: <20201111215213.4152354-7-krisman@collabora.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201111215213.4152354-1-krisman@collabora.com>
References: <20201111215213.4152354-1-krisman@collabora.com>
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
 include/linux/fs.h               | 56 ++++++++++++++++++++++++++++++++
 include/uapi/linux/watch_queue.h | 17 ++++++++++
 2 files changed, 73 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 81aaa673ada7..9c241689d8bc 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3533,6 +3533,62 @@ static inline int notify_sb_error(struct super_block *s, const char *function, i
 	return error;
 }
 
+/**
+ * notify_sb_warning: Post superblock warning notification.
+ * @s: The superblock the notification is about.
+ * @function: function name reported as source of the warning.
+ * @line: source code line reported as source of the warning.
+ * @inode: The inode the error refers to (if available, 0 otherwise)
+ * @block: The block the error refers to (if available, 0 otherwise)
+ * @fmt: Formating string for extra information appended to the notification
+ * @args: arguments for extra information string appended to the notification
+ */
+static inline void notify_sb_warning(struct super_block *s, const char *function,
+				     int line, u64 inode, u64 block,
+				     const char *fmt, va_list *args)
+{
+#ifdef CONFIG_SB_NOTIFICATIONS
+	if (unlikely(s->s_watchers)) {
+		struct superblock_error_notification n = {
+			.s.watch.type	= WATCH_TYPE_SB_NOTIFY,
+			.s.watch.subtype = NOTIFY_SUPERBLOCK_WARNING,
+			.s.watch.info	= watch_sizeof(n),
+			.s.sb_id	= s->s_unique_id,
+			.inode		= inode,
+			.block		= block,
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
  * notify_sb_EDQUOT: Post superblock quota overrun notification.
  * @s: The superblock the notification is about.
diff --git a/include/uapi/linux/watch_queue.h b/include/uapi/linux/watch_queue.h
index 5fa5286c5cc7..c4afd545e234 100644
--- a/include/uapi/linux/watch_queue.h
+++ b/include/uapi/linux/watch_queue.h
@@ -110,6 +110,9 @@ enum superblock_notification_type {
 	NOTIFY_SUPERBLOCK_ERROR		= 1, /* Error in filesystem or blockdev */
 	NOTIFY_SUPERBLOCK_EDQUOT	= 2, /* EDQUOT notification */
 	NOTIFY_SUPERBLOCK_NETWORK	= 3, /* Network status change */
+	NOTIFY_SUPERBLOCK_MSG		= 4, /* Filesystem message */
+	NOTIFY_SUPERBLOCK_WARNING	= 5, /* Filesystem warning */
+
 };
 
 #define NOTIFY_SUPERBLOCK_IS_NOW_RO	WATCH_INFO_FLAG_0 /* Superblock changed to R/O */
@@ -136,4 +139,18 @@ struct superblock_error_notification {
 	char	desc[0];
 };
 
+struct superblock_msg_notification {
+	struct superblock_notification s; /* subtype = notify_superblock_msg */
+	char desc[0];
+};
+
+struct superblock_warning_notification {
+	struct superblock_notification s; /* subtype = notify_superblock_warning */
+	__u64	inode;
+	__u64	block;
+	char	function[SB_NOTIFICATION_FNAME_LEN];
+	__u16	line;
+	char desc[0];
+};
+
 #endif /* _UAPI_LINUX_WATCH_QUEUE_H */
-- 
2.29.2

