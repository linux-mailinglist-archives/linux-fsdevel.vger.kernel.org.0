Return-Path: <linux-fsdevel+bounces-64866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 29954BF6280
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 13:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A2F4C353CD1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 11:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC28B33B970;
	Tue, 21 Oct 2025 11:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVOEqrRb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFAD3321CA;
	Tue, 21 Oct 2025 11:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047110; cv=none; b=m/L3woVW+ZMc2QMb9auUdNZJ+AU1BcHa0wkNaaTX9W1ywbA80gOFPkG30687NdoQcR+ZH/9bepdeAX1uqB5uyn6vP6qDWEl01WjKerSOIRMJLK84lce6g1gTCUHoz/yX2+gWFw8l/7mNHJdPPWY4DvsXpDIPzjkMFBa4M52vsA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047110; c=relaxed/simple;
	bh=WzCNs8mY+FmpJ+YGymHPLKTZYpsE6yN0bYa2ba9zCgU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eT7+223pfeLuP52P7GBYQaCEmFiNrpGE09YyWApVuPYHNf9iTNLaK4ZBZxntLzhNefmutrR54Ot5H1S1ip7HXwVzWazziz1TzZF7UdJiF6V/CNGeQsNurW/LQ0XZDbJKsvVxuNG2MGZOjRhdXk9uXo2qVCkBSNXCbYsWVGoaEfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVOEqrRb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B086FC4CEF1;
	Tue, 21 Oct 2025 11:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761047109;
	bh=WzCNs8mY+FmpJ+YGymHPLKTZYpsE6yN0bYa2ba9zCgU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iVOEqrRbKsqhKVeOK+TrO3d+tGdKqHMWNXcxDjCgdaUbrq9tlFiY7LOQB0FD4EMAV
	 lJd0Hu8olltIgL0CQVxQSVbhxGecw+4MjoPY/q0ozj73uFjWcqLWeXWlVmeUyK7vD9
	 MA22cyZFx4FGK1kXBAabvMLr9R+N+KdGpiDU/5fD3E3UglSX45U2mEoywZbiCldtcm
	 ReFlGDpHCItcEo+Q85ABn3S2IHGuBhaw+NcOae+XFSs+qrTNNN/5orasnWFjVsu8N/
	 ot5N8IU5fl88H6X4HGafoO/nEYXh6I2of+n1UC/C1vqunQr6F2cwHMHOtLjImjuTU7
	 xdGCleMtoyTiQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 21 Oct 2025 13:43:21 +0200
Subject: [PATCH RFC DRAFT 15/50] nstree: add listns()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-work-namespace-nstree-listns-v1-15-ad44261a8a5b@kernel.org>
References: <20251021-work-namespace-nstree-listns-v1-0-ad44261a8a5b@kernel.org>
In-Reply-To: <20251021-work-namespace-nstree-listns-v1-0-ad44261a8a5b@kernel.org>
To: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>
Cc: Jann Horn <jannh@google.com>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Amir Goldstein <amir73il@gmail.com>, Tejun Heo <tj@kernel.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, bpf@vger.kernel.org, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=30001; i=brauner@kernel.org;
 h=from:subject:message-id; bh=WzCNs8mY+FmpJ+YGymHPLKTZYpsE6yN0bYa2ba9zCgU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR8L3xbYPd6VYFfU9r93lMpql/0Dn39NzM97kt6ydZLO
 +JXTuhP7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIPiPDbxYVT0f1zGomhxqe
 6P89WQpH9A6/YJwcKWC0z4xHWGvvLYZ/ljoF0srLbrnpR5lE2eVdPhHB8LWOu+fmb+N3Gx3ufAh
 mBQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a new listns() system call that allows userspace to iterate through
namespaces in the system. This provides a programmatic interface to
discover and inspect namespaces, enhancing existing namespace apis.

Currently, there is no direct way for userspace to enumerate namespaces
in the system. Applications must resort to scanning /proc/<pid>/ns/
across all processes, which is:

1. Inefficient - requires iterating over all processes
2. Incomplete - misses inactive namespaces that aren't attached to any
   running process but are kept alive by file descriptors, bind mounts,
   or parent namespace references
3. Permission-heavy - requires access to /proc for many processes
4. No ordering or ownership.
5. No filtering per namespace type: Must always iterate and check all
   namespaces.

The list goes on. The listns() system call solves these problems by
providing direct kernel-level enumeration of namespaces. It is similar
to listmount() but obviously tailored to namespaces.

/*
 * @req: Pointer to struct ns_id_req specifying search parameters
 * @ns_ids: User buffer to receive namespace IDs
 * @nr_ns_ids: Size of ns_ids buffer (maximum number of IDs to return)
 * @flags: Reserved for future use (must be 0)
 */
ssize_t listns(const struct ns_id_req *req, u64 *ns_ids,
               size_t nr_ns_ids, unsigned int flags);

Returns:
- On success: Number of namespace IDs written to ns_ids
- On error: Negative error code

