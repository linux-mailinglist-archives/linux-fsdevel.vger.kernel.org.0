Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B856C843D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 19:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbjCXSC6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 14:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbjCXSCS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:02:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46FD1DBA9;
        Fri, 24 Mar 2023 11:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=eq0Hn7DJEbMJVam2AiJQ2bZ34gX46DFpdYzh7SX7fJc=; b=gfPQj7CQaQb6F3Vf8qLxo+fTWk
        J0znFAL+IiNymV92Fj90QbCOYdxiQJhp7bPSMctzgtY516IU/kPNSxFTqCn6RiK5bOyWb27L7Ur/x
        /LA4GJYyU41UlWi3uuXSGcBVj3/cxuDaEQxZLvKH4XyH2IDaXCXK5pysld6grO33ygyPOyTjCe+XD
        G3zXGj//QFCDA9bSwupVouNVMyt9c1ag3cnfjGa2nPoMmhy7mC86839V9k6PSGlCmsZm3ZhCPhuqV
        dYUPTnNLCUzNMI4U2h9DLVFLTw+0Mmynbgzk0BhTGGf1PnYlbJR40t3tbQsLpCKjckQDUJZ0QqnWy
        BDxmVcnA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfljL-0057Yx-86; Fri, 24 Mar 2023 18:01:35 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 05/29] ext4: Turn mpage_process_page() into mpage_process_folio()
Date:   Fri, 24 Mar 2023 18:01:05 +0000
Message-Id: <20230324180129.1220691-6-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230324180129.1220691-1-willy@infradead.org>
References: <20230324180129.1220691-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The page/folio is only used to extract the buffers, so this is a
simple change.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/inode.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index eaeec84ec1b0..f8c02e55fbe3 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2022,21 +2022,22 @@ static int mpage_process_page_bufs(struct mpage_da_data *mpd,
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
@@ -2049,14 +2050,14 @@ static int mpage_process_page(struct mpage_da_data *mpd, struct page *page,
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
@@ -2129,9 +2130,9 @@ static int mpage_map_and_submit_buffers(struct mpage_da_data *mpd)
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
@@ -2141,10 +2142,10 @@ static int mpage_map_and_submit_buffers(struct mpage_da_data *mpd)
 			if (err < 0 || map_bh)
 				goto out;
 			/* Page fully mapped - let IO run! */
-			err = mpage_submit_page(mpd, page);
+			err = mpage_submit_page(mpd, &folio->page);
 			if (err < 0)
 				goto out;
-			mpage_page_done(mpd, page);
+			mpage_page_done(mpd, &folio->page);
 		}
 		folio_batch_release(&fbatch);
 	}
-- 
2.39.2

