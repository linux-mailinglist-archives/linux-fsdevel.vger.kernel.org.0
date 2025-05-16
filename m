Return-Path: <linux-fsdevel+bounces-49227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0601DAB99C9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 12:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88EDF1BA1291
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 10:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD20233D9C;
	Fri, 16 May 2025 10:11:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBA08F58;
	Fri, 16 May 2025 10:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747390283; cv=none; b=QQ9Mj6egeR4SEXlt+ANw3YAWXIN3AoplVl1Ho7WPVrbfCUB1o09Xy7WaK5ADs/BvqEmur6WurDtixoK/m8oP8GrTFprdExNQ45PZsGtcZ/kl6vXmYZquT6Im0QoKvGx2ApbJACjFcks/3c11Dj2csgL6ITMDiLIMQDJLbT2VWGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747390283; c=relaxed/simple;
	bh=8eKraBA6ag2WRjUmlRbTiPM4gQnifhxiQFHkkEMRhK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HhqIEqJQnD/Qz38YChE3NqbIzT3xX3JEnMcstKp33+JXkYAYBF5TXQNKibatz/yBOX8D7u6lLby+VbCoGJ1v73WUNbMvZt4TPV0lIpizps/vQPFSyDST0+lnL/vrjdI4k4/HjfA0qn5rKyXUKMU+ukJESxUPxeGD76uAQMDKsKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=pankajraghav.com; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4ZzNC70M28z9tBW;
	Fri, 16 May 2025 12:11:15 +0200 (CEST)
From: Pankaj Raghav <p.raghav@samsung.com>
To: "Darrick J . Wong" <djwong@kernel.org>,
	hch@lst.de,
	willy@infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	Andrew Morton <akpm@linux-foundation.org>,
	kernel@pankajraghav.com,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [RFC 1/3] mm: add large zero page for efficient zeroing of larger segments
Date: Fri, 16 May 2025 12:10:52 +0200
Message-ID: <20250516101054.676046-2-p.raghav@samsung.com>
In-Reply-To: <20250516101054.676046-1-p.raghav@samsung.com>
References: <20250516101054.676046-1-p.raghav@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce LARGE_ZERO_PAGE of size 2M as an alternative to ZERO_PAGE of
size PAGE_SIZE.

There are many places in the kernel where we need to zeroout larger
chunks but the maximum segment we can zeroout at a time is limited by
PAGE_SIZE.

This is especially annoying in block devices and filesystems where we
attach multiple ZERO_PAGEs to the bio in different bvecs. With multipage
bvec support in block layer, it is much more efficient to send out
larger zero pages as a part of single bvec.

While there are other options such as huge_zero_page, they can fail
based on the system memory pressure requiring a fallback to ZERO_PAGE[3].

This idea (but not the implementation) was suggested during the review of
adding LBS support to XFS[1][2].

LARGE_ZERO_PAGE is added behind a config option so that systems that are
constrained by memory are not forced to use it.

[1] https://lore.kernel.org/linux-xfs/20231027051847.GA7885@lst.de/
[2] https://lore.kernel.org/linux-xfs/ZitIK5OnR7ZNY0IG@infradead.org/
[3] https://lore.kernel.org/linux-xfs/3pqmgrlewo6ctcwakdvbvjqixac5en6irlipe5aiz6vkylfyni@2luhrs36ke5r/

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 arch/Kconfig                   |  8 ++++++++
 arch/x86/include/asm/pgtable.h | 20 +++++++++++++++++++-
 arch/x86/kernel/head_64.S      |  9 ++++++++-
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index b0adb665041f..aefa519cb211 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -218,6 +218,14 @@ config USER_RETURN_NOTIFIER
 	  Provide a kernel-internal notification when a cpu is about to
 	  switch to user mode.
 
+config LARGE_ZERO_PAGE
+	bool "Large zero pages"
+	def_bool n
+	help
+	  2M sized zero pages for zeroing. This will reserve 2M sized
+	  physical pages for zeroing. Not suitable for memory constrained
+	  systems.
+
 config HAVE_IOREMAP_PROT
 	bool
 
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 3f59d7a16010..78eb83f2da34 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -17,6 +17,7 @@
 
 #ifndef __ASSEMBLER__
 #include <linux/spinlock.h>
+#include <linux/sizes.h>
 #include <asm/x86_init.h>
 #include <asm/pkru.h>
 #include <asm/fpu/api.h>
@@ -47,14 +48,31 @@ void ptdump_walk_user_pgd_level_checkwx(void);
 #define debug_checkwx_user()	do { } while (0)
 #endif
 
+#ifdef CONFIG_LARGE_ZERO_PAGE
+/*
+ * LARGE_ZERO_PAGE is a global shared page that is always zero: used
+ * for zero-mapped memory areas etc..
+ */
+extern unsigned long empty_large_zero_page[(SZ_2M) / sizeof(unsigned long)]
+	__visible;
+#define ZERO_LARGE_PAGE(vaddr) ((void)(vaddr),virt_to_page(empty_large_zero_page))
+
+#define ZERO_PAGE(vaddr) ZERO_LARGE_PAGE(vaddr)
+#define ZERO_LARGE_PAGE_SIZE SZ_2M
+#else
 /*
  * ZERO_PAGE is a global shared page that is always zero: used
  * for zero-mapped memory areas etc..
  */
-extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)]
+extern unsigned long empty_zero_page[(PAGE_SIZE) / sizeof(unsigned long)]
 	__visible;
 #define ZERO_PAGE(vaddr) ((void)(vaddr),virt_to_page(empty_zero_page))
 
+#define ZERO_LARGE_PAGE(vaddr) ZERO_PAGE(vaddr)
+
+#define ZERO_LARGE_PAGE_SIZE PAGE_SIZE
+#endif
+
 extern spinlock_t pgd_lock;
 extern struct list_head pgd_list;
 
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index fefe2a25cf02..ebcd12f72966 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -14,6 +14,7 @@
 #include <linux/threads.h>
 #include <linux/init.h>
 #include <linux/pgtable.h>
+#include <linux/sizes.h>
 #include <asm/segment.h>
 #include <asm/page.h>
 #include <asm/msr.h>
@@ -708,8 +709,14 @@ EXPORT_SYMBOL(phys_base)
 #include "../xen/xen-head.S"
 
 	__PAGE_ALIGNED_BSS
+#ifdef CONFIG_LARGE_ZERO_PAGE
+SYM_DATA_START_PAGE_ALIGNED(empty_large_zero_page)
+	.skip SZ_2M
+SYM_DATA_END(empty_large_zero_page)
+EXPORT_SYMBOL(empty_large_zero_page)
+#else
 SYM_DATA_START_PAGE_ALIGNED(empty_zero_page)
 	.skip PAGE_SIZE
 SYM_DATA_END(empty_zero_page)
 EXPORT_SYMBOL(empty_zero_page)
-
+#endif
-- 
2.47.2


