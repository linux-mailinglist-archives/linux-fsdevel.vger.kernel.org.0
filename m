Return-Path: <linux-fsdevel+bounces-60801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D60CAB51A71
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 16:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 962BB44249D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 14:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9132737288D;
	Wed, 10 Sep 2025 14:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlBot1gJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85823376B7;
	Wed, 10 Sep 2025 14:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515187; cv=none; b=sJXGeLouICKhR1lKr2WGPc1encW3ZFDjbndQX3f50bRW6Zvtpt7QtcaU23ZYPGVLs33k0v35jGKEl7ypIOAaEPx1vxr2tT7a557I5/JY36hknRqxUaCKa6MM95udRBTVUKiN8KVB6I/sjJw900bwl7PJGLpnXDgl9vjQiNqoguk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515187; c=relaxed/simple;
	bh=93zobprarsfhaK9wvmZuL2ifa/e6eX+56DGLdNBvdEs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qpBHDIrxH97n7pCo5zk2LlBtj76EC8ou0FaPYAhkJnqHkxucpsgh5QBFW5INMh3DlKNRu3BP6KkujCOWdB7RrOCmQYyOkKQzO38UivyDcO2aosYyVvp53L9NtWr1gBdoDJCiisfxjbHtuWU6+HrzQPE6ZcmNl0HRlTKqd+ocG9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlBot1gJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32055C4CEEB;
	Wed, 10 Sep 2025 14:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757515187;
	bh=93zobprarsfhaK9wvmZuL2ifa/e6eX+56DGLdNBvdEs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DlBot1gJxFjjAKDUQ/PtIVM1jO+3PybmmPsK1Ti+faY27DvW+B1KoimKXXp8we3KY
	 WXaYTx+Oxd4xjYP9DM0WOsp/tT1KhN3PPBWh4QB7N3ECdMAV2WGjzWPu3EYDcEd4wD
	 Rk0+kkOz1LwQUFG2WeOgB9FmfYFnThIrMPOcgDcIAsVFubTrt6OShkN6f9nvTYqdxU
	 7kh+vr6nefyQQem6l7fktJVW1JJsca6HrB39XCjtJXgSIHGRVPOkUi7GjwRh66C3tt
	 odQvngaDW+1R2h8EGmbXWZ/jI0TVQrpsI2ST0RP8UCTf0QfWiDDDfqGCwZFFH2RHKO
	 XUn9Wy4SqSOrQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 10 Sep 2025 16:37:12 +0200
Subject: [PATCH 27/32] nsfs: support file handles
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-work-namespace-v1-27-4dd56e7359d8@kernel.org>
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
In-Reply-To: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
To: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 netdev@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.14.3-dev-385fa
X-Developer-Signature: v=1; a=openpgp-sha256; l=6320; i=brauner@kernel.org;
 h=from:subject:message-id; bh=93zobprarsfhaK9wvmZuL2ifa/e6eX+56DGLdNBvdEs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc7OX8dFdnovh6C+d/3LyHF8mbq0/ZtnjN6zuP2/e2l
 Xmz/myw6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiI7DRGht/R22f4Bu2OUuba
 eTq3P1bgX5Wa7u+fNi9+nr/uGnxphRvD/1oO3hynDbYzw58IFnAx8vDuVbpaUrp6Dd8s/tO/jZS
 E2AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

A while ago we added support for file handles to pidfs so pidfds can be
encoded and decoded as file handles. Userspace has adopted this quickly
and it's proven very useful. Pidfd file handles are exhaustive meaning
they don't require a handle on another pidfd to pass to
open_by_handle_at() so it can derive the filesystem to decode in.

Implement the exhaustive file handles for namespaces as well.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/nsfs.c                | 176 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/exportfs.h |   6 ++
 2 files changed, 182 insertions(+)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 6f8008177133..a1585a2f4f03 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -13,6 +13,12 @@
 #include <linux/nsfs.h>
 #include <linux/uaccess.h>
 #include <linux/mnt_namespace.h>
+#include <linux/ipc_namespace.h>
+#include <linux/time_namespace.h>
+#include <linux/utsname.h>
+#include <linux/exportfs.h>
+#include <linux/nstree.h>
+#include <net/net_namespace.h>
 
 #include "mount.h"
 #include "internal.h"
@@ -417,12 +423,182 @@ static const struct stashed_operations nsfs_stashed_ops = {
 	.put_data = nsfs_put_data,
 };
 
