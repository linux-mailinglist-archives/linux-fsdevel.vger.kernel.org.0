Return-Path: <linux-fsdevel+bounces-66232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A3CC1A468
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44D65565ACE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0869A3570B3;
	Wed, 29 Oct 2025 12:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fc833d2r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DDE3563EC;
	Wed, 29 Oct 2025 12:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740536; cv=none; b=rIIDYYQ/rm0xecnY4CVf/fGl/ly1UGI4y7CHpMNe6EgJUxfak5399EIvzxj9SctHMLsokr6l5PmAEvMp/JR44K0IMuvxmUplKeqb87sNqgzuJ/KOCXNU3XLvmpM4DMPydrsdhKsnRyx8Mk68l9YB0V+QlKoLSbG/VjhotIDRQV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740536; c=relaxed/simple;
	bh=ShENnzkEMpgS41SvvSQFc4SbAPdiAki0NaMv4seIeIM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZhL7TZlafxufv+8/Cle1ha1BnVBPaN887IbaHd7KPlpeWiY70yTdwBq5bdoEDDYZDF1k+RS8cNZOfeOeXvyMx1z/1JGGUpMfCEFZrSUeAv0XRyrM6wj115l2n3oi5doYgWFVlEaMX4oTWrhh2FPNAyXERShrxttXVyViTjk1x/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fc833d2r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39915C4CEF7;
	Wed, 29 Oct 2025 12:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740534;
	bh=ShENnzkEMpgS41SvvSQFc4SbAPdiAki0NaMv4seIeIM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fc833d2rwZKAZd1ICQvKuIdX8ECt2e3RSaZ40EOQSe5aYQnWYhH8cLspIOmFRv3o7
	 mMLhfKTSdtwXLZAgMTZopmM9jFOMXOIGoJqCsZDKob3tj8YM91aAOQ7W2MUE0AXrMq
	 pxDQwCNxTvV12sukvdu+TuY55+78KB7fRfQH38HG4ttZZXN3oi56S8WlwNQnbePO+K
	 NDZm7c/D6YslgkYbSqIKOpW6ugqF8HFdqbPlr4BVEqJAW1r/d9fBuP2sYqZvpI1qbi
	 pM43GY4kIvY+PpzpeKvkhOWeJvdooXgL+cOhCYZMpHUqpBI1nvZUYkjJoYWlETCvvN
	 JZ3w/8jlo1img==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:20:32 +0100
Subject: [PATCH v4 19/72] nstree: add listns()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-19-2e6f823ebdc0@kernel.org>
References: <20251029-work-namespace-nstree-listns-v4-0-2e6f823ebdc0@kernel.org>
In-Reply-To: <20251029-work-namespace-nstree-listns-v4-0-2e6f823ebdc0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=22853; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ShENnzkEMpgS41SvvSQFc4SbAPdiAki0NaMv4seIeIM=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGkCBo2jCH02JzNF90Ly+nHjwrOGN2KymmLFwyvZiOxJ0DFjQ
 Yh1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmkCBo0ACgkQkcYbwGV43KI6QQD/bZ7G
 jZgQN7nsV71eQ7lIhP8LFpZgyTeRGKs2wN/X+WQA/1Mvj0ejM3CQVgsoxjjMHHzp6k8iJ86LPP4
 dCtCqaAAI
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
 fs/nsfs.c                      |  39 ++++
 include/linux/ns_common.h      |   2 +
 include/linux/syscalls.h       |   4 +
 include/linux/user_namespace.h |   4 +-
 include/uapi/linux/nsfs.h      |  44 +++++
 kernel/nscommon.c              |   2 +-
 kernel/nstree.c                | 397 +++++++++++++++++++++++++++++++++++++++++
 7 files changed, 489 insertions(+), 3 deletions(-)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 201d6de53353..49864c479e80 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -471,6 +471,45 @@ static int nsfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
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
index e4041603434e..241eb1e98e1d 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -129,8 +129,10 @@ struct ns_common {
 	};
 };
 
+bool is_current_namespace(struct ns_common *ns);
 int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_operations *ops, int inum);
 void __ns_common_free(struct ns_common *ns);
