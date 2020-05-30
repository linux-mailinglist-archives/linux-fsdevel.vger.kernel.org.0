Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFAF1E90D5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 13:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgE3Ldm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 May 2020 07:33:42 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47000 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728304AbgE3Ldm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 May 2020 07:33:42 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E3206B0D01E1345457AB;
        Sat, 30 May 2020 19:33:36 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Sat, 30 May 2020
 19:33:26 +0800
From:   Zheng Bin <zhengbin13@huawei.com>
To:     <hch@infradead.org>, <axboe@kernel.dk>, <bvanassche@acm.org>,
        <jaegeuk@kernel.org>, <viro@zeniv.linux.org.uk>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC:     <houtao1@huawei.com>, <yi.zhang@huawei.com>,
        <zhengbin13@huawei.com>
Subject: [PATCH v2 1/2] loop: replace kill_bdev with invalidate_bdev
Date:   Sat, 30 May 2020 19:40:31 +0800
Message-ID: <20200530114032.125678-2-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
In-Reply-To: <20200530114032.125678-1-zhengbin13@huawei.com>
References: <20200530114032.125678-1-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When a filesystem is mounted on a loop device and on a loop ioctl
LOOP_SET_STATUS64, because of kill_bdev, buffer_head mappings are getting
destroyed.
kill_bdev
  truncate_inode_pages
    truncate_inode_pages_range
      do_invalidatepage
        block_invalidatepage
          discard_buffer  -->clear BH_Mapped flag

sb_bread
  __bread_gfp
  bh = __getblk_gfp
  -->discard_buffer clear BH_Mapped flag
  __bread_slow
    submit_bh
      submit_bh_wbc
        BUG_ON(!buffer_mapped(bh))  --> hit this BUG_ON

Fixes: 5db470e229e2 ("loop: drop caches if offset or block_size are changed")
Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index da693e6a834e..418bb4621255 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1289,7 +1289,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	if (lo->lo_offset != info->lo_offset ||
 	    lo->lo_sizelimit != info->lo_sizelimit) {
 		sync_blockdev(lo->lo_device);
-		kill_bdev(lo->lo_device);
+		invalidate_bdev(lo->lo_device);
 	}

 	/* I/O need to be drained during transfer transition */
@@ -1320,7 +1320,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)

 	if (lo->lo_offset != info->lo_offset ||
 	    lo->lo_sizelimit != info->lo_sizelimit) {
-		/* kill_bdev should have truncated all the pages */
+		/* invalidate_bdev should have truncated all the pages */
 		if (lo->lo_device->bd_inode->i_mapping->nrpages) {
 			err = -EAGAIN;
 			pr_warn("%s: loop%d (%s) has still dirty pages (nrpages=%lu)\n",
@@ -1565,11 +1565,11 @@ static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
 		return 0;

 	sync_blockdev(lo->lo_device);
-	kill_bdev(lo->lo_device);
+	invalidate_bdev(lo->lo_device);

 	blk_mq_freeze_queue(lo->lo_queue);

-	/* kill_bdev should have truncated all the pages */
+	/* invalidate_bdev should have truncated all the pages */
 	if (lo->lo_device->bd_inode->i_mapping->nrpages) {
 		err = -EAGAIN;
 		pr_warn("%s: loop%d (%s) has still dirty pages (nrpages=%lu)\n",
--
2.21.3

