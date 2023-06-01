Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CE3719773
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 11:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbjFAJqH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 05:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbjFAJpw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:45:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5E219D;
        Thu,  1 Jun 2023 02:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=SUpOllJbKhqT3YEmC3iheCrejbguNofqWimeHbccUMI=; b=tDIBqGXnztSeTBP+Og2j2qkGdU
        xD32U0OGfPlUajFNjhfv2sYWLAQoUGkY12auIfZ9IcoEslwNDz6C5KFIFm9/1AsiQGfj1m8Hs6a7w
        lSCFZYneJiWGKURUd8VszaSZdiaWYDLR3IXZBDLKwykXNSupuXPfex3CNyCDfYvHs3nLxnRIO6P2c
        FvSGmtpWj42L8M528GTP2xwzCZqpYubVuMkY2BHtoxO+oPKn1q+WHzdh+oXdme5L4H90E7G9Bv3Gv
        dj7DpNkmpwZv7qHD0CDoc8vz8zbNoL8K1Qx+Ecoue6TaokTusC+ViCOpIoCCkDEbwogNhAgVDuPK8
        35N5asTw==;
Received: from [2001:4bb8:182:6d06:35f3:1da0:1cc3:d86d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4esH-002m5M-2C;
        Thu, 01 Jun 2023 09:45:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: [PATCH 08/16] block: remove blk_drop_partitions
Date:   Thu,  1 Jun 2023 11:44:51 +0200
Message-Id: <20230601094459.1350643-9-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230601094459.1350643-1-hch@lst.de>
References: <20230601094459.1350643-1-hch@lst.de>
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

There is only a single caller left, so fold the loop into that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 block/partitions/core.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index c3c12671a949d2..87a21942d60667 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -524,17 +524,6 @@ static bool disk_unlock_native_capacity(struct gendisk *disk)
 	return true;
 }
 
-static void blk_drop_partitions(struct gendisk *disk)
-{
-	struct block_device *part;
-	unsigned long idx;
-
-	lockdep_assert_held(&disk->open_mutex);
-
-	xa_for_each_start(&disk->part_tbl, idx, part, 1)
-		delete_partition(part);
-}
-
 static bool blk_add_partition(struct gendisk *disk,
 		struct parsed_partitions *state, int p)
 {
@@ -651,6 +640,8 @@ static int blk_add_partitions(struct gendisk *disk)
 
 int bdev_disk_changed(struct gendisk *disk, bool invalidate)
 {
+	struct block_device *part;
+	unsigned long idx;
 	int ret = 0;
 
 	lockdep_assert_held(&disk->open_mutex);
@@ -663,8 +654,9 @@ int bdev_disk_changed(struct gendisk *disk, bool invalidate)
 		return -EBUSY;
 	sync_blockdev(disk->part0);
 	invalidate_bdev(disk->part0);
-	blk_drop_partitions(disk);
 
+	xa_for_each_start(&disk->part_tbl, idx, part, 1)
+		delete_partition(part);
 	clear_bit(GD_NEED_PART_SCAN, &disk->state);
 
 	/*
-- 
2.39.2

