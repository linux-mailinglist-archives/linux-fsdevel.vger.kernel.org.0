Return-Path: <linux-fsdevel+bounces-4464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A0F7FF9CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 19:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87F6DB20A44
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090F25220
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6KnrBq7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0377E6
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 09:19:15 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-a02ba1f500fso177710866b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 09:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701364754; x=1701969554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjUWtDefA/A+lb1YvcEsu0ZzfspkPvOZ1iBQf+QUcm8=;
        b=O6KnrBq7V90Uv9zoL6BufNUSMifvBfl5fUa/EvgzsnzkhATJZ2cX3a2ujdFWVylRjZ
         6Xj4CgTCe0qw+5Dh26IwPUGkD2L4Ef2H1Gw3n+3Phnn6KUPras7+xSjGcZVXhcFqrwi+
         XVYeLEt4oDb7r4+Rm6gOuYedhtz+6C2ShHcBp4FLD68ex3JC4y5rPj9+Mg28K0aVnCS9
         a4sYsXFerCzzWLbWfrCFbfz+8npU9tqlCEyXbC35BiseRRQ1GLJeUewLDBDUU2dCY04V
         w5MSnI17hOfbAOMuPl9ZMw7eDdq5TQp0aIw93tVZEmySLReVbZgxLZ6KvoEQf0mMsSDr
         DWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701364754; x=1701969554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjUWtDefA/A+lb1YvcEsu0ZzfspkPvOZ1iBQf+QUcm8=;
        b=AuwRp6vVqCBM9Z/u+rwNsNsZevwaCANU4Bb81ebl6uv4Nl51tk0mCHqk167/TyRCNm
         qNzvQOYvA0OqWP3FL3Ktl3freiWCyaLFkplaauRgi22qTrUhYIgLHMbFjEMJtzPrSUbY
         xSN8LnYzsO2B7uQgwcjwdITzf0RdiH/4243JwqAxKR8swnS0Cm2CJ6SAAsxHtp4k+Dj/
         /pnG7YjDJ/uhS/kBXyWm6dNDKpnXO+fBGQfWDZ/H6WFDz+zKEq7Ux7dxl6JR4lZPIwF9
         PTkcENa9jOTAuqnzMSeQaZ6JqCVUuQuX2ApTXKSLNuGUhUm1mzVgq4UAmQ29kQfGhbI7
         5muw==
X-Gm-Message-State: AOJu0YznfT11jAndUpTUsvOINsKKZOm0TzGN3YWvKs/rte9f5v+7Uczs
	HrVpa2En4cSFy1GSenCMB/G5YS38nhk=
X-Google-Smtp-Source: AGHT+IHDpJAllioQ278kuXdof5mbML/wqNqAF5YlYPbe6voy2RvBfviPGRBIVH8jhXqOSdBTb0pCVA==
X-Received: by 2002:a05:600c:1c8f:b0:40b:42d4:3319 with SMTP id k15-20020a05600c1c8f00b0040b42d43319mr1317wms.0.1701363395415;
        Thu, 30 Nov 2023 08:56:35 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id o18-20020a05600c511200b004064e3b94afsm6204241wms.4.2023.11.30.08.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 08:56:34 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/2] fanotify: store fsid in mark instead of in connector
Date: Thu, 30 Nov 2023 18:56:18 +0200
Message-Id: <20231130165619.3386452-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130165619.3386452-1-amir73il@gmail.com>
References: <20231130165619.3386452-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some filesystems like fuse and nfs have zero or non-unique fsid.
We would like to avoid reporting ambiguous fsid in events, so we need
to avoid marking objects with same fsid and different sb.

