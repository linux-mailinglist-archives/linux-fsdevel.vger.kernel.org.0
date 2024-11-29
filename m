Return-Path: <linux-fsdevel+bounces-36150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EBE9DE7D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 14:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06DCA2809A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 13:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7ED1AA1EC;
	Fri, 29 Nov 2024 13:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnbMI3Hh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC851A9B2A;
	Fri, 29 Nov 2024 13:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732887577; cv=none; b=dDaZn3BC8pjB6xLnhh3kNQC6VimiEkloYDr+EmZ4xQlhBfPZFsGpLJJ3gdCufnH+/zxnEvzMXDhdp5whNApzyqXvl9Mk9x0b/F8Tde49l+b/0/2cxnyd7z6bx9YO2/GYJbrWNGPGWAoJkuB0cv4ovJQOqDsaEmPBVX9eNVydvvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732887577; c=relaxed/simple;
	bh=WEQD5GD1MRTw0uQNZQTK0HL8w7OgRdr07MVKxiGGaVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GQmLMmYOiXN9LchzHwW/elg8Jt4mP4sLD+0t6MNxgDcleGZCBS7ekARnc+ZxhfdsjnHz9Ve+2c9hC99sSKDmHJYfoLIN6SOhEz1o73ggZEJV8bQt/AloUGwbeXF+d5R8cfANQJ+xwpy0oeiqCp+TnI1PkPIA/qIDSN4JGHmCAvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnbMI3Hh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528E4C4CECF;
	Fri, 29 Nov 2024 13:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732887576;
	bh=WEQD5GD1MRTw0uQNZQTK0HL8w7OgRdr07MVKxiGGaVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hnbMI3Hh65KedCuSDpx1x/cPkl0mAhCkn/nu2JShAr8jMYY678SDVxkUd+89fxbQd
	 NNZQKDegYEf0hbQkMFSs3IEL0kpM+h6AbZQ0Z3ULUkYYLWleVH5PjHozlX2ty6kkF3
	 v1HSmI+jZRd3kA37N6C33CGN1PgLhPMgx4WgajwgF8W7jEGCAlHPYYji6pDRwNgA1T
	 5f2Cjy8O4VdQwaWaxfs4upTu/V6PjNsCbj2dCjlv1YGyrVgynmda7i9JIlBwf4jred
	 whHUsRi6Vur+9v/O2zeZLQk8kfMKLo7bCWWYhDIBEy0xN6odJOyKR0ITqLWIQXqmzP
	 6I2NA+4DKQLLQ==
From: Christian Brauner <brauner@kernel.org>
To: Erin Shepherd <erin.shepherd@e43.eu>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH RFC 6/6] pidfs: implement file handle support
Date: Fri, 29 Nov 2024 14:38:05 +0100
Message-ID: <20241129-work-pidfs-file_handle-v1-6-87d803a42495@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241129-work-pidfs-file_handle-v1-0-87d803a42495@kernel.org>
References: <20241129-work-pidfs-file_handle-v1-0-87d803a42495@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6382; i=brauner@kernel.org; h=from:subject:message-id; bh=WEQD5GD1MRTw0uQNZQTK0HL8w7OgRdr07MVKxiGGaVU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR7Hj5kuS/k0ZmFdU8Fzod/z0yvli1vL6m226l/lM9n9 mvxYP4vHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOZvJ6RYZHprYiLbcsWptXF XkmbdbQxkre2ojnt3/5YMVeuZY/5kxgZ1p2JcJj6gq8gdlmU/ISSWIXLn6p3ck+snOFd0+/2Wew QCwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On 64-bit platforms, userspace can read the pidfd's inode in order to
get a never-repeated PID identifier. On 32-bit platforms this identifier
is not exposed, as inodes are limited to 32 bits. Instead expose the
identifier via export_fh, which makes it available to userspace via
name_to_handle_at.

In addition we implement fh_to_dentry, which allows userspace to
recover a pidfd from a pidfs file handle.

