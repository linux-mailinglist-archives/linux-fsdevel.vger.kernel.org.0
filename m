Return-Path: <linux-fsdevel+bounces-67714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0930EC4778E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 16:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 267EB1893C5D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 15:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B7E32A3FE;
	Mon, 10 Nov 2025 15:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oauibloa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E09031961B;
	Mon, 10 Nov 2025 15:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762787407; cv=none; b=liuzAfjrziFx9Vgmi5d6Ts7WoyluYQW2o9EgDsWr9cz7w2VCw7g2DvQTyZPCdQrkpf5WEyfks2JpRb0XySXKgfE4iyrVRbmGrDOecOkQvijyA9tZQ6Wz/5MyUbmEma3SmenidLjX1TCRemE+DCzDuZmK4G0zWbxOSm5u7elmh0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762787407; c=relaxed/simple;
	bh=mkw17GZKEVt9ZPefjyYbPiUgoVd5EISliGaqBbxPbzE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uuil3er7edNzrvMCV0s/YqaGWm3OF+rxoimsu0LNarlT8FDvrAbNJqZmy8ufr+or9zRyZc4THIqHTtGW6a7lyDXOK1dfHXHa3R8y0GMM2MDF2fPcYllA3EXGBlN30dXWJELGCGP45Mom5UUodIFmVU0iWdMkCf41dw9A0mQMFfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oauibloa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19A6C116B1;
	Mon, 10 Nov 2025 15:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762787404;
	bh=mkw17GZKEVt9ZPefjyYbPiUgoVd5EISliGaqBbxPbzE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oauibloargbs2Qkwc64xeHQOShPZ7t0mQZCK7V8H2nIQ5o3/s7Q0kuLVTzhzIMP/t
	 OITHYzTkwxYFQXUkgNAizg77AcZ/q0WNbJRLNfWIsEflpiHpXMf58tXQZgj3fZXR1f
	 SMFAkD0eqS8jnZ0N/rvXeJSWHVem6euuc7TZ220Ntw3P9KWnO+HXJJ72vmhqQ/rf9u
	 v6lU1IVDLkhiyriZKfZDLMw3VN/3Rf0FqNKlavVumEj4YbzycEzwqA1qRLRTLUyh77
	 2yr7Vey+cWCvxRCAR4uZco5Nz5bqXBz5clDTxIqfjmimNgqLx7GFDETCRLgMCaS8P7
	 QEDcM8wWSowiQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 10 Nov 2025 16:08:28 +0100
Subject: [PATCH 16/17] ns: drop custom reference count initialization for
 initial namespaces
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-work-namespace-nstree-fixes-v1-16-e8a9264e0fb9@kernel.org>
References: <20251110-work-namespace-nstree-fixes-v1-0-e8a9264e0fb9@kernel.org>
In-Reply-To: <20251110-work-namespace-nstree-fixes-v1-0-e8a9264e0fb9@kernel.org>
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
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4449; i=brauner@kernel.org;
 h=from:subject:message-id; bh=mkw17GZKEVt9ZPefjyYbPiUgoVd5EISliGaqBbxPbzE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQK/v+i2XU9TCxqUZ4dy9PVNmtWW5/8ziDSciPG8sniW
 r3FX1uCOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZy8QQjw2FPvumXVsV9U2dt
 YyjfU/vc+emhwyeWLQp7FuTMwFQiKcXwV5Lh547lf/oDHPuusW+wc+Wq+LHa+rOc6BllXX+7Iwb
 WzAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Initial namespaces don't modify their reference count anymore.
They remain fixed at one so drop the custom refcount initializations.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c            | 2 +-
 include/linux/ns_common.h | 4 ++--
 init/version-timestamp.c  | 2 +-
 ipc/msgutil.c             | 2 +-
 kernel/cgroup/cgroup.c    | 2 +-
 kernel/pid.c              | 2 +-
 kernel/time/namespace.c   | 2 +-
 kernel/user.c             | 2 +-
 8 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index efaff8680eaf..25289b869be1 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5986,7 +5986,7 @@ SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req,
 }
 
 struct mnt_namespace init_mnt_ns = {
-	.ns		= NS_COMMON_INIT(init_mnt_ns, 1),
+	.ns		= NS_COMMON_INIT(init_mnt_ns),
 	.user_ns	= &init_user_ns,
 	.passive	= REFCOUNT_INIT(1),
 	.mounts		= RB_ROOT,
diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index 43f709ab846a..136f6a322e53 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -26,14 +26,14 @@ static __always_inline bool is_ns_init_id(const struct ns_common *ns)
 	return ns->ns_id <= NS_LAST_INIT_ID;
 }
 
