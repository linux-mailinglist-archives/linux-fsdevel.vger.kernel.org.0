Return-Path: <linux-fsdevel+bounces-61908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6322DB7F775
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 15:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53C6E481A17
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 10:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C0C36C071;
	Wed, 17 Sep 2025 10:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYrFoRFN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC603081A6;
	Wed, 17 Sep 2025 10:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758104954; cv=none; b=sIBKblVDZwChvj2zXZJr45fifZNC/Acy0e+9AUE1T17MU9W658YhLtj1IwfFvsHwxmilA9XW5vD2zXziPi/4/h/dkf68IgAOUK/wE+P9z7i1LqkpJk1kVRDZq3dpqs5x4ZSd0CWo0lfm5E+FwhLClhKjhiialXXK4hzwmAG53N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758104954; c=relaxed/simple;
	bh=CMPBxNtATUlgpLmzq6VKksLBVJ3sJD7dJN0BZeoB1OM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ls6ASdRdArM9ik8Mi7DGJ/XnFA9kDfsQv4KDKHzpGH3/HGXMZnZMkjo/mu0QvuJxFwLN0nmQ4Q66tAUZj6Nw6N4ZupabEs9t1lw1xtpD8ren/i2z15s/EU89vUBUOub+wLp2L0rmUIrhH+l3wbXTxAwyxnrn0v8i36zXFgclZmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYrFoRFN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30FC9C4CEF0;
	Wed, 17 Sep 2025 10:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758104954;
	bh=CMPBxNtATUlgpLmzq6VKksLBVJ3sJD7dJN0BZeoB1OM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VYrFoRFNYQzCzaYSja/GF2tDvQCcNb/PpGEUlxo030BiaNSuGZjhMQku72HxWAYVK
	 zZC8BuCK61SfSgi4zS39RE+te7b9nAxZ9gh08BH/UdCb1iu510xGrklfJK8ssA/sXq
	 7i74HUs1mABhLcKJJf+8Iib+XN3q4+A0Z6t3Ebu0ZBCtcLcKe9Iydie9G372+r5Jig
	 Ej2zBkt4HJgdqeSbCqWN+aur+0pEfPb0FRs39pE16szLuh//lBHiMJCYgfNXQQEvsa
	 Efzu7qL27zSMktCdUVq65EJvNX8d6l60WLbHExua6Mfxggr6/+Kbpx51RknDQpIQUT
	 1MPyGlFMdolAg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 17 Sep 2025 12:28:07 +0200
Subject: [PATCH 8/9] nscommon: simplify initialization
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-work-namespace-ns_common-v1-8-1b3bda8ef8f2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7890; i=brauner@kernel.org;
 h=from:subject:message-id; bh=CMPBxNtATUlgpLmzq6VKksLBVJ3sJD7dJN0BZeoB1OM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSc6vVburvA4+TVUD85l29npL/MVtS/ZZkSdk76vligQ
 85+t0TWjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInMkWRkaFjlc4Dt2MmnKx7Y
 n3c+uLT+39nP6x9n7d20es+mD2kbE44y/Per3WSvHOj0wskzYPmnd7cLA6IbzlXe4Il0a3309uv
 +KhYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

There's a lot of information that namespace implementers don't need to
know about at all. Encapsulate this all in the initialization helper.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c            |  5 +++--
 include/linux/ns_common.h | 41 +++++++++++++++++++++++++++++++++++++++--
 ipc/namespace.c           |  2 +-
 kernel/cgroup/namespace.c |  2 +-
 kernel/nscommon.c         | 17 ++++++++---------
 kernel/pid_namespace.c    |  2 +-
 kernel/time/namespace.c   |  2 +-
 kernel/user_namespace.c   |  2 +-
 kernel/utsname.c          |  2 +-
 net/core/net_namespace.c  |  2 +-
 10 files changed, 57 insertions(+), 20 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 09e4ecd44972..31eb0e8f21eb 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4105,8 +4105,9 @@ static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *user_ns, bool a
 	}
 
 	if (anon)
