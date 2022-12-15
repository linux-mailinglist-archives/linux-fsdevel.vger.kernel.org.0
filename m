Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94F164E370
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Dec 2022 22:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiLOVoT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Dec 2022 16:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiLOVoE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Dec 2022 16:44:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EDE5C750
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Dec 2022 13:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=XNtV03kYWqvwcuI+GKUmwm+3ChSXjAfg0Z+REe98p9g=; b=SjHy+LTeV2i/8sohLzrV2N1IZx
        6WjXcDY8Ld5Z3/DHuFR0FKmUvyyi0DRCmHwUfs0XxjoUxklBRUN3R+4w3mTQ7R16Kb4e55PiJ7pxp
        i5vmnWpTQtC4/gYNfgK85bUcl8iTOmLd1b0AFl6oCKKJ/a2fZIWgOjYVwjE0M17P+hrZ7WvT/q6lZ
        1GjYIWBBPlpKaSdaqgtPQWu5soFqbo6rFvVUuN0QgVDHNqHR/UUGqdxJD3USlAxdgwW2ZpZk7HXBp
        y0IpDhUD2G8vtMFwlMB9OHaSVDWGThPOKinVtsIWo1AY3dyPMOAHmTWXu3zGZc69RFitYe6TLBLHS
        8hZqcQLQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p5w1O-00EmLW-LO; Thu, 15 Dec 2022 21:44:06 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/12] buffer: Use b_folio in end_buffer_async_write()
Date:   Thu, 15 Dec 2022 21:43:55 +0000
Message-Id: <20221215214402.3522366-6-willy@infradead.org>
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

Save 76 bytes from avoiding the call to compound_head() in SetPageError().
Also avoid the call to compound_head() in end_page_writeback().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 5bdcc040eca3..c44ca40530c3 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -344,21 +344,21 @@ void end_buffer_async_write(struct buffer_head *bh, int uptodate)
 	unsigned long flags;
 	struct buffer_head *first;
 	struct buffer_head *tmp;
-	struct page *page;
+	struct folio *folio;
 
 	BUG_ON(!buffer_async_write(bh));
 
-	page = bh->b_page;
+	folio = bh->b_folio;
 	if (uptodate) {
 		set_buffer_uptodate(bh);
 	} else {
 		buffer_io_error(bh, ", lost async page write");
 		mark_buffer_write_io_error(bh);
 		clear_buffer_uptodate(bh);
-		SetPageError(page);
+		folio_set_error(folio);
 	}
 
-	first = page_buffers(page);
+	first = folio_buffers(folio);
 	spin_lock_irqsave(&first->b_uptodate_lock, flags);
 
 	clear_buffer_async_write(bh);
@@ -372,7 +372,7 @@ void end_buffer_async_write(struct buffer_head *bh, int uptodate)
 		tmp = tmp->b_this_page;
 	}
 	spin_unlock_irqrestore(&first->b_uptodate_lock, flags);
-	end_page_writeback(page);
+	folio_end_writeback(folio);
 	return;
 
 still_busy:
-- 
2.35.1

