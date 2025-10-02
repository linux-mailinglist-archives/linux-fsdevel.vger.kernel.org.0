Return-Path: <linux-fsdevel+bounces-63211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A8CBB2BE3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 09:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56F3D7AF7FC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 07:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6749D2D1905;
	Thu,  2 Oct 2025 07:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="M3MfH+rU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC0B1DD9AD;
	Thu,  2 Oct 2025 07:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759391534; cv=none; b=EAhn2FVO2+fM8ex5hH9Zq9XJJFUV9foMNpu5+bVYjVMsyfc6nyA8k+oZoAoLn4dODJ1XX1rS7tpQ9ckxayR7FEaeUPfkDdjhxk6N2vRQBt8H0ZTDVdn4vZR10481CVeQX6Ic2ygQ28INAfjmIPHRhqiRB1CBPQ5S7K9OzRQzqhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759391534; c=relaxed/simple;
	bh=Ah8TYPLJ8zfpSzOJ6OqScr2Gx8nC8ju05DqYixGcl34=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h2zL7c2PUj2o/SyOZO62l/LrYDsxsJsiP9kSDXBBDygiMwhFBpaBr2SbPMjYBtTd5E3AgR4032V3aOB7sgNxTEh3WxvM6XUAurrAaP0T4VIs+nUbnRV62CgBCRztG8olAFnqjrmogWwQZ4418NJ8tDnjj6ZPwaswQJxiUkS+LpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=M3MfH+rU; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1759391532; x=1790927532;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2SGvgtfExrVMKD6QFwY+i2a9wnruIxOwASxfKxqf6S8=;
  b=M3MfH+rUZHYNfPzV62LgAFbuBbCWOKi1BJqsz4gxpbEIKTV7HDbAXPiS
   8wXpnvh7Bcld/lLkzbfyQnLlSdXx9QSyEZbT7sXVRY+Ke2gjZdfgygyqg
   vPHI7eJxhGHyXTuE/nAfEeVSBKTgJaE46AHU3lkLeE1lfUObUWDmt57m7
   h5kVHpu9l203xk6z7Xptd/iBh6lIaOpTZ3DSdqBf7lYpRsaO0mlQzLLsN
   MHABVGgBvOiT52QS7rIGmni7zKhBrrU1MI6ESKZckaFkrVcW84nPaOz+a
   Pb/9QjXvYhDDL4s9VoKkk6/tttRL0iSH08ngf/Kis0SzvVeqHhmWem6ih
   A==;
X-CSE-ConnectionGUID: hzfbE5ZsTnCi/kS8l7dAKg==
X-CSE-MsgGUID: fDs/5FZ+T2Smfxg1JTMupw==
X-IronPort-AV: E=Sophos;i="6.18,281,1751241600"; 
   d="scan'208";a="4137127"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 07:52:10 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:24445]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.71:2525] with esmtp (Farcaster)
 id 4a555600-ee08-4b41-952a-f943cb84732e; Thu, 2 Oct 2025 07:52:10 +0000 (UTC)
X-Farcaster-Flow-ID: 4a555600-ee08-4b41-952a-f943cb84732e
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Thu, 2 Oct 2025 07:52:10 +0000
Received: from dev-dsk-acsjakub-1b-6f9934e2.eu-west-1.amazon.com
 (172.19.75.107) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Thu, 2 Oct 2025
 07:52:08 +0000
From: Jakub Acs <acsjakub@amazon.de>
To: <linux-fsdevel@vger.kernel.org>
CC: <acsjakub@amazon.de>, Andrew Morton <akpm@linux-foundation.org>, "David
 Hildenbrand" <david@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou
	<chengming.zhou@linux.dev>, Peter Xu <peterx@redhat.com>, Axel Rasmussen
	<axelrasmussen@google.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4] mm: redefine VM_* flag constants with BIT()
Date: Thu, 2 Oct 2025 07:52:02 +0000
Message-ID: <20251002075202.11306-1-acsjakub@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D040UWA002.ant.amazon.com (10.13.139.113) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Make VM_* flag constant definitions consistent - unify all to use BIT()
macro.

We have previously changed VM_MERGEABLE in a separate bugfix. This is a
follow-up to make all the VM_* flag constant definitions consistent, as
suggested by David in [1].

[1]: https://lore.kernel.org/all/85f852f9-8577-4230-adc7-c52e7f479454@redhat.com/

Signed-off-by: Jakub Acs <acsjakub@amazon.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Xu Xin <xu.xin16@zte.com.cn>
Cc: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Peter Xu <peterx@redhat.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
v3 -> v4:
 - fix VM_MAYOVERLAY and VM_PFNMAP definitions
 - send outside the series

This depends on the following patch:
https://lore.kernel.org/all/20251001090353.57523-2-acsjakub@amazon.de/

v3: https://lore.kernel.org/all/20251001090353.57523-3-acsjakub@amazon.de/

 include/linux/mm.h | 66 +++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c6794d0e24eb..cb33f967d327 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -246,56 +246,56 @@ extern unsigned int kobjsize(const void *objp);
  * vm_flags in vm_area_struct, see mm_types.h.
  * When changing, update also include/trace/events/mmflags.h
  */
-#define VM_NONE		0x00000000
+#define VM_NONE		0
 
