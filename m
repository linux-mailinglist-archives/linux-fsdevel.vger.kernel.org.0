Return-Path: <linux-fsdevel+bounces-45749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3098A7BB16
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 12:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6C4616CE95
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 10:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3E21D959B;
	Fri,  4 Apr 2025 10:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wk1vR+zt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F3B1D7E54;
	Fri,  4 Apr 2025 10:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743763163; cv=none; b=tG2fG9p+OddDDX663JaF4vLE5Gnv3X0dPvzV+ooiXK4ICEJnGCDKG2YbXXEmvwWtKqyeBc6dIOS/rwOvnoAe0fOhyboi8+EjEJOD+CvUG+0f5Ggf9qbexFgAgAvUYJaydy/SW2nECcSr+jfWZ5PadI4MjRc5T0miEg/cyChdBEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743763163; c=relaxed/simple;
	bh=4AdbkdDVyBX6jEBtq4y9rlrM1Cu82MlcstjsBSpa4gA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SoDOfb9YzErKKXA6WS5pZNc+3yWn08oNRHSBen2/wzvICiTTSbX9rEVu3ClVe7f4grqMWG5wYDWKx3VOqKhxwG1wi7PDwdQDBy9Skyq5X8UEXn3klr0SByFG6q/CW7X+FaoJxRkP0rvis9X8Mv50UkN9qOuH5G3u5yhwP+ns/Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wk1vR+zt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DB9C4CEDD;
	Fri,  4 Apr 2025 10:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743763162;
	bh=4AdbkdDVyBX6jEBtq4y9rlrM1Cu82MlcstjsBSpa4gA=;
	h=From:To:Cc:Subject:Date:From;
	b=Wk1vR+zt8m2HitztpAjsi6Rr6Vz3v6/VfErgrusAcabl6MMcq1qgLLpe8IKkjbBPs
	 J2MhMMT0zGhiuz95OqH8oTabjlHHkNu58urxqsj+VVxsCCwDIZiByQnKPPUwl7iLG1
	 zjTXnXU4lz+SNVaMWnLPqy5ylfTI0U1O/RLh0DKHpXSDDrsBGZdWLC/UMQL1vqh9Dc
	 RyZBZSPd/pnNnr+enJv38/PoiYFoS4+KHcbVYlmDa/XqfXCgcDJAeaJTBt6jh/ThFI
	 lsbmOWVcMLC3+Ig0QHOtTCvsiPdj5phTnfOIv4nehtcHcXM29H5vZhq5Ad7+MwHviM
	 tOhowTkLptFDg==
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>,
	Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Penglei Jiang <superman.xpt@gmail.com>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com
Subject: [PATCH] anon_inode: use a proper mode internally
Date: Fri,  4 Apr 2025 12:39:14 +0200
Message-ID: <20250404-aphorismen-reibung-12028a1db7e3@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4980; i=brauner@kernel.org; h=from:subject:message-id; bh=4AdbkdDVyBX6jEBtq4y9rlrM1Cu82MlcstjsBSpa4gA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS/33ZJbpXHxW0Hnnxs1c+V/Hj0+Y8EBc0TO06embq+5 kH7TQtZl45SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJfDFj+M3iPffxxrvHfBde uirsbRstf3jTPYlSodBzPdybtbYsZdzD8Jv9bo1PWmx7t+C6m921+6XOPuOapHy8a8mLRS5h+sw r3rEBAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

This allows the VFS to not trip over anonymous inodes and we can add
asserts based on the mode into the vfs. When we report it to userspace
we can simply hide the mode to avoid regressions. I've audited all
direct callers of alloc_anon_inode() and only secretmen overrides i_mode
and i_op inode operations but it already uses a regular file.

Fixes: af153bb63a336 ("vfs: catch invalid modes in may_open()")
Reported-by: syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/67ed3fb3.050a0220.14623d.0009.GAE@google.com"
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/anon_inodes.c | 36 ++++++++++++++++++++++++++++++++++++
 fs/internal.h    |  3 +++
 fs/libfs.c       |  2 +-
 fs/pidfs.c       | 24 +-----------------------
 4 files changed, 41 insertions(+), 24 deletions(-)

diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index 583ac81669c2..42e4b9c34f89 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -24,9 +24,43 @@
 
 #include <linux/uaccess.h>
 
+#include "internal.h"
+
 static struct vfsmount *anon_inode_mnt __ro_after_init;
 static struct inode *anon_inode_inode __ro_after_init;
 
