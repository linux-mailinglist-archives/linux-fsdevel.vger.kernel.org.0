Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00C264E368
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Dec 2022 22:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiLOVoI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Dec 2022 16:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiLOVoE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Dec 2022 16:44:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221095C760
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Dec 2022 13:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=khJQ00oVdRi4Ce9uKr3QlH6vu2l+5ozsXEuEfKPCRzE=; b=jHNjcLMrc10jhoazTapdMyn5OJ
        nsOq5fpnYGvbpimYAi2Pmkv+1JYJ98lGaQf3xVWhZx4rInsQ0yeVPcT2aSQfKghkcmE2C6FYYvU58
        HP6cnbA6+S4nJr/NJjlV2/BELo86wWtJx0Z5HPsswuuTNjaXM+SbY7vijoK3cLPKwpIQL0DiBi8sv
        Bi/rwaUiPat6BLfFnspMt8G4ydXxjsW0bRH+u2Q8cOufXctwTzDUy7W5yTH9T/UMGZtJvmlqmz6Uh
        ehddLXdODTU39Lk45ISndAyD9CJpO4mjcKDWYjSDmyqy2F48s9Dkit4PBPKXmlxwG5nOv9pUD/8ID
        FG4hZB0g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p5w1O-00EmL8-4p; Thu, 15 Dec 2022 21:44:06 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 01/12] buffer: Add b_folio as an alias of b_page
Date:   Thu, 15 Dec 2022 21:43:51 +0000
Message-Id: <20221215214402.3522366-2-willy@infradead.org>
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

Buffer heads point to the allocation (ie the folio), not the page.
This is currently the same thing for all filesystems that use buffer
heads, so this is a safe transitional step.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/buffer_head.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 33fa5e94aa80..8f14dca5fed7 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -61,7 +61,10 @@ typedef void (bh_end_io_t)(struct buffer_head *bh, int uptodate);
 struct buffer_head {
 	unsigned long b_state;		/* buffer state bitmap (see above) */
 	struct buffer_head *b_this_page;/* circular list of page's buffers */
-	struct page *b_page;		/* the page this bh is mapped to */
+	union {
+		struct page *b_page;	/* the page this bh is mapped to */
+		struct folio *b_folio;	/* the folio this bh is mapped to */
+	};
 
 	sector_t b_blocknr;		/* start block number */
 	size_t b_size;			/* size of mapping */
-- 
2.35.1

