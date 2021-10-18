Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6373430F3D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 06:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbhJREnv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 00:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhJREnr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 00:43:47 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97E5C06161C;
        Sun, 17 Oct 2021 21:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=NWRSaBjXDrc58K1oj+PE/wR9vn+9X0aQXm/bAOg12tE=; b=1d8cXQVXjk+JGdcI/anFzyAIB+
        jgB3oMIkS682cycJDTMPg4gPEB3/UnsmiLecgvLUw9Ajih6dFsVYlAJNXr39QLXQx55yPJvt4ci4i
        ECGp50OerwpW6muAkWZxKjOhppD4FBGWZIWzq3zTd/NIdoHfdANyRQLEYs5l4j6w/hIO46IfrsWCG
        De9Rt5dzKHh3HIWGA0Wyvl8zgk05HIKasE9OdehfasxF2JNJKXglz5/7bxaXkQpJhu2ZEo5xioeZ5
        5X8XdkB9I86u11AycCppr1InCFSpK4nFDVxZgzu69RSpqtGxvlhcjrX9ZumEhVNy6f9UAHj3vTQsJ
        xXuTwgrA==;
Received: from 089144211028.atnat0020.highway.a1.net ([89.144.211.28] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcKSn-00E3Tr-Rc; Mon, 18 Oct 2021 04:41:30 +0000
From:   Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, dm-devel@redhat.com,
        linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 10/11] dm-stripe: add a stripe_dax_pgoff helper
Date:   Mon, 18 Oct 2021 06:40:53 +0200
Message-Id: <20211018044054.1779424-11-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211018044054.1779424-1-hch@lst.de>
References: <20211018044054.1779424-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a helper to perform the entire remapping for DAX accesses.  This
helper open codes bdev_dax_pgoff given that the alignment checks have
already been done by the submitting file system and don't need to be
repeated.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm-stripe.c | 63 ++++++++++--------------------------------
 1 file changed, 15 insertions(+), 48 deletions(-)

diff --git a/drivers/md/dm-stripe.c b/drivers/md/dm-stripe.c
index f084607220293..50dba3f39274c 100644
--- a/drivers/md/dm-stripe.c
+++ b/drivers/md/dm-stripe.c
@@ -301,83 +301,50 @@ static int stripe_map(struct dm_target *ti, struct bio *bio)
 }
 
 #if IS_ENABLED(CONFIG_FS_DAX)
-static long stripe_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
-		long nr_pages, void **kaddr, pfn_t *pfn)
+static struct dax_device *stripe_dax_pgoff(struct dm_target *ti, pgoff_t *pgoff)
 {
-	sector_t dev_sector, sector = pgoff * PAGE_SECTORS;
 	struct stripe_c *sc = ti->private;
-	struct dax_device *dax_dev;
 	struct block_device *bdev;
+	sector_t dev_sector;
 	uint32_t stripe;
-	long ret;
 
-	stripe_map_sector(sc, sector, &stripe, &dev_sector);
+	stripe_map_sector(sc, *pgoff * PAGE_SECTORS, &stripe, &dev_sector);
 	dev_sector += sc->stripe[stripe].physical_start;
-	dax_dev = sc->stripe[stripe].dev->dax_dev;
 	bdev = sc->stripe[stripe].dev->bdev;
 
-	ret = bdev_dax_pgoff(bdev, dev_sector, nr_pages * PAGE_SIZE, &pgoff);
-	if (ret)
-		return ret;
+	*pgoff = (get_start_sect(bdev) + dev_sector) >> PAGE_SECTORS_SHIFT;
+	return sc->stripe[stripe].dev->dax_dev;
+}
+
+static long stripe_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
+		long nr_pages, void **kaddr, pfn_t *pfn)
+{
+	struct dax_device *dax_dev = stripe_dax_pgoff(ti, &pgoff);
+
 	return dax_direct_access(dax_dev, pgoff, nr_pages, kaddr, pfn);
 }
 
 static size_t stripe_dax_copy_from_iter(struct dm_target *ti, pgoff_t pgoff,
 		void *addr, size_t bytes, struct iov_iter *i)
 {
-	sector_t dev_sector, sector = pgoff * PAGE_SECTORS;
-	struct stripe_c *sc = ti->private;
-	struct dax_device *dax_dev;
-	struct block_device *bdev;
-	uint32_t stripe;
-
-	stripe_map_sector(sc, sector, &stripe, &dev_sector);
-	dev_sector += sc->stripe[stripe].physical_start;
-	dax_dev = sc->stripe[stripe].dev->dax_dev;
-	bdev = sc->stripe[stripe].dev->bdev;
+	struct dax_device *dax_dev = stripe_dax_pgoff(ti, &pgoff);
 
-	if (bdev_dax_pgoff(bdev, dev_sector, ALIGN(bytes, PAGE_SIZE), &pgoff))
-		return 0;
 	return dax_copy_from_iter(dax_dev, pgoff, addr, bytes, i);
 }
 
 static size_t stripe_dax_copy_to_iter(struct dm_target *ti, pgoff_t pgoff,
 		void *addr, size_t bytes, struct iov_iter *i)
 {
-	sector_t dev_sector, sector = pgoff * PAGE_SECTORS;
-	struct stripe_c *sc = ti->private;
-	struct dax_device *dax_dev;
-	struct block_device *bdev;
-	uint32_t stripe;
-
-	stripe_map_sector(sc, sector, &stripe, &dev_sector);
-	dev_sector += sc->stripe[stripe].physical_start;
-	dax_dev = sc->stripe[stripe].dev->dax_dev;
-	bdev = sc->stripe[stripe].dev->bdev;
+	struct dax_device *dax_dev = stripe_dax_pgoff(ti, &pgoff);
 
-	if (bdev_dax_pgoff(bdev, dev_sector, ALIGN(bytes, PAGE_SIZE), &pgoff))
-		return 0;
 	return dax_copy_to_iter(dax_dev, pgoff, addr, bytes, i);
 }
 
 static int stripe_dax_zero_page_range(struct dm_target *ti, pgoff_t pgoff,
 				      size_t nr_pages)
 {
-	int ret;
-	sector_t dev_sector, sector = pgoff * PAGE_SECTORS;
-	struct stripe_c *sc = ti->private;
-	struct dax_device *dax_dev;
-	struct block_device *bdev;
-	uint32_t stripe;
+	struct dax_device *dax_dev = stripe_dax_pgoff(ti, &pgoff);
 
-	stripe_map_sector(sc, sector, &stripe, &dev_sector);
-	dev_sector += sc->stripe[stripe].physical_start;
-	dax_dev = sc->stripe[stripe].dev->dax_dev;
-	bdev = sc->stripe[stripe].dev->bdev;
-
-	ret = bdev_dax_pgoff(bdev, dev_sector, nr_pages << PAGE_SHIFT, &pgoff);
-	if (ret)
-		return ret;
 	return dax_zero_page_range(dax_dev, pgoff, nr_pages);
 }
 
-- 
2.30.2

