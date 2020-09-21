Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A52A6271B92
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 09:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgIUHUR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 03:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgIUHUH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 03:20:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64ACC0613D0;
        Mon, 21 Sep 2020 00:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=mK3IFrmKleYuDfPBu63jJazzBdauHkYdgkU6Y/JSZC8=; b=WNqTBIMOPCX7jPmyxhZHIGiZXL
        X54zbFtIGp1EVhQ0T70mguh6oWP0ez2yzi/MA8sErwgmZKhWKjhNfpIasBHAK6pOyrxLzXh5dLDed
        hHyxLf2UMs3aVvew5jXcOZXfHtUMRir0ynh0FWAK3sgBLb2vU7a3vJ5mEDSY4zf/UmB8fTV48QiiP
        E9QXiNAcnkn+pTjR+OOX5NcmvHGzRE4bTYyb0hL2mbmAB6GgkAIvbo2449VSsxVo3+am0Od1lwrAz
        nPQPR6C81/DDuFEDaH/6J7TasFFjQEPr0RbNfzfhGelHwt9w0t36aYqNCX5Hf8+sik2SFxHeJz0YQ
        uYgPc5rQ==;
Received: from p4fdb0c34.dip0.t-ipconnect.de ([79.219.12.52] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKG79-0003Em-H2; Mon, 21 Sep 2020 07:19:55 +0000
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
Subject: [PATCH 05/14] pktcdvd: use blkdev_get_by_dev instead of open coding it
Date:   Mon, 21 Sep 2020 09:19:49 +0200
Message-Id: <20200921071958.307589-6-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200921071958.307589-1-hch@lst.de>
References: <20200921071958.307589-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Replace bdget + blkdev_get by blkdev_get_by_dev.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/pktcdvd.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index bc870a5f15f77b..467dbd06b7cdb1 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2110,16 +2110,18 @@ static int pkt_open_dev(struct pktcdvd_device *pd, fmode_t write)
 	int ret;
 	long lba;
 	struct request_queue *q;
+	struct block_device *bdev;
 
 	/*
 	 * We need to re-open the cdrom device without O_NONBLOCK to be able
 	 * to read/write from/to it. It is already opened in O_NONBLOCK mode
-	 * so bdget() can't fail.
+	 * so open should not fail.
 	 */
-	bdget(pd->bdev->bd_dev);
-	ret = blkdev_get(pd->bdev, FMODE_READ | FMODE_EXCL, pd);
-	if (ret)
+	bdev = blkdev_get_by_dev(pd->bdev->bd_dev, FMODE_READ | FMODE_EXCL, pd);
+	if (IS_ERR(bdev)) {
+		ret = PTR_ERR(bdev);
 		goto out;
+	}
 
 	ret = pkt_get_last_written(pd, &lba);
 	if (ret) {
@@ -2163,7 +2165,7 @@ static int pkt_open_dev(struct pktcdvd_device *pd, fmode_t write)
 	return 0;
 
 out_putdev:
-	blkdev_put(pd->bdev, FMODE_READ | FMODE_EXCL);
+	blkdev_put(bdev, FMODE_READ | FMODE_EXCL);
 out:
 	return ret;
 }
@@ -2500,7 +2502,6 @@ static int pkt_seq_show(struct seq_file *m, void *p)
 static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 {
 	int i;
-	int ret = 0;
 	char b[BDEVNAME_SIZE];
 	struct block_device *bdev;
 
@@ -2523,12 +2524,9 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 		}
 	}
 
-	bdev = bdget(dev);
-	if (!bdev)
-		return -ENOMEM;
-	ret = blkdev_get(bdev, FMODE_READ | FMODE_NDELAY, NULL);
-	if (ret)
-		return ret;
+	bdev = blkdev_get_by_dev(dev, FMODE_READ | FMODE_NDELAY, NULL);
+	if (IS_ERR(bdev))
+		return PTR_ERR(bdev);
 	if (!blk_queue_scsi_passthrough(bdev_get_queue(bdev))) {
 		blkdev_put(bdev, FMODE_READ | FMODE_NDELAY);
 		return -EINVAL;
@@ -2546,7 +2544,6 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 	pd->cdrw.thread = kthread_run(kcdrwd, pd, "%s", pd->name);
 	if (IS_ERR(pd->cdrw.thread)) {
 		pkt_err(pd, "can't start kernel thread\n");
-		ret = -ENOMEM;
 		goto out_mem;
 	}
 
@@ -2558,7 +2555,7 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 	blkdev_put(bdev, FMODE_READ | FMODE_NDELAY);
 	/* This is safe: open() is still holding a reference. */
 	module_put(THIS_MODULE);
-	return ret;
+	return -ENOMEM;
 }
 
 static int pkt_ioctl(struct block_device *bdev, fmode_t mode, unsigned int cmd, unsigned long arg)
-- 
2.28.0

