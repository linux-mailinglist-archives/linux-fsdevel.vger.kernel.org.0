Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86AB638BC83
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 04:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238635AbhEUCn2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 22:43:28 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54852 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbhEUCn2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 22:43:28 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 511461F43D41
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, "Darrick J . Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>, jack@suse.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH 02/11] fanotify: Split fsid check from other fid mode checks
Date:   Thu, 20 May 2021 22:41:25 -0400
Message-Id: <20210521024134.1032503-3-krisman@collabora.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210521024134.1032503-1-krisman@collabora.com>
References: <20210521024134.1032503-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

FAN_ERROR will require fsid, but not necessarily require the filesystem
to expose a file handle.  Split those checks into different functions, so
they can be used separately when setting up an event.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Changes since v1:
  (Amir)
  - Rename fanotify_check_path_fsid -> fanotify_test_fsid
  - Use dentry directly instead of path
---
 fs/notify/fanotify/fanotify_user.c | 43 ++++++++++++++++++------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 3ccdee3c9f1e..9cc6c8808ed5 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1178,15 +1178,31 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 }
 
 /* Check if filesystem can encode a unique fid */
-static int fanotify_test_fid(struct path *path, __kernel_fsid_t *fsid)
+static int fanotify_test_fid(struct dentry *dentry)
+{
+	/*
+	 * We need to make sure that the file system supports at least
+	 * encoding a file handle so user can use name_to_handle_at() to
+	 * compare fid returned with event to the file handle of watched
+	 * objects. However, name_to_handle_at() requires that the
+	 * filesystem also supports decoding file handles.
+	 */
+	if (!dentry->d_sb->s_export_op ||
+	    !dentry->d_sb->s_export_op->fh_to_dentry)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static int fanotify_test_fsid(struct dentry *dentry, __kernel_fsid_t *fsid)
 {
 	__kernel_fsid_t root_fsid;
 	int err;
 
 	/*
-	 * Make sure path is not in filesystem with zero fsid (e.g. tmpfs).
+	 * Make sure dentry is not of a filesystem with zero fsid (e.g. tmpfs).
 	 */
-	err = vfs_get_fsid(path->dentry, fsid);
+	err = vfs_get_fsid(dentry, fsid);
 	if (err)
 		return err;
 
@@ -1194,10 +1210,10 @@ static int fanotify_test_fid(struct path *path, __kernel_fsid_t *fsid)
 		return -ENODEV;
 
 	/*
-	 * Make sure path is not inside a filesystem subvolume (e.g. btrfs)
+	 * Make sure dentry is not of a filesystem subvolume (e.g. btrfs)
 	 * which uses a different fsid than sb root.
 	 */
-	err = vfs_get_fsid(path->dentry->d_sb->s_root, &root_fsid);
+	err = vfs_get_fsid(dentry->d_sb->s_root, &root_fsid);
 	if (err)
 		return err;
 
@@ -1205,17 +1221,6 @@ static int fanotify_test_fid(struct path *path, __kernel_fsid_t *fsid)
 	    root_fsid.val[1] != fsid->val[1])
 		return -EXDEV;
 
-	/*
-	 * We need to make sure that the file system supports at least
-	 * encoding a file handle so user can use name_to_handle_at() to
-	 * compare fid returned with event to the file handle of watched
-	 * objects. However, name_to_handle_at() requires that the
-	 * filesystem also supports decoding file handles.
-	 */
-	if (!path->dentry->d_sb->s_export_op ||
-	    !path->dentry->d_sb->s_export_op->fh_to_dentry)
-		return -EOPNOTSUPP;
-
 	return 0;
 }
 
@@ -1362,7 +1367,11 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	}
 
 	if (fid_mode) {
-		ret = fanotify_test_fid(&path, &__fsid);
+		ret = fanotify_test_fsid(path.dentry, &__fsid);
+		if (ret)
+			goto path_put_and_out;
+
+		ret = fanotify_test_fid(path.dentry);
 		if (ret)
 			goto path_put_and_out;
 
-- 
2.31.0

