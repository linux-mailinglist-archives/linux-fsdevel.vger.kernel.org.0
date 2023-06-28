Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D6C741523
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 17:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbjF1Pcl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 11:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbjF1Pc0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:32:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3DA2110;
        Wed, 28 Jun 2023 08:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=hg5WWy8kMqhkood0mgXihIPnhNAN0IuoJkNdpCiQHag=; b=aBxZ9BC6XmMlmbtTKhNTlD2aLb
        6EMH3x+h89Vot2Bvlus8VlVExzxluejfUumibyBi+PBDvyRbZzCNWXYg9XAJ89epKXh/Hx8Acdhcg
        VpsUhHyv4sRwyMkqpt4+YOu6+0oeDYrRzBDekU3Ebz6lvjz98pOTS+FMGlSDG/x/QyAFeNAxewt6u
        dqzJ9rHkwzAGS+JCw25FHkyOlGnh2jSn4RPCtXLK1bcc9/F7lgv/szKEcUISGVnhQwJsHeEeDRGoB
        8AkJjUMOhze5koCM1ELp29xWOeVwG+solbaq1lFLlGz0DyRK0of6HdED059NK5zf48arROhK8Dh7K
        IlU/fqaw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qEX9U-00G07B-3A;
        Wed, 28 Jun 2023 15:32:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/23] btrfs: improve the delalloc_to_write calculation in writepage_delalloc
Date:   Wed, 28 Jun 2023 17:31:30 +0200
Message-Id: <20230628153144.22834-10-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230628153144.22834-1-hch@lst.de>
References: <20230628153144.22834-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently writepage_delalloc adds to delalloc_to_write in every loop
operation.  That is not only more work than doing it once after the
loop, but can also over-increment the counter due to rounding errors
when a new loop iteration starts with an offset into a page.

Add a new page_start variable instead of recaculation that value over
and over, move the delalloc_to_write calculation out of the loop, use
the DIV_ROUND_UP helper instead of open coding it and remove the pointless
found local variable.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e32ec41bade681..aa2f88365ad05a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1164,8 +1164,10 @@ static inline void contiguous_readpages(struct page *pages[], int nr_pages,
 static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 		struct page *page, struct writeback_control *wbc)
 {
-	const u64 page_end = page_offset(page) + PAGE_SIZE - 1;
-	u64 delalloc_start = page_offset(page);
+	const u64 page_start = page_offset(page);
+	const u64 page_end = page_start + PAGE_SIZE - 1;
+	u64 delalloc_start = page_start;
+	u64 delalloc_end = page_end;
 	u64 delalloc_to_write = 0;
 	/* How many pages are started by btrfs_run_delalloc_range() */
 	unsigned long nr_written = 0;
@@ -1173,13 +1175,9 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 	int page_started = 0;
 
 	while (delalloc_start < page_end) {
-		u64 delalloc_end = page_end;
-		bool found;
-
-		found = find_lock_delalloc_range(&inode->vfs_inode, page,
-					       &delalloc_start,
-					       &delalloc_end);
-		if (!found) {
+		delalloc_end = page_end;
+		if (!find_lock_delalloc_range(&inode->vfs_inode, page,
+					      &delalloc_start, &delalloc_end)) {
 			delalloc_start = delalloc_end + 1;
 			continue;
 		}
@@ -1188,14 +1186,15 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 		if (ret)
 			return ret;
 
-		/*
-		 * delalloc_end is already one less than the total length, so
-		 * we don't subtract one from PAGE_SIZE
-		 */
-		delalloc_to_write += (delalloc_end - delalloc_start +
-				      PAGE_SIZE) >> PAGE_SHIFT;
 		delalloc_start = delalloc_end + 1;
 	}
+
+	/*
+	 * delalloc_end is already one less than the total length, so
+	 * we don't subtract one from PAGE_SIZE
+	 */
+	delalloc_to_write +=
+		DIV_ROUND_UP(delalloc_end + 1 - page_start, PAGE_SIZE);
 	if (wbc->nr_to_write < delalloc_to_write) {
 		int thresh = 8192;
 
-- 
2.39.2

