Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF162B4682
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 15:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730476AbgKPO6e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 09:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730230AbgKPO6c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:58:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E522AC0613D1;
        Mon, 16 Nov 2020 06:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=82UVn9JDhZ7kcS3JGvYaAt4iz84QDJp/mOdtcI/Npsk=; b=usuU2sefAFYqsEXj3qbul/Q7Un
        CCv9GjY0IirraZHVxERI0VFsNKbIJNWWfb9W2amAmbgPQFz1SQQGP9jucGmGFK5Dmz+uV/dQrh4EZ
        Yz7+inlUGGRZ2SENP6FNBzSsnyPPr/9g2oHpP/gfHR3aZh9bCC9SRkZky62gN2xUhMktrW7I1gC8O
        OlLKrcM8QGapUy4m0OUacF0pEkCV+NYMm0cjABSANyQg80uGZOPlSQK6hRsBvshv4teWYRl87jbJA
        +wqxRblm4gAKo4kgFpaUcUBO3YCWIyQ/tck3EBg4rNw0ym4xMAVhVwQ1xnNmFGgIlSjLbsb6rNNg5
        l7qTv7cQ==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kefxL-0003ie-Nn; Mon, 16 Nov 2020 14:58:12 +0000
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
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 01/78] block: remove the call to __invalidate_device in check_disk_size_change
Date:   Mon, 16 Nov 2020 15:56:52 +0100
Message-Id: <20201116145809.410558-2-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116145809.410558-1-hch@lst.de>
References: <20201116145809.410558-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

__invalidate_device without the kill_dirty parameter just invalidates
various clean entries in caches, which doesn't really help us with
anything, but can cause all kinds of horrible lock orders due to how
it calls into the file system.  The only reason this hasn't been a
major issue is because so many people use partitions, for which no
invalidation was performed anyway.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 fs/block_dev.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 9e84b1928b9401..66ebf594c97f47 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1334,12 +1334,6 @@ static void check_disk_size_change(struct gendisk *disk,
 		i_size_write(bdev->bd_inode, disk_size);
 	}
 	spin_unlock(&bdev->bd_size_lock);
-
-	if (bdev_size > disk_size) {
-		if (__invalidate_device(bdev, false))
-			pr_warn("VFS: busy inodes on resized disk %s\n",
-				disk->disk_name);
-	}
 }
 
 /**
-- 
2.29.2

