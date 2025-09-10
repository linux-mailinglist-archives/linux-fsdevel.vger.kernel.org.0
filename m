Return-Path: <linux-fsdevel+bounces-60799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A36B51A1B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 16:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E356A7BF8BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 14:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F70C36CC8A;
	Wed, 10 Sep 2025 14:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwjpvgeA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D7632C312;
	Wed, 10 Sep 2025 14:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515176; cv=none; b=FbX9yBOq05CcIT25tO+o2ZtZJELaFXJOczMZroDRgBSuLqXSd4dBEalPgMK+LREeiODj0J4CaTX3djv6MmC3PRTxH9WCb+2fRVYZtgDaxj32Y6SoxsPqDxEvvsaQuB32To0vJmkY6v62gkBT7KtBVL1muArjTVgSOFY2Kt0uXrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515176; c=relaxed/simple;
	bh=IZBqhhmgsdKD2MSFlaiE8lz6qiN3IyHlYbx4M51Kx84=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qtfiWe0qdA70j+qA33xXjmpRgrzNCp/OarKXAIegHWowkoK9EGfXBdfFUOxALQDEyYJRsJ6F4PFba1ZxbDYQKmuhu9aDCcOnLyIIAxvqDCbYupzREJEM+HPkgpAvjuWBb5xeuwdQnQCV5LS9VUwJO42LwGYnmR2kKmd3xBcn3PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwjpvgeA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AED0C4CEF8;
	Wed, 10 Sep 2025 14:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757515175;
	bh=IZBqhhmgsdKD2MSFlaiE8lz6qiN3IyHlYbx4M51Kx84=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XwjpvgeAvKerYcTwQ3qKUxDm+uYFGTmQxfpAB/lYCgi9LfyVmLsqRWlurjlP+8xp8
	 AoqSLl9FOA2HECcba5PRE5GTes1dutL15LxoIT4UUbf11A9Z+QweEkww6047gjyofp
	 8KGL7p8KfCj7eJj4QnECbvNg4up/suDKaBwRewRwj5jAjNm0+xsJ0Orl8+DPlrOS/Y
	 DTdBJOu5Hv7lFMmrN+1qy6mqBacuWLy0wR72QxEU3hgmf9PphOvIPFIVKwTXG5hLPy
	 v0IItvTeg3pF69fe8NuMpu6syrRaR2uEZJJy/d0SSVFLfpziEJ6bjxoyQkjapG56ek
	 PJhlw30xXJThA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 10 Sep 2025 16:37:10 +0200
Subject: [PATCH 25/32] ns: add to_<type>_ns() to respective headers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-work-namespace-v1-25-4dd56e7359d8@kernel.org>
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
In-Reply-To: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
To: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 netdev@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.14.3-dev-385fa
X-Developer-Signature: v=1; a=openpgp-sha256; l=8276; i=brauner@kernel.org;
 h=from:subject:message-id; bh=IZBqhhmgsdKD2MSFlaiE8lz6qiN3IyHlYbx4M51Kx84=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc7OU8r9/wYd4zq+/fu0TbZ6ceaW8K/925OeJtVuejb
 aqMx3JOdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyk+xDDX1G92juz9Crfdncm
 Muo95+ePWLWVsaV9QRbPz12XFF0zrzH84fjtNckopN3wYvvfmF+3PPIPvW7b+EKl70Cryb3iA6F
 crAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Every namespace type has a container_of(ns, <ns_type>, ns) static inline
function that is currently not exposed in the header. So we have a bunch
of places that open-code it via container_of(). Move it to the headers
so we can use it directly.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/cgroup.h         | 5 +++++
 include/linux/ipc_namespace.h  | 5 +++++
 include/linux/pid_namespace.h  | 5 +++++
 include/linux/time_namespace.h | 4 ++++
 include/linux/user_namespace.h | 5 +++++
 include/linux/utsname.h        | 5 +++++
 include/net/net_namespace.h    | 5 +++++
 ipc/namespace.c                | 5 -----
 kernel/cgroup/namespace.c      | 5 -----
 kernel/pid_namespace.c         | 5 -----
 kernel/time/namespace.c        | 5 -----
 kernel/user_namespace.c        | 5 -----
 kernel/utsname.c               | 5 -----
 net/core/net_namespace.c       | 5 -----
 14 files changed, 34 insertions(+), 35 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index b18fb5fcb38e..9ca25346f7cb 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -794,6 +794,11 @@ extern struct cgroup_namespace init_cgroup_ns;
 
 #ifdef CONFIG_CGROUPS
 
