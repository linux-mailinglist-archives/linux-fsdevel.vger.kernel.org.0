Return-Path: <linux-fsdevel+bounces-4459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F4F7FF9C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 19:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D55628176B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FD454FB6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djlSG4ob"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A396D10DF
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 09:11:48 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-33318b866a0so1015310f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 09:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701364307; x=1701969107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9WvWjt9Zhblluupo8Qkw4CZOgMvp0KhLmtx6SqLGLg=;
        b=djlSG4obMSwgmC4NzNN8v5cKNEksIUalFRuTy1s1EsDKBj+XaZ5K3rMkZnzj3LX4kZ
         w5YKtCjptl1gUlPO+jFqnrK4/he2BLRqckGC8IZ6DBENR9YIPjjy/uOpT71FS+yE6QCS
         V9WYixVonUSCBp43pMhVHcltQ15ZUF9aVwWGtvhLRi7RSh5ylKdMVIuDO121CGD+DXsM
         LZi1HFd4c619rzIZT3/ayO+nVOPRhXu8lB1jkseFYRndavfz8U74KYY+Ea7qJIzjcSuc
         tjBT1bd5uHD15TEnKQsY7fcBLlsNwQr8rx94BxXm7c+itNrgC2O/KIRis/GipYPyUXLW
         LkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701364307; x=1701969107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V9WvWjt9Zhblluupo8Qkw4CZOgMvp0KhLmtx6SqLGLg=;
        b=AgGwRiRebtZfaRa5zLVw1aeCMqYi9Y8sxfyn3tXDAjcbcBl5553Hvk0Q2bTEd/CSKE
         x0r7YST4r91IVui/TeFx2MLfAwSXDnbXtRigrY59wrgHE8aRY7CpLaFsvezvbHxFhW2F
         EJspEAZ9ptreNJu1guJhZq6WjDxac4tfQH0Am+9fzKiTMHuuXiKQcIccVAi5mfwTxT2S
         vWEpcPqQ7C+VXoqRz24PEOeviy4MPLaivq3SCElCdWv1SElafjpCQ2pmwgmWhrfOs4O/
         2VPuZ4INQKqcJVq3xxdF3xw8jAQ5vpCZ+zOpKJeEl4HR+zEIX79txXoG9uQluZusbqWQ
         RLeg==
X-Gm-Message-State: AOJu0Yw7ccJGiJxQyMtiGbwj7F5XyBdIn1UIRvaszKtqdEwWzSzcLElA
	0JWh1hN/JaO3DqfqqnhtwsFyzIKhN1w=
X-Google-Smtp-Source: AGHT+IH0W2t1MxuS+fOjHITCeUuYWYj4dC1lFOretSkBgdNGCqMjLjOIF1TdDqDxiPGie99WmE4gDA==
X-Received: by 2002:ac2:5e68:0:b0:503:1d46:6f29 with SMTP id a8-20020ac25e68000000b005031d466f29mr19564lfr.37.1701363397835;
        Thu, 30 Nov 2023 08:56:37 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id o18-20020a05600c511200b004064e3b94afsm6204241wms.4.2023.11.30.08.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 08:56:37 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 2/2] fanotify: allow "weak" fsid when watching a single filesystem
Date: Thu, 30 Nov 2023 18:56:19 +0200
Message-Id: <20231130165619.3386452-3-amir73il@gmail.com>
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

So far, fanotify returns -ENODEV or -EXDEV when trying to set a mark
on a filesystem with a "weak" fsid, namely, zero fsid (e.g. fuse), or
non-uniform fsid (e.g. btrfs non-root subvol).

When group is watching inodes all from the same filesystem (or subvol),
allow adding inode marks with "weak" fsid, because there is no ambiguity
regarding which filesystem reports the event.

The first mark added to a group determines if this group is single or
multi filesystem, depending on the fsid at the path of the added mark.

If the first mark added has a "strong" fsid, marks with "weak" fsid
cannot be added and vice versa.

