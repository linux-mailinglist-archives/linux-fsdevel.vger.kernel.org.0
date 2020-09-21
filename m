Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD49271B6F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 09:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgIUHUU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 03:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbgIUHUQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 03:20:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D6FC0613D5;
        Mon, 21 Sep 2020 00:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=dTpGHfaq95OXqjnAvo7A5jn1vW+VHQingvSWd7mRhfA=; b=QdOcNposcwYu+a18qo8HKUQOVa
        owxQ93mb8hCAa1UT9tDRjhw1EiVvUItpm/IPt7jsF1CUnH1ym51XO/y4iNULGA9v2UISW56iS+0A3
        cNr+HUteRyfStSo7geEGY/wYgR7XHQibQZPEgYdFUw1l3rJXxhHmfdjPPZQ65bHnyIqBEpgHhOLX3
        IHmEw3nRZlcaPASPSdenJs5YdzlHwCmeSP9DHkdfqTikasl8Va2l9t9h0IlVSyMm1rVqwC8KfTcov
        v4yBU2uqAOMVcycpwSGwD3Yvqzk54vUWzJ8PLCIEWlOJV5OSEr2K0GoSInA2Sbqf9AB3SR9fVegGT
        xTqvINgA==;
Received: from p4fdb0c34.dip0.t-ipconnect.de ([79.219.12.52] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKG76-0003EO-P2; Mon, 21 Sep 2020 07:19:53 +0000
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
Subject: [PATCH 03/14] block: cleanup blkdev_bszset
Date:   Mon, 21 Sep 2020 09:19:47 +0200
Message-Id: <20200921071958.307589-4-hch@lst.de>
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
 block/ioctl.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index ae74d0409afab9..06262c28f0c6c1 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -478,15 +478,14 @@ static int blkdev_bszset(struct block_device *bdev, fmode_t mode,
 	if (get_user(n, argp))
 		return -EFAULT;
 
-	if (!(mode & FMODE_EXCL)) {
-		bdgrab(bdev);
-		if (blkdev_get(bdev, mode | FMODE_EXCL, &bdev) < 0)
-			return -EBUSY;
-	}
+	if (mode & FMODE_EXCL)
+		return set_blocksize(bdev, n);
 
+	if (IS_ERR(blkdev_get_by_dev(bdev->bd_dev, mode | FMODE_EXCL, &bdev)))
+		return -EBUSY;
 	ret = set_blocksize(bdev, n);
-	if (!(mode & FMODE_EXCL))
-		blkdev_put(bdev, mode | FMODE_EXCL);
+	blkdev_put(bdev, mode | FMODE_EXCL);
+
 	return ret;
 }
 
-- 
2.28.0

