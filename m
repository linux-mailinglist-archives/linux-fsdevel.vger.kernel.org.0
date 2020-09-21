Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E42271B9F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 09:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgIUHVN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 03:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgIUHUH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 03:20:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3C5C0613CE;
        Mon, 21 Sep 2020 00:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=kKrnsk0G0+/53OYcI1nKBJAYP0PP2drQYHczMU8H8l8=; b=h1WymipwzsfQg6HGoHFnSqm2lG
        lSXGTKndViTtD3Wqt+Prxiv9pPXKbXQhDojOLblOFVeTB6V5u0uTDKJccl4Yuj8auFwmoVkRVu8Ph
        OC4Ld6W8CSLSh8alUcRHew6l5j5n/oheWAmJxIkUZrGkDuwMeXX7eQvBUwlquYOi6qEXAmIBthDJO
        rxUP7OtZoBoTroj/4cKed9bAf5MrfY7nVCYa+Rzutl1yvPIkC83ZFIAFrBRPUAmEJoV6Fu4GmaHpe
        VHMSAXpnpQAkXRZxUjr+0vzqQmstuZnM2+5oSlYyMisXcqZC8c2nK5u9kpyXtAeJtWD6QgWv2dOwk
        Anv6OZNQ==;
Received: from p4fdb0c34.dip0.t-ipconnect.de ([79.219.12.52] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKG7A-0003Ex-FW; Mon, 21 Sep 2020 07:19:56 +0000
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
Subject: [PATCH 06/14] zram: cleanup backing_dev_store
Date:   Mon, 21 Sep 2020 09:19:50 +0200
Message-Id: <20200921071958.307589-7-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200921071958.307589-1-hch@lst.de>
References: <20200921071958.307589-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use blkdev_get_by_dev instead of bdgrab + blkdev_get.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/zram/zram_drv.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a356275605b104..91ccfe444525b4 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -491,9 +491,10 @@ static ssize_t backing_dev_store(struct device *dev,
 		goto out;
 	}
 
-	bdev = bdgrab(I_BDEV(inode));
-	err = blkdev_get(bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL, zram);
-	if (err < 0) {
+	bdev = blkdev_get_by_dev(inode->i_rdev,
+			FMODE_READ | FMODE_WRITE | FMODE_EXCL, zram);
+	if (IS_ERR(bdev)) {
+		err = PTR_ERR(bdev);
 		bdev = NULL;
 		goto out;
 	}
-- 
2.28.0

