Return-Path: <linux-fsdevel+bounces-8946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5820A83C864
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 17:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E9041F25B5C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 16:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE45135412;
	Thu, 25 Jan 2024 16:43:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F09135417;
	Thu, 25 Jan 2024 16:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706200988; cv=none; b=JMJhvT2tIgGWwlWAThl1vEQBsxW8KM0/Yi5ckUndUVUT3Hk+SAYSlaKJeXhyK5W4eSv5nMRs3KK0SwC3rCYcrGInPu7EK1nVEzxgGVTPOglnEgsZmXpi/fna0Bg1G3PMTnF9T46rU2okS80KPgqrgxWHEquoIYsHT5OYLgqitZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706200988; c=relaxed/simple;
	bh=D/hqHT7m4p56hZz+nSWR5TR3chuuOg75oPh3Ho54hkM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ojUKs5CYWwz9/XBg1BJFcCy9s8AHsbFEGN0Brfp9KXYReC9uDeSMhlFHzQelc1JAfi5DkxAiF2fI8vSy9vlLDth2yZTvsevS3h5ql0HXl0bK8RKR8HvkHuNx4yLBN+VmRm8N5E3vsfBsb0YCpI+xSsmjMqtEveBkaJzEyfECP0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2B4A1477;
	Thu, 25 Jan 2024 08:43:48 -0800 (PST)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E1DA43F5A1;
	Thu, 25 Jan 2024 08:42:58 -0800 (PST)
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
Subject: [PATCH RFC v3 03/35] mm: page_alloc: Add an arch hook to filter MIGRATE_CMA allocations
Date: Thu, 25 Jan 2024 16:42:24 +0000
Message-Id: <20240125164256.4147-4-alexandru.elisei@arm.com>
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

As an architecture might have specific requirements around the allocation
of CMA pages, add an arch hook that can disable allocations from
MIGRATE_CMA, if the allocation was otherwise allowed.

This will be used by arm64, which will put tag storage pages on the
MIGRATE_CMA list, and tag storage pages cannot be tagged. The filter will
be used to deny using MIGRATE_CMA for __GFP_TAGGED allocations.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 include/linux/pgtable.h | 7 +++++++
 mm/page_alloc.c         | 3 ++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 6d98d5fdd697..c5ddec6b5305 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -905,6 +905,13 @@ static inline void arch_do_swap_page(struct mm_struct *mm,
 static inline void arch_free_pages_prepare(struct page *page, int order) { }
 #endif
 
+#ifndef __HAVE_ARCH_ALLOC_CMA
+static inline bool arch_alloc_cma(gfp_t gfp)
+{
+	return true;
+}
+#endif
+
 #ifndef __HAVE_ARCH_UNMAP_ONE
 /*
  * Some architectures support metadata associated with a page. When a
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 27282a1c82fe..a96d47a6393e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3157,7 +3157,8 @@ static inline unsigned int gfp_to_alloc_flags_cma(gfp_t gfp_mask,
 						  unsigned int alloc_flags)
 {
 #ifdef CONFIG_CMA
-	if (gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE)
+	if (gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE &&
+	    arch_alloc_cma(gfp_mask))
 		alloc_flags |= ALLOC_CMA;
 #endif
 	return alloc_flags;
-- 
2.43.0


