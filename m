Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB6C26E345
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 20:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgIQSJm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 14:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgIQRa6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 13:30:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE849C06174A;
        Thu, 17 Sep 2020 10:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Vy+i14rdw+4hEhmBKTGutehzr8kV3l2y359HNYmPy6s=; b=Gm/aiQSY8U+jiHppzEQUoEzwep
        cqGvY+jq384xbJGVBnfbwko8D5JZ0BGFns3s46sJKWmlyvr6Rprp6SB2EJM4tA5ZWwGgXjtq63029
        6fca9dZX058BRWvIB7FVHM7gYriRdj93U6YriX8r4ysa1mBIe4YAaix4s1MqxQOLS42Oh2oGaQFEH
        l/uG3rNoPBAWon9nPGtcQpTAFKhd3wMIPRsfkZGuARLiy2dYO81b/IGG1NmtVn1x1xE8tIT2y9NUm
        dqXKBMMk9FcsMdibx/rdw78P0a5PJ/TlNM8r+Vr1v1L7claUCM+evzRzabhvPxLbjhmoPgUKFwgyF
        nVKxc99Q==;
Received: from 089144214092.atnat0023.highway.a1.net ([89.144.214.92] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIxhM-0002QQ-Le; Thu, 17 Sep 2020 17:27:56 +0000
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
Subject: [PATCH 13/14] PM: mm: cleanup swsusp_swap_check
Date:   Thu, 17 Sep 2020 18:57:19 +0200
Message-Id: <20200917165720.3285256-14-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200917165720.3285256-1-hch@lst.de>
References: <20200917165720.3285256-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use blkdev_get_by_dev instead of bdget + blkdev_get.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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

