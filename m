Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4AB1612EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 14:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgBQNPS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 08:15:18 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37442 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729078AbgBQNPP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 08:15:15 -0500
Received: by mail-wm1-f68.google.com with SMTP id a6so18437669wme.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Feb 2020 05:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n4QRMUmDbTzXCoJUleJyV2gfRI6X6+6qFC3WMs48hTs=;
        b=d/4f7Htv6BZDv0ad9/o6CAdSiR6dAT+XGqZft9zdaJoTrmG6/Lo8+/UFxwxH0bhTyx
         7kGYh0CPPuGTZYUc5u0m++NjQpjz512z5HroArnSF06jK7o1EoIrnCA8HRodiXcnah7W
         HerVZjdfQF78oW9v/wdLz0hHg5qzxv+ISq29MIxNAXyibj1yLFrSY0MlaSS2xd4odR1V
         tfUAGbZxEM+Hrk1H2pIpvRGejsfLIbocMwQFPJHn5iI1bVhEcC+xtvvIoHjT7nUtzUnt
         BAkSWP0NTfDPgB3cmvT6kWN2FGwyouprdifMM/fwSYfvHUcIYo1dLsEZe0a4v10O9tDW
         +kMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n4QRMUmDbTzXCoJUleJyV2gfRI6X6+6qFC3WMs48hTs=;
        b=W6582gAgQT1RcK3TXLBvKvEz960E65hIV6ai010vFM9gRblszX9B2yWUTRiJEJG8CR
         Hcm3ZEOQ5RnlFx3OSWHzB8ZDX4Dj6tee5KAivn/cu42AmJ1/wqds8iElyknr46qSVMwU
         LiCeoHrMeOj7C7OvCuSSEH1YncWZsPAf6tFffy9F50O+NuSvAqBrXmYDaonekMp7YN7Y
         TaGeAuYEhJBLSYJkIN5J6t9c+EGVn4UDQjzMO4gAyYm5ohfKptICnjl4CT7q9KFF0jmc
         yBiNsAFHyVQEtKpoQYYd3fZwe1R178AVPxdkZGU3PUs4ntDIMbRZqZqzjCUtc66r56bQ
         mPXA==
X-Gm-Message-State: APjAAAV99WhhAz6c+Avefz64AcMg8nRuPseac+jTHzvT2x5ht0NY/bkn
        DCRQUCuDg9l5Qwk2G6uqU7Q=
X-Google-Smtp-Source: APXvYqzla1EsEDnm+gbQE/y79h0xzllejg1rAGULRMtldn/Ctjyuol10rpChNivGLz7ED4QSrfvvOQ==
X-Received: by 2002:a1c:7717:: with SMTP id t23mr23188802wmi.17.1581945312032;
        Mon, 17 Feb 2020 05:15:12 -0800 (PST)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id m21sm545745wmi.27.2020.02.17.05.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 05:15:11 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 04/16] fsnotify: use helpers to access data by data_type
Date:   Mon, 17 Feb 2020 15:14:43 +0200
Message-Id: <20200217131455.31107-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200217131455.31107-1-amir73il@gmail.com>
References: <20200217131455.31107-1-amir73il@gmail.com>
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