If the first mark added has a "weak" fsid, following marks must have
the same "weak" fsid and the same sb as the first mark.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      |  15 +---
 fs/notify/fanotify/fanotify.h      |   6 ++
 fs/notify/fanotify/fanotify_user.c | 112 +++++++++++++++++++++++------
 include/linux/fsnotify_backend.h   |   1 +
 4 files changed, 101 insertions(+), 33 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index aff1ab3c32aa..1e4def21811e 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -29,12 +29,6 @@ static unsigned int fanotify_hash_path(const struct path *path)
 		hash_ptr(path->mnt, FANOTIFY_EVENT_HASH_BITS);
 }
 
-static inline bool fanotify_fsid_equal(__kernel_fsid_t *fsid1,
-				       __kernel_fsid_t *fsid2)
-{
-	return fsid1->val[0] == fsid2->val[0] && fsid1->val[1] == fsid2->val[1];
-}
-
 static unsigned int fanotify_hash_fsid(__kernel_fsid_t *fsid)
 {
 	return hash_32(fsid->val[0], FANOTIFY_EVENT_HASH_BITS) ^
@@ -851,7 +845,8 @@ static __kernel_fsid_t fanotify_get_fsid(struct fsnotify_iter_info *iter_info)
 		if (!(mark->flags & FSNOTIFY_MARK_FLAG_HAS_FSID))
 			continue;
 		fsid = FANOTIFY_MARK(mark)->fsid;
-		if (WARN_ON_ONCE(!fsid.val[0] && !fsid.val[1]))
+		if (!(mark->flags & FSNOTIFY_MARK_FLAG_WEAK_FSID) &&
+		    WARN_ON_ONCE(!fsid.val[0] && !fsid.val[1]))
 			continue;
 		return fsid;
 	}
@@ -933,12 +928,8 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 			return 0;
 	}
 
-	if (FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS)) {
+	if (FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS))
 		fsid = fanotify_get_fsid(iter_info);
-		/* Racing with mark destruction or creation? */
-		if (!fsid.val[0] && !fsid.val[1])
-			return 0;
-	}
 
 	event = fanotify_alloc_event(group, mask, data, data_type, dir,
 				     file_name, &fsid, match_mask);
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index f3b9ef60f0c0..e5ab33cae6a7 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -499,6 +499,12 @@ static inline struct fanotify_mark *FANOTIFY_MARK(struct fsnotify_mark *mark)
 	return container_of(mark, struct fanotify_mark, fsn_mark);
 }
 
+static inline bool fanotify_fsid_equal(__kernel_fsid_t *fsid1,
+				       __kernel_fsid_t *fsid2)
+{
+	return fsid1->val[0] == fsid2->val[0] && fsid1->val[1] == fsid2->val[1];
+}
+
 static inline unsigned int fanotify_mark_user_flags(struct fsnotify_mark *mark)
 {
 	unsigned int mflags = 0;
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index e3d836d4d156..f83e7cc5ccf2 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -23,7 +23,7 @@
 
 #include <asm/ioctls.h>
 
-#include "../../mount.h"
+#include "../fsnotify.h"
 #include "../fdinfo.h"
 #include "fanotify.h"
 
@@ -1192,11 +1192,68 @@ static bool fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
 	return recalc;
 }
 
