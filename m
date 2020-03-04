Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D803179608
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 18:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388272AbgCDQ77 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 11:59:59 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34573 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729966AbgCDQ7S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:59:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583341157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ri13vTOknpetvDy7ElAZqwOtMgDlHO5b+O2XLP0jFKY=;
        b=Pm+ZOHuv9vuGwsoA1x2IpkCeGR1lLNQdn3i7YYGGgPvn8DSpHzkQbdCDrt7gRlpEJFt7aX
        ZhzXPnzC+9LtiCw9SvSGG9J8HgGweQI7+fLQiH+gRtKth5fEXxj9i3jcpCDGNI7SIbAiXH
        HOfbVDLt3Gq750MZ0wrpqaRAkf29ZdI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-miPyIUfpM46Y_nUpRqKVLg-1; Wed, 04 Mar 2020 11:59:13 -0500
X-MC-Unique: miPyIUfpM46Y_nUpRqKVLg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7EBB800D4E;
        Wed,  4 Mar 2020 16:59:11 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A38E75D9C9;
        Wed,  4 Mar 2020 16:59:03 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 45B4B2257D6; Wed,  4 Mar 2020 11:59:03 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu
Cc:     vgoyal@redhat.com, stefanha@redhat.com, dgilbert@redhat.com,
        mst@redhat.com, Sebastien Boeuf <sebastien.boeuf@intel.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH 04/20] virtio: Implement get_shm_region for PCI transport
Date:   Wed,  4 Mar 2020 11:58:29 -0500
Message-Id: <20200304165845.3081-5-vgoyal@redhat.com>
In-Reply-To: <20200304165845.3081-1-vgoyal@redhat.com>
References: <20200304165845.3081-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
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
---
 drivers/virtio/virtio_pci_modern.c | 107 +++++++++++++++++++++++++++++
 include/uapi/linux/virtio_pci.h    |  11 ++-
 2 files changed, 117 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_p=
ci_modern.c
index 7abcc50838b8..52f179411015 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -443,6 +443,111 @@ static void del_vq(struct virtio_pci_vq_info *info)
 	vring_del_virtqueue(vq);
 }
=20
+static int virtio_pci_find_shm_cap(struct pci_dev *dev,
+                                   u8 required_id,
+                                   u8 *bar, u64 *offset, u64 *len)
+{
+	int pos;
+
+        for (pos =3D pci_find_capability(dev, PCI_CAP_ID_VNDR);
+             pos > 0;
+             pos =3D pci_find_next_capability(dev, pos, PCI_CAP_ID_VNDR)=
) {
+		u8 type, cap_len, id;
+                u32 tmp32;
+                u64 res_offset, res_length;
+
+		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
+                                                         cfg_type),
+                                     &type);
+                if (type !=3D VIRTIO_PCI_CAP_SHARED_MEMORY_CFG)
+                        continue;
+
+		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
+                                                         cap_len),
+                                     &cap_len);
+		if (cap_len !=3D sizeof(struct virtio_pci_cap64)) {
+		        printk(KERN_ERR "%s: shm cap with bad size offset: %d size: %d=
\n",
+                               __func__, pos, cap_len);
+                        continue;
+                }
+
+		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
+                                                         id),
+                                     &id);
+                if (id !=3D required_id)
+                        continue;
+
+                /* Type, and ID match, looks good */
+                pci_read_config_byte(dev, pos + offsetof(struct virtio_p=
ci_cap,
+                                                         bar),
+                                     bar);
+
+                /* Read the lower 32bit of length and offset */
+                pci_read_config_dword(dev, pos + offsetof(struct virtio_=
pci_cap, offset),
+                                      &tmp32);
+                res_offset =3D tmp32;
+                pci_read_config_dword(dev, pos + offsetof(struct virtio_=
pci_cap, length),
+                                      &tmp32);
+                res_length =3D tmp32;
+
+                /* and now the top half */
+                pci_read_config_dword(dev,
+                                      pos + offsetof(struct virtio_pci_c=
ap64,
+                                                     offset_hi),
+                                      &tmp32);
+                res_offset |=3D ((u64)tmp32) << 32;
+                pci_read_config_dword(dev,
+                                      pos + offsetof(struct virtio_pci_c=
ap64,
+                                                     length_hi),
+                                      &tmp32);
+                res_length |=3D ((u64)tmp32) << 32;
+
+                *offset =3D res_offset;
+                *len =3D res_length;
+
+                return pos;
+        }
+        return 0;
+}
+
+static bool vp_get_shm_region(struct virtio_device *vdev,
+			      struct virtio_shm_region *region, u8 id)
+{
+	struct virtio_pci_device *vp_dev =3D to_vp_device(vdev);
+	struct pci_dev *pci_dev =3D vp_dev->pci_dev;
+	u8 bar;
+	u64 offset, len;
+	phys_addr_t phys_addr;
+	size_t bar_len;
+	int ret;
+
+	if (!virtio_pci_find_shm_cap(pci_dev, id, &bar, &offset, &len)) {
+		return false;
+	}
+
+	ret =3D pci_request_region(pci_dev, bar, "virtio-pci-shm");
+	if (ret < 0) {
+		dev_err(&pci_dev->dev, "%s: failed to request BAR\n",
+			__func__);
+		return false;
+	}
+
+	phys_addr =3D pci_resource_start(pci_dev, bar);
+	bar_len =3D pci_resource_len(pci_dev, bar);
+
+        if (offset + len > bar_len) {
+                dev_err(&pci_dev->dev,
+                        "%s: bar shorter than cap offset+len\n",
+                        __func__);
+                return false;
+        }
+
+	region->len =3D len;
+	region->addr =3D (u64) phys_addr + offset;
+
+	return true;
+}
+
 static const struct virtio_config_ops virtio_pci_config_nodev_ops =3D {
 	.get		=3D NULL,
 	.set		=3D NULL,
@@ -457,6 +562,7 @@ static const struct virtio_config_ops virtio_pci_conf=
ig_nodev_ops =3D {
 	.bus_name	=3D vp_bus_name,
 	.set_vq_affinity =3D vp_set_vq_affinity,
 	.get_vq_affinity =3D vp_get_vq_affinity,
+	.get_shm_region  =3D vp_get_shm_region,
 };
=20
 static const struct virtio_config_ops virtio_pci_config_ops =3D {
@@ -473,6 +579,7 @@ static const struct virtio_config_ops virtio_pci_conf=
ig_ops =3D {
 	.bus_name	=3D vp_bus_name,
 	.set_vq_affinity =3D vp_set_vq_affinity,
 	.get_vq_affinity =3D vp_get_vq_affinity,
+	.get_shm_region  =3D vp_get_shm_region,
 };
=20
 /**
diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_=
pci.h
index 90007a1abcab..fe9f43680a1d 100644
--- a/include/uapi/linux/virtio_pci.h
+++ b/include/uapi/linux/virtio_pci.h
@@ -113,6 +113,8 @@
 #define VIRTIO_PCI_CAP_DEVICE_CFG	4
 /* PCI configuration access */
 #define VIRTIO_PCI_CAP_PCI_CFG		5
+/* Additional shared memory capability */
+#define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG 8
=20
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
=20
+struct virtio_pci_cap64 {
+       struct virtio_pci_cap cap;
+       __le32 offset_hi;             /* Most sig 32 bits of offset */
+       __le32 length_hi;             /* Most sig 32 bits of length */
+};
+
 struct virtio_pci_notify_cap {
 	struct virtio_pci_cap cap;
 	__le32 notify_off_multiplier;	/* Multiplier for queue_notify_off. */
--=20
2.20.1

