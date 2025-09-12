Return-Path: <linux-fsdevel+bounces-61070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B1260B54C40
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 14:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9AC5C4E2F6E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 12:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC6232A805;
	Fri, 12 Sep 2025 11:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTURILdJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73313074A6;
	Fri, 12 Sep 2025 11:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678126; cv=none; b=LPu4buKyMkO/KJsuLR3WTwfjxBCFbFlBPzpBr/XxH7TJrx4xmLNqBAzcsmkyANFe8RIWe7SPI5Taxk8ZTSzEkP2MLIdhAH7R6/vrC1eVf/Xt3dNOiAZhmJN2hlRhT2jSFysOi8i0lD29PqLzzvJa7ARFIN23fqcQxwm8rOhWU2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678126; c=relaxed/simple;
	bh=De4ojnwgkm9eMqqPSKyIiyLz23QqFGKtmyVxTIjNLfQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TzxUrVfKuSEd5HGcMarDK0119RJSHLvDPLgG1fl7Lwtx1RGvu0wFS5nUKlL7hLSIZ6ImO0lJsEBLjMFLebDQ2CiWztmuAUoVZx04az5KZkj2TZv6ZS0tNN/0VzYlEllBCIleUo1pmeyD1dBmZnywT47jr1hwuGdqU0qrm2NeZjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTURILdJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA131C4CEF1;
	Fri, 12 Sep 2025 11:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757678126;
	bh=De4ojnwgkm9eMqqPSKyIiyLz23QqFGKtmyVxTIjNLfQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JTURILdJEmUAkvarf7UQC84aYm10rNqAw5HpdHjauWZLfC0GrHmQearLU5fScYn+y
	 V2oBasrmX3kOTVFo9pnBHmb44R/gj+FRboyQvULGBvrfpxekF2o9Uvtuc3o+2cP8SW
	 x1WlJrz+OTG0eaMNTm+tA0TxVmItm9CEEzOaPepi8FmVF7qxF7m89yzwKL5bibMTEK
	 roI6rn/NVqGAlYyCi9B4VdOZSxLkS0O8R26DG37srP0Eilc8Ncnw6BRg5Fm1Gmys1n
	 gJ+IHHJcznIQK8mlmF5jI6MABZE35fT94bw6+wLIckgZlzUzxzXXQUtgGzCXqAqbIR
	 G7DD/I+kCH1wQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 12 Sep 2025 13:52:48 +0200
Subject: [PATCH v2 25/33] uts: support ns lookup
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-work-namespace-v2-25-1a247645cef5@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1513; i=brauner@kernel.org;
 h=from:subject:message-id; bh=De4ojnwgkm9eMqqPSKyIiyLz23QqFGKtmyVxTIjNLfQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc4Zz6modrmXDq9G1+zmmCz/3XLI0SUudUEOHMKDzMV
 qGpcfxtRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwET+hTMyfLDoWDnfdUa2KrtR
 pYdvXfGMs/WKRjIC3S19q3xK7SKYGP5wBq6Qqrrjv1Kx5Pems772n5bK3nBe+k1y79Vs0Ss9jiI
 8AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Support the generic ns lookup infrastructure to support file handles for
namespaces.

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


