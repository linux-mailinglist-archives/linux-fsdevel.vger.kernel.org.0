Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEF7517D85
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 08:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiECGoc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 02:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiECGnz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 02:43:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CEB5F42
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 May 2022 23:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ZzrfwhFvZ4lKbA1Gqsb9Nd8jE6YDqzct+3TYHW354nk=; b=ta/NJP8Ql0eG6wgTZCPPRF6LlU
        IldbZQaj28YB9otiqpgmMy1Unbyax0nMaqWyk+lwq8uCJd1843AQL4YIWv93zHIKaVS9CA2gIJxZu
        nZMQwydk3l7wxqWUfZBgMYZd/dfXXtMvDy4YhGAOeIw2tFfKy8296/+EDgBDF+vsKp+NFC9MxAMj+
        gLO26JOS9q/4f8ktSB+xdB7cHU9dtmZP/3rQUFYR8cGATZtayKJkimRDEUjIkvXCKoIOveV2qeaAN
        Z6K6IEVih6tfhLZ/wVgHhejzwrB8K9zhiuEoGEV6nxU00tLtG6SK6LZPX++wzKtE8ck51RYrJvtk2
        Ot8bCo0w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlmCi-00FRxM-1y; Tue, 03 May 2022 06:40:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [RFC PATCH 05/10] iomap: Allow a NULL writeback_control argument to iomap_alloc_ioend()
Date:   Tue,  3 May 2022 07:40:03 +0100
Message-Id: <20220503064008.3682332-6-willy@infradead.org>
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

When we're doing writethrough, we don't have a writeback_control to
pass in.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 85bcdb0dc66c..024e16fb95a8 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1232,9 +1232,13 @@ static struct iomap_ioend *iomap_alloc_ioend(struct inode *inode,
 	bio = bio_alloc_bioset(GFP_NOFS, BIO_MAX_VECS, &iomap_ioend_bioset);
 	bio_set_dev(bio, iomap->bdev);
 	bio->bi_iter.bi_sector = sector;
-	bio->bi_opf = REQ_OP_WRITE | wbc_to_write_flags(wbc);
+	bio->bi_opf = REQ_OP_WRITE;
 	bio->bi_write_hint = inode->i_write_hint;
-	wbc_init_bio(wbc, bio);
+
+	if (wbc) {
+		bio->bi_opf |= wbc_to_write_flags(wbc);
+		wbc_init_bio(wbc, bio);
+	}
 
 	ioend = container_of(bio, struct iomap_ioend, io_inline_bio);
 	INIT_LIST_HEAD(&ioend->io_list);
-- 
2.34.1

