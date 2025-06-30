Return-Path: <linux-fsdevel+bounces-53284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C2AAED2AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 04:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93651168863
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 02:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B4D21CC6D;
	Mon, 30 Jun 2025 02:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="UCLTcD3o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9A21DE3C0
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 02:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751251984; cv=none; b=nZv7lIvVw5YbMN//z2DwgcHt6hi2FG2GHFnYnBwiF4h8PNjIwH3pXXu7DO1kEydi+feDtJFypViLAm4esJ1mMfA3oDChAiOf7bKPSjLBONFVdT7gSfXlEvtNNEBkKdLhS1WbCai1UZpq++/xmJBUkI6xbrvkaNmn4qtLOWfA8Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751251984; c=relaxed/simple;
	bh=x7E9F7Nuqwjje23qZ7dQGQwGyhd92IWEve3su1odd24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VbDnnoqyAVMAE5UBvFbTPxVKJqBSfwAPgqt1xvMYQ6sXrsSOPPn1HFp3XDB+uF0sK1+7VA7+VLWnDnG+88j577gxuq570RQa7yO/GxcKMCLlzQv6vG0VzbXAUmMx2yaeU4BrxMSG177sLSCKmT2PYOFssrnT2yrZgkNS9ywW/zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=UCLTcD3o; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=JwXJleBDozlwbJTHO8R7DGhlYvwN5TyaYLITqkipCnE=; b=UCLTcD3ogTI9m1eI92OOlU3/Ey
	D8Nf5bKc5T/CMbsJMndqrimenohOVxEK0lHJ3Tjgapm0jg0cXUfJ/SeLlKSHl+w/sQaut2+xN1Kb4
	I6zl2GyphmKLt2qJNyQX4TRLwMJWf5yuR+oRa509tRKWXwgb43xIjxhC6sZvt/i4gIMC8K5l4TIaG
	hjZBxLalC8xxgcs6PRqKP2CrSWM8nhhaJauoAT8Kdm35C242lmBzqWxlLACDlpss2Nnm5LIX5MV8e
	VEGPNlGuNLJCDnSVddiZIau32gyHQ922y4CFTeNEt7NE89jNsXyoDEszsytBanUmcCf22jytHXWqh
	ht6YK8Aw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW4dg-00000005p3M-2nu0;
	Mon, 30 Jun 2025 02:53:00 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 44/48] copy_tree(): don't link the mounts via mnt_list
Date: Mon, 30 Jun 2025 03:52:51 +0100
Message-ID: <20250630025255.1387419-44-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630025255.1387419-1-viro@zeniv.linux.org.uk>
References: <20250630025148.GA1383774@ZenIV>
 <20250630025255.1387419-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

The only place that really needs to be adjusted is commit_tree() -
there we need to iterate through the copy and we might as well
use next_mnt() for that.  However, in case when our tree has been
slid under something already mounted (propagation to a mountpoint
that already has something mounted on it or a 'beneath' move_mount)
we need to take care not to walk into the overmounting tree.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/mount.h     |  3 +--
 fs/namespace.c | 60 ++++++++++++++++++++------------------------------
 fs/pnode.c     |  3 ++-
 3 files changed, 27 insertions(+), 39 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index 08583428b10b..97737051a8b9 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -193,7 +193,7 @@ static inline bool mnt_ns_empty(const struct mnt_namespace *ns)
 	return RB_EMPTY_ROOT(&ns->mounts);
 }
 
-static inline void move_from_ns(struct mount *mnt, struct list_head *dt_list)
+static inline void move_from_ns(struct mount *mnt)
 {
 	struct mnt_namespace *ns = mnt->mnt_ns;
 	WARN_ON(!mnt_ns_attached(mnt));
@@ -203,7 +203,6 @@ static inline void move_from_ns(struct mount *mnt, struct list_head *dt_list)
 		ns->mnt_first_node = rb_next(&mnt->mnt_node);
 	rb_erase(&mnt->mnt_node, &ns->mounts);
 	RB_CLEAR_NODE(&mnt->mnt_node);
-	list_add_tail(&mnt->mnt_list, dt_list);
 }
 
 bool has_locked_children(struct mount *mnt, struct dentry *dentry);
