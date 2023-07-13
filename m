Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A3D7522F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 15:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbjGMNGT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 09:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234989AbjGMNFy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:05:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF23E3A97;
        Thu, 13 Jul 2023 06:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=dIOSe9C7Eta5xFws/YXktNlrD1JACTeSAMCGDk/3k7w=; b=XhbZXlZtAes91JgrFyQ65CY1zn
        orIxGitW6f/Khv5OmuAUjPHr6FHVJfUNzC3Af0rVFRG0sSkk0hst7me3LT7cqVn5DJpRyjTNxqAO3
        1icKxPRWBWyqsTwpSYa8NMzmisCYyzFNMVH3Poou2aXhXnxfVJhBgmfsUPDZklOO5+W3uUDGHkICB
        N+sef8+FzMgGgm/G4+2Kn+2GpyjfjRT6azXoTKDRMOKdAnj/dXoPtRqpte7PYtYsyzOwZel72XKSY
        ZXA8i6fKhS/CjVcew/gpL60gmq1FrMKWXwa6nhzn6Jms9NzIv5ouq/+e5duiYYT+A9PBn2OZL1i/Q
        odqTvMFw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qJw01-003Lb6-0x;
        Thu, 13 Jul 2023 13:04:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 6/9] btrfs: stop submitting I/O after an error in extent_write_locked_range
Date:   Thu, 13 Jul 2023 15:04:28 +0200
Message-Id: <20230713130431.4798-7-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230713130431.4798-1-hch@lst.de>
References: <20230713130431.4798-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As soon a __extent_writepage_io returns an error we know that the
extent_map is corrupted or we're out of memory, and there is no point
in continuing to submit I/O.  Follow the behavior in extent_write_cache
pages and stop submitting I/O, and instead just unlock all pages.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 0c5e540eb2ebea..035f49de024887 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2151,7 +2151,6 @@ void extent_write_locked_range(struct inode *inode, struct page *locked_page,
 			       u64 start, u64 end, struct writeback_control *wbc,
 			       bool pages_dirty)
 {
-	bool found_error = false;
 	int ret = 0;
 	struct address_space *mapping = inode->i_mapping;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
@@ -2180,16 +2179,29 @@ void extent_write_locked_range(struct inode *inode, struct page *locked_page,
 			clear_page_dirty_for_io(page);
 		}
 
-		ret = __extent_writepage_io(BTRFS_I(inode), page, &bio_ctrl,
-					    i_size);
+		/*
+		 * The entire page range that we were called on is locked and
+		 * covered by an ordered_extent.  Make sure we continue the
+		 * loop after an initial writeback error to unwind these as well
+		 * as clearing the dirty bit on the page by starting and ending
+		 * writeback.
+		 */
+		if (ret) {
+			btrfs_mark_ordered_io_finished(BTRFS_I(inode), page,
+						       cur, cur_len, false);
+			btrfs_page_clear_uptodate(fs_info, page, cur, cur_len);
+			set_page_writeback(page);
+			end_page_writeback(page);
+		} else {
+			ret = __extent_writepage_io(BTRFS_I(inode), page,
+						    &bio_ctrl, i_size);
+		}
 		btrfs_page_unlock_writer(fs_info, page, cur, cur_len);
-		if (ret < 0)
-			found_error = true;
 		put_page(page);
 		cur = cur_end + 1;
 	}
 
-	submit_write_bio(&bio_ctrl, found_error ? ret : 0);
+	submit_write_bio(&bio_ctrl, ret);
 }
 
 int extent_writepages(struct address_space *mapping,
-- 
2.39.2

