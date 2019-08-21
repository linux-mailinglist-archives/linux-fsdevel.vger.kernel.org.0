Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA1AC98226
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 19:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbfHUR7J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 13:59:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52708 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729525AbfHUR5i (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 13:57:38 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 645C33090FC7;
        Wed, 21 Aug 2019 17:57:38 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F11D560610;
        Wed, 21 Aug 2019 17:57:32 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 873F2223CFF; Wed, 21 Aug 2019 13:57:32 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc:     virtio-fs@redhat.com, vgoyal@redhat.com, miklos@szeredi.hu,
        stefanha@redhat.com, dgilbert@redhat.com,
        Sebastien Boeuf <sebastien.boeuf@intel.com>
Subject: [PATCH 03/19] virtio: Add get_shm_region method
Date:   Wed, 21 Aug 2019 13:57:04 -0400
Message-Id: <20190821175720.25901-4-vgoyal@redhat.com>
In-Reply-To: <20190821175720.25901-1-vgoyal@redhat.com>
References: <20190821175720.25901-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 21 Aug 2019 17:57:38 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Sebastien Boeuf <sebastien.boeuf@intel.com>

Virtio defines 'shared memory regions' that provide a continuously
shared region between the host and guest.

Provide a method to find a particular region on a device.

Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/linux/virtio_config.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index bb4cc4910750..c859f000a751 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -10,6 +10,11 @@
 
 struct irq_affinity;
 
+struct virtio_shm_region {
+       u64 addr;
+       u64 len;
+};
+
 /**
  * virtio_config_ops - operations for configuring a virtio device
  * Note: Do not assume that a transport implements all of the operations
@@ -65,6 +70,7 @@ struct irq_affinity;
  *      the caller can then copy.
  * @set_vq_affinity: set the affinity for a virtqueue (optional).
  * @get_vq_affinity: get the affinity for a virtqueue (optional).
+ * @get_shm_region: get a shared memory region based on the index.
  */
 typedef void vq_callback_t(struct virtqueue *);
 struct virtio_config_ops {
@@ -88,6 +94,8 @@ struct virtio_config_ops {
 			       const struct cpumask *cpu_mask);
 	const struct cpumask *(*get_vq_affinity)(struct virtio_device *vdev,
 			int index);
+	bool (*get_shm_region)(struct virtio_device *vdev,
+			       struct virtio_shm_region *region, u8 id);
 };
 
 /* If driver didn't advertise the feature, it will never appear. */
@@ -250,6 +258,15 @@ int virtqueue_set_affinity(struct virtqueue *vq, const struct cpumask *cpu_mask)
 	return 0;
 }
 
+static inline
+bool virtio_get_shm_region(struct virtio_device *vdev,
+                         struct virtio_shm_region *region, u8 id)
+{
+	if (!vdev->config->get_shm_region)
+		return false;
+	return vdev->config->get_shm_region(vdev, region, id);
+}
+
 static inline bool virtio_is_little_endian(struct virtio_device *vdev)
 {
 	return virtio_has_feature(vdev, VIRTIO_F_VERSION_1) ||
-- 
2.20.1

