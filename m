Return-Path: <linux-fsdevel+bounces-23996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C00093773B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 13:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC6B41C20FBB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 11:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0338012C81F;
	Fri, 19 Jul 2024 11:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwlTpSnE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6341012C530
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jul 2024 11:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721389357; cv=none; b=NAy/hVdvrfmTcqGJYvBmYCMFpVdSV5cfGVcVz8X/RNJiDfTaIW2Oklq2kC3hw/JeEg+G7+bFFlkrsh3/52E6v8DHufJGg0s72mOY284Koq77tM5fVNp9IViNAJGYSKSNZppsMJcGQKf3xjvOzOWvgw+RrkVQmbx/TP5ZlCVCA8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721389357; c=relaxed/simple;
	bh=JiWYFxjv3zJ/IBNPWasmdceg7hk4TriYPu4AN062EIs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q6egMxM5qgG0H5GLlesjciYlmpboqROtgxYHeuOi5+dqAF1hblek6YP5F1NYnkCiKdYQyY/usoogoWkxxE3pouOyPwk76EZsZQcuMyLgYtgxg62v5h4ryQB/gHHA+2T338R/UANA8NlGcJGWgwtGvS7UHSnI7rAZzOjlVSePq68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwlTpSnE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF7DC4AF0A;
	Fri, 19 Jul 2024 11:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721389357;
	bh=JiWYFxjv3zJ/IBNPWasmdceg7hk4TriYPu4AN062EIs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OwlTpSnEusfqU1qCe5b5OU0YjrDymgSzP6Vt/BEqXiKFL7jEtiONtekn63pTOChCD
	 FVkkY32b9bPGWPAfAiLjEl5gEsiiQDCvt32PqsDVNFxrh4e9niWmyTv33iNACB1zwS
	 KvOswxzol7bMxraBwrLJk/6hTHorvgxIVo7HVH0FSyiAQjxe18o35xnHjCxyJCcXg6
	 kJRVyYoMsD237Y6MZs2VeP9cccHLpwIUpQv8ImJKRrEfvT9CBwo0goJTmBR2e57pBP
	 btafFVJRAlqMhoIYgZDQhkbXQAFdAgAVCEOTLIKutzTU9qL12USaubnbJOgOv9NTCy
	 d8n7R/y+Z7+CA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 19 Jul 2024 13:41:52 +0200
Subject: [PATCH RFC 5/5] nsfs: iterate through mount namespaces
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-work-mount-namespace-v1-5-834113cab0d2@kernel.org>
References: <20240719-work-mount-namespace-v1-0-834113cab0d2@kernel.org>
In-Reply-To: <20240719-work-mount-namespace-v1-0-834113cab0d2@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Karel Zak <kzak@redhat.com>, Stephane Graber <stgraber@stgraber.org>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-13183
X-Developer-Signature: v=1; a=openpgp-sha256; l=8889; i=brauner@kernel.org;
 h=from:subject:message-id; bh=JiWYFxjv3zJ/IBNPWasmdceg7hk4TriYPu4AN062EIs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTNClSwFD+X//7nNWnLcHGd4xtLk9RnmHCIbXLc13j8X
 lNJjvLcjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIl8mMLIsLr+9dUJR3t1XRZo
 7LjKxGex9Y2NC3fW5xMSQrMOevOUqTIyzFaL7Nj8dt20pb0Wh+Rez/IMtm8I+rI3gO8Up/Yaozs
 l7AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

It is already possible to list mounts in other mount namespaces and to
retrieve namespace file descriptors without having to go through procfs
by deriving them from pidfds.

Augment these abilities by adding the ability to retrieve information
about a mount namespace via NS_MNT_GET_INFO. This will return the mount
namespace id and the number of mounts currently in the mount namespace.
The number of mounts can be used to size the buffer that needs to be
used for listmount() and is in general useful without having to actually
iterate through all the mounts. The structure is extensible.

And add the ability to iterate through all mount namespaces over which
the caller holds privilege returning the file descriptor for the next or
previous mount namespace.

To retrieve a mount namespace the caller must be privileged wrt to it's
owning user namespace. This means that PID 1 on the host can list all
mounts in all mount namespaces or that a container can list all mounts
of its nested containers.

Optionally pass a structure for NS_MNT_GET_INFO with
NS_MNT_GET_{PREV,NEXT} to retrieve information about the mount namespace
in one go. Both ioctls can be implemented for other namespace types
easily.

