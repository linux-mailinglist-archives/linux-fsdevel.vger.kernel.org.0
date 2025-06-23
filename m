Return-Path: <linux-fsdevel+bounces-52463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF39AE3486
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 06:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 694163B0445
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 04:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5671F2382;
	Mon, 23 Jun 2025 04:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="D/eYCrXN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADC81DF98B
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 04:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750654476; cv=none; b=hX8wUhJ94BryDqUzp64V2C/AqZGrUEjCAGPX3FVbeA62tEEwhGQUhArsgULvSh7fqKmefv1dDDN10F9hhXfnmt8Dv+UA32sS2+1ULVv1PjmqvkJa7OpHmdjS4wuSnN3f224L8ccS1CYEfKOMlG8lruCG80RjFO8K15YecLSpkGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750654476; c=relaxed/simple;
	bh=oQShpeY8IAfd7F3Xv1zzHvHEyH1BL00wCxhhXCLMuPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ViXn0DqLZTYCo26UT8XaKdKEX4cADX+bwihDJnzIqyEjCIkpxTSGc9edlGMdNRGS4sc0WcAmfRjVFiGsjLK6PHJl5pUczInnkS9esigaOS9ZRdiu38VWh9oxqSUIbuI6y/knpvBWA5N/GaN8pzneiyaDZgtgBt+52xSTw4mmC3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=D/eYCrXN; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=yXagqCHzn2ofZ1KFsXeS/K+bNpnIFawlBVObxX+s7uQ=; b=D/eYCrXNJ3lhb3GSg5HYyvgiHN
	NFUqEgihLErUF3thIpJIL1HVwN3ooUI7pT3L9B3owRaKugZuA1EVPYuW5qgvnlOoOSVhmez6lmrUy
	ZLB6qROwdgXJoX/ulcU9W8Pb2tv/s3QgCOj9OVPjByUjwVwp87NuSBoMUFCqxZMx2zHslquEyDPx0
	golScU/yp0s+ZuHBQEuRCG0IxWCdbLwD2Kjz3EMe9fZO7sodEXEVsqJJDcYM9tE18nOdGI5Z2VaMo
	mXxrGTqyK3tMIkkGm9aa5hE/OZu087jYIM2an8Kk8KJehTSSMUcmmdcmIlXy0YWNOJ6eZ/LgxSThG
	+6KZfgaQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTZCT-00000005Ku3-1Flg;
	Mon, 23 Jun 2025 04:54:33 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 30/35] don't have mounts pin their parents
Date: Mon, 23 Jun 2025 05:54:23 +0100
Message-ID: <20250623045428.1271612-30-viro@zeniv.linux.org.uk>
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

Simplify the rules for mount refcounts.  Current rules include:
	* being a namespace root => +1
	* being someone's child => +1
	* being someone's child => +1 to parent's refcount, unless you've
				   already been through umount_tree().

The last part is not needed at all.  It makes for more places where need
to decrement refcounts and it creates an asymmetry between the situations
for something that has never been a part of a namespace and something that
left one, both for no good reason.

If mount's refcount has additions from its children, we know that
	* it's either someone's child itself (and will remain so
until umount_tree(), at which point contributions from children
will disappear), or
	* or is the root of namespace (and will remain such until
it either becomes someone's child in another namespace or goes through
umount_tree()), or
	* it is the root of some tree copy, and is currently pinned
by the caller of copy_tree() (and remains such until it either gets
into namespace, or goes to umount_tree()).
In all cases we already have contribution(s) to refcount that will last
as long as the contribution from children remains.  In other words, the
lifetime is not affected by refcount contributions from children.

It might be useful for "is it busy" checks, but those are actually
no harder to express without it.

