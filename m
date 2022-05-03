Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4C4517D88
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 08:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbiECGoi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 02:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiECGoA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 02:44:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3ABA5F42
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 May 2022 23:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=W95F6vgOTyekoy37n4Q60E+qAvQTF3eBfM3YF+VAdao=; b=j1ed4yRMlO+WfFqLqSCx4FYtqW
        df+6rBcUCX0M+2HDlHi38qd+mRwGz2e5BD7T9RMsIWhXw5DarAVQM/3QIA7sIH4xpLKGi6wM6T2lw
        gt14xk9srvGcWa5da8zH7oFxXGNYctxIuOX75BMYRYPDjZroTu0m9/EgAShwU6GjhnDzX8OGCAUki
        9H2bYoVeVeLysJY2MCMaiIniYI/QGlc7Y1mIAPtqd05tDeKUsHonSwePX6TkUrpipiTXjB/re/PwJ
        OLK4H23+6aNygZiafw00I2b41tMdt6/Px2YHVPMbA2DNuBBotr2yalT8iDU5JRM1mnAhV1jo8qUYk
        I6cGCszA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlmCh-00FRxI-S7; Tue, 03 May 2022 06:40:11 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [RFC PATCH 03/10] iomap: Do not pass iomap_writepage_ctx to iomap_add_to_ioend()
Date:   Tue,  3 May 2022 07:40:01 +0100
Message-Id: <20220503064008.3682332-4-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220503064008.3682332-1-willy@infradead.org>
References: <20220503064008.3682332-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In preparation for calling iomap_add_to_ioend() without a writepage_ctx
available, pass in the iomap and the (current) ioend, and return the
current ioend.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index c91259530ac1..1bf361446267 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1299,13 +1299,11 @@ static bool iomap_can_add_to_ioend(struct iomap *iomap,
  * Test to see if we have an existing ioend structure that we could append to
  * first; otherwise finish off the current ioend and start another.
  */
-static void
-iomap_add_to_ioend(struct inode *inode, loff_t pos, struct folio *folio,
-		struct iomap_page *iop, struct iomap_writepage_ctx *wpc,
+static struct iomap_ioend *iomap_add_to_ioend(struct inode *inode,
+		loff_t pos, struct folio *folio, struct iomap_page *iop,
+		struct iomap *iomap, struct iomap_ioend *ioend,
 		struct writeback_control *wbc, struct list_head *iolist)
 {
-	struct iomap *iomap = &wpc->iomap;
-	struct iomap_ioend *ioend = wpc->ioend;
 	sector_t sector = iomap_sector(iomap, pos);
 	unsigned len = i_blocksize(inode);
 	size_t poff = offset_in_folio(folio, pos);
@@ -1314,7 +1312,6 @@ iomap_add_to_ioend(struct inode *inode, loff_t pos, struct folio *folio,
 		if (ioend)
 			list_add(&ioend->io_list, iolist);
 		ioend = iomap_alloc_ioend(inode, iomap, pos, sector, wbc);
-		wpc->ioend = ioend;
 	}
 
 	if (!bio_add_folio(ioend->io_bio, folio, len, poff)) {
@@ -1326,6 +1323,7 @@ iomap_add_to_ioend(struct inode *inode, loff_t pos, struct folio *folio,
 		atomic_add(len, &iop->write_bytes_pending);
 	ioend->io_size += len;
 	wbc_account_cgroup_owner(wbc, &folio->page, len);
+	return ioend;
 }
 
 /*
@@ -1375,8 +1373,8 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 			continue;
 		if (wpc->iomap.type == IOMAP_HOLE)
 			continue;
-		iomap_add_to_ioend(inode, pos, folio, iop, wpc, wbc,
-				 &submit_list);
+		wpc->ioend = iomap_add_to_ioend(inode, pos, folio, iop,
+				&wpc->iomap, wpc->ioend, wbc, &submit_list);
 		count++;
 	}
 	if (count)
-- 
2.34.1

