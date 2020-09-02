Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA81725ACC0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 16:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgIBOQD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 10:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727800AbgIBONl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:13:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409BDC06121A;
        Wed,  2 Sep 2020 07:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=14ox7AoWFV7H5eezSnPosQXA4Ch2lScJ8xsHfnvdcmE=; b=RORkOG08fmVugfbQ99Gx7jozhC
        eAymlmT88pxoykAk+WjDRqF5npN0B1qcz9hVNqW1x+QP/uJrQ0FIcskDRlASpOifjxwjUuWJX524t
        j+Z5mDigF96Xx3Ersqs0qYENZ81LgQ2H2DWetvYe5fNOj1Vjw/+lVBYa2+eE/cDtSAfhM+LzChaKs
        Al6pvkpiZG+U1rhUNSNA+01EvLfyZyemwxnqTZQDhHL8svh0Rip7fErO9Q8RuBMh3ZITHV8T81eXr
        l1upawrNBJB+PbPic0lHl0e4CSgElro7RlYXf6VpOlFxMqqz5o83yR3RIUrkyZCV4FyYa8e8oSML6
        +CyElTPA==;
Received: from [2001:4bb8:184:af1:6a63:7fdb:a80e:3b0b] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDTVA-0005fh-T9; Wed, 02 Sep 2020 14:12:41 +0000
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
Subject: [PATCH 15/19] md: use bdev_check_media_change
Date:   Wed,  2 Sep 2020 16:12:14 +0200
Message-Id: <20200902141218.212614-16-hch@lst.de>
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
 drivers/md/md.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 9562ef598ae1f4..27ed61197014ef 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -7848,7 +7848,7 @@ static int md_open(struct block_device *bdev, fmode_t mode)
 	atomic_inc(&mddev->openers);
 	mutex_unlock(&mddev->open_mutex);
 
-	check_disk_change(bdev);
+	bdev_check_media_change(bdev);
  out:
 	if (err)
 		mddev_put(mddev);
-- 
2.28.0

