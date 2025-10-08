Return-Path: <linux-fsdevel+bounces-63596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9922BC5044
	for <lists+linux-fsdevel@lfdr.de>; Wed, 08 Oct 2025 14:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F3C719E2DD3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Oct 2025 12:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFD1261B86;
	Wed,  8 Oct 2025 12:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="DnnZ3dTE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2AD255F24;
	Wed,  8 Oct 2025 12:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759928087; cv=none; b=I/MJZ7c+R4fRxb8aLyKnszMEok3QXdjlc3O08nKO7c4Q0+hNhL41d+7KRJ1xuZcVzgdlXCb/Muj9EP8GV8Hfx93SGlkUzt5vtGyWcqgIRbBb6gq0AP6Gh1LDQj/eUbJdHTiZZdleniKx9BbdQRzOvVZjCzlQRG2HxDwkKxmLGLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759928087; c=relaxed/simple;
	bh=W6Su0zvUbKBAp5gS50zGnBYp1oJrGt5PJf150nAFsZA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O9khK1GTGKfwbnx92ifCNjgFNCjoVu2Iu27wY8dulBSIyfLJtxvXBe/ruI4Tf7YxdnHh0U4EDpjP1ETU/j0tJU56e7Kx9VUbAqF/MXEefdtdbP6tJK8d463TsPl8tsk4qMF4c2Nrest6GMgjdFS0J8XdtC2Lep9bmkmA/8jM8EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=DnnZ3dTE; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1759928085; x=1791464085;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZRDeMLmMEK6yn6l4ewtwCCdRu9Khsl3Xp6VISO2xrwE=;
  b=DnnZ3dTEGpdhw0VpHnsQ6pznJoFd4kb+WzApsNXLaVYSBiwlamsffoif
   +3v1OS3jUuh9toJMAOFqwZjOjysqr58m8YRXOw2b01DsvzVn9Bvrr3z5o
   ELeS9mP1wIYqIrO/vlNlfL5k01hgVjxA8/hq8Qe8NgR6hWw4TKbwWrE1k
   YR43BoyuZDddc+9zcNhXLPQZeJ5zzBeLuLaftgeCCIZ5rvcLHi2E0V/AY
   DVWUfsPzrN1KFGQj+vn7Xk91GlV+bjPjNrkbHwFOzesFEgXTzX5k0KvtX
   mqGShV4UUZtSNnlK0lv006yzZQ/++GptZEGYGQEZakViiH6Oh5v/BPRfs
   Q==;
X-CSE-ConnectionGUID: mLsNYFOJRhSzPy7GhW1xEw==
X-CSE-MsgGUID: Jm0hr+PXQjSTK4ngOiWpag==
X-IronPort-AV: E=Sophos;i="6.18,281,1751241600"; 
   d="scan'208";a="4518957"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 12:54:43 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:27609]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.71:2525] with esmtp (Farcaster)
 id 1b53c0ac-769c-46a7-ba29-79ccaadef900; Wed, 8 Oct 2025 12:54:43 +0000 (UTC)
X-Farcaster-Flow-ID: 1b53c0ac-769c-46a7-ba29-79ccaadef900
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 8 Oct 2025 12:54:42 +0000
Received: from dev-dsk-acsjakub-1b-6f9934e2.eu-west-1.amazon.com
 (172.19.75.107) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Wed, 8 Oct 2025
 12:54:40 +0000
From: Jakub Acs <acsjakub@amazon.de>
To: <aliceryhl@google.com>, <djwong@kernel.org>
CC: <jhubbard@nvidia.com>, <acsjakub@amazon.de>, <akpm@linux-foundation.org>,
	<axelrasmussen@google.com>, <chengming.zhou@linux.dev>, <david@redhat.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <peterx@redhat.com>, <rust-for-linux@vger.kernel.org>,
	<xu.xin16@zte.com.cn>
Subject: [PATCH] mm: use enum for vm_flags
Date: Wed, 8 Oct 2025 12:54:27 +0000
Message-ID: <20251008125427.68735-1-acsjakub@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251007162136.1885546-1-aliceryhl@google.com>
References: <20251007162136.1885546-1-aliceryhl@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D041UWB003.ant.amazon.com (10.13.139.176) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

