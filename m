Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7411851F188
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiEHUiA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbiEHUgo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:36:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D629E11C1D
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=IuaDtuBdgHhMI+I3GGlIesMesfKFnTZwtEO6lEC7Slg=; b=r2/4y6yOEjKir2xSeHOj9o3KRc
        ka05Q97hUVBtK9FE9Wd9Jaj/2hEYS0olefCstFnusk03QnJT4MBqYCehvHOaQceodC5/udwl1UmDy
        qtZF90/4QC1x5HFtoc1nKjzcwbPNKj58kKjkiLzysYGXwtgTmkIlKFSTcoV+MwxswCLl0BUXk3dtr
        IkQJ0jltGzwb7K0+U9V5ZT6W1BoYzmdt4wrbo7HNDAg86ZcV2sZJ8+CLpVy2xaY1ijGqbinPApQyk
        o7/KwNjJDsxhHFCTdiayTuoy6gTrXKeU9lelQWYOpUFyAizns+GkioJV5GP10UrvO2qc0wGJXqngM
        TJFPz0Jw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnaD-002o1G-M5; Sun, 08 May 2022 20:32:49 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 07/26] cifs: Convert to release_folio
Date:   Sun,  8 May 2022 21:32:28 +0100
Message-Id: <20220508203247.668791-8-willy@infradead.org>
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

Use a folio throughout cifs_release_folio().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/cifs/file.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index bc6d88e2e672..06003bb9cbe9 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -4758,16 +4758,16 @@ static int cifs_write_begin(struct file *file, struct address_space *mapping,
 	return rc;
 }
 
-static int cifs_release_page(struct page *page, gfp_t gfp)
+static bool cifs_release_folio(struct folio *folio, gfp_t gfp)
 {
-	if (PagePrivate(page))
+	if (folio_test_private(folio))
 		return 0;
-	if (PageFsCache(page)) {
+	if (folio_test_fscache(folio)) {
 		if (current_is_kswapd() || !(gfp & __GFP_FS))
 			return false;
-		wait_on_page_fscache(page);
+		folio_wait_fscache(folio);
 	}
-	fscache_note_page_release(cifs_inode_cookie(page->mapping->host));
+	fscache_note_page_release(cifs_inode_cookie(folio->mapping->host));
 	return true;
 }
 
@@ -4973,7 +4973,7 @@ const struct address_space_operations cifs_addr_ops = {
 	.write_begin = cifs_write_begin,
 	.write_end = cifs_write_end,
 	.dirty_folio = cifs_dirty_folio,
-	.releasepage = cifs_release_page,
+	.release_folio = cifs_release_folio,
 	.direct_IO = cifs_direct_io,
 	.invalidate_folio = cifs_invalidate_folio,
 	.launder_folio = cifs_launder_folio,
@@ -4998,7 +4998,7 @@ const struct address_space_operations cifs_addr_ops_smallbuf = {
 	.write_begin = cifs_write_begin,
 	.write_end = cifs_write_end,
 	.dirty_folio = cifs_dirty_folio,
-	.releasepage = cifs_release_page,
+	.release_folio = cifs_release_folio,
 	.invalidate_folio = cifs_invalidate_folio,
 	.launder_folio = cifs_launder_folio,
 };
-- 
2.34.1

