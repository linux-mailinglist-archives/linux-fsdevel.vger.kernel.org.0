Return-Path: <linux-fsdevel+bounces-8961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F8483C8AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 17:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0988029654D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 16:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB3413DBB7;
	Thu, 25 Jan 2024 16:44:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96ADF13DB91;
	Thu, 25 Jan 2024 16:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201074; cv=none; b=pGXJvWe5NciI+5F7I3X4PVx9Kl0QZ4j6WbP+ZQGhc6cn+cBMOoJVwLJrOUwTYpIArBeB0J5OWLnKCtspM7n/5gMQeK+0y25B+GcYuiFUpvy+fr8xONEFFa3LQyBjOxZXp4VhpyJhL96VDc8ZmpeYWh6UajtJSiirAdKHjqYHAOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201074; c=relaxed/simple;
	bh=HH75AX1fqfgofps2qV9OVvLXq8bCrN5uYZNi6BX7E/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ia/nqoHWP+x3tWOo7P8cDNIyKOU7pAercrBMQT4oECT03EeQoQ3AhBCC6E8sSZ/q3dlGUiWmpE4b2gLwjc0gUQEWPhBzxMDCoLFM8m507y/Ehx8+d0pYSRl96Bc9G1uM+W0LXFYutAbBRG+R4VQipKNMlm6kLVZlAQdg2w2WnRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97188165C;
	Thu, 25 Jan 2024 08:45:15 -0800 (PST)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A9C433F5A1;
	Thu, 25 Jan 2024 08:44:25 -0800 (PST)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	oliver.upton@linux.dev,
	maz@kernel.org,
	james.morse@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	arnd@arndb.de,
	akpm@linux-foundation.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	mhiramat@kernel.org,
	rppt@kernel.org,
	hughd@google.com
Cc: pcc@google.com,
	steven.price@arm.com,
	anshuman.khandual@arm.com,
	vincenzo.frascino@arm.com,
	david@redhat.com,
	eugenis@google.com,
	kcc@google.com,
	hyesoo.yu@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH RFC v3 18/35] arm64: mte: Rename __GFP_ZEROTAGS to __GFP_TAGGED
Date: Thu, 25 Jan 2024 16:42:39 +0000
Message-Id: <20240125164256.4147-19-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125164256.4147-1-alexandru.elisei@arm.com>
References: <20240125164256.4147-1-alexandru.elisei@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__GFP_ZEROTAGS is used to instruct the page allocator to zero the tags at
the same time as the physical frame is zeroed. The name can be slightly
misleading, because it doesn't mean that the code will zero the tags
unconditionally, but that the tags will be zeroed if and only if the
physical frame is also zeroed (either __GFP_ZERO is set or init_on_alloc is
1).

Rename it to __GFP_TAGGED, in preparation for it to be used by the page
allocator to recognize when an allocation is tagged (has metadata).

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/mm/fault.c          | 2 +-
 include/linux/gfp_types.h      | 6 +++---
 include/trace/events/mmflags.h | 2 +-
 mm/page_alloc.c                | 2 +-
 mm/shmem.c                     | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 4d3f0a870ad8..c022e473c17c 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -944,7 +944,7 @@ NOKPROBE_SYMBOL(do_debug_exception);
 gfp_t arch_calc_vma_gfp(struct vm_area_struct *vma, gfp_t gfp)
 {
 	if (vma->vm_flags & VM_MTE)
-		return __GFP_ZEROTAGS;
+		return __GFP_TAGGED;
 	return 0;
 }
 
diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 1b6053da8754..f638353ebdc7 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -45,7 +45,7 @@ typedef unsigned int __bitwise gfp_t;
 #define ___GFP_HARDWALL		0x100000u
 #define ___GFP_THISNODE		0x200000u
 #define ___GFP_ACCOUNT		0x400000u
-#define ___GFP_ZEROTAGS		0x800000u
+#define ___GFP_TAGGED		0x800000u
 #ifdef CONFIG_KASAN_HW_TAGS
 #define ___GFP_SKIP_ZERO	0x1000000u
 #define ___GFP_SKIP_KASAN	0x2000000u
@@ -226,7 +226,7 @@ typedef unsigned int __bitwise gfp_t;
  *
  * %__GFP_ZERO returns a zeroed page on success.
  *
- * %__GFP_ZEROTAGS zeroes memory tags at allocation time if the memory itself
+ * %__GFP_TAGGED zeroes memory tags at allocation time if the memory itself
  * is being zeroed (either via __GFP_ZERO or via init_on_alloc, provided that
  * __GFP_SKIP_ZERO is not set). This flag is intended for optimization: setting
  * memory tags at the same time as zeroing memory has minimal additional
@@ -241,7 +241,7 @@ typedef unsigned int __bitwise gfp_t;
 #define __GFP_NOWARN	((__force gfp_t)___GFP_NOWARN)
 #define __GFP_COMP	((__force gfp_t)___GFP_COMP)
 #define __GFP_ZERO	((__force gfp_t)___GFP_ZERO)
-#define __GFP_ZEROTAGS	((__force gfp_t)___GFP_ZEROTAGS)
+#define __GFP_TAGGED	((__force gfp_t)___GFP_TAGGED)
 #define __GFP_SKIP_ZERO ((__force gfp_t)___GFP_SKIP_ZERO)
 #define __GFP_SKIP_KASAN ((__force gfp_t)___GFP_SKIP_KASAN)
 
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index d801409b33cf..6ca0d5ed46c0 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -50,7 +50,7 @@
 	gfpflag_string(__GFP_RECLAIM),		\
 	gfpflag_string(__GFP_DIRECT_RECLAIM),	\
 	gfpflag_string(__GFP_KSWAPD_RECLAIM),	\
-	gfpflag_string(__GFP_ZEROTAGS)
+	gfpflag_string(__GFP_TAGGED)
 
 #ifdef CONFIG_KASAN_HW_TAGS
 #define __def_gfpflag_names_kasan ,			\
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 502ee3eb8583..0a0118612a13 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1480,7 +1480,7 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 {
 	bool init = !want_init_on_free() && want_init_on_alloc(gfp_flags) &&
 			!should_skip_init(gfp_flags);
-	bool zero_tags = init && (gfp_flags & __GFP_ZEROTAGS);
+	bool zero_tags = init && (gfp_flags & __GFP_TAGGED);
 	int i;
 
 	set_page_private(page, 0);
diff --git a/mm/shmem.c b/mm/shmem.c
index 621fabc3b8c6..3e28357b0a40 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1585,7 +1585,7 @@ static struct folio *shmem_swapin_cluster(swp_entry_t swap, gfp_t gfp,
  */
 static gfp_t limit_gfp_mask(gfp_t huge_gfp, gfp_t limit_gfp)
 {
-	gfp_t allowflags = __GFP_IO | __GFP_FS | __GFP_RECLAIM | __GFP_ZEROTAGS;
+	gfp_t allowflags = __GFP_IO | __GFP_FS | __GFP_RECLAIM | __GFP_TAGGED;
 	gfp_t denyflags = __GFP_NOWARN | __GFP_NORETRY;
 	gfp_t zoneflags = limit_gfp & GFP_ZONEMASK;
 	gfp_t result = huge_gfp & ~(allowflags | GFP_ZONEMASK);
-- 
2.43.0


