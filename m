Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B55730FBB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 08:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244039AbjFOGuV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 02:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244524AbjFOGt5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:49:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5618F35A2;
        Wed, 14 Jun 2023 23:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=O5rqINDOhGBEmYmacIiPWpa7oZ33A3MhfQ9jfU86Orc=; b=2+DsE36xb63m2Zc84KQ7PH894I
        rBMP3Eumf4cCd5fMxWkbnn02fO0xoSE17+5z48XreihvUbhHSR6pSw3tDDx2ELQQBPC9PHKuNTR/M
        exCkuwhED4ypM0vwQAqANJRXIX6jLVrXoTAQ1a6Zo3eQkoiMGigVLRbm0rG4Tw1iOn9egHBlMteHg
        yx5b0xMmoVOfBGykoSTNin6O3AddV83z8x3LNI4DRJAlOTrNFrCdadYdGa8vMPaXO/xj/z4yPxU4j
        qQjq3hPUw28uuTUvv+H9UOw0gmdh6I14HlqPVELeQ7DFSSVxkY0vmaNf0nuiZ1aUyxBIUfN15oQjy
        u9eBP/tw==;
Received: from 2a02-8389-2341-5b80-8c8c-28f8-1274-e038.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:8c8c:28f8:1274:e038] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q9gmq-00DuAV-2s;
        Thu, 15 Jun 2023 06:48:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Song Liu <song@kernel.org>
Cc:     linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/11] md-bitmap: split file writes into a separate helper
Date:   Thu, 15 Jun 2023 08:48:33 +0200
Message-Id: <20230615064840.629492-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230615064840.629492-1-hch@lst.de>
References: <20230615064840.629492-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Split the file write code out of write_page into a separate helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/md-bitmap.c | 48 +++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index e4b466522d4e74..46fbcfc9d1fcac 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -296,33 +296,22 @@ static void write_sb_page(struct bitmap *bitmap, struct page *page, int wait)
 }
 
 static void md_bitmap_file_kick(struct bitmap *bitmap);
-/*
- * write out a page to a file
- */
-static void write_page(struct bitmap *bitmap, struct page *page, int wait)
-{
-	struct buffer_head *bh;
 
-	if (bitmap->storage.file == NULL) {
-		write_sb_page(bitmap, page, wait);
-	} else {
-
-		bh = page_buffers(page);
-
-		while (bh && bh->b_blocknr) {
-			atomic_inc(&bitmap->pending_writes);
-			set_buffer_locked(bh);
-			set_buffer_mapped(bh);
-			submit_bh(REQ_OP_WRITE | REQ_SYNC, bh);
-			bh = bh->b_this_page;
-		}
+static void write_file_page(struct bitmap *bitmap, struct page *page, int wait)
+{
+	struct buffer_head *bh = page_buffers(page);
 
-		if (wait)
-			wait_event(bitmap->write_wait,
-				   atomic_read(&bitmap->pending_writes)==0);
+	while (bh && bh->b_blocknr) {
+		atomic_inc(&bitmap->pending_writes);
+		set_buffer_locked(bh);
+		set_buffer_mapped(bh);
+		submit_bh(REQ_OP_WRITE | REQ_SYNC, bh);
+		bh = bh->b_this_page;
 	}
-	if (test_bit(BITMAP_WRITE_ERROR, &bitmap->flags))
-		md_bitmap_file_kick(bitmap);
+
+	if (wait)
+		wait_event(bitmap->write_wait,
+			   atomic_read(&bitmap->pending_writes) == 0);
 }
 
 static void end_bitmap_write(struct buffer_head *bh, int uptodate)
@@ -429,6 +418,17 @@ static int read_page(struct file *file, unsigned long index,
  * bitmap file superblock operations
  */
 
+/*
+ * write out a page to a file
+ */
+static void write_page(struct bitmap *bitmap, struct page *page, int wait)
+{
+	if (bitmap->storage.file)
+		write_file_page(bitmap, page, wait);
+	else
+		write_sb_page(bitmap, page, wait);
+}
+
 /*
  * md_bitmap_wait_writes() should be called before writing any bitmap
  * blocks, to ensure previous writes, particularly from
-- 
2.39.2

