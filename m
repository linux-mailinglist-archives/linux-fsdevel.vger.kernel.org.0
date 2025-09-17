Return-Path: <linux-fsdevel+bounces-61901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58236B7FB39
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 16:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D6E5326EC3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 10:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096B1350D4A;
	Wed, 17 Sep 2025 10:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCvOjRku"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53921303A1E;
	Wed, 17 Sep 2025 10:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758104920; cv=none; b=XzwvDim4SsCv5aLokyAJSVKi8JOiMAHNT7jdK12NEzbmdWJ2GzC2xno7PxNGsZIVnKB4QrsosURVQuwuCV7V/YLBTdpOpvq8i9AmR1NXnnLEWkzIT9q1NAVl+qWB+u66D35Ng4E9OZR3JIcUOrZXpMWIWoj6mkTZh/hSBrtV/+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758104920; c=relaxed/simple;
	bh=AvdOHxfXHrvdoBdIQ10mM48HLMw4+4GPk3SqftCCZM8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=urWqCGLg2z33z2FZympYVzYILNuil+r+M1hLNQdnFovhSLacpjoQQx+EgrE+3Sh0ZJogQ2i/iLpPc5aA5Z/3KWPFViNM/h1T9ThyzXxrKmB6ZG0LLRopXF2pL0vNWPSzoq2/UfHVJCRGmkpb2bl85oWU8daw5KR97YFXEunBW8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCvOjRku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C83C4CEF0;
	Wed, 17 Sep 2025 10:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758104920;
	bh=AvdOHxfXHrvdoBdIQ10mM48HLMw4+4GPk3SqftCCZM8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CCvOjRku2B74YaC9Bka/d9l72iV8shu4Hyh985EQuiHZLwIg6mlg2nIY41KwQQ6Bc
	 jkwytlzDNUjAxBLflKZwffEGwrW6uJ3vD6IA96Hf9jKnpoNtim213UAjt1Ejhbr1Pm
	 AygPg8zbDkOzKyvXQ2zE6Qaak/o/W9aUJXGWi8AkYpbzOro8D4orMx3SBFm+rbO4X7
	 OaEpwtIRcqtAhes+JjA8T7rSJTDrA4j47RvtePyA+/LdeqjmVNMCvsdG859T5dNZ8i
	 ECTnIqAXOjEcazVfzujiKC2sZwGsCnRbGaxv4ux8/kPFAFtQUcgSkKUh5K3FJLX+lf
	 uWsSZc113ZA8A==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 17 Sep 2025 12:28:00 +0200
Subject: [PATCH 1/9] uts: split namespace into separate header
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-work-namespace-ns_common-v1-1-1b3bda8ef8f2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4023; i=brauner@kernel.org;
 h=from:subject:message-id; bh=AvdOHxfXHrvdoBdIQ10mM48HLMw4+4GPk3SqftCCZM8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSc6vVtMrnXf4f9QPm3ewud93cf5324KylFcJVGaUvwy
 l18DvslOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbS9Z6R4QWL18ufq5W+NauJ
 SJxYd2B7+G0Rw8oL2nmPhTq2shcmszL8T83NvbeBwemVTGj2psWibJNeh1j/ypzmaiJ0dZHF7X9
 /uQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

We have dedicated headers for all namespace types. Add one for the uts
namespace as well. Now it's consistent for all namespace types.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/uts_namespace.h | 65 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/utsname.h       | 58 +-------------------------------------
 2 files changed, 66 insertions(+), 57 deletions(-)

