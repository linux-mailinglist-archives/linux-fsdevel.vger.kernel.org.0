Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1FC25962F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 18:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731976AbgIAP7W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Sep 2020 11:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730331AbgIAP6S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:58:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E59DC061245;
        Tue,  1 Sep 2020 08:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=YEpQxN/tPsUCQFZoeqkrzaPHhhl8x81h/vM0+OyoL28=; b=jH0wC/gLb4OEfKTPkMKn4/dwIB
        06OVZMsHWVv/8Ms5vHWtqbTepow87YxpfqdfzYvT8ngNVJWvmGyH+d3oWmigSSoF1/U8bWSw87zoj
        R7WHGvxsM+OYDjT8alV54CgTTC2LTLkX4FklDK0cOp6L2CfU3NF/Uz4QfqZrf3hrYjavcdH1O3IPt
        yWkaAefpWZnYievyIqsT0JwcH/F105z9MikBVHa3n2TqnYa/Rv7Ee1nknCwck4ProTZ8WWldT08x4
        ugsxov6xkqNTiwoKWr18ACNEGfX/ofsRGcs/7PECZtJcFhzLkuJXENLWc35VlThOG6sV0pnbdb9LA
        uMBE2png==;
Received: from [2001:4bb8:18c:45ba:2f95:e5:ca6b:9b4a] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kD8fe-0004S0-Bi; Tue, 01 Sep 2020 15:58:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Dan Williams <dan.j.williams@intel.com>, dm-devel@redhat.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        nbd@other.debian.org, ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-raid@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 9/9] block: remove revalidate_disk()
Date:   Tue,  1 Sep 2020 17:57:48 +0200
Message-Id: <20200901155748.2884-10-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901155748.2884-1-hch@lst.de>
References: <20200901155748.2884-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove the now unused helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/md.h       |  2 +-
 fs/block_dev.c        | 19 -------------------
 include/linux/genhd.h |  1 -
 3 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/md/md.h b/drivers/md/md.h
index d9c4e6b7e9398d..f9e2ccdd22c478 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -397,7 +397,7 @@ struct mddev {
 	 * These locks are separate due to conflicting interactions
 	 * with bdev->bd_mutex.
 	 * Lock ordering is:
-	 *  reconfig_mutex -> bd_mutex : e.g. do_md_run -> revalidate_disk
+	 *  reconfig_mutex -> bd_mutex
 	 *  bd_mutex -> open_mutex:  e.g. __blkdev_get -> md_open
 	 */
 	struct mutex			open_mutex;
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 85f013315d48b3..0771836d0220bd 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1339,25 +1339,6 @@ void revalidate_disk_size(struct gendisk *disk, bool verbose)
 }
 EXPORT_SYMBOL(revalidate_disk_size);
 
-/**
- * revalidate_disk - wrapper for lower-level driver's revalidate_disk call-back
- * @disk: struct gendisk to be revalidated
- *
- * This routine is a wrapper for lower-level driver's revalidate_disk
- * call-backs.  It is used to do common pre and post operations needed
- * for all revalidate_disk operations.
- */
-int revalidate_disk(struct gendisk *disk)
-{
-	int ret = 0;
-
-	if (disk->fops->revalidate_disk)
-		ret = disk->fops->revalidate_disk(disk);
-	revalidate_disk_size(disk, ret == 0);
-	return ret;
-}
-EXPORT_SYMBOL(revalidate_disk);
-
 /*
  * This routine checks whether a removable media has been changed,
  * and invalidates all buffer-cache-entries in that case. This
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index c340b392452ce6..2cdc41a3fb6a57 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -372,7 +372,6 @@ extern void blk_unregister_region(dev_t devt, unsigned long range);
 int register_blkdev(unsigned int major, const char *name);
 void unregister_blkdev(unsigned int major, const char *name);
 
-int revalidate_disk(struct gendisk *disk);
 void revalidate_disk_size(struct gendisk *disk, bool verbose);
 int check_disk_change(struct block_device *bdev);
 int __invalidate_device(struct block_device *bdev, bool kill_dirty);
-- 
2.28.0

