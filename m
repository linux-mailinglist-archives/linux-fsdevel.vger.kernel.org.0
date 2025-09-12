Return-Path: <linux-fsdevel+bounces-61064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A604B54C3B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 14:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB598189AB49
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 12:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E367301475;
	Fri, 12 Sep 2025 11:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEL9gfAr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDCD305E1B;
	Fri, 12 Sep 2025 11:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678090; cv=none; b=o1mJ8wDmnmCjIDriXrtdGbIbi6jYOE39EInXK9mybzjpiLx3PQ11H4mk01jo8XnlZWeWaiLZ1GftOl5RGihE8PhQ/dwjcZag+2rr9ttTXZ+rdh9jO2qUDR+n6yWn9d0tlFjhQy37137sAoM5WyISSPYQpyjwz7pq4ZTp2UpolKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678090; c=relaxed/simple;
	bh=zXzswUxucAZ3erAopYaaLksXgDoG/F+VNyIyuNZ/PzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PKowkvThN1S8B/Tr8+KUildGgepraQ1KAvoRXUmNcEv9rXNwFwIAzOVGXY434/nCNBBZ5cNh1mJRdQhCbRWrGaQgvvh49meHCTClL4ZL9c7kAXZuBzGkJJjzM22b1sWA3CyiuV8LcHwUUActMUAJHZUhGQNLTlbkuZVvoH1IKuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEL9gfAr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C88C4CEFB;
	Fri, 12 Sep 2025 11:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757678090;
	bh=zXzswUxucAZ3erAopYaaLksXgDoG/F+VNyIyuNZ/PzY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WEL9gfArHvVkhsly6oAcu9lfW+/Ekmnt4Z43f9JIz8gxVOuMUUssnExgVW8pn3PNC
	 bEyFsBCkD7Q/6fYd3g3KAqmIxxJ4L32XLD9uSSEgt/IAPD4R4dVm5uQSA78+5v7g2O
	 5lbOTNUanEzK1WRtMmq26OEwavhT+hhQkejLNFrkTBAAwMRcY4tfkV6sB8moBSWxgW
	 vH0sf2Qo7oZOYJrptNZD0OB9Dn8osxFCR38XxjkAy7nSOpYY0CZs/5YNEOTo83VQHc
	 6UuGZl457+Fzusuwi5jDeO1r57mlEITSxVZSXGNbVLcWoqNmUGUQm/N/qVZN2hkDbg
	 HgcWqAVykmNRw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 12 Sep 2025 13:52:42 +0200
Subject: [PATCH v2 19/33] cgroup: support ns lookup
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-work-namespace-v2-19-1a247645cef5@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1788; i=brauner@kernel.org;
 h=from:subject:message-id; bh=zXzswUxucAZ3erAopYaaLksXgDoG/F+VNyIyuNZ/PzY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc4ZzqsLrsz4+ZpzzWSyWb6O+vbehprV6wIjny7WZ5q
 6444/uiHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOpqGT473jASWN2ecX50zuT
 mjes1P50wEtPTc/p8EPHzy8eh2/dw83IsPHuuleSRQlKj8WLOR6of7QM8uut3lLd5Oqzp/DEIo5
 wFgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Support the generic ns lookup infrastructure to support file handles for
namespaces.

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/cgroup/cgroup.c    | 2 ++
 kernel/cgroup/namespace.c | 7 +++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 312c6a8b55bb..092e6bf081ed 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -59,6 +59,7 @@
 #include <linux/sched/cputime.h>
 #include <linux/sched/deadline.h>
 #include <linux/psi.h>
+#include <linux/nstree.h>
 #include <net/sock.h>
 
 #define CREATE_TRACE_POINTS
@@ -6312,6 +6313,7 @@ int __init cgroup_init(void)
 	WARN_ON(register_filesystem(&cpuset_fs_type));
 #endif
 
+	ns_tree_add(&init_cgroup_ns);
 	return 0;
 }
 
diff --git a/kernel/cgroup/namespace.c b/kernel/cgroup/namespace.c
index 0391b6ab0bf1..fc12c416dfeb 100644
--- a/kernel/cgroup/namespace.c
+++ b/kernel/cgroup/namespace.c
@@ -5,7 +5,7 @@
 #include <linux/slab.h>
 #include <linux/nsproxy.h>
 #include <linux/proc_ns.h>
-
+#include <linux/nstree.h>
 
 /* cgroup namespaces */
 
@@ -30,16 +30,19 @@ static struct cgroup_namespace *alloc_cgroup_ns(void)
 	ret = ns_common_init(&new_ns->ns, &cgroupns_operations, true);
 	if (ret)
 		return ERR_PTR(ret);
+	ns_tree_add(new_ns);
 	return no_free_ptr(new_ns);
 }
 
 void free_cgroup_ns(struct cgroup_namespace *ns)
 {
+	ns_tree_remove(ns);
 	put_css_set(ns->root_cset);
 	dec_cgroup_namespaces(ns->ucounts);
 	put_user_ns(ns->user_ns);
 	ns_free_inum(&ns->ns);
-	kfree(ns);
+	/* Concurrent nstree traversal depends on a grace period. */
+	kfree_rcu(ns, ns.ns_rcu);
 }
 EXPORT_SYMBOL(free_cgroup_ns);
 

-- 
2.47.3


