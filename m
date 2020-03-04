Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50A6517962C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 18:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbgCDRB2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 12:01:28 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47700 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729749AbgCDQ7Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:59:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583341155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zRimOH5EEBiZrbE1/4aC2axl7i7qB+PwyVdi/gqeMng=;
        b=iPx3L3llIJn7ei5l7piQIFx02nxzVmogsopXnibrTeqiMExrYlByApp/fDmje6qxJSRFkI
        pOoc3j5kmSmFr2pMBAKmGMQhOEf0RtpIypWWHu+gIA7K+NKhjE2TcBNMZof0j/gEoG0LRr
        Ec0/gAI2MxWqN9oEbx4powO4k9BztkM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-D6SwdeoaMS6v2ZN6PcRoxg-1; Wed, 04 Mar 2020 11:59:12 -0500
X-MC-Unique: D6SwdeoaMS6v2ZN6PcRoxg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF456800D53;
        Wed,  4 Mar 2020 16:59:11 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 99C1D48;
        Wed,  4 Mar 2020 16:59:11 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 4AE3B2257D7; Wed,  4 Mar 2020 11:59:03 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu
Cc:     vgoyal@redhat.com, stefanha@redhat.com, dgilbert@redhat.com,
        mst@redhat.com, Sebastien Boeuf <sebastien.boeuf@intel.com>
Subject: [PATCH 05/20] virtio: Implement get_shm_region for MMIO transport
Date:   Wed,  4 Mar 2020 11:58:30 -0500
Message-Id: <20200304165845.3081-6-vgoyal@redhat.com>
In-Reply-To: <20200304165845.3081-1-vgoyal@redhat.com>
References: <20200304165845.3081-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Sebastien Boeuf <sebastien.boeuf@intel.com>

On MMIO a new set of registers is defined for finding SHM
regions.  Add their definitions and use them to find the region.

Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
---
 drivers/virtio/virtio_mmio.c     | 32 ++++++++++++++++++++++++++++++++
 include/uapi/linux/virtio_mmio.h | 11 +++++++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 97d5725fd9a2..4922a1a9e3a7 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -500,6 +500,37 @@ static const char *vm_bus_name(struct virtio_device =
*vdev)
 	return vm_dev->pdev->name;
 }
=20
+static bool vm_get_shm_region(struct virtio_device *vdev,
+			      struct virtio_shm_region *region, u8 id)
+{
+	struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vdev);
+	u64 len, addr;
+
+	/* Select the region we're interested in */
+	writel(id, vm_dev->base + VIRTIO_MMIO_SHM_SEL);
+
+	/* Read the region size */
+	len =3D (u64) readl(vm_dev->base + VIRTIO_MMIO_SHM_LEN_LOW);
+	len |=3D (u64) readl(vm_dev->base + VIRTIO_MMIO_SHM_LEN_HIGH) << 32;
+
+	region->len =3D len;
+
+	/* Check if region length is -1. If that's the case, the shared memory
+	 * region does not exist and there is no need to proceed further.
+	 */
+	if (len =3D=3D ~(u64)0) {
+		return false;
+	}
+
+	/* Read the region base address */
+	addr =3D (u64) readl(vm_dev->base + VIRTIO_MMIO_SHM_BASE_LOW);
+	addr |=3D (u64) readl(vm_dev->base + VIRTIO_MMIO_SHM_BASE_HIGH) << 32;
+
+	region->addr =3D addr;
+
+	return true;
+}
+
 static const struct virtio_config_ops virtio_mmio_config_ops =3D {
 	.get		=3D vm_get,
 	.set		=3D vm_set,
@@ -512,6 +543,7 @@ static const struct virtio_config_ops virtio_mmio_con=
fig_ops =3D {
 	.get_features	=3D vm_get_features,
 	.finalize_features =3D vm_finalize_features,
 	.bus_name	=3D vm_bus_name,
+	.get_shm_region =3D vm_get_shm_region,
 };
=20
=20
diff --git a/include/uapi/linux/virtio_mmio.h b/include/uapi/linux/virtio=
_mmio.h
index c4b09689ab64..0650f91bea6c 100644
--- a/include/uapi/linux/virtio_mmio.h
+++ b/include/uapi/linux/virtio_mmio.h
@@ -122,6 +122,17 @@
 #define VIRTIO_MMIO_QUEUE_USED_LOW	0x0a0
 #define VIRTIO_MMIO_QUEUE_USED_HIGH	0x0a4
=20
+/* Shared memory region id */
+#define VIRTIO_MMIO_SHM_SEL             0x0ac
+
+/* Shared memory region length, 64 bits in two halves */
+#define VIRTIO_MMIO_SHM_LEN_LOW         0x0b0
+#define VIRTIO_MMIO_SHM_LEN_HIGH        0x0b4
+
+/* Shared memory region base address, 64 bits in two halves */
+#define VIRTIO_MMIO_SHM_BASE_LOW        0x0b8
+#define VIRTIO_MMIO_SHM_BASE_HIGH       0x0bc
+
 /* Configuration atomicity value */
 #define VIRTIO_MMIO_CONFIG_GENERATION	0x0fc
=20
--=20
2.20.1

