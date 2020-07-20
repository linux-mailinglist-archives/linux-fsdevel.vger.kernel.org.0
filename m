Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8506F22593E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 09:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgGTHwJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 03:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbgGTHwF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 03:52:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EAFC0619D5;
        Mon, 20 Jul 2020 00:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=toLJ0vqGJpB+m2DWzx8OUV3mzNvbIyso0hs1e0NzMQw=; b=FCmYWkXfKHf8vcWqHZtukh2Mhg
        Zhz781JZCC5Vr/7TzVKlvhhajQC/IogCphBsM5bEQ2bHfIUHsP9gNw6mss9CB+MYhu++OWdcIlzJc
        ToX7MyaSKtuvIfu3D3olBT6cB/R9p4ZewyqY/wAk3kUwFsFbbxDlERNw+suYnF8QofGmJCyvWVKp1
        bwOWSfGtzDTbiXMx+3a7jAQeq5Go0SyhWGp9YU5sgG3btXovaw5pcATV0G7YNqG4GMpUiiuFDPIO6
        B9Ln08c9CscR7atiQyfObpDsbi/il9V5S8svAdlqFdIzk7y7NRbME8niHiPUeJr8KgQi9VSU6cEK7
        hv3Ywcuw==;
Received: from [2001:4bb8:105:4a81:5185:88fc:94bb:f8bf] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxQaZ-00040F-7Z; Mon, 20 Jul 2020 07:51:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Song Liu <song@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Subject: [PATCH 03/14] drbd: remove RB_CONGESTED_REMOTE
Date:   Mon, 20 Jul 2020 09:51:37 +0200
Message-Id: <20200720075148.172156-4-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720075148.172156-1-hch@lst.de>
References: <20200720075148.172156-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This case isn't ever used.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/drbd/drbd_req.c | 4 ----
 include/linux/drbd.h          | 1 -
 2 files changed, 5 deletions(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 674be09b2da94a..4d944f2eb56efa 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -901,13 +901,9 @@ static bool drbd_may_do_local_read(struct drbd_device *device, sector_t sector,
 static bool remote_due_to_read_balancing(struct drbd_device *device, sector_t sector,
 		enum drbd_read_balancing rbm)
 {
-	struct backing_dev_info *bdi;
 	int stripe_shift;
 
 	switch (rbm) {
-	case RB_CONGESTED_REMOTE:
-		bdi = device->ldev->backing_bdev->bd_disk->queue->backing_dev_info;
-		return bdi_read_congested(bdi);
 	case RB_LEAST_PENDING:
 		return atomic_read(&device->local_cnt) >
 			atomic_read(&device->ap_pending_cnt) + atomic_read(&device->rs_pending_cnt);
diff --git a/include/linux/drbd.h b/include/linux/drbd.h
index 5755537b51b114..6a8286132751df 100644
--- a/include/linux/drbd.h
+++ b/include/linux/drbd.h
@@ -94,7 +94,6 @@ enum drbd_read_balancing {
 	RB_PREFER_REMOTE,
 	RB_ROUND_ROBIN,
 	RB_LEAST_PENDING,
-	RB_CONGESTED_REMOTE,
 	RB_32K_STRIPING,
 	RB_64K_STRIPING,
 	RB_128K_STRIPING,
-- 
2.27.0

