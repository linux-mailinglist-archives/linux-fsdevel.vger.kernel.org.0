Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A207A47F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 13:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241340AbjIRLGN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 07:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237382AbjIRLF1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:05:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E855E6;
        Mon, 18 Sep 2023 04:05:22 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7FEE021AB5;
        Mon, 18 Sep 2023 11:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695035117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6w4JGP4ZAJgEQ0CQlDyJBIWo8/sjcn8nHyYU2QwWMn8=;
        b=SNVcuFDMM+tjaY0aZOxGKhu1/ySJ3PJqSZ2USKwgGMjgAO8LUzJEVGrEz4uWtz/el+FVoR
        H3VaaCmlWyBRSDX7bp3A7VqBJdX0ToKvaogaetJV5NbMk0qfhSC7MdK3iIM4u9dCIuMuqQ
        ZPaqALrbsTwA5JUUXaVt1FzLJNY4riY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695035117;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6w4JGP4ZAJgEQ0CQlDyJBIWo8/sjcn8nHyYU2QwWMn8=;
        b=1LaVmJMsp6PjF29N3PPd5t5+s6o2nQa3FGwv5ysq50aBsC8UaP8yeJqPW8d5mySRoROHsh
        5MvMZm6znij8DlCQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 692E92C15D;
        Mon, 18 Sep 2023 11:05:17 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 6C9C951CD15D; Mon, 18 Sep 2023 13:05:17 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Pankaj Raghav <p.raghav@samsung.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 16/18] brd: make logical sector size configurable
Date:   Mon, 18 Sep 2023 13:05:08 +0200
Message-Id: <20230918110510.66470-17-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230918110510.66470-1-hare@suse.de>
References: <20230918110510.66470-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a module option 'rd_logical_blksize' to allow the user to change
the logical sector size of the RAM disks.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/block/brd.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 0c5f3dbbb77c..e2e364255902 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -45,6 +45,8 @@ struct brd_device {
 	u64			brd_nr_folios;
 	unsigned int		brd_sector_shift;
 	unsigned int		brd_sector_size;
+	unsigned int		brd_logical_sector_shift;
+	unsigned int		brd_logical_sector_size;
 };
 
 #define BRD_SECTOR_SHIFT(b) ((b)->brd_sector_shift - SECTOR_SHIFT)
@@ -242,8 +244,8 @@ static void brd_submit_bio(struct bio *bio)
 		int err;
 
 		/* Don't support un-aligned buffer */
-		WARN_ON_ONCE((iter.offset & (SECTOR_SIZE - 1)) ||
-				(len & (SECTOR_SIZE - 1)));
+		WARN_ON_ONCE((iter.offset & (brd->brd_logical_sector_size - 1)) ||
+				(len & (brd->brd_logical_sector_size - 1)));
 
 		err = brd_do_folio(brd, iter.folio, len, iter.offset,
 				   bio->bi_opf, sector);
@@ -285,6 +287,10 @@ static unsigned int rd_blksize = PAGE_SIZE;
 module_param(rd_blksize, uint, 0444);
 MODULE_PARM_DESC(rd_blksize, "Blocksize of each RAM disk in bytes.");
 
+static unsigned int rd_logical_blksize = SECTOR_SIZE;
+module_param(rd_logical_blksize, uint, 0444);
+MODULE_PARM_DESC(rd_logical_blksize, "Logical blocksize of each RAM disk in bytes.");
+
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_BLOCKDEV_MAJOR(RAMDISK_MAJOR);
 MODULE_ALIAS("rd");
@@ -342,6 +348,21 @@ static int brd_alloc(int i)
 	brd->brd_sector_shift = ilog2(rd_blksize);
 	brd->brd_sector_size = rd_blksize;
 
+	if (!is_power_of_2(rd_logical_blksize)) {
+		pr_err("rd_logical_blksize %d is not supported\n",
+		       rd_logical_blksize);
+		err = -EINVAL;
+		goto out_free_dev;
+	}
+	if (rd_logical_blksize > rd_blksize) {
+		pr_err("rd_logical_blksize %d larger than rd_blksize %d\n",
+		       rd_logical_blksize, rd_blksize);
+		err = -EINVAL;
+		goto out_free_dev;
+	}
+	brd->brd_logical_sector_shift = ilog2(rd_logical_blksize);
+	brd->brd_logical_sector_size = rd_logical_blksize;
+
 	xa_init(&brd->brd_folios);
 
 	snprintf(buf, DISK_NAME_LEN, "ram%d", i);
@@ -362,6 +383,7 @@ static int brd_alloc(int i)
 	set_capacity(disk, rd_size * 2);
 
 	blk_queue_physical_block_size(disk->queue, rd_blksize);
+	blk_queue_logical_block_size(disk->queue, rd_logical_blksize);
 	blk_queue_max_hw_sectors(disk->queue, rd_max_sectors);
 
 	/* Tell the block layer that this is not a rotational device */
-- 
2.35.3

