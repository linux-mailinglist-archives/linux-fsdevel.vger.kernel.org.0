Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BE7661E52
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 06:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbjAIFSU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 00:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjAIFSS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 00:18:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEEACE16;
        Sun,  8 Jan 2023 21:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=20JVe/q5nqvxBF2DQBmPeH9KaV31rTvIVcnyqDD6QmU=; b=tx0zFFcHpu3W2ppNLSOI9B5Sz+
        xd91xrR9fMh4Z6dRVmSBn0jkXtna1ZZDZn0uFhvE6MiSIlY8+hIE0Lrio1bwW+2uWiaiMwb/Wpsd6
        zJ8jSC2IElx3hY6ACHIcBjHn5xFGDTdpUCYWPxzpWl+sZ3GaZrI8u759dIKXifFdjiQM8gCO3a2nD
        JiCbF9/p1SucWAF0/taqy5CyWt3rpIpVpekZy0IdnRdWprkiL8MqmcxZn2XHNo1NIrzvk9pui+NL5
        TK+MByXCi2QINbqO4iSHVv7NTJS/A9pOe9xQJ+MR5d0PJly663FCWwH722+gI7EaL+Ab+Hdq4zj07
        OEHsN6BA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pEkYD-0020wy-CL; Mon, 09 Jan 2023 05:18:25 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jeff Layton <jlayton@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 05/11] page-writeback: Convert folio_write_one() to use an errseq
Date:   Mon,  9 Jan 2023 05:18:17 +0000
Message-Id: <20230109051823.480289-6-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230109051823.480289-1-willy@infradead.org>
References: <20230109051823.480289-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the errseq infrastructure to detect an error due to writing
back this folio instead of the old error checking code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/page-writeback.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index ad608ef2a243..491b70dad994 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2610,15 +2610,12 @@ int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
  *
  * The folio must be locked by the caller and will be unlocked upon return.
  *
- * Note that the mapping's AS_EIO/AS_ENOSPC flags will be cleared when this
- * function returns.
- *
  * Return: %0 on success, negative error code otherwise
  */
 int folio_write_one(struct folio *folio)
 {
 	struct address_space *mapping = folio->mapping;
-	int ret = 0;
+	int err = 0;
 	struct writeback_control wbc = {
 		.sync_mode = WB_SYNC_ALL,
 		.nr_to_write = folio_nr_pages(folio),
@@ -2629,18 +2626,20 @@ int folio_write_one(struct folio *folio)
 	folio_wait_writeback(folio);
 
 	if (folio_clear_dirty_for_io(folio)) {
+		errseq_t since = filemap_sample_wb_err(mapping);
+
 		folio_get(folio);
-		ret = mapping->a_ops->writepage(&folio->page, &wbc);
-		if (ret == 0)
+		err = mapping->a_ops->writepage(&folio->page, &wbc);
+		if (!err) {
 			folio_wait_writeback(folio);
+			err = filemap_check_wb_err(mapping, since);
+		}
 		folio_put(folio);
 	} else {
 		folio_unlock(folio);
 	}
 
-	if (!ret)
-		ret = filemap_check_errors(mapping);
-	return ret;
+	return err;
 }
 EXPORT_SYMBOL(folio_write_one);
 
-- 
2.35.1