+struct nsfs_fid {
+	u64 ns_id;
+	u32 ns_type;
+	u32 ns_inum;
+} __attribute__ ((packed));
+
+#define NSFS_FID_SIZE (sizeof(struct nsfs_fid) / sizeof(u32))
+
+static int nsfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
+			  struct inode *parent)
+{
+	struct nsfs_fid *fid = (struct nsfs_fid *)fh;
+	struct ns_common *ns = inode->i_private;
+	int len = *max_len;
+
+	/*
+	 * TODO:
+	 * For hierarchical namespaces we should start to encode the
+	 * parent namespace. Then userspace can walk a namespace
+	 * hierarchy purely based on file handles.
+	 */
+	if (parent)
+		return FILEID_INVALID;
+
+	if (len < NSFS_FID_SIZE) {
+		*max_len = NSFS_FID_SIZE;
+		return FILEID_INVALID;
+	}
+
+	len  = NSFS_FID_SIZE;
+
+	fid->ns_id = ns->ns_id;
+	fid->ns_type = ns->ops->type;
+	fid->ns_inum = inode->i_ino;
+	*max_len = len;
+	return FILEID_NSFS;
+}
+
+static struct dentry *nsfs_fh_to_dentry(struct super_block *sb, struct fid *fh,
+					int fh_len, int fh_type)
+{
+	struct path path __free(path_put) = {};
+	struct nsfs_fid *fid = (struct nsfs_fid *)fh;
+	struct user_namespace *owning_ns = NULL;
+	struct ns_common *ns;
+	int ret;
+
+	if (fh_len < NSFS_FID_SIZE)
+		return NULL;
+
+	switch (fh_type) {
+	case FILEID_NSFS:
+		break;
+	default:
+		return NULL;
+	}
+
+	scoped_guard(rcu) {
+		ns = ns_tree_lookup_rcu(fid->ns_id, fid->ns_type);
+		if (!ns)
+			return NULL;
+
+		VFS_WARN_ON_ONCE(ns->ns_id != fid->ns_id);
+		VFS_WARN_ON_ONCE(ns->ops->type != fid->ns_type);
+		VFS_WARN_ON_ONCE(ns->inum != fid->ns_inum);
+
+		if (!refcount_inc_not_zero(&ns->count))
+			return NULL;
+	}
+
+	switch (ns->ops->type) {
+#ifdef CONFIG_CGROUPS
+	case CLONE_NEWCGROUP:
+		if (!current_in_namespace(to_cg_ns(ns)))
+			owning_ns = to_cg_ns(ns)->user_ns;
+		break;
+#endif
+#ifdef CONFIG_IPC_NS
+	case CLONE_NEWIPC:
+		if (!current_in_namespace(to_ipc_ns(ns)))
+			owning_ns = to_ipc_ns(ns)->user_ns;
+		break;
+#endif
+	case CLONE_NEWNS:
+		if (!current_in_namespace(to_mnt_ns(ns)))
+			owning_ns = to_mnt_ns(ns)->user_ns;
+		break;
+#ifdef CONFIG_NET_NS
+	case CLONE_NEWNET:
+		if (!current_in_namespace(to_net_ns(ns)))
+			owning_ns = to_net_ns(ns)->user_ns;
+		break;
+#endif
+#ifdef CONFIG_PID_NS
+	case CLONE_NEWPID:
+		if (!current_in_namespace(to_pid_ns(ns))) {
+			owning_ns = to_pid_ns(ns)->user_ns;
+		} else if (!READ_ONCE(to_pid_ns(ns)->child_reaper)) {
+			ns->ops->put(ns);
+			return ERR_PTR(-EPERM);
+		}
+		break;
+#endif
+#ifdef CONFIG_TIME_NS
+	case CLONE_NEWTIME:
+		if (!current_in_namespace(to_time_ns(ns)))
+			owning_ns = to_time_ns(ns)->user_ns;
+		break;
+#endif
+#ifdef CONFIG_USER_NS
+	case CLONE_NEWUSER:
+		if (!current_in_namespace(to_user_ns(ns)))
+			owning_ns = to_user_ns(ns);
+		break;
+#endif
+#ifdef CONFIG_UTS_NS
+	case CLONE_NEWUTS:
+		if (!current_in_namespace(to_uts_ns(ns)))
+			owning_ns = to_uts_ns(ns)->user_ns;
+		break;
+#endif
+	default:
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
+	if (owning_ns && !ns_capable(owning_ns, CAP_SYS_ADMIN)) {
+		ns->ops->put(ns);
+		return ERR_PTR(-EPERM);
+	}
+
+	/* path_from_stashed() unconditionally consumes the reference. */
+	ret = path_from_stashed(&ns->stashed, nsfs_mnt, ns, &path);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return no_free_ptr(path.dentry);
+}
+
+/*
+ * Make sure that we reject any nonsensical flags that users pass via
+ * open_by_handle_at().
+ */
+#define VALID_FILE_HANDLE_OPEN_FLAGS \
+	(O_RDONLY | O_WRONLY | O_RDWR | O_NONBLOCK | O_CLOEXEC | O_EXCL)
+
+static int nsfs_export_permission(struct handle_to_path_ctx *ctx,
+				   unsigned int oflags)
+{
+	if (oflags & ~(VALID_FILE_HANDLE_OPEN_FLAGS | O_LARGEFILE))
+		return -EINVAL;
+
+	/* nsfs_fh_to_dentry() is performs further permission checks. */
+	return 0;
+}
+
+static struct file *nsfs_export_open(struct path *path, unsigned int oflags)
+{
+	/* Clear O_LARGEFILE as open_by_handle_at() forces it. */
+	oflags &= ~O_LARGEFILE;
+	return file_open_root(path, "", oflags, 0);
+}
+
+static const struct export_operations nsfs_export_operations = {
+	.encode_fh	= nsfs_encode_fh,
+	.fh_to_dentry	= nsfs_fh_to_dentry,
+	.open		= nsfs_export_open,
+	.permission	= nsfs_export_permission,
+};
+
 static int nsfs_init_fs_context(struct fs_context *fc)
 {
 	struct pseudo_fs_context *ctx = init_pseudo(fc, NSFS_MAGIC);
 	if (!ctx)
 		return -ENOMEM;
 	ctx->ops = &nsfs_ops;
+	ctx->eops = &nsfs_export_operations;
 	ctx->dops = &ns_dentry_operations;
 	fc->s_fs_info = (void *)&nsfs_stashed_ops;
 	return 0;
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index cfb0dd1ea49c..3aac58a520c7 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -122,6 +122,12 @@ enum fid_type {
 	FILEID_BCACHEFS_WITHOUT_PARENT = 0xb1,
 	FILEID_BCACHEFS_WITH_PARENT = 0xb2,
 
+	/*
+	 *
+	 * 64 bit namespace identifier, 32 bit namespace type, 32 bit inode number.
+	 */
+	FILEID_NSFS = 0xf1,
+
 	/*
 	 * 64 bit unique kernfs id
 	 */

-- 
2.47.3


