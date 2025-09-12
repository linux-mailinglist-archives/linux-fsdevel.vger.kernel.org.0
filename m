Return-Path: <linux-fsdevel+bounces-61069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98076B54C75
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 14:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 741F1587514
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 12:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0485D324B35;
	Fri, 12 Sep 2025 11:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+OTtfOO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421C3321433;
	Fri, 12 Sep 2025 11:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678121; cv=none; b=VqsMN0y5JfjdCDC8MygPhTPg8ASDDmfGzvhhTRjcSTesdZ+cf4h6nCbZSPGpVdTdq4yg2OO+eYk4INuEcoDh+SqANEQv5xokwispZGZ6Ce4N1Su38wT5E2YIKGWC0GKsyoFXV0Q8DqtMNM38M0F+n5ca1+e1JbPssmEmx0M1iNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678121; c=relaxed/simple;
	bh=1uuAWE+9wcYclZLD/iGw4RWTIUE3fwd+fasv7dDD/Xo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UatH2hD5FVKb/RX2DI6HqK2Pmsf9xASHJhxYod1iDlsmkIscb2aRm0KO1EerEfk1ZC/USGZ+DS3jmyRzn4l8q16nBrvXkrboVJcn88NuxvcpBeStvRHJ7TGvJXcqAC3DdS63iU1TfsH9wEfAaC9b7ciggdJ7kG2iAX0kteL8sqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+OTtfOO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED13FC4CEF4;
	Fri, 12 Sep 2025 11:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757678120;
	bh=1uuAWE+9wcYclZLD/iGw4RWTIUE3fwd+fasv7dDD/Xo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=t+OTtfOOK0d476r5GS6+zZvRDs2ZEG+JYGk0+wWwh/AwJSMuQSlQiUl9/BLy2hH4E
	 c1/EP9tAbti4UCKTCLiFa95z6RoVaFKp/VDx3FIRndSa3Up7wrLDQ1IwXMNaqG/rCd
	 NXOr/0CM8izUgR81/MAWhJzzCQ0ruNkCIVQBjWgwBLt61lUwnhzS68q+Cikz8Jcd/8
	 pbL5a1e4fFdJhbgcUwBcOg5Pk3tg7NOkHAwPmC+m5Qic1ha1vCs0bWfCCcDPQCIX8g
	 O8YiNKrA5Zrx17Mrt0/UXu/IbHBEHDJwTeU7yxpDN/mBgE9+aFBTiWDPexDi4My9ZK
	 fNGqwCjU8gU2A==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 12 Sep 2025 13:52:47 +0200
Subject: [PATCH v2 24/33] user: support ns lookup
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-work-namespace-v2-24-1a247645cef5@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1851; i=brauner@kernel.org;
 h=from:subject:message-id; bh=1uuAWE+9wcYclZLD/iGw4RWTIUE3fwd+fasv7dDD/Xo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc4Zz6MLOMtWO9v6rGKpFF/2QZJvg3GgnoV2kd9Qy3u
 mt0rYuxo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCKn9jAy7PFqrNu3ffXdm5+r
 D/gccjabNHfxgl8977XXtEztMBbd+ImRYV9iT+jvMwE1m3d+ZQmY82hyosTCnI1+H5pXvP45573
 zSR4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Support the generic ns lookup infrastructure to support file handles for
namespaces.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/user_namespace.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 98f4fe84d039..ade5b6806c5c 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -21,6 +21,7 @@
 #include <linux/fs_struct.h>
 #include <linux/bsearch.h>
 #include <linux/sort.h>
+#include <linux/nstree.h>
 
 static struct kmem_cache *user_ns_cachep __ro_after_init;
 static DEFINE_MUTEX(userns_state_mutex);
@@ -158,6 +159,7 @@ int create_user_ns(struct cred *new)
 		goto fail_keyring;
 
 	set_cred_user_ns(new, ns);
+	ns_tree_add(ns);
 	return 0;
 fail_keyring:
 #ifdef CONFIG_PERSISTENT_KEYRINGS
@@ -200,6 +202,7 @@ static void free_user_ns(struct work_struct *work)
 	do {
 		struct ucounts *ucounts = ns->ucounts;
 		parent = ns->parent;
+		ns_tree_remove(ns);
 		if (ns->gid_map.nr_extents > UID_GID_MAP_MAX_BASE_EXTENTS) {
 			kfree(ns->gid_map.forward);
 			kfree(ns->gid_map.reverse);
@@ -218,7 +221,8 @@ static void free_user_ns(struct work_struct *work)
 		retire_userns_sysctls(ns);
 		key_free_user_ns(ns);
 		ns_free_inum(&ns->ns);
-		kmem_cache_free(user_ns_cachep, ns);
+		/* Concurrent nstree traversal depends on a grace period. */
+		kfree_rcu(ns, ns.ns_rcu);
 		dec_user_namespaces(ucounts);
 		ns = parent;
 	} while (refcount_dec_and_test(&parent->ns.count));
@@ -1412,6 +1416,7 @@ const struct proc_ns_operations userns_operations = {
 static __init int user_namespaces_init(void)
 {
 	user_ns_cachep = KMEM_CACHE(user_namespace, SLAB_PANIC | SLAB_ACCOUNT);
+	ns_tree_add(&init_user_ns);
 	return 0;
 }
 subsys_initcall(user_namespaces_init);

-- 
2.47.3