NB: propagate_mnt_busy() part is an equivalent transformation, ugly as it
is; the current logics is actually wrong and may give false negatives,
but fixing that is for a separate patch (probably earlier in the queue).

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 31 +++++++++----------------------
 fs/pnode.c     | 49 +++++++++++++++++--------------------------------
 2 files changed, 26 insertions(+), 54 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index debc43282b26..4b123e2384ca 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1075,7 +1075,6 @@ void mnt_set_mountpoint(struct mount *mnt,
 			struct mountpoint *mp,
 			struct mount *child_mnt)
 {
-	mnt_add_count(mnt, 1);	/* essentially, that's mntget */
 	child_mnt->mnt_mountpoint = mp->m_dentry;
 	child_mnt->mnt_parent = mnt;
 	child_mnt->mnt_mp = mp;
@@ -1118,7 +1117,6 @@ static void attach_mnt(struct mount *mnt, struct mount *parent,
 void mnt_change_mountpoint(struct mount *parent, struct mountpoint *mp, struct mount *mnt)
 {
 	struct mountpoint *old_mp = mnt->mnt_mp;
-	struct mount *old_parent = mnt->mnt_parent;
 
 	list_del_init(&mnt->mnt_child);
 	hlist_del_init(&mnt->mnt_mp_list);
@@ -1127,7 +1125,6 @@ void mnt_change_mountpoint(struct mount *parent, struct mountpoint *mp, struct m
 	attach_mnt(mnt, parent, mp);
 
 	maybe_free_mountpoint(old_mp, &ex_mountpoints);
-	mnt_add_count(old_parent, -1);
 }
 
 static inline struct mount *node_to_mount(struct rb_node *node)
@@ -1652,23 +1649,19 @@ const struct seq_operations mounts_op = {
 int may_umount_tree(struct vfsmount *m)
 {
 	struct mount *mnt = real_mount(m);
-	int actual_refs = 0;
-	int minimum_refs = 0;
-	struct mount *p;
-	BUG_ON(!m);
+	bool busy = false;
 
 	/* write lock needed for mnt_get_count */
 	lock_mount_hash();
-	for (p = mnt; p; p = next_mnt(p, mnt)) {
-		actual_refs += mnt_get_count(p);
-		minimum_refs += 2;
+	for (struct mount *p = mnt; p; p = next_mnt(p, mnt)) {
+		if (mnt_get_count(p) > (p == mnt ? 2 : 1)) {
+			busy = true;
+			break;
+		}
 	}
 	unlock_mount_hash();
 
-	if (actual_refs > minimum_refs)
-		return 0;
-
-	return 1;
+	return !busy;
 }
 
 EXPORT_SYMBOL(may_umount_tree);
@@ -1869,7 +1862,6 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
 
 		disconnect = disconnect_mount(p, how);
 		if (mnt_has_parent(p)) {
-			mnt_add_count(p->mnt_parent, -1);
 			if (!disconnect) {
 				/* Don't forget about p */
 				list_add_tail(&p->mnt_child, &p->mnt_parent->mnt_mounts);
@@ -1946,7 +1938,7 @@ static int do_umount(struct mount *mnt, int flags)
 		 * all race cases, but it's a slowpath.
 		 */
 		lock_mount_hash();
-		if (mnt_get_count(mnt) != 2) {
+		if (!list_empty(&mnt->mnt_mounts) || mnt_get_count(mnt) != 2) {
 			unlock_mount_hash();
 			return -EBUSY;
 		}
@@ -3683,9 +3675,7 @@ static int do_move_mount(struct path *old_path,
 out:
 	unlock_mount(&mp);
 	if (!err) {
-		if (!is_anon_ns(ns)) {
-			mntput_no_expire(parent);
-		} else {
+		if (is_anon_ns(ns)) {
 			/* Make sure we notice when we leak mounts. */
 			VFS_WARN_ON_ONCE(!mnt_ns_empty(ns));
 			free_mnt_ns(ns);
@@ -4753,7 +4743,6 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 	/* mount new_root on / */
 	attach_mnt(new_mnt, root_parent, root_mnt->mnt_mp);
 	umount_mnt(root_mnt);
-	mnt_add_count(root_parent, -1);
 	/* mount old root on put_old */
 	attach_mnt(root_mnt, old_mnt, old_mp.mp);
 	touch_mnt_namespace(current->nsproxy->mnt_ns);
@@ -4766,8 +4755,6 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 	error = 0;
 out4:
 	unlock_mount(&old_mp);
-	if (!error)
-		mntput_no_expire(ex_parent);
 out3:
 	path_put(&root);
 out2:
diff --git a/fs/pnode.c b/fs/pnode.c
index 9aa892263a38..73a64c55deb3 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -332,21 +332,6 @@ int propagate_mnt(struct mount *dest_mnt, struct mountpoint *dest_mp,
 	return ret;
 }
 
-static struct mount *find_topper(struct mount *mnt)
-{
-	/* If there is exactly one mount covering mnt completely return it. */
-	struct mount *child;
-
-	if (!list_is_singular(&mnt->mnt_mounts))
-		return NULL;
-
-	child = list_first_entry(&mnt->mnt_mounts, struct mount, mnt_child);
-	if (child->mnt_mountpoint != mnt->mnt.mnt_root)
-		return NULL;
-
-	return child;
-}
-
 /*
  * return true if the refcount is greater than count
  */
@@ -404,12 +389,8 @@ bool propagation_would_overmount(const struct mount *from,
  */
 int propagate_mount_busy(struct mount *mnt, int refcnt)
 {
-	struct mount *m, *child, *topper;
 	struct mount *parent = mnt->mnt_parent;
 
-	if (mnt == parent)
-		return do_refcount_check(mnt, refcnt);
-
 	/*
 	 * quickly check if the current mount can be unmounted.
 	 * If not, we don't have to go checking for all other
@@ -418,23 +399,27 @@ int propagate_mount_busy(struct mount *mnt, int refcnt)
 	if (!list_empty(&mnt->mnt_mounts) || do_refcount_check(mnt, refcnt))
 		return 1;
 
-	for (m = propagation_next(parent, parent); m;
+	if (mnt == parent)
+		return 0;
+
+	for (struct mount *m = propagation_next(parent, parent); m;
 	     		m = propagation_next(m, parent)) {
-		int count = 1;
-		child = __lookup_mnt(&m->mnt, mnt->mnt_mountpoint);
-		if (!child)
-			continue;
+		struct list_head *head;
+		struct mount *child = __lookup_mnt(&m->mnt, mnt->mnt_mountpoint);
 
-		/* Is there exactly one mount on the child that covers
-		 * it completely whose reference should be ignored?
-		 */
-		topper = find_topper(child);
-		if (topper)
-			count += 1;
-		else if (!list_empty(&child->mnt_mounts))
+		if (!child)
 			continue;
 
-		if (do_refcount_check(child, count))
+		head = &child->mnt_mounts;
+		if (!list_empty(head)) {
+			/*
+			 * a mount that covers child completely wouldn't prevent
+			 * it being pulled out; any other would.
+			 */
+			if (!list_is_singular(head) || !child->overmount)
+				continue;
+		}
+		if (do_refcount_check(child, 1))
 			return 1;
 	}
 	return 0;
-- 
2.39.5


