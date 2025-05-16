Return-Path: <linux-fsdevel+bounces-49229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8495EAB99CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 12:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FCCE1896552
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 10:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EFF235BF3;
	Fri, 16 May 2025 10:11:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9139E23370C;
	Fri, 16 May 2025 10:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747390284; cv=none; b=D35qDZ61KXJor04dfxPqQTW2h7etzL0ZxSy7vLyp6G4t8l/AtGglU4iQQqWq29eHZDdHWORgNZKcqtjd1Ba0fZWjRKbUaQ1jnyE+1RP5Y3NnSTIpbOd1P0e1h9chMcugkEZfidLVHmeac2cDH9DOMW614mkXc/7NWM3dwP9ZUsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747390284; c=relaxed/simple;
	bh=ajC8gbTODZgih3ebHEAqb5o/Ct5VekreC9TKQudISIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TVfyfk2zibJIZ1wE1p+t7fhb69vAQ8KaaaA2NVjjcYxwTOli72vVV21qcjGjBGPQ6IhqpbJvSByKXdfUgcSI3tPSo4SCBIB1Fftk91pCk0bKuOP2EoaGriLCRBaP99HZKUdwQ30+xSFT/w35WHymUMbM20X53dBZAEYkq1cMwLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=pankajraghav.com; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4ZzNCC150Mz9ssM;
	Fri, 16 May 2025 12:11:19 +0200 (CEST)
From: Pankaj Raghav <p.raghav@samsung.com>
To: "Darrick J . Wong" <djwong@kernel.org>,
	hch@lst.de,
	willy@infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	Andrew Morton <akpm@linux-foundation.org>,
	kernel@pankajraghav.com,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [RFC 2/3] block: use LARGE_ZERO_PAGE in __blkdev_issue_zero_pages()
Date: Fri, 16 May 2025 12:10:53 +0200
Message-ID: <20250516101054.676046-3-p.raghav@samsung.com>
In-Reply-To: <20250516101054.676046-1-p.raghav@samsung.com>
References: <20250516101054.676046-1-p.raghav@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4ZzNCC150Mz9ssM

Use LARGE_ZERO_PAGE in __blkdev_issue_zero_pages() instead of ZERO_PAGE.
On systems that support LARGE_ZERO_PAGE, we will end up sending larger
bvecs instead of multiple small ones.

Noticed a 4% increase in performance on a commercial NVMe SSD which does
not support OP_WRITE_ZEROES. The performance gains might be bigger if
the device supports larger MDTS.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 block/blk-lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 4c9f20a689f7..80dfc737d1f6 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -211,8 +211,8 @@ static void __blkdev_issue_zero_pages(struct block_device *bdev,
 			unsigned int len, added;
 
 			len = min_t(sector_t,
-				PAGE_SIZE, nr_sects << SECTOR_SHIFT);
-			added = bio_add_page(bio, ZERO_PAGE(0), len, 0);
+				ZERO_LARGE_PAGE_SIZE, nr_sects << SECTOR_SHIFT);
+			added = bio_add_page(bio, ZERO_LARGE_PAGE(0), len, 0);
 			if (added < len)
 				break;
 			nr_sects -= added >> SECTOR_SHIFT;
-- 
2.47.2


