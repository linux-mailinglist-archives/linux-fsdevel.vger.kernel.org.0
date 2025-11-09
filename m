Return-Path: <linux-fsdevel+bounces-67614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EE114C44774
	for <lists+linux-fsdevel@lfdr.de>; Sun, 09 Nov 2025 22:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F2304E8E30
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Nov 2025 21:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E42279DCC;
	Sun,  9 Nov 2025 21:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOopcn5n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE242737E4;
	Sun,  9 Nov 2025 21:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762722829; cv=none; b=vC+kq3BeBI4lvTfoZI7uzpTOcn0rCdpXuPgNklzdjs/Us/7SQvQWTS4veYJzLwtTSV6H/UcAMos+Ae+fZHl4Fz96EHb4v3zlVUh3xQ3oKIapN/0GIyTpRJKELBiVuaenDHnNu9Yu925UuPF4gWdvEVw24HYrj78825DSweZD7hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762722829; c=relaxed/simple;
	bh=8y4aMICEEV0LiihR+FyZdw88fBca7WRMqCEtGLIdliw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n7UQNkFNrNCJbxZ8JpHroLjj05q4J3G//lybCHPYPCvZqGX6MmwAIAjlHUPQfKblJKtx36iDPYZj/K99oNeCLxnh1YM78IoZtOrRlVw5HukrC0Xmi5ZMnBZbJpaoxAAM2cj/1VL6TPlG/rCUXYMk0FkzOUetiQAwYx15KFsfcs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOopcn5n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CFCFC4CEF8;
	Sun,  9 Nov 2025 21:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762722828;
	bh=8y4aMICEEV0LiihR+FyZdw88fBca7WRMqCEtGLIdliw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mOopcn5nPKjp9ET/HK1MoGqbKamvY8j+oN3zAbpyOBrjIIQB8BJKgij2MDIouYqqF
	 1XAzGyLVi51vxjHXvsu+g38vArQ83PceTdh59Fv6tVU2ddt/PPXlCZ/04RUCfnzeRB
	 +zHvbqEKft6+NK7r1QdLdFXk54WyAAiV6C0Dygd2iO7kBQJNB61AIusvI27t22Aj6K
	 tV/CxOELIvpP+5bax176AfwrDdScfeZ5LXxl9EClPUgfkyCqnCFOK18REeLRbnkBqK
	 cU1wu1vuz6WUISiDTtW8tlLd0h7OP514y9kyw6T99AKNg77ksgLRgHGZP65XyckwTw
	 bXIbiJAMiV6sg==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 09 Nov 2025 22:11:27 +0100
Subject: [PATCH 6/8] ns: add asserts for active refcount underflow
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251109-namespace-6-19-fixes-v1-6-ae8a4ad5a3b3@kernel.org>
References: <20251109-namespace-6-19-fixes-v1-0-ae8a4ad5a3b3@kernel.org>
In-Reply-To: <20251109-namespace-6-19-fixes-v1-0-ae8a4ad5a3b3@kernel.org>
To: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>
Cc: Jann Horn <jannh@google.com>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Amir Goldstein <amir73il@gmail.com>, Tejun Heo <tj@kernel.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, bpf@vger.kernel.org, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2410; i=brauner@kernel.org;
 h=from:subject:message-id; bh=8y4aMICEEV0LiihR+FyZdw88fBca7WRMqCEtGLIdliw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQKMr94l1/5uyM4UfXv9Zy/QcYVfFzZC07+d68/ur7O7
 PWfd6m/O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACby8AUjw8H4pUZdv+6x1BhK
 qgSXsaVatl3+m54+0Wopv2/5vMCkW4wM6+daXThSYHuq7+cKpkaTPz4+plG9O/ftU7loJ7569uI
 ULgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a few more assert to detect active reference count underflows.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/ns_common.h |  1 -
 kernel/nscommon.c         | 18 ++++++++++++++----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index 3aaba2ca31d7..66ea09b48377 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -294,7 +294,6 @@ void __ns_ref_active_put(struct ns_common *ns);
 
 static __always_inline struct ns_common *__must_check ns_get_unless_inactive(struct ns_common *ns)
 {
-	VFS_WARN_ON_ONCE(__ns_ref_active_read(ns) && !__ns_ref_read(ns));
 	if (!__ns_ref_active_read(ns)) {
 		VFS_WARN_ON_ONCE(is_ns_init_id(ns));
 		return NULL;
diff --git a/kernel/nscommon.c b/kernel/nscommon.c
index bfd2d6805776..c910b979e433 100644
--- a/kernel/nscommon.c
+++ b/kernel/nscommon.c
@@ -170,8 +170,10 @@ void __ns_ref_active_put(struct ns_common *ns)
 	if (is_ns_init_id(ns))
 		return;
 
-	if (!atomic_dec_and_test(&ns->__ns_ref_active))
+	if (!atomic_dec_and_test(&ns->__ns_ref_active)) {
+		VFS_WARN_ON_ONCE(__ns_ref_active_read(ns) < 0);
 		return;
+	}
 
 	VFS_WARN_ON_ONCE(is_ns_init_id(ns));
 	VFS_WARN_ON_ONCE(!__ns_ref_read(ns));
@@ -181,8 +183,10 @@ void __ns_ref_active_put(struct ns_common *ns)
 		if (!ns)
 			return;
 		VFS_WARN_ON_ONCE(is_ns_init_id(ns));
-		if (!atomic_dec_and_test(&ns->__ns_ref_active))
+		if (!atomic_dec_and_test(&ns->__ns_ref_active)) {
+			VFS_WARN_ON_ONCE(__ns_ref_active_read(ns) < 0);
 			return;
+		}
 	}
 }
 
@@ -280,12 +284,16 @@ void __ns_ref_active_put(struct ns_common *ns)
  */
 void __ns_ref_active_get(struct ns_common *ns)
 {
+	int prev;
+
 	/* Initial namespaces are always active. */
 	if (is_ns_init_id(ns))
 		return;
 
 	/* If we didn't resurrect the namespace we're done. */
-	if (atomic_fetch_add(1, &ns->__ns_ref_active))
+	prev = atomic_fetch_add(1, &ns->__ns_ref_active);
+	VFS_WARN_ON_ONCE(prev < 0);
+	if (likely(prev))
 		return;
 
 	/*
@@ -298,7 +306,9 @@ void __ns_ref_active_get(struct ns_common *ns)
 			return;
 
 		VFS_WARN_ON_ONCE(is_ns_init_id(ns));
-		if (atomic_fetch_add(1, &ns->__ns_ref_active))
+		prev = atomic_fetch_add(1, &ns->__ns_ref_active);
+		VFS_WARN_ON_ONCE(prev < 0);
+		if (likely(prev))
 			return;
 	}
 }

-- 
2.47.3


