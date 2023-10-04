Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B1A7B85DE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 18:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243427AbjJDQyN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 12:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243573AbjJDQyJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:54:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59472114;
        Wed,  4 Oct 2023 09:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=5DKdxAyadRWDMiaslNEJr4yDpo8DKXMNV0hB6QcBBkM=; b=RYa3D/dVz/0wGHfevaGhpqecso
        oT/Olzw7bs2m/lGKXPnZgBQatCf8z7bbcJjMtVfb0rXmyId6jA7S52FGGUqnby6PARrrczH/tB+vq
        We8hxsnFlycmu3R+t9Hg+VA4GM8ODiAUa7NU9DLjpuEbw/0AZ/iezCzuzB9+HkzTs3GrLbqbefqdz
        FjnB4rMgOWGRfIMh3v+2asasqkmqjO6UKVDTIjqqQ0D5VUKk1n+87VHmoGUUb67cVpiXOCZdSiMUp
        mQAZqJAfG8Mo6maQNsXErIyaMjGeLDbbjBrqxR0eyXp59QLdFngcX8oNVmFosewRlKa6F7HDj/h9a
        DAi5gaWw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qo57f-004SF3-GH; Wed, 04 Oct 2023 16:53:19 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, torvalds@linux-foundation.org,
        npiggin@gmail.com
Subject: [PATCH v2 05/17] buffer: Use folio_end_read()
Date:   Wed,  4 Oct 2023 17:53:05 +0100
Message-Id: <20231004165317.1061855-6-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231004165317.1061855-1-willy@infradead.org>
References: <20231004165317.1061855-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There are two places that we can use this new helper.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 12e9a71c693d..b7bafba87273 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -282,13 +282,7 @@ static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
 	} while (tmp != bh);
 	spin_unlock_irqrestore(&first->b_uptodate_lock, flags);
 
-	/*
-	 * If all of the buffers are uptodate then we can set the page
-	 * uptodate.
-	 */
-	if (folio_uptodate)
-		folio_mark_uptodate(folio);
-	folio_unlock(folio);
+	folio_end_read(folio, folio_uptodate);
 	return;
 
 still_busy:
@@ -2425,12 +2419,10 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
 
 	if (!nr) {
 		/*
-		 * All buffers are uptodate - we can set the folio uptodate
-		 * as well. But not if get_block() returned an error.
+		 * All buffers are uptodate or get_block() returned an
+		 * error when trying to map them - we can finish the read.
 		 */
-		if (!page_error)
-			folio_mark_uptodate(folio);
-		folio_unlock(folio);
+		folio_end_read(folio, !page_error);
 		return 0;
 	}
 
-- 
2.40.1

