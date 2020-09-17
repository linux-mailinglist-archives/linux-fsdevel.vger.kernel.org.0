Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614CF26E226
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 19:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgIQRTy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 13:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgIQRTj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 13:19:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5BDC06174A;
        Thu, 17 Sep 2020 10:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=zqogdmLdzta9J0hBp0MDw02DVO1+TlY53BsA/rdY28w=; b=jeRYq0Vwt9pDvQPIMoyHro1yPb
        FHLgKT0EE0F3CGpywm1KG8OwiJJFjhdu5Hy+Fq27PpVMJpvD3imnqU4JlIGRl2wxMZ+GiAkM8BD3i
        m+it0FNFbx9rvkDFC3aN9wRniryRAj4Nk1oSJPmvjdUiXGihk//L8boGcBSdZr3h+Ge3whWtgPDzR
        OC5GosDEqYL4yKWdpJA9garZ+5LIlbalsvqNx95LLOLyj0vSm42XsyuE82HIf0UUbJjGLAnK/Gj1S
        jQRVwfbkcYpp2v9saNOtAMjtoYDiw6dJMW8wmaJ039NFk/htZdonS7FB1Qaalgr6m4aqI0q/+mtof
        a2k0498A==;
Received: from 089144214092.atnat0023.highway.a1.net ([89.144.214.92] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIxYu-0001lr-Fs; Thu, 17 Sep 2020 17:19:12 +0000
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
Date:   Thu, 17 Sep 2020 18:57:15 +0200
Message-Id: <20200917165720.3285256-10-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200917165720.3285256-1-hch@lst.de>
References: <20200917165720.3285256-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use blkdev_get_by_dev instead of igrab (aka open coded bdgrab) +
blkdev_get.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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

