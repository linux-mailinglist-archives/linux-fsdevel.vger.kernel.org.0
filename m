Return-Path: <linux-fsdevel+bounces-60788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9947CB51A0A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 16:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1E88A03D56
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 14:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798AD352FF9;
	Wed, 10 Sep 2025 14:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pgs65Z6x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB03C3314D4;
	Wed, 10 Sep 2025 14:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515109; cv=none; b=RnjDu7J/y53u4vXnvYT7TpNVRk0Pr3R1a+SZ6a8wFaZmpcISC162XBOokIgEk+VS1qWRH3XRVxMShZUlcmJNEWnKq/zVmIVJ4YJIn9R1zgTT7kDVnTWkRqJBqVIyX2tkCWyvo9F4o96ptyAm0cHgeNfDy/TXFGRkf2Fn9rTubx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515109; c=relaxed/simple;
	bh=8/A1bxZ4UuUeHxhFjq1bHDTfg5yr2/KaJ6j+CBu56xs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o8f0AaMQS9Fo1zuAvIHWoQvT+mgQvyJhq/Eh/PriKs/A0sTAMTW04EyftS8qKHyxNtgWKiSP5rgtvDbtWJPY7V/hTRCi4afXFfvLIhcz833algqUymDqnluzoL1//TU9fj5Sw4RQjJ1UsfeICz3ClycxUki+FSK6JTuMQycVsD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pgs65Z6x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DEEC4CEF8;
	Wed, 10 Sep 2025 14:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757515109;
	bh=8/A1bxZ4UuUeHxhFjq1bHDTfg5yr2/KaJ6j+CBu56xs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Pgs65Z6xM1PIgXjGvgjovg59qxYMsyu37WjGBi25eC04mZXDq4hh922v9lOurccAF
	 dkn5Fcqu1HXXobdVQnH4DR1VvsqOkqj0mnQe2hCPXCKhi4f7UcL/jxMGO+ttj7yKnF
	 zYTRcHdLEKipxd9m/wk0Iqkch13qkTO6YYAsyY52+FM/z6IvUInU4gRNimr4uV3DUK
	 2V04rbcrkNrEcjYD8JOxi70s4lLnSTwEGtKMWk7bkW0mWUiSzP/2VnJlNsrqHa9UAX
	 31HPh2PfpJDxFEC9ITzoNduk0Zf/aoi2vx9NSavNg81zbkr73uFmf2o8g/yb/vvILA
	 2Am80cLUWhYuw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 10 Sep 2025 16:36:59 +0200
Subject: [PATCH 14/32] net: use ns_common_init()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-work-namespace-v1-14-4dd56e7359d8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2959; i=brauner@kernel.org;
 h=from:subject:message-id; bh=8/A1bxZ4UuUeHxhFjq1bHDTfg5yr2/KaJ6j+CBu56xs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc7OU4PZ95/+Ut/0WPSvw/Vni2xE5lmsvintqTXjpXW
 B+vaa5P7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIbhlGhjfcfgvWn1tT395t
 mn8p6oaY86ku/4w9q9SOnQp5uFqiQp3hf0r+9MfTP/1yljr/4nFaYNL2eNu66d2vc+J0JKYHOm+
 eywEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Don't cargo-cult the same thing over and over.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 net/core/net_namespace.c | 46 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 1b6f3826dd0e..dafb3d947043 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -397,10 +397,22 @@ static __net_init void preinit_net_sysctl(struct net *net)
 }
 
 /* init code that must occur even if setup_net() is not called. */
-static __net_init void preinit_net(struct net *net, struct user_namespace *user_ns)
+static __net_init int preinit_net(struct net *net, struct user_namespace *user_ns)
 {
+	const struct proc_ns_operations *ns_ops;
+	int ret;
+
+#ifdef CONFIG_NET_NS
+	ns_ops = &netns_operations;
+#else
+	ns_ops = NULL;
+#endif
+
+	ret = ns_common_init(&net->ns, ns_ops, false);
+	if (ret)
+		return ret;
+
 	refcount_set(&net->passive, 1);
-	refcount_set(&net->ns.count, 1);
 	ref_tracker_dir_init(&net->refcnt_tracker, 128, "net_refcnt");
 	ref_tracker_dir_init(&net->notrefcnt_tracker, 128, "net_notrefcnt");
 
@@ -420,6 +432,7 @@ static __net_init void preinit_net(struct net *net, struct user_namespace *user_
 	INIT_LIST_HEAD(&net->ptype_all);
 	INIT_LIST_HEAD(&net->ptype_specific);
 	preinit_net_sysctl(net);
+	return 0;
 }
 
 /*
@@ -559,7 +572,9 @@ struct net *copy_net_ns(unsigned long flags,
 		goto dec_ucounts;
 	}
 
-	preinit_net(net, user_ns);
+	rv = preinit_net(net, user_ns);
+	if (rv < 0)
+		goto dec_ucounts;
 	net->ucounts = ucounts;
 	get_user_ns(user_ns);
 
@@ -573,6 +588,7 @@ struct net *copy_net_ns(unsigned long flags,
 
 	if (rv < 0) {
 put_userns:
+		ns_free_inum(&net->ns);
 #ifdef CONFIG_KEYS
 		key_remove_domain(net->key_domain);
 #endif
@@ -812,17 +828,14 @@ static void net_ns_net_debugfs(struct net *net)
 
 static __net_init int net_ns_net_init(struct net *net)
 {
-#ifdef CONFIG_NET_NS
-	net->ns.ops = &netns_operations;
-#endif
-	net->ns.inum = PROC_NET_INIT_INO;
-	if (net != &init_net) {
-		int ret = ns_alloc_inum(&net->ns);
-		if (ret)
-			return ret;
-	}
+	int ret = 0;
+
+	if (net == &init_net)
+		net->ns.inum = PROC_NET_INIT_INO;
+	else
+		ret = proc_alloc_inum(&to_ns_common(net)->inum);
 	net_ns_net_debugfs(net);
-	return 0;
+	return ret;
 }
 
 static __net_exit void net_ns_net_exit(struct net *net)
@@ -1282,7 +1295,12 @@ void __init net_ns_init(void)
 #ifdef CONFIG_KEYS
 	init_net.key_domain = &init_net_key_domain;
 #endif
-	preinit_net(&init_net, &init_user_ns);
+	/*
+	 * This currently cannot fail as the initial network namespace
+	 * has a static inode number.
+	 */
+	if (preinit_net(&init_net, &init_user_ns))
+		panic("Could not preinitialize the initial network namespace");
 
 	down_write(&pernet_ops_rwsem);
 	if (setup_net(&init_net))

-- 
2.47.3


