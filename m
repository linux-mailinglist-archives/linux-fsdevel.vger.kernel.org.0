Return-Path: <linux-fsdevel+bounces-61068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BA6B54C6B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 14:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A10BEAA52D1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 12:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51F0321F46;
	Fri, 12 Sep 2025 11:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6ClPBR3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AF0320CC7;
	Fri, 12 Sep 2025 11:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678119; cv=none; b=aad9Cfp4QMFJpADMqE7K8PAISpJCEfQTCEfA0tZ/2oWElfi6l4Q4vX8/UI+pshsrOJrAlnQKpUGJqBfdZIAx7ofRMFvzH75B4CuOxlKBMg7+w0tQSUUsQiGWT3Ekd8HXAzEs4ykeR9RDAU+6KiAHhVmrJ+p6A7gDyb708QY8gcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678119; c=relaxed/simple;
	bh=YpPoGp5TGLqKFHELAb8rX26TINgZ5qTGiosLQnkAkAY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ivILdNC4YLf1LgBcG57yBXkZ4IV8ZH/bPLykUoM+zadWPovxpObndfcEXnxit1SwWGGthow0OI3TA/VaQNZsux2WFwYNiCOhLjH48IEMMQIAZvBVDdp4kH7lyBucfjl6UnSIwjfS6sFs10wVFA4lKvx+hao1OoPv3YLFderS3AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6ClPBR3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25D6C4CEF1;
	Fri, 12 Sep 2025 11:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757678114;
	bh=YpPoGp5TGLqKFHELAb8rX26TINgZ5qTGiosLQnkAkAY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=T6ClPBR3+d2juqKSRlundvP1qc9//J3WIRq/AJtzul7JsBCV4ZHgM4mRhm9gM34We
	 nEhez4YNHRZEh+f0DpLR9X2C05hKKf/4iBUXTD3DTNoWZvGocat5Id0vNascs8t3ti
	 1INXijFL8N+SFmcBC3X6OnRdeZ1BXIknHwRypyti3yEQAFQLBQiVzHPblam3I6RzvC
	 VjPJCa4TiraHMzupL8zOZE2cDREMDfqKvdcRbPUEmnoXkweMHpbO6qvuBNmnaBtDKs
	 czc/qIb5E2KEw5FL2O/2DaCb3ZqHRU4TQf4pCR0bsg1hjksp0F9AAk59ZISyjKsz8V
	 vVAzxUxTAUdMg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 12 Sep 2025 13:52:46 +0200
Subject: [PATCH v2 23/33] time: support ns lookup
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-work-namespace-v2-23-1a247645cef5@kernel.org>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
In-Reply-To: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
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
 netdev@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>
X-Mailer: b4 0.14.3-dev-385fa
X-Developer-Signature: v=1; a=openpgp-sha256; l=2996; i=brauner@kernel.org;
 h=from:subject:message-id; bh=YpPoGp5TGLqKFHELAb8rX26TINgZ5qTGiosLQnkAkAY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc4Zz64oeQc9LRRMlEr8TJNxKmyO+ynPKtlMvNct6Bv
 bpRWiZvOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbSvZaR4fvVvqnCS27PXlfY
 feWuVlWVom52clH95C3vBKfLHJZofcTI8HSNvnUmj3WfurrW79iGvD9lgZNKxP4cfuHr/mvZQrY
 pTAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Support the generic ns lookup infrastructure to support file handles for
namespaces.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/time_namespace.h |  5 +++++
 init/main.c                    |  2 ++
 kernel/time/namespace.c        | 11 ++++++++++-
 3 files changed, 17 insertions(+), 1 deletion(-)

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
index 0be93d8f2896..408f60d0a3b6 100644
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