/*
 * @size: Structure size
 * @ns_id: Starting point for iteration; use 0 for first call, then
 *         use the last returned ID for subsequent calls to paginate
 * @ns_type: Bitmask of namespace types to include (from enum ns_type):
 *           0: Return all namespace types
 *           MNT_NS: Mount namespaces
 *           NET_NS: Network namespaces
 *           USER_NS: User namespaces
 *           etc. Can be OR'd together
 * @user_ns_id: Filter results to namespaces owned by this user namespace:
 *              0: Return all namespaces (subject to permission checks)
 *              LISTNS_CURRENT_USER: Namespaces owned by caller's user namespace
 *              Other value: Namespaces owned by the specified user namespace ID
 */
struct ns_id_req {
        __u32 size;         /* sizeof(struct ns_id_req) */
        __u32 spare;        /* Reserved, must be 0 */
        __u64 ns_id;        /* Last seen namespace ID (for pagination) */
        __u32 ns_type;      /* Filter by namespace type(s) */
        __u32 spare2;       /* Reserved, must be 0 */
        __u64 user_ns_id;   /* Filter by owning user namespace */
};

Example 1: List all namespaces

void list_all_namespaces(void)
{
    struct ns_id_req req = {
        .size = sizeof(req),
        .ns_id = 0,          /* Start from beginning */
        .ns_type = 0,        /* All types */
        .user_ns_id = 0,     /* All user namespaces */
    };
    uint64_t ids[100];
    ssize_t ret;

    printf("All namespaces in the system:\n");
    do {
        ret = listns(&req, ids, 100, 0);
        if (ret < 0) {
            perror("listns");
            break;
        }

        for (ssize_t i = 0; i < ret; i++)
            printf("  Namespace ID: %llu\n", (unsigned long long)ids[i]);

        /* Continue from last seen ID */
        if (ret > 0)
            req.ns_id = ids[ret - 1];
    } while (ret == 100);  /* Buffer was full, more may exist */
}

Example 2: List network namespaces only

void list_network_namespaces(void)
{
    struct ns_id_req req = {
        .size = sizeof(req),
        .ns_id = 0,
        .ns_type = NET_NS,   /* Only network namespaces */
        .user_ns_id = 0,
    };
    uint64_t ids[100];
    ssize_t ret;

    ret = listns(&req, ids, 100, 0);
    if (ret < 0) {
        perror("listns");
        return;
    }

    printf("Network namespaces: %zd found\n", ret);
    for (ssize_t i = 0; i < ret; i++)
        printf("  netns ID: %llu\n", (unsigned long long)ids[i]);
}

Example 3: List namespaces owned by current user namespace

void list_owned_namespaces(void)
{
    struct ns_id_req req = {
        .size = sizeof(req),
        .ns_id = 0,
        .ns_type = 0,                      /* All types */
        .user_ns_id = LISTNS_CURRENT_USER, /* Current userns */
    };
    uint64_t ids[100];
    ssize_t ret;

    ret = listns(&req, ids, 100, 0);
    if (ret < 0) {
        perror("listns");
        return;
    }

    printf("Namespaces owned by my user namespace: %zd\n", ret);
    for (ssize_t i = 0; i < ret; i++)
        printf("  ns ID: %llu\n", (unsigned long long)ids[i]);
}

Example 4: List multiple namespace types

void list_network_and_mount_namespaces(void)
{
    struct ns_id_req req = {
        .size = sizeof(req),
        .ns_id = 0,
        .ns_type = NET_NS | MNT_NS,  /* Network and mount */
        .user_ns_id = 0,
    };
    uint64_t ids[100];
    ssize_t ret;

    ret = listns(&req, ids, 100, 0);
    printf("Network and mount namespaces: %zd found\n", ret);
}

Example 5: Pagination through large namespace sets

void list_all_with_pagination(void)
{
    struct ns_id_req req = {
        .size = sizeof(req),
        .ns_id = 0,
        .ns_type = 0,
        .user_ns_id = 0,
    };
    uint64_t ids[50];
    size_t total = 0;
    ssize_t ret;

    printf("Enumerating all namespaces with pagination:\n");

    while (1) {
        ret = listns(&req, ids, 50, 0);
        if (ret < 0) {
            perror("listns");
            break;
        }
        if (ret == 0)
            break;  /* No more namespaces */

        total += ret;
        printf("  Batch: %zd namespaces\n", ret);

        /* Last ID in this batch becomes start of next batch */
        req.ns_id = ids[ret - 1];

        if (ret < 50)
            break;  /* Partial batch = end of results */
    }

    printf("Total: %zu namespaces\n", total);
}

Permission Model

listns() respects namespace isolation and capabilities:

(1) Global listing (user_ns_id = 0):
    - Requires CAP_SYS_ADMIN in the namespace's owning user namespace
    - OR the namespace must be in the caller's namespace context (e.g.,
      a namespace the caller is currently using)
    - User namespaces additionally allow listing if the caller has
      CAP_SYS_ADMIN in that user namespace itself
(2) Owner-filtered listing (user_ns_id != 0):
    - Requires CAP_SYS_ADMIN in the specified owner user namespace
    - OR the namespace must be in the caller's namespace context
    - This allows unprivileged processes to enumerate namespaces they own
