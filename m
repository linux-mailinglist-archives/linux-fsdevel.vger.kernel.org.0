Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9587D261FCB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 22:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbgIHUGj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 16:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730311AbgIHPVk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:21:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0D0C0A3BEC;
        Tue,  8 Sep 2020 07:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=lWxnm+FRJQ1gaOww4j+aWjmf7zJgAshxl0Y6TkF88gw=; b=PU5DnvnOhI/jzDLWv5bPiEmht7
        DtGs0BC1+AbVGld+So7H0Kjyd79UEuZVbXLfm0vR9ggpH2LqKH9c6uMsb71etCW18xv1sXC/cDouV
        FITlturAfZ0DcY1HdGLff+XauXrxep31o5JIlZ0Yr0I7gXkAc4va2lCOYjM54+wGYsQVQou9Hygrf
        TkADJMAxq3vrJ1PTpsRMUdaHqIUcrbdhFiRPwYnf1RAiJS0mzZdAXHrBM5fk89BGE6XI7DRZzeI62
        U/0kC2czTeIIQeyl8lVxt3v9+WsZ7egpPnITFSIFabYizej5kff/sKSbz9SFjzA8s27gdoQRo2o1A
        7RQyPrGg==;
Received: from [2001:4bb8:184:af1:3dc3:9c83:fc6c:e0f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFf0O-0002vr-1B; Tue, 08 Sep 2020 14:54:01 +0000
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
        linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 02/19] amiflop: use bdev_check_media_change
Date:   Tue,  8 Sep 2020 16:53:30 +0200
Message-Id: <20200908145347.2992670-3-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908145347.2992670-1-hch@lst.de>
References: <20200908145347.2992670-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The Amiga floppy driver does not have a ->revalidate_disk method, so it
can just use bdev_check_media_change without any additional changes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/block/amiflop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/amiflop.c b/drivers/block/amiflop.c
index 226219da3da6a7..71c2b156455860 100644
--- a/drivers/block/amiflop.c
+++ b/drivers/block/amiflop.c
@@ -1670,7 +1670,7 @@ static int floppy_open(struct block_device *bdev, fmode_t mode)
 	}
 
 	if (mode & (FMODE_READ|FMODE_WRITE)) {
-		check_disk_change(bdev);
+		bdev_check_media_change(bdev);
 		if (mode & FMODE_WRITE) {
 			int wrprot;
 
-- 
2.28.0

