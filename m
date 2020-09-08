Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18BAA261FFC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 22:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730400AbgIHUIj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 16:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730275AbgIHPTQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:19:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304B6C0A3BEA;
        Tue,  8 Sep 2020 07:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=AIbdaWqDOZXyI97EfNIUO6cOxzS/iRi/fiJ/sz/ZAL8=; b=GIpniUBInLXgvz98qrm3XEFBUU
        jI7kZn/WrtbX4474Skgn5Iwip5HLeqPsKx5DEn4psj2SQF9WbRQFr6hKKl3VF9Ii5a+mcgkre1Sza
        LvVllN82PZVtFinvq56fIrZ+RrfX3jfJo2TnUV32FrYcLzR4jFJCrT6NEMboJtHMh3kzEw0gcMwMo
        kjJpuGwfTeKms3eK/8v1oiodNb55XfT3nmCYDptXrSPYQqqabbpKVI0KcHMhN7OEQmG5UydppiZWH
        7B0QIIZZTgk9Gy3y1V11t3QVuwPYZecByMco+KFniEh8KoEeAjHYCnn8GTwF55IekYLSdRaFbpzFI
        XKaiiNDg==;
Received: from [2001:4bb8:184:af1:3dc3:9c83:fc6c:e0f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFf0u-0002xt-QY; Tue, 08 Sep 2020 14:54:30 +0000
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
Subject: [PATCH 08/19] xsysace: use bdev_check_media_change
Date:   Tue,  8 Sep 2020 16:53:36 +0200
Message-Id: <20200908145347.2992670-9-hch@lst.de>
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

Switch to use bdev_check_media_change instead of check_disk_change and
call ace_revalidate_disk manually.  Given that ace_revalidate_disk only
deals with media change events, the extra call into ->revalidate_disk
from bdev_disk_changed is not required either, so stop wiring up the
method.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/block/xsysace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/xsysace.c b/drivers/block/xsysace.c
index 5d8e0ab3f054f5..eefe542f2d9fff 100644
--- a/drivers/block/xsysace.c
+++ b/drivers/block/xsysace.c
@@ -922,7 +922,8 @@ static int ace_open(struct block_device *bdev, fmode_t mode)
 	ace->users++;
 	spin_unlock_irqrestore(&ace->lock, flags);
 
-	check_disk_change(bdev);
+	if (bdev_check_media_change(bdev))
+		ace_revalidate_disk(bdev->bd_disk);
 	mutex_unlock(&xsysace_mutex);
 
 	return 0;
@@ -966,7 +967,6 @@ static const struct block_device_operations ace_fops = {
 	.open = ace_open,
 	.release = ace_release,
 	.check_events = ace_check_events,
-	.revalidate_disk = ace_revalidate_disk,
 	.getgeo = ace_getgeo,
 };
 
-- 
2.28.0

