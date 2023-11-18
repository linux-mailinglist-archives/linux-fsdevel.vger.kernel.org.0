Return-Path: <linux-fsdevel+bounces-3122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4082A7F01F2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Nov 2023 19:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 845C7B20BA4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Nov 2023 18:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDC21DDF1;
	Sat, 18 Nov 2023 18:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRuoI68P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED7B9E
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Nov 2023 10:30:28 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-408382da7f0so5308045e9.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Nov 2023 10:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700332227; x=1700937027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LV+z44LVvXucwGOb6i6U1YCzrHsibFvIwlobGCJGxpQ=;
        b=fRuoI68PLSAJWO+m4fp+jLSMMBIfLLadQyhCE3CxTUpg2MnDbYjSF9UN7cL69pjiO0
         srTCfpyQx2SwRkAmOUH/TnI+IsxQTurOwawHhpxJjDM+xlKSsiQUcPlxzOq4YXQcKQpS
         OSJleGr3SjVVWsySZdj4NM8Ju23hrnausMa+HFpx01Gk7/xBmi1rodpnqS4cspoNtKRn
         pwhcsjUW5mhjgAACg0A/mi7o4wByoTD848YyVyoL41uBf/hJ3BeWFmXlL7ajLURMmMfC
         qyKHmUEi87YUOlIIALKZsb/RksPM+C8dzQUJMVkfneP5N6+xVFT3mYolkH55/BVnY02A
         /PYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700332227; x=1700937027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LV+z44LVvXucwGOb6i6U1YCzrHsibFvIwlobGCJGxpQ=;
        b=BseP6L8BdP9OyU5qSMG/PBkVcHrjcO72K6FBAn9IZOMtkLkxk21n8jdnciaT3FY2BV
         WjuWWuYeL/M/9HMGwkobuUjGbrAOvsBUVnWvFP+g2gDW6/Rg5xVLMshvrHdS7vKj0nL5
         E5SUm7l58AQ63NCnwcNTDSK2+qv1y76esQYsYu4YzGPjotfAScC26nFqDly9eMiMfxjZ
         e4Tqvkt//vP5Glzsotm0hllTLJFIXexF9u6ck1K9wYclkIr5gZae6UIPtAiGxed2+mme
         +RY/LChpEHsmMZyZ4YRWIhUQG+xT7/YRvJxeFMHGQZuGrN+eccf5WEPq7oJYXmC1I1tG
         zXxQ==
X-Gm-Message-State: AOJu0YwYp3BeGJYfYIFulXhIGoUU+s65CGtgiu9qxXdaxqP5jpefqrwS
	1ICtuaDxHG6ucNzsBGLB+Is=
X-Google-Smtp-Source: AGHT+IGmyuN/14y3NVj+j8wjRZAIX8H/TgKLjMsUSxYfPGJtz3wyPzAg3sZPqae+5arxk7zG70BJ5Q==
X-Received: by 2002:a05:600c:4453:b0:409:5c2b:43d1 with SMTP id v19-20020a05600c445300b004095c2b43d1mr2360195wmn.20.1700332226317;
        Sat, 18 Nov 2023 10:30:26 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id bg6-20020a05600c3c8600b004090ca6d785sm7373327wmb.2.2023.11.18.10.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 10:30:25 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] fanotify: allow "weak" fsid when watching a single filesystem
Date: Sat, 18 Nov 2023 20:30:18 +0200
Message-Id: <20231118183018.2069899-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231118183018.2069899-1-amir73il@gmail.com>
References: <20231118183018.2069899-1-amir73il@gmail.com>
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
 fs/notify/fanotify/fanotify.c      | 15 +----
 fs/notify/fanotify/fanotify.h      |  6 ++
 fs/notify/fanotify/fanotify_user.c | 97 ++++++++++++++++++++++++------
 include/linux/fsnotify_backend.h   |  1 +
 4 files changed, 90 insertions(+), 29 deletions(-)

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
index 2847fa564298..9c97ae638ac5 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -504,6 +504,12 @@ static inline __kernel_fsid_t *fanotify_mark_fsid(struct fsnotify_mark *mark)
 	return &FANOTIFY_MARK(mark)->fsid;
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
index e3d836d4d156..1cc68ea56c17 100644
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
+static int fanotify_check_mark_fsid(struct fsnotify_group *group,
+				    struct fsnotify_mark *mark,
+				    struct fan_fsid *fsid)
+{
+	struct fsnotify_mark_connector *conn;
+	struct fsnotify_mark *old;
+	struct super_block *old_sb = NULL;
+
+	*fanotify_mark_fsid(mark) = fsid->id;
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
+	if (!fanotify_fsid_equal(fanotify_mark_fsid(old),
+				 fanotify_mark_fsid(mark)))
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
@@ -1225,8 +1282,9 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
 
 	/* Cache fsid of filesystem containing the marked object */
 	if (fsid) {
-		fan_mark->fsid = *fsid;
-		mark->flags |= FSNOTIFY_MARK_FLAG_HAS_FSID;
+		ret = fanotify_check_mark_fsid(group, mark, fsid);
+		if (ret)
+			goto out_dec_ucounts;
 	} else {
 		fan_mark->fsid.val[0] = fan_mark->fsid.val[1] = 0;
 	}
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
+	/* Allow weak fsid when marking inodes */
+	fsid->sb = dentry->d_sb;
+	fsid->weak = mark_type == FAN_MARK_INODE;
+	if (!fsid->id.val[0] && !fsid->id.val[1])
+		return fsid->weak ? 0 : -ENODEV;
 
 	/*
 	 * Make sure dentry is not of a filesystem subvolume (e.g. btrfs)
@@ -1587,10 +1650,10 @@ static int fanotify_test_fsid(struct dentry *dentry, __kernel_fsid_t *fsid)
 	if (err)
 		return err;
 
-	if (root_fsid.val[0] != fsid->val[0] ||
-	    root_fsid.val[1] != fsid->val[1])
-		return -EXDEV;
+	if (!fanotify_fsid_equal(&root_fsid, &fsid->id))
+		return fsid->weak ? 0 : -EXDEV;
 
+	fsid->weak = false;
 	return 0;
 }
 
@@ -1675,7 +1738,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	struct fsnotify_group *group;
 	struct fd f;
 	struct path path;
-	__kernel_fsid_t __fsid, *fsid = NULL;
+	struct fan_fsid __fsid, *fsid = NULL;
 	u32 valid_mask = FANOTIFY_EVENTS | FANOTIFY_EVENT_FLAGS;
 	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
 	unsigned int mark_cmd = flags & FANOTIFY_MARK_CMD_BITS;
@@ -1827,7 +1890,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
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


