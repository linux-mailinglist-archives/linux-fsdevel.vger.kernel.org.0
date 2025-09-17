Return-Path: <linux-fsdevel+bounces-61904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06859B7ED1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 15:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7E51327A5B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 10:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37FB36208E;
	Wed, 17 Sep 2025 10:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBFwtgpe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E41B32D5D3;
	Wed, 17 Sep 2025 10:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758104935; cv=none; b=pgigppbeVQxjfFPSjUzPwDs/jtx15JXxQiZo+e/zZNx7BDwjq1lmcl/vUmjX5/YokH25MKUAn0jow02gawCho+KZlXbp3qZf/25Ja19G7LJdOobVRfzt92jfl5LZNmubpC2BS11JRar8Zn8+I+edS6nTPicHJlSBowUx/R11jcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758104935; c=relaxed/simple;
	bh=SsZE3XmD+yCPUHrqRLeweA2GPr1r2EaHz2fY+2nM1AE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IGqRHR13NHTBkcohAQrnMQNowj0pCrJVBsdkp73TGuHt055Ev38F/JyiGEIY28D7qc9jcn5PQGmHDtPZvelMVE6intIbLS173LsWc17UhNgey/9QrFKdhDch0zcfKr6ZYvRrYIlnG0JMzJPwRbPKopTN0v+yvEVDL8d1gutMfD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBFwtgpe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83932C4CEF0;
	Wed, 17 Sep 2025 10:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758104934;
	bh=SsZE3XmD+yCPUHrqRLeweA2GPr1r2EaHz2fY+2nM1AE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kBFwtgpepfshYuZnD4klIHAOM96iSsxdZORRZKQTKsXx4Nzb89fQYAS4ZBqwkEK5O
	 HCyxCs0A0wjM3txjEs31x3Qtter6wsVwL9YEMFGV5+vL/ZArcC5ZThqGwt2WTxQ43k
	 Ej4nzRnoOPKKJuBHCIyix4Ll+O9X5amXFmfALWC8Jx4bF0PpMnTXmPe2Dj5OXhPoHR
	 7F+BpSCzc3NncLBMmNkf1Y98wAlUiN0IuR58tRB/5rF3TiI++Asalw0GD5FJ+rcOnG
	 REAAhGWQeDBvCZhu8oMYBbsFxuW5nlgsUILo60sVd7SRLiO1gtaNn3Xv90qrZmRfT9
	 ucoPn17rBN8og==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 17 Sep 2025 12:28:03 +0200
Subject: [PATCH 4/9] cgroup: split namespace into separate header
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-work-namespace-ns_common-v1-4-1b3bda8ef8f2@kernel.org>
References: <20250917-work-namespace-ns_common-v1-0-1b3bda8ef8f2@kernel.org>
In-Reply-To: <20250917-work-namespace-ns_common-v1-0-1b3bda8ef8f2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4120; i=brauner@kernel.org;
 h=from:subject:message-id; bh=SsZE3XmD+yCPUHrqRLeweA2GPr1r2EaHz2fY+2nM1AE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSc6vUzPxpiPOlleeT9LW8TFr6fXbtGYsXk46/5th96z
 3F6h//eWx2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQATWbqD4X/Ukr0NYb7/ZJRn
 tAsXfbHwunEt09D0Y9/x90uOyEb8vHWTkWHhQx3nF4d5LnYni11q69vgUGx709nZa9Yc6Z3XF6d
 J23AAAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

We have dedicated headers for all namespace types. Add one for the
cgroup namespace as well. Now it's consistent for all namespace types
and easy to figure out what to include.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/cgroup.h           | 51 +-----------------------------------
 include/linux/cgroup_namespace.h | 56 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 50 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 9ca25346f7cb..5156fed8cbc3 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -27,6 +27,7 @@
 #include <linux/kernel_stat.h>
 
 #include <linux/cgroup-defs.h>
+#include <linux/cgroup_namespace.h>
 
 struct kernel_clone_args;
 
@@ -783,56 +784,6 @@ static inline void cgroup_sk_free(struct sock_cgroup_data *skcd) {}
 
 #endif	/* CONFIG_CGROUP_DATA */
 
