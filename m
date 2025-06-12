Return-Path: <linux-fsdevel+bounces-51437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FBAAD6E4E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 12:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 979D43B191F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 10:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7C1248864;
	Thu, 12 Jun 2025 10:51:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E10246797;
	Thu, 12 Jun 2025 10:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749725502; cv=none; b=XDW3gzfJgMUntqhIWA2dl9vcvD2ndXxAO4QF+mhwsipHYvtjKblGOBVfJ909jrXcrOylFGOGvxP/QJK2r5kTrPL7Bi0UwumflkFk0m8CEve4zYkzKU+v0KzV+ik+s3xI+Kw0JCCmDKnJj0KAJ0yFHHS1Jfj0uJwltEhh/QP60a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749725502; c=relaxed/simple;
	bh=QNuotDSbXamqQoufAqDmvk9X3kWMiUNh5OnMNgQcFr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yz47Tywrg3AmBjoS1vlb259TFMLR46u4fXVtjmIuURPUNe6x4Cwma2MY0YXp48sqauKeKDqyfd5zOwdr9R3FM50lve78HLxyRbvngTiIf/dL84ZsmlOL1InkWP1fIbvLTf4SPXJC8yOdsN6epKjTVfqrLNVWlR0TdW5CPZ4/3mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=pankajraghav.com; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bHzqF3rv5z9std;
	Thu, 12 Jun 2025 12:51:37 +0200 (CEST)
From: Pankaj Raghav <p.raghav@samsung.com>
To: Suren Baghdasaryan <surenb@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nico Pache <npache@redhat.com>,
	Dev Jain <dev.jain@arm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	willy@infradead.org,
	x86@kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	kernel@pankajraghav.com,
	hch@lst.de,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 4/5] mm: add mm_get_static_huge_zero_folio() routine
Date: Thu, 12 Jun 2025 12:50:59 +0200
Message-ID: <20250612105100.59144-5-p.raghav@samsung.com>
In-Reply-To: <20250612105100.59144-1-p.raghav@samsung.com>
References: <20250612105100.59144-1-p.raghav@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add mm_get_static_huge_zero_folio() routine so that huge_zero_folio can be
used without the need to pass any mm struct. This will return ZERO_PAGE
folio if CONFIG_STATIC_PMD_ZERO_PAGE is disabled.

This routine can also be called even if THP is disabled.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 include/linux/mm.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index b20d60d68b3c..c8805480ff21 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4021,6 +4021,22 @@ static inline bool vma_is_special_huge(const struct vm_area_struct *vma)
 extern struct folio *huge_zero_folio;
 extern unsigned long huge_zero_pfn;
 
+/*
+ * mm_get_static_huge_zero_folio - Get a PMD sized zero folio
+ *
+ * This function will return a PMD sized zero folio if CONFIG_STATIC_PMD_ZERO_PAGE
+ * is enabled. Otherwise, a ZERO_PAGE folio is returned.
+ *
+ * Deduce the size of the folio with folio_size instead of assuming the
+ * folio size.
+ */
+static inline struct folio *mm_get_static_huge_zero_folio(void)
+{
+	if(IS_ENABLED(CONFIG_STATIC_PMD_ZERO_PAGE))
+		return READ_ONCE(huge_zero_folio);
+	return page_folio(ZERO_PAGE(0));
+}
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static inline bool is_huge_zero_folio(const struct folio *folio)
 {
-- 
2.49.0


