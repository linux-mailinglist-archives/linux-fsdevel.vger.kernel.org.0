Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A646E74155E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 17:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbjF1Pdg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 11:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbjF1PdA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:33:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CD330C7;
        Wed, 28 Jun 2023 08:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=+7+4nsdFDbsRT1q2Uw8AAPCu0PUJ7daQq6Y87tECxWI=; b=2T/gp4mwuW67RaeBf5V/vXFlDv
        Pvb90WeIH3YAGSimQS7fDf17hIp289HXwiI2t8AnAHn3bM0dZfFVlmxzsqd7BJTC4h17mTzIkxnrI
        eeNsfr++uhQso3qBMDhRU0zl0bpXdGK5lgRvILAvH1EGzR7dbO3PoUi+siGkK4K2CPvV5+HMgl4XX
        WsBmv396BHuJSuJAyeCOVXOJSY6JJPlBANBrTKje7n0B08N+Rxt3Z+S1B7qO7rdcXEYKNePwvqFmw
        N4qUIpoasUFAdi4EwL8FEXXEu8rxOc+clH/9roN/caUzFRf8ClAPQxPRqyoCfBs++/HjLrkyryv/J
        IcNK3z4A==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qEX9x-00G0Dg-1K;
        Wed, 28 Jun 2023 15:32:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 18/23] btrfs: share the code to free the page array in compress_file_range
Date:   Wed, 28 Jun 2023 17:31:39 +0200
Message-Id: <20230628153144.22834-19-hch@lst.de>
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

compress_file_range has two code blocks to free the page array for the
compressed data.  Share the code using a goto label.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 00aabc088a9deb..8f3a72f3f897a1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1003,12 +1003,7 @@ static void compress_file_range(struct btrfs_work *work)
 						     PAGE_UNLOCK |
 						     PAGE_START_WRITEBACK |
 						     PAGE_END_WRITEBACK);
-			for (i = 0; i < nr_pages; i++) {
-				WARN_ON(pages[i]->mapping);
-				put_page(pages[i]);
-			}
-			kfree(pages);
-			return;
+			goto free_pages;
 		}
 	}
 
@@ -1044,21 +1039,6 @@ static void compress_file_range(struct btrfs_work *work)
 	if (!btrfs_test_opt(fs_info, FORCE_COMPRESS) && !inode->prop_compress)
 		inode->flags |= BTRFS_INODE_NOCOMPRESS;
 cleanup_and_bail_uncompressed:
-	if (pages) {
-		/*
-		 * the compression code ran but failed to make things smaller,
-		 * free any pages it allocated and our page pointer array
-		 */
-		for (i = 0; i < nr_pages; i++) {
-			WARN_ON(pages[i]->mapping);
-			put_page(pages[i]);
-		}
-		kfree(pages);
-		pages = NULL;
-		total_compressed = 0;
-		nr_pages = 0;
-	}
-
 	/*
 	 * No compression, but we still need to write the pages in the file
 	 * we've been given so far.  redirty the locked page if it corresponds
@@ -1076,6 +1056,14 @@ static void compress_file_range(struct btrfs_work *work)
 		extent_range_redirty_for_io(&inode->vfs_inode, start, end);
 	add_async_extent(async_chunk, start, end - start + 1, 0, NULL, 0,
 			 BTRFS_COMPRESS_NONE);
+free_pages:
+	if (pages) {
+		for (i = 0; i < nr_pages; i++) {
+			WARN_ON(pages[i]->mapping);
+			put_page(pages[i]);
+		}
+		kfree(pages);
+	}
 }
 
 static void free_async_extent_pages(struct async_extent *async_extent)
-- 
2.39.2

