Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF2D44A898
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 09:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244158AbhKIIga (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 03:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244150AbhKIIgW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 03:36:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF454C061766;
        Tue,  9 Nov 2021 00:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Vpkz3086VxLuagYIc2khh5tOTNYNsy927IaI4zhihik=; b=qHZxorqKwiVe5rY3M9gXhiU1hj
        OME5ZF3yPwHeDDxGTubHix4+Uzd8rNpPiP24KRvT1Abk8A1oFTmAfVIZQ91+MzAdr2eV8T2oL/XME
        j10hqNYZB2d5bfxBuxK9qPaRKafes9QwI9IFhRkI9sST116xIz7Zmh6XD5n2aHM39BR7uuEShbw/7
        v4TPZ75iMiLGvI6v+VEyoUvuZJQTDob6gMHHgZKTqi90OkjTP+EeUor0tQ8RZzXsWWxz2633m7y22
        DVuuPCl/ghcXrHywBoMmUOhphbi4XRJXPLWwcgbZ+21ddufDVMXugEZ3ioiVbBwxvjN5yGnJpCm5j
        YcrE7+jg==;
Received: from [2001:4bb8:19a:7ee7:fb46:2fe1:8652:d9d4] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkMZP-000s1P-HH; Tue, 09 Nov 2021 08:33:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        dm-devel@redhat.com, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 10/29] dm-log-writes: add a log_writes_dax_pgoff helper
Date:   Tue,  9 Nov 2021 09:32:50 +0100
Message-Id: <20211109083309.584081-11-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211109083309.584081-1-hch@lst.de>
References: <20211109083309.584081-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a helper to perform the entire remapping for DAX accesses.  This
helper open codes bdev_dax_pgoff given that the alignment checks have
already been done by the submitting file system and don't need to be
repeated.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm-log-writes.c | 42 +++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
index 524bc536922eb..df3cd78223fb2 100644
--- a/drivers/md/dm-log-writes.c
+++ b/drivers/md/dm-log-writes.c
@@ -949,17 +949,21 @@ static int log_dax(struct log_writes_c *lc, sector_t sector, size_t bytes,
 	return 0;
 }
 
+static struct dax_device *log_writes_dax_pgoff(struct dm_target *ti,
+		pgoff_t *pgoff)
+{
+	struct log_writes_c *lc = ti->private;
+
+	*pgoff += (get_start_sect(lc->dev->bdev) >> PAGE_SECTORS_SHIFT);
+	return lc->dev->dax_dev;
+}
+
 static long log_writes_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
 					 long nr_pages, void **kaddr, pfn_t *pfn)
 {
-	struct log_writes_c *lc = ti->private;
-	sector_t sector = pgoff * PAGE_SECTORS;
-	int ret;
+	struct dax_device *dax_dev = log_writes_dax_pgoff(ti, &pgoff);
 
-	ret = bdev_dax_pgoff(lc->dev->bdev, sector, nr_pages * PAGE_SIZE, &pgoff);
-	if (ret)
-		return ret;
-	return dax_direct_access(lc->dev->dax_dev, pgoff, nr_pages, kaddr, pfn);
+	return dax_direct_access(dax_dev, pgoff, nr_pages, kaddr, pfn);
 }
 
 static size_t log_writes_dax_copy_from_iter(struct dm_target *ti,
@@ -968,11 +972,9 @@ static size_t log_writes_dax_copy_from_iter(struct dm_target *ti,
 {
 	struct log_writes_c *lc = ti->private;
 	sector_t sector = pgoff * PAGE_SECTORS;
+	struct dax_device *dax_dev = log_writes_dax_pgoff(ti, &pgoff);
 	int err;
 
-	if (bdev_dax_pgoff(lc->dev->bdev, sector, ALIGN(bytes, PAGE_SIZE), &pgoff))
-		return 0;
-
 	/* Don't bother doing anything if logging has been disabled */
 	if (!lc->logging_enabled)
 		goto dax_copy;
@@ -983,34 +985,24 @@ static size_t log_writes_dax_copy_from_iter(struct dm_target *ti,
 		return 0;
 	}
 dax_copy:
-	return dax_copy_from_iter(lc->dev->dax_dev, pgoff, addr, bytes, i);
+	return dax_copy_from_iter(dax_dev, pgoff, addr, bytes, i);
 }
 
 static size_t log_writes_dax_copy_to_iter(struct dm_target *ti,
 					  pgoff_t pgoff, void *addr, size_t bytes,
 					  struct iov_iter *i)
 {
-	struct log_writes_c *lc = ti->private;
-	sector_t sector = pgoff * PAGE_SECTORS;
+	struct dax_device *dax_dev = log_writes_dax_pgoff(ti, &pgoff);
 
-	if (bdev_dax_pgoff(lc->dev->bdev, sector, ALIGN(bytes, PAGE_SIZE), &pgoff))
-		return 0;
-	return dax_copy_to_iter(lc->dev->dax_dev, pgoff, addr, bytes, i);
+	return dax_copy_to_iter(dax_dev, pgoff, addr, bytes, i);
 }
 
 static int log_writes_dax_zero_page_range(struct dm_target *ti, pgoff_t pgoff,
 					  size_t nr_pages)
 {
-	int ret;
-	struct log_writes_c *lc = ti->private;
-	sector_t sector = pgoff * PAGE_SECTORS;
+	struct dax_device *dax_dev = log_writes_dax_pgoff(ti, &pgoff);
 
-	ret = bdev_dax_pgoff(lc->dev->bdev, sector, nr_pages << PAGE_SHIFT,
-			     &pgoff);
-	if (ret)
-		return ret;
-	return dax_zero_page_range(lc->dev->dax_dev, pgoff,
-				   nr_pages << PAGE_SHIFT);
+	return dax_zero_page_range(dax_dev, pgoff, nr_pages << PAGE_SHIFT);
 }
 
 #else
-- 
2.30.2

