Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C412B46B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 15:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730756AbgKPO7D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 09:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730742AbgKPO66 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:58:58 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE5EC0613D1;
        Mon, 16 Nov 2020 06:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=2smnVJT4M8MVl5MGvHMWtgKudyWqsSN/hT8JKVcTkcU=; b=UeKPjR9HaE3H/C6qkhiTe+Rocu
        9ShxKNi2wYBSK1rbD5wbPkjZToEWHwpbA4XMmV+yrAvhrlb8waEumxcmLoo6UJpHzT0oVsedCaTNL
        vW0OMgcrFRZWuj9afM+tWViwsKJaqn/qJwmqXTkY1DXr3Udw+lcZ1Jmvd9j5+tvAB+GIbBJjsq0cu
        EaxCxhsT192EWhx+hhW0l/8Cx9tvBzSIb1ezyuiHE2R3FTysXBl34PHXfUeZshdFbbBjcZGRonRTx
        gq9eiawuSsc+VqdBITNC40hyduSCiehl7z2/Koo7uijrjtnSFRlmObRyTCoTBE1CTJke9v1CYf9cY
        zJjjwESg==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kefxt-0003sX-50; Mon, 16 Nov 2020 14:58:45 +0000
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
Subject: [PATCH 25/78] block: don't call into the driver for BLKFLSBUF
Date:   Mon, 16 Nov 2020 15:57:16 +0100
Message-Id: <20201116145809.410558-26-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116145809.410558-1-hch@lst.de>
References: <20201116145809.410558-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

BLKFLSBUF is entirely contained in the block core, and there is no
good reason to give the driver a hook into processing it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/ioctl.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 3fbc382eb926d4..c6d8863f040945 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -369,15 +369,8 @@ static inline int is_unrecognized_ioctl(int ret)
 static int blkdev_flushbuf(struct block_device *bdev, fmode_t mode,
 		unsigned cmd, unsigned long arg)
 {
-	int ret;
-
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
-
-	ret = __blkdev_driver_ioctl(bdev, mode, cmd, arg);
-	if (!is_unrecognized_ioctl(ret))
-		return ret;
-
 	fsync_bdev(bdev);
 	invalidate_bdev(bdev);
 	return 0;
-- 
2.29.2