Signed-off-by: Erin Shepherd <erin.shepherd@e43.eu>
[brauner: patch heavily rewritten]
Co-Developed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/fhandle.c | 34 +++++++++++----------
 fs/pidfs.c   | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 115 insertions(+), 15 deletions(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 23491094032ec037066a271873ea8ff794616bee..4c847ca16fabe31d51ff5698b0c9c355c3e2fb67 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -268,20 +268,6 @@ static int do_handle_to_path(struct file_handle *handle, struct path *path,
 	return 0;
 }
 
-/*
- * Allow relaxed permissions of file handles if the caller has the
- * ability to mount the filesystem or create a bind-mount of the
- * provided @mountdirfd.
- *
- * In both cases the caller may be able to get an unobstructed way to
- * the encoded file handle. If the caller is only able to create a
- * bind-mount we need to verify that there are no locked mounts on top
- * of it that could prevent us from getting to the encoded file.
- *
- * In principle, locked mounts can prevent the caller from mounting the
- * filesystem but that only applies to procfs and sysfs neither of which
- * support decoding file handles.
- */
 static inline bool may_decode_fh(struct handle_to_path_ctx *ctx,
 				 unsigned int o_flags)
 {
@@ -291,6 +277,19 @@ static inline bool may_decode_fh(struct handle_to_path_ctx *ctx,
 		return true;
 
 	/*
+	 * Allow relaxed permissions of file handles if the caller has the
+	 * ability to mount the filesystem or create a bind-mount of the
+	 * provided @mountdirfd.
+	 *
+	 * In both cases the caller may be able to get an unobstructed way to
+	 * the encoded file handle. If the caller is only able to create a
+	 * bind-mount we need to verify that there are no locked mounts on top
+	 * of it that could prevent us from getting to the encoded file.
+	 *
+	 * In principle, locked mounts can prevent the caller from mounting the
+	 * filesystem but that only applies to procfs and sysfs neither of which
+	 * support decoding file handles.
+	 *
 	 * Restrict to O_DIRECTORY to provide a deterministic API that avoids a
 	 * confusing api in the face of disconnected non-dir dentries.
 	 *
@@ -397,6 +396,7 @@ static long do_handle_open(int mountdirfd, struct file_handle __user *ufh,
 	long retval = 0;
 	struct path path __free(path_put) = {};
 	struct file *file;
+	const struct export_operations *eops;
 
 	retval = handle_to_path(mountdirfd, ufh, &path, open_flag);
 	if (retval)
@@ -406,7 +406,11 @@ static long do_handle_open(int mountdirfd, struct file_handle __user *ufh,
 	if (fd < 0)
 		return fd;
 
-	file = file_open_root(&path, "", open_flag, 0);
+	eops = path.mnt->mnt_sb->s_export_op;
+	if (eops->open)
+		file = eops->open(&path, open_flag);
+	else
+		file = file_open_root(&path, "", open_flag, 0);
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
diff --git a/fs/pidfs.c b/fs/pidfs.c
index f73a47e1d8379df886a90a044fb887f8d06f7c0b..f09af08a4abe4a9100ed972bee8f5c5d7ab33d84 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/anon_inodes.h>
+#include <linux/exportfs.h>
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/cgroup.h>
@@ -454,6 +455,100 @@ static const struct dentry_operations pidfs_dentry_operations = {
 	.d_prune	= stashed_dentry_prune,
 };
 
+static int pidfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
+			   struct inode *parent)
+{
+	struct pid *pid = inode->i_private;
+
+	if (*max_len < 2) {
+		*max_len = 2;
+		return FILEID_INVALID;
+	}
+
+	*max_len = 2;
+	*(u64 *)fh = pid->ino;
+	return FILEID_KERNFS;
+}
+
+/* Find a struct pid based on the inode number. */
+static struct pid *pidfs_ino_get_pid(u64 ino)
+{
+	ino_t pid_ino = pidfs_ino(ino);
+	u32 gen = pidfs_gen(ino);
+	struct pid *pid;
+
+	guard(rcu)();
+
+	/* Handle @pid lookup carefully so there's no risk of UAF. */
+	pid = idr_find(&pidfs_ino_idr, (u32)pid_ino);
+	if (!pid)
+		return NULL;
+
+	if (sizeof(ino_t) < sizeof(u64)) {
+		if (gen && pidfs_gen(pid->ino) != gen)
+			pid = NULL;
+	} else {
+		if (pidfs_ino(pid->ino) != pid_ino)
+			pid = NULL;
+	}
+
+	/* Within our pid namespace hierarchy? */
+	if (pid_vnr(pid) == 0)
+		pid = NULL;
+
+	return get_pid(pid);
+}
+
+static struct dentry *pidfs_fh_to_dentry(struct super_block *sb,
+					 struct fid *fid, int fh_len,
+					 int fh_type)
+{
+	int ret;
+	u64 pid_ino;
+	struct path path;
+	struct pid *pid;
+
+	if (fh_len < 2)
+		return NULL;
+
+	switch (fh_type) {
+	case FILEID_KERNFS:
+		pid_ino = *(u64 *)fid;
+		break;
+	default:
+		return NULL;
+	}
+
+	pid = pidfs_ino_get_pid(pid_ino);
+	if (!pid)
+		return NULL;
+
+	ret = path_from_stashed(&pid->stashed, pidfs_mnt, pid, &path);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	mntput(path.mnt);
+	return path.dentry;
+}
+
+static int pidfs_export_permission(struct handle_to_path_ctx *ctx,
+				   unsigned int oflags)
+{
+	return 0;
+}
+
+static struct file *pidfs_export_open(struct path *path, unsigned int oflags)
+{
+	return dentry_open(path, oflags | O_RDWR, current_cred());
+}
+
+static const struct export_operations pidfs_export_operations = {
+	.encode_fh	= pidfs_encode_fh,
+	.fh_to_dentry	= pidfs_fh_to_dentry,
+	.open		= pidfs_export_open,
+	.permission	= pidfs_export_permission,
+};
+
 static int pidfs_init_inode(struct inode *inode, void *data)
 {
 	struct pid *pid = data;
@@ -488,6 +583,7 @@ static int pidfs_init_fs_context(struct fs_context *fc)
 		return -ENOMEM;
 
 	ctx->ops = &pidfs_sops;
+	ctx->eops = &pidfs_export_operations;
 	ctx->dops = &pidfs_dentry_operations;
 	fc->s_fs_info = (void *)&pidfs_stashed_ops;
 	return 0;

-- 
2.45.2


