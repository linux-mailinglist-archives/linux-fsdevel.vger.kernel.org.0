Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4734A981F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 19:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730374AbfHUR5t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 13:57:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34270 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730356AbfHUR5r (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 13:57:47 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F156918C426E;
        Wed, 21 Aug 2019 17:57:46 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 00FC860E1C;
        Wed, 21 Aug 2019 17:57:33 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 8CD1A223D00; Wed, 21 Aug 2019 13:57:32 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc:     virtio-fs@redhat.com, vgoyal@redhat.com, miklos@szeredi.hu,
        stefanha@redhat.com, dgilbert@redhat.com,
        Sebastien Boeuf <sebastien.boeuf@intel.com>,
        kvm@vger.kernel.org, kbuild test robot <lkp@intel.com>
Subject: [PATCH 04/19] virtio: Implement get_shm_region for PCI transport
Date:   Wed, 21 Aug 2019 13:57:05 -0400
Message-Id: <20190821175720.25901-5-vgoyal@redhat.com>
In-Reply-To: <20190821175720.25901-1-vgoyal@redhat.com>
References: <20190821175720.25901-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Wed, 21 Aug 2019 17:57:47 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Sebastien Boeuf <sebastien.boeuf@intel.com>

On PCI the shm regions are found using capability entries;
find a region by searching for the capability.

Cc: kvm@vger.kernel.org
Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 drivers/virtio/virtio_pci_modern.c | 108 +++++++++++++++++++++++++++++
 include/uapi/linux/virtio_pci.h    |  11 ++-
 2 files changed, 118 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 7abcc50838b8..1cdedd93f42a 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -443,6 +443,112 @@ static void del_vq(struct virtio_pci_vq_info *info)
 	vring_del_virtqueue(vq);
 }
 
+static int virtio_pci_find_shm_cap(struct pci_dev *dev,
+                                   u8 required_id,
+                                   u8 *bar, u64 *offset, u64 *len)
+{
+	int pos;
+
+        for (pos = pci_find_capability(dev, PCI_CAP_ID_VNDR);
+             pos > 0;
+             pos = pci_find_next_capability(dev, pos, PCI_CAP_ID_VNDR)) {
+		u8 type, cap_len, id;
+                u32 tmp32;
+                u64 res_offset, res_length;
+
+		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
+                                                         cfg_type),
+                                     &type);
+                if (type != VIRTIO_PCI_CAP_SHARED_MEMORY_CFG)
+                        continue;
+
+		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
+                                                         cap_len),
+                                     &cap_len);
+		if (cap_len != sizeof(struct virtio_pci_cap64)) {
+		        printk(KERN_ERR "%s: shm cap with bad size offset: %d size: %d\n",
+                               __func__, pos, cap_len);
+                        continue;
+                }
+
+		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
+                                                         id),
+                                     &id);
+                if (id != required_id)
+                        continue;
+
+                /* Type, and ID match, looks good */
+                pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
+                                                         bar),
+                                     bar);
+
+                /* Read the lower 32bit of length and offset */
+                pci_read_config_dword(dev, pos + offsetof(struct virtio_pci_cap, offset),
+                                      &tmp32);
+                res_offset = tmp32;
+                pci_read_config_dword(dev, pos + offsetof(struct virtio_pci_cap, length),
+                                      &tmp32);
+                res_length = tmp32;
+
+                /* and now the top half */
+                pci_read_config_dword(dev,
+                                      pos + offsetof(struct virtio_pci_cap64,
+                                                     offset_hi),
+                                      &tmp32);
+                res_offset |= ((u64)tmp32) << 32;
+                pci_read_config_dword(dev,
+                                      pos + offsetof(struct virtio_pci_cap64,
+                                                     length_hi),
+                                      &tmp32);
+                res_length |= ((u64)tmp32) << 32;
+
+                *offset = res_offset;
+                *len = res_length;
+
+                return pos;
+        }
+        return 0;
+}
+
+static bool vp_get_shm_region(struct virtio_device *vdev,
+			      struct virtio_shm_region *region, u8 id)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	struct pci_dev *pci_dev = vp_dev->pci_dev;
+	u8 bar;
+	u64 offset, len;
+	phys_addr_t phys_addr;
+	size_t bar_len;
+	char *bar_name;
+	int ret;
+
+	if (!virtio_pci_find_shm_cap(pci_dev, id, &bar, &offset, &len)) {
+		return false;
+	}
+
+	ret = pci_request_region(pci_dev, bar, "virtio-pci-shm");
+	if (ret < 0) {
+		dev_err(&pci_dev->dev, "%s: failed to request BAR\n",
+			__func__);
+		return false;
+	}
+
+	phys_addr = pci_resource_start(pci_dev, bar);
+	bar_len = pci_resource_len(pci_dev, bar);
+
+        if (offset + len > bar_len) {
+                dev_err(&pci_dev->dev,
+                        "%s: bar shorter than cap offset+len\n",
+                        __func__);
+                return false;
+        }
+
+	region->len = len;
+	region->addr = (u64) phys_addr + offset;
+
+	return true;
+}
+
 static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
 	.get		= NULL,
 	.set		= NULL,
@@ -457,6 +563,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
 	.bus_name	= vp_bus_name,
 	.set_vq_affinity = vp_set_vq_affinity,
 	.get_vq_affinity = vp_get_vq_affinity,
+	.get_shm_region  = vp_get_shm_region,
 };
 
 static const struct virtio_config_ops virtio_pci_config_ops = {
@@ -473,6 +580,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
 	.bus_name	= vp_bus_name,
 	.set_vq_affinity = vp_set_vq_affinity,
 	.get_vq_affinity = vp_get_vq_affinity,
+	.get_shm_region  = vp_get_shm_region,
 };
 
 /**
diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index 90007a1abcab..fe9f43680a1d 100644
--- a/include/uapi/linux/virtio_pci.h
+++ b/include/uapi/linux/virtio_pci.h
@@ -113,6 +113,8 @@
 #define VIRTIO_PCI_CAP_DEVICE_CFG	4
 /* PCI configuration access */
 #define VIRTIO_PCI_CAP_PCI_CFG		5
+/* Additional shared memory capability */
+#define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG 8
 
 /* This is the PCI capability header: */
 struct virtio_pci_cap {
@@ -121,11 +123,18 @@ struct virtio_pci_cap {
 	__u8 cap_len;		/* Generic PCI field: capability length */
 	__u8 cfg_type;		/* Identifies the structure. */
 	__u8 bar;		/* Where to find it. */
-	__u8 padding[3];	/* Pad to full dword. */
+	__u8 id;		/* Multiple capabilities of the same type */
+	__u8 padding[2];	/* Pad to full dword. */
 	__le32 offset;		/* Offset within bar. */
 	__le32 length;		/* Length of the structure, in bytes. */
 };
 
+struct virtio_pci_cap64 {
+       struct virtio_pci_cap cap;
+       __le32 offset_hi;             /* Most sig 32 bits of offset */
+       __le32 length_hi;             /* Most sig 32 bits of length */
+};
+
 struct virtio_pci_notify_cap {
 	struct virtio_pci_cap cap;
 	__le32 notify_off_multiplier;	/* Multiplier for queue_notify_off. */
-- 
2.20.1

