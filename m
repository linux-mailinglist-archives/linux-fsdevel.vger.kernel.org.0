Return-Path: <linux-fsdevel+bounces-67997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E3122C4FD9A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 22:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 41E9F34C539
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 21:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC78352F93;
	Tue, 11 Nov 2025 21:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGKgOZih"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5206B33D6D1;
	Tue, 11 Nov 2025 21:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762896599; cv=none; b=LmSoLQkaOoNz+2Yj90u730p41z3IljaPO8zLTmkZXy3eC6itbRMdCMlKhPB7vU7MCRCUjLrKvf9K60AigDc145zyy7qgBgt1KUFyHB6w2OzUdsOH00zF8nENvYCRh96ezVbathLKh9VX/bXInii19lUff+F7+8Shj1uGMR6yiis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762896599; c=relaxed/simple;
	bh=/bC50lhCtcx6OG7oIZHLvFZOizTdGgNdqLCTc3tazgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQP8WoZOmI238qE13vbIgKwzS5UitDzRHGBkvd8s98EHtZERrK90nf+8mZZpT05uz4lGj9MUaauQW4fy+1UBPksuR5mK2K9HlWXowkSsHxyYFQgCtEzSLb+eDPkao6n7XXFsjcsCq7XGK5BLzGmANnHy5btieP+CwF4IKTJ1OXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGKgOZih; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CBE2C116D0;
	Tue, 11 Nov 2025 21:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762896598;
	bh=/bC50lhCtcx6OG7oIZHLvFZOizTdGgNdqLCTc3tazgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uGKgOZihX6WkxOXaYaMp7Ce45mAoZy1EdfFSGzxey8lL8ehrEFIL28KuIarmg/MNN
	 q3HW4jyWthAJ8uUu/tNQsUJIcWjqrwAyZYS2WAzJFEVqjfCokNpJ+pA5pdwBRqWMey
	 bPGuKEJQFW0OLIvy59Fzs8zpgRKcZmZjpPqjwd1hcYyG4KMM7du5CZ+tP62TLx16s2
	 vDik8OOPhpjo+w0OVb0HfR9Y1msHmcC+CUnE13AHRG//Nak7D47T7MeOw4cM6XUuLE
	 SN+jmchssstwp47zqOcbrNN6mzaZpHQXpJoluWRAwVhesyL1Yvf7L+IGOI9KCkFGB8
	 ZB7mc1l3UU0Dw==
From: Christian Brauner <brauner@kernel.org>
To: syzbot <syzbot+0b2e79f91ff6579bfa5b@syzkaller.appspotmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	akpm@linux-foundation.org,
	bpf@vger.kernel.org,
	bsegall@google.com,
	david@redhat.com,
	dietmar.eggemann@arm.com,
	jack@suse.cz,
	jsavitz@redhat.com,
	juri.lelli@redhat.com,
	kartikey406@gmail.com,
	kees@kernel.org,
	liam.howlett@oracle.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	mgorman@suse.de,
	mhocko@suse.com,
	mingo@redhat.com,
	mjguzik@gmail.com,
	oleg@redhat.com,
	paul@paul-moore.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	rppt@kernel.org,
	sergeh@kernel.org,
	surenb@google.com,
	syzkaller-bugs@googlegroups.com,
	vbabka@suse.cz,
	vincent.guittot@linaro.org,
	viro@zeniv.linux.org.uk,
	vschneid@redhat.com,
	syzbot+0a8655a80e189278487e@syzkaller.appspotmail.com
Subject: [PATCH] nsproxy: fix free_nsproxy() and simplify create_new_namespaces()
Date: Tue, 11 Nov 2025 22:29:44 +0100
Message-ID: <20251111-sakralbau-guthaben-7dcc277d337f@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <691360cc.a70a0220.22f260.013e.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6748; i=brauner@kernel.org; h=from:subject:message-id; bh=/bC50lhCtcx6OG7oIZHLvFZOizTdGgNdqLCTc3tazgg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQKrzr99kkW6wzH6+UP/PreNc3KE2rfU+NbHrZ+xbWOF t7s6PTXHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPRDmVkuJPxT1/H9VJg0TpP bYu9tkz6hpfdpUT+6F3i3+xsae+1ieGv0BItmR8v/+iyT+J6VCyx5du09JVfWi1ua75+sX5Kp8w rHgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Make it possible to handle NULL being passed to the reference count
helpers instead of forcing the caller to handle this. Afterwards we can
nicely allow a cleanup guard to handle nsproxy freeing.

