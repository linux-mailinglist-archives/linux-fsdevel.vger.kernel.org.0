Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25832B4787
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 16:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730830AbgKPO7L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 09:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730817AbgKPO7K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:59:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57738C0613CF;
        Mon, 16 Nov 2020 06:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=v/lQzgfk3g8cFkaFjGaW1PVi+J4d/Qp7XTb0qTcrcMw=; b=YqzdVakmLdPHF6ezNwy3j22Rhk
        XQVP6AxA/GIysbqTVVeNbFaXKt7fGm9agC08PMgcnJUJeh74vxBSvOfGIuDA/W9HICp10ASgp343S
        hLuXPuNnKIIaKSmewfilQzler2ZMSLSZNnA3JzXsI/oA/vpGcupQtF+vIl+sykv24N3IbJmKQaPjW
        Jn9WRJEVebbUFdcTwhZRo/qo4f5NgH2pRWNmJeZrAnILNTOw/lnNzTwrq9w/rBYEhDgZjS59KWZ4g
        UrBImqs7+qvykUY+GYj6lm5Ht8/hTyu9yEFUWTYQLA51bItg9eUgBTuodXJbLE5gVUevZsuOFItUu
        Kp0yfIOw==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kefy5-0003vm-UU; Mon, 16 Nov 2020 14:58:58 +0000
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
Subject: [PATCH 34/78] block: propagate BLKROSET to all partitions
Date:   Mon, 16 Nov 2020 15:57:25 +0100
Message-Id: <20201116145809.410558-35-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116145809.410558-1-hch@lst.de>
References: <20201116145809.410558-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When setting the whole device read-only (or clearing the read-only
state), also update the policy for all partitions.  The s390 dasd
driver has awlways been doing this and it makes a lot of sense.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/ioctl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 6b785181344fe1..22f394d118c302 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -354,7 +354,10 @@ static int blkdev_roset(struct block_device *bdev, fmode_t mode,
 		if (ret)
 			return ret;
 	}
-	bdev->bd_part->policy = n;
+	if (bdev_is_partition(bdev))
+		bdev->bd_part->policy = n;
+	else
+		set_disk_ro(bdev->bd_disk, n);
 	return 0;
 }
 
-- 
2.29.2