-		new_ns->ns.inum = MNT_NS_ANON_INO;
-	ret = ns_common_init(&new_ns->ns, &mntns_operations, !anon);
+		ret = ns_common_init_inum(new_ns, &mntns_operations, MNT_NS_ANON_INO);
+	else
+		ret = ns_common_init(new_ns, &mntns_operations);
 	if (ret) {
 		kfree(new_ns);
 		dec_mnt_namespaces(ucounts);
diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index 78b17fe80b62..284bba2b7c43 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -16,6 +16,15 @@ struct time_namespace;
 struct user_namespace;
 struct uts_namespace;
 
+extern struct cgroup_namespace init_cgroup_ns;
+extern struct ipc_namespace init_ipc_ns;
+extern struct mnt_namespace *init_mnt_ns;
+extern struct net init_net;
+extern struct pid_namespace init_pid_ns;
+extern struct time_namespace init_time_ns;
+extern struct user_namespace init_user_ns;
+extern struct uts_namespace init_uts_ns;
+
 struct ns_common {
 	struct dentry *stashed;
 	const struct proc_ns_operations *ops;
@@ -31,8 +40,7 @@ struct ns_common {
 	};
 };
 
-int ns_common_init(struct ns_common *ns, const struct proc_ns_operations *ops,
-		   bool alloc_inum);
+int __ns_common_init(struct ns_common *ns, const struct proc_ns_operations *ops, int inum);
 
 #define to_ns_common(__ns)                              \
 	_Generic((__ns),                                \
@@ -45,4 +53,33 @@ int ns_common_init(struct ns_common *ns, const struct proc_ns_operations *ops,
 		struct user_namespace *:   &(__ns)->ns, \
 		struct uts_namespace *:    &(__ns)->ns)
 
+#define ns_init_inum(__ns)                                     \
+	_Generic((__ns),                                       \
+		struct cgroup_namespace *: CGROUP_NS_INIT_INO, \
+		struct ipc_namespace *:    IPC_NS_INIT_INO,    \
+		struct mnt_namespace *:    MNT_NS_INIT_INO,    \
+		struct net *:              NET_NS_INIT_INO,    \
+		struct pid_namespace *:    PID_NS_INIT_INO,    \
+		struct time_namespace *:   TIME_NS_INIT_INO,   \
+		struct user_namespace *:   USER_NS_INIT_INO,   \
+		struct uts_namespace *:    UTS_NS_INIT_INO)
+
+#define ns_init_ns(__ns)                                    \
+	_Generic((__ns),                                    \
+		struct cgroup_namespace *: &init_cgroup_ns, \
+		struct ipc_namespace *:    &init_ipc_ns,    \
+		struct mnt_namespace *:    init_mnt_ns,     \
+		struct net *:              &init_net,       \
+		struct pid_namespace *:    &init_pid_ns,    \
+		struct time_namespace *:   &init_time_ns,   \
+		struct user_namespace *:   &init_user_ns,   \
+		struct uts_namespace *:    &init_uts_ns)
+
+#define ns_common_init(__ns, __ops) \
+	__ns_common_init(&(__ns)->ns, __ops, \
+		         (((__ns) == ns_init_ns(__ns)) ? ns_init_inum(__ns) : 0))
+
+#define ns_common_init_inum(__ns, __ops, __inum) \
+	__ns_common_init(&(__ns)->ns, __ops, __inum)
+
 #endif
diff --git a/ipc/namespace.c b/ipc/namespace.c
index 89588819956b..0f8bbd18a475 100644
--- a/ipc/namespace.c
+++ b/ipc/namespace.c
@@ -62,7 +62,7 @@ static struct ipc_namespace *create_ipc_ns(struct user_namespace *user_ns,
 	if (ns == NULL)
 		goto fail_dec;
 
-	err = ns_common_init(&ns->ns, &ipcns_operations, true);
+	err = ns_common_init(ns, &ipcns_operations);
 	if (err)
 		goto fail_free;
 
diff --git a/kernel/cgroup/namespace.c b/kernel/cgroup/namespace.c
index 5a327914b565..d928c557e28b 100644
--- a/kernel/cgroup/namespace.c
+++ b/kernel/cgroup/namespace.c
@@ -27,7 +27,7 @@ static struct cgroup_namespace *alloc_cgroup_ns(void)
 	new_ns = kzalloc(sizeof(struct cgroup_namespace), GFP_KERNEL_ACCOUNT);
 	if (!new_ns)
 		return ERR_PTR(-ENOMEM);
-	ret = ns_common_init(&new_ns->ns, &cgroupns_operations, true);
+	ret = ns_common_init(new_ns, &cgroupns_operations);
 	if (ret)
 		return ERR_PTR(ret);
 	ns_tree_add(new_ns);
diff --git a/kernel/nscommon.c b/kernel/nscommon.c
index e10fad8afe61..c3a90bb665ad 100644
--- a/kernel/nscommon.c
+++ b/kernel/nscommon.c
@@ -1,21 +1,20 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <linux/ns_common.h>
+#include <linux/proc_ns.h>
 
-int ns_common_init(struct ns_common *ns, const struct proc_ns_operations *ops,
-		   bool alloc_inum)
+int __ns_common_init(struct ns_common *ns, const struct proc_ns_operations *ops, int inum)
 {
-	if (alloc_inum && !ns->inum) {
-		int ret;
-		ret = proc_alloc_inum(&ns->inum);
-		if (ret)
-			return ret;
-	}
 	refcount_set(&ns->count, 1);
 	ns->stashed = NULL;
 	ns->ops = ops;
 	ns->ns_id = 0;
 	RB_CLEAR_NODE(&ns->ns_tree_node);
 	INIT_LIST_HEAD(&ns->ns_list_node);
-	return 0;
+
+	if (inum) {
+		ns->inum = inum;
+		return 0;
+	}
+	return proc_alloc_inum(&ns->inum);
 }
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 9b327420309e..170757c265c2 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -103,7 +103,7 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
 	if (ns->pid_cachep == NULL)
 		goto out_free_idr;
 
-	err = ns_common_init(&ns->ns, &pidns_operations, true);
+	err = ns_common_init(ns, &pidns_operations);
 	if (err)
 		goto out_free_idr;
 
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index 20b65f90549e..ce8e952104a7 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -97,7 +97,7 @@ static struct time_namespace *clone_time_ns(struct user_namespace *user_ns,
 	if (!ns->vvar_page)
 		goto fail_free;
 
-	err = ns_common_init(&ns->ns, &timens_operations, true);
+	err = ns_common_init(ns, &timens_operations);
 	if (err)
 		goto fail_free_page;
 
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index cfb0e28f2779..db9f0463219c 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -126,7 +126,7 @@ int create_user_ns(struct cred *new)
 
 	ns->parent_could_setfcap = cap_raised(new->cap_effective, CAP_SETFCAP);
 
-	ret = ns_common_init(&ns->ns, &userns_operations, true);
+	ret = ns_common_init(ns, &userns_operations);
 	if (ret)
 		goto fail_free;
 
diff --git a/kernel/utsname.c b/kernel/utsname.c
index a682830742d3..399888be66bd 100644
--- a/kernel/utsname.c
+++ b/kernel/utsname.c
@@ -50,7 +50,7 @@ static struct uts_namespace *clone_uts_ns(struct user_namespace *user_ns,
 	if (!ns)
 		goto fail_dec;
 
-	err = ns_common_init(&ns->ns, &utsns_operations, true);
+	err = ns_common_init(ns, &utsns_operations);
 	if (err)
 		goto fail_free;
 
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 897f4927df9e..fdb266bbdf93 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -409,7 +409,7 @@ static __net_init int preinit_net(struct net *net, struct user_namespace *user_n
 	ns_ops = NULL;
 #endif
 
-	ret = ns_common_init(&net->ns, ns_ops, true);
+	ret = ns_common_init(net, ns_ops);
 	if (ret)
 		return ret;
 

-- 
2.47.3


