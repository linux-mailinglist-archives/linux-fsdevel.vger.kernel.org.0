Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A3351F184
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbiEHUh4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbiEHUgs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:36:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFA511C31
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=N+nPZzQVU7ENkZ8MyrhlNkyUFrPUWPa52CLs4ArjSmw=; b=hUrGDW3KkNz6y2a5V45B7Rab4s
        zZ8aaQFMj6oW8K6ikP3KBYO7YSwP+XoAFXcnK3UHiS1n7NWthwjg10hvA4OzdXH4iHom9j1Hs5e8n
        2BQcakYls9iDxKA2brNhUbZ4CWTC1ABV91Y/8kIMr1s9mCqmyWjOlXaHUxmqU1pzoRkWVcSTMi7LB
        1b5G4TGWEiT5VhcOtDHsfPtvIr/DrF8SWcEVrYYe5gS0PBOXDk491FFQfc6Idhd9Ra7RbDi3Gkfrv
        f2LDUGMcFsQBSbi0NoqOpYxfIktjksAiDLyLW6sThMyzUMcly506KhdbQMkTg2GPK81Ag9DAHBotT
        EQkudKig==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnaF-002o2O-48; Sun, 08 May 2022 20:32:51 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 18/26] orangefs: Convert to release_folio
Date:   Sun,  8 May 2022 21:32:39 +0100
Message-Id: <20220508203247.668791-19-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508203247.668791-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203247.668791-1-willy@infradead.org>
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

Use folios throughout the release_folio path.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/orangefs/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 241ac21f527b..3509618e7b37 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -485,9 +485,9 @@ static void orangefs_invalidate_folio(struct folio *folio,
 	orangefs_launder_folio(folio);
 }
 
-static int orangefs_releasepage(struct page *page, gfp_t foo)
+static bool orangefs_release_folio(struct folio *folio, gfp_t foo)
 {
-	return !PagePrivate(page);
+	return !folio_test_private(folio);
 }
 
 static void orangefs_freepage(struct page *page)
@@ -636,7 +636,7 @@ static const struct address_space_operations orangefs_address_operations = {
 	.write_begin = orangefs_write_begin,
 	.write_end = orangefs_write_end,
 	.invalidate_folio = orangefs_invalidate_folio,
-	.releasepage = orangefs_releasepage,
+	.release_folio = orangefs_release_folio,
 	.freepage = orangefs_freepage,
 	.launder_folio = orangefs_launder_folio,
 	.direct_IO = orangefs_direct_IO,
-- 
2.34.1