(3) Visibility:
    - Only "active" namespaces are listed
    - A namespace is active if it has a non-zero __ns_ref_active count
    - This includes namespaces used by running processes, held by open
      file descriptors, or kept active by bind mounts
    - Inactive namespaces (kept alive only by internal kernel
      references) are not visible via listns()

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c            |   1 +
 fs/nsfs.c                 |  39 +++++
 include/linux/ns_common.h |   5 +-
 include/linux/syscalls.h  |   4 +
 include/uapi/linux/nsfs.h |  44 +++++
 init/version-timestamp.c  |   1 +
 ipc/msgutil.c             |   1 +
 kernel/cgroup/cgroup.c    |   1 +
 kernel/nscommon.c         |   3 +
 kernel/nstree.c           | 404 +++++++++++++++++++++++++++++++++++++++++++++-
 kernel/pid.c              |   1 +
 kernel/time/namespace.c   |   1 +
 kernel/user.c             |   1 +
 13 files changed, 501 insertions(+), 5 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index d460ca79f0e7..980296b0ec86 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5996,6 +5996,7 @@ struct mnt_namespace init_mnt_ns = {
 	.mounts		= RB_ROOT,
 	.poll		= __WAIT_QUEUE_HEAD_INITIALIZER(init_mnt_ns.poll),
 	.ns.ns_list_node = LIST_HEAD_INIT(init_mnt_ns.ns.ns_list_node),
+	.ns.ns_unified_list_node = LIST_HEAD_INIT(init_mnt_ns.ns.ns_unified_list_node),
 	.ns.ns_owner_entry = LIST_HEAD_INIT(init_mnt_ns.ns.ns_owner_entry),
 	.ns.ns_owner = LIST_HEAD_INIT(init_mnt_ns.ns.ns_owner),
 };
diff --git a/fs/nsfs.c b/fs/nsfs.c
index ba5863ee4150..629139a25d65 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -465,6 +465,45 @@ static int nsfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
 	return FILEID_NSFS;
 }
 
+bool is_current_namespace(struct ns_common *ns)
+{
+	switch (ns->ns_type) {
+#ifdef CONFIG_CGROUPS
+	case CLONE_NEWCGROUP:
+		return current_in_namespace(to_cg_ns(ns));
+#endif
+#ifdef CONFIG_IPC_NS
+	case CLONE_NEWIPC:
+		return current_in_namespace(to_ipc_ns(ns));
+#endif
+	case CLONE_NEWNS:
+		return current_in_namespace(to_mnt_ns(ns));
+#ifdef CONFIG_NET_NS
+	case CLONE_NEWNET:
+		return current_in_namespace(to_net_ns(ns));
+#endif
+#ifdef CONFIG_PID_NS
+	case CLONE_NEWPID:
+		return current_in_namespace(to_pid_ns(ns));
+#endif
+#ifdef CONFIG_TIME_NS
+	case CLONE_NEWTIME:
+		return current_in_namespace(to_time_ns(ns));
+#endif
+#ifdef CONFIG_USER_NS
+	case CLONE_NEWUSER:
+		return current_in_namespace(to_user_ns(ns));
+#endif
+#ifdef CONFIG_UTS_NS
+	case CLONE_NEWUTS:
+		return current_in_namespace(to_uts_ns(ns));
+#endif
+	default:
+		VFS_WARN_ON_ONCE(true);
+		return false;
+	}
+}
+
 static struct dentry *nsfs_fh_to_dentry(struct super_block *sb, struct fid *fh,
 					int fh_len, int fh_type)
 {
diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index 1afeaa93d319..151d9e594500 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -123,8 +123,10 @@ struct ns_common {
 				struct rb_node ns_tree_node;
 				struct list_head ns_list_node;
 			};
-			struct /* namespace ownership list */ {
+			struct /* namespace ownership rbtree and list */ {
+				struct rb_root ns_owner_tree; /* rbtree of namespaces owned by this namespace */
 				struct list_head ns_owner; /* list of namespaces owned by this namespace */
+				struct rb_node ns_owner_tree_node; /* node in the owner namespace's rbtree */
 				struct list_head ns_owner_entry; /* node in the owner namespace's ns_owned list */
 			};
 			atomic_t __ns_ref_active; /* do not use directly */
@@ -133,6 +135,7 @@ struct ns_common {
 	};
 };
 
+bool is_current_namespace(struct ns_common *ns);
 int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_operations *ops, int inum);
 void __ns_common_free(struct ns_common *ns);
 
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 66c06fcdfe19..cf84d98964b2 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -77,6 +77,7 @@ struct cachestat_range;
 struct cachestat;
 struct statmount;
 struct mnt_id_req;
+struct ns_id_req;
 struct xattr_args;
 struct file_attr;
 
