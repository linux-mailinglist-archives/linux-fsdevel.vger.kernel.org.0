Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E607A5903
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 06:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjISExZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 00:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbjISEwn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 00:52:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8DB1BB;
        Mon, 18 Sep 2023 21:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=AQlSme5gfgF1PuSREZ2XhDo5ATTymBH433vqXKy6HYA=; b=JJppl7UiNVc9XOSJeWze4h14kq
        Juko1qtn8fJ4aHHuB7zu5C4R7OyJGaSJnUSgzpdxkZ+dqLlTOFpqyWhefQbRcNpLhpNLmvQltWSAn
        C7ZpO0FcFmc1xx7X5C4bcbD0FKdTf9sXQRQ+banVLKDHHuO/w3zdBvtlLbwI5sFdJ5HPdJW1F9QVO
        mtSFcSTpG0CM2ReAEuaIBc5UyqeV1+Jb/9DXQhP8hsSjdzGEM2kI/a0JqyP6E6v8V4SgKBYUkTGWg
        INxIijyxrRagUGRekiCKh78YPLq80p8LPEtBi1aM3YXPnXLahkvXsgQbtM+jDe7ms5QM2kyjHITyA
        rDOz3Q6Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qiSi2-00FFkT-Va; Tue, 19 Sep 2023 04:51:39 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        reiserfs-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 07/26] gfs2; Convert gfs2_getjdatabuf to use a folio
Date:   Tue, 19 Sep 2023 05:51:16 +0100
Message-Id: <20230919045135.3635437-8-willy@infradead.org>
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

Use the folio APIs, saving four hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/gfs2/meta_io.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index f1fac1b45059..b28196015543 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -400,26 +400,20 @@ static struct buffer_head *gfs2_getjdatabuf(struct gfs2_inode *ip, u64 blkno)
 {
 	struct address_space *mapping = ip->i_inode.i_mapping;
 	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
-	struct page *page;
+	struct folio *folio;
 	struct buffer_head *bh;
 	unsigned int shift = PAGE_SHIFT - sdp->sd_sb.sb_bsize_shift;
 	unsigned long index = blkno >> shift; /* convert block to page */
 	unsigned int bufnum = blkno - (index << shift);
 
-	page = find_get_page_flags(mapping, index, FGP_LOCK|FGP_ACCESSED);
-	if (!page)
-		return NULL;
-	if (!page_has_buffers(page)) {
-		unlock_page(page);
-		put_page(page);
+	folio = __filemap_get_folio(mapping, index, FGP_LOCK | FGP_ACCESSED, 0);
+	if (IS_ERR(folio))
 		return NULL;
-	}
-	/* Locate header for our buffer within our page */
-	for (bh = page_buffers(page); bufnum--; bh = bh->b_this_page)
-		/* Do nothing */;
-	get_bh(bh);
-	unlock_page(page);
-	put_page(page);
+	bh = folio_buffers(folio);
+	if (bh)
+		get_nth_bh(bh, bufnum);
+	folio_unlock(folio);
+	folio_put(folio);
 	return bh;
 }
 
-- 
2.40.1

