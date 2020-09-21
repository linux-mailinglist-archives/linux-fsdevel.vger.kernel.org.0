Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1249271B87
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 09:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgIUHUS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 03:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgIUHUQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 03:20:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EFDC0613D2;
        Mon, 21 Sep 2020 00:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=rH7cSa9DL5os5jQC9jA3JdyjaAHSLlkPqftBlBnCr7E=; b=ES2D2BfGiz1kTREN1Zw1aEiUML
        yN3tE0P5XRnER56mCx5PkI30Q59VGyQrEh5EPC/UmarLTKWmViIwsDGAAovnSV/BAkMyPQC5yGuxl
        ENgWGtDJ6bDGN6rME7pQzGngkqzTaL2xxFlhhz9HJX7KfABNGAiqYtT6oCd4ti7TAgwVq4xw4YgEY
        4IolEoVibJpRHqIQjemg+UD9WQIoeSYC6qIxNvGZYtNuFC02EX6qJM4q8oi4PthhKKrYRL7Ps62O+
        MLBqEGi7Hq88Q9whqgktd1trmTObSIXUPvVu/znwzj3rjz06ExzSrAX5ni2VqijOLmMicWfwPbORl
        BaJQKhbg==;
Received: from p4fdb0c34.dip0.t-ipconnect.de ([79.219.12.52] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKG7E-0003Ff-CG; Mon, 21 Sep 2020 07:20:00 +0000
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
Date:   Mon, 21 Sep 2020 09:19:54 +0200
Message-Id: <20200921071958.307589-11-hch@lst.de>
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

