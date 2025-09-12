Return-Path: <linux-fsdevel+bounces-61073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2181B54C9C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 14:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74883177BC9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 12:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DC233EB0D;
	Fri, 12 Sep 2025 11:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWnBkkYe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D6B33A012;
	Fri, 12 Sep 2025 11:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678143; cv=none; b=LNbZac6fNh8QqfWVNkwXYrutz2W9EIAbvKPo5YtjvVPW2D9qKnz6tKN/lPPmqY2FAb6CmzkCN5iJjY5jqJ7X0EaMVHXGo0Ke8KKZhSUat2QXFqoaeKXnwQMiivZ00jqMDUatWZsRUAwReS+0BnsHl8zL/F4WgfDvs5VG5ZWDqgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678143; c=relaxed/simple;
	bh=a5XVb4dcZ9rIIoimWwsne7QeUSgHXwe9gOX/RBz9TPQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aiTTsr9D4VHeyqwNXxgdN+Yrzcu10bo+hhsKoR8QACqPQdJ0GBp+4T/ge1rKZ+C52KDBeAPLv0E1uzkvlLSD/Nmh9+eNIbXUQw83TkzdXSaatxooPOm8yvAekODrqwNcQTnyifeHAKx9eEEtUJ6izLaLLHvgHQCUaqvR0SX1eaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWnBkkYe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF81C4CEF1;
	Fri, 12 Sep 2025 11:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757678143;
	bh=a5XVb4dcZ9rIIoimWwsne7QeUSgHXwe9gOX/RBz9TPQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MWnBkkYeTH0AKVefEJFH2Z5nZWCTsDWQsP3bjn8yjl1Ca8mITpec0WAhx2hyR2etU
	 aawjJTjSifJddkk0mWZgRzOfXsTk07eWyjNT6ikBlK+NWspXHv/KUwCA55jgFFrVz0
	 iT+wCOgeai+b2yohD3tnQ3Y0wZTVAAFFskNKBuWpDT0vF7k50LHWCOGRmdSxzaAhtJ
	 XqBajNa1eKfNJoGK4UBrxssjavElyF6ji7gTOMYYAzZQzIc98yje97cBPGXGErHdW4
	 Ib7S3hvaSJwVKRMF1g1J37MyvQGgp3shmNbg4zD4EydHdaWm8RbrJh2h/3yuLM/aCz
	 SxJ5KctYBCjNA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 12 Sep 2025 13:52:51 +0200
Subject: [PATCH v2 28/33] nsfs: support file handles
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-work-namespace-v2-28-1a247645cef5@kernel.org>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
In-Reply-To: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7415; i=brauner@kernel.org;
 h=from:subject:message-id; bh=a5XVb4dcZ9rIIoimWwsne7QeUSgHXwe9gOX/RBz9TPQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc4ZxqPHmZb6zdpbWR2wQf5t9fsH/htaT+mZOfxjhtv
 v2cQy3+UEcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBE1qYyMnw3OtE0YWloxs3e
 y+ZViVz5r7elstpqndmZUP7VMuT4kT2MDDvSwxOKPKRjPjBNn3303JPA5Qbeyblq6x6nW/mw5j3
 V4gQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

A while ago we added support for file handles to pidfs so pidfds can be
encoded and decoded as file handles. Userspace has adopted this quickly
and it's proven very useful. Implement file handles for namespaces as
well.

A process is not always able to open /proc/self/ns/. That requires
procfs to be mounted and for /proc/self/ or /proc/self/ns/ to not be
overmounted. However, userspace can always derive a namespace fd from
a pidfd. And that always works for a task's own namespace.

There's no need to introduce unnecessary behavioral differences between
/proc/self/ns/ fds, pidfd-derived namespace fds, and file-handle-derived
namespace fds. So namespace file handles are always decodable if the
caller is located in the namespace the file handle refers to.

This also allows a task to e.g., store a set of file handles to its
namespaces in a file on-disk so it can verify when it gets rexeced that
they're still valid and so on. This is akin to the pidfd use-case.

Or just plainly for namespace comparison reasons where a file handle to
the task's own namespace can be easily compared against others.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/nsfs.c                 | 158 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/exportfs.h  |   6 ++
 include/uapi/linux/nsfs.h |   9 +++
 3 files changed, 173 insertions(+)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 80e631aeb3ce..926e2680414e 100644
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
@@ -417,12 +423,164 @@ static const struct stashed_operations nsfs_stashed_ops = {
 	.put_data = nsfs_put_data,
 };
 
+#define NSFS_FID_SIZE_U32_VER0 (NSFS_FILE_HANDLE_SIZE_VER0 / sizeof(u32))
+#define NSFS_FID_SIZE_U32_LATEST (NSFS_FILE_HANDLE_SIZE_LATEST / sizeof(u32))
+
+static int nsfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
+			  struct inode *parent)
+{
+	struct nsfs_file_handle *fid = (struct nsfs_file_handle *)fh;
+	struct ns_common *ns = inode->i_private;
+	int len = *max_len;
+
+	if (parent)
+		return FILEID_INVALID;
+
+	if (len < NSFS_FID_SIZE_U32_VER0) {
+		*max_len = NSFS_FID_SIZE_U32_LATEST;
+		return FILEID_INVALID;
+	} else if (len > NSFS_FID_SIZE_U32_LATEST) {
+		*max_len = NSFS_FID_SIZE_U32_LATEST;
+	}
+
+	fid->ns_id	= ns->ns_id;
+	fid->ns_type	= ns->ops->type;
+	fid->ns_inum	= inode->i_ino;
+	return FILEID_NSFS;
+}
+
+static struct dentry *nsfs_fh_to_dentry(struct super_block *sb, struct fid *fh,
+					int fh_len, int fh_type)
+{
+	struct path path __free(path_put) = {};
+	struct nsfs_file_handle *fid = (struct nsfs_file_handle *)fh;
+	struct user_namespace *owning_ns = NULL;
+	struct ns_common *ns;
+	int ret;
+
+	if (fh_len < NSFS_FID_SIZE_U32_VER0)
+		return NULL;
+
+	/* Check that any trailing bytes are zero. */
+	if ((fh_len > NSFS_FID_SIZE_U32_LATEST) &&
+	    memchr_inv((void *)fid + NSFS_FID_SIZE_U32_LATEST, 0,
+		       fh_len - NSFS_FID_SIZE_U32_LATEST))
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
+static int nsfs_export_permission(struct handle_to_path_ctx *ctx,
+				   unsigned int oflags)
+{
+	/* nsfs_fh_to_dentry() performs all permission checks. */
+	return 0;
+}
+
+static struct file *nsfs_export_open(struct path *path, unsigned int oflags)
+{
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
diff --git a/include/uapi/linux/nsfs.h b/include/uapi/linux/nsfs.h
index 97d8d80d139f..fa86fe3c8bd3 100644
--- a/include/uapi/linux/nsfs.h
+++ b/include/uapi/linux/nsfs.h
@@ -53,4 +53,13 @@ enum init_ns_ino {
 	MNT_NS_INIT_INO		= 0xEFFFFFF8U,
 };
 
+struct nsfs_file_handle {
+	__u64 ns_id;
+	__u32 ns_type;
+	__u32 ns_inum;
+};
+
+#define NSFS_FILE_HANDLE_SIZE_VER0 16 /* sizeof first published struct */
+#define NSFS_FILE_HANDLE_SIZE_LATEST sizeof(struct nsfs_file_handle) /* sizeof latest published struct */
+
 #endif /* __LINUX_NSFS_H */

-- 
2.47.3


