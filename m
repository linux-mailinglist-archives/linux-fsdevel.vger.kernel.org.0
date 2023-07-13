Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289C57522FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 15:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235226AbjGMNGm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 09:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbjGMNGC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:06:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E6B3AB6;
        Thu, 13 Jul 2023 06:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=jmJ5pZs1+tC3MnsnYQCRaWDiepQvfSm8uolE2IagJ2s=; b=n7nN05pFq8qPRJMRugNvgnjDsv
        UwBetNkAsTPjQPXKxtI1YM0cDu1WY8KrM2pN2/Uz8RJZTUl3d2gGS+UfAQtoOWTMGMKQcXX+Pqoll
        0sQebfuYxXM+7tAkN0qK8syfMzzLIhTBwxMxyHQSlxHYidZBio1ZO/6hrzfvk9SrVRJyQys8kXw54
        Io3kp2U8wxKjUy7Knl2wPlpjHL3IfCryZu3CF9XBkdV2AIz56bhh/p0pkvBLJqJP3uLjRc4X+72Cp
        a6C1+JMXJOA8t2BcJzdajDG4wvVYHSeEVtw705z3rzpUoVPnTvZEihLof4cn0smvZSECGtPa0GhVM
        9T9gKNRA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qJw08-003Lih-18;
        Thu, 13 Jul 2023 13:04:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 9/9] btrfs: lift the call to mapping_set_error out of cow_file_range
Date:   Thu, 13 Jul 2023 15:04:31 +0200
Message-Id: <20230713130431.4798-10-hch@lst.de>
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

Instead of calling mapping_set_error in cow_file_range for the
!locked_page case, make the submit_uncompressed_range call
mapping_set_error also for the !locked_page as that is the only caller
that might pass a NULL locked_page.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 46d04803d76f13..9305a100b5f809 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1074,6 +1074,7 @@ static void submit_uncompressed_range(struct btrfs_inode *inode,
 	wbc_detach_inode(&wbc);
 	if (ret < 0) {
 		btrfs_cleanup_ordered_extents(inode, locked_page, start, end - start + 1);
+		mapping_set_error(inode->vfs_inode.i_mapping, ret);
 		if (locked_page) {
 			const u64 page_start = page_offset(locked_page);
 
@@ -1085,7 +1086,6 @@ static void submit_uncompressed_range(struct btrfs_inode *inode,
 			btrfs_page_clear_uptodate(inode->root->fs_info,
 						  locked_page, page_start,
 						  PAGE_SIZE);
-			mapping_set_error(locked_page->mapping, ret);
 			unlock_page(locked_page);
 		}
 	}
@@ -1525,8 +1525,6 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	 * pages (except @locked_page) to ensure all the pages are unlocked.
 	 */
 	if ((flags & CFR_KEEP_LOCKED) && orig_start < start) {
-		if (!locked_page)
-			mapping_set_error(inode->vfs_inode.i_mapping, ret);
 		extent_clear_unlock_delalloc(inode, orig_start, start - 1,
 					     locked_page, 0, page_ops);
 	}
-- 
2.39.2

