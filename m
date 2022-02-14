Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CBC4B5BD4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Feb 2022 22:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiBNUzE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 15:55:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiBNUyz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 15:54:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53421FA78
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Feb 2022 12:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Fzp7C16v2HDmAqsmLy5ntKGanYQxtjdNpkW0IzZ1aD8=; b=VQX7Q+575/EpFRQmAXEVGtk36M
        DE0TtELNkMCdY5fFN57uA8UYu/K99ZQ+ZNMFV06BbGVdz9fhhKR8RD1+USgBsGcvBsbLY7T13SlFx
        Q87kd41HrnIWDMOXsI6Zk+IlWlE9W84kots0ThOEhb9qU/+OvIAN4K5d+xN+4vxygYMAcnaFybdl6
        qD/jgODhcMG62sCuGGC4Ksm+duhtt/h1W1uSO15suOJa8/aLpfS0+isV+fO7YLUixqPVr4SJMadei
        H2Ey/zprmA6Ut1ATVbDNAWTwbI6+4RWf+Qxzd1YLjbJ9ur0k96GqsYFM/9jwhN/i2MhRCJRe72K7g
        jhCG9CsQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJhWG-00DDdy-Jj; Mon, 14 Feb 2022 20:00:20 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 07/10] mm/truncate: Convert __invalidate_mapping_pages() to use a folio
Date:   Mon, 14 Feb 2022 20:00:14 +0000
Message-Id: <20220214200017.3150590-8-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220214200017.3150590-1-willy@infradead.org>
References: <20220214200017.3150590-1-willy@infradead.org>
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

Now we can call mapping_shrink_folio() instead of invalidate_inode_page()
and save a few calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/truncate.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index b1bdc61198f6..567557c36d45 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -505,27 +505,27 @@ static unsigned long __invalidate_mapping_pages(struct address_space *mapping,
 	folio_batch_init(&fbatch);
 	while (find_lock_entries(mapping, index, end, &fbatch, indices)) {
 		for (i = 0; i < folio_batch_count(&fbatch); i++) {
-			struct page *page = &fbatch.folios[i]->page;
+			struct folio *folio = fbatch.folios[i];
 
-			/* We rely upon deletion not changing page->index */
+			/* We rely upon deletion not changing folio->index */
 			index = indices[i];
 
-			if (xa_is_value(page)) {
+			if (xa_is_value(folio)) {
 				count += invalidate_exceptional_entry(mapping,
 								      index,
-								      page);
+								      folio);
 				continue;
 			}
-			index += thp_nr_pages(page) - 1;
+			index += folio_nr_pages(folio) - 1;
 
-			ret = invalidate_inode_page(page);
-			unlock_page(page);
+			ret = mapping_shrink_folio(mapping, folio);
+			folio_unlock(folio);
 			/*
-			 * Invalidation is a hint that the page is no longer
+			 * Invalidation is a hint that the folio is no longer
 			 * of interest and try to speed up its reclaim.
 			 */
 			if (!ret) {
-				deactivate_file_page(page);
+				deactivate_file_page(&folio->page);
 				/* It is likely on the pagevec of a remote CPU */
 				if (nr_pagevec)
 					(*nr_pagevec)++;
-- 
2.34.1