@@ -437,6 +438,9 @@ asmlinkage long sys_statmount(const struct mnt_id_req __user *req,
 asmlinkage long sys_listmount(const struct mnt_id_req __user *req,
 			      u64 __user *mnt_ids, size_t nr_mnt_ids,
 			      unsigned int flags);
+asmlinkage long sys_listns(const struct ns_id_req __user *req,
+			   u64 __user *ns_ids, size_t nr_ns_ids,
+			   unsigned int flags);
 asmlinkage long sys_truncate(const char __user *path, long length);
 asmlinkage long sys_ftruncate(unsigned int fd, off_t length);
 #if BITS_PER_LONG == 32
diff --git a/include/uapi/linux/nsfs.h b/include/uapi/linux/nsfs.h
index f8bc2aad74d6..a25e38d1c874 100644
--- a/include/uapi/linux/nsfs.h
+++ b/include/uapi/linux/nsfs.h
@@ -81,4 +81,48 @@ enum init_ns_id {
 #endif
 };
 
+enum ns_type {
+	TIME_NS    = (1ULL << 7),  /* CLONE_NEWTIME */
+	MNT_NS     = (1ULL << 17), /* CLONE_NEWNS */
+	CGROUP_NS  = (1ULL << 25), /* CLONE_NEWCGROUP */
+	UTS_NS     = (1ULL << 26), /* CLONE_NEWUTS */
+	IPC_NS     = (1ULL << 27), /* CLONE_NEWIPC */
+	USER_NS    = (1ULL << 28), /* CLONE_NEWUSER */
+	PID_NS     = (1ULL << 29), /* CLONE_NEWPID */
+	NET_NS     = (1ULL << 30), /* CLONE_NEWNET */
+};
+
+/**
+ * struct ns_id_req - namespace ID request structure
+ * @size: size of this structure
+ * @spare: reserved for future use
+ * @filter: filter mask
+ * @ns_id: last namespace id
+ * @user_ns_id: owning user namespace ID
+ *
+ * Structure for passing namespace ID and miscellaneous parameters to
+ * statns(2) and listns(2).
+ *
+ * For statns(2) @param represents the request mask.
+ * For listns(2) @param represents the last listed mount id (or zero).
+ */
+struct ns_id_req {
+	__u32 size;
+	__u32 spare;
+	__u64 ns_id;
+	struct /* listns */ {
+		__u32 ns_type;
+		__u32 spare2;
+		__u64 user_ns_id;
+	};
+};
+
+/*
+ * Special @user_ns_id value that can be passed to listns()
+ */
+#define LISTNS_CURRENT_USER 0xffffffffffffffff /* Caller's userns */
+
+/* List of all ns_id_req versions. */
+#define NS_ID_REQ_SIZE_VER0 32 /* sizeof first published struct */
+
 #endif /* __LINUX_NSFS_H */
diff --git a/init/version-timestamp.c b/init/version-timestamp.c
index e5c278dabecf..cd6f435d5fde 100644
--- a/init/version-timestamp.c
+++ b/init/version-timestamp.c
@@ -22,6 +22,7 @@ struct uts_namespace init_uts_ns = {
 	.user_ns = &init_user_ns,
 	.ns.inum = ns_init_inum(&init_uts_ns),
 	.ns.ns_list_node = LIST_HEAD_INIT(init_uts_ns.ns.ns_list_node),
+	.ns.ns_unified_list_node = LIST_HEAD_INIT(init_uts_ns.ns.ns_unified_list_node),
 	.ns.ns_owner_entry = LIST_HEAD_INIT(init_uts_ns.ns.ns_owner_entry),
 	.ns.ns_owner = LIST_HEAD_INIT(init_uts_ns.ns.ns_owner),
 #ifdef CONFIG_UTS_NS
diff --git a/ipc/msgutil.c b/ipc/msgutil.c
index ce1de73725c0..3708f325228d 100644
--- a/ipc/msgutil.c
+++ b/ipc/msgutil.c
@@ -32,6 +32,7 @@ struct ipc_namespace init_ipc_ns = {
 	.user_ns = &init_user_ns,
 	.ns.inum = ns_init_inum(&init_ipc_ns),
 	.ns.ns_list_node = LIST_HEAD_INIT(init_ipc_ns.ns.ns_list_node),
+	.ns.ns_unified_list_node = LIST_HEAD_INIT(init_ipc_ns.ns.ns_unified_list_node),
 	.ns.ns_owner_entry = LIST_HEAD_INIT(init_ipc_ns.ns.ns_owner_entry),
 	.ns.ns_owner = LIST_HEAD_INIT(init_ipc_ns.ns.ns_owner),
 #ifdef CONFIG_IPC_NS
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 41a1fc562ed0..9ab0e7d7b54d 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -258,6 +258,7 @@ struct cgroup_namespace init_cgroup_ns = {
 	.root_cset	= &init_css_set,
 	.ns.ns_type	= ns_common_type(&init_cgroup_ns),
 	.ns.ns_list_node = LIST_HEAD_INIT(init_cgroup_ns.ns.ns_list_node),
+	.ns.ns_unified_list_node = LIST_HEAD_INIT(init_cgroup_ns.ns.ns_unified_list_node),
 	.ns.ns_owner_entry = LIST_HEAD_INIT(init_cgroup_ns.ns.ns_owner_entry),
 	.ns.ns_owner = LIST_HEAD_INIT(init_cgroup_ns.ns.ns_owner),
 };
diff --git a/kernel/nscommon.c b/kernel/nscommon.c
index 0ef2939daf33..bf9a30fa82d6 100644
--- a/kernel/nscommon.c
+++ b/kernel/nscommon.c
@@ -62,7 +62,10 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
 	ns->ns_type = ns_type;
 	RB_CLEAR_NODE(&ns->ns_tree_node);
 	RB_CLEAR_NODE(&ns->ns_unified_tree_node);
+	RB_CLEAR_NODE(&ns->ns_owner_tree_node);
 	INIT_LIST_HEAD(&ns->ns_list_node);
+	INIT_LIST_HEAD(&ns->ns_unified_list_node);
+	ns->ns_owner_tree = RB_ROOT;
 	INIT_LIST_HEAD(&ns->ns_owner);
 	INIT_LIST_HEAD(&ns->ns_owner_entry);
 
diff --git a/kernel/nstree.c b/kernel/nstree.c
index 829682bb04a1..62d7571aced4 100644
--- a/kernel/nstree.c
+++ b/kernel/nstree.c
@@ -2,11 +2,14 @@
 
 #include <linux/nstree.h>
 #include <linux/proc_ns.h>
+#include <linux/rculist.h>
+#include <linux/syscalls.h>
 #include <linux/vfsdebug.h>
 #include <linux/user_namespace.h>
 
 __cacheline_aligned_in_smp DEFINE_SEQLOCK(ns_tree_lock);
 static struct rb_root ns_unified_tree = RB_ROOT; /* protected by ns_tree_lock */
+static LIST_HEAD(ns_unified_list); /* protected by ns_tree_lock */
 
 /**
  * struct ns_tree - Namespace tree
@@ -83,6 +86,13 @@ static inline struct ns_common *node_to_ns_unified(const struct rb_node *node)
 	return rb_entry(node, struct ns_common, ns_unified_tree_node);
 }
 
+static inline struct ns_common *node_to_ns_owner(const struct rb_node *node)
+{
+	if (!node)
+		return NULL;
+	return rb_entry(node, struct ns_common, ns_owner_tree_node);
+}
+
 static inline int ns_cmp(struct rb_node *a, const struct rb_node *b)
 {
 	struct ns_common *ns_a = node_to_ns(a);
@@ -111,6 +121,20 @@ static inline int ns_cmp_unified(struct rb_node *a, const struct rb_node *b)
 	return 0;
 }
 
+static inline int ns_cmp_owner(struct rb_node *a, const struct rb_node *b)
+{
+	struct ns_common *ns_a = node_to_ns_owner(a);
+	struct ns_common *ns_b = node_to_ns_owner(b);
+	u64 ns_id_a = ns_a->ns_id;
+	u64 ns_id_b = ns_b->ns_id;
+
+	if (ns_id_a < ns_id_b)
+		return -1;
+	if (ns_id_a > ns_id_b)
+		return 1;
+	return 0;
+}
+
 void __ns_tree_add_raw(struct ns_common *ns, struct ns_tree *ns_tree)
 {
 	struct rb_node *node, *prev;
@@ -134,7 +158,13 @@ void __ns_tree_add_raw(struct ns_common *ns, struct ns_tree *ns_tree)
 	else
 		list_add_rcu(&ns->ns_list_node, &node_to_ns(prev)->ns_list_node);
 
+	/* Add to unified tree and list */
 	rb_find_add_rcu(&ns->ns_unified_tree_node, &ns_unified_tree, ns_cmp_unified);
+	prev = rb_prev(&ns->ns_unified_tree_node);
+	if (!prev)
+		list_add_rcu(&ns->ns_unified_list_node, &ns_unified_list);
+	else
+		list_add_rcu(&ns->ns_unified_list_node, &node_to_ns_unified(prev)->ns_unified_list_node);
 
 	if (ops) {
 		struct user_namespace *user_ns;
@@ -144,7 +174,16 @@ void __ns_tree_add_raw(struct ns_common *ns, struct ns_tree *ns_tree)
 		if (user_ns) {
 			struct ns_common *owner = &user_ns->ns;
 			VFS_WARN_ON_ONCE(owner->ns_type != CLONE_NEWUSER);
-			list_add_tail_rcu(&ns->ns_owner_entry, &owner->ns_owner);
+
+			/* Insert into owner's rbtree */
+			rb_find_add_rcu(&ns->ns_owner_tree_node, &owner->ns_owner_tree, ns_cmp_owner);
+
+			/* Insert into owner's list in sorted order */
+			prev = rb_prev(&ns->ns_owner_tree_node);
+			if (!prev)
+				list_add_rcu(&ns->ns_owner_entry, &owner->ns_owner);
+			else
+				list_add_rcu(&ns->ns_owner_entry, &node_to_ns_owner(prev)->ns_owner_entry);
 		} else {
 			/* Only the initial user namespace doesn't have an owner. */
 			VFS_WARN_ON_ONCE(ns != to_ns_common(&init_user_ns));
@@ -157,16 +196,36 @@ void __ns_tree_add_raw(struct ns_common *ns, struct ns_tree *ns_tree)
 
 void __ns_tree_remove(struct ns_common *ns, struct ns_tree *ns_tree)
 {
+	const struct proc_ns_operations *ops = ns->ops;
+	struct user_namespace *user_ns;
+
 	VFS_WARN_ON_ONCE(RB_EMPTY_NODE(&ns->ns_tree_node));
 	VFS_WARN_ON_ONCE(list_empty(&ns->ns_list_node));
 	VFS_WARN_ON_ONCE(ns->ns_type != ns_tree->type);
 
 	write_seqlock(&ns_tree_lock);
 	rb_erase(&ns->ns_tree_node, &ns_tree->ns_tree);
-	rb_erase(&ns->ns_unified_tree_node, &ns_unified_tree);
-	list_bidir_del_rcu(&ns->ns_list_node);
 	RB_CLEAR_NODE(&ns->ns_tree_node);
-	list_bidir_del_rcu(&ns->ns_owner_entry);
+
+	list_bidir_del_rcu(&ns->ns_list_node);
+
+	rb_erase(&ns->ns_unified_tree_node, &ns_unified_tree);
+	RB_CLEAR_NODE(&ns->ns_unified_tree_node);
+
+	list_bidir_del_rcu(&ns->ns_unified_list_node);
+
+	/* Remove from owner's rbtree if this namespace has an owner */
+	if (ops) {
+		user_ns = ops->owner(ns);
+		if (user_ns) {
+			struct ns_common *owner = &user_ns->ns;
+			rb_erase(&ns->ns_owner_tree_node, &owner->ns_owner_tree);
+			RB_CLEAR_NODE(&ns->ns_owner_tree_node);
+		}
+
+		list_bidir_del_rcu(&ns->ns_owner_entry);
+	}
+
 	write_sequnlock(&ns_tree_lock);
 }
 EXPORT_SYMBOL_GPL(__ns_tree_remove);
@@ -312,3 +371,340 @@ u64 __ns_tree_gen_id(struct ns_common *ns, u64 id)
 		ns->ns_id = atomic64_inc_return(&namespace_cookie);
 	return ns->ns_id;
 }
+
+struct klistns {
+	u64 *kns_ids;
+	u32 nr_ns_ids;
+	u64 last_ns_id;
+	u64 user_ns_id;
+	u32 ns_type;
+	struct user_namespace *user_ns;
+	struct ns_common *first_ns;
+};
+
+static void __free_klistns_free(const struct klistns *kls)
+{
+	if (kls->user_ns_id != LISTNS_CURRENT_USER)
+		put_user_ns(kls->user_ns);
+	if (kls->first_ns)
+		kls->first_ns->ops->put(kls->first_ns);
+	kvfree(kls->kns_ids);
+}
+
+#define NS_ALL (PID_NS | USER_NS | MNT_NS | UTS_NS | IPC_NS | NET_NS | CGROUP_NS | TIME_NS)
+
+static int copy_ns_id_req(const struct ns_id_req __user *req,
+			  struct ns_id_req *kreq)
+{
+	int ret;
+	size_t usize;
+
+	BUILD_BUG_ON(sizeof(struct ns_id_req) != NS_ID_REQ_SIZE_VER0);
+
+	ret = get_user(usize, &req->size);
+	if (ret)
+		return -EFAULT;
+	if (unlikely(usize > PAGE_SIZE))
+		return -E2BIG;
+	if (unlikely(usize < NS_ID_REQ_SIZE_VER0))
+		return -EINVAL;
+	memset(kreq, 0, sizeof(*kreq));
+	ret = copy_struct_from_user(kreq, sizeof(*kreq), req, usize);
+	if (ret)
+		return ret;
+	if (kreq->spare != 0)
+		return -EINVAL;
+	if (kreq->ns_type & ~NS_ALL)
+		return -EOPNOTSUPP;
+	return 0;
+}
+
+static inline int prepare_klistns(struct klistns *kls, struct ns_id_req *kreq,
+				  size_t nr_ns_ids)
+{
+	kls->last_ns_id = kreq->ns_id;
+	kls->user_ns_id = kreq->user_ns_id;
+	kls->nr_ns_ids = nr_ns_ids;
+	kls->ns_type = kreq->ns_type;
+
+	kls->kns_ids = kvmalloc_array(nr_ns_ids, sizeof(*kls->kns_ids),
+				      GFP_KERNEL_ACCOUNT);
+	if (!kls->kns_ids)
+		return -ENOMEM;
+
+	return 0;
+}
+
+/*
+ * Lookup a namespace owned by owner with id >= ns_id.
+ * Returns the namespace with the smallest id that is >= ns_id.
+ */
+static struct ns_common *lookup_ns_owner_at(u64 ns_id, struct ns_common *owner)
+{
+	struct ns_common *ret = NULL;
+	struct rb_node *node;
+
+	VFS_WARN_ON_ONCE(owner->ns_type != CLONE_NEWUSER);
+
+	read_seqlock_excl(&ns_tree_lock);
+	node = owner->ns_owner_tree.rb_node;
+
+	while (node) {
+		struct ns_common *ns = node_to_ns_owner(node);
+
+		if (ns_id <= ns->ns_id) {
+			ret = ns;
+			if (ns_id == ns->ns_id)
+				break;
+			node = node->rb_left;
+		} else {
+			node = node->rb_right;
+		}
+	}
+
+	if (ret && !ns_get(ret))
+		ret = NULL;
+	read_sequnlock_excl(&ns_tree_lock);
+	return ret;
+}
+
+static struct ns_common *lookup_ns_id(u64 mnt_ns_id, int ns_type)
+{
+	struct ns_common *ns;
+
+	guard(rcu)();
+	ns = ns_tree_lookup_rcu(mnt_ns_id, ns_type);
+	if (!ns)
+		return NULL;
+
+	if (!ns_get(ns))
+		return NULL;
+
+	return ns;
+}
+
+static ssize_t do_listns_userns(struct klistns *kls)
+{
+	u64 *ns_ids = kls->kns_ids;
+	size_t nr_ns_ids = kls->nr_ns_ids;
+	struct ns_common *ns, *first_ns = NULL;
+	const struct list_head *head;
+	bool userns_capable;
+	ssize_t ret;
+
+	VFS_WARN_ON_ONCE(!kls->user_ns_id);
+
+	if (kls->user_ns_id == LISTNS_CURRENT_USER)
+		ns = to_ns_common(current_user_ns());
+	else if (kls->user_ns_id)
+		ns = lookup_ns_id(kls->user_ns_id, CLONE_NEWUSER);
+	if (!ns)
+		return -EINVAL;
+	kls->user_ns = to_user_ns(ns);
+
+	/*
+	 * Use the rbtree to find the first namespace we care about and
+	 * then use it's list entry to iterate from there.
+	 */
+	if (kls->last_ns_id) {
+		kls->first_ns = lookup_ns_owner_at(kls->last_ns_id + 1, ns);
+		if (!kls->first_ns)
+			return -ENOENT;
+		first_ns = kls->first_ns;
+	}
+
+	ret = 0;
+	head = &to_ns_common(kls->user_ns)->ns_owner;
+	userns_capable = ns_capable_noaudit(kls->user_ns, CAP_SYS_ADMIN);
+	guard(rcu)();
+	if (!first_ns)
+		first_ns = list_entry_rcu(head->next, typeof(*ns), ns_owner_entry);
+	for (ns = first_ns; &ns->ns_owner_entry != head && nr_ns_ids;
+	     ns = list_entry_rcu(ns->ns_owner_entry.next, typeof(*ns), ns_owner_entry)) {
+		if (kls->ns_type && !(kls->ns_type & ns->ns_type))
+			continue;
+		if (!__ns_ref_active_read(ns))
+			continue;
+		if (!userns_capable && !is_current_namespace(ns) &&
+		    ((ns->ns_type != CLONE_NEWUSER) ||
+		     !ns_capable_noaudit(to_user_ns(ns), CAP_SYS_ADMIN)))
+			continue;
+		*ns_ids = ns->ns_id;
+		ns_ids++;
+		nr_ns_ids--;
+		ret++;
+	}
+
+	return ret;
+}
+
+/*
+ * Lookup a namespace with id >= ns_id in either the unified tree or a type-specific tree.
+ * Returns the namespace with the smallest id that is >= ns_id.
+ */
+static struct ns_common *lookup_ns_id_at(u64 ns_id, int ns_type)
+{
+	struct ns_common *ret = NULL;
+	struct ns_tree *ns_tree = NULL;
+	struct rb_node *node;
+
+	if (ns_type) {
+		ns_tree = ns_tree_from_type(ns_type);
+		if (!ns_tree)
+			return NULL;
+	}
+
+	read_seqlock_excl(&ns_tree_lock);
+	if (ns_tree)
+		node = ns_tree->ns_tree.rb_node;
+	else
+		node = ns_unified_tree.rb_node;
+
+	while (node) {
+		struct ns_common *ns;
+
+		if (ns_type)
+			ns = node_to_ns(node);
+		else
+			ns = node_to_ns_unified(node);
+
+		if (ns_id <= ns->ns_id) {
+			if (ns_type)
+				ret = node_to_ns(node);
+			else
+				ret = node_to_ns_unified(node);
+			if (ns_id == ns->ns_id)
+				break;
+			node = node->rb_left;
+		} else {
+			node = node->rb_right;
+		}
+	}
+
+	if (ret && !ns_get(ret))
+		ret = NULL;
+	read_sequnlock_excl(&ns_tree_lock);
+	return ret;
+}
+
+static inline struct ns_common *first_ns_common(const struct list_head *head,
+						struct ns_tree *ns_tree)
+{
+	if (ns_tree)
+		return list_entry_rcu(head->next, struct ns_common, ns_list_node);
+	return list_entry_rcu(head->next, struct ns_common, ns_unified_list_node);
+}
+
+static inline struct ns_common *next_ns_common(struct ns_common *ns,
+					       struct ns_tree *ns_tree)
+{
+	if (ns_tree)
+		return list_entry_rcu(ns->ns_list_node.next, struct ns_common, ns_list_node);
+	return list_entry_rcu(ns->ns_unified_list_node.next, struct ns_common, ns_unified_list_node);
+}
+
+static inline bool ns_common_is_head(struct ns_common *ns,
+				     const struct list_head *head,
+				     struct ns_tree *ns_tree)
+{
+	if (ns_tree)
+		return &ns->ns_list_node == head;
+	return &ns->ns_unified_list_node == head;
+}
+
+static ssize_t do_listns(struct klistns *kls)
+{
+	u64 *ns_ids = kls->kns_ids;
+	size_t nr_ns_ids = kls->nr_ns_ids;
+	struct ns_common *ns, *first_ns = NULL;
+	struct ns_tree *ns_tree = NULL;
+	const struct list_head *head;
+	struct user_namespace *user_ns;
+	ssize_t ret;
+
+	if (hweight32(kls->ns_type) == 1) {
+		ns_tree = ns_tree_from_type(kls->ns_type);
+		if (!ns_tree)
+			return -EINVAL;
+	}
+
+	if (kls->last_ns_id) {
+		kls->first_ns = lookup_ns_id_at(kls->last_ns_id + 1, 0);
+		if (!kls->first_ns)
+			return -ENOENT;
+		first_ns = kls->first_ns;
+	}
+
+	ret = 0;
+	if (ns_tree)
+		head = &ns_tree->ns_list;
+	else
+		head = &ns_unified_list;
+
+	guard(rcu)();
+	if (!first_ns)
+		first_ns = first_ns_common(head, ns_tree);
+
+	for (ns = first_ns; !ns_common_is_head(ns, head, ns_tree) && nr_ns_ids;
+	     ns = next_ns_common(ns, ns_tree)) {
+		if (kls->ns_type && !(kls->ns_type & ns->ns_type))
+			continue;
+		if (!__ns_ref_active_read(ns))
+			continue;
+		/* Check permissions */
+		if (!ns->ops)
+			user_ns = NULL;
+		else
+			user_ns = ns->ops->owner(ns);
+		if (!user_ns)
+			user_ns = &init_user_ns;
+		if (!ns_capable_noaudit(user_ns, CAP_SYS_ADMIN) &&
+		    !is_current_namespace(ns) &&
+		    ((ns->ns_type != CLONE_NEWUSER) ||
+		     !ns_capable_noaudit(to_user_ns(ns), CAP_SYS_ADMIN)))
+			continue;
+		*ns_ids++ = ns->ns_id;
+		nr_ns_ids--;
+		ret++;
+	}
+
+	return ret;
+}
+
+SYSCALL_DEFINE4(listns, const struct ns_id_req __user *, req,
+		u64 __user *, ns_ids, size_t, nr_ns_ids, unsigned int, flags)
+{
+	struct klistns klns __free(klistns_free) = {};
+	const size_t maxcount = 1000000;
+	struct ns_id_req kreq;
+	ssize_t ret;
+
+	if (flags)
+		return -EINVAL;
+
+	if (unlikely(nr_ns_ids > maxcount))
+		return -EOVERFLOW;
+
+	if (!access_ok(ns_ids, nr_ns_ids * sizeof(*ns_ids)))
+		return -EFAULT;
+
+	ret = copy_ns_id_req(req, &kreq);
+	if (ret)
+		return ret;
+
+	ret = prepare_klistns(&klns, &kreq, nr_ns_ids);
+	if (ret)
+		return ret;
+
+	if (kreq.user_ns_id)
+		ret = do_listns_userns(&klns);
+	else
+		ret = do_listns(&klns);
+	if (ret <= 0)
+		return ret;
+
+	if (copy_to_user(ns_ids, klns.kns_ids, ret * sizeof(*ns_ids)))
+		return -EFAULT;
+
+	return ret;
+}
diff --git a/kernel/pid.c b/kernel/pid.c
index f82dab348540..a1bfb2924476 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -80,6 +80,7 @@ struct pid_namespace init_pid_ns = {
 	.user_ns = &init_user_ns,
 	.ns.inum = ns_init_inum(&init_pid_ns),
 	.ns.ns_list_node = LIST_HEAD_INIT(init_pid_ns.ns.ns_list_node),
+	.ns.ns_unified_list_node = LIST_HEAD_INIT(init_pid_ns.ns.ns_unified_list_node),
 	.ns.ns_owner_entry = LIST_HEAD_INIT(init_pid_ns.ns.ns_owner_entry),
 	.ns.ns_owner = LIST_HEAD_INIT(init_pid_ns.ns.ns_owner),
 #ifdef CONFIG_PID_NS
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index 15cb74267c75..acbeec049263 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -489,6 +489,7 @@ struct time_namespace init_time_ns = {
 	.ns.ns_owner = LIST_HEAD_INIT(init_time_ns.ns.ns_owner),
 	.frozen_offsets	= true,
 	.ns.ns_list_node = LIST_HEAD_INIT(init_time_ns.ns.ns_list_node),
+	.ns.ns_unified_list_node = LIST_HEAD_INIT(init_time_ns.ns.ns_unified_list_node),
 };
 
 void __init time_ns_init(void)
diff --git a/kernel/user.c b/kernel/user.c
index e392768ccd44..68fe16617d38 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -72,6 +72,7 @@ struct user_namespace init_user_ns = {
 	.group = GLOBAL_ROOT_GID,
 	.ns.inum = ns_init_inum(&init_user_ns),
 	.ns.ns_list_node = LIST_HEAD_INIT(init_user_ns.ns.ns_list_node),
+	.ns.ns_unified_list_node = LIST_HEAD_INIT(init_user_ns.ns.ns_unified_list_node),
 	.ns.ns_owner_entry = LIST_HEAD_INIT(init_user_ns.ns.ns_owner_entry),
 	.ns.ns_owner = LIST_HEAD_INIT(init_user_ns.ns.ns_owner),
 #ifdef CONFIG_USER_NS

-- 
2.47.3


