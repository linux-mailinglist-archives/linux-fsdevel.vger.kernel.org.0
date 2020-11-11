Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67FFA2AEB6F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Nov 2020 09:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgKKI1s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Nov 2020 03:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgKKI1q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Nov 2020 03:27:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBC8C0613D4;
        Wed, 11 Nov 2020 00:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=0pOGuZ16rreJ8RZ4ivF8AiAM7803r01swtmMxrdYqs4=; b=RTU5UMhdpsjtChFCSIwnQCiNZ0
        nLMhYrquzojaCWKfYUYpIV8wG55z/9uW3YWLeoQ1rUIpnE//ou/YhU/DPlXAapy4YewrFNGqBo2FO
        NBMfZ9QZ5CbAIfIgfBRWxY3KHi6Jzjx2slAcrlK/u6FEmKnmHNFQ3/hYrKTa3Bv1kBZpb1GR/mJBU
        RrVIalCfa+Zm+i+qCLA8uu6mcb1MtochkntXC+ZhYnh8VC4mv7MvHqnbR+NuSytrJJQpp7KhMHXlF
        ySOGQCEIpF2KZxWJUEOmTknhZ1d00cwIeytUy1JVjpL77pAaI+ZcDeJgM9rthHxW+G1//Kr4qHv8B
        dlmVJQfQ==;
Received: from [2001:4bb8:180:6600:bcde:334f:863c:27b8] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kclTW-0007fT-TE; Wed, 11 Nov 2020 08:27:31 +0000
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
Subject: [PATCH 23/24] virtio-blk: remove a spurious call to revalidate_disk_size
Date:   Wed, 11 Nov 2020 09:26:57 +0100
Message-Id: <20201111082658.3401686-24-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201111082658.3401686-1-hch@lst.de>
References: <20201111082658.3401686-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

revalidate_disk_size just updates the block device size from the disk
size.  Thus calling it from virtblk_update_cache_mode doesn't actually
do anything.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/block/virtio_blk.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 3e812b4c32e669..145606dc52db1e 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -598,7 +598,6 @@ static void virtblk_update_cache_mode(struct virtio_device *vdev)
 	struct virtio_blk *vblk = vdev->priv;
 
 	blk_queue_write_cache(vblk->disk->queue, writeback, false);
-	revalidate_disk_size(vblk->disk, true);
 }
 
 static const char *const virtblk_cache_types[] = {
-- 
2.28.0

