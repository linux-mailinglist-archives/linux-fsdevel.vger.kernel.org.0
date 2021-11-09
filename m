Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D504444A8D3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 09:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244221AbhKIIgi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 03:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244175AbhKIIgd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 03:36:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180C2C0613F5;
        Tue,  9 Nov 2021 00:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=xLzTeTwSOtoTfIUkgklZETw0n3WrCJUb6rxQ2UIADBU=; b=Qu+sHlhP1f41O67tHyN0ihLqsy
        HGY394+wu27/EDuT+S8kc0vgPEtjA1HZZ6hMtQlg++JufmBwRvJ4utJSe+eRJvGql42zPfqwXsSyw
        i2bUmaHWZdHv6expcVKnmTO3jbd+D1VnrfLnP0o5CV6clqLhmDy4Tmc3DeL+zB2nNCadj782pVFSe
        oh2QkYtsloQxpdRg4H3rQH6WVuMAZG6AqjwKWvgzKXS4WeGwxTILXIx4Sy/whKKTOBp8kfma1i96K
        07iGkHeXKIsInhxVdgFQYtA0PziLisa75Maw4niwNlE+e1HsGtlvcHGhldFhW6hfba8Lp1GDpGhfm
        Go1/+4Eg==;
Received: from [2001:4bb8:19a:7ee7:fb46:2fe1:8652:d9d4] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkMZW-000s49-Ix; Tue, 09 Nov 2021 08:33:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        dm-devel@redhat.com, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 14/29] fsdax: simplify the pgoff calculation
Date:   Tue,  9 Nov 2021 09:32:54 +0100
Message-Id: <20211109083309.584081-15-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211109083309.584081-1-hch@lst.de>
References: <20211109083309.584081-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Replace the two steps of dax_iomap_sector and bdev_dax_pgoff with a
single dax_iomap_pgoff helper that avoids lots of cumbersome sector
conversions.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/dax/super.c | 14 --------------
 fs/dax.c            | 35 ++++++++++-------------------------
 include/linux/dax.h |  1 -
 3 files changed, 10 insertions(+), 40 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 803942586d1b6..c0910687fbcb2 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -67,20 +67,6 @@ void dax_remove_host(struct gendisk *disk)
 }
 EXPORT_SYMBOL_GPL(dax_remove_host);
 
