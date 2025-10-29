Return-Path: <linux-fsdevel+bounces-66231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9869BC1A3DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F29018965FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67623563D4;
	Wed, 29 Oct 2025 12:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UW8SoFp5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4073833DEFD;
	Wed, 29 Oct 2025 12:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740533; cv=none; b=EoU1riA5M0miSiPAKQ85v7FEbPtsq/vhPQrq2VNDfNQ6DzWCR6hSTcQ88Vs/Gj3q8Kytyzj+4uzo3wRMfKJ5M+p+AaDCcqaSw0Z4vslfYrlYROH+OqYSzOjTuHMLpgqDANRejkQnWE3wtwOGz3C0H5QM3Q6LyYuLqyzgxF2DhNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740533; c=relaxed/simple;
	bh=zBZ8k9vNKGmXFGtRmtowfVJFJn71uOWCNT+vTVEJ+6E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cfUtHSfArPNL1nV6crvMJFiGQLEUusGbNOTMKBJa5Q0a6Hqc9XwrN8V3hYP2/LZ5dsYHU87rlFxI/54ZWYJjFfx6/4ieFsDgohZ302K8R0RCEv/DBdDpZhJ0QPzGs422paTKgewx7RsY7B/xAwhcRtTuGPxOPqs4PNVdu6DL5Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UW8SoFp5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17928C116B1;
	Wed, 29 Oct 2025 12:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740529;
	bh=zBZ8k9vNKGmXFGtRmtowfVJFJn71uOWCNT+vTVEJ+6E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UW8SoFp5uwVT3blwSS8V3GwymHuX9cctb5jeEDv+MYcbnLdjcGquBFCR2vSoMf2Oj
	 Zqz65924uCquVOK2XjRqreA/kxiSb5exO2Dp/+oj6Dg62xohxk/7Ni25nVgpEkmd4o
	 ndhpbWTkZ0f+dCK32Fsa72/1IRACpr7zoe8W7ER1mY7A0c29MrcFNVmXWV3Ubmmkfq
	 KCz6Mq09peOXBWcKVC52DPu94aQP6Z5aEBQUVEj/CnZc8lk4hN0C3vjMcpRYSVF4kL
	 Faj/poPBUYfWPkavsliD/tUmakIghotxGjUiV77Xr+eNqDGgOyP8bMIQcMmA9uXwIl
	 E7W9qyjto1Rsw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:20:31 +0100
Subject: [PATCH v4 18/72] nstree: add unified namespace list
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-18-2e6f823ebdc0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6556; i=brauner@kernel.org;
 h=from:subject:message-id; bh=zBZ8k9vNKGmXFGtRmtowfVJFJn71uOWCNT+vTVEJ+6E=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysfVqWTwJOlr+6aKotNxVR8fnSy+Y3an+plnErp6l0
 cD9ySyno5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCJLGBn+179i+q7H3/GOx+jW
 We7DLIvWPJwbaeo4W7RT7hYP/8eNRYwMe6PTp61VlhGZuOfiD6nf5obvZhX3VKyum+1p9rTsX/M
 EPgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Allow to walk the unified namespace list completely locklessly.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c           |  1 +
 init/version-timestamp.c |  1 +
 ipc/msgutil.c            |  1 +
 kernel/cgroup/cgroup.c   |  1 +
 kernel/nscommon.c        |  1 +
 kernel/nstree.c          | 13 ++++++++++++-
 kernel/pid.c             |  1 +
 kernel/time/namespace.c  |  1 +
 kernel/user.c            |  1 +
 9 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 3e0361c4c138..1cb4cc8f7f5f 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5995,6 +5995,7 @@ struct mnt_namespace init_mnt_ns = {
 	.mounts		= RB_ROOT,
 	.poll		= __WAIT_QUEUE_HEAD_INITIALIZER(init_mnt_ns.poll),
 	.ns.ns_list_node = LIST_HEAD_INIT(init_mnt_ns.ns.ns_list_node),
+	.ns.ns_unified_list_node = LIST_HEAD_INIT(init_mnt_ns.ns.ns_unified_list_node),
 	.ns.ns_owner_entry = LIST_HEAD_INIT(init_mnt_ns.ns.ns_owner_entry),
 	.ns.ns_owner = LIST_HEAD_INIT(init_mnt_ns.ns.ns_owner),
 };
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
index 9fa082e2eb1a..a0eee0785080 100644
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
index bd4cf8bb8a77..affaf91c2074 100644
--- a/kernel/nscommon.c
+++ b/kernel/nscommon.c
@@ -64,6 +64,7 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
 	RB_CLEAR_NODE(&ns->ns_unified_tree_node);
 	RB_CLEAR_NODE(&ns->ns_owner_tree_node);
 	INIT_LIST_HEAD(&ns->ns_list_node);
+	INIT_LIST_HEAD(&ns->ns_unified_list_node);
 	ns->ns_owner_tree = RB_ROOT;
 	INIT_LIST_HEAD(&ns->ns_owner);
 	INIT_LIST_HEAD(&ns->ns_owner_entry);
diff --git a/kernel/nstree.c b/kernel/nstree.c
index 1779fa314a7d..100145e5edd1 100644
--- a/kernel/nstree.c
+++ b/kernel/nstree.c
@@ -8,6 +8,7 @@
 
 __cacheline_aligned_in_smp DEFINE_SEQLOCK(ns_tree_lock);
 static struct rb_root ns_unified_tree = RB_ROOT; /* protected by ns_tree_lock */
+static LIST_HEAD(ns_unified_list); /* protected by ns_tree_lock */
 
 /**
  * struct ns_tree - Namespace tree
@@ -154,7 +155,13 @@ void __ns_tree_add_raw(struct ns_common *ns, struct ns_tree *ns_tree)
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
@@ -203,11 +210,15 @@ void __ns_tree_remove(struct ns_common *ns, struct ns_tree *ns_tree)
 
 	write_seqlock(&ns_tree_lock);
 	rb_erase(&ns->ns_tree_node, &ns_tree->ns_tree);
-	rb_erase(&ns->ns_unified_tree_node, &ns_unified_tree);
 	RB_CLEAR_NODE(&ns->ns_tree_node);
 
 	list_bidir_del_rcu(&ns->ns_list_node);
 
+	rb_erase(&ns->ns_unified_tree_node, &ns_unified_tree);
+	RB_CLEAR_NODE(&ns->ns_unified_tree_node);
+
+	list_bidir_del_rcu(&ns->ns_unified_list_node);
+
 	/* Remove from owner's rbtree if this namespace has an owner */
 	if (ops) {
 		user_ns = ops->owner(ns);
diff --git a/kernel/pid.c b/kernel/pid.c
index 8134c40b2584..22a0440a62fa 100644
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
index f543c4a83229..6a41269b1a5d 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -488,6 +488,7 @@ struct time_namespace init_time_ns = {
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


