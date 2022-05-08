Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEF851F198
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbiEHUiD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbiEHUhG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:37:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B2711C3C
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=eh6xgDdWf177qaxfMODvgKL5UEDIhv0WN38TTsndXvg=; b=psnF1q+XMR1EECfPlWAVOt5sGy
        ZW+k8Fu3w+zOJEoH0IyP3syDuLpSIN84x7JiNFh8wjFhzKUWio4TM0Dp40fmSr6WSuhtko33aTgHJ
        7QucVSA44KIAuYUOWb2lZABzqHyBrveeJoWAeV/wG5ZEfTFhAQB0XKilOsXWSTYXk4xYsyQ/sBH3H
        Z2AXNGg90Pqknf/+33qg7B/eTfJspPz0/ibCZreXtNgKNm24Kc4w6/hgdFJtlPYtk0Anc+nmH9ElQ
        5A+1ONtBznLXvVgaYn9DZCoynEk4/E8UXWCxkRcapATP7DNyNoDj6uhZqwNVxlWlQ3zw4McGB4/G7
        Hnl94XVg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnaG-002o3E-6o; Sun, 08 May 2022 20:32:52 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 26/26] fs: Convert drop_buffers() to use a folio
Date:   Sun,  8 May 2022 21:32:47 +0100
Message-Id: <20220508203247.668791-27-willy@infradead.org>
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

All callers now have a folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 701af0035802..898c7f301b1b 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -3180,10 +3180,10 @@ static inline int buffer_busy(struct buffer_head *bh)
 		(bh->b_state & ((1 << BH_Dirty) | (1 << BH_Lock)));
 }
 
-static int
-drop_buffers(struct page *page, struct buffer_head **buffers_to_free)
+static bool
+drop_buffers(struct folio *folio, struct buffer_head **buffers_to_free)
 {
-	struct buffer_head *head = page_buffers(page);
+	struct buffer_head *head = folio_buffers(folio);
 	struct buffer_head *bh;
 
 	bh = head;
@@ -3201,10 +3201,10 @@ drop_buffers(struct page *page, struct buffer_head **buffers_to_free)
 		bh = next;
 	} while (bh != head);
 	*buffers_to_free = head;
-	detach_page_private(page);
-	return 1;
+	folio_detach_private(folio);
+	return true;
 failed:
-	return 0;
+	return false;
 }
 
 bool try_to_free_buffers(struct folio *folio)
@@ -3218,12 +3218,12 @@ bool try_to_free_buffers(struct folio *folio)
 		return false;
 
 	if (mapping == NULL) {		/* can this still happen? */
-		ret = drop_buffers(&folio->page, &buffers_to_free);
+		ret = drop_buffers(folio, &buffers_to_free);
 		goto out;
 	}
 
 	spin_lock(&mapping->private_lock);
-	ret = drop_buffers(&folio->page, &buffers_to_free);
+	ret = drop_buffers(folio, &buffers_to_free);
 
 	/*
 	 * If the filesystem writes its buffers by hand (eg ext3)
-- 
2.34.1