-int bdev_dax_pgoff(struct block_device *bdev, sector_t sector, size_t size,
-		pgoff_t *pgoff)
-{
-	sector_t start_sect = bdev ? get_start_sect(bdev) : 0;
-	phys_addr_t phys_off = (start_sect + sector) * 512;
-
-	if (pgoff)
-		*pgoff = PHYS_PFN(phys_off);
-	if (phys_off % PAGE_SIZE || size % PAGE_SIZE)
-		return -EINVAL;
-	return 0;
-}
-EXPORT_SYMBOL(bdev_dax_pgoff);
-
 /**
  * dax_get_by_host() - temporary lookup mechanism for filesystem-dax
  * @bdev: block device to find a dax_device for
diff --git a/fs/dax.c b/fs/dax.c
index e51b4129d1b65..5364549d67a48 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -709,23 +709,22 @@ int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
 	return __dax_invalidate_entry(mapping, index, false);
 }
 
-static sector_t dax_iomap_sector(const struct iomap *iomap, loff_t pos)
+static pgoff_t dax_iomap_pgoff(const struct iomap *iomap, loff_t pos)
 {
-	return (iomap->addr + (pos & PAGE_MASK) - iomap->offset) >> 9;
+	phys_addr_t paddr = iomap->addr + (pos & PAGE_MASK) - iomap->offset;
+
+	if (iomap->bdev)
+		paddr += (get_start_sect(iomap->bdev) << SECTOR_SHIFT);
+	return PHYS_PFN(paddr);
 }
 
 static int copy_cow_page_dax(struct vm_fault *vmf, const struct iomap_iter *iter)
 {
-	sector_t sector = dax_iomap_sector(&iter->iomap, iter->pos);
+	pgoff_t pgoff = dax_iomap_pgoff(&iter->iomap, iter->pos);
 	void *vto, *kaddr;
-	pgoff_t pgoff;
 	long rc;
 	int id;
 
-	rc = bdev_dax_pgoff(iter->iomap.bdev, sector, PAGE_SIZE, &pgoff);
-	if (rc)
-		return rc;
-
 	id = dax_read_lock();
 	rc = dax_direct_access(iter->iomap.dax_dev, pgoff, 1, &kaddr, NULL);
 	if (rc < 0) {
@@ -1013,14 +1012,10 @@ EXPORT_SYMBOL_GPL(dax_writeback_mapping_range);
 static int dax_iomap_pfn(const struct iomap *iomap, loff_t pos, size_t size,
 			 pfn_t *pfnp)
 {
-	const sector_t sector = dax_iomap_sector(iomap, pos);
-	pgoff_t pgoff;
+	pgoff_t pgoff = dax_iomap_pgoff(iomap, pos);
 	int id, rc;
 	long length;
 
-	rc = bdev_dax_pgoff(iomap->bdev, sector, size, &pgoff);
-	if (rc)
-		return rc;
 	id = dax_read_lock();
 	length = dax_direct_access(iomap->dax_dev, pgoff, PHYS_PFN(size),
 				   NULL, pfnp);
@@ -1129,7 +1124,7 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
 {
 	sector_t sector = iomap_sector(iomap, pos & PAGE_MASK);
-	pgoff_t pgoff;
+	pgoff_t pgoff = dax_iomap_pgoff(iomap, pos);
 	long rc, id;
 	void *kaddr;
 	bool page_aligned = false;
@@ -1140,10 +1135,6 @@ s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
 	    (size == PAGE_SIZE))
 		page_aligned = true;
 
-	rc = bdev_dax_pgoff(iomap->bdev, sector, PAGE_SIZE, &pgoff);
-	if (rc)
-		return rc;
-
 	id = dax_read_lock();
 
 	if (page_aligned)
@@ -1169,7 +1160,6 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 	const struct iomap *iomap = &iomi->iomap;
 	loff_t length = iomap_length(iomi);
 	loff_t pos = iomi->pos;
-	struct block_device *bdev = iomap->bdev;
 	struct dax_device *dax_dev = iomap->dax_dev;
 	loff_t end = pos + length, done = 0;
 	ssize_t ret = 0;
@@ -1203,9 +1193,8 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 	while (pos < end) {
 		unsigned offset = pos & (PAGE_SIZE - 1);
 		const size_t size = ALIGN(length + offset, PAGE_SIZE);
-		const sector_t sector = dax_iomap_sector(iomap, pos);
+		pgoff_t pgoff = dax_iomap_pgoff(iomap, pos);
 		ssize_t map_len;
-		pgoff_t pgoff;
 		void *kaddr;
 
 		if (fatal_signal_pending(current)) {
@@ -1213,10 +1202,6 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 			break;
 		}
 
-		ret = bdev_dax_pgoff(bdev, sector, size, &pgoff);
-		if (ret)
-			break;
-
 		map_len = dax_direct_access(dax_dev, pgoff, PHYS_PFN(size),
 				&kaddr, NULL);
 		if (map_len < 0) {
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 439c3c70e347b..324363b798ecd 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -107,7 +107,6 @@ static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
 #endif
 
 struct writeback_control;
-int bdev_dax_pgoff(struct block_device *, sector_t, size_t, pgoff_t *pgoff);
 #if IS_ENABLED(CONFIG_FS_DAX)
 int dax_add_host(struct dax_device *dax_dev, struct gendisk *disk);
 void dax_remove_host(struct gendisk *disk);
-- 
2.30.2

