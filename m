Return-Path: <linux-fsdevel+bounces-3848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C917F92B1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 13:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEE93B20D92
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 12:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CA0DDB6;
	Sun, 26 Nov 2023 12:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="skZwzf3e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFAF910F;
	Sun, 26 Nov 2023 04:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=AQK98VN3ZPFPXW9nC8Xre48vrnhsdBlYTtG/aK7s89Q=; b=skZwzf3e1G1ojjmou+3994B9W3
	Wk5u8P4QdkWLpiqTSuT2NMCMTwwElJhtxLlNoPUmapDwFmFCZmoFuygoSpy5sQm22i+G7/HpoRoFJ
	MC6LfoH/AJlmwQH5hsVdk/Jt6dDDmzLt1yBWz5iIVWj3xEboXNwjgqMksVqRhHNb28Axg9KHIkha1
	M8aBogiIKY4IJ7xZn5dXREaAjGm2fMIN4nbjtBSHKpxc4ZVmr5ffhndXojq8wDw/KS6ReKBmQACIB
	JhUXfsjhN20zK5tiCP/e6fx3/qZqRXCAhZdiPABq8W4AcXyqjytr5q0Gv/lwMfHzKy+zpTvw1Z8bM
	rYc05Z1Q==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1r7EY8-00BCJi-0Z;
	Sun, 26 Nov 2023 12:47:48 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/13] iomap: clean up the iomap_new_ioend calling convention
Date: Sun, 26 Nov 2023 13:47:14 +0100
Message-Id: <20231126124720.1249310-8-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231126124720.1249310-1-hch@lst.de>
References: <20231126124720.1249310-1-hch@lst.de>
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
---
 fs/iomap/buffered-io.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 5834aa46bdb8cf..7f86d2f90e3863 100644
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


