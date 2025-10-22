Return-Path: <linux-fsdevel+bounces-65138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE6FBFD0AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBC4619A2C5D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3912C11D5;
	Wed, 22 Oct 2025 16:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzbmJdnQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA48227A10D;
	Wed, 22 Oct 2025 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149219; cv=none; b=XDGJQk+UKeBiOoomuo8zuDqIRZ802EMPqBDLbfC5zqm5SP64HQnuc8cuj6EYGKuqYpBx6Z0tpuWfhvVZfxjKHai0vOxdATukKa+GuWh5mklPza5q6VL1M0kpxIDE+DVnUJ7RACiX1CMV/98ud71pOh/8ElvtTAax4PWyhF0TRyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149219; c=relaxed/simple;
	bh=+BA6Ji07XyQJ9aDuuwwFHepKxfmtS4I8owdAv7+CnpU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KB+Qk7Dp/0gLWD2G/dohFgiuG+rBHpgq2fovT+qvNNXD+77ugREcXBXBUKFnIbstndeAM1DjZQM9WosL6G+2c2tp0mE9D7GuXaPWBYJP6C4qLrssuy2JOAztqVF3EEacFfLNuZzlXzKGL4tt2LZaugVGwZwjd6yFILQ8CuZKduY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tzbmJdnQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C347FC4CEF7;
	Wed, 22 Oct 2025 16:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761149218;
	bh=+BA6Ji07XyQJ9aDuuwwFHepKxfmtS4I8owdAv7+CnpU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tzbmJdnQNs1XKkaGcs8LZ0X4n6OR4B+W8VGLPJ/K8FvxheNeO7QWcUiXofyoaJ9XP
	 9iBEkcISk7GIxHuuy4RQA3Ur6MEvuW7mUalLySdDGx03Je9yK4tZLFxBWcxg9X1mvL
	 Z2CJaLvqvkashldzmVH9R/vgVKjRNYsQN4TVOVE5atWrddcRxvnGjcmHo+iEH7JI58
	 IBglMzSjgqOs5FTt1IKMMqpkAhyc21AC7LrHOU9+gzCuSDVukGxJHwO5LVi1J2Ydkt
	 Gm0K4Kb/6BsP2ZEZLzKpWpSSul1It6aLI7cfk2h/F5fY4ZmoDxfS76OnjsGmwDWZ8O
	 1J8oQ06k3Q0Uw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Oct 2025 18:05:48 +0200
Subject: [PATCH v2 10/63] ns: add active reference count
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-work-namespace-nstree-listns-v2-10-71a588572371@kernel.org>
References: <20251022-work-namespace-nstree-listns-v2-0-71a588572371@kernel.org>
In-Reply-To: <20251022-work-namespace-nstree-listns-v2-0-71a588572371@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=34379; i=brauner@kernel.org;
 h=from:subject:message-id; bh=+BA6Ji07XyQJ9aDuuwwFHepKxfmtS4I8owdAv7+CnpU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8ZHjyzuv3qtxVOhv2Xz3eOcUvwMj86OT5gveV5hiZf
 t2hWsJk2lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAnCRdQz/jIXSfs5t8PU//lLX
 U+tpfthk7c/ZL/6yLLj8cRvrpm87bzD8T+iNdwlakatx9d5z4+lTjH1P3XsopmUVLSP/Setn7Or
 TfAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The namespace tree is, among other things, currently used to support
file handles for namespaces. When a namespace is created it is placed on
the namespace trees and when it is destroyed it is removed from the
namespace trees.

While a namespace is on the namespace trees with a valid reference count
it is possible to reopen it through a namespace file handle. This is all
fine but has some issues that should be addressed.

On current kernels a namespace is visible to userspace in the
following cases:

(1) The namespace is in use by a task.
(2) The namespace is persisted through a VFS object (namespace file
    descriptor or bind-mount).
    Note that (2) only cares about direct persistence of the namespace
    itself not indirectly via e.g., file->f_cred file references or
    similar.
(3) The namespace is a hierarchical namespace type and is the parent of
    a single or multiple child namespaces.

Case (3) is interesting because it is possible that a parent namespace
might not fulfill any of (1) or (2), i.e., is invisible to userspace but
it may still be resurrected through the NS_GET_PARENT ioctl().

Currently namespace file handles allow much broader access to namespaces
than what is currently possible via (1)-(4). The reason is that
namespaces may remain pinned for completely internal reasons yet are
inaccessible to userspace.

For example, a user namespace my remain pinned by get_cred() calls to
stash the opener's credentials into file->f_cred. As it stands file
handles allow to resurrect such a users namespace even though this
should not be possible via (1)-(3). This is a fundamental uapi change
that we shouldn't do if we don't have to.

Consider the following insane case: Various architectures support the
CONFIG_MMU_LAZY_TLB_REFCOUNT option which uses lazy TLB destruction.
When this option is set a userspace task's struct mm_struct may be used
for kernel threads such as the idle task and will only be destroyed once
the cpu's runqueue switches back to another task. But because of ptrace()
permission checks struct mm_struct stashes the user namespace of the
task that struct mm_struct originally belonged to. The kernel thread
will take a reference on the struct mm_struct and thus pin it.

