Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFA37B0083
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 11:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjI0Jfa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 05:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjI0JfA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:35:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889B819E;
        Wed, 27 Sep 2023 02:34:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 477711FD65;
        Wed, 27 Sep 2023 09:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695807284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QNzpMGFLbXGYyaDQMuHHrPGqnw1mg4byVLBZHI5POWw=;
        b=dhTih9m3roXywxSf0PYyUPDmy0VPLOvsp8nEKVvr4gBSbRFtMs0OUJsa2ZnnBXJ4cez5fJ
        PTo00umlZ8SCUxsd/CVq+/3i2NChrpvG58kZNS2FATVv423IaUSOThR4sunVvCFGKQftEk
        sqOtzsvu2XL7sM+muXJr9VxjqjUOWX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695807284;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QNzpMGFLbXGYyaDQMuHHrPGqnw1mg4byVLBZHI5POWw=;
        b=EqtnEcCHsih9E3xCcP4ztpSItzJ5oOhxmUlMFCugZ2rFjBIMA3fnPmQk/GQG/qfMiHIwaC
        BehVYn/s/LKnfSBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3188E13ADA;
        Wed, 27 Sep 2023 09:34:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ye4VDDT3E2UaEwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 27 Sep 2023 09:34:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3DB02A07E0; Wed, 27 Sep 2023 11:34:43 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Joern Engel <joern@lazybastard.org>,
        linux-mtd@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 12/29] mtd: block2mtd: Convert to bdev_open_by_dev/path()
Date:   Wed, 27 Sep 2023 11:34:18 +0200
Message-Id: <20230927093442.25915-12-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230818123232.2269-1-jack@suse.cz>
References: <20230818123232.2269-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6174; i=jack@suse.cz; h=from:subject; bh=vjNGCOpPsLqBxuk0X44cou8DAKQ9UCL0vlz44FO0WT0=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlE/cbksy3muvEYOZaqIZZ0q/mmtSNovzidh4fw9aj OhnwPcWJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZRP3GwAKCRCcnaoHP2RA2QJtB/ 4qhIGS3HTRgFAzJhoDzBrmjFU97hkHr0R0ppTTwXzoE65gL/A2+FAKHFpknPcbTutz3EA8T1OY/KMY 2IRfi29E8658ylcRCT/vCadWfj/1Lw+fPni+VaGTujsaWkE8OWKyazxHNIigEUm7FGoGmyWuqzglxA uNtwqQcpTLdQ8LKfResTxzOjK0rHk+nUgOKbsVb8jSpK92CkzvCKKdAPhEHjL5QBf2U1bVSJzRb72g NnXJqhei9hAFiVJBbQt7P9mT7tOm5PtLA8DxBwOcY9Zx7KJYDnshFOIuKeIhEWm5KhDPS4PHkjONBM c9GbXeIjX0TN/FPw8O7duecoouKija
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert block2mtd to use bdev_open_by_dev() and bdev_open_by_path() and
pass the handle around.

CC: Joern Engel <joern@lazybastard.org>
CC: linux-mtd@lists.infradead.org
Acked-by: Christoph Hellwig <hch@lst.de>
Acked-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/mtd/devices/block2mtd.c | 51 +++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 22 deletions(-)

diff --git a/drivers/mtd/devices/block2mtd.c b/drivers/mtd/devices/block2mtd.c
index be106dc20ff3..aa44a23ec045 100644
--- a/drivers/mtd/devices/block2mtd.c
+++ b/drivers/mtd/devices/block2mtd.c
@@ -37,7 +37,7 @@
 /* Info for the block device */
 struct block2mtd_dev {
 	struct list_head list;
-	struct block_device *blkdev;
+	struct bdev_handle *bdev_handle;
 	struct mtd_info mtd;
 	struct mutex write_mutex;
 };
