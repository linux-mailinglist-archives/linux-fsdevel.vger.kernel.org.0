Return-Path: <linux-fsdevel+bounces-58913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D47B3356F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EBBF3A6085
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0669927EFE7;
	Mon, 25 Aug 2025 04:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="kbgSDb43"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6803270548
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097040; cv=none; b=lw9q1OBeFvoHctkmFr6+DNed8qcFUjj8lxK958mQTwcojAc+UpLs3js9u0zf5Nh/SclQwMBVJUd1WIenzPkKorfwbwF9hnK7VnfloUGJsMUU0dCAOjU8Z17rvMtrtVVKNgZOE7xdnAd/1XwT0/AvSlpGFqrrbHjZrtTGn4MehUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097040; c=relaxed/simple;
	bh=ir6H2wTXjEpYGYjjABtpC2qhdJNkIbGVK7zMxy+lip4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lukOlyfCcI3aXhfwkQdqLbBZYuDhcCb/RcjOd3T8MyNJorYA2t37HazAK6x5gCiQ4xNHzTs4xTCYj3zWH2unujk2ZjMgiO7VGLQgGT4aJbtNVUY9B0KQeQyvAp7WrMMXRgnt71+qB1KdvxMdt/isVXkdJV9Ft7FiWyI+7zUsuPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=kbgSDb43; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=DqgjrWGHf8gpAEfOYuJ+e+GEAOF2jeLnfE3HWrE5u14=; b=kbgSDb438BDxFduTx+1+EN7Gkq
	ZJVo7WjtfnHEJz5XYPwf+YgF57ExarTKJX7Xj6a9N3OOGxr4+HTv2Nqr9VSGano9qKyypRi31S//7
	BWoiW/Um5obrBH6qwUY1ZVo0xOMibcOwXosxJ0Kkc7GdxYjabJ5mPh1qSgOXh3aG2PIsdj4ue4iKg
	PVGq0+NDKTcqUNWhzIjhBzQhb8lfE6qCtXSQhB+IVE+YTN734ICPtRP9RoQJnpvHmQDJcRUsjZztC
	7reB++0pyUhSdn4XpSVhmhy/35xk/3+XXuBTN8l+8XNhUNyg0x2oyG2afrT+CCpBlD6FDs1h/Gdu3
	M9Ow6ngA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3l-00000006TAF-1Q9E;
	Mon, 25 Aug 2025 04:43:57 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 15/52] path_is_under(): use guards
Date: Mon, 25 Aug 2025 05:43:18 +0100
Message-ID: <20250825044355.1541941-15-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

... and document that locking requirements for is_path_reachable().
There is one questionable caller in do_listmount() where we are not
holding mount_lock *and* might not have the first argument mounted.
However, in that case it will immediately return true without having
to look at the ancestors.  Might be cleaner to move the check into
non-LSTM_ROOT case which it really belongs in - there the check is
not always true and is_mounted() is guaranteed.

Document the locking environments for is_path_reachable() callers:
	get_peer_under_root()
	get_dominating_id()
	do_statmount()
	do_listmount()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 12 ++++++------
 fs/pnode.c     |  3 ++-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index acacfe767a7c..bf9a3a644faa 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4592,7 +4592,7 @@ SYSCALL_DEFINE5(move_mount,
 /*
  * Return true if path is reachable from root
  *
- * namespace_sem or mount_lock is held
+ * locks: mount_locked_reader || namespace_shared && is_mounted(mnt)
  */
 bool is_path_reachable(struct mount *mnt, struct dentry *dentry,
 			 const struct path *root)
@@ -4606,11 +4606,9 @@ bool is_path_reachable(struct mount *mnt, struct dentry *dentry,
 
 bool path_is_under(const struct path *path1, const struct path *path2)
 {
-	bool res;
-	read_seqlock_excl(&mount_lock);
-	res = is_path_reachable(real_mount(path1->mnt), path1->dentry, path2);
-	read_sequnlock_excl(&mount_lock);
-	return res;
+	scoped_guard(mount_locked_reader)
+		return is_path_reachable(real_mount(path1->mnt), path1->dentry,
+					 path2);
 }
 EXPORT_SYMBOL(path_is_under);
 
@@ -5689,6 +5687,7 @@ static int grab_requested_root(struct mnt_namespace *ns, struct path *root)
 			     STATMOUNT_MNT_UIDMAP | \
 			     STATMOUNT_MNT_GIDMAP)
 
+/* locks: namespace_shared */
 static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
 			struct mnt_namespace *ns)
 {
@@ -5949,6 +5948,7 @@ SYSCALL_DEFINE4(statmount, const struct mnt_id_req __user *, req,
 	return ret;
 }
 
+/* locks: namespace_shared */
 static ssize_t do_listmount(struct mnt_namespace *ns, u64 mnt_parent_id,
 			    u64 last_mnt_id, u64 *mnt_ids, size_t nr_mnt_ids,
 			    bool reverse)
diff --git a/fs/pnode.c b/fs/pnode.c
index 0702d45d856d..edaf9d9d0eaf 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -29,6 +29,7 @@ static inline struct mount *next_slave(struct mount *p)
 	return hlist_entry(p->mnt_slave.next, struct mount, mnt_slave);
 }
 
+/* locks: namespace_shared && is_mounted(mnt) */
 static struct mount *get_peer_under_root(struct mount *mnt,
 					 struct mnt_namespace *ns,
 					 const struct path *root)
@@ -50,7 +51,7 @@ static struct mount *get_peer_under_root(struct mount *mnt,
  * Get ID of closest dominating peer group having a representative
  * under the given root.
  *
- * Caller must hold namespace_sem
+ * locks: namespace_shared
  */
 int get_dominating_id(struct mount *mnt, const struct path *root)
 {
-- 
2.47.2


