Return-Path: <linux-fsdevel+bounces-61056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91623B54BF4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 13:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3AB6A05510
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 11:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418C730DEDC;
	Fri, 12 Sep 2025 11:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRV7pcoY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2643043B3;
	Fri, 12 Sep 2025 11:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678044; cv=none; b=ZcqGEmRRXbV9HsWR1ifZ2sogGkIYjFy7NOJaAkxmC+EDYOKlMxXuUdRofnwtCh5agdmkKi6uilTNwASUlHOZPchmpGbujz+2YoYxXnmydPvFDq0YCvQNX8lZ3+9qkK9B6qwgS+BGD4QoXY/MJ5gte+J4QCzEpF68FGVIG31AB5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678044; c=relaxed/simple;
	bh=SW4LUAStSLrCqB2DKL4lsJofoDPGCAkW5MTBrwabxew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZpTp4SEDTby4bqjP/JwsqKrJB77cPis9QlqKAHmfSBsK0RHm0bZ+97IeHm3e5i8o3xwvAsyxRkrftIUbBgZeutYRxB6wMN6m9UeHF++WeVmgWQtWb4K52pEvc1jOS9fnHsOsMZuh7a0fKnIAKUu+d80YeWzRwIdMAPb8UkX0Ums=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRV7pcoY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B67C4CEF4;
	Fri, 12 Sep 2025 11:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757678044;
	bh=SW4LUAStSLrCqB2DKL4lsJofoDPGCAkW5MTBrwabxew=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BRV7pcoYwdrjaSGKyyVyiwIeS6TdXVrtIkLxYnac3PKWGkqdwVYkwBoDrx81oggbx
	 I5UQjpWXP9Nw5eJAZ/16nHgF035FABZ84Plbucmb3EZYSXtUBNRJgvKmsyVUdmgTS3
	 ZYR0zabwhg/SAyHMP1AaPZ1SR1O4AL0hj3PA+n28szT4Gp/qjB8NrzOAX96wtvTQiA
	 LWPRPMtXnAeb5YpATPeBN1phr9Ne7qOR4H7D2hwVqm/bFOMdapsQoZJcq4QNiv9kQn
	 HgyE/1eCglE+FKoswVeREBFw9YZ4WOevVLoFGt190gvrvvgVz+gCb/mAg9egATf/0d
	 0pgzvaYoi0oxw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 12 Sep 2025 13:52:34 +0200
Subject: [PATCH v2 11/33] net: use ns_common_init()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-work-namespace-v2-11-1a247645cef5@kernel.org>
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
 netdev@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.14.3-dev-385fa
X-Developer-Signature: v=1; a=openpgp-sha256; l=2716; i=brauner@kernel.org;
 h=from:subject:message-id; bh=SW4LUAStSLrCqB2DKL4lsJofoDPGCAkW5MTBrwabxew=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGjECZSg9fts7U0PLPwltiiV8WGl29QXw4zVDZ582nzkZrcE7
 Yh1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmjECZQACgkQkcYbwGV43KLv5wD/b+5D
 tnQO6geLrj/AlFV8/xWTdgCcWCCN5p7w4AlyhlsA/1nwzFORyyHYFY8gO0A+YE0I7SDvV5bjyaP
 rmrOqAloG
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Don't cargo-cult the same thing over and over.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 net/core/net_namespace.c | 46 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 13 deletions(-)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 1b6f3826dd0e..5fb7bd8ac45a 100644
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
 
@@ -812,15 +827,15 @@ static void net_ns_net_debugfs(struct net *net)
 
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
+	if (ret)
+		return ret;
+
 	net_ns_net_debugfs(net);
 	return 0;
 }
@@ -1282,7 +1297,12 @@ void __init net_ns_init(void)
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


