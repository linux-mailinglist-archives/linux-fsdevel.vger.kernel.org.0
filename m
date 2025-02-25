Return-Path: <linux-fsdevel+bounces-42560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B226A43B37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 11:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD7DE16BFFA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 10:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5432266196;
	Tue, 25 Feb 2025 10:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVDSQTiS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DCC260A29
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2025 10:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740478602; cv=none; b=isZQZVK9GRh775tL+z1s5oLc5I7XIr3D1qQ+UIyEvWzL8NY6/UbLxOOmIAsue55VbzORZn4UbA60tIdVPOubI3LkyqwOVUmPFkAJu7xRYj4YQZkekLkvTeFyAf9hTw9GovayLZfbfpkkzYvDUxattuks76TC9VLR+6dKCZKyB6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740478602; c=relaxed/simple;
	bh=aEmXCHQrohymmUvc9bEZGwPBYCZ1O6+W4FKAIe1hRkM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B13XoSLgr5Wi42wxB7xgojEGXTtxBqma99bKVRFZG7qZjgxPYDhRU2Y7s93FGCNYaisW3yMqLO1t5UcK4d1hrOx42oLK2zD/X8V9jW3XllxKLT+mzKkLyo6TtBjS9ZoGldOk6Q4ARM02hMOaS9c3lN4AUSE7JoNUpoWqy6UE48Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pVDSQTiS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A79EC4CEE7;
	Tue, 25 Feb 2025 10:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740478601;
	bh=aEmXCHQrohymmUvc9bEZGwPBYCZ1O6+W4FKAIe1hRkM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pVDSQTiSFFAK08MriAXDNstg8/5uEz3PKyUO7y4zY9RpP2KC6AkI5CXFu1PV3RVkh
	 Q05A+XRlPKMbBVIqRbzYIkaUI5zSZE8ZAMmgG2vRkIPCc4OPLw4x1Qi8VFU0HsXsK0
	 xvJLXBnTifyfafTD8NbHFOqGgWWbCBB04FKZ7c2fOfMyi2eAp6+GhGRoP3sL6jrB+P
	 rVU2DbKJuSY6PVEX8XDtV7HTh+Ry1WDub3/li566em83YQXe80kPThQs/w1HTPY9eQ
	 1UcnjHOZfxq58yIy9N4yqbG74G2zpbUfA5wdx6nETOQjDKDDRlwBP3F2VfvBuF19tN
	 wQCzwk1aeeNAw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 25 Feb 2025 11:15:46 +0100
Subject: [PATCH 1/3] mount: handle mount propagation for detached mount
 trees
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-work-mount-propagation-v1-1-e6e3724500eb@kernel.org>
References: <20250225-work-mount-propagation-v1-0-e6e3724500eb@kernel.org>
In-Reply-To: <20250225-work-mount-propagation-v1-0-e6e3724500eb@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Seth Forshee <sforshee@kernel.org>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=6739; i=brauner@kernel.org;
 h=from:subject:message-id; bh=aEmXCHQrohymmUvc9bEZGwPBYCZ1O6+W4FKAIe1hRkM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTvndG6LoT5ue/rlUc4TKb2eW341hw6OW2be01F2mS5t
 1dPmPKYd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzk4DdGhg+WrZJrtDqcBLs2
 X6tSDMldmXb/08FT/HdNwswelV0J12NkmFspM3HyLqvJdr9niYYHr5HSqKqW2BrTYBxVHN+ULRz
 GCwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