To make this easier to enforce, store the fsid in the marks of the group
instead of in the shared conenctor.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      | 19 +++--------
 fs/notify/fanotify/fanotify.h      | 10 ++++++
 fs/notify/fanotify/fanotify_user.c | 18 ++++++++---
 fs/notify/mark.c                   | 52 +++++-------------------------
 include/linux/fsnotify_backend.h   | 13 +++-----
 5 files changed, 42 insertions(+), 70 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 9dac7f6e72d2..aff1ab3c32aa 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -838,9 +838,8 @@ static struct fanotify_event *fanotify_alloc_event(
 }
 
 /*
- * Get cached fsid of the filesystem containing the object from any connector.
- * All connectors are supposed to have the same fsid, but we do not verify that
- * here.
+ * Get cached fsid of the filesystem containing the object from any mark.
+ * All marks are supposed to have the same fsid, but we do not verify that here.
  */
 static __kernel_fsid_t fanotify_get_fsid(struct fsnotify_iter_info *iter_info)
 {
@@ -849,17 +848,9 @@ static __kernel_fsid_t fanotify_get_fsid(struct fsnotify_iter_info *iter_info)
 	__kernel_fsid_t fsid = {};
 
 	fsnotify_foreach_iter_mark_type(iter_info, mark, type) {
-		struct fsnotify_mark_connector *conn;
-
-		conn = READ_ONCE(mark->connector);
-		/* Mark is just getting destroyed or created? */
-		if (!conn)
-			continue;
-		if (!(conn->flags & FSNOTIFY_CONN_FLAG_HAS_FSID))
+		if (!(mark->flags & FSNOTIFY_MARK_FLAG_HAS_FSID))
 			continue;
-		/* Pairs with smp_wmb() in fsnotify_add_mark_list() */
-		smp_rmb();
-		fsid = conn->fsid;
+		fsid = FANOTIFY_MARK(mark)->fsid;
 		if (WARN_ON_ONCE(!fsid.val[0] && !fsid.val[1]))
 			continue;
 		return fsid;
@@ -1068,7 +1059,7 @@ static void fanotify_freeing_mark(struct fsnotify_mark *mark,
 
 static void fanotify_free_mark(struct fsnotify_mark *fsn_mark)
 {
-	kmem_cache_free(fanotify_mark_cache, fsn_mark);
+	kmem_cache_free(fanotify_mark_cache, FANOTIFY_MARK(fsn_mark));
 }
 
 const struct fsnotify_ops fanotify_fsnotify_ops = {
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 6936671e148d..f3b9ef60f0c0 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -489,6 +489,16 @@ static inline unsigned int fanotify_event_hash_bucket(
 	return event->hash & FANOTIFY_HTABLE_MASK;
 }
 
+struct fanotify_mark {
+	struct fsnotify_mark fsn_mark;
+	__kernel_fsid_t fsid;
+};
+
+static inline struct fanotify_mark *FANOTIFY_MARK(struct fsnotify_mark *mark)
+{
+	return container_of(mark, struct fanotify_mark, fsn_mark);
+}
+
 static inline unsigned int fanotify_mark_user_flags(struct fsnotify_mark *mark)
 {
 	unsigned int mflags = 0;
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 4d765c72496f..e3d836d4d156 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1199,6 +1199,7 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
 						   __kernel_fsid_t *fsid)
 {
 	struct ucounts *ucounts = group->fanotify_data.ucounts;
+	struct fanotify_mark *fan_mark;
 	struct fsnotify_mark *mark;
 	int ret;
 
@@ -1211,17 +1212,26 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
 	    !inc_ucount(ucounts->ns, ucounts->uid, UCOUNT_FANOTIFY_MARKS))
 		return ERR_PTR(-ENOSPC);
 
-	mark = kmem_cache_alloc(fanotify_mark_cache, GFP_KERNEL);
-	if (!mark) {
+	fan_mark = kmem_cache_alloc(fanotify_mark_cache, GFP_KERNEL);
+	if (!fan_mark) {
 		ret = -ENOMEM;
 		goto out_dec_ucounts;
 	}
 
+	mark = &fan_mark->fsn_mark;
 	fsnotify_init_mark(mark, group);
 	if (fan_flags & FAN_MARK_EVICTABLE)
 		mark->flags |= FSNOTIFY_MARK_FLAG_NO_IREF;
 
-	ret = fsnotify_add_mark_locked(mark, connp, obj_type, 0, fsid);
+	/* Cache fsid of filesystem containing the marked object */
+	if (fsid) {
+		fan_mark->fsid = *fsid;
+		mark->flags |= FSNOTIFY_MARK_FLAG_HAS_FSID;
+	} else {
+		fan_mark->fsid.val[0] = fan_mark->fsid.val[1] = 0;
+	}
+
+	ret = fsnotify_add_mark_locked(mark, connp, obj_type, 0);
 	if (ret) {
 		fsnotify_put_mark(mark);
 		goto out_dec_ucounts;
@@ -1935,7 +1945,7 @@ static int __init fanotify_user_setup(void)
 	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 12);
 	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 11);
 
-	fanotify_mark_cache = KMEM_CACHE(fsnotify_mark,
+	fanotify_mark_cache = KMEM_CACHE(fanotify_mark,
 					 SLAB_PANIC|SLAB_ACCOUNT);
 	fanotify_fid_event_cachep = KMEM_CACHE(fanotify_fid_event,
 					       SLAB_PANIC);
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index c74ef947447d..d6944ff86ffa 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -537,8 +537,7 @@ int fsnotify_compare_groups(struct fsnotify_group *a, struct fsnotify_group *b)
 }
 
 static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
-					       unsigned int obj_type,
-					       __kernel_fsid_t *fsid)
+					       unsigned int obj_type)
 {
 	struct fsnotify_mark_connector *conn;
 
@@ -550,14 +549,7 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
 	conn->flags = 0;
 	conn->type = obj_type;
 	conn->obj = connp;
-	/* Cache fsid of filesystem containing the object */
-	if (fsid) {
-		conn->fsid = *fsid;
-		conn->flags = FSNOTIFY_CONN_FLAG_HAS_FSID;
-	} else {
-		conn->fsid.val[0] = conn->fsid.val[1] = 0;
-		conn->flags = 0;
-	}
+	conn->flags = 0;
 	fsnotify_get_sb_connectors(conn);
 
 	/*
@@ -608,8 +600,7 @@ static struct fsnotify_mark_connector *fsnotify_grab_connector(
  */
 static int fsnotify_add_mark_list(struct fsnotify_mark *mark,
 				  fsnotify_connp_t *connp,
-				  unsigned int obj_type,
-				  int add_flags, __kernel_fsid_t *fsid)
+				  unsigned int obj_type, int add_flags)
 {
 	struct fsnotify_mark *lmark, *last = NULL;
 	struct fsnotify_mark_connector *conn;
@@ -619,41 +610,15 @@ static int fsnotify_add_mark_list(struct fsnotify_mark *mark,
 	if (WARN_ON(!fsnotify_valid_obj_type(obj_type)))
 		return -EINVAL;
 
-	/* Backend is expected to check for zero fsid (e.g. tmpfs) */
-	if (fsid && WARN_ON_ONCE(!fsid->val[0] && !fsid->val[1]))
-		return -ENODEV;
-
 restart:
 	spin_lock(&mark->lock);
 	conn = fsnotify_grab_connector(connp);
 	if (!conn) {
 		spin_unlock(&mark->lock);
-		err = fsnotify_attach_connector_to_object(connp, obj_type,
-							  fsid);
+		err = fsnotify_attach_connector_to_object(connp, obj_type);
 		if (err)
 			return err;
 		goto restart;
-	} else if (fsid && !(conn->flags & FSNOTIFY_CONN_FLAG_HAS_FSID)) {
-		conn->fsid = *fsid;
-		/* Pairs with smp_rmb() in fanotify_get_fsid() */
-		smp_wmb();
-		conn->flags |= FSNOTIFY_CONN_FLAG_HAS_FSID;
-	} else if (fsid && (conn->flags & FSNOTIFY_CONN_FLAG_HAS_FSID) &&
-		   (fsid->val[0] != conn->fsid.val[0] ||
-		    fsid->val[1] != conn->fsid.val[1])) {
-		/*
-		 * Backend is expected to check for non uniform fsid
-		 * (e.g. btrfs), but maybe we missed something?
-		 * Only allow setting conn->fsid once to non zero fsid.
-		 * inotify and non-fid fanotify groups do not set nor test
-		 * conn->fsid.
-		 */
-		pr_warn_ratelimited("%s: fsid mismatch on object of type %u: "
-				    "%x.%x != %x.%x\n", __func__, conn->type,
-				    fsid->val[0], fsid->val[1],
-				    conn->fsid.val[0], conn->fsid.val[1]);
-		err = -EXDEV;
-		goto out_err;
 	}
 
 	/* is mark the first mark? */
@@ -703,7 +668,7 @@ static int fsnotify_add_mark_list(struct fsnotify_mark *mark,
  */
 int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
 			     fsnotify_connp_t *connp, unsigned int obj_type,
-			     int add_flags, __kernel_fsid_t *fsid)
+			     int add_flags)
 {
 	struct fsnotify_group *group = mark->group;
 	int ret = 0;
@@ -723,7 +688,7 @@ int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
 	fsnotify_get_mark(mark); /* for g_list */
 	spin_unlock(&mark->lock);
 
-	ret = fsnotify_add_mark_list(mark, connp, obj_type, add_flags, fsid);
+	ret = fsnotify_add_mark_list(mark, connp, obj_type, add_flags);
 	if (ret)
 		goto err;
 
@@ -742,14 +707,13 @@ int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
 }
 
 int fsnotify_add_mark(struct fsnotify_mark *mark, fsnotify_connp_t *connp,
-		      unsigned int obj_type, int add_flags,
-		      __kernel_fsid_t *fsid)
+		      unsigned int obj_type, int add_flags)
 {
 	int ret;
 	struct fsnotify_group *group = mark->group;
 
 	fsnotify_group_lock(group);
-	ret = fsnotify_add_mark_locked(mark, connp, obj_type, add_flags, fsid);
+	ret = fsnotify_add_mark_locked(mark, connp, obj_type, add_flags);
 	fsnotify_group_unlock(group);
 	return ret;
 }
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index c0892d75ce33..a80b525ca653 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -472,10 +472,8 @@ typedef struct fsnotify_mark_connector __rcu *fsnotify_connp_t;
 struct fsnotify_mark_connector {
 	spinlock_t lock;
 	unsigned short type;	/* Type of object [lock] */
-#define FSNOTIFY_CONN_FLAG_HAS_FSID	0x01
 #define FSNOTIFY_CONN_FLAG_HAS_IREF	0x02
 	unsigned short flags;	/* flags [lock] */
-	__kernel_fsid_t fsid;	/* fsid of filesystem containing object */
 	union {
 		/* Object pointer [lock] */
 		fsnotify_connp_t *obj;
@@ -530,6 +528,7 @@ struct fsnotify_mark {
 #define FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY	0x0100
 #define FSNOTIFY_MARK_FLAG_NO_IREF		0x0200
 #define FSNOTIFY_MARK_FLAG_HAS_IGNORE_FLAGS	0x0400
+#define FSNOTIFY_MARK_FLAG_HAS_FSID		0x0800
 	unsigned int flags;		/* flags [mark->lock] */
 };
 
@@ -763,11 +762,10 @@ extern struct fsnotify_mark *fsnotify_find_mark(fsnotify_connp_t *connp,
 /* attach the mark to the object */
 extern int fsnotify_add_mark(struct fsnotify_mark *mark,
 			     fsnotify_connp_t *connp, unsigned int obj_type,
-			     int add_flags, __kernel_fsid_t *fsid);
+			     int add_flags);
 extern int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
 				    fsnotify_connp_t *connp,
-				    unsigned int obj_type, int add_flags,
-				    __kernel_fsid_t *fsid);
+				    unsigned int obj_type, int add_flags);
 
 /* attach the mark to the inode */
 static inline int fsnotify_add_inode_mark(struct fsnotify_mark *mark,
@@ -775,15 +773,14 @@ static inline int fsnotify_add_inode_mark(struct fsnotify_mark *mark,
 					  int add_flags)
 {
 	return fsnotify_add_mark(mark, &inode->i_fsnotify_marks,
-				 FSNOTIFY_OBJ_TYPE_INODE, add_flags, NULL);
+				 FSNOTIFY_OBJ_TYPE_INODE, add_flags);
 }
 static inline int fsnotify_add_inode_mark_locked(struct fsnotify_mark *mark,
 						 struct inode *inode,
 						 int add_flags)
 {
 	return fsnotify_add_mark_locked(mark, &inode->i_fsnotify_marks,
-					FSNOTIFY_OBJ_TYPE_INODE, add_flags,
-					NULL);
+					FSNOTIFY_OBJ_TYPE_INODE, add_flags);
 }
 
 /* given a group and a mark, flag mark to be freed when all references are dropped */
-- 
2.34.1