@@ -55,7 +55,8 @@ static struct page *page_read(struct address_space *mapping, pgoff_t index)
 /* erase a specified part of the device */
 static int _block2mtd_erase(struct block2mtd_dev *dev, loff_t to, size_t len)
 {
-	struct address_space *mapping = dev->blkdev->bd_inode->i_mapping;
+	struct address_space *mapping =
+				dev->bdev_handle->bdev->bd_inode->i_mapping;
 	struct page *page;
 	pgoff_t index = to >> PAGE_SHIFT;	// page index
 	int pages = len >> PAGE_SHIFT;
@@ -105,6 +106,8 @@ static int block2mtd_read(struct mtd_info *mtd, loff_t from, size_t len,
 		size_t *retlen, u_char *buf)
 {
 	struct block2mtd_dev *dev = mtd->priv;
+	struct address_space *mapping =
+				dev->bdev_handle->bdev->bd_inode->i_mapping;
 	struct page *page;
 	pgoff_t index = from >> PAGE_SHIFT;
 	int offset = from & (PAGE_SIZE-1);
@@ -117,7 +120,7 @@ static int block2mtd_read(struct mtd_info *mtd, loff_t from, size_t len,
 			cpylen = len;	// this page
 		len = len - cpylen;
 
-		page = page_read(dev->blkdev->bd_inode->i_mapping, index);
+		page = page_read(mapping, index);
 		if (IS_ERR(page))
 			return PTR_ERR(page);
 
@@ -139,7 +142,8 @@ static int _block2mtd_write(struct block2mtd_dev *dev, const u_char *buf,
 		loff_t to, size_t len, size_t *retlen)
 {
 	struct page *page;
-	struct address_space *mapping = dev->blkdev->bd_inode->i_mapping;
+	struct address_space *mapping =
+				dev->bdev_handle->bdev->bd_inode->i_mapping;
 	pgoff_t index = to >> PAGE_SHIFT;	// page index
 	int offset = to & ~PAGE_MASK;	// page offset
 	int cpylen;
@@ -194,7 +198,7 @@ static int block2mtd_write(struct mtd_info *mtd, loff_t to, size_t len,
 static void block2mtd_sync(struct mtd_info *mtd)
 {
 	struct block2mtd_dev *dev = mtd->priv;
-	sync_blockdev(dev->blkdev);
+	sync_blockdev(dev->bdev_handle->bdev);
 	return;
 }
 
@@ -206,10 +210,10 @@ static void block2mtd_free_device(struct block2mtd_dev *dev)
 
 	kfree(dev->mtd.name);
 
-	if (dev->blkdev) {
-		invalidate_mapping_pages(dev->blkdev->bd_inode->i_mapping,
-					0, -1);
-		blkdev_put(dev->blkdev, NULL);
+	if (dev->bdev_handle) {
+		invalidate_mapping_pages(
+			dev->bdev_handle->bdev->bd_inode->i_mapping, 0, -1);
+		bdev_release(dev->bdev_handle);
 	}
 
 	kfree(dev);
@@ -219,10 +223,10 @@ static void block2mtd_free_device(struct block2mtd_dev *dev)
  * This function is marked __ref because it calls the __init marked
  * early_lookup_bdev when called from the early boot code.
  */
-static struct block_device __ref *mdtblock_early_get_bdev(const char *devname,
+static struct bdev_handle __ref *mdtblock_early_get_bdev(const char *devname,
 		blk_mode_t mode, int timeout, struct block2mtd_dev *dev)
 {
-	struct block_device *bdev = ERR_PTR(-ENODEV);
+	struct bdev_handle *bdev_handle = ERR_PTR(-ENODEV);
 #ifndef MODULE
 	int i;
 
@@ -230,7 +234,7 @@ static struct block_device __ref *mdtblock_early_get_bdev(const char *devname,
 	 * We can't use early_lookup_bdev from a running system.
 	 */
 	if (system_state >= SYSTEM_RUNNING)
-		return bdev;
+		return bdev_handle;
 
 	/*
 	 * We might not have the root device mounted at this point.
@@ -249,19 +253,20 @@ static struct block_device __ref *mdtblock_early_get_bdev(const char *devname,
 		wait_for_device_probe();
 
 		if (!early_lookup_bdev(devname, &devt)) {
-			bdev = blkdev_get_by_dev(devt, mode, dev, NULL);
-			if (!IS_ERR(bdev))
+			bdev_handle = bdev_open_by_dev(devt, mode, dev, NULL);
+			if (!IS_ERR(bdev_handle))
 				break;
 		}
 	}
 #endif
-	return bdev;
+	return bdev_handle;
 }
 
 static struct block2mtd_dev *add_device(char *devname, int erase_size,
 		char *label, int timeout)
 {
 	const blk_mode_t mode = BLK_OPEN_READ | BLK_OPEN_WRITE;
+	struct bdev_handle *bdev_handle;
 	struct block_device *bdev;
 	struct block2mtd_dev *dev;
 	char *name;
@@ -274,21 +279,23 @@ static struct block2mtd_dev *add_device(char *devname, int erase_size,
 		return NULL;
 
 	/* Get a handle on the device */
-	bdev = blkdev_get_by_path(devname, mode, dev, NULL);
-	if (IS_ERR(bdev))
-		bdev = mdtblock_early_get_bdev(devname, mode, timeout, dev);
-	if (IS_ERR(bdev)) {
+	bdev_handle = bdev_open_by_path(devname, mode, dev, NULL);
+	if (IS_ERR(bdev_handle))
+		bdev_handle = mdtblock_early_get_bdev(devname, mode, timeout,
+						      dev);
+	if (IS_ERR(bdev_handle)) {
 		pr_err("error: cannot open device %s\n", devname);
 		goto err_free_block2mtd;
 	}
-	dev->blkdev = bdev;
+	dev->bdev_handle = bdev_handle;
+	bdev = bdev_handle->bdev;
 
 	if (MAJOR(bdev->bd_dev) == MTD_BLOCK_MAJOR) {
 		pr_err("attempting to use an MTD device as a block device\n");
 		goto err_free_block2mtd;
 	}
 
-	if ((long)dev->blkdev->bd_inode->i_size % erase_size) {
+	if ((long)bdev->bd_inode->i_size % erase_size) {
 		pr_err("erasesize must be a divisor of device size\n");
 		goto err_free_block2mtd;
 	}
@@ -306,7 +313,7 @@ static struct block2mtd_dev *add_device(char *devname, int erase_size,
 
 	dev->mtd.name = name;
 
-	dev->mtd.size = dev->blkdev->bd_inode->i_size & PAGE_MASK;
+	dev->mtd.size = bdev->bd_inode->i_size & PAGE_MASK;
 	dev->mtd.erasesize = erase_size;
 	dev->mtd.writesize = 1;
 	dev->mtd.writebufsize = PAGE_SIZE;
-- 
2.35.3

