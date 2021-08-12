Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF343EAC93
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 23:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237838AbhHLVl3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 17:41:29 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45752 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhHLVl3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 17:41:29 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 1077D1F44220
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com, jack@suse.com
Cc:     linux-api@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, khazhy@google.com,
        dhowells@redhat.com, david@fromorbit.com, tytso@mit.edu,
        djwong@kernel.org, repnop@google.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v6 09/21] fsnotify: Allow events reported with an empty inode
Date:   Thu, 12 Aug 2021 17:39:58 -0400
Message-Id: <20210812214010.3197279-10-krisman@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210812214010.3197279-1-krisman@collabora.com>
References: <20210812214010.3197279-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some file system events (i.e. FS_ERROR) might not be associated with an
inode.  For these, it makes sense to associate them directly with the
super block of the file system they apply to.  This patch allows the
event to be reported with a NULL inode, by recovering the superblock
directly from the data field, if needed.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

--
Changes since v5:
  - add fsnotify_data_sb handle to retrieve sb from the data field. (jan)
---
 fs/notify/fsnotify.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 30d422b8c0fc..536db02cb26e 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -98,6 +98,14 @@ void fsnotify_sb_delete(struct super_block *sb)
 	fsnotify_clear_marks_by_sb(sb);
 }
 
+static struct super_block *fsnotify_data_sb(const void *data, int data_type)
+{
+	struct inode *inode = fsnotify_data_inode(data, data_type);
+	struct super_block *sb = inode ? inode->i_sb : NULL;
+
+	return sb;
+}
+
 /*
  * Given an inode, first check if we care what happens to our children.  Inotify
  * and dnotify both tell their parents about events.  If we care about any event
@@ -455,8 +463,10 @@ static void fsnotify_iter_next(struct fsnotify_iter_info *iter_info)
  *		@file_name is relative to
  * @file_name:	optional file name associated with event
  * @inode:	optional inode associated with event -
- *		either @dir or @inode must be non-NULL.
- *		if both are non-NULL event may be reported to both.
+ *		If @dir and @inode are NULL, @data must have a type that
+ *		allows retrieving the file system associated with this
+ *		event.  if both are non-NULL event may be reported to
+ *		both.
  * @cookie:	inotify rename cookie
  */
 int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
@@ -483,7 +493,7 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 		 */
 		parent = dir;
 	}
-	sb = inode->i_sb;
+	sb = inode ? inode->i_sb : fsnotify_data_sb(data, data_type);
 
 	/*
 	 * Optimization: srcu_read_lock() has a memory barrier which can
-- 
2.32.0

