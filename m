Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A28516A8B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 May 2022 07:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383439AbiEBGAh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 May 2022 02:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383382AbiEBGA1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 May 2022 02:00:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09071205E3
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 May 2022 22:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=N+nPZzQVU7ENkZ8MyrhlNkyUFrPUWPa52CLs4ArjSmw=; b=PK2m457z70AOKOj2QDD+n2VyHd
        0zFCwIAu9p8TxDEIITKLXkG4/8cVERLf7t1MVVqDPCh23qf+2aunWpCZkzUBHsvMqVUrJ91FiS3x+
        wc7oc36BKmN0nmBNrKB0f0uD53Hx2MMw5Z9CzTvoxjV5RNEcfMBE8JCCnTPVQxYz5iC9l6DKa7A+F
        oODLkdl+YOTy/JzMIJi+jsWfdL5qcVOycFLu+zu+2arZlVbsCpVeMOh/mI8zP1AQwIEEbhQiICrh5
        tGLv5sQKeJRgvdhgTLSImFUyn9LNWtFQ5yY+FY/vwY2x+OoP9HKBTJCqTMrO1pq2tREFHFPMLIo5R
        Mc7kFORw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlP2h-00EZWp-9x; Mon, 02 May 2022 05:56:19 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 18/26] orangefs: Convert to release_folio
Date:   Mon,  2 May 2022 06:56:06 +0100
Message-Id: <20220502055614.3473032-19-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220502055614.3473032-1-willy@infradead.org>
References: <20220502055614.3473032-1-willy@infradead.org>
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

