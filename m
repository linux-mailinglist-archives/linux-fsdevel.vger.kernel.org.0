Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3DF741517
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 17:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjF1Pcd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 11:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbjF1PcR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:32:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8052979;
        Wed, 28 Jun 2023 08:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=CRVWOZ/K4h6govUCQeEsnFecA9gGv9ULTyS6OF67+D0=; b=2vEsS1XMlo1E0JwCfcfvNaQR/8
        58MQ97e/KdjXSK3sqPoG6CfyjNsyBvc67/ju4mSkVIT5dtvmv/eiyyF3AAx3Hcj3VoWQkknBS+xx8
        Tcx1kjsHeBYL1FnXSqBCw1QmhEbecEbRk49dgKBO4goEQ+f0aU2oQM2sXjjoel9mvNJv44JxL9fTD
        Fgf4ROcIivp51fC+y/kBmXH8MCtI8W+O1hDPio+srXngH7epQGxd8SUdfU4lVQwU2Z0P6gJvqLtBI
        jPpbkvbrKYTbhE3v92bfsW1ldEd/qBWMo8JqUlLaRsfVfKaUUFmr5bPKvt5EyseyZisYpvZ7aT9AT
        HfYMt0gg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qEX9R-00G06r-2b;
        Wed, 28 Jun 2023 15:32:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/23] btrfs: remove the return value from extent_write_locked_range
Date:   Wed, 28 Jun 2023 17:31:29 +0200
Message-Id: <20230628153144.22834-9-hch@lst.de>
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

The return value from extent_write_locked_range is ignored, and that's
fine because the error reporting happens through the mapping and
ordered_extent.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 13 +++----------
 fs/btrfs/extent_io.h |  4 ++--
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 5a4f5fc09a2354..e32ec41bade681 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2152,11 +2152,10 @@ static int extent_write_cache_pages(struct address_space *mapping,
  * already been ran (aka, ordered extent inserted) and all pages are still
  * locked.
  */
-int extent_write_locked_range(struct inode *inode, u64 start, u64 end,
-			      struct writeback_control *wbc)
+void extent_write_locked_range(struct inode *inode, u64 start, u64 end,
+			       struct writeback_control *wbc)
 {
 	bool found_error = false;
-	int first_error = 0;
 	int ret = 0;
 	struct address_space *mapping = inode->i_mapping;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
@@ -2206,20 +2205,14 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end,
 			mapping_set_error(page->mapping, ret);
 		}
 		btrfs_page_unlock_writer(fs_info, page, cur, cur_len);
-		if (ret < 0) {
+		if (ret < 0)
 			found_error = true;
-			first_error = ret;
-		}
 next_page:
 		put_page(page);
 		cur = cur_end + 1;
 	}
 
 	submit_write_bio(&bio_ctrl, found_error ? ret : 0);
-
-	if (found_error)
-		return first_error;
-	return ret;
 }
 
 int extent_writepages(struct address_space *mapping,
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 8d11e17c0be9fa..0312022bbf4b7a 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -177,8 +177,8 @@ int try_release_extent_mapping(struct page *page, gfp_t mask);
 int try_release_extent_buffer(struct page *page);
 
 int btrfs_read_folio(struct file *file, struct folio *folio);
-int extent_write_locked_range(struct inode *inode, u64 start, u64 end,
-			      struct writeback_control *wbc);
+void extent_write_locked_range(struct inode *inode, u64 start, u64 end,
+			       struct writeback_control *wbc);
 int extent_writepages(struct address_space *mapping,
 		      struct writeback_control *wbc);
 int btree_write_cache_pages(struct address_space *mapping,
-- 
2.39.2