So on an idle system user namespaces can be persisted for arbitrary
amounts of time which also means that they can be resurrected using
namespace file handles. That makes no sense whatsoever. The problem is
of course excarabted on large systems with a huge number of cpus.

To handle this nicely we introduce an active reference count which
tracks (1)-(3). This is easy to do as all of these things are already
managed centrally. Only (1)-(3) will count towards the active reference
count and only namespaces which are active may be opened via namespace
file handles.

The problem is that namespaces may be resurrected. Which means that they
can become temporarily inactive and will be reactived some time later.
Currently the only example of this is the SIOGCSKNS socket ioctl. The
SIOCGSKNS ioctl allows to open a network namespace file descriptor based
on a socket file descriptor.

If a socket is tied to a network namespace that subsequently becomes
inactive but that socket is persisted by another process in another
network namespace (e.g., via SCM_RIGHTS of pidfd_getfd()) then the
SIOCGSKNS ioctl will resurrect this network namespace.

So calls to open_related_ns() and open_namespace() will end up
resurrecting the corresponding namespace tree.

Note that the active reference count does not regulate the lifetime of
the namespace itself. This is still done by the normal reference count.
The active reference count can only be elevated if the regular reference
count is elevated.

The active reference count also doesn't regulate the presence of a
namespace on the namespace trees. It only regulates its visiblity to
namespace file handles (and in later patches to listns()).

A namespace remains on the namespace trees from creation until its
actual destruction. This will allow the kernel to always reach any
namespace trivially and it will also enable subsystems like bpf to walk
the namespace lists on the system for tracing or general introspection
purposes.

Note that different namespaces have different visibility lifetimes on
current kernels. While most namespace are immediately released when the
last task using them exits, the user- and pid namespace are persisted
and thus both remain accessible via /proc/<pid>/ns/<ns_type>.

The user namespace lifetime is aliged with struct cred and is only
released through exit_creds(). However, it becomes inaccessible to
userspace once the last task using it is reaped, i.e., when
release_task() is called and all proc entries are flushed. Similarly,
the pid namespace is also visible until the last task using it has been
reaped and the associated pid numbers are freed.

The active reference counts of the user- and pid namespace are
decremented once the task is reaped.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c            |   2 +
 fs/nsfs.c                 |  46 +++++++++-
 include/linux/ns_common.h | 142 ++++++++++++++++++++++++++++-
 include/linux/nsfs.h      |   3 +
 init/version-timestamp.c  |   1 +
 ipc/msgutil.c             |   1 +
 ipc/namespace.c           |   1 +
 kernel/cgroup/cgroup.c    |   1 +
 kernel/cgroup/namespace.c |   1 +
 kernel/cred.c             |  17 ++++
 kernel/exit.c             |   1 +
 kernel/nscommon.c         | 221 +++++++++++++++++++++++++++++++++++++++++++++-
 kernel/nsproxy.c          |   7 ++
 kernel/pid.c              |  11 +++
 kernel/pid_namespace.c    |   1 +
 kernel/time/namespace.c   |   2 +
 kernel/user.c             |   1 +
 kernel/user_namespace.c   |   1 +
 kernel/utsname.c          |   1 +
 net/core/net_namespace.c  |   1 +
 20 files changed, 458 insertions(+), 4 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 8ef8ba3dd316..87116def5ee3 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4173,6 +4173,7 @@ struct mnt_namespace *copy_mnt_ns(u64 flags, struct mnt_namespace *ns,
 			p = next_mnt(skip_mnt_tree(p), old);
 	}
 	ns_tree_add_raw(new_ns);
+	ns_ref_active_get_owner(new_ns);
 	return new_ns;
 }
 
@@ -5989,6 +5990,7 @@ struct mnt_namespace init_mnt_ns = {
 	.ns.ops		= &mntns_operations,
 	.user_ns	= &init_user_ns,
 	.ns.__ns_ref	= REFCOUNT_INIT(1),
+	.ns.__ns_ref_active = ATOMIC_INIT(1),
 	.ns.ns_type	= ns_common_type(&init_mnt_ns),
 	.passive	= REFCOUNT_INIT(1),
 	.mounts		= RB_ROOT,
diff --git a/fs/nsfs.c b/fs/nsfs.c
index 363be226e357..ef9880232845 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -58,6 +58,8 @@ const struct dentry_operations ns_dentry_operations = {
 static void nsfs_evict(struct inode *inode)
 {
 	struct ns_common *ns = inode->i_private;
+
+	__ns_ref_active_put(ns);
 	clear_inode(inode);
 	ns->ops->put(ns);
 }
@@ -419,6 +421,16 @@ static int nsfs_init_inode(struct inode *inode, void *data)
 	inode->i_mode |= S_IRUGO;
 	inode->i_fop = &ns_file_operations;
 	inode->i_ino = ns->inum;
+
+	/*
+	 * Bring the namespace subtree back to life if we have to. This
+	 * can happen when e.g., all processes using a network namespace
+	 * and all namespace files or namespace file bind-mounts have
+	 * died but there are still sockets pinning it. The SIOCGSKNS
+	 * ioctl on such a socket will resurrect the relevant namespace
+	 * subtree.
+	 */
+	__ns_ref_active_resurrect(ns);
 	return 0;
 }
 
@@ -493,7 +505,15 @@ static struct dentry *nsfs_fh_to_dentry(struct super_block *sb, struct fid *fh,
 		VFS_WARN_ON_ONCE(ns->ns_type != fid->ns_type);
 		VFS_WARN_ON_ONCE(ns->inum != fid->ns_inum);
 
-		if (!__ns_ref_get(ns))
+		/*
+		 * This is racy because we're not actually taking an
+		 * active reference. IOW, it could happen that the
+		 * namespace becomes inactive after this check.
+		 * We don't care because nsfs_init_inode() will just
+		 * resurrect the relevant namespace tree for us. If it
+		 * has been active here we just proclaim it as namespac.
+		 */
+		if (!ns_get_unless_inactive(ns))
 			return NULL;
 	}
 
@@ -614,3 +634,27 @@ void __init nsfs_init(void)
 	nsfs_root_path.mnt = nsfs_mnt;
 	nsfs_root_path.dentry = nsfs_mnt->mnt_root;
 }
