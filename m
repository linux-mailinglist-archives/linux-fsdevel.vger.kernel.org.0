Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29CA54AFE3C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbiBIUWz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:22:55 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbiBIUWZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C79EE039C65
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=9eBlgoTbDOoyCNeNyDCPyle9RUeQEB0ooNyxA3MqQuc=; b=h457csS6ktCrAgjWF3SzKOeLHX
        pQ22LtkEXwfZ3hCRz5GmMaVXZRhDXZABA7rn31Eqi9nfoAjtILwaL8VmwtQBt1rQ3fxvJpBMqNqUL
        xPBmuu/shoIKw0n5IXCYt6ZbBfyScX1Jaj7o1/WhM4R9xjwDLK/rAN9CeEQRhWE8Ya9q9UtRTUaw5
        X5GpCF76B8gcZbI/ceXxiJ2cIoLHHJOXr6M2bkTX/lBjycMAF1IAZAZu3QP7NqQthwjPgnBLLg6Yp
        3Vbs2xdfai5SujW0m7sHCWAO98RaWGuATY5SOJ1I9yyZISNbVD29i+JckudN6JfRiKKmPEhuI9UR4
        jWhHLQLw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTt-008cqc-9K; Wed, 09 Feb 2022 20:22:25 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 21/56] ceph: Convert from invalidatepage to invalidate_folio
Date:   Wed,  9 Feb 2022 20:21:40 +0000
Message-Id: <20220209202215.2055748-22-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209202215.2055748-1-willy@infradead.org>
References: <20220209202215.2055748-1-willy@infradead.org>
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

Mostly a straightforward conversion.  Delete the pointer from the
debugging output as this has no value.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ceph/addr.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 852ee161e8a4..09fd7a02586c 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -121,7 +121,7 @@ static int ceph_set_page_dirty(struct page *page)
 
 	/*
 	 * Reference snap context in page->private.  Also set
-	 * PagePrivate so that we get invalidatepage callback.
+	 * PagePrivate so that we get invalidate_folio callback.
 	 */
 	BUG_ON(PagePrivate(page));
 	attach_page_private(page, snapc);
@@ -130,37 +130,37 @@ static int ceph_set_page_dirty(struct page *page)
 }
 
 /*
- * If we are truncating the full page (i.e. offset == 0), adjust the
- * dirty page counters appropriately.  Only called if there is private
- * data on the page.
+ * If we are truncating the full folio (i.e. offset == 0), adjust the
+ * dirty folio counters appropriately.  Only called if there is private
+ * data on the folio.
  */
-static void ceph_invalidatepage(struct page *page, unsigned int offset,
-				unsigned int length)
+static void ceph_invalidate_folio(struct folio *folio, size_t offset,
+				size_t length)
 {
 	struct inode *inode;
 	struct ceph_inode_info *ci;
 	struct ceph_snap_context *snapc;
 
-	inode = page->mapping->host;
+	inode = folio->mapping->host;
 	ci = ceph_inode(inode);
 
-	if (offset != 0 || length != thp_size(page)) {
-		dout("%p invalidatepage %p idx %lu partial dirty page %u~%u\n",
-		     inode, page, page->index, offset, length);
+	if (offset != 0 || length != folio_size(folio)) {
+		dout("%p invalidate_folio idx %lu partial dirty page %zu~%zu\n",
+		     inode, folio->index, offset, length);
 		return;
 	}
 
-	WARN_ON(!PageLocked(page));
-	if (PagePrivate(page)) {
-		dout("%p invalidatepage %p idx %lu full dirty page\n",
-		     inode, page, page->index);
+	WARN_ON(!folio_test_locked(folio));
+	if (folio_get_private(folio)) {
+		dout("%p invalidate_folio idx %lu full dirty page\n",
+		     inode, folio->index);
 
-		snapc = detach_page_private(page);
+		snapc = folio_detach_private(folio);
 		ceph_put_wrbuffer_cap_refs(ci, 1, snapc);
 		ceph_put_snap_context(snapc);
 	}
 
-	wait_on_page_fscache(page);
+	folio_wait_fscache(folio);
 }
 
 static int ceph_releasepage(struct page *page, gfp_t gfp)
@@ -1377,7 +1377,7 @@ const struct address_space_operations ceph_aops = {
 	.write_begin = ceph_write_begin,
 	.write_end = ceph_write_end,
 	.set_page_dirty = ceph_set_page_dirty,
-	.invalidatepage = ceph_invalidatepage,
+	.invalidate_folio = ceph_invalidate_folio,
 	.releasepage = ceph_releasepage,
 	.direct_IO = noop_direct_IO,
 };
-- 
2.34.1

