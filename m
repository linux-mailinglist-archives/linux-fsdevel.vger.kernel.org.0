Return-Path: <linux-fsdevel+bounces-67700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F88C476DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 16:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 61F4E4EE985
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 15:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF8931961F;
	Mon, 10 Nov 2025 15:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDTfVruW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37EC1A7AE3;
	Mon, 10 Nov 2025 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762787338; cv=none; b=UoUGhF5fVllshWDZ1rnm+ICtIPW+JiLscpJL6p7EREqRBnzzQ++sb9XkGOrLSToiCoVFxjixR8OsjyAjMMkOgIEzrOlK/Obx2rutXpdEIs8kcJ5WPQxgO+lnE5BXvTqjjDrWeU6bdOJWozNSQS3g4g3MF1UXP3Tdl6785Qs5DzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762787338; c=relaxed/simple;
	bh=4TnT7dNtM26aiDCa9gomKWL/ULkN2b8t1DCiIPKkOgI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rWnJAuB4GcfBW8HJdXbAU+rSffFOZso//GunXdTP4LmFVHa7DUZJj0rGw4ak3y/Cc13pLlbtTIGHeJdjSku6jz576FpODfoPdFcU6+Fo4ENxN3Si2HGccrCuuqu14R9Ys+3GzncEqAbRdCYi1mAuUKLYF5rNOEOKTqHouhsKJ2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDTfVruW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D318C4CEF5;
	Mon, 10 Nov 2025 15:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762787337;
	bh=4TnT7dNtM26aiDCa9gomKWL/ULkN2b8t1DCiIPKkOgI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fDTfVruW3SMdOzrInC6/Eyr+UhGbDoC9dGeQBOV2KnY3tE8iTByP2BbI8/FuKigHo
	 ky19Kso0zS5KpJyCmeFQgklh4XwuQ68P4XR+Kkl7TyYVNmUMQ22Sv6UEIOXQrmBjO9
	 9UplAiFEO6NI+YFYa1yU7OJms/dwHYcMDuvstQReJWkiqLesbFBQ2y2QLPtQRWWVOd
	 lUXrpfhhnLE1nWrzt2SkX+5HbAzMVdh0gJIEqDHkJmcTokNOo4t5RIFHSTSCbQvoE0
	 flTVSp3A9MG18EJVncKwjQdcoUrCY5nyP8Ir3HO91Z3XSCwKEktRf8nCylF7YgzhEQ
	 yxOy69K6Ifetg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 10 Nov 2025 16:08:15 +0100
Subject: [PATCH 03/17] nstree: move nstree types into separate header
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-work-namespace-nstree-fixes-v1-3-e8a9264e0fb9@kernel.org>
References: <20251110-work-namespace-nstree-fixes-v1-0-e8a9264e0fb9@kernel.org>
In-Reply-To: <20251110-work-namespace-nstree-fixes-v1-0-e8a9264e0fb9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2027; i=brauner@kernel.org;
 h=from:subject:message-id; bh=4TnT7dNtM26aiDCa9gomKWL/ULkN2b8t1DCiIPKkOgI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQK/v9s6Kuy6+qu3auNZA6Xhb9d71WawJzU/keaOb9nu
 uXaLT+ndZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkw1yG/8ky/PHepr981Qzs
 ypy36jybPZ/bbXa701fLo8vOlM39Mpnhf+Kpeo52zpny8UmNNp/ZvNZVbhX+rR9XvkE+mmXpDaN
 6DgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Introduce two new fundamental data structures for namespace tree
management in a separate header file.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/ns/nstree_types.h | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/nstree.h          |  1 +
 2 files changed, 37 insertions(+)

diff --git a/include/linux/ns/nstree_types.h b/include/linux/ns/nstree_types.h
new file mode 100644
index 000000000000..6ee0c39686f8
--- /dev/null
+++ b/include/linux/ns/nstree_types.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2025 Christian Brauner <brauner@kernel.org> */
+#ifndef _LINUX_NSTREE_TYPES_H
+#define _LINUX_NSTREE_TYPES_H
+
+#include <linux/rbtree.h>
+#include <linux/list.h>
+
+/**
+ * struct ns_tree_root - Root of a namespace tree
+ * @ns_rb: Red-black tree root for efficient lookups
+ * @ns_list_head: List head for sequential iteration
+ *
+ * Each namespace tree maintains both an rbtree (for O(log n) lookups)
+ * and a list (for efficient sequential iteration). The list is kept in
+ * the same sorted order as the rbtree.
+ */
+struct ns_tree_root {
+	struct rb_root ns_rb;
+	struct list_head ns_list_head;
+};
+
+/**
+ * struct ns_tree_node - Node in a namespace tree
+ * @ns_node: Red-black tree node
+ * @ns_list_entry: List entry for sequential iteration
+ *
+ * Represents a namespace's position in a tree. Each namespace has
+ * multiple tree nodes for different trees (unified, per-type, owner).
+ */
+struct ns_tree_node {
+	struct rb_node ns_node;
+	struct list_head ns_list_entry;
+};
+
+#endif /* _LINUX_NSTREE_TYPES_H */
diff --git a/include/linux/nstree.h b/include/linux/nstree.h
index 25040a98a92b..0e275df7e99a 100644
--- a/include/linux/nstree.h
+++ b/include/linux/nstree.h
@@ -3,6 +3,7 @@
 #ifndef _LINUX_NSTREE_H
 #define _LINUX_NSTREE_H
 
+#include <linux/ns/nstree_types.h>
 #include <linux/nsproxy.h>
 #include <linux/rbtree.h>
 #include <linux/seqlock.h>

-- 
2.47.3


