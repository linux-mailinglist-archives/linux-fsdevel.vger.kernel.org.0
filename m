Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6792A9D13
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 20:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgKFTEl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 14:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbgKFTEk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 14:04:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FDBC0613CF;
        Fri,  6 Nov 2020 11:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=N8UuGGw9lDirN906bdHNl2lOQB2uewg0ZSFqxQb7Dc4=; b=EbShoq0e9ZdxuHzJ//Stacuw58
        fWC0EbT3bDkc4a76CHYJxCWttwRI59GvoSaEU0SW0M22mNQkH3EhRrAKd+QvVHizyPlJeJ0kMVJ4i
        zHx7ItnO6W/fLLrYnw+S/gSCKqgdFCCws7Nqwvf507VfDEMI+rvO4uJnsRlROtxVrdeIy2E7YL3TL
        S7BmHPSe96rpbKQWzhRBiwcBzWjvB4sisrJVYeefsUF98+rDlF7LunTgLETgKBtlqQ1KRVmOxV937
        0aBRSGfCuluO2qQ6XYWclmFOBtO86wc6DyjOSAZKELdbbXCgn+Cmrf4JQhJv1RVmx1A2l424dcPHJ
        70sIudTA==;
Received: from [2001:4bb8:184:9a8d:9e34:f7f4:e59e:ad6f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kb725-00012H-Kj; Fri, 06 Nov 2020 19:04:22 +0000
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
Subject: [PATCH 17/24] rbd: use set_capacity_and_notify
Date:   Fri,  6 Nov 2020 20:03:29 +0100
Message-Id: <20201106190337.1973127-18-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106190337.1973127-1-hch@lst.de>
References: <20201106190337.1973127-1-hch@lst.de>
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
2.28.0

