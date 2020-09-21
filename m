Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF01271B81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 09:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgIUHUw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 03:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgIUHUS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 03:20:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E4EC061755;
        Mon, 21 Sep 2020 00:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=blabZPmWXgG0cxcX0iPoG2CU0yB/dn2E6XMr7wtvOlU=; b=P+xH+vZ5WozDW/mPdPOoeSIebG
        XZS2jbwOYrOnTthQk0Uhm2SN87yRyDUn+1hDAtJuRjjVe/XicpMadZaTTfDzItsqRxP8o2qV2xw+J
        wgYD2nLuTxeNFRAUjWM1VtY3PaSm5zVdGYXpcad8hFndoD1AZSe2iSlkKP1/tdil7vhDgqkhDxwQS
        E4kZzfmz7B2OoGgbvaA3W/YOA3nGsZTkMQbjCf6TCyC+pOZeLaPcFY/tOyz9SKH45tfIIXYTwB611
        bGDDyetv66m9+BQacOd9O8B2x2ftPjyj+cyfGSSLbX1LbAlrCntf+ngFdzLp9viVESfnCMpXnZkw+
        bqJgUGMA==;
Received: from p4fdb0c34.dip0.t-ipconnect.de ([79.219.12.52] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKG7I-0003Hv-7w; Mon, 21 Sep 2020 07:20:04 +0000
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
        linux-block@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 13/14] PM: mm: cleanup swsusp_swap_check
Date:   Mon, 21 Sep 2020 09:19:57 +0200
Message-Id: <20200921071958.307589-14-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200921071958.307589-1-hch@lst.de>
References: <20200921071958.307589-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use blkdev_get_by_dev instead of bdget + blkdev_get.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/power/swap.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 9d3ffbfe08dbf6..71385bedcc3a49 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -343,12 +343,10 @@ static int swsusp_swap_check(void)
 		return res;
 	root_swap = res;
 
-	hib_resume_bdev = bdget(swsusp_resume_device);
-	if (!hib_resume_bdev)
-		return -ENOMEM;
-	res = blkdev_get(hib_resume_bdev, FMODE_WRITE, NULL);
-	if (res)
-		return res;
+	hib_resume_bdev = blkdev_get_by_dev(swsusp_resume_device, FMODE_WRITE,
+			NULL);
+	if (IS_ERR(hib_resume_bdev))
+		return PTR_ERR(hib_resume_bdev);
 
 	res = set_blocksize(hib_resume_bdev, PAGE_SIZE);
 	if (res < 0)
-- 
2.28.0

