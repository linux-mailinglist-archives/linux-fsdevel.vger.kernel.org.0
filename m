Return-Path: <linux-fsdevel+bounces-61909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C1CB8017F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 16:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 983A41BC4D5C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 10:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A5336CC6B;
	Wed, 17 Sep 2025 10:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gorm2omj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABAD36C089;
	Wed, 17 Sep 2025 10:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758104960; cv=none; b=W5Ampax1tG1Eid8MUbZKLYNZ9NJkTnKkDdGbBazHHaG0lN4ZzKLGhlGc09gsfSWErkNSyazTs8BP2Vv6rVStMOG4fIFcQqS4RGuuJxmqBHpi/T8rWAc/r9lJlJ080Tq9o4AKcTgCmsnUAV/DBZGLl+zG9/KeY9m7nAuwEFl1T60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758104960; c=relaxed/simple;
	bh=ytXUVuRhFL2Z6NxX49D7FGEXV8wRySnj7wZZcy3g2hw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TOvmbhiyo62BhUuysohUdRXAM1Zrh+i2oo5301wtwgXMcGRBslfU5fPj3W4+Ip8YXfm8DePF4ReV05uIiFJdkdVxhLhMfJnVtOs5YnLtyjP7FXD90wtdNcifP3a5FIPqatPJOynux6vSGailCfDSDRmX1vQviqcsCDQUsY3N+CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gorm2omj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C60DC4CEF0;
	Wed, 17 Sep 2025 10:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758104959;
	bh=ytXUVuRhFL2Z6NxX49D7FGEXV8wRySnj7wZZcy3g2hw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Gorm2omjhgozGjfbkc3lGBFqws6mJOT8moEN/MqjLxiy1KyUb1JXEwjpym3JWoU0P
	 4buI4jXUxadgENvkIuXApYHKTrSIkzC32TC1ZjAa/oUCDkEZkEfMy3c4PGqfcFTY5T
	 DUl9abrxXbzi32a2Nr8z8AWrUErNvcOL8q2pynUZpvYeWDuH9Qd/JSqcSjBTQboLTF
	 YOlcVSPwrMWjxT9rzs/KoOPTuKn1zgj4xqH7BsidPzMlGVa5L5Mw8jDYzWaNepjZgw
	 9Xj6K2lyrIbzfxtMjU0NFokOb4FkTeuf776k/C5uVOlC+ptcNAHRo+rzj3UfosZLpC
	 tp5h+vgqL9CYA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 17 Sep 2025 12:28:08 +0200
Subject: [PATCH 9/9] ns: add ns_common_free()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-work-namespace-ns_common-v1-9-1b3bda8ef8f2@kernel.org>
References: <20250917-work-namespace-ns_common-v1-0-1b3bda8ef8f2@kernel.org>
In-Reply-To: <20250917-work-namespace-ns_common-v1-0-1b3bda8ef8f2@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-56183
X-Developer-Signature: v=1; a=openpgp-sha256; l=7062; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ytXUVuRhFL2Z6NxX49D7FGEXV8wRySnj7wZZcy3g2hw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSc6vU7VnPgb5xAyW3ru5V2F6bNdJEx0rRf6FFx0KPt/
 urP5qrGHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPZkcnwv/iTuOi5/4scpDjm
 OK768M1ubqKuZFuX4ObDDAoyr2w/6DH89zJ+us/AS9fx8eu7re0T/rC17m3gX73hfKVQYN4jdsZ
 yVgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

