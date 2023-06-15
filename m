Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D59730FC6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 08:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244326AbjFOGu2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 02:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244544AbjFOGt6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:49:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D2C35A6;
        Wed, 14 Jun 2023 23:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=KhhhbO/H4IhhYryw9kVCM7NntqzDQwz7VXWYmcFSZ/k=; b=tsNosnH8dzmWYgVZ7pQ3VWrciJ
        i1/WRnRWgcCvDvQrYpJ+9m26zVyXXyqw8y3HUG3Wrlq7eoz+xATQuksGDMU8nnLp5MaTj3U2EZZd6
        LM5Iz3KKZ+iHd2X1DOtT9gz8qtkrpuAZJaesEWQu+VUEh85vM0OKVv42mY7/L1M/RndZ791DViPmT
        84cpDjkbFepx4G7Ze5vaIiopm7B8V6OXYrN3TKQY4Z4BgxL6WCwOegmw4OMOoupgjcY185lQwnbb7
        Rnm1XtLPMoOwnTdl1eR9vOHCIM0zgUZdF+cFn1IDycFeAHw96WtUC05qCa1uqvdFcOlV8GxC+ZrQG
        29uDX5Hw==;
Received: from 2a02-8389-2341-5b80-8c8c-28f8-1274-e038.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:8c8c:28f8:1274:e038] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q9gmt-00DuAm-0v;
        Thu, 15 Jun 2023 06:48:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Song Liu <song@kernel.org>
Cc:     linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/11] md-bitmap: rename read_page to read_file_page
Date:   Thu, 15 Jun 2023 08:48:34 +0200
Message-Id: <20230615064840.629492-6-hch@lst.de>
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

Make the difference to read_sb_page clear.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/md-bitmap.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 46fbcfc9d1fcac..fa0f6ca7b61b0b 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -348,10 +348,8 @@ static void free_buffers(struct page *page)
  * This usage is similar to how swap files are handled, and allows us
  * to write to a file with no concerns of memory allocation failing.
  */
-static int read_page(struct file *file, unsigned long index,
-		     struct bitmap *bitmap,
-		     unsigned long count,
-		     struct page *page)
+static int read_file_page(struct file *file, unsigned long index,
+		struct bitmap *bitmap, unsigned long count, struct page *page)
 {
 	int ret = 0;
 	struct inode *inode = file_inode(file);
@@ -632,7 +630,7 @@ static int md_bitmap_read_sb(struct bitmap *bitmap)
 		loff_t isize = i_size_read(bitmap->storage.file->f_mapping->host);
 		int bytes = isize > PAGE_SIZE ? PAGE_SIZE : isize;
 
-		err = read_page(bitmap->storage.file, 0,
+		err = read_file_page(bitmap->storage.file, 0,
 				bitmap, bytes, sb_page);
 	} else {
 		err = read_sb_page(bitmap->mddev,
@@ -1141,7 +1139,7 @@ static int md_bitmap_init_from_disk(struct bitmap *bitmap, sector_t start)
 				count = PAGE_SIZE;
 			page = store->filemap[index];
 			if (file)
-				ret = read_page(file, index, bitmap,
+				ret = read_file_page(file, index, bitmap,
 						count, page);
 			else
 				ret = read_sb_page(
-- 
2.39.2

