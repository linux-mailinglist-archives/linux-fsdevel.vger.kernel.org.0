Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29BEC146EB0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2020 17:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgAWQyJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jan 2020 11:54:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23752 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729106AbgAWQyJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jan 2020 11:54:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579798446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=jpq/osZAJyDr2z94dAuCr9p/bGQZdQmEdxKCIx63h60=;
        b=Ui3Y1HGJAERm42El9A1MH+doSa28a3S+yodr0Q4gQIbulJ6WZxCDylsHzJ/7noMBqFlrTZ
        HpronqDBxHsF+N+MnTls0Ex8TUbXxHFW3udf5Pu/h/PNvMF6iteETQfazQrLp6JvNmnHYs
        /enjW31jDUTnDfyhT8BCizK2DgrBJQ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-Qv0KknqCOVGAJGcqvsA4nA-1; Thu, 23 Jan 2020 11:52:53 -0500
X-MC-Unique: Qv0KknqCOVGAJGcqvsA4nA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96FD01800D78;
        Thu, 23 Jan 2020 16:52:50 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5CC485C1BB;
        Thu, 23 Jan 2020 16:52:50 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id E2F7B2202E9; Thu, 23 Jan 2020 11:52:49 -0500 (EST)
Date:   Thu, 23 Jan 2020 11:52:49 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>, dan.j.williams@intel.com,
        linux-nvdimm@lists.01.org
Cc:     linux-fsdevel@vger.kernel.org, vishal.l.verma@intel.com,
        Jeff Moyer <jmoyer@redhat.com>
Subject: [RFC] dax,pmem: Provide a dax operation to zero range of memory
Message-ID: <20200123165249.GA7664@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This is an RFC patch to provide a dax operation to zero a range of memory.
It will also clear poison in the process. This is primarily compile tested
patch. I don't have real hardware to test the poison logic. I am posting
this to figure out if this is the right direction or not.

Motivation from this patch comes from Christoph's feedback that he will
rather prefer a dax way to zero a range instead of relying on having to
call blkdev_issue_zeroout() in __dax_zero_page_range().

https://lkml.org/lkml/2019/8/26/361

My motivation for this change is virtiofs DAX support. There we use DAX
but we don't have a block device. So any dax code which has the assumption
that there is always a block device associated is a problem. So this
is more of a cleanup of one of the places where dax has this dependency
on block device and if we add a dax operation for zeroing a range, it
can help with not having to call blkdev_issue_zeroout() in dax path.

I have yet to take care of stacked block drivers (dm/md).

Current poison clearing logic is primarily written with assumption that
I/O is sector aligned. With this new method, this assumption is broken
and one can pass any range of memory to zero. I have fixed few places
in existing logic to be able to handle an arbitrary start/end. I am
not sure are there other dependencies which might need fixing or
prohibit us from providing this method.

Any feedback or comment is welcome.

Thanks
Vivek

---
 drivers/dax/super.c   |   13 +++++++++
 drivers/nvdimm/pmem.c |   67 ++++++++++++++++++++++++++++++++++++++++++--------
 fs/dax.c              |   39 ++++++++---------------------
 include/linux/dax.h   |    3 ++
 4 files changed, 85 insertions(+), 37 deletions(-)

