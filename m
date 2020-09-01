Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC3525963F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 18:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732209AbgIAP76 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Sep 2020 11:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731796AbgIAP6G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:58:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC2AC061247;
        Tue,  1 Sep 2020 08:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=JssZ/9cfFlKY9nXiXN1eWHNYfq2IqPkVO48PJ0G1HVM=; b=TsLN4Ki5H6wDqMT7EkDDmICR5s
        2ikY9tR6e67GKJEqjuS9L66bSUIo+pu5PYEAc9ljO3uyf6oMcNiepE5rzwUxhjE+/vnTmCPgENmda
        C0OeAfERJgyA7K8KeFysVlBHyF0BPeIG7el80V9O61CNCYuSKhfujxSQgjXJOjMOSEy03HwmPQuPh
        RJCdiSoEUrRAJIJ7z0BaLS8JSw/BmFlWFm/qiMtciExAsNyJHCr7Vvb8RIEQV1UW0Wnk6ZMFBndz3
        +EuD/g9pjFt/AGKn2OUIwLAq2rE5vGf6lWordEqx3jg+9VI6y7EPXjBeepMY6Nus8DQ6cZOSE4OGn
        R3KU2Xqg==;
Received: from [2001:4bb8:18c:45ba:2f95:e5:ca6b:9b4a] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kD8fR-0004Op-3n; Tue, 01 Sep 2020 15:57:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Dan Williams <dan.j.williams@intel.com>, dm-devel@redhat.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        nbd@other.debian.org, ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-raid@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/9] block: don't clear bd_invalidated in check_disk_size_change
Date:   Tue,  1 Sep 2020 17:57:41 +0200
Message-Id: <20200901155748.2884-3-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901155748.2884-1-hch@lst.de>
References: <20200901155748.2884-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

bd_invalidated is set by check_disk_change or in add_disk to initiate a
partition scan.  Move it from check_disk_size_change which is called
from both revalidate_disk() and bdev_disk_changed() to only the latter,
as that is what is called from the block device open code (and nbd) to
deal with the bd_invalidated event.  revalidate_disk() on the other hand
is mostly used to propagate a size update from the gendisk to the block
device, which is entirely unrelated.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 08158bb2e76c85..2760292045c082 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1302,7 +1302,6 @@ static void check_disk_size_change(struct gendisk *disk,
 		}
 		i_size_write(bdev->bd_inode, disk_size);
 	}
-	bdev->bd_invalidated = 0;
 	spin_unlock(&bdev->bd_size_lock);
 
 	if (bdev_size > disk_size) {
@@ -1391,6 +1390,8 @@ int bdev_disk_changed(struct block_device *bdev, bool invalidate)
 
 	lockdep_assert_held(&bdev->bd_mutex);
 
+	bdev->bd_invalidated = 0;
+
 rescan:
 	ret = blk_drop_partitions(bdev);
 	if (ret)
-- 
2.28.0

