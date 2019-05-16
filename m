Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99BD62067B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 14:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfEPL4X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 07:56:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:40974 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726723AbfEPL4X (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 07:56:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7A9D6ACAA;
        Thu, 16 May 2019 11:56:22 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3D82B1E3ED6; Thu, 16 May 2019 13:56:22 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH v2] fanotify: Disallow permission events for proc filesystem
Date:   Thu, 16 May 2019 13:56:19 +0200
Message-Id: <20190516115619.18926-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Proc filesystem has special locking rules for various files. Thus
fanotify which opens files on event delivery can easily deadlock
against another process that waits for fanotify permission event to be
handled. Since permission events on /proc have doubtful value anyway,
just disallow them.

Link: https://lore.kernel.org/linux-fsdevel/20190320131642.GE9485@quack2.suse.cz/
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/notify/fanotify/fanotify_user.c | 22 ++++++++++++++++++++++
 fs/proc/root.c                     |  2 +-
 include/linux/fs.h                 |  1 +
 3 files changed, 24 insertions(+), 1 deletion(-)

Changes since v1:
* use type flag to detect filesystems not supporting permission events
* return -EINVAL instead of -EOPNOTSUPP for such filesystems

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index a90bb19dcfa2..91006f47e420 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -920,6 +920,22 @@ static int fanotify_test_fid(struct path *path, __kernel_fsid_t *fsid)
 	return 0;
 }
 
+static int fanotify_events_supported(struct path *path, __u64 mask)
+{
+	/*
+	 * Some filesystems such as 'proc' acquire unusual locks when opening
+	 * files. For them fanotify permission events have high chances of
+	 * deadlocking the system - open done when reporting fanotify event
+	 * blocks on this "unusual" lock while another process holding the lock
+	 * waits for fanotify permission event to be answered. Just disallow
+	 * permission events for such filesystems.
+	 */
+	if (mask & FANOTIFY_PERM_EVENTS &&
+	    path->mnt->mnt_sb->s_type->fs_flags & FS_DISALLOW_NOTIFY_PERM)
+		return -EINVAL;
+	return 0;
+}
+
 static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 			    int dfd, const char  __user *pathname)
 {
@@ -1018,6 +1034,12 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	if (ret)
 		goto fput_and_out;
 
+	if (flags & FAN_MARK_ADD) {
+		ret = fanotify_events_supported(&path, mask);
+		if (ret)
+			goto path_put_and_out;
+	}
+
 	if (FAN_GROUP_FLAG(group, FAN_REPORT_FID)) {
 		ret = fanotify_test_fid(&path, &__fsid);
 		if (ret)
diff --git a/fs/proc/root.c b/fs/proc/root.c
index 8b145e7b9661..522199e9525e 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -211,7 +211,7 @@ static struct file_system_type proc_fs_type = {
 	.init_fs_context	= proc_init_fs_context,
 	.parameters		= &proc_fs_parameters,
 	.kill_sb		= proc_kill_sb,
-	.fs_flags		= FS_USERNS_MOUNT,
+	.fs_flags		= FS_USERNS_MOUNT | FS_DISALLOW_NOTIFY_PERM,
 };
 
 void __init proc_root_init(void)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f7fdfe93e25d..c7136c98b5ba 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2184,6 +2184,7 @@ struct file_system_type {
 #define FS_BINARY_MOUNTDATA	2
 #define FS_HAS_SUBTYPE		4
 #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
+#define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
 	int (*init_fs_context)(struct fs_context *);
 	const struct fs_parameter_description *parameters;
-- 
2.16.4

