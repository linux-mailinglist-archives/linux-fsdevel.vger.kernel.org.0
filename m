Return-Path: <linux-fsdevel+bounces-8945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA02B83C861
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 17:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A10231F2594F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 16:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BDC1350C6;
	Thu, 25 Jan 2024 16:43:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A1A1339AC;
	Thu, 25 Jan 2024 16:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706200981; cv=none; b=SXtRzpllnD8mw+uO3eGpPy+HL3zfTwz++zLkr5Fl89uxhNyWc0jfnqIk55P8Mcbql0dUwAuI+77knEoCBgUYxbdbinsYuAHWCbDobKOUvUIOh3TFzB/L33Zr1FgBKdVmtgxA/mfKenXZnReSbgCa/NyvbiK53NbBtiGYODC2FiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706200981; c=relaxed/simple;
	bh=AU78t+xYF5XPueOYyl2tCt7NLi6rgnb5IFhCKQ+TQ2M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HIGLgaXK8qCEmJ6liyXSufAY1y6Y2yWlvjp6LRpvIFMfT2WFdiMC0xHazHcD/SEobjpbLahoSHqGumrjhp6AWljLtTpu91i7ykU0NWyz5JHSbfWVcIgwcXIdKUew22EXg+XQ/DpDP2saIQJNaKc/hQS/oL08+TR9jLUkFU14ozk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13EB31476;
	Thu, 25 Jan 2024 08:43:43 -0800 (PST)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 219223F5A1;
	Thu, 25 Jan 2024 08:42:52 -0800 (PST)
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
Subject: [PATCH RFC v3 02/35] mm: page_alloc: Add an arch hook early in free_pages_prepare()
Date: Thu, 25 Jan 2024 16:42:23 +0000
Message-Id: <20240125164256.4147-3-alexandru.elisei@arm.com>
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

The arm64 MTE code uses the PG_arch_2 page flag, which it renames to
PG_mte_tagged, to track if a page has been mapped with tagging enabled.
That flag is cleared by free_pages_prepare() by doing:

	page->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;

When tag storage management is added, tag storage will be reserved for a
page if and only if the page is mapped as tagged (the page flag
PG_mte_tagged is set). When a page is freed, likewise, the code will have
to look at the the page flags to determine if the page has tag storage
reserved, which should also be freed.

For this purpose, add an arch_free_pages_prepare() hook that is called
before that page flags are cleared. The function arch_free_page() has also
been considered for this purpose, but it is called after the flags are
cleared.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---

Changes since rfc v2:

* Expanded commit message (David Hildenbrand).

 include/linux/pgtable.h | 4 ++++
 mm/page_alloc.c         | 1 +
 2 files changed, 5 insertions(+)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index f6d0e3513948..6d98d5fdd697 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -901,6 +901,10 @@ static inline void arch_do_swap_page(struct mm_struct *mm,
 }
 #endif
 
+#ifndef __HAVE_ARCH_FREE_PAGES_PREPARE
+static inline void arch_free_pages_prepare(struct page *page, int order) { }
+#endif
+
 #ifndef __HAVE_ARCH_UNMAP_ONE
 /*
  * Some architectures support metadata associated with a page. When a
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2c140abe5ee6..27282a1c82fe 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1092,6 +1092,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 
 	trace_mm_page_free(page, order);
 	kmsan_free_page(page, order);
+	arch_free_pages_prepare(page, order);
 
 	if (memcg_kmem_online() && PageMemcgKmem(page))
 		__memcg_kmem_uncharge_page(page, order);
-- 
2.43.0


