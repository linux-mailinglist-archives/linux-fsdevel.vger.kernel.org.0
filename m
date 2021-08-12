Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471C73EACA3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 23:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237921AbhHLVlq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 17:41:46 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45842 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhHLVlp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 17:41:45 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 3C0221F41890
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com, jack@suse.com
Cc:     linux-api@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, khazhy@google.com,
        dhowells@redhat.com, david@fromorbit.com, tytso@mit.edu,
        djwong@kernel.org, repnop@google.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Jan Kara <jack@suse.cz>
Subject: [PATCH v6 13/21] fanotify: Require fid_mode for any non-fd event
Date:   Thu, 12 Aug 2021 17:40:02 -0400
Message-Id: <20210812214010.3197279-14-krisman@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210812214010.3197279-1-krisman@collabora.com>
References: <20210812214010.3197279-1-krisman@collabora.com>
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
index 4cacea5fcaca..54107f1533d5 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1387,14 +1387,14 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
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
index a16dbeced152..c05d45bde8b8 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -81,6 +81,9 @@ extern struct ctl_table fanotify_table[]; /* for sysctl */
  */
 #define FANOTIFY_DIRENT_EVENTS	(FAN_MOVE | FAN_CREATE | FAN_DELETE)
 
+/* Events that can be reported with event->fd */
+#define FANOTIFY_FD_EVENTS (FANOTIFY_PATH_EVENTS | FANOTIFY_PERM_EVENTS)
+
 /* Events that can only be reported with data type FSNOTIFY_EVENT_INODE */
 #define FANOTIFY_INODE_EVENTS	(FANOTIFY_DIRENT_EVENTS | \
 				 FAN_ATTRIB | FAN_MOVE_SELF | FAN_DELETE_SELF)
-- 
2.32.0

