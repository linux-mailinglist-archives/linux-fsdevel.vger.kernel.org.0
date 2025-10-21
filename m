Return-Path: <linux-fsdevel+bounces-64864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4DBBF6262
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 13:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0F941883E12
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 11:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03E03321DB;
	Tue, 21 Oct 2025 11:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWW3VcX0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD1F3321CC;
	Tue, 21 Oct 2025 11:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047098; cv=none; b=mjCFhziS1Hh6I2/b0IUlmsUh2GJoWUNl8qBbJNOwFAtwrEWMXa3IpceTKJ55e08UNwI8k5EMM6yRJUmABvWLUWlX7a9SqKj7UyMVqWJVPfNinonOVsK97LzsxH2bmMhnNnCtxoiLgbjvBOm+YqjZ+0CKJUGnJoRJ6oU2LEung1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047098; c=relaxed/simple;
	bh=0Z06FS7PHlmbbOXNaiYAotrcXY1wE2OxBYSA5XT3a6Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sp8RRxWW2FYxzx2nxw29k0TbSkl7qzK8O8PHt0WmbUc9OzhaVYmoLh0pDPqZmar3HIEmgD4nLAUUqAQUg54A0556VUts7RIePuNzQq5n+65hfpLdyBVDBCYzLJYoF6MJkNAYiVs0eYQhhHlWCB0cDXx9AeSgWZY28lCjdXROlFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWW3VcX0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88277C4CEF1;
	Tue, 21 Oct 2025 11:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761047098;
	bh=0Z06FS7PHlmbbOXNaiYAotrcXY1wE2OxBYSA5XT3a6Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kWW3VcX0M3TMk7YVqkSZ5+lzz5RaH52E946bVAWpoMZ+bojRkGGiUHfTN+k54qy57
	 Xa5U4BLkIRt/3uHrP5aLHxriLfM1hVdd8H7pQ7XbUFSagZz0fWWwOcMgYI6HFL8ISt
	 +JMN+R4Jh0zWJnnb+76N8X3SG80SIYZyU4HE2Omtiz5s6SVM5mBdt69NQK57m06ToI
	 e/8UlJq1/5QPq9qe+80aoBil2nQM+zQ9KV/1R9knS1UR6SvF6cC2+uFhvdpFav7ALG
	 BCbdCteAiXlRQGTEnJVxzdiI2A/prMsAVm1kNBvBcNsuKrSEfYuwOPDIDRojD7vuBd
	 2R9/YW32RMMzQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 21 Oct 2025 13:43:19 +0200
Subject: [PATCH RFC DRAFT 13/50] nstree: assign fixed ids to the initial
 namespaces
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-work-namespace-nstree-listns-v1-13-ad44261a8a5b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6182; i=brauner@kernel.org;
 h=from:subject:message-id; bh=0Z06FS7PHlmbbOXNaiYAotrcXY1wE2OxBYSA5XT3a6Q=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR8L3xbILydectXo2lu822310eb6Z3pzlfRXX8isEGB3
 Vbm0jLujlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlIWjEyPPZw0+WNZ/vffs7b
 Ol96TbTH5q3Kx3kWvlz1cfa9Sp02B0aGWQe7O5l++z6Vf9MyIzN5tkICS37kze/3KqdWNXyLW/u
 RFwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The initial set of namespace comes with fixed inode numbers making it
easy for userspace to identify them solely based on that information.
This has long preceeded anything here.

Similarly, let's assign fixed namespace ids for the initial namespaces.

Kill the cookie and use a sequentially increasing number. This has the
nice side-effect that the owning user namespace will always have a
namespace id that is smaller than any of it's descendant namespaces.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c            |  2 +-
 include/linux/nstree.h    | 26 ++++++++++++++++++++++----
 include/uapi/linux/nsfs.h | 14 ++++++++++++++
 kernel/nstree.c           | 13 ++++++++-----
 net/core/net_namespace.c  |  2 +-
 5 files changed, 46 insertions(+), 11 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 87116def5ee3..5d8a80e1e944 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4094,7 +4094,7 @@ static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *user_ns, bool a
 		return ERR_PTR(ret);
 	}
 	if (!anon)
-		ns_tree_gen_id(&new_ns->ns);
+		ns_tree_gen_id(new_ns);
 	refcount_set(&new_ns->passive, 1);
 	new_ns->mounts = RB_ROOT;
 	init_waitqueue_head(&new_ns->poll);
diff --git a/include/linux/nstree.h b/include/linux/nstree.h
index 8b8636690473..96ee71622517 100644
--- a/include/linux/nstree.h
+++ b/include/linux/nstree.h
@@ -8,6 +8,7 @@
 #include <linux/seqlock.h>
 #include <linux/rculist.h>
 #include <linux/cookie.h>
+#include <uapi/linux/nsfs.h>
 
 extern struct ns_tree cgroup_ns_tree;
 extern struct ns_tree ipc_ns_tree;
@@ -29,7 +30,22 @@ extern struct ns_tree uts_ns_tree;
 		struct user_namespace *:   &(user_ns_tree),	\
 		struct uts_namespace *:    &(uts_ns_tree))
 
