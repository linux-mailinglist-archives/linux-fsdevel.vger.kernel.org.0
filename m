Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6BC24A947
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 00:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgHSWXa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Aug 2020 18:23:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23910 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726819AbgHSWVG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Aug 2020 18:21:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597875665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zV4eGv1HmKEw4dEdYXRQk1b4dOpAiZN4WqAP4p4F6ZQ=;
        b=WYGFqhMYG4f5AeOA7frzpIh4i7guEx8UU2HvezUhpgNad7fDxL86bnCz3rOHkdMEoQN4H0
        dNS15BmN1v+UQ1CldeynsFRnPNkhrnKF1YcK6gtQDqUTFJ6BM9ibdmn0KCJ8LeSXxJ4QI4
        QDqKFXPWw1fIhnHVr7F7hCcnA6r8wj0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-ol9Li3MSNCuugzCmQy-YSw-1; Wed, 19 Aug 2020 18:21:02 -0400
X-MC-Unique: ol9Li3MSNCuugzCmQy-YSw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E74B2425CC;
        Wed, 19 Aug 2020 22:21:00 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-197.rdu2.redhat.com [10.10.115.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5F50C5C896;
        Wed, 19 Aug 2020 22:20:54 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id D2A592255A0; Wed, 19 Aug 2020 18:20:53 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, dan.j.williams@intel.com,
        Sebastien Boeuf <sebastien.boeuf@intel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v3 03/18] virtio: Add get_shm_region method
Date:   Wed, 19 Aug 2020 18:19:41 -0400
Message-Id: <20200819221956.845195-4-vgoyal@redhat.com>
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

Virtio defines 'shared memory regions' that provide a continuously
shared region between the host and guest.

Provide a method to find a particular region on a device.

Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Cc: kvm@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>
---
 include/linux/virtio_config.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 8fe857e27ef3..4b8e38c5c4d8 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -11,6 +11,11 @@
 
 struct irq_affinity;
 
+struct virtio_shm_region {
+	u64 addr;
+	u64 len;
+};
+
 /**
  * virtio_config_ops - operations for configuring a virtio device
  * Note: Do not assume that a transport implements all of the operations
@@ -66,6 +71,7 @@ struct irq_affinity;
  *      the caller can then copy.
  * @set_vq_affinity: set the affinity for a virtqueue (optional).
  * @get_vq_affinity: get the affinity for a virtqueue (optional).
+ * @get_shm_region: get a shared memory region based on the index.
  */
 typedef void vq_callback_t(struct virtqueue *);
 struct virtio_config_ops {
@@ -89,6 +95,8 @@ struct virtio_config_ops {
 			       const struct cpumask *cpu_mask);
 	const struct cpumask *(*get_vq_affinity)(struct virtio_device *vdev,
 			int index);
+	bool (*get_shm_region)(struct virtio_device *vdev,
+			       struct virtio_shm_region *region, u8 id);
 };
 
 /* If driver didn't advertise the feature, it will never appear. */
@@ -251,6 +259,15 @@ int virtqueue_set_affinity(struct virtqueue *vq, const struct cpumask *cpu_mask)
 	return 0;
 }
 
+static inline
+bool virtio_get_shm_region(struct virtio_device *vdev,
+			   struct virtio_shm_region *region, u8 id)
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
2.25.4