-#define NS_COMMON_INIT(nsname, refs)									\
+#define NS_COMMON_INIT(nsname)										\
 {													\
 	.ns_type			= ns_common_type(&nsname),					\
 	.ns_id				= ns_init_id(&nsname),						\
 	.inum				= ns_init_inum(&nsname),					\
 	.ops				= to_ns_operations(&nsname),					\
 	.stashed			= NULL,								\
-	.__ns_ref			= REFCOUNT_INIT(refs),						\
+	.__ns_ref			= REFCOUNT_INIT(1),						\
 	.__ns_ref_active		= ATOMIC_INIT(1),						\
 	.ns_unified_node.ns_list_entry	= LIST_HEAD_INIT(nsname.ns.ns_unified_node.ns_list_entry),	\
 	.ns_tree_node.ns_list_entry	= LIST_HEAD_INIT(nsname.ns.ns_tree_node.ns_list_entry),		\
diff --git a/init/version-timestamp.c b/init/version-timestamp.c
index 56ded64fdfe4..375726e05f69 100644
--- a/init/version-timestamp.c
+++ b/init/version-timestamp.c
@@ -8,7 +8,7 @@
 #include <linux/utsname.h>
 
 struct uts_namespace init_uts_ns = {
-	.ns = NS_COMMON_INIT(init_uts_ns, 2),
+	.ns = NS_COMMON_INIT(init_uts_ns),
 	.name = {
 		.sysname	= UTS_SYSNAME,
 		.nodename	= UTS_NODENAME,
diff --git a/ipc/msgutil.c b/ipc/msgutil.c
index 55a908ec0674..e28f0cecb2ec 100644
--- a/ipc/msgutil.c
+++ b/ipc/msgutil.c
@@ -27,7 +27,7 @@ DEFINE_SPINLOCK(mq_lock);
  * and not CONFIG_IPC_NS.
  */
 struct ipc_namespace init_ipc_ns = {
-	.ns = NS_COMMON_INIT(init_ipc_ns, 1),
+	.ns = NS_COMMON_INIT(init_ipc_ns),
 	.user_ns = &init_user_ns,
 };
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 20ab84b2cf4e..2bf3951ca88f 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -250,7 +250,7 @@ bool cgroup_enable_per_threadgroup_rwsem __read_mostly;
 
 /* cgroup namespace for init task */
 struct cgroup_namespace init_cgroup_ns = {
-	.ns		= NS_COMMON_INIT(init_cgroup_ns, 2),
+	.ns		= NS_COMMON_INIT(init_cgroup_ns),
 	.user_ns	= &init_user_ns,
 	.root_cset	= &init_css_set,
 };
diff --git a/kernel/pid.c b/kernel/pid.c
index a5a63dc0a491..a31771bc89c1 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -71,7 +71,7 @@ static int pid_max_max = PID_MAX_LIMIT;
  * the scheme scales to up to 4 million PIDs, runtime.
  */
 struct pid_namespace init_pid_ns = {
-	.ns = NS_COMMON_INIT(init_pid_ns, 2),
+	.ns = NS_COMMON_INIT(init_pid_ns),
 	.idr = IDR_INIT(init_pid_ns.idr),
 	.pid_allocated = PIDNS_ADDING,
 	.level = 0,
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index 19911f88e2b8..e76be24b132c 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -478,7 +478,7 @@ const struct proc_ns_operations timens_for_children_operations = {
 };
 
 struct time_namespace init_time_ns = {
-	.ns		= NS_COMMON_INIT(init_time_ns, 3),
+	.ns		= NS_COMMON_INIT(init_time_ns),
 	.user_ns	= &init_user_ns,
 	.frozen_offsets	= true,
 };
diff --git a/kernel/user.c b/kernel/user.c
index 4b3132e786d9..7aef4e679a6a 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -35,7 +35,7 @@ EXPORT_SYMBOL_GPL(init_binfmt_misc);
  * and 1 for... ?
  */
 struct user_namespace init_user_ns = {
-	.ns = NS_COMMON_INIT(init_user_ns, 3),
+	.ns = NS_COMMON_INIT(init_user_ns),
 	.uid_map = {
 		{
 			.extent[0] = {

-- 
2.47.3