+struct fan_fsid {
+	struct super_block *sb;
+	__kernel_fsid_t id;
+	bool weak;
+};
+
+static int fanotify_set_mark_fsid(struct fsnotify_group *group,
+				  struct fsnotify_mark *mark,
+				  struct fan_fsid *fsid)
+{
+	struct fsnotify_mark_connector *conn;
+	struct fsnotify_mark *old;
+	struct super_block *old_sb = NULL;
+
+	FANOTIFY_MARK(mark)->fsid = fsid->id;
+	mark->flags |= FSNOTIFY_MARK_FLAG_HAS_FSID;
+	if (fsid->weak)
+		mark->flags |= FSNOTIFY_MARK_FLAG_WEAK_FSID;
+
+	/* First mark added will determine if group is single or multi fsid */
+	if (list_empty(&group->marks_list))
+		return 0;
+
+	/* Find sb of an existing mark */
+	list_for_each_entry(old, &group->marks_list, g_list) {
+		conn = READ_ONCE(old->connector);
+		if (!conn)
+			continue;
+		old_sb = fsnotify_connector_sb(conn);
+		if (old_sb)
+			break;
+	}
+
+	/* Only detached marks left? */
+	if (!old_sb)
+		return 0;
+
+	/* Do not allow mixing of marks with weak and strong fsid */
+	if ((mark->flags ^ old->flags) & FSNOTIFY_MARK_FLAG_WEAK_FSID)
+		return -EXDEV;
+
+	/* Allow mixing of marks with strong fsid from different fs */
+	if (!fsid->weak)
+		return 0;
+
+	/* Do not allow mixing marks with weak fsid from different fs */
+	if (old_sb != fsid->sb)
+		return -EXDEV;
+
+	/* Do not allow mixing marks from different btrfs sub-volumes */
+	if (!fanotify_fsid_equal(&FANOTIFY_MARK(old)->fsid,
+				 &FANOTIFY_MARK(mark)->fsid))
+		return -EXDEV;
+
+	return 0;
+}
+
 static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
 						   fsnotify_connp_t *connp,
 						   unsigned int obj_type,
 						   unsigned int fan_flags,
