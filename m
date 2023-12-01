Return-Path: <linux-fsdevel+bounces-4592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F23C801030
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 17:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 283CB281818
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 16:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28594D12F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 16:34:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E5E81700
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 08:10:57 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54F091007;
	Fri,  1 Dec 2023 08:11:43 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E8253F6C4;
	Fri,  1 Dec 2023 08:10:56 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v1] mm/readahead: Do not allow order-1 folio
Date: Fri,  1 Dec 2023 16:10:45 +0000
Message-Id: <20231201161045.3962614-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The THP machinery does not support order-1 folios because it requires
meta data spanning the first 3 `struct page`s. So order-2 is the
smallest large folio that we can safely create.

There was a theoretical bug whereby if ra->size was 2 or 3 pages (due to
the device-specific bdi->ra_pages being set that way), we could end up
with order = 1. Fix this by unconditionally checking if the preferred
order is 1 and if so, set it to 0. Previously this was done in a few
specific places, but with this refactoring it is done just once,
unconditionally, at the end of the calculation.

This is a theoretical bug found during review of the code; I have no
evidence to suggest this manifests in the real world (I expect all
device-specific ra_pages values are much bigger than 3).

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 mm/readahead.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 6925e6959fd3..23620c57c122 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -511,16 +511,14 @@ void page_cache_ra_order(struct readahead_control *ractl,
 		unsigned int order = new_order;

 		/* Align with smaller pages if needed */
-		if (index & ((1UL << order) - 1)) {
+		if (index & ((1UL << order) - 1))
 			order = __ffs(index);
-			if (order == 1)
-				order = 0;
-		}
 		/* Don't allocate pages past EOF */
-		while (index + (1UL << order) - 1 > limit) {
-			if (--order == 1)
-				order = 0;
-		}
+		while (index + (1UL << order) - 1 > limit)
+			order--;
+		/* THP machinery does not support order-1 */
+		if (order == 1)
+			order = 0;
 		err = ra_alloc_folio(ractl, index, mark, order, gfp);
 		if (err)
 			break;
--
2.25.1


