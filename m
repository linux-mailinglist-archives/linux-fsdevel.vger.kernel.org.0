Return-Path: <linux-fsdevel+bounces-39999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC15A1AA7A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 20:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B74816AC0B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 19:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46ADB1BBBC8;
	Thu, 23 Jan 2025 19:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CGO1mFLL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4E21B4F3D
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 19:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737661278; cv=none; b=bRFrAySMaZV/M7yUBsyU/4mp8WHfGlHmbohr0d5pFUup5Wd4QnAnbpqQirCKCsvCuewX808jRPFVhKMVZrYVui/IU++CWKIjbx+PG4mK+qBQvWqtTm70vDyoewhYPy63bgWHA6C6BLTlkS4sJJ97UxCrRzoRZyuMqxbenpdl31Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737661278; c=relaxed/simple;
	bh=R230SQtYU8NxTzAXUlHxyqxePrL9pm9fTS6QMF9HH6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BSW6QZKq1uVZ8DGC7DbGO8EDcr3wjgx2Gt9T1mRMER0EBvpKpxukSM9IqywwrfSIKB5JOW1O9t1tahDXWiooEQWNYL6rmUxCK+0neCBfzjLd/eklE44EmoROVroDyS1ES1b5hDefDBrdVBFYdrOB3ALfuDI3kJk6NO0cxjFLQCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CGO1mFLL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737661275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WAOJgc0l44DRSISzpCqPlibXPEkW/cra254VqDqmeYU=;
	b=CGO1mFLLyPcebV0kwurOuApsGW8p0TL2B/6Mi4NzLQmUB7sK+oBDV+VxsaSxFAKUxiPX+a
	5YkLz7dfhd3g8lphQJrjuE+gaM618FWL3wE+62/OE+vk0dFDKmdPIOHxD+MYXCaanpw1go
	sNr3LH44NxDQIYFpjy/wM37dT9TBOKI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-GlQ37Lp8NVycHeNM8owAlA-1; Thu, 23 Jan 2025 14:41:13 -0500
X-MC-Unique: GlQ37Lp8NVycHeNM8owAlA-1
X-Mimecast-MFC-AGG-ID: GlQ37Lp8NVycHeNM8owAlA
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4361efc9d1fso10597895e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 11:41:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737661272; x=1738266072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WAOJgc0l44DRSISzpCqPlibXPEkW/cra254VqDqmeYU=;
        b=f6Ut9zDMgVcQi7/CJ/7dVjaRQ+oRszbe+5oAvnPM30jlZoNE81angv8j3o7SaLu2Y+
         jiwhm9x4aotAlqIwMkT/XfrX6Fvu3+aXlbfzHf6iJ62FryF38DQiaNDUEuP83ME8WY/L
         pdjwSlKuPXOOARFXaKSz8nCi7SdKAm+6vB+2KzwFe32IRI7DHVAbwxWaZVEHB0uR0KkL
         rcD9zShunXTxmHsbtA1tXHlBKdQZoXCuUaN0IMR6Swcg2HfJHLO3EuEBRL+yIoyhf7Fb
         8CDCiAA0qX3NMT48me2W690Oxy93GiWqsmqdnCR5yoYENzulDQE0o9Ky1jpHc1taTKW7
         scFQ==
X-Gm-Message-State: AOJu0YzKU902Z2zR8dDqPmEWuZTEO4l0iT9bzg0jrl7W/YpBkSmH6BNf
	TzcwHdseuS/bvJD2gp7IiAMeqrDYa7dj0CW19H+zp/+GmVNqargC8demTNw37NSHX4ezLqX5Yb3
	bJkY5zZ2LJ0/KV2O7v0fzz7ZsJNjMuRrndYRwQQj5EXGyLsRHE0lYFIR0rKFtfqNP9JbWuARyRM
	7YpJX4lzZB5jidTYCD/XMdnvlN7QDNGDVSnhl/890TnfUpd1zbCg==
X-Gm-Gg: ASbGnctQ83F/tCtWqs8n33SjZayC0CgYeZirxxMx85YQf+syne07BQrlfAdr/2WAGYv
	NWsOfGMUCyg1+cUj6BOnV3mT16w2BLD7jCCn2dw4ArarjVU1cDATTBG4Qprzba1C7sQ9G7qnYbf
	LR8Wth8bZIlouIE4KoElG0iVyFai4pWLVe6WjW7IPvyKrMkYlyjKaj+2fOtp5U5187iYRC5CboZ
	pI6Bzud7dd9LFIS/wNCr5axlVmYmCMdv8vArA6+xg0JmB0XZCMx5haTO2eZTVzUrrv2ZVZook82
	iFbwQKv5+GTvUvYtKvGbcHOOIAzhA+RdZbVUKxSnZfnuwA==
