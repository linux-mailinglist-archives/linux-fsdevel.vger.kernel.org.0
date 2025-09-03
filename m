Return-Path: <linux-fsdevel+bounces-60072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE0FB413DD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B00951BA138D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44E32D876A;
	Wed,  3 Sep 2025 04:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="iOvtmP4b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12AF2D6E55
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875346; cv=none; b=A4a7Fds3mh8Yuzd+Cpr8vQ/kolu95DKKPIPz7krTO/a+nfIqCr248JQaRurfdpcwf7xK1LVmvMqzdVuDFBtIiWYFHFOgG4Buq66EK+E/OEB9zQfusjPCq+9Ob1PtXb7HKd2PimhNy0GeekcbCdiRLZOqt2HyoSlGU6ZQl/JqnYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875346; c=relaxed/simple;
	bh=qM3VAoPLw44IShO+jwuiilJG6XVyvbdhkiIdWMuwMGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DYmiLoG0hAfzjVbi/ape3JFqUQBsaBlffFapBFEF65WTlSoO7WWn7mJNK0RWG3KZpXwZRMi9X5b4WSYF+uFaC4zG8jSR82K6wJEVAOgHPpPvvp+K0X4sjAzpHc+p4h4VwQlvX1H1mIhUDDe1Y7BF1KT/cE1eQepycYeLhBatP/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=iOvtmP4b; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=V05QKT26bO7imNqnaZIkXYcPGWkHIOzsMZAJKVDW5vw=; b=iOvtmP4bSxG3FLoR63EuSEgMBr
	quaQ9kFnoaeVxspIfEVEblbm3CD6MhNWN3kAM6OAHDMuyO6yxsUcWru7G3Ibui3Dj3LNzsB9WHLFU
	ZS/YO9yowSO5uzkFClvHkEf3cxNtuNj1/DNseQSYWju5rhEnzHA0cjfllyP5tb1xtBpd91bhDnrtz
	B0h93WZ5vEaHgTzMd5mEOPyuV4YxMGZ/xiMGreKZ0wPZUSuLbMOvIhp3BCc2+SAIaCG4MseIrNKR/
	ShrCr1AOUsofZb1kLDIlhuOZCjRd6d2P6TuFmT3Hi5j/i2agnGxGwiyxLuUXDvITVDZglE1/d8X9w
	ectOm+IA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfX5-0000000ApAd-0TtR;
	Wed, 03 Sep 2025 04:55:43 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 31/65] graft_tree(), attach_recursive_mnt() - pass pinned_mountpoint
Date: Wed,  3 Sep 2025 05:54:53 +0100
Message-ID: <20250903045537.2579614-32-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
References: <20250903045432.GH39973@ZenIV>
 <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

parent and mountpoint always come from the same struct pinned_mountpoint
now.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index b236536bbbc9..18d6ad0f4f76 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2549,8 +2549,7 @@ enum mnt_tree_flags_t {
 /**
  * attach_recursive_mnt - attach a source mount tree
  * @source_mnt: mount tree to be attached
- * @dest_mnt:   mount that @source_mnt will be mounted on
- * @dest_mp:    the mountpoint @source_mnt will be mounted at
+ * @dest:	the context for mounting at the place where the tree should go
  *
  *  NOTE: in the table below explains the semantics when a source mount
  *  of a given type is attached to a destination mount of a given type.
@@ -2613,10 +2612,11 @@ enum mnt_tree_flags_t {
  *         Otherwise a negative error code is returned.
  */
 static int attach_recursive_mnt(struct mount *source_mnt,
-				struct mount *dest_mnt,
-				struct mountpoint *dest_mp)
+				const struct pinned_mountpoint *dest)
 {
 	struct user_namespace *user_ns = current->nsproxy->mnt_ns->user_ns;
+	struct mount *dest_mnt = dest->parent;
+	struct mountpoint *dest_mp = dest->mp;
 	HLIST_HEAD(tree_list);
 	struct mnt_namespace *ns = dest_mnt->mnt_ns;
 	struct pinned_mountpoint root = {};
@@ -2864,16 +2864,16 @@ static inline void unlock_mount(struct pinned_mountpoint *m)
 	struct pinned_mountpoint mp __cleanup(unlock_mount) = {}; \
 	lock_mount_exact((path), &mp)
 
-static int graft_tree(struct mount *mnt, struct mount *p, struct mountpoint *mp)
+static int graft_tree(struct mount *mnt, const struct pinned_mountpoint *mp)
 {
 	if (mnt->mnt.mnt_sb->s_flags & SB_NOUSER)
 		return -EINVAL;
 
-	if (d_is_dir(mp->m_dentry) !=
+	if (d_is_dir(mp->mp->m_dentry) !=
 	      d_is_dir(mnt->mnt.mnt_root))
 		return -ENOTDIR;
 
-	return attach_recursive_mnt(mnt, p, mp);
+	return attach_recursive_mnt(mnt, mp);
 }
 
 static int may_change_propagation(const struct mount *m)
@@ -3055,7 +3055,7 @@ static int do_loopback(struct path *path, const char *old_name,
 	if (IS_ERR(mnt))
 		return PTR_ERR(mnt);
 
-	err = graft_tree(mnt, mp.parent, mp.mp);
+	err = graft_tree(mnt, &mp);
 	if (err) {
 		lock_mount_hash();
 		umount_tree(mnt, UMOUNT_SYNC);
@@ -3634,7 +3634,7 @@ static int do_move_mount(struct path *old_path,
 	if (mount_is_ancestor(old, mp.parent))
 		return -ELOOP;
 
-	return attach_recursive_mnt(old, mp.parent, mp.mp);
+	return attach_recursive_mnt(old, &mp);
 }
 
 static int do_move_mount_old(struct path *path, const char *old_name)
@@ -3685,7 +3685,7 @@ static int do_add_mount(struct mount *newmnt, const struct pinned_mountpoint *mp
 		return -EINVAL;
 
 	newmnt->mnt.mnt_flags = mnt_flags;
-	return graft_tree(newmnt, parent, mp->mp);
+	return graft_tree(newmnt, mp);
 }
 
 static bool mount_too_revealing(const struct super_block *sb, int *new_mnt_flags);
-- 
2.47.2


