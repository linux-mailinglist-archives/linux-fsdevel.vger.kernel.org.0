Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478FD517D81
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 08:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiECGo0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 02:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiECGnr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 02:43:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1F8318
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 May 2022 23:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=DXnyU8UdaKn/dEACocxQq39SsVe49AkFR7WSu5FfCiE=; b=cBdvTrBunnC7GNLOd0caKL/FrG
        QZ5H+H2wQZKDvvKtBe5z+6h2nRtQdPkWS+cGUot09sJpsmFnmtkPB6zoBOqVYLL2VX/yU1/KpKcCW
        Sj3Iih4s6ABoW7vtPSJs3XB7OoentfS+mUWHCRMChflJaYgLYj5/igPWsMmFGo4d+MNL0ReKAJr4S
        J9QqXoptsnANEtjS7UX0+WyBUZFJgXXOBhADKfjD3MHzOHf4CVcqY3M1NcuEN/3EWIovTDCjLRwVa
        MRwkWZJf8ko+oUb3pyael981/p1vOGO5tAx6G7uh6xOcORebrlS0fG3aJGQJj0f3FtX7WHLsRf4Bx
        nHdYjWxw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlmCi-00FRxo-Ip; Tue, 03 May 2022 06:40:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [RFC PATCH 10/10] remove write_through bool
Date:   Tue,  3 May 2022 07:40:08 +0100
Message-Id: <20220503064008.3682332-11-willy@infradead.org>
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

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 5050adbd4bc8..ec0189dc6747 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -534,7 +534,6 @@ EXPORT_SYMBOL_GPL(iomap_migrate_page);
 struct iomap_write_ctx {
 	struct iomap_ioend *ioend;
 	struct list_head iolist;
-	bool write_through;
 };
 
 static void
@@ -587,7 +586,7 @@ static bool iomap_can_add_to_ioend(struct iomap *iomap,
 }
 
 static struct iomap_ioend *iomap_alloc_ioend(struct inode *inode,
-		struct iomap *iomap, loff_t offset, sector_t sector,
+		const struct iomap *iomap, loff_t offset, sector_t sector,
 		struct writeback_control *wbc)
 {
 	struct iomap_ioend *ioend;
@@ -888,7 +887,7 @@ static bool iomap_write_through(struct iomap_write_ctx *iwc,
 {
 	unsigned int blksize = i_blocksize(inode);
 
-	if (!iwc || !iwc->write_through)
+	if (!iwc)
 		return false;
 	if (folio_test_dirty(folio))
 		return true;
@@ -1078,13 +1077,13 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
 	};
 	struct iomap_write_ctx iwc = {
 		.iolist = LIST_HEAD_INIT(iwc.iolist),
-		.write_through = iocb->ki_flags & IOCB_SYNC,
 	};
+	struct iomap_write_ctx *iwcp = iocb->ki_flags & IOCB_SYNC ? &iwc : NULL;
 	struct iomap_ioend *ioend, *next;
 	int ret;
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.processed = iomap_write_iter(&iter, i, &iwc);
+		iter.processed = iomap_write_iter(&iter, i, iwcp);
 
 	list_for_each_entry_safe(ioend, next, &iwc.iolist, io_list) {
 		list_del_init(&ioend->io_list);
-- 
2.34.1