-u64 ns_tree_gen_id(struct ns_common *ns);
+#define ns_init_id(__ns)				      \
+	_Generic((__ns),                                      \
+		struct cgroup_namespace *: CGROUP_NS_INIT_ID, \
+		struct ipc_namespace *:    IPC_NS_INIT_ID,    \
+		struct mnt_namespace *:    MNT_NS_INIT_ID,    \
+		struct net *:              NET_NS_INIT_ID,    \
+		struct pid_namespace *:    PID_NS_INIT_ID,    \
+		struct time_namespace *:   TIME_NS_INIT_ID,   \
+		struct user_namespace *:   USER_NS_INIT_ID,   \
+		struct uts_namespace *:    UTS_NS_INIT_ID)
+
+#define ns_tree_gen_id(__ns)                 \
+	__ns_tree_gen_id(to_ns_common(__ns), \
+			 (((__ns) == ns_init_ns(__ns)) ? ns_init_id(__ns) : 0))
+
+u64 __ns_tree_gen_id(struct ns_common *ns, u64 id);
 void __ns_tree_add_raw(struct ns_common *ns, struct ns_tree *ns_tree);
 void __ns_tree_remove(struct ns_common *ns, struct ns_tree *ns_tree);
 struct ns_common *ns_tree_lookup_rcu(u64 ns_id, int ns_type);
@@ -37,9 +53,9 @@ struct ns_common *__ns_tree_adjoined_rcu(struct ns_common *ns,
 					 struct ns_tree *ns_tree,
 					 bool previous);
 
-static inline void __ns_tree_add(struct ns_common *ns, struct ns_tree *ns_tree)
+static inline void __ns_tree_add(struct ns_common *ns, struct ns_tree *ns_tree, u64 id)
 {
-	ns_tree_gen_id(ns);
+	__ns_tree_gen_id(ns, id);
 	__ns_tree_add_raw(ns, ns_tree);
 }
 
@@ -59,7 +75,9 @@ static inline void __ns_tree_add(struct ns_common *ns, struct ns_tree *ns_tree)
  * This function assigns a new id to the namespace and adds it to the
  * appropriate namespace tree and list.
  */
-#define ns_tree_add(__ns) __ns_tree_add(to_ns_common(__ns), to_ns_tree(__ns))
+#define ns_tree_add(__ns)                                   \
+	__ns_tree_add(to_ns_common(__ns), to_ns_tree(__ns), \
+		      (((__ns) == ns_init_ns(__ns)) ? ns_init_id(__ns) : 0))
 
 /**
  * ns_tree_remove - Remove a namespace from a namespace tree
diff --git a/include/uapi/linux/nsfs.h b/include/uapi/linux/nsfs.h
index e098759ec917..f8bc2aad74d6 100644
--- a/include/uapi/linux/nsfs.h
+++ b/include/uapi/linux/nsfs.h
@@ -67,4 +67,18 @@ struct nsfs_file_handle {
 #define NSFS_FILE_HANDLE_SIZE_VER0 16 /* sizeof first published struct */
 #define NSFS_FILE_HANDLE_SIZE_LATEST sizeof(struct nsfs_file_handle) /* sizeof latest published struct */
 
+enum init_ns_id {
+	IPC_NS_INIT_ID		= 1ULL,
+	UTS_NS_INIT_ID		= 2ULL,
+	USER_NS_INIT_ID		= 3ULL,
+	PID_NS_INIT_ID		= 4ULL,
+	CGROUP_NS_INIT_ID	= 5ULL,
+	TIME_NS_INIT_ID		= 6ULL,
+	NET_NS_INIT_ID		= 7ULL,
+	MNT_NS_INIT_ID		= 8ULL,
+#ifdef __KERNEL__
+	NS_LAST_INIT_ID		= MNT_NS_INIT_ID,
+#endif
+};
+
 #endif /* __LINUX_NSFS_H */
diff --git a/kernel/nstree.c b/kernel/nstree.c
index d21df06b6747..de5ceda44637 100644
--- a/kernel/nstree.c
+++ b/kernel/nstree.c
@@ -68,8 +68,6 @@ struct ns_tree time_ns_tree = {
 	.type = CLONE_NEWTIME,
 };
 
-DEFINE_COOKIE(namespace_cookie);
-
 static inline struct ns_common *node_to_ns(const struct rb_node *node)
 {
 	if (!node)
@@ -278,15 +276,20 @@ struct ns_common *__ns_tree_adjoined_rcu(struct ns_common *ns,
 /**
  * ns_tree_gen_id - generate a new namespace id
  * @ns: namespace to generate id for
+ * @id: if non-zero, this is the initial namespace and this is a fixed id
  *
  * Generates a new namespace id and assigns it to the namespace. All
  * namespaces types share the same id space and thus can be compared
  * directly. IOW, when two ids of two namespace are equal, they are
  * identical.
  */
-u64 ns_tree_gen_id(struct ns_common *ns)
+u64 __ns_tree_gen_id(struct ns_common *ns, u64 id)
 {
-	guard(preempt)();
-	ns->ns_id = gen_cookie_next(&namespace_cookie);
+	static atomic64_t namespace_cookie = ATOMIC64_INIT(NS_LAST_INIT_ID + 1);
+
+	if (id)
+		ns->ns_id = id;
+	else
+		ns->ns_id = atomic64_inc_return(&namespace_cookie);
 	return ns->ns_id;
 }
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index f30fb78f020c..a76b9b9709d6 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -439,7 +439,7 @@ static __net_init int setup_net(struct net *net)
 	LIST_HEAD(net_exit_list);
 	int error = 0;
 
-	net->net_cookie = ns_tree_gen_id(&net->ns);
+	net->net_cookie = ns_tree_gen_id(net);
 
 	list_for_each_entry(ops, &pernet_list, list) {
 		error = ops_init(ops, net);

-- 
2.47.3