+
+void nsproxy_ns_active_get(struct nsproxy *ns)
+{
+	ns_ref_active_get(ns->mnt_ns);
+	ns_ref_active_get(ns->uts_ns);
+	ns_ref_active_get(ns->ipc_ns);
+	ns_ref_active_get(ns->pid_ns_for_children);
+	ns_ref_active_get(ns->cgroup_ns);
+	ns_ref_active_get(ns->net_ns);
+	ns_ref_active_get(ns->time_ns);
+	ns_ref_active_get(ns->time_ns_for_children);
+}
+
+void nsproxy_ns_active_put(struct nsproxy *ns)
+{
+	ns_ref_active_put(ns->mnt_ns);
+	ns_ref_active_put(ns->uts_ns);
+	ns_ref_active_put(ns->ipc_ns);
+	ns_ref_active_put(ns->pid_ns_for_children);
+	ns_ref_active_put(ns->cgroup_ns);
+	ns_ref_active_put(ns->net_ns);
+	ns_ref_active_put(ns->time_ns);
+	ns_ref_active_put(ns->time_ns_for_children);
+}
diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index 32114d5698dc..77ea38d8bac9 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -4,7 +4,9 @@
 
 #include <linux/refcount.h>
 #include <linux/rbtree.h>
+#include <linux/vfsdebug.h>
 #include <uapi/linux/sched.h>
+#include <uapi/linux/nsfs.h>
 
 struct proc_ns_operations;
 
@@ -37,6 +39,73 @@ extern const struct proc_ns_operations cgroupns_operations;
 extern const struct proc_ns_operations timens_operations;
 extern const struct proc_ns_operations timens_for_children_operations;
 
+/*
+ * Namespace lifetimes are managed via a two-tier reference counting model:
+ *
+ * (1) __ns_ref (refcount_t): Main reference count tracking memory lifetime.
+ *     Controls when the namespace structure itself is freed. It also
+ *     pins the namespace on the namespace trees whereas (2) only
+ *     regulates their visibility to userspace.
+ *
+ * (2) __ns_ref_active (atomic_t): Reference count tracking active users.
+ *     Controls visibility of the namespace in the namespace trees.
+ *     Any live task that uses the namespace (via nsproxy or cred) holds
+ *     an active reference. Any open file descriptor or bind-mount of
+ *     the namespace holds an active reference. Once all tasks have
+ *     called exit_task_namespaces() and all file descriptors and
+ *     bind-mounts have been released the active reference count drops
+ *     to zero and the namespace becomes inactive. IOW, the namespace
+ *     cannot be listed or opened via file handles anymore.
+ *
+ *     Note that it is valid to transition from active to inactive and
+ *     back from inactive to active e.g., when walking a hierarchical
+ *     namespace tree upwards and reopening parent namespaces via
+ *     NS_GET_PARENT that only exist because they are a parent of an
+ *     actively used namespace.
+ *
+ * Relationship and lifecycle states:
+ *
+ * - Active (__ns_ref_active > 0):
+ *   Namespace is actively used by one or more tasks. The namespace can
+ *   be reopened via /proc/<pid>/ns/<ns_type> or discovered in the
+ *   namespace tree.
+ *
+ * - Inactive (__ns_ref_active == 0, __ns_ref > 0):
+ *   No tasks are actively using the namespace and it isn't pinned by
+ *   any bind-mounts or open file descriptors anymore. But the namespace
+ *   is still kept alive by internal references. For example, the user
+ *   namespace could be pinned by an open file through file->f_cred
+ *   references when one of the now defunct tasks had opened a file and
+ *   handed the file descriptor off to another process via a UNIX
+ *   socket. Such references keep the namespace structure alive through
+ *   __ns_ref but will not take an active reference.
+ *
+ * - Destroyed (__ns_ref == 0):
+ *   No references remain. The namespace is removed from the tree and freed.
+ *
+ * State transitions:
+ *
+ * Active -> Inactive:
+ *   When the last task using the namespace exits (via
+ *   exit_task_namespaces()), it drops its active references to all
+ *   namespaces apart from the pid namespace which remains accessible
+ *   until the task has been reaped and its pid number is released.
+ *
+ * Inactive -> Active:
+ *   When walking a hierarchical namespace tree upwards and reopening
+ *   parent namespaces via NS_GET_PARENT that only exist because they
+ *   are a parent of an actively used namespace it is possible to
+ *   necrobump an inactive namespace back to the active state.
+ *
+ * Inactive -> Destroyed:
+ *   When __ns_ref drops to zero (last file descriptor closed, last bind
+ *   mount removed, parent namespace released), the namespace is removed
+ *   from the tree and the memory is freed (after RCU grace period).
+ *
+ * Initial namespaces:
+ *   Boot-time namespaces (init_net, init_pid_ns, etc.) start with
+ *   __ns_ref_active = 1 and remain active forever.
+ */
 struct ns_common {
 	u32 ns_type;
 	struct dentry *stashed;
@@ -48,6 +117,7 @@ struct ns_common {
 			u64 ns_id;
 			struct rb_node ns_tree_node;
 			struct list_head ns_list_node;
+			atomic_t __ns_ref_active; /* do not use directly */
 		};
 		struct rcu_head ns_rcu;
 	};