Index: rhvgoyal-linux/drivers/nvdimm/pmem.c
===================================================================
--- rhvgoyal-linux.orig/drivers/nvdimm/pmem.c	2020-01-23 11:32:11.075139183 -0500
+++ rhvgoyal-linux/drivers/nvdimm/pmem.c	2020-01-23 11:32:28.660139183 -0500
@@ -52,8 +52,8 @@ static void hwpoison_clear(struct pmem_d
 	if (is_vmalloc_addr(pmem->virt_addr))
 		return;
 
-	pfn_start = PHYS_PFN(phys);
-	pfn_end = pfn_start + PHYS_PFN(len);
+	pfn_start = PFN_UP(phys);
+	pfn_end = PFN_DOWN(phys + len);
 	for (pfn = pfn_start; pfn < pfn_end; pfn++) {
 		struct page *page = pfn_to_page(pfn);
 
@@ -71,22 +71,24 @@ static blk_status_t pmem_clear_poison(st
 		phys_addr_t offset, unsigned int len)
 {
 	struct device *dev = to_dev(pmem);
-	sector_t sector;
+	sector_t sector_start, sector_end;
 	long cleared;
 	blk_status_t rc = BLK_STS_OK;
+	int nr_sectors;
 
-	sector = (offset - pmem->data_offset) / 512;
+	sector_start = ALIGN((offset - pmem->data_offset), 512) / 512;
+	sector_end = ALIGN_DOWN((offset - pmem->data_offset + len), 512)/512;
+	nr_sectors =  sector_end - sector_start;
 
 	cleared = nvdimm_clear_poison(dev, pmem->phys_addr + offset, len);
 	if (cleared < len)
 		rc = BLK_STS_IOERR;
-	if (cleared > 0 && cleared / 512) {
+	if (cleared > 0 && nr_sectors > 0) {
 		hwpoison_clear(pmem, pmem->phys_addr + offset, cleared);
-		cleared /= 512;
-		dev_dbg(dev, "%#llx clear %ld sector%s\n",
-				(unsigned long long) sector, cleared,
-				cleared > 1 ? "s" : "");
-		badblocks_clear(&pmem->bb, sector, cleared);
+		dev_dbg(dev, "%#llx clear %d sector%s\n",
+				(unsigned long long) sector_start, nr_sectors,
+				nr_sectors > 1 ? "s" : "");
+		badblocks_clear(&pmem->bb, sector_start, nr_sectors);
 		if (pmem->bb_state)
 			sysfs_notify_dirent(pmem->bb_state);
 	}
@@ -268,6 +270,50 @@ static const struct block_device_operati
 	.revalidate_disk =	nvdimm_revalidate_disk,
 };
 
+static int pmem_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
+				    unsigned int offset, loff_t len)
+{
+	int rc = 0;
+	phys_addr_t phys_pos = pgoff * PAGE_SIZE + offset;
+	struct pmem_device *pmem = dax_get_private(dax_dev);
+	struct page *page = ZERO_PAGE(0);
+
+	do {
+		unsigned bytes, nr_sectors = 0;
+		sector_t sector_start, sector_end;
+		bool bad_pmem = false;
+		phys_addr_t pmem_off = phys_pos + pmem->data_offset;
+		void *pmem_addr = pmem->virt_addr + pmem_off;
+		unsigned int page_offset;
+
+		page_offset = offset_in_page(phys_pos);
+		bytes = min_t(loff_t, PAGE_SIZE - page_offset, len);
+
+		sector_start = ALIGN(phys_pos, 512)/512;
+		sector_end = ALIGN_DOWN(phys_pos + bytes, 512)/512;
+		if (sector_end > sector_start)
+			nr_sectors = sector_end - sector_start;
+
+		if (nr_sectors &&
+		    unlikely(is_bad_pmem(&pmem->bb, sector_start,
+					 nr_sectors * 512)))
+			bad_pmem = true;
+
+		write_pmem(pmem_addr, page, 0, bytes);
+		if (unlikely(bad_pmem)) {
+			rc = pmem_clear_poison(pmem, pmem_off, bytes);
+			write_pmem(pmem_addr, page, 0, bytes);
+		}
+		if (rc > 0)
+			return -EIO;
+
+		phys_pos += phys_pos + bytes;
+		len -= bytes;
+	} while (len > 0);
+
+	return 0;
+}
+
 static long pmem_dax_direct_access(struct dax_device *dax_dev,
 		pgoff_t pgoff, long nr_pages, void **kaddr, pfn_t *pfn)
 {
@@ -299,6 +345,7 @@ static const struct dax_operations pmem_
 	.dax_supported = generic_fsdax_supported,
 	.copy_from_iter = pmem_copy_from_iter,
 	.copy_to_iter = pmem_copy_to_iter,
+	.zero_page_range = pmem_dax_zero_page_range,
 };
 
 static const struct attribute_group *pmem_attribute_groups[] = {
Index: rhvgoyal-linux/include/linux/dax.h
===================================================================
--- rhvgoyal-linux.orig/include/linux/dax.h	2020-01-23 11:25:23.814139183 -0500
+++ rhvgoyal-linux/include/linux/dax.h	2020-01-23 11:32:17.799139183 -0500
@@ -34,6 +34,8 @@ struct dax_operations {
 	/* copy_to_iter: required operation for fs-dax direct-i/o */
 	size_t (*copy_to_iter)(struct dax_device *, pgoff_t, void *, size_t,
 			struct iov_iter *);
+	/* zero_page_range: optional operation for fs-dax direct-i/o */
+	int (*zero_page_range)(struct dax_device *, pgoff_t, unsigned, loff_t);
 };
 
 extern struct attribute_group dax_attribute_group;
@@ -209,6 +211,7 @@ size_t dax_copy_from_iter(struct dax_dev
 		size_t bytes, struct iov_iter *i);
 size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
 		size_t bytes, struct iov_iter *i);
+int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff, unsigned offset, loff_t len);
 void dax_flush(struct dax_device *dax_dev, void *addr, size_t size);
 
 ssize_t dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
Index: rhvgoyal-linux/fs/dax.c
===================================================================
--- rhvgoyal-linux.orig/fs/dax.c	2020-01-23 11:25:23.814139183 -0500
+++ rhvgoyal-linux/fs/dax.c	2020-01-23 11:32:17.801139183 -0500
@@ -1044,38 +1044,23 @@ static vm_fault_t dax_load_hole(struct x
 	return ret;
 }
 
-static bool dax_range_is_aligned(struct block_device *bdev,
-				 unsigned int offset, unsigned int length)
-{
-	unsigned short sector_size = bdev_logical_block_size(bdev);
-
-	if (!IS_ALIGNED(offset, sector_size))
-		return false;
-	if (!IS_ALIGNED(length, sector_size))
-		return false;
-
-	return true;
-}
-
 int __dax_zero_page_range(struct block_device *bdev,
 		struct dax_device *dax_dev, sector_t sector,
 		unsigned int offset, unsigned int size)
 {
-	if (dax_range_is_aligned(bdev, offset, size)) {
-		sector_t start_sector = sector + (offset >> 9);
+	pgoff_t pgoff;
+	long rc, id;
 
-		return blkdev_issue_zeroout(bdev, start_sector,
-				size >> 9, GFP_NOFS, 0);
-	} else {
-		pgoff_t pgoff;
-		long rc, id;
+	rc = bdev_dax_pgoff(bdev, sector, PAGE_SIZE, &pgoff);
+	if (rc)
+		return rc;
+
+	id = dax_read_lock();
+	rc = dax_zero_page_range(dax_dev, pgoff, offset, size);
+	if (rc == -EOPNOTSUPP) {
 		void *kaddr;
 
-		rc = bdev_dax_pgoff(bdev, sector, PAGE_SIZE, &pgoff);
-		if (rc)
-			return rc;
-
-		id = dax_read_lock();
+		/* If driver does not implement zero page range, fallback */
 		rc = dax_direct_access(dax_dev, pgoff, 1, &kaddr, NULL);
 		if (rc < 0) {
 			dax_read_unlock(id);
@@ -1083,9 +1068,9 @@ int __dax_zero_page_range(struct block_d
 		}
 		memset(kaddr + offset, 0, size);
 		dax_flush(dax_dev, kaddr + offset, size);
-		dax_read_unlock(id);
 	}
-	return 0;
+	dax_read_unlock(id);
+	return rc;
 }
 EXPORT_SYMBOL_GPL(__dax_zero_page_range);
 
Index: rhvgoyal-linux/drivers/dax/super.c
===================================================================
--- rhvgoyal-linux.orig/drivers/dax/super.c	2020-01-23 11:25:23.814139183 -0500
+++ rhvgoyal-linux/drivers/dax/super.c	2020-01-23 11:32:17.802139183 -0500
@@ -344,6 +344,19 @@ size_t dax_copy_to_iter(struct dax_devic
 }
 EXPORT_SYMBOL_GPL(dax_copy_to_iter);
 
+int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
+			unsigned offset, loff_t len)
+{
+	if (!dax_alive(dax_dev))
+		return 0;
+
+	if (!dax_dev->ops->zero_page_range)
+		return -EOPNOTSUPP;
+
+	return dax_dev->ops->zero_page_range(dax_dev, pgoff, offset, len);
+}
+EXPORT_SYMBOL_GPL(dax_zero_page_range);
+
 #ifdef CONFIG_ARCH_HAS_PMEM_API
 void arch_wb_cache_pmem(void *addr, size_t size);
 void dax_flush(struct dax_device *dax_dev, void *addr, size_t size)