Together with recent api additions this means one can iterate through
all mounts in all mount namespaces without ever touching procfs.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/mount.h                |  13 ++++++
 fs/namespace.c            |  35 ++++++++++++++--
 fs/nsfs.c                 | 102 +++++++++++++++++++++++++++++++++++++++++++++-
 include/uapi/linux/nsfs.h |  15 +++++++
 4 files changed, 159 insertions(+), 6 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index ad4b1ddebb54..c1db0c709c6a 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -155,3 +155,16 @@ static inline void move_from_ns(struct mount *mnt, struct list_head *dt_list)
 
 extern void mnt_cursor_del(struct mnt_namespace *ns, struct mount *cursor);
 bool has_locked_children(struct mount *mnt, struct dentry *dentry);
+struct mnt_namespace *__lookup_next_mnt_ns(struct mnt_namespace *mnt_ns, bool previous);
+static inline struct mnt_namespace *lookup_next_mnt_ns(struct mnt_namespace *mntns)
+{
+	return __lookup_next_mnt_ns(mntns, false);
+}
+static inline struct mnt_namespace *lookup_prev_mnt_ns(struct mnt_namespace *mntns)
+{
+	return __lookup_next_mnt_ns(mntns, true);
+}
+static inline struct mnt_namespace *to_mnt_ns(struct ns_common *ns)
+{
+	return container_of(ns, struct mnt_namespace, ns);
+}
diff --git a/fs/namespace.c b/fs/namespace.c
index 3ee8adb7f215..60e20f15e87e 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2060,14 +2060,41 @@ static bool is_mnt_ns_file(struct dentry *dentry)
 	       dentry->d_fsdata == &mntns_operations;
 }
 
-static struct mnt_namespace *to_mnt_ns(struct ns_common *ns)
+struct ns_common *from_mnt_ns(struct mnt_namespace *mnt)
 {
-	return container_of(ns, struct mnt_namespace, ns);
+	return &mnt->ns;
 }
 
-struct ns_common *from_mnt_ns(struct mnt_namespace *mnt)
+struct mnt_namespace *__lookup_next_mnt_ns(struct mnt_namespace *mntns, bool previous)
 {
-	return &mnt->ns;
+	guard(read_lock)(&mnt_ns_tree_lock);
+	for (;;) {
+		struct rb_node *node;
+
+		if (previous)
+			node = rb_prev(&mntns->mnt_ns_tree_node);
+		else
+			node = rb_next(&mntns->mnt_ns_tree_node);
+		if (!node)
+			return ERR_PTR(-ENOENT);
+
+		mntns = node_to_mnt_ns(node);
+		node = &mntns->mnt_ns_tree_node;
+
+		if (!ns_capable_noaudit(mntns->user_ns, CAP_SYS_ADMIN))
+			continue;
+
+		/*
+		 * Holding mnt_ns_tree_lock prevents the mount namespace from
+		 * being freed but it may well be on it's deathbed. We want an
+		 * active reference, not just a passive one here as we're
+		 * persisting the mount namespace.
+		 */
+		if (!refcount_inc_not_zero(&mntns->ns.count))
+			continue;
+
+		return mntns;
+	}
 }
 
 static bool mnt_ns_loop(struct dentry *dentry)
diff --git a/fs/nsfs.c b/fs/nsfs.c
index 97c37a9631e5..67ee176b8824 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -12,6 +12,7 @@
 #include <linux/user_namespace.h>
 #include <linux/nsfs.h>
 #include <linux/uaccess.h>
+#include <linux/mnt_namespace.h>
 
 #include "mount.h"
 #include "internal.h"
@@ -128,6 +129,30 @@ int open_related_ns(struct ns_common *ns,
 }
 EXPORT_SYMBOL_GPL(open_related_ns);
 
