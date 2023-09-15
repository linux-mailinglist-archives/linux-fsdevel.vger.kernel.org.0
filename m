Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A947E7A25F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 20:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236588AbjIOShv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 14:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236509AbjIOSh3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:37:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C487115;
        Fri, 15 Sep 2023 11:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=5PWa8bY4dekYeG890jHuH5+xQm9Lpc2bhtlqgPaBIx8=; b=m1Ryp53inYiFotTtBpCrbEJqhU
        mqeis08LHa2btJKQJ+ja28v2D+DIGo1PD25gPHrnN9TPG1PJSfbMS61hIUlhlstpyTQjIqdgbftjX
        PKnvMQthLiws4zgTBgwNPqwd44Jw2/kSpPLzxZVrlIQ8rgj/8mygtAqjlOPT02FIi3ho27qCUtDV/
        sLH8hK+zALH4dBoBCo0Mzh3R1xo9jq3RggHQM6urHIgvQ7FipCt0e/C6ufa3pb1CRKC48NeCwtADq
        lbN8JXJvVC4a8Xir81JjqXJ8YoGXWIm1YAzIINL4KbLWtMac+XL7H+tLJLi1Ob4XZUQIgjS2ewfGY
        FaeKtW4w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qhDgj-00BMIN-3p; Fri, 15 Sep 2023 18:37:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        torvalds@linux-foundation.org, Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 01/17] iomap: Hold state_lock over call to ifs_set_range_uptodate()
Date:   Fri, 15 Sep 2023 19:36:51 +0100
Message-Id: <20230915183707.2707298-2-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230915183707.2707298-1-willy@infradead.org>
References: <20230915183707.2707298-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
index ae8673ce08b1..4c05fd457ee7 100644
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

