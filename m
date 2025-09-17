Return-Path: <linux-fsdevel+bounces-61907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01046B7F50D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 15:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAC425257CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 10:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C10350D47;
	Wed, 17 Sep 2025 10:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTbkJxOo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D6735084A;
	Wed, 17 Sep 2025 10:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758104950; cv=none; b=qO2HurJuN0bqF709DYTHmhqOW93n61vU/H6CZ5eRDIKulFfgd7YG9MiAXGnd8dPzwUqkxG8t566iTSPhugEutqt/x3svE7r4gJNj4uVn6ZsZwMDcj8AClbQGri9y0zEldPvryoccBGhENI/xy86rEA0gipjm2tXS8P5CdPSK0lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758104950; c=relaxed/simple;
	bh=3Hqga83UDAk5jGtzoEZoqgWwOQ+JDaB906VMcmnlsao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FyKDpgQkiEaMpP+120ixM+PwDTpiREBdOC/wTYmVYxAIMq4sw0wHu5shtyRDXyudpfvZwenPO8KjMtr6RkQL7IchtlIe2GA3zW1LPWZ2eT/evn7mqlekeNxKmieg3/oCujmItoanfqjBP/0CFv0KrXeCR1+S9WVynpTJk55UqZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTbkJxOo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36447C4CEF5;
	Wed, 17 Sep 2025 10:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758104949;
	bh=3Hqga83UDAk5jGtzoEZoqgWwOQ+JDaB906VMcmnlsao=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZTbkJxOoP4FsrDFZpKG89wT8zHS98PFuQq9r6FpbTkfnElZxJVpTFdt/qW0HGo2wk
	 5rcPG2+CK99G6SaAjJME1vbmirza+C+RoDPk1TkWQl7qbIaURRWBdZDNQAfWsEPlht
	 mTe/+mrT7t5bIQLY09G+cF8HalMdmC3MQqn/zxd930dM4LNNlw/MW1jzdWK261tDaZ
	 yMCKcik4DePh7/3mlPbbYPSgeTqUyepoHXZdRQFWAs8nutAQv8GZgR7Kw1SLEf91O4
	 yQITTitys5JUamEFayYmeO/o86czPsM6hP/9cv+tDyESE96JWbQ2l4m/+MUKCGoH5n
	 9bAZCOd+UEnfw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 17 Sep 2025 12:28:06 +0200
Subject: [PATCH 7/9] net: centralize ns_common initialization
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-work-namespace-ns_common-v1-7-1b3bda8ef8f2@kernel.org>
References: <20250917-work-namespace-ns_common-v1-0-1b3bda8ef8f2@kernel.org>
In-Reply-To: <20250917-work-namespace-ns_common-v1-0-1b3bda8ef8f2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1838; i=brauner@kernel.org;
 h=from:subject:message-id; bh=3Hqga83UDAk5jGtzoEZoqgWwOQ+JDaB906VMcmnlsao=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSc6vUrqJFKfr2kvlDV9qOstrlsX98Pi7wDlhfv6Bmaz
 arvYqzsKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmMjiFoa/QkrXa+KCfX7t2p2S
 es62TFW44+ht65Q94ec+2now6x2NYfjvcnDCHJaFPZXrw38x/51yWyPm2saSdT6JMzrbXHKqY75
 wAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Centralize ns_common initialization.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 net/core/net_namespace.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index a57b3cda8dbc..897f4927df9e 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -409,7 +409,7 @@ static __net_init int preinit_net(struct net *net, struct user_namespace *user_n
 	ns_ops = NULL;
 #endif
 
-	ret = ns_common_init(&net->ns, ns_ops, false);
+	ret = ns_common_init(&net->ns, ns_ops, true);
 	if (ret)
 		return ret;
 
@@ -597,6 +597,7 @@ struct net *copy_net_ns(unsigned long flags,
 		net_passive_dec(net);
 dec_ucounts:
 		dec_net_namespaces(ucounts);
+		ns_free_inum(&net->ns);
 		return ERR_PTR(rv);
 	}
 	return net;
@@ -718,6 +719,7 @@ static void cleanup_net(struct work_struct *work)
 #endif
 		put_user_ns(net->user_ns);
 		net_passive_dec(net);
+		ns_free_inum(&net->ns);
 	}
 	WRITE_ONCE(cleanup_net_task, NULL);
 }
@@ -831,31 +833,12 @@ static void net_ns_net_debugfs(struct net *net)
 
 static __net_init int net_ns_net_init(struct net *net)
 {
-	int ret = 0;
-
-	if (net == &init_net)
-		net->ns.inum = PROC_NET_INIT_INO;
-	else
-		ret = proc_alloc_inum(&to_ns_common(net)->inum);
-	if (ret)
-		return ret;
-
 	net_ns_net_debugfs(net);
 	return 0;
 }
 
-static __net_exit void net_ns_net_exit(struct net *net)
-{
-	/*
-	 * Initial network namespace doesn't exit so we don't need any
-	 * special checks here.
-	 */
-	ns_free_inum(&net->ns);
-}
-
 static struct pernet_operations __net_initdata net_ns_ops = {
 	.init = net_ns_net_init,
-	.exit = net_ns_net_exit,
 };
 
 static const struct nla_policy rtnl_net_policy[NETNSA_MAX + 1] = {

-- 
2.47.3


