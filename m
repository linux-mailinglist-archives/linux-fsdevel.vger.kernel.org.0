Return-Path: <linux-fsdevel+bounces-60794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F72FB51A48
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 16:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5A9C5E396C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 14:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5C136207B;
	Wed, 10 Sep 2025 14:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFZGoyG/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15AC315D34;
	Wed, 10 Sep 2025 14:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515146; cv=none; b=f99u2QWa8MoX5zYCQyIE8mvQFDVAw6UxrSy+6iyLUmndedEMjmVGW8sBy6iSLpELVKQJbfRs9H7MywzMOS7W8PbbwpnqRaGWIoyWSjMMjS99v7rl50NdZpI51cpxMl2ko+pklxvKN5CCfmxdtCOQ5LJd51cYhheeIFJ+wfLmd6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515146; c=relaxed/simple;
	bh=oRiUykJBQlga5zzzIWDVy4MBnAL3DsvpFayNB03RaHE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P8zGtLKmO7/gyZwHyL9Rd8feph/k8/6fZZCYQ+MqehbrAVb0jjA4H5FvWXXHYV1VUTT4OkqDMuY5kkhtH9DSm/d++CxeiXXRCik64BD3JKYGUXqt2EJZ7vAfyrUxSBbT/gz7ebYSk+gWvSZoYO+tdI1XnkAhtoAckyyLIGlRP2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFZGoyG/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45032C4CEFB;
	Wed, 10 Sep 2025 14:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757515145;
	bh=oRiUykJBQlga5zzzIWDVy4MBnAL3DsvpFayNB03RaHE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TFZGoyG/GiHUMR8YVToC8GQ1OzLSta6G7n5Awy2McTrAlN/O060DW1PkblGtmiqwD
	 oV+CVvgTzE0qDfswWMZ6o7NDzFx48qSPIB8efED+62Wpzj62CK/c7QA8xMqEfMDuXk
	 ZJ+O+QK9Wvb3clsNCV9/hSOKq3YZEyD50GJ95O0LFlrnd+N0Yjm0NY7p5miBUDcEzg
	 F1+6HgdaV0nItBn6Zzd3C/0HAT1x/wQNYCOZuYz71nzgDwCgqagH52tf7pkY9p81gE
	 Ujuu1HR4a/fVa8eR64Hb9i3M2KhBFEV3ndUiqS+uUKJBtPcanhra0OKm4GT0umqXop
	 ecXBij+QenReA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 10 Sep 2025 16:37:05 +0200
Subject: [PATCH 20/32] net: support iterator
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-work-namespace-v1-20-4dd56e7359d8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2327; i=brauner@kernel.org;
 h=from:subject:message-id; bh=oRiUykJBQlga5zzzIWDVy4MBnAL3DsvpFayNB03RaHE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc7OWQrLYIdJ/EVht1x/1xW/KhAN/VDWJ537N9lTM39
 laV7XHqKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmMgrbkaGtxdWRqu8mHdJZlLM
 Tof79ZNXtQv9ObT794GW75FLL+qdPsvIsDBWrOH32jnsXExxN/w5Gos48yNq1c8uOmQm7fYi2u4
 3KwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Support the generic namespace iterator and lookup infrastructure to
support file handles for namespaces.

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
index dafb3d947043..b85e303400be 100644
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
 
@@ -675,8 +677,10 @@ static void cleanup_net(struct work_struct *work)
 
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


