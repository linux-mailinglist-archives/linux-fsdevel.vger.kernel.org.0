Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF4DD3B7851
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 21:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235471AbhF2TOp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 15:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234228AbhF2TOn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 15:14:43 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D414C061760;
        Tue, 29 Jun 2021 12:12:15 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id EDDD81F431AF
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        jack@suse.com, dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v3 03/15] fanotify: Split fsid check from other fid mode checks
Date:   Tue, 29 Jun 2021 15:10:23 -0400
Message-Id: <20210629191035.681913-4-krisman@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210629191035.681913-1-krisman@collabora.com>
References: <20210629191035.681913-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

FAN_FS_ERROR will require fsid, but not necessarily require the
filesystem to expose a file handle.  Split those checks into different
functions, so they can be used separately when setting up an event.

While there, update a comment about tmpfs having 0 fsid, which is no
longer true.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v2:
  - FAN_ERROR -> FAN_FS_ERROR (Amir)
  - Update comment (Amir)

Changes since v1:
  (Amir)
  - Sort hunks to simplify diff.
Changes since RFC:
  (Amir)
  - Rename fanotify_check_path_fsid -> fanotify_test_fsid.
  - Use dentry directly instead of path.
---
 fs/notify/fanotify/fanotify_user.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 68a53d3534f8..67b18dfe0025 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1192,16 +1192,15 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	return fd;
 }
 
-/* Check if filesystem can encode a unique fid */
-static int fanotify_test_fid(struct path *path, __kernel_fsid_t *fsid)
+static int fanotify_test_fsid(struct dentry *dentry, __kernel_fsid_t *fsid)
 {
 	__kernel_fsid_t root_fsid;
 	int err;
 
 	/*
-	 * Make sure path is not in filesystem with zero fsid (e.g. tmpfs).
+	 * Make sure dentry is not of a filesystem with zero fsid (e.g. fuse).
 	 */
-	err = vfs_get_fsid(path->dentry, fsid);
+	err = vfs_get_fsid(dentry, fsid);
 	if (err)
 		return err;
 
@@ -1209,10 +1208,10 @@ static int fanotify_test_fid(struct path *path, __kernel_fsid_t *fsid)
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
 
@@ -1220,6 +1219,12 @@ static int fanotify_test_fid(struct path *path, __kernel_fsid_t *fsid)
 	    root_fsid.val[1] != fsid->val[1])
 		return -EXDEV;
 
+	return 0;
+}
+
+/* Check if filesystem can encode a unique fid */
+static int fanotify_test_fid(struct dentry *dentry)
+{
 	/*
 	 * We need to make sure that the file system supports at least
 	 * encoding a file handle so user can use name_to_handle_at() to
@@ -1227,8 +1232,8 @@ static int fanotify_test_fid(struct path *path, __kernel_fsid_t *fsid)
 	 * objects. However, name_to_handle_at() requires that the
 	 * filesystem also supports decoding file handles.
 	 */
-	if (!path->dentry->d_sb->s_export_op ||
-	    !path->dentry->d_sb->s_export_op->fh_to_dentry)
+	if (!dentry->d_sb->s_export_op ||
+	    !dentry->d_sb->s_export_op->fh_to_dentry)
 		return -EOPNOTSUPP;
 
 	return 0;
@@ -1379,7 +1384,11 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
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
2.32.0

