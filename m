Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4426364E36C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Dec 2022 22:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiLOVoO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Dec 2022 16:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiLOVoE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Dec 2022 16:44:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220C85C759
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Dec 2022 13:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=HsMY9MrG5/c4/8q0wd8SB76CtOUUi8D1teXRxfN/iv0=; b=BEzOxntbptC2WdedNpdlPQRq+/
        BLQYCY/yYga8/rPn7/CJt+UCsrzybA614h4s7xKMpUWADxRFKJcd/ZX173Gf/xYpO3BAx36mvjMjZ
        TDA0SRMhv7CvTWDLqKooUFjad8ulcATa4ScbPKZ4hx1Nk0q8VkDDa9SkS9c6fNt3HKyIHvPuUV2L1
        0jVBSPakWdIM8JOcAZibji8Zsp5eNCwXs3fOSq10z+D7XmqqBZG9gSf08HdFGPqJZtTFhwfST3S3X
        5fMpiBrk5zZFh8/oKC1rQhRHi8hyJZ/aDYMyHcY0lAGaZkZSQo/RGYx91tn3VNEIgcWF/Cs0mysJq
        qLcqivUw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p5w1O-00EmLk-SA; Thu, 15 Dec 2022 21:44:06 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/12] buffer: Use b_folio in mark_buffer_dirty()
Date:   Thu, 15 Dec 2022 21:43:57 +0000
Message-Id: <20221215214402.3522366-8-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221215214402.3522366-1-willy@infradead.org>
References: <20221215214402.3522366-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Removes about four calls to compound_head().  Two of them are inline
which removes 132 bytes from the kernel text.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index c44ca40530c3..7e42d67bcaad 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1095,16 +1095,16 @@ void mark_buffer_dirty(struct buffer_head *bh)
 	}
 
 	if (!test_set_buffer_dirty(bh)) {
-		struct page *page = bh->b_page;
+		struct folio *folio = bh->b_folio;
 		struct address_space *mapping = NULL;
 
-		lock_page_memcg(page);
-		if (!TestSetPageDirty(page)) {
-			mapping = page_mapping(page);
+		folio_memcg_lock(folio);
+		if (!folio_test_set_dirty(folio)) {
+			mapping = folio->mapping;
 			if (mapping)
-				__set_page_dirty(page, mapping, 0);
+				__folio_mark_dirty(folio, mapping, 0);
 		}
-		unlock_page_memcg(page);
+		folio_memcg_unlock(folio);
 		if (mapping)
 			__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
 	}
-- 
2.35.1

