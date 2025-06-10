Return-Path: <linux-fsdevel+bounces-51135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5424AD3013
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 10:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C0EA3B6212
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 08:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD6D283136;
	Tue, 10 Jun 2025 08:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="n8jvkDFW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6723828136C
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 08:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749543715; cv=none; b=WC/6vXR96bjViT+/Ae8U48bHeLH3M5Qq5Yu2q2fRVhOk5m9gWu+0jLSe3CPvWRkix0JWWOpAvgUQ7dcCDtiY/uVEnbfIQLt+fbFgJbY+KxqzIgiV2D0PeHUumWugjG/vzatu+kCHOGbVmsZujqT47OL3Rq/IN76ReQPoHQB0uu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749543715; c=relaxed/simple;
	bh=xTlLu/eKj0QykkjYjBUzQoa8HsMbyP0ERSehhxxFFPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dnCy0YM7ME8yZjoJ+lgSY57U14F18aWGYaF64HJzcpRwzJwytTxZ25DK/T4kiJI7u8UL5hzfWdYQuyvRRPmtYTFjhN5BCmSUNl6MUXxXrYeHv0pSfHassUcVllbgurdZGCbos+Sp/fdW/N1DK/lelJmrQ7semcCf9+NnuXMcR+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=n8jvkDFW; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=BtKtixS42M/KdNRDUCG7KwdMX5uSG908ZAtaMYswE7w=; b=n8jvkDFWrBBskTwoqzIxZUGPFM
	VUM4AXGGEhjXhC385MdyvEH+MhExmKuzwOv8J7A/QLUotAnrcuFzGKQ6/6sZdw69FzZLsV+rL9aKL
	v1/50Ch223+IGHnlC1pr3uEhV/YAtKgFB71uxckT0tAKp2/JiO2ZTt5VlaI3sVlmiN29wwsOsoT93
	LoyRqVJD7phNHoDWMNPXGlI8q9OUke7Uqf52lfIKVNCzRpxtCpin9xz4V3XaqNHgNyxthe55U5jee
	S+yzrAcZ8x67gS6o3UiFRKTfNGZo8PFYC0jboOq6OgL3iTCK7ho0hH3VcgTzd6YORO+P86W/789zl
	cGtXOWeA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOuEx-00000004jO3-3LBW;
	Tue, 10 Jun 2025 08:21:51 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 19/26] attach_recursive_mnt(): get rid of flags entirely
Date: Tue, 10 Jun 2025 09:21:41 +0100
Message-ID: <20250610082148.1127550-19-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
References: <20250610081758.GE299672@ZenIV>
 <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

move vs. attach is trivially detected as mnt_has_parent(source_mnt)...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 571916df33fd..5906ad173a28 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2539,9 +2539,8 @@ int count_mounts(struct mnt_namespace *ns, struct mount *mnt)
 }
 
 enum mnt_tree_flags_t {
-	MNT_TREE_MOVE = BIT(0),
-	MNT_TREE_BENEATH = BIT(1),
-	MNT_TREE_PROPAGATION = BIT(2),
+	MNT_TREE_BENEATH = BIT(0),
+	MNT_TREE_PROPAGATION = BIT(1),
 };
 
 /**
@@ -2549,7 +2548,6 @@ enum mnt_tree_flags_t {
  * @source_mnt: mount tree to be attached
  * @dest_mnt:   mount that @source_mnt will be mounted on
  * @dest_mp:    the mountpoint @source_mnt will be mounted at
- * @flags:      modify how @source_mnt is supposed to be attached
  *
  *  NOTE: in the table below explains the semantics when a source mount
  *  of a given type is attached to a destination mount of a given type.
@@ -2613,8 +2611,7 @@ enum mnt_tree_flags_t {
  */
 static int attach_recursive_mnt(struct mount *source_mnt,
 				struct mount *dest_mnt,
-				struct mountpoint *dest_mp,
-				enum mnt_tree_flags_t flags)
+				struct mountpoint *dest_mp)
 {
 	struct user_namespace *user_ns = current->nsproxy->mnt_ns->user_ns;
 	HLIST_HEAD(tree_list);
@@ -2623,7 +2620,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 	struct mount *child, *p;
 	struct hlist_node *n;
 	int err = 0;
-	bool moving = flags & MNT_TREE_MOVE;
+	bool moving = mnt_has_parent(source_mnt);
 
 	/*
 	 * Preallocate a mountpoint in case the new mounts need to be
@@ -2828,7 +2825,7 @@ static int graft_tree(struct mount *mnt, struct mount *p, struct mountpoint *mp)
 	      d_is_dir(mnt->mnt.mnt_root))
 		return -ENOTDIR;
 
-	return attach_recursive_mnt(mnt, p, mp, 0);
+	return attach_recursive_mnt(mnt, p, mp);
 }
 
 /*
@@ -3570,8 +3567,6 @@ static int do_move_mount(struct path *old_path,
 	p = real_mount(new_path->mnt);
 	parent = old->mnt_parent;
 	attached = mnt_has_parent(old);
-	if (attached)
-		flags |= MNT_TREE_MOVE;
 	ns = old->mnt_ns;
 
 	err = -EINVAL;
@@ -3624,7 +3619,6 @@ static int do_move_mount(struct path *old_path,
 
 		err = -EINVAL;
 		p = p->mnt_parent;
-		flags |= MNT_TREE_BENEATH;
 	}
 
 	/*
@@ -3639,7 +3633,7 @@ static int do_move_mount(struct path *old_path,
 	if (mount_is_ancestor(old, p))
 		goto out;
 
-	err = attach_recursive_mnt(old, p, mp, flags);
+	err = attach_recursive_mnt(old, p, mp);
 	if (err)
 		goto out;
 
-- 
2.39.5


