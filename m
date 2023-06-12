Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427A472D167
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 23:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237677AbjFLVFN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 17:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238783AbjFLVEn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:04:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54FA1732
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 14:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=vKvynQGpjvP3shWSlyAyKuk5q4UrI4w69YUOsJMsW1c=; b=kDcBVqfGv0w8ceTHfcy0uqPeHY
        ij1TUg81AusxbwiXPLYJyuRQFPKjOujzLcAUYtMKsEdjlhLUbm4vyLT7+touimkipsuNhz7elll3l
        N+d2WpSWM5XqsoL4ml14K56UAkBv7bw9zjUaUof2FVsu9Z8asLdJ/8pzYBf8w7392Ye6aXPsU7v4z
        MQG1xDUEdMBDXaAI4Vt1e4HHkMAYBjZfTlaOWGzOe4EbhsOFtFU2DSMznp1VDaQVSqyTZ95aMQw0m
        8Sd2VlYwglRGcLQ1rkpYsVOw3Ce/2FIfY2Mlmrnz3yALSoSWPUan5FcSKl4hPPPgtt0eVEsS9pBH7
        KHC4zj0w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8ofY-0033xQ-6f; Mon, 12 Jun 2023 21:01:44 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        cluster-devel@redhat.com, Hannes Reinecke <hare@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v3 13/14] buffer: Use a folio in __find_get_block_slow()
Date:   Mon, 12 Jun 2023 22:01:40 +0100
Message-Id: <20230612210141.730128-14-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230612210141.730128-1-willy@infradead.org>
References: <20230612210141.730128-1-willy@infradead.org>
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

Saves a call to compound_head() and may be needed to support
block size > PAGE_SIZE.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 4ca2eb2b3dca..c38fdcaa32ff 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -195,19 +195,19 @@ __find_get_block_slow(struct block_device *bdev, sector_t block)
 	pgoff_t index;
 	struct buffer_head *bh;
 	struct buffer_head *head;
-	struct page *page;
+	struct folio *folio;
 	int all_mapped = 1;
 	static DEFINE_RATELIMIT_STATE(last_warned, HZ, 1);
 
 	index = block >> (PAGE_SHIFT - bd_inode->i_blkbits);
-	page = find_get_page_flags(bd_mapping, index, FGP_ACCESSED);
-	if (!page)
+	folio = __filemap_get_folio(bd_mapping, index, FGP_ACCESSED, 0);
+	if (IS_ERR(folio))
 		goto out;
 
 	spin_lock(&bd_mapping->private_lock);
-	if (!page_has_buffers(page))
+	head = folio_buffers(folio);
+	if (!head)
 		goto out_unlock;
-	head = page_buffers(page);
 	bh = head;
 	do {
 		if (!buffer_mapped(bh))
@@ -237,7 +237,7 @@ __find_get_block_slow(struct block_device *bdev, sector_t block)
 	}
 out_unlock:
 	spin_unlock(&bd_mapping->private_lock);
-	put_page(page);
+	folio_put(folio);
 out:
 	return ret;
 }
-- 
2.39.2

