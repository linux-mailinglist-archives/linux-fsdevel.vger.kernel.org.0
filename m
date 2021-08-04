Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E979C3E056A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Aug 2021 18:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbhHDQHu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Aug 2021 12:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbhHDQHr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Aug 2021 12:07:47 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4C6C0613D5;
        Wed,  4 Aug 2021 09:07:35 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 1DD2F1F4080F
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v5 15/23] fanotify: Require fid_mode for any non-fd event
Date:   Wed,  4 Aug 2021 12:06:04 -0400
Message-Id: <20210804160612.3575505-16-krisman@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210804160612.3575505-1-krisman@collabora.com>
References: <20210804160612.3575505-1-krisman@collabora.com>
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
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
changes since v5:
  - Fix condition to include FANOTIFY_EVENT_FLAGS. (me)
---
 fs/notify/fanotify/fanotify_user.c | 14 +++++++-------
 include/linux/fanotify.h           |  3 +++
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 0696f2121781..6dad2a00e337 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1382,14 +1382,14 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 		goto fput_and_out;
 
 	/*
-	 * Events with data type inode do not carry enough information to report
-	 * event->fd, so we do not allow setting a mask for inode events unless
-	 * group supports reporting fid.
-	 * inode events are not supported on a mount mark, because they do not
-	 * carry enough information (i.e. path) to be filtered by mount point.
-	 */
+	* Events that do not carry enough information to report
+	* event->fd require a group that supports reporting fid.  Those
+	* events are not supported on a mount mark, because they do not
+	* carry enough information (i.e. path) to be filtered by mount
+	* point.
+	*/
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

