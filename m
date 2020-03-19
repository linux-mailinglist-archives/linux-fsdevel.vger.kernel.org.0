Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6867218BAA0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 16:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbgCSPKq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 11:10:46 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33332 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727470AbgCSPKo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 11:10:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id r7so5012757wmg.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2020 08:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n4QRMUmDbTzXCoJUleJyV2gfRI6X6+6qFC3WMs48hTs=;
        b=DwNdAsPkiPunzbj+ywhrS3uKXyHycVSL4z06jmdPC9jXe5xmomn8wcRGkcuXLbTFeo
         r9p0TTNQkrumuGrMfjWecznRD84OdJxZ05YHwuxonel08cKeuYKhErS+ipUlue4CXpM4
         9ssKzK/uD4ihq4LoGv9QhvgskK1QIRRV7uytJCTvUWOA9rg5isCFCuFRU8Bwy0FdkFwh
         MZZiGSbm679OLSIEPrTXO+60MqBVkmOgT+A7PZafEO9m278QDPTPDAjrcl8Ifib5R/Q+
         LstUuVT/kY7E0mIgVkHoEPmgs1BdyqkWFIHP98LAKYwzFITmZ2kv5WkoN4zinGr9lq+M
         3sLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n4QRMUmDbTzXCoJUleJyV2gfRI6X6+6qFC3WMs48hTs=;
        b=sfCAPyTu322bGFycOFfhNJnX7sGKxpNjhQBPNJPJEoQ257o9AHMBspzb2jJGJrd82L
         5FsPEGW6U6BGczrlQ+XMBjPE0i04UrO0U4vsWh7+w3141aO7RTQ3wrKZXS3uy7TKS2Ig
         tKo/B9ag31CBFJ+BN+WAWkIdRaqUdJylR/AIKaoNeKhhenwtZ+a87dGWPf5h9qixaNZz
         xTP1u6xZ6T13HM6fMP7TR0V/UFHGIrSvVMeU54T7PAkCKH9LjFeotXaZ2jYKaoUUrvT2
         xlj3H2zyx/vdSlnONyEM+pbn7GTICHWBzuXo5WklWI8++Fpy1mTsI0RRlfD6N7GSh24C
         6L0w==
X-Gm-Message-State: ANhLgQ1eB6lHwGDX1HhUdEojvtg7eHH9EGvfVwh9s10VOVGVRbYHKTsd
        hBkutNsbBU61La6cTyzPCxQ=
X-Google-Smtp-Source: ADFU+vtokGSPaLXd74+WAAM0zeuWv8x3WqES9wBTHe1OrtpdTqZPi5WrMviNoKy1+2Cc4uWXPRzygA==
X-Received: by 2002:a1c:5684:: with SMTP id k126mr4369773wmb.181.1584630642269;
        Thu, 19 Mar 2020 08:10:42 -0700 (PDT)
Received: from localhost.localdomain ([141.226.9.174])
        by smtp.gmail.com with ESMTPSA id t193sm3716959wmt.14.2020.03.19.08.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 08:10:41 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 04/14] fsnotify: use helpers to access data by data_type
