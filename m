Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08464AFE33
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbiBIUWe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:22:34 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbiBIUWX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95D6E03AE4C
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=2aR8CUpJB9aZOBGHaTvwYsHklV4ennjk8houMF4jkgo=; b=bRZsxuc7UOj43CpGRQMAO0FNT9
        CJK7KItEWAMV6umUraP/47b1f/ucGNXBLrqxZw3FU+E33dO1kdXvcgYrmbEOc3nr26gGSDFh4GQGu
        ozR4iANCwytNhnh0XpbIhAdTVTAdZvAqFRlsl7uX6fBBkrUCj6KujS9t2znt124dgqXEwXZ+8Q7xC
        2k3yRHCrVBuf9THEN7UP2uFW2U+qHGe84a9RPS/pbftajlEP7FUhBx55eS69ZkNIRE1GAljBaWXjv
        8TUOezdZ/5up0Tj8rwUzed1OBWjM+Oy9gF8NHwcv2jFjPJfMJlsIrZAg08QWio/U9GdFNx9bs89+q
        i0NK2yIA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTs-008cpj-0q; Wed, 09 Feb 2022 20:22:24 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 11/56] ceph: Use folio_invalidate()
Date:   Wed,  9 Feb 2022 20:21:30 +0000
Message-Id: <20220209202215.2055748-12-willy@infradead.org>
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

Instead of calling ->invalidatepage directly, use folio_invalidate().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ceph/addr.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index c98e5238a1b6..852ee161e8a4 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -516,6 +516,7 @@ static u64 get_writepages_data_length(struct inode *inode,
  */
 static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 {
+	struct folio *folio = page_folio(page);
 	struct inode *inode = page->mapping->host;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
@@ -550,8 +551,9 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 
 	/* is this a partial page at end of file? */
 	if (page_off >= ceph_wbc.i_size) {
-		dout("%p page eof %llu\n", page, ceph_wbc.i_size);
-		page->mapping->a_ops->invalidatepage(page, 0, thp_size(page));
+		dout("folio at %lu beyond eof %llu\n", folio->index,
+				ceph_wbc.i_size);
+		folio_invalidate(folio, 0, folio_size(folio));
 		return 0;
 	}
 
@@ -867,14 +869,16 @@ static int ceph_writepages_start(struct address_space *mapping,
 				continue;
 			}
 			if (page_offset(page) >= ceph_wbc.i_size) {
-				dout("%p page eof %llu\n",
-				     page, ceph_wbc.i_size);
+				struct folio *folio = page_folio(page);
+
+				dout("folio at %lu beyond eof %llu\n",
+				     folio->index, ceph_wbc.i_size);
 				if ((ceph_wbc.size_stable ||
-				    page_offset(page) >= i_size_read(inode)) &&
-				    clear_page_dirty_for_io(page))
-					mapping->a_ops->invalidatepage(page,
-								0, thp_size(page));
-				unlock_page(page);
+				    folio_pos(folio) >= i_size_read(inode)) &&
+				    folio_clear_dirty_for_io(folio))
+					folio_invalidate(folio, 0,
+							folio_size(folio));
+				folio_unlock(folio);
 				continue;
 			}
 			if (strip_unit_end && (page->index > strip_unit_end)) {
-- 
2.34.1