Active reference count handling is not done in nsproxy_free() but rather
in free_nsproxy() as nsproxy_free() is also called from setns() failure
paths where a new nsproxy has been prepared but has not been marked as
active via switch_task_namespaces().

Fixes: 3c9820d5c64a ("ns: add active reference count")
Reported-by: syzbot+0b2e79f91ff6579bfa5b@syzkaller.appspotmail.com
Reported-by: syzbot+0a8655a80e189278487e@syzkaller.appspotmail.com
Link: https://lore.kernel.org/690bfb9e.050a0220.2e3c35.0013.GAE@google.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/ns_common.h |  11 ++--
 kernel/nsproxy.c          | 107 +++++++++++++++-----------------------
 2 files changed, 48 insertions(+), 70 deletions(-)

diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index 136f6a322e53..825f5865bfc5 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -114,11 +114,14 @@ static __always_inline __must_check bool __ns_ref_dec_and_lock(struct ns_common
 }
 
 #define ns_ref_read(__ns) __ns_ref_read(to_ns_common((__ns)))
-#define ns_ref_inc(__ns) __ns_ref_inc(to_ns_common((__ns)))
-#define ns_ref_get(__ns) __ns_ref_get(to_ns_common((__ns)))
-#define ns_ref_put(__ns) __ns_ref_put(to_ns_common((__ns)))
+#define ns_ref_inc(__ns) \
+	do { if (__ns) __ns_ref_inc(to_ns_common((__ns))); } while (0)
+#define ns_ref_get(__ns) \
+	((__ns) ? __ns_ref_get(to_ns_common((__ns))) : false)
+#define ns_ref_put(__ns) \
+	((__ns) ? __ns_ref_put(to_ns_common((__ns))) : false)
 #define ns_ref_put_and_lock(__ns, __ns_lock) \
-	__ns_ref_dec_and_lock(to_ns_common((__ns)), __ns_lock)
+	((__ns) ? __ns_ref_dec_and_lock(to_ns_common((__ns)), __ns_lock) : false)
 
 #define ns_ref_active_read(__ns) \
 	((__ns) ? __ns_ref_active_read(to_ns_common(__ns)) : 0)
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index 94c2cfe0afa1..2c94452dc793 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -60,6 +60,27 @@ static inline struct nsproxy *create_nsproxy(void)
 	return nsproxy;
 }
 
