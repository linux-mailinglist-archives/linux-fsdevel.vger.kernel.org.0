Return-Path: <linux-fsdevel+bounces-61066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97571B54C49
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 14:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21BE31CC7C02
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 12:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743CC31E107;
	Fri, 12 Sep 2025 11:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyR1gaLi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A14305E18;
	Fri, 12 Sep 2025 11:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678102; cv=none; b=ZF7sG3ZPF9GA467A7vkLEG6pVtqmfHUZz5T9Dd+WtCougWUiN8oZBooNDhBliqAdhZX8cRJHSqKgqy4uTXNB3TMZg8cuckNnClclcnjBcoU1rZa28Tg3vGMSnCEW6Ry6vUGYuSV0LhjIYOBzDoqCmslQbsdEXqVPdJxA38LjrkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678102; c=relaxed/simple;
	bh=kN8v0sLAXBF26II0zW4i59PTeEKnOPKRZO2QB53SEc4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NtIrkMEgv9YWMG8cS0GQk55SfIVCbA5x0liIHMXnSyHtOS6dwd6F3/3lcT3u0OcDK5eNfCqfbr4eAEhEl5pBqMnG2r148j5yk1RkUUNxtXFktGHwa0mwDH8CQK+H8FpEM8bWvWcBqdLi+GoIP/pNxRvaonOfT9PDM+IKODqdZBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OyR1gaLi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9728C4CEF1;
	Fri, 12 Sep 2025 11:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757678102;
	bh=kN8v0sLAXBF26II0zW4i59PTeEKnOPKRZO2QB53SEc4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OyR1gaLiOFLViltXQlTo0yz07isKA7bbzuNSbAEDIcwYTm9mVLg3zY/1fuPH10G3X
	 gn2ywMw5bfFmBAaqOqCvcvi40Hx8NTRaI07cBIv7dNfsolFo23ECAU0yToPYVL5PL6
	 Hq3Z/D2rkS1aiB+inibkpeSBFP7iWXtTxN2aOW6eavpIXCNaCwae1dO4CqOb1WTg4y
	 HiaISxcbS0hezmrTuivZ7/kCP5QUGo1GB1DpNKyr+y2OyYnXfL1N9f4WKsI9Xh/wBL
	 OMl0VmGfjXcZLQO9z/vuJArBFh3el0x9ebwHzPUTyAh+X5V+xErbogzksg1SCatZrQ
	 WRaiXaYiPpnTw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 12 Sep 2025 13:52:44 +0200
Subject: [PATCH v2 21/33] net: support ns lookup
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-work-namespace-v2-21-1a247645cef5@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2307; i=brauner@kernel.org;
 h=from:subject:message-id; bh=kN8v0sLAXBF26II0zW4i59PTeEKnOPKRZO2QB53SEc4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc4Zy694Dd3dSmksOH599+sYfjx5PU+cLeWR/iKyIWS
 +/UmLbtb0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEppYwMpycZhZ46sodo/pz
 c8JXyK8p/+V19nTh7//n2ae5S8vuWXmc4Z/BBHu2qoZLW5ZbNm9UOPRqnqEf2wmdu+WN6emXtO5
 7BvICAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Support the generic ns lookup infrastructure to support file handles for
namespaces.

The network namespace has a separate list with different lifetime rules
which we can just leave in tact. We have a similar concept for mount
namespaces as well where it is on two differenet lists for different
purposes.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/net/net_namespace.h | 1 +
 net/core/net_namespace.c    | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 025a7574b275..42075748dff1 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -11,6 +11,7 @@
 #include <linux/list.h>
 #include <linux/sysctl.h>
 #include <linux/uidgid.h>
+#include <linux/nstree.h>
 
 #include <net/flow.h>
 #include <net/netns/core.h>
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 5fb7bd8ac45a..169ec22c4758 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -20,6 +20,7 @@
 #include <linux/sched/task.h>
 #include <linux/uidgid.h>
 #include <linux/proc_fs.h>
+#include <linux/nstree.h>
 
 #include <net/aligned_data.h>
 #include <net/sock.h>
@@ -445,7 +446,7 @@ static __net_init int setup_net(struct net *net)
 	LIST_HEAD(net_exit_list);
 	int error = 0;
 
-	net->net_cookie = atomic64_inc_return(&net_aligned_data.net_cookie);
+	net->net_cookie = ns_tree_gen_id(&net->ns);
 
 	list_for_each_entry(ops, &pernet_list, list) {
 		error = ops_init(ops, net);
@@ -455,6 +456,7 @@ static __net_init int setup_net(struct net *net)
 	down_write(&net_rwsem);
 	list_add_tail_rcu(&net->list, &net_namespace_list);
 	up_write(&net_rwsem);
+	ns_tree_add_raw(net);
 out:
 	return error;
 
@@ -674,8 +676,10 @@ static void cleanup_net(struct work_struct *work)
 
 	/* Don't let anyone else find us. */
 	down_write(&net_rwsem);
-	llist_for_each_entry(net, net_kill_list, cleanup_list)
+	llist_for_each_entry(net, net_kill_list, cleanup_list) {
+		ns_tree_remove(net);
 		list_del_rcu(&net->list);
+	}
 	/* Cache last net. After we unlock rtnl, no one new net
 	 * added to net_namespace_list can assign nsid pointer
 	 * to a net from net_kill_list (see peernet2id_alloc()).

-- 
2.47.3


