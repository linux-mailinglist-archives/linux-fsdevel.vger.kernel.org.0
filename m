Return-Path: <linux-fsdevel+bounces-67613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0FAC44768
	for <lists+linux-fsdevel@lfdr.de>; Sun, 09 Nov 2025 22:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5EBC3B4E9E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Nov 2025 21:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87116277CA4;
	Sun,  9 Nov 2025 21:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRLGi6wX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEACC2690D1;
	Sun,  9 Nov 2025 21:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762722823; cv=none; b=HI6dUoXzURKsuqkqvxFjlsmauCeM6KNTksC1sKNSstfCForrHTXJgjABR4McvKil2NoOeLbg103b8gyfXR4r6oXc16gfkT//2J3x5Nwm+sWAwZKgQdvAMj10z3cITf/VpahHPWthF2mQ2ghQVis0zUGuVEmNjh4C21iFmqfpYyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762722823; c=relaxed/simple;
	bh=X4O1l1jh5P5U12QpZJZKtUrS5jtWwPrcPGImd8GD70A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ggInucuZz8KZjNIc9pAHLn9jqNPKI0G/NlJ81Rh8cOOb1KOPnZ72MdhbXp+n3RnfnrYr4OsUyjzFN1DfqtGiRTiTjoTSEYuDTJ8jPvrKIAFtH5hmnQOJBR4/KBMroHiIoBxr2kMJ3VVoTdFiS97If29b967TeWQSxfx3LvU0cz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pRLGi6wX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDEB9C19422;
	Sun,  9 Nov 2025 21:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762722823;
	bh=X4O1l1jh5P5U12QpZJZKtUrS5jtWwPrcPGImd8GD70A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pRLGi6wXPGrkaBRp6Yl4XkFhp9sOaFqh90jUfGrLpOmKKCJTtw7DjdZkhAG5sfubh
	 /tagEkZqRrXEtmKPmn9S1Msvbfpe2pGA9bYLuztMQiWo49I8sKINmyWXoTTDLrkcrN
	 AhcLn9MocMoqh4peiCgjdsup8fBac+aIeQRnKj0+VtSJAB1wUFvBKuIQBD0ipmg19c
	 wg78R+NFGtHZZnQDAPvbofw/B0ZUG6gih+JDnsgO4VenqdiOXdkePhwhfxdJ1grXRn
	 S6XxijK5fEo2jpItItR/eZMGLG0DO8PwZc09xOWeybvJOGzbYL10s0MnCleszIr+M9
	 P+5UwrVi10iuw==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 09 Nov 2025 22:11:26 +0100
Subject: [PATCH 5/8] ns: handle setns(pidfd, ...) cleanly
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251109-namespace-6-19-fixes-v1-5-ae8a4ad5a3b3@kernel.org>
References: <20251109-namespace-6-19-fixes-v1-0-ae8a4ad5a3b3@kernel.org>
In-Reply-To: <20251109-namespace-6-19-fixes-v1-0-ae8a4ad5a3b3@kernel.org>
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
 Christian Brauner <brauner@kernel.org>, 
 syzbot+1957b26299cf3ff7890c@syzkaller.appspotmail.com
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8855; i=brauner@kernel.org;
 h=from:subject:message-id; bh=X4O1l1jh5P5U12QpZJZKtUrS5jtWwPrcPGImd8GD70A=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQKMr9oLqsztM1nyOf7+aetJei2/0xeHn2D7yt/FiwPW
 aZYen59RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESsyhj+8Abbr1avPyFdV9fX
 9THMefelb6cu77aediVC8OyGDwJxmxn+ipSsdQ64fMdIzd7u8trKHxeEZjxZn1LJ9EDD9mrVuUN
 X2QA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The setns() system call supports:

(1) namespace file descriptors (nsfd)
(2) process file descriptors (pidfd)

When using nsfds the namespaces will remain active because they are
pinned by the vfs. However, when pidfds are used things are more
complicated.