diff --git a/fs/namespace.c b/fs/namespace.c
index 38a46b32413d..bd6c7da901fc 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1161,34 +1161,6 @@ static void mnt_add_to_ns(struct mnt_namespace *ns, struct mount *mnt)
 	mnt_notify_add(mnt);
 }
 
-/*
- * vfsmount lock must be held for write
- */
-static void commit_tree(struct mount *mnt)
-{
-	struct mount *parent = mnt->mnt_parent;
-	struct mount *m;
-	LIST_HEAD(head);
-	struct mnt_namespace *n = parent->mnt_ns;
-
-	BUG_ON(parent == mnt);
-
-	if (!mnt_ns_attached(mnt)) {
-		list_add_tail(&head, &mnt->mnt_list);
-		while (!list_empty(&head)) {
-			m = list_first_entry(&head, typeof(*m), mnt_list);
-			list_del(&m->mnt_list);
-
-			mnt_add_to_ns(n, m);
-		}
-		n->nr_mounts += n->pending_mounts;
-		n->pending_mounts = 0;
-	}
-
-	make_visible(mnt);
-	touch_mnt_namespace(n);
-}
-
 static struct mount *next_mnt(struct mount *p, struct mount *root)
 {
 	struct list_head *next = p->mnt_mounts.next;
@@ -1215,6 +1187,27 @@ static struct mount *skip_mnt_tree(struct mount *p)
 	return p;
 }
 
+/*
+ * vfsmount lock must be held for write
+ */
+static void commit_tree(struct mount *mnt)
+{
+	struct mnt_namespace *n = mnt->mnt_parent->mnt_ns;
+
+	if (!mnt_ns_attached(mnt)) {
+		for (struct mount *m = mnt; m; m = next_mnt(m, mnt))
+			if (unlikely(mnt_ns_attached(m)))
+				m = skip_mnt_tree(m);
+			else
+				mnt_add_to_ns(n, m);
+		n->nr_mounts += n->pending_mounts;
+		n->pending_mounts = 0;
+	}
+
+	make_visible(mnt);
+	touch_mnt_namespace(n);
+}
+
 /**
  * vfs_create_mount - Create a mount for a configured superblock
  * @fc: The configuration context with the superblock attached
@@ -1831,9 +1824,8 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
 	for (p = mnt; p; p = next_mnt(p, mnt)) {
 		p->mnt.mnt_flags |= MNT_UMOUNT;
 		if (mnt_ns_attached(p))
-			move_from_ns(p, &tmp_list);
-		else
-			list_move(&p->mnt_list, &tmp_list);
+			move_from_ns(p);
+		list_add_tail(&p->mnt_list, &tmp_list);
 	}
 
 	/* Hide the mounts from mnt_mounts */
@@ -2270,7 +2262,6 @@ struct mount *copy_tree(struct mount *src_root, struct dentry *dentry,
 					list_add(&dst_mnt->mnt_expire,
 						 &src_mnt->mnt_expire);
 			}
-			list_add_tail(&dst_mnt->mnt_list, &res->mnt_list);
 			attach_mnt(dst_mnt, dst_parent, src_parent->mnt_mp);
 			unlock_mount_hash();
 		}
@@ -2686,12 +2677,9 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 		list_del_init(&source_mnt->mnt_expire);
 	} else {
 		if (source_mnt->mnt_ns) {
-			LIST_HEAD(head);
-
 			/* move from anon - the caller will destroy */
 			for (p = source_mnt; p; p = next_mnt(p, source_mnt))
-				move_from_ns(p, &head);
-			list_del_init(&head);
+				move_from_ns(p);
 		}
 	}
 
diff --git a/fs/pnode.c b/fs/pnode.c
index cbf5f5746252..81f7599bdac4 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -449,7 +449,8 @@ static void umount_one(struct mount *m, struct list_head *to_umount)
 {
 	m->mnt.mnt_flags |= MNT_UMOUNT;
 	list_del_init(&m->mnt_child);
-	move_from_ns(m, to_umount);
+	move_from_ns(m);
+	list_add_tail(&m->mnt_list, to_umount);
 }
 
 static void remove_from_candidate_list(struct mount *m)
-- 
2.39.5


