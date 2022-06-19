Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6E8550B6A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jun 2022 17:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbiFSPL5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jun 2022 11:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbiFSPLv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jun 2022 11:11:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86B6AE56;
        Sun, 19 Jun 2022 08:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=bindIO2lTFDesoOeQ2oViKfEfCZlyJ8TfNVBigsijEU=; b=LFYmATCu1fX3l78jDNbK+xhNAo
        DcgucQf7ONWKGyPqRpVHlCUmhmynjxiGS9VGyA6neq2L8jTOMjkb8NmhEArLoabLJyWsGC/xSVtED
        xy+pBQ314fj/6ws20wk/YlffE786PNkPua4pe8DEjyJZ9tnsH9+7u7aeI5n/RU5fi3XX14U8m8nm4
        vEZTIuOjcuFbBJ2gYgAGkq0Z7nv2OnusSgNwE5KLogbSvK26zxBKPyr7N+Gi29o2dOlu+YI9Wh+da
        umaqTxE5cd3nfTrioNl1gqhwSBpRuJQ/I1gnYIgkaB6BL0re7iafEHA8ZSMPizsETgpK4pM3L2LJz
        W5Bd5m+w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o2waZ-004QOq-3d; Sun, 19 Jun 2022 15:11:47 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, Yu Kuai <yukuai3@huawei.com>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 1/3] filemap: Correct the conditions for marking a folio as accessed
Date:   Sun, 19 Jun 2022 16:11:41 +0100
Message-Id: <20220619151143.1054746-2-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220619151143.1054746-1-willy@infradead.org>
References: <20220619151143.1054746-1-willy@infradead.org>
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

We had an off-by-one error which meant that we never marked the first page
in a read as accessed.  This was visible as a slowdown when re-reading
a file as pages were being evicted from cache too soon.  In reviewing
this code, we noticed a second bug where a multi-page folio would be
marked as accessed multiple times when doing reads that were less than
the size of the folio.

Abstract the comparison of whether two file positions are in the same
folio into a new function, fixing both of these bugs.

Reported-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index ac3775c1ce4c..577068868449 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2629,6 +2629,13 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 	return err;
 }
 
+static inline bool pos_same_folio(loff_t pos1, loff_t pos2, struct folio *folio)
+{
+	unsigned int shift = folio_shift(folio);
+
+	return (pos1 >> shift == pos2 >> shift);
+}
+
 /**
  * filemap_read - Read data from the page cache.
  * @iocb: The iocb to read.
@@ -2700,11 +2707,11 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 		writably_mapped = mapping_writably_mapped(mapping);
 
 		/*
-		 * When a sequential read accesses a page several times, only
+		 * When a read accesses the same folio several times, only
 		 * mark it as accessed the first time.
 		 */
-		if (iocb->ki_pos >> PAGE_SHIFT !=
-		    ra->prev_pos >> PAGE_SHIFT)
+		if (!pos_same_folio(iocb->ki_pos, ra->prev_pos - 1,
+							fbatch.folios[0]))
 			folio_mark_accessed(fbatch.folios[0]);
 
 		for (i = 0; i < folio_batch_count(&fbatch); i++) {
-- 
2.35.1

