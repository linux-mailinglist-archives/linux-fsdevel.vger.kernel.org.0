Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E459E179601
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 17:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbgCDQ7p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 11:59:45 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28622 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729937AbgCDQ7Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:59:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583341162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZRgLnQcH2ZoQLdmHE/9Lqn0DzPj+SdCutG/kHD7VUtE=;
        b=aJh93ssUVRbY/VUiA6NGbrMC8DeExCPdJ+FouDWB8BilpXzWbsoiI6DYWrPB8f4vW/XASW
        52NeJt6K1U35+GzylAP1ToGwFSNnDdL9NaLK1MC58QKWDdRRLX6en9WFyul+sGAD/wRJUw
        QJTHwTZCsVMYbk8OiDpr9cRNcNQ3Z+Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-_BZubGb9M42ulPJLcLB7lw-1; Wed, 04 Mar 2020 11:59:20 -0500
X-MC-Unique: _BZubGb9M42ulPJLcLB7lw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E3DBDB6B;
        Wed,  4 Mar 2020 16:59:19 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D23F59CA3;
        Wed,  4 Mar 2020 16:59:11 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 5CF6522580F; Wed,  4 Mar 2020 11:59:03 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu
Cc:     vgoyal@redhat.com, stefanha@redhat.com, dgilbert@redhat.com,
        mst@redhat.com, Sebastien Boeuf <sebastien.boeuf@intel.com>,
        Liu Bo <bo.liu@linux.alibaba.com>
Subject: [PATCH 09/20] virtio_fs, dax: Set up virtio_fs dax_device
Date:   Wed,  4 Mar 2020 11:58:34 -0500
Message-Id: <20200304165845.3081-10-vgoyal@redhat.com>
In-Reply-To: <20200304165845.3081-1-vgoyal@redhat.com>
References: <20200304165845.3081-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
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
 fs/fuse/virtio_fs.c            | 115 +++++++++++++++++++++++++++++++++
 include/uapi/linux/virtio_fs.h |   3 +
 2 files changed, 118 insertions(+)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 62cdd6817b5b..b0574b208cd5 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -5,6 +5,9 @@
  */
=20
 #include <linux/fs.h>
+#include <linux/dax.h>
+#include <linux/pci.h>
+#include <linux/pfn_t.h>
 #include <linux/module.h>
 #include <linux/virtio.h>
 #include <linux/virtio_fs.h>
@@ -50,6 +53,12 @@ struct virtio_fs {
 	struct virtio_fs_vq *vqs;
 	unsigned int nvqs;               /* number of virtqueues */
 	unsigned int num_request_queues; /* number of request queues */
+	struct dax_device *dax_dev;
+
+	/* DAX memory window where file contents are mapped */
+	void *window_kaddr;
+	phys_addr_t window_phys_addr;
+	size_t window_len;
 };