+struct ns_common *__must_check ns_owner(struct ns_common *ns);
 
 static __always_inline bool is_initial_namespace(struct ns_common *ns)
 {
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
diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 9a9aebbf96b9..9c3be157397e 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -166,13 +166,13 @@ static inline void set_userns_rlimit_max(struct user_namespace *ns,
 	ns->rlimit_max[type] = max <= LONG_MAX ? max : LONG_MAX;
 }
 
-#ifdef CONFIG_USER_NS
-
 static inline struct user_namespace *to_user_ns(struct ns_common *ns)
 {
 	return container_of(ns, struct user_namespace, ns);
 }
 
+#ifdef CONFIG_USER_NS
+
 static inline struct user_namespace *get_user_ns(struct user_namespace *ns)
 {
 	if (ns)
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
diff --git a/kernel/nscommon.c b/kernel/nscommon.c
index affaf91c2074..718429dfbf7e 100644
--- a/kernel/nscommon.c
+++ b/kernel/nscommon.c
@@ -97,7 +97,7 @@ void __ns_common_free(struct ns_common *ns)
 	proc_free_inum(ns->inum);
 }
 
-static struct ns_common *ns_owner(struct ns_common *ns)
+struct ns_common *__must_check ns_owner(struct ns_common *ns)
 {
 	struct user_namespace *owner;
 
diff --git a/kernel/nstree.c b/kernel/nstree.c
index 100145e5edd1..54e1a466f8fe 100644
--- a/kernel/nstree.c
+++ b/kernel/nstree.c
@@ -4,6 +4,7 @@
 #include <linux/proc_ns.h>
 #include <linux/rculist.h>
 #include <linux/vfsdebug.h>
+#include <linux/syscalls.h>
 #include <linux/user_namespace.h>
 
 __cacheline_aligned_in_smp DEFINE_SEQLOCK(ns_tree_lock);
@@ -376,3 +377,399 @@ u64 __ns_tree_gen_id(struct ns_common *ns, u64 id)
 		ns->ns_id = atomic64_inc_return(&namespace_cookie);
 	return ns->ns_id;
 }
+
+struct klistns {
+	u64 __user *uns_ids;
+	u32 nr_ns_ids;
+	u64 last_ns_id;
+	u64 user_ns_id;
+	u32 ns_type;
+	struct user_namespace *user_ns;
+	bool userns_capable;
+	struct ns_common *first_ns;
+};
+
+static void __free_klistns_free(const struct klistns *kls)
+{
+	if (kls->user_ns_id != LISTNS_CURRENT_USER)
+		put_user_ns(kls->user_ns);
+	if (kls->first_ns && kls->first_ns->ops)
+		kls->first_ns->ops->put(kls->first_ns);
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
+				  u64 __user *ns_ids, size_t nr_ns_ids)
+{
+	kls->last_ns_id = kreq->ns_id;
+	kls->user_ns_id = kreq->user_ns_id;
+	kls->nr_ns_ids	= nr_ns_ids;
+	kls->ns_type	= kreq->ns_type;
+	kls->uns_ids	= ns_ids;
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
+		struct ns_common *ns;
+
+		ns = node_to_ns_owner(node);
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
+	if (ret)
+		ret = ns_get_unless_inactive(ret);
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
+	if (!ns_get_unless_inactive(ns))
+		return NULL;
+
+	return ns;
+}
+
+static inline bool __must_check ns_requested(const struct klistns *kls,
+					     const struct ns_common *ns)
+{
+	return !kls->ns_type || (kls->ns_type & ns->ns_type);
+}
+
+static inline bool __must_check may_list_ns(const struct klistns *kls,
+					    struct ns_common *ns)
+{
+	if (kls->user_ns) {
+		if (kls->userns_capable)
+			return true;
+	} else {
+		struct ns_common *owner;
+		struct user_namespace *user_ns;
+
+		owner = ns_owner(ns);
+		if (owner)
+			user_ns = to_user_ns(owner);
+		else
+			user_ns = &init_user_ns;
+		if (ns_capable_noaudit(user_ns, CAP_SYS_ADMIN))
+			return true;
+	}
+
+	if (is_current_namespace(ns))
+		return true;
+
+	if (ns->ns_type != CLONE_NEWUSER)
+		return false;
+
+	if (ns_capable_noaudit(to_user_ns(ns), CAP_SYS_ADMIN))
+		return true;
+
+	return false;
+}
+
+static void __ns_put(struct ns_common *ns)
+{
+	if (ns->ops)
+		ns->ops->put(ns);
+}
+
+DEFINE_FREE(ns_put, struct ns_common *, if (!IS_ERR_OR_NULL(_T)) __ns_put(_T))
+
+static inline struct ns_common *__must_check legitimize_ns(const struct klistns *kls,
+							   struct ns_common *candidate)
+{
+	struct ns_common *ns __free(ns_put) = NULL;
+
+	if (!ns_requested(kls, candidate))
+		return NULL;
+
+	ns = ns_get_unless_inactive(candidate);
+	if (!ns)
+		return NULL;
+
+	if (!may_list_ns(kls, ns))
+		return NULL;
+
+	return no_free_ptr(ns);
+}
+
+static ssize_t do_listns_userns(struct klistns *kls)
+{
+	u64 __user *ns_ids = kls->uns_ids;
+	size_t nr_ns_ids = kls->nr_ns_ids;
+	struct ns_common *ns = NULL, *first_ns = NULL;
+	const struct list_head *head;
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
+	kls->userns_capable = ns_capable_noaudit(kls->user_ns, CAP_SYS_ADMIN);
+
+	rcu_read_lock();
+
+	if (!first_ns)
+		first_ns = list_entry_rcu(head->next, typeof(*ns), ns_owner_entry);
+	for (ns = first_ns; &ns->ns_owner_entry != head && nr_ns_ids;
+	     ns = list_entry_rcu(ns->ns_owner_entry.next, typeof(*ns), ns_owner_entry)) {
+		struct ns_common *valid __free(ns_put);
+
+		valid = legitimize_ns(kls, ns);
+		if (!valid)
+			continue;
+
+		rcu_read_unlock();
+
+		if (put_user(valid->ns_id, ns_ids + ret))
+			return -EINVAL;
+		nr_ns_ids--;
+		ret++;
+
+		rcu_read_lock();
+	}
+
+	rcu_read_unlock();
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
+	if (ret)
+		ret = ns_get_unless_inactive(ret);
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
+	u64 __user *ns_ids = kls->uns_ids;
+	size_t nr_ns_ids = kls->nr_ns_ids;
+	struct ns_common *ns, *first_ns = NULL;
+	struct ns_tree *ns_tree = NULL;
+	const struct list_head *head;
+	u32 ns_type;
+	ssize_t ret;
+
+	if (hweight32(kls->ns_type) == 1)
+		ns_type = kls->ns_type;
+	else
+		ns_type = 0;
+
+	if (ns_type) {
+		ns_tree = ns_tree_from_type(ns_type);
+		if (!ns_tree)
+			return -EINVAL;
+	}
+
+	if (kls->last_ns_id) {
+		kls->first_ns = lookup_ns_id_at(kls->last_ns_id + 1, ns_type);
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
+	rcu_read_lock();
+
+	if (!first_ns)
+		first_ns = first_ns_common(head, ns_tree);
+
+	for (ns = first_ns; !ns_common_is_head(ns, head, ns_tree) && nr_ns_ids;
+	     ns = next_ns_common(ns, ns_tree)) {
+		struct ns_common *valid __free(ns_put);
+
+		valid = legitimize_ns(kls, ns);
+		if (!valid)
+			continue;
+
+		rcu_read_unlock();
+
+		if (put_user(valid->ns_id, ns_ids + ret))
+			return -EINVAL;
+
+		nr_ns_ids--;
+		ret++;
+
+		rcu_read_lock();
+	}
+
+	rcu_read_unlock();
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
+	ret = prepare_klistns(&klns, &kreq, ns_ids, nr_ns_ids);
+	if (ret)
+		return ret;
+
+	if (kreq.user_ns_id)
+		return do_listns_userns(&klns);
+
+	return do_listns(&klns);
+}

-- 
2.47.3