@@ -56,6 +126,13 @@ struct ns_common {
 int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_operations *ops, int inum);
 void __ns_common_free(struct ns_common *ns);
 
+static __always_inline bool is_initial_namespace(struct ns_common *ns)
+{
+	VFS_WARN_ON_ONCE(ns->inum == 0);
+	return unlikely(in_range(ns->inum, MNT_NS_INIT_INO,
+				 IPC_NS_INIT_INO - MNT_NS_INIT_INO + 1));
+}
+
 #define to_ns_common(__ns)                                    \
 	_Generic((__ns),                                      \
 		struct cgroup_namespace *:       &(__ns)->ns, \
@@ -133,14 +210,26 @@ void __ns_common_free(struct ns_common *ns);
 
 #define ns_common_free(__ns) __ns_common_free(to_ns_common((__ns)))
 
+static __always_inline __must_check int __ns_ref_active_read(const struct ns_common *ns)
+{
+	return atomic_read(&ns->__ns_ref_active);
+}
+
 static __always_inline __must_check bool __ns_ref_put(struct ns_common *ns)
 {
-	return refcount_dec_and_test(&ns->__ns_ref);
+	if (refcount_dec_and_test(&ns->__ns_ref)) {
+		VFS_WARN_ON_ONCE(__ns_ref_active_read(ns));
+		return true;
+	}
+	return false;
 }
 
 static __always_inline __must_check bool __ns_ref_get(struct ns_common *ns)
 {
-	return refcount_inc_not_zero(&ns->__ns_ref);
+	if (refcount_inc_not_zero(&ns->__ns_ref))
+		return true;
+	VFS_WARN_ON_ONCE(__ns_ref_active_read(ns));
+	return false;
 }
 
 static __always_inline __must_check int __ns_ref_read(const struct ns_common *ns)
@@ -155,4 +244,53 @@ static __always_inline __must_check int __ns_ref_read(const struct ns_common *ns
 #define ns_ref_put_and_lock(__ns, __lock) \
 	refcount_dec_and_lock(&to_ns_common((__ns))->__ns_ref, (__lock))
 
+#define ns_ref_active_read(__ns) \
+	((__ns) ? __ns_ref_active_read(to_ns_common(__ns)) : 0)
+
+void __ns_ref_active_get_owner(struct ns_common *ns);
+
+static __always_inline void __ns_ref_active_get(struct ns_common *ns)
+{
+	WARN_ON_ONCE(atomic_add_negative(1, &ns->__ns_ref_active));
+	VFS_WARN_ON_ONCE(is_initial_namespace(ns) && __ns_ref_active_read(ns) <= 0);
+}
+#define ns_ref_active_get(__ns) \
+	do { if (__ns) __ns_ref_active_get(to_ns_common(__ns)); } while (0)
+
+static __always_inline bool __ns_ref_active_get_not_zero(struct ns_common *ns)
+{
+	if (atomic_inc_not_zero(&ns->__ns_ref_active)) {
+		VFS_WARN_ON_ONCE(!__ns_ref_read(ns));
+		return true;
+	}
+	return false;
+}
+
+#define ns_ref_active_get_owner(__ns) \
+	do { if (__ns) __ns_ref_active_get_owner(to_ns_common(__ns)); } while (0)
+
+void __ns_ref_active_put_owner(struct ns_common *ns);
+
+static __always_inline void __ns_ref_active_put(struct ns_common *ns)
+{
+	if (atomic_dec_and_test(&ns->__ns_ref_active)) {
+		VFS_WARN_ON_ONCE(is_initial_namespace(ns));
+		VFS_WARN_ON_ONCE(!__ns_ref_read(ns));
+		__ns_ref_active_put_owner(ns);
+	}
+}
+#define ns_ref_active_put(__ns) \
+	do { if (__ns) __ns_ref_active_put(to_ns_common(__ns)); } while (0)
+
+static __always_inline bool ns_get_unless_inactive(struct ns_common *ns)
+{
+	VFS_WARN_ON_ONCE(__ns_ref_active_read(ns) && !__ns_ref_read(ns));
+	return __ns_ref_active_read(ns) && __ns_ref_get(ns);
+}
+
+void __ns_ref_active_resurrect(struct ns_common *ns);
+
+#define ns_ref_active_resurrect(__ns) \
+	do { if (__ns) __ns_ref_active_resurrect(to_ns_common(__ns)); } while (0)
+
 #endif
diff --git a/include/linux/nsfs.h b/include/linux/nsfs.h
index e5a5fa83d36b..731b67fc2fec 100644
--- a/include/linux/nsfs.h
+++ b/include/linux/nsfs.h
@@ -37,4 +37,7 @@ void nsfs_init(void);
 
 #define current_in_namespace(__ns) (__current_namespace_from_type(__ns) == __ns)
 
+void nsproxy_ns_active_get(struct nsproxy *ns);
+void nsproxy_ns_active_put(struct nsproxy *ns);
+
 #endif /* _LINUX_NSFS_H */
diff --git a/init/version-timestamp.c b/init/version-timestamp.c
index 61b2405d97f9..c38498f94646 100644
--- a/init/version-timestamp.c
+++ b/init/version-timestamp.c
@@ -10,6 +10,7 @@
 struct uts_namespace init_uts_ns = {
 	.ns.ns_type = ns_common_type(&init_uts_ns),
 	.ns.__ns_ref = REFCOUNT_INIT(2),
+	.ns.__ns_ref_active = ATOMIC_INIT(1),
 	.name = {
 		.sysname	= UTS_SYSNAME,
 		.nodename	= UTS_NODENAME,
diff --git a/ipc/msgutil.c b/ipc/msgutil.c
index c9469fbce27c..d7c66b430470 100644
--- a/ipc/msgutil.c
+++ b/ipc/msgutil.c
@@ -28,6 +28,7 @@ DEFINE_SPINLOCK(mq_lock);
  */
 struct ipc_namespace init_ipc_ns = {
 	.ns.__ns_ref = REFCOUNT_INIT(1),
+	.ns.__ns_ref_active = ATOMIC_INIT(1),
 	.user_ns = &init_user_ns,
 	.ns.inum = ns_init_inum(&init_ipc_ns),
 	.ns.ns_list_node = LIST_HEAD_INIT(init_ipc_ns.ns.ns_list_node),
diff --git a/ipc/namespace.c b/ipc/namespace.c
index 59b12fcb40bd..23390d4f9b1f 100644
--- a/ipc/namespace.c
+++ b/ipc/namespace.c
@@ -87,6 +87,7 @@ static struct ipc_namespace *create_ipc_ns(struct user_namespace *user_ns,
 	sem_init_ns(ns);
 	shm_init_ns(ns);
 	ns_tree_add(ns);
+	ns_ref_active_get_owner(ns);
 
 	return ns;
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index a82918da8bae..a18ec090ad7e 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -251,6 +251,7 @@ bool cgroup_enable_per_threadgroup_rwsem __read_mostly;
 /* cgroup namespace for init task */
 struct cgroup_namespace init_cgroup_ns = {
 	.ns.__ns_ref	= REFCOUNT_INIT(2),
+	.ns.__ns_ref_active = ATOMIC_INIT(1),
 	.user_ns	= &init_user_ns,
 	.ns.ops		= &cgroupns_operations,
 	.ns.inum	= ns_init_inum(&init_cgroup_ns),
diff --git a/kernel/cgroup/namespace.c b/kernel/cgroup/namespace.c
index db9617556dd7..1aeb4303a3d8 100644
--- a/kernel/cgroup/namespace.c
+++ b/kernel/cgroup/namespace.c
@@ -86,6 +86,7 @@ struct cgroup_namespace *copy_cgroup_ns(u64 flags,
 	new_ns->root_cset = cset;
 
 	ns_tree_add(new_ns);
+	ns_ref_active_get_owner(new_ns);
 	return new_ns;
 }
 
diff --git a/kernel/cred.c b/kernel/cred.c
index dbf6b687dc5c..9990875ea6e0 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -306,6 +306,11 @@ int copy_creds(struct task_struct *p, u64 clone_flags)
 		kdebug("share_creds(%p{%ld})",
 		       p->cred, atomic_long_read(&p->cred->usage));
 		inc_rlimit_ucounts(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);
+		/*
+		 * Each task gets its own active reference, even if
+		 * CLONE_THREAD shares the cred structure.
+		 */
+		ns_ref_active_get(new->user_ns);
 		return 0;
 	}
 
@@ -343,6 +348,8 @@ int copy_creds(struct task_struct *p, u64 clone_flags)
 
 	p->cred = p->real_cred = get_cred(new);
 	inc_rlimit_ucounts(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);
+	ns_ref_active_get(new->user_ns);
+
 	return 0;
 
 error_put:
@@ -435,6 +442,16 @@ int commit_creds(struct cred *new)
 	 */
 	if (new->user != old->user || new->user_ns != old->user_ns)
 		inc_rlimit_ucounts(new->ucounts, UCOUNT_RLIMIT_NPROC, 1);
+
+	/*
+	 * Swap active refs if changing user_ns. This task is switching from
+	 * actively using old->user_ns to actively using new->user_ns.
+	 */
+	if (new->user_ns != old->user_ns) {
+		ns_ref_active_get(new->user_ns);
+		ns_ref_active_put(old->user_ns);
+	}
+
 	rcu_assign_pointer(task->real_cred, new);
 	rcu_assign_pointer(task->cred, new);
 	if (new->user != old->user || new->user_ns != old->user_ns)
diff --git a/kernel/exit.c b/kernel/exit.c
index 9f74e8f1c431..599375553c1f 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -291,6 +291,7 @@ void release_task(struct task_struct *p)
 	write_unlock_irq(&tasklist_lock);
 	/* @thread_pid can't go away until free_pids() below */
 	proc_flush_pid(thread_pid);
+	ns_ref_active_put(p->real_cred->user_ns);
 	add_device_randomness(&p->se.sum_exec_runtime,
 			      sizeof(p->se.sum_exec_runtime));
 	free_pids(post.pids);
diff --git a/kernel/nscommon.c b/kernel/nscommon.c
index c1fb2bad6d72..d750e554d50b 100644
--- a/kernel/nscommon.c
+++ b/kernel/nscommon.c
@@ -2,6 +2,7 @@
 
 #include <linux/ns_common.h>
 #include <linux/proc_ns.h>
+#include <linux/user_namespace.h>
 #include <linux/vfsdebug.h>
 
 #ifdef CONFIG_DEBUG_VFS
@@ -52,6 +53,8 @@ static void ns_debug(struct ns_common *ns, const struct proc_ns_operations *ops)
 
 int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_operations *ops, int inum)
 {
+	int ret;
+
 	refcount_set(&ns->__ns_ref, 1);
 	ns->stashed = NULL;
 	ns->ops = ops;
@@ -68,10 +71,226 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
 		ns->inum = inum;
 		return 0;
 	}
-	return proc_alloc_inum(&ns->inum);
+	ret = proc_alloc_inum(&ns->inum);
+	if (ret)
+		return ret;
+	/*
+	 * Tree ref starts at 0. It's incremented when namespace enters
+	 * active use (installed in nsproxy) and decremented when all
+	 * active uses are gone. Initial namespaces are always active.
+	 */
+	if (is_initial_namespace(ns))
+		atomic_set(&ns->__ns_ref_active, 1);
+	else
+		atomic_set(&ns->__ns_ref_active, 0);
+	return 0;
 }
 
 void __ns_common_free(struct ns_common *ns)
 {
 	proc_free_inum(ns->inum);
 }
+
+static struct ns_common *ns_owner(struct ns_common *ns)
+{
+	struct user_namespace *owner;
+
+	if (unlikely(!ns->ops))
+		return NULL;
+	VFS_WARN_ON_ONCE(!ns->ops->owner);
+	owner = ns->ops->owner(ns);
+	VFS_WARN_ON_ONCE(!owner && ns != to_ns_common(&init_user_ns));
+	if (!owner)
+		return NULL;
+	/* Skip init_user_ns as it's always active */
+	if (owner == &init_user_ns)
+		return NULL;
+	return to_ns_common(owner);
+}
+
+void __ns_ref_active_get_owner(struct ns_common *ns)
+{
+	ns = ns_owner(ns);
+	if (ns)
+		WARN_ON_ONCE(atomic_add_negative(1, &ns->__ns_ref_active));
+}
+
+/*
+ * The active reference count works by having each namespace that gets
+ * created take a single active reference on its owning user namespace.
+ * That single reference is only released once the child namespace's
+ * active count itself goes down. This makes it possible to efficiently
+ * resurrect a namespace tree:
+ *
+ * On namespace creation each new namespace will take a single reference
+ * count on its owning user namespace.
+ *
+ * A regular namespace tree might look as follow:
+ * Legend:
+ * + : adding active reference
+ * - : dropping active reference
+ * x : always active (initial namespace)
+ *
+ *
+ *                 net_ns          pid_ns
+ *                       \        /
+ *                        +      +
+ *                        user_ns1 (2)
+ *                            |
+ *                 ipc_ns     |     uts_ns
+ *                       \    |    /
+ *                        +   +   +
+ *                        user_ns2 (3)
+ *                            |
+ *            cgroup_ns       |       mnt_ns
+ *                     \      |      /
+ *                      x     x     x
+ *                      init_user_ns (1)
+ *
+ * If both net_ns and pid_ns put their last active reference on
+ * themselves it will cascade to user_ns1 dropping its own active
+ * reference and dropping one active reference on user_ns2:
+ *
+ *                 net_ns          pid_ns
+ *                       \        /
+ *                        -      -
+ *                        user_ns1 (0)
+ *                            |
+ *                 ipc_ns     |     uts_ns
+ *                       \    |    /
+ *                        +   -   +
+ *                        user_ns2 (2)
+ *                            |
+ *            cgroup_ns       |       mnt_ns
+ *                     \      |      /
+ *                      x     x     x
+ *                      init_user_ns (1)
+ *
+ * The iteration stops once we reach a namespace that still has active
+ * references.
+ */
+void __ns_ref_active_put_owner(struct ns_common *ns)
+{
+	for (;;) {
+		ns = ns_owner(ns);
+		if (!ns)
+			return;
+		if (!atomic_dec_and_test(&ns->__ns_ref_active))
+			return;
+	}
+}
+
+/*
+ * The active reference count works by having each namespace that gets
+ * created take a single active reference on its owning user namespace.
+ * That single reference is only released once the child namespace's
+ * active count itself goes down. This makes it possible to efficiently
+ * resurrect a namespace tree:
+ *
+ * On namespace creation each new namespace will take a single reference
+ * count on its owning user namespace.
+ *
+ * A regular namespace tree might look as follow:
+ * Legend:
+ * + : adding active reference
+ * - : dropping active reference
+ * x : always active (initial namespace)
+ *
+ *
+ *                 net_ns          pid_ns
+ *                       \        /
+ *                        +      +
+ *                        user_ns1 (2)
+ *                            |
+ *                 ipc_ns     |     uts_ns
+ *                       \    |    /
+ *                        +   +   +
+ *                        user_ns2 (3)
+ *                            |
+ *            cgroup_ns       |       mnt_ns
+ *                     \      |      /
+ *                      x     x     x
+ *                      init_user_ns (1)
+ *
+ * If both net_ns and pid_ns put their last active reference on
+ * themselves it will cascade to user_ns1 dropping its own active
+ * reference and dropping one active reference on user_ns2:
+ *
+ *                 net_ns          pid_ns
+ *                       \        /
+ *                        -      -
+ *                        user_ns1 (0)
+ *                            |
+ *                 ipc_ns     |     uts_ns
+ *                       \    |    /
+ *                        +   -   +
+ *                        user_ns2 (2)
+ *                            |
+ *            cgroup_ns       |       mnt_ns
+ *                     \      |      /
+ *                      x     x     x
+ *                      init_user_ns (1)
+ *
+ * Assume the whole tree is dead but all namespaces are still active:
+ *
+ *                 net_ns          pid_ns
+ *                       \        /
+ *                        -      -
+ *                        user_ns1 (0)
+ *                            |
+ *                 ipc_ns     |     uts_ns
+ *                       \    |    /
+ *                        -   -   -
+ *                        user_ns2 (0)
+ *                            |
+ *            cgroup_ns       |       mnt_ns
+ *                     \      |      /
+ *                      x     x     x
+ *                      init_user_ns (1)
+ *
+ * Now assume the net_ns gets resurrected (.e.g., via the SIOCGSKNS ioctl()):
+ *
+ *                 net_ns          pid_ns
+ *                       \        /
+ *                        +      -
+ *                        user_ns1 (0)
+ *                            |
+ *                 ipc_ns     |     uts_ns
+ *                       \    |    /
+ *                        -   +   -
+ *                        user_ns2 (0)
+ *                            |
+ *            cgroup_ns       |       mnt_ns
+ *                     \      |      /
+ *                      x     x     x
+ *                      init_user_ns (1)
+ *
+ * If net_ns had a zero reference count and we bumped it we also need to
+ * take another reference on its owning user namespace. Similarly, if
+ * pid_ns had a zero reference count it also needs to take another
+ * reference on its owning user namespace. So both net_ns and pid_ns
+ * will each have their own reference on the owning user namespace.
+ *
+ * If the owning user namespace user_ns1 had a zero reference count then
+ * it also needs to take another reference on its owning user namespace
+ * and so on.
+ */
+void __ns_ref_active_resurrect(struct ns_common *ns)
+{
+	/* If we didn't resurrect the namespace we're done. */
+	if (atomic_fetch_add(1, &ns->__ns_ref_active))
+		return;
+
+	/*
+	 * We did resurrect it. Walk the ownership hierarchy upwards
+	 * until we found an owning user namespace that is active.
+	 */
+	for (;;) {
+		ns = ns_owner(ns);
+		if (!ns)
+			return;
+
+		if (atomic_fetch_add(1, &ns->__ns_ref_active))
+			return;
+	}
+}
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index 19aa64ab08c8..3324d827f6bc 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -26,6 +26,7 @@
 #include <linux/syscalls.h>
 #include <linux/cgroup.h>
 #include <linux/perf_event.h>
+#include <linux/nstree.h>
 
 static struct kmem_cache *nsproxy_cachep;
 
@@ -179,12 +180,15 @@ int copy_namespaces(u64 flags, struct task_struct *tsk)
 	if ((flags & CLONE_VM) == 0)
 		timens_on_fork(new_ns, tsk);
 
+	nsproxy_ns_active_get(new_ns);
 	tsk->nsproxy = new_ns;
 	return 0;
 }
 
 void free_nsproxy(struct nsproxy *ns)
 {
+	nsproxy_ns_active_put(ns);
+
 	put_mnt_ns(ns->mnt_ns);
 	put_uts_ns(ns->uts_ns);
 	put_ipc_ns(ns->ipc_ns);
@@ -232,6 +236,9 @@ void switch_task_namespaces(struct task_struct *p, struct nsproxy *new)
 
 	might_sleep();
 
+	if (new)
+		nsproxy_ns_active_get(new);
+
 	task_lock(p);
 	ns = p->nsproxy;
 	p->nsproxy = new;
diff --git a/kernel/pid.c b/kernel/pid.c
index cb7574ca00f7..4f7b5054e23d 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -72,6 +72,7 @@ static int pid_max_max = PID_MAX_LIMIT;
  */
 struct pid_namespace init_pid_ns = {
 	.ns.__ns_ref = REFCOUNT_INIT(2),
+	.ns.__ns_ref_active = ATOMIC_INIT(1),
 	.idr = IDR_INIT(init_pid_ns.idr),
 	.pid_allocated = PIDNS_ADDING,
 	.level = 0,
@@ -118,9 +119,13 @@ static void delayed_put_pid(struct rcu_head *rhp)
 void free_pid(struct pid *pid)
 {
 	int i;
+	struct pid_namespace *active_ns;
 
 	lockdep_assert_not_held(&tasklist_lock);
 
+	active_ns = pid->numbers[pid->level].ns;
+	ns_ref_active_put(active_ns);
+
 	spin_lock(&pidmap_lock);
 	for (i = 0; i <= pid->level; i++) {
 		struct upid *upid = pid->numbers + i;
@@ -285,6 +290,12 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 	spin_unlock(&pidmap_lock);
 	idr_preload_end();
 
+	/*
+	 * Increment active ref for the task's active PID namespace.
+	 * This marks the namespace as actively in use by a running task.
+	 */
+	ns_ref_active_get(ns);
+
 	return pid;
 
 out_unlock:
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 650be58d8d18..2e678338c6d1 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -124,6 +124,7 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
 #endif
 
 	ns_tree_add(ns);
+	ns_ref_active_get_owner(ns);
 	return ns;
 
 out_free_inum:
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index ee05cad288da..2e7c110bd13f 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -106,6 +106,7 @@ static struct time_namespace *clone_time_ns(struct user_namespace *user_ns,
 	ns->offsets = old_ns->offsets;
 	ns->frozen_offsets = false;
 	ns_tree_add(ns);
+	ns_ref_active_get_owner(ns);
 	return ns;
 
 fail_free_page:
@@ -480,6 +481,7 @@ const struct proc_ns_operations timens_for_children_operations = {
 struct time_namespace init_time_ns = {
 	.ns.ns_type	= ns_common_type(&init_time_ns),
 	.ns.__ns_ref	= REFCOUNT_INIT(3),
+	.ns.__ns_ref_active = ATOMIC_INIT(1),
 	.user_ns	= &init_user_ns,
 	.ns.inum	= ns_init_inum(&init_time_ns),
 	.ns.ops		= &timens_operations,
diff --git a/kernel/user.c b/kernel/user.c
index b9cf3b056a71..bf60532856db 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -67,6 +67,7 @@ struct user_namespace init_user_ns = {
 	},
 	.ns.ns_type = ns_common_type(&init_user_ns),
 	.ns.__ns_ref = REFCOUNT_INIT(3),
+	.ns.__ns_ref_active = ATOMIC_INIT(1),
 	.owner = GLOBAL_ROOT_UID,
 	.group = GLOBAL_ROOT_GID,
 	.ns.inum = ns_init_inum(&init_user_ns),
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 03cb63883d04..9da3ee9e2eb1 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -160,6 +160,7 @@ int create_user_ns(struct cred *new)
 
 	set_cred_user_ns(new, ns);
 	ns_tree_add(ns);
+	ns_ref_active_get_owner(ns);
 	return 0;
 fail_keyring:
 #ifdef CONFIG_PERSISTENT_KEYRINGS
diff --git a/kernel/utsname.c b/kernel/utsname.c
index ebbfc578a9d3..18f55a05ad5b 100644
--- a/kernel/utsname.c
+++ b/kernel/utsname.c
@@ -60,6 +60,7 @@ static struct uts_namespace *clone_uts_ns(struct user_namespace *user_ns,
 	ns->user_ns = get_user_ns(user_ns);
 	up_read(&uts_sem);
 	ns_tree_add(ns);
+	ns_ref_active_get_owner(ns);
 	return ns;
 
 fail_free:
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index b0e0f22d7b21..f30fb78f020c 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -450,6 +450,7 @@ static __net_init int setup_net(struct net *net)
 	list_add_tail_rcu(&net->list, &net_namespace_list);
 	up_write(&net_rwsem);
 	ns_tree_add_raw(net);
+	ns_ref_active_get_owner(net);
 out:
 	return error;
 

-- 
2.47.3


