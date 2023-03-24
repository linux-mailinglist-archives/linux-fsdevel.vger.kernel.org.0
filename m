Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9A96C8435
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 19:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbjCXSCf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 14:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbjCXSCS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:02:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F471DB99;
        Fri, 24 Mar 2023 11:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=bs3xrjvX4v/ttHgYVN7mKJRaPa8APMFbgY3eeHF20gw=; b=dlQZOzY7gUtaNmSE30xiFivm4z
        R6f45V0Ff3o/qEmchXic4OKSLrGxEr1e38TB9mhnSEl3dpfaQf8i1V7gU2z2jJC3VO2v7a0t65hf+
        e3XRsDVSu9qxowyLIsXRDa/KIFXJLDxo2wxZ0A/RMHF70vJVrfNkHcTtFqY9WukJox0JXDldlBF/J
        nuS9pPQ27rcgQQ7kKqqDXRYuz7i3xifdmFIkCq6uAExvIZjJ2ZD5/qBPBB0Yf6WQLq9uYhJXKoTmh
        YuOIwwOkDcEADmlzqWMy+VI7WGkP/T54pFSJiTdckbI/kqnf0OQCFAEzSWt2Qvw8EO9zh22f167Le
        joudqQtQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfljL-0057ZA-Ht; Fri, 24 Mar 2023 18:01:35 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 07/29] ext4: Convert mpage_page_done() to mpage_folio_done()
Date:   Fri, 24 Mar 2023 18:01:07 +0000
Message-Id: <20230324180129.1220691-8-willy@infradead.org>
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

All callers now have a folio so we can pass one in and use the folio
APIs to support large folios as well as save instructions by eliminating
a call to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/inode.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 8f482032d501..801fdeffe2f9 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1863,10 +1863,10 @@ int ext4_da_get_block_prep(struct inode *inode, sector_t iblock,
 	return 0;
 }
 
-static void mpage_page_done(struct mpage_da_data *mpd, struct page *page)
+static void mpage_folio_done(struct mpage_da_data *mpd, struct folio *folio)
 {
-	mpd->first_page++;
-	unlock_page(page);
+	mpd->first_page += folio_nr_pages(folio);
+	folio_unlock(folio);
 }
 
 static int mpage_submit_folio(struct mpage_da_data *mpd, struct folio *folio)
@@ -2011,7 +2011,7 @@ static int mpage_process_page_bufs(struct mpage_da_data *mpd,
 		err = mpage_submit_folio(mpd, head->b_folio);
 		if (err < 0)
 			return err;
-		mpage_page_done(mpd, head->b_page);
+		mpage_folio_done(mpd, head->b_folio);
 	}
 	if (lblk >= blocks) {
 		mpd->scanned_until_end = 1;
@@ -2144,7 +2144,7 @@ static int mpage_map_and_submit_buffers(struct mpage_da_data *mpd)
 			err = mpage_submit_folio(mpd, folio);
 			if (err < 0)
 				goto out;
-			mpage_page_done(mpd, &folio->page);
+			mpage_folio_done(mpd, folio);
 		}
 		folio_batch_release(&fbatch);
 	}
@@ -2544,7 +2544,7 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 					if (err < 0)
 						goto out;
 				}
-				mpage_page_done(mpd, &folio->page);
+				mpage_folio_done(mpd, folio);
 			} else {
 				/* Add all dirty buffers to mpd */
 				lblk = ((ext4_lblk_t)folio->index) <<
-- 
2.39.2

