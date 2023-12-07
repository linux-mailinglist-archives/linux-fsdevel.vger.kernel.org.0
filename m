Return-Path: <linux-fsdevel+bounces-5116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFA0808354
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 09:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62F331F22353
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 08:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FE7328C7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 08:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DNUgHjXp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF80D44;
	Wed,  6 Dec 2023 23:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=GKowZw5EFVL4s9hWrxJpcn0QfCciMG1qQeTNv820mBU=; b=DNUgHjXpZgpJTjBvG55R9ml3pH
	6nxEUkqFCCG4LEIw9i9YQU32uLeQwJ2Hy+l0JzvIaM8VDLh0/UU+y+rTl80nAArlH45FIORT0Ss+t
	l/iyDSeGp/nOKWB4hBOJ4B7beWtW4+WDf0zDHM1boROV/k1hf8koN/rBz6Kf/gEEM3X5wbjNzcoKR
	8EMSAshbKSqVmCJvrneuRiKYkW5o8/ZNJL1phVMXXqEPH2ZfWG/b0NxWV3ubso+PsH3FCYozKryar
	4eomZhpNNamJs9PJKA7GvBb2+X7ctHMS9cNQceHZTA7q0uN1tfwGP4OZXIETa7adaUS/XLn2fXHRG
	TrmAJShg==;
Received: from [2001:4bb8:191:e7ca:4bf6:cea4:9bbf:8b02] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rB8nH-00C50v-2N;
	Thu, 07 Dec 2023 07:27:36 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev
Subject: [PATCH 07/14] iomap: clean up the iomap_alloc_ioend calling convention
Date: Thu,  7 Dec 2023 08:27:03 +0100
Message-Id: <20231207072710.176093-8-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231207072710.176093-1-hch@lst.de>
References: <20231207072710.176093-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Switch to the same argument order as iomap_writepage_map and remove the
ifs argument that can be trivially recalculated.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index be23defc09c325..dc409ec85c3c0b 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1742,11 +1742,11 @@ iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t offset,
  * Test to see if we have an existing ioend structure that we could append to
  * first; otherwise finish off the current ioend and start another.
  */
-static void
-iomap_add_to_ioend(struct inode *inode, loff_t pos, struct folio *folio,
-		struct iomap_folio_state *ifs, struct iomap_writepage_ctx *wpc,
-		struct writeback_control *wbc, struct list_head *iolist)
+static void iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
+		struct writeback_control *wbc, struct folio *folio,
+		struct inode *inode, loff_t pos, struct list_head *iolist)
 {
+	struct iomap_folio_state *ifs = folio->private;
 	sector_t sector = iomap_sector(&wpc->iomap, pos);
 	unsigned len = i_blocksize(inode);
 	size_t poff = offset_in_folio(folio, pos);
@@ -1889,8 +1889,7 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		}
 		if (wpc->iomap.type == IOMAP_HOLE)
 			continue;
-		iomap_add_to_ioend(inode, pos, folio, ifs, wpc, wbc,
-				 &submit_list);
+		iomap_add_to_ioend(wpc, wbc, folio, inode, pos, &submit_list);
 		count++;
 	}
 	if (count)
-- 
2.39.2


