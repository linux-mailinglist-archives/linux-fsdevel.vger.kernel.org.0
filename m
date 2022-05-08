Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0091151F19F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbiEHUjx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbiEHUhd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:37:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969F91262E
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=DHXXEkjkgutXa0z8U66qSI+SAHEIx67e734aekDR7E0=; b=Bhxs6XhBF4UR51Ok1+cMK2oXFf
        riMKYRNm8hOpSjMq4Zkm0mZEX8uq9oMSTVnQAKRmZtv83QSFfJqOlOcRK0wAJuXe4Ng9V/6Xscy/1
        ezwLFOVTEMf4Jk8bFtbp5ixdbpLlAyDWujL16Ro9ULlI0+9woCrlENgxcs+pgxgB/vKmEpHiXnENz
        Lf7nYzXqyTHntV7Z4l9T9kGvz4qPhir7RqMWh+v2xKfBr4sdfwTbZ0WELsV7bbWLMYjxlemfsrbSe
        sW7iSONkvdBdTX+QvUHCSAUHPcizKIqRuKiymjSa9YW1+msMT44CuTa5NU+x52s5oj8HYE2Gu72mQ
        gwNO8jvQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnaT-002o6i-8c; Sun, 08 May 2022 20:33:05 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 4/5] secretmem: Convert to free_folio
Date:   Sun,  8 May 2022 21:33:00 +0100
Message-Id: <20220508203301.669147-5-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508203301.669147-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203301.669147-1-willy@infradead.org>
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

Prepare for any size of folio, even though secretmem only uses order-0
folios for now.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/secretmem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/secretmem.c b/mm/secretmem.c
index 3b3cf2892b6a..206ed6b40c1d 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -145,15 +145,15 @@ static int secretmem_migratepage(struct address_space *mapping,
 	return -EBUSY;
 }
 
-static void secretmem_freepage(struct page *page)
+static void secretmem_free_folio(struct folio *folio)
 {
-	set_direct_map_default_noflush(page);
-	clear_highpage(page);
+	set_direct_map_default_noflush(&folio->page);
+	folio_zero_segment(folio, 0, folio_size(folio));
 }
 
 const struct address_space_operations secretmem_aops = {
 	.dirty_folio	= noop_dirty_folio,
-	.freepage	= secretmem_freepage,
+	.free_folio	= secretmem_free_folio,
 	.migratepage	= secretmem_migratepage,
 	.isolate_page	= secretmem_isolate_page,
 };
-- 
2.34.1

