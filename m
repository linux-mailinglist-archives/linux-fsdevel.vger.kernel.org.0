Return-Path: <linux-fsdevel+bounces-14647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 374BE87DF47
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 19:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5673D1C20954
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 18:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F815208B0;
	Sun, 17 Mar 2024 18:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRb9NHh+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E26A1EB56
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 Mar 2024 18:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710700931; cv=none; b=ksMy57YdKaB/MhL3HZfQZgFbUTASPAe6getKzsmwv9t+Q7mdKf+QpR1QoDZoPY5Ik1/HZyW7qu+gf0Me06Uzc92HzbigPpfbsHPpT9aSuPfwcabqbIaePy31tUHWo0iAYTRrevz6XIhy8FdjcpaigW1sVmSa0EUvCGfuEl+DMU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710700931; c=relaxed/simple;
	bh=HNr4SEq4yF1lweywo4gIOr6Mnt8nrkXaXA0Q1jhR6sU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iIhUZSbocdAxH9TNhf2L66mOqiJzET5aV5m4JGPqYTR851ki2yX28gtFEfH2qHWmlJ8lkydTmHVsgebhEUocW4vw4SuHw66l4q2ycYMZSY6hKr9VaBsmnn0+Vx4Fc7U62J8StuvOWZl3wMIlNlIqkfkWDKIlly0aDb2h3iCV48I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRb9NHh+; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d228a132acso52800431fa.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Mar 2024 11:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710700927; x=1711305727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RbDDBVLUDDDrRFK+L5NrbvDesHycQn7TRBEkG1epLmc=;
        b=fRb9NHh+J7yhd52N4+t1vf13NIBO11cwDxtdD79BLU0BzDVhjRe/wY/3ilnO4WZB75
         cPQKjfrgrxJAfUBPXcIeQVlLhoLFdNjFuYGDOeIzaMRdC85nYHTD+YAWdlqFR+RuXPPU
         mNtGT4q2oood+9emgzHwDqbXH7qS5lBLFmalKusu9Yjh0dssV24TPOaaCDj3Qr5xKtiM
         X1TNF+3izAhnJzo2D5LgNIbT0HKfsbI3MRoG4dPp6/dxb2cLp4Ncz/B9U4sLDxvDupSt
         4riLxvnn4MdxoMSNME3PV1h/tQ2Z7/xDnl6MwzAPfZHti9qpR5nmFFlRfZpaNDJos2Uu
         W3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710700927; x=1711305727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RbDDBVLUDDDrRFK+L5NrbvDesHycQn7TRBEkG1epLmc=;
        b=Zx/TiJqo2TyTEnvCzRN45tdhVnUrnn7MfSmSBFuGKexeObXaRnfHoDn6luFY4gAImw
         LdJaS33VuiAmTRY9rBWIIX84NJUx9VdMuE8H9ozkqEfzVy4hJDwnbd1ilGWAnKrEqVhW
         d+1YDqfumLeb/Nseha4PWgrtmOlSv0VAr4iJH4wk8weq+FQCzsUXHutquTboDeMeCoun
         nAi08My5Rz5dprsCjeHFqZLPnXkR3JtUkt+t+o8jrA6YVixHevrp9S9Zr3n077fxuo0g
         oWKaipUdWpg1atBluV3e0yuGSuHA7Wb2sSTIwvj81tw+XRnwXyWJGloPvZO2sQZL0Yp3
         ER+A==
X-Forwarded-Encrypted: i=1; AJvYcCX019HsNzqs8uBYu6z0+PwtpwhplN+YdEuMLjWfAcMAz6mqNdZmf8ZAKpbsTtuTpaP73X7HvilkNywFmCIulLmyf3Rwtf6w9+vyvNIVcw==
X-Gm-Message-State: AOJu0YzYuunVEAwaBlQjthmLrnuU1ARsZrUBRzxgS3wYFzE2VfseLLEv
	WTHs/ot8QjsfQlFfKcZCwQ7MtgZ56qrjD1Lkip8bkiWjKrGDWVfuTGIjV0Q3
