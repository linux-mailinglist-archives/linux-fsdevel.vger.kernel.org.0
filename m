Return-Path: <linux-fsdevel+bounces-57068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EF2B1E819
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 14:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A11A5A06ED
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 12:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711F5279DA0;
	Fri,  8 Aug 2025 12:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="ZaGJdeS8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9EA277C80;
	Fri,  8 Aug 2025 12:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754655161; cv=none; b=c0URBBckYE/BdrzNv00OJ0C++1wcqTMTPzrrxMPjWC0CJ0mEKAxENA51Di3wX3+xvaTkmSGWNou5mHnFvoYB3iNCX9or7YDSHAZqVS6JV3InZeLzzn2QLnuSwZ/PwDCGMDeUqRNnFLhn4MRX1/BADOK0d9fIvC3sNEENZ+/hSaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754655161; c=relaxed/simple;
	bh=fFzN46s8fI+jPXzBN2wRyau0XR7zJopdfaevTTLhQwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W/CkqG+eTUOonpZSgV+wbyLW/AUPY/rgGYZDGx+AqwXyCmA0p2NaQ3uLRKtLnkXC9hbQB87rsbkvOBiQ6nm237TnThtjfK+T/k9yDkeaf/Pqkh43j/M2Mhc1bQSupFcQ6HqUl5HpfiVpqLEsvszU3/TT5jyRNHeUYjHNTlq/wj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=ZaGJdeS8; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bz2wN3TVnz9tLL;
	Fri,  8 Aug 2025 14:12:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1754655156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hl5pR6KEXqqmRKm0XQhFRqtMBlaQMUsVvgjCapFINjk=;
	b=ZaGJdeS88MWI5NXG3Fy0kv05JzmFrCMryJvIIsk5SlxRa/OALrQpqUbO7OG/n/G7Yr4Sda
	dC51E4KZ2b2T2b4idAP7ty61iehCdDdUhNOLDSNhW1AF2IVMbXYgYSWs+s4UbOZupjCiQQ
	CrMfrkJTIZ6UhFu+zYI7Spvlm4qnjI34BohLV+Vnri7LWcR1fXSnQ3t/Qf/irCwFmBkh7d
	hbvaESdPDVdP+WiXUHeLXGApaEIyCK7tRLfTRQ4WfL3gZ9UmLIjst16rr58es4oLMunmUK
	J0tWLUSDz85HNspTwwtHPZN/P5PNBzW3xm7K3eSDeHBU2sWkWZ+zVs3Re+/L3Q==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of kernel@pankajraghav.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=kernel@pankajraghav.com
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Suren Baghdasaryan <surenb@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Vlastimil Babka <vbabka@suse.cz>,
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
	willy@infradead.org,
	linux-mm@kvack.org,
	Ritesh Harjani <ritesh.list@gmail.com>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	kernel@pankajraghav.com,
	hch@lst.de,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v2 5/5] block: use largest_zero_folio in __blkdev_issue_zero_pages()
Date: Fri,  8 Aug 2025 14:11:41 +0200
Message-ID: <20250808121141.624469-6-kernel@pankajraghav.com>
In-Reply-To: <20250808121141.624469-1-kernel@pankajraghav.com>
References: <20250808121141.624469-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4bz2wN3TVnz9tLL

From: Pankaj Raghav <p.raghav@samsung.com>

Use largest_zero_folio() in __blkdev_issue_zero_pages().
On systems with CONFIG_PERSISTENT_HUGE_ZERO_FOLIO enabled, we will end up
sending larger bvecs instead of multiple small ones.

Noticed a 4% increase in performance on a commercial NVMe SSD which does
not support OP_WRITE_ZEROES. The device's MDTS was 128K. The performance
gains might be bigger if the device supports bigger MDTS.

Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 block/blk-lib.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 4c9f20a689f7..3030a772d3aa 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -196,6 +196,8 @@ static void __blkdev_issue_zero_pages(struct block_device *bdev,
 		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
 		struct bio **biop, unsigned int flags)
 {
+	struct folio *zero_folio = largest_zero_folio();
+
 	while (nr_sects) {
 		unsigned int nr_vecs = __blkdev_sectors_to_bio_pages(nr_sects);
 		struct bio *bio;
@@ -208,15 +210,14 @@ static void __blkdev_issue_zero_pages(struct block_device *bdev,
 			break;
 
 		do {
-			unsigned int len, added;
+			unsigned int len;
 
-			len = min_t(sector_t,
-				PAGE_SIZE, nr_sects << SECTOR_SHIFT);
-			added = bio_add_page(bio, ZERO_PAGE(0), len, 0);
-			if (added < len)
+			len = min_t(sector_t, folio_size(zero_folio),
+				    nr_sects << SECTOR_SHIFT);
+			if (!bio_add_folio(bio, zero_folio, len, 0))
 				break;
-			nr_sects -= added >> SECTOR_SHIFT;
-			sector += added >> SECTOR_SHIFT;
+			nr_sects -= len >> SECTOR_SHIFT;
+			sector += len >> SECTOR_SHIFT;
 		} while (nr_sects);
 
 		*biop = bio_chain_and_submit(*biop, bio);
-- 
2.49.0


