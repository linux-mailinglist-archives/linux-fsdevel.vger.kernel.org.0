Return-Path: <linux-fsdevel+bounces-62107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2932DB84041
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 12:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5670626A46
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 10:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517F5307493;
	Thu, 18 Sep 2025 10:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOFLOrWv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B41E2F83CF;
	Thu, 18 Sep 2025 10:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758190381; cv=none; b=eIAsIEurK/RBeFtZGTx4gX0tZ3Jf5Fx4RKZAY0HIsTgLPX8vCyDNV/nw5O0s2LZRn5o6gIRY1b6Q6DcTo58nPoiOGOst6d6J7Irc8W0NBrocHaDwIaBy/j+z3soqT3+a9T3MFrwrKqymHqL0Z37blz9E+8yH+fccKjhIHwuUaPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758190381; c=relaxed/simple;
	bh=OfQjKy/Zp2oThhXDYDXNlv99L2kJ15thP22bLFaBmOo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RWk9Xu2a6hywbPYMM/JTbVixg2g0hg88PUPsuMCkQSZTvBvPxJDnF49nRVaLLwzlWAwocJ4SmXQTUYMteUob4gFf0i1+SHmq6byOaTF15wRxLu4O9P+nA7OpYMinJCMvM669thPwn49lObqJzuwNLPtMzOOxk8+XK2wxc5Ras+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOFLOrWv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05201C4CEF0;
	Thu, 18 Sep 2025 10:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758190381;
	bh=OfQjKy/Zp2oThhXDYDXNlv99L2kJ15thP22bLFaBmOo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oOFLOrWvcdU7ANEGYkH6htNM4dZCxw+DskXxE6xIZAnXhjHlMLGmYprKZEIXPf/fa
	 sEEIaCd6ui6C1nTNJHxko+ip7GLjRDWbyxotBH8eVDWrX4dTgC7abLkxusuwMx58NN
	 o0OjkJ8MLDz28TGPjagQ7EltmgPV28OsEfvgxNq6iJBYpRD/4Zf0/aVgMhvLk5UrSP
	 mpsjKswUKEY7EGsgi6hGr8tpxBzB+bCxUTwMJAuxaKmlM4SM7CxSdkau7L2ao7qQr2
	 fhcrY/0NDsofn05aeiixLKQXPhfxw686dq3gU/dL3Zz2F1e2+wFLR02LlTZXotUnjD
	 knA1RsG5qXD2w==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 18 Sep 2025 12:11:59 +0200