X-Received: by 2002:a05:600c:a45:b0:436:faeb:2a0b with SMTP id 5b1f17b1804b1-438913e32bemr271430295e9.15.1737661272128;
        Thu, 23 Jan 2025 11:41:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtFUL4wg7wO1ipjblbwu2sumGjGss/GsywpcGVkDeEYjdEgH3Mv5QbEe+ycxgvIhUTytcQBg==
X-Received: by 2002:a05:600c:a45:b0:436:faeb:2a0b with SMTP id 5b1f17b1804b1-438913e32bemr271429985e9.15.1737661271679;
        Thu, 23 Jan 2025 11:41:11 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (91-82-183-41.pool.digikabel.hu. [91.82.183.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd507e46sm1687245e9.21.2025.01.23.11.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 11:41:10 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Karel Zak <kzak@redhat.com>,
	Lennart Poettering <lennart@poettering.net>,
	Ian Kent <raven@themaw.net>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-security-module@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>
Subject: [PATCH v4 1/4] fsnotify: add mount notification infrastructure
Date: Thu, 23 Jan 2025 20:41:04 +0100
Message-ID: <20250123194108.1025273-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123194108.1025273-1-mszeredi@redhat.com>
References: <20250123194108.1025273-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is just the plumbing between the event source (fs/namespace.c) and the
event consumer (fanotify).  In itself it does nothing.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/mount.h                       |  4 +++
 fs/notify/fsnotify.c             | 47 +++++++++++++++++++++++++++-----
 fs/notify/fsnotify.h             | 11 ++++++++
 fs/notify/mark.c                 | 14 ++++++++--
 include/linux/fsnotify.h         | 20 ++++++++++++++
 include/linux/fsnotify_backend.h | 40 ++++++++++++++++++++++++++-
 6 files changed, 125 insertions(+), 11 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index 179f690a0c72..33311ad81042 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -14,6 +14,10 @@ struct mnt_namespace {
 	u64			seq;	/* Sequence number to prevent loops */
 	wait_queue_head_t poll;
 	u64 event;
+#ifdef CONFIG_FSNOTIFY
+	__u32			n_fsnotify_mask;
+	struct fsnotify_mark_connector __rcu *n_fsnotify_marks;
+#endif
 	unsigned int		nr_mounts; /* # of mounts in the namespace */
 	unsigned int		pending_mounts;
 	struct rb_node		mnt_ns_tree_node; /* node in the mnt_ns_tree */
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index f976949d2634..2b2c3fd907c7 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -28,6 +28,11 @@ void __fsnotify_vfsmount_delete(struct vfsmount *mnt)
 	fsnotify_clear_marks_by_mount(mnt);
 }
 
+void __fsnotify_mntns_delete(struct mnt_namespace *mntns)
+{
+	fsnotify_clear_marks_by_mntns(mntns);
+}
+
 /**
  * fsnotify_unmount_inodes - an sb is unmounting.  handle any watched inodes.
  * @sb: superblock being unmounted.
@@ -402,7 +407,7 @@ static int send_to_group(__u32 mask, const void *data, int data_type,
 				     file_name, cookie, iter_info);
 }
 
-static struct fsnotify_mark *fsnotify_first_mark(struct fsnotify_mark_connector **connp)
+static struct fsnotify_mark *fsnotify_first_mark(struct fsnotify_mark_connector *const *connp)
 {
 	struct fsnotify_mark_connector *conn;
 	struct hlist_node *node = NULL;
@@ -520,14 +525,15 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 {
 	const struct path *path = fsnotify_data_path(data, data_type);
 	struct super_block *sb = fsnotify_data_sb(data, data_type);
-	struct fsnotify_sb_info *sbinfo = fsnotify_sb_info(sb);
+	const struct fsnotify_mnt *mnt_data = fsnotify_data_mnt(data, data_type);
+	struct fsnotify_sb_info *sbinfo = sb ? fsnotify_sb_info(sb) : NULL;
 	struct fsnotify_iter_info iter_info = {};
 	struct mount *mnt = NULL;
 	struct inode *inode2 = NULL;
 	struct dentry *moved;
 	int inode2_type;
 	int ret = 0;
-	__u32 test_mask, marks_mask;
+	__u32 test_mask, marks_mask = 0;
 
 	if (path)
 		mnt = real_mount(path->mnt);
@@ -560,17 +566,20 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 	if ((!sbinfo || !sbinfo->sb_marks) &&
 	    (!mnt || !mnt->mnt_fsnotify_marks) &&
 	    (!inode || !inode->i_fsnotify_marks) &&
-	    (!inode2 || !inode2->i_fsnotify_marks))
+	    (!inode2 || !inode2->i_fsnotify_marks) &&
+	    (!mnt_data || !mnt_data->ns->n_fsnotify_marks))
 		return 0;
 
-	marks_mask = READ_ONCE(sb->s_fsnotify_mask);
+	if (sb)
+		marks_mask |= READ_ONCE(sb->s_fsnotify_mask);
 	if (mnt)
 		marks_mask |= READ_ONCE(mnt->mnt_fsnotify_mask);
 	if (inode)
 		marks_mask |= READ_ONCE(inode->i_fsnotify_mask);
 	if (inode2)
 		marks_mask |= READ_ONCE(inode2->i_fsnotify_mask);
-
+	if (mnt_data)
+		marks_mask |= READ_ONCE(mnt_data->ns->n_fsnotify_mask);
 
 	/*
 	 * If this is a modify event we may need to clear some ignore masks.
@@ -600,6 +609,10 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 		iter_info.marks[inode2_type] =
 			fsnotify_first_mark(&inode2->i_fsnotify_marks);
 	}
+	if (mnt_data) {
+		iter_info.marks[FSNOTIFY_ITER_TYPE_MNTNS] =
+			fsnotify_first_mark(&mnt_data->ns->n_fsnotify_marks);
+	}
 
 	/*
 	 * We need to merge inode/vfsmount/sb mark lists so that e.g. inode mark
@@ -623,11 +636,31 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 }
 EXPORT_SYMBOL_GPL(fsnotify);
 
+void fsnotify_mnt(__u32 mask, struct mnt_namespace *ns, struct vfsmount *mnt)
+{
+	struct fsnotify_mnt data = {
+		.ns = ns,
+		.mnt_id = real_mount(mnt)->mnt_id_unique,
+	};
+
+	if (WARN_ON_ONCE(!ns))
+		return;
+
+	/*
+	 * This is an optimization as well as making sure fsnotify_init() has
+	 * been called.
+	 */
+	if (!ns->n_fsnotify_marks)
+		return;
+
+	fsnotify(mask, &data, FSNOTIFY_EVENT_MNT, NULL, NULL, NULL, 0);
+}
+
 static __init int fsnotify_init(void)
 {
 	int ret;
 
-	BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) != 23);
+	BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) != 25);
 
 	ret = init_srcu_struct(&fsnotify_mark_srcu);
 	if (ret)
diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
index 663759ed6fbc..5950c7a67f41 100644
--- a/fs/notify/fsnotify.h
+++ b/fs/notify/fsnotify.h
@@ -33,6 +33,12 @@ static inline struct super_block *fsnotify_conn_sb(
 	return conn->obj;
 }
 
+static inline struct mnt_namespace *fsnotify_conn_mntns(
+				struct fsnotify_mark_connector *conn)
+{
+	return conn->obj;
+}
+
 static inline struct super_block *fsnotify_object_sb(void *obj,
 			enum fsnotify_obj_type obj_type)
 {
@@ -89,6 +95,11 @@ static inline void fsnotify_clear_marks_by_sb(struct super_block *sb)
 	fsnotify_destroy_marks(fsnotify_sb_marks(sb));
 }
 
+static inline void fsnotify_clear_marks_by_mntns(struct mnt_namespace *mntns)
+{
+	fsnotify_destroy_marks(&mntns->n_fsnotify_marks);
+}
+
 /*
  * update the dentry->d_flags of all of inode's children to indicate if inode cares
  * about events that happen to its children.
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 4981439e6209..798340db69d7 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -107,6 +107,8 @@ static fsnotify_connp_t *fsnotify_object_connp(void *obj,
 		return &real_mount(obj)->mnt_fsnotify_marks;
 	case FSNOTIFY_OBJ_TYPE_SB:
 		return fsnotify_sb_marks(obj);
+	case FSNOTIFY_OBJ_TYPE_MNTNS:
+		return &((struct mnt_namespace *)obj)->n_fsnotify_marks;
 	default:
 		return NULL;
 	}
@@ -120,6 +122,8 @@ static __u32 *fsnotify_conn_mask_p(struct fsnotify_mark_connector *conn)
 		return &fsnotify_conn_mount(conn)->mnt_fsnotify_mask;
 	else if (conn->type == FSNOTIFY_OBJ_TYPE_SB)
 		return &fsnotify_conn_sb(conn)->s_fsnotify_mask;
+	else if (conn->type == FSNOTIFY_OBJ_TYPE_MNTNS)
+		return &fsnotify_conn_mntns(conn)->n_fsnotify_mask;
 	return NULL;
 }
 
@@ -346,12 +350,15 @@ static void *fsnotify_detach_connector_from_object(
 		fsnotify_conn_mount(conn)->mnt_fsnotify_mask = 0;
 	} else if (conn->type == FSNOTIFY_OBJ_TYPE_SB) {
 		fsnotify_conn_sb(conn)->s_fsnotify_mask = 0;
+	} else if (conn->type == FSNOTIFY_OBJ_TYPE_MNTNS) {
+		fsnotify_conn_mntns(conn)->n_fsnotify_mask = 0;
 	}
 
 	rcu_assign_pointer(*connp, NULL);
 	conn->obj = NULL;
 	conn->type = FSNOTIFY_OBJ_TYPE_DETACHED;
-	fsnotify_update_sb_watchers(sb, conn);
+	if (sb)
+		fsnotify_update_sb_watchers(sb, conn);
 
 	return inode;
 }
@@ -724,7 +731,7 @@ static int fsnotify_add_mark_list(struct fsnotify_mark *mark, void *obj,
 	 * Attach the sb info before attaching a connector to any object on sb.
 	 * The sb info will remain attached as long as sb lives.
 	 */
