Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5F25151E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379645AbiD2R3t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379533AbiD2R3a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B09B9F3B4
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=O1t4085GeyAcPbSh9EMTxNvJaZKXVDwCSXz6nFjuqnI=; b=kBXcCWY1nMi2zzWBRHgzmoedWC
        kQvrzaM2RTq4M3Xd+h4Oml6FBfxhX7/veuwxWNNIxuZhKqafFgKAlKUGy6x+LbtVtdmvkuBT9DvaC
        G8G5fcO1XsXOe9vC0TBDjMxV35OBUogiAYUmJ01/6sps3f7nAGFy+DF/lAXT9oGs3dq8Cf3JJWUPe
        oH0Tx5HzoL7G4p8BrvxZv9CDgicC2eu4fikSnc+kBz0eThjMfJhou0pUxkFWrFUZRMJSx0kQD7/++
        vQE0o4FeWa+sj2IAJk5xWdOiMl1o4t2YokfamnzdxXBtwJkOog5HGa3pLhXTMW6CL+ZQTq4zxC1hp
        kYGZ3BfA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNZ-00CdZK-Is; Fri, 29 Apr 2022 17:26:05 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 28/69] filemap: Update the folio_mark_dirty documentation
Date:   Fri, 29 Apr 2022 18:25:15 +0100
Message-Id: <20220429172556.3011843-29-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220429172556.3011843-1-willy@infradead.org>
References: <20220429172556.3011843-1-willy@infradead.org>
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

