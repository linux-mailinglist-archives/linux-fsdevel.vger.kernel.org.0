Return-Path: <linux-fsdevel+bounces-60792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5506B51A16
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 16:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECEB9188393E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 14:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9221335CEBF;
	Wed, 10 Sep 2025 14:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNSxojO/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D293A35AACA;
	Wed, 10 Sep 2025 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515134; cv=none; b=TzL1oPAk7pBqwg+BMKrAtqOmC1ejl3oE12gGoxMPRfT2uODqT590AI538tWyS+vSpFLtAmK1+R+acFJI3I4bA4WBR2oz5vUmGBrSVlsqFiRY8TP85H0PnYs4ua1tP3hakATXVwDDNU19PtbTteJZkp7S2MLrJvZSJ2podeRA4No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515134; c=relaxed/simple;
	bh=RvFeGI2dajh/uWdk6ZQQzDx/eoO/tdatpOIxDDd51DM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PF65InOs1OvhJJatQs8aorbbF83g6dMQ1o+daFJ4jlYHGEiGtjD6vyxroyK60Otwa4AcCFmtQ0IuHeU9q/H55fVQi2AbyYnfVIE7fOMMn3j+H4wyC/vF16uHc+4qnY4Z4o7slJl2/fZosbqLzWeC1NO1sCrSG5aAbQGCWN7VAM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNSxojO/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18928C4CEEB;
	Wed, 10 Sep 2025 14:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757515133;
	bh=RvFeGI2dajh/uWdk6ZQQzDx/eoO/tdatpOIxDDd51DM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cNSxojO/1LYvZNyxyrmdUEta7H4YZFjaxNW+msfaTODmiPO0f2SzoF852yrPKnceq
	 79JsILqca50TYBwuzzMG5ZzUDOcal6leKm5OQXJtS/EXl3gP1GI0s0bRQ4JB9D/jD8
	 Cuq3uflPHIS9ZxPswx6ZZDTevUaEzZKhrq3OP+nqTdYNhPLomIyl1QB8RiliBHSZLF
	 IWnTbYnQPCxaY9ILVPN/eVUY8dkSoZ6w3nPrRyRzwalseaF+qGcH1xqIuwUE8OPPJA
	 gm0EhBiQg2c0x01IKF/qfylwNsONYcZw6Q+uaWNmj7ueBFw/gzyFsmbNZDTcj9jkzm
	 zRT3NLHeHzkbQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 10 Sep 2025 16:37:03 +0200
Subject: [PATCH 18/32] cgroup: support iterator
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-work-namespace-v1-18-4dd56e7359d8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1771; i=brauner@kernel.org;
 h=from:subject:message-id; bh=RvFeGI2dajh/uWdk6ZQQzDx/eoO/tdatpOIxDDd51DM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc7OXobvnJkqPU4Rf6ualKL+tQhfS1P6+yvk2TPzBRe
 YfSnW8zO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaSZs7wP9V1whZW5nyvGgkB
 c53u10t7fIL3P1PbN02ch4PlIttNUUaGm6f85nSxSTJvNpaJ/dz1/OUNteS6SOkXe1L0XnEYC+9
 hAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Support the generic namespace iterator and lookup infrastructure to
support file handles for namespaces.

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


