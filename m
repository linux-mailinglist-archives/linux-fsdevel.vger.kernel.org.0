Return-Path: <linux-fsdevel+bounces-3163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E217F07F0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 18:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 020841C208C8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 17:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C66618033;
	Sun, 19 Nov 2023 17:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 18C4E170C;
	Sun, 19 Nov 2023 08:59:41 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E785F1480;
	Sun, 19 Nov 2023 09:00:26 -0800 (PST)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B408D3F6C4;
	Sun, 19 Nov 2023 08:59:35 -0800 (PST)
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
Subject: [PATCH RFC v2 23/27] arm64: mte: copypage: Handle tag restoring when missing tag storage
Date: Sun, 19 Nov 2023 16:57:17 +0000
Message-Id: <20231119165721.9849-24-alexandru.elisei@arm.com>
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

There are several situations where copy_highpage() can end up copying
tags to a page which doesn't have its tag storage reserved.

One situation involves migration racing with mprotect(PROT_MTE): VMA is
initially untagged, migration starts and destination page is allocated
as untagged, mprotect(PROT_MTE) changes the VMA to tagged and userspace
accesses the source page, thus making it tagged.  The migration code
then calls copy_highpage(), which will copy the tags from the source
page (now tagged) to the destination page (allocated as untagged).

Yes another situation can happen during THP collapse. The huge page that
will replace the HPAGE_PMD_NR contiguous mapped pages is allocated with
__GFP_TAGGED not set. copy_highpage() will copy the tags from the pages
being replaced to the huge page which doesn't have tag storage reserved.

The situation gets even more complicated when the replacement huge page
is a tag storage page. The tag storage huge page will be migrated after
a fault on access, but the tags from the original pages must be copied
over to the huge page that will be replacing the tag storage huge page.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/mm/copypage.c | 59 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
index a7bb20055ce0..7899f38773b9 100644
--- a/arch/arm64/mm/copypage.c
+++ b/arch/arm64/mm/copypage.c
@@ -13,6 +13,62 @@
 #include <asm/cacheflush.h>
 #include <asm/cpufeature.h>
 #include <asm/mte.h>
+#include <asm/mte_tag_storage.h>
+
+#ifdef CONFIG_ARM64_MTE_TAG_STORAGE
+static inline bool try_transfer_saved_tags(struct page *from, struct page *to)
+{
+	void *tags;
+	bool saved;
+
+	VM_WARN_ON_ONCE(!preemptible());
+
+	if (page_mte_tagged(from)) {
+		if (likely(page_tag_storage_reserved(to)))
+			return false;
+
+		tags = mte_allocate_tag_buf();
+		if (WARN_ON(!tags))
+			return true;
+
+		mte_copy_page_tags_to_buf(page_address(from), tags);
+		saved = mte_save_tags_for_pfn(tags, page_to_pfn(to));
+		if (!saved)
+			mte_free_tag_buf(tags);
+
+		return saved;
+	}
+
+	if (likely(!page_is_tag_storage(from)))
+		return false;
+
+	tags_by_pfn_lock();
+	tags = mte_erase_tags_for_pfn(page_to_pfn(from));
+	tags_by_pfn_unlock();
+
+	if (likely(!tags))
+		return false;
+
+	if (page_tag_storage_reserved(to)) {
+		WARN_ON_ONCE(!try_page_mte_tagging(to));
+		mte_copy_page_tags_from_buf(page_address(to), tags);
+		set_page_mte_tagged(to);
+		mte_free_tag_buf(tags);
+		return true;
+	}
+
+	saved = mte_save_tags_for_pfn(tags, page_to_pfn(to));
+	if (!saved)
+		mte_free_tag_buf(tags);
+
+	return saved;
+}
+#else
+static inline bool try_transfer_saved_tags(struct page *from, struct page *to)
+{
+	return false;
+}
+#endif
 
 void copy_highpage(struct page *to, struct page *from)
 {
@@ -24,6 +80,9 @@ void copy_highpage(struct page *to, struct page *from)
 	if (kasan_hw_tags_enabled())
 		page_kasan_tag_reset(to);
 
+	if (tag_storage_enabled() && try_transfer_saved_tags(from, to))
+		return;
+
 	if (system_supports_mte() && page_mte_tagged(from)) {
 		/* It's a new page, shouldn't have been tagged yet */
 		WARN_ON_ONCE(!try_page_mte_tagging(to));
-- 
2.42.1


