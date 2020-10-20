Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F472942D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Oct 2020 21:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438056AbgJTTQG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Oct 2020 15:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438032AbgJTTQG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Oct 2020 15:16:06 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7EDC0613CE;
        Tue, 20 Oct 2020 12:16:05 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id B09FF1F44C3F
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     dhowells@redhat.com
Cc:     viro@zeniv.linux.org.uk, tytso@mit.edu, khazhy@google.com,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH RFC 5/7] vfs: Include origin of the SB error notification
Date:   Tue, 20 Oct 2020 15:15:41 -0400
Message-Id: <20201020191543.601784-6-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020191543.601784-1-krisman@collabora.com>
References: <20201020191543.601784-1-krisman@collabora.com>
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
 include/linux/fs.h               | 10 ++++++++--
 include/uapi/linux/watch_queue.h |  3 +++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index d24905e10623..be9f7b480f50 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3516,12 +3516,14 @@ static inline void notify_sb(struct super_block *s,
 /**
  * notify_sb_error: Post superblock error notification.
  * @s: The superblock the notification is about.
+ * @function: function name reported as source of the warning.
+ * @line: source code line reported as source of the warning.
  * @error: The error number to be recorded.
  * @fmt: Formating string for extra information appended to the notification
  * @args: arguments for extra information string appended to the notification
  */
-static inline int notify_sb_error(struct super_block *s, int error,
-				  const char *fmt, va_list *args)
+static inline int notify_sb_error(struct super_block *s, const char *function,
+				  int line, int error, const char *fmt, va_list *args)
 {
 #ifdef CONFIG_SB_NOTIFICATIONS
 	if (unlikely(s->s_watchers)) {
@@ -3532,8 +3534,12 @@ static inline int notify_sb_error(struct super_block *s, int error,
 			.s.sb_id	= s->s_unique_id,
 			.error_number	= error,
 			.error_cookie	= 0,
+			.line		= line,
 		};
 
+		memcpy(&n.function, function, SB_NOTIFICATION_FNAME_LEN);
+		n.function[SB_NOTIFICATION_FNAME_LEN-1] = '\0';
+
 		post_sb_notification(s, &n.s, fmt, args);
 	}
 #endif
diff --git a/include/uapi/linux/watch_queue.h b/include/uapi/linux/watch_queue.h
index 5899936534f4..d0a45a4ded7d 100644
--- a/include/uapi/linux/watch_queue.h
+++ b/include/uapi/linux/watch_queue.h
@@ -114,6 +114,7 @@ enum superblock_notification_type {
 
 #define NOTIFY_SUPERBLOCK_IS_NOW_RO	WATCH_INFO_FLAG_0 /* Superblock changed to R/O */
 
+#define SB_NOTIFICATION_FNAME_LEN 30
 /*
  * Superblock notification record.
  * - watch.type = WATCH_TYPE_MOUNT_NOTIFY
@@ -128,6 +129,8 @@ struct superblock_error_notification {
 	struct superblock_notification s; /* subtype = notify_superblock_error */
 	__u32	error_number;
 	__u32	error_cookie;
+	char	function[SB_NOTIFICATION_FNAME_LEN];
+	__u16	line;
 	char	desc[0];
 };
 
-- 
2.28.0