=20
 struct virtio_fs_forget_req {
@@ -690,6 +699,108 @@ static void virtio_fs_cleanup_vqs(struct virtio_dev=
ice *vdev,
 	vdev->config->del_vqs(vdev);
 }
=20
+/* Map a window offset to a page frame number.  The window offset will h=
ave
+ * been produced by .iomap_begin(), which maps a file offset to a window
+ * offset.
+ */
+static long virtio_fs_direct_access(struct dax_device *dax_dev, pgoff_t =
pgoff,
+				    long nr_pages, void **kaddr, pfn_t *pfn)
+{
+	struct virtio_fs *fs =3D dax_get_private(dax_dev);
+	phys_addr_t offset =3D PFN_PHYS(pgoff);
+	size_t max_nr_pages =3D fs->window_len/PAGE_SIZE - pgoff;
+
+	if (kaddr)
+		*kaddr =3D fs->window_kaddr + offset;
+	if (pfn)
+		*pfn =3D phys_to_pfn_t(fs->window_phys_addr + offset,
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
+static const struct dax_operations virtio_fs_dax_ops =3D {
+	.direct_access =3D virtio_fs_direct_access,
+	.copy_from_iter =3D virtio_fs_copy_from_iter,
+	.copy_to_iter =3D virtio_fs_copy_to_iter,
+};
+
+static void virtio_fs_cleanup_dax(void *data)
+{
+	struct virtio_fs *fs =3D data;
+
+	kill_dax(fs->dax_dev);
+	put_dax(fs->dax_dev);
+}
+
+static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio=
_fs *fs)
+{
+	struct virtio_shm_region cache_reg;
+	struct dev_pagemap *pgmap;
+	bool have_cache;
+
+	if (!IS_ENABLED(CONFIG_DAX_DRIVER))
+		return 0;
+
+	/* Get cache region */
+	have_cache =3D virtio_get_shm_region(vdev, &cache_reg,
+					   (u8)VIRTIO_FS_SHMCAP_ID_CACHE);
+	if (!have_cache) {
+		dev_notice(&vdev->dev, "%s: No cache capability\n", __func__);
+		return 0;
+	} else {
+		dev_notice(&vdev->dev, "Cache len: 0x%llx @ 0x%llx\n",
+			   cache_reg.len, cache_reg.addr);
+	}
+
+	pgmap =3D devm_kzalloc(&vdev->dev, sizeof(*pgmap), GFP_KERNEL);
+	if (!pgmap)
+		return -ENOMEM;
+
+	pgmap->type =3D MEMORY_DEVICE_FS_DAX;
+
+	/* Ideally we would directly use the PCI BAR resource but
+	 * devm_memremap_pages() wants its own copy in pgmap.  So
+	 * initialize a struct resource from scratch (only the start
+	 * and end fields will be used).
+	 */
+	pgmap->res =3D (struct resource){
+		.name =3D "virtio-fs dax window",
+		.start =3D (phys_addr_t) cache_reg.addr,
+		.end =3D (phys_addr_t) cache_reg.addr + cache_reg.len - 1,
+	};
+
+	fs->window_kaddr =3D devm_memremap_pages(&vdev->dev, pgmap);
+	if (IS_ERR(fs->window_kaddr))
+		return PTR_ERR(fs->window_kaddr);
+
+	fs->window_phys_addr =3D (phys_addr_t) cache_reg.addr;
+	fs->window_len =3D (phys_addr_t) cache_reg.len;
+
+	dev_dbg(&vdev->dev, "%s: window kaddr 0x%px phys_addr 0x%llx"
+		" len 0x%llx\n", __func__, fs->window_kaddr, cache_reg.addr,
+		cache_reg.len);
+
+	fs->dax_dev =3D alloc_dax(fs, NULL, &virtio_fs_dax_ops, 0);
+	if (!fs->dax_dev)
+		return -ENOMEM;
+
+	return devm_add_action_or_reset(&vdev->dev, virtio_fs_cleanup_dax, fs);
+}
+
 static int virtio_fs_probe(struct virtio_device *vdev)
 {
 	struct virtio_fs *fs;
@@ -711,6 +822,10 @@ static int virtio_fs_probe(struct virtio_device *vde=
v)
=20
 	/* TODO vq affinity */
=20
+	ret =3D virtio_fs_setup_dax(vdev, fs);
+	if (ret < 0)
+		goto out_vqs;
+
 	/* Bring the device online in case the filesystem is mounted and
 	 * requests need to be sent before we return.
 	 */
diff --git a/include/uapi/linux/virtio_fs.h b/include/uapi/linux/virtio_f=
s.h
index b02eb2ac3d99..2f64abce781f 100644
--- a/include/uapi/linux/virtio_fs.h
+++ b/include/uapi/linux/virtio_fs.h
@@ -16,4 +16,7 @@ struct virtio_fs_config {
 	__u32 num_request_queues;
 } __attribute__((packed));
=20
+/* For the id field in virtio_pci_shm_cap */
+#define VIRTIO_FS_SHMCAP_ID_CACHE 0
+
 #endif /* _UAPI_LINUX_VIRTIO_FS_H */
--=20
2.20.1

