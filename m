Return-Path: <linux-fsdevel+bounces-62094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E3FB83FA4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 12:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF4575837B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 10:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415BA2F6562;
	Thu, 18 Sep 2025 10:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjuIoL/s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AFD2882CE;
	Thu, 18 Sep 2025 10:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758190321; cv=none; b=H+4FUbW/Wc0Y42MUxpiZq65YOiF5EsRVu62zmfwonSWzihsRfwH6hZiS95oiDk6ejgxkZWfPq/WZ9MgGY6aFGggDe8uphINGwF9qFNnieqnMNAjaECZ3ZQEp+7KHr/QWW81lpQcq2vpnU6sV8LRUxf8juZIHUsyY5zJ/3eCs3/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758190321; c=relaxed/simple;
	bh=HMXSeRrUilMAIcCkJMxqy3gRY2wo6gW53nQ3RSUckPU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BxEl3uMLCLQXaK2pU0shdzk4yASl1wx7gR7g9VsZcmsr3ANLnVfkTnHYSLW55pTlVOcdSJs0FFvTe5mUyIe8u9p8rj0bzUYFuhM1IuoMwBSUFftr9OpkresfPmCfjWY66kc2pWiTdFdgsltjtml+qSf1t6FCSuMDdw5/xZ0y5kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjuIoL/s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E00C4CEE7;
	Thu, 18 Sep 2025 10:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758190320;
	bh=HMXSeRrUilMAIcCkJMxqy3gRY2wo6gW53nQ3RSUckPU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EjuIoL/sexyH8UUVxjCXWQCZqfxndOp615s0QK8YViIALPPJqALLCJ/FE6IoBkStR
	 brb1o0NlqlrC85gJpAYLnAQ6jbtgsHIv2j3D2wqhf4agvrax7G23+sz9i54dX1UGUt
	 jLowCLsI+1GPGSWQImJ2ZRfpHCmnQA/9+mSl2wjMQl43ZSkwaApbxLpH4TZbdZPlzB
	 Muz46Od5EdRPm0wqeib+g8RxDsxZYXdvtG7qUeRWRNr4OQNaUdD45NMo+FoL5UIpi8
	 g2zyzgHhYZiZi0OuoafyHbkDXCHAxQMc5+ulaT30vMHVWLaYu0vb6kNmBxcCbw+sp5
	 FNHZt4ODAcQBw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 18 Sep 2025 12:11:46 +0200
Subject: [PATCH 01/14] ns: add reference count helpers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-work-namespace-ns_ref-v1-1-1b0a98ee041e@kernel.org>
References: <20250918-work-namespace-ns_ref-v1-0-1b0a98ee041e@kernel.org>
In-Reply-To: <20250918-work-namespace-ns_ref-v1-0-1b0a98ee041e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2929; i=brauner@kernel.org;
 h=from:subject:message-id; bh=HMXSeRrUilMAIcCkJMxqy3gRY2wo6gW53nQ3RSUckPU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWScvvXUi9Hxp52uhwzXRas5MzyMG5W8Zz929VqYpbLk1
 i4RC5ngjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIm8us3wP19nfuu6barnt+xS
 cfkVGlT1/MsEVWPbGadcL547dZvxezzD/5oe+SWfnX5PUk3RCBRoDNV/wv6DSeokr9oSmxOCezf
 +5gMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/ns_common.h | 45 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index 5094c0147b54..a65da646aef7 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -43,16 +43,24 @@ struct ns_common {
 int __ns_common_init(struct ns_common *ns, const struct proc_ns_operations *ops, int inum);
 void __ns_common_free(struct ns_common *ns);
 
-#define to_ns_common(__ns)                              \
-	_Generic((__ns),                                \
-		struct cgroup_namespace *: &(__ns)->ns, \
-		struct ipc_namespace *:    &(__ns)->ns, \
-		struct mnt_namespace *:    &(__ns)->ns, \
-		struct net *:              &(__ns)->ns, \
-		struct pid_namespace *:    &(__ns)->ns, \
-		struct time_namespace *:   &(__ns)->ns, \
-		struct user_namespace *:   &(__ns)->ns, \
-		struct uts_namespace *:    &(__ns)->ns)
+#define to_ns_common(__ns)                                    \
+	_Generic((__ns),                                      \
+		struct cgroup_namespace *:       &(__ns)->ns, \
+		const struct cgroup_namespace *: &(__ns)->ns, \
+		struct ipc_namespace *:          &(__ns)->ns, \
+		const struct ipc_namespace *:    &(__ns)->ns, \
+		struct mnt_namespace *:          &(__ns)->ns, \
+		const struct mnt_namespace *:    &(__ns)->ns, \
+		struct net *:                    &(__ns)->ns, \
+		const struct net *:              &(__ns)->ns, \
+		struct pid_namespace *:          &(__ns)->ns, \
+		const struct pid_namespace *:    &(__ns)->ns, \
+		struct time_namespace *:         &(__ns)->ns, \
+		const struct time_namespace *:   &(__ns)->ns, \
+		struct user_namespace *:         &(__ns)->ns, \
+		const struct user_namespace *:   &(__ns)->ns, \
+		struct uts_namespace *:          &(__ns)->ns, \
+		const struct uts_namespace *:    &(__ns)->ns)
 
 #define ns_init_inum(__ns)                                     \
 	_Generic((__ns),                                       \
@@ -85,4 +93,21 @@ void __ns_common_free(struct ns_common *ns);
 
 #define ns_common_free(__ns) __ns_common_free(to_ns_common((__ns)))
 
+static __always_inline __must_check bool __ns_ref_put(struct ns_common *ns)
+{
+	return refcount_dec_and_test(&ns->count);
+}
+
+static __always_inline __must_check bool __ns_ref_get(struct ns_common *ns)
+{
+	return refcount_inc_not_zero(&ns->count);
+}
+
+#define ns_ref_read(__ns) refcount_read(&to_ns_common((__ns))->count)
+#define ns_ref_inc(__ns) refcount_inc(&to_ns_common((__ns))->count)
+#define ns_ref_get(__ns) __ns_ref_get(to_ns_common((__ns)))
+#define ns_ref_put(__ns) __ns_ref_put(to_ns_common((__ns)))
+#define ns_ref_put_and_lock(__ns, __lock) \
+	refcount_dec_and_lock(&to_ns_common((__ns))->count, (__lock))
+
 #endif

-- 
2.47.3


