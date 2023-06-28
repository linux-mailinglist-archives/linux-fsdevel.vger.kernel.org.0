Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C55374153D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 17:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjF1Pdn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 11:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbjF1PdF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:33:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3CB2D62;
        Wed, 28 Jun 2023 08:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=yQ5/EYqh6+7ElCFQh/cPZvm0jOmok7mMWkqAn5adj+Q=; b=GjOCK+Yk0gPnEnIK/bOhw0H4CU
        x+oK1pZnspyDScImnM0MHM++VFu/WzVLjafUF7cq3IGqRBWY+6khvsF9C6jCQo01TXYCf1TYeIj8I
        7qSTMESgU9htmvPzgy3PAuTFCrUHZ+00OyGumOyrNkk/OHZ/FLZ/6YmdSCjuGZzgYVtyXzwfNSOnN
        IoG45jUzpRgj/BkOA3c2sl3pvj3kZ6kpfecZtq3VTjdpHQCWOE6pSin0i7Pj843ZdR4fV1HlNaNyL
        lKe3lpUqlFrfvObEW5Vfm1cbpUpWgf+BMYhiJqFOL0w5FToDS0OwMabe0O1txjKQ201YaErqTn9+n
        KDx73vbA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qEXAE-00G0Hu-17;
        Wed, 28 Jun 2023 15:33:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 23/23] mm: remove folio_account_redirty
Date:   Wed, 28 Jun 2023 17:31:44 +0200
Message-Id: <20230628153144.22834-24-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230628153144.22834-1-hch@lst.de>
References: <20230628153144.22834-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fold folio_account_redirty into folio_redirty_for_writepage now
that all other users except for the also unused account_page_redirty
wrapper are gone.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/writeback.h |  5 ----
 mm/page-writeback.c       | 49 +++++++++++----------------------------
 2 files changed, 14 insertions(+), 40 deletions(-)

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index fba937999fbfd3..083387c00f0c8b 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -375,11 +375,6 @@ void tag_pages_for_writeback(struct address_space *mapping,
 			     pgoff_t start, pgoff_t end);
 
 bool filemap_dirty_folio(struct address_space *mapping, struct folio *folio);
-void folio_account_redirty(struct folio *folio);
-static inline void account_page_redirty(struct page *page)
-{
-	folio_account_redirty(page_folio(page));
-}
 bool folio_redirty_for_writepage(struct writeback_control *, struct folio *);
 bool redirty_page_for_writepage(struct writeback_control *, struct page *);
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index db794399900734..56074637ef4fe0 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -1193,7 +1193,7 @@ static void wb_update_write_bandwidth(struct bdi_writeback *wb,
 	 * write_bandwidth = ---------------------------------------------------
 	 *                                          period
 	 *
-	 * @written may have decreased due to folio_account_redirty().
+	 * @written may have decreased due to folio_redirty_for_writepage().
 	 * Avoid underflowing @bw calculation.
 	 */
 	bw = written - min(written, wb->written_stamp);
@@ -2709,37 +2709,6 @@ bool filemap_dirty_folio(struct address_space *mapping, struct folio *folio)
 }
 EXPORT_SYMBOL(filemap_dirty_folio);
 
-/**
- * folio_account_redirty - Manually account for redirtying a page.
- * @folio: The folio which is being redirtied.
- *
- * Most filesystems should call folio_redirty_for_writepage() instead
- * of this fuction.  If your filesystem is doing writeback outside the
- * context of a writeback_control(), it can call this when redirtying
- * a folio, to de-account the dirty counters (NR_DIRTIED, WB_DIRTIED,
- * tsk->nr_dirtied), so that they match the written counters (NR_WRITTEN,
- * WB_WRITTEN) in long term. The mismatches will lead to systematic errors
- * in balanced_dirty_ratelimit and the dirty pages position control.
- */
-void folio_account_redirty(struct folio *folio)
-{
-	struct address_space *mapping = folio->mapping;
-
-	if (mapping && mapping_can_writeback(mapping)) {
-		struct inode *inode = mapping->host;
-		struct bdi_writeback *wb;
-		struct wb_lock_cookie cookie = {};
-		long nr = folio_nr_pages(folio);
-
-		wb = unlocked_inode_to_wb_begin(inode, &cookie);
-		current->nr_dirtied -= nr;
-		node_stat_mod_folio(folio, NR_DIRTIED, -nr);
-		wb_stat_mod(wb, WB_DIRTIED, -nr);
-		unlocked_inode_to_wb_end(inode, &cookie);
-	}
-}
-EXPORT_SYMBOL(folio_account_redirty);
-
 /**
  * folio_redirty_for_writepage - Decline to write a dirty folio.
  * @wbc: The writeback control.
@@ -2755,13 +2724,23 @@ EXPORT_SYMBOL(folio_account_redirty);
 bool folio_redirty_for_writepage(struct writeback_control *wbc,
 		struct folio *folio)
 {
-	bool ret;
+	struct address_space *mapping = folio->mapping;
 	long nr = folio_nr_pages(folio);
+	bool ret;
 
 	wbc->pages_skipped += nr;
-	ret = filemap_dirty_folio(folio->mapping, folio);
-	folio_account_redirty(folio);
+	ret = filemap_dirty_folio(mapping, folio);
+	if (mapping && mapping_can_writeback(mapping)) {
+		struct inode *inode = mapping->host;
+		struct bdi_writeback *wb;
+		struct wb_lock_cookie cookie = {};
 
+		wb = unlocked_inode_to_wb_begin(inode, &cookie);
+		current->nr_dirtied -= nr;
+		node_stat_mod_folio(folio, NR_DIRTIED, -nr);
+		wb_stat_mod(wb, WB_DIRTIED, -nr);
+		unlocked_inode_to_wb_end(inode, &cookie);
+	}
 	return ret;
 }
 EXPORT_SYMBOL(folio_redirty_for_writepage);
-- 
2.39.2

