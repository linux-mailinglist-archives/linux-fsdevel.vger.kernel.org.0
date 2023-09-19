Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC367A58AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 06:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjISEvw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 00:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjISEvr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 00:51:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD132122;
        Mon, 18 Sep 2023 21:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=3+ygHFl8VBE//i+jIFbzwz27nrHn7+CKZunR4nMah8o=; b=a0R1TMwjL7kTjAJn7QXnrOIurK
        Jk/KsvVgMWmyNgxqWN5vSm+fsVeErc+p2SA6/+JKtl/gEKJ+0QYncbcX+TH5IXWFm1kSYWvPuG2ip
        OajcUmwdb2Q1jdRy96OBqSI9A3X6nYI2Gne1jBNmqMZ6G5e8vDS82vesYeCBU0BKkKmDnaXSuLJHc
        F7rpZc3aYOtL9zGBN5ZI0SUwLCUcCJ640FT9Vttt57wR7CXyJ/CsYUcOsChqRuHWhIJUulzwRwF2F
        onoE1mEjpIOAFxCaBkVNUPExG2E40+aJJmfa3dlcBJgvTjZj82jejSKPCVarzwlrbvnhwKs75NSoo
        nKz21X2g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qiSi3-00FFkV-21; Tue, 19 Sep 2023 04:51:39 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        reiserfs-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 08/26] gfs2: Convert gfs2_write_buf_to_page() to use a folio
Date:   Tue, 19 Sep 2023 05:51:17 +0100
Message-Id: <20230919045135.3635437-9-willy@infradead.org>
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

Remove several folio->page->folio conversions.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/gfs2/quota.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 171b2713d2e5..0ee4865ebdca 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -736,7 +736,7 @@ static int gfs2_write_buf_to_page(struct gfs2_sbd *sdp, unsigned long index,
 	struct gfs2_inode *ip = GFS2_I(sdp->sd_quota_inode);
 	struct inode *inode = &ip->i_inode;
 	struct address_space *mapping = inode->i_mapping;
-	struct page *page;
+	struct folio *folio;
 	struct buffer_head *bh;
 	u64 blk;
 	unsigned bsize = sdp->sd_sb.sb_bsize, bnum = 0, boff = 0;
@@ -745,15 +745,15 @@ static int gfs2_write_buf_to_page(struct gfs2_sbd *sdp, unsigned long index,
 	blk = index << (PAGE_SHIFT - sdp->sd_sb.sb_bsize_shift);
 	boff = off % bsize;
 
-	page = grab_cache_page(mapping, index);
-	if (!page)
-		return -ENOMEM;
-	if (!page_has_buffers(page))
-		create_empty_buffers(page, bsize, 0);
+	folio = filemap_grab_folio(mapping, index);
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
+	bh = folio_buffers(folio);
+	if (!bh)
+		bh = folio_create_empty_buffers(folio, bsize, 0);
 
-	bh = page_buffers(page);
-	for(;;) {
-		/* Find the beginning block within the page */
+	for (;;) {
+		/* Find the beginning block within the folio */
 		if (pg_off >= ((bnum * bsize) + bsize)) {
 			bh = bh->b_this_page;
 			bnum++;
@@ -766,9 +766,10 @@ static int gfs2_write_buf_to_page(struct gfs2_sbd *sdp, unsigned long index,
 				goto unlock_out;
 			/* If it's a newly allocated disk block, zero it */
 			if (buffer_new(bh))
-				zero_user(page, bnum * bsize, bh->b_size);
+				folio_zero_range(folio, bnum * bsize,
+						bh->b_size);
 		}
-		if (PageUptodate(page))
+		if (folio_test_uptodate(folio))
 			set_buffer_uptodate(bh);
 		if (bh_read(bh, REQ_META | REQ_PRIO) < 0)
 			goto unlock_out;
@@ -784,17 +785,17 @@ static int gfs2_write_buf_to_page(struct gfs2_sbd *sdp, unsigned long index,
 		break;
 	}
 
-	/* Write to the page, now that we have setup the buffer(s) */
-	memcpy_to_page(page, off, buf, bytes);
-	flush_dcache_page(page);
-	unlock_page(page);
-	put_page(page);
+	/* Write to the folio, now that we have setup the buffer(s) */
+	memcpy_to_folio(folio, off, buf, bytes);
+	flush_dcache_folio(folio);
+	folio_unlock(folio);
+	folio_put(folio);
 
 	return 0;
 
 unlock_out:
-	unlock_page(page);
-	put_page(page);
+	folio_unlock(folio);
+	folio_put(folio);
 	return -EIO;
 }
 
-- 
2.40.1

