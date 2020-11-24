Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26692C273E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 14:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388103AbgKXN23 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 08:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388071AbgKXN2Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:28:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5F6C0613D6;
        Tue, 24 Nov 2020 05:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=qLuO7hD0TG0p9aylN+kHqBJxf5z3v4FVxxZ2M17hRmY=; b=cByrnVSUwNsV+8vL6OejYZMzYW
        g8VICMIEorS+0pOBvVioVLf/hyD/zxobeo8PAet5DaDiGdRDYy0L5JNIcM3yD1NCnwpsR6gWUVB5i
        Lptsh/7GyC3dYE+HryC4wV9CakS+3V2vvPvT4vRhVftfmO4XobgclczjV5yeEVlKRsJvJ9LwjX+8o
        1vNw6Sl4pqdKC25En8sUougbgcvCNyLxzyGGHsEPu8enWgOfJoKU0RIKHjBkbhK7GxVxYfvwMvJI6
        Vf9vnnAEkii3NBNG4XOnzwMMzJMYdhpc7IAUijTjrAXJlfebUq3ghdAO/ZeMpsZrhIZUAVgWmW/K4
        kMYMHe4Q==;
Received: from [2001:4bb8:180:5443:c70:4a89:bc61:3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khYMb-0006Vh-99; Tue, 24 Nov 2020 13:28:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 10/45] dm: remove the block_device reference in struct mapped_device
Date:   Tue, 24 Nov 2020 14:27:16 +0100
Message-Id: <20201124132751.3747337-11-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124132751.3747337-1-hch@lst.de>
References: <20201124132751.3747337-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Get rid of the long-lasting struct block_device reference in
struct mapped_device.  The only remaining user is the freeze code,
where we can trivially look up the block device at freeze time
and release the reference at thaw time.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm-core.h |  2 --
 drivers/md/dm.c      | 25 ++++++++++++++-----------
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index aace147effcacb..086d293c2b036c 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -102,8 +102,6 @@ struct mapped_device {
 	/* kobject and completion */
 	struct dm_kobject_holder kobj_holder;
 
-	struct block_device *bdev;
-
 	struct dm_stats stats;
 
 	/* for blk-mq request-based DM support */
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index ab0a8335f098d9..48051db006f30c 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1744,11 +1744,6 @@ static void cleanup_mapped_device(struct mapped_device *md)
 
 	cleanup_srcu_struct(&md->io_barrier);
 
-	if (md->bdev) {
-		bdput(md->bdev);
-		md->bdev = NULL;
-	}
-
 	mutex_destroy(&md->suspend_lock);
 	mutex_destroy(&md->type_lock);
 	mutex_destroy(&md->table_devices_lock);
@@ -1840,10 +1835,6 @@ static struct mapped_device *alloc_dev(int minor)
 	if (!md->wq)
 		goto bad;
 
-	md->bdev = bdget_disk(md->disk, 0);
-	if (!md->bdev)
-		goto bad;
-
 	dm_stats_init(&md->stats);
 
 	/* Populate the mapping, nobody knows we exist yet */
@@ -2384,11 +2375,16 @@ struct dm_table *dm_swap_table(struct mapped_device *md, struct dm_table *table)
  */
 static int lock_fs(struct mapped_device *md)
 {
+	struct block_device *bdev;
 	int r;
 
 	WARN_ON(test_bit(DMF_FROZEN, &md->flags));
 
-	r = freeze_bdev(md->bdev);
+	bdev = bdget_disk(md->disk, 0);
+	if (!bdev)
+		return -ENOMEM;
+	r = freeze_bdev(bdev);
+	bdput(bdev);
 	if (!r)
 		set_bit(DMF_FROZEN, &md->flags);
 	return r;
@@ -2396,9 +2392,16 @@ static int lock_fs(struct mapped_device *md)
 
 static void unlock_fs(struct mapped_device *md)
 {
+	struct block_device *bdev;
+
 	if (!test_bit(DMF_FROZEN, &md->flags))
 		return;
-	thaw_bdev(md->bdev);
+
+	bdev = bdget_disk(md->disk, 0);
+	if (!bdev)
+		return;
+	thaw_bdev(bdev);
+	bdput(bdev);
 	clear_bit(DMF_FROZEN, &md->flags);
 }
 
-- 
2.29.2

