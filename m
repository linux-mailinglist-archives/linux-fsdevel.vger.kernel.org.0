Return-Path: <linux-fsdevel+bounces-60797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A0DB51A5F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 16:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A2BFA021A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 14:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA80936999C;
	Wed, 10 Sep 2025 14:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFS4cfCo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CCD3375C2;
	Wed, 10 Sep 2025 14:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515164; cv=none; b=Cr0GhzwGQqmv023OIS7gCQyr/OFKdtXm8/FPCPHpz6tsSiB/50hr4YMfJaOQXrWeeL6Kg8YQSOu7no2tIeVm7oh6f8UIC12QMlEKeSpSkMzerOMoN7PWUFsoMg3ZAOkQYhVWZ1nHgyo0JiDWHvRiyt/A6UJ7y5UBeC1fCnsUTn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515164; c=relaxed/simple;
	bh=+TCT1A2PXWX9oafBWWfg0Q4e6cJwE6zfwnH7FmipbWw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=adwlvMbNh7szkvxzvYbTyaA5qAksdFmUXWcWsS9XY7K9aoEvB2s1G5gMlZP14V8+rjtmQOdtJKwPI1oAdj6i81x2cNZMrSdCaGrN7Lh0BqMSJVjjscY5BHgrvvPRRMeRD8SbpgpugCuzBgwxGkzJ7Q9jPdb1ZCn5BVEghlH9TGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFS4cfCo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157E7C4CEF9;
	Wed, 10 Sep 2025 14:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757515163;
	bh=+TCT1A2PXWX9oafBWWfg0Q4e6cJwE6zfwnH7FmipbWw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kFS4cfCotJxoY26zSFArrXF+MNIMxAQaiiE5m9sw/4RzgIqxe52wdB3aTBbJWFJ3N
	 Yp+X/rKAT4YMMCRAKJGfxmLCk1wlNmpLZF8XtT66gomAMz8GXC0x9HpxGdrld6OHuj
	 X7hki8hDcxCKeXDiCgHhao6Fx9y8NZQbwnczOMBRsoxYSagaQQq3DgCsoyWJersyR0
	 NCTB5TFTRpxyfv22j2alGnpZ4J1RyaUoROUoDX2SpEP+Y8BNpOORAe023mapuQJ9a4
	 JfUD1hD9NHRJL6vfJ7eceG9CJV7NaJBCFb2wZTn4oliqBfiBiTWmjRvwT0DIeBcH9S
	 ojM/IgV2FnNMQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 10 Sep 2025 16:37:08 +0200
Subject: [PATCH 23/32] userns: support iterator
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-work-namespace-v1-23-4dd56e7359d8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1871; i=brauner@kernel.org;
 h=from:subject:message-id; bh=+TCT1A2PXWX9oafBWWfg0Q4e6cJwE6zfwnH7FmipbWw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc7OX0e/h4yyanU4d/frgY96fu4xeWAKfrbst6esKFZ
 K7MmHs5oqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiBzcw/M9edPK/+sm/y2/K
 J1scCze4f/jf8cwQ840MTzZ32SdraTxi+O88ybOk+EbSi90Jc9ayHLLS+Sp24oH5juyTu+wSDdO
 SvNkB
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Support the generic namespace iterator and lookup infrastructure to
support file handles for namespaces.

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


