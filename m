Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C40271B5F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 09:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgIUHUT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 03:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgIUHUQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 03:20:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D55C0613D4;
        Mon, 21 Sep 2020 00:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Kr2+p2HR1nssIehKr/ZTjYDHrW6/Q4oBo+Y/OmGsqnM=; b=abFdUakMHuXEUxMyAnaArSfxcl
        ZWyR5P68nfjx1L8srsfXmjbadYr0atK34Ljowl563xZnCJysFzV+1dmtRYxOUSxjJc6xSytnetpAK
        5fC8PfB7oVL5CHmCtYoRdG6+empRE9Suocw6s9cksbEf4vzn6hUN3ms/gxj+ZEdeJv0X7v64zLpEc
        rVpKEzhTDw0iryrwwMAZoJ4r1UBKlYhIr3Ty8kKpDbyFdkPH7bvJdVQ3mEq2cZxMFoa4grUlf++VK
        Rd8sc1pwogP72aR3OQLMl/xXoOPGMJVDeBao+tAwI1/wyHklSihXxRlDVkTOv8GOjbHlfxEVczsKQ
        5VFg74NQ==;
Received: from p4fdb0c34.dip0.t-ipconnect.de ([79.219.12.52] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKG7D-0003FX-9O; Mon, 21 Sep 2020 07:19:59 +0000
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
Subject: [PATCH 09/14] ocfs2: cleanup o2hb_region_dev_store
Date:   Mon, 21 Sep 2020 09:19:53 +0200
Message-Id: <20200921071958.307589-10-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200921071958.307589-1-hch@lst.de>
References: <20200921071958.307589-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use blkdev_get_by_dev instead of igrab (aka open coded bdgrab) +
blkdev_get.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
 fs/ocfs2/cluster/heartbeat.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index 89d13e0705fe7b..0179a73a3fa2c4 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -1766,7 +1766,6 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
 	int sectsize;
 	char *p = (char *)page;
 	struct fd f;
-	struct inode *inode;
 	ssize_t ret = -EINVAL;
 	int live_threshold;
 
@@ -1793,20 +1792,16 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
 	    reg->hr_block_bytes == 0)
 		goto out2;
 
-	inode = igrab(f.file->f_mapping->host);
-	if (inode == NULL)
+	if (!S_ISBLK(f.file->f_mapping->host->i_mode))
 		goto out2;
 
-	if (!S_ISBLK(inode->i_mode))
-		goto out3;
-
-	reg->hr_bdev = I_BDEV(f.file->f_mapping->host);
-	ret = blkdev_get(reg->hr_bdev, FMODE_WRITE | FMODE_READ, NULL);
-	if (ret) {
+	reg->hr_bdev = blkdev_get_by_dev(f.file->f_mapping->host->i_rdev,
+					 FMODE_WRITE | FMODE_READ, NULL);
+	if (IS_ERR(reg->hr_bdev)) {
+		ret = PTR_ERR(reg->hr_bdev);
 		reg->hr_bdev = NULL;
-		goto out3;
+		goto out2;
 	}
-	inode = NULL;
 
 	bdevname(reg->hr_bdev, reg->hr_dev_name);
 
@@ -1909,16 +1904,13 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
 		       config_item_name(&reg->hr_item), reg->hr_dev_name);
 
 out3:
-	iput(inode);
+	if (ret < 0) {
+		blkdev_put(reg->hr_bdev, FMODE_READ | FMODE_WRITE);
+		reg->hr_bdev = NULL;
+	}
 out2:
 	fdput(f);
 out:
-	if (ret < 0) {
-		if (reg->hr_bdev) {
-			blkdev_put(reg->hr_bdev, FMODE_READ|FMODE_WRITE);
-			reg->hr_bdev = NULL;
-		}
-	}
 	return ret;
 }
 
-- 
2.28.0

