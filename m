Return-Path: <linux-fsdevel+bounces-66228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE058C1A3B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CC04188123E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46B534403C;
	Wed, 29 Oct 2025 12:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZjlTTNb/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09181350D44;
	Wed, 29 Oct 2025 12:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740515; cv=none; b=dhr+iLMCnBNXerPlVHcfW6bV5PlfFr2/hP2uW4L1RcTJo7FnsDi/D/41H3+HUFCpx1blupJTruwBUfUwrBa+OzpnbG46Z/Ob5NUYNmauMt8mFt2uUAacIiRyn3OewLTSK/Qq9Gc1x4/TF5rSWbiL5aFFAlGTF9O6v7F9y/V7MBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740515; c=relaxed/simple;
	bh=tqeqM46Pdv4KKERzwHTNlzyJ8qjuiZMaJt3xQME3qZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JJA4MtWO8ZNrd66lCou7t8EGxmoef9oEplrt4XsNfZLG/mI2i45fF1+mvFk70/raci0fML5RYa6X9hx7i2wiHnaLAJYK5RrDNHkP624B4VtuNwvPPGB9l8v1gzUUjOhXJJDRo0nuL7e/wXNNug6jLaHdw07CjNVrCTcJir8bzE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZjlTTNb/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C059C4CEFD;
	Wed, 29 Oct 2025 12:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740514;
	bh=tqeqM46Pdv4KKERzwHTNlzyJ8qjuiZMaJt3xQME3qZo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZjlTTNb/55hGV8B0GxPiRoIXEf4Wxx8lPUjp7Wr/MYxT+X+OmFKIV68BWc/lxBSE0
	 TIaQTAwRQhWGcnatkLVPHYFLVLFiY0ttgdDFOsvB01HonklsqcSaL5ArxSnBeyMsCr
	 MM6l/A5ZLedi19XF9XDhrAun0DY5nxplpkhFGnKC/DRv+BFe7zwAUhbbnRYOI8HSVj
	 M7ghS6wfZB2oB7CIr+E+difKpWeD4kNJWlKkAd2UcE1i0aPoyhKwVyyvm9Pu1yhQQf
	 zdoXgplMMelFbTEQ1xVdvN908NhVbW4VsMOojmSYNWGjckloScon8CGo1fPOpck6ds
	 CeKrvlwoeiJJw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:20:28 +0100
Subject: [PATCH v4 15/72] nstree: assign fixed ids to the initial
 namespaces
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-15-2e6f823ebdc0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6165; i=brauner@kernel.org;
 h=from:subject:message-id; bh=tqeqM46Pdv4KKERzwHTNlzyJ8qjuiZMaJt3xQME3qZo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysfVoXbGtiBeaHp7ePc2Bz2LvnqL699/qb3V0ai/p5
 13deUmpo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCLBvxj+ezQxfoyPqXyYqCi/
 uKVEde0rnZqW1D7t09F978o/TVeQY/hf2HZDgMkhnW/hljLF62rT9z72n8v9YdP8sAfrP0/R8b3
 IDgA=
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
index 85648dfce9be..22b4ff6ba134 100644
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
index dbe4fb18f021..bd6b0a22fd8e 100644
--- a/kernel/nstree.c
+++ b/kernel/nstree.c
@@ -86,8 +86,6 @@ struct ns_tree time_ns_tree = {
 #endif
 };
 
-DEFINE_COOKIE(namespace_cookie);
-
 static inline struct ns_common *node_to_ns(const struct rb_node *node)
 {
 	if (!node)
@@ -302,15 +300,20 @@ struct ns_common *__ns_tree_adjoined_rcu(struct ns_common *ns,
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
index b0e0f22d7b21..83cbec4afcb3 100644
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


