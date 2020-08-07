Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA2C23F358
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 21:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgHGTzz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 15:55:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31698 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726766AbgHGTzx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 15:55:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596830151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a11wJbhnzYwxb2Lcb6PDBA6q2DERVu1PinNtBvs2loo=;
        b=ECxnCLZETkmYL3qjagw+e1hTMNaCm6axWW3U9eJkZpNesWfZOvOFSq3EF/Y4Mt1qE243On
        KduljHce7hfJ0aTB3Yzj4GlE9Q5mdvvYjoLKdVHB3Mb4z49RibM1qTWooPkKMqgne73ESn
        aldiACsCi7fcvhk2d3yKdpoAsuF06Lk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-j7cTREl9MMqQBbypohLXfg-1; Fri, 07 Aug 2020 15:55:49 -0400
X-MC-Unique: j7cTREl9MMqQBbypohLXfg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5972C8014C1;
        Fri,  7 Aug 2020 19:55:48 +0000 (UTC)
Received: from horse.redhat.com (ovpn-113-142.rdu2.redhat.com [10.10.113.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F20B10027A6;
        Fri,  7 Aug 2020 19:55:45 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id BAF7F222E49; Fri,  7 Aug 2020 15:55:38 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, Sebastien Boeuf <sebastien.boeuf@intel.com>,
        kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 05/20] virtio: Implement get_shm_region for MMIO transport
Date:   Fri,  7 Aug 2020 15:55:11 -0400
Message-Id: <20200807195526.426056-6-vgoyal@redhat.com>
In-Reply-To: <20200807195526.426056-1-vgoyal@redhat.com>
References: <20200807195526.426056-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Sebastien Boeuf <sebastien.boeuf@intel.com>

On MMIO a new set of registers is defined for finding SHM
regions.  Add their definitions and use them to find the region.

Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
Cc: kvm@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>
---
 drivers/virtio/virtio_mmio.c     | 32 ++++++++++++++++++++++++++++++++
 include/uapi/linux/virtio_mmio.h | 11 +++++++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 627ac0487494..2697c492cf78 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -498,6 +498,37 @@ static const char *vm_bus_name(struct virtio_device *vdev)
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
+	if (len == ~(u64)0) {
+		return false;
+	}
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
@@ -510,6 +541,7 @@ static const struct virtio_config_ops virtio_mmio_config_ops = {
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

