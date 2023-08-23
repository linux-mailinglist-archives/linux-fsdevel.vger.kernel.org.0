Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70FB7855E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 12:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbjHWKt3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 06:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjHWKtZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:49:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A775AE66;
        Wed, 23 Aug 2023 03:48:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1847021ED2;
        Wed, 23 Aug 2023 10:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692787738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bkzW0RFPf6wHhgQUVoSt6Pj5UuLR3KcbmcoCJXwMkfc=;
        b=KW+n6zMdItMM0WynGcTFHRzTMFuIaaKTDRR4xbrnBZ7z0w+m4NcM0/LBOkJg2Iu320IxTY
        aZN8ocb3SXQBMkV8ieZeMlJa7mLSyw/ubxFrUuxCvd2T9euBLKMyneifCHaia8GuL0WWn2
        44IdK680cm02GIYI8qqkF3dQiWNnSu0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692787738;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bkzW0RFPf6wHhgQUVoSt6Pj5UuLR3KcbmcoCJXwMkfc=;
        b=1lZwJ8nohhETVHg75LeJekz07bi2IigXah6K2WydgihTku3w7bC6C/lswpEhibaI7woaT6
        oLdAS4I11Nk+fDDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0944A139D0;
        Wed, 23 Aug 2023 10:48:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3lEbARrk5WQqIAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 23 Aug 2023 10:48:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1DA85A077C; Wed, 23 Aug 2023 12:48:57 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, <linux-fsdevel@vger.kernel.org>,
        <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 03/29] block: Use bdev_open_by_dev() in disk_scan_partitions() and blkdev_bszset()
Date:   Wed, 23 Aug 2023 12:48:14 +0200
Message-Id: <20230823104857.11437-3-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230818123232.2269-1-jack@suse.cz>
References: <20230818123232.2269-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2034; i=jack@suse.cz; h=from:subject; bh=Akjd81RXnoKuESmfkgLLjphi9Qm7pAgGZzxphElfw0U=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBk5ePwgABplRysCYANDJEaSguR1Jf2xdoUnRwFflmn nrtJNNaJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZOXj8AAKCRCcnaoHP2RA2Su6B/ 9LHnICIth6cx4ElrC9OeaRdyImXsnlI9c1NInuf8tqr65aF7p2nfxRG8QaCJR3ddtlRS4ReTfCPGIy Tj6oiIBx73bxzVjtf1MyXEsnl01323vDYzLbXDsxZt5RYNd7DQKPS42/CdXATJEQ06ybAKaS1dxR/o jy38qmFvNcvZlB5AR4p0XrX0Y6IbahdrcQyT7walzNCtQielJ50Kp3dQqbMlfKQUKVwgASG81xronh f3hoCua70nPU4IZgZkDQWk5zXmPga55ucpLc5TCEgq6t2W8KUfqzdxg8Xnydvt/NVeHUrNpqbwOMvw xwRuQfVgJczdk5PY1pXLTJE0r6ky1P
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert disk_scan_partitions() and blkdev_bszset() to use
bdev_open_by_dev().

Acked-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/genhd.c | 12 ++++++------
 block/ioctl.c |  6 ++++--
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index cc32a0c704eb..4a16a424f57d 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -342,7 +342,7 @@ EXPORT_SYMBOL_GPL(disk_uevent);
 
 int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode)
 {
-	struct block_device *bdev;
+	struct bdev_handle *handle;
 	int ret = 0;
 
 	if (disk->flags & (GENHD_FL_NO_PART | GENHD_FL_HIDDEN))
@@ -366,12 +366,12 @@ int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode)
 	}
 
 	set_bit(GD_NEED_PART_SCAN, &disk->state);
-	bdev = blkdev_get_by_dev(disk_devt(disk), mode & ~BLK_OPEN_EXCL, NULL,
-				 NULL);
-	if (IS_ERR(bdev))
-		ret =  PTR_ERR(bdev);
+	handle = bdev_open_by_dev(disk_devt(disk), mode & ~BLK_OPEN_EXCL, NULL,
+				  NULL);
+	if (IS_ERR(handle))
+		ret = PTR_ERR(handle);
 	else
-		blkdev_put(bdev, NULL);
+		bdev_release(handle);
 
 	/*
 	 * If blkdev_get_by_dev() failed early, GD_NEED_PART_SCAN is still set,
diff --git a/block/ioctl.c b/block/ioctl.c
index 54c1e2f71031..2e46dc38424c 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -465,6 +465,7 @@ static int blkdev_bszset(struct block_device *bdev, blk_mode_t mode,
 		int __user *argp)
 {
 	int ret, n;
+	struct bdev_handle *handle;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
@@ -476,10 +477,11 @@ static int blkdev_bszset(struct block_device *bdev, blk_mode_t mode,
 	if (mode & BLK_OPEN_EXCL)
 		return set_blocksize(bdev, n);
 
-	if (IS_ERR(blkdev_get_by_dev(bdev->bd_dev, mode, &bdev, NULL)))
+	handle = bdev_open_by_dev(bdev->bd_dev, mode, &bdev, NULL);
+	if (IS_ERR(handle))
 		return -EBUSY;
 	ret = set_blocksize(bdev, n);
-	blkdev_put(bdev, &bdev);
+	bdev_release(handle);
 
 	return ret;
 }
-- 
2.35.3

