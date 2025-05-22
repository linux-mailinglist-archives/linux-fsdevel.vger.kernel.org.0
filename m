Return-Path: <linux-fsdevel+bounces-49665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 420A4AC0828
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 11:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 516303ADE0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 09:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0D52882DA;
	Thu, 22 May 2025 09:03:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919E113212A;
	Thu, 22 May 2025 09:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747904597; cv=none; b=PFNSXrh10IcV7NYhS+P96pxCoUdEJOUh0whTlNq/vxvOCtRIrrxzgAxwXykJIHyBINwSAOce2jVF3au7f5N8LypM1LSpqKPCusx0V28pQtxuh7645xjNDN2zmRf78pu2Dw2ro7U3q3nmKpziWBvzLuzA7zLvZi9VloRtaNFbA+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747904597; c=relaxed/simple;
	bh=/2FzKQy6N923y+2/aYeRTf7lFGlB3ZaKNCL5XEte00g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LO6ozZayc1buD1UhtWvIy1v1PjZb72C1cDAESYcp5PHqZ2mIpMsxNGbz25UZoG/Mcj9pn/htR3DX2H4kQqEbYgxpQ3Y265y4D0DODWiw2AlX+I6tu8+87TFwT7NzRpsf44kXRkc2+gbU1KiNlKEItpEfK3R+kZvregewiGv7i9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=pankajraghav.com; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4b32Pq2VNhz9t4X;
	Thu, 22 May 2025 11:03:11 +0200 (CEST)
From: Pankaj Raghav <p.raghav@samsung.com>
To: Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
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
	Zi Yan <ziy@nvidia.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>,
	gost.dev@samsung.com,
	kernel@pankajraghav.com,
	hch@lst.de,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	willy@infradead.org,
	x86@kernel.org,
	mcgrof@kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [RFC v2 2/2] block: use mm_huge_zero_folio in __blkdev_issue_zero_pages()
Date: Thu, 22 May 2025 11:02:43 +0200
Message-ID: <20250522090243.758943-3-p.raghav@samsung.com>
In-Reply-To: <20250522090243.758943-1-p.raghav@samsung.com>
References: <20250522090243.758943-1-p.raghav@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use mm_huge_zero_folio in __blkdev_issue_zero_pages(). Fallback to
ZERO_PAGE if mm_huge_zero_folio is not available.

On systems that allocates mm_huge_zero_folio, we will end up sending larger
bvecs instead of multiple small ones.

Noticed a 4% increase in performance on a commercial NVMe SSD which does
not support OP_WRITE_ZEROES. The device's MDTS was 128K. The performance
gains might be bigger if the device supports bigger MDTS.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 block/blk-lib.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 4c9f20a689f7..221389412359 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -196,6 +196,12 @@ static void __blkdev_issue_zero_pages(struct block_device *bdev,
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
@@ -208,11 +214,12 @@ static void __blkdev_issue_zero_pages(struct block_device *bdev,
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