+static inline struct cgroup_namespace *to_cg_ns(struct ns_common *ns)
+{
+	return container_of(ns, struct cgroup_namespace, ns);
+}
+
 void free_cgroup_ns(struct cgroup_namespace *ns);
 
 struct cgroup_namespace *copy_cgroup_ns(unsigned long flags,
diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.h
index e8240cf2611a..924e4754374f 100644
--- a/include/linux/ipc_namespace.h
+++ b/include/linux/ipc_namespace.h
@@ -129,6 +129,11 @@ static inline int mq_init_ns(struct ipc_namespace *ns) { return 0; }
 #endif
 
 #if defined(CONFIG_IPC_NS)
+static inline struct ipc_namespace *to_ipc_ns(struct ns_common *ns)
+{
+	return container_of(ns, struct ipc_namespace, ns);
+}
+
 extern struct ipc_namespace *copy_ipcs(unsigned long flags,
 	struct user_namespace *user_ns, struct ipc_namespace *ns);
 
diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
index 7c67a5811199..ba0efc8c8596 100644
--- a/include/linux/pid_namespace.h
+++ b/include/linux/pid_namespace.h
@@ -54,6 +54,11 @@ extern struct pid_namespace init_pid_ns;
 #define PIDNS_ADDING (1U << 31)
 
 #ifdef CONFIG_PID_NS
+static inline struct pid_namespace *to_pid_ns(struct ns_common *ns)
+{
+	return container_of(ns, struct pid_namespace, ns);
+}
+
 static inline struct pid_namespace *get_pid_ns(struct pid_namespace *ns)
 {
 	if (ns != &init_pid_ns)
diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index 7f6af7a9771e..a47a4ce4183e 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -33,6 +33,10 @@ struct time_namespace {
 extern struct time_namespace init_time_ns;
 
 #ifdef CONFIG_TIME_NS
+static inline struct time_namespace *to_time_ns(struct ns_common *ns)
+{
+	return container_of(ns, struct time_namespace, ns);
+}
 void __init time_ns_init(void);
 extern int vdso_join_timens(struct task_struct *task,
 			    struct time_namespace *ns);
diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index a0bb6d012137..a09056ad090e 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -168,6 +168,11 @@ static inline void set_userns_rlimit_max(struct user_namespace *ns,
 
 #ifdef CONFIG_USER_NS
 
+static inline struct user_namespace *to_user_ns(struct ns_common *ns)
+{
+	return container_of(ns, struct user_namespace, ns);
+}
+
 static inline struct user_namespace *get_user_ns(struct user_namespace *ns)
 {
 	if (ns)
diff --git a/include/linux/utsname.h b/include/linux/utsname.h
index bf7613ba412b..5d34c4f0f945 100644
--- a/include/linux/utsname.h
+++ b/include/linux/utsname.h
@@ -30,6 +30,11 @@ struct uts_namespace {
 extern struct uts_namespace init_uts_ns;
 
 #ifdef CONFIG_UTS_NS
+static inline struct uts_namespace *to_uts_ns(struct ns_common *ns)
+{
+	return container_of(ns, struct uts_namespace, ns);
+}
+
 static inline void get_uts_ns(struct uts_namespace *ns)
 {
 	refcount_inc(&ns->ns.count);
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 42075748dff1..b9c5f6c7ee1e 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -263,6 +263,11 @@ void ipx_unregister_sysctl(void);
 #ifdef CONFIG_NET_NS
 void __put_net(struct net *net);
 
+static inline struct net *to_net_ns(struct ns_common *ns)
+{
+	return container_of(ns, struct net, ns);
+}
+
 /* Try using get_net_track() instead */
 static inline struct net *get_net(struct net *net)
 {
diff --git a/ipc/namespace.c b/ipc/namespace.c
index 9f923c1a1eb3..89588819956b 100644
--- a/ipc/namespace.c
+++ b/ipc/namespace.c
@@ -209,11 +209,6 @@ void put_ipc_ns(struct ipc_namespace *ns)
 	}
 }
 
-static inline struct ipc_namespace *to_ipc_ns(struct ns_common *ns)
-{
-	return container_of(ns, struct ipc_namespace, ns);
-}
-
 static struct ns_common *ipcns_get(struct task_struct *task)
 {
 	struct ipc_namespace *ns = NULL;
diff --git a/kernel/cgroup/namespace.c b/kernel/cgroup/namespace.c
index fc12c416dfeb..5a327914b565 100644
--- a/kernel/cgroup/namespace.c
+++ b/kernel/cgroup/namespace.c
@@ -89,11 +89,6 @@ struct cgroup_namespace *copy_cgroup_ns(unsigned long flags,
 	return new_ns;
 }
 
-static inline struct cgroup_namespace *to_cg_ns(struct ns_common *ns)
-{
-	return container_of(ns, struct cgroup_namespace, ns);
-}
-
 static int cgroupns_install(struct nsset *nsset, struct ns_common *ns)
 {
 	struct nsproxy *nsproxy = nsset->nsproxy;
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 228ae20299f9..9b327420309e 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -345,11 +345,6 @@ int reboot_pid_ns(struct pid_namespace *pid_ns, int cmd)
 	return 0;
 }
 
-static inline struct pid_namespace *to_pid_ns(struct ns_common *ns)
-{
-	return container_of(ns, struct pid_namespace, ns);
-}
-
 static struct ns_common *pidns_get(struct task_struct *task)
 {
 	struct pid_namespace *ns;
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index 408f60d0a3b6..20b65f90549e 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -261,11 +261,6 @@ void free_time_ns(struct time_namespace *ns)
 	kfree_rcu(ns, ns.ns_rcu);
 }
 
-static struct time_namespace *to_time_ns(struct ns_common *ns)
-{
-	return container_of(ns, struct time_namespace, ns);
-}
-
 static struct ns_common *timens_get(struct task_struct *task)
 {
 	struct time_namespace *ns = NULL;
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index ade5b6806c5c..cfb0e28f2779 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -1325,11 +1325,6 @@ bool current_in_userns(const struct user_namespace *target_ns)
 }
 EXPORT_SYMBOL(current_in_userns);
 
-static inline struct user_namespace *to_user_ns(struct ns_common *ns)
-{
-	return container_of(ns, struct user_namespace, ns);
-}
-
 static struct ns_common *userns_get(struct task_struct *task)
 {
 	struct user_namespace *user_ns;
diff --git a/kernel/utsname.c b/kernel/utsname.c
index 64155417ae0c..a682830742d3 100644
--- a/kernel/utsname.c
+++ b/kernel/utsname.c
@@ -103,11 +103,6 @@ void free_uts_ns(struct uts_namespace *ns)
 	kfree_rcu(ns, ns.ns_rcu);
 }
 
-static inline struct uts_namespace *to_uts_ns(struct ns_common *ns)
-{
-	return container_of(ns, struct uts_namespace, ns);
-}
-
 static struct ns_common *utsns_get(struct task_struct *task)
 {
 	struct uts_namespace *ns = NULL;
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index b85e303400be..ca9b06f3925f 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -1539,11 +1539,6 @@ static struct ns_common *netns_get(struct task_struct *task)
 	return net ? &net->ns : NULL;
 }
 
-static inline struct net *to_net_ns(struct ns_common *ns)
-{
-	return container_of(ns, struct net, ns);
-}
-
 static void netns_put(struct ns_common *ns)
 {
 	put_net(to_net_ns(ns));

-- 
2.47.3


