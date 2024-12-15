Return-Path: <linux-fsdevel+bounces-37449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEDE9F2601
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Dec 2024 21:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B43701645BD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Dec 2024 20:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A4B1BC9F6;
	Sun, 15 Dec 2024 20:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIAfEZ+6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875428831
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Dec 2024 20:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734293850; cv=none; b=ctk26BCBRa+rsfzM+c2X56WRsB1eCqqwPSsfGq8HFSOuCXq086UmMhLs/5V/wQaMtPWWA1TZxqwrjzUtVlJk+9C03kVCqBs7Vgk9U0GBG893G50wHEirq5KDS/fXj/cGfpjfFXm29qLSTcgz9JkJF5aKm3dbz5qJzmlTjBx2fus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734293850; c=relaxed/simple;
	bh=W2efpwf1KYhsOHyF/eT+yY7EjGP6BhsW/NaEjUnHOdU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mq9Y58rShD5LLOz4i67DcxaSNR0rb6KTS+Imq1pQI2791QXM0A8Q+EBjqIf9jDVjft1wJmj9V2lnXNydd2jgSw4oNHUQtpDIuPGkQK6dQ8zsPtVjqyidy/YVUZ6EFyp85PTOTttKzcYtCvhyTA7edUs7klbzRQxydjD7JhM+Aqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIAfEZ+6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC661C4CEDD;
	Sun, 15 Dec 2024 20:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734293850;
	bh=W2efpwf1KYhsOHyF/eT+yY7EjGP6BhsW/NaEjUnHOdU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PIAfEZ+6YgrdGK+tO+s3psQOWUKjMz6bN2OzJ5yH0RrS+CxQYl3TgbqQi2NTZQTMG
	 YCwE7z+ZCExK+HYgyZsrMqB0/6lT5gBGGelchiWbjUMYcwdTEblXNjVg/lVtMMjM4Y
	 C9UdX8dCaMWlGCzvq5KFuk8JYxNnOqCwEeefvzfzYHdO+jvuMCViX/le1PBshRmyUK
	 srvbLkwcQnLHIUpRWqpb5SkJ+Kv0pEdWAHHDX0r1JgQnBlu0/rKhISXFV7HUjzUd2t
	 6ZMjt+YpNGHs4uRBqYizZtns1YNvaWtRwgarcGsyXJGTOOzqGxtnvX8eIEemtffsJ4
	 4EU21kI3Y/gmg==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 15 Dec 2024 21:17:05 +0100
Subject: [PATCH 1/3] fs: kill MNT_ONRB
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241215-vfs-6-14-mount-work-v1-1-fd55922c4af8@kernel.org>
References: <20241215-vfs-6-14-mount-work-v1-0-fd55922c4af8@kernel.org>
In-Reply-To: <20241215-vfs-6-14-mount-work-v1-0-fd55922c4af8@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5283; i=brauner@kernel.org;
 h=from:subject:message-id; bh=W2efpwf1KYhsOHyF/eT+yY7EjGP6BhsW/NaEjUnHOdU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTHW4atESi8e4HbcffL89lvtsc8nn5xueCs2/GSFz7J+
 xUEHzx0u6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiBSyMDKc1MpgUOYTNeSW/
 ex1gWhx37Dhv/2nmNzIyx1lfLPCymsnI0H1IiMdfpSfzmaRSQl2Dpozm6ZJZX6q8X60sN7nQ4vm
 ZAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Move mnt->mnt_node into the union with mnt->mnt_rcu and mnt->mnt_llist
instead of keeping it with mnt->mnt_list. This allows us to use
RB_CLEAR_NODE(&mnt->mnt_node) in umount_tree() as well as
list_empty(&mnt->mnt_node). That in turn allows us to remove MNT_ONRB.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/mount.h            | 15 +++++++++------
 fs/namespace.c        | 14 ++++++--------
 include/linux/mount.h |  3 +--
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index 8cda387f47c5efd9af5e2e422569446c3d51986f..e9f48e563c0fe9c4af77369423db2cc8695fa808 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -42,6 +42,7 @@ struct mount {
 	struct dentry *mnt_mountpoint;
 	struct vfsmount mnt;
 	union {
+		struct rb_node mnt_node; /* node in the ns->mounts rbtree */
 		struct rcu_head mnt_rcu;
 		struct llist_node mnt_llist;
 	};
@@ -55,10 +56,7 @@ struct mount {
 	struct list_head mnt_child;	/* and going through their mnt_child */
 	struct list_head mnt_instance;	/* mount instance on sb->s_mounts */
 	const char *mnt_devname;	/* Name of device e.g. /dev/dsk/hda1 */
-	union {
-		struct rb_node mnt_node;	/* Under ns->mounts */
-		struct list_head mnt_list;
-	};
+	struct list_head mnt_list;
 	struct list_head mnt_expire;	/* link in fs-specific expiry list */
 	struct list_head mnt_share;	/* circular list of shared mounts */
 	struct list_head mnt_slave_list;/* list of slave mounts */
@@ -149,11 +147,16 @@ static inline bool is_anon_ns(struct mnt_namespace *ns)
 	return ns->seq == 0;
 }
 
+static inline bool mnt_ns_attached(const struct mount *mnt)
+{
+	return !RB_EMPTY_NODE(&mnt->mnt_node);
+}
+
 static inline void move_from_ns(struct mount *mnt, struct list_head *dt_list)
 {
-	WARN_ON(!(mnt->mnt.mnt_flags & MNT_ONRB));
-	mnt->mnt.mnt_flags &= ~MNT_ONRB;
+	WARN_ON(!mnt_ns_attached(mnt));
 	rb_erase(&mnt->mnt_node, &mnt->mnt_ns->mounts);
+	RB_CLEAR_NODE(&mnt->mnt_node);
 	list_add_tail(&mnt->mnt_list, dt_list);
 }
 
diff --git a/fs/namespace.c b/fs/namespace.c
index 966dcd27c81cc877837eca747babe0bc31aaf922..d67df0fce4dcd1ee5ddf9ff5fbe005bcdcd626f1 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -378,6 +378,7 @@ static struct mount *alloc_vfsmnt(const char *name)
 		INIT_HLIST_NODE(&mnt->mnt_mp_list);
 		INIT_LIST_HEAD(&mnt->mnt_umounting);
 		INIT_HLIST_HEAD(&mnt->mnt_stuck_children);
+		RB_CLEAR_NODE(&mnt->mnt_node);
 		mnt->mnt.mnt_idmap = &nop_mnt_idmap;
 	}
 	return mnt;
