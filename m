Return-Path: <linux-fsdevel+bounces-49890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC81BAC4769
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 07:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE3143B953C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 05:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FFA1F78F2;
	Tue, 27 May 2025 05:05:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F291F582A;
	Tue, 27 May 2025 05:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748322328; cv=none; b=WIo9jLGOQaIFc3Wa+dS8EgkncejK1l0ZMOzkz8tUYFiTbcmqrJ0/zHq0/TsksNG5GW8STGeGOnUgDaX0YPTq2DtRoCU58hf51HxprDs0nv+Ztx7jqcorYchPhc0x1P/XglI9AFRGSquVCTH8ZHiuciwnO9i/8F4/bdeyInHsneE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748322328; c=relaxed/simple;
	bh=ZfJzFdHvBVoVt9yihJ6HO+m02MTs9dzOAIW953o6f9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WoIyUPObVPcKww13Q8twbDGvHDlJXkElaACm3UCBQlDEYRUyhz7xOwY2OIb/mXMkRu/On6zQTzLT/hU/EQ3uWdx4o/PYPHpxMbKFA3A1VQJxnvVh0eB0jXAxR1z32dAVmXw9XKD07I5oWmBCoLZwKJTjn4klQbtPdq+XB/JgpAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=pankajraghav.com; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4b60v75Kq0z9tPW;
	Tue, 27 May 2025 07:05:23 +0200 (CEST)
From: Pankaj Raghav <p.raghav@samsung.com>
To: Suren Baghdasaryan <surenb@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Zi Yan <ziy@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Michal Hocko <mhocko@suse.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nico Pache <npache@redhat.com>,
	Dev Jain <dev.jain@arm.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	willy@infradead.org,
	x86@kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	kernel@pankajraghav.com,
	hch@lst.de,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [RFC 3/3] block: use mm_huge_zero_folio in __blkdev_issue_zero_pages()
Date: Tue, 27 May 2025 07:04:52 +0200
Message-ID: <20250527050452.817674-4-p.raghav@samsung.com>
In-Reply-To: <20250527050452.817674-1-p.raghav@samsung.com>
References: <20250527050452.817674-1-p.raghav@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4b60v75Kq0z9tPW

Use mm_huge_zero_folio in __blkdev_issue_zero_pages(). Fallback to
ZERO_PAGE if mm_huge_zero_folio is not available.

On systems that allocates mm_huge_zero_folio, we will end up sending larger
bvecs instead of multiple small ones.

Noticed a 4% increase in performance on a commercial NVMe SSD which does
not support OP_WRITE_ZEROES. The device's MDTS was 128K. The performance
gains might be bigger if the device supports bigger MDTS.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 block/blk-lib.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 4c9f20a689f7..0fd55e028170 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -4,6 +4,7 @@
  */
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mm.h>
 #include <linux/bio.h>
 #include <linux/blkdev.h>
 #include <linux/scatterlist.h>
@@ -196,6 +197,12 @@ static void __blkdev_issue_zero_pages(struct block_device *bdev,
 		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
 		struct bio **biop, unsigned int flags)
 {
+	struct folio *zero_folio;
+
+	zero_folio = mm_get_huge_zero_folio(NULL);
+	if (!zero_folio)
+		zero_folio = page_folio(ZERO_PAGE(0));
+
 	while (nr_sects) {
 		unsigned int nr_vecs = __blkdev_sectors_to_bio_pages(nr_sects);
 		struct bio *bio;
@@ -208,11 +215,12 @@ static void __blkdev_issue_zero_pages(struct block_device *bdev,
 			break;
 
 		do {
-			unsigned int len, added;
+			unsigned int len, added = 0;
 
-			len = min_t(sector_t,
-				PAGE_SIZE, nr_sects << SECTOR_SHIFT);
-			added = bio_add_page(bio, ZERO_PAGE(0), len, 0);
+			len = min_t(sector_t, folio_size(zero_folio),
+				    nr_sects << SECTOR_SHIFT);
+			if (bio_add_folio(bio, zero_folio, len, 0))
+				added = len;
 			if (added < len)
 				break;
 			nr_sects -= added >> SECTOR_SHIFT;
-- 
2.47.2


