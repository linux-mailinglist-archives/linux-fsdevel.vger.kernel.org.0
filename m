Return-Path: <linux-fsdevel+bounces-62397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF39DB912CD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 14:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 342BC18A0C1E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 12:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F403B30ACEA;
	Mon, 22 Sep 2025 12:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6M05OIb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5000C306B24;
	Mon, 22 Sep 2025 12:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758544977; cv=none; b=ZZGsGTJMttC/9SyEopFnNqPA7tMzxolIxob4THGzMv3xyurMJmpYUYBJU4PZtoKzTPyy0+5cquPbgL0Oa0She4iPWigjk8CW0f7fl7i/FUgFmD1aZ7hXn+4n48C0N+tWZCu+FgC9yE2P1MS6EiyDTKVv6ymUXwBYhKn5BRPpiQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758544977; c=relaxed/simple;
	bh=Vk3NS+k0XxRhYp+lepoAJRH3NoVQr4il7ukecn/Ropc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z3HeL5j/OFemPSWTZC1oBZI0cil8f15c4Tw5+BXSr9er2YR7Pn6HscXLqn7Akxd7Qcqe3OrLRDufdi28zcWjMT7HtUaJT9icC5ZWfkD7ea801Xyn1dnDddGLPwExwBxWFKabI/vAQuk/3+f0bKmDi7xhCO8qh1cLQhkiUofeOV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6M05OIb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21EAC4CEF0;
	Mon, 22 Sep 2025 12:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758544976;
	bh=Vk3NS+k0XxRhYp+lepoAJRH3NoVQr4il7ukecn/Ropc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Y6M05OIbHb1z9HyM78GPmPcHrTeZfTyavzUKzD4s42wdbSiGNv9rmrK+CeTszTErc
	 aoOcHlVjmUkmtRbZvjGD6pOje1YN5sX8E63xEJ3Xv1X2X/AiQ8alG7vIrACenzERDk
	 nfTLb+IqBF9I3DCJMkkT0XDodqOt1esfkpElIxXlSHf6tVASCCAdRM9nsh6U1SXX9X
	 0vLzEwdXssvW+2FtNTAXZ28Wxxjc3g6U79X8ORSghGd0OdW3GYmMpUo1Ve7VNbib3x
	 gO2I7P7boJ+Dj8gLqxsrv9nR2xpOlmLx6Qpi4faYGLtx9hoeXuS4iYVOFaFlDZFotF
	 2LLHr6CXzsgtQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 22 Sep 2025 14:42:36 +0200
Subject: [PATCH 2/3] ns: simplify ns_common_init() further
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-work-namespace-ns_common-fixes-v1-2-3c26aeb30831@kernel.org>
References: <20250922-work-namespace-ns_common-fixes-v1-0-3c26aeb30831@kernel.org>
In-Reply-To: <20250922-work-namespace-ns_common-fixes-v1-0-3c26aeb30831@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, Aleksa Sarai <cyphar@cyphar.com>, 
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7072; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Vk3NS+k0XxRhYp+lepoAJRH3NoVQr4il7ukecn/Ropc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRcdHFWeniH55HMCmvPl+mMF1n3Hft0mPHjqi0PeFmnd
 iUvkt9zvKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAidSUM/yw4TDmdG2IEjjye
 E3b+R97NxK1pP8/MdXjwNqhQzCWtZjnD/+qvPfEbz108e3RL28tdDz4INh1h/3PQOOHYtS22AY0
 TS1kA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Simply derive the ns operations from the namespace type.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c            |  4 ++--
 include/linux/ns_common.h | 30 ++++++++++++++++++++++++++----
 ipc/namespace.c           |  2 +-
 kernel/cgroup/namespace.c |  2 +-
 kernel/pid_namespace.c    |  2 +-
 kernel/time/namespace.c   |  2 +-
 kernel/user_namespace.c   |  2 +-
 kernel/utsname.c          |  2 +-
 net/core/net_namespace.c  |  9 +--------
 9 files changed, 35 insertions(+), 20 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 271cd6294c8a..d65917ec5544 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4104,9 +4104,9 @@ static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *user_ns, bool a
 	}
 
 	if (anon)
-		ret = ns_common_init_inum(new_ns, &mntns_operations, MNT_NS_ANON_INO);
+		ret = ns_common_init_inum(new_ns, MNT_NS_ANON_INO);
 	else