+static inline void nsproxy_free(struct nsproxy *ns)
+{
+	put_mnt_ns(ns->mnt_ns);
+	put_uts_ns(ns->uts_ns);
+	put_ipc_ns(ns->ipc_ns);
+	put_pid_ns(ns->pid_ns_for_children);
+	put_time_ns(ns->time_ns);
+	put_time_ns(ns->time_ns_for_children);
+	put_cgroup_ns(ns->cgroup_ns);
+	put_net(ns->net_ns);
+	kmem_cache_free(nsproxy_cachep, ns);
+}
+
+DEFINE_FREE(nsproxy_free, struct nsproxy *, if (_T) nsproxy_free(_T))
+
+void free_nsproxy(struct nsproxy *ns)
+{
+	nsproxy_ns_active_put(ns);
+	nsproxy_free(ns);
+}
+
 /*
  * Create new nsproxy and all of its the associated namespaces.
  * Return the newly created nsproxy.  Do not attach this to the task,
@@ -69,76 +90,45 @@ static struct nsproxy *create_new_namespaces(u64 flags,
 	struct task_struct *tsk, struct user_namespace *user_ns,
 	struct fs_struct *new_fs)
 {
-	struct nsproxy *new_nsp;
-	int err;
+	struct nsproxy *new_nsp __free(nsproxy_free) = NULL;
 
 	new_nsp = create_nsproxy();
 	if (!new_nsp)
 		return ERR_PTR(-ENOMEM);
 
 	new_nsp->mnt_ns = copy_mnt_ns(flags, tsk->nsproxy->mnt_ns, user_ns, new_fs);
-	if (IS_ERR(new_nsp->mnt_ns)) {
-		err = PTR_ERR(new_nsp->mnt_ns);
-		goto out_ns;
-	}
+	if (IS_ERR(new_nsp->mnt_ns))
+		return ERR_CAST(new_nsp->mnt_ns);
 
 	new_nsp->uts_ns = copy_utsname(flags, user_ns, tsk->nsproxy->uts_ns);
-	if (IS_ERR(new_nsp->uts_ns)) {
-		err = PTR_ERR(new_nsp->uts_ns);
-		goto out_uts;
-	}
+	if (IS_ERR(new_nsp->uts_ns))
+		return ERR_CAST(new_nsp->uts_ns);
 
 	new_nsp->ipc_ns = copy_ipcs(flags, user_ns, tsk->nsproxy->ipc_ns);
-	if (IS_ERR(new_nsp->ipc_ns)) {
-		err = PTR_ERR(new_nsp->ipc_ns);
-		goto out_ipc;
-	}
+	if (IS_ERR(new_nsp->ipc_ns))
+		return ERR_CAST(new_nsp->ipc_ns);
 
-	new_nsp->pid_ns_for_children =
-		copy_pid_ns(flags, user_ns, tsk->nsproxy->pid_ns_for_children);
-	if (IS_ERR(new_nsp->pid_ns_for_children)) {
-		err = PTR_ERR(new_nsp->pid_ns_for_children);
-		goto out_pid;
-	}
+	new_nsp->pid_ns_for_children = copy_pid_ns(flags, user_ns,
+						   tsk->nsproxy->pid_ns_for_children);
+	if (IS_ERR(new_nsp->pid_ns_for_children))
+		return ERR_CAST(new_nsp->pid_ns_for_children);
 
 	new_nsp->cgroup_ns = copy_cgroup_ns(flags, user_ns,
 					    tsk->nsproxy->cgroup_ns);
-	if (IS_ERR(new_nsp->cgroup_ns)) {
-		err = PTR_ERR(new_nsp->cgroup_ns);
-		goto out_cgroup;
-	}
+	if (IS_ERR(new_nsp->cgroup_ns))
+		return ERR_CAST(new_nsp->cgroup_ns);
 
 	new_nsp->net_ns = copy_net_ns(flags, user_ns, tsk->nsproxy->net_ns);
-	if (IS_ERR(new_nsp->net_ns)) {
-		err = PTR_ERR(new_nsp->net_ns);
-		goto out_net;
-	}
+	if (IS_ERR(new_nsp->net_ns))
+		return ERR_CAST(new_nsp->net_ns);
 
 	new_nsp->time_ns_for_children = copy_time_ns(flags, user_ns,
-					tsk->nsproxy->time_ns_for_children);
-	if (IS_ERR(new_nsp->time_ns_for_children)) {
-		err = PTR_ERR(new_nsp->time_ns_for_children);
-		goto out_time;
-	}
+						     tsk->nsproxy->time_ns_for_children);
+	if (IS_ERR(new_nsp->time_ns_for_children))
+		return ERR_CAST(new_nsp->time_ns_for_children);
 	new_nsp->time_ns = get_time_ns(tsk->nsproxy->time_ns);
 
-	return new_nsp;
-
-out_time:
-	put_net(new_nsp->net_ns);
-out_net:
-	put_cgroup_ns(new_nsp->cgroup_ns);
-out_cgroup:
-	put_pid_ns(new_nsp->pid_ns_for_children);
-out_pid:
-	put_ipc_ns(new_nsp->ipc_ns);
-out_ipc:
-	put_uts_ns(new_nsp->uts_ns);
-out_uts:
-	put_mnt_ns(new_nsp->mnt_ns);
-out_ns:
-	kmem_cache_free(nsproxy_cachep, new_nsp);
-	return ERR_PTR(err);
+	return no_free_ptr(new_nsp);
 }
 
 /*
@@ -185,21 +175,6 @@ int copy_namespaces(u64 flags, struct task_struct *tsk)
 	return 0;
 }
 
-void free_nsproxy(struct nsproxy *ns)
-{
-	nsproxy_ns_active_put(ns);
-
-	put_mnt_ns(ns->mnt_ns);
-	put_uts_ns(ns->uts_ns);
-	put_ipc_ns(ns->ipc_ns);
-	put_pid_ns(ns->pid_ns_for_children);
-	put_time_ns(ns->time_ns);
-	put_time_ns(ns->time_ns_for_children);
-	put_cgroup_ns(ns->cgroup_ns);
-	put_net(ns->net_ns);
-	kmem_cache_free(nsproxy_cachep, ns);
-}
-
 /*
  * Called from unshare. Unshare all the namespaces part of nsproxy.
  * On success, returns the new nsproxy.
@@ -338,7 +313,7 @@ static void put_nsset(struct nsset *nsset)
 	if (nsset->fs && (flags & CLONE_NEWNS) && (flags & ~CLONE_NEWNS))
 		free_fs_struct(nsset->fs);
 	if (nsset->nsproxy)
-		free_nsproxy(nsset->nsproxy);
+		nsproxy_free(nsset->nsproxy);
 }
 
 static int prepare_nsset(unsigned flags, struct nsset *nsset)
-- 
2.47.3


