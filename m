Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07BE325AD0F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 16:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgIBO3K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 10:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbgIBONl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:13:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B77C061263;
        Wed,  2 Sep 2020 07:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nQ83Cu9ozqMklDRnkFmyDq+TQLjs94xXUv+UC4IWP5c=; b=G+AbJXlhEoNUEhaJJMqoU5D+/n
        mCY3DZHbjS+WEqjZrwnBNnG0+sGUP+Fc1k3byExCn/m364AtZmlOc+nnmyWYhyTb5kjveVPEf8WcG
        qpahI9oNcpABZcfIcvQE5nc9oDjc3+7JZh93qKoCzeGwpcTiYECz0hHUGsqeYHvJXRKRmAAoL2kSr
        679BHRTVcCTosaKcFvyFAoDRW9XVD14vlroKaBOJUJ7VNcght62kdZH4/3mWU8CwyKc4dzV6bOYBg
        qK9n+uDdU6xqvLTfuzTn5i1ykA3nW+kEZVfxhPVsQOsTgtek006rNLAAvc+z0/z2lILP5YuIh4Wso
        veiqYMwA==;
Received: from [2001:4bb8:184:af1:6a63:7fdb:a80e:3b0b] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDTV3-0005e2-8l; Wed, 02 Sep 2020 14:12:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Denis Efremov <efremov@linux.com>, Tim Waugh <tim@cyberelk.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-m68k@lists.linux-m68k.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/19] paride/pcd: use bdev_check_media_change
Date:   Wed,  2 Sep 2020 16:12:09 +0200
Message-Id: <20200902141218.212614-11-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902141218.212614-1-hch@lst.de>
References: <20200902141218.212614-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pcd driver does not have a ->revalidate_disk method, so it can just
use bdev_check_media_change without any additional changes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/paride/pcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/paride/pcd.c b/drivers/block/paride/pcd.c
index 5124eca90e8337..70da8b86ce587d 100644
--- a/drivers/block/paride/pcd.c
+++ b/drivers/block/paride/pcd.c
@@ -233,7 +233,7 @@ static int pcd_block_open(struct block_device *bdev, fmode_t mode)
 	struct pcd_unit *cd = bdev->bd_disk->private_data;
 	int ret;
 
-	check_disk_change(bdev);
+	bdev_check_media_change(bdev);
 
 	mutex_lock(&pcd_mutex);
 	ret = cdrom_open(&cd->info, bdev, mode);
-- 
2.28.0

