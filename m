Return-Path: <linux-fsdevel+bounces-44554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6821AA6A497
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 12:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EE5E8A3C24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 11:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F152721E094;
	Thu, 20 Mar 2025 11:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4Es30ejs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C447B21CA10;
	Thu, 20 Mar 2025 11:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742469224; cv=none; b=mGGGSh4xRQ+OGexsPROKDUqg+KJsNncUjy0mNOE7D5XLqCeG5WpSjHm99LAQeLlqL/rAYxe0KaFxD1Js+utOYIobSbFy920F8BhcoU28F7kzgfIZ1Gjp7xcumVIbCVvHbmJ3GQXM32Wmj8R2hEpaVKiaNMs2ZY6ST5KFP2y1AFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742469224; c=relaxed/simple;
	bh=63kralWYiFQ2jXtxV7kyaMiVqxquE+PU6XAsBS4blns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G8HTjXZPJFHWqorBPgj7NydaU+Shc9BR9XZhYyluISZNFdi/61yXWaXg0HOhdQdjIH0hF88FA+Cq7E+AVcRgEamY7F2ngjAAlpo3c49l8H1eHtOUTmfxwX/FaJV7JdGVbSLZjpZfZFRi/QgNQZkdsZh78rSUpZIHmy3qyYdD+tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4Es30ejs; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Jf1rG7AmJkP1u7S6fw0dmgKBHdEibmpz/cPja1fejVI=; b=4Es30ejsM1CkQnH1Jn7AIoeHqa
	CDzhhGO8nAeEq+AnFC4X0Zvc1qX8jnP1BRiLAGI2vqCMvDL+rwcs1bpoPvR0S6bbJKHcPEUt7BPOQ
	4dJG4tZvciMICp/N3Fi2RnoQys+y8Do76hvPJRXVX3cZBARBQ73SxwCc8C7KO7PXWTD9yzCs8rRSZ
	KOBQ23r+c15c3XhGAbKO1n/C/8CcnF7UlG+ngv/M4L47QA0hmitDUc/RxF7i9GmphyuCaYt3rLXeR
	EQ2PFBCtH3/M/+GM6R3pz/r6/sGgHQJDoiPqOILmugJ+3MtN+M5Z+VaLxSPtlnEOsE+R7Hqbj/of9
	9FAiHM1w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tvDqB-0000000BvGN-13gs;
	Thu, 20 Mar 2025 11:13:35 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: leon@kernel.org,
	hch@lst.de,
	kbusch@kernel.org,
	sagi@grimberg.me,
	axboe@kernel.dk,
	joro@8bytes.org,
	brauner@kernel.org,
	hare@suse.de,
	willy@infradead.org,
	david@fromorbit.com,
	djwong@kernel.org
Cc: john.g.garry@oracle.com,
	ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	kernel@pankajraghav.com,
	mcgrof@kernel.org
Subject: [RFC 3/4] nvme-pci: bump segments to what the device can use
Date: Thu, 20 Mar 2025 04:13:27 -0700
Message-ID: <20250320111328.2841690-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250320111328.2841690-1-mcgrof@kernel.org>
References: <20250320111328.2841690-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

Now that we're not scatter list bound, just use the device limits.
The blk integrity stuff needs to be converted to the new dma API
first, so to enable large IO experimentation just remove it for now.

The iod pools are not used anymore so just nuke them.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/nvme/host/pci.c | 164 +---------------------------------------
 1 file changed, 3 insertions(+), 161 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 1ca9ab2b8ec5..27b830072c14 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -40,8 +40,6 @@
  * require an sg allocation that needs more than a page of data.
  */
 #define NVME_MAX_KB_SZ	8192
-#define NVME_MAX_SEGS	128
-#define NVME_MAX_META_SEGS 15
 #define NVME_MAX_NR_DESCRIPTORS	5
 #define NVME_SMALL_DESCRIPTOR_SIZE	256
 
