Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A315426E1FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 19:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgIQRPX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 13:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbgIQRPB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 13:15:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DFAC06174A;
        Thu, 17 Sep 2020 10:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=OOOyqbfGBfADtTd2OFjO0d+j7/uUOQY5tAGUzrpX3bI=; b=ORRt5MKKZE1a7tEe+EqgJQPMiw
        q80Zt28VgUFf4COG0BxYMD6goAGTR6QbmxD4kB0As5TKbbnXDLnA2+hGHfbLdS1stxrHHkQbLo1My
        hxKxgrc08cIVuJOwaTDMKWk02CMmaMZjV6Vc+SelGVAo5CSFReaEl9Vs1n7KHG1lbdZJ/8FxWe2n0
        3yu9Jwb58lKTb3qHumLGdJcz4CPHg/tbJ5DC/yxixuWtwKGlOvaaMexlA7j9d6K9p7rdbsWkf16It
        vRo0LQcOOt6EXPuh3rdvappPHcMGbZDWT/A2HdJ3FAUqOnnfuxqSuLAbSk1kP4ABlocfJtnUjErLo
        c+JgCvxQ==;
Received: from 089144214092.atnat0023.highway.a1.net ([89.144.214.92] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIxUg-0001TE-BL; Thu, 17 Sep 2020 17:14:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        linux-ide@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        linux-pm@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: [PATCH 07/14] raw: don't keep unopened block device around
Date:   Thu, 17 Sep 2020 18:57:13 +0200
Message-Id: <20200917165720.3285256-8-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200917165720.3285256-1-hch@lst.de>
References: <20200917165720.3285256-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Turn binding into a normal dev_t as the struct block device doesn't
buy us anything and use blkdev_open_by_dev to actually open it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/char/raw.c | 51 +++++++++++++++++-----------------------------
 1 file changed, 19 insertions(+), 32 deletions(-)

diff --git a/drivers/char/raw.c b/drivers/char/raw.c
index ccf5bd528642da..5d52a1f4738c76 100644
--- a/drivers/char/raw.c
+++ b/drivers/char/raw.c
@@ -28,7 +28,8 @@
 #include <linux/uaccess.h>
 
 struct raw_device_data {
-	struct block_device *binding;
+	dev_t binding;
+	struct block_device *bdev;
 	int inuse;
 };
 
@@ -73,14 +74,15 @@ static int raw_open(struct inode *inode, struct file *filp)
 	/*
 	 * All we need to do on open is check that the device is bound.
 	 */
-	bdev = raw_devices[minor].binding;
 	err = -ENODEV;
-	if (!bdev)
+	if (!raw_devices[minor].binding)
 		goto out;
-	bdgrab(bdev);
-	err = blkdev_get(bdev, filp->f_mode | FMODE_EXCL, raw_open);
-	if (err)
+	bdev = blkdev_get_by_dev(raw_devices[minor].binding,
+				 filp->f_mode | FMODE_EXCL, raw_open);
+	if (IS_ERR(bdev)) {
+		err = PTR_ERR(bdev);
 		goto out;
+	}
 	err = set_blocksize(bdev, bdev_logical_block_size(bdev));
 	if (err)
 		goto out1;
@@ -90,6 +92,7 @@ static int raw_open(struct inode *inode, struct file *filp)
 		file_inode(filp)->i_mapping =
 			bdev->bd_inode->i_mapping;
 	filp->private_data = bdev;
+	raw_devices[minor].bdev = bdev;
 	mutex_unlock(&raw_mutex);
 	return 0;
 
@@ -110,7 +113,7 @@ static int raw_release(struct inode *inode, struct file *filp)
 	struct block_device *bdev;
 
 	mutex_lock(&raw_mutex);
-	bdev = raw_devices[minor].binding;
+	bdev = raw_devices[minor].bdev;
 	if (--raw_devices[minor].inuse == 0)
 		/* Here  inode->i_mapping == bdev->bd_inode->i_mapping  */
 		inode->i_mapping = &inode->i_data;
@@ -133,6 +136,7 @@ raw_ioctl(struct file *filp, unsigned int command, unsigned long arg)
 static int bind_set(int number, u64 major, u64 minor)
 {
 	dev_t dev = MKDEV(major, minor);
+	dev_t raw = MKDEV(RAW_MAJOR, number);
 	struct raw_device_data *rawdev;
 	int err = 0;
 
@@ -166,25 +170,17 @@ static int bind_set(int number, u64 major, u64 minor)
 		mutex_unlock(&raw_mutex);
 		return -EBUSY;
 	}
-	if (rawdev->binding) {
-		bdput(rawdev->binding);
+	if (rawdev->binding)
 		module_put(THIS_MODULE);
-	}
+
+	rawdev->binding = dev;
 	if (!dev) {
 		/* unbind */
-		rawdev->binding = NULL;
-		device_destroy(raw_class, MKDEV(RAW_MAJOR, number));
+		device_destroy(raw_class, raw);
 	} else {
-		rawdev->binding = bdget(dev);
-		if (rawdev->binding == NULL) {
-			err = -ENOMEM;
-		} else {
-			dev_t raw = MKDEV(RAW_MAJOR, number);
-			__module_get(THIS_MODULE);
-			device_destroy(raw_class, raw);
-			device_create(raw_class, NULL, raw, NULL,
-				      "raw%d", number);
-		}
+		__module_get(THIS_MODULE);
+		device_destroy(raw_class, raw);
+		device_create(raw_class, NULL, raw, NULL, "raw%d", number);
 	}
 	mutex_unlock(&raw_mutex);
 	return err;
@@ -192,18 +188,9 @@ static int bind_set(int number, u64 major, u64 minor)
 
 static int bind_get(int number, dev_t *dev)
 {
-	struct raw_device_data *rawdev;
-	struct block_device *bdev;
-
 	if (number <= 0 || number >= max_raw_minors)
 		return -EINVAL;
-
-	rawdev = &raw_devices[number];
-
-	mutex_lock(&raw_mutex);
-	bdev = rawdev->binding;
-	*dev = bdev ? bdev->bd_dev : 0;
-	mutex_unlock(&raw_mutex);
+	*dev = raw_devices[number].binding;
 	return 0;
 }
 
-- 
2.28.0

