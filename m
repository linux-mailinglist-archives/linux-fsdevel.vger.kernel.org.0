Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF8251F199
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbiEHUiG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbiEHUhM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:37:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A0211A18
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=53gmpou/csAQtk0mDA4IcMIkTYMO4P94hi1K9vWouxk=; b=rQ+0o43aNqM2+eIKflX4VS9bJy
        9ZSORnSLYwNcbwXzvoJMYC+t9bmPfkN+JastcA/sqiI/0IUJde/neORMd+wPZ9ibHqbNRObsztE25
        rOBMAvuM9XPeDZ3nnWRRAqM+n0biPXbzIU3k2xS9q/O1dk1eDyKBBPWp9O0/feALY5/8mQyPikdaI
        uCRE+LhXeNm9WGruXyJ5NxCVLR6RVpxY0GlwKDAIPP+6yMsSywv2XS9sQHrM607d+mVbDnfb8s84o
        TS0erVlpWYUwB6SoRb1KhBLNfP/KqRxGWRjExrEvDonDUjoEhqaupxsAkRLt0csXH1tv2iC+00oHt
        d+4DOMeA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnaE-002o1q-JQ; Sun, 08 May 2022 20:32:50 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 14/26] jfs: Convert to release_folio
Date:   Sun,  8 May 2022 21:32:35 +0100
Message-Id: <20220508203247.668791-15-willy@infradead.org>
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

The use of folios should be pushed further down into jfs from here.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/jfs/jfs_metapage.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index 2fc78405b3f2..387652ae14c2 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -524,29 +524,29 @@ static int metapage_read_folio(struct file *fp, struct folio *folio)
 	return -EIO;
 }
 
-static int metapage_releasepage(struct page *page, gfp_t gfp_mask)
+static bool metapage_release_folio(struct folio *folio, gfp_t gfp_mask)
 {
 	struct metapage *mp;
-	int ret = 1;
+	bool ret = true;
 	int offset;
 
 	for (offset = 0; offset < PAGE_SIZE; offset += PSIZE) {
-		mp = page_to_mp(page, offset);
+		mp = page_to_mp(&folio->page, offset);
 
 		if (!mp)
 			continue;
 
-		jfs_info("metapage_releasepage: mp = 0x%p", mp);
+		jfs_info("metapage_release_folio: mp = 0x%p", mp);
 		if (mp->count || mp->nohomeok ||
 		    test_bit(META_dirty, &mp->flag)) {
 			jfs_info("count = %ld, nohomeok = %d", mp->count,
 				 mp->nohomeok);
-			ret = 0;
+			ret = false;
 			continue;
 		}
 		if (mp->lsn)
 			remove_from_logsync(mp);
-		remove_metapage(page, mp);
+		remove_metapage(&folio->page, mp);
 		INCREMENT(mpStat.pagefree);
 		free_metapage(mp);
 	}
@@ -560,13 +560,13 @@ static void metapage_invalidate_folio(struct folio *folio, size_t offset,
 
 	BUG_ON(folio_test_writeback(folio));
 
-	metapage_releasepage(&folio->page, 0);
+	metapage_release_folio(folio, 0);
 }
 
 const struct address_space_operations jfs_metapage_aops = {
 	.read_folio	= metapage_read_folio,
 	.writepage	= metapage_writepage,
-	.releasepage	= metapage_releasepage,
+	.release_folio	= metapage_release_folio,
 	.invalidate_folio = metapage_invalidate_folio,
 	.dirty_folio	= filemap_dirty_folio,
 };
-- 
2.34.1

