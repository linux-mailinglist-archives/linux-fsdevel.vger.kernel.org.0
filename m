Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9E57B85DB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 18:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243611AbjJDQyL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 12:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243551AbjJDQxh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:53:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B646DD;
        Wed,  4 Oct 2023 09:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=KV8LjVnp8SrGIYzPBzTmbRSPvfzlFJYoh9EV/UdX1VU=; b=XKrwcSOWaQs6f+lvNnjqWsQNeA
        tgWGSVcwUcSUK+ppxTN6wCxuM6QU4zpdWpMiV6KVrIp0r98Vydm6CI9x3+M231XCLbvBHeUsTq1Ls
        +eZkvGGQwfurJSHA3nMDjyfvsg3VWB1w7Wx3V3DziFeKyn/pTJoHxUMnw/Y0g1ZbGCod0NlutrX1u
        figIDtFZopRavwvsxs9+1eC5eeKlB+YwkNGYdG+6yHXeWhuaeNGxlKiTUBIQrV/JCqNxwxPBkUPJ4
        ygOewt9UVPVSMnaPp9qvSI+NvRcESnTW6dPLxrxNb6Il9rZ36q3vUjsCZiCcnR1NwTo+eprsm+LCY
        ab+q/3Xg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qo57f-004SEt-6o; Wed, 04 Oct 2023 16:53:19 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, torvalds@linux-foundation.org,
        npiggin@gmail.com
Subject: [PATCH v2 01/17] iomap: Hold state_lock over call to ifs_set_range_uptodate()
Date:   Wed,  4 Oct 2023 17:53:01 +0100
Message-Id: <20231004165317.1061855-2-willy@infradead.org>
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

This is really preparation for the next patch, but it lets us call
folio_mark_uptodate() in just one place instead of two.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 5db54ca29a35..6e780ca64ce3 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -57,30 +57,32 @@ static inline bool ifs_block_is_uptodate(struct iomap_folio_state *ifs,
 	return test_bit(block, ifs->state);
 }
 
-static void ifs_set_range_uptodate(struct folio *folio,
+static bool ifs_set_range_uptodate(struct folio *folio,
 		struct iomap_folio_state *ifs, size_t off, size_t len)
 {
 	struct inode *inode = folio->mapping->host;
 	unsigned int first_blk = off >> inode->i_blkbits;
 	unsigned int last_blk = (off + len - 1) >> inode->i_blkbits;
 	unsigned int nr_blks = last_blk - first_blk + 1;
-	unsigned long flags;
 
-	spin_lock_irqsave(&ifs->state_lock, flags);
 	bitmap_set(ifs->state, first_blk, nr_blks);
-	if (ifs_is_fully_uptodate(folio, ifs))
-		folio_mark_uptodate(folio);
-	spin_unlock_irqrestore(&ifs->state_lock, flags);
+	return ifs_is_fully_uptodate(folio, ifs);
 }
 
 static void iomap_set_range_uptodate(struct folio *folio, size_t off,
 		size_t len)
 {
 	struct iomap_folio_state *ifs = folio->private;
+	unsigned long flags;
+	bool uptodate = true;
 
-	if (ifs)
-		ifs_set_range_uptodate(folio, ifs, off, len);
-	else
+	if (ifs) {
+		spin_lock_irqsave(&ifs->state_lock, flags);
+		uptodate = ifs_set_range_uptodate(folio, ifs, off, len);
+		spin_unlock_irqrestore(&ifs->state_lock, flags);
+	}
+
+	if (uptodate)
 		folio_mark_uptodate(folio);
 }
 
-- 
2.40.1