And drop ns_free_inum(). Anything common that can be wasted centrally
should be wasted in the new common helper.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c            | 4 ++--
 include/linux/ns_common.h | 3 +++
 include/linux/proc_ns.h   | 2 --
 ipc/namespace.c           | 4 ++--
 kernel/cgroup/namespace.c | 2 +-
 kernel/nscommon.c         | 5 +++++
 kernel/pid_namespace.c    | 4 ++--
 kernel/time/namespace.c   | 2 +-
 kernel/user_namespace.c   | 4 ++--
 kernel/utsname.c          | 2 +-
 net/core/net_namespace.c  | 4 ++--
 11 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 31eb0e8f21eb..03bd04559e69 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4083,7 +4083,7 @@ static void dec_mnt_namespaces(struct ucounts *ucounts)
 static void free_mnt_ns(struct mnt_namespace *ns)
 {
 	if (!is_anon_ns(ns))
-		ns_free_inum(&ns->ns);
+		ns_common_free(ns);
 	dec_mnt_namespaces(ns->ucounts);
 	mnt_ns_tree_remove(ns);
 }
@@ -4155,7 +4155,7 @@ struct mnt_namespace *copy_mnt_ns(unsigned long flags, struct mnt_namespace *ns,
 	new = copy_tree(old, old->mnt.mnt_root, copy_flags);
 	if (IS_ERR(new)) {
 		namespace_unlock();
-		ns_free_inum(&new_ns->ns);
+		ns_common_free(ns);
 		dec_mnt_namespaces(new_ns->ucounts);
 		mnt_ns_release(new_ns);
 		return ERR_CAST(new);
diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index 284bba2b7c43..5094c0147b54 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -41,6 +41,7 @@ struct ns_common {
 };
 
 int __ns_common_init(struct ns_common *ns, const struct proc_ns_operations *ops, int inum);
+void __ns_common_free(struct ns_common *ns);
 
 #define to_ns_common(__ns)                              \
 	_Generic((__ns),                                \
@@ -82,4 +83,6 @@ int __ns_common_init(struct ns_common *ns, const struct proc_ns_operations *ops,
 #define ns_common_init_inum(__ns, __ops, __inum) \
 	__ns_common_init(&(__ns)->ns, __ops, __inum)
 
+#define ns_common_free(__ns) __ns_common_free(to_ns_common((__ns)))
+
 #endif
diff --git a/include/linux/proc_ns.h b/include/linux/proc_ns.h
index 9f21670b5824..08016f6e0e6f 100644
--- a/include/linux/proc_ns.h
+++ b/include/linux/proc_ns.h
@@ -66,8 +66,6 @@ static inline void proc_free_inum(unsigned int inum) {}
 
 #endif /* CONFIG_PROC_FS */
 
-#define ns_free_inum(ns) proc_free_inum((ns)->inum)
-
 #define get_proc_ns(inode) ((struct ns_common *)(inode)->i_private)
 
 #endif /* _LINUX_PROC_NS_H */
diff --git a/ipc/namespace.c b/ipc/namespace.c
index 0f8bbd18a475..09d261a1a2aa 100644
--- a/ipc/namespace.c
+++ b/ipc/namespace.c
@@ -97,7 +97,7 @@ static struct ipc_namespace *create_ipc_ns(struct user_namespace *user_ns,
 
 fail_put:
 	put_user_ns(ns->user_ns);
-	ns_free_inum(&ns->ns);
+	ns_common_free(ns);
 fail_free:
 	kfree(ns);
 fail_dec:
@@ -161,7 +161,7 @@ static void free_ipc_ns(struct ipc_namespace *ns)
 
 	dec_ipc_namespaces(ns->ucounts);
 	put_user_ns(ns->user_ns);
-	ns_free_inum(&ns->ns);
+	ns_common_free(ns);
 	kfree(ns);
 }
 
diff --git a/kernel/cgroup/namespace.c b/kernel/cgroup/namespace.c
index d928c557e28b..16ead7508371 100644
--- a/kernel/cgroup/namespace.c
+++ b/kernel/cgroup/namespace.c
@@ -40,7 +40,7 @@ void free_cgroup_ns(struct cgroup_namespace *ns)
 	put_css_set(ns->root_cset);
 	dec_cgroup_namespaces(ns->ucounts);
 	put_user_ns(ns->user_ns);
-	ns_free_inum(&ns->ns);
+	ns_common_free(ns);
 	/* Concurrent nstree traversal depends on a grace period. */
 	kfree_rcu(ns, ns.ns_rcu);
 }
diff --git a/kernel/nscommon.c b/kernel/nscommon.c
index c3a90bb665ad..7c1b07e2a6c9 100644
--- a/kernel/nscommon.c
+++ b/kernel/nscommon.c
@@ -18,3 +18,8 @@ int __ns_common_init(struct ns_common *ns, const struct proc_ns_operations *ops,
 	}
 	return proc_alloc_inum(&ns->inum);
 }
+
+void __ns_common_free(struct ns_common *ns)
+{
+	proc_free_inum(ns->inum);
+}
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 170757c265c2..27e2dd9ee051 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -127,7 +127,7 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
 	return ns;
 
 out_free_inum:
-	ns_free_inum(&ns->ns);
+	ns_common_free(ns);
 out_free_idr:
 	idr_destroy(&ns->idr);
 	kmem_cache_free(pid_ns_cachep, ns);
@@ -152,7 +152,7 @@ static void destroy_pid_namespace(struct pid_namespace *ns)
 	ns_tree_remove(ns);
 	unregister_pidns_sysctls(ns);
 
-	ns_free_inum(&ns->ns);
+	ns_common_free(ns);
 
 	idr_destroy(&ns->idr);
 	call_rcu(&ns->rcu, delayed_free_pidns);
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index ce8e952104a7..d49c73015d6e 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -255,7 +255,7 @@ void free_time_ns(struct time_namespace *ns)
 	ns_tree_remove(ns);
 	dec_time_namespaces(ns->ucounts);
 	put_user_ns(ns->user_ns);
-	ns_free_inum(&ns->ns);
+	ns_common_free(ns);
 	__free_page(ns->vvar_page);
 	/* Concurrent nstree traversal depends on a grace period. */
 	kfree_rcu(ns, ns.ns_rcu);
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index db9f0463219c..32406bcab526 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -165,7 +165,7 @@ int create_user_ns(struct cred *new)
 #ifdef CONFIG_PERSISTENT_KEYRINGS
 	key_put(ns->persistent_keyring_register);
 #endif
-	ns_free_inum(&ns->ns);
+	ns_common_free(ns);
 fail_free:
 	kmem_cache_free(user_ns_cachep, ns);
 fail_dec:
@@ -220,7 +220,7 @@ static void free_user_ns(struct work_struct *work)
 #endif
 		retire_userns_sysctls(ns);
 		key_free_user_ns(ns);
-		ns_free_inum(&ns->ns);
+		ns_common_free(ns);
 		/* Concurrent nstree traversal depends on a grace period. */
 		kfree_rcu(ns, ns.ns_rcu);
 		dec_user_namespaces(ucounts);
diff --git a/kernel/utsname.c b/kernel/utsname.c
index 399888be66bd..95d733eb2c98 100644
--- a/kernel/utsname.c
+++ b/kernel/utsname.c
@@ -98,7 +98,7 @@ void free_uts_ns(struct uts_namespace *ns)
 	ns_tree_remove(ns);
 	dec_uts_namespaces(ns->ucounts);
 	put_user_ns(ns->user_ns);
-	ns_free_inum(&ns->ns);
+	ns_common_free(ns);
 	/* Concurrent nstree traversal depends on a grace period. */
 	kfree_rcu(ns, ns.ns_rcu);
 }
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index fdb266bbdf93..fdbaf5f8ac78 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -597,7 +597,7 @@ struct net *copy_net_ns(unsigned long flags,
 		net_passive_dec(net);
 dec_ucounts:
 		dec_net_namespaces(ucounts);
-		ns_free_inum(&net->ns);
+		ns_common_free(net);
 		return ERR_PTR(rv);
 	}
 	return net;
@@ -719,7 +719,7 @@ static void cleanup_net(struct work_struct *work)
 #endif
 		put_user_ns(net->user_ns);
 		net_passive_dec(net);
-		ns_free_inum(&net->ns);
+		ns_common_free(net);
 	}
 	WRITE_ONCE(cleanup_net_task, NULL);
 }

-- 
2.47.3


