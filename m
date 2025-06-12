Return-Path: <linux-fsdevel+bounces-51435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31679AD6E48
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 12:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6BE318924CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 10:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEA623C8DB;
	Thu, 12 Jun 2025 10:51:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CECF23A9AD;
	Thu, 12 Jun 2025 10:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749725488; cv=none; b=Pwq705tNvROjDXc9FTqwkkBI3djmlzyZqABIzDvKngHy8uqaj75Eb0HPvX/jI/S5xAg4yeOdspZh2bA0hb6y2WAj9lpKLeS92EkA1SFd93lrBirgwdRJn5Q/HhzgU9PyF2yQ2674AacIU/SpNmiQaFzpX1hS5291/E0fl4lmCjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749725488; c=relaxed/simple;
	bh=P33S8WOT/OmzM1wtlo2dQh4zF4v+rYw0sInMwlmnl1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TjYnamoHb5s+xgIkdUBUGPaBRk5F897xHRn31jkQv1wNabda+cfAkSO2AeqXs/ZPI5oBTmzYN7Kw9Siyv2OxbJUmAUuuOGyprYQAm/vPJ5jMQepny5nnvkpDpQBYK/3NK1ZT5ghnbsSiLSoZMR1zgkjtPoDIL4ypX59wemwLba0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=pankajraghav.com; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bHzpy5spkz9t8J;
	Thu, 12 Jun 2025 12:51:22 +0200 (CEST)
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
Subject: [PATCH 2/5] huge_memory: add huge_zero_page_shrinker_(init|exit) function
Date: Thu, 12 Jun 2025 12:50:57 +0200
Message-ID: <20250612105100.59144-3-p.raghav@samsung.com>
In-Reply-To: <20250612105100.59144-1-p.raghav@samsung.com>
References: <20250612105100.59144-1-p.raghav@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add huge_zero_page_shrinker_init() and huge_zero_page_shrinker_exit().
As shrinker will not be needed when static PMD zero page is enabled,
these two functions can be a no-op.

This is a preparation patch for static PMD zero page. No functional
changes.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 mm/huge_memory.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d3e66136e41a..101b67ab2eb6 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -289,6 +289,24 @@ static unsigned long shrink_huge_zero_page_scan(struct shrinker *shrink,
 }
 
 static struct shrinker *huge_zero_page_shrinker;
+static int huge_zero_page_shrinker_init(void)
+{
+	huge_zero_page_shrinker = shrinker_alloc(0, "thp-zero");
+	if (!huge_zero_page_shrinker)
+		return -ENOMEM;
+
+	huge_zero_page_shrinker->count_objects = shrink_huge_zero_page_count;
+	huge_zero_page_shrinker->scan_objects = shrink_huge_zero_page_scan;
+	shrinker_register(huge_zero_page_shrinker);
+	return 0;
+}
+
+static void huge_zero_page_shrinker_exit(void)
+{
+	shrinker_free(huge_zero_page_shrinker);
+	return;
+}
+
 
 #ifdef CONFIG_SYSFS
 static ssize_t enabled_show(struct kobject *kobj,
@@ -850,33 +868,31 @@ static inline void hugepage_exit_sysfs(struct kobject *hugepage_kobj)
 
 static int __init thp_shrinker_init(void)
 {
-	huge_zero_page_shrinker = shrinker_alloc(0, "thp-zero");
-	if (!huge_zero_page_shrinker)
-		return -ENOMEM;
+	int ret = 0;
 
 	deferred_split_shrinker = shrinker_alloc(SHRINKER_NUMA_AWARE |
 						 SHRINKER_MEMCG_AWARE |
 						 SHRINKER_NONSLAB,
 						 "thp-deferred_split");
-	if (!deferred_split_shrinker) {
-		shrinker_free(huge_zero_page_shrinker);
+	if (!deferred_split_shrinker)
 		return -ENOMEM;
-	}
-
-	huge_zero_page_shrinker->count_objects = shrink_huge_zero_page_count;
-	huge_zero_page_shrinker->scan_objects = shrink_huge_zero_page_scan;
-	shrinker_register(huge_zero_page_shrinker);
 
 	deferred_split_shrinker->count_objects = deferred_split_count;
 	deferred_split_shrinker->scan_objects = deferred_split_scan;
 	shrinker_register(deferred_split_shrinker);
 
+	ret = huge_zero_page_shrinker_init();
+	if (ret) {
+		shrinker_free(deferred_split_shrinker);
+		return ret;
+	}
+
 	return 0;
 }
 
 static void __init thp_shrinker_exit(void)
 {
-	shrinker_free(huge_zero_page_shrinker);
+	huge_zero_page_shrinker_exit();
 	shrinker_free(deferred_split_shrinker);
 }
 
-- 
2.49.0


