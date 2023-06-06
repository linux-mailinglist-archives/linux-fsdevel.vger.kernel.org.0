Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9BA724FF5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 00:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239781AbjFFWfX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 18:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240115AbjFFWez (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 18:34:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A495B2688
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 15:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=+KgibMizZ6kh+XVrYZEwmKrqDA8XWXa+C/CbqtOPblI=; b=rxLV5yDgoXftMDazAaenImZ1qF
        BgVj5TscGNw2+Q2M1KZrmYxPeGc66BbkXslLk+WF/e+22t0klsANeRkO/Gj0P0cVB7HnXUzomZums
        D8geV3TANiivmIy9evXR2RpcwSRNbSsgrgh31OWmXIU7VSI0UQVZabmpnDY9c9LY5k5nMmZowsvyn
        Kr932kEVOiH4n8Ktg+NQWOuY+whV2uO97f3OX79utdQX50WBH9/yxaVWvmA5IzwZlToueQHpZkpLU
        hokt6PHqyLdTw86ahuoiq6dgR9akArw09MpmppfRxFJNC8400uQxIaZOL0oqoF+fUPcwu3yvH6gBL
        +MGU7UUw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q6fFU-00DbEb-NV; Tue, 06 Jun 2023 22:33:56 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        cluster-devel@redhat.com, Hannes Reinecke <hare@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Subject: [PATCH v2 02/14] gfs2: Pass a folio to __gfs2_jdata_write_folio()
Date:   Tue,  6 Jun 2023 23:33:34 +0100
Message-Id: <20230606223346.3241328-3-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230606223346.3241328-1-willy@infradead.org>
References: <20230606223346.3241328-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove a couple of folio->page conversions in the callers, and two
calls to compound_head() in the function itself.  Rename it from
__gfs2_jdata_writepage() to __gfs2_jdata_write_folio().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Tested-by: Bob Peterson <rpeterso@redhat.com>
Reviewed-by: Bob Peterson <rpeterso@redhat.com>
---
 fs/gfs2/aops.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 0518861df783..749135252d52 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -113,30 +113,31 @@ static int gfs2_write_jdata_page(struct page *page,
 }
 
 /**
- * __gfs2_jdata_writepage - The core of jdata writepage
- * @page: The page to write
+ * __gfs2_jdata_write_folio - The core of jdata writepage
+ * @folio: The folio to write
  * @wbc: The writeback control
  *
  * This is shared between writepage and writepages and implements the
  * core of the writepage operation. If a transaction is required then
- * PageChecked will have been set and the transaction will have
+ * the checked flag will have been set and the transaction will have
  * already been started before this is called.
  */
-
-static int __gfs2_jdata_writepage(struct page *page, struct writeback_control *wbc)
+static int __gfs2_jdata_write_folio(struct folio *folio,
+		struct writeback_control *wbc)
 {
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	struct gfs2_inode *ip = GFS2_I(inode);
 
-	if (PageChecked(page)) {
-		ClearPageChecked(page);
-		if (!page_has_buffers(page)) {
-			create_empty_buffers(page, inode->i_sb->s_blocksize,
-					     BIT(BH_Dirty)|BIT(BH_Uptodate));
+	if (folio_test_checked(folio)) {
+		folio_clear_checked(folio);
+		if (!folio_buffers(folio)) {
+			folio_create_empty_buffers(folio,
+					inode->i_sb->s_blocksize,
+					BIT(BH_Dirty)|BIT(BH_Uptodate));
 		}
-		gfs2_trans_add_databufs(ip, page_folio(page), 0, PAGE_SIZE);
+		gfs2_trans_add_databufs(ip, folio, 0, folio_size(folio));
 	}
-	return gfs2_write_jdata_page(page, wbc);
+	return gfs2_write_jdata_page(&folio->page, wbc);
 }
 
 /**
@@ -159,7 +160,7 @@ static int gfs2_jdata_writepage(struct page *page, struct writeback_control *wbc
 		goto out;
 	if (folio_test_checked(folio) || current->journal_info)
 		goto out_ignore;
-	return __gfs2_jdata_writepage(&folio->page, wbc);
+	return __gfs2_jdata_write_folio(folio, wbc);
 
 out_ignore:
 	folio_redirty_for_writepage(wbc, folio);
@@ -256,7 +257,7 @@ static int gfs2_write_jdata_batch(struct address_space *mapping,
 
 		trace_wbc_writepage(wbc, inode_to_bdi(inode));
 
-		ret = __gfs2_jdata_writepage(&folio->page, wbc);
+		ret = __gfs2_jdata_write_folio(folio, wbc);
 		if (unlikely(ret)) {
 			if (ret == AOP_WRITEPAGE_ACTIVATE) {
 				folio_unlock(folio);
-- 
2.39.2