-		ret = ns_common_init(new_ns, &mntns_operations);
+		ret = ns_common_init(new_ns);
 	if (ret) {
 		kfree(new_ns);
 		dec_mnt_namespaces(ucounts);
diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index aea8528d799a..56492cd9ff8d 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -25,6 +25,17 @@ extern struct time_namespace init_time_ns;
 extern struct user_namespace init_user_ns;
 extern struct uts_namespace init_uts_ns;
 
+extern const struct proc_ns_operations netns_operations;
+extern const struct proc_ns_operations utsns_operations;
+extern const struct proc_ns_operations ipcns_operations;
+extern const struct proc_ns_operations pidns_operations;
+extern const struct proc_ns_operations pidns_for_children_operations;
+extern const struct proc_ns_operations userns_operations;
+extern const struct proc_ns_operations mntns_operations;
+extern const struct proc_ns_operations cgroupns_operations;
+extern const struct proc_ns_operations timens_operations;
+extern const struct proc_ns_operations timens_for_children_operations;
+
 struct ns_common {
 	struct dentry *stashed;
 	const struct proc_ns_operations *ops;
@@ -84,10 +95,21 @@ void __ns_common_free(struct ns_common *ns);
 		struct user_namespace *:   &init_user_ns,   \
 		struct uts_namespace *:    &init_uts_ns)
 
-#define ns_common_init(__ns, __ops) \
-	__ns_common_init(to_ns_common(__ns), __ops, (((__ns) == ns_init_ns(__ns)) ? ns_init_inum(__ns) : 0))
-
-#define ns_common_init_inum(__ns, __ops, __inum) __ns_common_init(to_ns_common(__ns), __ops, __inum)
+#define to_ns_operations(__ns)                                                                         \
+	_Generic((__ns),                                                                               \
+		struct cgroup_namespace *: (IS_ENABLED(CONFIG_CGROUPS) ? &cgroupns_operations : NULL), \
+		struct ipc_namespace *:    (IS_ENABLED(CONFIG_IPC_NS)  ? &ipcns_operations    : NULL), \
+		struct mnt_namespace *:    &mntns_operations,                                          \
+		struct net *:              (IS_ENABLED(CONFIG_NET_NS)  ? &netns_operations    : NULL), \
+		struct pid_namespace *:    (IS_ENABLED(CONFIG_PID_NS)  ? &pidns_operations    : NULL), \
+		struct time_namespace *:   (IS_ENABLED(CONFIG_TIME_NS) ? &timens_operations   : NULL), \
+		struct user_namespace *:   (IS_ENABLED(CONFIG_USER_NS) ? &userns_operations   : NULL), \
+		struct uts_namespace *:    (IS_ENABLED(CONFIG_UTS_NS)  ? &utsns_operations    : NULL))
+
+#define ns_common_init(__ns) \
+	__ns_common_init(to_ns_common(__ns), to_ns_operations(__ns), (((__ns) == ns_init_ns(__ns)) ? ns_init_inum(__ns) : 0))
+
+#define ns_common_init_inum(__ns, __inum) __ns_common_init(to_ns_common(__ns), to_ns_operations(__ns), __inum)
 
 #define ns_common_free(__ns) __ns_common_free(to_ns_common((__ns)))
 
diff --git a/ipc/namespace.c b/ipc/namespace.c
index bd85d1c9d2c2..d89dfd718d2b 100644
--- a/ipc/namespace.c
+++ b/ipc/namespace.c
@@ -62,7 +62,7 @@ static struct ipc_namespace *create_ipc_ns(struct user_namespace *user_ns,
 	if (ns == NULL)
 		goto fail_dec;
 
-	err = ns_common_init(ns, &ipcns_operations);
+	err = ns_common_init(ns);
 	if (err)
 		goto fail_free;
 
diff --git a/kernel/cgroup/namespace.c b/kernel/cgroup/namespace.c
index 16ead7508371..04c98338ac08 100644
--- a/kernel/cgroup/namespace.c
+++ b/kernel/cgroup/namespace.c
@@ -27,7 +27,7 @@ static struct cgroup_namespace *alloc_cgroup_ns(void)
 	new_ns = kzalloc(sizeof(struct cgroup_namespace), GFP_KERNEL_ACCOUNT);
 	if (!new_ns)
 		return ERR_PTR(-ENOMEM);
-	ret = ns_common_init(new_ns, &cgroupns_operations);
+	ret = ns_common_init(new_ns);
 	if (ret)
 		return ERR_PTR(ret);
 	ns_tree_add(new_ns);
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 162f5fb63d75..a262a3f19443 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -103,7 +103,7 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
 	if (ns->pid_cachep == NULL)
 		goto out_free_idr;
 
-	err = ns_common_init(ns, &pidns_operations);
+	err = ns_common_init(ns);
 	if (err)
 		goto out_free_idr;
 
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index 7aa4d6fedd49..9f26e61be044 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -97,7 +97,7 @@ static struct time_namespace *clone_time_ns(struct user_namespace *user_ns,
 	if (!ns->vvar_page)
 		goto fail_free;
 
-	err = ns_common_init(ns, &timens_operations);
+	err = ns_common_init(ns);
 	if (err)
 		goto fail_free_page;
 
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index f9df45c46235..e1559e8a8a02 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -126,7 +126,7 @@ int create_user_ns(struct cred *new)
 
 	ns->parent_could_setfcap = cap_raised(new->cap_effective, CAP_SETFCAP);
 
-	ret = ns_common_init(ns, &userns_operations);
+	ret = ns_common_init(ns);
 	if (ret)
 		goto fail_free;
 
diff --git a/kernel/utsname.c b/kernel/utsname.c
index 95d733eb2c98..00001592ad13 100644
--- a/kernel/utsname.c
+++ b/kernel/utsname.c
@@ -50,7 +50,7 @@ static struct uts_namespace *clone_uts_ns(struct user_namespace *user_ns,
 	if (!ns)
 		goto fail_dec;
 
-	err = ns_common_init(ns, &utsns_operations);
+	err = ns_common_init(ns);
 	if (err)
 		goto fail_free;
 
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index d5e3fd819163..bdea7d5fac56 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -400,16 +400,9 @@ static __net_init void preinit_net_sysctl(struct net *net)
 /* init code that must occur even if setup_net() is not called. */
 static __net_init int preinit_net(struct net *net, struct user_namespace *user_ns)
 {
-	const struct proc_ns_operations *ns_ops;
 	int ret;
 
-#ifdef CONFIG_NET_NS
-	ns_ops = &netns_operations;
-#else
-	ns_ops = NULL;
-#endif
-
-	ret = ns_common_init(net, ns_ops);
+	ret = ns_common_init(net);
 	if (ret)
 		return ret;
 

-- 
2.47.3