@@ -143,9 +141,6 @@ struct nvme_dev {
 	bool hmb;
 	struct sg_table *hmb_sgt;
 
-	mempool_t *iod_mempool;
-	mempool_t *iod_meta_mempool;
-
 	/* shadow doorbell buffer support: */
 	__le32 *dbbuf_dbs;
 	dma_addr_t dbbuf_dbs_dma_addr;
@@ -788,14 +783,6 @@ static void nvme_pci_sgl_set_data(struct nvme_sgl_desc *sge,
 	sge->type = NVME_SGL_FMT_DATA_DESC << 4;
 }
 
-static void nvme_pci_sgl_set_data_legacy(struct nvme_sgl_desc *sge,
-		struct scatterlist *sg)
-{
-	sge->addr = cpu_to_le64(sg_dma_address(sg));
-	sge->length = cpu_to_le32(sg_dma_len(sg));
-	sge->type = NVME_SGL_FMT_DATA_DESC << 4;
-}
-
 static void nvme_pci_sgl_set_seg(struct nvme_sgl_desc *sge,
 		dma_addr_t dma_addr, int entries)
 {
@@ -859,84 +846,6 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 	return nvme_pci_setup_prps(dev, req, &cmnd->rw);
 }
 
-static blk_status_t nvme_pci_setup_meta_sgls(struct nvme_dev *dev,
-					     struct request *req)
-{
-	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	struct nvme_rw_command *cmnd = &iod->cmd.rw;
-	struct nvme_sgl_desc *sg_list;
-	struct scatterlist *sgl, *sg;
-	unsigned int entries;
-	dma_addr_t sgl_dma;
-	int rc, i;
-
-	iod->meta_sgt.sgl = mempool_alloc(dev->iod_meta_mempool, GFP_ATOMIC);
-	if (!iod->meta_sgt.sgl)
-		return BLK_STS_RESOURCE;
-
-	sg_init_table(iod->meta_sgt.sgl, req->nr_integrity_segments);
-	iod->meta_sgt.orig_nents = blk_rq_map_integrity_sg(req,
-							   iod->meta_sgt.sgl);
-	if (!iod->meta_sgt.orig_nents)
-		goto out_free_sg;
-
-	rc = dma_map_sgtable(dev->dev, &iod->meta_sgt, rq_dma_dir(req),
-			     DMA_ATTR_NO_WARN);
-	if (rc)
-		goto out_free_sg;
-
-	sg_list = dma_pool_alloc(dev->prp_small_pool, GFP_ATOMIC, &sgl_dma);
-	if (!sg_list)
-		goto out_unmap_sg;
-
-	entries = iod->meta_sgt.nents;
-	iod->meta_descriptors[0] = sg_list;
-	iod->meta_dma = sgl_dma;
-
-	cmnd->flags = NVME_CMD_SGL_METASEG;
-	cmnd->metadata = cpu_to_le64(sgl_dma);
-
-	sgl = iod->meta_sgt.sgl;
-	if (entries == 1) {
-		nvme_pci_sgl_set_data_legacy(sg_list, sgl);
-		return BLK_STS_OK;
-	}
-
-	sgl_dma += sizeof(*sg_list);
-	nvme_pci_sgl_set_seg(sg_list, sgl_dma, entries);
-	for_each_sg(sgl, sg, entries, i)
-		nvme_pci_sgl_set_data_legacy(&sg_list[i + 1], sg);
-
-	return BLK_STS_OK;
-
-out_unmap_sg:
-	dma_unmap_sgtable(dev->dev, &iod->meta_sgt, rq_dma_dir(req), 0);
-out_free_sg:
-	mempool_free(iod->meta_sgt.sgl, dev->iod_meta_mempool);
-	return BLK_STS_RESOURCE;
-}
-
-static blk_status_t nvme_pci_setup_meta_mptr(struct nvme_dev *dev,
-					     struct request *req)
-{
-	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	struct bio_vec bv = rq_integrity_vec(req);
-	struct nvme_command *cmnd = &iod->cmd;
-
-	iod->meta_dma = dma_map_bvec(dev->dev, &bv, rq_dma_dir(req), 0);
-	if (dma_mapping_error(dev->dev, iod->meta_dma))
-		return BLK_STS_IOERR;
-	cmnd->rw.metadata = cpu_to_le64(iod->meta_dma);
-	return BLK_STS_OK;
-}
-
-static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct request *req)
-{
-	if (nvme_pci_metadata_use_sgls(dev, req))
-		return nvme_pci_setup_meta_sgls(dev, req);
-	return nvme_pci_setup_meta_mptr(dev, req);
-}
-
 static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
@@ -958,17 +867,8 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
 			goto out_free_cmd;
 	}
 
-	if (blk_integrity_rq(req)) {
-		ret = nvme_map_metadata(dev, req);
-		if (ret)
-			goto out_unmap_data;
-	}
-
 	nvme_start_request(req);
 	return BLK_STS_OK;
-out_unmap_data:
-	if (blk_rq_nr_phys_segments(req))
-		nvme_unmap_data(dev, req);
 out_free_cmd:
 	nvme_cleanup_cmd(req);
 	return ret;
@@ -1057,32 +957,11 @@ static void nvme_queue_rqs(struct rq_list *rqlist)
 	*rqlist = requeue_list;
 }
 
-static __always_inline void nvme_unmap_metadata(struct nvme_dev *dev,
-						struct request *req)
-{
-	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-
-	if (!iod->meta_sgt.nents) {
-		dma_unmap_page(dev->dev, iod->meta_dma,
-			       rq_integrity_vec(req).bv_len,
-			       rq_dma_dir(req));
-		return;
-	}
-
-	dma_pool_free(dev->prp_small_pool, iod->meta_descriptors[0],
-		      iod->meta_dma);
-	dma_unmap_sgtable(dev->dev, &iod->meta_sgt, rq_dma_dir(req), 0);
-	mempool_free(iod->meta_sgt.sgl, dev->iod_meta_mempool);
-}
-
 static __always_inline void nvme_pci_unmap_rq(struct request *req)
 {
 	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
 	struct nvme_dev *dev = nvmeq->dev;
 
-	if (blk_integrity_rq(req))
-		nvme_unmap_metadata(dev, req);
-
 	if (blk_rq_nr_phys_segments(req))
 		nvme_unmap_data(dev, req);
 }