X-Google-Smtp-Source: AGHT+IF1eskHadbIwcOk0paIQr4VL6wZxd75LNeCJtQyoIDDZ+JKAYV62DGIDJyxtUf4XJ68NUXCNA==
X-Received: by 2002:a2e:b1c2:0:b0:2d2:df0d:9e92 with SMTP id e2-20020a2eb1c2000000b002d2df0d9e92mr5498409lja.49.1710700927249;
        Sun, 17 Mar 2024 11:42:07 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan (85-250-214-4.bb.netvision.net.il. [85.250.214.4])
        by smtp.gmail.com with ESMTPSA id bk28-20020a0560001d9c00b0033e22a7b3f8sm3070716wrb.75.2024.03.17.11.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 11:42:06 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/10] fsnotify: pass object pointer and type to fsnotify mark helpers
Date: Sun, 17 Mar 2024 20:41:49 +0200
Message-Id: <20240317184154.1200192-6-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240317184154.1200192-1-amir73il@gmail.com>
References: <20240317184154.1200192-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of passing fsnotify_connp_t, pass the pointer to the marked
object.

Store the object pointer in the connector and move the definition of
fsnotify_connp_t to internal fsnotify subsystem API, so it is no longer
used by fsnotify backends.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify_user.c | 95 +++++++-----------------------
 fs/notify/fsnotify.h               | 23 ++++----
 fs/notify/mark.c                   | 28 +++++----
 include/linux/fsnotify_backend.h   | 33 ++++-------
 4 files changed, 59 insertions(+), 120 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 04b761fd47e6..ee2b5017d247 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1076,7 +1076,7 @@ static __u32 fanotify_mark_remove_from_mask(struct fsnotify_mark *fsn_mark,
 }
 
 static int fanotify_remove_mark(struct fsnotify_group *group,
-				fsnotify_connp_t *connp, __u32 mask,
+				void *obj, unsigned int obj_type, __u32 mask,
 				unsigned int flags, __u32 umask)
 {
 	struct fsnotify_mark *fsn_mark = NULL;
@@ -1084,7 +1084,7 @@ static int fanotify_remove_mark(struct fsnotify_group *group,
 	int destroy_mark;
 
 	fsnotify_group_lock(group);
-	fsn_mark = fsnotify_find_mark(connp, group);
+	fsn_mark = fsnotify_find_mark(obj, obj_type, group);
 	if (!fsn_mark) {
 		fsnotify_group_unlock(group);
 		return -ENOENT;
@@ -1105,30 +1105,6 @@ static int fanotify_remove_mark(struct fsnotify_group *group,
 	return 0;
 }
 
-static int fanotify_remove_vfsmount_mark(struct fsnotify_group *group,
-					 struct vfsmount *mnt, __u32 mask,
-					 unsigned int flags, __u32 umask)
-{
-	return fanotify_remove_mark(group, &real_mount(mnt)->mnt_fsnotify_marks,
-				    mask, flags, umask);
-}
-
-static int fanotify_remove_sb_mark(struct fsnotify_group *group,
-				   struct super_block *sb, __u32 mask,
-				   unsigned int flags, __u32 umask)
-{
-	return fanotify_remove_mark(group, &sb->s_fsnotify_marks, mask,
-				    flags, umask);
-}
-
-static int fanotify_remove_inode_mark(struct fsnotify_group *group,
-				      struct inode *inode, __u32 mask,
-				      unsigned int flags, __u32 umask)
-{
-	return fanotify_remove_mark(group, &inode->i_fsnotify_marks, mask,
-				    flags, umask);
-}
-
 static bool fanotify_mark_update_flags(struct fsnotify_mark *fsn_mark,
 				       unsigned int fan_flags)
 {
@@ -1249,7 +1225,7 @@ static int fanotify_set_mark_fsid(struct fsnotify_group *group,
 }
 
 static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
-						   fsnotify_connp_t *connp,
+						   void *obj,
 						   unsigned int obj_type,
 						   unsigned int fan_flags,
 						   struct fan_fsid *fsid)
@@ -1288,7 +1264,7 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
 		fan_mark->fsid.val[0] = fan_mark->fsid.val[1] = 0;
 	}
 
-	ret = fsnotify_add_mark_locked(mark, connp, obj_type, 0);
+	ret = fsnotify_add_mark_locked(mark, obj, obj_type, 0);
 	if (ret)
 		goto out_put_mark;
 
@@ -1344,7 +1320,7 @@ static int fanotify_may_update_existing_mark(struct fsnotify_mark *fsn_mark,
 }
 
 static int fanotify_add_mark(struct fsnotify_group *group,
-			     fsnotify_connp_t *connp, unsigned int obj_type,
+			     void *obj, unsigned int obj_type,
 			     __u32 mask, unsigned int fan_flags,
 			     struct fan_fsid *fsid)
 {
@@ -1353,9 +1329,9 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 	int ret = 0;
 
 	fsnotify_group_lock(group);
-	fsn_mark = fsnotify_find_mark(connp, group);
+	fsn_mark = fsnotify_find_mark(obj, obj_type, group);
 	if (!fsn_mark) {
-		fsn_mark = fanotify_add_new_mark(group, connp, obj_type,
+		fsn_mark = fanotify_add_new_mark(group, obj, obj_type,
 						 fan_flags, fsid);
 		if (IS_ERR(fsn_mark)) {
 			fsnotify_group_unlock(group);
@@ -1392,30 +1368,6 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 	return ret;
 }
 
-static int fanotify_add_vfsmount_mark(struct fsnotify_group *group,
-				      struct vfsmount *mnt, __u32 mask,
-				      unsigned int flags, struct fan_fsid *fsid)
-{
-	return fanotify_add_mark(group, &real_mount(mnt)->mnt_fsnotify_marks,
-				 FSNOTIFY_OBJ_TYPE_VFSMOUNT, mask, flags, fsid);
-}
-
-static int fanotify_add_sb_mark(struct fsnotify_group *group,
-				struct super_block *sb, __u32 mask,
-				unsigned int flags, struct fan_fsid *fsid)
-{
-	return fanotify_add_mark(group, &sb->s_fsnotify_marks,
-				 FSNOTIFY_OBJ_TYPE_SB, mask, flags, fsid);
-}
-
-static int fanotify_add_inode_mark(struct fsnotify_group *group,
-				   struct inode *inode, __u32 mask,
-				   unsigned int flags, struct fan_fsid *fsid)
-{
-	return fanotify_add_mark(group, &inode->i_fsnotify_marks,
-				 FSNOTIFY_OBJ_TYPE_INODE, mask, flags, fsid);
-}
-
 static struct fsnotify_event *fanotify_alloc_overflow_event(void)
 {
 	struct fanotify_event *oevent;
@@ -1738,6 +1690,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	unsigned int mark_cmd = flags & FANOTIFY_MARK_CMD_BITS;
 	unsigned int ignore = flags & FANOTIFY_MARK_IGNORE_BITS;
 	unsigned int obj_type, fid_mode;
+	void *obj;
 	u32 umask = 0;
 	int ret;
 
@@ -1896,10 +1849,16 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	}
 
 	/* inode held in place by reference to path; group by fget on fd */
-	if (mark_type == FAN_MARK_INODE)
+	if (mark_type == FAN_MARK_INODE) {
 		inode = path.dentry->d_inode;
-	else
+		obj = inode;
+	} else {
 		mnt = path.mnt;
+		if (mark_type == FAN_MARK_MOUNT)
+			obj = mnt;
+		else
+			obj = mnt->mnt_sb;
+	}
 
 	/*
 	 * If some other task has this inode open for write we should not add
@@ -1935,26 +1894,12 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	/* create/update an inode mark */
 	switch (mark_cmd) {
 	case FAN_MARK_ADD:
-		if (mark_type == FAN_MARK_MOUNT)
-			ret = fanotify_add_vfsmount_mark(group, mnt, mask,
-							 flags, fsid);
-		else if (mark_type == FAN_MARK_FILESYSTEM)
-			ret = fanotify_add_sb_mark(group, mnt->mnt_sb, mask,
-						   flags, fsid);
-		else
-			ret = fanotify_add_inode_mark(group, inode, mask,
-						      flags, fsid);
+		ret = fanotify_add_mark(group, obj, obj_type, mask, flags,
+					fsid);
 		break;
 	case FAN_MARK_REMOVE:
-		if (mark_type == FAN_MARK_MOUNT)
-			ret = fanotify_remove_vfsmount_mark(group, mnt, mask,
-							    flags, umask);
-		else if (mark_type == FAN_MARK_FILESYSTEM)
-			ret = fanotify_remove_sb_mark(group, mnt->mnt_sb, mask,
-						      flags, umask);
-		else
-			ret = fanotify_remove_inode_mark(group, inode, mask,
-							 flags, umask);
+		ret = fanotify_remove_mark(group, obj, obj_type, mask, flags,
+					   umask);
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
index 87456ce40364..8b73ad45cc71 100644
--- a/fs/notify/fsnotify.h
+++ b/fs/notify/fsnotify.h
@@ -9,22 +9,28 @@
 
 #include "../mount.h"
 
+/*
+ * fsnotify_connp_t is what we embed in objects which connector can be attached
+ * to.
+ */
+typedef struct fsnotify_mark_connector __rcu *fsnotify_connp_t;
+
 static inline struct inode *fsnotify_conn_inode(
 				struct fsnotify_mark_connector *conn)
 {
-	return container_of(conn->obj, struct inode, i_fsnotify_marks);
+	return conn->obj;
 }
 
 static inline struct mount *fsnotify_conn_mount(
 				struct fsnotify_mark_connector *conn)
 {
-	return container_of(conn->obj, struct mount, mnt_fsnotify_marks);
+	return real_mount(conn->obj);
 }
 
 static inline struct super_block *fsnotify_conn_sb(
 				struct fsnotify_mark_connector *conn)
 {
-	return container_of(conn->obj, struct super_block, s_fsnotify_marks);
+	return conn->obj;
 }
 
 static inline struct super_block *fsnotify_object_sb(void *obj, int obj_type)
@@ -44,16 +50,7 @@ static inline struct super_block *fsnotify_object_sb(void *obj, int obj_type)
 static inline struct super_block *fsnotify_connector_sb(
 				struct fsnotify_mark_connector *conn)
 {
-	switch (conn->type) {
-	case FSNOTIFY_OBJ_TYPE_INODE:
-		return fsnotify_conn_inode(conn)->i_sb;
-	case FSNOTIFY_OBJ_TYPE_VFSMOUNT:
-		return fsnotify_conn_mount(conn)->mnt.mnt_sb;
-	case FSNOTIFY_OBJ_TYPE_SB:
-		return fsnotify_conn_sb(conn);
-	default:
-		return NULL;
-	}
+	return fsnotify_object_sb(conn->obj, conn->type);
 }
 
 /* destroy all events sitting in this groups notification queue */
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 95bcd818ae96..aa4233b5a3e4 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -264,6 +264,7 @@ static void *fsnotify_detach_connector_from_object(
 					struct fsnotify_mark_connector *conn,
 					unsigned int *type)
 {
+	fsnotify_connp_t *connp = fsnotify_object_connp(conn->obj, conn->type);
 	struct inode *inode = NULL;
 
 	*type = conn->type;
@@ -284,7 +285,7 @@ static void *fsnotify_detach_connector_from_object(
 	}
 
 	fsnotify_put_sb_watchers(conn);
-	rcu_assign_pointer(*(conn->obj), NULL);
+	rcu_assign_pointer(*connp, NULL);
 	conn->obj = NULL;
 	conn->type = FSNOTIFY_OBJ_TYPE_DETACHED;
 
@@ -559,7 +560,7 @@ int fsnotify_compare_groups(struct fsnotify_group *a, struct fsnotify_group *b)
 }
 
 static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
-					       unsigned int obj_type)
+					       void *obj, unsigned int obj_type)
 {
 	struct fsnotify_mark_connector *conn;
 
@@ -570,7 +571,7 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
 	INIT_HLIST_HEAD(&conn->list);
 	conn->flags = 0;
 	conn->type = obj_type;
-	conn->obj = connp;
+	conn->obj = obj;
 
 	/*
 	 * cmpxchg() provides the barrier so that readers of *connp can see
@@ -619,24 +620,25 @@ static struct fsnotify_mark_connector *fsnotify_grab_connector(
  * to which group and for which inodes. These marks are ordered according to
  * priority, highest number first, and then by the group's location in memory.
  */
-static int fsnotify_add_mark_list(struct fsnotify_mark *mark,
-				  fsnotify_connp_t *connp,
+static int fsnotify_add_mark_list(struct fsnotify_mark *mark, void *obj,
 				  unsigned int obj_type, int add_flags)
 {
 	struct fsnotify_mark *lmark, *last = NULL;
 	struct fsnotify_mark_connector *conn;
+	fsnotify_connp_t *connp;
 	int cmp;
 	int err = 0;
 
 	if (WARN_ON(!fsnotify_valid_obj_type(obj_type)))
 		return -EINVAL;
 
+	connp = fsnotify_object_connp(obj, obj_type);
 restart:
 	spin_lock(&mark->lock);
 	conn = fsnotify_grab_connector(connp);
 	if (!conn) {
 		spin_unlock(&mark->lock);
-		err = fsnotify_attach_connector_to_object(connp, obj_type);
+		err = fsnotify_attach_connector_to_object(connp, obj, obj_type);
 		if (err)
 			return err;
 		goto restart;
@@ -688,7 +690,7 @@ static int fsnotify_add_mark_list(struct fsnotify_mark *mark,
  * event types should be delivered to which group.
  */
 int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
-			     fsnotify_connp_t *connp, unsigned int obj_type,
+			     void *obj, unsigned int obj_type,
 			     int add_flags)
 {
 	struct fsnotify_group *group = mark->group;
@@ -709,7 +711,7 @@ int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
 	fsnotify_get_mark(mark); /* for g_list */
 	spin_unlock(&mark->lock);
 
-	ret = fsnotify_add_mark_list(mark, connp, obj_type, add_flags);
+	ret = fsnotify_add_mark_list(mark, obj, obj_type, add_flags);
 	if (ret)
 		goto err;
 
@@ -727,14 +729,14 @@ int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
 	return ret;
 }
 
-int fsnotify_add_mark(struct fsnotify_mark *mark, fsnotify_connp_t *connp,
+int fsnotify_add_mark(struct fsnotify_mark *mark, void *obj,
 		      unsigned int obj_type, int add_flags)
 {
 	int ret;
 	struct fsnotify_group *group = mark->group;
 
 	fsnotify_group_lock(group);
-	ret = fsnotify_add_mark_locked(mark, connp, obj_type, add_flags);
+	ret = fsnotify_add_mark_locked(mark, obj, obj_type, add_flags);
 	fsnotify_group_unlock(group);
 	return ret;
 }
@@ -744,12 +746,16 @@ EXPORT_SYMBOL_GPL(fsnotify_add_mark);
  * Given a list of marks, find the mark associated with given group. If found
  * take a reference to that mark and return it, else return NULL.
  */
-struct fsnotify_mark *fsnotify_find_mark(fsnotify_connp_t *connp,
+struct fsnotify_mark *fsnotify_find_mark(void *obj, unsigned int obj_type,
 					 struct fsnotify_group *group)
 {
+	fsnotify_connp_t *connp = fsnotify_object_connp(obj, obj_type);
 	struct fsnotify_mark_connector *conn;
 	struct fsnotify_mark *mark;
 
+	if (!connp)
+		return NULL;
+
 	conn = fsnotify_grab_connector(connp);
 	if (!conn)
 		return NULL;
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 992b57a7e95f..face68fcf850 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -456,13 +456,6 @@ FSNOTIFY_ITER_FUNCS(sb, SB)
 	     type < FSNOTIFY_ITER_TYPE_COUNT; \
 	     type++)
 
-/*
- * fsnotify_connp_t is what we embed in objects which connector can be attached
- * to. fsnotify_connp_t * is how we refer from connector back to object.
- */
-struct fsnotify_mark_connector;
-typedef struct fsnotify_mark_connector __rcu *fsnotify_connp_t;
-
 /*
  * Inode/vfsmount/sb point to this structure which tracks all marks attached to
  * the inode/vfsmount/sb. The reference to inode/vfsmount/sb is held by this
@@ -476,7 +469,7 @@ struct fsnotify_mark_connector {
 	unsigned short flags;	/* flags [lock] */
 	union {
 		/* Object pointer [lock] */
-		fsnotify_connp_t *obj;
+		void *obj;
 		/* Used listing heads to free after srcu period expires */
 		struct fsnotify_mark_connector *destroy_next;
 	};
@@ -763,37 +756,35 @@ extern void fsnotify_recalc_mask(struct fsnotify_mark_connector *conn);
 extern void fsnotify_init_mark(struct fsnotify_mark *mark,
 			       struct fsnotify_group *group);
 /* Find mark belonging to given group in the list of marks */
-extern struct fsnotify_mark *fsnotify_find_mark(fsnotify_connp_t *connp,
-						struct fsnotify_group *group);
+struct fsnotify_mark *fsnotify_find_mark(void *obj, unsigned int obj_type,
+					 struct fsnotify_group *group);
 /* attach the mark to the object */
-extern int fsnotify_add_mark(struct fsnotify_mark *mark,
-			     fsnotify_connp_t *connp, unsigned int obj_type,
-			     int add_flags);
-extern int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
-				    fsnotify_connp_t *connp,
-				    unsigned int obj_type, int add_flags);
+int fsnotify_add_mark(struct fsnotify_mark *mark, void *obj,
+		      unsigned int obj_type, int add_flags);
+int fsnotify_add_mark_locked(struct fsnotify_mark *mark, void *obj,
+			     unsigned int obj_type, int add_flags);
 
 /* attach the mark to the inode */
 static inline int fsnotify_add_inode_mark(struct fsnotify_mark *mark,
 					  struct inode *inode,
 					  int add_flags)
 {
-	return fsnotify_add_mark(mark, &inode->i_fsnotify_marks,
-				 FSNOTIFY_OBJ_TYPE_INODE, add_flags);
+	return fsnotify_add_mark(mark, inode, FSNOTIFY_OBJ_TYPE_INODE,
+				 add_flags);
 }
 static inline int fsnotify_add_inode_mark_locked(struct fsnotify_mark *mark,
 						 struct inode *inode,
 						 int add_flags)
 {
-	return fsnotify_add_mark_locked(mark, &inode->i_fsnotify_marks,
-					FSNOTIFY_OBJ_TYPE_INODE, add_flags);
+	return fsnotify_add_mark_locked(mark, inode, FSNOTIFY_OBJ_TYPE_INODE,
+					add_flags);
 }
 
 static inline struct fsnotify_mark *fsnotify_find_inode_mark(
 						struct inode *inode,
 						struct fsnotify_group *group)
 {
-	return fsnotify_find_mark(&inode->i_fsnotify_marks, group);
+	return fsnotify_find_mark(inode, FSNOTIFY_OBJ_TYPE_INODE, group);
 }
 
 /* given a group and a mark, flag mark to be freed when all references are dropped */
-- 
2.34.1


