Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7842AEB8F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Nov 2020 09:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgKKI1f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Nov 2020 03:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgKKI1c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Nov 2020 03:27:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A111C061A04;
        Wed, 11 Nov 2020 00:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=lumJq5B2fyOOj2vqJR3cb92lXUnjwfkYYs/CdjVL7AE=; b=uDrlBIhMK6T1RnrpgvD/pKf6sG
        QV1Sp6TudbRl1mWifO0nZnLE7QfG2iw/OPgIhCSja3Blj4/cJ1bCXgyh4CGVU8X7dkAknvMZodl4b
        2ynoRHYB66K72oZd5MYRpOB7ObAcIAq2+HyK+1Hr2mJ91JL6kHn0bBGu17bSqY+tlRCoT0t+bpnhq
        rRarLOFqySYCDRZZr894GHJCn0WJl3x59Oz4tbjlcJPFDeufbZN7qJ20G6JYSqW+cnntCFsKfgQj/
        oMJ4UPFDhi1LuO4RUOy54Y+XqGoQnfQDGHb+DJOLJYIoYZZrMsBLtPkmlQJdVt/k6Enfm2GLnM3Zj
        Ld3eXzpQ==;
Received: from [2001:4bb8:180:6600:bcde:334f:863c:27b8] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kclTJ-0007cE-Po; Wed, 11 Nov 2020 08:27:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Justin Sanders <justin@coraid.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, nbd@other.debian.org,
        ceph-devel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 14/24] pktcdvd: use set_capacity_and_notify
Date:   Wed, 11 Nov 2020 09:26:48 +0100
Message-Id: <20201111082658.3401686-15-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201111082658.3401686-1-hch@lst.de>
References: <20201111082658.3401686-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use set_capacity_and_notify to set the size of both the disk and block
device.  This also gets the uevent notifications for the resize for free.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/pktcdvd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 467dbd06b7cdb1..4326401cede445 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2130,8 +2130,7 @@ static int pkt_open_dev(struct pktcdvd_device *pd, fmode_t write)
 	}
 
 	set_capacity(pd->disk, lba << 2);
-	set_capacity(pd->bdev->bd_disk, lba << 2);
-	bd_set_nr_sectors(pd->bdev, lba << 2);
+	set_capacity_and_notify(pd->bdev->bd_disk, lba << 2);
 
 	q = bdev_get_queue(pd->bdev);
 	if (write) {
-- 
2.28.0

