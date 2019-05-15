Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A442A1FAAF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 21:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfEOT3C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 May 2019 15:29:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49862 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727576AbfEOT1e (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 May 2019 15:27:34 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CB1953001561;
        Wed, 15 May 2019 19:27:33 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 92F671972A;
        Wed, 15 May 2019 19:27:33 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id D722C225486; Wed, 15 May 2019 15:27:29 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-nvdimm@lists.01.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, swhiteho@redhat.com
Subject: [PATCH v2 18/30] virtio_fs, dax: Set up virtio_fs dax_device
Date:   Wed, 15 May 2019 15:27:03 -0400
Message-Id: <20190515192715.18000-19-vgoyal@redhat.com>
In-Reply-To: <20190515192715.18000-1-vgoyal@redhat.com>
References: <20190515192715.18000-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 15 May 2019 19:27:33 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Stefan Hajnoczi <stefanha@redhat.com>

Setup a dax device.

Use the shm capability to find the cache entry and map it.

The DAX window is accessed by the fs/dax.c infrastructure and must have
struct pages (at least on x86).  Use devm_memremap_pages() to map the
DAX window PCI BAR and allocate struct page.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
---
 fs/fuse/fuse_i.h               |   1 +
 fs/fuse/inode.c                |   8 ++
 fs/fuse/virtio_fs.c            | 173 ++++++++++++++++++++++++++++++++-
 include/uapi/linux/virtio_fs.h |   3 +
 4 files changed, 183 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 46fc1a454084..840c88af711c 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -70,6 +70,7 @@ struct fuse_mount_data {
 	unsigned group_id_present:1;
 	unsigned default_permissions:1;
 	unsigned allow_other:1;
+	unsigned dax:1;
 	unsigned destroy:1;
 	unsigned max_read;
 	unsigned blksize;
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 42f3ac5b7521..97d218a7daa8 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -442,6 +442,7 @@ enum {
 	OPT_ALLOW_OTHER,
 	OPT_MAX_READ,
 	OPT_BLKSIZE,
+	OPT_DAX,
 	OPT_ERR
 };
 
@@ -455,6 +456,7 @@ static const match_table_t tokens = {
 	{OPT_ALLOW_OTHER,		"allow_other"},
 	{OPT_MAX_READ,			"max_read=%u"},
 	{OPT_BLKSIZE,			"blksize=%u"},
+	{OPT_DAX,			"dax"},
 	{OPT_ERR,			NULL}
 };
 
@@ -546,6 +548,10 @@ int parse_fuse_opt(char *opt, struct fuse_mount_data *d, int is_bdev,
 			d->blksize = value;
 			break;
 
+		case OPT_DAX:
+			d->dax = 1;
+			break;
+
 		default:
 			return 0;
 		}
@@ -574,6 +580,8 @@ static int fuse_show_options(struct seq_file *m, struct dentry *root)
 		seq_printf(m, ",max_read=%u", fc->max_read);
 	if (sb->s_bdev && sb->s_blocksize != FUSE_DEFAULT_BLKSIZE)
 		seq_printf(m, ",blksize=%lu", sb->s_blocksize);
+	if (fc->dax_dev)
+		seq_printf(m, ",dax");
 	return 0;
 }
 
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index a23a1fb67217..2b790865dc21 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -5,6 +5,9 @@
  */
 
 #include <linux/fs.h>
+#include <linux/dax.h>
+#include <linux/pci.h>
+#include <linux/pfn_t.h>
 #include <linux/module.h>
 #include <linux/virtio.h>
 #include <linux/virtio_fs.h>
@@ -31,6 +34,18 @@ struct virtio_fs_vq {
 	char name[24];
 } ____cacheline_aligned_in_smp;
 
+/* State needed for devm_memremap_pages().  This API is called on the
+ * underlying pci_dev instead of struct virtio_fs (layering violation).  Since
+ * the memremap release function only gets called when the pci_dev is released,
+ * keep the associated state separate from struct virtio_fs (it has a different
+ * lifecycle from pci_dev).
+ */
+struct virtio_fs_memremap_info {
+	struct dev_pagemap pgmap;
+	struct percpu_ref ref;
+	struct completion completion;
+};
+
 /* A virtio-fs device instance */
 struct virtio_fs {
 	struct list_head list;    /* on virtio_fs_instances */
@@ -38,6 +53,12 @@ struct virtio_fs {
 	struct virtio_fs_vq *vqs;
 	unsigned nvqs;            /* number of virtqueues */
 	unsigned num_queues;      /* number of request queues */
+	struct dax_device *dax_dev;
+
+	/* DAX memory window where file contents are mapped */
+	void *window_kaddr;
+	phys_addr_t window_phys_addr;
+	size_t window_len;
 };
 
 struct virtio_fs_forget {
@@ -421,6 +442,151 @@ static void virtio_fs_cleanup_vqs(struct virtio_device *vdev,
 	vdev->config->del_vqs(vdev);
 }
 
+/* Map a window offset to a page frame number.  The window offset will have
+ * been produced by .iomap_begin(), which maps a file offset to a window
+ * offset.
+ */
+static long virtio_fs_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
+				    long nr_pages, void **kaddr, pfn_t *pfn)
+{
+	struct virtio_fs *fs = dax_get_private(dax_dev);
+	phys_addr_t offset = PFN_PHYS(pgoff);
+	size_t max_nr_pages = fs->window_len/PAGE_SIZE - pgoff;
+
+	if (kaddr)
+		*kaddr = fs->window_kaddr + offset;
+	if (pfn)
+		*pfn = phys_to_pfn_t(fs->window_phys_addr + offset,
+					PFN_DEV | PFN_MAP);
+	return nr_pages > max_nr_pages ? max_nr_pages : nr_pages;
+}
+
+static size_t virtio_fs_copy_from_iter(struct dax_device *dax_dev,
+				       pgoff_t pgoff, void *addr,
+				       size_t bytes, struct iov_iter *i)
+{
+	return copy_from_iter(addr, bytes, i);
+}
+
+static size_t virtio_fs_copy_to_iter(struct dax_device *dax_dev,
+				       pgoff_t pgoff, void *addr,
+				       size_t bytes, struct iov_iter *i)
+{
+	return copy_to_iter(addr, bytes, i);
+}
+
+static const struct dax_operations virtio_fs_dax_ops = {
+	.direct_access = virtio_fs_direct_access,
+	.copy_from_iter = virtio_fs_copy_from_iter,
+	.copy_to_iter = virtio_fs_copy_to_iter,
+};
+
+static void virtio_fs_percpu_release(struct percpu_ref *ref)
+{
+	struct virtio_fs_memremap_info *mi =
+		container_of(ref, struct virtio_fs_memremap_info, ref);
+
+	complete(&mi->completion);
+}
+
+static void virtio_fs_percpu_exit(void *data)
+{
+	struct virtio_fs_memremap_info *mi = data;
+
+	wait_for_completion(&mi->completion);
+	percpu_ref_exit(&mi->ref);
+}
+
+static void virtio_fs_percpu_kill(struct percpu_ref *ref)
+{
+	percpu_ref_kill(ref);
+}
+
+static void virtio_fs_cleanup_dax(void *data)
+{
+	struct virtio_fs *fs = data;
+
+	kill_dax(fs->dax_dev);
+	put_dax(fs->dax_dev);
+}
+
+static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
+{
+	struct virtio_shm_region cache_reg;
+	struct virtio_fs_memremap_info *mi;
+	struct dev_pagemap *pgmap;
+	bool have_cache;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_DAX_DRIVER))
+		return 0;
+
+	/* Get cache region */
+	have_cache = virtio_get_shm_region(vdev,
+					   &cache_reg,
+					   (u8)VIRTIO_FS_SHMCAP_ID_CACHE);
+	if (!have_cache) {
+		dev_err(&vdev->dev, "%s: No cache capability\n", __func__);
+		return -ENXIO;
+	} else {
+		dev_notice(&vdev->dev, "Cache len: 0x%llx @ 0x%llx\n",
+			   cache_reg.len, cache_reg.addr);
+	}
+
+	mi = devm_kzalloc(&vdev->dev, sizeof(*mi), GFP_KERNEL);
+	if (!mi)
+		return -ENOMEM;
+
+	init_completion(&mi->completion);
+	ret = percpu_ref_init(&mi->ref, virtio_fs_percpu_release, 0,
+			      GFP_KERNEL);
+	if (ret < 0) {
+		dev_err(&vdev->dev, "%s: percpu_ref_init failed (%d)\n",
+			__func__, ret);
+		return ret;
+	}
+
+	ret = devm_add_action(&vdev->dev, virtio_fs_percpu_exit, mi);
+	if (ret < 0) {
+		percpu_ref_exit(&mi->ref);
+		return ret;
+	}
+
+	pgmap = &mi->pgmap;
+	pgmap->altmap_valid = false;
+	pgmap->ref = &mi->ref;
+	pgmap->kill = virtio_fs_percpu_kill;
+	pgmap->type = MEMORY_DEVICE_FS_DAX;
+
+	/* Ideally we would directly use the PCI BAR resource but
+	 * devm_memremap_pages() wants its own copy in pgmap.  So
+	 * initialize a struct resource from scratch (only the start
+	 * and end fields will be used).
+	 */
+	pgmap->res = (struct resource){
+		.name = "virtio-fs dax window",
+		.start = (phys_addr_t) cache_reg.addr,
+		.end = (phys_addr_t) cache_reg.addr + cache_reg.len - 1,
+	};
+
+	fs->window_kaddr = devm_memremap_pages(&vdev->dev, pgmap);
+	if (IS_ERR(fs->window_kaddr))
+		return PTR_ERR(fs->window_kaddr);
+
+	fs->window_phys_addr = (phys_addr_t) cache_reg.addr;
+	fs->window_len = (phys_addr_t) cache_reg.len;
+
+	dev_dbg(&vdev->dev, "%s: window kaddr 0x%px phys_addr 0x%llx"
+		" len 0x%llx\n", __func__, fs->window_kaddr, cache_reg.addr,
+		cache_reg.len);
+
+	fs->dax_dev = alloc_dax(fs, NULL, &virtio_fs_dax_ops);
+	if (!fs->dax_dev)
+		return -ENOMEM;
+
+	return devm_add_action_or_reset(&vdev->dev, virtio_fs_cleanup_dax, fs);
+}
+
 static int virtio_fs_probe(struct virtio_device *vdev)
 {
 	struct virtio_fs *fs;
@@ -442,6 +608,10 @@ static int virtio_fs_probe(struct virtio_device *vdev)
 	/* TODO vq affinity */
 	/* TODO populate notifications vq */
 
+	ret = virtio_fs_setup_dax(vdev, fs);
+	if (ret < 0)
+		goto out_vqs;
+
 	/* Bring the device online in case the filesystem is mounted and
 	 * requests need to be sent before we return.
 	 */
@@ -456,7 +626,6 @@ static int virtio_fs_probe(struct virtio_device *vdev)
 out_vqs:
 	vdev->config->reset(vdev);
 	virtio_fs_cleanup_vqs(vdev, fs);
-
 out:
 	vdev->priv = NULL;
 	return ret;
@@ -866,7 +1035,7 @@ static int virtio_fs_fill_super(struct super_block *sb, void *data,
  		goto err_free_fuse_devs;
 	__set_bit(FR_BACKGROUND, &init_req->flags);
 
-	d.dax_dev = NULL;
+	d.dax_dev = d.dax ? fs->dax_dev : NULL;
 	d.fiq_ops = &virtio_fs_fiq_ops;
 	d.fiq_priv = fs;
 	d.fudptr = (void **)&fs->vqs[VQ_REQUEST].fud;
diff --git a/include/uapi/linux/virtio_fs.h b/include/uapi/linux/virtio_fs.h
index 48f3590dcfbe..d4bb549568eb 100644
--- a/include/uapi/linux/virtio_fs.h
+++ b/include/uapi/linux/virtio_fs.h
@@ -38,4 +38,7 @@ struct virtio_fs_config {
 	__u32 num_queues;
 } __attribute__((packed));
 
+/* For the id field in virtio_pci_shm_cap */
+#define VIRTIO_FS_SHMCAP_ID_CACHE 0
+
 #endif /* _UAPI_LINUX_VIRTIO_FS_H */
-- 
2.20.1

