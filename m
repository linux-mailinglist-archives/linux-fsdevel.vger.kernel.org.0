Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7EC51F144
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbiEHUfT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbiEHUfA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:35:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2928110FCE
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=O1t4085GeyAcPbSh9EMTxNvJaZKXVDwCSXz6nFjuqnI=; b=Os0+TkWWU1R9ravRpGD9MmrAgf
        z4hLTYGO28fZ67OhFP91o0Ysp0NVk7aDjOzUDgCJY5/7D7/Pr5gE7hMWKyqPVpVvrQRpP09I9Dy2h
        pUab2BPF6m39S06vv7y8mnU/tgsa2tFW3tDjJzP0KpWz39LM3eopbhs+7x1ESVXvI0kGAM/Q25kEC
        HMd26FcOVEs1XpJFD4mAtLdO4En5X9BZieGndVUdPBIijiV87RJUourSsIIzIpMoZu17gNIUNDaOv
        RzPYxAzxss6vgMXlxdRY1ijHYCp/F5eTPGiNFf5C/EbGoPeRTUCHPOraJBUDQsOi5gvu7M4EK0vEc
        oucbyY+w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnYL-002ni6-FZ; Sun, 08 May 2022 20:30:53 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 3/3] filemap: Update the folio_mark_dirty documentation
Date:   Sun,  8 May 2022 21:30:48 +0100
Message-Id: <20220508203048.667631-4-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508203048.667631-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203048.667631-1-willy@infradead.org>
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

The previous comment was not terribly helpful.  Be a bit more explicit
about the necessary locking environment.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/page-writeback.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 7e2da284e427..fa1117db4610 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2602,10 +2602,12 @@ EXPORT_SYMBOL(folio_redirty_for_writepage);
  * folio_mark_dirty - Mark a folio as being modified.
  * @folio: The folio.
  *
- * For folios with a mapping this should be done with the folio lock held
- * for the benefit of asynchronous memory errors who prefer a consistent
- * dirty state. This rule can be broken in some special cases,
- * but should be better not to.
+ * The folio may not be truncated while this function is running.
+ * Holding the folio lock is sufficient to prevent truncation, but some
+ * callers cannot acquire a sleeping lock.  These callers instead hold
+ * the page table lock for a page table which contains at least one page
+ * in this folio.  Truncation will block on the page table lock as it
+ * unmaps pages before removing the folio from its mapping.
  *
  * Return: True if the folio was newly dirtied, false if it was already dirty.
  */
-- 
2.34.1

