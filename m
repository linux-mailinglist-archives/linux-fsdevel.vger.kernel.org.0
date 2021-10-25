Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 549A143A3FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 22:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236003AbhJYULv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 16:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237091AbhJYULm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 16:11:42 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F44C04A40B;
        Mon, 25 Oct 2021 12:30:07 -0700 (PDT)
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1002])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id DAF311F41704;
        Mon, 25 Oct 2021 20:29:11 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com, jack@suse.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v9 11/31] fsnotify: Protect fsnotify_handle_inode_event from no-inode events
Date:   Mon, 25 Oct 2021 16:27:26 -0300
Message-Id: <20211025192746.66445-12-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211025192746.66445-1-krisman@collabora.com>
References: <20211025192746.66445-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

FAN_FS_ERROR allows events without inodes - i.e. for file system-wide
errors.  Even though fsnotify_handle_inode_event is not currently used
by fanotify, this patch protects other backends from cases where neither
inode or dir are provided.  Also document the constraints of the
interface (inode and dir cannot be both NULL).

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v8:
  - Convert verifications to WARN_ON
  - Require either inode or dir
  - Protect nfsd backend from !inode.
---
 fs/nfsd/filecache.c              | 3 +++
 fs/notify/fsnotify.c             | 3 +++
 include/linux/fsnotify_backend.h | 1 +
 3 files changed, 7 insertions(+)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index be3c1aad50ea..fdf89fcf1a0c 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -602,6 +602,9 @@ nfsd_file_fsnotify_handle_event(struct fsnotify_mark *mark, u32 mask,
 				struct inode *inode, struct inode *dir,
 				const struct qstr *name, u32 cookie)
 {
+	if (WARN_ON_ONCE(!inode))
+		return 0;
+
 	trace_nfsd_file_fsnotify_handle_event(inode, mask);
 
 	/* Should be no marks on non-regular files */
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index fde3a1115a17..4034ca566f95 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -252,6 +252,9 @@ static int fsnotify_handle_inode_event(struct fsnotify_group *group,
 	if (WARN_ON_ONCE(!ops->handle_inode_event))
 		return 0;
 
+	if (WARN_ON_ONCE(!inode && !dir))
+		return 0;
+
 	if ((inode_mark->mask & FS_EXCL_UNLINK) &&
 	    path && d_unlinked(path->dentry))
 		return 0;
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 035438fe4a43..b71dc788018e 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -136,6 +136,7 @@ struct mem_cgroup;
  * @dir:	optional directory associated with event -
  *		if @file_name is not NULL, this is the directory that
  *		@file_name is relative to.
+ *		Either @inode or @dir must be non-NULL.
  * @file_name:	optional file name associated with event
  * @cookie:	inotify rename cookie
  *
-- 
2.33.0

