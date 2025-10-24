Return-Path: <linux-fsdevel+bounces-65456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4CBC05C29
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 13:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B36D21884C3D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 11:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA1131D74E;
	Fri, 24 Oct 2025 10:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CF7ChK+5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF79313525;
	Fri, 24 Oct 2025 10:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303262; cv=none; b=EY9eWIusm9zEEkCoGf7D9Crdn6/tDgiDOc0hwdHuzFeUzyZJArOe2m5vnPp0GaYFxWflDCPrkR8kV/CehthpvZzs/y5wumW0Nzpjm+fIr8M37GevBMs/xlq0wAMbB9tQ47QI8P6pjXejJgjfeDRT62AWiEa2ke8vj/vLHDYHFMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303262; c=relaxed/simple;
	bh=Co5S70aHxdL+O+qEH6Oe29bl2YvObKQAs7B24LZSp/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aF6TzlMgAPAMABWZVpABMztn2Qk6wfTZI0jr7txoQPINGONj9jDWnfmLB4dkP8nmpJBy+BZSuXVDSkhrcPSGYJdp3J0zhBkcLk/B+6XkXVS0h+eNj4VtRjNBAFLilbubiK5LyxNbbQ5UR1QJqqzqCXtfGj943IKkvINca+Qi0r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CF7ChK+5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4508C4CEF1;
	Fri, 24 Oct 2025 10:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761303262;
	bh=Co5S70aHxdL+O+qEH6Oe29bl2YvObKQAs7B24LZSp/E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CF7ChK+5EeZw2xl26uy3v25pfjPfJLl/tYGdcU9mb1zGPBpfqD3lz5G0pN1uKjQaZ
	 Occg3rPU3aaljeO2k9u61Nz9ox0tmTWwgFsi0KYElP7UDt20DOuC4VjWDQ34wPcb6f
	 5RwQ11IsR/narT3Iwu96ar5BZgRhDCd0sAU0yqdNgL/I1dSIPfVoal9ThNd1O1tAg1
	 LBbesYe5wtSz37WPgQVoR7EbwA5XQx/indPsmQfu1F9pasNhEyTBI4N3EPocZcsU8R
	 TXbOTx5dZ1Dx5OC9fMPQrqAUnjXY/GTAcpk46azXhBcYOG2MDkdInKwsOfcGtHAMmo
	 P2Amc8VDrY8tw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Oct 2025 12:52:45 +0200
Subject: [PATCH v3 16/70] ns: maintain list of owned namespaces
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-work-namespace-nstree-listns-v3-16-b6241981b72b@kernel.org>
References: <20251024-work-namespace-nstree-listns-v3-0-b6241981b72b@kernel.org>
In-Reply-To: <20251024-work-namespace-nstree-listns-v3-0-b6241981b72b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7611; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Co5S70aHxdL+O+qEH6Oe29bl2YvObKQAs7B24LZSp/E=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8jmply5yl5eh+sfvOSa+Zgu2t8atNbv0Xs9K+5JHkU
 nWos86yo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCKnyxh+s3c+yF2YlnCj803b
 crmdKV1GzP4dezQUld3nTjq571t6JCPDMlUJt1OxM3fkpMwWyztSH/x3o2PQdcmHPg9/JCqY/lf
 lBQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The namespace tree doesn't express the ownership concept of namespace
appropriately. Maintain a list of directly owned namespaces per user
namespace. This will allow userspace and the kernel to use the listns()
system call to walk the namespace tree by owning user namespace.
Read-only list operations are completely lockless.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c            |  2 ++
 include/linux/ns_common.h |  4 ++++
 init/version-timestamp.c  |  2 ++
 ipc/msgutil.c             |  2 ++
 kernel/cgroup/cgroup.c    |  2 ++
 kernel/nscommon.c         |  2 ++
 kernel/nstree.c           | 19 +++++++++++++++++++
 kernel/pid.c              |  2 ++
 kernel/time/namespace.c   |  2 ++
 kernel/user.c             |  2 ++
 10 files changed, 39 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 5d8a80e1e944..d460ca79f0e7 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5996,6 +5996,8 @@ struct mnt_namespace init_mnt_ns = {
 	.mounts		= RB_ROOT,
 	.poll		= __WAIT_QUEUE_HEAD_INITIALIZER(init_mnt_ns.poll),
 	.ns.ns_list_node = LIST_HEAD_INIT(init_mnt_ns.ns.ns_list_node),
+	.ns.ns_owner_entry = LIST_HEAD_INIT(init_mnt_ns.ns.ns_owner_entry),
+	.ns.ns_owner = LIST_HEAD_INIT(init_mnt_ns.ns.ns_owner),
 };
 
 static void __init init_mount_tree(void)
diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index b7d2123a9d19..88dce67e06e4 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -123,6 +123,10 @@ struct ns_common {
 				struct rb_node ns_tree_node;
 				struct list_head ns_list_node;
 			};
+			struct /* namespace ownership list */ {
+				struct list_head ns_owner; /* list of namespaces owned by this namespace */
+				struct list_head ns_owner_entry; /* node in the owner namespace's ns_owned list */
+			};
 			atomic_t __ns_ref_active; /* do not use directly */
 		};
 		struct rcu_head ns_rcu;
diff --git a/init/version-timestamp.c b/init/version-timestamp.c
index c38498f94646..e5c278dabecf 100644
--- a/init/version-timestamp.c
+++ b/init/version-timestamp.c
@@ -22,6 +22,8 @@ struct uts_namespace init_uts_ns = {
 	.user_ns = &init_user_ns,
 	.ns.inum = ns_init_inum(&init_uts_ns),
 	.ns.ns_list_node = LIST_HEAD_INIT(init_uts_ns.ns.ns_list_node),
+	.ns.ns_owner_entry = LIST_HEAD_INIT(init_uts_ns.ns.ns_owner_entry),
+	.ns.ns_owner = LIST_HEAD_INIT(init_uts_ns.ns.ns_owner),
 #ifdef CONFIG_UTS_NS
 	.ns.ops = &utsns_operations,
 #endif
diff --git a/ipc/msgutil.c b/ipc/msgutil.c
index d7c66b430470..ce1de73725c0 100644
--- a/ipc/msgutil.c
+++ b/ipc/msgutil.c
@@ -32,6 +32,8 @@ struct ipc_namespace init_ipc_ns = {
 	.user_ns = &init_user_ns,
 	.ns.inum = ns_init_inum(&init_ipc_ns),
 	.ns.ns_list_node = LIST_HEAD_INIT(init_ipc_ns.ns.ns_list_node),
+	.ns.ns_owner_entry = LIST_HEAD_INIT(init_ipc_ns.ns.ns_owner_entry),
+	.ns.ns_owner = LIST_HEAD_INIT(init_ipc_ns.ns.ns_owner),
 #ifdef CONFIG_IPC_NS
 	.ns.ops = &ipcns_operations,
 #endif
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 45e470011c77..9fa082e2eb1a 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -258,6 +258,8 @@ struct cgroup_namespace init_cgroup_ns = {
 	.root_cset	= &init_css_set,
 	.ns.ns_type	= ns_common_type(&init_cgroup_ns),
 	.ns.ns_list_node = LIST_HEAD_INIT(init_cgroup_ns.ns.ns_list_node),
+	.ns.ns_owner_entry = LIST_HEAD_INIT(init_cgroup_ns.ns.ns_owner_entry),
+	.ns.ns_owner = LIST_HEAD_INIT(init_cgroup_ns.ns.ns_owner),
 };
 
 static struct file_system_type cgroup2_fs_type;
diff --git a/kernel/nscommon.c b/kernel/nscommon.c
index bdd32e14a587..ba46de0637c3 100644
--- a/kernel/nscommon.c
+++ b/kernel/nscommon.c
@@ -63,6 +63,8 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
 	RB_CLEAR_NODE(&ns->ns_tree_node);
 	RB_CLEAR_NODE(&ns->ns_unified_tree_node);
 	INIT_LIST_HEAD(&ns->ns_list_node);
+	INIT_LIST_HEAD(&ns->ns_owner);
+	INIT_LIST_HEAD(&ns->ns_owner_entry);
 
 #ifdef CONFIG_DEBUG_VFS
 	ns_debug(ns, ops);
diff --git a/kernel/nstree.c b/kernel/nstree.c
index de5ceda44637..829682bb04a1 100644
--- a/kernel/nstree.c
+++ b/kernel/nstree.c
@@ -3,6 +3,7 @@
 #include <linux/nstree.h>
 #include <linux/proc_ns.h>
 #include <linux/vfsdebug.h>
+#include <linux/user_namespace.h>
 
 __cacheline_aligned_in_smp DEFINE_SEQLOCK(ns_tree_lock);
 static struct rb_root ns_unified_tree = RB_ROOT; /* protected by ns_tree_lock */
@@ -113,8 +114,10 @@ static inline int ns_cmp_unified(struct rb_node *a, const struct rb_node *b)
 void __ns_tree_add_raw(struct ns_common *ns, struct ns_tree *ns_tree)
 {
 	struct rb_node *node, *prev;
+	const struct proc_ns_operations *ops = ns->ops;
 
 	VFS_WARN_ON_ONCE(!ns->ns_id);
+	VFS_WARN_ON_ONCE(ns->ns_type != ns_tree->type);
 
 	write_seqlock(&ns_tree_lock);
 
@@ -132,6 +135,21 @@ void __ns_tree_add_raw(struct ns_common *ns, struct ns_tree *ns_tree)
 		list_add_rcu(&ns->ns_list_node, &node_to_ns(prev)->ns_list_node);
 
 	rb_find_add_rcu(&ns->ns_unified_tree_node, &ns_unified_tree, ns_cmp_unified);
+
+	if (ops) {
+		struct user_namespace *user_ns;
+
+		VFS_WARN_ON_ONCE(!ops->owner);
+		user_ns = ops->owner(ns);
+		if (user_ns) {
+			struct ns_common *owner = &user_ns->ns;
+			VFS_WARN_ON_ONCE(owner->ns_type != CLONE_NEWUSER);
+			list_add_tail_rcu(&ns->ns_owner_entry, &owner->ns_owner);
+		} else {
+			/* Only the initial user namespace doesn't have an owner. */
+			VFS_WARN_ON_ONCE(ns != to_ns_common(&init_user_ns));
+		}
+	}
 	write_sequnlock(&ns_tree_lock);
 
 	VFS_WARN_ON_ONCE(node);
@@ -148,6 +166,7 @@ void __ns_tree_remove(struct ns_common *ns, struct ns_tree *ns_tree)
 	rb_erase(&ns->ns_unified_tree_node, &ns_unified_tree);
 	list_bidir_del_rcu(&ns->ns_list_node);
 	RB_CLEAR_NODE(&ns->ns_tree_node);
+	list_bidir_del_rcu(&ns->ns_owner_entry);
 	write_sequnlock(&ns_tree_lock);
 }
 EXPORT_SYMBOL_GPL(__ns_tree_remove);
diff --git a/kernel/pid.c b/kernel/pid.c
index ec9051d387ee..8134c40b2584 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -80,6 +80,8 @@ struct pid_namespace init_pid_ns = {
 	.user_ns = &init_user_ns,
 	.ns.inum = ns_init_inum(&init_pid_ns),
 	.ns.ns_list_node = LIST_HEAD_INIT(init_pid_ns.ns.ns_list_node),
+	.ns.ns_owner_entry = LIST_HEAD_INIT(init_pid_ns.ns.ns_owner_entry),
+	.ns.ns_owner = LIST_HEAD_INIT(init_pid_ns.ns.ns_owner),
 #ifdef CONFIG_PID_NS
 	.ns.ops = &pidns_operations,
 #endif
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index 2e7c110bd13f..15cb74267c75 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -485,6 +485,8 @@ struct time_namespace init_time_ns = {
 	.user_ns	= &init_user_ns,
 	.ns.inum	= ns_init_inum(&init_time_ns),
 	.ns.ops		= &timens_operations,
+	.ns.ns_owner_entry = LIST_HEAD_INIT(init_time_ns.ns.ns_owner_entry),
+	.ns.ns_owner = LIST_HEAD_INIT(init_time_ns.ns.ns_owner),
 	.frozen_offsets	= true,
 	.ns.ns_list_node = LIST_HEAD_INIT(init_time_ns.ns.ns_list_node),
 };
diff --git a/kernel/user.c b/kernel/user.c
index bf60532856db..e392768ccd44 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -72,6 +72,8 @@ struct user_namespace init_user_ns = {
 	.group = GLOBAL_ROOT_GID,
 	.ns.inum = ns_init_inum(&init_user_ns),
 	.ns.ns_list_node = LIST_HEAD_INIT(init_user_ns.ns.ns_list_node),
+	.ns.ns_owner_entry = LIST_HEAD_INIT(init_user_ns.ns.ns_owner_entry),
+	.ns.ns_owner = LIST_HEAD_INIT(init_user_ns.ns.ns_owner),
 #ifdef CONFIG_USER_NS
 	.ns.ops = &userns_operations,
 #endif

-- 
2.47.3


