Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7F525ACE2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 16:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgIBOUk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 10:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727931AbgIBONl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:13:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C458AC061265;
        Wed,  2 Sep 2020 07:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=loS36YfO2qDSFRDtfhX92YEoXynWvQPkbrbjbgtkbWo=; b=JOtqTM13brS3TXvp4xmcyXjbtd
        0Gvxs46T8Bu7SM1BPnihOz9Lfpc4SEkd0bFm5HDi10YnpCkjUeXPuKqZqjtGa6fHLVGYcmsEQjZTx
        Ta6w+ZxKAVl1i/jgi0wT2G++CyqJYVDXzJ3ulvMXb2g8jR6zG4S93T357xfeyghWEl8g14sw3rfjc
        YFQ0IUNNGATUs+w9n2Nozg4I5runwPGbVNLdNp20Jq45b4JPlMF0AbsUgRFSVpuJaqIOOSZrUU8Cu
        tEe59NU1h7cux0ruAq3Lq+828QQl8CYSEhFdRct2e6DaOaOh29sH1y3uk2D7veh7GEjq2s5Mubh1P
        1bDcmCbw==;
Received: from [2001:4bb8:184:af1:6a63:7fdb:a80e:3b0b] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDTUs-0005co-QD; Wed, 02 Sep 2020 14:12:23 +0000
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
Subject: [PATCH 02/19] amiflop: use bdev_check_media_change
Date:   Wed,  2 Sep 2020 16:12:01 +0200
Message-Id: <20200902141218.212614-3-hch@lst.de>
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

The Amiga floppy driver does not have a ->revalidate_disk method, so it
can just use bdev_check_media_change without any additional changes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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

