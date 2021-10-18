Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABA2432ACA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 02:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbhJSAEs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 20:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233931AbhJSAEr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 20:04:47 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3186DC06161C;
        Mon, 18 Oct 2021 17:02:35 -0700 (PDT)
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1007])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 73E3C1F411B7;
        Tue, 19 Oct 2021 01:02:28 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Jan Kara <jack@suse.cz>
Subject: [PATCH v8 16/32] fanotify: Require fid_mode for any non-fd event
Date:   Mon, 18 Oct 2021 20:59:59 -0300
Message-Id: <20211019000015.1666608-17-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211019000015.1666608-1-krisman@collabora.com>
References: <20211019000015.1666608-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Like inode events, FAN_FS_ERROR will require fid mode.  Therefore,
convert the verification during fanotify_mark(2) to require fid for any
non-fd event.  This means fid_mode will not only be required for inode
events, but for any event that doesn't provide a descriptor.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
changes since v5:
  - Fix condition to include FANOTIFY_EVENT_FLAGS. (me)
  - Fix comment identation  (jan)
---
 fs/notify/fanotify/fanotify_user.c | 12 ++++++------
 include/linux/fanotify.h           |  3 +++
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index adeae6d65e35..66ee3c2805c7 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1458,14 +1458,14 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 		goto fput_and_out;
 
 	/*
-	 * Events with data type inode do not carry enough information to report
-	 * event->fd, so we do not allow setting a mask for inode events unless
-	 * group supports reporting fid.
-	 * inode events are not supported on a mount mark, because they do not
-	 * carry enough information (i.e. path) to be filtered by mount point.
+	 * Events that do not carry enough information to report
+	 * event->fd require a group that supports reporting fid.  Those
+	 * events are not supported on a mount mark, because they do not
+	 * carry enough information (i.e. path) to be filtered by mount
+	 * point.
 	 */
 	fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
-	if (mask & FANOTIFY_INODE_EVENTS &&
+	if (mask & ~(FANOTIFY_FD_EVENTS|FANOTIFY_EVENT_FLAGS) &&
 	    (!fid_mode || mark_type == FAN_MARK_MOUNT))
 		goto fput_and_out;
 
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index eec3b7c40811..52d464802d99 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -84,6 +84,9 @@ extern struct ctl_table fanotify_table[]; /* for sysctl */
  */
 #define FANOTIFY_DIRENT_EVENTS	(FAN_MOVE | FAN_CREATE | FAN_DELETE)
 
+/* Events that can be reported with event->fd */
+#define FANOTIFY_FD_EVENTS (FANOTIFY_PATH_EVENTS | FANOTIFY_PERM_EVENTS)
+
 /* Events that can only be reported with data type FSNOTIFY_EVENT_INODE */
 #define FANOTIFY_INODE_EVENTS	(FANOTIFY_DIRENT_EVENTS | \
 				 FAN_ATTRIB | FAN_MOVE_SELF | FAN_DELETE_SELF)
-- 
2.33.0

