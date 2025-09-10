Return-Path: <linux-fsdevel+bounces-60798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 151A0B51A64
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 16:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E0CA1697FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 14:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D438436C09A;
	Wed, 10 Sep 2025 14:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNpamWZu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C3932C33B;
	Wed, 10 Sep 2025 14:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515170; cv=none; b=UzkpgAtrKx72dxPecmeFc+7ZSHxQv+Mr9SY0AGl1pdpk5EjuSeShkjsWrxQURB/euU2O5obOdhiUzcYH26CUw9O2g5ugvBuhsi3t7kXp/2ve/SONM2MPOGnDE12p7uZmPUDAqPX/sy05vz965Zkbo1deXurJA1NNr/SrytzHBik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515170; c=relaxed/simple;
	bh=P3IhXUPNps89Uph+zReDw5Ax8vIvkOOMRZK7+M5sDUk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BFGYlHGQ+cvct3/R+1rWWX6HCwnqzkorrYPHUSIUG2UdjV8xLOafzsLMsET9if2OhmxN+y00ehm5Je4GP5XYN3iHrbtHNX3kKe/aQ/cg737rLN3B4hFfz7oAIt5xyClJgWXv8Ak0jZoHwxjEYnEuSXzvhYzmEzjxQ0Q9tjT51Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNpamWZu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2125AC4CEEB;
	Wed, 10 Sep 2025 14:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757515169;
	bh=P3IhXUPNps89Uph+zReDw5Ax8vIvkOOMRZK7+M5sDUk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BNpamWZu3dbeqglrQf1JNLGdbWHgewpInbIniGQuH9tmBft7dNqMLJ1A99X9o1Rc/
	 verH5pMX3btqjmLVJ2lXhp6c0ndO0KwiSRXq+/3Ywv8MO/hZSmrHA44Dptuh8K/XJm
	 abkeP6t4KovU7hvXq1DqvI5q2t3kWAw1ekqXdRSunMeMGw6AzVnEYRG54OZP2Q3jjt
	 41Ypd1tfF8Y+rQWwKGNpAQv37pI9tIe/cXDv5SWiKsqcndNbR3F4Q3Oqf/dHcP9uKu
	 IUu+ml0+mGzDyZF1TKMRSr7OK0gVGZwAvEq4XFTMUv31ey8rD7zdC7mV5JyCtd7qgl
	 M5m6xW9y4yOlg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 10 Sep 2025 16:37:09 +0200
Subject: [PATCH 24/32] uts: support iterator
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-work-namespace-v1-24-4dd56e7359d8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1533; i=brauner@kernel.org;
 h=from:subject:message-id; bh=P3IhXUPNps89Uph+zReDw5Ax8vIvkOOMRZK7+M5sDUk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc7OWM+JV0QFFvN0P7nLgZWmtOTuu8ySX7/53Z/czC0
 MJ/VrtKO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYS4M3I0FtivvSHmPUnzqsf
 Tt05c7Zb3a12Q/WOp2JSH7cslmOzM2X4n2el0y/bfiaCOSDdtfXxjhzVlMC1e3z2mdv7Ttj7dsM
 aJgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Support the generic namespace iterator and lookup infrastructure to
support file handles for namespaces.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/utsname.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/utsname.c b/kernel/utsname.c
index 02037010b378..64155417ae0c 100644
--- a/kernel/utsname.c
+++ b/kernel/utsname.c
@@ -13,6 +13,7 @@
 #include <linux/cred.h>
 #include <linux/user_namespace.h>
 #include <linux/proc_ns.h>
+#include <linux/nstree.h>
 #include <linux/sched/task.h>
 
 static struct kmem_cache *uts_ns_cache __ro_after_init;
@@ -58,6 +59,7 @@ static struct uts_namespace *clone_uts_ns(struct user_namespace *user_ns,
 	memcpy(&ns->name, &old_ns->name, sizeof(ns->name));
 	ns->user_ns = get_user_ns(user_ns);
 	up_read(&uts_sem);
+	ns_tree_add(ns);
 	return ns;
 
 fail_free:
@@ -93,10 +95,12 @@ struct uts_namespace *copy_utsname(unsigned long flags,
 
 void free_uts_ns(struct uts_namespace *ns)
 {
+	ns_tree_remove(ns);
 	dec_uts_namespaces(ns->ucounts);
 	put_user_ns(ns->user_ns);
 	ns_free_inum(&ns->ns);
-	kmem_cache_free(uts_ns_cache, ns);
+	/* Concurrent nstree traversal depends on a grace period. */
+	kfree_rcu(ns, ns.ns_rcu);
 }
 
 static inline struct uts_namespace *to_uts_ns(struct ns_common *ns)
@@ -162,4 +166,5 @@ void __init uts_ns_init(void)
 			offsetof(struct uts_namespace, name),
 			sizeof_field(struct uts_namespace, name),
 			NULL);
+	ns_tree_add(&init_uts_ns);
 }

-- 
2.47.3