@@ -1158,7 +1159,7 @@ static void mnt_add_to_ns(struct mnt_namespace *ns, struct mount *mnt)
 	struct rb_node **link = &ns->mounts.rb_node;
 	struct rb_node *parent = NULL;
 
-	WARN_ON(mnt->mnt.mnt_flags & MNT_ONRB);
+	WARN_ON(mnt_ns_attached(mnt));
 	mnt->mnt_ns = ns;
 	while (*link) {
 		parent = *link;
@@ -1169,7 +1170,6 @@ static void mnt_add_to_ns(struct mnt_namespace *ns, struct mount *mnt)
 	}
 	rb_link_node(&mnt->mnt_node, parent, link);
 	rb_insert_color(&mnt->mnt_node, &ns->mounts);
-	mnt->mnt.mnt_flags |= MNT_ONRB;
 }
 
 /*
@@ -1339,7 +1339,7 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 	}
 
 	mnt->mnt.mnt_flags = old->mnt.mnt_flags;
-	mnt->mnt.mnt_flags &= ~(MNT_WRITE_HOLD|MNT_MARKED|MNT_INTERNAL|MNT_ONRB);
+	mnt->mnt.mnt_flags &= ~(MNT_WRITE_HOLD|MNT_MARKED|MNT_INTERNAL);
 
 	atomic_inc(&sb->s_active);
 	mnt->mnt.mnt_idmap = mnt_idmap_get(mnt_idmap(&old->mnt));
@@ -1797,7 +1797,7 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
 	/* Gather the mounts to umount */
 	for (p = mnt; p; p = next_mnt(p, mnt)) {
 		p->mnt.mnt_flags |= MNT_UMOUNT;
-		if (p->mnt.mnt_flags & MNT_ONRB)
+		if (mnt_ns_attached(p))
 			move_from_ns(p, &tmp_list);
 		else
 			list_move(&p->mnt_list, &tmp_list);
@@ -1946,16 +1946,14 @@ static int do_umount(struct mount *mnt, int flags)
 
 	event++;
 	if (flags & MNT_DETACH) {
-		if (mnt->mnt.mnt_flags & MNT_ONRB ||
-		    !list_empty(&mnt->mnt_list))
+		if (mnt_ns_attached(mnt) || !list_empty(&mnt->mnt_list))
 			umount_tree(mnt, UMOUNT_PROPAGATE);
 		retval = 0;
 	} else {
 		shrink_submounts(mnt);
 		retval = -EBUSY;
 		if (!propagate_mount_busy(mnt, 2)) {
-			if (mnt->mnt.mnt_flags & MNT_ONRB ||
-			    !list_empty(&mnt->mnt_list))
+			if (mnt_ns_attached(mnt) || !list_empty(&mnt->mnt_list))
 				umount_tree(mnt, UMOUNT_PROPAGATE|UMOUNT_SYNC);
 			retval = 0;
 		}
diff --git a/include/linux/mount.h b/include/linux/mount.h
index c34c18b4e8f36f27775c4df624890eb8e6060965..04213d8ef8376d42d83b44d5a2ce1c35ad5a942e 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -50,7 +50,7 @@ struct path;
 #define MNT_ATIME_MASK (MNT_NOATIME | MNT_NODIRATIME | MNT_RELATIME )
 
 #define MNT_INTERNAL_FLAGS (MNT_SHARED | MNT_WRITE_HOLD | MNT_INTERNAL | \
-			    MNT_DOOMED | MNT_SYNC_UMOUNT | MNT_MARKED | MNT_ONRB)
+			    MNT_DOOMED | MNT_SYNC_UMOUNT | MNT_MARKED)
 
 #define MNT_INTERNAL	0x4000
 
@@ -64,7 +64,6 @@ struct path;
 #define MNT_SYNC_UMOUNT		0x2000000
 #define MNT_MARKED		0x4000000
 #define MNT_UMOUNT		0x8000000
-#define MNT_ONRB		0x10000000
 
 struct vfsmount {
 	struct dentry *mnt_root;	/* root of the mounted tree */

-- 
2.45.2


