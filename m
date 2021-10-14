Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9359F42E38D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 23:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbhJNVlI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 17:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbhJNVlI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 17:41:08 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAE1C061570;
        Thu, 14 Oct 2021 14:39:02 -0700 (PDT)
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1007])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 2136F1F44F83;
        Thu, 14 Oct 2021 22:39:00 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        repnop@google.com, Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Jan Kara <jack@suse.cz>
Subject: [PATCH v7 17/28] fanotify: Reserve UAPI bits for FAN_FS_ERROR
Date:   Thu, 14 Oct 2021 18:36:35 -0300
Message-Id: <20211014213646.1139469-18-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211014213646.1139469-1-krisman@collabora.com>
References: <20211014213646.1139469-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

FAN_FS_ERROR allows reporting of event type FS_ERROR to userspace, which
a mechanism to report file system wide problems via fanotify.  This
commit preallocate userspace visible bits to match the FS_ERROR event.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/notify/fanotify/fanotify.c | 1 +
 include/uapi/linux/fanotify.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index c64d61b673ca..8f152445d75c 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -752,6 +752,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	BUILD_BUG_ON(FAN_ONDIR != FS_ISDIR);
 	BUILD_BUG_ON(FAN_OPEN_EXEC != FS_OPEN_EXEC);
 	BUILD_BUG_ON(FAN_OPEN_EXEC_PERM != FS_OPEN_EXEC_PERM);
+	BUILD_BUG_ON(FAN_FS_ERROR != FS_ERROR);
 
 	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 19);
 
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index 64553df9d735..2990731ddc8b 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -20,6 +20,7 @@
 #define FAN_OPEN_EXEC		0x00001000	/* File was opened for exec */
 
 #define FAN_Q_OVERFLOW		0x00004000	/* Event queued overflowed */
+#define FAN_FS_ERROR		0x00008000	/* Filesystem error */
 
 #define FAN_OPEN_PERM		0x00010000	/* File open in perm check */
 #define FAN_ACCESS_PERM		0x00020000	/* File accessed in perm check */
-- 
2.33.0

