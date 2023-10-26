Return-Path: <linux-fsdevel+bounces-1255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D83507D864A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 17:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 023FC1C20F36
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 15:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CA6381B5;
	Thu, 26 Oct 2023 15:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fX05nvn+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD9D37C93
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 15:52:35 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA11C1A7;
	Thu, 26 Oct 2023 08:52:32 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40790b0a224so8147415e9.0;
        Thu, 26 Oct 2023 08:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698335551; x=1698940351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fjPxvcSCxB9vmFtMAe/wADl475KtwwXtJSVcFkXCWiU=;
        b=fX05nvn+J/ZK7VycZIrc5Iyu01TVtg6BcmrWwnzyFA8dWLDjEDgFBYbk+0qUIjana9
         xvzFzmhdty0QnXCOEdF9XM9ODNO1Z1p+/+PjABdedILDkbwdrB6tWnhGdQDO04q3E1/L
         INDTFn30p6SM2R9qyz6wmkqlowvpKfc01aCIZ7x8fK8ZAwW5o9uUT2zKTsnQw8tk72gl
         9bB3Ikf6RdD7NpZv67PdMgvdEP+hl5/C2G4+XQE7ysRGoLDHtBA8qc+JFtYdv7QJs5k+
         yk66zsB8kvJJP+e1CcdsjnoZkpf7UzThE7EIWADN9VST+ayGsRQWY7lF5HmQeboqmzbI
         5ugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698335551; x=1698940351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fjPxvcSCxB9vmFtMAe/wADl475KtwwXtJSVcFkXCWiU=;
        b=Fv5DN8/gEyVDxgpN8dRnMecafiqJk6j4rC1chAF9MTKbUnTNaLM1AkqtQYrRaXLQLU
         yx6ydiAYbbezYBssKWQmfvlhE4GrCL9r7D7hBJbR9rR26eh6YmPL2ne20WdCPu2cMoiB
         ag+8YW7L3W/yhg83z34pzhPLG5oN82SbvtAqAxgyLdJmGs1a8ECvwSg0Y5bxlKUWQzsy
         0MigpIPXmdTt6CxR41KI1SeP3DCS4KF7taJEnXzy5e2Z6EIeytMnffCmWsS162Tm9M+p
         1qdl1TOrPem4qlbDe8p0r56WMWXteSvssCtXl7FL8l0IW14SthYRCtNzG3N6I9qEdBdy
         C1hA==
X-Gm-Message-State: AOJu0Yw/pgnmIxgQvfy+RkFQ+wEq9tbFOII+5txhOm/jrncrrjfv5Tm2
	YSGhIr/4TOG3H0nDfdt1CD1+N1PGnBI=
X-Google-Smtp-Source: AGHT+IFFbL9+J5InAFFGx/ZBjjSs/QJYn28nPDaSpXr+/hxclscJ4cnNI+sJoPr7s/Fo++PhUlvwuw==
X-Received: by 2002:a5d:6488:0:b0:324:e284:fac2 with SMTP id o8-20020a5d6488000000b00324e284fac2mr67704wri.5.1698335551064;
        Thu, 26 Oct 2023 08:52:31 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id n12-20020adfe78c000000b00326f0ca3566sm14609838wrm.50.2023.10.26.08.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 08:52:30 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/3] fanotify: store fsid in mark instead of in connector
Date: Thu, 26 Oct 2023 18:52:22 +0300
Message-Id: <20231026155224.129326-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026155224.129326-1-amir73il@gmail.com>
References: <20231026155224.129326-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With btrfs, different inodes on the same sb can have different fsid.
We would like to report fsid in events that is the same as the fsid of
the object whose path was used to setup the mark.

That means that two different groups can report different fsid on
different sb marks on the same btrfs sb, so we need to store the fsid
in the marks of the group instead of in the shared conenctor.

This is needed to support fanotify marks in btrfs sub-volumes.

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
index e8a3c28c5d12..88367e7b41dc 100644
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
index 0eb9622e8a9f..fdd39bf91806 100644
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


