Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0E27A58B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 06:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjISEv4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 00:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbjISEvr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 00:51:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9638610F;
        Mon, 18 Sep 2023 21:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=1TQFktAQGh0zDqA+GJQVLyWb3smQ1H0QN8aDeY770F0=; b=PxHiF6cktFd/+CJWwFu4VfrtIM
        PU0/626kh0C0ccZjcHWLIbaeSrDKQSavppRX9DRoE01nHmzI0HlowA9/DqHak5U+KPUXKjQOdJsMs
        ZdwfK6M84AaKO9czXr1z7XfamvIK16jDsF+5FVERFeDeCp8meD7EpMpnB1ZpZfBurluqv/wWqIQ9i
        QrQ+B/blKNm3erh45AQnHTEWTOxqp2w0H0iFhdgfFEPkO9daOJuNfy5L7uoCrQdv+ULCTdbsbDSn0
        VsYB0iwbBHo3ho/jG4t1edo/ibYE4JPT0lVSSVCNpJvJ4DFaYIkEKiH/kWvwbRREVnyH8qtiMOMoD
        4z+k4GNw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qiSi3-00FFl8-RD; Tue, 19 Sep 2023 04:51:39 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        reiserfs-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 13/26] nilfs2: Convert nilfs_mdt_get_frozen_buffer to use a folio
Date:   Tue, 19 Sep 2023 05:51:22 +0100
Message-Id: <20230919045135.3635437-14-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230919045135.3635437-1-willy@infradead.org>
References: <20230919045135.3635437-1-willy@infradead.org>
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

Remove a number of folio->page->folio conversions.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nilfs2/mdt.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
index 11b7cf4acc92..7b754e6494d7 100644
--- a/fs/nilfs2/mdt.c
+++ b/fs/nilfs2/mdt.c
@@ -592,17 +592,19 @@ nilfs_mdt_get_frozen_buffer(struct inode *inode, struct buffer_head *bh)
 {
 	struct nilfs_shadow_map *shadow = NILFS_MDT(inode)->mi_shadow;
 	struct buffer_head *bh_frozen = NULL;
-	struct page *page;
+	struct folio *folio;
 	int n;
 
-	page = find_lock_page(shadow->inode->i_mapping, bh->b_folio->index);
-	if (page) {
-		if (page_has_buffers(page)) {
+	folio = filemap_lock_folio(shadow->inode->i_mapping,
+			bh->b_folio->index);
+	if (!IS_ERR(folio)) {
+		bh_frozen = folio_buffers(folio);
+		if (bh_frozen) {
 			n = bh_offset(bh) >> inode->i_blkbits;
-			bh_frozen = nilfs_page_get_nth_block(page, n);
+			bh_frozen = get_nth_bh(bh_frozen, n);
 		}
-		unlock_page(page);
-		put_page(page);
+		folio_unlock(folio);
+		folio_put(folio);
 	}
 	return bh_frozen;
 }
-- 
2.40.1

