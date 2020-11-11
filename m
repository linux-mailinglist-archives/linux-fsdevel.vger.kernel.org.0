Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B39F2AEB91
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Nov 2020 09:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgKKI2R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Nov 2020 03:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgKKI1l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Nov 2020 03:27:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F999C0613D4;
        Wed, 11 Nov 2020 00:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nVz8RkNtpZwARdADh/JLCUJA7/hL1Ru40zDyIK26ET0=; b=tinmFTQPUUV98QgHlYKWX8YU4L
        4qD5VD7H0dD3uFNSDokl4KoFGi+j9gbRq7IRLld2eCm6EcqPRS6TWJuVKJhRvlBT4k8G49ePxnn5y
        IJdwH0Tkv70a7xu934IYCUXQlwrqMdxTy/SOG5XZrYyyc8yRDIsMxf9cnhcVLrtzz5C+wb1IO24Zf
        AqNi1dVWI5Z0ckM3+Q2ktx3U+FU4QA8GqzJow7/V+uWu26C7iqg4HEhWS44W5/9cZSIyjuIofOa4K
        kaEY3fE06TS463cWbBOQ4b28ewRycc05JB8+7U97q79iJYL/Y9Nk16FoT28Ku03ykhf7QO82EmBlE
        Y3KW2tZQ==;
Received: from [2001:4bb8:180:6600:bcde:334f:863c:27b8] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kclTM-0007cn-Hp; Wed, 11 Nov 2020 08:27:20 +0000
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
Subject: [PATCH 16/24] drbd: use set_capacity_and_notify
Date:   Wed, 11 Nov 2020 09:26:50 +0100
Message-Id: <20201111082658.3401686-17-hch@lst.de>
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
Acked-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/drbd/drbd_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 65b95aef8dbc95..1c8c18b2a25f33 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2036,8 +2036,7 @@ void drbd_set_my_capacity(struct drbd_device *device, sector_t size)
 {
 	char ppb[10];
 
-	set_capacity(device->vdisk, size);
-	revalidate_disk_size(device->vdisk, false);
+	set_capacity_and_notify(device->vdisk, size);
 
 	drbd_info(device, "size = %s (%llu KB)\n",
 		ppsize(ppb, size>>1), (unsigned long long)size>>1);
@@ -2068,8 +2067,7 @@ void drbd_device_cleanup(struct drbd_device *device)
 	}
 	D_ASSERT(device, first_peer_device(device)->connection->net_conf == NULL);
 
-	set_capacity(device->vdisk, 0);
-	revalidate_disk_size(device->vdisk, false);
+	set_capacity_and_notify(device->vdisk, 0);
 	if (device->bitmap) {
 		/* maybe never allocated. */
 		drbd_bm_resize(device, 0, 1);
-- 
2.28.0

