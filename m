Return-Path: <linux-fsdevel+bounces-3142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BC17F07B4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 17:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E1A1280DE4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 16:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0775515494;
	Sun, 19 Nov 2023 16:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 697FF138;
	Sun, 19 Nov 2023 08:57:50 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DFD71042;
	Sun, 19 Nov 2023 08:58:36 -0800 (PST)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F2F53F6C4;
	Sun, 19 Nov 2023 08:57:45 -0800 (PST)
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
Subject: [PATCH RFC v2 02/27] arm64: mte: Rename __GFP_ZEROTAGS to __GFP_TAGGED
Date: Sun, 19 Nov 2023 16:56:56 +0000
Message-Id: <20231119165721.9849-3-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231119165721.9849-1-alexandru.elisei@arm.com>
References: <20231119165721.9849-1-alexandru.elisei@arm.com>
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
 arch/arm64/mm/fault.c          |  2 +-
 include/linux/gfp_types.h      | 14 +++++++-------
 include/trace/events/mmflags.h |  2 +-
 mm/page_alloc.c                |  2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 460d799e1296..daa91608d917 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -948,7 +948,7 @@ struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
 	 * separate DC ZVA and STGM.
 	 */
 	if (vma->vm_flags & VM_MTE)
-		flags |= __GFP_ZEROTAGS;
+		flags |= __GFP_TAGGED;
 
 	return vma_alloc_folio(flags, 0, vma, vaddr, false);
 }
diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 6583a58670c5..37b9e265d77e 100644
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
@@ -226,11 +226,11 @@ typedef unsigned int __bitwise gfp_t;
  *
  * %__GFP_ZERO returns a zeroed page on success.
  *
- * %__GFP_ZEROTAGS zeroes memory tags at allocation time if the memory itself
- * is being zeroed (either via __GFP_ZERO or via init_on_alloc, provided that
- * __GFP_SKIP_ZERO is not set). This flag is intended for optimization: setting
- * memory tags at the same time as zeroing memory has minimal additional
- * performace impact.
+ * %__GFP_TAGGED marks the allocation as having tags, which will be zeroed it
+ * allocation time if the memory itself is being zeroed (either via __GFP_ZERO
+ * or via init_on_alloc, provided that __GFP_SKIP_ZERO is not set). This flag is
+ * intended for optimization: setting memory tags at the same time as zeroing
+ * memory has minimal additional performace impact.
  *
  * %__GFP_SKIP_KASAN makes KASAN skip unpoisoning on page allocation.
  * Used for userspace and vmalloc pages; the latter are unpoisoned by
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
index 733732e7e0ba..770e585b77c8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1483,7 +1483,7 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 {
 	bool init = !want_init_on_free() && want_init_on_alloc(gfp_flags) &&
 			!should_skip_init(gfp_flags);
-	bool zero_tags = init && (gfp_flags & __GFP_ZEROTAGS);
+	bool zero_tags = init && (gfp_flags & __GFP_TAGGED);
 	int i;
 
 	set_page_private(page, 0);
-- 
2.42.1


