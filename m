Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F20364F2C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Dec 2022 21:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbiLPUy2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Dec 2022 15:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbiLPUx6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Dec 2022 15:53:58 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFA35EDF5;
        Fri, 16 Dec 2022 12:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=vJzKfyje4c819BFbns5UZdctaxltdCOefh268VxpRYY=; b=HP02vwX4CrEDk1k+bgXeH1COan
        V2i0imlSnVsm4wr8RzmXA7HJLFTXuD3pkSrOk0yb5tTKWZgFSzGepHoB8p1u2I1C2+I76X2piktgI
        z5LNFiRHnb4X63dDAy+Zkh0JDbjglzFRQX+nVFcBe57A1KZ8bkz01Od0yMKpIDAvR5TntpJAKe6v+
        kBgf3mruPGRhGRFk3w5nKESjIhJJI9YTTtfj0oiu0DrFwXFYTruIaOPOlaq6PrYacaVuKEkk/kYyW
        m4kksBW102j+Yzprkb59p2jumGxc28Ni4NUrLCQsDpoUJUpvVfDKVFD8VGcz1v5O6lQuBGhBLuBpt
        BKtrl/Xw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p6HiI-00Frfu-CQ; Fri, 16 Dec 2022 20:53:50 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     reiserfs-devel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 7/8] reiserfs: Convert convert_tail_for_hole() to use folios
Date:   Fri, 16 Dec 2022 20:53:46 +0000
Message-Id: <20221216205348.3781217-8-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221216205348.3781217-1-willy@infradead.org>
References: <20221216205348.3781217-1-willy@infradead.org>
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

It's not clear to me that reiserfs will ever support large folios, but
now this function will operate correctly if they are enabled.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/reiserfs/inode.c | 45 +++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index b79848111957..008855ddb365 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -571,57 +571,58 @@ static int convert_tail_for_hole(struct inode *inode,
 	unsigned long index;
 	unsigned long tail_end;
 	unsigned long tail_start;
-	struct page *tail_page;
-	struct page *hole_page = bh_result->b_page;
+	struct folio *tail_folio;
+	struct folio *hole_folio = bh_result->b_folio;
 	int retval = 0;
 
 	if ((tail_offset & (bh_result->b_size - 1)) != 1)
 		return -EIO;
 
-	/* always try to read until the end of the block */
-	tail_start = tail_offset & (PAGE_SIZE - 1);
-	tail_end = (tail_start | (bh_result->b_size - 1)) + 1;
-
 	index = tail_offset >> PAGE_SHIFT;
 	/*
-	 * hole_page can be zero in case of direct_io, we are sure
+	 * hole_folio can be zero in case of direct_io, we are sure
 	 * that we cannot get here if we write with O_DIRECT into tail page
 	 */
-	if (!hole_page || index != hole_page->index) {
-		tail_page = grab_cache_page(inode->i_mapping, index);
+	if (!hole_folio || !folio_contains(hole_folio, index)) {
+		tail_folio = __filemap_get_folio(inode->i_mapping, index,
+				FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
+				mapping_gfp_mask(inode->i_mapping));
 		retval = -ENOMEM;
-		if (!tail_page) {
+		if (!tail_folio)
 			goto out;
-		}
 	} else {
-		tail_page = hole_page;
+		tail_folio = hole_folio;
 	}
 
+	/* always try to read until the end of the block */
+	tail_start = offset_in_folio(tail_folio, tail_offset);
+	tail_end = (tail_start | (bh_result->b_size - 1)) + 1;
+
 	/*
 	 * we don't have to make sure the conversion did not happen while
-	 * we were locking the page because anyone that could convert
+	 * we were locking the folio because anyone that could convert
 	 * must first take i_mutex.
 	 *
-	 * We must fix the tail page for writing because it might have buffers
+	 * We must fix the tail folio for writing because it might have buffers
 	 * that are mapped, but have a block number of 0.  This indicates tail
-	 * data that has been read directly into the page, and
+	 * data that has been read directly into the folio, and
 	 * __block_write_begin won't trigger a get_block in this case.
 	 */
-	fix_tail_page_for_writing(tail_page);
-	retval = __reiserfs_write_begin(tail_page, tail_start,
+	fix_tail_page_for_writing(&tail_folio->page);
+	retval = __reiserfs_write_begin(&tail_folio->page, tail_start,
 				      tail_end - tail_start);
 	if (retval)
 		goto unlock;
 
 	/* tail conversion might change the data in the page */
-	flush_dcache_page(tail_page);
+	flush_dcache_folio(tail_folio);
 
-	retval = reiserfs_commit_write(NULL, tail_page, tail_start, tail_end);
+	retval = reiserfs_commit_write(NULL, &tail_folio->page, tail_start, tail_end);
 
 unlock:
-	if (tail_page != hole_page) {
-		unlock_page(tail_page);
-		put_page(tail_page);
+	if (tail_folio != hole_folio) {
+		folio_unlock(tail_folio);
+		folio_put(tail_folio);
 	}
 out:
 	return retval;
-- 
2.35.1