redefine VM_* flag constants with BIT()

Make VM_* flag constant definitions consistent - unify all to use BIT()
macro and define them within an enum.

The bindgen tool is better able to handle BIT(_) declarations when used
in an enum.

Also add enum definitions for tracepoints.

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

Hi Alice,

thanks for the patch, I squashed it in (should I add your signed-off-by
too?) and added the TRACE_DEFINE_ENUM calls pointed out by Derrick.

I have the following points to still address, though: 

- can the fact that we're not controlling the type of the values if
  using enum be a problem? (likely the indirect control we have through
  the highest value is good enough, but I'm not sure)

- where do TRACE_DEFINE_ENUM calls belong?
  I see them placed e.g. in include/trace/misc/nfs.h for nfs or
  arch/x86/kvm/mmu/mmutrace.h, but I don't see a corresponding file for
  mm.h - does this warrant creating a separate file for these
  definitions?

- with the need for TRACE_DEFINE_ENUM calls, do we still deem this
  to be a good trade-off? - isn't fixing all of these in
  rust/bindings/bindings_helper.h better?

@Derrick, can you point me to how to test for the issue you pointed out?

Thanks,
Jakub


 include/linux/mm.h              | 142 ++++++++++++++++++++++----------
 rust/bindings/bindings_helper.h |   1 -
 2 files changed, 98 insertions(+), 45 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 70a2a76007d4..8b9e7a9e7042 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -36,6 +36,7 @@
 #include <linux/rcuwait.h>
 #include <linux/bitmap.h>
 #include <linux/bitops.h>
+#include <linux/tracepoint.h>
 
 struct mempolicy;
 struct anon_vma;
@@ -273,57 +274,58 @@ extern unsigned int kobjsize(const void *objp);
  * vm_flags in vm_area_struct, see mm_types.h.
  * When changing, update also include/trace/events/mmflags.h
  */
-#define VM_NONE		0x00000000
+enum {
+	VM_NONE		= 0,
 
-#define VM_READ		0x00000001	/* currently active flags */
-#define VM_WRITE	0x00000002
-#define VM_EXEC		0x00000004
-#define VM_SHARED	0x00000008
+	VM_READ		= BIT(0),		/* currently active flags */
+	VM_WRITE	= BIT(1),
+	VM_EXEC		= BIT(2),
+	VM_SHARED	= BIT(3),
 
 /* mprotect() hardcodes VM_MAYREAD >> 4 == VM_READ, and so for r/w/x bits. */
-#define VM_MAYREAD	0x00000010	/* limits for mprotect() etc */
-#define VM_MAYWRITE	0x00000020
-#define VM_MAYEXEC	0x00000040
-#define VM_MAYSHARE	0x00000080
+	VM_MAYREAD	= BIT(4),		/* limits for mprotect() etc */
+	VM_MAYWRITE	= BIT(5),
+	VM_MAYEXEC	= BIT(6),
+	VM_MAYSHARE	= BIT(7),
 
-#define VM_GROWSDOWN	0x00000100	/* general info on the segment */
+	VM_GROWSDOWN	= BIT(8),		/* general info on the segment */
 #ifdef CONFIG_MMU
-#define VM_UFFD_MISSING	0x00000200	/* missing pages tracking */
+	VM_UFFD_MISSING	= BIT(9),		/* missing pages tracking */
 #else /* CONFIG_MMU */
-#define VM_MAYOVERLAY	0x00000200	/* nommu: R/O MAP_PRIVATE mapping that might overlay a file mapping */
+	VM_MAYOVERLAY	= BIT(9),		/* nommu: R/O MAP_PRIVATE mapping that might overlay a file mapping */
 #define VM_UFFD_MISSING	0
 #endif /* CONFIG_MMU */
-#define VM_PFNMAP	0x00000400	/* Page-ranges managed without "struct page", just pure PFN */
-#define VM_UFFD_WP	0x00001000	/* wrprotect pages tracking */
-
-#define VM_LOCKED	0x00002000
-#define VM_IO           0x00004000	/* Memory mapped I/O or similar */
-
-					/* Used by sys_madvise() */
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
+	VM_PFNMAP	= BIT(10),		/* Page-ranges managed without "struct page", just pure PFN */
+	VM_UFFD_WP	= BIT(12),		/* wrprotect pages tracking */
+
+	VM_LOCKED	= BIT(13),
+	VM_IO           = BIT(14),		/* Memory mapped I/O or similar */
+
+						/* Used by sys_madvise() */
+	VM_SEQ_READ	= BIT(15),		/* App will access data sequentially */
+	VM_RAND_READ	= BIT(16),		/* App will not benefit from clustered reads */
+
+	VM_DONTCOPY	= BIT(17),		/* Do not copy this vma on fork */
+	VM_DONTEXPAND	= BIT(18),		/* Cannot expand with mremap() */
+	VM_LOCKONFAULT	= BIT(19),		/* Lock the pages covered when they are faulted in */
+	VM_ACCOUNT	= BIT(20),		/* Is a VM accounted object */
+	VM_NORESERVE	= BIT(21),		/* should the VM suppress accounting */
+	VM_HUGETLB	= BIT(22),		/* Huge TLB Page VM */
+	VM_SYNC		= BIT(23),		/* Synchronous page faults */
+	VM_ARCH_1	= BIT(24),		/* Architecture-specific flag */
+	VM_WIPEONFORK	= BIT(25),		/* Wipe VMA contents in child. */
+	VM_DONTDUMP	= BIT(26),		/* Do not include in the core dump */
 
 #ifdef CONFIG_MEM_SOFT_DIRTY
-# define VM_SOFTDIRTY	0x08000000	/* Not soft dirty clean area */
+	VM_SOFTDIRTY	= BIT(27),		/* Not soft dirty clean area */
 #else
 # define VM_SOFTDIRTY	0
 #endif
 
-#define VM_MIXEDMAP	0x10000000	/* Can contain "struct page" and pure PFN pages */
-#define VM_HUGEPAGE	0x20000000	/* MADV_HUGEPAGE marked this vma */
-#define VM_NOHUGEPAGE	0x40000000	/* MADV_NOHUGEPAGE marked this vma */
-#define VM_MERGEABLE	BIT(31)		/* KSM may merge identical pages */
+	VM_MIXEDMAP	= BIT(28),		/* Can contain "struct page" and pure PFN pages */
+	VM_HUGEPAGE	= BIT(29),		/* MADV_HUGEPAGE marked this vma */
+	VM_NOHUGEPAGE	= BIT(30),		/* MADV_NOHUGEPAGE marked this vma */
+	VM_MERGEABLE	= BIT(31),		/* KSM may merge identical pages */
 
 #ifdef CONFIG_ARCH_USES_HIGH_VMA_FLAGS
 #define VM_HIGH_ARCH_BIT_0	32	/* bit only usable on 64-bit architectures */
@@ -333,14 +335,66 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_HIGH_ARCH_BIT_4	36	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_BIT_5	37	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_BIT_6	38	/* bit only usable on 64-bit architectures */
-#define VM_HIGH_ARCH_0	BIT(VM_HIGH_ARCH_BIT_0)
-#define VM_HIGH_ARCH_1	BIT(VM_HIGH_ARCH_BIT_1)
-#define VM_HIGH_ARCH_2	BIT(VM_HIGH_ARCH_BIT_2)
-#define VM_HIGH_ARCH_3	BIT(VM_HIGH_ARCH_BIT_3)
-#define VM_HIGH_ARCH_4	BIT(VM_HIGH_ARCH_BIT_4)
-#define VM_HIGH_ARCH_5	BIT(VM_HIGH_ARCH_BIT_5)
-#define VM_HIGH_ARCH_6	BIT(VM_HIGH_ARCH_BIT_6)
+	VM_HIGH_ARCH_0	= BIT(VM_HIGH_ARCH_BIT_0),
+	VM_HIGH_ARCH_1	= BIT(VM_HIGH_ARCH_BIT_1),
+	VM_HIGH_ARCH_2	= BIT(VM_HIGH_ARCH_BIT_2),
+	VM_HIGH_ARCH_3	= BIT(VM_HIGH_ARCH_BIT_3),
+	VM_HIGH_ARCH_4	= BIT(VM_HIGH_ARCH_BIT_4),
+	VM_HIGH_ARCH_5	= BIT(VM_HIGH_ARCH_BIT_5),
+	VM_HIGH_ARCH_6	= BIT(VM_HIGH_ARCH_BIT_6),
 #endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
+};
+
+TRACE_DEFINE_ENUM(VM_NONE);
+TRACE_DEFINE_ENUM(VM_READ);
+TRACE_DEFINE_ENUM(VM_WRITE);
+TRACE_DEFINE_ENUM(VM_EXEC);
+TRACE_DEFINE_ENUM(VM_SHARED);
+TRACE_DEFINE_ENUM(VM_MAYREAD);
+TRACE_DEFINE_ENUM(VM_MAYWRITE);
+TRACE_DEFINE_ENUM(VM_MAYEXEC);
+TRACE_DEFINE_ENUM(VM_MAYSHARE);
+TRACE_DEFINE_ENUM(VM_GROWSDOWN);
+TRACE_DEFINE_ENUM(VM_UFFD_MISSING);
+
+#ifndef CONFIG_MMU
+TRACE_DEFINE_ENUM(VM_MAYOVERLAY);
+#endif /* CONFIG_MMU */
+
+TRACE_DEFINE_ENUM(VM_PFNMAP);
+TRACE_DEFINE_ENUM(VM_UFFD_WP);
+TRACE_DEFINE_ENUM(VM_LOCKED);
+TRACE_DEFINE_ENUM(VM_IO);
+TRACE_DEFINE_ENUM(VM_SEQ_READ);
+TRACE_DEFINE_ENUM(VM_RAND_READ);
+TRACE_DEFINE_ENUM(VM_DONTCOPY);
+TRACE_DEFINE_ENUM(VM_DONTEXPAND);
+TRACE_DEFINE_ENUM(VM_LOCKONFAULT);
+TRACE_DEFINE_ENUM(VM_ACCOUNT);
+TRACE_DEFINE_ENUM(VM_NORESERVE);
+TRACE_DEFINE_ENUM(VM_HUGETLB);
+TRACE_DEFINE_ENUM(VM_SYNC);
+TRACE_DEFINE_ENUM(VM_ARCH_1);
+TRACE_DEFINE_ENUM(VM_WIPEONFORK);
+TRACE_DEFINE_ENUM(VM_DONTDUMP);
+
+TRACE_DEFINE_ENUM(VM_SOFTDIRTY);
+
+TRACE_DEFINE_ENUM(VM_MIXEDMAP);
+TRACE_DEFINE_ENUM(VM_HUGEPAGE);
+TRACE_DEFINE_ENUM(VM_NOHUGEPAGE);
+TRACE_DEFINE_ENUM(VM_MERGEABLE);
+
+#ifdef CONFIG_ARCH_USES_HIGH_VMA_FLAGS
+TRACE_DEFINE_ENUM(VM_HIGH_ARCH_0);
+TRACE_DEFINE_ENUM(VM_HIGH_ARCH_1);
+TRACE_DEFINE_ENUM(VM_HIGH_ARCH_2);
+TRACE_DEFINE_ENUM(VM_HIGH_ARCH_3);
+TRACE_DEFINE_ENUM(VM_HIGH_ARCH_4);
+TRACE_DEFINE_ENUM(VM_HIGH_ARCH_5);
+TRACE_DEFINE_ENUM(VM_HIGH_ARCH_6);
+#endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
+
 
 #ifdef CONFIG_ARCH_HAS_PKEYS
 # define VM_PKEY_SHIFT VM_HIGH_ARCH_BIT_0
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 2e43c66635a2..04b75d4d01c3 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -108,7 +108,6 @@ const xa_mark_t RUST_CONST_HELPER_XA_PRESENT = XA_PRESENT;
 
 const gfp_t RUST_CONST_HELPER_XA_FLAGS_ALLOC = XA_FLAGS_ALLOC;
 const gfp_t RUST_CONST_HELPER_XA_FLAGS_ALLOC1 = XA_FLAGS_ALLOC1;
-const vm_flags_t RUST_CONST_HELPER_VM_MERGEABLE = VM_MERGEABLE;
 
 #if IS_ENABLED(CONFIG_ANDROID_BINDER_IPC_RUST)
 #include "../../drivers/android/binder/rust_binder.h"
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


