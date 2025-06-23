Return-Path: <linux-fsdevel+bounces-52466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9842AE3488
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 06:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 662C516D817
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 04:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22F01F4177;
	Mon, 23 Jun 2025 04:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="qK8Y8rrr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D2F1E231F
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 04:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750654477; cv=none; b=iurXoSpsRdUOgifbTALoFtqmHLdQOz1XIxJFNwIZE2lPlcId54G5s/bE0tUVBJt89IYeuqpKP2e93XqRA0UAKalL1//Vntm3Tz0usFR6X3YhkmwX/W/9hI3Wn+KmTm7HSGupY6LB8oWaAz5QmlT4UgLybZwWW+TcWv5Anr18DQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750654477; c=relaxed/simple;
	bh=aYgaF/ITO4d+funNeOByqP/B56JIRn7Ot+Ly60WU3F0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E9bGbRmFemXeNU+daVDRiigP+/Zi4lbl+tepiBrlH34AErWqqGzG4WN5QN60R2ECny+WKDhvpHgiwvxKqO0cbiraL4hyvboNG4c92CZK6r0iWuI9jbnFw8R8HcUACDgXr0PVmM3gw2x8IKE6SZyplLo5ktalaRoIRjn/S9d1pj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=qK8Y8rrr; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=TnNzp7P2A67CUSsf6yDN6gx7CzZ+/4sabbdTQelSgJI=; b=qK8Y8rrrOnu0VKAwv/naIV3RUk
	UPq+uweeKjns2pC1zBzVKxUrpIkEIxJfmFh8Ubml8Ack/2CSMzXotsQCuO5B4xyMJz+HkDOBoqKot
	L+7EwLZcDQouGvp26A/f6iLbIcT/m0B89476A+ygx7zKg/0O3MYR1M71XzA6wYEpL35xuA0LXaRYE
	HhIzfm7WXX2uYwFnzwlqrlceRwcDPrayY9+vLxKRXa1GCoo/saerh0Jq+QsxjylAKeMOWzlgG2hXC
	Egf9bYh+FXndxYRMPillTFsaEB5UNv8eDFDGzg8fUKFFhS2Nu/zCIUpIt6AMGIkbd8ja60nA3tSdF
	YV13uOfA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTZCT-00000005KuC-22ID;
	Mon, 23 Jun 2025 04:54:33 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 31/35] copy_tree(): don't link the mounts via mnt_list
Date: Mon, 23 Jun 2025 05:54:24 +0100
Message-ID: <20250623045428.1271612-31-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623045428.1271612-1-viro@zeniv.linux.org.uk>
References: <20250623044912.GA1248894@ZenIV>
 <20250623045428.1271612-1-viro@zeniv.linux.org.uk>
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
index 4355c482a841..c5b170b6cb3c 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -176,7 +176,7 @@ static inline bool mnt_ns_empty(const struct mnt_namespace *ns)
 	return RB_EMPTY_ROOT(&ns->mounts);
 }
 
-static inline void move_from_ns(struct mount *mnt, struct list_head *dt_list)
+static inline void move_from_ns(struct mount *mnt)
 {
 	struct mnt_namespace *ns = mnt->mnt_ns;
 	WARN_ON(!mnt_ns_attached(mnt));
@@ -186,7 +186,6 @@ static inline void move_from_ns(struct mount *mnt, struct list_head *dt_list)
 		ns->mnt_first_node = rb_next(&mnt->mnt_node);
 	rb_erase(&mnt->mnt_node, &ns->mounts);
 	RB_CLEAR_NODE(&mnt->mnt_node);
-	list_add_tail(&mnt->mnt_list, dt_list);
 }
 
 bool has_locked_children(struct mount *mnt, struct dentry *dentry);
diff --git a/fs/namespace.c b/fs/namespace.c
index 4b123e2384ca..5556c5edbae9 100644
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
index 73a64c55deb3..f897a501bee7 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -459,7 +459,8 @@ static void umount_one(struct mount *m, struct list_head *to_umount)
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


