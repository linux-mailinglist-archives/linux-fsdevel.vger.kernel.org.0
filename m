Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50DCC44A877
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 09:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244140AbhKIIgR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 03:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244122AbhKIIgN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 03:36:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EC7C061764;
        Tue,  9 Nov 2021 00:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=PduHU8OVnaMlcyFBdvvC6dkNgFcNCcL6yWQuKe6gbBU=; b=KhOLEDF7sJqUd9mzdN43IwfTBm
        Zrv412eDLpQ0wyM+3T3QoYACpWiZwuQEcgego4mPFKeBo4mcplS1GigOzbX6bSPGQf9PVbS6l4FsL
        DDwnFWgl8nCtpDWB/BgRZC0GeGDMba51VXWddcD3wGVKzy+KtFplRayk1Wi+Ma0yM6cpOqSNxvaU2
        ltevw9X/YDGUUSNW/VN11LQsD5briS66BUrvxbvcEd4TG7CUabwGRngJPMA3FPjA7sJ7wqf9mDWQW
        7Owugg45pDPkijK0xD7YBUnLLJ9Il4g6ZF+M2HRj8WwgL4cNlHNJLAGlU1THKCAd8OoudgAOYLxZM
        ErX1FfHw==;
Received: from [2001:4bb8:19a:7ee7:fb46:2fe1:8652:d9d4] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkMZB-000ryB-NA; Tue, 09 Nov 2021 08:33:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        dm-devel@redhat.com, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 02/29] dm: make the DAX support dependend on CONFIG_FS_DAX
Date:   Tue,  9 Nov 2021 09:32:42 +0100
Message-Id: <20211109083309.584081-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211109083309.584081-1-hch@lst.de>
References: <20211109083309.584081-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The device mapper DAX support is all hanging off a block device and thus
can't be used with device dax.  Make it depend on CONFIG_FS_DAX instead
of CONFIG_DAX_DRIVER.  This also means that bdev_dax_pgoff only needs to
be built under CONFIG_FS_DAX now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/dax/super.c        | 6 ++----
 drivers/md/dm-linear.c     | 2 +-
 drivers/md/dm-log-writes.c | 2 +-
 drivers/md/dm-stripe.c     | 2 +-
 drivers/md/dm-writecache.c | 2 +-
 drivers/md/dm.c            | 2 +-
 6 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index b882cf8106ea3..e20d0cef10a18 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -63,7 +63,7 @@ static int dax_host_hash(const char *host)
 	return hashlen_hash(hashlen_string("DAX", host)) % DAX_HASH_SIZE;
 }
 
-#ifdef CONFIG_BLOCK
+#if defined(CONFIG_BLOCK) && defined(CONFIG_FS_DAX)
 #include <linux/blkdev.h>
 
 int bdev_dax_pgoff(struct block_device *bdev, sector_t sector, size_t size,
@@ -80,7 +80,6 @@ int bdev_dax_pgoff(struct block_device *bdev, sector_t sector, size_t size,
 }
 EXPORT_SYMBOL(bdev_dax_pgoff);
 
-#if IS_ENABLED(CONFIG_FS_DAX)
 /**
  * dax_get_by_host() - temporary lookup mechanism for filesystem-dax
  * @host: alternate name for the device registered by a dax driver
@@ -219,8 +218,7 @@ bool dax_supported(struct dax_device *dax_dev, struct block_device *bdev,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dax_supported);
-#endif /* CONFIG_FS_DAX */
-#endif /* CONFIG_BLOCK */
+#endif /* CONFIG_BLOCK && CONFIG_FS_DAX */
 
 enum dax_device_flags {
 	/* !alive + rcu grace period == no new operations / mappings */
diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 66ba16713f696..0a260c35aeeed 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -162,7 +162,7 @@ static int linear_iterate_devices(struct dm_target *ti,
 	return fn(ti, lc->dev, lc->start, ti->len, data);
 }
 
-#if IS_ENABLED(CONFIG_DAX_DRIVER)
+#if IS_ENABLED(CONFIG_FS_DAX)
 static long linear_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
 		long nr_pages, void **kaddr, pfn_t *pfn)
 {
diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
index 46de085a96709..524bc536922eb 100644
--- a/drivers/md/dm-log-writes.c
+++ b/drivers/md/dm-log-writes.c
@@ -903,7 +903,7 @@ static void log_writes_io_hints(struct dm_target *ti, struct queue_limits *limit
 	limits->io_min = limits->physical_block_size;
 }
 
-#if IS_ENABLED(CONFIG_DAX_DRIVER)
+#if IS_ENABLED(CONFIG_FS_DAX)
 static int log_dax(struct log_writes_c *lc, sector_t sector, size_t bytes,
 		   struct iov_iter *i)
 {
diff --git a/drivers/md/dm-stripe.c b/drivers/md/dm-stripe.c
index 6660b6b53d5bf..f084607220293 100644
--- a/drivers/md/dm-stripe.c
+++ b/drivers/md/dm-stripe.c
@@ -300,7 +300,7 @@ static int stripe_map(struct dm_target *ti, struct bio *bio)
 	return DM_MAPIO_REMAPPED;
 }
 
-#if IS_ENABLED(CONFIG_DAX_DRIVER)
+#if IS_ENABLED(CONFIG_FS_DAX)
 static long stripe_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
 		long nr_pages, void **kaddr, pfn_t *pfn)
 {
diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 017806096b91e..0af464a863fe6 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -38,7 +38,7 @@
 #define BITMAP_GRANULARITY	PAGE_SIZE
 #endif
 
-#if IS_ENABLED(CONFIG_ARCH_HAS_PMEM_API) && IS_ENABLED(CONFIG_DAX_DRIVER)
+#if IS_ENABLED(CONFIG_ARCH_HAS_PMEM_API) && IS_ENABLED(CONFIG_FS_DAX)
 #define DM_WRITECACHE_HAS_PMEM
 #endif
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 63aa522636585..893fca738a3d8 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1783,7 +1783,7 @@ static struct mapped_device *alloc_dev(int minor)
 	md->disk->private_data = md;
 	sprintf(md->disk->disk_name, "dm-%d", minor);
 
-	if (IS_ENABLED(CONFIG_DAX_DRIVER)) {
+	if (IS_ENABLED(CONFIG_FS_DAX)) {
 		md->dax_dev = alloc_dax(md, md->disk->disk_name,
 					&dm_dax_ops, 0);
 		if (IS_ERR(md->dax_dev))
-- 
2.30.2