Subject: [PATCH 14/14] ns: rename to __ns_ref
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-work-namespace-ns_ref-v1-14-1b0a98ee041e@kernel.org>
References: <20250918-work-namespace-ns_ref-v1-0-1b0a98ee041e@kernel.org>
In-Reply-To: <20250918-work-namespace-ns_ref-v1-0-1b0a98ee041e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4926; i=brauner@kernel.org;
 h=from:subject:message-id; bh=OfQjKy/Zp2oThhXDYDXNlv99L2kJ15thP22bLFaBmOo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWScvvXM/ot1cOoPNcnGhxz/Vor+D/tpkyl+gWUNt31Lz
 p+XMuHvO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbymZvhv+e8UNdLgXukN/8I
 e8Ybqh8brL2rq+f5g4c7H3/KTnU+48vwi+lI4K98/6KJxT5fj+U+Zw9sue22+cOXf0fY7x670cJ
 1kRkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Make it easier to grep and rename to ns_count.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/ns_common.h | 12 ++++++------
 init/version-timestamp.c  |  2 +-
 ipc/msgutil.c             |  2 +-
 kernel/cgroup/cgroup.c    |  2 +-
 kernel/nscommon.c         |  2 +-
 kernel/pid.c              |  2 +-
 kernel/time/namespace.c   |  2 +-
 kernel/user.c             |  2 +-
 8 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index a65da646aef7..24bbeb5161a5 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -29,7 +29,7 @@ struct ns_common {
 	struct dentry *stashed;
 	const struct proc_ns_operations *ops;
 	unsigned int inum;
-	refcount_t count;
+	refcount_t __ns_ref; /* do not use directly */
 	union {
 		struct {
 			u64 ns_id;
@@ -95,19 +95,19 @@ void __ns_common_free(struct ns_common *ns);
 
 static __always_inline __must_check bool __ns_ref_put(struct ns_common *ns)
 {
-	return refcount_dec_and_test(&ns->count);
+	return refcount_dec_and_test(&ns->__ns_ref);
 }
 
 static __always_inline __must_check bool __ns_ref_get(struct ns_common *ns)
 {
-	return refcount_inc_not_zero(&ns->count);
+	return refcount_inc_not_zero(&ns->__ns_ref);
 }
 
-#define ns_ref_read(__ns) refcount_read(&to_ns_common((__ns))->count)
-#define ns_ref_inc(__ns) refcount_inc(&to_ns_common((__ns))->count)
+#define ns_ref_read(__ns) refcount_read(&to_ns_common((__ns))->__ns_ref)
+#define ns_ref_inc(__ns) refcount_inc(&to_ns_common((__ns))->__ns_ref)
 #define ns_ref_get(__ns) __ns_ref_get(to_ns_common((__ns)))
 #define ns_ref_put(__ns) __ns_ref_put(to_ns_common((__ns)))
 #define ns_ref_put_and_lock(__ns, __lock) \
-	refcount_dec_and_lock(&to_ns_common((__ns))->count, (__lock))
+	refcount_dec_and_lock(&to_ns_common((__ns))->__ns_ref, (__lock))
 
 #endif
diff --git a/init/version-timestamp.c b/init/version-timestamp.c
index 043cbf80a766..547e522e6016 100644
--- a/init/version-timestamp.c
+++ b/init/version-timestamp.c
@@ -8,7 +8,7 @@
 #include <linux/utsname.h>
 
 struct uts_namespace init_uts_ns = {
-	.ns.count = REFCOUNT_INIT(2),
+	.ns.__ns_ref = REFCOUNT_INIT(2),
 	.name = {
 		.sysname	= UTS_SYSNAME,
 		.nodename	= UTS_NODENAME,
diff --git a/ipc/msgutil.c b/ipc/msgutil.c
index bbf61275df41..d0f7dcf4c208 100644
--- a/ipc/msgutil.c
+++ b/ipc/msgutil.c
@@ -27,7 +27,7 @@ DEFINE_SPINLOCK(mq_lock);
  * and not CONFIG_IPC_NS.
  */
 struct ipc_namespace init_ipc_ns = {
-	.ns.count = REFCOUNT_INIT(1),
+	.ns.__ns_ref = REFCOUNT_INIT(1),
 	.user_ns = &init_user_ns,
 	.ns.inum = PROC_IPC_INIT_INO,
 #ifdef CONFIG_IPC_NS
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 092e6bf081ed..a0e24adceef0 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -219,7 +219,7 @@ static bool have_favordynmods __ro_after_init = IS_ENABLED(CONFIG_CGROUP_FAVOR_D
 
 /* cgroup namespace for init task */
 struct cgroup_namespace init_cgroup_ns = {
-	.ns.count	= REFCOUNT_INIT(2),
+	.ns.__ns_ref	= REFCOUNT_INIT(2),
 	.user_ns	= &init_user_ns,
 	.ns.ops		= &cgroupns_operations,
 	.ns.inum	= PROC_CGROUP_INIT_INO,
diff --git a/kernel/nscommon.c b/kernel/nscommon.c
index 7c1b07e2a6c9..7aa2be6a0c32 100644
--- a/kernel/nscommon.c
+++ b/kernel/nscommon.c
@@ -5,7 +5,7 @@
 
 int __ns_common_init(struct ns_common *ns, const struct proc_ns_operations *ops, int inum)
 {
-	refcount_set(&ns->count, 1);
+	refcount_set(&ns->__ns_ref, 1);
 	ns->stashed = NULL;
 	ns->ops = ops;
 	ns->ns_id = 0;
diff --git a/kernel/pid.c b/kernel/pid.c
index c45a28c16cd2..e222426f745d 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -71,7 +71,7 @@ static int pid_max_max = PID_MAX_LIMIT;
  * the scheme scales to up to 4 million PIDs, runtime.
  */
 struct pid_namespace init_pid_ns = {
-	.ns.count = REFCOUNT_INIT(2),
+	.ns.__ns_ref = REFCOUNT_INIT(2),
 	.idr = IDR_INIT(init_pid_ns.idr),
 	.pid_allocated = PIDNS_ADDING,
 	.level = 0,
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index d49c73015d6e..d70bdfb7b001 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -480,7 +480,7 @@ const struct proc_ns_operations timens_for_children_operations = {
 };
 
 struct time_namespace init_time_ns = {
-	.ns.count	= REFCOUNT_INIT(3),
+	.ns.__ns_ref	= REFCOUNT_INIT(3),
 	.user_ns	= &init_user_ns,
 	.ns.inum	= PROC_TIME_INIT_INO,
 	.ns.ops		= &timens_operations,
diff --git a/kernel/user.c b/kernel/user.c
index f46b1d41163b..17a742fb4e10 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -65,7 +65,7 @@ struct user_namespace init_user_ns = {
 			.nr_extents = 1,
 		},
 	},
-	.ns.count = REFCOUNT_INIT(3),
+	.ns.__ns_ref = REFCOUNT_INIT(3),
 	.owner = GLOBAL_ROOT_UID,
 	.group = GLOBAL_ROOT_GID,
 	.ns.inum = PROC_USER_INIT_INO,

-- 
2.47.3