diff --git a/include/linux/uts_namespace.h b/include/linux/uts_namespace.h
new file mode 100644
index 000000000000..c2b619bb4e57
--- /dev/null
+++ b/include/linux/uts_namespace.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_UTS_NAMESPACE_H
+#define _LINUX_UTS_NAMESPACE_H
+
+#include <linux/ns_common.h>
+#include <uapi/linux/utsname.h>
+
+struct user_namespace;
+extern struct user_namespace init_user_ns;
+
+struct uts_namespace {
+	struct new_utsname name;
+	struct user_namespace *user_ns;
+	struct ucounts *ucounts;
+	struct ns_common ns;
+} __randomize_layout;
+
+extern struct uts_namespace init_uts_ns;
+
+#ifdef CONFIG_UTS_NS
+static inline struct uts_namespace *to_uts_ns(struct ns_common *ns)
+{
+	return container_of(ns, struct uts_namespace, ns);
+}
+
+static inline void get_uts_ns(struct uts_namespace *ns)
+{
+	refcount_inc(&ns->ns.count);
+}
+
+extern struct uts_namespace *copy_utsname(unsigned long flags,
+	struct user_namespace *user_ns, struct uts_namespace *old_ns);
+extern void free_uts_ns(struct uts_namespace *ns);
+
+static inline void put_uts_ns(struct uts_namespace *ns)
+{
+	if (refcount_dec_and_test(&ns->ns.count))
+		free_uts_ns(ns);
+}
+
+void uts_ns_init(void);
+#else
+static inline void get_uts_ns(struct uts_namespace *ns)
+{
+}
+
+static inline void put_uts_ns(struct uts_namespace *ns)
+{
+}
+
+static inline struct uts_namespace *copy_utsname(unsigned long flags,
+	struct user_namespace *user_ns, struct uts_namespace *old_ns)
+{
+	if (flags & CLONE_NEWUTS)
+		return ERR_PTR(-EINVAL);
+
+	return old_ns;
+}
+
+static inline void uts_ns_init(void)
+{
+}
+#endif
+
+#endif /* _LINUX_UTS_NAMESPACE_H */
diff --git a/include/linux/utsname.h b/include/linux/utsname.h
index 5d34c4f0f945..547bd4439706 100644
--- a/include/linux/utsname.h
+++ b/include/linux/utsname.h
@@ -7,7 +7,7 @@
 #include <linux/nsproxy.h>
 #include <linux/ns_common.h>
 #include <linux/err.h>
-#include <uapi/linux/utsname.h>
+#include <linux/uts_namespace.h>
 
 enum uts_proc {
 	UTS_PROC_ARCH,
@@ -18,62 +18,6 @@ enum uts_proc {
 	UTS_PROC_DOMAINNAME,
 };
 
-struct user_namespace;
-extern struct user_namespace init_user_ns;
-
-struct uts_namespace {
-	struct new_utsname name;
-	struct user_namespace *user_ns;
-	struct ucounts *ucounts;
-	struct ns_common ns;
-} __randomize_layout;
-extern struct uts_namespace init_uts_ns;
-
-#ifdef CONFIG_UTS_NS
-static inline struct uts_namespace *to_uts_ns(struct ns_common *ns)
-{
-	return container_of(ns, struct uts_namespace, ns);
-}
-
-static inline void get_uts_ns(struct uts_namespace *ns)
-{
-	refcount_inc(&ns->ns.count);
-}
-
-extern struct uts_namespace *copy_utsname(unsigned long flags,
-	struct user_namespace *user_ns, struct uts_namespace *old_ns);
-extern void free_uts_ns(struct uts_namespace *ns);
-
-static inline void put_uts_ns(struct uts_namespace *ns)
-{
-	if (refcount_dec_and_test(&ns->ns.count))
-		free_uts_ns(ns);
-}
-
-void uts_ns_init(void);
-#else
-static inline void get_uts_ns(struct uts_namespace *ns)
-{
-}
-
-static inline void put_uts_ns(struct uts_namespace *ns)
-{
-}
-
-static inline struct uts_namespace *copy_utsname(unsigned long flags,
-	struct user_namespace *user_ns, struct uts_namespace *old_ns)
-{
-	if (flags & CLONE_NEWUTS)
-		return ERR_PTR(-EINVAL);
-
-	return old_ns;
-}
-
-static inline void uts_ns_init(void)
-{
-}
-#endif
-
 #ifdef CONFIG_PROC_SYSCTL
 extern void uts_proc_notify(enum uts_proc proc);
 #else

-- 
2.47.3


