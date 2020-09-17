Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C857226E235
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 19:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgIQRWV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 13:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgIQRVc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 13:21:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2361BC06174A;
        Thu, 17 Sep 2020 10:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=rH7cSa9DL5os5jQC9jA3JdyjaAHSLlkPqftBlBnCr7E=; b=DPkvK3ev90l48Aoh1AG5Cyzb0x
        Kfg6+PI+NvhMi4ZkA9/Ya9L5/mU79yOyuklUBPc3l3ApCaq91Sr2f0IMuy3iBGySp4GA1HCvy5rML
        NRCIny5fSvFyuoqcyrAUSGW9x8LnRug2zL+r6nXPiRPNRLB1X+qEFUoT3OUJyTHTyWYxe+j0v/49G
        783ya8SOn5lTGwzo7vvUoKFiwldY6l9oHx3Mvas+ivWZ0aW3/UtFZJA06MBA7H4lbvtyqTX+Bi1kb
        9LAIJpLS1l9wi0pQgOB9u2eAfraWUlTpOcaJq4ua6OF0K/mxQoxXhDzxajxtGS7qh5byRKL1KQTZN
        Z/WDwxXA==;
Received: from 089144214092.atnat0023.highway.a1.net ([89.144.214.92] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIxb1-0001y1-JQ; Thu, 17 Sep 2020 17:21:23 +0000
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
Subject: [PATCH 10/14] mm: cleanup claim_swapfile
Date:   Thu, 17 Sep 2020 18:57:16 +0200
Message-Id: <20200917165720.3285256-11-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200917165720.3285256-1-hch@lst.de>
References: <20200917165720.3285256-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use blkdev_get_by_dev instead of bdgrab + blkdev_get.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/swapfile.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 12f59e641b5e29..7438c4affc75fa 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2920,10 +2920,10 @@ static int claim_swapfile(struct swap_info_struct *p, struct inode *inode)
 	int error;
 
 	if (S_ISBLK(inode->i_mode)) {
-		p->bdev = bdgrab(I_BDEV(inode));
-		error = blkdev_get(p->bdev,
+		p->bdev = blkdev_get_by_dev(inode->i_rdev,
 				   FMODE_READ | FMODE_WRITE | FMODE_EXCL, p);
-		if (error < 0) {
+		if (IS_ERR(p->bdev)) {
+			error = PTR_ERR(p->bdev);
 			p->bdev = NULL;
 			return error;
 		}
-- 
2.28.0

