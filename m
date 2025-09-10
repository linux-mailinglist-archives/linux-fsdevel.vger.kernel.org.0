Return-Path: <linux-fsdevel+bounces-60796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD237B51A0C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 16:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A92E7BEE54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 14:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA552369335;
	Wed, 10 Sep 2025 14:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/NiZzhF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECDC32C331;
	Wed, 10 Sep 2025 14:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515158; cv=none; b=G4oosctqlkedquLfai/C48i96CMyJFjIM8nH6zAKFFonjMYHtg8quCn1UyAbMw1KGwsYHj9h/TEa8AuEzuFBHQ7mXo92ssL8dqM2hMKkAucnCCx+ytNE/5Mbk6hOCTG5h4gY2bKxfIIB+sdtgAnO/PQ3Y7kC7CIC69bombJrE3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515158; c=relaxed/simple;
	bh=zqQ6rgi7O/wHq5neMUB7hh99707I6vBoC949QtDxqUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XBoJ00qNqYgyk3Wk9XQP3Ie2zYctpyOxTjFUR0iG1kZF0aOfi15+Ai7IOo1pulDzsJtCXg/2jLZoD5cJbOkzqXSD97PLlSF7lByI0m4maYl78r7KFYk2JXKgZ4uR/DYUMLMi7IT7rvMPB6bxp6DqLXPuWYlT+dNvFg0hSzGK9IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/NiZzhF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF6CC4CEF8;
	Wed, 10 Sep 2025 14:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757515157;
	bh=zqQ6rgi7O/wHq5neMUB7hh99707I6vBoC949QtDxqUc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P/NiZzhFl25Mf35HvvOae3cfDKbIiF66wLTVM+O6VjkuzC4U7wxS3PwmtauvflJob
	 hGG1IODBTWvFzZT/3hf7OZoOZnz+W3UXRNyx1B31mf4Mbnk6qHhq/9OptIzQTIftH7
	 nJrrrmIosc3XB1AKMLMl6qQdBXG5BkNwg1XH1gkuHc3CykzLR3gyfbnU9S9r9Y2lqQ
	 Y59vZ3C2rcLBBv9uOIKTILx91gOjd/uo5oovceO2M5t00EC8ZoPL3Q/mLEe3Gbp4BJ
	 Ea4+nMWnoz94nT/ikwRSdViLj4xXcV/N+TYAI2evLeqHlsCN1tnE1iMXapYQ0TbRNZ
	 c5WSoQBRqeabg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 10 Sep 2025 16:37:07 +0200
Subject: [PATCH 22/32] time: support iterator
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-work-namespace-v1-22-4dd56e7359d8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3233; i=brauner@kernel.org;
 h=from:subject:message-id; bh=zqQ6rgi7O/wHq5neMUB7hh99707I6vBoC949QtDxqUc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc7OUUDd1psjh5jsGCtbNjzjmGfFXWvW+WlyHdtEs/t
 FY17Cp/RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQ+CDL8d+veZ+Pp/Z57Tbem
 8hYZ64+8P/bvDDt79MksPpab3vskYxn+e5/xfDdh0eSDgqt0mOYYsmt9Z14zX5Wt04EjpqR6jeg
 PBgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Support the generic namespace iterator and lookup infrastructure to
support file handles for namespaces.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/time_namespace.h |  5 +++++
 init/main.c                    |  2 ++
 kernel/time/namespace.c        | 13 +++++++++++--
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index bb2c52f4fc94..7f6af7a9771e 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -33,6 +33,7 @@ struct time_namespace {
 extern struct time_namespace init_time_ns;
 
 #ifdef CONFIG_TIME_NS
+void __init time_ns_init(void);
 extern int vdso_join_timens(struct task_struct *task,
 			    struct time_namespace *ns);
 extern void timens_commit(struct task_struct *tsk, struct time_namespace *ns);
@@ -108,6 +109,10 @@ static inline ktime_t timens_ktime_to_host(clockid_t clockid, ktime_t tim)
 }
 
 #else
+static inline void __init time_ns_init(void)
+{
+}
+
 static inline int vdso_join_timens(struct task_struct *task,
 				   struct time_namespace *ns)
 {
diff --git a/init/main.c b/init/main.c
index 0ee0ee7b7c2c..e7d2c57c65a7 100644
--- a/init/main.c
+++ b/init/main.c
@@ -103,6 +103,7 @@
 #include <linux/randomize_kstack.h>
 #include <linux/pidfs.h>
 #include <linux/ptdump.h>
+#include <linux/time_namespace.h>
 #include <net/net_namespace.h>
 
 #include <asm/io.h>
@@ -1072,6 +1073,7 @@ void start_kernel(void)
 	fork_init();
 	proc_caches_init();
 	uts_ns_init();
+	time_ns_init();
 	key_init();
 	security_init();
 	dbg_late_init();
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index 80b3d2ce2fb6..408f60d0a3b6 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -12,6 +12,7 @@
 #include <linux/seq_file.h>
 #include <linux/proc_ns.h>
 #include <linux/export.h>
+#include <linux/nstree.h>
 #include <linux/time.h>
 #include <linux/slab.h>
 #include <linux/cred.h>
@@ -88,7 +89,7 @@ static struct time_namespace *clone_time_ns(struct user_namespace *user_ns,
 		goto fail;
 
 	err = -ENOMEM;
-	ns = kmalloc(sizeof(*ns), GFP_KERNEL_ACCOUNT);
+	ns = kzalloc(sizeof(*ns), GFP_KERNEL_ACCOUNT);
 	if (!ns)
 		goto fail_dec;
 
@@ -104,6 +105,7 @@ static struct time_namespace *clone_time_ns(struct user_namespace *user_ns,
 	ns->user_ns = get_user_ns(user_ns);
 	ns->offsets = old_ns->offsets;
 	ns->frozen_offsets = false;
+	ns_tree_add(ns);
 	return ns;
 
 fail_free_page:
@@ -250,11 +252,13 @@ static void timens_set_vvar_page(struct task_struct *task,
 
 void free_time_ns(struct time_namespace *ns)
 {
+	ns_tree_remove(ns);
 	dec_time_namespaces(ns->ucounts);
 	put_user_ns(ns->user_ns);
 	ns_free_inum(&ns->ns);
 	__free_page(ns->vvar_page);
-	kfree(ns);
+	/* Concurrent nstree traversal depends on a grace period. */
+	kfree_rcu(ns, ns.ns_rcu);
 }
 
 static struct time_namespace *to_time_ns(struct ns_common *ns)
@@ -487,3 +491,8 @@ struct time_namespace init_time_ns = {
 	.ns.ops		= &timens_operations,
 	.frozen_offsets	= true,
 };
+
+void __init time_ns_init(void)
+{
+	ns_tree_add(&init_time_ns);
+}

-- 
2.47.3


