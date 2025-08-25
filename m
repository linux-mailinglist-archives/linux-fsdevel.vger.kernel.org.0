Return-Path: <linux-fsdevel+bounces-58940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95510B33589
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3457A1686DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AA828506C;
	Mon, 25 Aug 2025 04:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hqI9I7+p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A082E27FB2F
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097045; cv=none; b=XvkRyU9OL+aYMXWvR4kQ3m2olgjQyIvI+OryVB1ukPTyj4jSpIaLD5/VTTKWW+voBnlQSSvnnmv3FffNer44vuSpJh2Isgs24a1MMt9yRjPS4ThOTVrtDbifxYd/OHL1kixQ1NAOCleUz1BgM+dNdJQJYrrnjN6mK8o9yQRye1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097045; c=relaxed/simple;
	bh=KdLyyttYcNIV/+WGbTBRPMOcvPn2wo2hS3IFN2Yb1Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cR/FSDWIRcbs8R0ViQMQJDIJ09UQqVt5FnP5iHFqngHuF5xkU2SWQjPTn4voAKqcIGAPOvwVbB26eCq9SqzY4xeD1khOpzhgle9qvsLFOibZeQ/PEJhnrjUdi8nTFMV3sJh6hyaxXCLhrGvChXRnoSS4IKwmc/UkfLzvH0hkH4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hqI9I7+p; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=kqBern+ihor8kmiKxfO9kon95FqQN3md7Rev7i89F70=; b=hqI9I7+pslXXRhucRDkhVhTpsM
	TODTkmqaIsVDdncGy8IoKcYK9VuXYNA6Fhu2J7qDwdq5PC8r4yrMHhU+1kc+ugb0w+aBYJ7hCM3di
	tsjvnLFAD8RwhRNxdLyDgZ7pe8CLCPms76UzAqB8xp1cCjSqj4yfxvMtTeo7lvqqbVN2wInrV4B1v
	AbmvoSXa5UG6ZElW/QTxOukGRH7+ZN0sQ2nOa18t+PAkTtCniKVBFmHcUChSCdAwcxmKaCyozqmL6
	MRU3cPFXiSMnCw/uAIIInZDfxk+6Xowgp/DheK3PrwapjML1Swr6b+er8JIfFTWKJXAw2htGTtcDm
	a6/7i1Mg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3o-00000006TE4-2p4o;
	Mon, 25 Aug 2025 04:44:00 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 38/52] drop_collected_paths(): constify arguments
Date: Mon, 25 Aug 2025 05:43:41 +0100
Message-ID: <20250825044355.1541941-38-viro@zeniv.linux.org.uk>
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

... and use that to constify the pointers in callers

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c        |  4 ++--
 include/linux/mount.h |  2 +-
 kernel/audit_tree.c   | 12 ++++++------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index d61601fc97ca..d29d7c948ec1 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2334,9 +2334,9 @@ struct path *collect_paths(const struct path *path,
 	return res;
 }
 
-void drop_collected_paths(struct path *paths, struct path *prealloc)
+void drop_collected_paths(const struct path *paths, struct path *prealloc)
 {
-	for (struct path *p = paths; p->mnt; p++)
+	for (const struct path *p = paths; p->mnt; p++)
 		path_put(p);
 	if (paths != prealloc)
 		kfree(paths);
diff --git a/include/linux/mount.h b/include/linux/mount.h
index 5f9c053b0897..c09032463b36 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -105,7 +105,7 @@ extern int may_umount(struct vfsmount *);
 int do_mount(const char *, const char __user *,
 		     const char *, unsigned long, void *);
 extern struct path *collect_paths(const struct path *, struct path *, unsigned);
-extern void drop_collected_paths(struct path *, struct path *);
+extern void drop_collected_paths(const struct path *, struct path *);
 extern void kern_unmount_array(struct vfsmount *mnt[], unsigned int num);
 
 extern int cifs_root_data(char **dev, char **opts);
diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
index b0eae2a3c895..32007edf0e55 100644
--- a/kernel/audit_tree.c
+++ b/kernel/audit_tree.c
@@ -678,7 +678,7 @@ void audit_trim_trees(void)
 		struct audit_tree *tree;
 		struct path path;
 		struct audit_node *node;
-		struct path *paths;
+		const struct path *paths;
 		struct path array[16];
 		int err;
 
@@ -701,7 +701,7 @@ void audit_trim_trees(void)
 			struct audit_chunk *chunk = find_chunk(node);
 			/* this could be NULL if the watch is dying else where... */
 			node->index |= 1U<<31;
-			for (struct path *p = paths; p->dentry; p++) {
+			for (const struct path *p = paths; p->dentry; p++) {
 				struct inode *inode = p->dentry->d_inode;
 				if (inode_to_key(inode) == chunk->key) {
 					node->index &= ~(1U<<31);
@@ -740,9 +740,9 @@ void audit_put_tree(struct audit_tree *tree)
 	put_tree(tree);
 }
 
-static int tag_mounts(struct path *paths, struct audit_tree *tree)
+static int tag_mounts(const struct path *paths, struct audit_tree *tree)
 {
-	for (struct path *p = paths; p->dentry; p++) {
+	for (const struct path *p = paths; p->dentry; p++) {
 		int err = tag_chunk(p->dentry->d_inode, tree);
 		if (err)
 			return err;
@@ -805,7 +805,7 @@ int audit_add_tree_rule(struct audit_krule *rule)
 	struct audit_tree *seed = rule->tree, *tree;
 	struct path path;
 	struct path array[16];
-	struct path *paths;
+	const struct path *paths;
 	int err;
 
 	rule->tree = NULL;
@@ -877,7 +877,7 @@ int audit_tag_tree(char *old, char *new)
 	int failed = 0;
 	struct path path1, path2;
 	struct path array[16];
-	struct path *paths;
+	const struct path *paths;
 	int err;
 
 	err = kern_path(new, 0, &path2);
-- 
2.47.2


