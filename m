Return-Path: <linux-fsdevel+bounces-59571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B73FBB3AE2F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1C363B475F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE542F9C3D;
	Thu, 28 Aug 2025 23:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="TISXrcXd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23362D0C78
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422497; cv=none; b=fC5jEYMGJN1Y8gd7PI6xT8DxCrCWMjD0x+9st3YGvp3Mys/4xmA56Kkm1N/1Zvbem31DqezBq4nL8Ge3lRaUQUjSI2NjLFmkDAU0+fW9spmKLtRxfvsZyUAmaV2qO2I1nlQu2OBzO65h1QilLOYD+NY+1sFuR/SKqcISALgLcBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422497; c=relaxed/simple;
	bh=y6Fh1y+zHM33o0S+Yn/ooENKtw7woFAOKB4B4UBTz08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QL/nxSB7W/wHUUzXImvNyKbQoLHt1puA8Xr41mXGE40wNuUlvK+jpiADpt/N3JFsCjBwsxBxJdv6WYpxUCo5a6ngQESU0uLv4wfFmHOYHWMzpcssgtLZty4O+ImLZJMILfEYzdHbQcETK2NKnDENhBVGqcp8tRpmg3yiJrPxFNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=TISXrcXd; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=3316xNeiBKGJXJ7WzsxCcCUSpFUjz6+/96FUsT7ntRs=; b=TISXrcXdWNGGWbcMjs/RvJZUB5
	px0Jz6pU/lSLKJvTyZFtc1SPsdhjhI/Juj3S5Xl7aUvDI6H1Jh3KUx08WkEQlORYKhp0AtsR5qxvP
	O1aCXd03JvX/qQqvnc1+unR/ZI2sPFY98PLDkIe9ntQp0wn+HJgA1HN9XX7umPP3jo/bFx9PqmlPJ
	UnAUN3jlB49WKChlfk5HsodAih6otQ/vCfeUGQcyEsVM/UEVxa0emcCaHRtf9AYsrtti5UuwZaBBF
	oi1Kkr9axFmX0m2u2a3Qm4pde3jckafWeuqlTbv4fI2eo6i8RUHDr0a9HdH8DmTKXAm4fUsCBKL3v
	vgXBtRog==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urlj2-0000000F276-0LJP;
	Thu, 28 Aug 2025 23:08:12 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 39/63] drop_collected_paths(): constify arguments
Date: Fri, 29 Aug 2025 00:07:42 +0100
Message-ID: <20250828230806.3582485-39-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

... and use that to constify the pointers in callers

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c        |  4 ++--
 include/linux/mount.h |  2 +-
 kernel/audit_tree.c   | 12 ++++++------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index e4ca76091bd7..61dfa899bd57 100644
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


