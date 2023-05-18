Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E954C707903
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 06:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjEREX5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 00:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjEREXt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 00:23:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDEA3AB6;
        Wed, 17 May 2023 21:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=1/OXbVboY/ppHHxtLKeuOmqflsdEtEksVL9FfEMSAvA=; b=PxZvEz5nl+/1UuFf2fKQRKDRxs
        WZOTKa9paZtxHIs7Se6dqJwB7OHXqlt3qD/GKsjUudhCTCnoDfseyivk7rf9tqB4uwzthAc6p3Nre
        DNyzlGzDLaxdowOvnmfBT+da1WJbJvcQctuwbzXEVSNnS2Xc7Rq0k+9mjPyh1e9pedzBLrX3yHxMp
        vo6byIRHMZdXl+qhgjJlHKeYDhB5exDqe7ixKleWOnRMKBdW5lI/DNGGIM+JnU9vIm6hXZceW0ldH
        U/tZBhQMRTAqZzUolIaN25xzUrJREWqvbWP2pLZSubeb6AFsFwYhODnyBe8M+2lMS9s+/d10zgvgQ
        ugWEc9VQ==;
Received: from [2001:4bb8:188:3dd5:c90:b13:29fb:f2b9] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pzVB3-00BqQs-2C;
        Thu, 18 May 2023 04:23:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: [PATCH 08/13] block: remove blk_drop_partitions
Date:   Thu, 18 May 2023 06:23:17 +0200
Message-Id: <20230518042323.663189-9-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518042323.663189-1-hch@lst.de>
References: <20230518042323.663189-1-hch@lst.de>
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
---
 block/partitions/core.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 31ac815d77a83c..2559bb830273eb 100644
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

