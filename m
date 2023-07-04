Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFF87470BC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 14:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjGDMWe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 08:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjGDMWd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:22:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A979310E0;
        Tue,  4 Jul 2023 05:22:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 47B6420561;
        Tue,  4 Jul 2023 12:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688473345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Lkbb5Mje0WNsZ/GcMq2E4mZ3VWbelBu2fs1LSzkcPQ=;
        b=2pLxAh1pRyvyKfHs6iUBjXSEFJCqGi3bSKp53BgNz3VKT2rXaYPb73WM8O6veibfJNDjAv
        U5gjH49me9Akg1SEHnqTDq/AtUHde9iAC9ufiAwL/Pz6PJw/UWOh21jv21vwX/1/64wkrh
        NRB1XHp1kxS3+we4024bxGiGCQcolLs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688473345;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Lkbb5Mje0WNsZ/GcMq2E4mZ3VWbelBu2fs1LSzkcPQ=;
        b=8X8Rm1OIKXZv/4QILit2yZsdQYIFZOLrQ3jfWfDBOL0hbtsXx3diVIZWWDc3nxqC+WPI33
        RB6bVM5EwPGRDZBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 38C6C13A26;
        Tue,  4 Jul 2023 12:22:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wvbaDQEPpGQMMAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 04 Jul 2023 12:22:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A69A2A0766; Tue,  4 Jul 2023 14:22:24 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-block@vger.kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 04/32] block: Use blkdev_get_handle_by_dev() in disk_scan_partitions() and blkdev_bszset()
Date:   Tue,  4 Jul 2023 14:21:31 +0200
Message-Id: <20230704122224.16257-4-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230629165206.383-1-jack@suse.cz>
References: <20230629165206.383-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2027; i=jack@suse.cz; h=from:subject; bh=reAa4xp+ByCWL4gyc8bkQWtKEMhXKZ0Swr+DGhQCXHA=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkpA7OaCVXB9KY7/IT1z0ojWoBnzT3ileJCfCBx5+e 02X2DTeJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZKQOzgAKCRCcnaoHP2RA2antB/ oD+a76tm9xp4vV+CVPOD/YgGjMpFCURoyQ2UZv+bDW/yH/V9WZyM8hIMNIZ9jhNTaitPGrzcNQ8M7T JN1XY8dVOOXNTw2DUKs6KU/IFxtq0unxAdnMcJ8wFTFJ27vFD7iBDwx3VGk6WljOomGTlFBxZ31hXX lNX5D6RWPomtcCBeOGRpgpftAcYmxlWXBGlDpcumf/xJ0o7ZbYkT5YvhV/l5o6VkfkVdSaxXFvUUnj BHw3WiIHEBsCPXtBgW182+cUhtD+8s+RPW5pirhFTt2XEVaDtFagTB/Oodp2tXKzSyzBl4Smvu849F gMN/td41M0jvKancQCdETvoVeQM3Dj
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert disk_scan_partitions() and blkdev_bszset() to use
blkdev_get_handle_by_dev().

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/genhd.c | 12 ++++++------
 block/ioctl.c |  6 ++++--
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 3d287b32d50d..d363ddb8d93a 100644
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
+	handle = blkdev_get_handle_by_dev(disk_devt(disk),
+					  mode & ~BLK_OPEN_EXCL, NULL, NULL);
+	if (IS_ERR(handle))
+		ret = PTR_ERR(handle);
 	else
-		blkdev_put(bdev, NULL);
+		blkdev_handle_put(handle);
 
 	/*
 	 * If blkdev_get_by_dev() failed early, GD_NEED_PART_SCAN is still set,
diff --git a/block/ioctl.c b/block/ioctl.c
index 3be11941fb2d..940a7b9284c4 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -458,6 +458,7 @@ static int blkdev_bszset(struct block_device *bdev, blk_mode_t mode,
 		int __user *argp)
 {
 	int ret, n;
+	struct bdev_handle *handle;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
@@ -469,10 +470,11 @@ static int blkdev_bszset(struct block_device *bdev, blk_mode_t mode,
 	if (mode & BLK_OPEN_EXCL)
 		return set_blocksize(bdev, n);
 
-	if (IS_ERR(blkdev_get_by_dev(bdev->bd_dev, mode, &bdev, NULL)))
+	handle = blkdev_get_handle_by_dev(bdev->bd_dev, mode, &bdev, NULL);
+	if (IS_ERR(handle))
 		return -EBUSY;
 	ret = set_blocksize(bdev, n);
-	blkdev_put(bdev, &bdev);
+	blkdev_handle_put(handle);
 
 	return ret;
 }
-- 
2.35.3

