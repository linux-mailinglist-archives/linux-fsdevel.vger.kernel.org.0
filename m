Return-Path: <linux-fsdevel+bounces-6259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D2E8156C5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 04:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B219F1C24833
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 03:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81D314A91;
	Sat, 16 Dec 2023 03:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wEL1M8P7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84B9134C0
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Dec 2023 03:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702697229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lSEfcPVLSVdGjudbUJ8Sggq3p7WbAaRsO8gXu0Omim0=;
	b=wEL1M8P7dGXDYkqa7TZ0623+1nRbflZcjURNMTTrfHumsxxvoj66ZAcvpFCSzlBCmznGOS
	ShvM+xfySrI3hUK03bi1hMOQo88TQq4lz2lpKcqo9kn0Iqn4roIrmWzq8nWh/E7pzm5vVj
	gHdLwG+8+qW+yBjQLDhmmlyg1zl3eKY=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	tglx@linutronix.de,
	x86@kernel.org,
	tj@kernel.org,
	peterz@infradead.org,
	mathieu.desnoyers@efficios.com,
	paulmck@kernel.org,
	keescook@chromium.org,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	will@kernel.org,
	longman@redhat.com,
	boqun.feng@gmail.com,
	brauner@kernel.org
Subject: [PATCH 15/50] kernel/numa.c: Move logging out of numa.h
Date: Fri, 15 Dec 2023 22:26:14 -0500
Message-ID: <20231216032651.3553101-5-kent.overstreet@linux.dev>
In-Reply-To: <20231216032651.3553101-1-kent.overstreet@linux.dev>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216032651.3553101-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Moving these stub functions to a .c file means we can kill a sched.h
dependency on printk.h.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/numa.h | 18 +++++-------------
 kernel/Makefile      |  1 +
 kernel/numa.c        | 24 ++++++++++++++++++++++++
 3 files changed, 30 insertions(+), 13 deletions(-)
 create mode 100644 kernel/numa.c

diff --git a/include/linux/numa.h b/include/linux/numa.h
index a904861de800..aeab3d9f57ae 100644
--- a/include/linux/numa.h
+++ b/include/linux/numa.h
@@ -22,34 +22,26 @@
 #endif
 
 #ifdef CONFIG_NUMA
-#include <linux/printk.h>
 #include <asm/sparsemem.h>
 
 /* Generic implementation available */
 int numa_nearest_node(int node, unsigned int state);
 
 #ifndef memory_add_physaddr_to_nid
-static inline int memory_add_physaddr_to_nid(u64 start)
-{
-	pr_info_once("Unknown online node for memory at 0x%llx, assuming node 0\n",
-			start);
-	return 0;
-}
+int memory_add_physaddr_to_nid(u64 start);
 #endif
+
 #ifndef phys_to_target_node
-static inline int phys_to_target_node(u64 start)
-{
-	pr_info_once("Unknown target node for memory at 0x%llx, assuming node 0\n",
-			start);
-	return 0;
-}
+int phys_to_target_node(u64 start);
 #endif
+
 #ifndef numa_fill_memblks
 static inline int __init numa_fill_memblks(u64 start, u64 end)
 {
 	return NUMA_NO_MEMBLK;
 }
 #endif
+
 #else /* !CONFIG_NUMA */
 static inline int numa_nearest_node(int node, unsigned int state)
 {
diff --git a/kernel/Makefile b/kernel/Makefile
index 3947122d618b..ce105a5558fc 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -114,6 +114,7 @@ obj-$(CONFIG_SHADOW_CALL_STACK) += scs.o
 obj-$(CONFIG_HAVE_STATIC_CALL) += static_call.o
 obj-$(CONFIG_HAVE_STATIC_CALL_INLINE) += static_call_inline.o
 obj-$(CONFIG_CFI_CLANG) += cfi.o
+obj-$(CONFIG_NUMA) += numa.o
 
 obj-$(CONFIG_PERF_EVENTS) += events/
 
diff --git a/kernel/numa.c b/kernel/numa.c
new file mode 100644
index 000000000000..c24c72f45989
--- /dev/null
+++ b/kernel/numa.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/printk.h>
+#include <linux/numa.h>
+
+/* Stub functions: */
+
+#ifndef memory_add_physaddr_to_nid
+int memory_add_physaddr_to_nid(u64 start)
+{
+	pr_info_once("Unknown online node for memory at 0x%llx, assuming node 0\n",
+			start);
+	return 0;
+}
+#endif
+
+#ifndef phys_to_target_node
+int phys_to_target_node(u64 start)
+{
+	pr_info_once("Unknown target node for memory at 0x%llx, assuming node 0\n",
+			start);
+	return 0;
+}
+#endif
-- 
2.43.0


