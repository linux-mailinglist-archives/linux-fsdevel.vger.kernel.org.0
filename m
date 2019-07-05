Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3322F6073F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2019 16:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfGEOFq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jul 2019 10:05:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57589 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfGEOFp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jul 2019 10:05:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 10DD337F43;
        Fri,  5 Jul 2019 14:05:40 +0000 (UTC)
Received: from dhcp201-121.englab.pnq.redhat.com (ovpn-116-58.sin2.redhat.com [10.67.116.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C97486420;
        Fri,  5 Jul 2019 14:04:48 +0000 (UTC)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     dm-devel@redhat.com, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-acpi@vger.kernel.org,
        qemu-devel@nongnu.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
Cc:     dan.j.williams@intel.com, zwisler@kernel.org,
        vishal.l.verma@intel.com, dave.jiang@intel.com, mst@redhat.com,
        jasowang@redhat.com, willy@infradead.org, rjw@rjwysocki.net,
        hch@infradead.org, lenb@kernel.org, jack@suse.cz, tytso@mit.edu,
        adilger.kernel@dilger.ca, darrick.wong@oracle.com,
        lcapitulino@redhat.com, kwolf@redhat.com, imammedo@redhat.com,
        jmoyer@redhat.com, nilal@redhat.com, riel@surriel.com,
        stefanha@redhat.com, aarcange@redhat.com, david@redhat.com,
        david@fromorbit.com, cohuck@redhat.com,
        xiaoguangrong.eric@gmail.com, pagupta@redhat.com,
        pbonzini@redhat.com, yuval.shaia@oracle.com, kilobyte@angband.pl,
        jstaron@google.com, rdunlap@infradead.org, snitzer@redhat.com
Subject: [PATCH v15 1/7] libnvdimm: nd_region flush callback support
Date:   Fri,  5 Jul 2019 19:33:22 +0530
Message-Id: <20190705140328.20190-2-pagupta@redhat.com>
In-Reply-To: <20190705140328.20190-1-pagupta@redhat.com>
References: <20190705140328.20190-1-pagupta@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 05 Jul 2019 14:05:45 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch adds functionality to perform flush from guest
to host over VIRTIO. We are registering a callback based
on 'nd_region' type. virtio_pmem driver requires this special
flush function. For rest of the region types we are registering
existing flush function. Report error returned by host fsync
failure to userspace.

Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
---
 drivers/acpi/nfit/core.c     |  4 ++--
 drivers/nvdimm/claim.c       |  6 ++++--
 drivers/nvdimm/nd.h          |  1 +
 drivers/nvdimm/pmem.c        | 13 ++++++++-----
 drivers/nvdimm/region_devs.c | 26 ++++++++++++++++++++++++--
 include/linux/libnvdimm.h    |  9 ++++++++-
 6 files changed, 47 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index f1ed0befe303..9ddd8667153e 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -2434,7 +2434,7 @@ static void write_blk_ctl(struct nfit_blk *nfit_blk, unsigned int bw,
 		offset = to_interleave_offset(offset, mmio);
 
 	writeq(cmd, mmio->addr.base + offset);
-	nvdimm_flush(nfit_blk->nd_region);
+	nvdimm_flush(nfit_blk->nd_region, NULL);
 
 	if (nfit_blk->dimm_flags & NFIT_BLK_DCR_LATCH)
 		readq(mmio->addr.base + offset);
@@ -2483,7 +2483,7 @@ static int acpi_nfit_blk_single_io(struct nfit_blk *nfit_blk,
 	}
 
 	if (rw)
-		nvdimm_flush(nfit_blk->nd_region);
+		nvdimm_flush(nfit_blk->nd_region, NULL);
 
 	rc = read_blk_stat(nfit_blk, lane) ? -EIO : 0;
 	return rc;
diff --git a/drivers/nvdimm/claim.c b/drivers/nvdimm/claim.c
index fb667bf469c7..13510bae1e6f 100644
--- a/drivers/nvdimm/claim.c
+++ b/drivers/nvdimm/claim.c
@@ -263,7 +263,7 @@ static int nsio_rw_bytes(struct nd_namespace_common *ndns,
 	struct nd_namespace_io *nsio = to_nd_namespace_io(&ndns->dev);
 	unsigned int sz_align = ALIGN(size + (offset & (512 - 1)), 512);
 	sector_t sector = offset >> 9;
-	int rc = 0;
+	int rc = 0, ret = 0;
 
 	if (unlikely(!size))
 		return 0;
@@ -301,7 +301,9 @@ static int nsio_rw_bytes(struct nd_namespace_common *ndns,
 	}
 
 	memcpy_flushcache(nsio->addr + offset, buf, size);
-	nvdimm_flush(to_nd_region(ndns->dev.parent));
+	ret = nvdimm_flush(to_nd_region(ndns->dev.parent), NULL);
+	if (ret)
+		rc = ret;
 
 	return rc;
 }
diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
index a5ac3b240293..0c74d2428bd7 100644
--- a/drivers/nvdimm/nd.h
+++ b/drivers/nvdimm/nd.h
@@ -159,6 +159,7 @@ struct nd_region {
 	struct badblocks bb;
 	struct nd_interleave_set *nd_set;
 	struct nd_percpu_lane __percpu *lane;
+	int (*flush)(struct nd_region *nd_region, struct bio *bio);
 	struct nd_mapping mapping[0];
 };
 
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 0279eb1da3ef..c757a47183b8 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -192,6 +192,7 @@ static blk_status_t pmem_do_bvec(struct pmem_device *pmem, struct page *page,
 
 static blk_qc_t pmem_make_request(struct request_queue *q, struct bio *bio)
 {
+	int ret = 0;
 	blk_status_t rc = 0;
 	bool do_acct;
 	unsigned long start;
@@ -201,7 +202,7 @@ static blk_qc_t pmem_make_request(struct request_queue *q, struct bio *bio)
 	struct nd_region *nd_region = to_region(pmem);
 
 	if (bio->bi_opf & REQ_PREFLUSH)
-		nvdimm_flush(nd_region);
+		ret = nvdimm_flush(nd_region, bio);
 
 	do_acct = nd_iostat_start(bio, &start);
 	bio_for_each_segment(bvec, bio, iter) {
@@ -216,7 +217,10 @@ static blk_qc_t pmem_make_request(struct request_queue *q, struct bio *bio)
 		nd_iostat_end(bio, start);
 
 	if (bio->bi_opf & REQ_FUA)
-		nvdimm_flush(nd_region);
+		ret = nvdimm_flush(nd_region, bio);
+
+	if (ret)
+		bio->bi_status = errno_to_blk_status(ret);
 
 	bio_endio(bio);
 	return BLK_QC_T_NONE;
@@ -469,7 +473,6 @@ static int pmem_attach_disk(struct device *dev,
 	}
 	dax_write_cache(dax_dev, nvdimm_has_cache(nd_region));
 	pmem->dax_dev = dax_dev;
-
 	gendev = disk_to_dev(disk);
 	gendev->groups = pmem_attribute_groups;
 
@@ -527,14 +530,14 @@ static int nd_pmem_remove(struct device *dev)
 		sysfs_put(pmem->bb_state);
 		pmem->bb_state = NULL;
 	}
-	nvdimm_flush(to_nd_region(dev->parent));
+	nvdimm_flush(to_nd_region(dev->parent), NULL);
 
 	return 0;
 }
 
 static void nd_pmem_shutdown(struct device *dev)
 {
-	nvdimm_flush(to_nd_region(dev->parent));
+	nvdimm_flush(to_nd_region(dev->parent), NULL);
 }
 
 static void nd_pmem_notify(struct device *dev, enum nvdimm_event event)
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index b4ef7d9ff22e..e5b59708865e 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -295,7 +295,9 @@ static ssize_t deep_flush_store(struct device *dev, struct device_attribute *att
 		return rc;
 	if (!flush)
 		return -EINVAL;
-	nvdimm_flush(nd_region);
+	rc = nvdimm_flush(nd_region, NULL);
+	if (rc)
+		return rc;
 
 	return len;
 }
@@ -1085,6 +1087,11 @@ static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
 	dev->of_node = ndr_desc->of_node;
 	nd_region->ndr_size = resource_size(ndr_desc->res);
 	nd_region->ndr_start = ndr_desc->res->start;
+	if (ndr_desc->flush)
+		nd_region->flush = ndr_desc->flush;
+	else
+		nd_region->flush = NULL;
+
 	nd_device_register(dev);
 
 	return nd_region;
@@ -1125,11 +1132,24 @@ struct nd_region *nvdimm_volatile_region_create(struct nvdimm_bus *nvdimm_bus,
 }
 EXPORT_SYMBOL_GPL(nvdimm_volatile_region_create);
 
+int nvdimm_flush(struct nd_region *nd_region, struct bio *bio)
+{
+	int rc = 0;
+
+	if (!nd_region->flush)
+		rc = generic_nvdimm_flush(nd_region);
+	else {
+		if (nd_region->flush(nd_region, bio))
+			rc = -EIO;
+	}
+
+	return rc;
+}
 /**
  * nvdimm_flush - flush any posted write queues between the cpu and pmem media
  * @nd_region: blk or interleaved pmem region
  */
-void nvdimm_flush(struct nd_region *nd_region)
+int generic_nvdimm_flush(struct nd_region *nd_region)
 {
 	struct nd_region_data *ndrd = dev_get_drvdata(&nd_region->dev);
 	int i, idx;
@@ -1153,6 +1173,8 @@ void nvdimm_flush(struct nd_region *nd_region)
 		if (ndrd_get_flush_wpq(ndrd, i, 0))
 			writeq(1, ndrd_get_flush_wpq(ndrd, i, idx));
 	wmb();
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(nvdimm_flush);
 
diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
index feb342d026f2..5a4f7b13574d 100644
--- a/include/linux/libnvdimm.h
+++ b/include/linux/libnvdimm.h
@@ -19,6 +19,7 @@
 #include <linux/types.h>
 #include <linux/uuid.h>
 #include <linux/spinlock.h>
+#include <linux/bio.h>
 
 struct badrange_entry {
 	u64 start;
@@ -65,6 +66,9 @@ enum {
 	 */
 	ND_REGION_PERSIST_MEMCTRL = 2,
 
+	/* Platform provides asynchronous flush mechanism */
+	ND_REGION_ASYNC = 3,
+
 	/* mark newly adjusted resources as requiring a label update */
 	DPA_RESOURCE_ADJUSTED = 1 << 0,
 };
@@ -121,6 +125,7 @@ struct nd_mapping_desc {
 	int position;
 };
 
+struct nd_region;
 struct nd_region_desc {
 	struct resource *res;
 	struct nd_mapping_desc *mapping;
@@ -133,6 +138,7 @@ struct nd_region_desc {
 	int target_node;
 	unsigned long flags;
 	struct device_node *of_node;
+	int (*flush)(struct nd_region *nd_region, struct bio *bio);
 };
 
 struct device;
@@ -260,7 +266,8 @@ unsigned long nd_blk_memremap_flags(struct nd_blk_region *ndbr);
 unsigned int nd_region_acquire_lane(struct nd_region *nd_region);
 void nd_region_release_lane(struct nd_region *nd_region, unsigned int lane);
 u64 nd_fletcher64(void *addr, size_t len, bool le);
-void nvdimm_flush(struct nd_region *nd_region);
+int nvdimm_flush(struct nd_region *nd_region, struct bio *bio);
+int generic_nvdimm_flush(struct nd_region *nd_region);
 int nvdimm_has_flush(struct nd_region *nd_region);
 int nvdimm_has_cache(struct nd_region *nd_region);
 int nvdimm_in_overwrite(struct nvdimm *nvdimm);
-- 
2.20.1

