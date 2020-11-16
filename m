Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 524CD2B4691
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 15:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730642AbgKPO6n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 09:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730591AbgKPO6m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:58:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE1CC0613CF;
        Mon, 16 Nov 2020 06:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=j/0/qXcDYvQ/KRFTCfbeLrD6BKftlYW1jMJrLTQknrA=; b=byXWvuFWUAS6lZPm5Zeq7p8bBe
        us/bzllqhkru2czyVVokQTTeYL+/3nVsuU4/rDhYvEj/ImRfWDgds8ciFSHt3DJegL3w+3AQaGHag
        PKasBfLdKS5E4pWdTFh6/4uyvJRFiUdVWjcV1a5aQvY/kBYNo4iLxhmPSh2kdJdTp7A4ixInIx3wo
        JpWIePokKzvwp8PcbSTxxumquRpS137WC1RZjgyVjiJeOwfVg8ecKo6rYbXAhcQrObDK5SeQ3EIfa
        OTrz4SZ5xlHtXA94sJkOV0q/92afNyn3WLIhIoPBbXq1zA8kztmL78I31XmGh7QR7o5AcHIy7rcAn
        HnC1nGVw==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kefxb-0003mp-ER; Mon, 16 Nov 2020 14:58:27 +0000
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
Subject: [PATCH 13/78] pktcdvd: use set_capacity_and_notify
Date:   Mon, 16 Nov 2020 15:57:04 +0100
Message-Id: <20201116145809.410558-14-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116145809.410558-1-hch@lst.de>
References: <20201116145809.410558-1-hch@lst.de>
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
2.29.2