+/*
+ * User space expects anonymous inodes to have no file type in st_mode.
+ *
+ * In particular, 'lsof' has this legacy logic:
+ *
+ *	type = s->st_mode & S_IFMT;
+ *	switch (type) {
+ *	  ...
+ *	case 0:
+ *		if (!strcmp(p, "anon_inode"))
+ *			Lf->ntype = Ntype = N_ANON_INODE;
+ *
+ * to detect our old anon_inode logic.
+ *
+ * Rather than mess with our internal sane inode data, just fix it
+ * up here in getattr() by masking off the format bits.
+ */
+int anon_inode_getattr(struct mnt_idmap *idmap, const struct path *path,
+		       struct kstat *stat, u32 request_mask,
+		       unsigned int query_flags)
+{
+	struct inode *inode = d_inode(path->dentry);
+
+	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
+	stat->mode &= ~S_IFMT;
+	return 0;
+}
+
+static const struct inode_operations anon_inode_operations = {
+	.getattr = anon_inode_getattr,
+};
+
 /*
  * anon_inodefs_dname() is called from d_path().
  */
@@ -66,6 +100,7 @@ static struct inode *anon_inode_make_secure_inode(
 	if (IS_ERR(inode))
 		return inode;
 	inode->i_flags &= ~S_PRIVATE;
+	inode->i_op = &anon_inode_operations;
 	error =	security_inode_init_security_anon(inode, &QSTR(name),
 						  context_inode);
 	if (error) {
@@ -313,6 +348,7 @@ static int __init anon_inode_init(void)
 	anon_inode_inode = alloc_anon_inode(anon_inode_mnt->mnt_sb);
 	if (IS_ERR(anon_inode_inode))
 		panic("anon_inode_init() inode allocation failed (%ld)\n", PTR_ERR(anon_inode_inode));
+	anon_inode_inode->i_op = &anon_inode_operations;
 
 	return 0;
 }
diff --git a/fs/internal.h b/fs/internal.h
index b9b3e29a73fd..717dc9eb6185 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -343,3 +343,6 @@ static inline bool path_mounted(const struct path *path)
 void file_f_owner_release(struct file *file);
 bool file_seek_cur_needs_f_lock(struct file *file);
 int statmount_mnt_idmap(struct mnt_idmap *idmap, struct seq_file *seq, bool uid_map);
+int anon_inode_getattr(struct mnt_idmap *idmap, const struct path *path,
+		       struct kstat *stat, u32 request_mask,
+		       unsigned int query_flags);
diff --git a/fs/libfs.c b/fs/libfs.c
index 6393d7c49ee6..0ad3336f5b49 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1647,7 +1647,7 @@ struct inode *alloc_anon_inode(struct super_block *s)
 	 * that it already _is_ on the dirty list.
 	 */
 	inode->i_state = I_DIRTY;
-	inode->i_mode = S_IRUSR | S_IWUSR;
+	inode->i_mode = S_IFREG | S_IRUSR | S_IWUSR;
 	inode->i_uid = current_fsuid();
 	inode->i_gid = current_fsgid();
 	inode->i_flags |= S_PRIVATE;
diff --git a/fs/pidfs.c b/fs/pidfs.c
index d64a4cbeb0da..809c3393b6a3 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -572,33 +572,11 @@ static int pidfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	return -EOPNOTSUPP;
 }
 
-
-/*
- * User space expects pidfs inodes to have no file type in st_mode.
- *
- * In particular, 'lsof' has this legacy logic:
- *
- *	type = s->st_mode & S_IFMT;
- *	switch (type) {
- *	  ...
- *	case 0:
- *		if (!strcmp(p, "anon_inode"))
- *			Lf->ntype = Ntype = N_ANON_INODE;
- *
- * to detect our old anon_inode logic.
- *
- * Rather than mess with our internal sane inode data, just fix it
- * up here in getattr() by masking off the format bits.
- */
 static int pidfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 			 struct kstat *stat, u32 request_mask,
 			 unsigned int query_flags)
 {
-	struct inode *inode = d_inode(path->dentry);
-
-	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
-	stat->mode &= ~S_IFMT;
-	return 0;
+	return anon_inode_getattr(idmap, path, stat, request_mask, query_flags);
 }
 
 static const struct inode_operations pidfs_inode_operations = {
-- 
2.47.2