+static int copy_ns_info_to_user(const struct mnt_namespace *mnt_ns,
+				struct mnt_ns_info __user *uinfo, size_t usize,
+				struct mnt_ns_info *kinfo)
+{
+	/*
+	 * If userspace and the kernel have the same struct size it can just
+	 * be copied. If userspace provides an older struct, only the bits that
+	 * userspace knows about will be copied. If userspace provides a new
+	 * struct, only the bits that the kernel knows aobut will be copied and
+	 * the size value will be set to the size the kernel knows about.
+	 */
+	kinfo->size		= min(usize, sizeof(*kinfo));
+	kinfo->mnt_ns_id	= mnt_ns->seq;
+	kinfo->nr_mounts	= READ_ONCE(mnt_ns->nr_mounts);
+	/* Subtract the root mount of the mount namespace. */
+	if (kinfo->nr_mounts)
+		kinfo->nr_mounts--;
+
+	if (copy_to_user(uinfo, kinfo, kinfo->size))
+		return -EFAULT;
+
+	return 0;
+}
+
 static long ns_ioctl(struct file *filp, unsigned int ioctl,
 			unsigned long arg)
 {
@@ -135,6 +160,8 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
 	struct pid_namespace *pid_ns;
 	struct task_struct *tsk;
 	struct ns_common *ns = get_proc_ns(file_inode(filp));
+	struct mnt_namespace *mnt_ns;
+	bool previous = false;
 	uid_t __user *argp;
 	uid_t uid;
 	int ret;
@@ -156,7 +183,6 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
 		uid = from_kuid_munged(current_user_ns(), user_ns->owner);
 		return put_user(uid, argp);
 	case NS_GET_MNTNS_ID: {
-		struct mnt_namespace *mnt_ns;
 		__u64 __user *idp;
 		__u64 id;
 
@@ -211,7 +237,79 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
 
 		if (!ret)
 			ret = -ESRCH;
-		break;
+		return ret;
+	}
+	}
+
+	/* extensible ioctls */
+	switch (_IOC_NR(ioctl)) {
+	case _IOC_NR(NS_MNT_GET_INFO): {
+		struct mnt_ns_info kinfo = {};
+		struct mnt_ns_info __user *uinfo = (struct mnt_ns_info __user *)arg;
+		size_t usize = _IOC_SIZE(ioctl);
+
+		if (ns->ops->type != CLONE_NEWNS)
+			return -EINVAL;
+
+		if (!uinfo)
+			return -EINVAL;
+
+		if (usize < MNT_NS_INFO_SIZE_VER0)
+			return -EINVAL;
+
+		return copy_ns_info_to_user(to_mnt_ns(ns), uinfo, usize, &kinfo);
+	}
+	case _IOC_NR(NS_MNT_GET_PREV):
+		previous = true;
+		fallthrough;
+	case _IOC_NR(NS_MNT_GET_NEXT): {
+		struct mnt_ns_info kinfo = {};
+		struct mnt_ns_info __user *uinfo = (struct mnt_ns_info __user *)arg;
+		struct path path __free(path_put) = {};
+		struct file *f __free(fput) = NULL;
+		size_t usize = _IOC_SIZE(ioctl);
+
+		if (ns->ops->type != CLONE_NEWNS)
+			return -EINVAL;
+
+		if (usize < MNT_NS_INFO_SIZE_VER0)
+			return -EINVAL;
+
+		if (previous)
+			mnt_ns = lookup_prev_mnt_ns(to_mnt_ns(ns));
+		else
+			mnt_ns = lookup_next_mnt_ns(to_mnt_ns(ns));
+		if (IS_ERR(mnt_ns))
+			return PTR_ERR(mnt_ns);
+
+		ns = to_ns_common(mnt_ns);
+		/* Transfer ownership of @mnt_ns reference to @path. */
+		ret = path_from_stashed(&ns->stashed, nsfs_mnt, ns, &path);
+		if (ret)
+			return ret;
+
+		CLASS(get_unused_fd, fd)(O_CLOEXEC);
+		if (fd < 0)
+			return fd;
+
+		f = dentry_open(&path, O_RDONLY, current_cred());
+		if (IS_ERR(f))
+			return PTR_ERR(f);
+
+		if (uinfo) {
+			/*
+			 * If @uinfo is passed return all information about the
+			 * mount namespace as well.
+			 */
+			ret = copy_ns_info_to_user(to_mnt_ns(ns), uinfo, usize, &kinfo);
+			if (ret)
+				return ret;
+		}
+
+		/* Transfer reference of @f to caller's fdtable. */
+		fd_install(fd, no_free_ptr(f));
+		/* File descriptor is live so hand it off to the caller. */
+		return take_fd(fd);
 	}
 	default:
 		ret = -ENOTTY;
diff --git a/include/uapi/linux/nsfs.h b/include/uapi/linux/nsfs.h
index b133211331f6..bfb9666860a1 100644
--- a/include/uapi/linux/nsfs.h
+++ b/include/uapi/linux/nsfs.h
@@ -26,4 +26,19 @@
 /* Return thread-group leader id of pid in the target pid namespace. */
 #define NS_GET_TGID_IN_PIDNS	_IOR(NSIO, 0x9, int)
 
+struct mnt_ns_info {
+	__u32 size;
+	__u32 nr_mounts;
+	__u64 mnt_ns_id;
+};
+
+#define MNT_NS_INFO_SIZE_VER0 16 /* size of first published struct */
+
+/* Get information about namespace. */
+#define NS_MNT_GET_INFO		_IOR(NSIO, 10, struct mnt_ns_info)
+/* Get next namespace. */
+#define NS_MNT_GET_NEXT		_IOR(NSIO, 11, struct mnt_ns_info)
+/* Get previous namespace. */
+#define NS_MNT_GET_PREV		_IOR(NSIO, 12, struct mnt_ns_info)
+
 #endif /* __LINUX_NSFS_H */

-- 
2.43.0


