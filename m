Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 566C84624AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 23:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbhK2WXu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 17:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbhK2WV6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:21:58 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FD5C06FD45
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Nov 2021 12:15:43 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id u1so39365328wru.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Nov 2021 12:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S3xkXI66FUITlnTTENCUvJGEeLsgGrZszkNeqbeQg18=;
        b=mY+T3kD2y5SW0FmMt1F+1gtb3pIKJ6QyHME5Nn79NZJKUTJW9BplbddzLOV3ZXCpoI
         e3ji0z+POiLwgaRSild78j3jMLAlp88+imaNgzFufwxdt/6ptyKzsORi7VVjar0P2cWo
         oda8mPom5QCungWbUGolSnZMeGUdFx1nzxxMTkX9iG9X/haOnlmP2C4Ae0wxaSmDSY9Q
         nQZeLtLwrUz1LJm35vSkVakCM/a1slcpthuUmlns87fwTyBtyGUBSczwOtp3VcJ4Jdii
         HG6hq+xU7o59y+T9Lf5TGWaYiB3I4ptVXbITgM0GVnQswpr+PLwyj5L08PvcmnSzzPzh
         emTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S3xkXI66FUITlnTTENCUvJGEeLsgGrZszkNeqbeQg18=;
        b=CugODtBSmQ1+fB/E6MXyqWbaH8cMoe20BNy3Vns3b/K2Pf40z1Khlw48RrXrMzkJPs
         83+AzoVmnZ6G6KMxAJQ7UJekH9LFOkn1/BOVZAiEA5eNQXuMiFZYr85+ffaZnZ3XPbVx
         +VSZ277z+TqWLeya1lLr7bzpFCTyYI0FWW74zZzPIrx7CjOCwbb9zkDNS3/o/bSF9WCz
         OU6rrn9kFhggSNoofR8oGmtkVcGHEj5keW5VVg6KTTxnz60b1b7AEMX2Y7+vdsh1tgdR
         FgApcpmtWng9DoQXWM/10pdAsbtjDdEkWx1/HnHRSvPZWlU2nQLmE4+nFnnZ82pkd9fi
         hWFA==
X-Gm-Message-State: AOAM533fE92+vou4nmqhZbWyXUH1KlNtr02sRMrz+Rbrql59uLicb9OY
        r2iREtjUOpe7t056goZpFCZ0ua+RLic=
X-Google-Smtp-Source: ABdhPJyELuOFc4QT6mGm634wv7q7Wlgd/HDdef7j1pEp0liEtCQejx+myoifNX6GZfYdgvLOQ7Ub+Q==
X-Received: by 2002:adf:df89:: with SMTP id z9mr36227620wrl.336.1638216941543;
        Mon, 29 Nov 2021 12:15:41 -0800 (PST)
Received: from localhost.localdomain ([82.114.45.86])
        by smtp.gmail.com with ESMTPSA id m14sm19791830wrp.28.2021.11.29.12.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 12:15:41 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 01/11] fsnotify: clarify object type argument
Date:   Mon, 29 Nov 2021 22:15:27 +0200
Message-Id: <20211129201537.1932819-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211129201537.1932819-1-amir73il@gmail.com>
References: <20211129201537.1932819-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In preparation for separating object type from iterator type, rename
some 'type' arguments in functions to 'obj_type' and remove the unused
interface to clear marks by object type mask.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify_user.c |  8 ++++----
 fs/notify/group.c                  |  2 +-
 fs/notify/mark.c                   | 27 +++++++++++++++------------
 include/linux/fsnotify_backend.h   | 28 ++++++++++++----------------
 4 files changed, 32 insertions(+), 33 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 559bc1e9926d..ab24c37f1fdf 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1057,7 +1057,7 @@ static __u32 fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
 
 static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
 						   fsnotify_connp_t *connp,
-						   unsigned int type,
+						   unsigned int obj_type,
 						   __kernel_fsid_t *fsid)
 {
 	struct ucounts *ucounts = group->fanotify_data.ucounts;
@@ -1080,7 +1080,7 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
 	}
 
 	fsnotify_init_mark(mark, group);
