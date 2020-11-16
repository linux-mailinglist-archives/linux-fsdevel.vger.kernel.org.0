Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A647C2B4696
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 15:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730670AbgKPO6r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 09:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730651AbgKPO6q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:58:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A10C0613CF;
        Mon, 16 Nov 2020 06:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ud6p7e1IhRULC6wZtzdvOstF28I68kQBPxpGvL+xOgI=; b=gPww3FQIhl5iWeI+g9tG2PGyW2
        8cFaViQoZFAn3scL7v7e6VlWSSHM0qujAFL7izZSOKnG55zOSstvCPtgh6j+BgcIcjdOLRmWbSuPx
        87livSCdfMp3Q0CIYUUkcKRJP5Va1JiGvvjNWim+FctICo3+JOPZDui4e1QuYygSU2PpQDLhZqOWf
        f197DU1YDQPIlLWXNMJiKwoVJLVKNOz6H3aGhMJM8IdhDJMUGVHFFQeJkvMcj1S9q2+rh+/TxUG2Y
        29p0F2fhazyop6FNc7WioL6g6LusWwAv5JZKRR86YRvfazPlnU/qoUaNKbSGMde0pGudftQZoTtiY
        4sHWOC/g==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kefxf-0003ny-QH; Mon, 16 Nov 2020 14:58:32 +0000
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
Subject: [PATCH 16/78] rbd: use set_capacity_and_notify
Date:   Mon, 16 Nov 2020 15:57:07 +0100
Message-Id: <20201116145809.410558-17-hch@lst.de>
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
Acked-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index f84128abade319..b7a194ffda55b4 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4920,8 +4920,7 @@ static void rbd_dev_update_size(struct rbd_device *rbd_dev)
 	    !test_bit(RBD_DEV_FLAG_REMOVING, &rbd_dev->flags)) {
 		size = (sector_t)rbd_dev->mapping.size / SECTOR_SIZE;
 		dout("setting size to %llu sectors", (unsigned long long)size);
-		set_capacity(rbd_dev->disk, size);
-		revalidate_disk_size(rbd_dev->disk, true);
+		set_capacity_and_notify(rbd_dev->disk, size);
 	}
 }
 
-- 
2.29.2