-						   __kernel_fsid_t *fsid)
+						   struct fan_fsid *fsid)
 {
 	struct ucounts *ucounts = group->fanotify_data.ucounts;
 	struct fanotify_mark *fan_mark;
@@ -1225,20 +1282,21 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
 
 	/* Cache fsid of filesystem containing the marked object */
 	if (fsid) {
-		fan_mark->fsid = *fsid;
-		mark->flags |= FSNOTIFY_MARK_FLAG_HAS_FSID;
+		ret = fanotify_set_mark_fsid(group, mark, fsid);
+		if (ret)
+			goto out_put_mark;
 	} else {
 		fan_mark->fsid.val[0] = fan_mark->fsid.val[1] = 0;
 	}
 
 	ret = fsnotify_add_mark_locked(mark, connp, obj_type, 0);
-	if (ret) {
-		fsnotify_put_mark(mark);
-		goto out_dec_ucounts;
-	}
+	if (ret)
+		goto out_put_mark;
 
 	return mark;
 
+out_put_mark:
+	fsnotify_put_mark(mark);
 out_dec_ucounts:
 	if (!FAN_GROUP_FLAG(group, FAN_UNLIMITED_MARKS))
 		dec_ucount(ucounts, UCOUNT_FANOTIFY_MARKS);
@@ -1289,7 +1347,7 @@ static int fanotify_may_update_existing_mark(struct fsnotify_mark *fsn_mark,
 static int fanotify_add_mark(struct fsnotify_group *group,
 			     fsnotify_connp_t *connp, unsigned int obj_type,
 			     __u32 mask, unsigned int fan_flags,
-			     __kernel_fsid_t *fsid)
+			     struct fan_fsid *fsid)
 {
 	struct fsnotify_mark *fsn_mark;
 	bool recalc;
@@ -1337,7 +1395,7 @@ static int fanotify_add_mark(struct fsnotify_group *group,
 
 static int fanotify_add_vfsmount_mark(struct fsnotify_group *group,
 				      struct vfsmount *mnt, __u32 mask,
-				      unsigned int flags, __kernel_fsid_t *fsid)
+				      unsigned int flags, struct fan_fsid *fsid)
 {
 	return fanotify_add_mark(group, &real_mount(mnt)->mnt_fsnotify_marks,
 				 FSNOTIFY_OBJ_TYPE_VFSMOUNT, mask, flags, fsid);
@@ -1345,7 +1403,7 @@ static int fanotify_add_vfsmount_mark(struct fsnotify_group *group,
 
 static int fanotify_add_sb_mark(struct fsnotify_group *group,
 				struct super_block *sb, __u32 mask,
-				unsigned int flags, __kernel_fsid_t *fsid)
+				unsigned int flags, struct fan_fsid *fsid)
 {
 	return fanotify_add_mark(group, &sb->s_fsnotify_marks,
 				 FSNOTIFY_OBJ_TYPE_SB, mask, flags, fsid);
@@ -1353,7 +1411,7 @@ static int fanotify_add_sb_mark(struct fsnotify_group *group,
 
 static int fanotify_add_inode_mark(struct fsnotify_group *group,
 				   struct inode *inode, __u32 mask,
-				   unsigned int flags, __kernel_fsid_t *fsid)
+				   unsigned int flags, struct fan_fsid *fsid)
 {
 	pr_debug("%s: group=%p inode=%p\n", __func__, group, inode);
 
@@ -1564,20 +1622,25 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	return fd;
 }
 
-static int fanotify_test_fsid(struct dentry *dentry, __kernel_fsid_t *fsid)
+static int fanotify_test_fsid(struct dentry *dentry, unsigned int flags,
+			      struct fan_fsid *fsid)
 {
+	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
 	__kernel_fsid_t root_fsid;
 	int err;
 
 	/*
 	 * Make sure dentry is not of a filesystem with zero fsid (e.g. fuse).
 	 */
-	err = vfs_get_fsid(dentry, fsid);
+	err = vfs_get_fsid(dentry, &fsid->id);
 	if (err)
 		return err;
 
-	if (!fsid->val[0] && !fsid->val[1])
-		return -ENODEV;
+	fsid->sb = dentry->d_sb;
+	if (!fsid->id.val[0] && !fsid->id.val[1]) {
+		err = -ENODEV;
+		goto weak;
+	}
 
 	/*
 	 * Make sure dentry is not of a filesystem subvolume (e.g. btrfs)
@@ -1587,11 +1650,18 @@ static int fanotify_test_fsid(struct dentry *dentry, __kernel_fsid_t *fsid)
 	if (err)
 		return err;
 
-	if (root_fsid.val[0] != fsid->val[0] ||
-	    root_fsid.val[1] != fsid->val[1])
-		return -EXDEV;
+	if (!fanotify_fsid_equal(&root_fsid, &fsid->id)) {
+		err = -EXDEV;
+		goto weak;
+	}
 
+	fsid->weak = false;
 	return 0;
+
+weak:
+	/* Allow weak fsid when marking inodes */
+	fsid->weak = true;
+	return (mark_type == FAN_MARK_INODE) ? 0 : err;
 }
 
 /* Check if filesystem can encode a unique fid */
@@ -1675,7 +1745,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	struct fsnotify_group *group;
 	struct fd f;
 	struct path path;
-	__kernel_fsid_t __fsid, *fsid = NULL;
+	struct fan_fsid __fsid, *fsid = NULL;
 	u32 valid_mask = FANOTIFY_EVENTS | FANOTIFY_EVENT_FLAGS;
 	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
 	unsigned int mark_cmd = flags & FANOTIFY_MARK_CMD_BITS;
@@ -1827,7 +1897,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	}
 
 	if (fid_mode) {
-		ret = fanotify_test_fsid(path.dentry, &__fsid);
+		ret = fanotify_test_fsid(path.dentry, flags, &__fsid);
 		if (ret)
 			goto path_put_and_out;
 
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index a80b525ca653..7f63be5ca0f1 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -529,6 +529,7 @@ struct fsnotify_mark {
 #define FSNOTIFY_MARK_FLAG_NO_IREF		0x0200
 #define FSNOTIFY_MARK_FLAG_HAS_IGNORE_FLAGS	0x0400
 #define FSNOTIFY_MARK_FLAG_HAS_FSID		0x0800
+#define FSNOTIFY_MARK_FLAG_WEAK_FSID		0x1000
 	unsigned int flags;		/* flags [mark->lock] */
 };
 
-- 
2.34.1