@@ -2874,31 +2753,6 @@ static void nvme_release_prp_pools(struct nvme_dev *dev)
 	dma_pool_destroy(dev->prp_small_pool);
 }
 
-static int nvme_pci_alloc_iod_mempool(struct nvme_dev *dev)
-{
-	size_t meta_size = sizeof(struct scatterlist) * (NVME_MAX_META_SEGS + 1);
-	size_t alloc_size = sizeof(struct scatterlist) * NVME_MAX_SEGS;
-
-	dev->iod_mempool = mempool_create_node(1,
-			mempool_kmalloc, mempool_kfree,
-			(void *)alloc_size, GFP_KERNEL,
-			dev_to_node(dev->dev));
-	if (!dev->iod_mempool)
-		return -ENOMEM;
-
-	dev->iod_meta_mempool = mempool_create_node(1,
-			mempool_kmalloc, mempool_kfree,
-			(void *)meta_size, GFP_KERNEL,
-			dev_to_node(dev->dev));
-	if (!dev->iod_meta_mempool)
-		goto free;
-
-	return 0;
-free:
-	mempool_destroy(dev->iod_mempool);
-	return -ENOMEM;
-}
-
 static void nvme_free_tagset(struct nvme_dev *dev)
 {
 	if (dev->tagset.tags)
@@ -2962,7 +2816,7 @@ static void nvme_reset_work(struct work_struct *work)
 		goto out;
 
 	if (nvme_ctrl_meta_sgl_supported(&dev->ctrl))
-		dev->ctrl.max_integrity_segments = NVME_MAX_META_SEGS;
+		dev->ctrl.max_integrity_segments = 0;
 	else
 		dev->ctrl.max_integrity_segments = 1;
 
@@ -3234,7 +3088,6 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 	 */
 	dev->ctrl.max_hw_sectors = min_t(u32,
 		NVME_MAX_KB_SZ << 1, dma_opt_mapping_size(&pdev->dev) >> 9);
-	dev->ctrl.max_segments = NVME_MAX_SEGS;
 	dev->ctrl.max_integrity_segments = 1;
 	return dev;
 
@@ -3267,15 +3120,11 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (result)
 		goto out_dev_unmap;
 
-	result = nvme_pci_alloc_iod_mempool(dev);
-	if (result)
-		goto out_release_prp_pools;
-
 	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
 
 	result = nvme_pci_enable(dev);
 	if (result)
-		goto out_release_iod_mempool;
+		goto out_release_prp_pools;
 
 	result = nvme_alloc_admin_tag_set(&dev->ctrl, &dev->admin_tagset,
 				&nvme_mq_admin_ops, sizeof(struct nvme_iod));
@@ -3298,7 +3147,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto out_disable;
 
 	if (nvme_ctrl_meta_sgl_supported(&dev->ctrl))
-		dev->ctrl.max_integrity_segments = NVME_MAX_META_SEGS;
+		dev->ctrl.max_integrity_segments = 0;
 	else
 		dev->ctrl.max_integrity_segments = 1;
 
@@ -3342,9 +3191,6 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	nvme_dev_remove_admin(dev);
 	nvme_dbbuf_dma_free(dev);
 	nvme_free_queues(dev, 0);
-out_release_iod_mempool:
-	mempool_destroy(dev->iod_mempool);
-	mempool_destroy(dev->iod_meta_mempool);
 out_release_prp_pools:
 	nvme_release_prp_pools(dev);
 out_dev_unmap:
@@ -3409,8 +3255,6 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_dev_remove_admin(dev);
 	nvme_dbbuf_dma_free(dev);
 	nvme_free_queues(dev, 0);
-	mempool_destroy(dev->iod_mempool);
-	mempool_destroy(dev->iod_meta_mempool);
 	nvme_release_prp_pools(dev);
 	nvme_dev_unmap(dev);
 	nvme_uninit_ctrl(&dev->ctrl);
@@ -3804,8 +3648,6 @@ static int __init nvme_init(void)
 	BUILD_BUG_ON(sizeof(struct nvme_create_sq) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_delete_queue) != 64);
 	BUILD_BUG_ON(IRQ_AFFINITY_MAX_SETS < 2);
-	BUILD_BUG_ON(NVME_MAX_SEGS > SGES_PER_PAGE);
-	BUILD_BUG_ON(sizeof(struct scatterlist) * NVME_MAX_SEGS > PAGE_SIZE);
 	BUILD_BUG_ON(nvme_pci_npages_prp() > NVME_MAX_NR_DESCRIPTORS);
 
 	return pci_register_driver(&nvme_driver);
-- 
2.47.2


