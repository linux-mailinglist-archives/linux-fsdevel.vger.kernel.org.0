Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 151E336B92B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 20:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239355AbhDZSnV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 14:43:21 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47414 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239301AbhDZSnK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:43:10 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 8C38B1F41E27
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com, tytso@mit.edu, djwong@kernel.org
Cc:     david@fromorbit.com, jack@suse.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH RFC 02/15] fanotify: Split fsid check from other fid mode checks
Date:   Mon, 26 Apr 2021 14:41:48 -0400
Message-Id: <20210426184201.4177978-3-krisman@collabora.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426184201.4177978-1-krisman@collabora.com>
References: <20210426184201.4177978-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

FAN_ERROR will require fsid, but not necessarily require the filesystem
to expose a file handle.  Split those checks into different functions, so
they can be used separately when creating a mark.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/notify/fanotify/fanotify_user.c | 35 +++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 0332c4afeec3..e0d113e3b65c 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1055,7 +1055,23 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 }
 
 /* Check if filesystem can encode a unique fid */
-static int fanotify_test_fid(struct path *path, __kernel_fsid_t *fsid)
+static int fanotify_test_fid(struct path *path)
+{
+	/*
+	 * We need to make sure that the file system supports at least
+	 * encoding a file handle so user can use name_to_handle_at() to
+	 * compare fid returned with event to the file handle of watched
+	 * objects. However, name_to_handle_at() requires that the
+	 * filesystem also supports decoding file handles.
+	 */
+	if (!path->dentry->d_sb->s_export_op ||
+	    !path->dentry->d_sb->s_export_op->fh_to_dentry)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static int fanotify_check_path_fsid(struct path *path, __kernel_fsid_t *fsid)
 {
 	__kernel_fsid_t root_fsid;
 	int err;
@@ -1082,17 +1098,6 @@ static int fanotify_test_fid(struct path *path, __kernel_fsid_t *fsid)
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
 
@@ -1230,7 +1235,11 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	}
 
 	if (fid_mode) {
-		ret = fanotify_test_fid(&path, &__fsid);
+		ret = fanotify_check_path_fsid(&path, &__fsid);
+		if (ret)
+			goto path_put_and_out;
+
+		ret = fanotify_test_fid(&path);
 		if (ret)
 			goto path_put_and_out;
 
-- 
2.31.0