When the target task exits and passes through exit_nsproxy_namespaces()
or is reaped and thus also passes through exit_cred_namespaces() after
the setns()'ing task has called prepare_nsset() but before the active
reference count of the set of namespaces it wants to setns() to might
have been dropped already:

  P1                                                              P2

  pid_p1 = clone(CLONE_NEWUSER | CLONE_NEWNET | CLONE_NEWNS)
                                                                  pidfd = pidfd_open(pid_p1)
                                                                  setns(pidfd, CLONE_NEWUSER | CLONE_NEWNET | CLONE_NEWNS)
                                                                  prepare_nsset()

  exit(0)
  // ns->__ns_active_ref        == 1
  // parent_ns->__ns_active_ref == 1
  -> exit_nsproxy_namespaces()
  -> exit_cred_namespaces()

  // ns_active_ref_put() will also put
  // the reference on the owner of the
  // namespace. If the only reason the
  // owning namespace was alive was
  // because it was a parent of @ns
  // it's active reference count now goes
  // to zero... --------------------------------
  //                                           |
  // ns->__ns_active_ref        == 0           |
  // parent_ns->__ns_active_ref == 0           |
                                               |                  commit_nsset()
                                               -----------------> // If setns()
                                                                  // now manages to install the namespaces
                                                                  // it will call ns_active_ref_get()
                                                                  // on them thus bumping the active reference
                                                                  // count from zero again but without also
                                                                  // taking the required reference on the owner.
                                                                  // Thus we get:
                                                                  //
                                                                  // ns->__ns_active_ref        == 1
                                                                  // parent_ns->__ns_active_ref == 0

  When later someone does ns_active_ref_put() on @ns it will underflow
  parent_ns->__ns_active_ref leading to a splat from our asserts
  thinking there are still active references when in fact the counter
  just underflowed.

So resurrect the ownership chain if necessary as well. If the caller
succeeded to grab passive references to the set of namespaces the
setns() should simply succeed even if the target task exists or gets
reaped in the meantime and thus has dropped all active references to its
namespaces.

The race is rare and can only be triggered when using pidfs to setns()
to namespaces. Also note that active reference on initial namespaces are
nops.

Since we now always handle parent references directly we can drop
ns_ref_active_get_owner() when adding a namespace to a namespace tree.
This is now all handled uniformly in the places where the new namespaces
actually become active.

Reported-by: syzbot+1957b26299cf3ff7890c@syzkaller.appspotmail.com
Fixes: 3c9820d5c64a ("ns: add active reference count")
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/nsfs.c                 |  2 +-
 include/linux/ns_common.h | 47 ++++-------------------------------------------
 kernel/nscommon.c         | 21 ++++++++++++---------
 kernel/nstree.c           |  8 --------
 4 files changed, 17 insertions(+), 61 deletions(-)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index ba6c8975c82e..a80f8d2a4122 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -430,7 +430,7 @@ static int nsfs_init_inode(struct inode *inode, void *data)
 	 * ioctl on such a socket will resurrect the relevant namespace
 	 * subtree.
 	 */
-	__ns_ref_active_resurrect(ns);
+	__ns_ref_active_get(ns);
 	return 0;
 }
 
diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index 791b18dc77d0..3aaba2ca31d7 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -287,47 +287,8 @@ static __always_inline __must_check int __ns_ref_read(const struct ns_common *ns
 #define ns_ref_active_read(__ns) \
 	((__ns) ? __ns_ref_active_read(to_ns_common(__ns)) : 0)
 
-void __ns_ref_active_get_owner(struct ns_common *ns);
+void __ns_ref_active_put(struct ns_common *ns);
 
-static __always_inline void __ns_ref_active_get(struct ns_common *ns)
-{
-	/* Initial namespaces are always active. */
-	if (!is_ns_init_id(ns))
-		WARN_ON_ONCE(atomic_add_negative(1, &ns->__ns_ref_active));
-}
-#define ns_ref_active_get(__ns) \
-	do { if (__ns) __ns_ref_active_get(to_ns_common(__ns)); } while (0)
-
-static __always_inline bool __ns_ref_active_get_not_zero(struct ns_common *ns)
-{
-	/* Initial namespaces are always active. */
-	if (is_ns_init_id(ns))
-		return true;
-
-	if (atomic_inc_not_zero(&ns->__ns_ref_active)) {
-		VFS_WARN_ON_ONCE(!__ns_ref_read(ns));
-		return true;
-	}
-	return false;
-}
-
-#define ns_ref_active_get_owner(__ns) \
-	do { if (__ns) __ns_ref_active_get_owner(to_ns_common(__ns)); } while (0)
-
-void __ns_ref_active_put_owner(struct ns_common *ns);
-
-static __always_inline void __ns_ref_active_put(struct ns_common *ns)
-{
-	/* Initial namespaces are always active. */
-	if (is_ns_init_id(ns))
-		return;
-
-	if (atomic_dec_and_test(&ns->__ns_ref_active)) {
-		VFS_WARN_ON_ONCE(is_initial_namespace(ns));
-		VFS_WARN_ON_ONCE(!__ns_ref_read(ns));
-		__ns_ref_active_put_owner(ns);
-	}
-}
 #define ns_ref_active_put(__ns) \
 	do { if (__ns) __ns_ref_active_put(to_ns_common(__ns)); } while (0)
 
@@ -343,9 +304,9 @@ static __always_inline struct ns_common *__must_check ns_get_unless_inactive(str
 	return ns;
 }
 
-void __ns_ref_active_resurrect(struct ns_common *ns);
+void __ns_ref_active_get(struct ns_common *ns);
 
-#define ns_ref_active_resurrect(__ns) \
-	do { if (__ns) __ns_ref_active_resurrect(to_ns_common(__ns)); } while (0)
+#define ns_ref_active_get(__ns) \
+	do { if (__ns) __ns_ref_active_get(to_ns_common(__ns)); } while (0)
 
 #endif
diff --git a/kernel/nscommon.c b/kernel/nscommon.c
index 70cb66232e4c..bfd2d6805776 100644
--- a/kernel/nscommon.c
+++ b/kernel/nscommon.c
@@ -114,13 +114,6 @@ struct ns_common *__must_check ns_owner(struct ns_common *ns)
 	return to_ns_common(owner);
 }
 
-void __ns_ref_active_get_owner(struct ns_common *ns)
-{
-	ns = ns_owner(ns);
-	if (ns)
-		WARN_ON_ONCE(atomic_add_negative(1, &ns->__ns_ref_active));
-}
-
 /*
  * The active reference count works by having each namespace that gets
  * created take a single active reference on its owning user namespace.
@@ -171,8 +164,18 @@ void __ns_ref_active_get_owner(struct ns_common *ns)
  * The iteration stops once we reach a namespace that still has active
  * references.
  */
-void __ns_ref_active_put_owner(struct ns_common *ns)
+void __ns_ref_active_put(struct ns_common *ns)
 {
+	/* Initial namespaces are always active. */
+	if (is_ns_init_id(ns))
+		return;
+
+	if (!atomic_dec_and_test(&ns->__ns_ref_active))
+		return;
+
+	VFS_WARN_ON_ONCE(is_ns_init_id(ns));
+	VFS_WARN_ON_ONCE(!__ns_ref_read(ns));
+
 	for (;;) {
 		ns = ns_owner(ns);
 		if (!ns)
@@ -275,7 +278,7 @@ void __ns_ref_active_put_owner(struct ns_common *ns)
  * it also needs to take another reference on its owning user namespace
  * and so on.
  */
-void __ns_ref_active_resurrect(struct ns_common *ns)
+void __ns_ref_active_get(struct ns_common *ns)
 {
 	/* Initial namespaces are always active. */
 	if (is_ns_init_id(ns))
diff --git a/kernel/nstree.c b/kernel/nstree.c
index f27f772a6762..97404fb90749 100644
--- a/kernel/nstree.c
+++ b/kernel/nstree.c
@@ -173,14 +173,6 @@ void __ns_tree_add_raw(struct ns_common *ns, struct ns_tree *ns_tree)
 	write_sequnlock(&ns_tree_lock);
 
 	VFS_WARN_ON_ONCE(node);
-
-	/*
-	 * Take an active reference on the owner namespace. This ensures
-	 * that the owner remains visible while any of its child namespaces
-	 * are active. For init namespaces this is a no-op as ns_owner()
-	 * returns NULL for namespaces owned by init_user_ns.
-	 */
-	__ns_ref_active_get_owner(ns);
 }
 
 void __ns_tree_remove(struct ns_common *ns, struct ns_tree *ns_tree)

-- 
2.47.3