In commit ee2e3f50629f ("mount: fix mounting of detached mounts onto
targets that reside on shared mounts") I fixed a bug where propagating
the source mount tree of an anonymous mount namespace into a target
mount tree of a non-anonymous mount namespace could be used to trigger
an integer overflow in the non-anonymous mount namespace causing any new
mounts to fail.

The cause of this was that the propagation algorithm was unable to
recognize mounts from the source mount tree that were already propagated
into the target mount tree and then reappeared as propagation targets
when walking the destination propagation mount tree.

When fixing this I disabled mount propagation into anonymous mount
namespaces. Make it possible for anonymous mount namespace to receive
mount propagation events correctly. This is no also a correctness issue
now that we allow mounting detached mount trees onto detached mount
trees.

Mark the source anonymous mount namespace with MNTNS_PROPAGATING
indicating that all mounts belonging to this mount namespace are
currently in the process of being propagated and make the propagation
algorithm discard those if they appear as propagation targets.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/mount.h     |  7 +++++++
 fs/namespace.c | 42 +++++++++++++++++++++++++++---------------
 fs/pnode.c     | 10 +++++-----
 fs/pnode.h     |  2 +-
 4 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index e2501a724688..96862eba2246 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -5,6 +5,12 @@
 #include <linux/ns_common.h>
 #include <linux/fs_pin.h>
 
+extern struct list_head notify_list;
+
+typedef __u32 __bitwise mntns_flags_t;
+
+#define MNTNS_PROPAGATING	((__force mntns_flags_t)(1 << 0))
+
 struct mnt_namespace {
 	struct ns_common	ns;
 	struct mount *	root;
@@ -27,6 +33,7 @@ struct mnt_namespace {
 	struct rb_node		mnt_ns_tree_node; /* node in the mnt_ns_tree */
 	struct list_head	mnt_ns_list; /* entry in the sequential list of mounts namespace */
 	refcount_t		passive; /* number references not pinning @mounts */
+	mntns_flags_t		mntns_flags;
 } __randomize_layout;
 
 struct mnt_pcp {
diff --git a/fs/namespace.c b/fs/namespace.c
index f86a2b32c052..c0c48baf98a8 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3534,13 +3534,6 @@ static int do_move_mount(struct path *old_path,
 	if (!may_use_mount(p))
 		goto out;
 
-	/*
-	 * Don't allow moving an attached mount tree to an anonymous
-	 * mount tree.
-	 */
-	if (!is_anon_ns(ns) && is_anon_ns(p->mnt_ns))
-		goto out;
-
 	/* The thing moved must be mounted... */
 	if (!is_mounted(&old->mnt))
 		goto out;
@@ -3549,15 +3542,31 @@ static int do_move_mount(struct path *old_path,
 	if (!(attached ? check_mnt(old) : is_anon_ns(ns)))
 		goto out;
 
-	/*
-	 * Ending up with two files referring to the root of the same
-	 * anonymous mount namespace would cause an error as this would
-	 * mean trying to move the same mount twice into the mount tree
-	 * which would be rejected later. But be explicit about it right
-	 * here.
-	 */
-	if (is_anon_ns(ns) && is_anon_ns(p->mnt_ns) && ns == p->mnt_ns)
+	if (is_anon_ns(ns)) {
+		/*
+		 * Ending up with two files referring to the root of the
+		 * same anonymous mount namespace would cause an error
+		 * as this would mean trying to move the same mount
+		 * twice into the mount tree which would be rejected
+		 * later. But be explicit about it right here.
+		 */
+		if ((is_anon_ns(p->mnt_ns) && ns == p->mnt_ns))
+			goto out;
+
+		/*
+		 * If this is an anonymous mount tree ensure that mount
+		 * propagation can detect mounts that were just
+		 * propagated to the target mount tree so we don't
+		 * propagate onto them.
+		 */
+		ns->mntns_flags |= MNTNS_PROPAGATING;
+	} else if (is_anon_ns(p->mnt_ns)) {
+		/*
+		 * Don't allow moving an attached mount tree to an
+		 * anonymous mount tree.
+		 */
 		goto out;
+	}
 
 	if (old->mnt.mnt_flags & MNT_LOCKED)
 		goto out;
@@ -3601,6 +3610,9 @@ static int do_move_mount(struct path *old_path,
 	if (err)
 		goto out;
 
+	if (is_anon_ns(ns))
+		ns->mntns_flags &= ~MNTNS_PROPAGATING;
+
 	/* if the mount is moved, it should no longer be expire
 	 * automatically */
 	list_del_init(&old->mnt_expire);
diff --git a/fs/pnode.c b/fs/pnode.c
index ef048f008bdd..6dd26ca96cdd 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -150,7 +150,7 @@ static struct mount *propagation_next(struct mount *m,
 					 struct mount *origin)
 {
 	/* are there any slaves of this mount? */
-	if (!IS_MNT_NEW(m) && !list_empty(&m->mnt_slave_list))
+	if (!IS_MNT_PROPAGATED(m) && !list_empty(&m->mnt_slave_list))
 		return first_slave(m);
 
 	while (1) {
@@ -174,7 +174,7 @@ static struct mount *skip_propagation_subtree(struct mount *m,
 	 * Advance m such that propagation_next will not return
 	 * the slaves of m.
 	 */
-	if (!IS_MNT_NEW(m) && !list_empty(&m->mnt_slave_list))
+	if (!IS_MNT_PROPAGATED(m) && !list_empty(&m->mnt_slave_list))
 		m = last_slave(m);
 
 	return m;
@@ -185,7 +185,7 @@ static struct mount *next_group(struct mount *m, struct mount *origin)
 	while (1) {
 		while (1) {
 			struct mount *next;
-			if (!IS_MNT_NEW(m) && !list_empty(&m->mnt_slave_list))
+			if (!IS_MNT_PROPAGATED(m) && !list_empty(&m->mnt_slave_list))
 				return first_slave(m);
 			next = next_peer(m);
 			if (m->mnt_group_id == origin->mnt_group_id) {
@@ -226,7 +226,7 @@ static int propagate_one(struct mount *m, struct mountpoint *dest_mp)
 	struct mount *child;
 	int type;
 	/* skip ones added by this propagate_mnt() */
-	if (IS_MNT_NEW(m))
+	if (IS_MNT_PROPAGATED(m))
 		return 0;
 	/* skip if mountpoint isn't covered by it */
 	if (!is_subdir(dest_mp->m_dentry, m->mnt.mnt_root))
@@ -380,7 +380,7 @@ bool propagation_would_overmount(const struct mount *from,
 	if (!IS_MNT_SHARED(from))
 		return false;
 
-	if (IS_MNT_NEW(to))
+	if (IS_MNT_PROPAGATED(to))
 		return false;
 
 	if (to->mnt.mnt_root != mp->m_dentry)
diff --git a/fs/pnode.h b/fs/pnode.h
index 0b02a6393891..a81db78c0237 100644
--- a/fs/pnode.h
+++ b/fs/pnode.h
@@ -12,7 +12,7 @@
 
 #define IS_MNT_SHARED(m) ((m)->mnt.mnt_flags & MNT_SHARED)
 #define IS_MNT_SLAVE(m) ((m)->mnt_master)
-#define IS_MNT_NEW(m)  (!(m)->mnt_ns || is_anon_ns((m)->mnt_ns))
+#define IS_MNT_PROPAGATED(m) (!(m)->mnt_ns || (m)->mnt_ns->mntns_flags & MNTNS_PROPAGATING)
 #define CLEAR_MNT_SHARED(m) ((m)->mnt.mnt_flags &= ~MNT_SHARED)
 #define IS_MNT_UNBINDABLE(m) ((m)->mnt.mnt_flags & MNT_UNBINDABLE)
 #define IS_MNT_MARKED(m) ((m)->mnt.mnt_flags & MNT_MARKED)

-- 
2.47.2


