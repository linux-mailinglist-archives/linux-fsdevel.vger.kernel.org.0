Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C77730FB5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 08:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243921AbjFOGuU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 02:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244490AbjFOGtz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:49:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9714214;
        Wed, 14 Jun 2023 23:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=5QI7iu2tF5lZVrJtHh2PVrgwjIKSOna7mZOiuqyQzX4=; b=UbHqcaNEQZRITid+9dUv/AO2hZ
        xzu872kfgccLbnTwMav990u+GElyK6qDuf8iLrmvGsEDfNNUU4gaZ7BupNfTwvztSxwvR5Bw6WZvj
        KikP+XLpe2nMgIXAV112uKkhwGq3PaNp01Vl6osJGQer1SI49C3N+tXXh6Nr5m2/PluNZI//m/YjB
        dJqttrEONot364Qp8vscBUh1x7eonV6N6rWyOq/WUkSqiCCLiyjSdL4QIRyvOIdwgdxzniAmTxAFH
        eGzsDXgpbID7XxecLABpOZNydc+wSmbM+XOiGTsEaJUEiHd4fgtij/gkRbWy60829T47eqFEJCqSd
        qFq89IdQ==;
Received: from 2a02-8389-2341-5b80-8c8c-28f8-1274-e038.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:8c8c:28f8:1274:e038] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q9gmk-00Du95-07;
        Thu, 15 Jun 2023 06:48:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Song Liu <song@kernel.org>
Cc:     linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 01/11] md-bitmap: set BITMAP_WRITE_ERROR in write_sb_page
Date:   Thu, 15 Jun 2023 08:48:30 +0200
Message-Id: <20230615064840.629492-2-hch@lst.de>
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

Set BITMAP_WRITE_ERROR directly in write_sb_page instead of propagating
the error to the caller and setting it there.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/md-bitmap.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 1ff712889a3b36..d8469720fac23f 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -279,22 +279,20 @@ static int __write_sb_page(struct md_rdev *rdev, struct bitmap *bitmap,
 	return 0;
 }
 
-static int write_sb_page(struct bitmap *bitmap, struct page *page, int wait)
+static void write_sb_page(struct bitmap *bitmap, struct page *page, int wait)
 {
-	struct md_rdev *rdev;
 	struct mddev *mddev = bitmap->mddev;
-	int ret;
 
 	do {
-		rdev = NULL;
+		struct md_rdev *rdev = NULL;
+
 		while ((rdev = next_active_rdev(rdev, mddev)) != NULL) {
-			ret = __write_sb_page(rdev, bitmap, page);
-			if (ret)
-				return ret;
+			if (__write_sb_page(rdev, bitmap, page) < 0) {
+				set_bit(BITMAP_WRITE_ERROR, &bitmap->flags);
+				return;
+			}
 		}
 	} while (wait && md_super_wait(mddev) < 0);
-
-	return 0;
 }
 
 static void md_bitmap_file_kick(struct bitmap *bitmap);
@@ -306,10 +304,7 @@ static void write_page(struct bitmap *bitmap, struct page *page, int wait)
 	struct buffer_head *bh;
 
 	if (bitmap->storage.file == NULL) {
-		switch (write_sb_page(bitmap, page, wait)) {
-		case -EINVAL:
-			set_bit(BITMAP_WRITE_ERROR, &bitmap->flags);
-		}
+		write_sb_page(bitmap, page, wait);
 	} else {
 
 		bh = page_buffers(page);
-- 
2.39.2

