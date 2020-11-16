Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7142B481B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 16:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731261AbgKPPB2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 10:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731037AbgKPO7v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:59:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D5AC0613CF;
        Mon, 16 Nov 2020 06:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=2AKcef4DY6iJcprvQynjGgbCIgh8d3+qztu8J6nwbBU=; b=pWF6GiYZwuWwwwCepRCy7HJGry
        ebNMkKhyrUdm7IJyWpCzL1mHXVX2uHrDvMEZnLp7EDprwz/Ixpo6UyIkP9C/eBgJtKePlQ9iOFGEX
        anVcipPAM3jKhn7+W0pAqmOpSUkPyf5/WcShPIbr+Kvrkdy7ShEiMu40JORvE9Eu7vJW7k1YP9SBn
        x4dzOxFL2eT+4GeR6EmljUox59XCLVLuOr/c4rirnRVpl1nSS3OL1hT4yGJ4ATQQt0nK9jflQBVkF
        1F1WeS9cKSzs/UYR7bWm7TOPnDssO/WwxWuvt6FJ3Za4yj5tMQ3BhtLdQ4aklV0fV0Tw57B/U2ugq
        BAULThIQ==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kefyl-0004C5-Vu; Mon, 16 Nov 2020 14:59:40 +0000
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
Subject: [PATCH 62/78] loop: do not call set_blocksize
Date:   Mon, 16 Nov 2020 15:57:53 +0100
Message-Id: <20201116145809.410558-63-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116145809.410558-1-hch@lst.de>
References: <20201116145809.410558-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

set_blocksize is used by file systems to use their preferred buffer cache
block size.  Block drivers should not set it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 9a27d4f1c08aac..b42c728620c9e4 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1164,9 +1164,6 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	size = get_loop_size(lo, file);
 	loop_set_size(lo, size);
 
-	set_blocksize(bdev, S_ISBLK(inode->i_mode) ?
-		      block_size(inode->i_bdev) : PAGE_SIZE);
-
 	lo->lo_state = Lo_bound;
 	if (part_shift)
 		lo->lo_flags |= LO_FLAGS_PARTSCAN;
-- 
2.29.2

