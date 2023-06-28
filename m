Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DEE741550
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 17:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjF1Pc3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 11:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbjF1PcR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:32:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CA52728;
        Wed, 28 Jun 2023 08:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=LcDc0H6zoBs18aKmyXsHcP1XOIqUzH3TPTBSNaCP85U=; b=XtwQ3J6r3aD2UL9OJVshlNS5sq
        7tAFY5W89qsJiLRL0Y2t6medd6KBM4HwolyLlUP+UGg7XxW+O6cS5DbCj2AUAhNAghfkwNfM0sA0+
        XUmwRdygKTb0Vw68QQ7IUgV5hktQQipifFQNiAKu4Y+B0w4d1iaNXBLR90mr5uFAWfvPlX2XfZLbZ
        zYnD2XU1nwvdPwpAJLK/p0wM+ntJNJT5IUwse1smN/WmCassoQ85tRkD9iO5zudgLCgBdfx8AQpqJ
        vRn/B5sTmZv8nCs86epOoG5a0ocAG6CpdkgGTAZsM3fbnye/SOmQUM5l3o6U49pMrmwyGlW4LyuGA
        X9XLXAdA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qEX9O-00G068-2E;
        Wed, 28 Jun 2023 15:32:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/23] btrfs: remove the return value from submit_uncompressed_range
Date:   Wed, 28 Jun 2023 17:31:28 +0200
Message-Id: <20230628153144.22834-8-hch@lst.de>
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

The return value from submit_uncompressed_range is ignored, and that's
fine because the error reporting happens through the mapping and
ordered_extent.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0f709f766b6a94..c6845b0591b77e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1126,9 +1126,9 @@ static void free_async_extent_pages(struct async_extent *async_extent)
 	async_extent->pages = NULL;
 }
 
-static int submit_uncompressed_range(struct btrfs_inode *inode,
-				     struct async_extent *async_extent,
-				     struct page *locked_page)
+static void submit_uncompressed_range(struct btrfs_inode *inode,
+				      struct async_extent *async_extent,
+				      struct page *locked_page)
 {
 	u64 start = async_extent->start;
 	u64 end = async_extent->start + async_extent->ram_size - 1;
@@ -1153,7 +1153,7 @@ static int submit_uncompressed_range(struct btrfs_inode *inode,
 			     &nr_written, NULL, CFR_KEEP_LOCKED);
 	/* Inline extent inserted, page gets unlocked and everything is done */
 	if (page_started)
-		return 0;
+		return;
 
 	if (ret < 0) {
 		btrfs_cleanup_ordered_extents(inode, locked_page, start, end - start + 1);
@@ -1171,14 +1171,13 @@ static int submit_uncompressed_range(struct btrfs_inode *inode,
 			mapping_set_error(locked_page->mapping, ret);
 			unlock_page(locked_page);
 		}
-		return ret;
+		return;
 	}
 
 	/* All pages will be unlocked, including @locked_page */
 	wbc_attach_fdatawrite_inode(&wbc, &inode->vfs_inode);
-	ret = extent_write_locked_range(&inode->vfs_inode, start, end, &wbc);
+	extent_write_locked_range(&inode->vfs_inode, start, end, &wbc);
 	wbc_detach_inode(&wbc);
-	return ret;
 }
 
 static void submit_one_async_extent(struct async_chunk *async_chunk,
@@ -1215,7 +1214,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 
 	/* We have fall back to uncompressed write */
 	if (!async_extent->pages) {
-		ret = submit_uncompressed_range(inode, async_extent, locked_page);
+		submit_uncompressed_range(inode, async_extent, locked_page);
 		goto done;
 	}
 
-- 
2.39.2