-	ret = fsnotify_add_mark_locked(mark, connp, type, 0, fsid);
+	ret = fsnotify_add_mark_locked(mark, connp, obj_type, 0, fsid);
 	if (ret) {
 		fsnotify_put_mark(mark);
 		goto out_dec_ucounts;
@@ -1105,7 +1105,7 @@ static int fanotify_group_init_error_pool(struct fsnotify_group *group)
 }
 
 static int fanotify_add_mark(struct fsnotify_group *group,
-			     fsnotify_connp_t *connp, unsigned int type,
+			     fsnotify_connp_t *connp, unsigned int obj_type,
 			     __u32 mask, unsigned int flags,
 			     __kernel_fsid_t *fsid)
 {
@@ -1116,7 +1116,7 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 	mutex_lock(&group->mark_mutex);
 	fsn_mark = fsnotify_find_mark(connp, group);
 	if (!fsn_mark) {
-		fsn_mark = fanotify_add_new_mark(group, connp, type, fsid);
+		fsn_mark = fanotify_add_new_mark(group, connp, obj_type, fsid);
 		if (IS_ERR(fsn_mark)) {
 			mutex_unlock(&group->mark_mutex);
 			return PTR_ERR(fsn_mark);
diff --git a/fs/notify/group.c b/fs/notify/group.c
index 6a297efc4788..b7d4d64f87c2 100644
--- a/fs/notify/group.c
+++ b/fs/notify/group.c
@@ -58,7 +58,7 @@ void fsnotify_destroy_group(struct fsnotify_group *group)
 	fsnotify_group_stop_queueing(group);
 
 	/* Clear all marks for this group and queue them for destruction */
-	fsnotify_clear_marks_by_group(group, FSNOTIFY_OBJ_ALL_TYPES_MASK);
+	fsnotify_clear_marks_by_group(group, FSNOTIFY_OBJ_TYPE_ANY);
 
 	/*
 	 * Some marks can still be pinned when waiting for response from
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index fa1d99101f89..52af2e9dadc0 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -496,7 +496,7 @@ int fsnotify_compare_groups(struct fsnotify_group *a, struct fsnotify_group *b)
 }
 
 static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
-					       unsigned int type,
+					       unsigned int obj_type,
 					       __kernel_fsid_t *fsid)
 {
 	struct inode *inode = NULL;
@@ -507,7 +507,7 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
 		return -ENOMEM;
 	spin_lock_init(&conn->lock);
 	INIT_HLIST_HEAD(&conn->list);
-	conn->type = type;
+	conn->type = obj_type;
 	conn->obj = connp;
 	/* Cache fsid of filesystem containing the object */
 	if (fsid) {
@@ -572,7 +572,8 @@ static struct fsnotify_mark_connector *fsnotify_grab_connector(
  * priority, highest number first, and then by the group's location in memory.
  */
 static int fsnotify_add_mark_list(struct fsnotify_mark *mark,
-				  fsnotify_connp_t *connp, unsigned int type,
+				  fsnotify_connp_t *connp,
+				  unsigned int obj_type,
 				  int allow_dups, __kernel_fsid_t *fsid)
 {
 	struct fsnotify_mark *lmark, *last = NULL;
@@ -580,7 +581,7 @@ static int fsnotify_add_mark_list(struct fsnotify_mark *mark,
 	int cmp;
 	int err = 0;
 
-	if (WARN_ON(!fsnotify_valid_obj_type(type)))
+	if (WARN_ON(!fsnotify_valid_obj_type(obj_type)))
 		return -EINVAL;
 
 	/* Backend is expected to check for zero fsid (e.g. tmpfs) */
@@ -592,7 +593,8 @@ static int fsnotify_add_mark_list(struct fsnotify_mark *mark,
 	conn = fsnotify_grab_connector(connp);
 	if (!conn) {
 		spin_unlock(&mark->lock);
-		err = fsnotify_attach_connector_to_object(connp, type, fsid);
+		err = fsnotify_attach_connector_to_object(connp, obj_type,
+							  fsid);
 		if (err)
 			return err;
 		goto restart;
@@ -665,7 +667,7 @@ static int fsnotify_add_mark_list(struct fsnotify_mark *mark,
  * event types should be delivered to which group.
  */
 int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
-			     fsnotify_connp_t *connp, unsigned int type,
+			     fsnotify_connp_t *connp, unsigned int obj_type,
 			     int allow_dups, __kernel_fsid_t *fsid)
 {
 	struct fsnotify_group *group = mark->group;
@@ -686,7 +688,7 @@ int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
 	fsnotify_get_mark(mark); /* for g_list */
 	spin_unlock(&mark->lock);
 
-	ret = fsnotify_add_mark_list(mark, connp, type, allow_dups, fsid);
+	ret = fsnotify_add_mark_list(mark, connp, obj_type, allow_dups, fsid);
 	if (ret)
 		goto err;
 
@@ -706,13 +708,14 @@ int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
 }
 
 int fsnotify_add_mark(struct fsnotify_mark *mark, fsnotify_connp_t *connp,
-		      unsigned int type, int allow_dups, __kernel_fsid_t *fsid)
+		      unsigned int obj_type, int allow_dups,
+		      __kernel_fsid_t *fsid)
 {
 	int ret;
 	struct fsnotify_group *group = mark->group;
 
 	mutex_lock(&group->mark_mutex);
-	ret = fsnotify_add_mark_locked(mark, connp, type, allow_dups, fsid);
+	ret = fsnotify_add_mark_locked(mark, connp, obj_type, allow_dups, fsid);
 	mutex_unlock(&group->mark_mutex);
 	return ret;
 }
@@ -747,14 +750,14 @@ EXPORT_SYMBOL_GPL(fsnotify_find_mark);
 
 /* Clear any marks in a group with given type mask */
 void fsnotify_clear_marks_by_group(struct fsnotify_group *group,
-				   unsigned int type_mask)
+				   unsigned int obj_type)
 {
 	struct fsnotify_mark *lmark, *mark;
 	LIST_HEAD(to_free);
 	struct list_head *head = &to_free;
 
 	/* Skip selection step if we want to clear all marks. */
-	if (type_mask == FSNOTIFY_OBJ_ALL_TYPES_MASK) {
+	if (obj_type == FSNOTIFY_OBJ_TYPE_ANY) {
 		head = &group->marks_list;
 		goto clear;
 	}
@@ -769,7 +772,7 @@ void fsnotify_clear_marks_by_group(struct fsnotify_group *group,
 	 */
 	mutex_lock_nested(&group->mark_mutex, SINGLE_DEPTH_NESTING);
 	list_for_each_entry_safe(mark, lmark, &group->marks_list, g_list) {
-		if ((1U << mark->connector->type) & type_mask)
+		if (mark->connector->type == obj_type)
 			list_move(&mark->g_list, &to_free);
 	}
 	mutex_unlock(&group->mark_mutex);
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 51ef2b079bfa..b9c84b1dbcc8 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -338,6 +338,7 @@ static inline struct fs_error_report *fsnotify_data_error_report(
 }
 
 enum fsnotify_obj_type {
+	FSNOTIFY_OBJ_TYPE_ANY = -1,
 	FSNOTIFY_OBJ_TYPE_INODE,
 	FSNOTIFY_OBJ_TYPE_PARENT,
 	FSNOTIFY_OBJ_TYPE_VFSMOUNT,
@@ -346,15 +347,9 @@ enum fsnotify_obj_type {
 	FSNOTIFY_OBJ_TYPE_DETACHED = FSNOTIFY_OBJ_TYPE_COUNT
 };
 
-#define FSNOTIFY_OBJ_TYPE_INODE_FL	(1U << FSNOTIFY_OBJ_TYPE_INODE)
-#define FSNOTIFY_OBJ_TYPE_PARENT_FL	(1U << FSNOTIFY_OBJ_TYPE_PARENT)
-#define FSNOTIFY_OBJ_TYPE_VFSMOUNT_FL	(1U << FSNOTIFY_OBJ_TYPE_VFSMOUNT)
-#define FSNOTIFY_OBJ_TYPE_SB_FL		(1U << FSNOTIFY_OBJ_TYPE_SB)
-#define FSNOTIFY_OBJ_ALL_TYPES_MASK	((1U << FSNOTIFY_OBJ_TYPE_COUNT) - 1)
-
-static inline bool fsnotify_valid_obj_type(unsigned int type)
+static inline bool fsnotify_valid_obj_type(unsigned int obj_type)
 {
-	return (type < FSNOTIFY_OBJ_TYPE_COUNT);
+	return (obj_type < FSNOTIFY_OBJ_TYPE_COUNT);
 }
 
 struct fsnotify_iter_info {
@@ -387,7 +382,7 @@ static inline void fsnotify_iter_set_report_type_mark(
 static inline struct fsnotify_mark *fsnotify_iter_##name##_mark( \
 		struct fsnotify_iter_info *iter_info) \
 { \
-	return (iter_info->report_mask & FSNOTIFY_OBJ_TYPE_##NAME##_FL) ? \
+	return (iter_info->report_mask & (1U << FSNOTIFY_OBJ_TYPE_##NAME)) ? \
 		iter_info->marks[FSNOTIFY_OBJ_TYPE_##NAME] : NULL; \
 }
 
@@ -604,11 +599,11 @@ extern int fsnotify_get_conn_fsid(const struct fsnotify_mark_connector *conn,
 				  __kernel_fsid_t *fsid);
 /* attach the mark to the object */
 extern int fsnotify_add_mark(struct fsnotify_mark *mark,
-			     fsnotify_connp_t *connp, unsigned int type,
+			     fsnotify_connp_t *connp, unsigned int obj_type,
 			     int allow_dups, __kernel_fsid_t *fsid);
 extern int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
 				    fsnotify_connp_t *connp,
-				    unsigned int type, int allow_dups,
+				    unsigned int obj_type, int allow_dups,
 				    __kernel_fsid_t *fsid);
 
 /* attach the mark to the inode */
@@ -637,22 +632,23 @@ extern void fsnotify_detach_mark(struct fsnotify_mark *mark);
 extern void fsnotify_free_mark(struct fsnotify_mark *mark);
 /* Wait until all marks queued for destruction are destroyed */
 extern void fsnotify_wait_marks_destroyed(void);
-/* run all the marks in a group, and clear all of the marks attached to given object type */
-extern void fsnotify_clear_marks_by_group(struct fsnotify_group *group, unsigned int type);
+/* Clear all of the marks of a group attached to a given object type */
+extern void fsnotify_clear_marks_by_group(struct fsnotify_group *group,
+					  unsigned int obj_type);
 /* run all the marks in a group, and clear all of the vfsmount marks */
 static inline void fsnotify_clear_vfsmount_marks_by_group(struct fsnotify_group *group)
 {
-	fsnotify_clear_marks_by_group(group, FSNOTIFY_OBJ_TYPE_VFSMOUNT_FL);
+	fsnotify_clear_marks_by_group(group, FSNOTIFY_OBJ_TYPE_VFSMOUNT);
 }
 /* run all the marks in a group, and clear all of the inode marks */
 static inline void fsnotify_clear_inode_marks_by_group(struct fsnotify_group *group)
 {
-	fsnotify_clear_marks_by_group(group, FSNOTIFY_OBJ_TYPE_INODE_FL);
+	fsnotify_clear_marks_by_group(group, FSNOTIFY_OBJ_TYPE_INODE);
 }
 /* run all the marks in a group, and clear all of the sn marks */
 static inline void fsnotify_clear_sb_marks_by_group(struct fsnotify_group *group)
 {
-	fsnotify_clear_marks_by_group(group, FSNOTIFY_OBJ_TYPE_SB_FL);
+	fsnotify_clear_marks_by_group(group, FSNOTIFY_OBJ_TYPE_SB);
 }
 extern void fsnotify_get_mark(struct fsnotify_mark *mark);
 extern void fsnotify_put_mark(struct fsnotify_mark *mark);
-- 
2.33.1

