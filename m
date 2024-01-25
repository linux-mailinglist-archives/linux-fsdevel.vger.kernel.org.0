Return-Path: <linux-fsdevel+bounces-8944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6F083C85B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 17:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23AF828F7A2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 16:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29BF13398E;
	Thu, 25 Jan 2024 16:42:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FCA130E5D;
	Thu, 25 Jan 2024 16:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706200978; cv=none; b=ByeK0wdKXbAibtipjGJkDWCZ87YFGjzcMos4H0ZNcll2Fe9zPgA3zbmHz/bqXgebOh5Sn+z8XWp/T5nS+4qzzVDmobA6nK0GKzzQINZy0KeaweWqkxLC85VsCMfu+ZUhg3dscF462HDmRghpP5i7mSsymEe2Vg1d8vDIXrBmmK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706200978; c=relaxed/simple;
	bh=pv+l5Hf9xpsUjjiG1/GGQYsq3dMEQYkLkWbXEdf4Mdg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JOeUKxrB3FPNoOz99GT6DU8Mf5sOpUZ3q/gjiWAPuCtmgilw+10WsZkJBc51WwKHdxaJJcMWwrW+G5v84bXvkE1FojQ3bmbr/woicPBxWX3SV3DhFnwAnZj/xDcHGzfrF98B/lREKz4neek6NNRi/iEGGqBhP3nBjXnKw10i+3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46F74FEC;
	Thu, 25 Jan 2024 08:43:37 -0800 (PST)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 52C263F5A1;
	Thu, 25 Jan 2024 08:42:47 -0800 (PST)
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
Subject: [PATCH RFC v3 01/35] mm: page_alloc: Add gfp_flags parameter to arch_alloc_page()
Date: Thu, 25 Jan 2024 16:42:22 +0000
Message-Id: <20240125164256.4147-2-alexandru.elisei@arm.com>
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

Extend the usefulness of arch_alloc_page() by adding the gfp_flags
parameter.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---

Changes since rfc v2:

* New patch.

 arch/s390/include/asm/page.h | 2 +-
 arch/s390/mm/page-states.c   | 2 +-
 include/linux/gfp.h          | 2 +-
 mm/page_alloc.c              | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/page.h b/arch/s390/include/asm/page.h
index 73b9c3bf377f..859f0958c574 100644
--- a/arch/s390/include/asm/page.h
+++ b/arch/s390/include/asm/page.h
@@ -163,7 +163,7 @@ static inline int page_reset_referenced(unsigned long addr)
 
 struct page;
 void arch_free_page(struct page *page, int order);
-void arch_alloc_page(struct page *page, int order);
+void arch_alloc_page(struct page *page, int order, gfp_t gfp_flags);
 
 static inline int devmem_is_allowed(unsigned long pfn)
 {
diff --git a/arch/s390/mm/page-states.c b/arch/s390/mm/page-states.c
index 01f9b39e65f5..b986c8b158e3 100644
--- a/arch/s390/mm/page-states.c
+++ b/arch/s390/mm/page-states.c
@@ -21,7 +21,7 @@ void arch_free_page(struct page *page, int order)
 	__set_page_unused(page_to_virt(page), 1UL << order);
 }
 
-void arch_alloc_page(struct page *page, int order)
+void arch_alloc_page(struct page *page, int order, gfp_t gfp_flags)
 {
 	if (!cmma_flag)
 		return;
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index de292a007138..9e8aa3d144db 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -172,7 +172,7 @@ static inline struct zonelist *node_zonelist(int nid, gfp_t flags)
 static inline void arch_free_page(struct page *page, int order) { }
 #endif
 #ifndef HAVE_ARCH_ALLOC_PAGE
-static inline void arch_alloc_page(struct page *page, int order) { }
+static inline void arch_alloc_page(struct page *page, int order, gfp_t gfp_flags) { }
 #endif
 
 struct page *__alloc_pages(gfp_t gfp, unsigned int order, int preferred_nid,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 150d4f23b010..2c140abe5ee6 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1485,7 +1485,7 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 	set_page_private(page, 0);
 	set_page_refcounted(page);
 
-	arch_alloc_page(page, order);
+	arch_alloc_page(page, order, gfp_flags);
 	debug_pagealloc_map_pages(page, 1 << order);
 
 	/*
-- 
2.43.0


