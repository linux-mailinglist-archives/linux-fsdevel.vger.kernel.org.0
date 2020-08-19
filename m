Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA3024A932
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 00:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgHSWWW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Aug 2020 18:22:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35250 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727898AbgHSWVM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Aug 2020 18:21:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597875670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TyfDDzjk7iVLHGODF357EhFJkg0SzlK67gF9XuQG3ns=;
        b=DI4wQD1+0OCQFT3qbc6cWf4fAyXkJQwvX5OUrMV4jZ70AjopagnYUxnPPmdHkux8k5SstR
        bEvHYaTkKHEkXi5XT2mShH6y1qcvwTzv980sxnFW3YbcVNGG19VjxLV21czVpd9d4vVTxr
        CoHD7iCVL2KW1vivXIBs6Y3zNmi5npM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-eGGWEASBPpuyz_ktCJrRPA-1; Wed, 19 Aug 2020 18:21:05 -0400
X-MC-Unique: eGGWEASBPpuyz_ktCJrRPA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2083E8030AC;
        Wed, 19 Aug 2020 22:21:04 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-197.rdu2.redhat.com [10.10.115.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5F57060BEC;
        Wed, 19 Aug 2020 22:20:54 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id DC6202255D9; Wed, 19 Aug 2020 18:20:53 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, dan.j.williams@intel.com,
        Sebastien Boeuf <sebastien.boeuf@intel.com>,
        kbuild test robot <lkp@intel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v3 04/18] virtio: Implement get_shm_region for PCI transport
Date:   Wed, 19 Aug 2020 18:19:42 -0400
Message-Id: <20200819221956.845195-5-vgoyal@redhat.com>
In-Reply-To: <20200819221956.845195-1-vgoyal@redhat.com>
References: <20200819221956.845195-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Sebastien Boeuf <sebastien.boeuf@intel.com>

On PCI the shm regions are found using capability entries;
find a region by searching for the capability.

Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: kbuild test robot <lkp@intel.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Cc: kvm@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>
---
 drivers/virtio/virtio_pci_modern.c | 95 ++++++++++++++++++++++++++++++
 include/uapi/linux/virtio_pci.h    | 11 +++-
 2 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 3e14e700b231..3d6ae5a5e252 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -444,6 +444,99 @@ static void del_vq(struct virtio_pci_vq_info *info)
 	vring_del_virtqueue(vq);
 }
 
+static int virtio_pci_find_shm_cap(struct pci_dev *dev, u8 required_id,
+				   u8 *bar, u64 *offset, u64 *len)
+{
+	int pos;
+
+	for (pos = pci_find_capability(dev, PCI_CAP_ID_VNDR); pos > 0;
+	     pos = pci_find_next_capability(dev, pos, PCI_CAP_ID_VNDR)) {
+		u8 type, cap_len, id;
+		u32 tmp32;
+		u64 res_offset, res_length;
+
+		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
+							 cfg_type), &type);
+		if (type != VIRTIO_PCI_CAP_SHARED_MEMORY_CFG)
+			continue;
+
+		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
+							 cap_len), &cap_len);
+		if (cap_len != sizeof(struct virtio_pci_cap64)) {
+			dev_err(&dev->dev, "%s: shm cap with bad size offset:"
+				" %d size: %d\n", __func__, pos, cap_len);
+			continue;
+		}
+
+		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
+							 id), &id);
+		if (id != required_id)
+			continue;
+
+		/* Type, and ID match, looks good */
+		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
+							 bar), bar);
+
+		/* Read the lower 32bit of length and offset */
+		pci_read_config_dword(dev, pos + offsetof(struct virtio_pci_cap,
+							  offset), &tmp32);
+		res_offset = tmp32;
+		pci_read_config_dword(dev, pos + offsetof(struct virtio_pci_cap,
+							  length), &tmp32);
+		res_length = tmp32;
+
+		/* and now the top half */
+		pci_read_config_dword(dev,
+				      pos + offsetof(struct virtio_pci_cap64,
+						     offset_hi), &tmp32);
+		res_offset |= ((u64)tmp32) << 32;
+		pci_read_config_dword(dev,
+				      pos + offsetof(struct virtio_pci_cap64,
+						     length_hi), &tmp32);
+		res_length |= ((u64)tmp32) << 32;
+
+		*offset = res_offset;
+		*len = res_length;
+
+		return pos;
+	}
+	return 0;
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
+
+	if (!virtio_pci_find_shm_cap(pci_dev, id, &bar, &offset, &len))
+		return false;
+
+	phys_addr = pci_resource_start(pci_dev, bar);
+	bar_len = pci_resource_len(pci_dev, bar);
+
+	if ((offset + len) < offset) {
+		dev_err(&pci_dev->dev, "%s: cap offset+len overflow detected\n",
+			__func__);
+		return false;
+	}
+
+	if (offset + len > bar_len) {
+		dev_err(&pci_dev->dev, "%s: bar shorter than cap offset+len\n",
+			__func__);
+		return false;
+	}
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
@@ -458,6 +551,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
 	.bus_name	= vp_bus_name,
 	.set_vq_affinity = vp_set_vq_affinity,
 	.get_vq_affinity = vp_get_vq_affinity,
+	.get_shm_region  = vp_get_shm_region,
 };
 
 static const struct virtio_config_ops virtio_pci_config_ops = {
@@ -474,6 +568,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
 	.bus_name	= vp_bus_name,
 	.set_vq_affinity = vp_set_vq_affinity,
 	.get_vq_affinity = vp_get_vq_affinity,
+	.get_shm_region  = vp_get_shm_region,
 };
 
 /**
diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index 90007a1abcab..3a86f36d7e3d 100644
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
+	struct virtio_pci_cap cap;
+	__le32 offset_hi;             /* Most sig 32 bits of offset */
+	__le32 length_hi;             /* Most sig 32 bits of length */
+};
+
 struct virtio_pci_notify_cap {
 	struct virtio_pci_cap cap;
 	__le32 notify_off_multiplier;	/* Multiplier for queue_notify_off. */
-- 
2.25.4