-	if (!fsnotify_sb_info(sb)) {
+	if (sb && !fsnotify_sb_info(sb)) {
 		err = fsnotify_attach_info_to_sb(sb);
 		if (err)
 			return err;
@@ -770,7 +777,8 @@ static int fsnotify_add_mark_list(struct fsnotify_mark *mark, void *obj,
 	/* mark should be the last entry.  last is the current last entry */
 	hlist_add_behind_rcu(&mark->obj_list, &last->obj_list);
 added:
-	fsnotify_update_sb_watchers(sb, conn);
+	if (sb)
+		fsnotify_update_sb_watchers(sb, conn);
 	/*
 	 * Since connector is attached to object using cmpxchg() we are
 	 * guaranteed that connector initialization is fully visible by anyone
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 278620e063ab..ea998551dd0d 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -255,6 +255,11 @@ static inline void fsnotify_vfsmount_delete(struct vfsmount *mnt)
 	__fsnotify_vfsmount_delete(mnt);
 }
 
+static inline void fsnotify_mntns_delete(struct mnt_namespace *mntns)
+{
+	__fsnotify_mntns_delete(mntns);
+}
+
 /*
  * fsnotify_inoderemove - an inode is going away
  */
@@ -463,4 +468,19 @@ static inline int fsnotify_sb_error(struct super_block *sb, struct inode *inode,
 			NULL, NULL, NULL, 0);
 }
 
+static inline void fsnotify_mnt_attach(struct mnt_namespace *ns, struct vfsmount *mnt)
+{
+	fsnotify_mnt(FS_MNT_ATTACH, ns, mnt);
+}
+
+static inline void fsnotify_mnt_detach(struct mnt_namespace *ns, struct vfsmount *mnt)
+{
+	fsnotify_mnt(FS_MNT_DETACH, ns, mnt);
+}
+
+static inline void fsnotify_mnt_move(struct mnt_namespace *ns, struct vfsmount *mnt)
+{
+	fsnotify_mnt(FS_MNT_MOVE, ns, mnt);
+}
+
 #endif	/* _LINUX_FS_NOTIFY_H */
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 3ecf7768e577..6c3e3a4a7b10 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -56,6 +56,10 @@
 #define FS_ACCESS_PERM		0x00020000	/* access event in a permissions hook */
 #define FS_OPEN_EXEC_PERM	0x00040000	/* open/exec event in a permission hook */
 
+#define FS_MNT_ATTACH		0x01000000	/* Mount was attached */
+#define FS_MNT_DETACH		0x02000000	/* Mount was detached */
+#define FS_MNT_MOVE		(FS_MNT_ATTACH | FS_MNT_DETACH)
+
 /*
  * Set on inode mark that cares about things that happen to its children.
  * Always set for dnotify and inotify.
@@ -102,7 +106,7 @@
 			     FS_EVENTS_POSS_ON_CHILD | \
 			     FS_DELETE_SELF | FS_MOVE_SELF | \
 			     FS_UNMOUNT | FS_Q_OVERFLOW | FS_IN_IGNORED | \
-			     FS_ERROR)
+			     FS_ERROR | FS_MNT_ATTACH | FS_MNT_DETACH)
 
 /* Extra flags that may be reported with event or control handling of events */
 #define ALL_FSNOTIFY_FLAGS  (FS_ISDIR | FS_EVENT_ON_CHILD | FS_DN_MULTISHOT)
@@ -288,6 +292,7 @@ enum fsnotify_data_type {
 	FSNOTIFY_EVENT_PATH,
 	FSNOTIFY_EVENT_INODE,
 	FSNOTIFY_EVENT_DENTRY,
+	FSNOTIFY_EVENT_MNT,
 	FSNOTIFY_EVENT_ERROR,
 };
 
@@ -297,6 +302,11 @@ struct fs_error_report {
 	struct super_block *sb;
 };
 
+struct fsnotify_mnt {
+	const struct mnt_namespace *ns;
+	u64 mnt_id;
+};
+
 static inline struct inode *fsnotify_data_inode(const void *data, int data_type)
 {
 	switch (data_type) {
@@ -354,6 +364,24 @@ static inline struct super_block *fsnotify_data_sb(const void *data,
 	}
 }
 
+static inline const struct fsnotify_mnt *fsnotify_data_mnt(const void *data,
+							   int data_type)
+{
+	switch (data_type) {
+	case FSNOTIFY_EVENT_MNT:
+		return data;
+	default:
+		return NULL;
+	}
+}
+
+static inline u64 fsnotify_data_mnt_id(const void *data, int data_type)
+{
+	const struct fsnotify_mnt *mnt_data = fsnotify_data_mnt(data, data_type);
+
+	return mnt_data ? mnt_data->mnt_id : 0;
+}
+
 static inline struct fs_error_report *fsnotify_data_error_report(
 							const void *data,
 							int data_type)
@@ -379,6 +407,7 @@ enum fsnotify_iter_type {
 	FSNOTIFY_ITER_TYPE_SB,
 	FSNOTIFY_ITER_TYPE_PARENT,
 	FSNOTIFY_ITER_TYPE_INODE2,
+	FSNOTIFY_ITER_TYPE_MNTNS,
 	FSNOTIFY_ITER_TYPE_COUNT
 };
 
@@ -388,6 +417,7 @@ enum fsnotify_obj_type {
 	FSNOTIFY_OBJ_TYPE_INODE,
 	FSNOTIFY_OBJ_TYPE_VFSMOUNT,
 	FSNOTIFY_OBJ_TYPE_SB,
+	FSNOTIFY_OBJ_TYPE_MNTNS,
 	FSNOTIFY_OBJ_TYPE_COUNT,
 	FSNOTIFY_OBJ_TYPE_DETACHED = FSNOTIFY_OBJ_TYPE_COUNT
 };
@@ -572,8 +602,10 @@ extern int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data
 extern void __fsnotify_inode_delete(struct inode *inode);
 extern void __fsnotify_vfsmount_delete(struct vfsmount *mnt);
 extern void fsnotify_sb_delete(struct super_block *sb);
+extern void __fsnotify_mntns_delete(struct mnt_namespace *mntns);
 extern void fsnotify_sb_free(struct super_block *sb);
 extern u32 fsnotify_get_cookie(void);
+extern void fsnotify_mnt(__u32 mask, struct mnt_namespace *ns, struct vfsmount *mnt);
 
 static inline __u32 fsnotify_parent_needed_mask(__u32 mask)
 {
@@ -879,6 +911,9 @@ static inline void __fsnotify_vfsmount_delete(struct vfsmount *mnt)
 static inline void fsnotify_sb_delete(struct super_block *sb)
 {}
 
+static inline void __fsnotify_mntns_delete(struct mnt_namespace *mntns)
+{}
+
 static inline void fsnotify_sb_free(struct super_block *sb)
 {}
 
@@ -893,6 +928,9 @@ static inline u32 fsnotify_get_cookie(void)
 static inline void fsnotify_unmount_inodes(struct super_block *sb)
 {}
 
+static inline void fsnotify_mnt(__u32 mask, struct mnt_namespace *ns, struct vfsmount *mnt)
+{}
+
 #endif	/* CONFIG_FSNOTIFY */
 
 #endif	/* __KERNEL __ */
-- 
2.47.1


