Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057DC67D651
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 21:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbjAZUYx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 15:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbjAZUY3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:24:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DB64CE57;
        Thu, 26 Jan 2023 12:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=GDuQ6wQ/bfAds1LW0fa92iuTDGoEEIeE4XVRE+IKeFU=; b=SD5fRj4pO4RQr88pcufpYuq1Ee
        zaNRUubk0tBfj8BhRFGidDiF4vpjpxUSZNWdJiELEe+RR/hJUQ7hUixSKiciYdtyEnQvKBDtvYguB
        iReH10mrFyMmn9cnhC7e0XBx17rKenopPgqT71ynE9j4yEs+45zlMJz0/4X+WSMCkATuQpQaJSQSR
        UtbC81C75FsHAhWdzzhcCnzQB4lLGq4wlUhnuf4yDAxyxSEi4A1qvtQOfnj3FrtyNB+i/tciBumG/
        3Js3+0rRaqVtuMaGhmYUslDCZpPMSj8oCHAAmKhAop8E9SBQwUBiMjzeQG3TO1o1g54UJVaiOmZbG
        CzgBra2w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL8nC-0073jW-Vg; Thu, 26 Jan 2023 20:24:19 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Theodore Tso" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/31] ext4: Turn mpage_process_page() into mpage_process_folio()
Date:   Thu, 26 Jan 2023 20:23:50 +0000
Message-Id: <20230126202415.1682629-7-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230126202415.1682629-1-willy@infradead.org>
References: <20230126202415.1682629-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The page/folio is only used to extract the buffers, so this is a
simple change.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/inode.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 8e3d2cca1e0c..e8f2918fd854 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2250,21 +2250,22 @@ static int mpage_process_page_bufs(struct mpage_da_data *mpd,
 }
 
 /*
- * mpage_process_page - update page buffers corresponding to changed extent and
- *		       may submit fully mapped page for IO
- *
- * @mpd		- description of extent to map, on return next extent to map
- * @m_lblk	- logical block mapping.
- * @m_pblk	- corresponding physical mapping.
- * @map_bh	- determines on return whether this page requires any further
+ * mpage_process_folio - update folio buffers corresponding to changed extent
+ *			 and may submit fully mapped page for IO
+ * @mpd: description of extent to map, on return next extent to map
+ * @folio: Contains these buffers.
+ * @m_lblk: logical block mapping.
+ * @m_pblk: corresponding physical mapping.
+ * @map_bh: determines on return whether this page requires any further
  *		  mapping or not.
- * Scan given page buffers corresponding to changed extent and update buffer
+ *
+ * Scan given folio buffers corresponding to changed extent and update buffer
  * state according to new extent state.
  * We map delalloc buffers to their physical location, clear unwritten bits.
- * If the given page is not fully mapped, we update @map to the next extent in
- * the given page that needs mapping & return @map_bh as true.
+ * If the given folio is not fully mapped, we update @mpd to the next extent in
+ * the given folio that needs mapping & return @map_bh as true.
  */
-static int mpage_process_page(struct mpage_da_data *mpd, struct page *page,
+static int mpage_process_folio(struct mpage_da_data *mpd, struct folio *folio,
 			      ext4_lblk_t *m_lblk, ext4_fsblk_t *m_pblk,
 			      bool *map_bh)
 {
@@ -2277,14 +2278,14 @@ static int mpage_process_page(struct mpage_da_data *mpd, struct page *page,
 	ssize_t io_end_size = 0;
 	struct ext4_io_end_vec *io_end_vec = ext4_last_io_end_vec(io_end);
 
-	bh = head = page_buffers(page);
+	bh = head = folio_buffers(folio);
 	do {
 		if (lblk < mpd->map.m_lblk)
 			continue;
 		if (lblk >= mpd->map.m_lblk + mpd->map.m_len) {
 			/*
 			 * Buffer after end of mapped extent.
-			 * Find next buffer in the page to map.
+			 * Find next buffer in the folio to map.
 			 */
 			mpd->map.m_len = 0;
 			mpd->map.m_flags = 0;
@@ -2357,9 +2358,9 @@ static int mpage_map_and_submit_buffers(struct mpage_da_data *mpd)
 		if (nr == 0)
 			break;
 		for (i = 0; i < nr; i++) {
-			struct page *page = &fbatch.folios[i]->page;
+			struct folio *folio = fbatch.folios[i];
 
-			err = mpage_process_page(mpd, page, &lblk, &pblock,
+			err = mpage_process_folio(mpd, folio, &lblk, &pblock,
 						 &map_bh);
 			/*
 			 * If map_bh is true, means page may require further bh
@@ -2369,7 +2370,7 @@ static int mpage_map_and_submit_buffers(struct mpage_da_data *mpd)
 			if (err < 0 || map_bh)
 				goto out;
 			/* Page fully mapped - let IO run! */
-			err = mpage_submit_page(mpd, page);
+			err = mpage_submit_page(mpd, &folio->page);
 			if (err < 0)
 				goto out;
 		}
-- 
2.35.1