-#define VM_READ		0x00000001	/* currently active flags */
-#define VM_WRITE	0x00000002
-#define VM_EXEC		0x00000004
-#define VM_SHARED	0x00000008
+#define VM_READ		BIT(0)		/* currently active flags */
+#define VM_WRITE	BIT(1)
+#define VM_EXEC		BIT(2)
+#define VM_SHARED	BIT(3)
 
 /* mprotect() hardcodes VM_MAYREAD >> 4 == VM_READ, and so for r/w/x bits. */
-#define VM_MAYREAD	0x00000010	/* limits for mprotect() etc */
-#define VM_MAYWRITE	0x00000020
-#define VM_MAYEXEC	0x00000040
-#define VM_MAYSHARE	0x00000080
+#define VM_MAYREAD	BIT(4)		/* limits for mprotect() etc */
+#define VM_MAYWRITE	BIT(5)
+#define VM_MAYEXEC	BIT(6)
+#define VM_MAYSHARE	BIT(7)
 
-#define VM_GROWSDOWN	0x00000100	/* general info on the segment */
+#define VM_GROWSDOWN	BIT(8)		/* general info on the segment */
 #ifdef CONFIG_MMU
-#define VM_UFFD_MISSING	0x00000200	/* missing pages tracking */
+#define VM_UFFD_MISSING	BIT(9)		/* missing pages tracking */
 #else /* CONFIG_MMU */
-#define VM_MAYOVERLAY	0x00000200	/* nommu: R/O MAP_PRIVATE mapping that might overlay a file mapping */
+#define VM_MAYOVERLAY	BIT(9)		/* nommu: R/O MAP_PRIVATE mapping that might overlay a file mapping */
 #define VM_UFFD_MISSING	0
 #endif /* CONFIG_MMU */
-#define VM_PFNMAP	0x00000400	/* Page-ranges managed without "struct page", just pure PFN */
-#define VM_UFFD_WP	0x00001000	/* wrprotect pages tracking */
+#define VM_PFNMAP	BIT(10)		/* Page-ranges managed without "struct page", just pure PFN */
+#define VM_UFFD_WP	BIT(12)		/* wrprotect pages tracking */
 
-#define VM_LOCKED	0x00002000
-#define VM_IO           0x00004000	/* Memory mapped I/O or similar */
+#define VM_LOCKED	BIT(13)
+#define VM_IO           BIT(14)		/* Memory mapped I/O or similar */
 
 					/* Used by sys_madvise() */
-#define VM_SEQ_READ	0x00008000	/* App will access data sequentially */
-#define VM_RAND_READ	0x00010000	/* App will not benefit from clustered reads */
-
-#define VM_DONTCOPY	0x00020000      /* Do not copy this vma on fork */
-#define VM_DONTEXPAND	0x00040000	/* Cannot expand with mremap() */
-#define VM_LOCKONFAULT	0x00080000	/* Lock the pages covered when they are faulted in */
-#define VM_ACCOUNT	0x00100000	/* Is a VM accounted object */
-#define VM_NORESERVE	0x00200000	/* should the VM suppress accounting */
-#define VM_HUGETLB	0x00400000	/* Huge TLB Page VM */
-#define VM_SYNC		0x00800000	/* Synchronous page faults */
-#define VM_ARCH_1	0x01000000	/* Architecture-specific flag */
-#define VM_WIPEONFORK	0x02000000	/* Wipe VMA contents in child. */
-#define VM_DONTDUMP	0x04000000	/* Do not include in the core dump */
+#define VM_SEQ_READ	BIT(15)		/* App will access data sequentially */
+#define VM_RAND_READ	BIT(16)		/* App will not benefit from clustered reads */
+
+#define VM_DONTCOPY	BIT(17)		/* Do not copy this vma on fork */
+#define VM_DONTEXPAND	BIT(18)		/* Cannot expand with mremap() */
+#define VM_LOCKONFAULT	BIT(19)		/* Lock the pages covered when they are faulted in */
+#define VM_ACCOUNT	BIT(20)		/* Is a VM accounted object */
+#define VM_NORESERVE	BIT(21)		/* should the VM suppress accounting */
+#define VM_HUGETLB	BIT(22)		/* Huge TLB Page VM */
+#define VM_SYNC		BIT(23)		/* Synchronous page faults */
+#define VM_ARCH_1	BIT(24)		/* Architecture-specific flag */
+#define VM_WIPEONFORK	BIT(25)		/* Wipe VMA contents in child. */
+#define VM_DONTDUMP	BIT(26)		/* Do not include in the core dump */
 
 #ifdef CONFIG_MEM_SOFT_DIRTY
-# define VM_SOFTDIRTY	0x08000000	/* Not soft dirty clean area */
+# define VM_SOFTDIRTY	BIT(27)		/* Not soft dirty clean area */
 #else
 # define VM_SOFTDIRTY	0
 #endif
 
-#define VM_MIXEDMAP	0x10000000	/* Can contain "struct page" and pure PFN pages */
-#define VM_HUGEPAGE	0x20000000	/* MADV_HUGEPAGE marked this vma */
-#define VM_NOHUGEPAGE	0x40000000	/* MADV_NOHUGEPAGE marked this vma */
+#define VM_MIXEDMAP	BIT(28)		/* Can contain "struct page" and pure PFN pages */
+#define VM_HUGEPAGE	BIT(29)		/* MADV_HUGEPAGE marked this vma */
+#define VM_NOHUGEPAGE	BIT(30)		/* MADV_NOHUGEPAGE marked this vma */
 #define VM_MERGEABLE	BIT(31)		/* KSM may merge identical pages */
 
 #ifdef CONFIG_ARCH_USES_HIGH_VMA_FLAGS
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


