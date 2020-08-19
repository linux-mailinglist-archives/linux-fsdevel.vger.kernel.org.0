Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBF424A941
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 00:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgHSWXE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Aug 2020 18:23:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53789 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727871AbgHSWVH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Aug 2020 18:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597875665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GQQRLRSw4j8HkEfa+DKkvenAI5uYOUqQOX/jVMQ+gzs=;
        b=WusOttw9AC1QQ9AFk77hZq0UAfQlzam8uB34OaxFhQnTksLnc2wxQth6erOSqsxXqux+TE
        fLo9CoqhQf2BB6/5lMQCDDRaKPiTF/bVg4fsJz3VRdFEys+9f5JRLb4FLGMPPT1zuBlfLL
        0jX2Sh/Y7tTIW3YBR2MontVjjdRtSVc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-9qBezfhxN2WzK8QymfmESA-1; Wed, 19 Aug 2020 18:21:03 -0400
X-MC-Unique: 9qBezfhxN2WzK8QymfmESA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85F681007465;
        Wed, 19 Aug 2020 22:21:01 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-197.rdu2.redhat.com [10.10.115.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 61CA25C3E0;
        Wed, 19 Aug 2020 22:21:01 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id E25162256B5; Wed, 19 Aug 2020 18:20:53 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, dan.j.williams@intel.com,
        Sebastien Boeuf <sebastien.boeuf@intel.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 05/18] virtio: Implement get_shm_region for MMIO transport
Date:   Wed, 19 Aug 2020 18:19:43 -0400
Message-Id: <20200819221956.845195-6-vgoyal@redhat.com>
In-Reply-To: <20200819221956.845195-1-vgoyal@redhat.com>
References: <20200819221956.845195-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Sebastien Boeuf <sebastien.boeuf@intel.com>

On MMIO a new set of registers is defined for finding SHM
regions.  Add their definitions and use them to find the region.

Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
Cc: kvm@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>
---
 drivers/virtio/virtio_mmio.c     | 31 +++++++++++++++++++++++++++++++
 include/uapi/linux/virtio_mmio.h | 11 +++++++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 627ac0487494..238383ff1064 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -498,6 +498,36 @@ static const char *vm_bus_name(struct virtio_device *vdev)
 	return vm_dev->pdev->name;
 }
 
+static bool vm_get_shm_region(struct virtio_device *vdev,
+			      struct virtio_shm_region *region, u8 id)
+{
+	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
+	u64 len, addr;
+
+	/* Select the region we're interested in */
+	writel(id, vm_dev->base + VIRTIO_MMIO_SHM_SEL);
+
+	/* Read the region size */
+	len = (u64) readl(vm_dev->base + VIRTIO_MMIO_SHM_LEN_LOW);
+	len |= (u64) readl(vm_dev->base + VIRTIO_MMIO_SHM_LEN_HIGH) << 32;
+
+	region->len = len;
+
+	/* Check if region length is -1. If that's the case, the shared memory
+	 * region does not exist and there is no need to proceed further.
+	 */
+	if (len == ~(u64)0)
+		return false;
+
+	/* Read the region base address */
+	addr = (u64) readl(vm_dev->base + VIRTIO_MMIO_SHM_BASE_LOW);
+	addr |= (u64) readl(vm_dev->base + VIRTIO_MMIO_SHM_BASE_HIGH) << 32;
+
+	region->addr = addr;
+
+	return true;
+}
+
 static const struct virtio_config_ops virtio_mmio_config_ops = {
 	.get		= vm_get,
 	.set		= vm_set,
@@ -510,6 +540,7 @@ static const struct virtio_config_ops virtio_mmio_config_ops = {
 	.get_features	= vm_get_features,
 	.finalize_features = vm_finalize_features,
 	.bus_name	= vm_bus_name,
+	.get_shm_region = vm_get_shm_region,
 };
 
 
diff --git a/include/uapi/linux/virtio_mmio.h b/include/uapi/linux/virtio_mmio.h
index c4b09689ab64..0650f91bea6c 100644
--- a/include/uapi/linux/virtio_mmio.h
+++ b/include/uapi/linux/virtio_mmio.h
@@ -122,6 +122,17 @@
 #define VIRTIO_MMIO_QUEUE_USED_LOW	0x0a0
 #define VIRTIO_MMIO_QUEUE_USED_HIGH	0x0a4
 
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
 
-- 
2.25.4

