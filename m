Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797F151F19E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbiEHUjz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbiEHUhd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:37:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536571262A
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=FpiLvC94zRiMjUAFPAiLyW4U+7bsS7REW/uc69eDO0M=; b=DwP8UHbIyDNkK8YO6SzAoThxhE
        6wV+ee1fZQdBt4y5XN9SVfbKJSLZxJST23RfHJqHhj8gzCUXRtlUiGns4M1ehCx6jdUhFU447dDMu
        KKYwPCDY7PgvbtTi/YWcLwYuNtkFUV5qgnl51tRyTrggu6K62niCUdUoV97Xu+9CbCvCjsn3ma10c
        hrHrOzoY7HtrpK8qygpRE+wn3JfP+7IaM3iv5xp4YvxCVx/KXXOXg3YGtbchGb+A2PfiqD/QGUYHk
        hl7DpGPFI3qjkxkBRO9WYlBpRC8MoBnF3X57tp7nzo9PxalU6Abntn9Lmd8uiAo2dVD1nqccugdoM
        YUjpobcw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnaT-002o6Y-0W; Sun, 08 May 2022 20:33:05 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 2/5] orangefs: Convert to free_folio
Date:   Sun,  8 May 2022 21:32:58 +0100
Message-Id: <20220508203301.669147-3-willy@infradead.org>
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

I suspect this isn't actually needed and that releasepage will have
done the job, but convert it for now and we can delete it later.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/orangefs/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 3509618e7b37..5ce27dde3c79 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -490,9 +490,9 @@ static bool orangefs_release_folio(struct folio *folio, gfp_t foo)
 	return !folio_test_private(folio);
 }
 
-static void orangefs_freepage(struct page *page)
+static void orangefs_free_folio(struct folio *folio)
 {
-	kfree(detach_page_private(page));
+	kfree(folio_detach_private(folio));
 }
 
 static int orangefs_launder_folio(struct folio *folio)
@@ -637,7 +637,7 @@ static const struct address_space_operations orangefs_address_operations = {
 	.write_end = orangefs_write_end,
 	.invalidate_folio = orangefs_invalidate_folio,
 	.release_folio = orangefs_release_folio,
-	.freepage = orangefs_freepage,
+	.free_folio = orangefs_free_folio,
 	.launder_folio = orangefs_launder_folio,
 	.direct_IO = orangefs_direct_IO,
 };
-- 
2.34.1

