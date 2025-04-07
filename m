Return-Path: <linux-fsdevel+bounces-45847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00781A7DA5F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 11:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12E92188ED14
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 09:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AD9232363;
	Mon,  7 Apr 2025 09:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmfUyDnb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2AD230993;
	Mon,  7 Apr 2025 09:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744019678; cv=none; b=o3QBWqBG2b3VaKxkKQv6sYD2ajZlvCnGA4GPN8BT4oEekGUopCy0PA5XxSP65PYTjUYRmcSyyO4m/TMK11PdkKSED3S0c/Do1z7bLUBtoygvZG6IJtBvCqTN0gEmNjJMgOGBl7DP2+hyDZziBjIf41MzJs+O1RE/88NhoqKEaTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744019678; c=relaxed/simple;
	bh=NYh0DihgsxzRcHuA1zI/gQF/Wj+Z5uW0uYxJfjAB+IU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W7CfJIq9CNyP568FmyGP6bLiYCVBIzJt8Wa4wqWgvKnojyhVvY6wCtO/ckCG+DmedbSal5MSGZ7t5RpTDfU9WtdL/8PJeJhV1Og6Ze1iXiLy/CiDy3/U1vGA/245lfXJLZ8ZF1vdB5hG6WGtFK23t93Pp2Ig7wR8Z1Bt+HiVj2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmfUyDnb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D844C4CEEB;
	Mon,  7 Apr 2025 09:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744019677;
	bh=NYh0DihgsxzRcHuA1zI/gQF/Wj+Z5uW0uYxJfjAB+IU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rmfUyDnbB4VL+bkpmQu9Mdqr2jnm6FTbz+eephcuqznnHd5xOCSrxlQqda+a9ZXE6
	 VQmedmy9JUy95NAGqLTjOOPVKPuEjjvqmiKAqmGvm4/6p3f36li0w3NJNP5yAiXM6D
	 MJnPVz8rNgKXvukFbh97SaApXaHOhmkdRPbAhkirOsaaAKEHbrQQAvgYkRmET5iNlk
	 n08guH6qJCBXc/22F4LRvz03hnLFzxi7D57rcWqyBA8C4SOiD+MGLxlLN/URSebyZ2
	 dp4UFeBUsD8VDn8+e3FDifQrNGo/jfAtOyKfP8DpD7913ts1QAmsA9mZCMp5hH6LGR
	 HWcpEBgSYViVA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 07 Apr 2025 11:54:15 +0200
Subject: [PATCH 1/9] anon_inode: use a proper mode internally
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-work-anon_inode-v1-1-53a44c20d44e@kernel.org>
References: <20250407-work-anon_inode-v1-0-53a44c20d44e@kernel.org>
In-Reply-To: <20250407-work-anon_inode-v1-0-53a44c20d44e@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, 
 Mateusz Guzik <mjguzik@gmail.com>, Penglei Jiang <superman.xpt@gmail.com>, 
 Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com, 
 Christian Brauner <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3800; i=brauner@kernel.org;
 h=from:subject:message-id; bh=NYh0DihgsxzRcHuA1zI/gQF/Wj+Z5uW0uYxJfjAB+IU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR/XnD9U/q5575WCxSW8Z29p8Z0ZMusC9zRv3ezdMbP7
 t92sqPQvaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiWo8Y/qel/XUo3Rheqfxk
 r8iZ7XpHX6frn3VW2zm970ansLa2lQkjw/OXCj8P+Xa8zS2Y1++4JVuKvdTu2nxV76+fzvmvDzH
 ZzwoA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

This allows the VFS to not trip over anonymous inodes and we can add
asserts based on the mode into the vfs. When we report it to userspace
we can simply hide the mode to avoid regressions. I've audited all
direct callers of alloc_anon_inode() and only secretmen overrides i_mode
and i_op inode operations but it already uses a regular file.

Fixes: af153bb63a336 ("vfs: catch invalid modes in may_open()")
Cc: <stable@vger.kernel.org> # all LTS kernels
Reported-by: syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/67ed3fb3.050a0220.14623d.0009.GAE@google.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/anon_inodes.c | 36 ++++++++++++++++++++++++++++++++++++
 fs/internal.h    |  3 +++
 fs/libfs.c       |  2 +-
 3 files changed, 40 insertions(+), 1 deletion(-)

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

-- 
2.47.2