-struct cgroup_namespace {
-	struct ns_common	ns;
-	struct user_namespace	*user_ns;
-	struct ucounts		*ucounts;
-	struct css_set          *root_cset;
-};
-
-extern struct cgroup_namespace init_cgroup_ns;
-
-#ifdef CONFIG_CGROUPS
-
-static inline struct cgroup_namespace *to_cg_ns(struct ns_common *ns)
-{
-	return container_of(ns, struct cgroup_namespace, ns);
-}
-
-void free_cgroup_ns(struct cgroup_namespace *ns);
-
-struct cgroup_namespace *copy_cgroup_ns(unsigned long flags,
-					struct user_namespace *user_ns,
-					struct cgroup_namespace *old_ns);
-
-int cgroup_path_ns(struct cgroup *cgrp, char *buf, size_t buflen,
-		   struct cgroup_namespace *ns);
-
-static inline void get_cgroup_ns(struct cgroup_namespace *ns)
-{
-	refcount_inc(&ns->ns.count);
-}
-
-static inline void put_cgroup_ns(struct cgroup_namespace *ns)
-{
-	if (refcount_dec_and_test(&ns->ns.count))
-		free_cgroup_ns(ns);
-}
-
-#else /* !CONFIG_CGROUPS */
-
-static inline void free_cgroup_ns(struct cgroup_namespace *ns) { }
-static inline struct cgroup_namespace *
-copy_cgroup_ns(unsigned long flags, struct user_namespace *user_ns,
-	       struct cgroup_namespace *old_ns)
-{
-	return old_ns;
-}
-
-static inline void get_cgroup_ns(struct cgroup_namespace *ns) { }
-static inline void put_cgroup_ns(struct cgroup_namespace *ns) { }
-
-#endif /* !CONFIG_CGROUPS */
 
 #ifdef CONFIG_CGROUPS
 
diff --git a/include/linux/cgroup_namespace.h b/include/linux/cgroup_namespace.h
new file mode 100644
index 000000000000..c02bb76c5e32
--- /dev/null
+++ b/include/linux/cgroup_namespace.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_CGROUP_NAMESPACE_H
+#define _LINUX_CGROUP_NAMESPACE_H
+
+struct cgroup_namespace {
+	struct ns_common	ns;
+	struct user_namespace	*user_ns;
+	struct ucounts		*ucounts;
+	struct css_set          *root_cset;
+};
+
+extern struct cgroup_namespace init_cgroup_ns;
+
+#ifdef CONFIG_CGROUPS
+
+static inline struct cgroup_namespace *to_cg_ns(struct ns_common *ns)
+{
+	return container_of(ns, struct cgroup_namespace, ns);
+}
+
+void free_cgroup_ns(struct cgroup_namespace *ns);
+
+struct cgroup_namespace *copy_cgroup_ns(unsigned long flags,
+					struct user_namespace *user_ns,
+					struct cgroup_namespace *old_ns);
+
+int cgroup_path_ns(struct cgroup *cgrp, char *buf, size_t buflen,
+		   struct cgroup_namespace *ns);
+
+static inline void get_cgroup_ns(struct cgroup_namespace *ns)
+{
+	refcount_inc(&ns->ns.count);
+}
+
+static inline void put_cgroup_ns(struct cgroup_namespace *ns)
+{
+	if (refcount_dec_and_test(&ns->ns.count))
+		free_cgroup_ns(ns);
+}
+
+#else /* !CONFIG_CGROUPS */
+
+static inline void free_cgroup_ns(struct cgroup_namespace *ns) { }
+static inline struct cgroup_namespace *
+copy_cgroup_ns(unsigned long flags, struct user_namespace *user_ns,
+	       struct cgroup_namespace *old_ns)
+{
+	return old_ns;
+}
+
+static inline void get_cgroup_ns(struct cgroup_namespace *ns) { }
+static inline void put_cgroup_ns(struct cgroup_namespace *ns) { }
+
+#endif /* !CONFIG_CGROUPS */
+
+#endif /* _LINUX_CGROUP_NAMESPACE_H */

-- 
2.47.3