Date:   Thu, 19 Mar 2020 17:10:12 +0200
Message-Id: <20200319151022.31456-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200319151022.31456-1-amir73il@gmail.com>
References: <20200319151022.31456-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Create helpers to access path and inode from different data types.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c        | 18 +++++++--------
 fs/notify/fsnotify.c                 |  5 ++--
 fs/notify/inotify/inotify_fsnotify.c |  8 +++----
 include/linux/fsnotify_backend.h     | 34 ++++++++++++++++++++++++----
 kernel/audit_fsnotify.c              | 13 ++---------
 kernel/audit_watch.c                 | 16 ++-----------
 6 files changed, 48 insertions(+), 46 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 5778d1347b35..19ec7a4f4d50 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -151,7 +151,7 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 {
 	__u32 marks_mask = 0, marks_ignored_mask = 0;
 	__u32 test_mask, user_mask = FANOTIFY_OUTGOING_EVENTS;
-	const struct path *path = data;
+	const struct path *path = fsnotify_data_path(data, data_type);
 	struct fsnotify_mark *mark;
 	int type;
 
@@ -160,7 +160,7 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 
 	if (!FAN_GROUP_FLAG(group, FAN_REPORT_FID)) {
 		/* Do we have path to open a file descriptor? */
-		if (data_type != FSNOTIFY_EVENT_PATH)
+		if (!path)
 			return 0;
 		/* Path type events are only relevant for files and dirs */
 		if (!d_is_reg(path->dentry) && !d_can_lookup(path->dentry))
@@ -269,11 +269,8 @@ static struct inode *fanotify_fid_inode(struct inode *to_tell, u32 event_mask,
 {
 	if (event_mask & ALL_FSNOTIFY_DIRENT_EVENTS)
 		return to_tell;
-	else if (data_type == FSNOTIFY_EVENT_INODE)
-		return (struct inode *)data;
-	else if (data_type == FSNOTIFY_EVENT_PATH)
-		return d_inode(((struct path *)data)->dentry);
-	return NULL;
+
+	return (struct inode *)fsnotify_data_inode(data, data_type);
 }
 
 struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
@@ -284,6 +281,7 @@ struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 	struct fanotify_event *event = NULL;
 	gfp_t gfp = GFP_KERNEL_ACCOUNT;
 	struct inode *id = fanotify_fid_inode(inode, mask, data, data_type);
+	const struct path *path = fsnotify_data_path(data, data_type);
 
 	/*
 	 * For queues with unlimited length lost events are not expected and
@@ -324,10 +322,10 @@ init: __maybe_unused
 	if (id && FAN_GROUP_FLAG(group, FAN_REPORT_FID)) {
 		/* Report the event without a file identifier on encode error */
 		event->fh_type = fanotify_encode_fid(event, id, gfp, fsid);
-	} else if (data_type == FSNOTIFY_EVENT_PATH) {
+	} else if (path) {
 		event->fh_type = FILEID_ROOT;
-		event->path = *((struct path *)data);
-		path_get(&event->path);
+		event->path = *path;
+		path_get(path);
 	} else {
 		event->fh_type = FILEID_INVALID;
 		event->path.mnt = NULL;
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 46f225580009..a5d6467f89a0 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -318,6 +318,7 @@ static void fsnotify_iter_next(struct fsnotify_iter_info *iter_info)
 int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_is,
 	     const struct qstr *file_name, u32 cookie)
 {
+	const struct path *path = fsnotify_data_path(data, data_is);
 	struct fsnotify_iter_info iter_info = {};
 	struct super_block *sb = to_tell->i_sb;
 	struct mount *mnt = NULL;
@@ -325,8 +326,8 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_is,
 	int ret = 0;
 	__u32 test_mask = (mask & ALL_FSNOTIFY_EVENTS);
 
-	if (data_is == FSNOTIFY_EVENT_PATH) {
-		mnt = real_mount(((const struct path *)data)->mnt);
+	if (path) {
+		mnt = real_mount(path->mnt);
 		mnt_or_sb_mask |= mnt->mnt_fsnotify_mask;
 	}
 	/* An event "on child" is not intended for a mount/sb mark */
diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
index d510223d302c..6bb98522bbfd 100644
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -61,6 +61,7 @@ int inotify_handle_event(struct fsnotify_group *group,
 			 const struct qstr *file_name, u32 cookie,
 			 struct fsnotify_iter_info *iter_info)
 {
+	const struct path *path = fsnotify_data_path(data, data_type);
 	struct fsnotify_mark *inode_mark = fsnotify_iter_inode_mark(iter_info);
 	struct inotify_inode_mark *i_mark;
 	struct inotify_event_info *event;
@@ -73,12 +74,9 @@ int inotify_handle_event(struct fsnotify_group *group,
 		return 0;
 
 	if ((inode_mark->mask & FS_EXCL_UNLINK) &&
-	    (data_type == FSNOTIFY_EVENT_PATH)) {
-		const struct path *path = data;
+	    path && d_unlinked(path->dentry))
+		return 0;
 
-		if (d_unlinked(path->dentry))
-			return 0;
-	}
 	if (file_name) {
 		len = file_name->len;
 		alloc_len += len + 1;
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index db3cabb4600e..5cc838db422a 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -212,10 +212,36 @@ struct fsnotify_group {
 	};
 };
 
-/* when calling fsnotify tell it if the data is a path or inode */
-#define FSNOTIFY_EVENT_NONE	0
-#define FSNOTIFY_EVENT_PATH	1
-#define FSNOTIFY_EVENT_INODE	2
+/* When calling fsnotify tell it if the data is a path or inode */
+enum fsnotify_data_type {
+	FSNOTIFY_EVENT_NONE,
+	FSNOTIFY_EVENT_PATH,
+	FSNOTIFY_EVENT_INODE,
+};
+
+static inline const struct inode *fsnotify_data_inode(const void *data,
+						      int data_type)
+{
+	switch (data_type) {
+	case FSNOTIFY_EVENT_INODE:
+		return data;
+	case FSNOTIFY_EVENT_PATH:
+		return d_inode(((const struct path *)data)->dentry);
+	default:
+		return NULL;
+	}
+}
+
+static inline const struct path *fsnotify_data_path(const void *data,
+						    int data_type)
+{
+	switch (data_type) {
+	case FSNOTIFY_EVENT_PATH:
+		return data;
+	default:
+		return NULL;
+	}
+}
 
 enum fsnotify_obj_type {
 	FSNOTIFY_OBJ_TYPE_INODE,
diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
index f0d243318452..3596448bfdab 100644
--- a/kernel/audit_fsnotify.c
+++ b/kernel/audit_fsnotify.c
@@ -160,23 +160,14 @@ static int audit_mark_handle_event(struct fsnotify_group *group,
 {
 	struct fsnotify_mark *inode_mark = fsnotify_iter_inode_mark(iter_info);
 	struct audit_fsnotify_mark *audit_mark;
-	const struct inode *inode = NULL;
+	const struct inode *inode = fsnotify_data_inode(data, data_type);
 
 	audit_mark = container_of(inode_mark, struct audit_fsnotify_mark, mark);
 
 	BUG_ON(group != audit_fsnotify_group);
 
-	switch (data_type) {
-	case (FSNOTIFY_EVENT_PATH):
-		inode = ((const struct path *)data)->dentry->d_inode;
-		break;
-	case (FSNOTIFY_EVENT_INODE):
-		inode = (const struct inode *)data;
-		break;
-	default:
-		BUG();
+	if (WARN_ON(!inode))
 		return 0;
-	}
 
 	if (mask & (FS_CREATE|FS_MOVED_TO|FS_DELETE|FS_MOVED_FROM)) {
 		if (audit_compare_dname_path(dname, audit_mark->path, AUDIT_NAME_FULL))
diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 4508d5e0cf69..dcfbb44c6720 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -473,25 +473,13 @@ static int audit_watch_handle_event(struct fsnotify_group *group,
 				    struct fsnotify_iter_info *iter_info)
 {
 	struct fsnotify_mark *inode_mark = fsnotify_iter_inode_mark(iter_info);
-	const struct inode *inode;
+	const struct inode *inode = fsnotify_data_inode(data, data_type);
 	struct audit_parent *parent;
 
 	parent = container_of(inode_mark, struct audit_parent, mark);
 
 	BUG_ON(group != audit_watch_group);
-
-	switch (data_type) {
-	case (FSNOTIFY_EVENT_PATH):
-		inode = d_backing_inode(((const struct path *)data)->dentry);
-		break;
-	case (FSNOTIFY_EVENT_INODE):
-		inode = (const struct inode *)data;
-		break;
-	default:
-		BUG();
-		inode = NULL;
-		break;
-	}
+	WARN_ON(!inode);
 
 	if (mask & (FS_CREATE|FS_MOVED_TO) && inode)
 		audit_update_watch(parent, dname, inode->i_sb->s_dev, inode->i_ino, 0);
-- 
2.17.1

